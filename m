Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSBZAEh>; Mon, 25 Feb 2002 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292530AbSBZAE0>; Mon, 25 Feb 2002 19:04:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25873 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292527AbSBZAED>; Mon, 25 Feb 2002 19:04:03 -0500
From: Daniel Quinlan <quinlan@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15482.53460.90295.920987@sodium.transmeta.com>
Date: Mon, 25 Feb 2002 16:03:32 -0800 (PST)
To: linux-kernel@vger.kernel.org
Cc: quinlan@transmeta.com
Subject: [PATCH] cramfs big-endian user-space patch
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: quinlan@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cramfs CVS tree is under http://sourceforge.net/projects/cramfs/

This patch is against the "linux" module, use the HEAD of the tree.

 - Dan

Index: Documentation/filesystems/cramfs.txt
===================================================================
RCS file: /cvsroot/cramfs/linux/Documentation/filesystems/cramfs.txt,v
retrieving revision 1.3
diff -u -r1.3 cramfs.txt
--- Documentation/filesystems/cramfs.txt	16 Feb 2002 00:25:15 -0000	1.3
+++ Documentation/filesystems/cramfs.txt	25 Feb 2002 23:35:51 -0000
@@ -37,12 +37,11 @@
 the update lasts only as long as the inode is cached in memory, after
 which the timestamp reverts to 1970, i.e. moves backwards in time.
 
-Currently, cramfs must be written and read with architectures of the
-same endianness, and can be read only by kernels with PAGE_CACHE_SIZE
-== 4096.  At least the latter of these is a bug, but it hasn't been
-decided what the best fix is.  For the moment if you have larger pages
-you can just change the #define in mkcramfs.c, so long as you don't
-mind the filesystem becoming unreadable to future kernels.
+Currently, cramfs can be read only by kernels with PAGE_CACHE_SIZE ==
+4096.  This is a bug, but it hasn't been decided what the best fix is.
+For the moment if you have larger pages you can just change the
+#define in mkcramfs.c, so long as you don't mind the filesystem
+becoming unreadable to future kernels.
 
 
 For /usr/share/magic
Index: fs/cramfs/README
===================================================================
RCS file: /cvsroot/cramfs/linux/fs/cramfs/README,v
retrieving revision 1.4
diff -u -r1.4 README
--- fs/cramfs/README	22 Feb 2002 23:56:14 -0000	1.4
+++ fs/cramfs/README	25 Feb 2002 23:35:51 -0000
@@ -6,8 +6,8 @@
 swapped around (though it does care that directory entries (inodes) in
 a given directory are contiguous, as this is used by readdir).
 
