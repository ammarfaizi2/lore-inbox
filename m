Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSC1Biz>; Wed, 27 Mar 2002 20:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311378AbSC1Bil>; Wed, 27 Mar 2002 20:38:41 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:32988 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311362AbSC1BiZ>; Wed, 27 Mar 2002 20:38:25 -0500
Message-ID: <3CA273D5.90103@didntduck.org>
Date: Wed, 27 Mar 2002 20:37:25 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: [PATCH] struct super_block cleanup - reiserfs
Content-Type: multipart/mixed;
 boundary="------------020000000008080005040403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000000008080005040403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates ufs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------020000000008080005040403
Content-Type: text/plain;
 name="sb-ufs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-ufs-1"

diff -urN linux-2.5.7-bg1/fs/ufs/balloc.c linux-2.5.7-bg2/fs/ufs/balloc.c
--- linux-2.5.7-bg1/fs/ufs/balloc.c	Thu Mar  7 21:18:10 2002
+++ linux-2.5.7-bg2/fs/ufs/balloc.c	Wed Mar 27 20:18:33 2002
@@ -46,7 +46,7 @@
 	unsigned cgno, bit, end_bit, bbase, blkmap, i, blkno, cylno;
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
@@ -88,7 +88,7 @@
 	
 	fs32_add(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_add(sb, &usb1->fs_cstotal.cs_nffree, count);
-	fs32_add(sb, &sb->fs_cs(cgno).cs_nffree, count);
+	fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	blkmap = ubh_blkmap (UCPI_UBH, ucpi->c_freeoff, bbase);
 	ufs_fragacct(sb, blkmap, ucg->cg_frsum, 1);
 
@@ -99,12 +99,12 @@
 	if (ubh_isblockset(UCPI_UBH, ucpi->c_freeoff, blkno)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, uspi->s_fpb);
-		fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, uspi->s_fpb);
-		if ((sb->u.ufs_sb.s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
+		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
+		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
 		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
-		fs32_add(sb, &sb->fs_cs(cgno).cs_nbfree, 1);
+		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno (bbase);
 		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(bbase)), 1);
 		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
@@ -140,7 +140,7 @@
 	unsigned overflow, cgno, bit, end_bit, blkno, i, cylno;
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
@@ -183,13 +183,13 @@
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
 		ubh_setblock(UCPI_UBH, ucpi->c_freeoff, blkno);
-		if ((sb->u.ufs_sb.s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
+		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
 		DQUOT_FREE_BLOCK(inode, uspi->s_fpb);
 
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
 		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
-		fs32_add(sb, &sb->fs_cs(cgno).cs_nbfree, 1);
+		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno(i);
 		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(i)), 1);
 		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
@@ -246,7 +246,7 @@
 	UFSD(("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count))
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	*err = -ENOSPC;
 
@@ -406,12 +406,12 @@
 	UFSD(("ENTER, fragment %u, oldcount %u, newcount %u\n", fragment, oldcount, newcount))
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	count = newcount - oldcount;
 	
 	cgno = ufs_dtog(fragment);
-	if (sb->fs_cs(cgno).cs_nffree < count)
+	if (UFS_SB(sb)->fs_cs(cgno).cs_nffree < count)
 		return 0;
 	if ((ufs_fragnum (fragment) + newcount) > uspi->s_fpb)
 		return 0;
@@ -452,7 +452,7 @@
 	}
 
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
-	fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, count);
+	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
 	
 	ubh_mark_buffer_dirty (USPI_UBH);
@@ -469,7 +469,7 @@
 }
 
 #define UFS_TEST_FREE_SPACE_CG \
-	ucg = (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[cgno]->b_data; \
+	ucg = (struct ufs_cylinder_group *) UFS_SB(sb)->s_ucg[cgno]->b_data; \
 	if (fs32_to_cpu(sb, ucg->cg_cs.cs_nbfree)) \
 		goto cg_found; \
 	for (k = count; k < uspi->s_fpb; k++) \
@@ -489,7 +489,7 @@
 	UFSD(("ENTER, ino %lu, cgno %u, goal %u, count %u\n", inode->i_ino, cgno, goal, count))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	oldcg = cgno;
 	
@@ -556,7 +556,7 @@
 
 		fs32_add(sb, &ucg->cg_cs.cs_nffree, i);
 		fs32_add(sb, &usb1->fs_cstotal.cs_nffree, i);
-		fs32_add(sb, &sb->fs_cs(cgno).cs_nffree, i);
+		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, i);
 		fs32_add(sb, &ucg->cg_frsum[i], 1);
 		goto succed;
 	}
@@ -573,7 +573,7 @@
 	
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
-	fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, count);
+	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	fs32_sub(sb, &ucg->cg_frsum[allocsize], 1);
 
 	if (count != allocsize)
@@ -605,7 +605,7 @@
 	UFSD(("ENTER, goal %u\n", goal))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
@@ -632,7 +632,7 @@
 gotit:
 	blkno = ufs_fragstoblks(result);
 	ubh_clrblock (UCPI_UBH, ucpi->c_freeoff, blkno);
-	if ((sb->u.ufs_sb.s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
+	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 		ufs_clusteracct (sb, ucpi, blkno, -1);
 	if(DQUOT_ALLOC_BLOCK(inode, uspi->s_fpb)) {
 		*err = -EDQUOT;
@@ -641,7 +641,7 @@
 
 	fs32_sub(sb, &ucg->cg_cs.cs_nbfree, 1);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nbfree, 1);
-	fs32_sub(sb, &sb->fs_cs(ucpi->c_cgx).cs_nbfree, 1);
+	fs32_sub(sb, &UFS_SB(sb)->fs_cs(ucpi->c_cgx).cs_nbfree, 1);
 	cylno = ufs_cbtocylno(result);
 	fs16_sub(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(result)), 1);
 	fs32_sub(sb, &ubh_cg_blktot(ucpi, cylno), 1);
@@ -662,7 +662,7 @@
 	
 	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count))
 
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
@@ -728,7 +728,7 @@
 	struct ufs_sb_private_info * uspi;
 	int i, start, end, forw, back;
 	
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	if (uspi->s_contigsumsize <= 0)
 		return;
 
