Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUDLLGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 07:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUDLLGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 07:06:46 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:1258 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262840AbUDLLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 07:06:39 -0400
Message-ID: <407A7826.3090600@iitbombay.org>
Date: Mon, 12 Apr 2004 16:36:14 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, gcs@lsc.hu
Subject: [2.6 PATCH]  ufs2_frag_map_fix : fixes wrong content reading in ufs2
 code
Content-Type: multipart/mixed;
 boundary="------------090008080603010100070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090008080603010100070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

This is in continuation of the ufs2 read-only code that went into 2.6.5.

This patch fixes a bug where wrong content was being read off the disk
after around 4 MB mark.


Patch is also located at
http://ufs-linux.sourceforge.net/ufs2/2.6.5/ufs2_frag_map_fix.txt

Regards
Niraj



--------------090008080603010100070104
Content-Type: text/plain;
 name="ufs2_frag_map_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ufs2_frag_map_fix.txt"

diff -ur linux-2.6.5/fs/ufs/dir.c linux-2.6.5-ufs2/fs/ufs/dir.c
--- linux-2.6.5/fs/ufs/dir.c	2004-04-04 09:07:44.000000000 +0530
+++ linux-2.6.5-ufs2/fs/ufs/dir.c	2004-04-05 14:00:37.000000000 +0530
@@ -56,13 +56,14 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int error = 0;
-	unsigned long offset, lblk, blk;
+	unsigned long offset, lblk;
 	int i, stored;
 	struct buffer_head * bh;
 	struct ufs_dir_entry * de;
 	struct super_block * sb;
 	int de_reclen;
 	unsigned flags;
+	u64     blk= 0L;
 
 	lock_kernel();
 
diff -ur linux-2.6.5/fs/ufs/inode.c linux-2.6.5-ufs2/fs/ufs/inode.c
--- linux-2.6.5/fs/ufs/inode.c	2004-04-04 09:06:26.000000000 +0530
+++ linux-2.6.5-ufs2/fs/ufs/inode.c	2004-04-12 15:02:28.000000000 +0530
@@ -50,7 +50,7 @@
 #define UFSD(x)
 #endif
 
