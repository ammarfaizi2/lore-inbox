Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRAOLem>; Mon, 15 Jan 2001 06:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRAOLec>; Mon, 15 Jan 2001 06:34:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131138AbRAOLeS>; Mon, 15 Jan 2001 06:34:18 -0500
Date: Mon, 15 Jan 2001 03:33:31 -0800
Message-Id: <200101151133.DAA14094@sodium.transmeta.com>
To: linux-kernel@vger.kernel.org
Cc: Matthias Kilian <kili@outback.escape.de>, David Schleef <ds@schleef.org>,
        shane@agendacomputing.com
Subject: cramfs filesystem patch for 2.4.0
From: Daniel Quinlan <quinlan@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update of my patch for the cramfs filesystem for 2.4.0 with a
few minor additions.  See below for the list of changes.

It's backward-compatible and only modifies cramfs code (aside from
adding cramfs to struct super_block).  All old cramfs images will still
work and new cramfs images are mountable on old kernels if you avoid
using new features: holes (holes require kernel 2.3.39 or later) and
padding for a boot sector (you should have a new kernel in that case).

Most of this code has been fairly well-tested, but a few features are
newer and less well-tested (like the directory sorting).  If you use
cramfs, please try it out and let me know if you have any feedback,
comments, or patches.  (I've started looking at adding some of the
existing patches, although I'll need help testing most of them.)

  Dan

------------------------------------------------------------------------

15 Jan 2001:

  - update for 2.4.0
  - move fs/cramfs/cramfs.h to include/linux/cramfs_fs.h
  - add magic to in-memory version of cramfs superblock (for initrd support)
  - renamed a few #defines in cramfs_fs.h

07 Dec 2000:

superblock changes:
  - revised fsid field (still unique, contains useful fs info:
    a CRC, edition number for implementation-specific versioning,
    block and file counts for statfs)
  - size field is now used
  - new feature flags (fsid version 2, holes, shifted root for boot loader,
    directory sorting)

inode.c
  - proper checking for device size (torvalds)
  - speed up IO a bit - read in the block asynchronously rather than
    using bread() on them one by one (torvalds)
  - early directory lookup exit (since directories are now sorted)
  - add reporting of blocks and blksize for statfs
  - removed superfluous test for cramfs signature

cramfsck.c
  - new program to fsck/extract cramfs images

mkcramfs.c
  - CRC added to filesystem image
  - allow holes to be created (see -z option)
  - support for a cramfs boot loader (see -p option)
  - support for inserting an kernel image into a cramfs image (see -i option)
  - directory sorting (more consistent images, allows faster lookups)
  - bug fix: allocate enough RAM for the fs image (small images)
  - bug fix: work around a bug in ramfs where it would
    incorrectly report the number of blocks for file (a problem when
    creating cramfs images from a ramfs filesystem)
  - options to set name/edition number in superblock (-n and -e, respectively)

cramfs.txt:
  - added entry for /etc/magic to cramfs.txt documentation

cleanup:
  - moved width definitions to cramfs.h
  - define special cramfs super block

------------------------------------------------------------------------

diff -urN linux-2.4.0-orig/Documentation/filesystems/cramfs.txt linux/Documentation/filesystems/cramfs.txt
--- linux-2.4.0-orig/Documentation/filesystems/cramfs.txt	Sat May 20 11:30:31 2000
+++ linux/Documentation/filesystems/cramfs.txt	Sat Jan 13 18:50:47 2001
@@ -47,6 +47,21 @@
 mind the filesystem becoming unreadable to future kernels.
 
 
+For /usr/share/magic
+------------------
+
+0	long	0x28cd3d45	Linux cramfs
+>4	long	x		size %d
+>8	long	x		flags 0x%x
+>12	long	x		future 0x%x
+>16	string	>\0		signature "%.16s"
+>32	long	x		fsid.crc 0x%x
+>36	long	x		fsid.edition %d
+>40	long	x		fsid.blocks %d
+>44	long	x		fsid.files %d
+>48	string	>\0		name "%.16s"
+
+
 Hacker Notes
 ------------
 
diff -urN linux-2.4.0-orig/fs/cramfs/README linux/fs/cramfs/README
--- linux-2.4.0-orig/fs/cramfs/README	Tue Jan 11 10:24:58 2000
+++ linux/fs/cramfs/README	Sat Jan 13 18:50:47 2001
@@ -14,11 +14,11 @@
 	<directory_structure>
 	<data>
 
-<superblock>: struct cramfs_super (see cramfs.h).
+<superblock>: struct cramfs_super (see cramfs_fs.h).
 
 <directory_structure>:
 	For each file:
-		struct cramfs_inode (see cramfs.h).
+		struct cramfs_inode (see cramfs_fs.h).
 		Filename.  Not generally null-terminated, but it is
 		 null-padded to a multiple of 4 bytes.
 
diff -urN linux-2.4.0-orig/fs/cramfs/cramfs.h linux/fs/cramfs/cramfs.h
--- linux-2.4.0-orig/fs/cramfs/cramfs.h	Tue Jan 11 10:24:58 2000
+++ linux/fs/cramfs/cramfs.h	Wed Dec 31 16:00:00 1969
@@ -1,52 +0,0 @@
-#ifndef __CRAMFS_H
-#define __CRAMFS_H
-
-#define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
-#define CRAMFS_SIGNATURE	"Compressed ROMFS"
-
-/*
- * Reasonably terse representation of the inode data.
- */
-struct cramfs_inode {
-	u32 mode:16, uid:16;
-	/* SIZE for device files is i_rdev */
-	u32 size:24, gid:8;
-	/* NAMELEN is the length of the file name, divided by 4 and
-           rounded up.  (cramfs doesn't support hard links.) */
-	/* OFFSET: For symlinks and non-empty regular files, this
-	   contains the offset (divided by 4) of the file data in
-	   compressed form (starting with an array of block pointers;
-	   see README).  For non-empty directories it is the offset
-	   (divided by 4) of the inode of the first file in that
-	   directory.  For anything else, offset is zero. */
-	u32 namelen:6, offset:26;
-};
-
-/*
- * Superblock information at the beginning of the FS.
- */
-struct cramfs_super {
-	u32 magic;		/* 0x28cd3d45 - random number */
-	u32 size;		/* Not used.  mkcramfs currently
-                                   writes a constant 1<<16 here. */
-	u32 flags;		/* 0 */
-	u32 future;		/* 0 */
-	u8 signature[16];	/* "Compressed ROMFS" */
-	u8 fsid[16];		/* random number */
-	u8 name[16];		/* user-defined name */
-	struct cramfs_inode root;	/* Root inode data */
-};
-
-/*
- * Valid values in super.flags.  Currently we refuse to mount
- * if (flags & ~CRAMFS_SUPPORTED_FLAGS).  Maybe that should be
- * changed to test super.future instead.
- */
-#define CRAMFS_SUPPORTED_FLAGS (0xff)
-
-/* Uncompression interfaces to the underlying zlib */
-int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
-int cramfs_uncompress_init(void);
-int cramfs_uncompress_exit(void);
-
-#endif
diff -urN linux-2.4.0-orig/fs/cramfs/inode.c linux/fs/cramfs/inode.c
--- linux-2.4.0-orig/fs/cramfs/inode.c	Wed Jan 10 19:47:50 2001
+++ linux/fs/cramfs/inode.c	Sat Jan 13 18:59:31 2001
@@ -17,10 +17,16 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include <linux/blkdev.h>
+#include <linux/cramfs_fs.h>
 
 #include <asm/uaccess.h>
 
-#include "cramfs.h"
+#define CRAMFS_SB_MAGIC u.cramfs_sb.magic
+#define CRAMFS_SB_SIZE u.cramfs_sb.size
+#define CRAMFS_SB_BLOCKS u.cramfs_sb.blocks
+#define CRAMFS_SB_FILES u.cramfs_sb.files
+#define CRAMFS_SB_FLAGS u.cramfs_sb.flags
 
 static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
@@ -40,6 +46,8 @@
 		inode->i_mode = cramfs_inode->mode;
 		inode->i_uid = cramfs_inode->uid;
 		inode->i_size = cramfs_inode->size;
+		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
+		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
@@ -100,7 +108,11 @@
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
 {
 	struct buffer_head * bh_array[BLKS_PER_BUF];
-	unsigned i, blocknr, buffer;
+	struct buffer_head * read_array[BLKS_PER_BUF];
+	unsigned i, blocknr, buffer, unread;
+	unsigned long devsize;
+	int major, minor;
+	
 	char *data;
 
 	if (!len)
@@ -123,9 +135,34 @@
 		return read_buffers[i] + blk_offset;
 	}
 
+	devsize = ~0UL;
+	major = MAJOR(sb->s_dev);
+	minor = MINOR(sb->s_dev);
+
+	if (blk_size[major])
+		devsize = blk_size[major][minor] >> 2;
+
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
-	for (i = 0; i < BLKS_PER_BUF; i++)
-		bh_array[i] = bread(sb->s_dev, blocknr + i, PAGE_CACHE_SIZE);
+	unread = 0;
+	for (i = 0; i < BLKS_PER_BUF; i++) {
+		struct buffer_head *bh;
+
+		bh = NULL;
+		if (blocknr + i < devsize) {
+			bh = getblk(sb->s_dev, blocknr + i, PAGE_CACHE_SIZE);
+			if (!buffer_uptodate(bh))
+				read_array[unread++] = bh;
+		}
+		bh_array[i] = bh;
+	}
+
+	if (unread) {
+		ll_rw_block(READ, unread, read_array);
+		do {
+			unread--;
+			wait_on_buffer(read_array[unread]);
+		} while (unread);
+	}
 
 	/* Ok, copy them to the staging area without sleeping. */
 	buffer = next_buffer;
@@ -167,33 +204,49 @@
 
 	/* Do sanity checks on the superblock */
 	if (super.magic != CRAMFS_MAGIC) {
-		printk("wrong magic\n");
-		goto out;
-	}
-	if (memcmp(super.signature, CRAMFS_SIGNATURE, sizeof(super.signature))) {
-		printk("wrong signature\n");
-		goto out;
+		/* check at 512 byte offset */
+		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
+		if (super.magic != CRAMFS_MAGIC) {
+			printk(KERN_ERR "cramfs: wrong magic\n");
+			goto out;
+		}
 	}
+
+	/* get feature flags first */
 	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
-		printk("unsupported filesystem features\n");
+		printk(KERN_ERR "cramfs: unsupported filesystem features\n");
 		goto out;
 	}
 
 	/* Check that the root inode is in a sane state */
 	if (!S_ISDIR(super.root.mode)) {
-		printk("root is not a directory\n");
+		printk(KERN_ERR "cramfs: root is not a directory\n");
 		goto out;
 	}
 	root_offset = super.root.offset << 2;
