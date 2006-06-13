Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWFNADG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWFNADG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWFNACh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41964 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964818AbWFNACG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:06 -0400
Subject: [PATCH 08/11] Task watchers:  Register profile as a task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Philippe Elie <phil.el@wanadoo.fr>, oprofile-list@lists.sourceforge.net
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:57 -0700
Message-Id: <1150242897.21787.148.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify oprofile to use the task watcher chain to watch for task exit.
oprofile uses task exit as a point to synch buffers.

This patch does not modify oprofile to use the task free path of task watchers. 
oprofile has its own task_free atomic notifier chain. Since its an atomic chain
we can't replace it with task watcher. Also, it's called much later when the
actual task struct is really about to be freed.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>
Cc: oprofile-list@lists.sf.net
--

 drivers/oprofile/buffer_sync.c |   11 ++++++-----
 include/linux/profile.h        |    3 +--
 kernel/exit.c                  |    1 -
 kernel/profile.c               |   14 --------------
 4 files changed, 7 insertions(+), 22 deletions(-)

Index: linux-2.6.17-rc6-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc6-mm2/kernel/exit.c
@@ -847,11 +847,10 @@ fastcall NORET_TYPE void do_exit(long co
 	struct task_struct *tsk = current;
 	struct taskstats *tidstats, *tgidstats;
 	int group_dead;
 	int notify_result;
 
-	profile_task_exit(tsk);
 	tsk->exit_code = code;
 	notify_result = notify_watchers(WATCH_TASK_EXIT, tsk);
 
 	WARN_ON(atomic_read(&tsk->fs_excl));
 
Index: linux-2.6.17-rc6-mm2/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6.17-rc6-mm2/drivers/oprofile/buffer_sync.c
@@ -63,12 +63,13 @@ static int task_free_notify(struct notif
 static int task_exit_notify(struct notifier_block * self, unsigned long val, void * data)
 {
 	/* To avoid latency problems, we only process the current CPU,
 	 * hoping that most samples for the task are on this CPU
 	 */
-	sync_buffer(raw_smp_processor_id());
-  	return 0;
+	if (get_watch_event(val) == WATCH_TASK_EXIT)
+		sync_buffer(raw_smp_processor_id());
+  	return NOTIFY_DONE;
 }
 

 /* The task is about to try a do_munmap(). We peek at what it's going to
  * do, and if it's an executable region, process the samples first, so
@@ -150,11 +151,11 @@ int sync_start(void)
 	start_cpu_work();
 
 	err = task_handoff_register(&task_free_nb);
 	if (err)
 		goto out1;
-	err = profile_event_register(PROFILE_TASK_EXIT, &task_exit_nb);
+	err = register_task_watcher(&task_exit_nb);
 	if (err)
 		goto out2;
 	err = profile_event_register(PROFILE_MUNMAP, &munmap_nb);
 	if (err)
 		goto out3;
@@ -165,11 +166,11 @@ int sync_start(void)
 out:
 	return err;
 out4:
 	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
 out3:
-	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
+	unregister_task_watcher(&task_exit_nb);
 out2:
 	task_handoff_unregister(&task_free_nb);
 out1:
 	end_sync();
 	goto out;
@@ -178,11 +179,11 @@ out1:
 
 void sync_stop(void)
 {
 	unregister_module_notifier(&module_load_nb);
 	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
-	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
+	unregister_task_watcher(&task_exit_nb);
 	task_handoff_unregister(&task_free_nb);
 	end_sync();
 }
 
  
Index: linux-2.6.17-rc6-mm2/kernel/profile.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/profile.c
+++ linux-2.6.17-rc6-mm2/kernel/profile.c
@@ -85,19 +85,13 @@ void __init profile_init(void)
 
 /* Profile event notifications */
  
 #ifdef CONFIG_PROFILING
  
-static BLOCKING_NOTIFIER_HEAD(task_exit_notifier);
 static ATOMIC_NOTIFIER_HEAD(task_free_notifier);
 static BLOCKING_NOTIFIER_HEAD(munmap_notifier);
  
-void profile_task_exit(struct task_struct * task)
-{
-	blocking_notifier_call_chain(&task_exit_notifier, 0, task);
-}
- 
 int profile_handoff_task(struct task_struct * task)
 {
 	int ret;
 	ret = atomic_notifier_call_chain(&task_free_notifier, 0, task);
 	return (ret == NOTIFY_OK) ? 1 : 0;
@@ -121,14 +115,10 @@ int task_handoff_unregister(struct notif
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
  
 	switch (type) {
-		case PROFILE_TASK_EXIT:
-			err = blocking_notifier_chain_register(
-					&task_exit_notifier, n);
-			break;
 		case PROFILE_MUNMAP:
 			err = blocking_notifier_chain_register(
 					&munmap_notifier, n);
 			break;
 	}
@@ -140,14 +130,10 @@ int profile_event_register(enum profile_
 int profile_event_unregister(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
  
 	switch (type) {
-		case PROFILE_TASK_EXIT:
-			err = blocking_notifier_chain_unregister(
-					&task_exit_notifier, n);
-			break;
 		case PROFILE_MUNMAP:
 			err = blocking_notifier_chain_unregister(
 					&munmap_notifier, n);
 			break;
 	}
Index: linux-2.6.17-rc6-mm2/include/linux/profile.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/profile.h
+++ linux-2.6.17-rc6-mm2/include/linux/profile.h
@@ -24,12 +24,11 @@ void create_prof_cpu_mask(struct proc_di
 #else
 #define create_prof_cpu_mask(x)			do { (void)(x); } while (0)
 #endif
 
 enum profile_type {
-	PROFILE_TASK_EXIT,
-	PROFILE_MUNMAP
+	PROFILE_MUNMAP = 1
 };
 
 #ifdef CONFIG_PROFILING
 
 struct task_struct;

--