-static int ufs_block_to_path(struct inode *inode, long i_block, int offsets[4])
+static int ufs_block_to_path(struct inode *inode, sector_t i_block, sector_t offsets[4])
 {
 	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
 	int ptrs = uspi->s_apb;
@@ -60,6 +60,8 @@
 		double_blocks = (1 << (ptrs_bits * 2));
 	int n = 0;
 
+	UFSD(("ptrs=uspi->s_apb = %d,double_blocks=%d \n",ptrs,double_blocks));
 	if (i_block < 0) {
 		ufs_warning(inode->i_sb, "ufs_block_to_path", "block < 0");
 	} else if (i_block < direct_blocks) {
@@ -87,20 +89,23 @@
  * the begining of the filesystem.
  */
 
-u64  ufs_frag_map(struct inode *inode, int frag)
+u64  ufs_frag_map(struct inode *inode, sector_t frag)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
-	int mask = uspi->s_apbmask>>uspi->s_fpbshift;
+	u64 mask = (u64) uspi->s_apbmask>>uspi->s_fpbshift;
 	int shift = uspi->s_apbshift-uspi->s_fpbshift;
-	int offsets[4], *p;
+	sector_t offsets[4], *p;
 	int depth = ufs_block_to_path(inode, frag >> uspi->s_fpbshift, offsets);
-	int ret = 0;
+	u64  ret = 0L;
 	u32 block;
-	u64 u2_block = 0;
+	u64 u2_block = 0L;
 	unsigned flags = UFS_SB(sb)->s_flags;
-	u64 temp = 0;
+	u64 temp = 0L;
+
+	UFSD((": frag = %lu  depth = %d\n",frag,depth));
+	UFSD((": uspi->s_fpbshift = %d ,uspi->s_apbmask = %x, mask=%llx\n",uspi->s_fpbshift,uspi->s_apbmask,mask));
 
 	if (depth == 0)
 		return 0;
@@ -116,7 +121,7 @@
 		goto out;
 	while (--depth) {
 		struct buffer_head *bh;
-		int n = *p++;
+		sector_t n = *p++;
 
 		bh = sb_bread(sb, uspi->s_sbbase + fs32_to_cpu(sb, block)+(n>>shift));
 		if (!bh)
@@ -126,20 +131,21 @@
 		if (!block)
 			goto out;
 	}
-	ret = uspi->s_sbbase + fs32_to_cpu(sb, block) + (frag & uspi->s_fpbmask);
+	ret = (u64) (uspi->s_sbbase + fs32_to_cpu(sb, block) + (frag & uspi->s_fpbmask));
 	goto out;
 ufs2:
 	u2_block = ufsi->i_u1.u2_i_data[*p++];
 	if (!u2_block)
 		goto out;
 
-	temp = (u64)uspi->s_sbbase + fs64_to_cpu(sb, u2_block);
 
 	while (--depth) {
 		struct buffer_head *bh;
-		u64 n = *p++;
+		sector_t n = *p++;
 
-		bh = sb_bread(sb, temp +(n>>shift));
+
+		temp = (u64)(uspi->s_sbbase) + fs64_to_cpu(sb, u2_block);
+		bh = sb_bread(sb, temp +(u64) (n>>shift));
 		if (!bh)
 			goto out;
 		u2_block = ((u64*)bh->b_data)[n & mask];
@@ -147,7 +153,8 @@
 		if (!u2_block)
 			goto out;
 	}
-	ret = temp + (frag & uspi->s_fpbmask);
+	temp = (u64)uspi->s_sbbase + fs64_to_cpu(sb, u2_block);
+	ret = temp + (u64) (frag & uspi->s_fpbmask);
 
 out:
 	unlock_kernel();
@@ -379,6 +386,7 @@
 	
 	if (!create) {
 		phys64 = ufs_frag_map(inode, fragment);
+		UFSD(("phys64 = %lu \n",phys64));
 		if (phys64)
 			map_bh(bh_result, sb, phys64);
 		return 0;
diff -ur linux-2.6.5/fs/ufs/super.c linux-2.6.5-ufs2/fs/ufs/super.c
--- linux-2.6.5/fs/ufs/super.c	2004-04-04 09:06:11.000000000 +0530
+++ linux-2.6.5-ufs2/fs/ufs/super.c	2004-04-12 15:03:25.000000000 +0530
@@ -93,6 +93,8 @@
 #undef UFS_SUPER_DEBUG
 #undef UFS_SUPER_DEBUG_MORE
 
+
+#undef UFS_SUPER_DEBUG_MORE
 #ifdef UFS_SUPER_DEBUG
 #define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
 #else
@@ -157,6 +159,8 @@
 	printk("  magic:         0x%x\n", fs32_to_cpu(sb, usb->fs_magic));
 	printk("  fs_size:   %u\n",fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size));
 	printk("  fs_dsize:  %u\n",fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize));
+	printk("  bsize:         %u\n", fs32_to_cpu(usb, usb->fs_bsize));
+	printk("  fsize:         %u\n", fs32_to_cpu(usb, usb->fs_fsize));
 	printk("  fs_volname:  %s\n", usb->fs_u11.fs_u2.fs_volname);
 	printk("  fs_fsmnt:  %s\n", usb->fs_u11.fs_u2.fs_fsmnt);
 	printk("  fs_sblockloc: %u\n",fs64_to_cpu(sb,
@@ -897,6 +901,8 @@
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
 	uspi->s_bshift = fs32_to_cpu(sb, usb1->fs_bshift);
 	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
+	UFSD(("uspi->s_bshift = %d,uspi->s_fshift = %d", uspi->s_bshift,
+		uspi->s_fshift));
 	uspi->s_fpbshift = fs32_to_cpu(sb, usb1->fs_fragshift);
 	uspi->s_fsbtodb = fs32_to_cpu(sb, usb1->fs_fsbtodb);
 	/* s_sbsize already set */
@@ -929,7 +935,12 @@
 	 * Compute another frequently used values
 	 */
 	uspi->s_fpbmask = uspi->s_fpb - 1;
-	uspi->s_apbshift = uspi->s_bshift - 2;
+	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
+		uspi->s_apbshift = uspi->s_bshift - 3;
+	}
+	else {
+		uspi->s_apbshift = uspi->s_bshift - 2;
+	}
 	uspi->s_2apbshift = uspi->s_apbshift * 2;
 	uspi->s_3apbshift = uspi->s_apbshift * 3;
 	uspi->s_apb = 1 << uspi->s_apbshift;
diff -ur linux-2.6.5/include/linux/ufs_fs.h linux-2.6.5-ufs2/include/linux/ufs_fs.h
--- linux-2.6.5/include/linux/ufs_fs.h	2004-04-04 09:07:43.000000000 +0530
+++ linux-2.6.5-ufs2/include/linux/ufs_fs.h	2004-04-05 14:00:42.000000000 +0530
@@ -896,7 +896,7 @@
 extern struct inode * ufs_new_inode (struct inode *, int);
 
 /* inode.c */
-extern u64  ufs_frag_map (struct inode *, int);
+extern u64  ufs_frag_map (struct inode *, sector_t);
 extern void ufs_read_inode (struct inode *);
 extern void ufs_put_inode (struct inode *);
 extern void ufs_write_inode (struct inode *, int);

--------------090008080603010100070104--