-All data is currently in host-endian format; neither mkcramfs nor the
-kernel ever do swabbing.  (See section `Block Size' below.)
+All data is in little-endian format; user-space tools and the kernel do
+swabbing on big-endian systems.  (See section `Byte Order' below.)
 
 <filesystem>:
 	<superblock>
@@ -71,6 +71,27 @@
 with -z if you want it to create files that can have holes in them.
 
 
+Byte Order
+----------
+
+When defining the cramfs filesystem, the two options for byte order were
+`always use little-endian' (like ext2fs) or `writer chooses endianness;
+kernel adapts at runtime'.  Little-endian wins because of code
+simplicity and little CPU overhead even on big-endian machines.
+
+While cramfs has always been defined to be little-endian, this
+implementation originally required that cramfs filesystems be written
+and read with architectures of the same endianness; big-endian machines
+would write and read cramfs filesystems with big-endian byte order (the
+"incorrect" byte order for cramfs filesystems).
+
+Now, only little-endian cramfs filesystems are supported for both
+little-endian and big-endian machines.  If you need to support
+big-endian cramfs filesystems for a legacy application on a big-endian
+machine, you could remove the byte-swapping, but it would probably be
+better to write a one-time byte order conversion program.
+
+
 Tools
 -----
 
@@ -108,17 +129,8 @@
 PAGE_CACHE_SIZE is subject to change between kernel versions
 (currently possible with arm and ia64).
 
-The remaining options try to make cramfs more sharable.
-
-One part of that is addressing endianness.  The two options here are
-`always use little-endian' (like ext2fs) or `writer chooses
-endianness; kernel adapts at runtime'.  Little-endian wins because of
-code simplicity and little CPU overhead even on big-endian machines.
-
-The cost of swabbing is changing the code to use the le32_to_cpu
-etc. macros as used by ext2fs.  We don't need to swab the compressed
-data, only the superblock, inodes and block pointers.
-
+The remaining options try to make cramfs more sharable by choosing a
+block size.  The options are:
 
 The other part of making cramfs more sharable is choosing a block
 size.  The options are:
@@ -152,7 +164,6 @@
 cost is greater complexity.  Probably not worth it, but I hope someone
 will disagree.  (If it is implemented, then I'll re-use that code in
 e2compr.)
-
 
 Another cost of 2 and 3 over 1 is making mkcramfs use a different
 block size, but that just means adding and parsing a -b option.
Index: fs/cramfs/inode.c
===================================================================
RCS file: /cvsroot/cramfs/linux/fs/cramfs/inode.c,v
retrieving revision 1.4
diff -u -r1.4 inode.c
--- fs/cramfs/inode.c	22 Feb 2002 23:55:16 -0000	1.4
+++ fs/cramfs/inode.c	25 Feb 2002 23:35:51 -0000
@@ -39,7 +39,7 @@
 
 /* These two macros may change in future, to provide better st_ino
    semantics. */
-#define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
+#define CRAMINO(x)	(CRAMFS_GET_OFFSET(x) ? CRAMFS_GET_OFFSET(x)<<2 : 1)
 #define OFFSET(x)	((x)->i_ino)
 
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
@@ -47,16 +47,16 @@
 	struct inode * inode = new_inode(sb);
 
 	if (inode) {
-		inode->i_mode = cramfs_inode->mode;
-		inode->i_uid = cramfs_inode->uid;
-		inode->i_size = cramfs_inode->size;
-		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
+		inode->i_mode = CRAMFS_16(cramfs_inode->mode);
+		inode->i_uid = CRAMFS_16(cramfs_inode->uid);
+		inode->i_size = CRAMFS_24(cramfs_inode->size);
+		inode->i_blocks = (CRAMFS_24(cramfs_inode->size) - 1)/512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
-	           contents.  1 yields the right result in GNU find, even
+		   contents.  1 yields the right result in GNU find, even
 		   without -noleaf option. */
 		insert_inode_hash(inode);
 		if (S_ISREG(inode->i_mode)) {
@@ -70,7 +70,7 @@
 			inode->i_data.a_ops = &cramfs_aops;
 		} else {
 			inode->i_size = 0;
-			init_special_inode(inode, inode->i_mode, cramfs_inode->size);
+			init_special_inode(inode, inode->i_mode, CRAMFS_24(cramfs_inode->size));
 		}
 	}
 	return inode;
@@ -153,7 +153,7 @@
 
 		bh = NULL;
 		if (blocknr + i < devsize) {
-			bh = getblk(sb->s_dev, blocknr + i, PAGE_CACHE_SIZE);
+			bh = sb_getblk(sb, blocknr + i);
 			if (!buffer_uptodate(bh))
 				read_array[unread++] = bh;
 		}
@@ -209,15 +209,18 @@
 	up(&read_mutex);
 
 	/* Do sanity checks on the superblock */
-	if (super.magic != CRAMFS_MAGIC) {
+	if (super.magic != CRAMFS_32(CRAMFS_MAGIC)) {
 		/* check at 512 byte offset */
 		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
-		if (super.magic != CRAMFS_MAGIC) {
+		if (super.magic != CRAMFS_32(CRAMFS_MAGIC)) {
 			printk(KERN_ERR "cramfs: wrong magic\n");
 			goto out;
 		}
 	}
 
+	/* flags is reused several times, so swab it once */
+	super.flags = CRAMFS_32(super.flags);
+
 	/* get feature flags first */
 	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
 		printk(KERN_ERR "cramfs: unsupported filesystem features\n");
@@ -225,22 +228,22 @@
 	}
 
 	/* Check that the root inode is in a sane state */
-	if (!S_ISDIR(super.root.mode)) {
+	if (!S_ISDIR(CRAMFS_16(super.root.mode))) {
 		printk(KERN_ERR "cramfs: root is not a directory\n");
 		goto out;
 	}
-	root_offset = super.root.offset << 2;
+	root_offset = CRAMFS_GET_OFFSET(&(super.root)) << 2;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
-		sb->CRAMFS_SB_SIZE=super.size;
-		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
-		sb->CRAMFS_SB_FILES=super.fsid.files;
+		sb->CRAMFS_SB_SIZE = CRAMFS_32(super.size);
+		sb->CRAMFS_SB_BLOCKS = CRAMFS_32(super.fsid.blocks);
+		sb->CRAMFS_SB_FILES = CRAMFS_32(super.fsid.files);
 	} else {
-		sb->CRAMFS_SB_SIZE=1<<28;
-		sb->CRAMFS_SB_BLOCKS=0;
-		sb->CRAMFS_SB_FILES=0;
+		sb->CRAMFS_SB_SIZE = 1 << 28;
+		sb->CRAMFS_SB_BLOCKS = 0;
+		sb->CRAMFS_SB_FILES = 0;
 	}
-	sb->CRAMFS_SB_MAGIC=super.magic;
-	sb->CRAMFS_SB_FLAGS=super.flags;
+	sb->CRAMFS_SB_MAGIC = CRAMFS_MAGIC;
+	sb->CRAMFS_SB_FLAGS = super.flags;
 	if (root_offset == 0)
 		printk(KERN_INFO "cramfs: empty filesystem");
 	else if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
@@ -307,7 +310,7 @@
 		 * and the name padded out to 4-byte boundaries
 		 * with zeroes.
 		 */
-		namelen = de->namelen << 2;
+		namelen = CRAMFS_GET_NAMELEN(de) << 2;
 		nextoffset = offset + sizeof(*de) + namelen;
 		for (;;) {
 			if (!namelen)
@@ -316,7 +319,7 @@
 				break;
 			namelen--;
 		}
-		error = filldir(dirent, name, namelen, offset, CRAMINO(de), de->mode >> 12);
+		error = filldir(dirent, name, namelen, offset, CRAMINO(de), CRAMFS_16(de->mode) >> 12);
 		if (error)
 			break;
 
@@ -349,7 +352,7 @@
 		if (sorted && (dentry->d_name.name[0] < name[0]))
 			break;
 
-		namelen = de->namelen << 2;
+		namelen = CRAMFS_GET_NAMELEN(de) << 2;
 		offset += sizeof(*de) + namelen;
 
 		/* Quick check that the name is roughly the right length */
@@ -396,8 +399,8 @@
 		start_offset = OFFSET(inode) + maxblock*4;
 		down(&read_mutex);
 		if (page->index)
-			start_offset = *(u32 *) cramfs_read(sb, blkptr_offset-4, 4);
-		compr_len = (*(u32 *) cramfs_read(sb, blkptr_offset, 4) - start_offset);
+			start_offset = CRAMFS_32(*(u32 *) cramfs_read(sb, blkptr_offset-4, 4));
+		compr_len = CRAMFS_32(*(u32 *) cramfs_read(sb, blkptr_offset, 4)) - start_offset;
 		up(&read_mutex);
 		pgdata = kmap(page);
 		if (compr_len == 0)
Index: include/linux/cramfs_fs.h
===================================================================
RCS file: /cvsroot/cramfs/linux/include/linux/cramfs_fs.h,v
retrieving revision 1.2
diff -u -r1.2 cramfs_fs.h
--- include/linux/cramfs_fs.h	17 Jan 2002 02:24:19 -0000	1.2
+++ include/linux/cramfs_fs.h	25 Feb 2002 23:35:51 -0000
@@ -1,13 +1,25 @@
-#ifndef __CRAMFS_H
-#define __CRAMFS_H
+#ifndef __CRAMFS_FS_H
+#define __CRAMFS_FS_H
 
-#ifndef __KERNEL__
+#ifdef __KERNEL__
+
+#include <asm/byteorder.h>
+
+/* Uncompression interfaces to the underlying zlib */
+int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
+int cramfs_uncompress_init(void);
+int cramfs_uncompress_exit(void);
+
+#else /* not __KERNEL__ */
+
+#include <byteswap.h>
+#include <endian.h>
 
 typedef unsigned char u8;
 typedef unsigned short u16;
 typedef unsigned int u32;
 
-#endif
+#endif /* not __KERNEL__ */
 
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_SIGNATURE	"Compressed ROMFS"
@@ -90,9 +102,50 @@
 				| CRAMFS_FLAG_WRONG_SIGNATURE \
 				| CRAMFS_FLAG_SHIFTED_ROOT_OFFSET )
 
-/* Uncompression interfaces to the underlying zlib */
-int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
-int cramfs_uncompress_init(void);
-int cramfs_uncompress_exit(void);
+/*
+ * Since cramfs is little-endian, provide macros to swab the bitfields.
+ */
+
+#ifndef __BYTE_ORDER
+#if defined(__LITTLE_ENDIAN) && !defined(__BIG_ENDIAN)
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#elif defined(__BIG_ENDIAN) && !defined(__LITTLE_ENDIAN)
+#define __BYTE_ORDER __BIG_ENDIAN
+#else
+#error "unable to define __BYTE_ORDER"
+#endif
+#endif /* not __BYTE_ORDER */
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#warning  "__BYTE_ORDER == __LITTLE_ENDIAN"
+#define CRAMFS_16(x)	(x)
+#define CRAMFS_24(x)	(x)
+#define CRAMFS_32(x)	(x)
+#define CRAMFS_GET_NAMELEN(x)	((x)->namelen)
+#define CRAMFS_GET_OFFSET(x)	((x)->offset)
+#define CRAMFS_SET_OFFSET(x,y)	((x)->offset = (y))
+#define CRAMFS_SET_NAMELEN(x,y)	((x)->namelen = (y))
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#warning "__BYTE_ORDER == __BIG_ENDIAN"
+#ifdef __KERNEL__
+#define CRAMFS_16(x)	swab16(x)
+#define CRAMFS_24(x)	((swab32(x)) >> 8)
+#define CRAMFS_32(x)	swab32(x)
+#else /* not __KERNEL__ */
+#define CRAMFS_16(x)	bswap_16(x)
+#define CRAMFS_24(x)	((bswap_32(x)) >> 8)
+#define CRAMFS_32(x)	bswap_32(x)
+#endif /* not __KERNEL__ */
+#define CRAMFS_GET_NAMELEN(x)	(((u8*)(x))[8] & 0x3f)
+#define CRAMFS_GET_OFFSET(x)	((CRAMFS_24(((u32*)(x))[2] & 0xffffff) << 2) |\
+				 ((((u32*)(x))[2] & 0xc0000000) >> 30))
+#define CRAMFS_SET_NAMELEN(x,y)	(((u8*)(x))[8] = (((0x3f & (y))) | \
+						  (0xc0 & ((u8*)(x))[8])))
+#define CRAMFS_SET_OFFSET(x,y)	(((u32*)(x))[2] = (((y) & 3) << 30) | \
+				 CRAMFS_24((((y) & 0x03ffffff) >> 2)) | \
+				 (((u32)(((u8*)(x))[8] & 0x3f)) << 24))
+#else
+#error "__BYTE_ORDER must be __LITTLE_ENDIAN or __BIG_ENDIAN"
 #endif
