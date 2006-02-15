Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWBOW6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWBOW6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBOW6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:58:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60140 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932205AbWBOW6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:58:44 -0500
Date: Wed, 15 Feb 2006 23:56:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 2/5] lightweight robust futexes: core
Message-ID: <20060215225654.GC5599@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch adds the core infrastructure for robust futexes:
structure definitions, the new syscalls and the do_exit() based
cleanup mechanism.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Acked-by: Ulrich Drepper <drepper@redhat.com>

----

 include/linux/futex.h   |   95 ++++++++++++++++++++++++++
 include/linux/sched.h   |    3 
 include/linux/threads.h |    3 
 kernel/exit.c           |    3 
 kernel/futex.c          |  173 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys_ni.c         |    4 +
 6 files changed, 280 insertions(+), 1 deletion(-)

Index: linux-robust-list.q/include/linux/futex.h
===================================================================
--- linux-robust-list.q.orig/include/linux/futex.h
+++ linux-robust-list.q/include/linux/futex.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_FUTEX_H
 #define _LINUX_FUTEX_H
 
+#include <linux/sched.h>
+
 /* Second argument to futex syscall */
 
 
@@ -11,10 +13,103 @@
 #define FUTEX_CMP_REQUEUE	4
 #define FUTEX_WAKE_OP		5
 
+/*
+ * Support for robust futexes: the kernel cleans up held futexes at
+ * thread exit time.
+ */
+
+/*
+ * Per-lock list entry - embedded in user-space locks, somewhere close
+ * to the futex field. (Note: user-space uses a double-linked list to
+ * achieve O(1) list add and remove, but the kernel only needs to know
+ * about the forward link)
+ *
+ * NOTE: this structure is part of the syscall ABI, and must not be
+ * changed.
+ */
+struct robust_list {
+	struct robust_list __user *next;
+};
+
+/*
+ * Per-thread list head:
+ *
+ * NOTE: this structure is part of the syscall ABI, and must only be
+ * changed if the change is first communicated with the glibc folks.
+ * (When an incompatible change is done, we'll increase the structure
+ *  size, which glibc will detect)
+ */
+struct robust_list_head {
+	/*
+	 * The head of the list. Points back to itself if empty:
+	 */
+	struct robust_list list;
+
+	/*
+	 * This relative offset is set by user-space, it gives the kernel
+	 * the relative position of the futex field to examine. This way
+	 * we keep userspace flexible, to freely shape its data-structure,
+	 * without hardcoding any particular offset into the kernel:
+	 */
+	long futex_offset;
+
+	/*
+	 * The death of the thread may race with userspace setting
+	 * up a lock's links. So to handle this race, userspace first
+	 * sets this field to the address of the to-be-taken lock,
+	 * then does the lock acquire, and then adds itself to the
+	 * list, and then clears this field. Hence the kernel will
+	 * always have full knowledge of all locks that the thread
+	 * _might_ have taken. We check the owner TID in any case,
+	 * so only truly owned locks will be handled.
+	 */
+	struct robust_list __user *list_add_pending;
+};
+
+/*
+ * Are there any waiters for this robust futex:
+ */
+#define FUTEX_WAITERS		0x80000000
+
+/*
+ * The kernel signals via this bit that a thread holding a futex
+ * has exited without unlocking the futex. The kernel also does
+ * a FUTEX_WAKE on such futexes, after setting the bit, to wake
+ * up any possible waiters:
+ */
+#define FUTEX_OWNER_DIED	0x40000000
+
+/*
+ * Reserved bit:
+ */
+#define FUTEX_OWNER_PENDING	0x20000000
+
+/*
+ * The rest of the robust-futex field is for the TID:
+ */
+#define FUTEX_TID_MASK		0x1fffffff
+
+/*
+ * A limit of one million locks held per thread (!) ought to be enough
+ * for some time. This also protects against a deliberately circular
+ * list. Not worth introducing an rlimit for this:
+ */
+#define ROBUST_LIST_LIMIT	1048576
+
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2,
 		int val3);
 
