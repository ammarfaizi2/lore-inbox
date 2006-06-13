Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWFNACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWFNACd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWFNAC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:57022 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964821AbWFNACO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:14 -0400
Subject: [PATCH 10/11] Task watchers:  Register semundo task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:55:03 -0700
Message-Id: <1150242903.21787.150.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the task_watcher notifier chain to invoke exit_sem() at
appropriate times.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Jes Sorensen <jes@sgi.com>
--

 ipc/sem.c     |   23 +++++++++++++++++++++++
 kernel/exit.c |    1 -
 kernel/fork.c |    4 +---
 3 files changed, 24 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc6-mm2/ipc/sem.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/ipc/sem.c
+++ linux-2.6.17-rc6-mm2/ipc/sem.c
@@ -82,10 +82,11 @@
 #include <linux/audit.h>
 #include <linux/capability.h>
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include "util.h"
 
 #define sem_ids(ns)	(*((ns)->ids[IPC_SEM_IDS]))
@@ -121,10 +122,31 @@ static int sysvipc_sem_proc_show(struct 
 #define sc_semmsl	sem_ctls[0]
 #define sc_semmns	sem_ctls[1]
 #define sc_semopm	sem_ctls[2]
 #define sc_semmni	sem_ctls[3]
 
+static int sem_undo_task_exit(struct notifier_block *nb, unsigned long val,
+			      void *t)
+{
+	switch(get_watch_event(val)) {
+	/*
+	 * If it weren't for the fact that we need clone flags to call
+	 * it we could also implement the copy_semundo portion of
+	 * copy_process inside case WATCH_TASK_INIT
+	 */
+	case WATCH_TASK_FREE:
+		exit_sem(t);
+		return NOTIFY_OK;
+	default: /* Don't care */
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block sem_watch_tasks_nb = {
+	.notifier_call = sem_undo_task_exit
+};
+
 static void __ipc_init __sem_init_ns(struct ipc_namespace *ns, struct ipc_ids *ids)
 {
 	ns->ids[IPC_SEM_IDS] = ids;
 	ns->sc_semmsl = SEMMSL;
 	ns->sc_semmns = SEMMNS;
@@ -171,10 +193,11 @@ void __init sem_init (void)
 {
 	__sem_init_ns(&init_ipc_ns, &init_sem_ids);
 	ipc_init_proc_interface("sysvipc/sem",
 				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
 				IPC_SEM_IDS, sysvipc_sem_proc_show);
+	register_task_watcher(&sem_watch_tasks_nb);
 }
 
 /*
  * Lockless wakeup algorithm:
  * Without the check/retry algorithm a lockless wakeup is possible:
Index: linux-2.6.17-rc6-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc6-mm2/kernel/exit.c
@@ -919,11 +919,10 @@ fastcall NORET_TYPE void do_exit(long co
 	notify_result = notify_watchers(WATCH_TASK_FREE, tsk);
 	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 
 	exit_mm(tsk);
 
-	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_task_namespaces(tsk);
 	exit_thread();
 	cpuset_exit(tsk);
Index: linux-2.6.17-rc6-mm2/kernel/fork.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/fork.c
+++ linux-2.6.17-rc6-mm2/kernel/fork.c
@@ -1089,11 +1089,11 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_policy;
 	/* copy all the process information */
 	if ((retval = copy_semundo(clone_flags, p)))
 		goto bad_fork_cleanup_security;
 	if ((retval = copy_files(clone_flags, p)))
-		goto bad_fork_cleanup_semundo;
+		goto bad_fork_cleanup_security;
 	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
 	if ((retval = copy_sighand(clone_flags, p)))
 		goto bad_fork_cleanup_fs;
 	if ((retval = copy_signal(clone_flags, p)))
@@ -1263,12 +1263,10 @@ bad_fork_cleanup_sighand:
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
-bad_fork_cleanup_semundo:
-	exit_sem(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 	notify_result = notify_watchers(WATCH_TASK_FREE, p);
 	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 bad_fork_cleanup_policy:

--

