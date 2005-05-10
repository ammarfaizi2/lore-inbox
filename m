Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVEJUgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVEJUgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVEJUfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:35:43 -0400
Received: from palrel13.hp.com ([156.153.255.238]:50839 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261780AbVEJUcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:32:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17025.6719.837031.411067@napali.hpl.hp.com>
Date: Tue, 10 May 2005 13:31:59 -0700
To: akpm@osdl.org
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, roland@redhat.com
Subject: [patch] add arch_ptrace_stop() hook and use it on ia64
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

My earlier mail to lkml [1] resulted in no feedback (negative or
positive) and the patch passes all the tests I have thrown at it, so
it would be good to get some more exposure via your tree.

For non-ia64, the patch is almost trivial except that in ptrace_stop()
it changes the order in which sighand->siglock is released and
set_current_state(TASK_TRACED) is performed.  I _think_ that's OK (as
explained in the earlier mail), but since I'm not terribly familiar
with this code, I could be missing something.

As far as ia64 is concerned, the patch should be strictly goodness: it
simplifies things quite a bit and even makes the sigaltstack test pass
in the gdb test-suite.

I considered splitting up the patch into two pieces (generic and ia64)
but since it is frowned upon to introduce new hooks without any users,
I thought it's better to keep them together.

Tony, I assume you'd be OK if Andrew merged this into his tree.  If
not, please speak up.

Thanks,

	--david

[1] http://marc.theaimsgroup.com/?l=linux-ia64&m=111530205816184

Add arch_ptrace_stop() hook and use it on ia64.

The hook lets architectures do their own thing when a task stops for
ptrace.  In the case of ia64, we'd like to use this to update the
user's virtual memory with the portion of the register-backing store
that ended up on the kernel-stack.

Note that the patch changes ptrace_stop() to release the
sighand->siglock before setting the task to TASK_TRACED state.  This
is needed such that arch_ptrace_stop() can run without holding
sighand->siglock (arch_ptrace_stop() may access user-memory and hence
indirectly modify the task's run state and hence it is not possible to
establish the TASK_TRACED state before running the hook).

This patch is based on an idea and draft patch by Roland McGrath.

 arch/ia64/kernel/head.S   |   11 +++
 arch/ia64/kernel/ptrace.c |  165 ++++++++++++++++++++++++----------------------
 include/asm-ia64/ptrace.h |   17 ++++
 include/linux/ptrace.h    |    4 +
 kernel/signal.c           |    4 -
 5 files changed, 122 insertions(+), 79 deletions(-)

Signed-off-by: David Mosberger-Tang <davidm@hpl.hp.com>

Index: arch/ia64/kernel/head.S
===================================================================
--- e2923a24b6b2cd3cd5b1af3ef477da2922ba8fb2/arch/ia64/kernel/head.S  (mode:100644)
+++ uncommitted/arch/ia64/kernel/head.S  (mode:100644)
@@ -1010,6 +1010,17 @@
 1:	br.sptk.few 1b				// not reached
 END(start_kernel_thread)
 