+	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
+		sb->CRAMFS_SB_SIZE=super.size;
+		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
+		sb->CRAMFS_SB_FILES=super.fsid.files;
+	} else {
+		sb->CRAMFS_SB_SIZE=1<<28;
+		sb->CRAMFS_SB_BLOCKS=0;
+		sb->CRAMFS_SB_FILES=0;
+	}
+	sb->CRAMFS_SB_MAGIC=super.magic;
+	sb->CRAMFS_SB_FLAGS=super.flags;
 	if (root_offset == 0)
-		printk(KERN_INFO "cramfs: note: empty filesystem");
-	else if (root_offset != sizeof(struct cramfs_super)) {
-		printk("bad root offset %lu\n", root_offset);
+		printk(KERN_INFO "cramfs: empty filesystem");
+	else if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
+		 ((root_offset != sizeof(struct cramfs_super)) &&
+		  (root_offset != 512 + sizeof(struct cramfs_super))))
+	{
+		printk(KERN_ERR "cramfs: bad root offset %lu\n", root_offset);
 		goto out;
 	}
 
 	/* Set it all up.. */
-	sb->s_op	= &cramfs_ops;
+	sb->s_op = &cramfs_ops;
 	sb->s_root = d_alloc_root(get_cramfs_inode(sb, &super.root));
 	retval = sb;
 
