Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSHSMK4>; Mon, 19 Aug 2002 08:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318830AbSHSMK4>; Mon, 19 Aug 2002 08:10:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57240 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318859AbSHSMKu>;
	Mon, 19 Aug 2002 08:10:50 -0400
Date: Mon, 19 Aug 2002 14:16:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <Pine.LNX.4.44.0208191254220.11609-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch is the next step in the journey to get top-notch threading
support implemented under Linux.

every Linux kernel in existence, including 2.5.31, has a fundamentally
unscalable sys_exit() implementation, with an overhead that goes up if the
number of tasks in the system goes up. It does not matter whether those
tasks are doing any work - just sleeping indefinitely causes sys_exit()
overhead to go up.

200 tasks is typical for a relatively idle server system. 1000 tasks or
more is not uncommon during usual server load on a midrange server.  
There are servers that use 5000 tasks or more. It is not uncommon for
highly threaded code to use even more threads - client/server models are
often the easiest to implement by using a per-connection thread model.  
[Eg. vsftpd, one of the fastest and most secure FTP servers under Linux,
uses 2 (often 3) threads per client connection [which, for security reason
is implemented via inside per-client isolated processes].]

Some numbers to back this up, i've tested 2.5.31-BK-curr on a 525 MHz
PIII, it produces the following lat_proc fork+exit latencies:

  # of tasks in the system                200   1000    2000    4000
  ------------------------------------------------------------------
  ./lat_proc fork+exit (microseconds):  743.0  923.1  1153.4  1622.2

it can be seen that the fork()+exit() overhead more than doubles with
every 4000 tasks in the system.


for threaded applications the situation is even worse. A threading
benchmark that just tests the (linear) creation and exit of 100 thousand
threads using the old glibc libpthreads library, gives the following
results:

  # of tasks in the system                200   1000    2000    4000
  ------------------------------------------------------------------
  ./perf -s 100000 -t 1 -r 0 -T
  in seconds:                            17.8   37.3    61.1   108.0

  latency of single-thread create+exit
  in microseconds:                        178    373     611    1080

using the same test linked against new libpthreads:

  # of tasks in the system                200   1000    2000    4000
  ------------------------------------------------------------------
  ./perf -s 100000 -t 1 -r 0 -T
  in seconds:                             6.8   25.6    48.7    95.1

  latency of single-thread create+exit
  in microseconds:                         68    256     487     951

the same regression happens as in the old-pthreads case, but with a
(dramatically) lower baseline [which are due to the other optimizations].
With a couple of hundred threads created, the thread create+exit latency
becomes dominated by the hefty sys_exit() overhead.

all in one - sys_exit() is O(nr_tasks), and heavily so - even a reasonable
number of completely idle tasks increase the exit() overhead very visibly.


why is sys_exit() so expensive? The main overhead is in
forget_original_parent(), which must be called for every thread that
exits: the kernel has to find all children the exiting task has created
during its lifetime, and has to 'reparent' them to some other task. The
current implementation uses a for_each_task() over every task in the
system, and finds those tasks whose real parent is the now exiting task.  
This is a fundamental work of the kernel that cannot be optimized away -
the child/parent tree must always stay coherent.

but the for_each_task() iteration is excessive. There is a subtle reason
for it though: ptrace reparents debugged tasks to the debugging task,
which detaches the child from the original parent. Thus
forget_original_parent() has to search the whole tasklist, to make sure
even debugged tasks are properly reparented.

the attached patch (against BK-curr) reimplements this logic in a scalable
way: the pthreads code also maintains a global list of debugged tasks -
which list is usually empty in a normal system. It has at most a few tasks
- those one which are debugged currently. This list can be maintained very
cheaply, in a number of strategic places.

forget_original_parent() then searched the exiting task's ->children list,
plus the global ptrace list. In the usual 'task has no children and there
are no debugged tasks around' case this becomes as cheap as two
list_empty() tests!

now on to the performance results, on the same 525 MHz PIII box, lat_proc:

  # of tasks in the system                200     1000     2000     4000
  ----------------------------------------------------------------------
  ./lat_proc fork+exit (microseconds):  
                                        657.1    680.6    640.8    682.5

  (unpatched kernel results):          (743.0)  (923.1) (1153.4) (1622.2)

process creation latency is essentially constant, it's independent of the
number of tasks in the system. Even the baseline results got improved by
more than 10%. For the 4000 tasks case the speedup is more than 130%.

the speedup is even bigger for threaded applications using the old
pthreads code:

  # of tasks in the system                200    1000    2000    4000
  --------------------------------------------------------------------
  ./perf -s 100000 -t 1 -r 0 -T
  in seconds:                            12.6    12.8    11.9    11.9
  (unpatched results):                   (17.8) (37.3)  (61.1) (108.0)

  latency of single-thread create+exit
  in microseconds:                        126    128     119      119
  (unpatched kernel):                    (178)   (373)   (611)  (1080)

  improvement:                             41%    191%   413%     807%