+GLOBAL_ENTRY(ia64_flush_rbs)
+	flushrs
+	;;
+	mov ar.rsc = 0
+	;;
+	mov r8 = ar.bspstore
+	mov r9 = ar.rnat
+	mov ar.rsc = 3
+	br.ret.sptk.many rp
+END(ia64_flush_rbs)
+
 #ifdef CONFIG_IA64_BRL_EMU
 
 /*
Index: arch/ia64/kernel/ptrace.c
===================================================================
--- e2923a24b6b2cd3cd5b1af3ef477da2922ba8fb2/arch/ia64/kernel/ptrace.c  (mode:100644)
+++ uncommitted/arch/ia64/kernel/ptrace.c  (mode:100644)
@@ -402,8 +402,7 @@
 {
 	unsigned long *bspstore, *krbs, regnum, *laddr, *urbs_end, *rnat_addr;
 	struct pt_regs *child_regs;
-	size_t copied;
-	long ret;
+	long ret, err;
 
 	urbs_end = (long *) user_rbs_end;
 	laddr = (unsigned long *) addr;
@@ -451,8 +450,12 @@
 			return 0;
 		}
 	}
-	copied = access_process_vm(child, addr, &ret, sizeof(ret), 0);
-	if (copied != sizeof(ret))
+	if (child == current)
+		err = get_user(ret, (long __user *) addr);
+	else
+		err = (access_process_vm(child, addr, &ret, sizeof(ret), 0)
+		       != sizeof(ret));
+	if (err)
 		return -EIO;
 	*val = ret;
 	return 0;
@@ -534,97 +537,110 @@
 		    unsigned long user_rbs_start, unsigned long user_rbs_end)
 {
 	unsigned long addr, val;
-	long ret;
+	long ret, err;
+
+	if (child == current &&
+	    !access_ok(VERIFY_WRITE, user_rbs_start,
+		       (user_rbs_end - user_rbs_start)))
+	    return -EIO;
 
 	/* now copy word for word from kernel rbs to user rbs: */
 	for (addr = user_rbs_start; addr < user_rbs_end; addr += 8) {
-		ret = ia64_peek(child, sw, user_rbs_end, addr, &val);
-		if (ret < 0)
+		if ((ret = ia64_peek(child, sw, user_rbs_end, addr, &val)) < 0)
 			return ret;
-		if (access_process_vm(child, addr, &val, sizeof(val), 1)
-		    != sizeof(val))
+		if (child == current)
+			err = __put_user(val, (unsigned long __user *) addr);
+		else
+			err = access_process_vm(child, addr, &val, sizeof(val),
+						1) != sizeof(val);
+		if (err)
 			return -EIO;
 	}
 	return 0;
 }
 
-static inline int
-thread_matches (struct task_struct *thread, unsigned long addr)
+void
+arch_ptrace_stop (struct task_struct *child, siginfo_t *info)
 {
-	unsigned long thread_rbs_end;
-	struct pt_regs *thread_regs;
+	struct pt_regs *regs = ia64_task_regs(child);
+	struct switch_stack *sw;
+	unsigned long rbs_end;
 
-	if (ptrace_check_attach(thread, 0) < 0)
+	if (likely (child == current)) {
+		struct ia64_flush_rbs_retval rv;
 		/*
-		 * If the thread is not in an attachable state, we'll
-		 * ignore it.  The net effect is that if ADDR happens
-		 * to overlap with the portion of the thread's
-		 * register backing store that is currently residing
-		 * on the thread's kernel stack, then ptrace() may end
-		 * up accessing a stale value.  But if the thread
-		 * isn't stopped, that's a problem anyhow, so we're
-		 * doing as well as we can...
+		 * Create a minimal switch-stack which just contains enough
+		 * info to do ia64_peek().
 		 */
-		return 0;
+		sw = kmalloc(sizeof(*sw), GFP_KERNEL);
+		rv = ia64_flush_rbs();
+		sw->ar_bspstore = rv.bspstore;
+		sw->ar_rnat = rv.rnat;
+	} else
+		sw = (struct switch_stack *) (child->thread.ksp + 16);
 
-	thread_regs = ia64_task_regs(thread);
-	thread_rbs_end = ia64_get_user_rbs_end(thread, thread_regs, NULL);
-	if (!on_kernel_rbs(addr, thread_regs->ar_bspstore, thread_rbs_end))
-		return 0;
+	/*
+	 * Copy this task's dirty partition from the kernel stack back
+	 * to user-level so ptrace() gets a consistent view of this
+	 * task's stack.
+	 */
+	rbs_end = ia64_get_user_rbs_end(child, regs, NULL);
+	ia64_sync_user_rbs(child, sw, regs->ar_bspstore, rbs_end);
 
-	return 1;	/* looks like we've got a winner */
+	if (child == current)
+		kfree(sw);
 }
 
 /*
- * GDB apparently wants to be able to read the register-backing store
- * of any thread when attached to a given process.  If we are peeking
- * or poking an address that happens to reside in the kernel-backing
- * store of another thread, we need to attach to that thread, because
- * otherwise we end up accessing stale data.
- *
- * task_list_lock must be read-locked before calling this routine!
+ * After PTRACE_ATTACH, a thread's register backing store area in user
+ * space is assumed to contain correct data whenever the thread is
+ * stopped.  arch_ptrace_stop takes care of this on tracing stops.
+ * But if the child was already stopped for job control when we attach
+ * to it, then it might not ever get into ptrace_stop by the time we
+ * want to examine the user memory containing the RBS.
  */