diff -urN linux-2.5.7-bg1/fs/ufs/cylinder.c linux-2.5.7-bg2/fs/ufs/cylinder.c
--- linux-2.5.7-bg1/fs/ufs/cylinder.c	Thu Mar  7 21:18:16 2002
+++ linux-2.5.7-bg2/fs/ufs/cylinder.c	Wed Mar 27 20:18:33 2002
@@ -37,26 +37,27 @@
 static void ufs_read_cylinder (struct super_block * sb,
 	unsigned cgno, unsigned bitmap_nr)
 {
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned i, j;
 
 	UFSD(("ENTER, cgno %u, bitmap_nr %u\n", cgno, bitmap_nr))
-	uspi = sb->u.ufs_sb.s_uspi;
-	ucpi = sb->u.ufs_sb.s_ucpi[bitmap_nr];
-	ucg = (struct ufs_cylinder_group *)sb->u.ufs_sb.s_ucg[cgno]->b_data;
+	uspi = sbi->s_uspi;
+	ucpi = sbi->s_ucpi[bitmap_nr];
+	ucg = (struct ufs_cylinder_group *)sbi->s_ucg[cgno]->b_data;
 
 	UCPI_UBH->fragment = ufs_cgcmin(cgno);
 	UCPI_UBH->count = uspi->s_cgsize >> sb->s_blocksize_bits;
 	/*
 	 * We have already the first fragment of cylinder group block in buffer
 	 */
-	UCPI_UBH->bh[0] = sb->u.ufs_sb.s_ucg[cgno];
+	UCPI_UBH->bh[0] = sbi->s_ucg[cgno];
 	for (i = 1; i < UCPI_UBH->count; i++)
 		if (!(UCPI_UBH->bh[i] = sb_bread(sb, UCPI_UBH->fragment + i)))
 			goto failed;
-	sb->u.ufs_sb.s_cgno[bitmap_nr] = cgno;
+	sbi->s_cgno[bitmap_nr] = cgno;
 			
 	ucpi->c_cgx	= fs32_to_cpu(sb, ucg->cg_cgx);
 	ucpi->c_ncyl	= fs16_to_cpu(sb, ucg->cg_ncyl);
@@ -78,8 +79,8 @@
 	
 failed:
 	for (j = 1; j < i; j++)
-		brelse (sb->u.ufs_sb.s_ucg[j]);
-	sb->u.ufs_sb.s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
+		brelse (sbi->s_ucg[j]);
+	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
 	ufs_error (sb, "ufs_read_cylinder", "can't read cylinder group block %u", cgno);
 }
 