ie. in the 4000 tasks case the improvement is almost 10-fold!

testing the new glibc libpthreads code shows dramatic improvements:

  # of tasks in the system                200   1000    2000    4000
  ------------------------------------------------------------------
  ./perf -s 100000 -t 1 -r 0 -T
  in seconds:                             1.7    1.9     1.9     1.9
  (unpatched results):                   (6.8) (25.6)  (48.7)  (95.1)

  latency of single-thread create+exit
  in microseconds:                         17     19      19      19
  (unpatched kernel):                     (68)  (256)   (487)   (951)


  improvement:                            300%  1247%   2463%   4900%

in the 200 tasks case the speedup is 4-fold, in the 4000 tasks case the
speedup is 50-fold (!). Thread create+destroy latency is a steady 19
usecs. This also enables the head-to-head comparison of old pthreads and
new libpthreads: new libpthreads is more than 6 times faster. This is what
i'd finally call good threading performance.

the hardest part of the patch was to make sure ptrace() semantics are
still correct. I believe i have managed to at least test the typical
workload: i've tested a complex mix of high-load strace situations,
threaded and unthreaded code as well, SMP and UP, so i'm reasonably
certain that it works for the kind of load i use on my systems. [ But
ptrace() is complex beyond belief, so i might as well have missed some of
the subtler items. ]

- the patch also includes another optimization to make bash's wait4() job
  easier as well: wait4() does not have to consider non-debugged
  CLONE_DETACHED tasks, it wont get any exit code from them, and those
  tasks can clean themselves up.

- the patch also cleans up the <linux/ptrace.h> includes, and moves the
  pthread specific declarations from mm.h to ptrace.h - most of the
  existing includes were bogus.

Comments?

	Ingo

--- linux/arch/i386/kernel/irq.c.orig	Mon Aug 19 12:10:27 2002
+++ linux/arch/i386/kernel/irq.c	Mon Aug 19 12:11:21 2002
@@ -18,7 +18,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
--- linux/arch/i386/kernel/i8259.c.orig	Mon Aug 19 12:11:00 2002
+++ linux/arch/i386/kernel/i8259.c	Mon Aug 19 12:11:05 2002
@@ -1,5 +1,4 @@
 #include <linux/config.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
--- linux/arch/i386/kernel/process.c.orig	Mon Aug 19 12:38:47 2002
+++ linux/arch/i386/kernel/process.c	Mon Aug 19 12:38:49 2002
@@ -23,7 +23,6 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/user.h>
--- linux/arch/i386/kernel/signal.c.orig	Mon Aug 19 12:38:56 2002
+++ linux/arch/i386/kernel/signal.c	Mon Aug 19 12:38:58 2002
@@ -15,7 +15,6 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
-#include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
--- linux/arch/i386/kernel/traps.c.orig	Mon Aug 19 12:39:05 2002
+++ linux/arch/i386/kernel/traps.c	Mon Aug 19 12:39:06 2002
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/ptrace.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/init.h>
--- linux/arch/i386/kernel/vm86.c.orig	Mon Aug 19 12:39:17 2002
+++ linux/arch/i386/kernel/vm86.c	Mon Aug 19 12:39:20 2002
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/string.h>
-#include <linux/ptrace.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
--- linux/include/linux/sched.h.orig	Mon Aug 19 11:57:00 2002
+++ linux/include/linux/sched.h	Mon Aug 19 11:57:06 2002
@@ -270,6 +270,7 @@
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
+	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
 	struct list_head local_pages;
--- linux/include/linux/mm.h.orig	Mon Aug 19 11:57:25 2002
+++ linux/include/linux/mm.h	Mon Aug 19 12:16:24 2002
@@ -354,12 +354,6 @@
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
-extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
-extern int ptrace_attach(struct task_struct *tsk);
-extern int ptrace_detach(struct task_struct *, unsigned int);
-extern void ptrace_disable(struct task_struct *);
-extern int ptrace_check_attach(struct task_struct *task, int kill);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
--- linux/include/linux/ptrace.h.orig	Mon Aug 19 12:08:30 2002
+++ linux/include/linux/ptrace.h	Mon Aug 19 12:37:12 2002
@@ -23,4 +23,28 @@
 
 #include <asm/ptrace.h>
 
