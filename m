Return-Path: <linux-kernel-owner+w=401wt.eu-S1750794AbWLOAYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWLOAYv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWLOAXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:23:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34740 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbWLOAXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:40 -0500
Message-Id: <20061215000818.976953000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:07:59 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: Register NUMA mempolicy task watcher
Content-Disposition: inline; filename=task-watchers-register-numa-mempolicy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register a NUMA mempolicy task watcher instead of hooking into
copy_process() and do_exit() directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/exit.c  |    4 ----
 kernel/fork.c  |   15 +--------------
 mm/mempolicy.c |   25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)

Benchmark results:
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone	Number of Children Cloned
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17836.3 	18085.2 	18220.4 	18225 		18319	 	18339
Dev	302.801 	314.617 	303.079 	293.46 		287.267 	294.819
Err (%)	1.69767 	1.73963 	1.6634	 	1.6102	 	1.56814 	1.60761

Fork	Number of Children Forked
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17896.2 	17990 		18100.6 	18242.3 	18244 		18346.9
Dev	301.64	 	285.698 	295.646 	304.361 	299.472 	287.153
Err (%)	1.6855 		1.58809 	1.63335 	1.66844 	1.64148 	1.56513

Kernbench:
Elapsed: 124.532s User: 439.732s System: 46.497s CPU: 389.9%
439.71user 46.48system 2:04.24elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.79user 46.42system 2:05.10elapsed 388%CPU (0avgtext+0avgdata 0maxresident)k
439.74user 46.44system 2:04.60elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.75user 46.64system 2:04.74elapsed 389%CPU (0avgtext+0avgdata 0maxresident)k
439.61user 46.45system 2:05.36elapsed 387%CPU (0avgtext+0avgdata 0maxresident)k
439.60user 46.43system 2:04.33elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.77user 46.47system 2:04.34elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.87user 46.45system 2:04.10elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.76user 46.71system 2:04.58elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.72user 46.48system 2:03.93elapsed 392%CPU (0avgtext+0avgdata 0maxresident)k

Index: linux-2.6.19/mm/mempolicy.c
===================================================================
--- linux-2.6.19.orig/mm/mempolicy.c
+++ linux-2.6.19/mm/mempolicy.c
@@ -87,10 +87,11 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/migrate.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/init.h>
 
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
 /* Internal flags */
@@ -1331,10 +1332,34 @@ struct mempolicy *__mpol_copy(struct mem
 		}
 	}
 	return new;
 }
 
+static int __task_init init_task_mempolicy(unsigned long clone_flags,
+			    		   struct task_struct *tsk)
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
+DEFINE_TASK_INITCALL(init_task_mempolicy);
+
+static int __task_free free_task_mempolicy(unsigned int ignored,
+					   struct task_struct *tsk)
+{
+	mpol_free(tsk->mempolicy);
+	tsk->mempolicy = NULL;
+}
+DEFINE_TASK_FREECALL(free_task_mempolicy);
+
 /* Slow path of a mempolicy comparison */
 int __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	if (!a || !b)
 		return 0;
Index: linux-2.6.19/kernel/fork.c
===================================================================
--- linux-2.6.19.orig/kernel/fork.c
+++ linux-2.6.19/kernel/fork.c
@@ -1059,19 +1059,10 @@ static struct task_struct *copy_process(
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
@@ -1098,11 +1089,11 @@ static struct task_struct *copy_process(
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
@@ -1274,14 +1265,10 @@ bad_fork_cleanup_fs:
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
Index: linux-2.6.19/kernel/exit.c
===================================================================
--- linux-2.6.19.orig/kernel/exit.c
+++ linux-2.6.19/kernel/exit.c
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
