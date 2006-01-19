Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWASVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWASVcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWASVbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422651AbWASVbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:42 -0500
Date: Thu, 19 Jan 2006 15:31:11 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dlm: sem2mutex
Message-ID: <20060119213111.GG31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert semaphore to mutex.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/ast.c
===================================================================
--- linux.orig/drivers/dlm/ast.c	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/ast.c	2006-01-19 13:40:53.000000000 -0600
@@ -21,7 +21,7 @@
 static spinlock_t		ast_queue_lock;
 static struct task_struct *	astd_task;
 static unsigned long		astd_wakeflags;
-static struct semaphore		astd_running;
+static struct mutex		astd_running;
 
 
 void dlm_del_ast(struct dlm_lkb *lkb)
@@ -117,10 +117,10 @@
 			schedule();
 		set_current_state(TASK_RUNNING);
 
-		down(&astd_running);
+		mutex_lock(&astd_running);
 		if (test_and_clear_bit(WAKE_ASTS, &astd_wakeflags))
 			process_asts();
-		up(&astd_running);
+		mutex_unlock(&astd_running);
 	}
 	return 0;
 }
@@ -140,7 +140,7 @@
 
 	INIT_LIST_HEAD(&ast_queue);
 	spin_lock_init(&ast_queue_lock);
-	init_MUTEX(&astd_running);
+	mutex_init(&astd_running);
 
 	p = kthread_run(dlm_astd, NULL, "dlm_astd");
 	if (IS_ERR(p))
@@ -157,11 +157,11 @@
 
 void dlm_astd_suspend(void)
 {
-	down(&astd_running);
+	mutex_lock(&astd_running);
 }
 
 void dlm_astd_resume(void)
 {
-	up(&astd_running);
+	mutex_unlock(&astd_running);
 }
 
Index: linux/drivers/dlm/config.c
===================================================================
--- linux.orig/drivers/dlm/config.c	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/config.c	2006-01-19 13:42:17.000000000 -0600
@@ -162,7 +162,7 @@
 struct space {
 	struct config_group group;
 	struct list_head members;
-	struct semaphore members_lock;
+	struct mutex members_lock;
 	int members_count;
 };
 
@@ -374,7 +374,7 @@
 	sp->group.default_groups[1] = NULL;
 
 	INIT_LIST_HEAD(&sp->members);
-	init_MUTEX(&sp->members_lock);
+	mutex_init(&sp->members_lock);
 	sp->members_count = 0;
 	return &sp->group;
 
@@ -453,10 +453,10 @@
 	nd->nodeid = -1;
 	nd->weight = 1;  /* default weight of 1 if none is set */
 
-	down(&sp->members_lock);
+	mutex_lock(&sp->members_lock);
 	list_add(&nd->list, &sp->members);
 	sp->members_count++;
-	up(&sp->members_lock);
+	mutex_unlock(&sp->members_lock);
 
 	return &nd->item;
 }
@@ -466,10 +466,10 @@
 	struct space *sp = to_space(g->cg_item.ci_parent);
 	struct node *nd = to_node(i);
 
-	down(&sp->members_lock);
+	mutex_lock(&sp->members_lock);
 	list_del(&nd->list);
 	sp->members_count--;
-	up(&sp->members_lock);
+	mutex_unlock(&sp->members_lock);
 
 	config_item_put(i);
 }
@@ -677,7 +677,7 @@
 	if (!sp)
 		return -EEXIST;
 
-	down(&sp->members_lock);
+	mutex_lock(&sp->members_lock);
 	if (!sp->members_count) {
 		rv = 0;
 		goto out;
@@ -698,7 +698,7 @@
 
 	*ids_out = ids;
  out:
-	up(&sp->members_lock);
+	mutex_unlock(&sp->members_lock);
 	put_space(sp);
 	return rv;
 }
@@ -713,14 +713,14 @@
 	if (!sp)
 		goto out;
 
-	down(&sp->members_lock);
+	mutex_lock(&sp->members_lock);
 	list_for_each_entry(nd, &sp->members, list) {
 		if (nd->nodeid != nodeid)
 			continue;
 		w = nd->weight;
 		break;
 	}
