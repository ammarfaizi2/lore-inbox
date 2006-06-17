Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWFQKKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWFQKKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWFQKKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:10:00 -0400
Received: from mx1.mail.ru ([194.67.23.121]:15638 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751338AbWFQKJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:09:58 -0400
Date: Sat, 17 Jun 2006 14:15:16 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5]: ufs: one way to access super block
Message-ID: <20060617101516.GA25765@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Super block of UFS usually has size >512,
because of fragment size may be 512, this cause
some problems.
Currently, there are two methods to work with ufs super block:
1)split structure which describes ufs super blocks into structures
with size <=512
2)use one structure which describes ufs super block, and
hope that array of "buffer_head" which holds "super block",
has such construction:
bh[n]->b_data + bh[n]->b_size == bh[n + 1]->b_data

The second variant may cause some problems in the future,
and usage of two variants cause unnecessary code duplication.

This patch remove the second variant.
Also patch contains some CodingStyle fixes.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc6-mm2/fs/ufs/super.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/super.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/super.c
@@ -94,82 +94,77 @@
 /*
  * Print contents of ufs_super_block, useful for debugging
  */
-void ufs_print_super_stuff(struct super_block *sb,
-	struct ufs_super_block_first * usb1,
-	struct ufs_super_block_second * usb2, 
-	struct ufs_super_block_third * usb3)
+static void ufs_print_super_stuff(struct super_block *sb, unsigned flags,
+				  struct ufs_super_block_first *usb1,
+				  struct ufs_super_block_second *usb2,
+				  struct ufs_super_block_third *usb3)
 {
 	printk("ufs_print_super_stuff\n");
-	printk("size of usb:     %zu\n", sizeof(struct ufs_super_block));
-	printk("  magic:         0x%x\n", fs32_to_cpu(sb, usb3->fs_magic));
-	printk("  sblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_sblkno));
-	printk("  cblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_cblkno));
-	printk("  iblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_iblkno));
-	printk("  dblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_dblkno));
-	printk("  cgoffset:      %u\n", fs32_to_cpu(sb, usb1->fs_cgoffset));
-	printk("  ~cgmask:       0x%x\n", ~fs32_to_cpu(sb, usb1->fs_cgmask));
-	printk("  size:          %u\n", fs32_to_cpu(sb, usb1->fs_size));
-	printk("  dsize:         %u\n", fs32_to_cpu(sb, usb1->fs_dsize));
-	printk("  ncg:           %u\n", fs32_to_cpu(sb, usb1->fs_ncg));
-	printk("  bsize:         %u\n", fs32_to_cpu(sb, usb1->fs_bsize));
-	printk("  fsize:         %u\n", fs32_to_cpu(sb, usb1->fs_fsize));
-	printk("  frag:          %u\n", fs32_to_cpu(sb, usb1->fs_frag));
-	printk("  fragshift:     %u\n", fs32_to_cpu(sb, usb1->fs_fragshift));
-	printk("  ~fmask:        %u\n", ~fs32_to_cpu(sb, usb1->fs_fmask));
-	printk("  fshift:        %u\n", fs32_to_cpu(sb, usb1->fs_fshift));
-	printk("  sbsize:        %u\n", fs32_to_cpu(sb, usb1->fs_sbsize));
-	printk("  spc:           %u\n", fs32_to_cpu(sb, usb1->fs_spc));
-	printk("  cpg:           %u\n", fs32_to_cpu(sb, usb1->fs_cpg));
-	printk("  ipg:           %u\n", fs32_to_cpu(sb, usb1->fs_ipg));
-	printk("  fpg:           %u\n", fs32_to_cpu(sb, usb1->fs_fpg));
-	printk("  csaddr:        %u\n", fs32_to_cpu(sb, usb1->fs_csaddr));
-	printk("  cssize:        %u\n", fs32_to_cpu(sb, usb1->fs_cssize));
-	printk("  cgsize:        %u\n", fs32_to_cpu(sb, usb1->fs_cgsize));
-	printk("  fstodb:        %u\n", fs32_to_cpu(sb, usb1->fs_fsbtodb));
-	printk("  contigsumsize: %d\n", fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_contigsumsize));
-	printk("  postblformat:  %u\n", fs32_to_cpu(sb, usb3->fs_postblformat));
-	printk("  nrpos:         %u\n", fs32_to_cpu(sb, usb3->fs_nrpos));
-	printk("  ndir           %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_ndir));
-	printk("  nifree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree));
-	printk("  nbfree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree));
-	printk("  nffree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree));
-	printk("\n");
-}
-
-/*
- * Print contents of ufs2 ufs_super_block, useful for debugging
- */
-void ufs2_print_super_stuff(
-     struct super_block *sb,
-      struct ufs_super_block *usb)
-{
-	printk("ufs_print_super_stuff\n");
-	printk("size of usb:     %zu\n", sizeof(struct ufs_super_block));
-	printk("  magic:         0x%x\n", fs32_to_cpu(sb, usb->fs_magic));
-	printk("  fs_size:   %llu\n",
-	       (unsigned long long)fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size));
-	printk("  fs_dsize:  %llu\n",
-	       (unsigned long long)fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize));
-	printk("  bsize:         %u\n", fs32_to_cpu(sb, usb->fs_bsize));
-	printk("  fsize:         %u\n", fs32_to_cpu(sb, usb->fs_fsize));
-	printk("  fs_volname:  %s\n", usb->fs_u11.fs_u2.fs_volname);
-	printk("  fs_fsmnt:  %s\n", usb->fs_u11.fs_u2.fs_fsmnt);
-	printk("  fs_sblockloc: %llu\n",
-	       (unsigned long long)fs64_to_cpu(sb,
-					       usb->fs_u11.fs_u2.fs_sblockloc));
-	printk("  cs_ndir(No of dirs):  %llu\n",
-	       (unsigned long long)fs64_to_cpu(sb,
-				         usb->fs_u11.fs_u2.fs_cstotal.cs_ndir));
-	printk("  cs_nbfree(No of free blocks):  %llu\n",
-	       (unsigned long long)fs64_to_cpu(sb,
-				       usb->fs_u11.fs_u2.fs_cstotal.cs_nbfree));
+	printk("  magic:     0x%x\n", fs32_to_cpu(sb, usb3->fs_magic));
+	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
+		printk("  fs_size:   %llu\n", (unsigned long long)
+		       fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_size));
+		printk("  fs_dsize:  %llu\n", (unsigned long long)
+		       fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_dsize));
+		printk("  bsize:         %u\n",
+		       fs32_to_cpu(sb, usb1->fs_bsize));
+		printk("  fsize:         %u\n",
+		       fs32_to_cpu(sb, usb1->fs_fsize));
+		printk("  fs_volname:  %s\n", usb2->fs_un.fs_u2.fs_volname);
+		printk("  fs_sblockloc: %llu\n", (unsigned long long)
+		       fs64_to_cpu(sb, usb2->fs_un.fs_u2.fs_sblockloc));
+		printk("  cs_ndir(No of dirs):  %llu\n", (unsigned long long)
+		       fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_ndir));
+		printk("  cs_nbfree(No of free blocks):  %llu\n",
+		       (unsigned long long)
+		       fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_nbfree));
+	} else {
+		printk(" sblkno:      %u\n", fs32_to_cpu(sb, usb1->fs_sblkno));
+		printk(" cblkno:      %u\n", fs32_to_cpu(sb, usb1->fs_cblkno));
+		printk(" iblkno:      %u\n", fs32_to_cpu(sb, usb1->fs_iblkno));
+		printk(" dblkno:      %u\n", fs32_to_cpu(sb, usb1->fs_dblkno));
+		printk(" cgoffset:    %u\n",
+		       fs32_to_cpu(sb, usb1->fs_cgoffset));
+		printk(" ~cgmask:     0x%x\n",
+		       ~fs32_to_cpu(sb, usb1->fs_cgmask));
+		printk(" size:        %u\n", fs32_to_cpu(sb, usb1->fs_size));
+		printk(" dsize:       %u\n", fs32_to_cpu(sb, usb1->fs_dsize));
+		printk(" ncg:         %u\n", fs32_to_cpu(sb, usb1->fs_ncg));
+		printk(" bsize:       %u\n", fs32_to_cpu(sb, usb1->fs_bsize));
+		printk(" fsize:       %u\n", fs32_to_cpu(sb, usb1->fs_fsize));
+		printk(" frag:        %u\n", fs32_to_cpu(sb, usb1->fs_frag));
+		printk(" fragshift:   %u\n",
+		       fs32_to_cpu(sb, usb1->fs_fragshift));
+		printk(" ~fmask:      %u\n", ~fs32_to_cpu(sb, usb1->fs_fmask));
+		printk(" fshift:      %u\n", fs32_to_cpu(sb, usb1->fs_fshift));
+		printk(" sbsize:      %u\n", fs32_to_cpu(sb, usb1->fs_sbsize));
+		printk(" spc:         %u\n", fs32_to_cpu(sb, usb1->fs_spc));
+		printk(" cpg:         %u\n", fs32_to_cpu(sb, usb1->fs_cpg));
+		printk(" ipg:         %u\n", fs32_to_cpu(sb, usb1->fs_ipg));
+		printk(" fpg:         %u\n", fs32_to_cpu(sb, usb1->fs_fpg));
+		printk(" csaddr:      %u\n", fs32_to_cpu(sb, usb1->fs_csaddr));
+		printk(" cssize:      %u\n", fs32_to_cpu(sb, usb1->fs_cssize));
+		printk(" cgsize:      %u\n", fs32_to_cpu(sb, usb1->fs_cgsize));
+		printk(" fstodb:      %u\n",
+		       fs32_to_cpu(sb, usb1->fs_fsbtodb));
+		printk(" nrpos:       %u\n", fs32_to_cpu(sb, usb3->fs_nrpos));
+		printk(" ndir         %u\n",
+		       fs32_to_cpu(sb, usb1->fs_cstotal.cs_ndir));
+		printk(" nifree       %u\n",
+		       fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree));
+		printk(" nbfree       %u\n",
+		       fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree));
+		printk(" nffree       %u\n",
+		       fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree));
+	}
 	printk("\n");
 }
 
 /*
  * Print contents of ufs_cylinder_group, useful for debugging
  */
