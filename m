Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWEYGf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEYGf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWEYGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:35:27 -0400
Received: from mx1.mail.ru ([194.67.23.121]:42274 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S965026AbWEYGfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:35:24 -0400
Date: Thu, 25 May 2006 10:38:52 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2]: ufs: wrong type cast
Message-ID: <20060525063852.GA5100@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ugly macros in ufs code:
#define UCPI_UBH ((struct ufs_buffer_head *)ucpi)
#define USPI_UBH ((struct ufs_buffer_head *)uspi)
when uspi looks like
struct {
struct ufs_buffer_head ;
}
and USPI_UBH has some sence,
ucpi looks like
struct {
struct not_ufs_buffer_head;
}

To prevent bugs in future, this patch convert
macros to inline function and fix "ucpi" structure.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/balloc.c linux-2.6.17-rc4-mm3.mod/fs/ufs/balloc.c
--- linux-2.6.17-rc4-mm3/fs/ufs/balloc.c	2006-05-25 10:17:28.068236750 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/balloc.c	2006-05-25 10:08:52.648025000 +0400
@@ -69,7 +69,7 @@ void ufs_free_fragments(struct inode *in
 	ucpi = ufs_load_cylinder (sb, cgno);
 	if (!ucpi) 
 		goto failed;
-	ucg = ubh_get_ucg (UCPI_UBH);
+	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_free_fragments", "internal error, bad magic number on cg %u", cgno);
 		goto failed;
@@ -77,11 +77,11 @@ void ufs_free_fragments(struct inode *in
 
 	end_bit = bit + count;
 	bbase = ufs_blknum (bit);
-	blkmap = ubh_blkmap (UCPI_UBH, ucpi->c_freeoff, bbase);
+	blkmap = ubh_blkmap (UCPI_UBH(ucpi), ucpi->c_freeoff, bbase);
 	ufs_fragacct (sb, blkmap, ucg->cg_frsum, -1);
 	for (i = bit; i < end_bit; i++) {
-		if (ubh_isclr (UCPI_UBH, ucpi->c_freeoff, i))
-			ubh_setbit (UCPI_UBH, ucpi->c_freeoff, i);
+		if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_freeoff, i))
+			ubh_setbit (UCPI_UBH(ucpi), ucpi->c_freeoff, i);
 		else 
 			ufs_error (sb, "ufs_free_fragments",
 				   "bit already cleared for fragment %u", i);
@@ -93,14 +93,14 @@ void ufs_free_fragments(struct inode *in
 	fs32_add(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_add(sb, &usb1->fs_cstotal.cs_nffree, count);
 	fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
-	blkmap = ubh_blkmap (UCPI_UBH, ucpi->c_freeoff, bbase);
+	blkmap = ubh_blkmap (UCPI_UBH(ucpi), ucpi->c_freeoff, bbase);
 	ufs_fragacct(sb, blkmap, ucg->cg_frsum, 1);
 
 	/*
 	 * Trying to reassemble free fragments into block
 	 */
 	blkno = ufs_fragstoblks (bbase);
-	if (ubh_isblockset(UCPI_UBH, ucpi->c_freeoff, blkno)) {
+	if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, uspi->s_fpb);
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
@@ -114,11 +114,11 @@ void ufs_free_fragments(struct inode *in
 		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	}
 	
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
 	
@@ -176,7 +176,7 @@ do_more:
 	ucpi = ufs_load_cylinder (sb, cgno);
 	if (!ucpi) 
 		goto failed;
-	ucg = ubh_get_ucg (UCPI_UBH);
+	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_free_blocks", "internal error, bad magic number on cg %u", cgno);
 		goto failed;
@@ -184,10 +184,10 @@ do_more:
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
 		blkno = ufs_fragstoblks(i);
-		if (ubh_isblockset(UCPI_UBH, ucpi->c_freeoff, blkno)) {
+		if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
-		ubh_setblock(UCPI_UBH, ucpi->c_freeoff, blkno);
+		ubh_setblock(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
 		DQUOT_FREE_BLOCK(inode, uspi->s_fpb);
@@ -200,11 +200,11 @@ do_more:
 		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	}
 
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 
 	if (overflow) {
@@ -493,7 +493,7 @@ ufs_add_fragments (struct inode * inode,
 	ucpi = ufs_load_cylinder (sb, cgno);
 	if (!ucpi)
 		return 0;
-	ucg = ubh_get_ucg (UCPI_UBH);
+	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
 		ufs_panic (sb, "ufs_add_fragments",
 			"internal error, bad magic number on cg %u", cgno);
@@ -503,14 +503,14 @@ ufs_add_fragments (struct inode * inode,
 	fragno = ufs_dtogd (fragment);
 	fragoff = ufs_fragnum (fragno);
 	for (i = oldcount; i < newcount; i++)
-		if (ubh_isclr (UCPI_UBH, ucpi->c_freeoff, fragno + i))
+		if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_freeoff, fragno + i))
 			return 0;
 	/*
 	 * Block can be extended
 	 */
 	ucg->cg_time = cpu_to_fs32(sb, get_seconds());
 	for (i = newcount; i < (uspi->s_fpb - fragoff); i++)
-		if (ubh_isclr (UCPI_UBH, ucpi->c_freeoff, fragno + i))
+		if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_freeoff, fragno + i))
 			break;
 	fragsize = i - oldcount;
 	if (!fs32_to_cpu(sb, ucg->cg_frsum[fragsize]))
@@ -520,7 +520,7 @@ ufs_add_fragments (struct inode * inode,
 	if (fragsize != count)
 		fs32_add(sb, &ucg->cg_frsum[fragsize - count], 1);
 	for (i = oldcount; i < newcount; i++)
-		ubh_clrbit (UCPI_UBH, ucpi->c_freeoff, fragno + i);
+		ubh_clrbit (UCPI_UBH(ucpi), ucpi->c_freeoff, fragno + i);
 	if(DQUOT_ALLOC_BLOCK(inode, count)) {
 		*err = -EDQUOT;
 		return 0;
@@ -530,11 +530,11 @@ ufs_add_fragments (struct inode * inode,
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
 	
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
 
@@ -602,7 +602,7 @@ cg_found:
 	ucpi = ufs_load_cylinder (sb, cgno);
 	if (!ucpi)
 		return 0;
-	ucg = ubh_get_ucg (UCPI_UBH);
+	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) 
 		ufs_panic (sb, "ufs_alloc_fragments",
 			"internal error, bad magic number on cg %u", cgno);
@@ -625,7 +625,7 @@ cg_found:
 			return 0;
 		goal = ufs_dtogd (result);
 		for (i = count; i < uspi->s_fpb; i++)
-			ubh_setbit (UCPI_UBH, ucpi->c_freeoff, goal + i);
+			ubh_setbit (UCPI_UBH(ucpi), ucpi->c_freeoff, goal + i);
 		i = uspi->s_fpb - count;
 		DQUOT_FREE_BLOCK(inode, i);
 
@@ -644,7 +644,7 @@ cg_found:
 		return 0;
 	}
 	for (i = 0; i < count; i++)
-		ubh_clrbit (UCPI_UBH, ucpi->c_freeoff, result + i);
+		ubh_clrbit (UCPI_UBH(ucpi), ucpi->c_freeoff, result + i);
 	
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_sub(sb, &usb1->fs_cstotal.cs_nffree, count);
@@ -655,11 +655,11 @@ cg_found:
 		fs32_add(sb, &ucg->cg_frsum[allocsize - count], 1);
 
 succed:
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
 
@@ -682,7 +682,7 @@ static unsigned ufs_alloccg_block (struc
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
-	ucg = ubh_get_ucg(UCPI_UBH);
+	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 
 	if (goal == 0) {
 		goal = ucpi->c_rotor;
@@ -694,7 +694,7 @@ static unsigned ufs_alloccg_block (struc
 	/*
 	 * If the requested block is available, use it.
 	 */
-	if (ubh_isblockset(UCPI_UBH, ucpi->c_freeoff, ufs_fragstoblks(goal))) {
+	if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, ufs_fragstoblks(goal))) {
 		result = goal;
 		goto gotit;
 	}
@@ -706,7 +706,7 @@ norot:	
 	ucpi->c_rotor = result;
 gotit:
 	blkno = ufs_fragstoblks(result);
-	ubh_clrblock (UCPI_UBH, ucpi->c_freeoff, blkno);
+	ubh_clrblock (UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
 	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 		ufs_clusteracct (sb, ucpi, blkno, -1);
 	if(DQUOT_ALLOC_BLOCK(inode, uspi->s_fpb)) {
@@ -739,7 +739,7 @@ static unsigned ufs_bitmap_search (struc
 
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first (uspi);
-	ucg = ubh_get_ucg(UCPI_UBH);
+	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 
 	if (goal)
 		start = ufs_dtogd(goal) >> 3;
@@ -747,12 +747,12 @@ static unsigned ufs_bitmap_search (struc
 		start = ucpi->c_frotor >> 3;
 		
 	length = ((uspi->s_fpg + 7) >> 3) - start;
-	location = ubh_scanc(UCPI_UBH, ucpi->c_freeoff + start, length,
+	location = ubh_scanc(UCPI_UBH(ucpi), ucpi->c_freeoff + start, length,
 		(uspi->s_fpb == 8) ? ufs_fragtable_8fpb : ufs_fragtable_other,
 		1 << (count - 1 + (uspi->s_fpb & 7))); 
 	if (location == 0) {
 		length = start + 1;
-		location = ubh_scanc(UCPI_UBH, ucpi->c_freeoff, length, 
+		location = ubh_scanc(UCPI_UBH(ucpi), ucpi->c_freeoff, length,
 			(uspi->s_fpb == 8) ? ufs_fragtable_8fpb : ufs_fragtable_other,
 			1 << (count - 1 + (uspi->s_fpb & 7)));
 		if (location == 0) {
@@ -769,7 +769,7 @@ static unsigned ufs_bitmap_search (struc
 	/*
 	 * found the byte in the map
 	 */
-	blockmap = ubh_blkmap(UCPI_UBH, ucpi->c_freeoff, result);
+	blockmap = ubh_blkmap(UCPI_UBH(ucpi), ucpi->c_freeoff, result);
 	fragsize = 0;
 	for (possition = 0, mask = 1; possition < 8; possition++, mask <<= 1) {
 		if (blockmap & mask) {
@@ -808,9 +808,9 @@ static void ufs_clusteracct(struct super
 		return;
 
 	if (cnt > 0)
-		ubh_setbit(UCPI_UBH, ucpi->c_clusteroff, blkno);
+		ubh_setbit(UCPI_UBH(ucpi), ucpi->c_clusteroff, blkno);
 	else
-		ubh_clrbit(UCPI_UBH, ucpi->c_clusteroff, blkno);
+		ubh_clrbit(UCPI_UBH(ucpi), ucpi->c_clusteroff, blkno);
 
 	/*
 	 * Find the size of the cluster going forward.
@@ -819,7 +819,7 @@ static void ufs_clusteracct(struct super
 	end = start + uspi->s_contigsumsize;
 	if ( end >= ucpi->c_nclusterblks)
 		end = ucpi->c_nclusterblks;
-	i = ubh_find_next_zero_bit (UCPI_UBH, ucpi->c_clusteroff, end, start);
+	i = ubh_find_next_zero_bit (UCPI_UBH(ucpi), ucpi->c_clusteroff, end, start);
 	if (i > end)
 		i = end;
 	forw = i - start;
@@ -831,7 +831,7 @@ static void ufs_clusteracct(struct super
 	end = start - uspi->s_contigsumsize;
 	if (end < 0 ) 
 		end = -1;
-	i = ubh_find_last_zero_bit (UCPI_UBH, ucpi->c_clusteroff, start, end);
+	i = ubh_find_last_zero_bit (UCPI_UBH(ucpi), ucpi->c_clusteroff, start, end);
 	if ( i < end) 
 		i = end;
 	back = start - i;
@@ -843,11 +843,11 @@ static void ufs_clusteracct(struct super
 	i = back + forw + 1;
 	if (i > uspi->s_contigsumsize)
 		i = uspi->s_contigsumsize;
-	fs32_add(sb, (__fs32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (i << 2)), cnt);
+	fs32_add(sb, (__fs32*)ubh_get_addr(UCPI_UBH(ucpi), ucpi->c_clustersumoff + (i << 2)), cnt);
 	if (back > 0)
-		fs32_sub(sb, (__fs32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (back << 2)), cnt);
+		fs32_sub(sb, (__fs32*)ubh_get_addr(UCPI_UBH(ucpi), ucpi->c_clustersumoff + (back << 2)), cnt);
 	if (forw > 0)
-		fs32_sub(sb, (__fs32*)ubh_get_addr(UCPI_UBH, ucpi->c_clustersumoff + (forw << 2)), cnt);
+		fs32_sub(sb, (__fs32*)ubh_get_addr(UCPI_UBH(ucpi), ucpi->c_clustersumoff + (forw << 2)), cnt);
 }
 
 
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/cylinder.c linux-2.6.17-rc4-mm3.mod/fs/ufs/cylinder.c
--- linux-2.6.17-rc4-mm3/fs/ufs/cylinder.c	2006-05-25 10:10:32.626273250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/cylinder.c	2006-05-25 10:08:52.676026750 +0400
@@ -47,14 +47,14 @@ static void ufs_read_cylinder (struct su
 	ucpi = sbi->s_ucpi[bitmap_nr];
 	ucg = (struct ufs_cylinder_group *)sbi->s_ucg[cgno]->b_data;
 
-	UCPI_UBH->fragment = ufs_cgcmin(cgno);
-	UCPI_UBH->count = uspi->s_cgsize >> sb->s_blocksize_bits;
+	UCPI_UBH(ucpi)->fragment = ufs_cgcmin(cgno);
+	UCPI_UBH(ucpi)->count = uspi->s_cgsize >> sb->s_blocksize_bits;
 	/*
 	 * We have already the first fragment of cylinder group block in buffer
 	 */
-	UCPI_UBH->bh[0] = sbi->s_ucg[cgno];
-	for (i = 1; i < UCPI_UBH->count; i++)
-		if (!(UCPI_UBH->bh[i] = sb_bread(sb, UCPI_UBH->fragment + i)))
+	UCPI_UBH(ucpi)->bh[0] = sbi->s_ucg[cgno];
+	for (i = 1; i < UCPI_UBH(ucpi)->count; i++)
+		if (!(UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i)))
 			goto failed;
 	sbi->s_cgno[bitmap_nr] = cgno;
 			
@@ -103,7 +103,7 @@ void ufs_put_cylinder (struct super_bloc
 		return;
 	}
 	ucpi = sbi->s_ucpi[bitmap_nr];
-	ucg = ubh_get_ucg(UCPI_UBH);
+	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 
 	if (uspi->s_ncg > UFS_MAX_GROUP_LOADED && bitmap_nr >= sbi->s_cg_loaded) {
 		ufs_panic (sb, "ufs_put_cylinder", "internal error");
@@ -116,9 +116,9 @@ void ufs_put_cylinder (struct super_bloc
 	ucg->cg_rotor = cpu_to_fs32(sb, ucpi->c_rotor);
 	ucg->cg_frotor = cpu_to_fs32(sb, ucpi->c_frotor);
 	ucg->cg_irotor = cpu_to_fs32(sb, ucpi->c_irotor);
-	ubh_mark_buffer_dirty (UCPI_UBH);
-	for (i = 1; i < UCPI_UBH->count; i++) {
-		brelse (UCPI_UBH->bh[i]);
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
+	for (i = 1; i < UCPI_UBH(ucpi)->count; i++) {
+		brelse (UCPI_UBH(ucpi)->bh[i]);
 	}
 
 	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/ialloc.c linux-2.6.17-rc4-mm3.mod/fs/ufs/ialloc.c
--- linux-2.6.17-rc4-mm3/fs/ufs/ialloc.c	2006-05-25 10:10:32.626273250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/ialloc.c	2006-05-25 10:08:52.660025750 +0400
@@ -91,7 +91,7 @@ void ufs_free_inode (struct inode * inod
 		unlock_super (sb);
 		return;
 	}
-	ucg = ubh_get_ucg(UCPI_UBH);
+	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg))
 		ufs_panic (sb, "ufs_free_fragments", "internal error, bad cg magic number");
 
@@ -104,10 +104,10 @@ void ufs_free_inode (struct inode * inod
 
 	clear_inode (inode);
 
-	if (ubh_isclr (UCPI_UBH, ucpi->c_iusedoff, bit))
+	if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit))
 		ufs_error(sb, "ufs_free_inode", "bit already cleared for inode %u", ino);
 	else {
-		ubh_clrbit (UCPI_UBH, ucpi->c_iusedoff, bit);
+		ubh_clrbit (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit);
 		if (ino < ucpi->c_irotor)
 			ucpi->c_irotor = ino;
 		fs32_add(sb, &ucg->cg_cs.cs_nifree, 1);
@@ -121,11 +121,11 @@ void ufs_free_inode (struct inode * inod
 		}
 	}
 
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	
 	sb->s_dirt = 1;
@@ -213,14 +213,14 @@ cg_found:
 	ucpi = ufs_load_cylinder (sb, cg);
 	if (!ucpi)
 		goto failed;
-	ucg = ubh_get_ucg(UCPI_UBH);
+	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) 
 		ufs_panic (sb, "ufs_new_inode", "internal error, bad cg magic number");
 
 	start = ucpi->c_irotor;
-	bit = ubh_find_next_zero_bit (UCPI_UBH, ucpi->c_iusedoff, uspi->s_ipg, start);
+	bit = ubh_find_next_zero_bit (UCPI_UBH(ucpi), ucpi->c_iusedoff, uspi->s_ipg, start);
 	if (!(bit < uspi->s_ipg)) {
-		bit = ubh_find_first_zero_bit (UCPI_UBH, ucpi->c_iusedoff, start);
+		bit = ubh_find_first_zero_bit (UCPI_UBH(ucpi), ucpi->c_iusedoff, start);
 		if (!(bit < start)) {
 			ufs_error (sb, "ufs_new_inode",
 			    "cylinder group %u corrupted - error in inode bitmap\n", cg);
@@ -228,8 +228,8 @@ cg_found:
 		}
 	}
 	UFSD(("start = %u, bit = %u, ipg = %u\n", start, bit, uspi->s_ipg))
-	if (ubh_isclr (UCPI_UBH, ucpi->c_iusedoff, bit))
-		ubh_setbit (UCPI_UBH, ucpi->c_iusedoff, bit);
+	if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit))
+		ubh_setbit (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit);
 	else {
 		ufs_panic (sb, "ufs_new_inode", "internal error");
 		goto failed;
@@ -245,11 +245,11 @@ cg_found:
 		fs32_add(sb, &sbi->fs_cs(cg).cs_ndir, 1);
 	}
 
-	ubh_mark_buffer_dirty (USPI_UBH);
-	ubh_mark_buffer_dirty (UCPI_UBH);
+	ubh_mark_buffer_dirty (USPI_UBH(uspi));
+	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
 		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
-		ubh_wait_on_buffer (UCPI_UBH);
+		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
 
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/super.c linux-2.6.17-rc4-mm3.mod/fs/ufs/super.c
--- linux-2.6.17-rc4-mm3/fs/ufs/super.c	2006-05-25 10:10:32.658275250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/super.c	2006-05-25 10:08:52.668026250 +0400
@@ -225,7 +225,7 @@ void ufs_error (struct super_block * sb,
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
-		ubh_mark_buffer_dirty(USPI_UBH);
+		ubh_mark_buffer_dirty(USPI_UBH(uspi));
 		sb->s_dirt = 1;
 		sb->s_flags |= MS_RDONLY;
 	}
@@ -257,7 +257,7 @@ void ufs_panic (struct super_block * sb,
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
-		ubh_mark_buffer_dirty(USPI_UBH);
+		ubh_mark_buffer_dirty(USPI_UBH(uspi));
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
@@ -1014,7 +1014,7 @@ static void ufs_write_super (struct supe
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86)
 			ufs_set_fs_state(sb, usb1, usb3,
 					UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
-		ubh_mark_buffer_dirty (USPI_UBH);
+		ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	}
 	sb->s_dirt = 0;
 	UFSD(("EXIT\n"))
@@ -1083,7 +1083,7 @@ static int ufs_remount (struct super_blo
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
 			ufs_set_fs_state(sb, usb1, usb3,
 				UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
-		ubh_mark_buffer_dirty (USPI_UBH);
+		ubh_mark_buffer_dirty (USPI_UBH(uspi));
 		sb->s_dirt = 0;
 		sb->s_flags |= MS_RDONLY;
 	}
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/util.c linux-2.6.17-rc4-mm3.mod/fs/ufs/util.c
--- linux-2.6.17-rc4-mm3/fs/ufs/util.c	2006-05-25 10:17:28.076237250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/util.c	2006-05-25 10:08:52.648025000 +0400
@@ -63,17 +63,17 @@ struct ufs_buffer_head * ubh_bread_uspi 
 	count = size >> uspi->s_fshift;
 	if (count <= 0 || count > UFS_MAXFRAG)
 		return NULL;
-	USPI_UBH->fragment = fragment;
-	USPI_UBH->count = count;
+	USPI_UBH(uspi)->fragment = fragment;
+	USPI_UBH(uspi)->count = count;
 	for (i = 0; i < count; i++)
-		if (!(USPI_UBH->bh[i] = sb_bread(sb, fragment + i)))
+		if (!(USPI_UBH(uspi)->bh[i] = sb_bread(sb, fragment + i)))
 			goto failed;
 	for (; i < UFS_MAXFRAG; i++)
-		USPI_UBH->bh[i] = NULL;
-	return USPI_UBH;
+		USPI_UBH(uspi)->bh[i] = NULL;
+	return USPI_UBH(uspi);
 failed:
 	for (j = 0; j < i; j++)
-		brelse (USPI_UBH->bh[j]);
+		brelse (USPI_UBH(uspi)->bh[j]);
 	return NULL;
 }
 
@@ -90,11 +90,11 @@ void ubh_brelse (struct ufs_buffer_head 
 void ubh_brelse_uspi (struct ufs_sb_private_info * uspi)
 {
 	unsigned i;
-	if (!USPI_UBH)
+	if (!USPI_UBH(uspi))
 		return;
-	for ( i = 0; i < USPI_UBH->count; i++ ) {
-		brelse (USPI_UBH->bh[i]);
-		USPI_UBH->bh[i] = NULL;
+	for ( i = 0; i < USPI_UBH(uspi)->count; i++ ) {
+		brelse (USPI_UBH(uspi)->bh[i]);
+		USPI_UBH(uspi)->bh[i] = NULL;
 	}
 }
 
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/util.h linux-2.6.17-rc4-mm3.mod/fs/ufs/util.h
--- linux-2.6.17-rc4-mm3/fs/ufs/util.h	2006-05-25 10:17:28.076237250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/util.h	2006-05-25 10:08:52.636024250 +0400
@@ -17,10 +17,16 @@
 #define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
 
 /*
- * macros used for retyping
+ * functions used for retyping
  */
-#define UCPI_UBH ((struct ufs_buffer_head *)ucpi)
-#define USPI_UBH ((struct ufs_buffer_head *)uspi)
+static inline struct ufs_buffer_head *UCPI_UBH(struct ufs_cg_private_info *cpi)
+{
+	return &cpi->c_ubh;
+}
+static inline struct ufs_buffer_head *USPI_UBH(struct ufs_sb_private_info *spi)
+{
+	return &spi->s_ubh;
+}
 
 
 
@@ -326,10 +332,10 @@ static inline void *get_usb_offset(struc
  * Macros to access cylinder group array structures
  */
 #define ubh_cg_blktot(ucpi,cylno) \
-	(*((__fs32*)ubh_get_addr(UCPI_UBH, (ucpi)->c_btotoff + ((cylno) << 2))))
+	(*((__fs32*)ubh_get_addr(UCPI_UBH(ucpi), (ucpi)->c_btotoff + ((cylno) << 2))))
 
 #define ubh_cg_blks(ucpi,cylno,rpos) \
-	(*((__fs16*)ubh_get_addr(UCPI_UBH, \
+	(*((__fs16*)ubh_get_addr(UCPI_UBH(ucpi), \
 	(ucpi)->c_boff + (((cylno) * uspi->s_nrpos + (rpos)) << 1 ))))
 
 /*
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/include/linux/ufs_fs.h linux-2.6.17-rc4-mm3.mod/include/linux/ufs_fs.h
--- linux-2.6.17-rc4-mm3/include/linux/ufs_fs.h	2006-05-25 10:17:31.920477500 +0400
+++ linux-2.6.17-rc4-mm3.mod/include/linux/ufs_fs.h	2006-05-25 10:08:52.680027000 +0400
@@ -666,7 +666,7 @@ struct ufs_buffer_head {
 };
 
 struct ufs_cg_private_info {
-	struct ufs_cylinder_group ucg;
+	struct ufs_buffer_head c_ubh;
 	__u32	c_cgx;		/* number of cylidner group */
 	__u16	c_ncyl;		/* number of cyl's this cg */
 	__u16	c_niblk;	/* number of inode blocks this cg */

-- 
/Evgeniy

