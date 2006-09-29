Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWI2CPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWI2CPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWI2CNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54179 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbWI2CND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:03 -0400
Message-Id: <20060929021300.307110000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:35 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 03/10] Task watchers v2 Register audit task watcher
Content-Disposition: inline; filename=task-watchers-register-audit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change audit to register a task watcher function rather than modify
the copy_process() and do_exit() paths directly.

Removes an unlikely() hint from kernel/exit.c:
	if (unlikely(tsk->audit_context))
		audit_free(tsk);
This use of unlikely() is an artifact of audit_free()'s former invocation from
__put_task_struct() (commit: fa84cb935d4ec601528f5e2f0d5d31e7876a5044).
Clearly in the __put_task_struct() path it would be called much more frequently
than do_exit() and hence the use of unlikely() there was justified. However, in
the new location the hint most likely offers no measurable performance impact.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com
---
 include/linux/audit.h |    4 ----
 kernel/auditsc.c      |   10 +++++++---
 kernel/exit.c         |    3 ---
 kernel/fork.c         |    7 +------
 4 files changed, 8 insertions(+), 16 deletions(-)

Index: linux-2.6.18-mm1/kernel/auditsc.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/auditsc.c
+++ linux-2.6.18-mm1/kernel/auditsc.c
@@ -63,10 +63,11 @@
 #include <linux/list.h>
 #include <linux/tty.h>
 #include <linux/selinux.h>
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
+#include <linux/task_watchers.h>
 
 #include "audit.h"
 
 extern struct list_head audit_filter_list[];
 
@@ -674,11 +675,11 @@ static inline struct audit_context *audi
  * Filter on the task information and allocate a per-task audit context
  * if necessary.  Doing so turns on system call auditing for the
  * specified task.  This is called from copy_process, so no lock is
  * needed.
  */
-int audit_alloc(struct task_struct *tsk)
+static int audit_alloc(unsigned long val, struct task_struct *tsk)
 {
 	struct audit_context *context;
 	enum audit_state     state;
 
 	if (likely(!audit_enabled))
@@ -700,10 +701,11 @@ int audit_alloc(struct task_struct *tsk)
 
 	tsk->audit_context  = context;
 	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
 	return 0;
 }
+task_watcher_func(init, audit_alloc);
 
 static inline void audit_free_context(struct audit_context *context)
 {
 	struct audit_context *previous;
 	int		     count = 0;
@@ -1029,28 +1031,30 @@ static void audit_log_exit(struct audit_
  * audit_free - free a per-task audit context
  * @tsk: task whose audit context block to free
  *
  * Called from copy_process and do_exit
  */
-void audit_free(struct task_struct *tsk)
+static int audit_free(unsigned long val, struct task_struct *tsk)
 {
 	struct audit_context *context;
 
 	context = audit_get_context(tsk, 0, 0);
 	if (likely(!context))
-		return;
+		return 0;
 
 	/* Check for system calls that do not go through the exit
 	 * function (e.g., exit_group), then free context block. 
 	 * We use GFP_ATOMIC here because we might be doing this 
 	 * in the context of the idle thread */
 	/* that can happen only if we are called from do_exit() */
 	if (context->in_syscall && context->auditable)
 		audit_log_exit(context, tsk);
 
 	audit_free_context(context);
+	return 0;
 }
+task_watcher_func(free, audit_free);
 
 /**
  * audit_syscall_entry - fill in an audit record at syscall entry
  * @tsk: task being audited
  * @arch: architecture type
Index: linux-2.6.18-mm1/include/linux/audit.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/audit.h
+++ linux-2.6.18-mm1/include/linux/audit.h
@@ -326,12 +326,10 @@ struct mqstat;
 extern int __init audit_register_class(int class, unsigned *list);
 extern int audit_classify_syscall(int abi, unsigned syscall);
 #ifdef CONFIG_AUDITSYSCALL
 /* These are defined in auditsc.c */
 				/* Public API */
-extern int  audit_alloc(struct task_struct *task);
-extern void audit_free(struct task_struct *task);
 extern void audit_syscall_entry(int arch,
 				int major, unsigned long a0, unsigned long a1,
 				unsigned long a2, unsigned long a3);
 extern void audit_syscall_exit(int failed, long return_code);
 extern void __audit_getname(const char *name);
@@ -426,12 +424,10 @@ static inline int audit_mq_getsetattr(mq
 		return __audit_mq_getsetattr(mqdes, mqstat);
 	return 0;
 }
 extern int audit_n_rules;
 #else
-#define audit_alloc(t) ({ 0; })
-#define audit_free(t) do { ; } while (0)
 #define audit_syscall_entry(ta,a,b,c,d,e) do { ; } while (0)
 #define audit_syscall_exit(f,r) do { ; } while (0)
 #define audit_dummy_context() 1
 #define audit_getname(n) do { ; } while (0)
 #define audit_putname(n) do { ; } while (0)
Index: linux-2.6.18-mm1/kernel/fork.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/fork.c
+++ linux-2.6.18-mm1/kernel/fork.c
@@ -37,11 +37,10 @@
 #include <linux/jiffies.h>
 #include <linux/futex.h>
 #include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
-#include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
@@ -1103,15 +1102,13 @@ static struct task_struct *copy_process(
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
-	if ((retval = audit_alloc(p)))
-		goto bad_fork_cleanup_security;
 	/* copy all the process information */
 	if ((retval = copy_semundo(clone_flags, p)))
-		goto bad_fork_cleanup_audit;
+		goto bad_fork_cleanup_security;
 	if ((retval = copy_files(clone_flags, p)))
 		goto bad_fork_cleanup_semundo;
 	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
 	if ((retval = copy_sighand(clone_flags, p)))
@@ -1282,12 +1279,10 @@ bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
-bad_fork_cleanup_audit:
-	audit_free(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
 	mpol_free(p->mempolicy);
Index: linux-2.6.18-mm1/kernel/exit.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/exit.c
+++ linux-2.6.18-mm1/kernel/exit.c
@@ -36,11 +36,10 @@
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
-#include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
 #include <linux/blkdev.h>
 #include <linux/task_watchers.h>
 
 #include <asm/uaccess.h>
@@ -908,12 +907,10 @@ fastcall NORET_TYPE void do_exit(long co
 		exit_robust_list(tsk);
 #if defined(CONFIG_FUTEX) && defined(CONFIG_COMPAT)
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
-	if (unlikely(tsk->audit_context))
-		audit_free(tsk);
 	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
 
 	exit_mm(tsk);
 	notify_task_watchers(WATCH_TASK_FREE, code, tsk);

--