-void ufs_print_cylinder_stuff(struct super_block *sb, struct ufs_cylinder_group *cg)
+static void ufs_print_cylinder_stuff(struct super_block *sb,
+				     struct ufs_cylinder_group *cg)
 {
 	printk("\nufs_print_cylinder_stuff\n");
 	printk("size of ucg: %zu\n", sizeof(struct ufs_cylinder_group));
@@ -196,11 +191,17 @@ void ufs_print_cylinder_stuff(struct sup
 	printk("  iuseoff:      %u\n", fs32_to_cpu(sb, cg->cg_iusedoff));
 	printk("  freeoff:      %u\n", fs32_to_cpu(sb, cg->cg_freeoff));
 	printk("  nextfreeoff:  %u\n", fs32_to_cpu(sb, cg->cg_nextfreeoff));
-	printk("  clustersumoff %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clustersumoff));
-	printk("  clusteroff    %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clusteroff));
-	printk("  nclusterblks  %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_nclusterblks));
+	printk("  clustersumoff %u\n",
+	       fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clustersumoff));
+	printk("  clusteroff    %u\n",
+	       fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clusteroff));
+	printk("  nclusterblks  %u\n",
+	       fs32_to_cpu(sb, cg->cg_u.cg_44.cg_nclusterblks));
 	printk("\n");
 }
+#else
+#  define ufs_print_super_stuff(sb, flags, usb1, usb2, usb3) /**/
+#  define ufs_print_cylinder_stuff(sb, cg) /**/
 #endif /* CONFIG_UFS_DEBUG */
 
 static struct super_operations ufs_super_ops;
@@ -384,9 +385,9 @@ static int ufs_parse_options (char * opt
  */
 static int ufs_read_cylinder_structures (struct super_block *sb)
 {
-	struct ufs_sb_info * sbi = UFS_SB(sb);
-	struct ufs_sb_private_info * uspi;
-	struct ufs_super_block *usb;
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_sb_private_info *uspi = sbi->s_uspi;
+	struct ufs_super_block_third *usb3;
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned size, blks, i;
@@ -394,10 +395,7 @@ static int ufs_read_cylinder_structures 
 	
 	UFSD("ENTER\n");
 	
-	uspi = sbi->s_uspi;
-
-	usb  = (struct ufs_super_block *)
-		((struct ufs_buffer_head *)uspi)->bh[0]->b_data;
+	usb3 = ubh_get_usb_third(uspi);
 
         flags = UFS_SB(sb)->s_flags;
 	
@@ -418,7 +416,7 @@ static int ufs_read_cylinder_structures 
 
 		if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) 
 			ubh = ubh_bread(sb,
-				fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_csaddr) + i, size);
+				fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_csaddr) + i, size);
 		else 
 			ubh = ubh_bread(sb, uspi->s_csaddr + i, size);
 		
