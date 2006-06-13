Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWFNADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWFNADH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWFNACe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:19883 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964817AbWFNACG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:06 -0400
Subject: [PATCH 09/11] Task watchers:  Add support for per-task watchers
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:55:00 -0700
Message-Id: <1150242901.21787.149.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a second, per-task, blocking notifier chain. The per-task
chain offers watchers the chance to register with a specific task nstead of
all tasks. It also allows the watcher to associate a block of data with the task
by wrapping the notifier block using containerof().

Both the global, all-tasks chain and the per-task chain are called from the samefunction. The two types of chains share the same set of notification
values, however registration functions and the registered notifier blocks must
be separate.

These notifiers are only safe if notifier blocks are registered with the current
task while in the context of the current task. This ensures that there are no
races between registration, unregistration, and notification.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Jes Sorensen <jes@sgi.com>
Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
--

 include/linux/init_task.h |    2 ++
 include/linux/notifier.h  |    2 ++
 include/linux/sched.h     |    2 ++
 kernel/sys.c              |   30 +++++++++++++++++++++++++++++-
 4 files changed, 35 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc6-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/sched.h
+++ linux-2.6.17-rc6-mm2/include/linux/sched.h
@@ -996,10 +996,12 @@ struct task_struct {
 	struct futex_pi_state *pi_state_cache;
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
 
+	struct raw_notifier_head notify; /* generic per-task notifications */
+
 	/*
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
 #ifdef	CONFIG_TASK_DELAY_ACCT
Index: linux-2.6.17-rc6-mm2/include/linux/init_task.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/init_task.h
+++ linux-2.6.17-rc6-mm2/include/linux/init_task.h
@@ -3,10 +3,11 @@
 
 #include <linux/file.h>
 #include <linux/rcupdate.h>
 #include <linux/utsname.h>
 #include <linux/interrupt.h>
+#include <linux/notifier.h>
 
 #define INIT_FDTABLE \
 {							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
 	.max_fdset	= EMBEDDED_FD_SET_SIZE,		\
@@ -134,10 +135,11 @@ extern struct group_info init_groups;
 	.alloc_lock	= __SPIN_LOCK_UNLOCKED(tsk.alloc_lock),		\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
+	.notify		= RAW_NOTIFIER_INIT(tsk.notify),		\
  	INIT_TRACE_IRQFLAGS						\
  	INIT_LOCKDEP							\
 }
 

Index: linux-2.6.17-rc6-mm2/kernel/sys.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
+++ linux-2.6.17-rc6-mm2/kernel/sys.c
@@ -450,13 +450,41 @@ int unregister_task_watcher(struct notif
 	return blocking_notifier_chain_unregister(&task_watchers, nb);
 }
 
 EXPORT_SYMBOL_GPL(unregister_task_watcher);
 
+static inline int notify_per_task_watchers(unsigned int val,
+					   struct task_struct *task)
+{
+	if (get_watch_event(val) != WATCH_TASK_INIT)
+		return raw_notifier_call_chain(&task->notify, val, task);
+	RAW_INIT_NOTIFIER_HEAD(&task->notify);
+	if (task->real_parent)
+		return raw_notifier_call_chain(&task->real_parent->notify,
+		   			       val, task);
+}
+
+int register_per_task_watcher(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&current->notify, nb);
+}
+EXPORT_SYMBOL_GPL(register_per_task_watcher);
+
+int unregister_per_task_watcher(struct notifier_block *nb)
+{
+	return raw_notifier_chain_unregister(&current->notify, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_per_task_watcher);
+
 int notify_watchers(unsigned long val, void *v)
 {
-	return blocking_notifier_call_chain(&task_watchers, val, v);
+	int retval;
+
+	retval = blocking_notifier_call_chain(&task_watchers, val, v);
+	if (retval & NOTIFY_STOP_MASK)
+		return retval;
+	return notify_per_task_watchers(val, v);
 }
 

 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
Index: linux-2.6.17-rc6-mm2/include/linux/notifier.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/notifier.h
+++ linux-2.6.17-rc6-mm2/include/linux/notifier.h
@@ -154,10 +154,12 @@ extern int raw_notifier_call_chain(struc
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
 
 extern int register_task_watcher(struct notifier_block *nb);
 extern int unregister_task_watcher(struct notifier_block *nb);
+extern int register_per_task_watcher(struct notifier_block *nb);
+extern int unregister_per_task_watcher(struct notifier_block *nb);
 #define WATCH_FLAGS_MASK		((-1) ^ 0x0FFFFUL)
 #define get_watch_event(v)		({ ((v) & ~WATCH_FLAGS_MASK); })
 #define get_watch_flags(v) 		({ ((v) & WATCH_FLAGS_MASK); })
 
 #define WATCH_TASK_INIT			0x00000001 /* initialize task_struct */

--

