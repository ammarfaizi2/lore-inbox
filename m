Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWEJC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWEJC4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEJC4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51773 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932424AbWEJC4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:21 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u8ho031797@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] xfs gcc 4.1 warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings,

fs/xfs/xfs_dir.c: In function 'xfs_dir_removename':
fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function

fs/xfs/xfs_da_btree.c: In function 'xfs_da_split':
fs/xfs/xfs_da_btree.c:151: warning: 'action' may be used uninitialized in this function

fs/xfs/xfs_bmap_btree.c: In function 'xfs_bmbt_insert':
fs/xfs/xfs_bmap_btree.c:753: warning: 'nkey.br_startoff' may be used uninitialized in this functi

fs/xfs/xfs_inode.c: In function 'xfs_ifree':
fs/xfs/xfs_inode.c:1960: warning: 'last_offset' may be used uninitialized in this function
fs/xfs/xfs_inode.c:1958: warning: 'last_dip' may be used uninitialized in this function

fs/xfs/xfs_log.c: In function ‘xlog_write’:
fs/xfs/xfs_log.c:1749: warning: ‘iclog’ may be used uninitialized in this function

fs/xfs/xfs_log_recover.c: In function 'xlog_find_tail':
fs/xfs/xfs_log_recover.c:523: warning: 'first_blk' may be used uninitialized in this function

fs/xfs/xfs_ialloc_btree.c: In function ‘xfs_inobt_insert’:
fs/xfs/xfs_ialloc_btree.c:545: warning: ‘nkey.ir_startino’ may be used uninitialized in this function

fs/xfs/xfs_alloc_btree.c: In function 'xfs_alloc_insert':
fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_startblock' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_blockcount' may be used uninitialized in this function