-	up(&sp->members_lock);
+	mutex_unlock(&sp->members_lock);
 	put_space(sp);
  out:
 	return w;
Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c	2006-01-19 13:38:54.000000000 -0600
+++ linux/drivers/dlm/device.c	2006-01-19 14:25:00.000000000 -0600
@@ -43,7 +43,7 @@
 static struct file_operations _dlm_fops;
 static const char *name_prefix="dlm";
 static struct list_head user_ls_list;
-static struct semaphore user_ls_lock;
+static struct mutex user_ls_lock;
 
 /* Lock infos are stored in here indexed by lock ID */
 static DEFINE_IDR(lockinfo_idr);
@@ -212,18 +212,18 @@
 {
 	struct user_ls *lsinfo;
 
-	down(&user_ls_lock);
+	mutex_lock(&user_ls_lock);
 	lsinfo = __find_lockspace(minor);
-	up(&user_ls_lock);
+	mutex_unlock(&user_ls_lock);
 
 	return lsinfo;
 }
 
 static void add_lockspace_to_list(struct user_ls *lsinfo)
 {
-	down(&user_ls_lock);
+	mutex_lock(&user_ls_lock);
 	list_add(&lsinfo->ls_list, &user_ls_list);
-	up(&user_ls_lock);
+	mutex_unlock(&user_ls_lock);
 }
 
 /* Register a lockspace with the DLM and create a misc
@@ -277,7 +277,7 @@
 	return 0;
 }
 
-/* Called with the user_ls_lock semaphore held */
+/* Called with the user_ls_lock mutex held */
 static int unregister_lockspace(struct user_ls *lsinfo, int force)
 {
 	int status;
@@ -570,7 +570,7 @@
 	 * then free the struct. If it's an AUTOFREE lockspace
 	 * then free the whole thing.
 	 */
-	down(&user_ls_lock);
+	mutex_lock(&user_ls_lock);
 	if (atomic_dec_and_test(&lsinfo->ls_refcnt)) {
 
 		if (lsinfo->ls_lockspace) {
@@ -582,7 +582,7 @@
 			kfree(lsinfo);
 		}
 	}
-	up(&user_ls_lock);
+	mutex_unlock(&user_ls_lock);
 	put_file_info(f);
 
 	/* Restore signals */
@@ -620,10 +620,10 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	down(&user_ls_lock);
+	mutex_lock(&user_ls_lock);
 	lsinfo = __find_lockspace(kparams->minor);
 	if (!lsinfo) {
-		up(&user_ls_lock);
+		mutex_unlock(&user_ls_lock);
 		return -EINVAL;
 	}
 
@@ -631,7 +631,7 @@
 		force = 2;
 
 	status = unregister_lockspace(lsinfo, force);
-	up(&user_ls_lock);
+	mutex_unlock(&user_ls_lock);
 
 	return status;
 }
@@ -1066,7 +1066,7 @@
 	int r;
 
 	INIT_LIST_HEAD(&user_ls_list);
-	init_MUTEX(&user_ls_lock);
+	mutex_init(&user_ls_lock);
 	rwlock_init(&lockinfo_lock);
 
 	ctl_device.name = "dlm-control";
Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/dlm_internal.h	2006-01-19 14:15:32.000000000 -0600
@@ -35,6 +35,7 @@
 #include <linux/kref.h>
 #include <linux/kernel.h>
 #include <linux/jhash.h>