+
+#endif /* not __CRAMFS_FS_H */
Index: scripts/cramfs/cramfsck.c
===================================================================
RCS file: /cvsroot/cramfs/linux/scripts/cramfs/cramfsck.c,v
retrieving revision 1.4
diff -u -r1.4 cramfsck.c
--- scripts/cramfs/cramfsck.c	22 Feb 2002 23:56:47 -0000	1.4
+++ scripts/cramfs/cramfsck.c	25 Feb 2002 23:35:52 -0000
@@ -30,6 +30,8 @@
  * 2000/07/15: Daniel Quinlan (initial support for block devices)
  * 2002/01/10: Daniel Quinlan (additional checks, test more return codes,
  *                            use read if mmap fails, standardize messages)
+ * 2002/02/22: Brad Bozarth,  (add support for big-endian systems)
+ *             Daniel Quinlan
  */
 
 /* compile-time options */
@@ -162,7 +164,7 @@
 	if (read(fd, &super, sizeof(super)) != sizeof(super)) {
 		die(FSCK_ERROR, 1, "read failed: %s", filename);
 	}
-	if (super.magic == CRAMFS_MAGIC) {
+	if (super.magic == CRAMFS_32(CRAMFS_MAGIC)) {
 		*start = 0;
 	}
 	else if (*length >= (PAD_SIZE + sizeof(super))) {
@@ -170,15 +172,24 @@
 		if (read(fd, &super, sizeof(super)) != sizeof(super)) {
 			die(FSCK_ERROR, 1, "read failed: %s", filename);
 		}
-		if (super.magic == CRAMFS_MAGIC) {
+		if (super.magic == CRAMFS_32(CRAMFS_MAGIC)) {
 			*start = PAD_SIZE;
 		}
 	}
 
 	/* superblock tests */
-	if (super.magic != CRAMFS_MAGIC) {
+	if (super.magic != CRAMFS_32(CRAMFS_MAGIC)) {
 		die(FSCK_UNCORRECTED, 0, "superblock magic not found");
 	}
+#if __BYTE_ORDER == __BIG_ENDIAN
+	super.size = CRAMFS_32(super.size);
+	super.flags = CRAMFS_32(super.flags);
+	super.future = CRAMFS_32(super.future);
+	super.fsid.crc = CRAMFS_32(super.fsid.crc);
+	super.fsid.edition = CRAMFS_32(super.fsid.edition);
+	super.fsid.blocks = CRAMFS_32(super.fsid.blocks);
+	super.fsid.files = CRAMFS_32(super.fsid.files);
+#endif /* __BYTE_ORDER == __BIG_ENDIAN */
 	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
 		die(FSCK_ERROR, 0, "unsupported filesystem features");
 	}
@@ -296,14 +307,23 @@
 	return read_buffer + (offset & ROMBUFFERMASK);
 }
 
-static struct cramfs_inode *cramfs_iget(struct cramfs_inode * i)
+static struct cramfs_inode *cramfs_iget(struct cramfs_inode *i)
 {
 	struct cramfs_inode *inode = malloc(sizeof(struct cramfs_inode));
 
 	if (!inode) {
 		die(FSCK_ERROR, 1, "malloc failed");
 	}
+#if __BYTE_ORDER == __BIG_ENDIAN
+	inode->mode = CRAMFS_16(i->mode);
+	inode->uid = CRAMFS_16(i->uid);
+	inode->size = CRAMFS_24(i->size);
+	inode->gid = i->gid;
+	inode->namelen = CRAMFS_GET_NAMELEN(i);
+	inode->offset = CRAMFS_GET_OFFSET(i);
+#else /* not __BYTE_ORDER == __BIG_ENDIAN */
 	*inode = *i;
+#endif /* not __BYTE_ORDER == __BIG_ENDIAN */
 	return inode;
 }
 
@@ -317,24 +337,6 @@
 	free(inode);
 }
 
