Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWFQKMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWFQKMF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWFQKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:12:05 -0400
Received: from mx1.mail.ru ([194.67.23.121]:13080 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751363AbWFQKMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:12:01 -0400
Date: Sat, 17 Jun 2006 14:17:20 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5]: ufs: make fsck -f happy
Message-ID: <20060617101720.GA402@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ufs super block contains some statistic about
file systems, like amount of directories, free blocks, inodes
and so on.

UFS1 hold this information in one location and uses 32bit
integers for such information,
UFS2 hold statistic in another location and uses 64bit integers.

There is transition variant, if UFS1 has type 44BSD and
flags field in super block has some special value this
mean that we work with statistic like UFS2 does.
and this also means that nobody care about old(UFS1) statistic.

So if start fsck against such file system, after usage
linux ufs driver, it found error: at now only UFS1 like
statistic is updated.

This patch should fix this. 
Also it contains some minor cleanup: CodingSytle and remove
unused variables.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>


Index: linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
@@ -83,7 +83,7 @@ void ufs_free_fragments(struct inode *in
 
 	
 	fs32_add(sb, &ucg->cg_cs.cs_nffree, count);
-	fs32_add(sb, &usb1->fs_cstotal.cs_nffree, count);
+	uspi->cs_total.cs_nffree += count;
 	fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	blkmap = ubh_blkmap (UCPI_UBH(ucpi), ucpi->c_freeoff, bbase);
 	ufs_fragacct(sb, blkmap, ucg->cg_frsum, 1);
@@ -94,12 +94,12 @@ void ufs_free_fragments(struct inode *in
 	blkno = ufs_fragstoblks (bbase);
 	if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
-		fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, uspi->s_fpb);
+		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
-		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+		uspi->cs_total.cs_nbfree++;
 		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno (bbase);
 		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(bbase)), 1);
@@ -185,7 +185,7 @@ do_more:
 		DQUOT_FREE_BLOCK(inode, uspi->s_fpb);
 
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
-		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+		uspi->cs_total.cs_nbfree++;
 		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno(i);
 		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(i)), 1);
