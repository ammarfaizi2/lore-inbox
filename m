Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWFNADF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWFNADF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWFNACl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50846 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964816AbWFNACC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:02 -0400
Subject: [PATCH 07/11] Task watchers:  Register per-task delay accounting
	task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:49 -0700
Message-Id: <1150242889.21787.147.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adapts delayacct to use Task Watchers. Does not adapt taskstats to use Task
Watchers.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
--

 include/linux/delayacct.h |    2 +-
 kernel/delayacct.c        |   23 +++++++++++++++++++++++
 kernel/exit.c             |    2 --
 kernel/fork.c             |    2 --
 4 files changed, 24 insertions(+), 5 deletions(-)

Index: linux-2.6.17-rc5-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc5-mm2/kernel/exit.c
@@ -26,11 +26,10 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/taskstats_kern.h>
-#include <linux/delayacct.h>
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 #include <linux/posix-timers.h>
 #include <linux/mutex.h>
@@ -916,11 +915,10 @@ fastcall NORET_TYPE void do_exit(long co
 		compat_exit_robust_list(tsk);
 #endif
 	tsk->exit_code = code;
 	taskstats_exit_send(tsk, tidstats, tgidstats);
 	taskstats_exit_free(tidstats, tgidstats);
-	delayacct_tsk_exit(tsk);
 	notify_result = notify_watchers(WATCH_TASK_FREE, tsk);
 	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 
 	exit_mm(tsk);
 
Index: linux-2.6.17-rc5-mm2/kernel/fork.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/fork.c
+++ linux-2.6.17-rc5-mm2/kernel/fork.c
@@ -41,11 +41,10 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
-#include <linux/delayacct.h>
 #include <linux/notifier.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1002,11 +1001,10 @@ static task_t *copy_process(unsigned lon
 
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;
 
 	p->did_exec = 0;
-	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	copy_flags(clone_flags, p);
 	p->pid = pid;
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
 		if (put_user(p->pid, parent_tidptr))
Index: linux-2.6.17-rc5-mm2/kernel/delayacct.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/delayacct.c
+++ linux-2.6.17-rc5-mm2/kernel/delayacct.c
@@ -16,10 +16,11 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
+#include <linux/notifier.h>
 
 int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
 kmem_cache_t *delayacct_cache;
 
 static int __init delayacct_setup_enable(char *str)
@@ -27,17 +28,39 @@ static int __init delayacct_setup_enable
 	delayacct_on = 1;
 	return 1;
 }
 __setup("delayacct", delayacct_setup_enable);
 
+static int delayacct_watch_task(struct notifier_block *nb, unsigned long val,
+				void *t)
+{
+	struct task_struct *tsk = t;
+	switch(get_watch_event(val)) {
+	case WATCH_TASK_CLONE:
+		delayacct_tsk_init(tsk);
+		break;
+	case WATCH_TASK_FREE:
+		delayacct_tsk_exit(tsk);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __read_mostly delayacct_nb = {
+	.notifier_call = delayacct_watch_task,
+};
+
 void delayacct_init(void)
 {
 	delayacct_cache = kmem_cache_create("delayacct_cache",
 					sizeof(struct task_delay_info),
 					0,
 					SLAB_PANIC,
 					NULL, NULL);
+	register_task_watcher(&delayacct_nb);
 	delayacct_tsk_init(&init_task);
 }
 
 void __delayacct_tsk_init(struct task_struct *tsk)
 {
Index: linux-2.6.17-rc5-mm2/include/linux/delayacct.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/include/linux/delayacct.h
+++ linux-2.6.17-rc5-mm2/include/linux/delayacct.h
@@ -59,11 +59,11 @@ static inline void delayacct_tsk_init(st
 		__delayacct_tsk_init(tsk);
 }
 
 static inline void delayacct_tsk_exit(struct task_struct *tsk)
 {
-	if (tsk->delays)
+	if (unlikely(tsk->delays))
 		__delayacct_tsk_exit(tsk);
 }
 
 static inline void delayacct_blkio_start(void)
 {

--

