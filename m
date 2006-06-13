Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWFNAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWFNAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWFNACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11178 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964820AbWFNACP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:15 -0400
Subject: [PATCH 11/11] Task watchers:  Register per-task semundo watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:55:06 -0700
Message-Id: <1150242906.21787.151.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches semundo from using the global task_watchers notifier chain
to a per-task notifier chain. In the case where a task does not use SysV
semaphores this would save a call to exit_sem().

Based off Jes Sorensen's patch implementing this with task_notifiers.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Jes Sorensen <jes@sgi.com>
--

 ipc/sem.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

Index: linux-2.6.17-rc6-mm2/ipc/sem.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/ipc/sem.c
+++ linux-2.6.17-rc6-mm2/ipc/sem.c
@@ -139,14 +139,10 @@ static int sem_undo_task_exit(struct not
 	default: /* Don't care */
 		return NOTIFY_DONE;
 	}
 }
 
-static struct notifier_block sem_watch_tasks_nb = {
-	.notifier_call = sem_undo_task_exit
-};
-
 static void __ipc_init __sem_init_ns(struct ipc_namespace *ns, struct ipc_ids *ids)
 {
 	ns->ids[IPC_SEM_IDS] = ids;
 	ns->sc_semmsl = SEMMSL;
 	ns->sc_semmns = SEMMNS;
@@ -193,11 +189,10 @@ void __init sem_init (void)
 {
 	__sem_init_ns(&init_ipc_ns, &init_sem_ids);
 	ipc_init_proc_interface("sysvipc/sem",
 				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
 				IPC_SEM_IDS, sysvipc_sem_proc_show);
-	register_task_watcher(&sem_watch_tasks_nb);
 }
 
 /*
  * Lockless wakeup algorithm:
  * Without the check/retry algorithm a lockless wakeup is possible:
@@ -1010,11 +1005,10 @@ static inline void unlock_semundo(void)
 	undo_list = current->sysvsem.undo_list;
 	if (undo_list)
 		spin_unlock(&undo_list->lock);
 }
 
-
 /* If the task doesn't already have a undo_list, then allocate one
  * here.  We guarantee there is only one thread using this undo list,
  * and current is THE ONE
  *
  * If this allocation and assignment succeeds, but later
@@ -1026,24 +1020,39 @@ static inline void unlock_semundo(void)
  */
 static inline int get_undo_list(struct sem_undo_list **undo_listp)
 {
 	struct sem_undo_list *undo_list;
 	int size;
+	struct notifier_block *semun_nb;
+	int retval;
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
+		semun_nb = NULL;
+		retval = -ENOMEM;
 		size = sizeof(struct sem_undo_list);
 		undo_list = (struct sem_undo_list *) kmalloc(size, GFP_KERNEL);
 		if (undo_list == NULL)
-			return -ENOMEM;
+			goto err;
+		semun_nb = kzalloc(sizeof(*semun_nb), GFP_KERNEL);
+		if (semun_nb == NULL)
+			goto err;
+		semun_nb->notifier_call = sem_undo_task_exit;
+		retval = register_per_task_watcher(semun_nb);
+		if (retval)
+			goto err;
 		memset(undo_list, 0, size);
 		spin_lock_init(&undo_list->lock);
 		atomic_set(&undo_list->refcnt, 1);
 		current->sysvsem.undo_list = undo_list;
 	}
 	*undo_listp = undo_list;
 	return 0;
+err:
+	kfree(semun_nb);
+	kfree(undo_list);
+	return retval;
 }
 
 static struct sem_undo *lookup_undo(struct sem_undo_list *ulp, int semid)
 {
 	struct sem_undo **last, *un;

--