@@ -450,9 +448,8 @@ static int ufs_read_cylinder_structures 
 			goto failed;
 		if (!ufs_cg_chkmagic (sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data))
 			goto failed;
-#ifdef CONFIG_UFS_DEBUG
+
 		ufs_print_cylinder_stuff(sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data);
-#endif
 	}
 	for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
 		if (!(sbi->s_ucpi[i] = kmalloc (sizeof(struct ufs_cg_private_info), GFP_KERNEL)))
@@ -818,12 +815,8 @@ magic_found:
 		goto again;
 	}
 
-#ifdef CONFIG_UFS_DEBUG
-        if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
-		ufs2_print_super_stuff(sb,usb);
-        else
-		ufs_print_super_stuff(sb, usb1, usb2, usb3);
-#endif
+
+	ufs_print_super_stuff(sb, flags, usb1, usb2, usb3);
 
 	/*
 	 * Check, if file system was correctly unmounted.
@@ -878,10 +871,9 @@ magic_found:
 	uspi->s_cgmask = fs32_to_cpu(sb, usb1->fs_cgmask);
 
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
-		uspi->s_u2_size  = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size);
-		uspi->s_u2_dsize = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize);
-	}
-	else {
+		uspi->s_u2_size  = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_size);
+		uspi->s_u2_dsize = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_dsize);
+	} else {
 		uspi->s_size  =  fs32_to_cpu(sb, usb1->fs_size);
 		uspi->s_dsize =  fs32_to_cpu(sb, usb1->fs_dsize);
 	}
@@ -916,8 +908,8 @@ magic_found:
 	uspi->s_spc = fs32_to_cpu(sb, usb1->fs_spc);
 	uspi->s_ipg = fs32_to_cpu(sb, usb1->fs_ipg);
 	uspi->s_fpg = fs32_to_cpu(sb, usb1->fs_fpg);
-	uspi->s_cpc = fs32_to_cpu(sb, usb2->fs_cpc);
-	uspi->s_contigsumsize = fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_contigsumsize);
+	uspi->s_cpc = fs32_to_cpu(sb, usb2->fs_un.fs_u1.fs_cpc);
+	uspi->s_contigsumsize = fs32_to_cpu(sb, usb3->fs_un2.fs_44.fs_contigsumsize);
 	uspi->s_qbmask = ufs_get_fs_qbmask(sb, usb3);
 	uspi->s_qfmask = ufs_get_fs_qfmask(sb, usb3);
 	uspi->s_postblformat = fs32_to_cpu(sb, usb3->fs_postblformat);
@@ -949,7 +941,7 @@ magic_found:
 	if ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) ==
 	    UFS_MOUNT_UFSTYPE_44BSD)
 		uspi->s_maxsymlinklen =
-		    fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_maxsymlinklen);
+		    fs32_to_cpu(sb, usb3->fs_un2.fs_44.fs_maxsymlinklen);
 	
 	sbi->s_flags = flags;
 
@@ -987,7 +979,8 @@ failed_nomem:
 	return -ENOMEM;
 }
 
-static void ufs_write_super (struct super_block *sb) {
+static void ufs_write_super(struct super_block *sb)
+{
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_third * usb3;
@@ -1027,7 +1020,7 @@ static void ufs_put_super(struct super_b
 	kfree (sbi->s_uspi);
 	kfree (sbi);
 	sb->s_fs_info = NULL;
-UFSD("EXIT\n");
+	UFSD("EXIT\n");
 	return;
 }
 
@@ -1109,28 +1102,26 @@ static int ufs_remount (struct super_blo
 
 static int ufs_statfs (struct super_block *sb, struct kstatfs *buf)
 {
-	struct ufs_sb_private_info * uspi;
-	struct ufs_super_block_first * usb1;
-	struct ufs_super_block * usb;
-	unsigned  flags = 0;
+	struct ufs_sb_private_info *uspi= UFS_SB(sb)->s_uspi;
+	unsigned  flags = UFS_SB(sb)->s_flags;
+	struct ufs_super_block_first *usb1;
+	struct ufs_super_block_second *usb2;
+	struct ufs_super_block_third *usb3;
 
 	lock_kernel();
 
-	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (uspi);
-	usb  = (struct ufs_super_block *)
-		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
+	usb1 = ubh_get_usb_first(uspi);
+	usb2 = ubh_get_usb_second(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 	
-	flags = UFS_SB(sb)->s_flags;
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
 		buf->f_type = UFS2_MAGIC;
-		buf->f_blocks = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize);
-		buf->f_bfree = ufs_blkstofrags(fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_cstotal.cs_nbfree)) +
-			fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_cstotal.cs_nffree);
-		buf->f_ffree = fs64_to_cpu(sb,
-        		usb->fs_u11.fs_u2.fs_cstotal.cs_nifree);
-	}
-	else {
+		buf->f_blocks = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.fs_dsize);
+		buf->f_bfree = ufs_blkstofrags(
+			fs64_to_cpu(sb, usb2->fs_un.fs_u2.cs_nbfree)) +
+			fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nffree);
+		buf->f_ffree = fs64_to_cpu(sb, usb3->fs_un1.fs_u2.cs_nifree);
+	} else {
 		buf->f_type = UFS_MAGIC;
 		buf->f_blocks = uspi->s_dsize;
 		buf->f_bfree = ufs_blkstofrags(fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree)) +
Index: linux-2.6.17-rc6-mm2/fs/ufs/util.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/util.h
+++ linux-2.6.17-rc6-mm2/fs/ufs/util.h
@@ -39,12 +39,12 @@ ufs_get_fs_state(struct super_block *sb,
 {
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
-		return fs32_to_cpu(sb, usb3->fs_u2.fs_sun.fs_state);
+		return fs32_to_cpu(sb, usb3->fs_un2.fs_sun.fs_state);
 	case UFS_ST_SUNx86:
 		return fs32_to_cpu(sb, usb1->fs_u1.fs_sunx86.fs_state);
 	case UFS_ST_44BSD:
 	default:
-		return fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_state);
+		return fs32_to_cpu(sb, usb3->fs_un2.fs_44.fs_state);
 	}
 }
 
@@ -54,13 +54,13 @@ ufs_set_fs_state(struct super_block *sb,
 {
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
-		usb3->fs_u2.fs_sun.fs_state = cpu_to_fs32(sb, value);
+		usb3->fs_un2.fs_sun.fs_state = cpu_to_fs32(sb, value);
 		break;
 	case UFS_ST_SUNx86:
 		usb1->fs_u1.fs_sunx86.fs_state = cpu_to_fs32(sb, value);
 		break;
 	case UFS_ST_44BSD:
-		usb3->fs_u2.fs_44.fs_state = cpu_to_fs32(sb, value);
+		usb3->fs_un2.fs_44.fs_state = cpu_to_fs32(sb, value);
 		break;
 	}
 }
@@ -70,7 +70,7 @@ ufs_get_fs_npsect(struct super_block *sb
 		  struct ufs_super_block_third *usb3)
 {
 	if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
-		return fs32_to_cpu(sb, usb3->fs_u2.fs_sunx86.fs_npsect);
+		return fs32_to_cpu(sb, usb3->fs_un2.fs_sunx86.fs_npsect);
 	else
 		return fs32_to_cpu(sb, usb1->fs_u1.fs_sun.fs_npsect);
 }
@@ -82,16 +82,16 @@ ufs_get_fs_qbmask(struct super_block *sb
 
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qbmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qbmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_sun.fs_qbmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_sun.fs_qbmask[1];
 		break;
 	case UFS_ST_SUNx86:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qbmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qbmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_sunx86.fs_qbmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_sunx86.fs_qbmask[1];
 		break;
 	case UFS_ST_44BSD:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qbmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qbmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_44.fs_qbmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_44.fs_qbmask[1];
 		break;
 	}
 
@@ -105,16 +105,16 @@ ufs_get_fs_qfmask(struct super_block *sb
 
 	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qfmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qfmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_sun.fs_qfmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_sun.fs_qfmask[1];
 		break;
 	case UFS_ST_SUNx86:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qfmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qfmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_sunx86.fs_qfmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_sunx86.fs_qfmask[1];
 		break;
 	case UFS_ST_44BSD:
-		((__fs32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qfmask[0];
-		((__fs32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qfmask[1];
+		((__fs32 *)&tmp)[0] = usb3->fs_un2.fs_44.fs_qfmask[0];
+		((__fs32 *)&tmp)[1] = usb3->fs_un2.fs_44.fs_qfmask[1];
 		break;
 	}
 
@@ -302,24 +302,6 @@ static inline void *get_usb_offset(struc
 #define ubh_blkmap(ubh,begin,bit) \
 	((*ubh_get_addr(ubh, (begin) + ((bit) >> 3)) >> ((bit) & 7)) & (0xff >> (UFS_MAXFRAG - uspi->s_fpb)))
 
-
-/*
- * Macros for access to superblock array structures
- */
-#define ubh_postbl(ubh,cylno,i) \
-	((uspi->s_postblformat != UFS_DYNAMICPOSTBLFMT) \
-	? (*(__s16*)(ubh_get_addr(ubh, \
-	(unsigned)(&((struct ufs_super_block *)0)->fs_opostbl) \
-	+ (((cylno) * 16 + (i)) << 1) ) )) \
-	: (*(__s16*)(ubh_get_addr(ubh, \
-	uspi->s_postbloff + (((cylno) * uspi->s_nrpos + (i)) << 1) ))))
-
-#define ubh_rotbl(ubh,i) \
-	((uspi->s_postblformat != UFS_DYNAMICPOSTBLFMT) \
-	? (*(__u8*)(ubh_get_addr(ubh, \
-	(unsigned)(&((struct ufs_super_block *)0)->fs_space) + (i)))) \
-	: (*(__u8*)(ubh_get_addr(ubh, uspi->s_rotbloff + (i)))))
-
 /*
  * Determine the number of available frags given a
  * percentage to hold in reserve.
Index: linux-2.6.17-rc6-mm2/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/ufs_fs.h
+++ linux-2.6.17-rc6-mm2/include/linux/ufs_fs.h
@@ -351,8 +351,12 @@ struct ufs2_csum_total {
 	__fs64   cs_spare[3];	/* future expansion */
 };
 
