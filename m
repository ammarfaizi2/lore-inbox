Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRJ2Qkc>; Mon, 29 Oct 2001 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJ2QkR>; Mon, 29 Oct 2001 11:40:17 -0500
Received: from ns.caldera.de ([212.34.180.1]:18305 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276255AbRJ2Qjg>;
	Mon, 29 Oct 2001 11:39:36 -0500
Date: Mon, 29 Oct 2001 17:39:50 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: alan@redhat.com, viro@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs byteswapping cleanup
Message-ID: <20011029173950.D24272@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>, alan@redhat.com,
	viro@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch cleans up ufs to use sane inlines
for byteswapping instead of the current macros that
use variables from the enviroment (yuck!).

Older version already was in -ac.

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/balloc.c linux/fs/ufs/balloc.c
--- ../master/linux-2.4.14-pre3/fs/ufs/balloc.c	Wed Oct 10 10:34:16 2001
+++ linux/fs/ufs/balloc.c	Mon Oct 29 16:46:54 2001
@@ -44,11 +44,9 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, bit, end_bit, bbase, blkmap, i, blkno, cylno;
-	unsigned swab;
 	
 	sb = inode->i_sb;
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
@@ -69,7 +67,7 @@
 	if (!ucpi) 
 		goto failed;
 	ucg = ubh_get_ucg (UCPI_UBH);
-	if (!ufs_cg_chkmagic (ucg)) {
+	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_free_fragments", "internal error, bad magic number on cg %u", cgno);
 		goto failed;
 	}
@@ -86,9 +84,11 @@
 	}
 	
 	DQUOT_FREE_BLOCK (inode, count);
-	ADD_SWAB32(ucg->cg_cs.cs_nffree, count);
-	ADD_SWAB32(usb1->fs_cstotal.cs_nffree, count);
-	ADD_SWAB32(sb->fs_cs(cgno).cs_nffree, count);
+
+	
+	fs32_add(sb, &ucg->cg_cs.cs_nffree, count);
+	fs32_add(sb, &usb1->fs_cstotal.cs_nffree, count);
+	fs32_add(sb, &sb->fs_cs(cgno).cs_nffree, count);
 	blkmap = ubh_blkmap (UCPI_UBH, ucpi->c_freeoff, bbase);
 	ufs_fragacct(sb, blkmap, ucg->cg_frsum, 1);
 
@@ -97,17 +97,17 @@
 	 */
 	blkno = ufs_fragstoblks (bbase);
 	if (ubh_isblockset(UCPI_UBH, ucpi->c_freeoff, blkno)) {
-		SUB_SWAB32(ucg->cg_cs.cs_nffree, uspi->s_fpb);
-		SUB_SWAB32(usb1->fs_cstotal.cs_nffree, uspi->s_fpb);
-		SUB_SWAB32(sb->fs_cs(cgno).cs_nffree, uspi->s_fpb);
+		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
+		fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, uspi->s_fpb);
+		fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, uspi->s_fpb);
 		if ((sb->u.ufs_sb.s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
-		INC_SWAB32(ucg->cg_cs.cs_nbfree);
-		INC_SWAB32(usb1->fs_cstotal.cs_nbfree);
-		INC_SWAB32(sb->fs_cs(cgno).cs_nbfree);
+		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
+		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+		fs32_add(sb, &sb->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno (bbase);
-		INC_SWAB16(ubh_cg_blks (ucpi, cylno, ufs_cbtorpos(bbase)));
-		INC_SWAB32(ubh_cg_blktot (ucpi, cylno));
+		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(bbase)), 1);
+		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	}
 	
 	ubh_mark_buffer_dirty (USPI_UBH);
@@ -138,11 +138,9 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned overflow, cgno, bit, end_bit, blkno, i, cylno;
-	unsigned swab;
 	
 	sb = inode->i_sb;
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
@@ -174,7 +172,7 @@
 	if (!ucpi) 
 		goto failed;
 	ucg = ubh_get_ucg (UCPI_UBH);
-	if (!ufs_cg_chkmagic (ucg)) {
+	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_free_blocks", "internal error, bad magic number on cg %u", cgno);
 		goto failed;
 	}
@@ -188,12 +186,13 @@
 		if ((sb->u.ufs_sb.s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
 		DQUOT_FREE_BLOCK(inode, uspi->s_fpb);
-		INC_SWAB32(ucg->cg_cs.cs_nbfree);
-		INC_SWAB32(usb1->fs_cstotal.cs_nbfree);
-		INC_SWAB32(sb->fs_cs(cgno).cs_nbfree);
+
+		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
+		fs32_add(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+		fs32_add(sb, &sb->fs_cs(cgno).cs_nbfree, 1);
 		cylno = ufs_cbtocylno(i);
-		INC_SWAB16(ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(i)));
-		INC_SWAB32(ubh_cg_blktot(ucpi, cylno));
+		fs16_add(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(i)), 1);
+		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	}
 
 	ubh_mark_buffer_dirty (USPI_UBH);
@@ -243,19 +242,17 @@
 	struct ufs_super_block_first * usb1;
 	struct buffer_head * bh;
 	unsigned cgno, oldcount, newcount, tmp, request, i, result;
-	unsigned swab;
 	
 	UFSD(("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count))
 	
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	*err = -ENOSPC;
 
 	lock_super (sb);
 	
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (count + ufs_fragnum(fragment) > uspi->s_fpb) {
 		ufs_warning (sb, "ufs_new_fragments", "internal warning"
 			" fragment %u, count %u", fragment, count);
@@ -310,7 +307,7 @@
 	if (oldcount == 0) {
 		result = ufs_alloc_fragments (inode, cgno, goal, count, err);
 		if (result) {
-			*p = SWAB32(result);
+			*p = cpu_to_fs32(sb, result);
 			*err = 0;
 			inode->i_blocks += count << uspi->s_nspfshift;
 			inode->u.ufs_i.i_lastfrag = max_t(u32, inode->u.ufs_i.i_lastfrag, fragment + count);
@@ -338,23 +335,23 @@
 	/*
 	 * allocate new block and move data
 	 */
-	switch (SWAB32(usb1->fs_optim)) {
+	switch (fs32_to_cpu(sb, usb1->fs_optim)) {
 	    case UFS_OPTSPACE:
 		request = newcount;
-		if (uspi->s_minfree < 5 || SWAB32(usb1->fs_cstotal.cs_nffree) 
+		if (uspi->s_minfree < 5 || fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree) 
 		    > uspi->s_dsize * uspi->s_minfree / (2 * 100) )
 			break;
-		usb1->fs_optim = SWAB32(UFS_OPTTIME);
+		usb1->fs_optim = cpu_to_fs32(sb, UFS_OPTTIME);
 		break;
 	    default:
-		usb1->fs_optim = SWAB32(UFS_OPTTIME);
+		usb1->fs_optim = cpu_to_fs32(sb, UFS_OPTTIME);
 	
 	    case UFS_OPTTIME:
 		request = uspi->s_fpb;
-		if (SWAB32(usb1->fs_cstotal.cs_nffree) < uspi->s_dsize *
+		if (fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree) < uspi->s_dsize *
 		    (uspi->s_minfree - 2) / 100)
 			break;
-		usb1->fs_optim = SWAB32(UFS_OPTSPACE);
+		usb1->fs_optim = cpu_to_fs32(sb, UFS_OPTTIME);
 		break;
 	}
 	result = ufs_alloc_fragments (inode, cgno, goal, request, err);
@@ -378,7 +375,7 @@
 				return 0;
 			}
 		}
-		*p = SWAB32(result);
+		*p = cpu_to_fs32(sb, result);
 		*err = 0;
 		inode->i_blocks += count << uspi->s_nspfshift;
 		inode->u.ufs_i.i_lastfrag = max_t(u32, inode->u.ufs_i.i_lastfrag, fragment + count);
@@ -405,12 +402,10 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, fragno, fragoff, count, fragsize, i;
-	unsigned swab;
 	
 	UFSD(("ENTER, fragment %u, oldcount %u, newcount %u\n", fragment, oldcount, newcount))
 	
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	count = newcount - oldcount;
@@ -424,7 +419,7 @@
 	if (!ucpi)
 		return 0;
 	ucg = ubh_get_ucg (UCPI_UBH);
-	if (!ufs_cg_chkmagic(ucg)) {
+	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_add_fragments",
 			"internal error, bad magic number on cg %u", cgno);
 		return 0;
@@ -438,26 +433,27 @@
 	/*
 	 * Block can be extended
 	 */
-	ucg->cg_time = SWAB32(CURRENT_TIME);
+	ucg->cg_time = cpu_to_fs32(sb, CURRENT_TIME);
 	for (i = newcount; i < (uspi->s_fpb - fragoff); i++)
 		if (ubh_isclr (UCPI_UBH, ucpi->c_freeoff, fragno + i))
 			break;
 	fragsize = i - oldcount;
-	if (!SWAB32(ucg->cg_frsum[fragsize]))
+	if (!fs32_to_cpu(sb, ucg->cg_frsum[fragsize]))
 		ufs_panic (sb, "ufs_add_fragments",
 			"internal error or corrupted bitmap on cg %u", cgno);
-	DEC_SWAB32(ucg->cg_frsum[fragsize]);
+	fs32_sub(sb, &ucg->cg_frsum[fragsize], 1);
 	if (fragsize != count)
-		INC_SWAB32(ucg->cg_frsum[fragsize - count]);
+		fs32_add(sb, &ucg->cg_frsum[fragsize - count], 1);
 	for (i = oldcount; i < newcount; i++)
 		ubh_clrbit (UCPI_UBH, ucpi->c_freeoff, fragno + i);
 	if(DQUOT_ALLOC_BLOCK(inode, count)) {
 		*err = -EDQUOT;
 		return 0;
 	}
-	SUB_SWAB32(ucg->cg_cs.cs_nffree, count);
-	SUB_SWAB32(sb->fs_cs(cgno).cs_nffree, count);
-	SUB_SWAB32(usb1->fs_cstotal.cs_nffree, count);
+
+	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
+	fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, count);
+	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
 	
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
@@ -474,10 +470,10 @@
 
 #define UFS_TEST_FREE_SPACE_CG \
 	ucg = (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[cgno]->b_data; \
-	if (SWAB32(ucg->cg_cs.cs_nbfree)) \
+	if (fs32_to_cpu(sb, ucg->cg_cs.cs_nbfree)) \
 		goto cg_found; \
 	for (k = count; k < uspi->s_fpb; k++) \
-		if (SWAB32(ucg->cg_frsum[k])) \
+		if (fs32_to_cpu(sb, ucg->cg_frsum[k])) \
 			goto cg_found; 
 
 unsigned ufs_alloc_fragments (struct inode * inode, unsigned cgno,
@@ -489,12 +485,10 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned oldcg, i, j, k, result, allocsize;
-	unsigned swab;
 	
 	UFSD(("ENTER, ino %lu, cgno %u, goal %u, count %u\n", inode->i_ino, cgno, goal, count))
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	oldcg = cgno;
@@ -534,10 +528,10 @@
 	if (!ucpi)
 		return 0;
 	ucg = ubh_get_ucg (UCPI_UBH);
-	if (!ufs_cg_chkmagic(ucg)) 
+	if (!ufs_cg_chkmagic(sb, ucg)) 
 		ufs_panic (sb, "ufs_alloc_fragments",
 			"internal error, bad magic number on cg %u", cgno);
-	ucg->cg_time = SWAB32(CURRENT_TIME);
+	ucg->cg_time = cpu_to_fs32(sb, CURRENT_TIME);
 
 	if (count == uspi->s_fpb) {
 		result = ufs_alloccg_block (inode, ucpi, goal, err);
@@ -547,7 +541,7 @@
 	}
 
 	for (allocsize = count; allocsize < uspi->s_fpb; allocsize++)
-		if (SWAB32(ucg->cg_frsum[allocsize]) != 0)
+		if (fs32_to_cpu(sb, ucg->cg_frsum[allocsize]) != 0)
 			break;
 	
 	if (allocsize == uspi->s_fpb) {
@@ -559,10 +553,11 @@
 			ubh_setbit (UCPI_UBH, ucpi->c_freeoff, goal + i);
 		i = uspi->s_fpb - count;
 		DQUOT_FREE_BLOCK(inode, i);
-		ADD_SWAB32(ucg->cg_cs.cs_nffree, i);
-		ADD_SWAB32(usb1->fs_cstotal.cs_nffree, i);
-		ADD_SWAB32(sb->fs_cs(cgno).cs_nffree, i);
-		INC_SWAB32(ucg->cg_frsum[i]);
+
+		fs32_add(sb, &ucg->cg_cs.cs_nffree, i);
+		fs32_add(sb, &usb1->fs_cstotal.cs_nffree, i);
+		fs32_add(sb, &sb->fs_cs(cgno).cs_nffree, i);
+		fs32_add(sb, &ucg->cg_frsum[i], 1);
 		goto succed;
 	}
 
@@ -575,12 +570,14 @@
 	}
 	for (i = 0; i < count; i++)
 		ubh_clrbit (UCPI_UBH, ucpi->c_freeoff, result + i);
-	SUB_SWAB32(ucg->cg_cs.cs_nffree, count);
-	SUB_SWAB32(usb1->fs_cstotal.cs_nffree, count);
-	SUB_SWAB32(sb->fs_cs(cgno).cs_nffree, count);
-	DEC_SWAB32(ucg->cg_frsum[allocsize]);
+	
+	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
+	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
+	fs32_sub(sb, &sb->fs_cs(cgno).cs_nffree, count);
+	fs32_sub(sb, &ucg->cg_frsum[allocsize], 1);
+
 	if (count != allocsize)
-		INC_SWAB32(ucg->cg_frsum[allocsize - count]);
+		fs32_add(sb, &ucg->cg_frsum[allocsize - count], 1);
 
 succed:
 	ubh_mark_buffer_dirty (USPI_UBH);
@@ -604,12 +601,10 @@
 	struct ufs_super_block_first * usb1;
 	struct ufs_cylinder_group * ucg;
 	unsigned result, cylno, blkno;
-	unsigned swab;
 
 	UFSD(("ENTER, goal %u\n", goal))
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	ucg = ubh_get_ucg(UCPI_UBH);
@@ -643,12 +638,13 @@
 		*err = -EDQUOT;
 		return (unsigned)-1;
 	}
-	DEC_SWAB32(ucg->cg_cs.cs_nbfree);
-	DEC_SWAB32(usb1->fs_cstotal.cs_nbfree);
-	DEC_SWAB32(sb->fs_cs(ucpi->c_cgx).cs_nbfree);
+
+	fs32_sub(sb, &ucg->cg_cs.cs_nbfree, 1);
+	fs32_sub(sb, &usb1->fs_cstotal.cs_nbfree, 1);
+	fs32_sub(sb, &sb->fs_cs(ucpi->c_cgx).cs_nbfree, 1);
 	cylno = ufs_cbtocylno(result);
-	DEC_SWAB16(ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(result)));
-	DEC_SWAB32(ubh_cg_blktot(ucpi, cylno));
+	fs16_sub(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(result)), 1);
+	fs32_sub(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	
 	UFSD(("EXIT, result %u\n", result))
 
@@ -663,11 +659,9 @@
 	struct ufs_cylinder_group * ucg;
 	unsigned start, length, location, result;
 	unsigned possition, fragsize, blockmap, mask;
-	unsigned swab;
 	
 	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count))
 
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	ucg = ubh_get_ucg(UCPI_UBH);
@@ -733,12 +727,8 @@
 {
 	struct ufs_sb_private_info * uspi;
 	int i, start, end, forw, back;
-	unsigned swab;
-	
 	
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
-	
 	if (uspi->s_contigsumsize <= 0)
 		return;
 
@@ -778,11 +768,11 @@
 	i = back + forw + 1;
 	if (i > uspi->s_contigsumsize)
 		i = uspi->s_contigsumsize;
-	ADD_SWAB32(*((u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (i << 2))), cnt);
+	fs32_add(sb, (u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (i << 2)), cnt);
 	if (back > 0)
-		SUB_SWAB32(*((u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (back << 2))), cnt);
+		fs32_sub(sb, (u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (back << 2)), cnt);
 	if (forw > 0)
-		SUB_SWAB32(*((u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (forw << 2))), cnt);
+		fs32_sub(sb, (u32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (forw << 2)), cnt);
 }
 
 
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/cylinder.c linux/fs/ufs/cylinder.c
--- ../master/linux-2.4.14-pre3/fs/ufs/cylinder.c	Tue Sep  5 23:07:30 2000
+++ linux/fs/ufs/cylinder.c	Mon Oct 29 16:46:54 2001
@@ -41,10 +41,8 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned i, j;
-	unsigned swab;
 
 	UFSD(("ENTER, cgno %u, bitmap_nr %u\n", cgno, bitmap_nr))