+#ifdef __KERNEL__
+extern list_t ptrace_tasks;
+
+extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
+extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
+extern int ptrace_attach(struct task_struct *tsk);
+extern int ptrace_detach(struct task_struct *, unsigned int);
+extern void ptrace_disable(struct task_struct *);
+extern int ptrace_check_attach(struct task_struct *task, int kill);
+extern void __ptrace_link(struct task_struct *child, struct task_struct *new_parent);
+extern void __ptrace_unlink(struct task_struct *child);
+
+static inline void ptrace_link(struct task_struct *child, struct task_struct *new_parent)
+{
+	if (child->ptrace)
+		__ptrace_link(child, new_parent);
+}
+static inline void ptrace_unlink(struct task_struct *child)
+{
+	if (child->ptrace)
+		__ptrace_unlink(child);
+}
+#endif
+
 #endif
--- linux/include/linux/binfmts.h.orig	Mon Aug 19 12:19:45 2002
+++ linux/include/linux/binfmts.h	Mon Aug 19 12:20:30 2002
@@ -1,7 +1,6 @@
 #ifndef _LINUX_BINFMTS_H
 #define _LINUX_BINFMTS_H
 
-#include <linux/ptrace.h>
 #include <linux/capability.h>
 
 /*
--- linux/include/linux/elfcore.h.orig	Mon Aug 19 12:22:38 2002
+++ linux/include/linux/elfcore.h	Mon Aug 19 12:22:41 2002
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 #include <linux/signal.h>
 #include <linux/time.h>
-#include <linux/ptrace.h>
 #include <linux/user.h>
 
 struct elf_siginfo
--- linux/include/asm-i386/smp.h.orig	Mon Aug 19 12:12:27 2002
+++ linux/include/asm-i386/smp.h	Mon Aug 19 12:12:32 2002
@@ -7,7 +7,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/ptrace.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
--- linux/include/asm-i386/user.h.orig	Mon Aug 19 12:22:19 2002
+++ linux/include/asm-i386/user.h	Mon Aug 19 12:22:21 2002
@@ -2,7 +2,6 @@
 #define _I386_USER_H
 
 #include <asm/page.h>
-#include <linux/ptrace.h>
 /* Core file format: The core file is written in such a way that gdb
    can understand it and provide useful information to the user (under
    linux we use the 'trad-core' bfd).  There are quite a number of
--- linux/kernel/exit.c.orig	Mon Aug 19 11:45:38 2002
+++ linux/kernel/exit.c	Mon Aug 19 12:40:51 2002
@@ -18,6 +18,7 @@
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/ptrace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -65,6 +66,8 @@
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
+	if (p->ptrace || !list_empty(&p->ptrace_list))
+		BUG();
 	unhash_process(p);
 
 	release_thread(p);
@@ -177,6 +180,7 @@
 {
 	write_lock_irq(&tasklist_lock);
 
+	ptrace_unlink(current);
 	/* Reparent to init */
 	REMOVE_LINKS(current);
 	current->parent = child_reaper;
@@ -231,6 +235,22 @@
 	atomic_inc(&current->files->count);
 }
 