@@ -205,8 +258,10 @@
 {
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
+	buf->f_blocks = sb->CRAMFS_SB_BLOCKS;
 	buf->f_bfree = 0;
 	buf->f_bavail = 0;
+	buf->f_files = sb->CRAMFS_SB_FILES;
 	buf->f_ffree = 0;
 	buf->f_namelen = 255;
 	return 0;
@@ -271,14 +326,20 @@
 static struct dentry * cramfs_lookup(struct inode *dir, struct dentry *dentry)
 {
 	unsigned int offset = 0;
+	int sorted = dir->i_sb->CRAMFS_SB_FLAGS & CRAMFS_FLAG_SORTED_DIRS;
 
 	while (offset < dir->i_size) {
 		struct cramfs_inode *de;
 		char *name;
-		int namelen;
+		int namelen, retval;
 
 		de = cramfs_read(dir->i_sb, OFFSET(dir) + offset, sizeof(*de)+256);
 		name = (char *)(de+1);
+
+		/* Try to take advantage of sorted directories */
+		if (sorted && (dentry->d_name.name[0] < name[0]))
+			break;
+
 		namelen = de->namelen << 2;
 		offset += sizeof(*de) + namelen;
 
@@ -295,10 +356,16 @@
 		}
 		if (namelen != dentry->d_name.len)
 			continue;
-		if (memcmp(dentry->d_name.name, name, namelen))
+		retval = memcmp(dentry->d_name.name, name, namelen);
+		if (retval > 0)
 			continue;
-		d_add(dentry, get_cramfs_inode(dir->i_sb, de));
-		return NULL;
+		if (!retval) {
+			d_add(dentry, get_cramfs_inode(dir->i_sb, de));
+			return NULL;
+		}
+		/* else (retval < 0) */
+		if (sorted)
+			break;
 	}
 	d_add(dentry, NULL);
 	return NULL;
diff -urN linux-2.4.0-orig/include/linux/cramfs_fs.h linux/include/linux/cramfs_fs.h
--- linux-2.4.0-orig/include/linux/cramfs_fs.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/cramfs_fs.h	Sat Jan 13 20:39:23 2001
@@ -0,0 +1,89 @@
+#ifndef __CRAMFS_H
+#define __CRAMFS_H
+
+#ifndef __KERNEL__
+
+typedef unsigned char u8;
+typedef unsigned short u16;
+typedef unsigned int u32;
+
+#endif
+
+#define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
+#define CRAMFS_SIGNATURE	"Compressed ROMFS"
+
+/*
+ * Width of various bitfields in struct cramfs_inode.
+ * Primarily used to generate warnings in mkcramfs.
+ */
+#define CRAMFS_MODE_WIDTH 16
+#define CRAMFS_UID_WIDTH 16
+#define CRAMFS_SIZE_WIDTH 24
+#define CRAMFS_GID_WIDTH 8
+#define CRAMFS_NAMELEN_WIDTH 6
+#define CRAMFS_OFFSET_WIDTH 26
+
+/*
+ * Reasonably terse representation of the inode data.
+ */
+struct cramfs_inode {
+	u32 mode:CRAMFS_MODE_WIDTH, uid:CRAMFS_UID_WIDTH;
+	/* SIZE for device files is i_rdev */
+	u32 size:CRAMFS_SIZE_WIDTH, gid:CRAMFS_GID_WIDTH;
+	/* NAMELEN is the length of the file name, divided by 4 and
+           rounded up.  (cramfs doesn't support hard links.) */
+	/* OFFSET: For symlinks and non-empty regular files, this
+	   contains the offset (divided by 4) of the file data in
+	   compressed form (starting with an array of block pointers;
+	   see README).  For non-empty directories it is the offset
+	   (divided by 4) of the inode of the first file in that
+	   directory.  For anything else, offset is zero. */
+	u32 namelen:CRAMFS_NAMELEN_WIDTH, offset:CRAMFS_OFFSET_WIDTH;
+};
+
+struct cramfs_info {
+	u32 crc;
+	u32 edition;
+	u32 blocks;
+	u32 files;
+};
+
+/*
+ * Superblock information at the beginning of the FS.
+ */
+struct cramfs_super {
+	u32 magic;		/* 0x28cd3d45 - random number */
+	u32 size;		/* length in bytes */
+	u32 flags;		/* 0 */
+	u32 future;		/* 0 */
+	u8 signature[16];	/* "Compressed ROMFS" */
+	struct cramfs_info fsid;	/* unique filesystem info */
+	u8 name[16];		/* user-defined name */
+	struct cramfs_inode root;	/* Root inode data */
+};
+
+/*
+ * Feature flags
+ *
+ * 0x00000000 - 0x000000ff: features that work for all past kernels
+ * 0x00000100 - 0xffffffff: features that don't work for past kernels
+ */
+#define CRAMFS_FLAG_FSID_VERSION_2	0x00000001	/* fsid version #2 */
+#define CRAMFS_FLAG_SORTED_DIRS		0x00000002	/* sorted dirs */
+#define CRAMFS_FLAG_HOLES		0x00000100	/* support for holes */
+#define CRAMFS_FLAG_WRONG_SIGNATURE	0x00000200	/* reserved */
+#define CRAMFS_FLAG_SHIFTED_ROOT_OFFSET	0x00000400	/* shifted root fs */
+
+/*
+ * Valid values in super.flags.  Currently we refuse to mount
+ * if (flags & ~CRAMFS_SUPPORTED_FLAGS).  Maybe that should be
+ * changed to test super.future instead.
+ */
+#define CRAMFS_SUPPORTED_FLAGS (0x7ff)
+
+/* Uncompression interfaces to the underlying zlib */
+int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
+int cramfs_uncompress_init(void);
+int cramfs_uncompress_exit(void);
+
+#endif
diff -urN linux-2.4.0-orig/include/linux/cramfs_fs_sb.h linux/include/linux/cramfs_fs_sb.h
--- linux-2.4.0-orig/include/linux/cramfs_fs_sb.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/cramfs_fs_sb.h	Sat Jan 13 18:50:47 2001
@@ -0,0 +1,15 @@
+#ifndef _CRAMFS_FS_SB
+#define _CRAMFS_FS_SB
+
+/*
+ * cramfs super-block data in memory
+ */
+struct cramfs_sb_info {
+			unsigned long magic;
+			unsigned long size;
+			unsigned long blocks;
+			unsigned long files;
+			unsigned long flags;
+};
+
+#endif
diff -urN linux-2.4.0-orig/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.0-orig/include/linux/fs.h	Thu Jan  4 14:50:47 2001
+++ linux/include/linux/fs.h	Sat Jan 13 19:36:52 2001
@@ -658,6 +658,7 @@
 #include <linux/udf_fs_sb.h>
 #include <linux/ncp_fs_sb.h>
 #include <linux/usbdev_fs_sb.h>
+#include <linux/cramfs_fs_sb.h>
 
 extern struct list_head super_blocks;
 
@@ -706,6 +707,7 @@
 		struct udf_sb_info	udf_sb;
 		struct ncp_sb_info	ncpfs_sb;
 		struct usbdev_sb_info   usbdevfs_sb;
+		struct cramfs_sb_info	cramfs_sb;
 		void			*generic_sbp;
 	} u;
 	/*
diff -urN linux-2.4.0-orig/scripts/cramfs/GNUmakefile linux/scripts/cramfs/GNUmakefile
--- linux-2.4.0-orig/scripts/cramfs/GNUmakefile	Tue Jan 11 10:24:58 2000
+++ linux/scripts/cramfs/GNUmakefile	Sat Jan 13 18:50:47 2001
@@ -1,7 +1,8 @@
-CFLAGS = -Wall -O2
-CPPFLAGS = -I../../fs/cramfs
+CC = gcc
+CFLAGS = -W -Wall -O2 -g
+CPPFLAGS = -I../../include
 LDLIBS = -lz
-PROGS = mkcramfs
+PROGS = mkcramfs cramfsck
 
 all: $(PROGS)
 
diff -urN linux-2.4.0-orig/scripts/cramfs/cramfsck.c linux/scripts/cramfs/cramfsck.c
--- linux-2.4.0-orig/scripts/cramfs/cramfsck.c	Wed Dec 31 16:00:00 1969
+++ linux/scripts/cramfs/cramfsck.c	Sat Jan 13 20:39:35 2001
@@ -0,0 +1,588 @@
+/*
+ * cramfsck - check a cramfs file system
+ *
+ * Copyright (C) 2000 Transmeta Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * 1999/12/03: Linus Torvalds (cramfs tester and unarchive program)
+ * 2000/06/03: Daniel Quinlan (CRC and length checking program)
+ * 2000/06/04: Daniel Quinlan (merged programs, added options, support
+ *                            for special files, preserve permissions and
+ *                            ownership, cramfs superblock v2, bogus mode
+ *                            test, pathname length test, etc.)
+ * 2000/06/06: Daniel Quinlan (support for holes, pretty-printing,
+ *                            symlink size test)
+ * 2000/07/11: Daniel Quinlan (file length tests, start at offset 0 or 512,
+ *                            fsck-compatible exit codes)
+ * 2000/07/15: Daniel Quinlan (initial support for block devices)
+ */
+
+/* compile-time options */
+#define INCLUDE_FS_TESTS	/* include cramfs checking and extraction */
+
+#include <sys/types.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/fcntl.h>
+#include <dirent.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <assert.h>
+#include <getopt.h>
+#include <sys/sysmacros.h>
+#include <utime.h>
+#include <sys/ioctl.h>
+#define _LINUX_STRING_H_
+#include <linux/fs.h>
+#include <linux/cramfs_fs.h>
+#include <zlib.h>
+
+static const char *progname = "cramfsck";
+
+static int fd;			/* ROM image file descriptor */
+static char *filename;		/* ROM image filename */
+struct cramfs_super *super;	/* just find the cramfs superblock once */
+static int opt_verbose = 0;	/* 1 = verbose (-v), 2+ = very verbose (-vv) */
+#ifdef INCLUDE_FS_TESTS
+static int opt_extract = 0;	/* extract cramfs (-x) */
+char *extract_dir = NULL;	/* extraction directory (-x) */
+
+unsigned long start_inode = 1 << 28;	/* start of first non-root inode */
+unsigned long end_inode = 0;		/* end of the directory structure */
+unsigned long start_data = 1 << 28;	/* start of the data (256 MB = max) */
+unsigned long end_data = 0;		/* end of the data */
+/* true?  cramfs_super < start_inode < end_inode <= start_data <= end_data */
+static uid_t euid;			/* effective UID */
+
+#define PAD_SIZE 512
+#define PAGE_CACHE_SIZE (4096)
+
+/* Guarantee access to at least 8kB at a time */
+#define ROMBUFFER_BITS	13
+#define ROMBUFFERSIZE	(1 << ROMBUFFER_BITS)
+#define ROMBUFFERMASK	(ROMBUFFERSIZE-1)
+static char read_buffer[ROMBUFFERSIZE * 2];
+static unsigned long read_buffer_block = ~0UL;
+
+/* Uncompressing data structures... */
+static char outbuffer[PAGE_CACHE_SIZE*2];
+z_stream stream;
+
+#endif /* INCLUDE_FS_TESTS */
+
+/* Input status of 0 to print help and exit without an error. */
+static void usage(int status)
+{
+	FILE *stream = status ? stderr : stdout;
+
+	fprintf(stream, "usage: %s [-hv] [-x dir] file\n"
+		" -h         print this help\n"
+		" -x dir     extract into dir\n"
+		" -v         be more verbose\n"
+		" file       file to test\n", progname);
+
+	exit(status);
+}
+
+#ifdef INCLUDE_FS_TESTS
+void print_node(char type, struct cramfs_inode *i, char *name)
+{
+	char info[10];
+
+	if (S_ISCHR(i->mode) || (S_ISBLK(i->mode))) {
+		/* major/minor numbers can be as high as 2^12 or 4096 */
+		snprintf(info, 10, "%4d,%4d", major(i->size), minor(i->size));
+	}
+	else {
+		/* size be as high as 2^24 or 16777216 */
+		snprintf(info, 10, "%9d", i->size);
+	}
+
+	printf("%c %04o %s %5d:%-3d %s\n",
+	       type, i->mode & ~S_IFMT, info, i->uid, i->gid, name);
+}
+
+/*
+ * Create a fake "blocked" access
+ */
+static void *romfs_read(unsigned long offset)
+{
+	unsigned int block = offset >> ROMBUFFER_BITS;
+	if (block != read_buffer_block) {
+		read_buffer_block = block;
+		lseek(fd, block << ROMBUFFER_BITS, SEEK_SET);
+		read(fd, read_buffer, ROMBUFFERSIZE * 2);
+	}
+	return read_buffer + (offset & ROMBUFFERMASK);
+}
+
+static struct cramfs_inode *cramfs_iget(struct cramfs_inode * i)
+{
+	struct cramfs_inode *inode = malloc(sizeof(struct cramfs_inode));
+	*inode = *i;
+	return inode;
+}
+
+static struct cramfs_inode *iget(unsigned int ino)
+{
+	return cramfs_iget(romfs_read(ino));
+}
+
+void iput(struct cramfs_inode *inode)
+{
+	free(inode);
+}
+
+/*
+ * Return the offset of the root directory,
+ * or 0 if none.
+ */
+static struct cramfs_inode *read_super(void)
+{
+	unsigned long offset;
+
+	offset = super->root.offset << 2;
+	if (super->magic != CRAMFS_MAGIC)
+		return NULL;
+	if (memcmp(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature)) != 0)
+		return NULL;
+	if (offset < sizeof(super))
+		return NULL;
+	return cramfs_iget(&super->root);
+}
+
+static int uncompress_block(void *src, int len)
+{
+	int err;
+
+	stream.next_in = src;
+	stream.avail_in = len;
+
+	stream.next_out = (unsigned char *) outbuffer;
+	stream.avail_out = PAGE_CACHE_SIZE*2;
+
+	inflateReset(&stream);
+
+	err = inflate(&stream, Z_FINISH);
+	if (err != Z_STREAM_END) {
+		fprintf(stderr, "%s: error %d while decompressing! %p(%d)\n",
+			filename, err, src, len);
+		exit(4);
+	}
+	return stream.total_out;
+}
+
+static void change_file_status(char *path, struct cramfs_inode *i)
+{
+	struct utimbuf epoch = { 0, 0 };
+
+	if (euid == 0) {
+		if (lchown(path, i->uid, i->gid) < 0) {
+			perror(path);
+			exit(8);
+		}
+		if (S_ISLNK(i->mode))
+			return;
+		if ((S_ISUID | S_ISGID) & i->mode) {
+			if (chmod(path, i->mode) < 0) {
+				perror(path);
+				exit(8);
+			}
+		}
+	}
+	if (S_ISLNK(i->mode))
+		return;
+	if (utime(path, &epoch) < 0) {
+		perror(path);
+		exit(8);
+	}
+}
+
+static void do_symlink(char *path, struct cramfs_inode *i)
+{
+	unsigned long offset = i->offset << 2;
+	unsigned long curr = offset + 4;
+	unsigned long next = *(u32 *) romfs_read(offset);
+	unsigned long size;
+
+	if (next > end_data) {
+		end_data = next;
+	}
+
+	size = uncompress_block(romfs_read(curr), next - curr);
+	if (size != i->size) {
+		fprintf(stderr, "%s: size error in symlink `%s'\n",
+			filename, path);
+		exit(4);
+	}
+	outbuffer[size] = 0;
+	if (opt_verbose) {
+		char *str;
+
+		str = malloc(strlen(outbuffer) + strlen(path) + 5);
+		strcpy(str, path);
+		strncat(str, " -> ", 4);
+		strncat(str, outbuffer, size);
+
+		print_node('l', i, str);
+		if (opt_verbose > 1) {
+			printf("  uncompressing block at %ld to %ld (%ld)\n", curr, next, next - curr);
+		}
+	}
+	if (opt_extract) {
+		symlink(outbuffer, path);
+		change_file_status(path, i);
+	}
+}
+
+static void do_special_inode(char *path, struct cramfs_inode *i)
+{
+	dev_t devtype = 0;
+	char type;
+
+	if (S_ISCHR(i->mode)) {
+		devtype = i->size;
+		type = 'c';
+	}
+	else if (S_ISBLK(i->mode)) {
+		devtype = i->size;
+		type = 'b';
+	}
+	else if (S_ISFIFO(i->mode))
+		type = 'p';
+	else if (S_ISSOCK(i->mode))
+		type = 's';
+	else {
+		fprintf(stderr, "%s: bogus mode on `%s' (%o)\n", filename, path, i->mode);
+		exit(4);
+	}
+
+	if (opt_verbose) {
+		print_node(type, i, path);
+	}
+
+	if (opt_extract) {
+		if (mknod(path, i->mode, devtype) < 0) {
+			perror(path);
+			exit(8);
+		}
+		change_file_status(path, i);
+	}
+}
+
+static void do_uncompress(int fd, unsigned long offset, unsigned long size)
+{
+	unsigned long curr = offset + 4 * ((size + PAGE_CACHE_SIZE - 1) / PAGE_CACHE_SIZE);
+
+	do {
+		unsigned long out = PAGE_CACHE_SIZE;
+		unsigned long next = *(u32 *) romfs_read(offset);
+
+		if (next > end_data) {
+			end_data = next;
+		}
+
+		offset += 4;
+		if (curr == next) {
+			if (opt_verbose > 1) {
+				printf("  hole at %ld (%d)\n", curr, PAGE_CACHE_SIZE);
+			}
+			if (size < PAGE_CACHE_SIZE)
+				out = size;
+			memset(outbuffer, 0x00, out);
+		}
+		else {
+			if (opt_verbose > 1) {
+				printf("  uncompressing block at %ld to %ld (%ld)\n", curr, next, next - curr);
+			}
+			out = uncompress_block(romfs_read(curr), next - curr);
+		}
+		if (size >= PAGE_CACHE_SIZE) {
+			if (out != PAGE_CACHE_SIZE) {
+				fprintf(stderr, "%s: Non-block (%ld) bytes\n", filename, out);
+				exit(4);
+			}
+		} else {
+			if (out != size) {
+				fprintf(stderr, "%s: Non-size (%ld vs %ld) bytes\n", filename, out, size);
+				exit(4);
+			}
+		}
+		size -= out;
+		if (opt_extract) {
+			write(fd, outbuffer, out);
+		}
+		curr = next;
+	} while (size);
+}
+
+static void expand_fs(int pathlen, char *path, struct cramfs_inode *inode)
+{
+	if (S_ISDIR(inode->mode)) {
+		int count = inode->size;
+		unsigned long offset = inode->offset << 2;
+		char *newpath = malloc(pathlen + 256);
+
+		if (count > 0 && offset < start_inode) {
+			start_inode = offset;
+		}
+		/* XXX - need to check end_inode for empty case? */
+		memcpy(newpath, path, pathlen);
+		newpath[pathlen] = '/';
+		pathlen++;
+		if (opt_verbose) {
+			print_node('d', inode, path);
+		}
+		if (opt_extract) {
+			mkdir(path, inode->mode);
+			change_file_status(path, inode);
+		}
+		while (count > 0) {
+			struct cramfs_inode *child = iget(offset);
+			int size;
+			int newlen = child->namelen << 2;
+
+			size = sizeof(struct cramfs_inode) + newlen;
+			count -= size;
+
+			offset += sizeof(struct cramfs_inode);
+
+			memcpy(newpath + pathlen, romfs_read(offset), newlen);
+			newpath[pathlen + newlen] = 0;
+			if ((pathlen + newlen) - strlen(newpath) > 3) {
+				fprintf(stderr, "%s: invalid cramfs--bad path length\n", filename);
+				exit(4);
+			}
+			expand_fs(strlen(newpath), newpath, child);
+
+			offset += newlen;
+
+			if (offset > end_inode) {
+				end_inode = offset;
+			}
+		}
+		return;
+	}
+	if (S_ISREG(inode->mode)) {
+		int fd = 0;
+		unsigned long offset = inode->offset << 2;
+
+		if (offset > 0 && offset < start_data) {
+			start_data = offset;
+		}
+		if (opt_verbose) {
+			print_node('f', inode, path);
+		}
+		if (opt_extract) {
+			fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, inode->mode);
+		}
+		if (inode->size) {
+			do_uncompress(fd, offset, inode->size);
+		}
+		if (opt_extract) {
+			close(fd);
+			change_file_status(path, inode);
+		}
+		return;
+	}
+	if (S_ISLNK(inode->mode)) {
+		unsigned long offset = inode->offset << 2;
+
+		if (offset < start_data) {
+			start_data = offset;
+		}
+		do_symlink(path, inode);
+		return;
+	}
+	else {
+		do_special_inode(path, inode);
+		return;
+	}
+}
+#endif /* INCLUDE_FS_TESTS */
+
+int main(int argc, char **argv)
+{
+	void *buf;
+	size_t length;
+	struct stat st;
+	u32 crc_old, crc_new;
+#ifdef INCLUDE_FS_TESTS
+	struct cramfs_inode *root;
+#endif /* INCLUDE_FS_TESTS */
+	int c;			/* for getopt */
+	int start = 0;
+
+	if (argc)
+		progname = argv[0];
+
+	/* command line options */
+	while ((c = getopt(argc, argv, "hx:v")) != EOF) {
+		switch (c) {
+		case 'h':
+			usage(0);
+		case 'x':
+#ifdef INCLUDE_FS_TESTS
+			opt_extract = 1;
+			extract_dir = malloc(strlen(optarg) + 1);
+			strcpy(extract_dir, optarg);
+			break;
+#else /*  not INCLUDE_FS_TESTS */
+			fprintf(stderr, "%s: compiled without -x support\n",
+				progname);
+			exit(16);
+#endif /* not INCLUDE_FS_TESTS */
+		case 'v':
+			opt_verbose++;
+			break;
+		}
+	}
+
+	if ((argc - optind) != 1)
+		usage(16);
+	filename = argv[optind];
+
+	/* find the physical size of the file or block device */
+	if (lstat(filename, &st) < 0) {
+		perror(filename);
+		exit(8);
+	}
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		exit(8);
+	}
+	if (S_ISBLK(st.st_mode)) {
+		if (ioctl(fd, BLKGETSIZE, &length) < 0) {
+			fprintf(stderr, "%s: warning--unable to determine filesystem size \n", filename);
+			exit(4);
+		}
+		length = length * 512;
+	}
+	else if (S_ISREG(st.st_mode)) {
+		length = st.st_size;
+	}
+	else {
+		fprintf(stderr, "%s is not a block device or file\n", filename);
+		exit(8);
+	}
+
+	if (length < sizeof(struct cramfs_super)) {
+		fprintf(stderr, "%s: invalid cramfs--file length too short\n", filename);
+		exit(4);
+	}
+
+	if (S_ISBLK(st.st_mode)) {
+		/* nasty because mmap of block devices fails */
+		buf = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		read(fd, buf, length);
+	}
+	else {
+		/* nice and easy */
+		buf = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	}
+
+	/* XXX - this could be cleaner... */
+	if (((struct cramfs_super *) buf)->magic == CRAMFS_MAGIC) {
+		start = 0;
+		super = (struct cramfs_super *) buf;
+	}
+	else if (length >= (PAD_SIZE + sizeof(struct cramfs_super)) &&
+		 ((((struct cramfs_super *) (buf + PAD_SIZE))->magic == CRAMFS_MAGIC)))
+	{
+		start = PAD_SIZE;
+		super = (struct cramfs_super *) (buf + PAD_SIZE);
+	}
+	else {
+		fprintf(stderr, "%s: invalid cramfs--wrong magic\n", filename);
+		exit(4);
+	}
+
+	if (super->flags & CRAMFS_FLAG_FSID_VERSION_2) {
+		/* length test */
+		if (length < super->size) {
+			fprintf(stderr, "%s: invalid cramfs--file length too short\n", filename);
+			exit(4);
+		}
+		else if (length > super->size) {
+			fprintf(stderr, "%s: warning--file length too long, padded image?\n", filename);
+		}
+
+		/* CRC test */
+		crc_old = super->fsid.crc;
+		super->fsid.crc = crc32(0L, Z_NULL, 0);
+		crc_new = crc32(0L, Z_NULL, 0);
+		crc_new = crc32(crc_new, (unsigned char *) buf+start, super->size - start);
+		if (crc_new != crc_old) {
+			fprintf(stderr, "%s: invalid cramfs--crc error\n", filename);
+			exit(4);
+		}
+	}
+	else {
+		fprintf(stderr, "%s: warning--old cramfs image, no CRC\n",
+			filename);
+	}
+
+#ifdef INCLUDE_FS_TESTS
+	super = (struct cramfs_super *) malloc(sizeof(struct cramfs_super));
+	if (((struct cramfs_super *) buf)->magic == CRAMFS_MAGIC) {
+		memcpy(super, buf, sizeof(struct cramfs_super));
+	}
+	else if (length >= (PAD_SIZE + sizeof(struct cramfs_super)) &&
+		 ((((struct cramfs_super *) (buf + PAD_SIZE))->magic == CRAMFS_MAGIC)))
+	{
+		memcpy(super, (buf + PAD_SIZE), sizeof(struct cramfs_super));
+	}
+
+	munmap(buf, length);
+
+	/* file format test, uses fake "blocked" accesses */
+	root = read_super();
+	umask(0);
+	euid = geteuid();
+	if (!root) {
+		fprintf(stderr, "%s: invalid cramfs--bad superblock\n",
+			filename);
+		exit(4);
+	}
+	stream.next_in = NULL;
+	stream.avail_in = 0;
+	inflateInit(&stream);
+
+	if (!extract_dir) {
+		extract_dir = "root";
+	}
+
+	expand_fs(strlen(extract_dir), extract_dir, root);
+	inflateEnd(&stream);
+
+	if (start_data != 1 << 28  && end_inode != start_data) {
+		fprintf(stderr, "%s: invalid cramfs--directory data end (%ld) != file data start (%ld)\n", filename, end_inode, start_data);
+		exit(4);
+	}
+	if (super->flags & CRAMFS_FLAG_FSID_VERSION_2) {
+		if (end_data > super->size) {
+			fprintf(stderr, "%s: invalid cramfs--invalid file data offset\n", filename);
+			exit(4);
+		}
+	}
+#endif /* INCLUDE_FS_TESTS */
+
+	exit(0);
+}
diff -urN linux-2.4.0-orig/scripts/cramfs/mkcramfs.c linux/scripts/cramfs/mkcramfs.c
--- linux-2.4.0-orig/scripts/cramfs/mkcramfs.c	Mon Jun 19 13:45:52 2000
+++ linux/scripts/cramfs/mkcramfs.c	Sun Jan 14 12:12:14 2001
@@ -1,3 +1,23 @@
+/*
+ * mkcramfs - make a cramfs file system
+ *
+ * Copyright (C) 1999-2000 Transmeta Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
 #include <sys/types.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -9,43 +29,55 @@
 #include <errno.h>
 #include <string.h>
 #include <assert.h>
-
-/* zlib required.. */
+#include <getopt.h>
+#include <linux/cramfs_fs.h>
 #include <zlib.h>
 
