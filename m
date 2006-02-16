Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWBPJoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWBPJoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWBPJog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:44:36 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61647 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932523AbWBPJoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:44:09 -0500
Date: Thu, 16 Feb 2006 10:42:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 4/6] lightweight robust futexes: compat
Message-ID: <20060216094227.GE29716@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


32-bit syscall compatibility support. (This patch also moves all
futex related compat functionality into kernel/futex_compat.c.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Acked-by: Ulrich Drepper <drepper@redhat.com>

----

 include/linux/compat.h |   18 ++++++
 include/linux/sched.h  |    3 +
 kernel/Makefile        |    3 +
 kernel/compat.c        |   23 -------
 kernel/exit.c          |    5 +
 kernel/futex_compat.c  |  142 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 171 insertions(+), 23 deletions(-)

Index: linux-robust-list.q/include/linux/compat.h
===================================================================
--- linux-robust-list.q.orig/include/linux/compat.h
+++ linux-robust-list.q/include/linux/compat.h
@@ -121,6 +121,24 @@ typedef struct compat_sigevent {
 	} _sigev_un;
 } compat_sigevent_t;
 
+struct compat_robust_list {
+	compat_uptr_t			next;
+};
+
+struct compat_robust_list_head {
+	struct compat_robust_list	list;
+	compat_long_t			futex_offset;
+	compat_uptr_t			list_op_pending;
+};
+
+extern void compat_exit_robust_list(struct task_struct *curr);
+
+asmlinkage long
+compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+			   compat_size_t len);
+asmlinkage long
+compat_sys_get_robust_list(int pid, compat_uptr_t *head_ptr,
+			   compat_size_t __user *len_ptr);
 
 long compat_sys_semctl(int first, int second, int third, void __user *uptr);
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr);
Index: linux-robust-list.q/include/linux/sched.h
===================================================================
--- linux-robust-list.q.orig/include/linux/sched.h
+++ linux-robust-list.q/include/linux/sched.h
@@ -873,6 +873,9 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	struct robust_list_head __user *robust_list;
+#ifdef CONFIG_COMPAT
+	struct compat_robust_list_head __user *compat_robust_list;
+#endif
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
Index: linux-robust-list.q/kernel/Makefile
===================================================================
--- linux-robust-list.q.orig/kernel/Makefile
+++ linux-robust-list.q/kernel/Makefile
@@ -12,6 +12,9 @@ obj-y     = sched.o fork.o exec_domain.o
 
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_FUTEX) += futex.o
+ifeq ($(CONFIG_COMPAT),y)
+obj-$(CONFIG_FUTEX) += futex_compat.o
+endif
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
Index: linux-robust-list.q/kernel/compat.c
===================================================================
--- linux-robust-list.q.orig/kernel/compat.c
+++ linux-robust-list.q/kernel/compat.c
@@ -17,7 +17,6 @@
 #include <linux/time.h>
 #include <linux/signal.h>
 #include <linux/sched.h>	/* for MAX_SCHEDULE_TIMEOUT */
-#include <linux/futex.h>	/* for FUTEX_WAIT */
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/security.h>
@@ -238,28 +237,6 @@ asmlinkage long compat_sys_sigprocmask(i
 	return ret;
 }
 