@@ -89,6 +90,7 @@
  */
 void ufs_put_cylinder (struct super_block * sb, unsigned bitmap_nr)
 {
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi; 
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
@@ -96,15 +98,15 @@
 
 	UFSD(("ENTER, bitmap_nr %u\n", bitmap_nr))
 
-	uspi = sb->u.ufs_sb.s_uspi;
-	if (sb->u.ufs_sb.s_cgno[bitmap_nr] == UFS_CGNO_EMPTY) {
+	uspi = sbi->s_uspi;
+	if (sbi->s_cgno[bitmap_nr] == UFS_CGNO_EMPTY) {
 		UFSD(("EXIT\n"))
 		return;
 	}
-	ucpi = sb->u.ufs_sb.s_ucpi[bitmap_nr];
+	ucpi = sbi->s_ucpi[bitmap_nr];
 	ucg = ubh_get_ucg(UCPI_UBH);
 
-	if (uspi->s_ncg > UFS_MAX_GROUP_LOADED && bitmap_nr >= sb->u.ufs_sb.s_cg_loaded) {
+	if (uspi->s_ncg > UFS_MAX_GROUP_LOADED && bitmap_nr >= sbi->s_cg_loaded) {
 		ufs_panic (sb, "ufs_put_cylinder", "internal error");
 		return;
 	}
@@ -120,7 +122,7 @@
 		brelse (UCPI_UBH->bh[i]);
 	}
 
-	sb->u.ufs_sb.s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
+	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
 	UFSD(("EXIT\n"))
 }
 
@@ -133,13 +135,14 @@
 struct ufs_cg_private_info * ufs_load_cylinder (
 	struct super_block * sb, unsigned cgno)
 {
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_cg_private_info * ucpi;
 	unsigned cg, i, j;
 
 	UFSD(("ENTER, cgno %u\n", cgno))
 
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = sbi->s_uspi;
 	if (cgno >= uspi->s_ncg) {
 		ufs_panic (sb, "ufs_load_cylinder", "internal error, high number of cg");
 		return NULL;
@@ -147,61 +150,61 @@
 	/*
 	 * Cylinder group number cg it in cache and it was last used
 	 */
-	if (sb->u.ufs_sb.s_cgno[0] == cgno) {
+	if (sbi->s_cgno[0] == cgno) {
 		UFSD(("EXIT\n"))
-		return sb->u.ufs_sb.s_ucpi[0];
+		return sbi->s_ucpi[0];
 	}
 	/*
 	 * Number of cylinder groups is not higher than UFS_MAX_GROUP_LOADED
 	 */
 	if (uspi->s_ncg <= UFS_MAX_GROUP_LOADED) {
-		if (sb->u.ufs_sb.s_cgno[cgno] != UFS_CGNO_EMPTY) {
-			if (sb->u.ufs_sb.s_cgno[cgno] != cgno) {
+		if (sbi->s_cgno[cgno] != UFS_CGNO_EMPTY) {
+			if (sbi->s_cgno[cgno] != cgno) {
 				ufs_panic (sb, "ufs_load_cylinder", "internal error, wrong number of cg in cache");
 				UFSD(("EXIT (FAILED)\n"))
 				return NULL;
 			}
 			else {
 				UFSD(("EXIT\n"))
-				return sb->u.ufs_sb.s_ucpi[cgno];
+				return sbi->s_ucpi[cgno];
 			}
 		} else {
 			ufs_read_cylinder (sb, cgno, cgno);
 			UFSD(("EXIT\n"))
-			return sb->u.ufs_sb.s_ucpi[cgno];
+			return sbi->s_ucpi[cgno];
 		}
 	}
 	/*
 	 * Cylinder group number cg is in cache but it was not last used, 
 	 * we will move to the first position
 	 */
-	for (i = 0; i < sb->u.ufs_sb.s_cg_loaded && sb->u.ufs_sb.s_cgno[i] != cgno; i++);
-	if (i < sb->u.ufs_sb.s_cg_loaded && sb->u.ufs_sb.s_cgno[i] == cgno) {
-		cg = sb->u.ufs_sb.s_cgno[i];
-		ucpi = sb->u.ufs_sb.s_ucpi[i];
+	for (i = 0; i < sbi->s_cg_loaded && sbi->s_cgno[i] != cgno; i++);
+	if (i < sbi->s_cg_loaded && sbi->s_cgno[i] == cgno) {
+		cg = sbi->s_cgno[i];
+		ucpi = sbi->s_ucpi[i];
 		for (j = i; j > 0; j--) {
-			sb->u.ufs_sb.s_cgno[j] = sb->u.ufs_sb.s_cgno[j-1];
-			sb->u.ufs_sb.s_ucpi[j] = sb->u.ufs_sb.s_ucpi[j-1];
+			sbi->s_cgno[j] = sbi->s_cgno[j-1];
+			sbi->s_ucpi[j] = sbi->s_ucpi[j-1];
 		}
-		sb->u.ufs_sb.s_cgno[0] = cg;
-		sb->u.ufs_sb.s_ucpi[0] = ucpi;
+		sbi->s_cgno[0] = cg;
+		sbi->s_ucpi[0] = ucpi;
 	/*
 	 * Cylinder group number cg is not in cache, we will read it from disk
 	 * and put it to the first position
 	 */
 	} else {
-		if (sb->u.ufs_sb.s_cg_loaded < UFS_MAX_GROUP_LOADED)
-			sb->u.ufs_sb.s_cg_loaded++;
+		if (sbi->s_cg_loaded < UFS_MAX_GROUP_LOADED)
+			sbi->s_cg_loaded++;
 		else
 			ufs_put_cylinder (sb, UFS_MAX_GROUP_LOADED-1);
-		ucpi = sb->u.ufs_sb.s_ucpi[sb->u.ufs_sb.s_cg_loaded - 1];
-		for (j = sb->u.ufs_sb.s_cg_loaded - 1; j > 0; j--) {
-			sb->u.ufs_sb.s_cgno[j] = sb->u.ufs_sb.s_cgno[j-1];
-			sb->u.ufs_sb.s_ucpi[j] = sb->u.ufs_sb.s_ucpi[j-1];
+		ucpi = sbi->s_ucpi[sbi->s_cg_loaded - 1];
+		for (j = sbi->s_cg_loaded - 1; j > 0; j--) {
+			sbi->s_cgno[j] = sbi->s_cgno[j-1];
+			sbi->s_ucpi[j] = sbi->s_ucpi[j-1];
 		}
-		sb->u.ufs_sb.s_ucpi[0] = ucpi;
+		sbi->s_ucpi[0] = ucpi;
 		ufs_read_cylinder (sb, cgno, 0);
 	}
 	UFSD(("EXIT\n"))
-	return sb->u.ufs_sb.s_ucpi[0];
+	return sbi->s_ucpi[0];
 }
diff -urN linux-2.5.7-bg1/fs/ufs/dir.c linux-2.5.7-bg2/fs/ufs/dir.c
--- linux-2.5.7-bg1/fs/ufs/dir.c	Thu Mar  7 21:18:19 2002
+++ linux-2.5.7-bg2/fs/ufs/dir.c	Wed Mar 27 20:18:33 2002
@@ -63,7 +63,7 @@
 	unsigned flags;
 
 	sb = inode->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
+	flags = UFS_SB(sb)->s_flags;
 
 	UFSD(("ENTER, ino %lu  f_pos %lu\n", inode->i_ino, (unsigned long) filp->f_pos))
 
@@ -301,8 +301,8 @@
 		error_msg = "reclen is too small for namlen";
 	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
-	else if (fs32_to_cpu(sb, de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg *
-				      sb->u.ufs_sb.s_uspi->s_ncg))
+	else if (fs32_to_cpu(sb, de->d_ino) > (UFS_SB(sb)->s_uspi->s_ipg *
+				      UFS_SB(sb)->s_uspi->s_ncg))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
@@ -379,7 +379,7 @@
 	UFSD(("ENTER, name %s, namelen %u\n", name, namelen))
 	
 	sb = dir->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 
 	if (!namelen)
 		return -EINVAL;
diff -urN linux-2.5.7-bg1/fs/ufs/ialloc.c linux-2.5.7-bg2/fs/ufs/ialloc.c
--- linux-2.5.7-bg1/fs/ufs/ialloc.c	Thu Mar  7 21:18:23 2002
+++ linux-2.5.7-bg2/fs/ufs/ialloc.c	Wed Mar 27 20:18:33 2002
@@ -70,7 +70,7 @@
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
 	ino = inode->i_ino;
@@ -111,12 +111,12 @@
 			ucpi->c_irotor = ino;
 		fs32_add(sb, &ucg->cg_cs.cs_nifree, 1);
 		fs32_add(sb, &usb1->fs_cstotal.cs_nifree, 1);
-		fs32_add(sb, &sb->fs_cs(cg).cs_nifree, 1);
+		fs32_add(sb, &UFS_SB(sb)->fs_cs(cg).cs_nifree, 1);
 
 		if (is_directory) {
 			fs32_sub(sb, &ucg->cg_cs.cs_ndir, 1);
 			fs32_sub(sb, &usb1->fs_cstotal.cs_ndir, 1);
-			fs32_sub(sb, &sb->fs_cs(cg).cs_ndir, 1);
+			fs32_sub(sb, &UFS_SB(sb)->fs_cs(cg).cs_ndir, 1);
 		}
 	}
 
@@ -145,6 +145,7 @@
 struct inode * ufs_new_inode(struct inode * dir, int mode)
 {
 	struct super_block * sb;
+	struct ufs_sb_info * sbi;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_cg_private_info * ucpi;
@@ -163,7 +164,8 @@
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	ufsi = UFS_I(inode);
-	uspi = sb->u.ufs_sb.s_uspi;
+	sbi = UFS_SB(sb);
+	uspi = sbi->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 
 	lock_super (sb);
@@ -172,7 +174,7 @@
 	 * Try to place the inode in its parent directory
 	 */
 	i = ufs_inotocg(dir->i_ino);
-	if (sb->fs_cs(i).cs_nifree) {
+	if (sbi->fs_cs(i).cs_nifree) {
 		cg = i;
 		goto cg_found;
 	}
@@ -184,7 +186,7 @@
 		i += j;
 		if (i >= uspi->s_ncg)
 			i -= uspi->s_ncg;
-		if (sb->fs_cs(i).cs_nifree) {
+		if (sbi->fs_cs(i).cs_nifree) {
 			cg = i;
 			goto cg_found;
 		}
@@ -198,7 +200,7 @@
 		i++;
 		if (i >= uspi->s_ncg)
 			i = 0;
-		if (sb->fs_cs(i).cs_nifree) {
+		if (sbi->fs_cs(i).cs_nifree) {
 			cg = i;
 			goto cg_found;
 		}
@@ -234,12 +236,12 @@
 	
 	fs32_sub(sb, &ucg->cg_cs.cs_nifree, 1);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nifree, 1);
-	fs32_sub(sb, &sb->fs_cs(cg).cs_nifree, 1);
+	fs32_sub(sb, &sbi->fs_cs(cg).cs_nifree, 1);
 	
 	if (S_ISDIR(mode)) {
 		fs32_add(sb, &ucg->cg_cs.cs_ndir, 1);
 		fs32_add(sb, &usb1->fs_cstotal.cs_ndir, 1);
-		fs32_add(sb, &sb->fs_cs(cg).cs_ndir, 1);
+		fs32_add(sb, &sbi->fs_cs(cg).cs_ndir, 1);
 	}
 
 	ubh_mark_buffer_dirty (USPI_UBH);
diff -urN linux-2.5.7-bg1/fs/ufs/inode.c linux-2.5.7-bg2/fs/ufs/inode.c
--- linux-2.5.7-bg1/fs/ufs/inode.c	Thu Mar  7 21:18:16 2002
+++ linux-2.5.7-bg2/fs/ufs/inode.c	Wed Mar 27 20:18:33 2002
@@ -52,7 +52,7 @@
 
 static int ufs_block_to_path(struct inode *inode, long i_block, int offsets[4])
 {
-	struct ufs_sb_private_info *uspi = inode->i_sb->u.ufs_sb.s_uspi;
+	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
 	int ptrs = uspi->s_apb;
 	int ptrs_bits = uspi->s_apbshift;
 	const long direct_blocks = UFS_NDADDR,
@@ -86,7 +86,7 @@
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct ufs_sb_private_info *uspi = sb->u.ufs_sb.s_uspi;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	int mask = uspi->s_apbmask>>uspi->s_fpbshift;
 	int shift = uspi->s_apbshift-uspi->s_fpbshift;
 	int offsets[4], *p;
@@ -137,7 +137,7 @@
 		inode->i_ino, fragment, new_fragment, required))         
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
 	p = ufsi->i_u1.i_data + block;
@@ -243,7 +243,7 @@
 	u32 * p;
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
 
@@ -313,7 +313,7 @@
 static int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
 {
 	struct super_block * sb = inode->i_sb;
-	struct ufs_sb_private_info * uspi = sb->u.ufs_sb.s_uspi;
+	struct ufs_sb_private_info * uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * bh;
 	int ret, err, new;
 	unsigned long ptr, phys;
@@ -483,8 +483,8 @@
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
-	flags = sb->u.ufs_sb.s_flags;
+	uspi = UFS_SB(sb)->s_uspi;
+	flags = UFS_SB(sb)->s_flags;
 
 	if (inode->i_ino < UFS_ROOTINO || 
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
@@ -579,8 +579,8 @@
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
-	flags = sb->u.ufs_sb.s_flags;
+	uspi = UFS_SB(sb)->s_uspi;
+	flags = UFS_SB(sb)->s_flags;
 
 	if (inode->i_ino < UFS_ROOTINO || 
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
diff -urN linux-2.5.7-bg1/fs/ufs/namei.c linux-2.5.7-bg2/fs/ufs/namei.c
--- linux-2.5.7-bg1/fs/ufs/namei.c	Thu Mar  7 21:18:32 2002
+++ linux-2.5.7-bg2/fs/ufs/namei.c	Wed Mar 27 20:18:33 2002
@@ -138,7 +138,7 @@
 	if (IS_ERR(inode))
 		goto out;
 
-	if (l > sb->u.ufs_sb.s_uspi->s_maxsymlinklen) {
+	if (l > UFS_SB(sb)->s_uspi->s_maxsymlinklen) {
 		/* slow symlink */
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ufs_aops;
diff -urN linux-2.5.7-bg1/fs/ufs/super.c linux-2.5.7-bg2/fs/ufs/super.c
--- linux-2.5.7-bg1/fs/ufs/super.c	Mon Mar 18 16:14:16 2002
+++ linux-2.5.7-bg2/fs/ufs/super.c	Wed Mar 27 20:18:33 2002
@@ -188,7 +188,7 @@
 	struct ufs_super_block_first * usb1;
 	va_list args;
 
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -200,7 +200,7 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	switch (sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_ONERROR) {
+	switch (UFS_SB(sb)->s_mount_opt & UFS_MOUNT_ONERROR) {
 	case UFS_MOUNT_ONERROR_PANIC:
 		panic ("UFS-fs panic (device %s): %s: %s\n", 
 			sb->s_id, function, error_buf);
@@ -220,7 +220,7 @@
 	struct ufs_super_block_first * usb1;
 	va_list args;
 	
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -317,6 +317,7 @@
  * Read on-disk structures associated with cylinder groups
  */
 int ufs_read_cylinder_structures (struct super_block * sb) {
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
@@ -324,7 +325,7 @@
 	
 	UFSD(("ENTER\n"))
 	
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = sbi->s_uspi;
 	
 	/*
 	 * Read cs structures from (usually) first data block
@@ -343,7 +344,7 @@
 		if (!ubh)
 			goto failed;
 		ubh_ubhcpymem (space, ubh, size);
-		sb->u.ufs_sb.s_csp[ufs_fragstoblks(i)] = (struct ufs_csum *)space;
+		sbi->s_csp[ufs_fragstoblks(i)] = (struct ufs_csum *)space;
 		space += size;
 		ubh_brelse (ubh);
 		ubh = NULL;
@@ -353,41 +354,41 @@
 	 * Read cylinder group (we read only first fragment from block
 	 * at this time) and prepare internal data structures for cg caching.
 	 */
-	if (!(sb->u.ufs_sb.s_ucg = kmalloc (sizeof(struct buffer_head *) * uspi->s_ncg, GFP_KERNEL)))
+	if (!(sbi->s_ucg = kmalloc (sizeof(struct buffer_head *) * uspi->s_ncg, GFP_KERNEL)))
 		goto failed;
 	for (i = 0; i < uspi->s_ncg; i++) 
-		sb->u.ufs_sb.s_ucg[i] = NULL;
+		sbi->s_ucg[i] = NULL;
 	for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
-		sb->u.ufs_sb.s_ucpi[i] = NULL;
-		sb->u.ufs_sb.s_cgno[i] = UFS_CGNO_EMPTY;
+		sbi->s_ucpi[i] = NULL;
+		sbi->s_cgno[i] = UFS_CGNO_EMPTY;
 	}
 	for (i = 0; i < uspi->s_ncg; i++) {
 		UFSD(("read cg %u\n", i))
-		if (!(sb->u.ufs_sb.s_ucg[i] = sb_bread(sb, ufs_cgcmin(i))))
+		if (!(sbi->s_ucg[i] = sb_bread(sb, ufs_cgcmin(i))))
 			goto failed;
-		if (!ufs_cg_chkmagic (sb, (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data))
+		if (!ufs_cg_chkmagic (sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data))
 			goto failed;
 #ifdef UFS_SUPER_DEBUG_MORE
-		ufs_print_cylinder_stuff(sb, (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data);
+		ufs_print_cylinder_stuff(sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data);
 #endif
 	}
 	for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
-		if (!(sb->u.ufs_sb.s_ucpi[i] = kmalloc (sizeof(struct ufs_cg_private_info), GFP_KERNEL)))
+		if (!(sbi->s_ucpi[i] = kmalloc (sizeof(struct ufs_cg_private_info), GFP_KERNEL)))
 			goto failed;
-		sb->u.ufs_sb.s_cgno[i] = UFS_CGNO_EMPTY;
+		sbi->s_cgno[i] = UFS_CGNO_EMPTY;
 	}
-	sb->u.ufs_sb.s_cg_loaded = 0;
+	sbi->s_cg_loaded = 0;
 	UFSD(("EXIT\n"))
 	return 1;
 
 failed:
 	if (base) kfree (base);
-	if (sb->u.ufs_sb.s_ucg) {
+	if (sbi->s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
-			if (sb->u.ufs_sb.s_ucg[i]) brelse (sb->u.ufs_sb.s_ucg[i]);
-		kfree (sb->u.ufs_sb.s_ucg);
+			if (sbi->s_ucg[i]) brelse (sbi->s_ucg[i]);
+		kfree (sbi->s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			if (sb->u.ufs_sb.s_ucpi[i]) kfree (sb->u.ufs_sb.s_ucpi[i]);
+			if (sbi->s_ucpi[i]) kfree (sbi->s_ucpi[i]);
 	}
 	UFSD(("EXIT (FAILED)\n"))
 	return 0;
@@ -398,6 +399,7 @@
  * write them back to disk
  */
 void ufs_put_cylinder_structures (struct super_block * sb) {
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 	struct ufs_sb_private_info * uspi;
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
@@ -405,11 +407,11 @@
 	
 	UFSD(("ENTER\n"))
 	
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = sbi->s_uspi;
 
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
-	base = space = (char*) sb->u.ufs_sb.s_csp[0];
+	base = space = (char*) sbi->s_csp[0];
 	for (i = 0; i < blks; i += uspi->s_fpb) {
 		size = uspi->s_bsize;
 		if (i + uspi->s_fpb > blks)
@@ -421,21 +423,22 @@
 		ubh_mark_buffer_dirty (ubh);
 		ubh_brelse (ubh);
 	}
-	for (i = 0; i < sb->u.ufs_sb.s_cg_loaded; i++) {
+	for (i = 0; i < sbi->s_cg_loaded; i++) {
 		ufs_put_cylinder (sb, i);
-		kfree (sb->u.ufs_sb.s_ucpi[i]);
+		kfree (sbi->s_ucpi[i]);
 	}
 	for (; i < UFS_MAX_GROUP_LOADED; i++) 
-		kfree (sb->u.ufs_sb.s_ucpi[i]);
+		kfree (sbi->s_ucpi[i]);
 	for (i = 0; i < uspi->s_ncg; i++) 
-		brelse (sb->u.ufs_sb.s_ucg[i]);
-	kfree (sb->u.ufs_sb.s_ucg);
+		brelse (sbi->s_ucg[i]);
+	kfree (sbi->s_ucg);
 	kfree (base);
 	UFSD(("EXIT\n"))
 }
 
 static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 {
+	struct ufs_sb_info * sbi;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_second * usb2;
@@ -451,6 +454,12 @@
 	
 	UFSD(("ENTER\n"))
 		
+	sbi = kmalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		goto failed_nomem;
+	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct ufs_sb_info));
+
 	UFSD(("flag %u\n", (int)(sb->s_flags & MS_RDONLY)))
 	
 #ifndef CONFIG_UFS_FS_WRITE
@@ -464,22 +473,22 @@
 	 * Set default mount options
 	 * Parse mount options
 	 */
-	sb->u.ufs_sb.s_mount_opt = 0;
-	ufs_set_opt (sb->u.ufs_sb.s_mount_opt, ONERROR_LOCK);
-	if (!ufs_parse_options ((char *) data, &sb->u.ufs_sb.s_mount_opt)) {
+	sbi->s_mount_opt = 0;
+	ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
+	if (!ufs_parse_options ((char *) data, &sbi->s_mount_opt)) {
 		printk("wrong mount options\n");
 		goto failed;
 	}
-	if (!(sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE)) {
+	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		printk("You didn't specify the type of your ufs filesystem\n\n"
 		"mount -t ufs -o ufstype="
 		"sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
 		">>>WARNING<<< Wrong ufstype may corrupt your filesystem, "
 		"default is ufstype=old\n");
-		ufs_set_opt (sb->u.ufs_sb.s_mount_opt, UFSTYPE_OLD);
+		ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);
 	}
 
-	sb->u.ufs_sb.s_uspi = uspi =
+	sbi->s_uspi = uspi =
 		kmalloc (sizeof(struct ufs_sb_private_info), GFP_KERNEL);
 	if (!uspi)
 		goto failed;
@@ -488,7 +497,7 @@
 	   this but as I don't know which I'll let those in the know loosen
 	   the rules */
 	   
-	switch (sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) {
+	switch (sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) {
 	case UFS_MOUNT_UFSTYPE_44BSD:
 		UFSD(("ufstype=44bsd\n"))
 		uspi->s_fsize = block_size = 512;
@@ -617,7 +626,7 @@
 		case UFS_MAGIC_LFN:
 	        case UFS_MAGIC_FEA:
 	        case UFS_MAGIC_4GB:
-			sb->u.ufs_sb.s_bytesex = BYTESEX_LE;
+			sbi->s_bytesex = BYTESEX_LE;
 			goto magic_found;
 	}
 	switch (__constant_be32_to_cpu(usb3->fs_magic)) {
@@ -625,13 +634,13 @@
 		case UFS_MAGIC_LFN:
 	        case UFS_MAGIC_FEA:
 	        case UFS_MAGIC_4GB:
-			sb->u.ufs_sb.s_bytesex = BYTESEX_BE;
+			sbi->s_bytesex = BYTESEX_BE;
 			goto magic_found;
 	}
 
-	if ((((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP) 
-	  || ((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP_CD) 
-	  || ((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_OPENSTEP)) 
+	if ((((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP) 
+	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP_CD) 
+	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_OPENSTEP)) 
 	  && uspi->s_sbbase < 256) {
 		ubh_brelse_uspi(uspi);
 		ubh = NULL;
@@ -783,12 +792,12 @@
 	uspi->s_bpf = uspi->s_fsize << 3;
 	uspi->s_bpfshift = uspi->s_fshift + 3;
 	uspi->s_bpfmask = uspi->s_bpf - 1;
-	if ((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) ==
+	if ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) ==
 	    UFS_MOUNT_UFSTYPE_44BSD)
 		uspi->s_maxsymlinklen =
 		    fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_maxsymlinklen);
 	
-	sb->u.ufs_sb.s_flags = flags;
+	sbi->s_flags = flags;
 
 	inode = iget(sb, UFS_ROOTINO);
 	if (!inode || is_bad_inode(inode))
@@ -813,8 +822,14 @@
 failed:
 	if (ubh) ubh_brelse_uspi (uspi);
 	if (uspi) kfree (uspi);
+	if (sbi) kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	UFSD(("EXIT (FAILED)\n"))
 	return -EINVAL;
+
+failed_nomem:
+	UFSD(("EXIT (NOMEM)\n"))
+	return -ENOMEM;
 }
 
 void ufs_write_super (struct super_block * sb) {
@@ -824,8 +839,8 @@
 	unsigned flags;
 
 	UFSD(("ENTER\n"))
-	flags = sb->u.ufs_sb.s_flags;
-	uspi = sb->u.ufs_sb.s_uspi;
+	flags = UFS_SB(sb)->s_flags;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	usb3 = ubh_get_usb_third(USPI_UBH);
 
@@ -843,17 +858,17 @@
 
 void ufs_put_super (struct super_block * sb)
 {
-	struct ufs_sb_private_info * uspi;
+	struct ufs_sb_info * sbi = UFS_SB(sb);
 		
 	UFSD(("ENTER\n"))
 
-	uspi = sb->u.ufs_sb.s_uspi;
-
 	if (!(sb->s_flags & MS_RDONLY))
 		ufs_put_cylinder_structures (sb);
 	
-	ubh_brelse_uspi (uspi);
-	kfree (sb->u.ufs_sb.s_uspi);
+	ubh_brelse_uspi (sbi->s_uspi);
+	kfree (sbi->s_uspi);
+	kfree (sbi);
+	sb->u.generic_sbp = NULL;
 	return;
 }
 
@@ -866,8 +881,8 @@
 	unsigned new_mount_opt, ufstype;
 	unsigned flags;
 	
-	uspi = sb->u.ufs_sb.s_uspi;
-	flags = sb->u.ufs_sb.s_flags;
+	uspi = UFS_SB(sb)->s_uspi;
+	flags = UFS_SB(sb)->s_flags;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	usb3 = ubh_get_usb_third(USPI_UBH);
 	
@@ -875,7 +890,7 @@
 	 * Allow the "check" option to be passed as a remount option.
 	 * It is not possible to change ufstype option during remount
 	 */
-	ufstype = sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE;
+	ufstype = UFS_SB(sb)->s_mount_opt & UFS_MOUNT_UFSTYPE;
 	new_mount_opt = 0;
 	ufs_set_opt (new_mount_opt, ONERROR_LOCK);
 	if (!ufs_parse_options (data, &new_mount_opt))
@@ -889,7 +904,7 @@
 	}
 
 	if ((*mount_flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY)) {
-		sb->u.ufs_sb.s_mount_opt = new_mount_opt;
+		UFS_SB(sb)->s_mount_opt = new_mount_opt;
 		return 0;
 	}
 	
@@ -929,7 +944,7 @@
 		sb->s_flags &= ~MS_RDONLY;
 #endif
 	}
-	sb->u.ufs_sb.s_mount_opt = new_mount_opt;
+	UFS_SB(sb)->s_mount_opt = new_mount_opt;
 	return 0;
 }
 
@@ -938,7 +953,7 @@
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	
 	buf->f_type = UFS_MAGIC;
diff -urN linux-2.5.7-bg1/fs/ufs/swab.h linux-2.5.7-bg2/fs/ufs/swab.h
--- linux-2.5.7-bg1/fs/ufs/swab.h	Thu Mar  7 21:18:58 2002
+++ linux-2.5.7-bg2/fs/ufs/swab.h	Wed Mar 27 20:18:33 2002
@@ -25,7 +25,7 @@
 static __inline u64
 fs64_to_cpu(struct super_block *sbp, u64 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return le64_to_cpu(n);
 	else
 		return be64_to_cpu(n);
@@ -34,7 +34,7 @@
 static __inline u64
 cpu_to_fs64(struct super_block *sbp, u64 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return cpu_to_le64(n);
 	else
 		return cpu_to_be64(n);
@@ -43,7 +43,7 @@
 static __inline u32
 fs64_add(struct super_block *sbp, u32 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le64(le64_to_cpu(*n)+d);
 	else
 		return *n = cpu_to_be64(be64_to_cpu(*n)+d);
@@ -52,7 +52,7 @@
 static __inline u32
 fs64_sub(struct super_block *sbp, u32 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le64(le64_to_cpu(*n)-d);
 	else
 		return *n = cpu_to_be64(be64_to_cpu(*n)-d);
@@ -61,7 +61,7 @@
 static __inline u32
 fs32_to_cpu(struct super_block *sbp, u32 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return le32_to_cpu(n);
 	else
 		return be32_to_cpu(n);
@@ -70,7 +70,7 @@
 static __inline u32
 cpu_to_fs32(struct super_block *sbp, u32 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return cpu_to_le32(n);
 	else
 		return cpu_to_be32(n);
@@ -79,7 +79,7 @@
 static __inline u32
 fs32_add(struct super_block *sbp, u32 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le32(le32_to_cpu(*n)+d);
 	else
 		return *n = cpu_to_be32(be32_to_cpu(*n)+d);
@@ -88,7 +88,7 @@
 static __inline u32
 fs32_sub(struct super_block *sbp, u32 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le32(le32_to_cpu(*n)-d);
 	else
 		return *n = cpu_to_be32(be32_to_cpu(*n)-d);
@@ -97,7 +97,7 @@
 static __inline u16
 fs16_to_cpu(struct super_block *sbp, u16 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return le16_to_cpu(n);
 	else
 		return be16_to_cpu(n);
@@ -106,7 +106,7 @@
 static __inline u16
 cpu_to_fs16(struct super_block *sbp, u16 n)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return cpu_to_le16(n);
 	else
 		return cpu_to_be16(n);
@@ -115,7 +115,7 @@
 static __inline u16
 fs16_add(struct super_block *sbp, u16 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le16(le16_to_cpu(*n)+d);
 	else
 		return *n = cpu_to_be16(be16_to_cpu(*n)+d);
@@ -124,7 +124,7 @@
 static __inline u16
 fs16_sub(struct super_block *sbp, u16 *n, int d)
 {
-	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+	if (UFS_SB(sbp)->s_bytesex == BYTESEX_LE)
 		return *n = cpu_to_le16(le16_to_cpu(*n)-d);
 	else
 		return *n = cpu_to_be16(be16_to_cpu(*n)-d);
diff -urN linux-2.5.7-bg1/fs/ufs/truncate.c linux-2.5.7-bg2/fs/ufs/truncate.c
--- linux-2.5.7-bg1/fs/ufs/truncate.c	Thu Mar  7 21:18:31 2002
+++ linux-2.5.7-bg2/fs/ufs/truncate.c	Wed Mar 27 20:18:33 2002
@@ -81,7 +81,7 @@
 	UFSD(("ENTER\n"))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	
 	frag_to_free = 0;
 	free_count = 0;
@@ -211,7 +211,7 @@
 	UFSD(("ENTER\n"))
 		
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 
 	frag_to_free = 0;
 	free_count = 0;
@@ -305,7 +305,7 @@
 	UFSD(("ENTER\n"))
 	
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 
 	dindirect_block = (DIRECT_BLOCK > offset) 
 		? ((DIRECT_BLOCK - offset) >> uspi->s_apbshift) : 0;
@@ -373,7 +373,7 @@
 	UFSD(("ENTER\n"))
 
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	retry = 0;
 	
 	tindirect_block = (DIRECT_BLOCK > (UFS_NDADDR + uspi->s_apb + uspi->s_2apb))
@@ -434,7 +434,7 @@
 	
 	UFSD(("ENTER\n"))
 	sb = inode->i_sb;
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
 		return;
diff -urN linux-2.5.7-bg1/fs/ufs/util.h linux-2.5.7-bg2/fs/ufs/util.h
--- linux-2.5.7-bg1/fs/ufs/util.h	Thu Mar  7 21:18:33 2002
+++ linux-2.5.7-bg2/fs/ufs/util.h	Wed Mar 27 20:28:51 2002
@@ -30,7 +30,7 @@
 ufs_get_fs_state(struct super_block *sb, struct ufs_super_block_first *usb1,
 		 struct ufs_super_block_third *usb3)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
 		return fs32_to_cpu(sb, usb3->fs_u2.fs_sun.fs_state);
 	case UFS_ST_SUNx86:
@@ -45,7 +45,7 @@
 ufs_set_fs_state(struct super_block *sb, struct ufs_super_block_first *usb1,
 		 struct ufs_super_block_third *usb3, s32 value)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
 		usb3->fs_u2.fs_sun.fs_state = cpu_to_fs32(sb, value);
 		break;
@@ -62,7 +62,7 @@
 ufs_get_fs_npsect(struct super_block *sb, struct ufs_super_block_first *usb1,
 		  struct ufs_super_block_third *usb3)
 {
-	if ((sb->u.ufs_sb.s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
+	if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
 		return fs32_to_cpu(sb, usb3->fs_u2.fs_sunx86.fs_npsect);
 	else
 		return fs32_to_cpu(sb, usb1->fs_u1.fs_sun.fs_npsect);
@@ -73,7 +73,7 @@
 {
 	u64 tmp;
 
-	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
 		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qbmask[0];
 		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qbmask[1];
@@ -96,7 +96,7 @@
 {
 	u64 tmp;
 
-	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
 	case UFS_ST_SUN:
 		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qfmask[0];
 		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qfmask[1];
@@ -117,7 +117,7 @@
 static inline u16
 ufs_get_de_namlen(struct super_block *sb, struct ufs_dir_entry *de)
 {
-	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) == UFS_DE_OLD)
+	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) == UFS_DE_OLD)
 		return fs16_to_cpu(sb, de->d_u.d_namlen);
 	else
 		return de->d_u.d_44.d_namlen; /* XXX this seems wrong */
@@ -126,7 +126,7 @@
 static inline void
 ufs_set_de_namlen(struct super_block *sb, struct ufs_dir_entry *de, u16 value)
 {
-	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) == UFS_DE_OLD)
+	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) == UFS_DE_OLD)
 		de->d_u.d_namlen = cpu_to_fs16(sb, value);
 	else
 		de->d_u.d_44.d_namlen = value; /* XXX this seems wrong */
@@ -135,7 +135,7 @@
 static inline void
 ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 {
-	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
+	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
 	/*
@@ -171,7 +171,7 @@
 static inline u32
 ufs_get_inode_uid(struct super_block *sb, struct ufs_inode *inode)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
 	case UFS_UID_EFT:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_uid);
 	case UFS_UID_44BSD:
@@ -184,7 +184,7 @@
 static inline void
 ufs_set_inode_uid(struct super_block *sb, struct ufs_inode *inode, u32 value)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
 	case UFS_UID_EFT:
 		inode->ui_u3.ui_sun.ui_uid = cpu_to_fs32(sb, value);
 		break;
@@ -198,7 +198,7 @@
 static inline u32
 ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
 	case UFS_UID_EFT:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
 	case UFS_UID_44BSD:
@@ -211,7 +211,7 @@
 static inline void
 ufs_set_inode_gid(struct super_block *sb, struct ufs_inode *inode, u32 value)
 {
-	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	switch (UFS_SB(sb)->s_flags & UFS_UID_MASK) {
 	case UFS_UID_EFT:
 		inode->ui_u3.ui_sun.ui_gid = cpu_to_fs32(sb, value);
 		break;
@@ -480,7 +480,7 @@
 	struct ufs_sb_private_info * uspi;
 	unsigned fragsize, pos;
 	
-	uspi = sb->u.ufs_sb.s_uspi;
+	uspi = UFS_SB(sb)->s_uspi;
 	
 	fragsize = 0;
 	for (pos = 0; pos < uspi->s_fpb; pos++) {
diff -urN linux-2.5.7-bg1/include/linux/fs.h linux-2.5.7-bg2/include/linux/fs.h
--- linux-2.5.7-bg1/include/linux/fs.h	Wed Mar 27 20:14:39 2002
+++ linux-2.5.7-bg2/include/linux/fs.h	Wed Mar 27 20:27:58 2002
@@ -648,7 +648,6 @@
 #include <linux/hpfs_fs_sb.h>
 #include <linux/ntfs_fs_sb.h>
 #include <linux/sysv_fs_sb.h>
-#include <linux/ufs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
@@ -691,7 +690,6 @@
 		struct hpfs_sb_info	hpfs_sb;
 		struct ntfs_sb_info	ntfs_sb;
 		struct sysv_sb_info	sysv_sb;
-		struct ufs_sb_info	ufs_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		struct bfs_sb_info	bfs_sb;
diff -urN linux-2.5.7-bg1/include/linux/ufs_fs.h linux-2.5.7-bg2/include/linux/ufs_fs.h
--- linux-2.5.7-bg1/include/linux/ufs_fs.h	Thu Mar  7 21:18:19 2002
+++ linux-2.5.7-bg2/include/linux/ufs_fs.h	Wed Mar 27 20:28:51 2002
@@ -32,6 +32,9 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 
+#include <linux/ufs_fs_i.h>
+#include <linux/ufs_fs_sb.h>
+
 #define UFS_BBLOCK 0
 #define UFS_BBSIZE 8192
 #define UFS_SBLOCK 8192
@@ -397,7 +400,7 @@
  * Convert cylinder group to base address of its global summary info.
  */
 #define fs_cs(indx) \
-	u.ufs_sb.s_csp[(indx) >> uspi->s_csshift][(indx) & ~uspi->s_csmask]
+	s_csp[(indx) >> uspi->s_csshift][(indx) & ~uspi->s_csmask]
 
 /*
  * Cylinder group block for a file system.
@@ -779,7 +782,10 @@
 /* truncate.c */
 extern void ufs_truncate (struct inode *);
 
-#include <linux/ufs_fs_i.h>
+static inline struct ufs_sb_info *UFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 static inline struct ufs_inode_info *UFS_I(struct inode *inode)
 {

--------------020000000008080005040403--