@@ -372,7 +372,7 @@ unsigned ufs_new_fragments(struct inode 
 	/*
 	 * There is not enough space for user on the device
 	 */
-	if (!capable(CAP_SYS_RESOURCE) && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
+	if (!capable(CAP_SYS_RESOURCE) && ufs_freespace(uspi, UFS_MINFREE) <= 0) {
 		unlock_super (sb);
 		UFSD("EXIT (FAILED)\n");
 		return 0;
@@ -418,8 +418,8 @@ unsigned ufs_new_fragments(struct inode 
 	switch (fs32_to_cpu(sb, usb1->fs_optim)) {
 	    case UFS_OPTSPACE:
 		request = newcount;
-		if (uspi->s_minfree < 5 || fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree) 
-		    > uspi->s_dsize * uspi->s_minfree / (2 * 100) )
+		if (uspi->s_minfree < 5 || uspi->cs_total.cs_nffree
+		    > uspi->s_dsize * uspi->s_minfree / (2 * 100))
 			break;
 		usb1->fs_optim = cpu_to_fs32(sb, UFS_OPTTIME);
 		break;
@@ -428,7 +428,7 @@ unsigned ufs_new_fragments(struct inode 
 	
 	    case UFS_OPTTIME:
 		request = uspi->s_fpb;
-		if (fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree) < uspi->s_dsize *
+		if (uspi->cs_total.cs_nffree < uspi->s_dsize *
 		    (uspi->s_minfree - 2) / 100)
 			break;
 		usb1->fs_optim = cpu_to_fs32(sb, UFS_OPTTIME);
@@ -516,7 +516,7 @@ ufs_add_fragments (struct inode * inode,
 
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
-	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
+	uspi->cs_total.cs_nffree -= count;
 	
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
@@ -618,7 +618,7 @@ cg_found:
 		DQUOT_FREE_BLOCK(inode, i);
 
 		fs32_add(sb, &ucg->cg_cs.cs_nffree, i);
-		fs32_add(sb, &usb1->fs_cstotal.cs_nffree, i);
+		uspi->cs_total.cs_nffree += i;
 		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, i);
 		fs32_add(sb, &ucg->cg_frsum[i], 1);
 		goto succed;
@@ -635,7 +635,7 @@ cg_found:
 		ubh_clrbit (UCPI_UBH(ucpi), ucpi->c_freeoff, result + i);
 	
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
-	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
+	uspi->cs_total.cs_nffree -= count;
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	fs32_sub(sb, &ucg->cg_frsum[allocsize], 1);
 
@@ -703,7 +703,7 @@ gotit:
 	}
 
 	fs32_sub(sb, &ucg->cg_cs.cs_nbfree, 1);
-	fs32_sub(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+	uspi->cs_total.cs_nbfree--;
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(ucpi->c_cgx).cs_nbfree, 1);
 	cylno = ufs_cbtocylno(result);
 	fs16_sub(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(result)), 1);
Index: linux-2.6.17-rc6-mm2/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/ialloc.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/ialloc.c
@@ -103,12 +103,12 @@ void ufs_free_inode (struct inode * inod
 		if (ino < ucpi->c_irotor)
 			ucpi->c_irotor = ino;
 		fs32_add(sb, &ucg->cg_cs.cs_nifree, 1);
-		fs32_add(sb, &usb1->fs_cstotal.cs_nifree, 1);
+		uspi->cs_total.cs_nifree++;
 		fs32_add(sb, &UFS_SB(sb)->fs_cs(cg).cs_nifree, 1);
 
 		if (is_directory) {
 			fs32_sub(sb, &ucg->cg_cs.cs_ndir, 1);
-			fs32_sub(sb, &usb1->fs_cstotal.cs_ndir, 1);
+			uspi->cs_total.cs_ndir--;
 			fs32_sub(sb, &UFS_SB(sb)->fs_cs(cg).cs_ndir, 1);
 		}
 	}
@@ -228,12 +228,12 @@ cg_found:
 	}
 	
 	fs32_sub(sb, &ucg->cg_cs.cs_nifree, 1);
-	fs32_sub(sb, &usb1->fs_cstotal.cs_nifree, 1);
+	uspi->cs_total.cs_nifree--;
 	fs32_sub(sb, &sbi->fs_cs(cg).cs_nifree, 1);
 	
 	if (S_ISDIR(mode)) {
 		fs32_add(sb, &ucg->cg_cs.cs_ndir, 1);
-		fs32_add(sb, &usb1->fs_cstotal.cs_ndir, 1);
+		uspi->cs_total.cs_ndir++;
 		fs32_add(sb, &sbi->fs_cs(cg).cs_ndir, 1);
 	}
 
Index: linux-2.6.17-rc6-mm2/fs/ufs/super.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/super.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/super.c
@@ -381,24 +381,57 @@ static int ufs_parse_options (char * opt
 }
 
 /*
- * Read on-disk structures associated with cylinder groups
+ * Diffrent types of UFS hold fs_cstotal in different
+ * places, and use diffrent data structure for it.
+ * To make things simplier we just copy fs_cstotal to ufs_sb_private_info
  */
-static int ufs_read_cylinder_structures (struct super_block *sb)
+static void ufs_setup_cstotal(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
+	struct ufs_super_block_first *usb1;
+	struct ufs_super_block_second *usb2;
 	struct ufs_super_block_third *usb3;
+	unsigned mtype = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
+
+	UFSD("ENTER, mtype=%u\n", mtype);
+	usb1 = ubh_get_usb_first(uspi);
+	usb2 = ubh_get_usb_second(uspi);
+	usb3 = ubh_get_usb_third(uspi);
+
+	if ((mtype == UFS_MOUNT_UFSTYPE_44BSD &&
+	     (usb1->fs_flags & UFS_FLAGS_UPDATED)) ||
+	    mtype == UFS_MOUNT_UFSTYPE_UFS2) {
+		/*we have statistic in different place, then usual*/
+		uspi->cs_total.cs_ndir = fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_ndir);
+		uspi->cs_total.cs_nbfree = fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_nbfree);
+		uspi->cs_total.cs_nifree = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nifree);
+		uspi->cs_total.cs_nffree = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nffree);
+	} else {
+		uspi->cs_total.cs_ndir = fs32_to_cpu(sb, usb1->fs_cstotal.cs_ndir);
+		uspi->cs_total.cs_nbfree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree);
+		uspi->cs_total.cs_nifree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree);
+		uspi->cs_total.cs_nffree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree);
+	}
+	UFSD("EXIT\n");
+}
+
+/*
+ * Read on-disk structures associated with cylinder groups
+ */
+static int ufs_read_cylinder_structures(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_sb_private_info *uspi = sbi->s_uspi;
+	unsigned flags = sbi->s_flags;
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned size, blks, i;
-	unsigned flags = 0;
-	
+	struct ufs_super_block_third *usb3;
+
 	UFSD("ENTER\n");
-	
-	usb3 = ubh_get_usb_third(uspi);
 
-        flags = UFS_SB(sb)->s_flags;
-	
+	usb3 = ubh_get_usb_third(uspi);
 	/*
 	 * Read cs structures from (usually) first data block
 	 * on the device. 
@@ -475,21 +508,64 @@ failed:
 }
 
 /*
- * Put on-disk structures associated with cylinder groups and 
- * write them back to disk
+ * Sync our internal copy of fs_cstotal with disk
  */
-static void ufs_put_cylinder_structures (struct super_block *sb)
+static void ufs_put_cstotal(struct super_block *sb)
 {
-	struct ufs_sb_info * sbi = UFS_SB(sb);
-	struct ufs_sb_private_info * uspi;
+	unsigned mtype = UFS_SB(sb)->s_mount_opt & UFS_MOUNT_UFSTYPE;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_super_block_first *usb1;
+	struct ufs_super_block_second *usb2;
+	struct ufs_super_block_third *usb3;
+
+	UFSD("ENTER\n");
+	usb1 = ubh_get_usb_first(uspi);
+	usb2 = ubh_get_usb_second(uspi);
+	usb3 = ubh_get_usb_third(uspi);
+
+	if ((mtype == UFS_MOUNT_UFSTYPE_44BSD &&
+	     (usb1->fs_flags & UFS_FLAGS_UPDATED)) ||
+	    mtype == UFS_MOUNT_UFSTYPE_UFS2) {
+		/*we have statistic in different place, then usual*/
+		usb2->fs_un.fs_u2.cs_ndir =
+			cpu_to_fs64(sb, uspi->cs_total.cs_ndir);
+		usb2->fs_un.fs_u2.cs_nbfree =
+			cpu_to_fs64(sb, uspi->cs_total.cs_nbfree);
+		usb3->fs_un1.fs_u2.cs_nifree =
+			cpu_to_fs64(sb, uspi->cs_total.cs_nifree);
+		usb3->fs_un1.fs_u2.cs_nffree =
+			cpu_to_fs64(sb, uspi->cs_total.cs_nffree);
+	} else {
+		usb1->fs_cstotal.cs_ndir =
+			cpu_to_fs32(sb, uspi->cs_total.cs_ndir);
+		usb1->fs_cstotal.cs_nbfree =
+			cpu_to_fs32(sb, uspi->cs_total.cs_nbfree);
+		usb1->fs_cstotal.cs_nifree =
+			cpu_to_fs32(sb, uspi->cs_total.cs_nifree);
+		usb1->fs_cstotal.cs_nffree =
+			cpu_to_fs32(sb, uspi->cs_total.cs_nffree);
+	}
+	ubh_mark_buffer_dirty(USPI_UBH(uspi));
+	UFSD("EXIT\n");
+}
+
+/**
+ * ufs_put_super_internal() - put on-disk intrenal structures
+ * @sb: pointer to super_block structure
+ * Put on-disk structures associated with cylinder groups
+ * and write them back to disk, also update cs_total on disk
+ */
+static void ufs_put_super_internal(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_sb_private_info *uspi = sbi->s_uspi;
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned blks, size, i;
+
 	
 	UFSD("ENTER\n");
-	
-	uspi = sbi->s_uspi;
-
+	ufs_put_cstotal(sb);
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	base = space = (char*) sbi->s_csp;
@@ -524,7 +600,6 @@ static int ufs_fill_super(struct super_b
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_second * usb2;
 	struct ufs_super_block_third * usb3;
-	struct ufs_super_block *usb;
 	struct ufs_buffer_head * ubh;	
 	struct inode *inode;
 	unsigned block_size, super_block_size;
@@ -728,8 +803,6 @@ again:	
 	usb1 = ubh_get_usb_first(uspi);
 	usb2 = ubh_get_usb_second(uspi);
 	usb3 = ubh_get_usb_third(uspi);
-	usb  = (struct ufs_super_block *)
-		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
 
 	/*
 	 * Check ufs magic number
@@ -850,8 +923,7 @@ magic_found:
 			sb->s_flags |= MS_RDONLY;
 			break;
 		}
-	}
-	else {
+	} else {
 		printk("ufs_read_super: fs needs fsck\n");
 		sb->s_flags |= MS_RDONLY;
 	}
@@ -952,7 +1024,7 @@ magic_found:
 	if (!sb->s_root)
 		goto dalloc_failed;
 
-
+	ufs_setup_cstotal(sb);
 	/*
 	 * Read cylinder group structures
 	 */
@@ -1000,7 +1072,7 @@ static void ufs_write_super(struct super
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86)
 			ufs_set_fs_state(sb, usb1, usb3,
 					UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
-		ubh_mark_buffer_dirty (USPI_UBH(uspi));
+		ufs_put_cstotal(sb);
 	}
 	sb->s_dirt = 0;
 	UFSD("EXIT\n");
@@ -1014,7 +1086,7 @@ static void ufs_put_super(struct super_b
 	UFSD("ENTER\n");
 
 	if (!(sb->s_flags & MS_RDONLY))
-		ufs_put_cylinder_structures (sb);
+		ufs_put_super_internal(sb);
 	
 	ubh_brelse_uspi (sbi->s_uspi);
 	kfree (sbi->s_uspi);
@@ -1049,8 +1121,7 @@ static int ufs_remount (struct super_blo
 		return -EINVAL;
 	if (!(new_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		new_mount_opt |= ufstype;
-	}
-	else if ((new_mount_opt & UFS_MOUNT_UFSTYPE) != ufstype) {
+	} else if ((new_mount_opt & UFS_MOUNT_UFSTYPE) != ufstype) {
 		printk("ufstype can't be changed during remount\n");
 		return -EINVAL;
 	}
@@ -1064,7 +1135,7 @@ static int ufs_remount (struct super_blo
 	 * fs was mouted as rw, remounting ro
 	 */
 	if (*mount_flags & MS_RDONLY) {
-		ufs_put_cylinder_structures(sb);
+		ufs_put_super_internal(sb);
 		usb1->fs_time = cpu_to_fs32(sb, get_seconds());
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
@@ -1073,11 +1144,10 @@ static int ufs_remount (struct super_blo
 		ubh_mark_buffer_dirty (USPI_UBH(uspi));
 		sb->s_dirt = 0;
 		sb->s_flags |= MS_RDONLY;
-	}
+	} else {
 	/*
 	 * fs was mounted as ro, remounting rw
 	 */
-	else {
 #ifndef CONFIG_UFS_FS_WRITE
 		printk("ufs was compiled with read-only support, "
 		"can't be mounted as read-write\n");
@@ -1089,7 +1159,7 @@ static int ufs_remount (struct super_blo
 			printk("this ufstype is read-only supported\n");
 			return -EINVAL;
 		}
-		if (!ufs_read_cylinder_structures (sb)) {
+		if (!ufs_read_cylinder_structures(sb)) {
 			printk("failed during remounting\n");
 			return -EPERM;
 		}
@@ -1100,7 +1170,7 @@ static int ufs_remount (struct super_blo
 	return 0;
 }
 
-static int ufs_statfs (struct super_block *sb, struct kstatfs *buf)
+static int ufs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct ufs_sb_private_info *uspi= UFS_SB(sb)->s_uspi;
 	unsigned  flags = UFS_SB(sb)->s_flags;
@@ -1117,17 +1187,13 @@ static int ufs_statfs (struct super_bloc
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
 		buf->f_type = UFS2_MAGIC;
 		buf->f_blocks = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_dsize);
-		buf->f_bfree = ufs_blkstofrags(
-			fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_nbfree)) +
-			fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nffree);
-		buf->f_ffree = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nifree);
 	} else {
 		buf->f_type = UFS_MAGIC;
 		buf->f_blocks = uspi->s_dsize;
-		buf->f_bfree = ufs_blkstofrags(fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree)) +
-			fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree);
-		buf->f_ffree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree);
 	}
+	buf->f_bfree = ufs_blkstofrags(uspi->cs_total.cs_nbfree) +
+		uspi->cs_total.cs_nffree;
+	buf->f_ffree = uspi->cs_total.cs_nifree;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_bavail = (buf->f_bfree > (((long)buf->f_blocks / 100) * uspi->s_minfree))
 		? (buf->f_bfree - (((long)buf->f_blocks / 100) * uspi->s_minfree)) : 0;
Index: linux-2.6.17-rc6-mm2/fs/ufs/util.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/util.h
+++ linux-2.6.17-rc6-mm2/fs/ufs/util.h
@@ -306,9 +306,13 @@ static inline void *get_usb_offset(struc
  * Determine the number of available frags given a
  * percentage to hold in reserve.
  */
-#define ufs_freespace(usb, percentreserved) \
-	(ufs_blkstofrags(fs32_to_cpu(sb, (usb)->fs_cstotal.cs_nbfree)) + \
-	fs32_to_cpu(sb, (usb)->fs_cstotal.cs_nffree) - (uspi->s_dsize * (percentreserved) / 100))
+static inline u64
+ufs_freespace(struct ufs_sb_private_info *uspi, int percentreserved)
+{
+	return ufs_blkstofrags(uspi->cs_total.cs_nbfree) +
+		uspi->cs_total.cs_nffree -
+		(uspi->s_dsize * (percentreserved) / 100);
+}
 
 /*
  * Macros to access cylinder group array structures
Index: linux-2.6.17-rc6-mm2/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/ufs_fs.h
+++ linux-2.6.17-rc6-mm2/include/linux/ufs_fs.h
@@ -351,6 +351,17 @@ struct ufs2_csum_total {
 	__fs64   cs_spare[3];	/* future expansion */
 };
 
+/*
+ * File system flags
+ */
+#define UFS_UNCLEAN      0x01    /* file system not clean at mount (unused) */
+#define UFS_DOSOFTDEP    0x02    /* file system using soft dependencies */
+#define UFS_NEEDSFSCK    0x04    /* needs sync fsck (FreeBSD compat, unused) */
+#define UFS_INDEXDIRS    0x08    /* kernel supports indexed directories */
+#define UFS_ACLS         0x10    /* file system has ACLs enabled */
+#define UFS_MULTILABEL   0x20    /* file system is MAC multi-label */
+#define UFS_FLAGS_UPDATED 0x80   /* flags have been moved to new location */
+
 #if 0
 /*
  * This is the actual superblock, as it is laid out on the disk.
@@ -433,7 +444,7 @@ struct ufs_super_block {
 	__s8	fs_fmod;	/* super block modified flag */
 	__s8	fs_clean;	/* file system is clean flag */
 	__s8	fs_ronly;	/* mounted read-only flag */
-	__s8	fs_flags;	/* currently unused flag */
+	__s8	fs_flags;
 	union {
 		struct {
 			__s8	fs_fsmnt[UFS_MAXMNTLEN];/* name mounted on */
@@ -704,6 +715,7 @@ struct ufs_cg_private_info {
 
 struct ufs_sb_private_info {
 	struct ufs_buffer_head s_ubh; /* buffer containing super block */
+	struct ufs2_csum_total cs_total;
 	__u32	s_sblkno;	/* offset of super-blocks in filesys */
 	__u32	s_cblkno;	/* offset of cg-block in filesys */
 	__u32	s_iblkno;	/* offset of inode-blocks in filesys */

-- 
/Evgeniy