-typedef unsigned char u8;
-typedef unsigned short u16;
-typedef unsigned int u32;
-
-#include "cramfs.h"
+#define PAD_SIZE 512		/* only 0 and 512 supported by kernel */
 
 static const char *progname = "mkcramfs";
 
 /* N.B. If you change the disk format of cramfs, please update fs/cramfs/README. */
 
-static void usage(void)
+/* Input status of 0 to print help and exit without an error. */
+static void usage(int status)
 {
-	fprintf(stderr, "Usage: '%s dirname outfile'\n"
-		" where <dirname> is the root of the\n"
-		" filesystem to be compressed.\n", progname);
-	exit(1);
-}
+	FILE *stream = status ? stderr : stdout;
 
-/*
- * If DO_HOLES is defined, then mkcramfs can create explicit holes in the
- * data, which saves 26 bytes per hole (which is a lot smaller a saving than
- * most filesystems).
- *
- * Note that kernels up to at least 2.3.39 don't support cramfs holes, which
- * is why this defaults to undefined at the moment.
- */
-/* #define DO_HOLES 1 */
+	fprintf(stream, "usage: %s [-h] [-e edition] [-i file] [-n name] dirname outfile\n"
+		" -h         print this help\n"
+		" -e edition set edition number (part of fsid)\n"
+		" -i file    insert a file image into the filesystem (requires >= 2.4.0)\n"
+		" -n name    set name of cramfs filesystem\n"
+		" -p         pad by %d bytes for boot code\n"
+		" -s         sort directory entries (old option, ignored)\n"
+		" -z         make explicit holes (requires >= 2.3.39)\n"
+		" dirname    root of the filesystem to be compressed\n"
+		" outfile    output file\n", progname, PAD_SIZE);
+
+	exit(status);
+}
 
 #define PAGE_CACHE_SIZE (4096)
 /* The kernel assumes PAGE_CACHE_SIZE as block size. */
 static unsigned int blksize = PAGE_CACHE_SIZE;