-	swab = sb->u.ufs_sb.s_swab;	
 	uspi = sb->u.ufs_sb.s_uspi;
 	ucpi = sb->u.ufs_sb.s_ucpi[bitmap_nr];
 	ucg = (struct ufs_cylinder_group *)sb->u.ufs_sb.s_ucg[cgno]->b_data;
@@ -60,21 +58,21 @@
 			goto failed;
 	sb->u.ufs_sb.s_cgno[bitmap_nr] = cgno;
 			
-	ucpi->c_cgx = SWAB32(ucg->cg_cgx);
-	ucpi->c_ncyl = SWAB16(ucg->cg_ncyl);
-	ucpi->c_niblk = SWAB16(ucg->cg_niblk);
-	ucpi->c_ndblk = SWAB32(ucg->cg_ndblk);
-	ucpi->c_rotor = SWAB32(ucg->cg_rotor);
-	ucpi->c_frotor = SWAB32(ucg->cg_frotor);
-	ucpi->c_irotor = SWAB32(ucg->cg_irotor);
-	ucpi->c_btotoff = SWAB32(ucg->cg_btotoff);
-	ucpi->c_boff = SWAB32(ucg->cg_boff);
-	ucpi->c_iusedoff = SWAB32(ucg->cg_iusedoff);
-	ucpi->c_freeoff = SWAB32(ucg->cg_freeoff);
-	ucpi->c_nextfreeoff = SWAB32(ucg->cg_nextfreeoff);
-	ucpi->c_clustersumoff = SWAB32(ucg->cg_u.cg_44.cg_clustersumoff);
-	ucpi->c_clusteroff = SWAB32(ucg->cg_u.cg_44.cg_clusteroff);
-	ucpi->c_nclusterblks = SWAB32(ucg->cg_u.cg_44.cg_nclusterblks);
+	ucpi->c_cgx	= fs32_to_cpu(sb, ucg->cg_cgx);
+	ucpi->c_ncyl	= fs16_to_cpu(sb, ucg->cg_ncyl);
+	ucpi->c_niblk	= fs16_to_cpu(sb, ucg->cg_niblk);
+	ucpi->c_ndblk	= fs32_to_cpu(sb, ucg->cg_ndblk);
+	ucpi->c_rotor	= fs32_to_cpu(sb, ucg->cg_rotor);
+	ucpi->c_frotor	= fs32_to_cpu(sb, ucg->cg_frotor);
+	ucpi->c_irotor	= fs32_to_cpu(sb, ucg->cg_irotor);
+	ucpi->c_btotoff	= fs32_to_cpu(sb, ucg->cg_btotoff);
+	ucpi->c_boff	= fs32_to_cpu(sb, ucg->cg_boff);
+	ucpi->c_iusedoff = fs32_to_cpu(sb, ucg->cg_iusedoff);
+	ucpi->c_freeoff	= fs32_to_cpu(sb, ucg->cg_freeoff);
+	ucpi->c_nextfreeoff = fs32_to_cpu(sb, ucg->cg_nextfreeoff);
+	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
+	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
+	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
 	UFSD(("EXIT\n"))
 	return;	
 	