-#ifdef CONFIG_FUTEX
-asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, int val,
-		struct compat_timespec __user *utime, u32 __user *uaddr2,
-		int val3)
-{
-	struct timespec t;
-	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
-	int val2 = 0;
-
-	if ((op == FUTEX_WAIT) && utime) {
-		if (get_compat_timespec(&t, utime))
-			return -EFAULT;
-		timeout = timespec_to_jiffies(&t) + 1;
-	}
-	if (op >= FUTEX_REQUEUE)
-		val2 = (int) (unsigned long) utime;
-
-	return do_futex((unsigned long)uaddr, op, val, timeout,
-			(unsigned long)uaddr2, val2, val3);
-}
-#endif
-
 asmlinkage long compat_sys_setrlimit(unsigned int resource,
 		struct compat_rlimit __user *rlim)
 {
Index: linux-robust-list.q/kernel/exit.c
===================================================================
--- linux-robust-list.q.orig/kernel/exit.c
+++ linux-robust-list.q/kernel/exit.c
@@ -32,6 +32,7 @@
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
 #include <linux/futex.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -852,6 +853,10 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	if (unlikely(tsk->robust_list))
 		exit_robust_list(tsk);
+#ifdef CONFIG_COMPAT
+	if (unlikely(tsk->compat_robust_list))
+		compat_exit_robust_list(tsk);
+#endif
 	exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux-robust-list.q/kernel/futex_compat.c
===================================================================
--- /dev/null
+++ linux-robust-list.q/kernel/futex_compat.c
@@ -0,0 +1,142 @@
+/*
+ * linux/kernel/futex_compat.c
+ *
+ * Futex compatibililty routines.
+ *
+ * Copyright 2006, Red Hat, Inc., Ingo Molnar
+ */
+
+#include <linux/linkage.h>
+#include <linux/compat.h>
+#include <linux/futex.h>
+
+#include <asm/uaccess.h>
+
+/*
+ * Walk curr->robust_list (very carefully, it's a userspace list!)
+ * and mark any locks found there dead, and notify any waiters.
+ *
+ * We silently return on any sign of list-walking problem.
+ */
+void compat_exit_robust_list(struct task_struct *curr)
+{
+	struct compat_robust_list_head __user *head = curr->compat_robust_list;
+	struct robust_list __user *entry, *pending;
+	compat_uptr_t uentry, upending;
+	unsigned int limit = ROBUST_LIST_LIMIT;
+	compat_long_t futex_offset;
+
+	/*
+	 * Fetch the list head (which was registered earlier, via
+	 * sys_set_robust_list()):
+	 */
+	if (get_user(uentry, &head->list.next))
+		return;
+	entry = compat_ptr(uentry);
+	/*
+	 * Fetch the relative futex offset:
+	 */
+	if (get_user(futex_offset, &head->futex_offset))
+		return;
+	/*
+	 * Fetch any possibly pending lock-add first, and handle it
+	 * if it exists:
+	 */
+	if (get_user(upending, &head->list_op_pending))
+		return;
+	pending = compat_ptr(upending);
+	if (upending)
+		handle_futex_death((void *)pending + futex_offset, curr);
+
+	while (compat_ptr(uentry) != &head->list) {
+		/*
+		 * A pending lock might already be on the list, so
+		 * dont process it twice:
+		 */
+		if (entry != pending)
+			if (handle_futex_death((void *)entry + futex_offset,
+						curr))
+				return;
+
+		/*
+		 * Fetch the next entry in the list:
+		 */
+		if (get_user(uentry, (compat_uptr_t *)&entry->next))
+			return;
+		entry = compat_ptr(uentry);
+		/*
+		 * Avoid excessively long or circular lists:
+		 */
+		if (!--limit)
+			break;
+
+		cond_resched();
+	}
+}
+
+asmlinkage long
+compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+			   compat_size_t len)
+{
+	if (unlikely(len != sizeof(*head)))
+		return -EINVAL;
+
+	current->compat_robust_list = head;
+
+	return 0;
+}
+
+asmlinkage long
+compat_sys_get_robust_list(int pid, compat_uptr_t *head_ptr,
+			   compat_size_t __user *len_ptr)
+{
+	struct compat_robust_list_head *head;
+	unsigned long ret;
+
+	if (!pid)
+		head = current->compat_robust_list;
+	else {
+		struct task_struct *p;
+
+		ret = -ESRCH;
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(pid);
+		if (!p)
+			goto err_unlock;
+		ret = -EPERM;
+		if ((current->euid != p->euid) && (current->euid != p->uid) &&
+				!capable(CAP_SYS_PTRACE))
+			goto err_unlock;
+		head = p->compat_robust_list;
+		read_unlock(&tasklist_lock);
+	}
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(ptr_to_compat(head), head_ptr);
+
+err_unlock:
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
+asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, int val,
+		struct compat_timespec __user *utime, u32 __user *uaddr2,
+		int val3)
+{
+	struct timespec t;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+	int val2 = 0;
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (get_compat_timespec(&t, utime))
+			return -EFAULT;
+		timeout = timespec_to_jiffies(&t) + 1;
+	}
+	if (op >= FUTEX_REQUEUE)
+		val2 = (int) (unsigned long) utime;
+
+	return do_futex((unsigned long)uaddr, op, val, timeout,
+			(unsigned long)uaddr2, val2, val3);
+}