+static long total_blocks = 0, total_nodes = 1; /* pre-count the root node */
+static int image_length = 0;
+
+/*
+ * If opt_holes is set, then mkcramfs can create explicit holes in the
+ * data, which saves 26 bytes per hole (which is a lot smaller a
+ * saving than most most filesystems).
+ *
+ * Note that kernels up to at least 2.3.39 don't support cramfs holes,
+ * which is why this is turned off by default.
+ */
+static int opt_holes = 0;
+static int opt_edition = 0;
+static int opt_pad = 0;
+static char *opt_name = NULL, *opt_image = NULL;
 
-static int warn_dev, warn_gid, warn_namelen, warn_size, warn_uid;
+static int warn_dev, warn_gid,  warn_namelen, warn_size, warn_uid;
 
 #ifndef MIN
 # define MIN(_a,_b) ((_a) < (_b) ? (_a) : (_b))
@@ -70,15 +102,6 @@
 };
 
 /*
- * Width of various bitfields in struct cramfs_inode.
- * Used only to generate warnings.
- */
-#define SIZE_WIDTH 24
-#define UID_WIDTH 16
-#define GID_WIDTH 8
-#define OFFSET_WIDTH 26
-
-/*
  * The longest file name component to allow for in the input directory tree.
  * Ext2fs (and many others) allow up to 255 bytes.  A couple of filesystems
  * allow longer (e.g. smbfs 1024), but there isn't much use in supporting
@@ -101,27 +124,30 @@
 
 static void eliminate_doubles(struct entry *root,struct entry *orig) {
         if(orig) {
-                if(orig->size && orig->uncompressed) 
+                if(orig->size && orig->uncompressed)
 			find_identical_file(root,orig);
                 eliminate_doubles(root,orig->child);
                 eliminate_doubles(root,orig->next);
         }
 }
 
+/*
+ * We define our own sorting function instead of using alphasort which
+ * uses strcoll and changes ordering based on locale information.
+ */
+static int cramsort (const void *a, const void *b)
+{
+	return strcmp ((*(const struct dirent **) a)->d_name,
+		       (*(const struct dirent **) b)->d_name);
+}
+
 static unsigned int parse_directory(struct entry *root_entry, const char *name, struct entry **prev, loff_t *fslen_ub)
 {
-	DIR *dir;
-	int count = 0, totalsize = 0;
-	struct dirent *dirent;
+	struct dirent **dirlist;
+	int totalsize = 0, dircount, dirindex;
 	char *path, *endpath;
 	size_t len = strlen(name);
 
-	dir = opendir(name);
-	if (!dir) {
-		perror(name);
-		exit(2);
-	}
-
 	/* Set up the path. */
 	/* TODO: Reuse the parent's buffer to save memcpy'ing and duplication. */
 	path = malloc(len + 1 + MAX_INPUT_NAMELEN + 1);
@@ -134,12 +160,24 @@
 	*endpath = '/';
 	endpath++;
 
-	while ((dirent = readdir(dir)) != NULL) {
+        /* read in the directory and sort */
+        dircount = scandir(name, &dirlist, 0, cramsort);
+
+	if (dircount < 0) {
+		perror(name);
+		exit(2);
+	}
+
+	/* process directory */
+	for (dirindex = 0; dirindex < dircount; dirindex++) {
+		struct dirent *dirent;
 		struct entry *entry;
 		struct stat st;
 		int size;
 		size_t namelen;
 
+		dirent = dirlist[dirindex];
+
 		/* Ignore "." and ".." - we won't be adding them to the archive */
 		if (dirent->d_name[0] == '.') {
 			if (dirent->d_name[1] == '\0')
@@ -184,10 +222,10 @@
 		entry->mode = st.st_mode;
 		entry->size = st.st_size;
 		entry->uid = st.st_uid;
-		if (entry->uid >= 1 << UID_WIDTH)
+		if (entry->uid >= 1 << CRAMFS_UID_WIDTH)
 			warn_uid = 1;
 		entry->gid = st.st_gid;
-		if (entry->gid >= 1 << GID_WIDTH)
+		if (entry->gid >= 1 << CRAMFS_GID_WIDTH)
 			/* TODO: We ought to replace with a default
                            gid instead of truncating; otherwise there
                            are security problems.  Maybe mode should
@@ -214,9 +252,9 @@
 				continue;
 			}
 			if (entry->size) {
-				if ((entry->size >= 1 << SIZE_WIDTH)) {
+				if ((entry->size >= 1 << CRAMFS_SIZE_WIDTH)) {
 					warn_size = 1;
-					entry->size = (1 << SIZE_WIDTH) - 1;
+					entry->size = (1 << CRAMFS_SIZE_WIDTH) - 1;
 				}
 
 				entry->uncompressed = mmap(NULL, entry->size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -238,55 +276,57 @@
 			}
 		} else {
 			entry->size = st.st_rdev;
-			if (entry->size & -(1<<SIZE_WIDTH))
+			if (entry->size & -(1<<CRAMFS_SIZE_WIDTH))
 				warn_dev = 1;
 		}
 
 		if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
+			int blocks = ((entry->size - 1) / blksize + 1);
+
 			/* block pointers & data expansion allowance + data */
-                        if(entry->size) 
-                                *fslen_ub += ((4+26)*((entry->size - 1) / blksize + 1)
-                                              + MIN(entry->size + 3, st.st_blocks << 9));
-                        else 
-                                *fslen_ub += MIN(entry->size + 3, st.st_blocks << 9);
+			if(entry->size)
+				*fslen_ub += (4+26)*blocks + entry->size + 3;
                 }
 
 		/* Link it into the list */
 		*prev = entry;
 		prev = &entry->next;
-		count++;
 		totalsize += size;
 	}
-	closedir(dir);
 	free(path);
+	free(dirlist);		/* allocated by scandir() with malloc() */
 	return totalsize;
 }
 
-static void set_random(void *area, size_t size)
-{
-	int fd = open("/dev/random", O_RDONLY);
-
-	if (fd >= 0) {
-		if (read(fd, area, size) == size)
-			return;
-	}
-	memset(area, 0x00, size);
-}
-
 /* Returns sizeof(struct cramfs_super), which includes the root inode. */
-static unsigned int write_superblock(struct entry *root, char *base)
+static unsigned int write_superblock(struct entry *root, char *base, int size)
 {
 	struct cramfs_super *super = (struct cramfs_super *) base;
-	unsigned int offset = sizeof(struct cramfs_super);
+	unsigned int offset = sizeof(struct cramfs_super) + image_length;
+
+	if (opt_pad) {
+		offset += opt_pad;
+	}
 
 	super->magic = CRAMFS_MAGIC;
-	super->flags = 0;
-	/* Note: 0x10000 is meaningless, which is a bug; but
-	   super->size is never used anyway. */
-	super->size = 0x10000;
+	super->flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
+	if (opt_holes)
+		super->flags |= CRAMFS_FLAG_HOLES;
+	if (image_length > 0)
+		super->flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
+	super->size = size;
 	memcpy(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature));
-	set_random(super->fsid, sizeof(super->fsid));
-	strncpy(super->name, "Compressed", sizeof(super->name));
+
+	super->fsid.crc = crc32(0L, Z_NULL, 0);
+	super->fsid.edition = opt_edition;
+	super->fsid.blocks = total_blocks;
+	super->fsid.files = total_nodes;
+
+	memset(super->name, 0x00, sizeof(super->name));
+	if (opt_name)
+		strncpy(super->name, opt_name, sizeof(super->name));
+	else
+		strncpy(super->name, "Compressed", sizeof(super->name));
 
 	super->root.mode = root->mode;
 	super->root.uid = root->uid;
@@ -300,8 +340,10 @@
 static void set_data_offset(struct entry *entry, char *base, unsigned long offset)
 {
 	struct cramfs_inode *inode = (struct cramfs_inode *) (base + entry->dir_offset);
+#ifdef DEBUG
 	assert ((offset & 3) == 0);
-	if (offset >= (1 << (2 + OFFSET_WIDTH))) {
+#endif /* DEBUG */
+	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH))) {
 		fprintf(stderr, "filesystem too big.  Exiting.\n");
 		exit(1);
 	}