@@ -95,11 +93,9 @@
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned i;
-	unsigned swab;
 
 	UFSD(("ENTER, bitmap_nr %u\n", bitmap_nr))
 
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	if (sb->u.ufs_sb.s_cgno[bitmap_nr] == UFS_CGNO_EMPTY) {
 		UFSD(("EXIT\n"))
@@ -116,9 +112,9 @@
 	 * rotor is not so important data, so we put it to disk 
 	 * at the end of working with cylinder
 	 */
-	ucg->cg_rotor = SWAB32(ucpi->c_rotor);
-	ucg->cg_frotor = SWAB32(ucpi->c_frotor);
-	ucg->cg_irotor = SWAB32(ucpi->c_irotor);
+	ucg->cg_rotor = cpu_to_fs32(sb, ucpi->c_rotor);
+	ucg->cg_frotor = cpu_to_fs32(sb, ucpi->c_frotor);
+	ucg->cg_irotor = cpu_to_fs32(sb, ucpi->c_irotor);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	for (i = 1; i < UCPI_UBH->count; i++) {
 		brelse (UCPI_UBH->bh[i]);
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/dir.c linux/fs/ufs/dir.c
--- ../master/linux-2.4.14-pre3/fs/ufs/dir.c	Thu Oct 25 19:05:47 2001
+++ linux/fs/ufs/dir.c	Mon Oct 29 16:46:54 2001
@@ -29,15 +29,17 @@
 #define UFSD(x)
 #endif
 
+
+
 /*
  * NOTE! unlike strncmp, ufs_match returns 1 for success, 0 for failure.
  *
  * len <= UFS_MAXNAMLEN and de != NULL are guaranteed by caller.
  */
-static inline int ufs_match (int len, const char * const name,
-	struct ufs_dir_entry * de, unsigned flags, unsigned swab)
+static inline int ufs_match(struct super_block *sb, int len,
+		const char * const name, struct ufs_dir_entry * de)
 {
-	if (len != ufs_get_de_namlen(de))
+	if (len != ufs_get_de_namlen(sb, de))
 		return 0;
 	if (!de->d_ino)
 		return 0;
@@ -58,10 +60,9 @@
 	struct ufs_dir_entry * de;
 	struct super_block * sb;
 	int de_reclen;
-	unsigned flags, swab;
+	unsigned flags;
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	flags = sb->u.ufs_sb.s_flags;
 
 	UFSD(("ENTER, ino %lu  f_pos %lu\n", inode->i_ino, (unsigned long) filp->f_pos))
@@ -96,7 +97,7 @@
 				 * least that it is non-zero.  A
 				 * failure will be detected in the
 				 * dirent test below. */
-				de_reclen = SWAB16(de->d_reclen);
+				de_reclen = fs16_to_cpu(sb, de->d_reclen);
 				if (de_reclen < 1)
 					break;
 				i += de_reclen;
@@ -111,8 +112,7 @@
 		       && offset < sb->s_blocksize) {
 			de = (struct ufs_dir_entry *) (bh->b_data + offset);
 			/* XXX - put in a real ufs_check_dir_entry() */
-			if ((de->d_reclen == 0) || (ufs_get_de_namlen(de) == 0)) {
-			/* SWAB16() was unneeded -- compare to 0 */
+			if ((de->d_reclen == 0) || (ufs_get_de_namlen(sb, de) == 0)) {
 				filp->f_pos = (filp->f_pos &
 				              (sb->s_blocksize - 1)) +
 				               sb->s_blocksize;
@@ -129,9 +129,8 @@
 				brelse (bh);
 				return stored;
 			}
-			offset += SWAB16(de->d_reclen);
+			offset += fs16_to_cpu(sb, de->d_reclen);
 			if (de->d_ino) {
-			/* SWAB16() was unneeded -- compare to 0 */
 				/* We might block in the next section
 				 * if the data destination is
 				 * currently swapped out.  So, use a
@@ -141,19 +140,22 @@
 				unsigned long version = filp->f_version;
 				unsigned char d_type = DT_UNKNOWN;
 
-				UFSD(("filldir(%s,%u)\n", de->d_name, SWAB32(de->d_ino)))
-				UFSD(("namlen %u\n", ufs_get_de_namlen(de)))
+				UFSD(("filldir(%s,%u)\n", de->d_name,
+							fs32_to_cpu(sb, de->d_ino)))
+				UFSD(("namlen %u\n", ufs_get_de_namlen(sb, de)))
+
 				if ((flags & UFS_DE_MASK) == UFS_DE_44BSD)
 					d_type = de->d_u.d_44.d_type;
-				error = filldir(dirent, de->d_name, ufs_get_de_namlen(de),
-						filp->f_pos, SWAB32(de->d_ino), d_type);
+				error = filldir(dirent, de->d_name,
+						ufs_get_de_namlen(sb, de), filp->f_pos,
+						fs32_to_cpu(sb, de->d_ino), d_type);
 				if (error)
 					break;
 				if (version != filp->f_version)
 					goto revalidate;
 				stored ++;
 			}
-			filp->f_pos += SWAB16(de->d_reclen);
+			filp->f_pos += fs16_to_cpu(sb, de->d_reclen);
 		}
 		offset = 0;
 		brelse (bh);
@@ -186,7 +188,6 @@
 	struct buffer_head * bh_read[NAMEI_RA_SIZE];
 	unsigned long offset;
 	int block, toread, i, err;
-	unsigned flags, swab;
 	struct inode *dir = dentry->d_parent->d_inode;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
@@ -196,8 +197,6 @@
 	*res_bh = NULL;
 	
 	sb = dir->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 	
 	if (namelen > UFS_MAXNAMLEN)
 		return NULL;
@@ -248,7 +247,7 @@
 			int de_len;
 
 			if ((char *) de + namelen <= dlimit &&
-			    ufs_match (namelen, name, de, flags, swab)) {
+			    ufs_match(sb, namelen, name, de)) {
 				/* found a match -
 				just to be sure, do a full check */
 				if (!ufs_check_dir_entry("ufs_find_entry",
@@ -262,7 +261,7 @@
 				return de;
 			}
                         /* prevent looping on a bad block */
-			de_len = SWAB16(de->d_reclen);
+			de_len = fs16_to_cpu(sb, de->d_reclen);
 			if (de_len <= 0)
 				goto failed;
 			offset += de_len;
@@ -292,31 +291,31 @@
 {
 	struct super_block * sb;
 	const char * error_msg;
-	unsigned flags, swab;
+	int rlen;
 	
 	sb = dir->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
+	rlen = fs16_to_cpu(sb, de->d_reclen);
 	error_msg = NULL;
 			
-	if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(1))
+	if (rlen < UFS_DIR_REC_LEN(1))
 		error_msg = "reclen is smaller than minimal";
-	else if (SWAB16(de->d_reclen) % 4 != 0)
+	else if (rlen % 4 != 0)
 		error_msg = "reclen % 4 != 0";
-	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
+	else if (rlen < UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)))
 		error_msg = "reclen is too small for namlen";
-	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
+	else if (dir && ((char *) de - bh->b_data) + rlen >
 		 dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
-	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
+	else if (dir && fs32_to_cpu(sb, de->d_ino) >
+		 (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
 		ufs_error (sb, function, "bad entry in directory #%lu, size %Lu: %s - "
 			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
 			    dir->i_ino, dir->i_size, error_msg, offset,
-			    (unsigned long) SWAB32(de->d_ino),
-			    SWAB16(de->d_reclen), ufs_get_de_namlen(de));
+			    (unsigned long)fs32_to_cpu(sb, de->d_ino),
+			    rlen, ufs_get_de_namlen(sb, de));
 	
 	return (error_msg == NULL ? 1 : 0);
 }
@@ -328,25 +327,22 @@
 	struct ufs_dir_entry *res = NULL;
 
 	if (bh) {
-		unsigned swab = dir->i_sb->u.ufs_sb.s_swab;
-
 		res = (struct ufs_dir_entry *) bh->b_data;
 		res = (struct ufs_dir_entry *)((char *)res +
-			SWAB16(res->d_reclen));
+			fs16_to_cpu(dir->i_sb, res->d_reclen));
 	}
 	*p = bh;
 	return res;
 }
 ino_t ufs_inode_by_name(struct inode * dir, struct dentry *dentry)
 {
-	unsigned swab = dir->i_sb->u.ufs_sb.s_swab;
 	ino_t res = 0;
 	struct ufs_dir_entry * de;
 	struct buffer_head *bh;
 
 	de = ufs_find_entry (dentry, &bh);
 	if (de) {
-		res = SWAB32(de->d_ino);
+		res = fs32_to_cpu(dir->i_sb, de->d_ino);
 		brelse(bh);
 	}
 	return res;
@@ -355,9 +351,8 @@
 void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 		struct buffer_head *bh, struct inode *inode)
 {
-	unsigned swab = dir->i_sb->u.ufs_sb.s_swab;
 	dir->i_version = ++event;
-	de->d_ino = SWAB32(inode->i_ino);
+	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	mark_buffer_dirty(bh);
 	if (IS_SYNC(dir)) {
 		ll_rw_block (WRITE, 1, &bh);
@@ -381,7 +376,6 @@
 	unsigned short rec_len;
 	struct buffer_head * bh;
 	struct ufs_dir_entry * de, * de1;
-	unsigned flags, swab;
 	struct inode *dir = dentry->d_parent->d_inode;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
@@ -390,8 +384,6 @@
 	UFSD(("ENTER, name %s, namelen %u\n", name, namelen))
 	
 	sb = dir->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 
 	if (!namelen)
@@ -420,9 +412,9 @@
 					return -ENOENT;
 				}
 				de = (struct ufs_dir_entry *) (bh->b_data + fragoff);
-				de->d_ino = SWAB32(0);
-				de->d_reclen = SWAB16(UFS_SECTOR_SIZE);
-				ufs_set_de_namlen(de,0);
+				de->d_ino = 0;
+				de->d_reclen = cpu_to_fs16(sb, UFS_SECTOR_SIZE);
+				ufs_set_de_namlen(sb, de, 0);
 				dir->i_size = offset + UFS_SECTOR_SIZE;
 				mark_inode_dirty(dir);
 			} else {
@@ -433,32 +425,35 @@
 			brelse (bh);
 			return -ENOENT;
 		}
-		if (ufs_match (namelen, name, de, flags, swab)) {
+		if (ufs_match(sb, namelen, name, de)) {
 			brelse (bh);
 			return -EEXIST;
 		}
-		if (SWAB32(de->d_ino) == 0 && SWAB16(de->d_reclen) >= rec_len)
+		if (de->d_ino == 0 && fs16_to_cpu(sb, de->d_reclen) >= rec_len)
 			break;
 			
-		if (SWAB16(de->d_reclen) >= UFS_DIR_REC_LEN(ufs_get_de_namlen(de)) + rec_len)
+		if (fs16_to_cpu(sb, de->d_reclen) >=
+		     UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)) + rec_len)
 			break;
-		offset += SWAB16(de->d_reclen);
-		de = (struct ufs_dir_entry *) ((char *) de + SWAB16(de->d_reclen));
+		offset += fs16_to_cpu(sb, de->d_reclen);
+		de = (struct ufs_dir_entry *) ((char *) de + fs16_to_cpu(sb, de->d_reclen));
 	}
 
-	if (SWAB32(de->d_ino)) {
+	if (de->d_ino) {
 		de1 = (struct ufs_dir_entry *) ((char *) de +
-			UFS_DIR_REC_LEN(ufs_get_de_namlen(de)));
-		de1->d_reclen = SWAB16(SWAB16(de->d_reclen) -
-			UFS_DIR_REC_LEN(ufs_get_de_namlen(de)));
-		de->d_reclen = SWAB16(UFS_DIR_REC_LEN(ufs_get_de_namlen(de)));
+			UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
+		de1->d_reclen =
+			cpu_to_fs16(sb, fs16_to_cpu(sb, de->d_reclen) -
+				UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
+		de->d_reclen =
+			cpu_to_fs16(sb, UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
 		de = de1;
 	}
-	de->d_ino = SWAB32(0);
-	ufs_set_de_namlen(de, namelen);
+	de->d_ino = 0;
+	ufs_set_de_namlen(sb, de, namelen);
 	memcpy (de->d_name, name, namelen + 1);
-	de->d_ino = SWAB32(inode->i_ino);
-	ufs_set_de_type (de, inode->i_mode);
+	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
+	ufs_set_de_type(sb, de, inode->i_mode);
 	mark_buffer_dirty(bh);
 	if (IS_SYNC(dir)) {
 		ll_rw_block (WRITE, 1, &bh);
@@ -484,19 +479,18 @@
 	struct super_block * sb;
 	struct ufs_dir_entry * de, * pde;
 	unsigned i;
-	unsigned flags, swab;
 	
 	UFSD(("ENTER\n"))
 
 	sb = inode->i_sb;
-	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 	i = 0;
 	pde = NULL;
 	de = (struct ufs_dir_entry *) bh->b_data;
 	
-	UFSD(("ino %u, reclen %u, namlen %u, name %s\n", SWAB32(de->d_ino),
-		SWAB16(de->d_reclen), ufs_get_de_namlen(de), de->d_name))
+	UFSD(("ino %u, reclen %u, namlen %u, name %s\n",
+		fs32_to_cpu(sb, de->d_ino),
+		fs16to_cpu(sb, de->d_reclen),
+		ufs_get_de_namlen(sb, de), de->d_name))
 
 	while (i < bh->b_size) {
 		if (!ufs_check_dir_entry ("ufs_delete_entry", inode, de, bh, i)) {
@@ -505,10 +499,9 @@
 		}
 		if (de == dir)  {
 			if (pde)
-				pde->d_reclen =
-				    SWAB16(SWAB16(pde->d_reclen) +
-				    SWAB16(dir->d_reclen));
-			dir->d_ino = SWAB32(0);
+				fs16_add(sb, &pde->d_reclen,
+					fs16_to_cpu(sb, dir->d_reclen));
+			dir->d_ino = 0;
 			inode->i_version = ++event;
 			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 			mark_inode_dirty(inode);
@@ -521,12 +514,12 @@
 			UFSD(("EXIT\n"))
 			return 0;
 		}
-		i += SWAB16(de->d_reclen);
+		i += fs16_to_cpu(sb, de->d_reclen);
 		if (i == UFS_SECTOR_SIZE) pde = NULL;
 		else pde = de;
 		de = (struct ufs_dir_entry *)
-		    ((char *) de + SWAB16(de->d_reclen));
-		if (i == UFS_SECTOR_SIZE && SWAB16(de->d_reclen) == 0)
+		    ((char *) de + fs16_to_cpu(sb, de->d_reclen));
+		if (i == UFS_SECTOR_SIZE && de->d_reclen == 0)
 			break;
 	}
 	UFSD(("EXIT\n"))
@@ -537,8 +530,6 @@
 int ufs_make_empty(struct inode * inode, struct inode *dir)
 {
 	struct super_block * sb = dir->i_sb;
-	unsigned flags = sb->u.ufs_sb.s_flags;
-	unsigned swab = sb->u.ufs_sb.s_swab;
 	struct buffer_head * dir_block;
 	struct ufs_dir_entry * de;
 	int err;
@@ -549,16 +540,17 @@
 
 	inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
 	de = (struct ufs_dir_entry *) dir_block->b_data;
-	de->d_ino = SWAB32(inode->i_ino);
-	ufs_set_de_type (de, inode->i_mode);
-	ufs_set_de_namlen(de,1);
-	de->d_reclen = SWAB16(UFS_DIR_REC_LEN(1));
+	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
+	ufs_set_de_type(sb, de, inode->i_mode);
+	ufs_set_de_namlen(sb, de, 1);
+	de->d_reclen = cpu_to_fs16(sb, UFS_DIR_REC_LEN(1));
 	strcpy (de->d_name, ".");
-	de = (struct ufs_dir_entry *) ((char *) de + SWAB16(de->d_reclen));
-	de->d_ino = SWAB32(dir->i_ino);
-	ufs_set_de_type (de, dir->i_mode);
-	de->d_reclen = SWAB16(UFS_SECTOR_SIZE - UFS_DIR_REC_LEN(1));
-	ufs_set_de_namlen(de,2);
+	de = (struct ufs_dir_entry *)
+		((char *)de + fs16_to_cpu(sb, de->d_reclen));
+	de->d_ino = cpu_to_fs32(sb, dir->i_ino);
+	ufs_set_de_type(sb, de, dir->i_mode);
+	de->d_reclen = cpu_to_fs16(sb, UFS_SECTOR_SIZE - UFS_DIR_REC_LEN(1));
+	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
 	mark_buffer_dirty(dir_block);
 	brelse (dir_block);
@@ -576,10 +568,8 @@
 	struct buffer_head * bh;
 	struct ufs_dir_entry * de, * de1;
 	int err;
-	unsigned swab;	
 	
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 
 	if (inode->i_size < UFS_DIR_REC_LEN(1) + UFS_DIR_REC_LEN(2) ||
 	    !(bh = ufs_bread (inode, 0, 0, &err))) {
@@ -589,16 +579,18 @@
 		return 1;
 	}
 	de = (struct ufs_dir_entry *) bh->b_data;
-	de1 = (struct ufs_dir_entry *) ((char *) de + SWAB16(de->d_reclen));
-	if (SWAB32(de->d_ino) != inode->i_ino || !SWAB32(de1->d_ino) || 
-	    strcmp (".", de->d_name) || strcmp ("..", de1->d_name)) {
+	de1 = (struct ufs_dir_entry *)
+		((char *)de + fs16_to_cpu(sb, de->d_reclen));
+	if (fs32_to_cpu(sb, de->d_ino) != inode->i_ino || de1->d_ino == 0 ||
+	     strcmp (".", de->d_name) || strcmp ("..", de1->d_name)) {
 	    	ufs_warning (inode->i_sb, "empty_dir",
 			      "bad directory (dir #%lu) - no `.' or `..'",
 			      inode->i_ino);
 		return 1;
 	}
-	offset = SWAB16(de->d_reclen) + SWAB16(de1->d_reclen);
-	de = (struct ufs_dir_entry *) ((char *) de1 + SWAB16(de1->d_reclen));
+	offset = fs16_to_cpu(sb, de->d_reclen) + fs16_to_cpu(sb, de1->d_reclen);
+	de = (struct ufs_dir_entry *)
+		((char *)de1 + fs16_to_cpu(sb, de1->d_reclen));
 	while (offset < inode->i_size ) {
 		if (!bh || (void *) de >= (void *) (bh->b_data + sb->s_blocksize)) {
 			brelse (bh);
@@ -616,12 +608,13 @@
 			brelse (bh);
 			return 1;
 		}
-		if (SWAB32(de->d_ino)) {
+		if (de->d_ino) {
 			brelse (bh);
 			return 0;
 		}
-		offset += SWAB16(de->d_reclen);
-		de = (struct ufs_dir_entry *) ((char *) de + SWAB16(de->d_reclen));
+		offset += fs16_to_cpu(sb, de->d_reclen);
+		de = (struct ufs_dir_entry *)
+			((char *)de + fs16_to_cpu(sb, de->d_reclen));
 	}
 	brelse (bh);
 	return 1;
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/ialloc.c linux/fs/ufs/ialloc.c
--- ../master/linux-2.4.14-pre3/fs/ufs/ialloc.c	Thu Oct 25 19:05:48 2001
+++ linux/fs/ufs/ialloc.c	Mon Oct 29 16:46:54 2001
@@ -66,12 +66,10 @@
 	struct ufs_cylinder_group * ucg;
 	int is_directory;
 	unsigned ino, cg, bit;
-	unsigned swab;
 	
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	
@@ -93,10 +91,10 @@
 		return;
 	}
 	ucg = ubh_get_ucg(UCPI_UBH);
-	if (!ufs_cg_chkmagic(ucg))
+	if (!ufs_cg_chkmagic(sb, ucg))
 		ufs_panic (sb, "ufs_free_fragments", "internal error, bad cg magic number");
 
-	ucg->cg_time = SWAB32(CURRENT_TIME);
+	ucg->cg_time = cpu_to_fs32(sb, CURRENT_TIME);
 
 	is_directory = S_ISDIR(inode->i_mode);
 
@@ -111,16 +109,17 @@
 		ubh_clrbit (UCPI_UBH, ucpi->c_iusedoff, bit);
 		if (ino < ucpi->c_irotor)
 			ucpi->c_irotor = ino;
-		INC_SWAB32(ucg->cg_cs.cs_nifree);
-		INC_SWAB32(usb1->fs_cstotal.cs_nifree);
-		INC_SWAB32(sb->fs_cs(cg).cs_nifree);
+		fs32_add(sb, &ucg->cg_cs.cs_nifree, 1);
+		fs32_add(sb, &usb1->fs_cstotal.cs_nifree, 1);
+		fs32_add(sb, &sb->fs_cs(cg).cs_nifree, 1);
 
 		if (is_directory) {
-			DEC_SWAB32(ucg->cg_cs.cs_ndir);
-			DEC_SWAB32(usb1->fs_cstotal.cs_ndir);
-			DEC_SWAB32(sb->fs_cs(cg).cs_ndir);
+			fs32_sub(sb, &ucg->cg_cs.cs_ndir, 1);
+			fs32_sub(sb, &usb1->fs_cstotal.cs_ndir, 1);
+			fs32_sub(sb, &sb->fs_cs(cg).cs_ndir, 1);
 		}
 	}
+
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -152,7 +151,6 @@
 	struct ufs_cylinder_group * ucg;
 	struct inode * inode;
 	unsigned cg, bit, i, j, start;
-	unsigned swab;
 
 	UFSD(("ENTER\n"))
 	
@@ -163,7 +161,6 @@
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 
@@ -173,7 +170,7 @@
 	 * Try to place the inode in its parent directory
 	 */
 	i = ufs_inotocg(dir->i_ino);
-	if (SWAB32(sb->fs_cs(i).cs_nifree)) {
+	if (sb->fs_cs(i).cs_nifree) {
 		cg = i;
 		goto cg_found;
 	}
@@ -185,7 +182,7 @@
 		i += j;
 		if (i >= uspi->s_ncg)
 			i -= uspi->s_ncg;
-		if (SWAB32(sb->fs_cs(i).cs_nifree)) {
+		if (sb->fs_cs(i).cs_nifree) {
 			cg = i;
 			goto cg_found;
 		}
@@ -199,7 +196,7 @@
 		i++;
 		if (i >= uspi->s_ncg)
 			i = 0;
-		if (SWAB32(sb->fs_cs(i).cs_nifree)) {
+		if (sb->fs_cs(i).cs_nifree) {
 			cg = i;
 			goto cg_found;
 		}
@@ -212,7 +209,7 @@
 	if (!ucpi)
 		goto failed;
 	ucg = ubh_get_ucg(UCPI_UBH);
-	if (!ufs_cg_chkmagic(ucg)) 
+	if (!ufs_cg_chkmagic(sb, ucg)) 
 		ufs_panic (sb, "ufs_new_inode", "internal error, bad cg magic number");
 
 	start = ucpi->c_irotor;
@@ -233,14 +230,14 @@
 		goto failed;
 	}
 	
-	DEC_SWAB32(ucg->cg_cs.cs_nifree);
-	DEC_SWAB32(usb1->fs_cstotal.cs_nifree);
-	DEC_SWAB32(sb->fs_cs(cg).cs_nifree);
+	fs32_sub(sb, &ucg->cg_cs.cs_nifree, 1);
+	fs32_sub(sb, &usb1->fs_cstotal.cs_nifree, 1);
+	fs32_sub(sb, &sb->fs_cs(cg).cs_nifree, 1);
 	
 	if (S_ISDIR(mode)) {
-		INC_SWAB32(ucg->cg_cs.cs_ndir);
-		INC_SWAB32(usb1->fs_cstotal.cs_ndir);
-		INC_SWAB32(sb->fs_cs(cg).cs_ndir);
+		fs32_add(sb, &ucg->cg_cs.cs_ndir, 1);
+		fs32_add(sb, &usb1->fs_cstotal.cs_ndir, 1);
+		fs32_add(sb, &sb->fs_cs(cg).cs_ndir, 1);
 	}
 
 	ubh_mark_buffer_dirty (USPI_UBH);
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/inode.c linux/fs/ufs/inode.c
--- ../master/linux-2.4.14-pre3/fs/ufs/inode.c	Thu Oct 25 19:05:48 2001
+++ linux/fs/ufs/inode.c	Mon Oct 29 16:46:54 2001
@@ -50,17 +50,6 @@
 #define UFSD(x)
 #endif
 
-static inline unsigned int ufs_block_bmap1(struct buffer_head * bh, unsigned nr, 
-	struct ufs_sb_private_info * uspi, unsigned swab)
-{
-	unsigned int tmp;
-	if (!bh)
-		return 0;
-	tmp = SWAB32(((u32 *) bh->b_data)[nr]);
-	brelse (bh);
-	return tmp;
-}
-
 static int ufs_block_to_path(struct inode *inode, long i_block, int offsets[4])
 {
 	struct ufs_sb_private_info *uspi = inode->i_sb->u.ufs_sb.s_uspi;
@@ -97,7 +86,6 @@
 {
 	struct super_block *sb = inode->i_sb;
 	struct ufs_sb_private_info *uspi = sb->u.ufs_sb.s_uspi;
-	unsigned int swab = sb->u.ufs_sb.s_swab;
 	int mask = uspi->s_apbmask>>uspi->s_fpbshift;
 	int shift = uspi->s_apbshift-uspi->s_fpbshift;
 	int offsets[4], *p;
@@ -118,7 +106,7 @@
 		struct buffer_head *bh;
 		int n = *p++;
 
-		bh = bread(sb->s_dev, uspi->s_sbbase+SWAB32(block)+(n>>shift),
+		bh = bread(sb->s_dev, uspi->s_sbbase + fs32_to_cpu(sb, block)+(n>>shift),
 				sb->s_blocksize);
 		if (!bh)
 			goto out;
@@ -127,7 +115,7 @@
 		if (!block)
 			goto out;
 	}
-	ret = uspi->s_sbbase + SWAB32(block) + (frag & uspi->s_fpbmask);
+	ret = uspi->s_sbbase + fs32_to_cpu(sb, block) + (frag & uspi->s_fpbmask);
 out:
 	unlock_kernel();
 	return ret;
@@ -143,13 +131,11 @@
 	unsigned block, blockoff, lastfrag, lastblock, lastblockoff;
 	unsigned tmp, goal;
 	u32 * p, * p2;
-	unsigned int swab;
 
 	UFSD(("ENTER, ino %lu, fragment %u, new_fragment %u, required %u\n",
 		inode->i_ino, fragment, new_fragment, required))         
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
@@ -157,13 +143,13 @@
 	goal = 0;
 
 repeat:
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	lastfrag = inode->u.ufs_i.i_lastfrag;
 	if (tmp && fragment < lastfrag) {
 		if (metadata) {
 			result = getblk (sb->s_dev, uspi->s_sbbase + tmp + blockoff,
 					 sb->s_blocksize);
-			if (tmp == SWAB32(*p)) {
+			if (tmp == fs32_to_cpu(sb, *p)) {
 				UFSD(("EXIT, result %u\n", tmp + blockoff))
 				return result;
 			}
@@ -187,7 +173,7 @@
 		if (lastblockoff) {
 			p2 = inode->u.ufs_i.i_u1.i_data + lastblock;
 			tmp = ufs_new_fragments (inode, p2, lastfrag, 
-				SWAB32(*p2), uspi->s_fpb - lastblockoff, err);
+				fs32_to_cpu(sb, *p2), uspi->s_fpb - lastblockoff, err);
 			if (!tmp) {
 				if (lastfrag != inode->u.ufs_i.i_lastfrag)
 					goto repeat;
@@ -197,7 +183,7 @@
 			lastfrag = inode->u.ufs_i.i_lastfrag;
 			
 		}
-		goal = SWAB32(inode->u.ufs_i.i_u1.i_data[lastblock]) + uspi->s_fpb;
+		goal = fs32_to_cpu(sb, inode->u.ufs_i.i_u1.i_data[lastblock]) + uspi->s_fpb;
 		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
 			goal, required + blockoff, err);
 	}
@@ -206,19 +192,19 @@
 	 */
 	else if (lastblock == block) {
 		tmp = ufs_new_fragments (inode, p, fragment - (blockoff - lastblockoff),
-			SWAB32(*p), required +  (blockoff - lastblockoff), err);
+			fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff), err);
 	}
 	/*
 	 * We will allocate new block before last allocated block
 	 */
 	else /* (lastblock > block) */ {
-		if (lastblock && (tmp = SWAB32(inode->u.ufs_i.i_u1.i_data[lastblock-1])))
+		if (lastblock && (tmp = fs32_to_cpu(sb, inode->u.ufs_i.i_u1.i_data[lastblock-1])))
 			goal = tmp + uspi->s_fpb;
 		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
 			goal, uspi->s_fpb, err);
 	}
 	if (!tmp) {
-		if ((!blockoff && SWAB32(*p)) || 
+		if ((!blockoff && *p) || 
 		    (blockoff && lastfrag != inode->u.ufs_i.i_lastfrag))
 			goto repeat;
 		*err = -ENOSPC;
@@ -255,10 +241,8 @@
 	struct buffer_head * result;
 	unsigned tmp, goal, block, blockoff;
 	u32 * p;
-	unsigned int swab;
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
@@ -277,12 +261,12 @@
 
 	p = (u32 *) bh->b_data + block;
 repeat:
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (tmp) {
 		if (metadata) {
 			result = getblk (bh->b_dev, uspi->s_sbbase + tmp + blockoff,
 					 sb->s_blocksize);
-			if (tmp == SWAB32(*p))
+			if (tmp == fs32_to_cpu(sb, *p))
 				goto out;
 			brelse (result);
 			goto repeat;
@@ -292,13 +276,13 @@
 		}
 	}
 
-	if (block && (tmp = SWAB32(((u32*)bh->b_data)[block-1]) + uspi->s_fpb))
+	if (block && (tmp = fs32_to_cpu(sb, ((u32*)bh->b_data)[block-1]) + uspi->s_fpb))
 		goal = tmp + uspi->s_fpb;
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
 	tmp = ufs_new_fragments (inode, p, ufs_blknum(new_fragment), goal, uspi->s_fpb, err);
 	if (!tmp) {
-		if (SWAB32(*p))
+		if (fs32_to_cpu(sb, *p))
 			goto repeat;
 		goto out;
 	}		
@@ -332,13 +316,11 @@
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct buffer_head * bh;
-	unsigned int swab;
 	int ret, err, new;
 	unsigned long ptr, phys;
 	
 	sb = inode->i_sb;
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
 
 	if (!create) {
 		phys = ufs_frag_map(inode, fragment);
@@ -504,14 +486,13 @@
 	struct ufs_inode * ufs_inode;	
 	struct buffer_head * bh;
 	unsigned i;
-	unsigned flags, swab;
+	unsigned flags;
 	
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 	
 	sb = inode->i_sb;
 	uspi = sb->u.ufs_sb.s_uspi;
 	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 
 	if (inode->i_ino < UFS_ROOTINO || 
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
@@ -529,37 +510,29 @@
 	/*
 	 * Copy data to the in-core inode.
 	 */
-	inode->i_mode = SWAB16(ufs_inode->ui_mode);
-	inode->i_nlink = SWAB16(ufs_inode->ui_nlink);
+	inode->i_mode = fs16_to_cpu(sb, ufs_inode->ui_mode);
+	inode->i_nlink = fs16_to_cpu(sb, ufs_inode->ui_nlink);
 	if (inode->i_nlink == 0)
 		ufs_error (sb, "ufs_read_inode", "inode %lu has zero nlink\n", inode->i_ino);
 	
 	/*
 	 * Linux now has 32-bit uid and gid, so we can support EFT.
 	 */
-	inode->i_uid = ufs_get_inode_uid(ufs_inode);
-	inode->i_gid = ufs_get_inode_gid(ufs_inode);
-	
-	/*
-	 * Linux i_size can be 32 on some architectures. We will mark 
-	 * big files as read only and let user access first 32 bits.
-	 */
-	inode->u.ufs_i.i_size = SWAB64(ufs_inode->ui_size);
-	inode->i_size = (off_t) inode->u.ufs_i.i_size;
-	if (sizeof(off_t) == 4 && (inode->u.ufs_i.i_size >> 32))
-		inode->i_size = (__u32)-1;
-
-	inode->i_atime = SWAB32(ufs_inode->ui_atime.tv_sec);
-	inode->i_ctime = SWAB32(ufs_inode->ui_ctime.tv_sec);
-	inode->i_mtime = SWAB32(ufs_inode->ui_mtime.tv_sec);
-	inode->i_blocks = SWAB32(ufs_inode->ui_blocks);
+	inode->i_uid = ufs_get_inode_uid(sb, ufs_inode);
+	inode->i_gid = ufs_get_inode_gid(sb, ufs_inode);
+
+	inode->i_size = fs64_to_cpu(sb, ufs_inode->ui_size);
+	inode->i_atime = fs32_to_cpu(sb, ufs_inode->ui_atime.tv_sec);
+	inode->i_ctime = fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec);
+	inode->i_mtime = fs32_to_cpu(sb, ufs_inode->ui_mtime.tv_sec);
+	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
 	inode->i_blksize = PAGE_SIZE;   /* This is the optimal IO size (for stat) */
 	inode->i_version = ++event;
 
-	inode->u.ufs_i.i_flags = SWAB32(ufs_inode->ui_flags);
-	inode->u.ufs_i.i_gen = SWAB32(ufs_inode->ui_gen);
-	inode->u.ufs_i.i_shadow = SWAB32(ufs_inode->ui_u3.ui_sun.ui_shadow);
-	inode->u.ufs_i.i_oeftflag = SWAB32(ufs_inode->ui_u3.ui_sun.ui_oeftflag);
+	inode->u.ufs_i.i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
+	inode->u.ufs_i.i_gen = fs32_to_cpu(sb, ufs_inode->ui_gen);
+	inode->u.ufs_i.i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
+	inode->u.ufs_i.i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 	inode->u.ufs_i.i_lastfrag = (inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
@@ -590,7 +563,7 @@
 		}
 	} else
 		init_special_inode(inode, inode->i_mode,
-				   SWAB32(ufs_inode->ui_u2.ui_addr.ui_db[0]));
+			fs32_to_cpu(sb, ufs_inode->ui_u2.ui_addr.ui_db[0]));
 
 	brelse (bh);
 
@@ -604,14 +577,13 @@
 	struct buffer_head * bh;
 	struct ufs_inode * ufs_inode;
 	unsigned i;
-	unsigned flags, swab;
+	unsigned flags;
 
 	UFSD(("ENTER, ino %lu\n", inode->i_ino))
 
 	sb = inode->i_sb;
 	uspi = sb->u.ufs_sb.s_uspi;
 	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 
 	if (inode->i_ino < UFS_ROOTINO || 
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
@@ -626,30 +598,30 @@
 	}
 	ufs_inode = (struct ufs_inode *) (bh->b_data + ufs_inotofsbo(inode->i_ino) * sizeof(struct ufs_inode));
 
-	ufs_inode->ui_mode = SWAB16(inode->i_mode);
-	ufs_inode->ui_nlink = SWAB16(inode->i_nlink);
+	ufs_inode->ui_mode = cpu_to_fs16(sb, inode->i_mode);
+	ufs_inode->ui_nlink = cpu_to_fs16(sb, inode->i_nlink);
 
-	ufs_set_inode_uid (ufs_inode, inode->i_uid);
-	ufs_set_inode_gid (ufs_inode, inode->i_gid);
+	ufs_set_inode_uid(sb, ufs_inode, inode->i_uid);
+	ufs_set_inode_gid(sb, ufs_inode, inode->i_gid);
 		
-	ufs_inode->ui_size = SWAB64((u64)inode->i_size);
-	ufs_inode->ui_atime.tv_sec = SWAB32(inode->i_atime);
-	ufs_inode->ui_atime.tv_usec = SWAB32(0);
-	ufs_inode->ui_ctime.tv_sec = SWAB32(inode->i_ctime);
-	ufs_inode->ui_ctime.tv_usec = SWAB32(0);
-	ufs_inode->ui_mtime.tv_sec = SWAB32(inode->i_mtime);
-	ufs_inode->ui_mtime.tv_usec = SWAB32(0);
-	ufs_inode->ui_blocks = SWAB32(inode->i_blocks);
-	ufs_inode->ui_flags = SWAB32(inode->u.ufs_i.i_flags);
-	ufs_inode->ui_gen = SWAB32(inode->u.ufs_i.i_gen);
+	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
+	ufs_inode->ui_atime.tv_sec = cpu_to_fs32(sb, inode->i_atime);
+	ufs_inode->ui_atime.tv_usec = 0;
+	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb, inode->i_ctime);
+	ufs_inode->ui_ctime.tv_usec = 0;
+	ufs_inode->ui_mtime.tv_sec = cpu_to_fs32(sb, inode->i_mtime);
+	ufs_inode->ui_mtime.tv_usec = 0;
+	ufs_inode->ui_blocks = cpu_to_fs32(sb, inode->i_blocks);
+	ufs_inode->ui_flags = cpu_to_fs32(sb, inode->u.ufs_i.i_flags);
+	ufs_inode->ui_gen = cpu_to_fs32(sb, inode->u.ufs_i.i_gen);
 
 	if ((flags & UFS_UID_MASK) == UFS_UID_EFT) {
-		ufs_inode->ui_u3.ui_sun.ui_shadow = SWAB32(inode->u.ufs_i.i_shadow);
-		ufs_inode->ui_u3.ui_sun.ui_oeftflag = SWAB32(inode->u.ufs_i.i_oeftflag);
+		ufs_inode->ui_u3.ui_sun.ui_shadow = cpu_to_fs32(sb, inode->u.ufs_i.i_shadow);
+		ufs_inode->ui_u3.ui_sun.ui_oeftflag = cpu_to_fs32(sb, inode->u.ufs_i.i_oeftflag);
 	}
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		ufs_inode->ui_u2.ui_addr.ui_db[0] = SWAB32(kdev_t_to_nr(inode->i_rdev));
+		ufs_inode->ui_u2.ui_addr.ui_db[0] = cpu_to_fs32(sb, kdev_t_to_nr(inode->i_rdev));
 	else if (inode->i_blocks) {
 		for (i = 0; i < (UFS_NDADDR + UFS_NINDIR); i++)
 			ufs_inode->ui_u2.ui_addr.ui_db[i] = inode->u.ufs_i.i_u1.i_data[i];
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/super.c linux/fs/ufs/super.c
--- ../master/linux-2.4.14-pre3/fs/ufs/super.c	Wed May 16 19:31:27 2001
+++ linux/fs/ufs/super.c	Mon Oct 29 16:46:54 2001
@@ -97,44 +97,45 @@
 /*
  * Print contents of ufs_super_block, useful for debugging
  */
-void ufs_print_super_stuff(struct ufs_super_block_first * usb1,
+void ufs_print_super_stuff(struct super_block *sb,
+	struct ufs_super_block_first * usb1,
 	struct ufs_super_block_second * usb2, 
-	struct ufs_super_block_third * usb3, unsigned swab)
+	struct ufs_super_block_third * usb3)
 {
 	printk("ufs_print_super_stuff\n");
 	printk("size of usb:     %u\n", sizeof(struct ufs_super_block));
-	printk("  magic:         0x%x\n", SWAB32(usb3->fs_magic));
-	printk("  sblkno:        %u\n", SWAB32(usb1->fs_sblkno));
-	printk("  cblkno:        %u\n", SWAB32(usb1->fs_cblkno));
-	printk("  iblkno:        %u\n", SWAB32(usb1->fs_iblkno));
-	printk("  dblkno:        %u\n", SWAB32(usb1->fs_dblkno));
-	printk("  cgoffset:      %u\n", SWAB32(usb1->fs_cgoffset));
-	printk("  ~cgmask:       0x%x\n", ~SWAB32(usb1->fs_cgmask));
-	printk("  size:          %u\n", SWAB32(usb1->fs_size));
-	printk("  dsize:         %u\n", SWAB32(usb1->fs_dsize));
-	printk("  ncg:           %u\n", SWAB32(usb1->fs_ncg));
-	printk("  bsize:         %u\n", SWAB32(usb1->fs_bsize));
-	printk("  fsize:         %u\n", SWAB32(usb1->fs_fsize));
-	printk("  frag:          %u\n", SWAB32(usb1->fs_frag));
-	printk("  fragshift:     %u\n", SWAB32(usb1->fs_fragshift));
-	printk("  ~fmask:        %u\n", ~SWAB32(usb1->fs_fmask));
-	printk("  fshift:        %u\n", SWAB32(usb1->fs_fshift));
-	printk("  sbsize:        %u\n", SWAB32(usb1->fs_sbsize));
-	printk("  spc:           %u\n", SWAB32(usb1->fs_spc));
-	printk("  cpg:           %u\n", SWAB32(usb1->fs_cpg));
-	printk("  ipg:           %u\n", SWAB32(usb1->fs_ipg));
-	printk("  fpg:           %u\n", SWAB32(usb1->fs_fpg));
-	printk("  csaddr:        %u\n", SWAB32(usb1->fs_csaddr));
-	printk("  cssize:        %u\n", SWAB32(usb1->fs_cssize));
-	printk("  cgsize:        %u\n", SWAB32(usb1->fs_cgsize));
-	printk("  fstodb:        %u\n", SWAB32(usb1->fs_fsbtodb));
-	printk("  contigsumsize: %d\n", SWAB32(usb3->fs_u2.fs_44.fs_contigsumsize));
-	printk("  postblformat:  %u\n", SWAB32(usb3->fs_postblformat));
-	printk("  nrpos:         %u\n", SWAB32(usb3->fs_nrpos));
-	printk("  ndir           %u\n", SWAB32(usb1->fs_cstotal.cs_ndir));
-	printk("  nifree         %u\n", SWAB32(usb1->fs_cstotal.cs_nifree));
-	printk("  nbfree         %u\n", SWAB32(usb1->fs_cstotal.cs_nbfree));
-	printk("  nffree         %u\n", SWAB32(usb1->fs_cstotal.cs_nffree));
+	printk("  magic:         0x%x\n", fs32_to_cpu(sb, usb3->fs_magic));
+	printk("  sblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_sblkno));
+	printk("  cblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_cblkno));
+	printk("  iblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_iblkno));
+	printk("  dblkno:        %u\n", fs32_to_cpu(sb, usb1->fs_dblkno));
+	printk("  cgoffset:      %u\n", fs32_to_cpu(sb, usb1->fs_cgoffset));
+	printk("  ~cgmask:       0x%x\n", ~fs32_to_cpu(sb, usb1->fs_cgmask));
+	printk("  size:          %u\n", fs32_to_cpu(sb, usb1->fs_size));
+	printk("  dsize:         %u\n", fs32_to_cpu(sb, usb1->fs_dsize));
+	printk("  ncg:           %u\n", fs32_to_cpu(sb, usb1->fs_ncg));
+	printk("  bsize:         %u\n", fs32_to_cpu(sb, usb1->fs_bsize));
+	printk("  fsize:         %u\n", fs32_to_cpu(sb, usb1->fs_fsize));
+	printk("  frag:          %u\n", fs32_to_cpu(sb, usb1->fs_frag));
+	printk("  fragshift:     %u\n", fs32_to_cpu(sb, usb1->fs_fragshift));
+	printk("  ~fmask:        %u\n", ~fs32_to_cpu(sb, usb1->fs_fmask));
+	printk("  fshift:        %u\n", fs32_to_cpu(sb, usb1->fs_fshift));
+	printk("  sbsize:        %u\n", fs32_to_cpu(sb, usb1->fs_sbsize));
+	printk("  spc:           %u\n", fs32_to_cpu(sb, usb1->fs_spc));
+	printk("  cpg:           %u\n", fs32_to_cpu(sb, usb1->fs_cpg));
+	printk("  ipg:           %u\n", fs32_to_cpu(sb, usb1->fs_ipg));
+	printk("  fpg:           %u\n", fs32_to_cpu(sb, usb1->fs_fpg));
+	printk("  csaddr:        %u\n", fs32_to_cpu(sb, usb1->fs_csaddr));
+	printk("  cssize:        %u\n", fs32_to_cpu(sb, usb1->fs_cssize));
+	printk("  cgsize:        %u\n", fs32_to_cpu(sb, usb1->fs_cgsize));
+	printk("  fstodb:        %u\n", fs32_to_cpu(sb, usb1->fs_fsbtodb));
+	printk("  contigsumsize: %d\n", fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_contigsumsize));
+	printk("  postblformat:  %u\n", fs32_to_cpu(sb, usb3->fs_postblformat));
+	printk("  nrpos:         %u\n", fs32_to_cpu(sb, usb3->fs_nrpos));
+	printk("  ndir           %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_ndir));
+	printk("  nifree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree));
+	printk("  nbfree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree));
+	printk("  nffree         %u\n", fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree));
 	printk("\n");
 }
 
@@ -142,36 +143,36 @@
 /*
  * Print contents of ufs_cylinder_group, useful for debugging
  */
-void ufs_print_cylinder_stuff(struct ufs_cylinder_group *cg, unsigned swab)
+void ufs_print_cylinder_stuff(struct super_block *sb, struct ufs_cylinder_group *cg)
 {
 	printk("\nufs_print_cylinder_stuff\n");
 	printk("size of ucg: %u\n", sizeof(struct ufs_cylinder_group));
-	printk("  magic:        %x\n", SWAB32(cg->cg_magic));
-	printk("  time:         %u\n", SWAB32(cg->cg_time));
-	printk("  cgx:          %u\n", SWAB32(cg->cg_cgx));
-	printk("  ncyl:         %u\n", SWAB16(cg->cg_ncyl));
-	printk("  niblk:        %u\n", SWAB16(cg->cg_niblk));
-	printk("  ndblk:        %u\n", SWAB32(cg->cg_ndblk));
-	printk("  cs_ndir:      %u\n", SWAB32(cg->cg_cs.cs_ndir));
-	printk("  cs_nbfree:    %u\n", SWAB32(cg->cg_cs.cs_nbfree));
-	printk("  cs_nifree:    %u\n", SWAB32(cg->cg_cs.cs_nifree));
-	printk("  cs_nffree:    %u\n", SWAB32(cg->cg_cs.cs_nffree));
-	printk("  rotor:        %u\n", SWAB32(cg->cg_rotor));
-	printk("  frotor:       %u\n", SWAB32(cg->cg_frotor));
-	printk("  irotor:       %u\n", SWAB32(cg->cg_irotor));
+	printk("  magic:        %x\n", fs32_to_cpu(sb, cg->cg_magic));
+	printk("  time:         %u\n", fs32_to_cpu(sb, cg->cg_time));
+	printk("  cgx:          %u\n", fs32_to_cpu(sb, cg->cg_cgx));
+	printk("  ncyl:         %u\n", fs16_to_cpu(sb, cg->cg_ncyl));
+	printk("  niblk:        %u\n", fs16_to_cpu(sb, cg->cg_niblk));
+	printk("  ndblk:        %u\n", fs32_to_cpu(sb, cg->cg_ndblk));
+	printk("  cs_ndir:      %u\n", fs32_to_cpu(sb, cg->cg_cs.cs_ndir));
+	printk("  cs_nbfree:    %u\n", fs32_to_cpu(sb, cg->cg_cs.cs_nbfree));
+	printk("  cs_nifree:    %u\n", fs32_to_cpu(sb, cg->cg_cs.cs_nifree));
+	printk("  cs_nffree:    %u\n", fs32_to_cpu(sb, cg->cg_cs.cs_nffree));
+	printk("  rotor:        %u\n", fs32_to_cpu(sb, cg->cg_rotor));
+	printk("  frotor:       %u\n", fs32_to_cpu(sb, cg->cg_frotor));
+	printk("  irotor:       %u\n", fs32_to_cpu(sb, cg->cg_irotor));
 	printk("  frsum:        %u, %u, %u, %u, %u, %u, %u, %u\n",
-	    SWAB32(cg->cg_frsum[0]), SWAB32(cg->cg_frsum[1]),
-	    SWAB32(cg->cg_frsum[2]), SWAB32(cg->cg_frsum[3]),
-	    SWAB32(cg->cg_frsum[4]), SWAB32(cg->cg_frsum[5]),
-	    SWAB32(cg->cg_frsum[6]), SWAB32(cg->cg_frsum[7]));
-	printk("  btotoff:      %u\n", SWAB32(cg->cg_btotoff));
-	printk("  boff:         %u\n", SWAB32(cg->cg_boff));
-	printk("  iuseoff:      %u\n", SWAB32(cg->cg_iusedoff));
-	printk("  freeoff:      %u\n", SWAB32(cg->cg_freeoff));
-	printk("  nextfreeoff:  %u\n", SWAB32(cg->cg_nextfreeoff));
-	printk("  clustersumoff %u\n", SWAB32(cg->cg_u.cg_44.cg_clustersumoff));
-	printk("  clusteroff    %u\n", SWAB32(cg->cg_u.cg_44.cg_clusteroff));
-	printk("  nclusterblks  %u\n", SWAB32(cg->cg_u.cg_44.cg_nclusterblks));
+	    fs32_to_cpu(sb, cg->cg_frsum[0]), fs32_to_cpu(sb, cg->cg_frsum[1]),
+	    fs32_to_cpu(sb, cg->cg_frsum[2]), fs32_to_cpu(sb, cg->cg_frsum[3]),
+	    fs32_to_cpu(sb, cg->cg_frsum[4]), fs32_to_cpu(sb, cg->cg_frsum[5]),
+	    fs32_to_cpu(sb, cg->cg_frsum[6]), fs32_to_cpu(sb, cg->cg_frsum[7]));
+	printk("  btotoff:      %u\n", fs32_to_cpu(sb, cg->cg_btotoff));
+	printk("  boff:         %u\n", fs32_to_cpu(sb, cg->cg_boff));
+	printk("  iuseoff:      %u\n", fs32_to_cpu(sb, cg->cg_iusedoff));
+	printk("  freeoff:      %u\n", fs32_to_cpu(sb, cg->cg_freeoff));
+	printk("  nextfreeoff:  %u\n", fs32_to_cpu(sb, cg->cg_nextfreeoff));
+	printk("  clustersumoff %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clustersumoff));
+	printk("  clusteroff    %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_clusteroff));
+	printk("  nclusterblks  %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_nclusterblks));
 	printk("\n");
 }
 #endif /* UFS_SUPER_DEBUG_MORE */
@@ -320,12 +321,10 @@
 	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned size, blks, i;
-	unsigned swab;
 	
 	UFSD(("ENTER\n"))
 	
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
 	
 	/*
 	 * Read cs structures from (usually) first data block
@@ -366,10 +365,10 @@
 		UFSD(("read cg %u\n", i))
 		if (!(sb->u.ufs_sb.s_ucg[i] = bread (sb->s_dev, ufs_cgcmin(i), sb->s_blocksize)))
 			goto failed;
-		if (!ufs_cg_chkmagic ((struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data))
+		if (!ufs_cg_chkmagic (sb, (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data))
 			goto failed;
 #ifdef UFS_SUPER_DEBUG_MORE
-		ufs_print_cylinder_stuff((struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data, swab);
+		ufs_print_cylinder_stuff(sb, (struct ufs_cylinder_group *) sb->u.ufs_sb.s_ucg[i]->b_data);
 #endif
 	}
 	for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
@@ -444,12 +443,11 @@
 	struct ufs_super_block_third * usb3;
 	struct ufs_buffer_head * ubh;	
 	unsigned block_size, super_block_size;
-	unsigned flags, swab;
+	unsigned flags;
 
 	uspi = NULL;
 	ubh = NULL;
 	flags = 0;
-	swab = 0;
 	
 	UFSD(("ENTER\n"))
 		
@@ -614,37 +612,22 @@
 	/*
 	 * Check ufs magic number
 	 */
-#if defined(__LITTLE_ENDIAN) || defined(__BIG_ENDIAN) /* sane bytesex */
-	switch (usb3->fs_magic) {
+	switch (__constant_le32_to_cpu(usb3->fs_magic)) {
 		case UFS_MAGIC:
-	        case UFS_MAGIC_LFN:
+		case UFS_MAGIC_LFN:
 	        case UFS_MAGIC_FEA:
 	        case UFS_MAGIC_4GB:
-			swab = UFS_NATIVE_ENDIAN;
-			goto magic_found;
-		case UFS_CIGAM:
-	        case UFS_CIGAM_LFN:
-	        case UFS_CIGAM_FEA:
-	        case UFS_CIGAM_4GB:
-			swab = UFS_SWABBED_ENDIAN;
+			sb->u.ufs_sb.s_bytesex = BYTESEX_LE;
 			goto magic_found;
 	}
-#else /* bytesex perversion */
-	switch (le32_to_cpup(&usb3->fs_magic)) {
+	switch (__constant_be32_to_cpu(usb3->fs_magic)) {
 		case UFS_MAGIC:
 		case UFS_MAGIC_LFN:
 	        case UFS_MAGIC_FEA:
 	        case UFS_MAGIC_4GB:
-			swab = UFS_LITTLE_ENDIAN;
-			goto magic_found;
-		case UFS_CIGAM:
-		case UFS_CIGAM_LFN:
-	        case UFS_CIGAM_FEA:
-	        case UFS_CIGAM_4GB:
-			swab = UFS_BIG_ENDIAN;
+			sb->u.ufs_sb.s_bytesex = BYTESEX_BE;
 			goto magic_found;
 	}
-#endif
 
 	if ((((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP) 
 	  || ((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP_CD) 
@@ -662,11 +645,11 @@
 	/*
 	 * Check block and fragment sizes
 	 */
-	uspi->s_bsize = SWAB32(usb1->fs_bsize);
-	uspi->s_fsize = SWAB32(usb1->fs_fsize);
-	uspi->s_sbsize = SWAB32(usb1->fs_sbsize);
-	uspi->s_fmask = SWAB32(usb1->fs_fmask);
-	uspi->s_fshift = SWAB32(usb1->fs_fshift);
+	uspi->s_bsize = fs32_to_cpu(sb, usb1->fs_bsize);
+	uspi->s_fsize = fs32_to_cpu(sb, usb1->fs_fsize);
+	uspi->s_sbsize = fs32_to_cpu(sb, usb1->fs_sbsize);
+	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
+	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
 
 	if (uspi->s_bsize != 4096 && uspi->s_bsize != 8192 
 	  && uspi->s_bsize != 32768) {
@@ -688,7 +671,7 @@
 	}
 
 #ifdef UFS_SUPER_DEBUG_MORE
-	ufs_print_super_stuff (usb1, usb2, usb3, swab);
+	ufs_print_super_stuff(sb, usb1, usb2, usb3);
 #endif
 
 	/*
@@ -699,7 +682,7 @@
 	  ((flags & UFS_ST_MASK) == UFS_ST_OLD) ||
 	  (((flags & UFS_ST_MASK) == UFS_ST_SUN || 
 	  (flags & UFS_ST_MASK) == UFS_ST_SUNx86) && 
-	  (ufs_get_fs_state(usb1, usb3) == (UFS_FSOK - SWAB32(usb1->fs_time))))) {
+	  (ufs_get_fs_state(sb, usb1, usb3) == (UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time))))) {
 		switch(usb1->fs_clean) {
 		case UFS_FSCLEAN:
 			UFSD(("fs is clean\n"))
@@ -732,56 +715,56 @@
 	/*
 	 * Read ufs_super_block into internal data structures
 	 */
-	sb->s_blocksize =  SWAB32(usb1->fs_fsize);
-	sb->s_blocksize_bits = SWAB32(usb1->fs_fshift);
+	sb->s_blocksize = fs32_to_cpu(sb, usb1->fs_fsize);
+	sb->s_blocksize_bits = fs32_to_cpu(sb, usb1->fs_fshift);
 	sb->s_op = &ufs_super_ops;
 	sb->dq_op = NULL; /***/
-	sb->s_magic = SWAB32(usb3->fs_magic);
+	sb->s_magic = fs32_to_cpu(sb, usb3->fs_magic);
 
-	uspi->s_sblkno = SWAB32(usb1->fs_sblkno);
-	uspi->s_cblkno = SWAB32(usb1->fs_cblkno);
-	uspi->s_iblkno = SWAB32(usb1->fs_iblkno);
-	uspi->s_dblkno = SWAB32(usb1->fs_dblkno);
-	uspi->s_cgoffset = SWAB32(usb1->fs_cgoffset);
-	uspi->s_cgmask = SWAB32(usb1->fs_cgmask);
-	uspi->s_size = SWAB32(usb1->fs_size);
-	uspi->s_dsize = SWAB32(usb1->fs_dsize);
-	uspi->s_ncg = SWAB32(usb1->fs_ncg);
+	uspi->s_sblkno = fs32_to_cpu(sb, usb1->fs_sblkno);
+	uspi->s_cblkno = fs32_to_cpu(sb, usb1->fs_cblkno);
+	uspi->s_iblkno = fs32_to_cpu(sb, usb1->fs_iblkno);
+	uspi->s_dblkno = fs32_to_cpu(sb, usb1->fs_dblkno);
+	uspi->s_cgoffset = fs32_to_cpu(sb, usb1->fs_cgoffset);
+	uspi->s_cgmask = fs32_to_cpu(sb, usb1->fs_cgmask);
+	uspi->s_size = fs32_to_cpu(sb, usb1->fs_size);
+	uspi->s_dsize = fs32_to_cpu(sb, usb1->fs_dsize);
+	uspi->s_ncg = fs32_to_cpu(sb, usb1->fs_ncg);
 	/* s_bsize already set */
 	/* s_fsize already set */
-	uspi->s_fpb = SWAB32(usb1->fs_frag);
-	uspi->s_minfree = SWAB32(usb1->fs_minfree);
-	uspi->s_bmask = SWAB32(usb1->fs_bmask);
-	uspi->s_fmask = SWAB32(usb1->fs_fmask);
-	uspi->s_bshift = SWAB32(usb1->fs_bshift);
-	uspi->s_fshift = SWAB32(usb1->fs_fshift);
-	uspi->s_fpbshift = SWAB32(usb1->fs_fragshift);
-	uspi->s_fsbtodb = SWAB32(usb1->fs_fsbtodb);
+	uspi->s_fpb = fs32_to_cpu(sb, usb1->fs_frag);
+	uspi->s_minfree = fs32_to_cpu(sb, usb1->fs_minfree);
+	uspi->s_bmask = fs32_to_cpu(sb, usb1->fs_bmask);
+	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
+	uspi->s_bshift = fs32_to_cpu(sb, usb1->fs_bshift);
+	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
+	uspi->s_fpbshift = fs32_to_cpu(sb, usb1->fs_fragshift);
+	uspi->s_fsbtodb = fs32_to_cpu(sb, usb1->fs_fsbtodb);
 	/* s_sbsize already set */
-	uspi->s_csmask = SWAB32(usb1->fs_csmask);
-	uspi->s_csshift = SWAB32(usb1->fs_csshift);
-	uspi->s_nindir = SWAB32(usb1->fs_nindir);
-	uspi->s_inopb = SWAB32(usb1->fs_inopb);
-	uspi->s_nspf = SWAB32(usb1->fs_nspf);
-	uspi->s_npsect = ufs_get_fs_npsect(usb1, usb3);
-	uspi->s_interleave = SWAB32(usb1->fs_interleave);
-	uspi->s_trackskew = SWAB32(usb1->fs_trackskew);
-	uspi->s_csaddr = SWAB32(usb1->fs_csaddr);
-	uspi->s_cssize = SWAB32(usb1->fs_cssize);
-	uspi->s_cgsize = SWAB32(usb1->fs_cgsize);
-	uspi->s_ntrak = SWAB32(usb1->fs_ntrak);
-	uspi->s_nsect = SWAB32(usb1->fs_nsect);
-	uspi->s_spc = SWAB32(usb1->fs_spc);
-	uspi->s_ipg = SWAB32(usb1->fs_ipg);
-	uspi->s_fpg = SWAB32(usb1->fs_fpg);
-	uspi->s_cpc = SWAB32(usb2->fs_cpc);
-	uspi->s_contigsumsize = SWAB32(usb3->fs_u2.fs_44.fs_contigsumsize);
-	uspi->s_qbmask = ufs_get_fs_qbmask(usb3);
-	uspi->s_qfmask = ufs_get_fs_qfmask(usb3);
-	uspi->s_postblformat = SWAB32(usb3->fs_postblformat);
-	uspi->s_nrpos = SWAB32(usb3->fs_nrpos);
-	uspi->s_postbloff = SWAB32(usb3->fs_postbloff);
-	uspi->s_rotbloff = SWAB32(usb3->fs_rotbloff);
+	uspi->s_csmask = fs32_to_cpu(sb, usb1->fs_csmask);
+	uspi->s_csshift = fs32_to_cpu(sb, usb1->fs_csshift);
+	uspi->s_nindir = fs32_to_cpu(sb, usb1->fs_nindir);
+	uspi->s_inopb = fs32_to_cpu(sb, usb1->fs_inopb);
+	uspi->s_nspf = fs32_to_cpu(sb, usb1->fs_nspf);
+	uspi->s_npsect = ufs_get_fs_npsect(sb, usb1, usb3);
+	uspi->s_interleave = fs32_to_cpu(sb, usb1->fs_interleave);
+	uspi->s_trackskew = fs32_to_cpu(sb, usb1->fs_trackskew);
+	uspi->s_csaddr = fs32_to_cpu(sb, usb1->fs_csaddr);
+	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
+	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
+	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
+	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
+	uspi->s_spc = fs32_to_cpu(sb, usb1->fs_spc);
+	uspi->s_ipg = fs32_to_cpu(sb, usb1->fs_ipg);
+	uspi->s_fpg = fs32_to_cpu(sb, usb1->fs_fpg);
+	uspi->s_cpc = fs32_to_cpu(sb, usb2->fs_cpc);
+	uspi->s_contigsumsize = fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_contigsumsize);
+	uspi->s_qbmask = ufs_get_fs_qbmask(sb, usb3);
+	uspi->s_qfmask = ufs_get_fs_qfmask(sb, usb3);
+	uspi->s_postblformat = fs32_to_cpu(sb, usb3->fs_postblformat);
+	uspi->s_nrpos = fs32_to_cpu(sb, usb3->fs_nrpos);
+	uspi->s_postbloff = fs32_to_cpu(sb, usb3->fs_postbloff);
+	uspi->s_rotbloff = fs32_to_cpu(sb, usb3->fs_rotbloff);
 
 	/*
 	 * Compute another frequently used values
@@ -803,11 +786,9 @@
 	if ((sb->u.ufs_sb.s_mount_opt & UFS_MOUNT_UFSTYPE) ==
 	    UFS_MOUNT_UFSTYPE_44BSD)
 		uspi->s_maxsymlinklen =
-		    SWAB32(usb3->fs_u2.fs_44.fs_maxsymlinklen);
+		    fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_maxsymlinklen);
 	
 	sb->u.ufs_sb.s_flags = flags;
-	sb->u.ufs_sb.s_swab = swab;
-	 	                                                          
 	sb->s_root = d_alloc_root(iget(sb, UFS_ROOTINO));
 
 
@@ -832,20 +813,20 @@
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_third * usb3;
-	unsigned flags, swab;
+	unsigned flags;
 
 	UFSD(("ENTER\n"))
-	swab = sb->u.ufs_sb.s_swab;
 	flags = sb->u.ufs_sb.s_flags;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	usb3 = ubh_get_usb_third(USPI_UBH);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		usb1->fs_time = SWAB32(CURRENT_TIME);
+		usb1->fs_time = cpu_to_fs32(sb, CURRENT_TIME);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN 
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86)
-			ufs_set_fs_state(usb1, usb3, UFS_FSOK - SWAB32(usb1->fs_time));
+			ufs_set_fs_state(sb, usb1, usb3,
+					UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
 		ubh_mark_buffer_dirty (USPI_UBH);
 	}
 	sb->s_dirt = 0;
@@ -855,12 +836,10 @@
 void ufs_put_super (struct super_block * sb)
 {
 	struct ufs_sb_private_info * uspi;
-	unsigned swab;
 		
 	UFSD(("ENTER\n"))
 
 	uspi = sb->u.ufs_sb.s_uspi;
-	swab = sb->u.ufs_sb.s_swab;
 
 	if (!(sb->s_flags & MS_RDONLY))
 		ufs_put_cylinder_structures (sb);
@@ -877,11 +856,10 @@
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_third * usb3;
 	unsigned new_mount_opt, ufstype;
-	unsigned flags, swab;
+	unsigned flags;
 	
 	uspi = sb->u.ufs_sb.s_uspi;
 	flags = sb->u.ufs_sb.s_flags;
-	swab = sb->u.ufs_sb.s_swab;
 	usb1 = ubh_get_usb_first(USPI_UBH);
 	usb3 = ubh_get_usb_third(USPI_UBH);
 	
@@ -912,10 +890,11 @@
 	 */
 	if (*mount_flags & MS_RDONLY) {
 		ufs_put_cylinder_structures(sb);
-		usb1->fs_time = SWAB32(CURRENT_TIME);
+		usb1->fs_time = cpu_to_fs32(sb, CURRENT_TIME);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
-			ufs_set_fs_state(usb1, usb3, UFS_FSOK - SWAB32(usb1->fs_time));
+			ufs_set_fs_state(sb, usb1, usb3,
+				UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
 		ubh_mark_buffer_dirty (USPI_UBH);
 		sb->s_dirt = 0;
 		sb->s_flags |= MS_RDONLY;
@@ -950,21 +929,19 @@
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
-	unsigned swab;
 
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	usb1 = ubh_get_usb_first (USPI_UBH);
 	
 	buf->f_type = UFS_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = uspi->s_dsize;
-	buf->f_bfree = ufs_blkstofrags(SWAB32(usb1->fs_cstotal.cs_nbfree)) +
-		SWAB32(usb1->fs_cstotal.cs_nffree);
+	buf->f_bfree = ufs_blkstofrags(fs32_to_cpu(sb, usb1->fs_cstotal.cs_nbfree)) +
+		fs32_to_cpu(sb, usb1->fs_cstotal.cs_nffree);
 	buf->f_bavail = (buf->f_bfree > ((buf->f_blocks / 100) * uspi->s_minfree))
 		? (buf->f_bfree - ((buf->f_blocks / 100) * uspi->s_minfree)) : 0;
 	buf->f_files = uspi->s_ncg * uspi->s_ipg;
-	buf->f_ffree = SWAB32(usb1->fs_cstotal.cs_nifree);
+	buf->f_ffree = fs32_to_cpu(sb, usb1->fs_cstotal.cs_nifree);
 	buf->f_namelen = UFS_MAXNAMLEN;
 	return 0;
 }
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/swab.h linux/fs/ufs/swab.h
--- ../master/linux-2.4.14-pre3/fs/ufs/swab.h	Mon Dec 11 22:26:44 2000
+++ linux/fs/ufs/swab.h	Mon Oct 29 16:46:54 2001
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 1997, 1998 Francois-Rene Rideau <fare@tunes.org>
  * Copyright (C) 1998 Jakub Jelinek <jj@ultra.linux.cz>
+ * Copyright (C) 2001 Christoph Hellwig <hch@caldera.de>
  */
 
 #ifndef _UFS_SWAB_H
@@ -14,124 +15,119 @@
  *    in case there are ufs implementations that have strange bytesexes,
  *    you'll need to modify code here as well as in ufs_super.c and ufs_fs.h
  *    to support them.
- *
- *    WE ALSO ASSUME A REMOTELY SANE ARCHITECTURE BYTESEX.
- *    We are not ready to confront insane bytesexual perversions where
- *    conversion to/from little/big-endian is not an involution.
- *    That is, we require that XeYZ_to_cpu(x) == cpu_to_XeYZ(x)
- *
- *    NOTE that swab macros depend on a variable (or macro) swab being in
- *    scope and properly initialized (usually from sb->u.ufs_sb.s_swab).
- *    Its meaning depends on whether the architecture is sane-endian or not.
- *    For sane architectures, it's a flag taking values UFS_NATIVE_ENDIAN (0)
- *    or UFS_SWABBED_ENDIAN (1), indicating whether to swab or not.
- *    For pervert architectures, it's either UFS_LITTLE_ENDIAN or
- *    UFS_BIG_ENDIAN whose meaning you'll have to guess.
- *
- *    It is important to keep these conventions in synch with ufs_fs.h
- *    and super.c. Failure to do so (initializing swab to 0 both for
- *    NATIVE_ENDIAN and LITTLE_ENDIAN) led to nasty crashes on big endian
- *    machines reading little endian UFSes. Search for "swab =" in super.c.
- *
- *    I also suspect the whole UFS code to trust the on-disk structures
- *    much too much, which might lead to losing badly when mounting
- *    inconsistent partitions as UFS filesystems. fsck required (but of
- *    course, no fsck.ufs has yet to be ported from BSD to Linux as of 199808).
- */
-
-#include <linux/ufs_fs.h>
-#include <asm/byteorder.h>
-
-/*
- * These are only valid inside ufs routines,
- * after swab has been initialized to sb->u.ufs_sb.s_swab
  */
-#define SWAB16(x) ufs_swab16(swab,x)
-#define SWAB32(x) ufs_swab32(swab,x)
-#define SWAB64(x) ufs_swab64(swab,x)
 
-/*
- * We often use swabing, when we want to increment/decrement some value,
- * so these macros might become handy and increase readability. (Daniel)
- */
-#define INC_SWAB16(x)	((x)=ufs_swab16_add(swab,x,1))
-#define INC_SWAB32(x)	((x)=ufs_swab32_add(swab,x,1))
-#define INC_SWAB64(x)	((x)=ufs_swab64_add(swab,x,1))
-#define DEC_SWAB16(x)	((x)=ufs_swab16_add(swab,x,-1))
-#define DEC_SWAB32(x)	((x)=ufs_swab32_add(swab,x,-1))
-#define DEC_SWAB64(x)	((x)=ufs_swab64_add(swab,x,-1))
-#define ADD_SWAB16(x,y)	((x)=ufs_swab16_add(swab,x,y))
-#define ADD_SWAB32(x,y)	((x)=ufs_swab32_add(swab,x,y))
-#define ADD_SWAB64(x,y)	((x)=ufs_swab64_add(swab,x,y))
-#define SUB_SWAB16(x,y)	((x)=ufs_swab16_add(swab,x,-(y)))
-#define SUB_SWAB32(x,y)	((x)=ufs_swab32_add(swab,x,-(y)))
-#define SUB_SWAB64(x,y)	((x)=ufs_swab64_add(swab,x,-(y)))
+enum {
+	BYTESEX_LE,
+	BYTESEX_BE
+};
 
-#if defined(__LITTLE_ENDIAN) || defined(__BIG_ENDIAN) /* sane bytesex */
-extern __inline__ __const__ __u16 ufs_swab16(unsigned swab, __u16 x) {
-	if (swab)
-		return swab16(x);
+static __inline u64
+fs64_to_cpu(struct super_block *sbp, u64 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return le64_to_cpu(n);
 	else
-		return x;
+		return be64_to_cpu(n);
 }
-extern __inline__ __const__ __u32 ufs_swab32(unsigned swab, __u32 x) {
-	if (swab)
-		return swab32(x);
+
+static __inline u64
+cpu_to_fs64(struct super_block *sbp, u64 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return cpu_to_le64(n);
 	else
-		return x;
+		return cpu_to_be64(n);
 }
-extern __inline__ __const__ __u64 ufs_swab64(unsigned swab, __u64 x) {
-	if (swab)
-		return swab64(x);
+
+static __inline u32
+fs64_add(struct super_block *sbp, u32 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le64(le64_to_cpu(*n)+d);
 	else
-		return x;
+		return *n = cpu_to_be64(be64_to_cpu(*n)+d);
 }
-extern __inline__ __const__ __u16 ufs_swab16_add(unsigned swab, __u16 x, __u16 y) {
-	if (swab)
-		return swab16(swab16(x)+y);
+
+static __inline u32
+fs64_sub(struct super_block *sbp, u32 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le64(le64_to_cpu(*n)-d);
 	else
-		return x + y;
+		return *n = cpu_to_be64(be64_to_cpu(*n)-d);
 }
-extern __inline__ __const__ __u32 ufs_swab32_add(unsigned swab, __u32 x, __u32 y) {
-	if (swab)
-		return swab32(swab32(x)+y);
+
+static __inline u32
+fs32_to_cpu(struct super_block *sbp, u32 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return le32_to_cpu(n);
 	else
-		return x + y;
+		return be32_to_cpu(n);
 }
-extern __inline__ __const__ __u64 ufs_swab64_add(unsigned swab, __u64 x, __u64 y) {
-	if (swab)
-		return swab64(swab64(x)+y);
+
+static __inline u32
+cpu_to_fs32(struct super_block *sbp, u32 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return cpu_to_le32(n);
 	else
-		return x + y;
+		return cpu_to_be32(n);
 }
-#else /* bytesexual perversion -- BEWARE! Read note at top of file! */
-extern __inline__ __const__ __u16 ufs_swab16(unsigned swab, __u16 x) {
-	if (swab == UFS_LITTLE_ENDIAN)
-		return le16_to_cpu(x);
+
+static __inline u32
+fs32_add(struct super_block *sbp, u32 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le32(le32_to_cpu(*n)+d);
 	else
-		return be16_to_cpu(x);
+		return *n = cpu_to_be32(be32_to_cpu(*n)+d);
 }
-extern __inline__ __const__ __u32 ufs_swab32(unsigned swab, __u32 x) {
-	if (swab == UFS_LITTLE_ENDIAN)
-		return le32_to_cpu(x);
+
+static __inline u32
+fs32_sub(struct super_block *sbp, u32 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le32(le32_to_cpu(*n)-d);
 	else
-		return be32_to_cpu(x);
+		return *n = cpu_to_be32(be32_to_cpu(*n)-d);
 }
-extern __inline__ __const__ __u64 ufs_swab64(unsigned swab, __u64 x) {
-	if (swab == UFS_LITTLE_ENDIAN)
-		return le64_to_cpu(x);
+
+static __inline u16
+fs16_to_cpu(struct super_block *sbp, u16 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return le16_to_cpu(n);
 	else
-		return be64_to_cpu(x);
+		return be16_to_cpu(n);
 }
-extern __inline__ __const__ __u16 ufs_swab16_add(unsigned swab, __u16 x, __u16 y) {
-	return ufs_swab16(swab, ufs_swab16(swab, x) + y);
+
+static __inline u16
+cpu_to_fs16(struct super_block *sbp, u16 n)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return cpu_to_le16(n);
+	else
+		return cpu_to_be16(n);
 }
-extern __inline__ __const__ __u32 ufs_swab32_add(unsigned swab, __u32 x, __u32 y) {
-	return ufs_swab32(swab, ufs_swab32(swab, x) + y);
+
+static __inline u16
+fs16_add(struct super_block *sbp, u16 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le16(le16_to_cpu(*n)+d);
+	else
+		return *n = cpu_to_be16(be16_to_cpu(*n)+d);
 }
-extern __inline__ __const__ __u64 ufs_swab64_add(unsigned swab, __u64 x, __u64 y) {
-	return ufs_swab64(swab, ufs_swab64(swab, x) + y);
+
+static __inline u16
+fs16_sub(struct super_block *sbp, u16 *n, int d)
+{
+	if (sbp->u.ufs_sb.s_bytesex == BYTESEX_LE)
+		return *n = cpu_to_le16(le16_to_cpu(*n)-d);
+	else
+		return *n = cpu_to_be16(be16_to_cpu(*n)-d);
 }
-#endif /* byte sexuality */
 
 #endif /* _UFS_SWAB_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/truncate.c linux/fs/ufs/truncate.c
--- ../master/linux-2.4.14-pre3/fs/ufs/truncate.c	Sun Sep 23 21:21:01 2001
+++ linux/fs/ufs/truncate.c	Mon Oct 29 16:46:54 2001
@@ -75,12 +75,10 @@
 	unsigned frag_to_free, free_count;
 	unsigned i, j, tmp;
 	int retry;
-	unsigned swab;
 	
 	UFSD(("ENTER\n"))
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	
 	frag_to_free = 0;
@@ -110,14 +108,14 @@
 	 * Free first free fragments
 	 */
 	p = inode->u.ufs_i.i_u1.i_data + ufs_fragstoblks (frag1);
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (!tmp )
 		ufs_panic (sb, "ufs_trunc_direct", "internal error");
 	frag1 = ufs_fragnum (frag1);
 	frag2 = ufs_fragnum (frag2);
 	for (j = frag1; j < frag2; j++) {
 		bh = get_hash_table (sb->s_dev, tmp + j, uspi->s_fsize);
-		if ((bh && DATA_BUFFER_USED(bh)) || tmp != SWAB32(*p)) {
+		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 			retry = 1;
 			brelse (bh);
 			goto next1;
@@ -135,19 +133,19 @@
 	 */
 	for (i = block1 ; i < block2; i++) {
 		p = inode->u.ufs_i.i_u1.i_data + i;
-		tmp = SWAB32(*p);
+		tmp = fs32_to_cpu(sb, *p);
 		if (!tmp)
 			continue;
 		for (j = 0; j < uspi->s_fpb; j++) {
 			bh = get_hash_table (sb->s_dev, tmp + j, uspi->s_fsize);
-			if ((bh && DATA_BUFFER_USED(bh)) || tmp != SWAB32(*p)) {
+			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 				retry = 1;
 				brelse (bh);
 				goto next2;
 			}
 			bforget (bh);
 		}
-		*p = SWAB32(0);
+		*p = 0;
 		inode->i_blocks -= uspi->s_nspb;
 		mark_inode_dirty(inode);
 		if (free_count == 0) {
@@ -173,20 +171,20 @@
 	 * Free last free fragments
 	 */
 	p = inode->u.ufs_i.i_u1.i_data + ufs_fragstoblks (frag3);
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (!tmp )
 		ufs_panic(sb, "ufs_truncate_direct", "internal error");
 	frag4 = ufs_fragnum (frag4);
 	for (j = 0; j < frag4; j++) {
 		bh = get_hash_table (sb->s_dev, tmp + j, uspi->s_fsize);
-		if ((bh && DATA_BUFFER_USED(bh)) || tmp != SWAB32(*p)) {
+		if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *p)) {
 			retry = 1;
 			brelse (bh);
 			goto next1;
 		}
 		bforget (bh);
 	}
-	*p = SWAB32(0);
+	*p = 0;
 	inode->i_blocks -= frag4 << uspi->s_nspfshift;
 	mark_inode_dirty(inode);
 	ufs_free_fragments (inode, tmp, frag4);
@@ -207,47 +205,45 @@
 	unsigned indirect_block, i, j, tmp;
 	unsigned frag_to_free, free_count;
 	int retry;
-	unsigned swab;
 
 	UFSD(("ENTER\n"))
 		
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 
 	frag_to_free = 0;
 	free_count = 0;
 	retry = 0;
 	
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (!tmp)
 		return 0;
 	ind_ubh = ubh_bread (sb->s_dev, tmp, uspi->s_bsize);
-	if (tmp != SWAB32(*p)) {
+	if (tmp != fs32_to_cpu(sb, *p)) {
 		ubh_brelse (ind_ubh);
 		return 1;
 	}
 	if (!ind_ubh) {
-		*p = SWAB32(0);
+		*p = 0;
 		return 0;
 	}
 
 	indirect_block = (DIRECT_BLOCK > offset) ? (DIRECT_BLOCK - offset) : 0;
 	for (i = indirect_block; i < uspi->s_apb; i++) {
 		ind = ubh_get_addr32 (ind_ubh, i);
-		tmp = SWAB32(*ind);
+		tmp = fs32_to_cpu(sb, *ind);
 		if (!tmp)
 			continue;
 		for (j = 0; j < uspi->s_fpb; j++) {
 			bh = get_hash_table (sb->s_dev, tmp + j, uspi->s_fsize);
-			if ((bh && DATA_BUFFER_USED(bh)) || tmp != SWAB32(*ind)) {
+			if ((bh && DATA_BUFFER_USED(bh)) || tmp != fs32_to_cpu(sb, *ind)) {
 				retry = 1;
 				brelse (bh);
 				goto next;
 			}
 			bforget (bh);
 		}	
-		*ind = SWAB32(0);
+		*ind = 0;
 		ubh_mark_buffer_dirty(ind_ubh);
 		if (free_count == 0) {
 			frag_to_free = tmp;
@@ -268,15 +264,15 @@
 		ufs_free_blocks (inode, frag_to_free, free_count);
 	}
 	for (i = 0; i < uspi->s_apb; i++)
-		if (SWAB32(*ubh_get_addr32(ind_ubh,i)))
+		if (*ubh_get_addr32(ind_ubh,i))
 			break;
 	if (i >= uspi->s_apb) {
 		if (ubh_max_bcount(ind_ubh) != 1) {
 			retry = 1;
 		}
 		else {
-			tmp = SWAB32(*p);
-			*p = SWAB32(0);
+			tmp = fs32_to_cpu(sb, *p);
+			*p = 0;
 			inode->i_blocks -= uspi->s_nspb;
 			mark_inode_dirty(inode);
 			ufs_free_blocks (inode, tmp, uspi->s_fpb);
@@ -303,34 +299,32 @@
 	unsigned i, tmp, dindirect_block;
 	u32 * dind;
 	int retry = 0;
-	unsigned swab;
 	
 	UFSD(("ENTER\n"))
 	
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 
 	dindirect_block = (DIRECT_BLOCK > offset) 
 		? ((DIRECT_BLOCK - offset) >> uspi->s_apbshift) : 0;
 	retry = 0;
 	
-	tmp = SWAB32(*p);
+	tmp = fs32_to_cpu(sb, *p);
 	if (!tmp)
 		return 0;
 	dind_bh = ubh_bread (inode->i_dev, tmp, uspi->s_bsize);
-	if (tmp != SWAB32(*p)) {
+	if (tmp != fs32_to_cpu(sb, *p)) {
 		ubh_brelse (dind_bh);
 		return 1;
 	}
 	if (!dind_bh) {
-		*p = SWAB32(0);
+		*p = 0;
 		return 0;
 	}
 
 	for (i = dindirect_block ; i < uspi->s_apb ; i++) {
 		dind = ubh_get_addr32 (dind_bh, i);
-		tmp = SWAB32(*dind);
+		tmp = fs32_to_cpu(sb, *dind);
 		if (!tmp)
 			continue;
 		retry |= ufs_trunc_indirect (inode, offset + (i << uspi->s_apbshift), dind);
@@ -338,14 +332,14 @@
 	}
 
 	for (i = 0; i < uspi->s_apb; i++)
-		if (SWAB32(*ubh_get_addr32 (dind_bh, i)))
+		if (*ubh_get_addr32 (dind_bh, i))
 			break;
 	if (i >= uspi->s_apb) {
 		if (ubh_max_bcount(dind_bh) != 1)
 			retry = 1;
 		else {
-			tmp = SWAB32(*p);
-			*p = SWAB32(0);
+			tmp = fs32_to_cpu(sb, *p);
+			*p = 0;
 			inode->i_blocks -= uspi->s_nspb;
 			mark_inode_dirty(inode);
 			ufs_free_blocks (inode, tmp, uspi->s_fpb);
@@ -372,27 +366,25 @@
 	unsigned tindirect_block, tmp, i;
 	u32 * tind, * p;
 	int retry;
-	unsigned swab;
 	
 	UFSD(("ENTER\n"))
 
 	sb = inode->i_sb;
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	retry = 0;
 	
 	tindirect_block = (DIRECT_BLOCK > (UFS_NDADDR + uspi->s_apb + uspi->s_2apb))
 		? ((DIRECT_BLOCK - UFS_NDADDR - uspi->s_apb - uspi->s_2apb) >> uspi->s_2apbshift) : 0;
 	p = inode->u.ufs_i.i_u1.i_data + UFS_TIND_BLOCK;
-	if (!(tmp = SWAB32(*p)))
+	if (!(tmp = fs32_to_cpu(sb, *p)))
 		return 0;
 	tind_bh = ubh_bread (sb->s_dev, tmp, uspi->s_bsize);
-	if (tmp != SWAB32(*p)) {
+	if (tmp != fs32_to_cpu(sb, *p)) {
 		ubh_brelse (tind_bh);
 		return 1;
 	}
 	if (!tind_bh) {
-		*p = SWAB32(0);
+		*p = 0;
 		return 0;
 	}
 
@@ -403,14 +395,14 @@
 		ubh_mark_buffer_dirty(tind_bh);
 	}
 	for (i = 0; i < uspi->s_apb; i++)
-		if (SWAB32(*ubh_get_addr32 (tind_bh, i)))
+		if (*ubh_get_addr32 (tind_bh, i))
 			break;
 	if (i >= uspi->s_apb) {
 		if (ubh_max_bcount(tind_bh) != 1)
 			retry = 1;
 		else {
-			tmp = SWAB32(*p);
-			*p = SWAB32(0);
+			tmp = fs32_to_cpu(sb, *p);
+			*p = 0;
 			inode->i_blocks -= uspi->s_nspb;
 			mark_inode_dirty(inode);
 			ufs_free_blocks (inode, tmp, uspi->s_fpb);
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/fs/ufs/util.h linux/fs/ufs/util.h
--- ../master/linux-2.4.14-pre3/fs/ufs/util.h	Sun Sep 23 21:21:01 2001
+++ linux/fs/ufs/util.h	Mon Oct 29 17:13:47 2001
@@ -26,180 +26,203 @@
 /*
  * macros used for accesing structures
  */
-#define ufs_get_fs_state(usb1,usb3) _ufs_get_fs_state_(usb1,usb3,flags,swab)
-static inline __s32 _ufs_get_fs_state_(struct ufs_super_block_first * usb1,
-	struct ufs_super_block_third * usb3, unsigned flags, unsigned swab)
-{
-	switch (flags & UFS_ST_MASK) {
-		case UFS_ST_SUN:
-			return SWAB32((usb3)->fs_u2.fs_sun.fs_state);
-		case UFS_ST_SUNx86:
-			return SWAB32((usb1)->fs_u1.fs_sunx86.fs_state);
-		case UFS_ST_44BSD:
-		default:
-			return SWAB32((usb3)->fs_u2.fs_44.fs_state);
+static inline s32
+ufs_get_fs_state(struct super_block *sb, struct ufs_super_block_first *usb1,
+		 struct ufs_super_block_third *usb3)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	case UFS_ST_SUN:
+		return fs32_to_cpu(sb, usb3->fs_u2.fs_sun.fs_state);
+	case UFS_ST_SUNx86:
+		return fs32_to_cpu(sb, usb1->fs_u1.fs_sunx86.fs_state);
+	case UFS_ST_44BSD:
+	default:
+		return fs32_to_cpu(sb, usb3->fs_u2.fs_44.fs_state);
 	}
 }
 
-#define ufs_set_fs_state(usb1,usb3,value) _ufs_set_fs_state_(usb1,usb3,value,flags,swab)
-static inline void _ufs_set_fs_state_(struct ufs_super_block_first * usb1,
-	struct ufs_super_block_third * usb3, __s32 value, unsigned flags, unsigned swab)
-{
-	switch (flags & UFS_ST_MASK) {
-		case UFS_ST_SUN:
-			(usb3)->fs_u2.fs_sun.fs_state = SWAB32(value);
-			break;
-		case UFS_ST_SUNx86:
-			(usb1)->fs_u1.fs_sunx86.fs_state = SWAB32(value);
-			break;
-		case UFS_ST_44BSD:
-			(usb3)->fs_u2.fs_44.fs_state = SWAB32(value);
-			break;
+static inline void
+ufs_set_fs_state(struct super_block *sb, struct ufs_super_block_first *usb1,
+		 struct ufs_super_block_third *usb3, s32 value)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	case UFS_ST_SUN:
+		usb3->fs_u2.fs_sun.fs_state = cpu_to_fs32(sb, value);
+		break;
+	case UFS_ST_SUNx86:
+		usb1->fs_u1.fs_sunx86.fs_state = cpu_to_fs32(sb, value);
+		break;
+	case UFS_ST_44BSD:
+		usb3->fs_u2.fs_44.fs_state = cpu_to_fs32(sb, value);
+		break;
 	}
 }
 
-#define ufs_get_fs_npsect(usb1,usb3) _ufs_get_fs_npsect_(usb1,usb3,flags,swab)
-static inline __u32 _ufs_get_fs_npsect_(struct ufs_super_block_first * usb1,
-	struct ufs_super_block_third * usb3, unsigned flags, unsigned swab)
+static inline u32
+ufs_get_fs_npsect(struct super_block *sb, struct ufs_super_block_first *usb1,
+		  struct ufs_super_block_third *usb3)
 {
-	if ((flags & UFS_ST_MASK) == UFS_ST_SUNx86)
-		return SWAB32((usb3)->fs_u2.fs_sunx86.fs_npsect);
+	if ((sb->u.ufs_sb.s_flags & UFS_ST_MASK) == UFS_ST_SUNx86)
+		return fs32_to_cpu(sb, usb3->fs_u2.fs_sunx86.fs_npsect);
 	else
-		return SWAB32((usb1)->fs_u1.fs_sun.fs_npsect);
+		return fs32_to_cpu(sb, usb1->fs_u1.fs_sun.fs_npsect);
 }
 
-#define ufs_get_fs_qbmask(usb3) _ufs_get_fs_qbmask_(usb3,flags,swab)
-static inline __u64 _ufs_get_fs_qbmask_(struct ufs_super_block_third * usb3,
-	unsigned flags, unsigned swab)
-{
-	__u64 tmp;
-	switch (flags & UFS_ST_MASK) {
-		case UFS_ST_SUN:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qbmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qbmask[1];
-			break;
-		case UFS_ST_SUNx86:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qbmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qbmask[1];
-			break;
-		case UFS_ST_44BSD:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qbmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qbmask[1];
-			break;
-	}
-	return SWAB64(tmp);
-}
+static inline u64
+ufs_get_fs_qbmask(struct super_block *sb, struct ufs_super_block_third *usb3)
+{
+	u64 tmp;
 
-#define ufs_get_fs_qfmask(usb3) _ufs_get_fs_qfmask_(usb3,flags,swab)
-static inline __u64 _ufs_get_fs_qfmask_(struct ufs_super_block_third * usb3,
-	unsigned flags, unsigned swab)
-{
-	__u64 tmp;
-	switch (flags & UFS_ST_MASK) {
-		case UFS_ST_SUN:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qfmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qfmask[1];
-			break;
-		case UFS_ST_SUNx86:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qfmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qfmask[1];
-			break;
-		case UFS_ST_44BSD:
-			((u32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qfmask[0];
-			((u32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qfmask[1];
-			break;
+	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	case UFS_ST_SUN:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qbmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qbmask[1];
+		break;
+	case UFS_ST_SUNx86:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qbmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qbmask[1];
+		break;
+	case UFS_ST_44BSD:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qbmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qbmask[1];
+		break;
 	}
-	return SWAB64(tmp);
-}
 
-#define ufs_get_de_namlen(de) \
-	(((flags & UFS_DE_MASK) == UFS_DE_OLD) \
-	? SWAB16(de->d_u.d_namlen) \
-	: de->d_u.d_44.d_namlen)
-
-#define ufs_set_de_namlen(de,value) \
-	(((flags & UFS_DE_MASK) == UFS_DE_OLD) \
-	? (de->d_u.d_namlen = SWAB16(value)) \
-	: (de->d_u.d_44.d_namlen = value))
-
-#define ufs_set_de_type(de,mode) _ufs_set_de_type_(de,mode,flags,swab)
-static inline void _ufs_set_de_type_(struct ufs_dir_entry * de, int mode, 
-	unsigned flags, unsigned swab)
-{
-	if ((flags & UFS_DE_MASK) == UFS_DE_44BSD) {
-		switch (mode & S_IFMT) {
-			case S_IFSOCK: de->d_u.d_44.d_type = DT_SOCK; break;
-			case S_IFLNK: de->d_u.d_44.d_type = DT_LNK; break;
-			case S_IFREG: de->d_u.d_44.d_type = DT_REG; break;
-			case S_IFBLK: de->d_u.d_44.d_type = DT_BLK; break;
-			case S_IFDIR: de->d_u.d_44.d_type = DT_DIR; break;
-			case S_IFCHR: de->d_u.d_44.d_type = DT_CHR; break;
-			case S_IFIFO: de->d_u.d_44.d_type = DT_FIFO; break;
-			default: de->d_u.d_44.d_type = DT_UNKNOWN;
-		}
-	}
+	return fs64_to_cpu(sb, tmp);
 }
 
-#define ufs_get_inode_uid(inode) _ufs_get_inode_uid_(inode,flags,swab)
-static inline __u32 _ufs_get_inode_uid_(struct ufs_inode * inode,
-	unsigned flags, unsigned swab)
-{
-	switch (flags & UFS_UID_MASK) {
-		case UFS_UID_EFT:
-			return SWAB32(inode->ui_u3.ui_sun.ui_uid);
-		case UFS_UID_44BSD:
-			return SWAB32(inode->ui_u3.ui_44.ui_uid);
-		default:
-			return SWAB16(inode->ui_u1.oldids.ui_suid);
+static inline u64
+ufs_get_fs_qfmask(struct super_block *sb, struct ufs_super_block_third *usb3)
+{
+	u64 tmp;
+
+	switch (sb->u.ufs_sb.s_flags & UFS_ST_MASK) {
+	case UFS_ST_SUN:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sun.fs_qfmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sun.fs_qfmask[1];
+		break;
+	case UFS_ST_SUNx86:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_sunx86.fs_qfmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_sunx86.fs_qfmask[1];
+		break;
+	case UFS_ST_44BSD:
+		((u32 *)&tmp)[0] = usb3->fs_u2.fs_44.fs_qfmask[0];
+		((u32 *)&tmp)[1] = usb3->fs_u2.fs_44.fs_qfmask[1];
+		break;
 	}
+
+	return fs64_to_cpu(sb, tmp);
 }
 
-#define ufs_set_inode_uid(inode,value) _ufs_set_inode_uid_(inode,value,flags,swab)
-static inline void _ufs_set_inode_uid_(struct ufs_inode * inode, __u32 value,
-	unsigned flags, unsigned swab)
-{
-	inode->ui_u1.oldids.ui_suid = SWAB16(value); 
-	switch (flags & UFS_UID_MASK) {
-		case UFS_UID_EFT:
-			inode->ui_u3.ui_sun.ui_uid = SWAB32(value);
-			break;
-		case UFS_UID_44BSD:
-			inode->ui_u3.ui_44.ui_uid = SWAB32(value);
-			break;
-	}
+static inline u16
+ufs_get_de_namlen(struct super_block *sb, struct ufs_dir_entry *de)
+{
+	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) == UFS_DE_OLD)
+		return fs16_to_cpu(sb, de->d_u.d_namlen);
+	else
+		return de->d_u.d_44.d_namlen; /* XXX this seems wrong */
 }
 
-#define ufs_get_inode_gid(inode) _ufs_get_inode_gid_(inode,flags,swab)
-static inline __u32 _ufs_get_inode_gid_(struct ufs_inode * inode, 
-	unsigned flags, unsigned swab)
-{
-	switch (flags & UFS_UID_MASK) {
-		case UFS_UID_EFT:
-			return SWAB32(inode->ui_u3.ui_sun.ui_gid);
-		case UFS_UID_44BSD:
-			return SWAB32(inode->ui_u3.ui_44.ui_gid);
-		default:
-			return SWAB16(inode->ui_u1.oldids.ui_sgid);
-	}
+static inline void
+ufs_set_de_namlen(struct super_block *sb, struct ufs_dir_entry *de, u16 value)
+{
+	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) == UFS_DE_OLD)
+		de->d_u.d_namlen = cpu_to_fs16(sb, value);
+	else
+		de->d_u.d_44.d_namlen = value; /* XXX this seems wrong */
 }
 
-#define ufs_set_inode_gid(inode,value) _ufs_set_inode_gid_(inode,value,flags,swab)
-static inline void _ufs_set_inode_gid_(struct ufs_inode * inode, __u32 value, 
-	unsigned flags, unsigned swab)
-{
-	inode->ui_u1.oldids.ui_sgid =  SWAB16(value);
-	switch (flags & UFS_UID_MASK) {
-		case UFS_UID_EFT:
-			inode->ui_u3.ui_sun.ui_gid = SWAB32(value);
-			break;
-		case UFS_UID_44BSD:
-			inode->ui_u3.ui_44.ui_gid = SWAB32(value);
-			break;
+static inline void
+ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
+{
+	if ((sb->u.ufs_sb.s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
+		return;
+
+	/*
+	 * TODO turn this into a table lookup
+	 */
+	switch (mode & S_IFMT) {
+	case S_IFSOCK:
+		de->d_u.d_44.d_type = DT_SOCK;
+		break;
+	case S_IFLNK:
+		de->d_u.d_44.d_type = DT_LNK;
+		break;
+	case S_IFREG:
+		de->d_u.d_44.d_type = DT_REG;
+		break;
+	case S_IFBLK:
+		de->d_u.d_44.d_type = DT_BLK;
+		break;
+	case S_IFDIR:
+		de->d_u.d_44.d_type = DT_DIR;
+		break;
+	case S_IFCHR:
+		de->d_u.d_44.d_type = DT_CHR;
+		break;
+	case S_IFIFO:
+		de->d_u.d_44.d_type = DT_FIFO;
+		break;
+	default:
+		de->d_u.d_44.d_type = DT_UNKNOWN;
+	}
+}
+
+static inline u32
+ufs_get_inode_uid(struct super_block *sb, struct ufs_inode *inode)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	case UFS_UID_EFT:
+		return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_uid);
+	case UFS_UID_44BSD:
+		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_uid);
+	default:
+		return fs16_to_cpu(sb, inode->ui_u1.oldids.ui_suid);
+	}
+}
+
+static inline void
+ufs_set_inode_uid(struct super_block *sb, struct ufs_inode *inode, u32 value)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	case UFS_UID_EFT:
+		inode->ui_u3.ui_sun.ui_uid = cpu_to_fs32(sb, value);
+		break;
+	case UFS_UID_44BSD:
+		inode->ui_u3.ui_44.ui_uid = cpu_to_fs32(sb, value);
+		break;
+	}
+	inode->ui_u1.oldids.ui_suid = cpu_to_fs16(sb, value); 
+}
+
+static inline u32
+ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	case UFS_UID_EFT:
+		return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
+	case UFS_UID_44BSD:
+		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
+	default:
+		return fs16_to_cpu(sb, inode->ui_u1.oldids.ui_sgid);
+	}
+}
+
+static inline void
+ufs_set_inode_gid(struct super_block *sb, struct ufs_inode *inode, u32 value)
+{
+	switch (sb->u.ufs_sb.s_flags & UFS_UID_MASK) {
+	case UFS_UID_EFT:
+		inode->ui_u3.ui_sun.ui_gid = cpu_to_fs32(sb, value);
+		break;
+	case UFS_UID_44BSD:
+		inode->ui_u3.ui_44.ui_gid = cpu_to_fs32(sb, value);
+		break;
 	}
+	inode->ui_u1.oldids.ui_sgid =  cpu_to_fs16(sb, value);
 }
 
 
-
 /*
  * These functions manipulate ufs buffers
  */
@@ -284,8 +307,8 @@
  * percentage to hold in reserve.
  */
 #define ufs_freespace(usb, percentreserved) \
-	(ufs_blkstofrags(SWAB32((usb)->fs_cstotal.cs_nbfree)) + \
-	SWAB32((usb)->fs_cstotal.cs_nffree) - (uspi->s_dsize * (percentreserved) / 100))
+	(ufs_blkstofrags(fs32_to_cpu(sb, (usb)->fs_cstotal.cs_nbfree)) + \
+	fs32_to_cpu(sb, (usb)->fs_cstotal.cs_nffree) - (uspi->s_dsize * (percentreserved) / 100))
 
 /*
  * Macros to access cylinder group array structures
@@ -456,9 +479,7 @@
 {
 	struct ufs_sb_private_info * uspi;
 	unsigned fragsize, pos;
-	unsigned swab;
 	
-	swab = sb->u.ufs_sb.s_swab;
 	uspi = sb->u.ufs_sb.s_uspi;
 	
 	fragsize = 0;
@@ -467,12 +488,12 @@
 			fragsize++;
 		}
 		else if (fragsize > 0) {
-			ADD_SWAB32(fraglist[fragsize], cnt);
+			fs32_add(sb, &fraglist[fragsize], cnt);
 			fragsize = 0;
 		}
 	}
 	if (fragsize > 0 && fragsize < uspi->s_fpb)
-		ADD_SWAB32(fraglist[fragsize], cnt);
+		fs32_add(sb, &fraglist[fragsize], cnt);
 }
 
 #define ubh_scanc(ubh,begin,size,table,mask) _ubh_scanc_(uspi,ubh,begin,size,table,mask)
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/linux/ufs_fs.h linux/include/linux/ufs_fs.h
--- ../master/linux-2.4.14-pre3/include/linux/ufs_fs.h	Thu Oct 25 19:05:48 2001
+++ linux/include/linux/ufs_fs.h	Mon Oct 29 16:48:57 2001
@@ -96,17 +96,6 @@
 #define UFS_FSBAD     ((char)0xff)
 
 /* From here to next blank line, s_flags for ufs_sb_info */
-/* endianness */
-#define UFS_BYTESEX             0x00000001      /* mask; leave room to 0xF */
-#if defined(__LITTLE_ENDIAN) || defined(__BIG_ENDIAN)
-/* these are for sane architectures */
-#define UFS_NATIVE_ENDIAN	0x00000000
-#define UFS_SWABBED_ENDIAN	0x00000001
-#else
-/* these are for pervert architectures */
-#define UFS_LITTLE_ENDIAN	0x00000000
-#define UFS_BIG_ENDIAN		0x00000001
-#endif
 /* directory entry encoding */
 #define UFS_DE_MASK		0x00000010	/* mask for the following */
 #define UFS_DE_OLD		0x00000000
@@ -417,7 +406,8 @@
  * super block lock fs->fs_lock.
  */
 #define	CG_MAGIC	0x090255
-#define ufs_cg_chkmagic(ucg)	(SWAB32((ucg)->cg_magic) == CG_MAGIC)
+#define ufs_cg_chkmagic(sb, ucg) \
+	(fs32_to_cpu((sb), (ucg)->cg_magic) == CG_MAGIC)
 
 /*
  * size of this structure is 172 B
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/linux/ufs_fs_i.h linux/include/linux/ufs_fs_i.h
--- ../master/linux-2.4.14-pre3/include/linux/ufs_fs_i.h	Tue Jan 11 03:15:58 2000
+++ linux/include/linux/ufs_fs_i.h	Mon Oct 29 16:46:54 2001
@@ -18,7 +18,6 @@
 		__u32	i_data[15];
 		__u8	i_symlink[4*15];
 	} i_u1;
-	__u64	i_size;
 	__u32	i_flags;
 	__u32	i_gen;
 	__u32	i_shadow;
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/linux/ufs_fs_sb.h linux/include/linux/ufs_fs_sb.h
--- ../master/linux-2.4.14-pre3/include/linux/ufs_fs_sb.h	Fri Jul 20 21:52:18 2001
+++ linux/include/linux/ufs_fs_sb.h	Mon Oct 29 17:13:46 2001
@@ -118,7 +118,7 @@
 struct ufs_sb_info {
 	struct ufs_sb_private_info * s_uspi;	
 	struct ufs_csum	* s_csp[UFS_MAXCSBUFS];
-	unsigned s_swab;
+	unsigned s_bytesex;
 	unsigned s_flags;
 	struct buffer_head ** s_ucg;
 	struct ufs_cg_private_info * s_ucpi[UFS_MAX_GROUP_LOADED]; 