fs/xfs/xfs_mount.c: In function 'xfs_icsb_balance_counter':
fs/xfs/xfs_mount.c:2021: warning: 'count' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/fs/xfs/xfs_bmap_btree.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_bmap_btree.c
+++ linux-2.6.16/fs/xfs/xfs_bmap_btree.c
@@ -750,7 +750,7 @@ xfs_bmbt_insrec(
 	int			logflags;	/* inode logging flags */
 	xfs_fsblock_t		nbno;		/* new block number */
 	struct xfs_btree_cur	*ncur;		/* new btree cursor */
-	xfs_bmbt_key_t		nkey;		/* new btree key value */
+	xfs_bmbt_key_t		nkey = { .br_startoff = 0 };		/* new btree key value */
 	xfs_bmbt_rec_t		nrec;		/* new record count */
 	int			optr;		/* old key/record index */
 	xfs_bmbt_ptr_t		*pp;		/* pointer to bmap block addr */
Index: linux-2.6.16/fs/xfs/xfs_da_btree.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_da_btree.c
+++ linux-2.6.16/fs/xfs/xfs_da_btree.c
@@ -145,10 +145,11 @@ xfs_da_node_create(xfs_da_args_t *args, 
 int							/* error */
 xfs_da_split(xfs_da_state_t *state)
 {
+	int action = 0;
+	int max, error, i;
 	xfs_da_state_blk_t *oldblk, *newblk, *addblk;
 	xfs_da_intnode_t *node;
 	xfs_dabuf_t *bp;
-	int max, action, error, i;
 
 	/*
 	 * Walk back up the tree splitting/inserting/adjusting as necessary.
Index: linux-2.6.16/fs/xfs/xfs_dir.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_dir.c
+++ linux-2.6.16/fs/xfs/xfs_dir.c
@@ -359,8 +359,10 @@ xfs_dir_removename(xfs_trans_t *trans, x
 		   int namelen, xfs_ino_t ino, xfs_fsblock_t *firstblock,
 		   xfs_bmap_free_t *flist, xfs_extlen_t total)
 {
+	int count = 0;
+	int totallen = 0;
 	xfs_da_args_t args;
-	int count, totallen, newsize, retval;
+	int newsize, retval;
 
 	ASSERT((dp->i_d.di_mode & S_IFMT) == S_IFDIR);
 	XFS_STATS_INC(xs_dir_remove);
Index: linux-2.6.16/fs/xfs/xfs_ialloc_btree.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_ialloc_btree.c
+++ linux-2.6.16/fs/xfs/xfs_ialloc_btree.c
@@ -542,7 +542,7 @@ xfs_inobt_insrec(
 	xfs_inobt_key_t		*kp=NULL;	/* pointer to btree keys */
 	xfs_agblock_t		nbno;	/* block number of allocated block */
 	xfs_btree_cur_t		*ncur;	/* new cursor to be used at next lvl */
-	xfs_inobt_key_t		nkey;	/* new key value, from split */
+	xfs_inobt_key_t		nkey = { .ir_startino = 0 };	/* new key value, from split */
 	xfs_inobt_rec_t		nrec;	/* new record value, for caller */
 	int			numrecs;
 	int			optr;	/* old ptr value */
Index: linux-2.6.16/fs/xfs/xfs_inode.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_inode.c
+++ linux-2.6.16/fs/xfs/xfs_inode.c
@@ -1955,9 +1955,10 @@ xfs_iunlink_remove(
 	xfs_agino_t	agino;
 	xfs_agino_t	next_agino;
 	xfs_buf_t	*last_ibp;
-	xfs_dinode_t	*last_dip;
+	xfs_dinode_t	*last_dip = NULL;
 	short		bucket_index;
-	int		offset, last_offset;
+	int		offset;
+	int		last_offset = 0;
 	int		error;
 	int		agi_ok;
 
Index: linux-2.6.16/fs/xfs/xfs_log.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_log.c
+++ linux-2.6.16/fs/xfs/xfs_log.c
@@ -1746,7 +1746,7 @@ xlog_write(xfs_mount_t *	mp,
     xlog_t	     *log    = mp->m_log;
     xlog_ticket_t    *ticket = (xlog_ticket_t *)tic;
     xlog_op_header_t *logop_head;    /* ptr to log operation header */
-    xlog_in_core_t   *iclog;	     /* ptr to current in-core log */
+    xlog_in_core_t   *iclog = NULL;  /* ptr to current in-core log */
     __psint_t	     ptr;	     /* copy address into data region */
     int		     len;	     /* # xlog_write() bytes 2 still copy */
     int		     index;	     /* region index currently copying */
Index: linux-2.6.16/fs/xfs/xfs_log_recover.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_log_recover.c
+++ linux-2.6.16/fs/xfs/xfs_log_recover.c
@@ -520,7 +520,8 @@ xlog_find_head(
 {
 	xfs_buf_t	*bp;
 	xfs_caddr_t	offset;
-	xfs_daddr_t	new_blk, first_blk, start_blk, last_blk, head_blk;
+	xfs_daddr_t	first_blk = 0;
+	xfs_daddr_t	new_blk, start_blk, last_blk, head_blk;
 	int		num_scan_bblks;
 	uint		first_half_cycle, last_half_cycle;
 	uint		stop_on_cycle;
Index: linux-2.6.16/fs/xfs/xfs_alloc_btree.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_alloc_btree.c
+++ linux-2.6.16/fs/xfs/xfs_alloc_btree.c
@@ -608,7 +608,7 @@ xfs_alloc_insrec(
 	xfs_alloc_key_t		*kp;	/* pointer to btree keys */
 	xfs_agblock_t		nbno;	/* block number of allocated block */
 	xfs_btree_cur_t		*ncur;	/* new cursor to be used at next lvl */
-	xfs_alloc_key_t		nkey;	/* new key value, from split */
+	xfs_alloc_key_t		nkey = { 0, 0 };	/* new key value, from split */
 	xfs_alloc_rec_t		nrec;	/* new record value, for caller */
 	int			optr;	/* old ptr value */
 	xfs_alloc_ptr_t		*pp;	/* pointer to btree addresses */
Index: linux-2.6.16/fs/xfs/xfs_mount.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/xfs_mount.c
+++ linux-2.6.16/fs/xfs/xfs_mount.c
@@ -2018,7 +2018,8 @@ xfs_icsb_balance_counter(
 	xfs_sb_field_t  field,
 	int		flags)
 {
-	uint64_t	count, resid = 0;
+	uint64_t	count = 0;
+	uint64_t	resid = 0;
 	int		weight = num_online_cpus();
 	int		s;
 