+#include <linux/mutex.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
@@ -252,7 +253,7 @@
 struct dlm_rsb {
 	struct dlm_ls		*res_ls;	/* the lockspace */
 	struct kref		res_ref;
-	struct semaphore	res_sem;
+	struct mutex		res_mutex;
 	unsigned long		res_flags;
 	int			res_length;	/* length of rsb name */
 	int			res_nodeid;
@@ -435,7 +436,7 @@
 	struct dlm_dirtable	*ls_dirtbl;
 	uint32_t		ls_dirtbl_size;
 
-	struct semaphore	ls_waiters_sem;
+	struct mutex		ls_waiters_mutex;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
 	struct list_head	ls_nodes;	/* current nodes in ls */
@@ -458,14 +459,14 @@
 
 	struct timer_list	ls_timer;
 	struct task_struct	*ls_recoverd_task;
-	struct semaphore	ls_recoverd_active;
+	struct mutex		ls_recoverd_active;
 	spinlock_t		ls_recover_lock;
 	uint32_t		ls_recover_status; /* DLM_RS_ */
 	uint64_t		ls_recover_seq;
 	struct dlm_recover	*ls_recover_args;
 	struct rw_semaphore	ls_in_recovery;	/* block local requests */
 	struct list_head	ls_requestqueue;/* queue remote requests */
-	struct semaphore	ls_requestqueue_lock;
+	struct mutex		ls_requestqueue_mutex;
 	char			*ls_recover_buf;
 	struct list_head	ls_recover_list;
 	spinlock_t		ls_recover_list_lock;
Index: linux/drivers/dlm/lock.c
===================================================================
--- linux.orig/drivers/dlm/lock.c	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/lock.c	2006-01-19 14:35:25.638621443 -0600
@@ -269,7 +269,7 @@
 	r->res_ls = ls;
 	r->res_length = len;
 	memcpy(r->res_name, name, len);
-	init_MUTEX(&r->res_sem);
+	mutex_init(&r->res_mutex);
 
 	INIT_LIST_HEAD(&r->res_lookup);
 	INIT_LIST_HEAD(&r->res_grantqueue);
@@ -712,7 +712,7 @@
 {
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 
-	down(&ls->ls_waiters_sem);
+	mutex_lock(&ls->ls_waiters_mutex);
 	if (lkb->lkb_wait_type) {
 		log_print("add_to_waiters error %d", lkb->lkb_wait_type);
 		goto out;
@@ -721,7 +721,7 @@
 	kref_get(&lkb->lkb_ref);
 	list_add(&lkb->lkb_wait_reply, &ls->ls_waiters);
  out:
-	up(&ls->ls_waiters_sem);
+	mutex_unlock(&ls->ls_waiters_mutex);
 }
 
 static int _remove_from_waiters(struct dlm_lkb *lkb)
@@ -745,9 +745,9 @@
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error;
 
-	down(&ls->ls_waiters_sem);
+	mutex_lock(&ls->ls_waiters_mutex);
 	error = _remove_from_waiters(lkb);
-	up(&ls->ls_waiters_sem);
+	mutex_unlock(&ls->ls_waiters_mutex);
 	return error;
 }
 
@@ -3205,7 +3205,7 @@
 {
 	struct dlm_lkb *lkb, *safe;
 
-	down(&ls->ls_waiters_sem);
+	mutex_lock(&ls->ls_waiters_mutex);
 
 	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
 		log_debug(ls, "pre recover waiter lkid %x type %d flags %x",
@@ -3253,7 +3253,7 @@
 				  lkb->lkb_wait_type);
 		}
 	}
-	up(&ls->ls_waiters_sem);
+	mutex_unlock(&ls->ls_waiters_mutex);
 }
 
 static int remove_resend_waiter(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
@@ -3261,7 +3261,7 @@
 	struct dlm_lkb *lkb;
 	int rv = 0;
 
-	down(&ls->ls_waiters_sem);
+	mutex_lock(&ls->ls_waiters_mutex);
 	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
 		if (lkb->lkb_flags & DLM_IFL_RESEND) {
 			rv = lkb->lkb_wait_type;
@@ -3270,7 +3270,7 @@
 			break;
 		}
 	}
-	up(&ls->ls_waiters_sem);
+	mutex_unlock(&ls->ls_waiters_mutex);
 
 	if (!rv)
 		lkb = NULL;
Index: linux/drivers/dlm/lock.h
===================================================================
--- linux.orig/drivers/dlm/lock.h	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/lock.h	2006-01-19 14:16:25.000000000 -0600
@@ -38,12 +38,12 @@
 
 static inline void lock_rsb(struct dlm_rsb *r)
 {
-	down(&r->res_sem);
+	mutex_lock(&r->res_mutex);
 }
 
 static inline void unlock_rsb(struct dlm_rsb *r)
 {
-	up(&r->res_sem);
+	mutex_unlock(&r->res_mutex);
 }
 
 #endif