+extern int handle_futex_death(unsigned int *uaddr, struct task_struct *curr);
+
+#ifdef CONFIG_FUTEX
+extern void exit_robust_list(struct task_struct *curr);
+#else
+static inline void exit_robust_list(struct task_struct *curr)
+{
+}
+#endif
+
 #define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
 #define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
 #define FUTEX_OP_OR		2	/* *(int *)UADDR2 |= OPARG; */
Index: linux-robust-list.q/include/linux/sched.h
===================================================================
--- linux-robust-list.q.orig/include/linux/sched.h
+++ linux-robust-list.q/include/linux/sched.h
@@ -35,6 +35,7 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 #include <linux/rcupdate.h>
+#include <linux/futex.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -871,6 +872,8 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+	struct robust_list_head __user *robust_list;
+
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
 };
Index: linux-robust-list.q/include/linux/threads.h
===================================================================
--- linux-robust-list.q.orig/include/linux/threads.h
+++ linux-robust-list.q/include/linux/threads.h
@@ -28,7 +28,8 @@
 #define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
 
 /*
- * A maximum of 4 million PIDs should be enough for a while:
+ * A maximum of 4 million PIDs should be enough for a while.
+ * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
  */
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
Index: linux-robust-list.q/kernel/exit.c
===================================================================
--- linux-robust-list.q.orig/kernel/exit.c
+++ linux-robust-list.q/kernel/exit.c
@@ -31,6 +31,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
+#include <linux/futex.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -849,6 +850,8 @@ fastcall NORET_TYPE void do_exit(long co
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
+	if (unlikely(tsk->robust_list))
+		exit_robust_list(tsk);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux-robust-list.q/kernel/futex.c
===================================================================
--- linux-robust-list.q.orig/kernel/futex.c
+++ linux-robust-list.q/kernel/futex.c
@@ -8,6 +8,10 @@
  *  Removed page pinning, fix privately mapped COW pages and other cleanups
  *  (C) Copyright 2003, 2004 Jamie Lokier
  *
+ *  Robust futex support started by Ingo Molnar
+ *  (C) Copyright 2006 Red Hat Inc, All Rights Reserved
+ *  Thanks to Thomas Gleixner for suggestions, analysis and fixes.
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -829,6 +833,175 @@ error:
 	goto out;
 }
 
