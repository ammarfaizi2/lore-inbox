Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUGKKyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUGKKyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUGKKyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:54:23 -0400
Received: from dsl-prvgw1cc4.dial.inet.fi ([80.223.50.196]:12929 "EHLO
	dsl-prvgw1cc4.dial.inet.fi") by vger.kernel.org with ESMTP
	id S266554AbUGKKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:54:10 -0400
Date: Sun, 11 Jul 2004 13:54:09 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: xfs-masters@oss.sgi.com, nathans@sgi.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix XFS uses of plain integer as NULL pointer
Message-ID: <Pine.LNX.4.58.0407111343260.1846@dsl-prvgw1cc4.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch will fix XFS sparse warnings about using plain integer as NULL
pointer.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>

--- linux-2.6/fs/xfs/linux-2.6/xfs_stats.c.orig	2004-07-11 12:26:13.000000000 +0300
+++ linux-2.6/fs/xfs/linux-2.6/xfs_stats.c	2004-07-11 12:33:28.000000000 +0300
@@ -119,9 +119,9 @@
 void
 xfs_init_procfs(void)
 {
-	if (!proc_mkdir("fs/xfs", 0))
+	if (!proc_mkdir("fs/xfs", NULL))
 		return;
-	create_proc_read_entry("fs/xfs/stat", 0, 0, xfs_read_xfsstats, NULL);
+	create_proc_read_entry("fs/xfs/stat", 0, NULL, xfs_read_xfsstats, NULL);
 }

 void

--- linux-2.6/fs/xfs/linux-2.6/xfs_aops.c.orig	2004-07-11 13:09:32.000000000 +0300
+++ linux-2.6/fs/xfs/linux-2.6/xfs_aops.c	2004-07-11 13:09:53.000000000 +0300
@@ -264,7 +264,7 @@

 	page = find_trylock_page(mapping, index);
 	if (!page)
-		return 0;
+		return NULL;
 	if (PageWriteback(page))
 		goto out;


--- linux-2.6/fs/xfs/quota/xfs_dquot.c.orig	2004-07-11 13:22:39.000000000 +0300
+++ linux-2.6/fs/xfs/quota/xfs_dquot.c	2004-07-11 13:23:01.000000000 +0300
@@ -145,7 +145,7 @@
 		 dqp->q_res_icount = 0;
 		 dqp->q_res_rtbcount = 0;
 		 dqp->q_pincount = 0;
-		 dqp->q_hash = 0;
+		 dqp->q_hash = NULL;
 		 ASSERT(dqp->dq_flnext == dqp->dq_flprev);

 #ifdef XFS_DQUOT_TRACE

--- linux-2.6/fs/xfs/quota/xfs_qm_stats.c.orig	2004-07-11 13:24:26.000000000 +0300
+++ linux-2.6/fs/xfs/quota/xfs_qm_stats.c	2004-07-11 13:27:34.000000000 +0300
@@ -137,8 +137,10 @@
 void
 xfs_qm_init_procfs(void)
 {
-	create_proc_read_entry("fs/xfs/xqmstat", 0, 0, xfs_qm_read_stats, NULL);
-	create_proc_read_entry("fs/xfs/xqm", 0, 0, xfs_qm_read_xfsquota, NULL);
+	create_proc_read_entry("fs/xfs/xqmstat", 0, NULL, xfs_qm_read_stats,
+			NULL);
+	create_proc_read_entry("fs/xfs/xqm", 0, NULL, xfs_qm_read_xfsquota,
+			NULL);
 }

 void

--- linux-2.6/fs/xfs/linux-2.6/xfs_super.c.orig	2004-07-11 13:29:30.000000000 +0300
+++ linux-2.6/fs/xfs/linux-2.6/xfs_super.c	2004-07-11 13:29:46.000000000 +0300
@@ -573,7 +573,7 @@

 	dotdot.d_name.name = "..";
 	dotdot.d_name.len = 2;
-	dotdot.d_inode = 0;
+	dotdot.d_inode = NULL;

 	cvp = NULL;
 	vp = LINVFS_GET_VP(child->d_inode);

--- linux-2.6/fs/xfs/xfs_alloc.c.orig	2004-07-11 12:38:21.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_alloc.c	2004-07-11 12:45:29.000000000 +0300
@@ -665,7 +665,7 @@
 	 * Allocate/initialize a cursor for the by-number freespace btree.
 	 */
 	bno_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_BNO, 0, 0);
+		args->agno, XFS_BTNUM_BNO, NULL, 0);
 	/*
 	 * Lookup bno and minlen in the btree (minlen is irrelevant, really).
 	 * Look for the closest free block <= bno, it must contain bno
@@ -721,7 +721,7 @@
 	 * Allocate/initialize a cursor for the by-size btree.
 	 */
 	cnt_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_CNT, 0, 0);
