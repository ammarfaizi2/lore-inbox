Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271520AbRIBPef>; Sun, 2 Sep 2001 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271634AbRIBPe0>; Sun, 2 Sep 2001 11:34:26 -0400
Received: from ns.caldera.de ([212.34.180.1]:48287 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271520AbRIBPeP>;
	Sun, 2 Sep 2001 11:34:15 -0400
Date: Sun, 2 Sep 2001 17:33:57 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] System V filesystem update
Message-ID: <20010902173357.C11520@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch updates the System V filesystem driver to the latest
version from Alan's tree.

The follwoing updates are included:

  o add SCO fast symlink support (me)
  o add readonly SCO AFS support (me)
  o be more graceful in the case of a wrong filesystem type (aeb)

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/sysv/Makefile linux/fs/sysv/Makefile
--- ../master/linux-2.4.10-pre3/fs/sysv/Makefile	Mon Jul  2 23:03:04 2001
+++ linux/fs/sysv/Makefile	Sun Sep  2 17:04:47 2001
@@ -9,7 +9,8 @@
 
 O_TARGET := sysv.o
 
-obj-y   := ialloc.o balloc.o inode.o itree.o file.o dir.o namei.o super.o
+obj-y   := ialloc.o balloc.o inode.o itree.o file.o dir.o \
+	   namei.o super.o symlink.o
 obj-m   := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/sysv/balloc.c linux/fs/sysv/balloc.c
--- ../master/linux-2.4.10-pre3/fs/sysv/balloc.c	Mon Jul  2 23:03:04 2001
+++ linux/fs/sysv/balloc.c	Sun Sep  2 17:04:47 2001
@@ -46,6 +46,14 @@
 	unsigned count;
 	unsigned block = fs32_to_cpu(sb, nr);
 
+	/*
+	 * This code does not work at all for AFS (it has a bitmap
+	 * free list).  As AFS is supposed to be read-only no one
+	 * should call this for an AFS filesystem anyway...
+	 */
+	if (sb->sv_type == FSTYPE_AFS)
+		return;
+
 	if (block < sb->sv_firstdatazone || block >= sb->sv_nzones) {
 		printk("sysv_free_block: trying to free block not in datazone\n");
 		return;
@@ -154,6 +162,14 @@
 	unsigned block;
 	int n;
 
+	/*
+	 * This code does not work at all for AFS (it has a bitmap
+	 * free list).  As AFS is supposed to be read-only we just
+	 * lie and say it has no free block at all.
+	 */
+	if (sb->sv_type == FSTYPE_AFS)
+		return 0;
+
 	lock_super(sb);
 	sb_count = fs32_to_cpu(sb, *sb->sv_free_blocks);
 
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/sysv/inode.c linux/fs/sysv/inode.c
--- ../master/linux-2.4.10-pre3/fs/sysv/inode.c	Wed Jul 18 03:53:55 2001
+++ linux/fs/sysv/inode.c	Sun Sep  2 17:16:38 2001
@@ -131,8 +131,11 @@
 		inode->i_fop = &sysv_dir_operations;
 		inode->i_mapping->a_ops = &sysv_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &sysv_symlink_inode_operations;
-		inode->i_mapping->a_ops = &sysv_aops;
+		if (inode->i_blocks) {
+			inode->i_op = &sysv_symlink_inode_operations;
+			inode->i_mapping->a_ops = &sysv_aops;
+		} else
+			inode->i_op = &sysv_fast_symlink_inode_operations;
 	} else
 		init_special_inode(inode, inode->i_mode, rdev);
 }
@@ -196,7 +199,6 @@
 				attr->ia_mode = COH_KLUDGE_NOT_SYMLINK;
 
 	inode_setattr(inode, attr);
-
 	return 0;
 }
 
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/sysv/super.c linux/fs/sysv/super.c
--- ../master/linux-2.4.10-pre3/fs/sysv/super.c	Mon Jul  2 23:03:04 2001
+++ linux/fs/sysv/super.c	Sun Sep  2 17:04:47 2001
@@ -26,11 +26,16 @@
 #include <linux/sysv_fs.h>
 #include <linux/init.h>
 
-/* The following functions try to recognize specific filesystems.
+/*
+ * The following functions try to recognize specific filesystems.
+ *
  * We recognize:
  * - Xenix FS by its magic number.
  * - SystemV FS by its magic number.
  * - Coherent FS by its funny fname/fpack field.
+ * - SCO AFS by s_nfree == 0xffff
+ * - V7 FS has no distinguishing features.
+ *
  * We discriminate among SystemV4 and SystemV2 FS by the assumption that
  * the time stamp is not < 01-01-1980.
  */
@@ -197,7 +202,19 @@
 		sb->sv_bytesex = BYTESEX_BE;
 	else
 		return 0;