-/*
- * Return the offset of the root directory
- */
-static struct cramfs_inode *read_super(void)
-{
-	unsigned long offset = super.root.offset << 2;
-
-	if (!S_ISDIR(super.root.mode))
-		die(FSCK_UNCORRECTED, 0, "root inode is not directory");
-	if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
-	    ((offset != sizeof(struct cramfs_super)) &&
-	     (offset != PAD_SIZE + sizeof(struct cramfs_super))))
-	{
-		die(FSCK_UNCORRECTED, 0, "bad root offset (%lu)", offset);
-	}
-	return cramfs_iget(&super.root);
-}
-
 static int uncompress_block(void *src, int len)
 {
 	int err;
@@ -364,7 +366,7 @@
 
 	do {
 		unsigned long out = PAGE_CACHE_SIZE;
-		unsigned long next = *(u32 *) romfs_read(offset);
+		unsigned long next = CRAMFS_32(*(u32 *) romfs_read(offset));
 
 		if (next > end_data) {
 			end_data = next;
@@ -525,7 +527,7 @@
 {
 	unsigned long offset = i->offset << 2;
 	unsigned long curr = offset + 4;
-	unsigned long next = *(u32 *) romfs_read(offset);
+	unsigned long next = CRAMFS_32(*(u32 *) romfs_read(offset));
 	unsigned long size;
 
 	if (offset == 0) {
@@ -629,8 +631,18 @@
 static void test_fs(int start)
 {
 	struct cramfs_inode *root;
+	unsigned long root_offset;
 
-	root = read_super();
+	root = cramfs_iget(&super.root);
+	root_offset = root->offset << 2;
+	if (!S_ISDIR(root->mode))
+		die(FSCK_UNCORRECTED, 0, "root inode is not directory");
+	if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
+	    ((root_offset != sizeof(struct cramfs_super)) &&
+	     (root_offset != PAD_SIZE + sizeof(struct cramfs_super))))
+	{
+		die(FSCK_UNCORRECTED, 0, "bad root offset (%lu)", root_offset);
+	}
 	umask(0);
 	euid = geteuid();
 	stream.next_in = NULL;
Index: scripts/cramfs/mkcramfs.c
===================================================================
RCS file: /cvsroot/cramfs/linux/scripts/cramfs/mkcramfs.c,v
retrieving revision 1.4
diff -u -r1.4 mkcramfs.c
--- scripts/cramfs/mkcramfs.c	19 Feb 2002 10:13:34 -0000	1.4
+++ scripts/cramfs/mkcramfs.c	25 Feb 2002 23:35:52 -0000
@@ -380,19 +380,20 @@
 
 	offset += opt_pad;	/* 0 if no padding */
 
-	super->magic = CRAMFS_MAGIC;
+	super->magic = CRAMFS_32(CRAMFS_MAGIC);
 	super->flags = CRAMFS_FLAG_FSID_VERSION_2 | CRAMFS_FLAG_SORTED_DIRS;
 	if (opt_holes)
 		super->flags |= CRAMFS_FLAG_HOLES;
 	if (image_length > 0)
 		super->flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
-	super->size = size;
+	super->flags = CRAMFS_32(super->flags);
+	super->size = CRAMFS_32(size);
 	memcpy(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature));
 
-	super->fsid.crc = crc32(0L, Z_NULL, 0);
-	super->fsid.edition = opt_edition;
-	super->fsid.blocks = total_blocks;
-	super->fsid.files = total_nodes;
+	super->fsid.crc = CRAMFS_32(crc32(0L, Z_NULL, 0));
+	super->fsid.edition = CRAMFS_32(opt_edition);
+	super->fsid.blocks = CRAMFS_32(total_blocks);
+	super->fsid.files = CRAMFS_32(total_nodes);
 
 	memset(super->name, 0x00, sizeof(super->name));
 	if (opt_name)
@@ -400,11 +401,11 @@
 	else
 		strncpy(super->name, "Compressed", sizeof(super->name));
 
-	super->root.mode = root->mode;
-	super->root.uid = root->uid;
+	super->root.mode = CRAMFS_16(root->mode);
+	super->root.uid = CRAMFS_16(root->uid);
 	super->root.gid = root->gid;
-	super->root.size = root->size;
-	super->root.offset = offset >> 2;
+	super->root.size = CRAMFS_24(root->size);
+	CRAMFS_SET_OFFSET(&(super->root), offset >> 2);
 
 	return offset;
 }
@@ -419,7 +420,7 @@
 	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH))) {
 		die(MKFS_ERROR, 0, "filesystem too big");
 	}