Index: linux/drivers/dlm/lockspace.c
===================================================================
--- linux.orig/drivers/dlm/lockspace.c	2006-01-19 13:38:54.000000000 -0600
+++ linux/drivers/dlm/lockspace.c	2006-01-19 14:19:50.000000000 -0600
@@ -31,7 +31,7 @@
 #endif
 
 static int			ls_count;
-static struct semaphore		ls_lock;
+static struct mutex		ls_lock;
 static struct list_head		lslist;
 static spinlock_t		lslist_lock;
 static struct task_struct *	scand_task;
@@ -177,7 +177,7 @@
 	int error;
 
 	ls_count = 0;
-	init_MUTEX(&ls_lock);
+	mutex_init(&ls_lock);
 	INIT_LIST_HEAD(&lslist);
 	spin_lock_init(&lslist_lock);
 
@@ -397,7 +397,7 @@
 	}
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
-	init_MUTEX(&ls->ls_waiters_sem);
+	mutex_init(&ls->ls_waiters_mutex);
 
 	INIT_LIST_HEAD(&ls->ls_nodes);
 	INIT_LIST_HEAD(&ls->ls_nodes_gone);
@@ -415,14 +415,14 @@
 	ls->ls_uevent_result = 0;
 
 	ls->ls_recoverd_task = NULL;
-	init_MUTEX(&ls->ls_recoverd_active);
+	mutex_init(&ls->ls_recoverd_active);
 	spin_lock_init(&ls->ls_recover_lock);
 	ls->ls_recover_status = 0;
 	ls->ls_recover_seq = 0;
 	ls->ls_recover_args = NULL;
 	init_rwsem(&ls->ls_in_recovery);
 	INIT_LIST_HEAD(&ls->ls_requestqueue);
-	init_MUTEX(&ls->ls_requestqueue_lock);
+	mutex_init(&ls->ls_requestqueue_mutex);
 
 	ls->ls_recover_buf = kmalloc(dlm_config.buffer_size, GFP_KERNEL);
 	if (!ls->ls_recover_buf)
@@ -492,7 +492,7 @@
 {
 	int error = 0;
 
-	down(&ls_lock);
+	mutex_lock(&ls_lock);
 	if (!ls_count)
 		error = threads_start();
 	if (error)
@@ -502,7 +502,7 @@
 	if (!error)
 		ls_count++;
  out:
-	up(&ls_lock);
+	mutex_unlock(&ls_lock);
 	return error;
 }
 
@@ -628,11 +628,11 @@
 	kobject_unregister(&ls->ls_kobj);
 	kfree(ls);
 
-	down(&ls_lock);
+	mutex_lock(&ls_lock);
 	ls_count--;
 	if (!ls_count)
 		threads_stop();
-	up(&ls_lock);
+	mutex_unlock(&ls_lock);
 
 	module_put(THIS_MODULE);
 	return 0;
Index: linux/drivers/dlm/recoverd.c
===================================================================
--- linux.orig/drivers/dlm/recoverd.c	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/recoverd.c	2006-01-19 14:19:13.000000000 -0600
@@ -47,7 +47,7 @@
 
 	log_debug(ls, "recover %llx", rv->seq);
 
