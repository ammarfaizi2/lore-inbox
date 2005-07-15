Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263281AbVGOKeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbVGOKeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbVGOKcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:32:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263272AbVGOKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:31:45 -0400
Date: Fri, 15 Jul 2005 18:36:23 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 05/12] dlm: rsb flag ops with inlined functions
Message-ID: <20050715103623.GH17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rsb-flags.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace test/set/clear_bit of rsb flags with new inline functions that use
the less expense non-atomic bit ops.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/debug_fs.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/debug_fs.c
+++ linux-2.6.12-mm1/drivers/dlm/debug_fs.c
@@ -114,7 +114,7 @@ static int print_resource(struct dlm_rsb
 			seq_printf(s, "%02x ",
 				   (unsigned char) res->res_lvbptr[i]);
 		}
-		if (test_bit(RESFL_VALNOTVALID, &res->res_flags))
+		if (rsb_flag(res, RSB_VALNOTVALID))
 			seq_printf(s, " (INVALID)");
 		seq_printf(s, "\n");
 	}
Index: linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dlm_internal.h
+++ linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
@@ -262,25 +262,11 @@ struct dlm_lkb {
 	long			lkb_astparam;	/* caller's ast arg */
 };
 
-
-/* find_rsb() flags */
-
-#define R_MASTER		1	/* only return rsb if it's a master */
-#define R_CREATE		2	/* create/add rsb if not found */
-
-#define RESFL_MASTER_WAIT	0
-#define RESFL_MASTER_UNCERTAIN	1
-#define RESFL_VALNOTVALID	2
-#define RESFL_VALNOTVALID_PREV	3
-#define RESFL_NEW_MASTER	4
-#define RESFL_NEW_MASTER2	5
-#define RESFL_RECOVER_CONVERT	6
-
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
 	struct semaphore	res_sem;
-	unsigned long		res_flags;	/* RESFL_ */
+	unsigned long		res_flags;
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
 	uint32_t                res_lvbseq;
@@ -301,6 +287,38 @@ struct dlm_rsb {
 	char			res_name[1];
 };
 
+/* find_rsb() flags */
+
+#define R_MASTER		1	/* only return rsb if it's a master */
+#define R_CREATE		2	/* create/add rsb if not found */
+
+/* rsb_flags */
+
+enum rsb_flags {
+	RSB_MASTER_WAIT,
+	RSB_MASTER_UNCERTAIN,
+	RSB_VALNOTVALID,
+	RSB_VALNOTVALID_PREV,
+	RSB_NEW_MASTER,
+	RSB_NEW_MASTER2,
+	RSB_RECOVER_CONVERT,
+};
+
+static inline void rsb_set_flag(struct dlm_rsb *r, enum rsb_flags flag)
+{
+	__set_bit(flag, &r->res_flags);
+}
+
+static inline void rsb_clear_flag(struct dlm_rsb *r, enum rsb_flags flag)
+{
+	__clear_bit(flag, &r->res_flags);
+}
+
+static inline int rsb_flag(struct dlm_rsb *r, enum rsb_flags flag)
+{
+	return test_bit(flag, &r->res_flags);
+}
+
 
 /* dlm_header is first element of all structs sent between nodes */
 
Index: linux-2.6.12-mm1/drivers/dlm/lock.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lock.c
+++ linux-2.6.12-mm1/drivers/dlm/lock.c
@@ -317,18 +317,17 @@ static int _search_rsb(struct dlm_ls *ls
 	list_move(&r->res_hashchain, &ls->ls_rsbtbl[b].list);
 
 	if (r->res_nodeid == -1) {
-		clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
-		clear_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags);
+		rsb_clear_flag(r, RSB_MASTER_WAIT);
+		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
 		r->res_trial_lkid = 0;
 	} else if (r->res_nodeid > 0) {
-		clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
-		set_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags);
+		rsb_clear_flag(r, RSB_MASTER_WAIT);
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
 		r->res_trial_lkid = 0;
 	} else {
 		DLM_ASSERT(r->res_nodeid == 0, dlm_print_rsb(r););
-		DLM_ASSERT(!test_bit(RESFL_MASTER_WAIT, &r->res_flags),
-			   dlm_print_rsb(r););
-		DLM_ASSERT(!test_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags),);
+		DLM_ASSERT(!rsb_flag(r, RSB_MASTER_WAIT), dlm_print_rsb(r););
+		DLM_ASSERT(!rsb_flag(r, RSB_MASTER_UNCERTAIN),);
 	}
  out:
 	*r_ret = r;
