Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263283AbVGOKeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263283AbVGOKeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGOKcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:32:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263280AbVGOKbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:31:50 -0400
Date: Fri, 15 Jul 2005 18:36:30 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 06/12] dlm: rework recovery control
Message-ID: <20050715103630.GI17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="control-recovery.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rework recovery control, simplifying the process significantly and
removing a lot of code.  This also makes it easier for different
user-space infrastructures to drive the dlm.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/ast.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/ast.c
+++ linux-2.6.12-mm1/drivers/dlm/ast.c
@@ -61,7 +61,7 @@ static void process_asts(void)
 			r = lkb->lkb_resource;
 			ls = r->res_ls;
 
-			if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
+			if (dlm_locking_stopped(ls))
 				continue;
 
 			list_del(&lkb->lkb_astqueue);
Index: linux-2.6.12-mm1/drivers/dlm/dir.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dir.c
+++ linux-2.6.12-mm1/drivers/dlm/dir.c
@@ -270,7 +270,7 @@ int dlm_recover_directory(struct dlm_ls 
 		;
 	}
 
-	set_bit(LSFL_DIR_VALID, &ls->ls_flags);
+	dlm_set_recover_status(ls, DLM_RS_DIR);
 	error = 0;
 
 	log_debug(ls, "dlm_recover_directory %d entries", count);
Index: linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dlm_internal.h
+++ linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
@@ -133,7 +133,6 @@ struct dlm_lkbtable {
 struct dlm_member {
 	struct list_head	list;
 	int			nodeid;
-	int			gone_event;
 	int			weight;
 };
 
@@ -145,7 +144,7 @@ struct dlm_recover {
 	struct list_head	list;
 	int			*nodeids;
 	int			node_count;
-	int			event_id;
+	uint64_t		seq;
 };
 
 /*
@@ -262,6 +261,7 @@ struct dlm_lkb {
 	long			lkb_astparam;	/* caller's ast arg */
 };
 
+
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
@@ -376,12 +376,14 @@ struct dlm_message {
 };
 
 
-#define DIR_VALID		0x00000001
-#define DIR_ALL_VALID		0x00000002
-#define NODES_VALID		0x00000004
-#define NODES_ALL_VALID		0x00000008
-#define LOCKS_VALID		0x00000010
-#define LOCKS_ALL_VALID		0x00000020
+#define DLM_RS_NODES		0x00000001
+#define DLM_RS_NODES_ALL	0x00000002
+#define DLM_RS_DIR		0x00000004
+#define DLM_RS_DIR_ALL		0x00000008
+#define DLM_RS_LOCKS		0x00000010
+#define DLM_RS_LOCKS_ALL	0x00000020
+#define DLM_RS_DONE		0x00000040
+#define DLM_RS_DONE_ALL		0x00000080
 
 #define DLM_RCOM_STATUS		1
 #define DLM_RCOM_NAMES		2
@@ -427,31 +429,6 @@ struct rcom_lock {
 	char			rl_lvb[0];
 };
 