+static void reparent_thread(task_t *p, task_t *reaper, task_t *child_reaper)
+{
+	/* We dont want people slaying init */
+	p->exit_signal = SIGCHLD;
+	p->self_exec_id++;
+
+	/* Make sure we're not reparenting to ourselves */
+	if (p == reaper)
+		p->real_parent = child_reaper;
+	else
+		p->real_parent = reaper;
+
+	if (p->pdeath_signal)
+		send_sig(p->pdeath_signal, p, 0);
+}
+
 /*
  * When we die, we re-parent all our children.
  * Try to give them to another thread in our thread
@@ -239,7 +259,8 @@
  */
 static inline void forget_original_parent(struct task_struct * father)
 {
-	struct task_struct * p, *reaper;
+	struct task_struct *p, *reaper;
+	list_t *_p;
 
 	read_lock(&tasklist_lock);
 
@@ -254,20 +275,22 @@
 	if (reaper == father)
 		reaper = child_reaper;
 
-	for_each_task(p) {
-		if (p->real_parent == father) {
-			/* We dont want people slaying init */
-			p->exit_signal = SIGCHLD;
-			p->self_exec_id++;
-
-			/* Make sure we're not reparenting to ourselves */
-			if (p == reaper)
-				p->real_parent = child_reaper;
-			else
-				p->real_parent = reaper;
-
-			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
-		}
+	/*
+	 * There are only two places where our children can be:
+	 *
+	 * - in our child list
+	 * - in the global ptrace list
+	 *
+	 * Search them and reparent children.
+	 */
+	list_for_each(_p, &father->children) {
+		p = list_entry(_p,struct task_struct,sibling);
+		reparent_thread(p, reaper, child_reaper);
+	}
+	list_for_each(_p, &ptrace_tasks) {
+		p = list_entry(_p,struct task_struct,ptrace_list);
+		if (p->real_parent == father)
+			reparent_thread(p, reaper, child_reaper);
 	}
 	read_unlock(&tasklist_lock);
 }
@@ -485,11 +508,12 @@
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
 	while ((p = eldest_child(current))) {
+		ptrace_unlink(p);
 		list_del_init(&p->sibling);
 		p->ptrace = 0;
 
 		p->parent = p->real_parent;
-		list_add_tail(&p->sibling,&p->parent->children);
+		list_add_tail(&p->sibling, &p->parent->children);
 		if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
 			do_notify_parent(p, p->exit_signal);
 		/*
@@ -623,6 +647,12 @@
 				if (p->pgrp != -pid)
 					continue;
 			}
+			/*
+			 * Do not consider detached threads that are
+			 * not ptraced:
+			 */
+			if (p->exit_signal == -1 && !p->ptrace)
+				continue;
 			/* Wait for all children (clone and not) if __WALL is set;
 			 * otherwise, wait for clone children *only* if __WCLONE is
 			 * set; otherwise, wait for non-clone children *only*.  (Note:
@@ -667,7 +697,7 @@
 				if (retval)
 					goto end_wait4; 
 				retval = p->pid;
-				if (p->real_parent != p->parent) {
+				if (p->real_parent != p->parent || p->ptrace) {
 					write_lock_irq(&tasklist_lock);
 					remove_parent(p);
 					p->parent = p->real_parent;
--- linux/kernel/fork.c.orig	Mon Aug 19 11:53:22 2002
+++ linux/kernel/fork.c	Mon Aug 19 12:20:54 2002
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/futex.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -808,6 +809,7 @@
 	 */
 	p->tgid = p->pid;
 	INIT_LIST_HEAD(&p->thread_group);
+	INIT_LIST_HEAD(&p->ptrace_list);
 
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
@@ -827,6 +829,7 @@
 	}
 
 	SET_LINKS(p);
+	ptrace_link(p, p->parent);
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
--- linux/kernel/ptrace.c.orig	Mon Aug 19 11:58:06 2002
+++ linux/kernel/ptrace.c	Mon Aug 19 13:29:53 2002
@@ -13,11 +13,56 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
 /*
+ * This is the global list of ptraced threads.
+ *
+ * Any code that wants to iterate over its ->children list has to
+ * search this list as well, because sys_ptrace() temporarily reparents
+ * tasks to the debugging task.
+ */
+LIST_HEAD(ptrace_tasks);
+
+/*
+ * ptrace a task: make the debugger its new parent and
+ * move it to the ptrace list.
+ *
+ * Must be called with the tasklist lock write-held.
+ */
+void __ptrace_link(task_t *child, task_t *new_parent)
+{
+	if (!list_empty(&child->ptrace_list))
+		BUG();
+	list_add(&child->ptrace_list, &ptrace_tasks);
+	REMOVE_LINKS(child);
+	child->parent = new_parent;
+	SET_LINKS(child);
+}
+ 
+/*
+ * unptrace a task: move it back to its original parent and
+ * remove it from the ptrace list.
+ *
+ * Must be called with the tasklist lock write-held.
+ */
+void __ptrace_unlink(task_t *child)
+{
+	if (!child->ptrace)
+		BUG();
+	child->ptrace = 0;
+	if (list_empty(&child->ptrace_list))
+		return;
+	list_del_init(&child->ptrace_list);
+	REMOVE_LINKS(child);
+	child->parent = child->real_parent;
+	SET_LINKS(child);
+}
+
+/*
  * Check that we have indeed attached to the thing..
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
@@ -75,11 +120,7 @@
 	task_unlock(task);
 
 	write_lock_irq(&tasklist_lock);
-	if (task->parent != current) {
-		REMOVE_LINKS(task);
-		task->parent = current;
-		SET_LINKS(task);
-	}
+	__ptrace_link(task, current);
 	write_unlock_irq(&tasklist_lock);
 
 	send_sig(SIGSTOP, task, 1);
@@ -99,16 +140,15 @@
 	ptrace_disable(child);
 
 	/* .. re-parent .. */
-	child->ptrace = 0;
 	child->exit_code = data;
+
 	write_lock_irq(&tasklist_lock);
-	REMOVE_LINKS(child);
-	child->parent = child->real_parent;
-	SET_LINKS(child);
+	__ptrace_unlink(child);
+	/* .. and wake it up. */
+	if (child->state != TASK_ZOMBIE)
+		wake_up_process(child);
 	write_unlock_irq(&tasklist_lock);
 
-	/* .. and wake it up. */
-	wake_up_process(child);
 	return 0;
 }
 