-	down(&ls->ls_recoverd_active);
+	mutex_lock(&ls->ls_recoverd_active);
 
 	/*
 	 * Suspending and resuming dlm_astd ensures that no lkb's from this ls
@@ -201,14 +201,14 @@
 
 	log_debug(ls, "recover %llx done: %u ms", rv->seq,
 		  jiffies_to_msecs(jiffies - start));
-	up(&ls->ls_recoverd_active);
+	mutex_unlock(&ls->ls_recoverd_active);
 
 	return 0;
 
  fail:
 	dlm_release_root_list(ls);
 	log_debug(ls, "recover %llx error %d", rv->seq, error);
-	up(&ls->ls_recoverd_active);
+	mutex_unlock(&ls->ls_recoverd_active);
 	return error;
 }
 
@@ -275,11 +275,11 @@
 
 void dlm_recoverd_suspend(struct dlm_ls *ls)
 {
-	down(&ls->ls_recoverd_active);
+	mutex_lock(&ls->ls_recoverd_active);
 }
 
 void dlm_recoverd_resume(struct dlm_ls *ls)
 {
-	up(&ls->ls_recoverd_active);
+	mutex_unlock(&ls->ls_recoverd_active);
 }
 
Index: linux/drivers/dlm/requestqueue.c
===================================================================
--- linux.orig/drivers/dlm/requestqueue.c	2006-01-19 13:39:18.000000000 -0600
+++ linux/drivers/dlm/requestqueue.c	2006-01-19 14:21:37.000000000 -0600
@@ -47,9 +47,9 @@
 	e->nodeid = nodeid;
 	memcpy(e->request, hd, length);
 
-	down(&ls->ls_requestqueue_lock);
+	mutex_lock(&ls->ls_requestqueue_mutex);
 	list_add_tail(&e->list, &ls->ls_requestqueue);
-	up(&ls->ls_requestqueue_lock);
+	mutex_unlock(&ls->ls_requestqueue_mutex);
 }
 
 int dlm_process_requestqueue(struct dlm_ls *ls)
@@ -58,16 +58,16 @@
 	struct dlm_header *hd;
 	int error = 0;
 
-	down(&ls->ls_requestqueue_lock);
+	mutex_lock(&ls->ls_requestqueue_mutex);
 
 	for (;;) {
 		if (list_empty(&ls->ls_requestqueue)) {
-			up(&ls->ls_requestqueue_lock);
+			mutex_unlock(&ls->ls_requestqueue_mutex);
 			error = 0;
 			break;
 		}
 		e = list_entry(ls->ls_requestqueue.next, struct rq_entry, list);
-		up(&ls->ls_requestqueue_lock);
+		mutex_unlock(&ls->ls_requestqueue_mutex);
 
 		hd = (struct dlm_header *) e->request;
 		error = dlm_receive_message(hd, e->nodeid, 1);
@@ -78,13 +78,13 @@
 			break;
 		}
 
-		down(&ls->ls_requestqueue_lock);
+		mutex_lock(&ls->ls_requestqueue_mutex);
 		list_del(&e->list);
 		kfree(e);
 
 		if (dlm_locking_stopped(ls)) {
 			log_debug(ls, "process_requestqueue abort running");
-			up(&ls->ls_requestqueue_lock);
+			mutex_unlock(&ls->ls_requestqueue_mutex);
 			error = -EINTR;
 			break;
 		}
@@ -105,15 +105,15 @@
 void dlm_wait_requestqueue(struct dlm_ls *ls)
 {
 	for (;;) {
-		down(&ls->ls_requestqueue_lock);
+		mutex_lock(&ls->ls_requestqueue_mutex);
 		if (list_empty(&ls->ls_requestqueue))
 			break;
 		if (dlm_locking_stopped(ls))
 			break;
-		up(&ls->ls_requestqueue_lock);
+		mutex_unlock(&ls->ls_requestqueue_mutex);
 		schedule();
 	}
-	up(&ls->ls_requestqueue_lock);
+	mutex_unlock(&ls->ls_requestqueue_mutex);
 }
 
 static int purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
@@ -170,7 +170,7 @@
 	struct dlm_message *ms;
 	struct rq_entry *e, *safe;
 
-	down(&ls->ls_requestqueue_lock);
+	mutex_lock(&ls->ls_requestqueue_mutex);
 	list_for_each_entry_safe(e, safe, &ls->ls_requestqueue, list) {
 		ms = (struct dlm_message *) e->request;
 
@@ -179,6 +179,6 @@
 			kfree(e);
 		}
 	}
-	up(&ls->ls_requestqueue_lock);
+	mutex_unlock(&ls->ls_requestqueue_mutex);
 }
 
