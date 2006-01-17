Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWAQLeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWAQLeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWAQLeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:34:21 -0500
Received: from mx1.mail.ru ([194.67.23.121]:19228 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1750754AbWAQLeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:34:20 -0500
Date: Tue, 17 Jan 2006 14:21:30 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ufs: rm hang up the kernel
Message-ID: <20060117112130.GA18860@rain.homenetwork>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"rm" command, on file system with "ufs1" type cause
system hang up. This is, in fact, not so bad as it seems
to be, because of after that in "kernel control path" there are
3-4 places which may cause "oops".

So the first patch fix oopses, and the second patch fix "kernel hang
up".

"oops"  appears because of reading of group's summary info partly
wrong, and access to not first group's summary info cause "oops".

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/fs/ufs/super.c linux-2.6.15-git11/fs/ufs/super.c
--- linux-2.6.15-git11-vanilla/fs/ufs/super.c	2006-01-16 11:48:30.000000000 +0300
+++ linux-2.6.15-git11/fs/ufs/super.c	2006-01-16 21:53:43.708519750 +0300
@@ -388,7 +388,8 @@ static int ufs_parse_options (char * opt
 /*
  * Read on-disk structures associated with cylinder groups
  */
-static int ufs_read_cylinder_structures (struct super_block *sb) {
+static int ufs_read_cylinder_structures (struct super_block *sb) 
+{
 	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block *usb;
@@ -415,6 +416,7 @@ static int ufs_read_cylinder_structures 
 	base = space = kmalloc(size, GFP_KERNEL);
 	if (!base)
 		goto failed; 
+	sbi->s_csp = (struct ufs_csum *)space;
 	for (i = 0; i < blks; i += uspi->s_fpb) {
 		size = uspi->s_bsize;
 		if (i + uspi->s_fpb > blks)
@@ -430,7 +432,6 @@ static int ufs_read_cylinder_structures 
 			goto failed;
 
 		ubh_ubhcpymem (space, ubh, size);
-		sbi->s_csp[ufs_fragstoblks(i)]=(struct ufs_csum *)space;
 
 		space += size;
 		ubh_brelse (ubh);
@@ -486,7 +487,8 @@ failed:
  * Put on-disk structures associated with cylinder groups and 
  * write them back to disk
  */
-static void ufs_put_cylinder_structures (struct super_block *sb) {
+static void ufs_put_cylinder_structures (struct super_block *sb) 
+{
 	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_buffer_head * ubh;
@@ -499,7 +501,7 @@ static void ufs_put_cylinder_structures 
 
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
-	base = space = (char*) sbi->s_csp[0];
+	base = space = (char*) sbi->s_csp;
 	for (i = 0; i < blks; i += uspi->s_fpb) {
 		size = uspi->s_bsize;
 		if (i + uspi->s_fpb > blks)
diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/include/linux/ufs_fs.h linux-2.6.15-git11/include/linux/ufs_fs.h
--- linux-2.6.15-git11-vanilla/include/linux/ufs_fs.h	2006-01-16 11:48:30.000000000 +0300
+++ linux-2.6.15-git11/include/linux/ufs_fs.h	2006-01-16 21:14:40.138055750 +0300
@@ -502,8 +502,7 @@ struct ufs_super_block {
 /*
  * Convert cylinder group to base address of its global summary info.
  */
-#define fs_cs(indx) \
-	s_csp[(indx) >> uspi->s_csshift][(indx) & ~uspi->s_csmask]
+#define fs_cs(indx) s_csp[(indx)]
 
 /*
  * Cylinder group block for a file system.
diff -uprN -X linux-2.6.15-git11-vanilla/Documentation/dontdiff linux-2.6.15-git11-vanilla/include/linux/ufs_fs_sb.h linux-2.6.15-git11/include/linux/ufs_fs_sb.h
--- linux-2.6.15-git11-vanilla/include/linux/ufs_fs_sb.h	2006-01-16 11:48:30.000000000 +0300
+++ linux-2.6.15-git11/include/linux/ufs_fs_sb.h	2006-01-16 20:33:49.352891250 +0300
@@ -25,7 +25,7 @@ struct ufs_csum;
 
 struct ufs_sb_info {
 	struct ufs_sb_private_info * s_uspi;	
-	struct ufs_csum	* s_csp[UFS_MAXCSBUFS];
+	struct ufs_csum	* s_csp;
 	unsigned s_bytesex;
 	unsigned s_flags;
 	struct buffer_head ** s_ucg;

-- 
/Evgeniy