@@ -837,7 +836,7 @@ static void set_lvb_lock(struct dlm_rsb 
 
 	} else if (b == 0) {
 		if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
-			set_bit(RESFL_VALNOTVALID, &r->res_flags);
+			rsb_set_flag(r, RSB_VALNOTVALID);
 			return;
 		}
 
@@ -856,10 +855,10 @@ static void set_lvb_lock(struct dlm_rsb 
 		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, len);
 		r->res_lvbseq++;
 		lkb->lkb_lvbseq = r->res_lvbseq;
-		clear_bit(RESFL_VALNOTVALID, &r->res_flags);
+		rsb_clear_flag(r, RSB_VALNOTVALID);
 	}
 
-	if (test_bit(RESFL_VALNOTVALID, &r->res_flags))
+	if (rsb_flag(r, RSB_VALNOTVALID))
 		lkb->lkb_sbflags |= DLM_SBF_VALNOTVALID;
 }
 
@@ -869,7 +868,7 @@ static void set_lvb_unlock(struct dlm_rs
 		return;
 
 	if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
-		set_bit(RESFL_VALNOTVALID, &r->res_flags);
+		rsb_set_flag(r, RSB_VALNOTVALID);
 		return;
 	}
 
@@ -887,7 +886,7 @@ static void set_lvb_unlock(struct dlm_rs
 
 	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, r->res_ls->ls_lvblen);
 	r->res_lvbseq++;
-	clear_bit(RESFL_VALNOTVALID, &r->res_flags);
+	rsb_clear_flag(r, RSB_VALNOTVALID);
 }
 
 /* lkb is process copy (pc) */