-static struct task_struct *
-find_thread_for_addr (struct task_struct *child, unsigned long addr)
+static void
+ptrace_attach_sync_user_rbs (struct task_struct *child)
 {
-	struct task_struct *g, *p;
-	struct mm_struct *mm;
-	int mm_users;
-
-	if (!(mm = get_task_mm(child)))
-		return child;
-
-	/* -1 because of our get_task_mm(): */
-	mm_users = atomic_read(&mm->mm_users) - 1;
-	if (mm_users <= 1)
-		goto out;		/* not multi-threaded */
+	int stopped = 0;
 
 	/*
-	 * First, traverse the child's thread-list.  Good for scalability with
-	 * NPTL-threads.
+	 * If the child is in TASK_STOPPED, we need to change that to
+	 * TASK_TRACED momentarily while we operate on it.  This ensures
+	 * that the child won't be woken up and return to user mode while
+	 * we are doing the sync.  (It can only be woken up for SIGKILL.)
 	 */
-	p = child;
-	do {
-		if (thread_matches(p, addr)) {
-			child = p;
-			goto out;
+
+	read_lock(&tasklist_lock);
+	if (child->signal) {
+		spin_lock_irq(&child->sighand->siglock);
+		if (child->state == TASK_STOPPED) {
+			child->state = TASK_TRACED;
+			stopped = 1;
 		}
-		if (mm_users-- <= 1)
-			goto out;
-	} while ((p = next_thread(p)) != child);
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
 
-	do_each_thread(g, p) {
-		if (child->mm != mm)
-			continue;
+	if (!stopped)
+		return;
 
-		if (thread_matches(p, addr)) {
-			child = p;
-			goto out;
+	arch_ptrace_stop(child, NULL);
+
+	/*
+	 * Now move the child back into TASK_STOPPED if it should be in a
+	 * job control stop, so that SIGCONT can be used to wake it up.
+	 */
+	read_lock(&tasklist_lock);
+	if (child->signal) {
+		spin_lock_irq(&child->sighand->siglock);
+		if (child->state == TASK_TRACED &&
+		    (child->signal->flags & SIGNAL_STOP_STOPPED)) {
+			child->state = TASK_STOPPED;
 		}
-	} while_each_thread(g, p);
-  out:
-	mmput(mm);
-	return child;
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);
 }
 
 /*
@@ -1409,7 +1425,7 @@
 sys_ptrace (long request, pid_t pid, unsigned long addr, unsigned long data)
 {
 	struct pt_regs *pt;
-	unsigned long urbs_end, peek_or_poke;
+	unsigned long urbs_end;
 	struct task_struct *child;
 	struct switch_stack *sw;
 	long ret;
@@ -1428,19 +1444,12 @@
 		goto out;
 	}
 
-	peek_or_poke = (request == PTRACE_PEEKTEXT
-			|| request == PTRACE_PEEKDATA
-			|| request == PTRACE_POKETEXT
-			|| request == PTRACE_POKEDATA);
 	ret = -ESRCH;
 	read_lock(&tasklist_lock);
 	{
 		child = find_task_by_pid(pid);
-		if (child) {
-			if (peek_or_poke)
-				child = find_thread_for_addr(child, addr);
+		if (child)
 			get_task_struct(child);
-		}
 	}
 	read_unlock(&tasklist_lock);
 	if (!child)
@@ -1451,6 +1460,8 @@
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
+		if (ret == 0)
+			ptrace_attach_sync_user_rbs(child);
 		goto out_tsk;
 	}
 
Index: include/asm-ia64/ptrace.h
===================================================================
--- e2923a24b6b2cd3cd5b1af3ef477da2922ba8fb2/include/asm-ia64/ptrace.h  (mode:100644)
+++ uncommitted/include/asm-ia64/ptrace.h  (mode:100644)
@@ -2,7 +2,7 @@
 #define _ASM_IA64_PTRACE_H
 
 /*
- * Copyright (C) 1998-2004 Hewlett-Packard Co
+ * Copyright (C) 1998-2005 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *	Stephane Eranian <eranian@hpl.hp.com>
  * Copyright (C) 2003 Intel Co
@@ -271,6 +271,11 @@
   struct task_struct;			/* forward decl */
   struct unw_frame_info;		/* forward decl */
 
+  struct ia64_flush_rbs_retval {
+	  unsigned long bspstore;
+	  unsigned long rnat;
+  };
+
   extern void show_regs (struct pt_regs *);
   extern void ia64_do_show_stack (struct unw_frame_info *, void *);
   extern unsigned long ia64_get_user_rbs_end (struct task_struct *, struct pt_regs *,
@@ -283,6 +288,12 @@
   extern void ia64_sync_fph (struct task_struct *);
   extern long ia64_sync_user_rbs (struct task_struct *, struct switch_stack *,
 				  unsigned long, unsigned long);
+  /*
+   * Flush the register-backing store to memory and return the
+   * resulting AR.BSPSTORE and AR.RNAT.
+   */
+  extern struct ia64_flush_rbs_retval ia64_flush_rbs (void);
+
 
   /* get nat bits for scratch registers such that bit N==1 iff scratch register rN is a NaT */
   extern unsigned long ia64_get_scratch_nat_bits (struct pt_regs *pt, unsigned long scratch_unat);
@@ -292,6 +303,10 @@
   extern void ia64_increment_ip (struct pt_regs *pt);
   extern void ia64_decrement_ip (struct pt_regs *pt);
 
+  struct siginfo;
+  extern void arch_ptrace_stop (struct task_struct *, struct siginfo *);
+# define HAVE_ARCH_PTRACE_STOP
+
 #endif /* !__KERNEL__ */
 
 /* pt_all_user_regs is used for PTRACE_GETREGS PTRACE_SETREGS */
Index: include/linux/ptrace.h
===================================================================
--- e2923a24b6b2cd3cd5b1af3ef477da2922ba8fb2/include/linux/ptrace.h  (mode:100644)
+++ uncommitted/include/linux/ptrace.h  (mode:100644)
@@ -117,6 +117,10 @@
 #define force_successful_syscall_return() do { } while (0)
 #endif
 
+#ifndef HAVE_ARCH_PTRACE_STOP
+#define arch_ptrace_stop(info)		do { } while (0)
+#endif
+
 #endif
 
 #endif
Index: kernel/signal.c
===================================================================
--- e2923a24b6b2cd3cd5b1af3ef477da2922ba8fb2/kernel/signal.c  (mode:100644)
+++ uncommitted/kernel/signal.c  (mode:100644)
@@ -1593,10 +1593,12 @@
 
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
+	spin_unlock_irq(&current->sighand->siglock);
+
+	arch_ptrace_stop(current, info);
 
 	/* Let the debugger run.  */
 	set_current_state(TASK_TRACED);
-	spin_unlock_irq(&current->sighand->siglock);
 	read_lock(&tasklist_lock);
 	if (likely(current->ptrace & PT_PTRACED) &&
 	    likely(current->parent != current->real_parent ||