-
-#define LSST_NONE		0
-#define LSST_INIT		1
-#define LSST_INIT_DONE		2
-#define LSST_CLEAR		3
-#define LSST_WAIT_START		4
-#define LSST_RECONFIG_DONE	5
-
-#define LSFL_WORK		0
-#define LSFL_LS_RUN		1
-#define LSFL_LS_STOP		2
-#define LSFL_LS_START		3
-#define LSFL_LS_FINISH		4
-#define LSFL_RCOM_READY		5
-#define LSFL_FINISH_RECOVERY	6
-#define LSFL_DIR_VALID		7
-#define LSFL_ALL_DIR_VALID	8
-#define LSFL_NODES_VALID	9
-#define LSFL_ALL_NODES_VALID	10
-#define LSFL_LS_TERMINATE	11
-#define LSFL_JOIN_DONE		12
-#define LSFL_LEAVE_DONE		13
-#define LSFL_LOCKS_VALID	14
-#define LSFL_ALL_LOCKS_VALID	15
-
 struct dlm_ls {
 	struct list_head	ls_list;	/* list of lockspaces */
 	uint32_t		ls_global_id;	/* global unique lockspace ID */
@@ -487,20 +464,18 @@ struct dlm_ls {
 
 	struct dentry		*ls_debug_dentry; /* debugfs */
 
+	wait_queue_head_t	ls_uevent_wait;	/* user part of join/leave */
+	int			ls_uevent_result;
+
 	/* recovery related */
 
 	struct timer_list	ls_timer;
-	wait_queue_head_t	ls_wait_member;
 	struct task_struct	*ls_recoverd_task;
 	struct semaphore	ls_recoverd_active;
-	struct list_head	ls_recover;	/* dlm_recover structs */
 	spinlock_t		ls_recover_lock;
-	int			ls_last_stop;
-	int			ls_last_start;
-	int			ls_last_finish;
-	int			ls_startdone;
-	int			ls_state;	/* recovery states */
-
+	uint32_t		ls_recover_status; /* DLM_RS_ */
+	uint64_t		ls_recover_seq;
+	struct dlm_recover	*ls_recover_args;
 	struct rw_semaphore	ls_in_recovery;	/* block local requests */
 	struct list_head	ls_requestqueue;/* queue remote requests */
 	struct semaphore	ls_requestqueue_lock;
@@ -517,5 +492,21 @@ struct dlm_ls {
 	char			ls_name[1];
 };
 
+#define LSFL_WORK		0
+#define LSFL_RUNNING		1
+#define LSFL_RECOVERY_STOP	2
+#define LSFL_RCOM_READY		3
+#define LSFL_UEVENT_WAIT	4
+
+static inline int dlm_locking_stopped(struct dlm_ls *ls)
+{
+	return !test_bit(LSFL_RUNNING, &ls->ls_flags);
+}
+
+static inline int dlm_recovery_stopped(struct dlm_ls *ls)
+{
+	return test_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
+}
+
 #endif				/* __DLM_INTERNAL_DOT_H__ */
 
Index: linux-2.6.12-mm1/drivers/dlm/lock.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lock.c
+++ linux-2.6.12-mm1/drivers/dlm/lock.c
@@ -800,7 +800,7 @@ void dlm_scan_rsbs(struct dlm_ls *ls)
 {
 	int i;
 
-	if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
+	if (dlm_locking_stopped(ls))
 		return;
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
@@ -3086,7 +3086,7 @@ int dlm_receive_message(struct dlm_heade
 	   recovery operation is starting. */
 
 	while (1) {
-		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags)) {
+		if (dlm_locking_stopped(ls)) {
 			if (!recovery)
 				dlm_add_requestqueue(ls, nodeid, hd);
 			error = -EINTR;
@@ -3293,7 +3293,7 @@ int dlm_recover_waiters_post(struct dlm_
 	int error = 0, mstype;
 
 	while (1) {
-		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags)) {
+		if (dlm_locking_stopped(ls)) {
 			log_debug(ls, "recover_waiters_post aborted");
 			error = -EINTR;
 			break;
Index: linux-2.6.12-mm1/drivers/dlm/lockspace.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lockspace.c
+++ linux-2.6.12-mm1/drivers/dlm/lockspace.c
@@ -252,36 +252,46 @@ static int new_lockspace(char *name, int
 		rwlock_init(&ls->ls_dirtbl[i].lock);
 	}
 
-	ls->ls_recover_buf = kmalloc(dlm_config.buffer_size, GFP_KERNEL);
-	if (!ls->ls_recover_buf)
-		goto out_dirfree;
+	INIT_LIST_HEAD(&ls->ls_waiters);
+	init_MUTEX(&ls->ls_waiters_sem);
 
-	init_waitqueue_head(&ls->ls_wait_member);
 	INIT_LIST_HEAD(&ls->ls_nodes);
 	INIT_LIST_HEAD(&ls->ls_nodes_gone);
-	INIT_LIST_HEAD(&ls->ls_waiters);
 	ls->ls_num_nodes = 0;
+	ls->ls_low_nodeid = 0;
+	ls->ls_total_weight = 0;
 	ls->ls_node_array = NULL;
+	ls->ls_nodeids_next = NULL;
+	ls->ls_nodeids_next_count = 0;
+
+	memset(&ls->ls_stub_rsb, 0, sizeof(struct dlm_rsb));
+	ls->ls_stub_rsb.res_ls = ls;
+
+	ls->ls_debug_dentry = NULL;
+
+	init_waitqueue_head(&ls->ls_uevent_wait);
+	ls->ls_uevent_result = 0;
+
 	ls->ls_recoverd_task = NULL;
 	init_MUTEX(&ls->ls_recoverd_active);
-	INIT_LIST_HEAD(&ls->ls_recover);
 	spin_lock_init(&ls->ls_recover_lock);
+	ls->ls_recover_status = 0;
+	ls->ls_recover_seq = 0;
+	ls->ls_recover_args = NULL;
+	init_rwsem(&ls->ls_in_recovery);
+	INIT_LIST_HEAD(&ls->ls_requestqueue);
+	init_MUTEX(&ls->ls_requestqueue_lock);
+
+	ls->ls_recover_buf = kmalloc(dlm_config.buffer_size, GFP_KERNEL);
+	if (!ls->ls_recover_buf)
+		goto out_dirfree;
+
 	INIT_LIST_HEAD(&ls->ls_recover_list);
-	ls->ls_recover_list_count = 0;
 	spin_lock_init(&ls->ls_recover_list_lock);
+	ls->ls_recover_list_count = 0;
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_root_list);
-	INIT_LIST_HEAD(&ls->ls_requestqueue);
-	ls->ls_last_stop = 0;
-	ls->ls_last_start = 0;
-	ls->ls_last_finish = 0;
-	init_MUTEX(&ls->ls_waiters_sem);
-	init_MUTEX(&ls->ls_requestqueue_lock);
 	init_rwsem(&ls->ls_root_sem);
-	init_rwsem(&ls->ls_in_recovery);
-
-	memset(&ls->ls_stub_rsb, 0, sizeof(struct dlm_rsb));
-	ls->ls_stub_rsb.res_ls = ls;
 
 	down_write(&ls->ls_in_recovery);
 
@@ -291,8 +301,6 @@ static int new_lockspace(char *name, int
 		goto out_rcomfree;
 	}
 
-	ls->ls_state = LSST_INIT;
-
 	spin_lock(&lslist_lock);
 	list_add(&ls->ls_list, &lslist);
 	spin_unlock(&lslist_lock);
@@ -307,22 +315,10 @@ static int new_lockspace(char *name, int
 	if (error)
 		goto out_del;
 
-	kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE, NULL);
-
-	/* Now we depend on userspace to notice the new ls, join it and
-	   give us a start or terminate.  The ls isn't actually running
-	   until it receives a start. */
-
-	error = wait_event_interruptible(ls->ls_wait_member,
-				test_bit(LSFL_JOIN_DONE, &ls->ls_flags));
+	error = dlm_uevent(ls, 1);
 	if (error)
 		goto out_unreg;
 
-	if (test_bit(LSFL_LS_TERMINATE, &ls->ls_flags)) {
-		error = -ERESTARTSYS;
-		goto out_unreg;
-	}
-
 	*lockspace = ls;
 	return 0;
 
@@ -402,19 +398,15 @@ static int release_lockspace(struct dlm_
 {
 	struct dlm_lkb *lkb;
 	struct dlm_rsb *rsb;
-	struct dlm_recover *rv;
 	struct list_head *head;
-	int i, error;
+	int i;
 	int busy = lockspace_busy(ls);
 
 	if (busy > force)
 		return -EBUSY;
 
-	if (force < 3) {
-		error = kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE, NULL);
-		error = wait_event_interruptible(ls->ls_wait_member,
-				test_bit(LSFL_LEAVE_DONE, &ls->ls_flags));
-	}
+	if (force < 3)
+		dlm_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
 
@@ -486,13 +478,7 @@ static int release_lockspace(struct dlm_
 	 * Free structures on any other lists
 	 */
 
-	head = &ls->ls_recover;
-	while (!list_empty(head)) {
-		rv = list_entry(head->next, struct dlm_recover, list);
-		list_del(&rv->list);
-		kfree(rv);
-	}
-
+	kfree(ls->ls_recover_args);
 	dlm_clear_free_entries(ls);
 	dlm_clear_members(ls);
 	dlm_clear_members_gone(ls);
Index: linux-2.6.12-mm1/drivers/dlm/member.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member.c
+++ linux-2.6.12-mm1/drivers/dlm/member.c
@@ -112,18 +112,6 @@ void dlm_clear_members_gone(struct dlm_l
 	clear_memb_list(&ls->ls_nodes_gone);
 }
 
-void dlm_clear_members_finish(struct dlm_ls *ls, int finish_event)
-{
-	struct dlm_member *memb, *safe;
-
-	list_for_each_entry_safe(memb, safe, &ls->ls_nodes_gone, list) {
-		if (memb->gone_event <= finish_event) {
-			list_del(&memb->list);
-			kfree(memb);
-		}
-	}
-}
-
 static void make_member_array(struct dlm_ls *ls)
 {
 	struct dlm_member *memb;
@@ -195,7 +183,6 @@ int dlm_recover_members(struct dlm_ls *l
 
 		if (!found) {
 			neg++;
-			memb->gone_event = rv->event_id;
 			dlm_remove_member(ls, memb);
 			log_debug(ls, "remove member %d", memb->nodeid);
 		}
@@ -218,7 +205,7 @@ int dlm_recover_members(struct dlm_ls *l
 	ls->ls_low_nodeid = low;
 
 	make_member_array(ls);
-	set_bit(LSFL_NODES_VALID, &ls->ls_flags);
+	dlm_set_recover_status(ls, DLM_RS_NODES);
 	*neg_out = neg;
 
 	ping_members(ls);
@@ -228,57 +215,24 @@ int dlm_recover_members(struct dlm_ls *l
 	return error;
 }
 
-int dlm_recover_members_first(struct dlm_ls *ls, struct dlm_recover *rv)
-{
-	int i, error, nodeid, low = -1;
-
-	dlm_clear_members(ls);
-
-	log_debug(ls, "add members");
-
-	for (i = 0; i < rv->node_count; i++) {
-		nodeid = rv->nodeids[i];
-		dlm_add_member(ls, nodeid);
-
-		if (low == -1 || nodeid < low)
-			low = nodeid;
-	}
-	ls->ls_low_nodeid = low;
-
-	make_member_array(ls);
-	set_bit(LSFL_NODES_VALID, &ls->ls_flags);
-
-	ping_members(ls);
-
-	error = dlm_recover_members_wait(ls);
-	log_debug(ls, "total members %d", ls->ls_num_nodes);
-	return error;
-}
-
 /*
  * Following called from member_sysfs.c
  */
 
-int dlm_ls_terminate(struct dlm_ls *ls)
-{
-	spin_lock(&ls->ls_recover_lock);
-	set_bit(LSFL_LS_TERMINATE, &ls->ls_flags);
-	set_bit(LSFL_JOIN_DONE, &ls->ls_flags);
-	set_bit(LSFL_LEAVE_DONE, &ls->ls_flags);
-	spin_unlock(&ls->ls_recover_lock);
-	wake_up(&ls->ls_wait_member);
-	log_error(ls, "dlm_ls_terminate");
-	return 0;
-}
-
 int dlm_ls_stop(struct dlm_ls *ls)
 {
 	int new;
 
+	/*
+	 * A stop cancels any recovery that's in progress (see RECOVERY_STOP,
+	 * dlm_recovery_stopped()) and prevents any new locks from being
+	 * processed (see RUNNING, dlm_locking_stopped()).
+	 */
+
 	spin_lock(&ls->ls_recover_lock);
-	ls->ls_last_stop = ls->ls_last_start;
-	set_bit(LSFL_LS_STOP, &ls->ls_flags);
-	new = test_and_clear_bit(LSFL_LS_RUN, &ls->ls_flags);
+	set_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
+	new = test_and_clear_bit(LSFL_RUNNING, &ls->ls_flags);
+	ls->ls_recover_seq++;
 	spin_unlock(&ls->ls_recover_lock);
 
 	/*
@@ -295,26 +249,20 @@ int dlm_ls_stop(struct dlm_ls *ls)
 
 	/*
 	 * The recoverd suspend/resume makes sure that dlm_recoverd (if
-	 * running) has noticed the clearing of LS_RUN above and quit
+	 * running) has noticed the clearing of RUNNING above and quit
 	 * processing the previous recovery.  This will be true for all nodes
-	 * before any nodes get the start.
+	 * before any nodes start the new recovery.
 	 */
 
 	dlm_recoverd_suspend(ls);
-	clear_bit(LSFL_LOCKS_VALID, &ls->ls_flags);
-	clear_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags);
-	clear_bit(LSFL_DIR_VALID, &ls->ls_flags);
-	clear_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
-	clear_bit(LSFL_NODES_VALID, &ls->ls_flags);
-	clear_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags);
+	ls->ls_recover_status = 0;
 	dlm_recoverd_resume(ls);
-	dlm_recoverd_kick(ls);
 	return 0;
 }
 
-int dlm_ls_start(struct dlm_ls *ls, int event_nr)
+int dlm_ls_start(struct dlm_ls *ls)
 {
-	struct dlm_recover *rv;
+	struct dlm_recover *rv, *rv_old;
 	int error = 0;
 
 	rv = kmalloc(sizeof(struct dlm_recover), GFP_KERNEL);
@@ -324,7 +272,9 @@ int dlm_ls_start(struct dlm_ls *ls, int 
 
 	spin_lock(&ls->ls_recover_lock);
 
-	if (test_bit(LSFL_LS_RUN, &ls->ls_flags)) {
+	/* the lockspace needs to be stopped before it can be started */
+
+	if (!dlm_locking_stopped(ls)) {
 		spin_unlock(&ls->ls_recover_lock);
 		log_error(ls, "start ignored: lockspace running");
 		kfree(rv);
@@ -340,44 +290,21 @@ int dlm_ls_start(struct dlm_ls *ls, int 
 		goto out;
 	}
 
-	if (event_nr <= ls->ls_last_start) {
-		spin_unlock(&ls->ls_recover_lock);
-		log_error(ls, "start event_nr %d not greater than last %d",
-			  event_nr, ls->ls_last_start);
-		kfree(rv);
-		error = -EINVAL;
-		goto out;
-	}
-
 	rv->nodeids = ls->ls_nodeids_next;
 	ls->ls_nodeids_next = NULL;
 	rv->node_count = ls->ls_nodeids_next_count;
-	rv->event_id = event_nr;
-	ls->ls_last_start = event_nr;
-	list_add_tail(&rv->list, &ls->ls_recover);
-	set_bit(LSFL_LS_START, &ls->ls_flags);
+	rv->seq = ++ls->ls_recover_seq;
+	rv_old = ls->ls_recover_args;
+	ls->ls_recover_args = rv;
 	spin_unlock(&ls->ls_recover_lock);
 
-	set_bit(LSFL_JOIN_DONE, &ls->ls_flags);
-	wake_up(&ls->ls_wait_member);
+	if (rv_old) {
+		kfree(rv_old->nodeids);
+		kfree(rv_old);
+	}
+
 	dlm_recoverd_kick(ls);
  out:
 	return error;
 }
 
-int dlm_ls_finish(struct dlm_ls *ls, int event_nr)
-{
-	spin_lock(&ls->ls_recover_lock);
-	if (event_nr != ls->ls_last_start) {
-		spin_unlock(&ls->ls_recover_lock);
-		log_error(ls, "finish event_nr %d doesn't match start %d",
-			  event_nr, ls->ls_last_start);
-		return -EINVAL;
-	}
-	ls->ls_last_finish = event_nr;
-	set_bit(LSFL_LS_FINISH, &ls->ls_flags);
-	spin_unlock(&ls->ls_recover_lock);
-	dlm_recoverd_kick(ls);
-	return 0;
-}
-
Index: linux-2.6.12-mm1/drivers/dlm/member.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member.h
+++ linux-2.6.12-mm1/drivers/dlm/member.h
@@ -13,15 +13,10 @@
 #ifndef __MEMBER_DOT_H__
 #define __MEMBER_DOT_H__
 
-int dlm_ls_terminate(struct dlm_ls *ls);
 int dlm_ls_stop(struct dlm_ls *ls);
-int dlm_ls_start(struct dlm_ls *ls, int event_nr);
-int dlm_ls_finish(struct dlm_ls *ls, int event_nr);
-
+int dlm_ls_start(struct dlm_ls *ls);
 void dlm_clear_members(struct dlm_ls *ls);
 void dlm_clear_members_gone(struct dlm_ls *ls);
-void dlm_clear_members_finish(struct dlm_ls *ls, int finish_event);
-int dlm_recover_members_first(struct dlm_ls *ls, struct dlm_recover *rv);
 int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv,int *neg_out);
 int dlm_is_removed(struct dlm_ls *ls, int nodeid);
 
Index: linux-2.6.12-mm1/drivers/dlm/member_sysfs.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member_sysfs.c
+++ linux-2.6.12-mm1/drivers/dlm/member_sysfs.c
@@ -13,113 +13,33 @@
 #include "dlm_internal.h"
 #include "member.h"
 
-/*
-/dlm/lsname/stop       RW  write 1 to suspend operation
-/dlm/lsname/start      RW  write event_nr to start recovery
-/dlm/lsname/finish     RW  write event_nr to finish recovery
-/dlm/lsname/terminate  RW  write event_nr to term recovery
-/dlm/lsname/done       RO  event_nr dlm is done processing
-/dlm/lsname/id         RW  global id of lockspace
-/dlm/lsname/members    RW  read = current members, write = next members
-*/
 
-
-static ssize_t dlm_stop_show(struct dlm_ls *ls, char *buf)
-{
-	ssize_t ret;
-	int val;
-
-	spin_lock(&ls->ls_recover_lock);
-	val = ls->ls_last_stop;
-	spin_unlock(&ls->ls_recover_lock);
-	ret = sprintf(buf, "%d\n", val);
-	return ret;
-}
-
-static ssize_t dlm_stop_store(struct dlm_ls *ls, const char *buf, size_t len)
+static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
 {
-	ssize_t ret = -EINVAL;
+	ssize_t ret = len;
+	int n = simple_strtol(buf, NULL, 0);
 
-	if (simple_strtol(buf, NULL, 0) == 1) {
+	switch (n) {
+	case 0:
 		dlm_ls_stop(ls);
-		ret = len;
+		break;
+	case 1:
+		dlm_ls_start(ls);
+		break;
+	default:
+		ret = -EINVAL;
 	}
 	return ret;
 }
 
-static ssize_t dlm_start_show(struct dlm_ls *ls, char *buf)
-{
-	ssize_t ret;
-	int val;
-
-	spin_lock(&ls->ls_recover_lock);
-	val = ls->ls_last_start;
-	spin_unlock(&ls->ls_recover_lock);
-	ret = sprintf(buf, "%d\n", val);
-	return ret;
-}
-
-static ssize_t dlm_start_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	ssize_t ret;
-	ret = dlm_ls_start(ls, simple_strtol(buf, NULL, 0));
-	return ret ? ret : len;
-}
-
-static ssize_t dlm_finish_show(struct dlm_ls *ls, char *buf)
-{
-	ssize_t ret;
-	int val;
-
-	spin_lock(&ls->ls_recover_lock);
-	val = ls->ls_last_finish;
-	spin_unlock(&ls->ls_recover_lock);
-	ret = sprintf(buf, "%d\n", val);
-	return ret;
-}
-
-static ssize_t dlm_finish_store(struct dlm_ls *ls, const char *buf, size_t len)
+static ssize_t dlm_event_store(struct dlm_ls *ls, const char *buf, size_t len)
 {
-	dlm_ls_finish(ls, simple_strtol(buf, NULL, 0));
+	ls->ls_uevent_result = simple_strtol(buf, NULL, 0);
+	set_bit(LSFL_UEVENT_WAIT, &ls->ls_flags);
+	wake_up(&ls->ls_uevent_wait);
 	return len;
 }
 
-static ssize_t dlm_terminate_show(struct dlm_ls *ls, char *buf)
-{
-	ssize_t ret;
-	int val = 0;
-
-	spin_lock(&ls->ls_recover_lock);
-	if (test_bit(LSFL_LS_TERMINATE, &ls->ls_flags))
-		val = 1;
-	spin_unlock(&ls->ls_recover_lock);
-	ret = sprintf(buf, "%d\n", val);
-	return ret;
-}
-
-static ssize_t dlm_terminate_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	ssize_t ret = -EINVAL;
-
-	if (simple_strtol(buf, NULL, 0) == 1) {
-		dlm_ls_terminate(ls);
-		ret = len;
-	}
-	return ret;
-}
-
-static ssize_t dlm_done_show(struct dlm_ls *ls, char *buf)
-{
-	ssize_t ret;
-	int val;
-
-	spin_lock(&ls->ls_recover_lock);
-	val = ls->ls_startdone;
-	spin_unlock(&ls->ls_recover_lock);
-	ret = sprintf(buf, "%d\n", val);
-	return ret;
-}
-
 static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
 {
 	return sprintf(buf, "%u\n", ls->ls_global_id);
@@ -204,33 +124,14 @@ struct dlm_attr {
 	ssize_t (*store)(struct dlm_ls *, const char *, size_t);
 };
 
-static struct dlm_attr dlm_attr_stop = {
-	.attr  = {.name = "stop", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_stop_show,
-	.store = dlm_stop_store
-};
-
-static struct dlm_attr dlm_attr_start = {
-	.attr  = {.name = "start", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_start_show,
-	.store = dlm_start_store
-};
-
-static struct dlm_attr dlm_attr_finish = {
-	.attr  = {.name = "finish", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_finish_show,
-	.store = dlm_finish_store
-};
-
-static struct dlm_attr dlm_attr_terminate = {
-	.attr  = {.name = "terminate", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_terminate_show,
-	.store = dlm_terminate_store
+static struct dlm_attr dlm_attr_control = {
+	.attr  = {.name = "control", .mode = S_IWUSR},
+	.store = dlm_control_store
 };
 
-static struct dlm_attr dlm_attr_done = {
-	.attr  = {.name = "done", .mode = S_IRUGO},
-	.show  = dlm_done_show,
+static struct dlm_attr dlm_attr_event = {
+	.attr  = {.name = "event_done", .mode = S_IWUSR},
+	.store = dlm_event_store
 };
 
 static struct dlm_attr dlm_attr_id = {
@@ -246,11 +147,8 @@ static struct dlm_attr dlm_attr_members 
 };
 
 static struct attribute *dlm_attrs[] = {
-	&dlm_attr_stop.attr,
-	&dlm_attr_start.attr,
-	&dlm_attr_finish.attr,
-	&dlm_attr_terminate.attr,
-	&dlm_attr_done.attr,
+	&dlm_attr_control.attr,
+	&dlm_attr_event.attr,
 	&dlm_attr_id.attr,
 	&dlm_attr_members.attr,
 	NULL,
@@ -320,3 +218,22 @@ int dlm_kobject_setup(struct dlm_ls *ls)
 	return 0;
 }
 
+int dlm_uevent(struct dlm_ls *ls, int in)
+{
+	int error;
+
+	if (in)
+		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE, NULL);
+	else
+		kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE, NULL);
+
+	error = wait_event_interruptible(ls->ls_uevent_wait,
+			test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
+	if (error)
+		goto out;
+
+	error = ls->ls_uevent_result;
+ out:
+	return error;
+}
+
Index: linux-2.6.12-mm1/drivers/dlm/member_sysfs.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member_sysfs.h
+++ linux-2.6.12-mm1/drivers/dlm/member_sysfs.h
@@ -16,6 +16,7 @@
 int dlm_member_sysfs_init(void);
 void dlm_member_sysfs_exit(void);
 int dlm_kobject_setup(struct dlm_ls *ls);
+int dlm_uevent(struct dlm_ls *ls, int in);
 
 #endif                          /* __MEMBER_SYSFS_DOT_H__ */
 
Index: linux-2.6.12-mm1/drivers/dlm/rcom.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/rcom.c
+++ linux-2.6.12-mm1/drivers/dlm/rcom.c
@@ -84,31 +84,6 @@ static int check_config(struct dlm_ls *l
 	return 0;
 }
 
-static int make_status(struct dlm_ls *ls)
-{
-	int status = 0;
-
-	if (test_bit(LSFL_NODES_VALID, &ls->ls_flags))
-		status |= NODES_VALID;
-
-	if (test_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags))
-		status |= NODES_ALL_VALID;
-
-	if (test_bit(LSFL_DIR_VALID, &ls->ls_flags))
-		status |= DIR_VALID;
-
-	if (test_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags))
-		status |= DIR_ALL_VALID;
-
-	if (test_bit(LSFL_LOCKS_VALID, &ls->ls_flags))
-		status |= LOCKS_VALID;
-
-	if (test_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags))
-		status |= LOCKS_ALL_VALID;
-
-	return status;
-}
-
 int dlm_rcom_status(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_rcom *rc;
@@ -119,7 +94,7 @@ int dlm_rcom_status(struct dlm_ls *ls, i
 
 	if (nodeid == dlm_our_nodeid()) {
 		rc = (struct dlm_rcom *) ls->ls_recover_buf;
-		rc->rc_result = make_status(ls);
+		rc->rc_result = dlm_recover_status(ls);
 		goto out;
 	}
 
@@ -150,7 +125,7 @@ static void receive_rcom_status(struct d
 			    sizeof(struct rcom_config), &rc, &mh);
 	if (error)
 		return;
-	rc->rc_result = make_status(ls);
+	rc->rc_result = dlm_recover_status(ls);
 	make_config(ls, (struct rcom_config *) rc->rc_buf);
 
 	send_rcom(ls, mh, rc);
@@ -197,6 +172,7 @@ static void receive_rcom_names(struct dl
 	struct dlm_mhandle *mh;
 	int error, inlen, outlen;
 	int nodeid = rc_in->rc_header.h_nodeid;
+	uint32_t status = dlm_recover_status(ls);
 
 	/*
 	 * We can't run dlm_dir_rebuild_send (which uses ls_nodes) while
@@ -205,7 +181,7 @@ static void receive_rcom_names(struct dl
 	 * message from a previous instance of recovery.
 	 */
 
-	if (!test_bit(LSFL_NODES_VALID, &ls->ls_flags)) {
+	if (!(status & DLM_RS_NODES)) {
 		log_debug(ls, "ignoring RCOM_NAMES from %u", nodeid);
 		return;
 	}
@@ -355,7 +331,9 @@ static void receive_rcom_lock(struct dlm
 
 static void receive_rcom_lock_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
 {
-	if (!test_bit(LSFL_DIR_VALID, &ls->ls_flags)) {
+	uint32_t status = dlm_recover_status(ls);
+
+	if (!(status & DLM_RS_DIR)) {
 		log_debug(ls, "ignoring RCOM_LOCK_REPLY from %u",
 			  rc_in->rc_header.h_nodeid);
 		return;
Index: linux-2.6.12-mm1/drivers/dlm/recover.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recover.c
+++ linux-2.6.12-mm1/drivers/dlm/recover.c
@@ -30,19 +30,14 @@
  * the one being waited for).
  */
 
-int dlm_recovery_stopped(struct dlm_ls *ls)
-{
-	return test_bit(LSFL_LS_STOP, &ls->ls_flags);
-}
-
 /*
- * Wait until given function returns non-zero or lockspace is stopped (LS_STOP
- * set due to failure of a node in ls_nodes).  When another function thinks it
- * could have completed the waited-on task, they should wake up ls_wait_general
- * to get an immediate response rather than waiting for the timer to detect the
- * result.  A timer wakes us up periodically while waiting to see if we should
- * abort due to a node failure.  This should only be called by the dlm_recoverd
- * thread.
+ * Wait until given function returns non-zero or lockspace is stopped
+ * (LS_RECOVERY_STOP set due to failure of a node in ls_nodes).  When another
+ * function thinks it could have completed the waited-on task, they should wake
+ * up ls_wait_general to get an immediate response rather than waiting for the
+ * timer to detect the result.  A timer wakes us up periodically while waiting
+ * to see if we should abort due to a node failure.  This should only be called
+ * by the dlm_recoverd thread.
  */
 
 static void dlm_wait_timer_fn(unsigned long data)
@@ -73,11 +68,28 @@ int dlm_wait_function(struct dlm_ls *ls,
 /*
  * An efficient way for all nodes to wait for all others to have a certain
  * status.  The node with the lowest nodeid polls all the others for their
- * status (dlm_wait_status_all) and all the others poll the node with the low
- * id for its accumulated result (dlm_wait_status_low).
+ * status (wait_status_all) and all the others poll the node with the low id
+ * for its accumulated result (wait_status_low).  When all nodes have set
+ * status flag X, then status flag X_ALL will be set on the low nodeid.
  */
 
-static int dlm_wait_status_all(struct dlm_ls *ls, unsigned int wait_status)
+uint32_t dlm_recover_status(struct dlm_ls *ls)
+{
+	uint32_t status;
+	spin_lock(&ls->ls_recover_lock);
+	status = ls->ls_recover_status;
+	spin_unlock(&ls->ls_recover_lock);
+	return status;
+}
+
+void dlm_set_recover_status(struct dlm_ls *ls, uint32_t status)
+{
+	spin_lock(&ls->ls_recover_lock);
+	ls->ls_recover_status |= status;
+	spin_unlock(&ls->ls_recover_lock);
+}
+
+static int wait_status_all(struct dlm_ls *ls, uint32_t wait_status)
 {
 	struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
 	struct dlm_member *memb;
@@ -105,7 +117,7 @@ static int dlm_wait_status_all(struct dl
 	return error;
 }
 
-static int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status)
+static int wait_status_low(struct dlm_ls *ls, uint32_t wait_status)
 {
 	struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
 	int error = 0, delay = 0, nodeid = ls->ls_low_nodeid;
@@ -129,46 +141,39 @@ static int dlm_wait_status_low(struct dl
 	return error;
 }
 
-int dlm_recover_members_wait(struct dlm_ls *ls)
+static int wait_status(struct dlm_ls *ls, uint32_t status)
 {
+	uint32_t status_all = status << 1;
 	int error;
 
 	if (ls->ls_low_nodeid == dlm_our_nodeid()) {
-		error = dlm_wait_status_all(ls, NODES_VALID);
+		error = wait_status_all(ls, status);
 		if (!error)
-			set_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags);
+			dlm_set_recover_status(ls, status_all);
 	} else
-		error = dlm_wait_status_low(ls, NODES_ALL_VALID);
+		error = wait_status_low(ls, status_all);
 
 	return error;
 }
 
-int dlm_recover_directory_wait(struct dlm_ls *ls)
+int dlm_recover_members_wait(struct dlm_ls *ls)
 {
-	int error;
-
-	if (ls->ls_low_nodeid == dlm_our_nodeid()) {
-		error = dlm_wait_status_all(ls, DIR_VALID);
-		if (!error)
-			set_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
-	} else
-		error = dlm_wait_status_low(ls, DIR_ALL_VALID);
+	return wait_status(ls, DLM_RS_NODES);
+}
 
-	return error;
+int dlm_recover_directory_wait(struct dlm_ls *ls)
+{
+	return wait_status(ls, DLM_RS_DIR);
 }
 
 int dlm_recover_locks_wait(struct dlm_ls *ls)
 {
-	int error;
-
-	if (ls->ls_low_nodeid == dlm_our_nodeid()) {
-		error = dlm_wait_status_all(ls, LOCKS_VALID);
-		if (!error)
-			set_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags);
-	} else
-		error = dlm_wait_status_low(ls, LOCKS_ALL_VALID);
+	return wait_status(ls, DLM_RS_LOCKS);
+}
 
-	return error;
+int dlm_recover_done_wait(struct dlm_ls *ls)
+{
+	return wait_status(ls, DLM_RS_DONE);
 }
 
 /*
@@ -517,7 +522,7 @@ int dlm_recover_locks(struct dlm_ls *ls)
 	if (error)
 		recover_list_clear(ls);
 	else
-		set_bit(LSFL_LOCKS_VALID, &ls->ls_flags);
+		dlm_set_recover_status(ls, DLM_RS_LOCKS);
 	return error;
 }
 
Index: linux-2.6.12-mm1/drivers/dlm/recover.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recover.h
+++ linux-2.6.12-mm1/drivers/dlm/recover.h
@@ -14,8 +14,13 @@
 #ifndef __RECOVER_DOT_H__
 #define __RECOVER_DOT_H__
 
-int dlm_recovery_stopped(struct dlm_ls *ls);
 int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls));
+uint32_t dlm_recover_status(struct dlm_ls *ls);
+void dlm_set_recover_status(struct dlm_ls *ls, uint32_t status);
+int dlm_recover_members_wait(struct dlm_ls *ls);
+int dlm_recover_directory_wait(struct dlm_ls *ls);
+int dlm_recover_locks_wait(struct dlm_ls *ls);
+int dlm_recover_done_wait(struct dlm_ls *ls);
 int dlm_recover_masters(struct dlm_ls *ls);
 int dlm_recover_master_reply(struct dlm_ls *ls, struct dlm_rcom *rc);
 int dlm_recover_locks(struct dlm_ls *ls);
@@ -24,9 +29,6 @@ int dlm_create_root_list(struct dlm_ls *
 void dlm_release_root_list(struct dlm_ls *ls);
 void dlm_clear_toss_list(struct dlm_ls *ls);
 void dlm_recover_rsbs(struct dlm_ls *ls);
-int dlm_recover_members_wait(struct dlm_ls *ls);
-int dlm_recover_directory_wait(struct dlm_ls *ls);
-int dlm_recover_locks_wait(struct dlm_ls *ls);
 
 #endif				/* __RECOVER_DOT_H__ */
 
Index: linux-2.6.12-mm1/drivers/dlm/recoverd.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/recoverd.c
+++ linux-2.6.12-mm1/drivers/dlm/recoverd.c
@@ -21,91 +21,30 @@
 #include "lock.h"
 #include "requestqueue.h"
 
-/*
- * next_move actions
- */
-
-#define DO_STOP             (1)
-#define DO_START            (2)
-#define DO_FINISH           (3)
-#define DO_FINISH_STOP      (4)
-#define DO_FINISH_START     (5)
 
-static void set_start_done(struct dlm_ls *ls, int event_id)
-{
-	spin_lock(&ls->ls_recover_lock);
-	ls->ls_startdone = event_id;
-	spin_unlock(&ls->ls_recover_lock);
-
-	kobject_uevent(&ls->ls_kobj, KOBJ_CHANGE, NULL);
-}
+/* If the start for which we're re-enabling locking (seq) has been superseded
+   by a newer stop (ls_recover_seq), we need to leave locking disabled. */
 
-static int enable_locking(struct dlm_ls *ls, int event_id)
+static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 {
-	int error = 0;
+	int error = -EINTR;
 
 	spin_lock(&ls->ls_recover_lock);
-	if (ls->ls_last_stop < event_id) {
-		set_bit(LSFL_LS_RUN, &ls->ls_flags);
+	if (ls->ls_recover_seq == seq) {
+		set_bit(LSFL_RUNNING, &ls->ls_flags);
 		up_write(&ls->ls_in_recovery);
-	} else {
-		error = -EINTR;
-		log_debug(ls, "enable_locking: abort %d", event_id);
+		error = 0;
 	}
 	spin_unlock(&ls->ls_recover_lock);
 	return error;
 }
 
-static int ls_first_start(struct dlm_ls *ls, struct dlm_recover *rv)
-{
-	int error;
-
-	log_debug(ls, "recover event %u (first)", rv->event_id);
-
-	down(&ls->ls_recoverd_active);
-
-	error = dlm_recover_members_first(ls, rv);
-	if (error) {
-		log_error(ls, "recover_members first failed %d", error);
-		goto out;
-	}
-
-	error = dlm_recover_directory(ls);
-	if (error) {
-		log_error(ls, "recover_directory failed %d", error);
-		goto out;
-	}
-
-	error = dlm_recover_directory_wait(ls);
-	if (error) {
-		log_error(ls, "recover_directory_wait failed %d", error);
-		goto out;
-	}
-
-	log_debug(ls, "recover event %u done", rv->event_id);
-	set_start_done(ls, rv->event_id);
-
- out:
-	up(&ls->ls_recoverd_active);
-	return error;
-}
-
-/*
- * We are given here a new group of nodes which are in the lockspace.  We first
- * figure out the differences in ls membership from when we were last running.
- * If nodes from before are gone, then there will be some lock recovery to do.
- * If there are only nodes which have joined, then there's no lock recovery.
- *
- * Lockspace recovery for failed nodes must be completed before any nodes are
- * allowed to join or leave the lockspace.
- */
-
-static int ls_reconfig(struct dlm_ls *ls, struct dlm_recover *rv)
+static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 {
 	unsigned long start;
 	int error, neg = 0;
 
-	log_debug(ls, "recover event %u", rv->event_id);
+	log_debug(ls, "recover %"PRIx64"", rv->seq);
 
 	down(&ls->ls_recoverd_active);
 
@@ -228,431 +167,61 @@ static int ls_reconfig(struct dlm_ls *ls
 
 	dlm_release_root_list(ls);
 
-	log_debug(ls, "recover event %u done: %u ms", rv->event_id,
-		  jiffies_to_msecs(jiffies - start));
-	set_start_done(ls, rv->event_id);
-	up(&ls->ls_recoverd_active);
-
-	return 0;
-
- fail:
-	log_debug(ls, "recover event %d error %d", rv->event_id, error);
-	up(&ls->ls_recoverd_active);
-	return error;
-}
-
-/*
- * Between calls to this routine for a ls, there can be multiple stop/start
- * events where every start but the latest is cancelled by stops.  There can
- * only be a single finish because every finish requires us to call start_done.
- * A single finish event could be followed by multiple stop/start events.  This
- * routine takes any combination of events and boils them down to one course of
- * action.
- */
-
-static int next_move(struct dlm_ls *ls, struct dlm_recover **rv_out,
-		     int *finish_out)
-{
-	LIST_HEAD(events);
-	unsigned int cmd = 0, stop, start, finish;
-	unsigned int last_stop, last_start, last_finish;
-	struct dlm_recover *rv = NULL, *start_rv = NULL;
-
-	spin_lock(&ls->ls_recover_lock);
-
-	stop = test_and_clear_bit(LSFL_LS_STOP, &ls->ls_flags) ? 1 : 0;
-	start = test_and_clear_bit(LSFL_LS_START, &ls->ls_flags) ? 1 : 0;
-	finish = test_and_clear_bit(LSFL_LS_FINISH, &ls->ls_flags) ? 1 : 0;
-
-	last_stop = ls->ls_last_stop;
-	last_start = ls->ls_last_start;
-	last_finish = ls->ls_last_finish;
-
-	while (!list_empty(&ls->ls_recover)) {
-		rv = list_entry(ls->ls_recover.next, struct dlm_recover, list);
-		list_del(&rv->list);
-		list_add_tail(&rv->list, &events);
+	dlm_set_recover_status(ls, DLM_RS_DONE);
+	error = dlm_recover_done_wait(ls);
+	if (error) {
+		log_error(ls, "recover_done_wait failed %d", error);
+		goto fail;
 	}
 
-	/*
-	 * There are two cases where we need to adjust these event values:
-	 * 1. - we get a first start
-	 *    - we get a stop
-	 *    - we process the start + stop here and notice this special case
-	 *
-	 * 2. - we get a first start
-	 *    - we process the start
-	 *    - we get a stop
-	 *    - we process the stop here and notice this special case
-	 *
-	 * In both cases, the first start we received was aborted by a
-	 * stop before we received a finish.  last_finish being zero is the
-	 * indication that this is the "first" start, i.e. we've not yet
-	 * finished a start; if we had, last_finish would be non-zero.
-	 * Part of the problem arises from the fact that when we initially
-	 * get start/stop/start, we may get the same event id for both starts
-	 * (since the first was cancelled).
-	 *
-	 * In both cases, last_start and last_stop will be equal.
-	 * In both cases, finish=0.
-	 * In the first case start=1 && stop=1.
-	 * In the second case start=0 && stop=1.
-	 *
-	 * In both cases, we need to make adjustments to values so:
-	 * - we process the current event (now) as a normal stop
-	 * - the next start we receive will be processed normally
-	 *   (taking into account the assertions below)
-	 *
-	 * In the first case, dlm_ls_start() will have printed the
-	 * "repeated start" warning.
-	 *
-	 * In the first case we need to get rid of the recover event struct.
-	 *
-	 * - set stop=1, start=0, finish=0 for case 4 below
-	 * - last_stop and last_start must be set equal per the case 4 assert
-	 * - ls_last_stop = 0 so the next start will be larger
-	 * - ls_last_start = 0 not really necessary (avoids dlm_ls_start print)
-	 */
+	dlm_clear_members_gone(ls);
 
-	if (!last_finish && (last_start == last_stop)) {
-		log_debug(ls, "move reset %u,%u,%u ids %u,%u,%u", stop,
-			  start, finish, last_stop, last_start, last_finish);
-		stop = 1;
-		start = 0;
-		finish = 0;
-		last_stop = 0;
-		last_start = 0;
-		ls->ls_last_stop = 0;
-		ls->ls_last_start = 0;
-
-		while (!list_empty(&events)) {
-			rv = list_entry(events.next, struct dlm_recover, list);
-			list_del(&rv->list);
-			kfree(rv->nodeids);
-			kfree(rv);
-		}
+	error = enable_locking(ls, rv->seq);
+	if (error) {
+		log_error(ls, "enable_locking failed %d", error);
+		goto fail;
 	}
-	spin_unlock(&ls->ls_recover_lock);
 
-	log_debug(ls, "move flags %u,%u,%u ids %u,%u,%u", stop, start, finish,
-		  last_stop, last_start, last_finish);
-
-	/*
-	 * Toss start events which have since been cancelled.
-	 */
+	error = dlm_process_requestqueue(ls);
+	if (error) {
+		log_error(ls, "process_requestqueue failed %d", error);
+		goto fail;
+	}
 
-	while (!list_empty(&events)) {
-		DLM_ASSERT(start,);
-		rv = list_entry(events.next, struct dlm_recover, list);
-		list_del(&rv->list);
-
-		if (rv->event_id <= last_stop) {
-			log_debug(ls, "move skip event %u", rv->event_id);
-			kfree(rv->nodeids);
-			kfree(rv);
-			rv = NULL;
-		} else {
-			log_debug(ls, "move use event %u", rv->event_id);
-			DLM_ASSERT(!start_rv,);
-			start_rv = rv;
-		}
+	error = dlm_recover_waiters_post(ls);
+	if (error) {
+		log_error(ls, "recover_waiters_post failed %d", error);
+		goto fail;
 	}
 
-	/*
-	 * Eight possible combinations of events.
-	 */
+	dlm_grant_after_purge(ls);
 
-	/* 0 */
-	if (!stop && !start && !finish) {
-		DLM_ASSERT(!start_rv,);
-		cmd = 0;
-		goto out;
-	}
-
-	/* 1 */
-	if (!stop && !start && finish) {
-		DLM_ASSERT(!start_rv,);
-		DLM_ASSERT(last_start > last_stop,);
-		DLM_ASSERT(last_finish == last_start,);
-		cmd = DO_FINISH;
-		*finish_out = last_finish;
-		goto out;
-	}
-
-	/* 2 */
-	if (!stop && start && !finish) {
-		DLM_ASSERT(start_rv,);
-		DLM_ASSERT(last_start > last_stop,);
-		cmd = DO_START;
-		*rv_out = start_rv;
-		goto out;
-	}
-
-	/* 3 */
-	if (!stop && start && finish) {
-		DLM_ASSERT(0, printk("finish and start with no stop\n"););
-	}
-
-	/* 4 */
-	if (stop && !start && !finish) {
-		DLM_ASSERT(!start_rv,);
-		DLM_ASSERT(last_start == last_stop,);
-		cmd = DO_STOP;
-		goto out;
-	}
-
-	/* 5 */
-	if (stop && !start && finish) {
-		DLM_ASSERT(!start_rv,);
-		DLM_ASSERT(last_finish == last_start,);
-		DLM_ASSERT(last_stop == last_start,);
-		cmd = DO_FINISH_STOP;
-		*finish_out = last_finish;
-		goto out;
-	}
-
-	/* 6 */
-	if (stop && start && !finish) {
-		if (start_rv) {
-			DLM_ASSERT(last_start > last_stop,);
-			cmd = DO_START;
-			*rv_out = start_rv;
-		} else {
-			DLM_ASSERT(last_stop == last_start,);
-			cmd = DO_STOP;
-		}
-		goto out;
-	}
+	dlm_astd_wake();
 
-	/* 7 */
-	if (stop && start && finish) {
-		if (start_rv) {
-			DLM_ASSERT(last_start > last_stop,);
-			DLM_ASSERT(last_start > last_finish,);
-			cmd = DO_FINISH_START;
-			*finish_out = last_finish;
-			*rv_out = start_rv;
-		} else {
-			DLM_ASSERT(last_start == last_stop,);
-			DLM_ASSERT(last_start > last_finish,);
-			cmd = DO_FINISH_STOP;
-			*finish_out = last_finish;
-		}
-		goto out;
-	}
+	log_debug(ls, "recover %"PRIx64" done: %u ms", rv->seq,
+		  jiffies_to_msecs(jiffies - start));
+	up(&ls->ls_recoverd_active);
 
- out:
-	return cmd;
-}
+	return 0;
 
-/*
- * This function decides what to do given every combination of current
- * lockspace state and next lockspace state.
- */
+ fail:
+	log_debug(ls, "recover %"PRIx64" error %d", rv->seq, error);
+	up(&ls->ls_recoverd_active);
+	return error;
+}
 
 static void do_ls_recovery(struct dlm_ls *ls)
 {
 	struct dlm_recover *rv = NULL;
-	int error, cur_state, next_state = 0, do_now, finish_event = 0;
-
-	do_now = next_move(ls, &rv, &finish_event);
-	if (!do_now)
-		goto out;
-
-	cur_state = ls->ls_state;
-	next_state = 0;
-
-	DLM_ASSERT(!test_bit(LSFL_LS_RUN, &ls->ls_flags),
-		    log_error(ls, "curstate=%d donow=%d", cur_state, do_now););
-
-	/*
-	 * LSST_CLEAR - we're not in any recovery state.  We can get a stop or
-	 * a stop and start which equates with a START.
-	 */
 
-	if (cur_state == LSST_CLEAR) {
-		switch (do_now) {
-		case DO_STOP:
-			next_state = LSST_WAIT_START;
-			break;
-
-		case DO_START:
-			error = ls_reconfig(ls, rv);
-			if (error)
-				next_state = LSST_WAIT_START;
-			else
-				next_state = LSST_RECONFIG_DONE;
-			break;
-
-		case DO_FINISH:	/* invalid */
-		case DO_FINISH_STOP:	/* invalid */
-		case DO_FINISH_START:	/* invalid */
-		default:
-			DLM_ASSERT(0,);
-		}
-		goto out;
-	}
-
-	/*
-	 * LSST_WAIT_START - we're not running because of getting a stop or
-	 * failing a start.  We wait in this state for another stop/start or
-	 * just the next start to begin another reconfig attempt.
-	 */
-
-	if (cur_state == LSST_WAIT_START) {
-		switch (do_now) {
-		case DO_STOP:
-			break;
-
-		case DO_START:
-			error = ls_reconfig(ls, rv);
-			if (error)
-				next_state = LSST_WAIT_START;
-			else
-				next_state = LSST_RECONFIG_DONE;
-			break;
-
-		case DO_FINISH:	/* invalid */
-		case DO_FINISH_STOP:	/* invalid */
-		case DO_FINISH_START:	/* invalid */
-		default:
-			DLM_ASSERT(0,);
-		}
-		goto out;
-	}
-
-	/*
-	 * LSST_RECONFIG_DONE - we entered this state after successfully
-	 * completing ls_reconfig and calling set_start_done.  We expect to get
-	 * a finish if everything goes ok.  A finish could be followed by stop
-	 * or stop/start before we get here to check it.  Or a finish may never
-	 * happen, only stop or stop/start.
-	 */
-
-	if (cur_state == LSST_RECONFIG_DONE) {
-		switch (do_now) {
-		case DO_FINISH:
-			dlm_clear_members_finish(ls, finish_event);
-			next_state = LSST_CLEAR;
-
-			error = enable_locking(ls, finish_event);
-			if (error)
-				break;
-
-			error = dlm_process_requestqueue(ls);
-			if (error)
-				break;
-
-			error = dlm_recover_waiters_post(ls);
-			if (error)
-				break;
-
-			dlm_grant_after_purge(ls);
-
-			dlm_astd_wake();
-
-			log_debug(ls, "recover event %u finished", finish_event);
-			break;
-
-		case DO_STOP:
-			next_state = LSST_WAIT_START;
-			break;
-
-		case DO_FINISH_STOP:
-			dlm_clear_members_finish(ls, finish_event);
-			next_state = LSST_WAIT_START;
-			break;
-
-		case DO_FINISH_START:
-			dlm_clear_members_finish(ls, finish_event);
-			/* fall into DO_START */
-
-		case DO_START:
-			error = ls_reconfig(ls, rv);
-			if (error)
-				next_state = LSST_WAIT_START;
-			else
-				next_state = LSST_RECONFIG_DONE;
-			break;
-
-		default:
-			DLM_ASSERT(0,);
-		}
-		goto out;
-	}
-
-	/*
-	 * LSST_INIT - state after ls is created and before it has been
-	 * started.  A start operation will cause the ls to be started for the
-	 * first time.  A failed start will cause to just wait in INIT for
-	 * another stop/start.
-	 */
-
-	if (cur_state == LSST_INIT) {
-		switch (do_now) {
-		case DO_START:
-			error = ls_first_start(ls, rv);
-			if (!error)
-				next_state = LSST_INIT_DONE;
-			break;
-
-		case DO_STOP:
-			break;
-
-		case DO_FINISH:	/* invalid */
-		case DO_FINISH_STOP:	/* invalid */
-		case DO_FINISH_START:	/* invalid */
-		default:
-			DLM_ASSERT(0,);
-		}
-		goto out;
-	}
-
-	/*
-	 * LSST_INIT_DONE - after the first start operation is completed
-	 * successfully and set_start_done() called.  If there are no errors, a
-	 * finish will arrive next and we'll move to LSST_CLEAR.
-	 */
-
-	if (cur_state == LSST_INIT_DONE) {
-		switch (do_now) {
-		case DO_STOP:
-		case DO_FINISH_STOP:
-			next_state = LSST_WAIT_START;
-			break;
-
-		case DO_START:
-		case DO_FINISH_START:
-			error = ls_reconfig(ls, rv);
-			if (error)
-				next_state = LSST_WAIT_START;
-			else
-				next_state = LSST_RECONFIG_DONE;
-			break;
-
-		case DO_FINISH:
-			next_state = LSST_CLEAR;
-
-			enable_locking(ls, finish_event);
-
-			dlm_process_requestqueue(ls);
-
-			dlm_astd_wake();
-
-			log_debug(ls, "recover event %u finished", finish_event);
-			break;
-
-		default:
-			DLM_ASSERT(0,);
-		}
-		goto out;
-	}
-
- out:
-	if (next_state)
-		ls->ls_state = next_state;
+	spin_lock(&ls->ls_recover_lock);
+	rv = ls->ls_recover_args;
+	ls->ls_recover_args = NULL;
+	clear_bit(LSFL_RECOVERY_STOP, &ls->ls_flags);
+	spin_unlock(&ls->ls_recover_lock);
 
 	if (rv) {
+		ls_recover(ls, rv);
 		kfree(rv->nodeids);
 		kfree(rv);
 	}
Index: linux-2.6.12-mm1/drivers/dlm/requestqueue.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/requestqueue.c
+++ linux-2.6.12-mm1/drivers/dlm/requestqueue.c
@@ -79,8 +79,8 @@ int dlm_process_requestqueue(struct dlm_
 		list_del(&e->list);
 		kfree(e);
 
-		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags)) {
-			log_debug(ls, "process_requestqueue abort ls_run");
+		if (dlm_locking_stopped(ls)) {
+			log_debug(ls, "process_requestqueue abort running");
 			up(&ls->ls_requestqueue_lock);
 			error = -EINTR;
 			break;
@@ -105,7 +105,7 @@ void dlm_wait_requestqueue(struct dlm_ls
 		down(&ls->ls_requestqueue_lock);
 		if (list_empty(&ls->ls_requestqueue))
 			break;
-		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
+		if (dlm_locking_stopped(ls))
 			break;
 		up(&ls->ls_requestqueue_lock);
 		schedule();

--