+#if 0
 /*
  * This is the actual superblock, as it is laid out on the disk.
+ * Do NOT use this structure, because of sizeof(ufs_super_block) > 512 and
+ * it may occupy several blocks, use
+ * struct ufs_super_block_(first,second,third) instead.
  */
 struct ufs_super_block {
 	__fs32	fs_link;	/* UNUSED */
@@ -498,6 +502,7 @@ struct ufs_super_block {
 	__fs32	fs_magic;		/* magic number */
 	__u8	fs_space[1];		/* list of blocks for each rotation */
 };
+#endif/*struct ufs_super_block*/
 
 /*
  * Preference for optimization.
@@ -837,16 +842,54 @@ struct ufs_super_block_first {
 };
 
 struct ufs_super_block_second {
-	__s8	fs_fsmnt[212];
-	__fs32	fs_cgrotor;
-	__fs32	fs_csp[UFS_MAXCSBUFS];
-	__fs32	fs_maxcluster;
-	__fs32	fs_cpc;
-	__fs16	fs_opostbl[82];
-};	
+	union {
+		struct {
+			__s8	fs_fsmnt[212];
+			__fs32	fs_cgrotor;
+			__fs32	fs_csp[UFS_MAXCSBUFS];
+			__fs32	fs_maxcluster;
+			__fs32	fs_cpc;
+			__fs16	fs_opostbl[82];
+		} fs_u1;
+		struct {
+			__s8  fs_fsmnt[UFS2_MAXMNTLEN - UFS_MAXMNTLEN + 212];
+			__u8   fs_volname[UFS2_MAXVOLLEN];
+			__fs64  fs_swuid;
+			__fs32  fs_pad;
+			__fs32   fs_cgrotor;
+			__fs32   fs_ocsp[UFS2_NOCSPTRS];
+			__fs32   fs_contigdirs;
+			__fs32   fs_csp;
+			__fs32   fs_maxcluster;
+			__fs32   fs_active;
+			__fs32   fs_old_cpc;
+			__fs32   fs_maxbsize;
+			__fs64   fs_sparecon64[17];
+			__fs64   fs_sblockloc;
+			__fs64	cs_ndir;
+			__fs64	cs_nbfree;
+		} fs_u2;
+	} fs_un;
+};
 
 struct ufs_super_block_third {
-	__fs16	fs_opostbl[46];
+	union {
+		struct {
+			__fs16	fs_opostbl[46];
+		} fs_u1;
+		struct {
+			__fs64	cs_nifree;	/* number of free inodes */
+			__fs64	cs_nffree;	/* number of free frags */
+			__fs64   cs_numclusters;	/* number of free clusters */
+			__fs64   cs_spare[3];	/* future expansion */
+			struct  ufs_timeval    fs_time;		/* last time written */
+			__fs64    fs_size;		/* number of blocks in fs */
+			__fs64    fs_dsize;	/* number of data blocks in fs */
+			__fs64   fs_csaddr;	/* blk addr of cyl grp summary area */
+			__fs64    fs_pendingblocks;/* blocks in process of being freed */
+			__fs32    fs_pendinginodes;/*inodes in process of being freed */
+		} fs_u2;
+	} fs_un1;
 	union {
 		struct {
 			__fs32	fs_sparecon[53];/* reserved for future constants */
@@ -874,7 +917,7 @@ struct ufs_super_block_third {
 			__fs32	fs_qfmask[2];	/* ~usb_fmask */
 			__fs32	fs_state;	/* file system state time stamp */
 		} fs_44;
-	} fs_u2;
+	} fs_un2;
 	__fs32	fs_postblformat;
 	__fs32	fs_nrpos;
 	__fs32	fs_postbloff;

-- 
/Evgeniy

