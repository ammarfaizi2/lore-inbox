Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315254AbSDWQ3t>; Tue, 23 Apr 2002 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSDWQ3s>; Tue, 23 Apr 2002 12:29:48 -0400
Received: from krynn.axis.se ([193.13.178.10]:12701 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S315254AbSDWQ3r>;
	Tue, 23 Apr 2002 12:29:47 -0400
Date: Tue, 23 Apr 2002 18:26:32 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
X-X-Sender: <johana@ado-2.axis.se>
To: <linux-kernel@vger.kernel.org>
cc: Johan Adolfsson <johan.adolfsson@axis.com>
Subject: [PATCH and RFC] Compact time in cramfs
Message-ID: <Pine.LNX.4.33.0204231821150.21049-100000@ado-2.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following patch gives a cramfs filesystem a single timestamp
stored in the superblock. It uses the "future" field so no space
is wasted.
mkcramfs uses the newest mtime or ctime from the filesystem.

We is this feature good then?
For example: embedded systems with a webserver can now,
instead of simply generating a Last-Modified: header with
Jan 01 1970.. that the browser will use when caching stuff
provide an accurate timestamp that will change between
firmware releases making caching in the browser work better.

Patch is against 2.4.18 for everything except mkcramfs.c
which is a heavily hacked version although you should get the idea.
It has moved from the kernel anyway in 2.4.19-pre7.

Does it look ok?
Obvious improvements are to rename the future field in the superblock
to fstime and remove the fprintf.

/Johan



Index: linux/scripts/cramfs/mkcramfs.c
===================================================================
RCS file: /n/cvsroot/os/linux/scripts/cramfs/mkcramfs.c,v
retrieving revision 1.8
diff -u -p -r1.8 mkcramfs.c
--- linux/scripts/cramfs/mkcramfs.c	7 Sep 2001 11:31:28 -0000	1.8
+++ linux/scripts/cramfs/mkcramfs.c	23 Apr 2002 15:26:16 -0000
@@ -34,6 +34,7 @@
 #include <getopt.h>
 #include <linux/cramfs_fs.h>
 #include <zlib.h>
+#include <time.h>

 #define PAD_SIZE 512		/* only 0 and 512 supported by kernel */

@@ -71,6 +72,8 @@ static unsigned int blksize = DEFAULT_PA
 static long total_blocks = 0, total_nodes = 1; /* pre-count the root node */
 static int image_length = 0;

+static time_t newest_time = 0; /* Newest file in the filesystem */
+
 /*
  * If opt_holes is set, then mkcramfs can create explicit holes in the
  * data, which saves 26 bytes per hole (which is a lot smaller a
@@ -576,6 +579,13 @@ static unsigned int parse_directory(stru
 			warn_skip = 1;
 			continue;
 		}
+		/* Update the newest time */
+		if (st.st_mtime > newest_time) {
+			newest_time = st.st_mtime;
+		}
+		if (st.st_ctime > newest_time) {
+			newest_time = st.st_ctime;
+		}
 		entry = calloc(1, sizeof(struct entry));
 		if (!entry) {
 			perror(NULL);
@@ -708,7 +718,8 @@ static unsigned int write_superblock(str
 	if (opt_pad) {
 		offset += opt_pad;
 	}
-
+	fprintf(stderr, "Newest time: %lu = %s \n", (unsigned long)newest_time, ctime(&newest_time));
+	super->future = newest_time;
 	super->magic = CRAMFS_MAGIC;
 	super->flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
 	if (opt_holes)
Index: linux/include/linux/cramfs_fs.h
===================================================================
RCS file: /n/cvsroot/os/linux/include/linux/cramfs_fs.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 cramfs_fs.h
--- linux/include/linux/cramfs_fs.h	24 Jul 2001 12:41:48 -0000	1.1.1.1
+++ linux/include/linux/cramfs_fs.h	23 Apr 2002 15:26:24 -0000
@@ -55,7 +55,7 @@ struct cramfs_super {
 	u32 magic;		/* 0x28cd3d45 - random number */
 	u32 size;		/* length in bytes */
 	u32 flags;		/* 0 */
-	u32 future;		/* 0 */
+	u32 future;		/* Newest ctime or mtime for the filesystem */
 	u8 signature[16];	/* "Compressed ROMFS" */
 	struct cramfs_info fsid;	/* unique filesystem info */
 	u8 name[16];		/* user-defined name */
Index: linux/include/linux/cramfs_fs_sb.h
===================================================================
RCS file: /n/cvsroot/os/linux/include/linux/cramfs_fs_sb.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 cramfs_fs_sb.h
--- linux/include/linux/cramfs_fs_sb.h	24 Jul 2001 12:41:48 -0000	1.1.1.1
+++ linux/include/linux/cramfs_fs_sb.h	23 Apr 2002 15:26:29 -0000
@@ -5,11 +5,12 @@
  * cramfs super-block data in memory
  */
 struct cramfs_sb_info {
-			unsigned long magic;
-			unsigned long size;
-			unsigned long blocks;
-			unsigned long files;
-			unsigned long flags;
+	unsigned long magic;
+	unsigned long size;
+	unsigned long blocks;
+	unsigned long files;
+	unsigned long flags;
+	unsigned long fstime; /* From the future field, max(mtime, ctime) */
 };

 #endif
Index: linux/fs/cramfs/inode.c
===================================================================
RCS file: /n/cvsroot/os/linux/fs/cramfs/inode.c,v
retrieving revision 1.16
diff -u -p -r1.16 inode.c
--- linux/fs/cramfs/inode.c	12 Apr 2002 11:38:08 -0000	1.16
+++ linux/fs/cramfs/inode.c	23 Apr 2002 15:26:35 -0000
@@ -28,6 +28,7 @@
 #define CRAMFS_SB_BLOCKS u.cramfs_sb.blocks
 #define CRAMFS_SB_FILES u.cramfs_sb.files
 #define CRAMFS_SB_FLAGS u.cramfs_sb.flags
+#define CRAMFS_SB_FSTIME u.cramfs_sb.fstime

 #define CRAMFS_AS_IMAGE

@@ -56,6 +57,8 @@ static struct inode *get_cramfs_inode(st
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
+		inode->i_mtime = sb->CRAMFS_SB_FSTIME;
+		inode->i_ctime = sb->CRAMFS_SB_FSTIME;
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
 	           contents.  1 yields the right result in GNU find, even
@@ -267,6 +270,7 @@ static struct super_block * cramfs_read_
 	}
 	sb->CRAMFS_SB_MAGIC=super.magic;
 	sb->CRAMFS_SB_FLAGS=super.flags;
+	sb->CRAMFS_SB_FSTIME=super.future;
 	if (root_offset == 0)
 		printk(KERN_INFO "cramfs: empty filesystem");
 	else if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&