-	inode->offset = (offset >> 2);
+	CRAMFS_SET_OFFSET(inode, offset >> 2);
 }
 
 /*
@@ -481,10 +482,10 @@
 
 			entry->dir_offset = offset;
 
-			inode->mode = entry->mode;
-			inode->uid = entry->uid;
+			inode->mode = CRAMFS_16(entry->mode);
+			inode->uid = CRAMFS_16(entry->uid);
 			inode->gid = entry->gid;
-			inode->size = entry->size;
+			inode->size = CRAMFS_24(entry->size);
 			inode->offset = 0;
 			/* Non-empty directories, regfiles and symlinks will
 			   write over inode->offset later. */
@@ -497,7 +498,7 @@
 				*(base + offset + len) = '\0';
 				len++;
 			}
-			inode->namelen = len >> 2;
+			CRAMFS_SET_NAMELEN(inode, len >> 2);
 			offset += len;
 
 			if (opt_verbose)
@@ -608,7 +609,7 @@
 			die(MKFS_ERROR, 0, "AIEEE: block \"compressed\" to > 2*blocklength (%ld)", len);
 		}
 
-		*(u32 *) (base + offset) = curr;
+		*(u32 *) (base + offset) = CRAMFS_32(curr);
 		offset += 4;
 	} while (size);
 
@@ -823,7 +824,7 @@
 	/* Put the checksum in. */
 	crc = crc32(0L, Z_NULL, 0);
 	crc = crc32(crc, (rom_image+opt_pad), (offset-opt_pad));
-	((struct cramfs_super *) (rom_image+opt_pad))->fsid.crc = crc;
+	((struct cramfs_super *) (rom_image+opt_pad))->fsid.crc = CRAMFS_32(crc);
 	printf("CRC: %x\n", crc);
 
 	/* Check to make sure we allocated enough space. */
