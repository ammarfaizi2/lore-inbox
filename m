Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVGOKyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVGOKyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbVGOKem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:34:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263275AbVGOKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:32:01 -0400
Date: Fri, 15 Jul 2005 18:36:50 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 08/12] dlm: no directory option
Message-ID: <20050715103650.GK17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nodir.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per-lockspace option for dlm to run without using a resource
directory.  What would be the directory node for a resource is
statically assigned to be the master node instead.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/dir.c
===================================================================
--- linux.orig/drivers/dlm/dir.c
+++ linux/drivers/dlm/dir.c
@@ -72,15 +72,14 @@ void dlm_clear_free_entries(struct dlm_l
  *
  * To give the exact range wanted (0 to num_nodes-1), we apply a modulus of
  * num_nodes to the hash value.  This value in the desired range is used as an
- * offset into the sorted list of nodeid's to give the particular nodeid of the
- * directory node.
+ * offset into the sorted list of nodeid's to give the particular nodeid.
  */
 
-int dlm_dir_name2nodeid(struct dlm_ls *ls, char *name, int length)
+int dlm_hash2nodeid(struct dlm_ls *ls, uint32_t hash)
 {
 	struct list_head *tmp;
 	struct dlm_member *memb = NULL;
-	uint32_t hash, node, n = 0;
+	uint32_t node, n = 0;
 	int nodeid;
 
 	if (ls->ls_num_nodes == 1) {
@@ -88,8 +87,6 @@ int dlm_dir_name2nodeid(struct dlm_ls *l
 		goto out;
 	}
 
-	hash = dlm_hash(name, length);
-
 	if (ls->ls_node_array) {
 		node = (hash >> 16) % ls->ls_total_weight;
 		nodeid = ls->ls_node_array[node];
@@ -114,9 +111,9 @@ int dlm_dir_name2nodeid(struct dlm_ls *l
 	return nodeid;
 }
 
-int dlm_dir_nodeid(struct dlm_rsb *rsb)
+int dlm_dir_nodeid(struct dlm_rsb *r)
 {
-	return dlm_dir_name2nodeid(rsb->res_ls, rsb->res_name, rsb->res_length);
+	return dlm_hash2nodeid(r->res_ls, r->res_hash);
 }
 
 static inline uint32_t dir_hash(struct dlm_ls *ls, char *name, int len)
@@ -202,12 +199,15 @@ int dlm_recover_directory(struct dlm_ls 
 {
 	struct dlm_member *memb;
 	struct dlm_direntry *de;
-	char *b, *last_name;
+	char *b, *last_name = NULL;
 	int error = -ENOMEM, last_len, count = 0;
 	uint16_t namelen;
 
 	log_debug(ls, "dlm_recover_directory");
 
+	if (dlm_no_directory(ls))
+		goto out_status;
+
 	dlm_dir_clear(ls);
 
 	last_name = kmalloc(DLM_RESNAME_MAXLEN, GFP_KERNEL);
@@ -221,12 +221,12 @@ int dlm_recover_directory(struct dlm_ls 
 		for (;;) {
 			error = dlm_recovery_stopped(ls);
 			if (error)
-				goto free_last;
+				goto out_free;
 
 			error = dlm_rcom_names(ls, memb->nodeid,
 					       last_name, last_len);
 			if (error)
-				goto free_last;
+				goto out_free;
 
 			schedule();
 
@@ -253,7 +253,7 @@ int dlm_recover_directory(struct dlm_ls 
 				error = -ENOMEM;
 				de = get_free_de(ls, namelen);
 				if (!de)
-					goto free_last;
+					goto out_free;
 
 				de->master_nodeid = memb->nodeid;
 				de->length = namelen;
@@ -270,12 +270,11 @@ int dlm_recover_directory(struct dlm_ls 
 		;
 	}
 
-	dlm_set_recover_status(ls, DLM_RS_DIR);
+ out_status:
 	error = 0;
-
+	dlm_set_recover_status(ls, DLM_RS_DIR);
 	log_debug(ls, "dlm_recover_directory %d entries", count);
-
- free_last:
+ out_free:
 	kfree(last_name);
  out:
 	dlm_clear_free_entries(ls);
Index: linux/drivers/dlm/dir.h
===================================================================
--- linux.orig/drivers/dlm/dir.h
+++ linux/drivers/dlm/dir.h
@@ -16,7 +16,7 @@
 
 
 int dlm_dir_nodeid(struct dlm_rsb *rsb);
-int dlm_dir_name2nodeid(struct dlm_ls *ls, char *name, int length);
+int dlm_hash2nodeid(struct dlm_ls *ls, uint32_t hash);
 void dlm_dir_remove_entry(struct dlm_ls *ls, int nodeid, char *name, int len);
 void dlm_dir_clear(struct dlm_ls *ls);
 void dlm_clear_free_entries(struct dlm_ls *ls);
Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h
+++ linux/drivers/dlm/dlm_internal.h
@@ -270,6 +270,7 @@ struct dlm_rsb {
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
 	uint32_t                res_lvbseq;
+	uint32_t		res_hash;
 	uint32_t		res_bucket;	/* rsbtbl */
 	unsigned long		res_toss_time;
 	uint32_t		res_first_lkid;
@@ -364,6 +365,7 @@ struct dlm_message {
 	uint32_t		m_sbflags;
 	uint32_t		m_flags;
 	uint32_t		m_lvbseq;
+	uint32_t		m_hash;
 	int			m_status;
 	int			m_grmode;
 	int			m_rqmode;
@@ -431,6 +433,7 @@ struct rcom_lock {
 struct dlm_ls {
 	struct list_head	ls_list;	/* list of lockspaces */
 	uint32_t		ls_global_id;	/* global unique lockspace ID */
+	uint32_t		ls_exflags;
 	int			ls_lvblen;
 	int			ls_count;	/* reference count */
 	unsigned long		ls_flags;	/* LSFL_ */
@@ -507,5 +510,10 @@ static inline int dlm_recovery_stopped(s
 	return test_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
 }
 
+static inline int dlm_no_directory(struct dlm_ls *ls)
+{
+	return (ls->ls_exflags & DLM_LSFL_NODIR) ? 1 : 0;
+}
+
 #endif				/* __DLM_INTERNAL_DOT_H__ */
 
Index: linux/drivers/dlm/lock.c
===================================================================
--- linux.orig/drivers/dlm/lock.c
+++ linux/drivers/dlm/lock.c
@@ -317,6 +317,9 @@ static int _search_rsb(struct dlm_ls *ls
 
 	list_move(&r->res_hashchain, &ls->ls_rsbtbl[b].list);
 
+	if (dlm_no_directory(ls))
+		goto out;
+
 	if (r->res_nodeid == -1) {
 		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
 		r->res_first_lkid = 0;
@@ -360,11 +363,14 @@ static int find_rsb(struct dlm_ls *ls, c
 		    unsigned int flags, struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r, *tmp;
-	uint32_t bucket;
+	uint32_t hash, bucket;
 	int error = 0;
 
-	bucket = dlm_hash(name, namelen);
-	bucket &= (ls->ls_rsbtbl_size - 1);
+	if (dlm_no_directory(ls))
+		flags |= R_CREATE;
+
+	hash = dlm_hash(name, namelen);
+	bucket = hash & (ls->ls_rsbtbl_size - 1);
 
 	error = search_rsb(ls, name, namelen, bucket, flags, &r);
 	if (!error)
@@ -382,10 +388,19 @@ static int find_rsb(struct dlm_ls *ls, c
 	if (!r)
 		goto out;
 
+	r->res_hash = hash;
 	r->res_bucket = bucket;
 	r->res_nodeid = -1;
 	kref_init(&r->res_ref);
 
+	/* With no directory, the master can be set immediately */
+	if (dlm_no_directory(ls)) {
+		int nodeid = dlm_dir_nodeid(r);
+		if (nodeid == dlm_our_nodeid())
+			nodeid = 0;
+		r->res_nodeid = nodeid;
+	}
+
 	write_lock(&ls->ls_rsbtbl[bucket].lock);
 	error = _search_rsb(ls, name, namelen, bucket, 0, &tmp);
 	if (!error) {
@@ -743,8 +758,12 @@ int dlm_remove_from_waiters(struct dlm_l
 
 static void dir_remove(struct dlm_rsb *r)
 {
-	int to_nodeid = dlm_dir_nodeid(r);
+	int to_nodeid;
+
+	if (dlm_no_directory(r->res_ls))
+		return;
 
+	to_nodeid = dlm_dir_nodeid(r);
 	if (to_nodeid != dlm_our_nodeid())
 		send_remove(r);
 	else
@@ -2124,6 +2143,7 @@ static void send_args(struct dlm_rsb *r,
 	ms->m_status   = lkb->lkb_status;
 	ms->m_grmode   = lkb->lkb_grmode;
 	ms->m_rqmode   = lkb->lkb_rqmode;
+	ms->m_hash     = r->res_hash;
 
 	/* m_result and m_bastmode are set from function args,
 	   not from lkb fields */
@@ -2288,6 +2308,7 @@ static int send_remove(struct dlm_rsb *r
 		goto out;
 
 	memcpy(ms->m_extra, r->res_name, r->res_length);
+	ms->m_hash = r->res_hash;
 
 	error = send_message(mh, ms);
  out:
@@ -2691,7 +2712,7 @@ static void receive_lookup(struct dlm_ls
 
 	len = receive_extralen(ms);
 
-	dir_nodeid = dlm_dir_name2nodeid(ls, ms->m_extra, len);
+	dir_nodeid = dlm_hash2nodeid(ls, ms->m_hash);
 	if (dir_nodeid != our_nodeid) {
 		log_error(ls, "lookup dir_nodeid %d from %d",
 			  dir_nodeid, from_nodeid);
@@ -2719,7 +2740,7 @@ static void receive_remove(struct dlm_ls
 
 	len = receive_extralen(ms);
 
-	dir_nodeid = dlm_dir_name2nodeid(ls, ms->m_extra, len);
+	dir_nodeid = dlm_hash2nodeid(ls, ms->m_hash);
 	if (dir_nodeid != dlm_our_nodeid()) {
 		log_error(ls, "remove dir entry dir_nodeid %d from %d",
 			  dir_nodeid, from_nodeid);
@@ -3156,6 +3177,23 @@ static void recover_convert_waiter(struc
 	   conversions are async; there's no reply from the remote master */
 }
 
+/* A waiting lkb needs recovery if the master node has failed, or
+   the master node is changing (only when no directory is used) */
+
+static int waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb)
+{
+	if (dlm_is_removed(ls, lkb->lkb_nodeid))
+		return 1;
+
+	if (!dlm_no_directory(ls))
+		return 0;
+
+	if (dlm_dir_nodeid(lkb->lkb_resource) != lkb->lkb_nodeid)
+		return 1;
+
+	return 0;
+}
+
 /* Recovery for locks that are waiting for replies from nodes that are now
    gone.  We can just complete unlocks and cancels by faking a reply from the
    dead node.  Requests and up-conversions we flag to be resent after
@@ -3180,7 +3218,7 @@ void dlm_recover_waiters_pre(struct dlm_
 			continue;
 		}
 
-		if (!dlm_is_removed(ls, lkb->lkb_nodeid))
+		if (!waiter_needs_recovery(ls, lkb))
 			continue;
 
 		switch (lkb->lkb_wait_type) {
@@ -3322,6 +3360,11 @@ static int purge_dead_test(struct dlm_ls
 	return (is_master_copy(lkb) && dlm_is_removed(ls, lkb->lkb_nodeid));
 }
 
+static int purge_mstcpy_test(struct dlm_ls *ls, struct dlm_lkb *lkb)
+{
+	return is_master_copy(lkb);
+}
+
 static void purge_dead_locks(struct dlm_rsb *r)
 {
 	purge_queue(r, &r->res_grantqueue, &purge_dead_test);
@@ -3329,6 +3372,13 @@ static void purge_dead_locks(struct dlm_
 	purge_queue(r, &r->res_waitqueue, &purge_dead_test);
 }
 
+void dlm_purge_mstcpy_locks(struct dlm_rsb *r)
+{
+	purge_queue(r, &r->res_grantqueue, &purge_mstcpy_test);
+	purge_queue(r, &r->res_convertqueue, &purge_mstcpy_test);
+	purge_queue(r, &r->res_waitqueue, &purge_mstcpy_test);
+}
+
 /* Get rid of locks held by nodes that are gone. */
 
 int dlm_purge_locks(struct dlm_ls *ls)
Index: linux/drivers/dlm/lock.h
===================================================================
--- linux.orig/drivers/dlm/lock.h
+++ linux/drivers/dlm/lock.h
@@ -26,6 +26,7 @@ int dlm_remove_from_waiters(struct dlm_l
 void dlm_scan_rsbs(struct dlm_ls *ls);
 
 int dlm_purge_locks(struct dlm_ls *ls);
+void dlm_purge_mstcpy_locks(struct dlm_rsb *r);
 int dlm_grant_after_purge(struct dlm_ls *ls);
 int dlm_recover_waiters_post(struct dlm_ls *ls);
 void dlm_recover_waiters_pre(struct dlm_ls *ls);
Index: linux/drivers/dlm/lockspace.c
===================================================================
--- linux.orig/drivers/dlm/lockspace.c
+++ linux/drivers/dlm/lockspace.c
@@ -185,8 +185,8 @@ static void threads_stop(void)
 	dlm_astd_stop();
 }
 
-static int new_lockspace(char *name, int namelen, void **lockspace, int flags,
-			 int lvblen)
+static int new_lockspace(char *name, int namelen, void **lockspace,
+			 uint32_t flags, int lvblen)
 {
 	struct dlm_ls *ls;
 	int i, size, error = -ENOMEM;
@@ -213,6 +213,7 @@ static int new_lockspace(char *name, int
 	memset(ls, 0, sizeof(struct dlm_ls) + namelen);
 	memcpy(ls->ls_name, name, namelen);
 	ls->ls_namelen = namelen;
+	ls->ls_exflags = flags;
 	ls->ls_lvblen = lvblen;
 	ls->ls_count = 0;
 	ls->ls_flags = 0;
@@ -345,8 +346,8 @@ static int new_lockspace(char *name, int
 	return error;
 }
 
-int dlm_new_lockspace(char *name, int namelen, void **lockspace, int flags,
-		      int lvblen)
+int dlm_new_lockspace(char *name, int namelen, void **lockspace,
+		      uint32_t flags, int lvblen)
 {
 	int error = 0;
 
Index: linux/drivers/dlm/rcom.c
===================================================================
--- linux.orig/drivers/dlm/rcom.c
+++ linux/drivers/dlm/rcom.c
@@ -75,12 +75,18 @@ static void send_rcom(struct dlm_ls *ls,
 static void make_config(struct dlm_ls *ls, struct rcom_config *rf)
 {
 	rf->rf_lvblen = ls->ls_lvblen;
+	rf->rf_lsflags = ls->ls_exflags;
 }
 
 static int check_config(struct dlm_ls *ls, struct rcom_config *rf)
 {
-	if (rf->rf_lvblen != ls->ls_lvblen)
+	if (rf->rf_lvblen != ls->ls_lvblen ||
+	    rf->rf_lsflags != ls->ls_exflags) {
+		log_error(ls, "config mismatch %d,%d %x,%x",
+			  rf->rf_lvblen, ls->ls_lvblen,
+			  rf->rf_lsflags, ls->ls_exflags);
 		return -EINVAL;
+	}
 	return 0;
 }
 
Index: linux/drivers/dlm/recover.c
===================================================================
--- linux.orig/drivers/dlm/recover.c
+++ linux/drivers/dlm/recover.c
@@ -60,8 +60,10 @@ int dlm_wait_function(struct dlm_ls *ls,
 	wait_event(ls->ls_wait_general, testfn(ls) || dlm_recovery_stopped(ls));
 	del_timer_sync(&ls->ls_timer);
 
-	if (dlm_recovery_stopped(ls))
+	if (dlm_recovery_stopped(ls)) {
+		log_debug(ls, "dlm_wait_function aborted");
 		error = -EINTR;
+	}
 	return error;
 }
 
@@ -98,9 +100,10 @@ static int wait_status_all(struct dlm_ls
 	list_for_each_entry(memb, &ls->ls_nodes, list) {
 		delay = 0;
 		for (;;) {
-			error = dlm_recovery_stopped(ls);
-			if (error)
+			if (dlm_recovery_stopped(ls)) {
+				error = -EINTR;
 				goto out;
+			}
 
 			error = dlm_rcom_status(ls, memb->nodeid);
 			if (error)
@@ -123,9 +126,10 @@ static int wait_status_low(struct dlm_ls
 	int error = 0, delay = 0, nodeid = ls->ls_low_nodeid;
 
 	for (;;) {
-		error = dlm_recovery_stopped(ls);
-		if (error)
+		if (dlm_recovery_stopped(ls)) {
+			error = -EINTR;
 			goto out;
+		}
 
 		error = dlm_rcom_status(ls, nodeid);
 		if (error)
@@ -306,14 +310,8 @@ static void set_master_lkbs(struct dlm_r
 static void set_new_master(struct dlm_rsb *r, int nodeid)
 {
 	lock_rsb(r);
-
-	if (nodeid == dlm_our_nodeid())
-		r->res_nodeid = 0;
-	else
-		r->res_nodeid = nodeid;
-
+	r->res_nodeid = nodeid;
 	set_master_lkbs(r);
-
 	rsb_set_flag(r, RSB_NEW_MASTER);
 	rsb_set_flag(r, RSB_NEW_MASTER2);
 	unlock_rsb(r);
@@ -337,6 +335,8 @@ static int recover_master(struct dlm_rsb
 		if (error)
 			log_error(ls, "recover dir lookup error %d", error);
 
+		if (ret_nodeid == our_nodeid)
+			ret_nodeid = 0;
 		set_new_master(r, ret_nodeid);
 	} else {
 		recover_list_add(r);
@@ -347,6 +347,27 @@ static int recover_master(struct dlm_rsb
 }
 
 /*
+ * When not using a directory, most resource names will hash to a new static
+ * master nodeid and the resource will need to be remastered.
+ */
+
+static int recover_master_static(struct dlm_rsb *r)
+{
+	int master = dlm_dir_nodeid(r);
+
+	if (master == dlm_our_nodeid())
+		master = 0;
+
+	if (r->res_nodeid != master) {
+		if (is_master(r))
+			dlm_purge_mstcpy_locks(r);
+		set_new_master(r, master);
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Go through local root resources and for each rsb which has a master which
  * has departed, get the new master nodeid from the directory.  The dir will
  * assign mastery to the first node to look up the new master.  That means
@@ -359,22 +380,21 @@ static int recover_master(struct dlm_rsb
 int dlm_recover_masters(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	int error, count = 0;
+	int error = 0, count = 0;
 
 	log_debug(ls, "dlm_recover_masters");
 
 	down_read(&ls->ls_root_sem);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
-		if (is_master(r))
-			continue;
-
-		error = dlm_recovery_stopped(ls);
-		if (error) {
+		if (dlm_recovery_stopped(ls)) {
 			up_read(&ls->ls_root_sem);
+			error = -EINTR;
 			goto out;
 		}
 
-		if (dlm_is_removed(ls, r->res_nodeid)) {
+		if (dlm_no_directory(ls))
+			count += recover_master_static(r);
+		else if (!is_master(r) && dlm_is_removed(ls, r->res_nodeid)) {
 			recover_master(r);
 			count++;
 		}
@@ -395,6 +415,7 @@ int dlm_recover_masters(struct dlm_ls *l
 int dlm_recover_master_reply(struct dlm_ls *ls, struct dlm_rcom *rc)
 {
 	struct dlm_rsb *r;
+	int nodeid;
 
 	r = recover_list_find(ls, rc->rc_id);
 	if (!r) {
@@ -403,7 +424,11 @@ int dlm_recover_master_reply(struct dlm_
 		goto out;
 	}
 
-	set_new_master(r, rc->rc_result);
+	nodeid = rc->rc_result;
+	if (nodeid == dlm_our_nodeid())
+		nodeid = 0;
+
+	set_new_master(r, nodeid);
 	recover_list_del(r);
 
 	if (recover_list_empty(ls))
@@ -499,8 +524,8 @@ int dlm_recover_locks(struct dlm_ls *ls)
 		if (!rsb_flag(r, RSB_NEW_MASTER))
 			continue;
 
-		error = dlm_recovery_stopped(ls);
-		if (error) {
+		if (dlm_recovery_stopped(ls)) {
+			error = -EINTR;
 			up_read(&ls->ls_root_sem);
 			goto out;
 		}
Index: linux/drivers/dlm/recoverd.c
===================================================================
--- linux.orig/drivers/dlm/recoverd.c
+++ linux/drivers/dlm/recoverd.c
@@ -122,7 +122,7 @@ static int ls_recover(struct dlm_ls *ls,
 	if (error)
 		goto fail;
 
-	if (neg) {
+	if (neg || dlm_no_directory(ls)) {
 		/*
 		 * Clear lkb's for departed nodes.
 		 */
Index: linux/drivers/dlm/requestqueue.c
===================================================================
--- linux.orig/drivers/dlm/requestqueue.c
+++ linux/drivers/dlm/requestqueue.c
@@ -13,6 +13,8 @@
 #include "dlm_internal.h"
 #include "member.h"
 #include "lock.h"
+#include "dir.h"
+#include "lowcomms.h"
 
 struct rq_entry {
 	struct list_head list;
@@ -113,28 +115,65 @@ void dlm_wait_requestqueue(struct dlm_ls
 	up(&ls->ls_requestqueue_lock);
 }
 
-/*
- * Dir lookups and lookup replies send before recovery are invalid because the
- * directory is rebuilt during recovery, so don't save any requests of this
- * type.  Don't save any requests from a node that's being removed either.
- */
+static int purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
+{
+	uint32_t type = ms->m_type;
+
+	if (dlm_is_removed(ls, nodeid))
+		return 1;
+
+	/* directory operations are always purged because the directory is
+	   always rebuilt during recovery and the lookups resent */
+
+	if (type == DLM_MSG_REMOVE ||
+	    type == DLM_MSG_LOOKUP ||
+	    type == DLM_MSG_LOOKUP_REPLY)
+		return 1;
+
+	if (!dlm_no_directory(ls))
+		return 0;
+
+	/* with no directory, the master is likely to change as a part of
+	   recovery; requests to/from the defunct master need to be purged */
+
+	switch (type) {
+	case DLM_MSG_REQUEST:
+	case DLM_MSG_CONVERT:
+	case DLM_MSG_UNLOCK:
+	case DLM_MSG_CANCEL:
+		/* we're no longer the master of this resource, the sender
+		   will resend to the new master (see waiter_needs_recovery) */
+
+		if (dlm_hash2nodeid(ls, ms->m_hash) != dlm_our_nodeid())
+			return 1;
+		break;
+
+	case DLM_MSG_REQUEST_REPLY:
+	case DLM_MSG_CONVERT_REPLY:
+	case DLM_MSG_UNLOCK_REPLY:
+	case DLM_MSG_CANCEL_REPLY:
+	case DLM_MSG_GRANT:
+		/* this reply is from the former master of the resource,
+		   we'll resend to the new master if needed */
+
+		if (dlm_hash2nodeid(ls, ms->m_hash) != nodeid)
+			return 1;
+		break;
+	}
+
+	return 0;
+}
 
 void dlm_purge_requestqueue(struct dlm_ls *ls)
 {
 	struct dlm_message *ms;
 	struct rq_entry *e, *safe;
-	uint32_t mstype;
 
 	down(&ls->ls_requestqueue_lock);
 	list_for_each_entry_safe(e, safe, &ls->ls_requestqueue, list) {
-
 		ms = (struct dlm_message *) e->request;
-		mstype = ms->m_type;
 
-		if (dlm_is_removed(ls, e->nodeid) ||
-		    mstype == DLM_MSG_REMOVE ||
-	            mstype == DLM_MSG_LOOKUP ||
-	            mstype == DLM_MSG_LOOKUP_REPLY) {
+		if (purge_request(ls, ms, e->nodeid)) {
 			list_del(&e->list);
 			kfree(e);
 		}
Index: linux/drivers/dlm/util.c
===================================================================
--- linux.orig/drivers/dlm/util.c
+++ linux/drivers/dlm/util.c
@@ -80,6 +80,7 @@ void dlm_message_out(struct dlm_message 
 	ms->m_sbflags		= cpu_to_le32(ms->m_sbflags);
 	ms->m_flags		= cpu_to_le32(ms->m_flags);
 	ms->m_lvbseq		= cpu_to_le32(ms->m_lvbseq);
+	ms->m_hash		= cpu_to_le32(ms->m_hash);
 	ms->m_status		= cpu_to_le32(ms->m_status);
 	ms->m_grmode		= cpu_to_le32(ms->m_grmode);
 	ms->m_rqmode		= cpu_to_le32(ms->m_rqmode);
@@ -107,6 +108,7 @@ void dlm_message_in(struct dlm_message *
 	ms->m_sbflags		= le32_to_cpu(ms->m_sbflags);
 	ms->m_flags		= le32_to_cpu(ms->m_flags);
 	ms->m_lvbseq		= le32_to_cpu(ms->m_lvbseq);
+	ms->m_hash		= le32_to_cpu(ms->m_hash);
 	ms->m_status		= le32_to_cpu(ms->m_status);
 	ms->m_grmode		= le32_to_cpu(ms->m_grmode);
 	ms->m_rqmode		= le32_to_cpu(ms->m_rqmode);
Index: linux/include/linux/dlm.h
===================================================================
--- linux.orig/include/linux/dlm.h
+++ linux/include/linux/dlm.h
@@ -204,6 +204,8 @@ struct dlm_lksb {
 
 #ifdef __KERNEL__
 
+#define DLM_LSFL_NODIR		0x00000001
+
 /*
  * dlm_new_lockspace
  *
@@ -212,7 +214,7 @@ struct dlm_lksb {
  */
 
 int dlm_new_lockspace(char *name, int namelen, dlm_lockspace_t **lockspace,
-		      int flags, int lvblen);
+		      uint32_t flags, int lvblen);
 
 /*
  * dlm_release_lockspace

--