+		args->agno, XFS_BTNUM_CNT, NULL, 0);
 	ASSERT(args->agbno + args->len <=
 		INT_GET(XFS_BUF_TO_AGF(args->agbp)->agf_length,
 			ARCH_CONVERT));
@@ -788,7 +788,7 @@
 	 * Get a cursor for the by-size btree.
 	 */
 	cnt_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_CNT, 0, 0);
+		args->agno, XFS_BTNUM_CNT, NULL, 0);
 	ltlen = 0;
 	bno_cur_lt = bno_cur_gt = NULL;
 	/*
@@ -916,7 +916,7 @@
 		 * Set up a cursor for the by-bno tree.
 		 */
 		bno_cur_lt = xfs_btree_init_cursor(args->mp, args->tp,
-			args->agbp, args->agno, XFS_BTNUM_BNO, 0, 0);
+			args->agbp, args->agno, XFS_BTNUM_BNO, NULL, 0);
 		/*
 		 * Fix up the btree entries.
 		 */
@@ -944,7 +944,7 @@
 	 * Allocate and initialize the cursor for the leftward search.
 	 */
 	bno_cur_lt = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_BNO, 0, 0);
+		args->agno, XFS_BTNUM_BNO, NULL, 0);
 	/*
 	 * Lookup <= bno to find the leftward search's starting point.
 	 */
@@ -956,7 +956,7 @@
 		 * search.
 		 */
 		bno_cur_gt = bno_cur_lt;
-		bno_cur_lt = 0;
+		bno_cur_lt = NULL;
 	}
 	/*
 	 * Found something.  Duplicate the cursor for the rightward search.
@@ -1301,7 +1301,7 @@
 	 * Allocate and initialize a cursor for the by-size btree.
 	 */
 	cnt_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_CNT, 0, 0);
+		args->agno, XFS_BTNUM_CNT, NULL, 0);
 	bno_cur = NULL;
 	/*
 	 * Look for an entry >= maxlen+alignment-1 blocks.
@@ -1406,7 +1406,7 @@
 	 * Allocate and initialize a cursor for the by-block tree.
 	 */
 	bno_cur = xfs_btree_init_cursor(args->mp, args->tp, args->agbp,
-		args->agno, XFS_BTNUM_BNO, 0, 0);
+		args->agno, XFS_BTNUM_BNO, NULL, 0);
 	if ((error = xfs_alloc_fixup_trees(cnt_cur, bno_cur, fbno, flen,
 			rbno, rlen, XFSA_FIXUP_CNT_OK)))
 		goto error0;
@@ -1553,8 +1553,8 @@
 	/*
 	 * Allocate and initialize a cursor for the by-block btree.
 	 */
-	bno_cur = xfs_btree_init_cursor(mp, tp, agbp, agno, XFS_BTNUM_BNO, 0,
-		0);
+	bno_cur = xfs_btree_init_cursor(mp, tp, agbp, agno, XFS_BTNUM_BNO,
+			NULL, 0);
 	cnt_cur = NULL;
 	/*
 	 * Look for a neighboring block on the left (lower block numbers)
@@ -1613,8 +1613,8 @@
 	/*
 	 * Now allocate and initialize a cursor for the by-size tree.
 	 */
-	cnt_cur = xfs_btree_init_cursor(mp, tp, agbp, agno, XFS_BTNUM_CNT, 0,
-		0);
+	cnt_cur = xfs_btree_init_cursor(mp, tp, agbp, agno, XFS_BTNUM_CNT,
+			NULL, 0);
 	/*
 	 * Have both left and right contiguous neighbors.
 	 * Merge all three into a single free block.

--- linux-2.6/fs/xfs/xfs_alloc_btree.c.orig	2004-07-11 12:48:08.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_alloc_btree.c	2004-07-11 12:48:56.000000000 +0300
@@ -263,7 +263,7 @@
 			/*
 			 * Update the cursor so there's one fewer level.
 			 */
-			xfs_btree_setbuf(cur, level, 0);
+			xfs_btree_setbuf(cur, level, NULL);
 			cur->bc_nlevels--;
 		} else if (level > 0 &&
 			   (error = xfs_alloc_decrement(cur, level, &i)))