+/*
+ * Support for robust futexes: the kernel cleans up held futexes at
+ * thread exit time.
+ *
+ * Implementation: user-space maintains a per-thread list of locks it
+ * is holding. Upon do_exit(), the kernel carefully walks this list,
+ * and marks all locks that are owned by this thread with the
+ * FUTEX_OWNER_DEAD bit, and wakes up a waiter (if any). The list is
+ * always manipulated with the lock held, so the list is private and
+ * per-thread. Userspace also maintains a per-thread 'list_add_pending'
+ * field, to allow the kernel to clean up if the thread dies after
+ * acquiring the lock, but just before it could have added itself to
+ * the list. There can only be one such pending lock.
+ */
+
+/**
+ * sys_set_robust_list - set the robust-futex list head of a task
+ * @head: pointer to the list-head
+ * @len: length of the list-head, as userspace expects
+ */
+asmlinkage long
+sys_set_robust_list(struct robust_list_head __user *head,
+		    size_t len)
+{
+	/*
+	 * The kernel knows only one size for now:
+	 */
+	if (unlikely(len != sizeof(*head)))
+		return -EINVAL;
+
+	current->robust_list = head;
+
+	return 0;
+}
+
+/**
+ * sys_get_robust_list - get the robust-futex list head of a task
+ * @pid: pid of the process [zero for current task]
+ * @head_ptr: pointer to a list-head pointer, the kernel fills it in
+ * @len_ptr: pointer to a length field, the kernel fills in the header size
+ */
+asmlinkage long
+sys_get_robust_list(int pid, struct robust_list_head __user **head_ptr,
+		    size_t __user *len_ptr)
+{
+	struct robust_list_head *head;
+	unsigned long ret;
+
+	if (!pid)
+		head = current->robust_list;
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
+		head = p->robust_list;
+		read_unlock(&tasklist_lock);
+	}
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(head, head_ptr);
+
+err_unlock:
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
+/*
+ * Process a futex-list entry, check whether it's owned by the
+ * dying task, and do notification if so:
+ */
+int handle_futex_death(unsigned int *uaddr, struct task_struct *curr)
+{
+	unsigned int futex_val;
+
+repeat:
+	if (get_user(futex_val, uaddr))
+		return -1;
+
+	if ((futex_val & FUTEX_TID_MASK) == curr->pid) {
+		/*
+		 * Ok, this dying thread is truly holding a futex
+		 * of interest. Set the OWNER_DIED bit atomically
+		 * via cmpxchg, and if the value had FUTEX_WAITERS
+		 * set, wake up a waiter (if any). (We have to do a
+		 * futex_wake() even if OWNER_DIED is already set -
+		 * to handle the rare but possible case of recursive
+		 * thread-death.) The rest of the cleanup is done in
+		 * userspace.
+		 */
+		if (futex_atomic_cmpxchg_inuser(uaddr, futex_val,
+					 futex_val | FUTEX_OWNER_DIED) !=
+								   futex_val)
+			goto repeat;
+
+		if (futex_val & FUTEX_WAITERS)
+			futex_wake((unsigned long)uaddr, 1);
+	}
+	return 0;
+}
+
+/*
+ * Walk curr->robust_list (very carefully, it's a userspace list!)
+ * and mark any locks found there dead, and notify any waiters.
+ *
+ * We silently return on any sign of list-walking problem.
+ */
+void exit_robust_list(struct task_struct *curr)
+{
+	struct robust_list_head __user *head = curr->robust_list;
+	struct robust_list __user *entry, *pending;
+	unsigned int limit = ROBUST_LIST_LIMIT;
+	unsigned long futex_offset;
+
+	/*
+	 * Fetch the list head (which was registered earlier, via
+	 * sys_set_robust_list()):
+	 */
+	if (get_user(entry, &head->list.next))
+		return;
+	/*
+	 * Fetch the relative futex offset:
+	 */
+	if (get_user(futex_offset, &head->futex_offset))
+		return;
+	/*
+	 * Fetch any possibly pending lock-add first, and handle it
+	 * if it exists:
+	 */
+	if (get_user(pending, &head->list_add_pending))
+		return;
+	if (pending)
+		if (handle_futex_death((void *)pending + futex_offset, curr))
+			return;
+
+	while (entry != &head->list) {
+		/*
+		 * A pending lock might already be on the list, so
+		 * dont process it twice:
+		 */
+		if (entry != pending)
+			if (handle_futex_death((void *)pending + futex_offset,
+						curr))
+				return;
+
+		/*
+		 * Fetch the next entry in the list:
+		 */
+		if (get_user(entry, &entry->next))
+			return;
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
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
 		unsigned long uaddr2, int val2, int val3)
 {
Index: linux-robust-list.q/kernel/sys_ni.c
===================================================================
--- linux-robust-list.q.orig/kernel/sys_ni.c
+++ linux-robust-list.q/kernel/sys_ni.c
@@ -42,6 +42,10 @@ cond_syscall(sys_recvmsg);
 cond_syscall(sys_socketcall);
 cond_syscall(sys_futex);
 cond_syscall(compat_sys_futex);
+cond_syscall(sys_set_robust_list);
+cond_syscall(compat_sys_set_robust_list);
+cond_syscall(sys_get_robust_list);
+cond_syscall(compat_sys_get_robust_list);
 cond_syscall(sys_epoll_create);
 cond_syscall(sys_epoll_ctl);
 cond_syscall(sys_epoll_wait);
