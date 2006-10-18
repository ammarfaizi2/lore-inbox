Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWJRKyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWJRKyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWJRKyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:54:36 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:35018 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751030AbWJRKyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:54:35 -0400
Subject: Re: [PATCH] fs/xfs: Handcrafted MIN/MAX macro removal
From: Amol Lad <amol@verismonetworks.com>
To: xfs-masters@oss.sgi.com
Cc: linux kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:27:48 +0530
Message-Id: <1161169068.20400.149.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incroporated comments from Christoph Hellwig

Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
macros are changed to use macros in kernel.h

Tested using allmodconfig

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Christoph, 

I'm going on vacation. If you have more comments, I'll take them after I
come back after 5 days..

Thanks
---
 xfs_alloc.c   |   24 +++++++++++-------------
 xfs_bmap.c    |   32 ++++++++++++++------------------
 xfs_btree.h   |   29 -----------------------------
 xfs_inode.c   |    2 +-
 xfs_iomap.c   |    2 +-
 xfs_rtalloc.c |   16 ++++++++--------
 xfs_rtalloc.h |    3 ---
 7 files changed, 35 insertions(+), 73 deletions(-)
---
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_alloc.c linux-2.6.19-rc2/fs/xfs/xfs_alloc.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_alloc.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_alloc.c	2006-10-18 16:13:44.000000000 +0530
@@ -151,11 +151,11 @@ xfs_alloc_compute_diff(
 		if (newbno1 >= freeend)
 			newbno1 = NULLAGBLOCK;
 		else
-			newlen1 = XFS_EXTLEN_MIN(wantlen, freeend - newbno1);
+			newlen1 = min_t(xfs_extlen_t, wantlen, freeend - newbno1);
 		if (newbno2 < freebno)
 			newbno2 = NULLAGBLOCK;
 		else
-			newlen2 = XFS_EXTLEN_MIN(wantlen, freeend - newbno2);
+			newlen2 = min_t(xfs_extlen_t, wantlen, freeend - newbno2);
 		if (newbno1 != NULLAGBLOCK && newbno2 != NULLAGBLOCK) {
 			if (newlen1 < newlen2 ||
 			    (newlen1 == newlen2 &&
@@ -686,7 +686,7 @@ xfs_alloc_ag_vextent_exact(
 	 * End of extent will be smaller of the freespace end and the
 	 * maximal requested end.
 	 */
-	end = XFS_AGBLOCK_MIN(fend, maxend);
+	end = min_t(xfs_agblock_t, fend, maxend);
 	/*
 	 * Fix the length according to mod and prod if given.
 	 */
@@ -850,7 +850,7 @@ xfs_alloc_ag_vextent_near(
 					args->alignment, args->minlen,
 					&ltbnoa, &ltlena))
 				continue;
-			args->len = XFS_EXTLEN_MIN(ltlena, args->maxlen);
+			args->len = min_t(xfs_extlen_t, ltlena, args->maxlen);
 			xfs_alloc_fix_len(args);
 			ASSERT(args->len >= args->minlen);
 			if (args->len < blen)
@@ -1007,7 +1007,7 @@ xfs_alloc_ag_vextent_near(
 			/*
 			 * Fix up the length.
 			 */
-			args->len = XFS_EXTLEN_MIN(ltlena, args->maxlen);
+			args->len = min_t(xfs_extlen_t, ltlena, args->maxlen);
 			xfs_alloc_fix_len(args);
 			rlen = args->len;
 			ltdiff = xfs_alloc_compute_diff(args->agbno, rlen,
@@ -1045,8 +1045,7 @@ xfs_alloc_ag_vextent_near(
 					 */
 					if (gtlena >= args->minlen) {
 						args->len =
-							XFS_EXTLEN_MIN(gtlena,
-								args->maxlen);
+							min_t(xfs_extlen_t, gtlena, args->maxlen);
 						xfs_alloc_fix_len(args);
 						rlen = args->len;
 						gtdiff = xfs_alloc_compute_diff(
@@ -1104,7 +1103,7 @@ xfs_alloc_ag_vextent_near(
 			/*
 			 * Fix up the length.
 			 */
-			args->len = XFS_EXTLEN_MIN(gtlena, args->maxlen);
+			args->len = min_t(xfs_extlen_t, gtlena, args->maxlen);
 			xfs_alloc_fix_len(args);
 			rlen = args->len;
 			gtdiff = xfs_alloc_compute_diff(args->agbno, rlen,
@@ -1141,8 +1140,7 @@ xfs_alloc_ag_vextent_near(
 					 * compare the two and pick the best.
 					 */
 					if (ltlena >= args->minlen) {
-						args->len = XFS_EXTLEN_MIN(
-							ltlena, args->maxlen);
+						args->len = min_t(xfs_extlen_t, ltlena, args->maxlen);
 						xfs_alloc_fix_len(args);
 						rlen = args->len;
 						ltdiff = xfs_alloc_compute_diff(
@@ -1221,7 +1219,7 @@ xfs_alloc_ag_vextent_near(
 	 * Fix up the length and compute the useful address.
 	 */
 	ltend = ltbno + ltlen;
-	args->len = XFS_EXTLEN_MIN(ltlena, args->maxlen);
+	args->len = min_t(xfs_extlen_t, ltlena, args->maxlen);
 	xfs_alloc_fix_len(args);
 	if (!xfs_alloc_fix_minleft(args)) {
 		TRACE_ALLOC("nominleft", args);
@@ -1320,7 +1318,7 @@ xfs_alloc_ag_vextent_size(
 	 */
 	xfs_alloc_compute_aligned(fbno, flen, args->alignment, args->minlen,
 		&rbno, &rlen);
-	rlen = XFS_EXTLEN_MIN(args->maxlen, rlen);
+	rlen = min_t(xfs_extlen_t, args->maxlen, rlen);
 	XFS_WANT_CORRUPTED_GOTO(rlen == 0 ||
 			(rlen <= flen && rbno + rlen <= fbno + flen), error0);
 	if (rlen < args->maxlen) {
@@ -1346,7 +1344,7 @@ xfs_alloc_ag_vextent_size(
 				break;
 			xfs_alloc_compute_aligned(fbno, flen, args->alignment,
 				args->minlen, &rbno, &rlen);
-			rlen = XFS_EXTLEN_MIN(args->maxlen, rlen);
+			rlen = min_t(xfs_extlen_t, args->maxlen, rlen);
 			XFS_WANT_CORRUPTED_GOTO(rlen == 0 ||
 				(rlen <= flen && rbno + rlen <= fbno + flen),
 				error0);
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_bmap.c linux-2.6.19-rc2/fs/xfs/xfs_bmap.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_bmap.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_bmap.c	2006-10-18 16:17:59.000000000 +0530
@@ -1005,7 +1005,7 @@ xfs_bmap_add_extent_delay_real(
 					LEFT.br_state)))
 				goto done;
 		}
-		temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
+		temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
 			STARTBLOCKVAL(PREV.br_startblock));
 		xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
 		xfs_bmap_trace_post_update(fname, "LF|LC", ip, idx,
@@ -1054,7 +1054,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
-		temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
+		temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
 			STARTBLOCKVAL(PREV.br_startblock) -
 			(cur ? cur->bc_private.b.allocated : 0));
 		ep = xfs_iext_get_ext(ifp, idx + 1);
@@ -1101,7 +1101,7 @@ xfs_bmap_add_extent_delay_real(
 					RIGHT.br_state)))
 				goto done;
 		}
-		temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
+		temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
 			STARTBLOCKVAL(PREV.br_startblock));
 		xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
 		xfs_bmap_trace_post_update(fname, "RF|RC", ip, idx,
@@ -1149,7 +1149,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
-		temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
+		temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
 			STARTBLOCKVAL(PREV.br_startblock) -
 			(cur ? cur->bc_private.b.allocated : 0));
 		ep = xfs_iext_get_ext(ifp, idx);
@@ -3186,8 +3186,7 @@ xfs_bmap_del_extent(
 		xfs_bmbt_set_blockcount(ep, temp);
 		ifp->if_lastex = idx;
 		if (delay) {
-			temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
-				da_old);
+			temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp), da_old);
 			xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
 			xfs_bmap_trace_post_update(fname, "2", ip, idx,
 				whichfork);
@@ -3215,8 +3214,7 @@ xfs_bmap_del_extent(
 		xfs_bmbt_set_blockcount(ep, temp);
 		ifp->if_lastex = idx;
 		if (delay) {
-			temp = XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
-				da_old);
+			temp = min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp), da_old);
 			xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
 			xfs_bmap_trace_post_update(fname, "1", ip, idx,
 				whichfork);
@@ -4346,7 +4344,7 @@ xfs_bmap_first_unused(
 			return 0;
 		}
 		lastaddr = off + xfs_bmbt_get_blockcount(ep);
-		max = XFS_FILEOFF_MAX(lastaddr, lowest);
+		max = max_t(xfs_fileoff_t, lastaddr, lowest);
 	}
 	*first_unused = max;
 	return 0;
@@ -4861,17 +4859,15 @@ xfs_bmapi(
 				}
 			} else if (wasdelay) {
 				alen = (xfs_extlen_t)
-					XFS_FILBLKS_MIN(len,
-						(got.br_startoff +
-						 got.br_blockcount) - bno);
+					min_t(xfs_filblks_t, len,
+						(got.br_startoff + got.br_blockcount) - bno);
 				aoff = bno;
 			} else {
 				alen = (xfs_extlen_t)
-					XFS_FILBLKS_MIN(len, MAXEXTLEN);
+					min_t(xfs_filblks_t, len, MAXEXTLEN);
 				if (!eof)
 					alen = (xfs_extlen_t)
-						XFS_FILBLKS_MIN(alen,
-							got.br_startoff - bno);
+						min_t(xfs_filblks_t, alen, got.br_startoff - bno);
 				aoff = bno;
 			}
 			minlen = (flags & XFS_BMAPI_CONTIG) ? alen : 1;
@@ -5098,7 +5094,7 @@ xfs_bmapi(
 			mval->br_startoff = bno;
 			mval->br_startblock = HOLESTARTBLOCK;
 			mval->br_blockcount =
-				XFS_FILBLKS_MIN(len, got.br_startoff - bno);
+				min_t(xfs_filblks_t, len, got.br_startoff - bno);
 			mval->br_state = XFS_EXT_NORM;
 			bno += mval->br_blockcount;
 			len -= mval->br_blockcount;
@@ -5133,7 +5129,7 @@ xfs_bmapi(
 			 * didn't overlap what was asked for.
 			 */
 			mval->br_blockcount =
-				XFS_FILBLKS_MIN(end - bno, got.br_blockcount -
+				min_t(xfs_filblks_t, end - bno, got.br_blockcount -
 					(bno - got.br_startoff));
 			mval->br_state = got.br_state;
 			ASSERT(mval->br_blockcount <= len);
@@ -5473,7 +5469,7 @@ xfs_bunmapi(
 		 * Is the last block of this extent before the range
 		 * we're supposed to delete?  If so, we're done.
 		 */
-		bno = XFS_FILEOFF_MIN(bno,
+		bno = min_t(xfs_fileoff_t, bno,
 			got.br_startoff + got.br_blockcount - 1);
 		if (bno < start)
 			break;
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h linux-2.6.19-rc2/fs/xfs/xfs_btree.h
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_btree.h	2006-10-18 15:56:01.000000000 +0530
@@ -440,35 +440,6 @@ xfs_btree_setbuf(
 
 #endif	/* __KERNEL__ */
 
-
-/*
- * Min and max functions for extlen, agblock, fileoff, and filblks types.
- */
-#define	XFS_EXTLEN_MIN(a,b)	\
-	((xfs_extlen_t)(a) < (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_EXTLEN_MAX(a,b)	\
-	((xfs_extlen_t)(a) > (xfs_extlen_t)(b) ? \
-		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
-#define	XFS_AGBLOCK_MIN(a,b)	\
-	((xfs_agblock_t)(a) < (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_AGBLOCK_MAX(a,b)	\
-	((xfs_agblock_t)(a) > (xfs_agblock_t)(b) ? \
-		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
-#define	XFS_FILEOFF_MIN(a,b)	\
-	((xfs_fileoff_t)(a) < (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILEOFF_MAX(a,b)	\
-	((xfs_fileoff_t)(a) > (xfs_fileoff_t)(b) ? \
-		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
-#define	XFS_FILBLKS_MIN(a,b)	\
-	((xfs_filblks_t)(a) < (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
-#define	XFS_FILBLKS_MAX(a,b)	\
-	((xfs_filblks_t)(a) > (xfs_filblks_t)(b) ? \
-		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
-
 #define	XFS_FSB_SANITY_CHECK(mp,fsb)	\
 	(XFS_FSB_TO_AGNO(mp, fsb) < mp->m_sb.sb_agcount && \
 		XFS_FSB_TO_AGBNO(mp, fsb) < mp->m_sb.sb_agblocks)
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_inode.c linux-2.6.19-rc2/fs/xfs/xfs_inode.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_inode.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_inode.c	2006-10-18 16:18:41.000000000 +0530
@@ -1342,7 +1342,7 @@ xfs_file_last_byte(
 		last_block = 0;
 	}
 	size_last_block = XFS_B_TO_FSB(mp, (xfs_ufsize_t)ip->i_d.di_size);
-	last_block = XFS_FILEOFF_MAX(last_block, size_last_block);
+	last_block = max_t(xfs_fileoff_t, last_block, size_last_block);
 
 	last_byte = XFS_FSB_TO_B(mp, last_block);
 	if (last_byte < 0) {
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_iomap.c linux-2.6.19-rc2/fs/xfs/xfs_iomap.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_iomap.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_iomap.c	2006-10-18 15:54:13.000000000 +0530
@@ -822,7 +822,7 @@ xfs_iomap_write_allocate(
 			end_fsb = XFS_B_TO_FSB(mp, ip->i_d.di_size);
 			xfs_bmap_last_offset(NULL, ip, &last_block,
 				XFS_DATA_FORK);
-			last_block = XFS_FILEOFF_MAX(last_block, end_fsb);
+			last_block = max_t(xfs_fileoff_t,last_block, end_fsb);
 			if ((map_start_fsb + count_fsb) > last_block) {
 				count_fsb = last_block - map_start_fsb;
 				if (count_fsb == 0) {
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.c linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.c	2006-10-18 09:29:18.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c	2006-10-18 16:06:37.000000000 +0530
@@ -699,8 +699,8 @@ xfs_rtallocate_extent_size(
 			 * this summary level.
 			 */
 			error = xfs_rtallocate_extent_block(mp, tp, i,
-					XFS_RTMAX(minlen, 1 << l),
-					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
+					max_t(xfs_extlen_t, minlen, 1 << l),
+					min_t(xfs_extlen_t, maxlen, (1 << (l + 1)) - 1),
 					len, &n, rbpp, rsb, prod, &r);
 			if (error) {
 				return error;
@@ -1020,7 +1020,7 @@ xfs_rtcheck_range(
 		/*
 		 * Compute first bit not examined.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min_t(xfs_extlen_t, bit + len, XFS_NBWORD);
 		/*
 		 * Mask of relevant bits.
 		 */
@@ -1238,7 +1238,7 @@ xfs_rtfind_back(
 		 * Calculate first (leftmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		firstbit = XFS_RTMAX((xfs_srtblock_t)(bit - len + 1), 0);
+		firstbit = max_t(xfs_srtblock_t, bit - len + 1, 0);
 		mask = (((xfs_rtword_t)1 << (bit - firstbit + 1)) - 1) <<
 			firstbit;
 		/*
@@ -1413,7 +1413,7 @@ xfs_rtfind_forw(
 		 * Calculate last (rightmost) bit number to look at,
 		 * and mask for all the relevant bits in this word.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min_t(xfs_rtblock_t, bit + len, XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Calculate the difference between the value there
@@ -1724,7 +1724,7 @@ xfs_rtmodify_range(
 		/*
 		 * Compute first bit not changed and mask of relevant bits.
 		 */
-		lastbit = XFS_RTMIN(bit + len, XFS_NBWORD);
+		lastbit = min_t(xfs_extlen_t, bit + len, XFS_NBWORD);
 		mask = (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
 		/*
 		 * Set/clear the active bits.
@@ -1998,7 +1998,7 @@ xfs_growfs_rt(
 		nsbp->sb_rextsize = in->extsize;
 		nsbp->sb_rbmblocks = bmbno + 1;
 		nsbp->sb_rblocks =
-			XFS_RTMIN(nrblocks,
+			min_t(xfs_drfsbno_t, nrblocks,
 				  nsbp->sb_rbmblocks * NBBY *
 				  nsbp->sb_blocksize * nsbp->sb_rextsize);
 		nsbp->sb_rextents = nsbp->sb_rblocks;
@@ -2424,7 +2424,7 @@ xfs_rtprint_summary(
 			if (c) {
 				if (!p) {
 					cmn_err(CE_DEBUG, "%Ld-%Ld:", 1LL << l,
-						XFS_RTMIN((1LL << l) +
+						min((1LL << l) +
 							  ((1LL << l) - 1LL),
 							 mp->m_sb.sb_rextents));
 					p = 1;
diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.h linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h
--- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.h	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h	2006-10-18 15:46:53.000000000 +0530
@@ -57,9 +57,6 @@ struct xfs_trans;
 #define	XFS_BITTOWORD(mp,bi)	\
 	((int)(((bi) >> XFS_NBWORDLOG) & XFS_BLOCKWMASK(mp)))
 
-#define	XFS_RTMIN(a,b)	((a) < (b) ? (a) : (b))
-#define	XFS_RTMAX(a,b)	((a) > (b) ? (a) : (b))
-
 #define	XFS_RTLOBIT(w)	xfs_lowbit32(w)
 #define	XFS_RTHIBIT(w)	xfs_highbit32(w)
 