@@ -337,6 +379,7 @@
 			   write over inode->offset later. */
 
 			offset += sizeof(struct cramfs_inode);
+			total_nodes++;	/* another node */
 			memcpy(base + offset, entry->name, len);
 			/* Pad up the name to a 4-byte boundary */
 			while (len & 3) {
@@ -393,26 +436,24 @@
 	return offset;
 }
 
-#ifdef DO_HOLES
-/*
- * Returns non-zero iff the first LEN bytes from BEGIN are all NULs.
- */
-static int
-is_zero(char const *begin, unsigned len)
+static int is_zero(char const *begin, unsigned len)
 {
-	return (len-- == 0 ||
-		(begin[0] == '\0' &&
-		 (len-- == 0 ||
-		  (begin[1] == '\0' &&
-		   (len-- == 0 ||
-		    (begin[2] == '\0' &&
-		     (len-- == 0 ||
-		      (begin[3] == '\0' &&
-		       memcmp(begin, begin + 4, len) == 0))))))));
-}
-#else /* !DO_HOLES */
-# define is_zero(_begin,_len) (0)  /* Never create holes. */
-#endif /* !DO_HOLES */
+	if (opt_holes)
+		/* Returns non-zero iff the first LEN bytes from BEGIN are
+		   all NULs. */
+		return (len-- == 0 ||
+			(begin[0] == '\0' &&
+			 (len-- == 0 ||
+			  (begin[1] == '\0' &&
+			   (len-- == 0 ||
+			    (begin[2] == '\0' &&
+			     (len-- == 0 ||
+			      (begin[3] == '\0' &&
+			       memcmp(begin, begin + 4, len) == 0))))))));
+	else
+		/* Never create holes. */
+		return 0;
+}
 
 /*
  * One 4-byte pointer per block and then the actual blocked
@@ -433,6 +474,8 @@
 	unsigned long curr = offset + 4 * blocks;
 	int change;
 
+	total_blocks += blocks;
+
 	do {
 		unsigned long len = 2 * blksize;
 		unsigned int input = size;
@@ -493,6 +536,27 @@
 	return offset;
 }
 
+static unsigned int write_file(char *file, char *base, unsigned int offset)
+{
+	int fd;
+	char *buf;
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		perror(file);
+		exit(1);
+	}
+	buf = mmap(NULL, image_length, PROT_READ, MAP_PRIVATE, fd, 0);
+	memcpy(base + offset, buf, image_length);
+	munmap(buf, image_length);
+	close (fd);
+	/* Pad up the image_length to a 4-byte boundary */
+	while (image_length & 3) {
+		*(base + offset + image_length) = '\0';
+		image_length++;
+	}
+	return (offset + image_length);
+}
 
 /*
  * Maximum size fs you can create is roughly 256MB.  (The last file's
@@ -501,9 +565,9 @@
  * Note that if you want it to fit in a ROM then you're limited to what the
  * hardware and kernel can support (64MB?).
  */