-	if (sbd->s_time < JAN_1_1980) {
+ 
+ 	if (fs16_to_cpu(sb, sbd->s_nfree) == 0xffff) {
+ 		sb->sv_type = FSTYPE_AFS;
+ 		if (!(sb->s_flags & MS_RDONLY)) {
+ 			printk("SysV FS: SCO EAFS on %s detected, " 
+ 				"forcing read-only mode.\n", 
+ 				bdevname(sb->s_dev));
+ 			sb->s_flags |= MS_RDONLY;
+ 		}
+ 		return sbd->s_type;
+ 	}
+ 
+	if (fs32_to_cpu(sb, sbd->s_time) < JAN_1_1980) {
 		/* this is likely to happen on SystemV2 FS */
 		if (sbd->s_type > 3 || sbd->s_type < 1)
 			return 0;
@@ -261,6 +278,7 @@
 	[FSTYPE_SYSV2]	"SystemV Release 2",
 	[FSTYPE_COH]	"Coherent",
 	[FSTYPE_V7]	"V7",
+	[FSTYPE_AFS]	"AFS",
 };
 
 static void (*flavour_setup[])(struct super_block *) = {
@@ -269,6 +287,7 @@
 	[FSTYPE_SYSV2]	detected_sysv2,
 	[FSTYPE_COH]	detected_coherent,
 	[FSTYPE_V7]	detected_v7,
+	[FSTYPE_AFS]	detected_sysv4,
 };
 
 static int complete_read_super(struct super_block *sb, int silent, int size)
@@ -294,7 +313,8 @@
 	sb->sv_toobig_block = 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
 	sb->sv_ind_per_block_bits = n_bits-2;
 
-	sb->sv_ninodes = (sb->sv_firstdatazone - sb->sv_firstinodezone) << sb->sv_inodes_per_block_bits;
+	sb->sv_ninodes = (sb->sv_firstdatazone - sb->sv_firstinodezone)
+		<< sb->sv_inodes_per_block_bits;
 
 	sb->s_blocksize = bsize;
 	sb->s_blocksize_bits = n_bits;
@@ -346,13 +366,10 @@
 	sb->sv_block_base = 0;
 
 	for (i = 0; i < sizeof(flavours)/sizeof(flavours[0]) && !size; i++) {
-		struct buffer_head *next_bh;
-		next_bh = bread(dev, flavours[i].block, BLOCK_SIZE);
-		if (!next_bh)
-			continue;
 		brelse(bh);
-		bh = next_bh;
-
+		bh = bread(dev, flavours[i].block, BLOCK_SIZE);
+		if (!bh)
+			continue;
 		size = flavours[i].test(sb, bh);
 	}
 
@@ -411,8 +428,10 @@
 static struct super_block *v7_read_super(struct super_block *sb,void *data,
 				  int silent)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bh, *bh2 = NULL;
 	kdev_t dev = sb->s_dev;
+	struct v7_super_block *v7sb;
+	struct sysv_inode *v7i;
 
 	if (440 != sizeof (struct v7_super_block))
 		panic("V7 FS: bad super-block size");
@@ -422,23 +441,41 @@
 	sb->sv_type = FSTYPE_V7;
 	sb->sv_bytesex = BYTESEX_PDP;
 
-	set_blocksize(dev,512);
+	set_blocksize(dev, 512);
 
 	if ((bh = bread(dev, 1, 512)) == NULL) {
 		if (!silent)
-			printk("VFS: unable to read V7 FS superblock on device "
-			       "%s.\n", bdevname(dev));
+			printk("VFS: unable to read V7 FS superblock on "
+			       "device %s.\n", bdevname(dev));
 		goto failed;
 	}
 
+	/* plausibility check on superblock */
+	v7sb = (struct v7_super_block *) bh->b_data;
+	if (fs16_to_cpu(sb,v7sb->s_nfree) > V7_NICFREE ||
+	    fs16_to_cpu(sb,v7sb->s_ninode) > V7_NICINOD ||
+	    fs32_to_cpu(sb,v7sb->s_time) == 0)
+		goto failed;
+
+	/* plausibility check on root inode: it is a directory,
+	   with a nonzero size that is a multiple of 16 */
+	if ((bh2 = bread(dev, 2, 512)) == NULL)
+		goto failed;
+	v7i = (struct sysv_inode *)(bh2->b_data + 64);
+	if ((fs16_to_cpu(sb,v7i->i_mode) & ~0777) != S_IFDIR ||
+	    (fs32_to_cpu(sb,v7i->i_size) == 0) ||
+	    (fs32_to_cpu(sb,v7i->i_size) & 017) != 0)
+		goto failed;
+	brelse(bh2);
 
 	sb->sv_bh1 = bh;
 	sb->sv_bh2 = bh;
 	if (complete_read_super(sb, silent, 1))
 		return sb;
 
-	brelse(bh);
 failed:
+	brelse(bh2);
+	brelse(bh);
 	return NULL;
 }
 
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/sysv/symlink.c linux/fs/sysv/symlink.c
--- ../master/linux-2.4.10-pre3/fs/sysv/symlink.c	Thu Jan  1 01:00:00 1970
+++ linux/fs/sysv/symlink.c	Sun Sep  2 17:04:47 2001
@@ -0,0 +1,25 @@
+/*
+ *  linux/fs/sysv/symlink.c
+ *
+ *  Handling of System V filesystem fast symlinks extensions.
+ *  Aug 2001, Christoph Hellwig (hch@caldera.de)
+ */
+
+#include <linux/fs.h>
+
+static int sysv_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+	return vfs_readlink(dentry, buffer, buflen, s);
+}
+
+static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
+	return vfs_follow_link(nd, s);
+}
+
+struct inode_operations sysv_fast_symlink_inode_operations = {
+	readlink:	sysv_readlink,
+	follow_link:	sysv_follow_link,
+};
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/include/linux/sysv_fs.h linux/include/linux/sysv_fs.h
--- ../master/linux-2.4.10-pre3/include/linux/sysv_fs.h	Tue Aug 14 20:03:14 2001
+++ linux/include/linux/sysv_fs.h	Sun Sep  2 17:10:45 2001
@@ -325,6 +325,7 @@
 	FSTYPE_SYSV2,
 	FSTYPE_COH,
 	FSTYPE_V7,
+	FSTYPE_AFS,
 	FSTYPE_END,
 };
 
@@ -373,6 +374,7 @@
 
 extern struct inode_operations sysv_file_inode_operations;
 extern struct inode_operations sysv_dir_inode_operations;
+extern struct inode_operations sysv_fast_symlink_inode_operations;
 extern struct file_operations sysv_file_operations;
 extern struct file_operations sysv_dir_operations;
 extern struct address_space_operations sysv_aops;
