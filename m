Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWI2CPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWI2CPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWI2COa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:14:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:42708 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161276AbWI2COY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:14:24 -0400
Message-Id: <20060929021301.134993000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:38 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 06/10] Task watchers v2 Register NUMA mempolicy task watcher
Content-Disposition: inline; filename=task-watchers-register-numa-mempolicy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a NUMA mempolicy task watcher instead of hooking into
copy_process() and do_exit() directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/exit.c  |    4 ----
 kernel/fork.c  |   15 +--------------
 mm/mempolicy.c |   24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 18 deletions(-)

Index: linux-2.6.18-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.18-mm1.orig/mm/mempolicy.c
+++ linux-2.6.18-mm1/mm/mempolicy.c
@@ -87,10 +87,11 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/migrate.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/task_watchers.h>
 
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
 /* Internal flags */
@@ -1331,10 +1332,33 @@ struct mempolicy *__mpol_copy(struct mem
 		}
 	}
 	return new;
 }
 
+static int init_task_mempolicy(unsigned long clone_flags,
+			       struct task_struct *tsk)
+{
+ 	tsk->mempolicy = mpol_copy(tsk->mempolicy);
+ 	if (IS_ERR(tsk->mempolicy)) {
+		int retval;
+
+ 		retval = PTR_ERR(tsk->mempolicy);
+ 		tsk->mempolicy = NULL;
+		return retval;
+ 	}
+	mpol_fix_fork_child_flag(tsk);
+	return 0;
+}
+task_watcher_func(init, init_task_mempolicy);
+
+static int free_task_mempolicy(unsigned int ignored, struct task_struct *tsk)
+{
+	mpol_free(tsk);
+	tsk->mempolicy = NULL;
+}
+task_watcher_func(free, free_task_mempolicy);
+
 /* Slow path of a mempolicy comparison */
 int __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	if (!a || !b)
 		return 0;
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -1058,19 +1058,10 @@ static struct task_struct *copy_process(
 		p->tgid = current->tgid;
 
 	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
 	if (retval < 0)
 		goto bad_fork_cleanup_delays_binfmt;
-#ifdef CONFIG_NUMA
- 	p->mempolicy = mpol_copy(p->mempolicy);
- 	if (IS_ERR(p->mempolicy)) {
- 		retval = PTR_ERR(p->mempolicy);
- 		p->mempolicy = NULL;
- 		goto bad_fork_cleanup_delays_binfmt;
- 	}
-	mpol_fix_fork_child_flag(p);
-#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
 #ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
 	p->hardirqs_enabled = 1;
 #else
@@ -1099,11 +1090,11 @@ static struct task_struct *copy_process(
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
 
 	if ((retval = security_task_alloc(p)))
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_cleanup_delays_binfmt;
 	/* copy all the process information */
 	if ((retval = copy_files(clone_flags, p)))
 		goto bad_fork_cleanup_security;
 	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
@@ -1275,14 +1266,10 @@ bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup_security:
 	security_task_free(p);
-bad_fork_cleanup_policy:
-#ifdef CONFIG_NUMA
-	mpol_free(p->mempolicy);
-#endif
 bad_fork_cleanup_delays_binfmt:
 	delayacct_tsk_free(p);
 	notify_task_watchers(WATCH_TASK_FREE, 0, p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -930,14 +930,10 @@ fastcall NORET_TYPE void do_exit(long co
 
 	tsk->exit_code = code;
 	proc_exit_connector(tsk);
 	exit_notify(tsk);
 	exit_task_namespaces(tsk);
-#ifdef CONFIG_NUMA
-	mpol_free(tsk->mempolicy);
-	tsk->mempolicy = NULL;
-#endif
 	/*
 	 * This must happen late, after the PID is not
 	 * hashed anymore:
 	 */
 	if (unlikely(!list_empty(&tsk->pi_state_list)))

--