-#define MAXFSLEN ((((1 << OFFSET_WIDTH) - 1) << 2) /* offset */ \
-		  + (1 << SIZE_WIDTH) - 1 /* filesize */ \
-		  + (1 << SIZE_WIDTH) * 4 / PAGE_CACHE_SIZE /* block pointers */ )
+#define MAXFSLEN ((((1 << CRAMFS_OFFSET_WIDTH) - 1) << 2) /* offset */ \
+		  + (1 << CRAMFS_SIZE_WIDTH) - 1 /* filesize */ \
+		  + (1 << CRAMFS_SIZE_WIDTH) * 4 / PAGE_CACHE_SIZE /* block pointers */ )
 
 
 /*
@@ -517,26 +581,64 @@
  */
 int main(int argc, char **argv)
 {
-	struct stat st;
+	struct stat st;		/* used twice... */
 	struct entry *root_entry;
 	char *rom_image;
-	unsigned int offset;
-	ssize_t written;
+	ssize_t offset, written;
 	int fd;
-	loff_t fslen_ub = 0; /* initial guess (upper-bound) of
-				required filesystem size */
-	char const *dirname;
+	loff_t fslen_ub = blksize; /* initial guess (upper-bound) of
+				      required filesystem size */
+	char const *dirname, *outfile;
+	u32 crc = crc32(0L, Z_NULL, 0);
+	int c;			/* for getopt */
+
+	total_blocks = 0;
 
 	if (argc)
 		progname = argv[0];
-	if (argc != 3)
-		usage();
 
-	if (stat(dirname = argv[1], &st) < 0) {
-		perror(argv[1]);
+	/* command line options */
+	while ((c = getopt(argc, argv, "he:i:n:zps")) != EOF) {
+		switch (c) {
+		case 'h':
+			usage(0);
+		case 'e':
+			opt_edition = atoi(optarg);
+			break;
+		case 'i':
+			opt_image = optarg;
+			if (lstat(opt_image, &st) < 0) {
+				perror(opt_image);
+				exit(1);
+			}
+			image_length = st.st_size; /* may be padded later */
+			fslen_ub += (image_length + 3); /* 3 is for padding */
+			break;
+		case 'n':
+			opt_name = optarg;
+			break;
+		case 'p':
+			opt_pad = PAD_SIZE;
+			break;
+		case 's':
+			/* old option, ignored */
+			break;
+		case 'z':
+			opt_holes = 1;
+			break;
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(1);
+	dirname = argv[optind];
+	outfile = argv[optind + 1];
+
+	if (stat(dirname, &st) < 0) {
+		perror(dirname);
 		exit(1);
 	}
-	fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	fd = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 
 	root_entry = calloc(1, sizeof(struct entry));
 	if (!root_entry) {
@@ -547,11 +649,11 @@
 	root_entry->uid = st.st_uid;
 	root_entry->gid = st.st_gid;
 
-	root_entry->size = parse_directory(root_entry, argv[1], &root_entry->child, &fslen_ub);
+	root_entry->size = parse_directory(root_entry, dirname, &root_entry->child, &fslen_ub);
 	if (fslen_ub > MAXFSLEN) {
 		fprintf(stderr,
-			"warning: guestimate of required size (upper bound) is %luMB, but maximum image size is %uMB.  We might die prematurely.\n",
-			(unsigned long) (fslen_ub >> 20),
+			"warning: guestimate of required size (upper bound) is %LdMB, but maximum image size is %uMB.  We might die prematurely.\n",
+			fslen_ub >> 20,
 			MAXFSLEN >> 20);
 		fslen_ub = MAXFSLEN;
 	}
@@ -560,7 +662,6 @@
            possible. */
         eliminate_doubles(root_entry,root_entry);
 
-
 	/* TODO: Why do we use a private/anonymous mapping here
            followed by a write below, instead of just a shared mapping
            and a couple of ftruncate calls?  Is it just to save us
@@ -570,13 +671,25 @@
            RAM free.  If the reason is to be able to write to
            un-mmappable block devices, then we could try shared mmap
            and revert to anonymous mmap if the shared mmap fails. */
-	rom_image = mmap(NULL, fslen_ub, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	rom_image = mmap(NULL, fslen_ub?fslen_ub:1, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
 	if (-1 == (int) (long) rom_image) {
 		perror("ROM image map");
 		exit(1);
 	}
-	offset = write_superblock(root_entry, rom_image);
-	printf("Super block: %d bytes\n", offset);
+
+	/* Skip the first opt_pad bytes for boot loader code */
+	offset = opt_pad;
+	memset(rom_image, 0x00, opt_pad);
+
+	/* Skip the superblock and come back to write it later. */
+	offset += sizeof(struct cramfs_super);
+
+	/* Insert a file image. */
+	if (opt_image) {
+		printf("Including: %s\n", opt_image);
+		offset = write_file(opt_image, rom_image, offset);
+	}
 
 	offset = write_directory_structure(root_entry->child, rom_image, offset);
 	printf("Directory data: %d bytes\n", offset);
@@ -588,9 +701,25 @@
 	offset = ((offset - 1) | (blksize - 1)) + 1;
 	printf("Everything: %d kilobytes\n", offset >> 10);
 
+	/* Write the superblock now that we can fill in all of the fields. */
+	write_superblock(root_entry, rom_image+opt_pad, offset);
+	printf("Super block: %d bytes\n", sizeof(struct cramfs_super));
+
+	/* Put the checksum in. */
+	crc = crc32(crc, (rom_image+opt_pad), (offset-opt_pad));
+	((struct cramfs_super *) (rom_image+opt_pad))->fsid.crc = crc;
+	printf("CRC: %x\n", crc);
+
+	/* Check to make sure we allocated enough space. */
+	if (fslen_ub < offset) {
+		fprintf(stderr, "not enough space allocated for ROM image (%Ld allocated, %d used)\n",
+			fslen_ub, offset);
+		exit(1);
+	}
+
 	written = write(fd, rom_image, offset);
 	if (written < 0) {
-		perror("rom image");
+		perror("ROM image");
 		exit(1);
 	}
 	if (offset != written) {
@@ -606,19 +735,19 @@
 	if (warn_size)
 		fprintf(stderr,
 			"warning: file sizes truncated to %luMB (minus 1 byte).\n",
-			1L << (SIZE_WIDTH - 20));
+			1L << (CRAMFS_SIZE_WIDTH - 20));
 	if (warn_uid) /* (not possible with current Linux versions) */
 		fprintf(stderr,
 			"warning: uids truncated to %u bits.  (This may be a security concern.)\n",
-			UID_WIDTH);
+			CRAMFS_UID_WIDTH);
 	if (warn_gid)
 		fprintf(stderr,
 			"warning: gids truncated to %u bits.  (This may be a security concern.)\n",
-			GID_WIDTH);
+			CRAMFS_GID_WIDTH);
 	if (warn_dev)
 		fprintf(stderr,
 			"WARNING: device numbers truncated to %u bits.  This almost certainly means\n"
 			"that some device files will be wrong.\n",
-			OFFSET_WIDTH);
+			CRAMFS_OFFSET_WIDTH);
 	return 0;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