@@ -1419,8 +1418,9 @@ static int set_master(struct dlm_rsb *r,
 	struct dlm_ls *ls = r->res_ls;
 	int error, dir_nodeid, ret_nodeid, our_nodeid = dlm_our_nodeid();
 
-	if (test_and_clear_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags)) {
-		set_bit(RESFL_MASTER_WAIT, &r->res_flags);
+	if (rsb_flag(r, RSB_MASTER_UNCERTAIN)) {
+		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
+		rsb_set_flag(r, RSB_MASTER_WAIT);
 		r->res_trial_lkid = lkb->lkb_id;
 		lkb->lkb_nodeid = r->res_nodeid;
 		return 0;
@@ -1437,7 +1437,7 @@ static int set_master(struct dlm_rsb *r,
 		return 0;
 	}
 
-	if (test_bit(RESFL_MASTER_WAIT, &r->res_flags)) {
+	if (rsb_flag(r, RSB_MASTER_WAIT)) {
 		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
 		return 1;
 	}
@@ -1455,7 +1455,7 @@ static int set_master(struct dlm_rsb *r,
 	dir_nodeid = dlm_dir_nodeid(r);
 
 	if (dir_nodeid != our_nodeid) {
-		set_bit(RESFL_MASTER_WAIT, &r->res_flags);
+		rsb_set_flag(r, RSB_MASTER_WAIT);
 		send_lookup(r, lkb);
 		return 1;
 	}
@@ -1481,7 +1481,7 @@ static int set_master(struct dlm_rsb *r,
 		return 0;
 	}
 
-	set_bit(RESFL_MASTER_WAIT, &r->res_flags);
+	rsb_set_flag(r, RSB_MASTER_WAIT);
 	r->res_trial_lkid = lkb->lkb_id;
 	r->res_nodeid = ret_nodeid;
 	lkb->lkb_nodeid = ret_nodeid;
@@ -1503,7 +1503,7 @@ static void confirm_master(struct dlm_rs
 {
 	struct dlm_lkb *lkb, *safe;
 
-	if (!test_bit(RESFL_MASTER_WAIT, &r->res_flags))
+	if (!rsb_flag(r, RSB_MASTER_WAIT))
 		return;
 
 	switch (error) {
@@ -1512,7 +1512,7 @@ static void confirm_master(struct dlm_rs
 		/* the remote master queued our request, or
 		   the remote dir node told us we're the master */
 
-		clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
+		rsb_clear_flag(r, RSB_MASTER_WAIT);
 		r->res_trial_lkid = 0;
 
 		list_for_each_entry_safe(lkb, safe, &r->res_lookup,
@@ -1544,7 +1544,7 @@ static void confirm_master(struct dlm_rs
 
 		r->res_nodeid = -1;
 		r->res_trial_lkid = 0;
-		clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
+		rsb_clear_flag(r, RSB_MASTER_WAIT);
 		break;
 
 	default:
@@ -2830,7 +2830,7 @@ static void receive_request_reply(struct
 	case -ENOTBLK:
 		/* find_rsb failed to find rsb or rsb wasn't master */
 
-		DLM_ASSERT(test_bit(RESFL_MASTER_WAIT, &r->res_flags),
+		DLM_ASSERT(rsb_flag(r, RSB_MASTER_WAIT),
 		           log_print("receive_request_reply error %d", error);
 		           dlm_print_lkb(lkb);
 		           dlm_print_rsb(r););
@@ -3188,7 +3188,7 @@ static void recover_convert_waiter(struc
 
 		/* Same special case as in receive_rcom_lock_args() */
 		lkb->lkb_grmode = DLM_LOCK_IV;
-		set_bit(RESFL_RECOVER_CONVERT, &lkb->lkb_resource->res_flags);
+		rsb_set_flag(lkb->lkb_resource, RSB_RECOVER_CONVERT);
 		unhold_lkb(lkb);
 
 	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
@@ -3482,7 +3482,7 @@ static int receive_rcom_lock_args(struct
 	if (rl->rl_wait_type == DLM_MSG_CONVERT && middle_conversion(lkb)) {
 		rl->rl_status = DLM_LKSTS_CONVERT;
 		lkb->lkb_grmode = DLM_LOCK_IV;
-		set_bit(RESFL_RECOVER_CONVERT, &r->res_flags);
+		rsb_set_flag(r, RSB_RECOVER_CONVERT);
 	}
 
 	return 0;
Index: linux-2.6.12-mm1/drivers/dlm/recover.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recover.c
+++ linux-2.6.12-mm1/drivers/dlm/recover.c
@@ -309,8 +309,8 @@ static void set_new_master(struct dlm_rs
 
 	set_master_lkbs(r);
 
-	set_bit(RESFL_NEW_MASTER, &r->res_flags);
-	set_bit(RESFL_NEW_MASTER2, &r->res_flags);
+	rsb_set_flag(r, RSB_NEW_MASTER);
+	rsb_set_flag(r, RSB_NEW_MASTER2);
 	unlock_rsb(r);
 }
 
@@ -487,11 +487,11 @@ int dlm_recover_locks(struct dlm_ls *ls)
 	down_read(&ls->ls_root_sem);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		if (is_master(r)) {
-			clear_bit(RESFL_NEW_MASTER, &r->res_flags);
+			rsb_clear_flag(r, RSB_NEW_MASTER);
 			continue;
 		}
 
-		if (!test_bit(RESFL_NEW_MASTER, &r->res_flags))
+		if (!rsb_flag(r, RSB_NEW_MASTER))
 			continue;
 
 		error = dlm_recovery_stopped(ls);
@@ -525,7 +525,7 @@ void dlm_recovered_lock(struct dlm_rsb *
 {
 	r->res_recover_locks_count--;
 	if (!r->res_recover_locks_count) {
-		clear_bit(RESFL_NEW_MASTER, &r->res_flags);
+		rsb_clear_flag(r, RSB_NEW_MASTER);
 		recover_list_del(r);
 	}
 
@@ -538,7 +538,7 @@ void dlm_recovered_lock(struct dlm_rsb *
  * the VALNOTVALID flag if necessary, and determining the correct lvb contents
  * based on the lvb's of the locks held on the rsb.
  *
- * RESFL_VALNOTVALID is set if there are only NL/CR locks on the rsb.  If it
+ * RSB_VALNOTVALID is set if there are only NL/CR locks on the rsb.  If it
  * was already set prior to recovery, it's not cleared, regardless of locks.
  *
  * The LVB contents are only considered for changing when this is a new master
@@ -594,10 +594,10 @@ static void recover_lvb(struct dlm_rsb *
 		goto out;
 
 	if (!big_lock_exists)
-		set_bit(RESFL_VALNOTVALID, &r->res_flags);
+		rsb_set_flag(r, RSB_VALNOTVALID);
 
 	/* don't mess with the lvb unless we're the new master */
-	if (!test_bit(RESFL_NEW_MASTER2, &r->res_flags))
+	if (!rsb_flag(r, RSB_NEW_MASTER2))
 		goto out;
 
 	if (!r->res_lvbptr) {
@@ -657,12 +657,12 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		lock_rsb(r);
 		if (is_master(r)) {
-			if (test_bit(RESFL_RECOVER_CONVERT, &r->res_flags))
+			if (rsb_flag(r, RSB_RECOVER_CONVERT))
 				recover_conversion(r);
 			recover_lvb(r);
 			count++;
 		}
-		clear_bit(RESFL_RECOVER_CONVERT, &r->res_flags);
+		rsb_clear_flag(r, RSB_RECOVER_CONVERT);
 		unlock_rsb(r);
 	}
 	up_read(&ls->ls_root_sem);

--
