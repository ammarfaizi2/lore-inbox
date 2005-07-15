Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVGOKyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVGOKyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGOKe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:34:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263273AbVGOKb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:31:56 -0400
Date: Fri, 15 Jul 2005 18:36:38 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 07/12] dlm: better handling of first lock
Message-ID: <20050715103638.GJ17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="first-lock.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first lock taken on an rsb is treated specially because the resource
master needs to be looked up.  There were some potential problems with
this during recovery, and the whole thing was becoming too complex.  This
simplifies the special first-lock case and solves the problems.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/debug_fs.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/debug_fs.c
+++ linux-2.6.12-mm1/drivers/dlm/debug_fs.c
@@ -99,11 +99,16 @@ static int print_resource(struct dlm_rsb
 		else
 			seq_printf(s, "%c", '.');
 	}
-	if (res->res_nodeid)
+	if (res->res_nodeid > 0)
 		seq_printf(s, "\"  \nLocal Copy, Master is node %d\n",
 			   res->res_nodeid);
-	else
+	else if (res->res_nodeid == 0)
 		seq_printf(s, "\"  \nMaster Copy\n");
+	else if (res->res_nodeid == -1)
+		seq_printf(s, "\"  \nLooking up master (lkid %x)\n",
+			   res->res_first_lkid);
+	else
+		seq_printf(s, "\"  \nInvalid master %d\n", res->res_nodeid);
 
 	/* Print the LVB: */
 	if (res->res_lvbptr) {
Index: linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dlm_internal.h
+++ linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
@@ -272,8 +272,8 @@ struct dlm_rsb {
 	uint32_t                res_lvbseq;
 	uint32_t		res_bucket;	/* rsbtbl */
 	unsigned long		res_toss_time;
-	uint32_t		res_trial_lkid;	/* lkb trying lookup result */
-	struct list_head	res_lookup;	/* lkbs waiting lookup confirm*/
+	uint32_t		res_first_lkid;
+	struct list_head	res_lookup;	/* lkbs waiting on first */
 	struct list_head	res_hashchain;	/* rsbtbl */
 	struct list_head	res_grantqueue;
 	struct list_head	res_convertqueue;
@@ -295,7 +295,6 @@ struct dlm_rsb {
 /* rsb_flags */
 
 enum rsb_flags {
-	RSB_MASTER_WAIT,
 	RSB_MASTER_UNCERTAIN,
 	RSB_VALNOTVALID,
 	RSB_VALNOTVALID_PREV,
Index: linux-2.6.12-mm1/drivers/dlm/lock.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lock.c
+++ linux-2.6.12-mm1/drivers/dlm/lock.c
@@ -112,6 +112,7 @@ static const int __dlm_compat_matrix[8][
  * 0 = LVB is written to the resource
  * -1 = nothing happens to the LVB
  */
+
 const int dlm_lvb_operations[8][8] = {
         /* UN   NL  CR  CW  PR  PW  EX  PD*/
         {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
@@ -162,8 +163,8 @@ void dlm_print_lkb(struct dlm_lkb *lkb)
 
 void dlm_print_rsb(struct dlm_rsb *r)
 {
-	printk(KERN_ERR "rsb: nodeid %d flags %lx trial %x rlc %d name %s\n",
-	       r->res_nodeid, r->res_flags, r->res_trial_lkid,
+	printk(KERN_ERR "rsb: nodeid %d flags %lx first %x rlc %d name %s\n",
+	       r->res_nodeid, r->res_flags, r->res_first_lkid,
 	       r->res_recover_locks_count, r->res_name);
 }
 
@@ -317,16 +318,13 @@ static int _search_rsb(struct dlm_ls *ls
 	list_move(&r->res_hashchain, &ls->ls_rsbtbl[b].list);
 
 	if (r->res_nodeid == -1) {
-		rsb_clear_flag(r, RSB_MASTER_WAIT);
 		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
-		r->res_trial_lkid = 0;
+		r->res_first_lkid = 0;
 	} else if (r->res_nodeid > 0) {
-		rsb_clear_flag(r, RSB_MASTER_WAIT);
 		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
-		r->res_trial_lkid = 0;
+		r->res_first_lkid = 0;
 	} else {
 		DLM_ASSERT(r->res_nodeid == 0, dlm_print_rsb(r););
-		DLM_ASSERT(!rsb_flag(r, RSB_MASTER_WAIT), dlm_print_rsb(r););
 		DLM_ASSERT(!rsb_flag(r, RSB_MASTER_UNCERTAIN),);
 	}
  out:
@@ -1398,19 +1396,10 @@ static void send_blocking_asts_all(struc
    lookup reply.  Other lkb's waiting for the same rsb lookup are kept
    on the rsb's res_lookup list until the master is verified.
 
-   After a remote lookup or when a tossed rsb is retrived that specifies
-   a remote master, that master value is uncertain -- it may have changed
-   by the time we send it a request.  While it's uncertain, only one lkb
-   is allowed to go ahead and use the master value; that lkb is specified
-   by res_trial_lkid.  Once the trial lkb is queued on the master node
-   we know the rsb master is correct and any other lkbs on res_lookup
-   can get the rsb nodeid and go ahead with their request.
-
    Return values:
    0: nodeid is set in rsb/lkb and the caller should go ahead and use it
    1: the rsb master is not available and the lkb has been placed on
       a wait queue
-   -EXXX: there was some error in processing
 */
 
 static int set_master(struct dlm_rsb *r, struct dlm_lkb *lkb)
@@ -1420,42 +1409,32 @@ static int set_master(struct dlm_rsb *r,
 
 	if (rsb_flag(r, RSB_MASTER_UNCERTAIN)) {
 		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
-		rsb_set_flag(r, RSB_MASTER_WAIT);
-		r->res_trial_lkid = lkb->lkb_id;
+		r->res_first_lkid = lkb->lkb_id;
 		lkb->lkb_nodeid = r->res_nodeid;
 		return 0;
 	}
 
-	if (r->res_nodeid == 0) {
-		lkb->lkb_nodeid = 0;
-		return 0;
+	if (r->res_first_lkid && r->res_first_lkid != lkb->lkb_id) {
+		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
+		return 1;
 	}
 
-	if (r->res_trial_lkid == lkb->lkb_id) {
-		DLM_ASSERT(lkb->lkb_id, dlm_print_lkb(lkb););
-		lkb->lkb_nodeid = r->res_nodeid;
+	if (r->res_nodeid == 0) {
+		lkb->lkb_nodeid = 0;
 		return 0;
 	}
 
-	if (rsb_flag(r, RSB_MASTER_WAIT)) {
-		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
-		return 1;
-	}
-
 	if (r->res_nodeid > 0) {
 		lkb->lkb_nodeid = r->res_nodeid;
 		return 0;
 	}
 
-	/* This is the first lkb requested on this rsb since the rsb
-	   was created.  We need to figure out who the rsb master is. */
-
-	DLM_ASSERT(r->res_nodeid == -1, );
+	DLM_ASSERT(r->res_nodeid == -1, dlm_print_rsb(r););
 
 	dir_nodeid = dlm_dir_nodeid(r);
 
 	if (dir_nodeid != our_nodeid) {
-		rsb_set_flag(r, RSB_MASTER_WAIT);
+		r->res_first_lkid = lkb->lkb_id;
 		send_lookup(r, lkb);
 		return 1;
 	}
@@ -1476,75 +1455,58 @@ static int set_master(struct dlm_rsb *r,
 	}
 
 	if (ret_nodeid == our_nodeid) {
+		r->res_first_lkid = 0;
 		r->res_nodeid = 0;
 		lkb->lkb_nodeid = 0;
-		return 0;
+	} else {
+		r->res_first_lkid = lkb->lkb_id;
+		r->res_nodeid = ret_nodeid;
+		lkb->lkb_nodeid = ret_nodeid;
 	}
-
-	rsb_set_flag(r, RSB_MASTER_WAIT);
-	r->res_trial_lkid = lkb->lkb_id;
-	r->res_nodeid = ret_nodeid;
-	lkb->lkb_nodeid = ret_nodeid;
 	return 0;
 }
 
-/* confirm_master -- confirm (or deny) an rsb's master nodeid
+static void process_lookup_list(struct dlm_rsb *r)
+{
+	struct dlm_lkb *lkb, *safe;
 
-   This is called when we get a request reply from a remote node
-   who we believe is the master.  The return value (error) we got
-   back indicates whether it's really the master or not.  If it
-   wasn't, we need to start over and do another master lookup.  If
-   it was and our lock was queued, then we know the master won't
-   change.  If it was and our lock wasn't queued, we need to do
-   another trial with the next lkb.
-*/
+	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
+		list_del(&lkb->lkb_rsb_lookup);
+		_request_lock(r, lkb);
+		schedule();
+	}
+}
+
+/* confirm_master -- confirm (or deny) an rsb's master nodeid */
 
 static void confirm_master(struct dlm_rsb *r, int error)
 {
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb;
 
-	if (!rsb_flag(r, RSB_MASTER_WAIT))
+	if (!r->res_first_lkid)
 		return;
 
 	switch (error) {
 	case 0:
 	case -EINPROGRESS:
-		/* the remote master queued our request, or
-		   the remote dir node told us we're the master */
-
-		rsb_clear_flag(r, RSB_MASTER_WAIT);
-		r->res_trial_lkid = 0;
-
-		list_for_each_entry_safe(lkb, safe, &r->res_lookup,
-					 lkb_rsb_lookup) {
-			list_del(&lkb->lkb_rsb_lookup);
-			_request_lock(r, lkb);
-			schedule();
-		}
+		r->res_first_lkid = 0;
+		process_lookup_list(r);
 		break;
-
+	
 	case -EAGAIN:
 		/* the remote master didn't queue our NOQUEUE request;
-		   do another trial with the next waiting lkb */
+		   make a waiting lkb the first_lkid */
+
+		r->res_first_lkid = 0;
 
 		if (!list_empty(&r->res_lookup)) {
 			lkb = list_entry(r->res_lookup.next, struct dlm_lkb,
 					 lkb_rsb_lookup);
 			list_del(&lkb->lkb_rsb_lookup);
-			r->res_trial_lkid = lkb->lkb_id;
+			r->res_first_lkid = lkb->lkb_id;
 			_request_lock(r, lkb);
-			break;
-		}
-		/* fall through so the rsb looks new */
-
-	case -ENOENT:
-	case -ENOTBLK:
-		/* the remote master wasn't really the master, i.e.  our
-		   trial failed; so we start over with another lookup */
-
-		r->res_nodeid = -1;
-		r->res_trial_lkid = 0;
-		rsb_clear_flag(r, RSB_MASTER_WAIT);
+		} else
+			r->res_nodeid = -1;
 		break;
 
 	default:
@@ -2181,7 +2143,7 @@ static void send_args(struct dlm_rsb *r,
 
 	else if (lkb->lkb_lvbptr)
 		memcpy(ms->m_extra, lkb->lkb_lvbptr, r->res_ls->ls_lvblen);
-
+	
 }
 
 static int send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
@@ -2799,7 +2761,6 @@ static void receive_request_reply(struct
 	if (mstype == DLM_MSG_LOOKUP) {
 		r->res_nodeid = ms->m_header.h_nodeid;
 		lkb->lkb_nodeid = r->res_nodeid;
-		r->res_trial_lkid = lkb->lkb_id;
 	}
 
 	switch (error) {
@@ -2829,13 +2790,7 @@ static void receive_request_reply(struct
 	case -ENOENT:
 	case -ENOTBLK:
 		/* find_rsb failed to find rsb or rsb wasn't master */
-
-		DLM_ASSERT(rsb_flag(r, RSB_MASTER_WAIT),
-		           log_print("receive_request_reply error %d", error);
-		           dlm_print_lkb(lkb);
-		           dlm_print_rsb(r););
-
-		confirm_master(r, error);
+		r->res_nodeid = -1;
 		lkb->lkb_nodeid = -1;
 		_request_lock(r, lkb);
 		break;
@@ -3038,17 +2993,19 @@ static void receive_lookup_reply(struct 
 	lock_rsb(r);
 
 	ret_nodeid = ms->m_nodeid;
-	if (ret_nodeid == dlm_our_nodeid())
-		r->res_nodeid = ret_nodeid = 0;
-	else {
+	if (ret_nodeid == dlm_our_nodeid()) {
+		r->res_nodeid = 0;
+		ret_nodeid = 0;
+		r->res_first_lkid = 0;
+	} else {
+		/* set_master() will copy res_nodeid to lkb_nodeid */
 		r->res_nodeid = ret_nodeid;
-		r->res_trial_lkid = lkb->lkb_id;
 	}
 
 	_request_lock(r, lkb);
 
 	if (!ret_nodeid)
-		confirm_master(r, 0);
+		process_lookup_list(r);
 
 	unlock_rsb(r);
 	put_rsb(r);
@@ -3194,7 +3151,7 @@ static void recover_convert_waiter(struc
 	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
 		lkb->lkb_flags |= DLM_IFL_RESEND;
 	}
-
+	
 	/* lkb->lkb_rqmode < lkb->lkb_grmode shouldn't happen since down
 	   conversions are async; there's no reply from the remote master */
 }
@@ -3311,6 +3268,15 @@ int dlm_recover_waiters_post(struct dlm_
 		switch (mstype) {
 
 		case DLM_MSG_LOOKUP:
+			hold_rsb(r);
+			lock_rsb(r);
+			_request_lock(r, lkb);
+			if (is_master(r))
+				confirm_master(r, 0);
+			unlock_rsb(r);
+			put_rsb(r);
+			break;
+
 		case DLM_MSG_REQUEST:
 			hold_rsb(r);
 			lock_rsb(r);

--