--- linux-2.6/fs/xfs/xfs_bmap_btree.c.orig	2004-07-11 12:50:30.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_bmap_btree.c	2004-07-11 12:51:11.000000000 +0300
@@ -1953,7 +1953,7 @@
 		*bpp = cur->bc_bufs[level];
 		rval = XFS_BUF_TO_BMBT_BLOCK(*bpp);
 	} else {
-		*bpp = 0;
+		*bpp = NULL;
 		ifp = XFS_IFORK_PTR(cur->bc_private.b.ip,
 			cur->bc_private.b.whichfork);
 		rval = ifp->if_broot;

--- linux-2.6/fs/xfs/xfs_da_btree.c.orig	2004-07-11 12:54:29.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_da_btree.c	2004-07-11 12:55:22.000000000 +0300
@@ -2092,7 +2092,7 @@
 	int		caller,
 	inst_t		*ra)
 {
-	xfs_buf_t	*bp = 0;
+	xfs_buf_t	*bp = NULL;
 	xfs_buf_t	**bplist;
 	int		error=0;
 	int		i;

--- linux-2.6/fs/xfs/xfs_log.c.orig	2004-07-11 12:56:27.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_log.c	2004-07-11 13:00:21.000000000 +0300
@@ -356,13 +356,13 @@
 	if (!xlog_debug && xlog_target == log->l_targ)
 		return 0;
 #endif
-	cb->cb_next = 0;
+	cb->cb_next = NULL;
 	spl = LOG_LOCK(log);
 	abortflg = (iclog->ic_state & XLOG_STATE_IOERROR);
 	if (!abortflg) {
 		ASSERT_ALWAYS((iclog->ic_state == XLOG_STATE_ACTIVE) ||
 			      (iclog->ic_state == XLOG_STATE_WANT_SYNC));
-		cb->cb_next = 0;
+		cb->cb_next = NULL;
 		*(iclog->ic_callback_tail) = cb;
 		iclog->ic_callback_tail = &(cb->cb_next);
 	}
@@ -564,7 +564,7 @@
 	xlog_in_core_t	 *first_iclog;
 #endif
 	xfs_log_iovec_t  reg[1];
-	xfs_log_ticket_t tic = 0;
+	xfs_log_ticket_t tic = NULL;
 	xfs_lsn_t	 lsn;
 	int		 error;
 	SPLDECL(s);
@@ -1277,7 +1277,7 @@
 	int		error;
 	xfs_log_iovec_t	reg[1];

-	reg[0].i_addr = 0;
+	reg[0].i_addr = NULL;
 	reg[0].i_len = 0;

 	ASSERT_ALWAYS(iclog);
@@ -1856,8 +1856,8 @@
 	do {
 		if (iclog->ic_state == XLOG_STATE_DIRTY) {
 			iclog->ic_state	= XLOG_STATE_ACTIVE;
-			iclog->ic_offset       = 0;
-			iclog->ic_callback	= 0;   /* don't need to free */
+			iclog->ic_offset = 0;
+			iclog->ic_callback = NULL; /* don't need to free */
 			/*
 			 * If the number of ops in this iclog indicate it just
 			 * contains the dummy transaction, we can
@@ -2080,7 +2080,7 @@

 			while (cb != 0) {
 				iclog->ic_callback_tail = &(iclog->ic_callback);
-				iclog->ic_callback = 0;
+				iclog->ic_callback = NULL;
 				LOG_UNLOCK(log, s);

 				/* perform callbacks in the order given */
@@ -3098,7 +3098,7 @@
 		log->l_ticket_cnt++;
 		log->l_ticket_tcnt++;
 	}
-	t_list->t_next = 0;
+	t_list->t_next = NULL;
 	log->l_tail = t_list;
 	LOG_UNLOCK(log, s);
 }	/* xlog_state_ticket_alloc */
@@ -3126,7 +3126,7 @@
 	/* no need to clear fields */
 #else
 	/* When we debug, it is easier if tickets are cycled */
-	ticket->t_next     = 0;
+	ticket->t_next = NULL;
 	if (log->l_tail != 0) {
 		log->l_tail->t_next = ticket;
 	} else {

--- linux-2.6/fs/xfs/xfs_log_recover.c.orig	2004-07-11 13:01:52.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_log_recover.c	2004-07-11 13:02:45.000000000 +0300
@@ -2319,7 +2319,7 @@
 		 * invalidate the buffer when we write it out below.
 		 */
 		imap.im_blkno = 0;
-		xfs_imap(log->l_mp, 0, ino, &imap, 0);
+		xfs_imap(log->l_mp, NULL, ino, &imap, 0);
 	}

 	/*

--- linux-2.6/fs/xfs/xfs_mount.c.orig	2004-07-11 13:04:23.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_mount.c	2004-07-11 13:04:45.000000000 +0300
@@ -633,7 +633,7 @@
 	xfs_buf_t	*bp;
 	xfs_sb_t	*sbp = &(mp->m_sb);
 	xfs_inode_t	*rip;
-	vnode_t		*rvp = 0;
+	vnode_t		*rvp = NULL;
 	int		readio_log, writeio_log;
 	vmap_t		vmap;
 	xfs_daddr_t	d;

--- linux-2.6/fs/xfs/xfs_trans_item.c.orig	2004-07-11 13:06:05.000000000 +0300
+++ linux-2.6/fs/xfs/xfs_trans_item.c	2004-07-11 13:07:27.000000000 +0300
@@ -290,7 +290,7 @@
 	}
 	ASSERT(0);
 	/* NOTREACHED */
-	return 0; /* keep gcc quite */
+	return NULL; /* keep gcc and sparse quiet */
 }

 /*

