Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318925AbSHSQK4>; Mon, 19 Aug 2002 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318926AbSHSQK4>; Mon, 19 Aug 2002 12:10:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10160 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318925AbSHSQKu>;
	Mon, 19 Aug 2002 12:10:50 -0400
Date: Mon, 19 Aug 2002 18:15:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-B4
In-Reply-To: <Pine.LNX.4.44.0208191254220.11609-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208191810480.28923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch updates a number of items:

 - adds cleanups suggested by Christoph Hellwig: needed unlikely()  
   statements, a superfluous #define and line length problems.

 - splits up the global ptrace list into per-task ptrace lists. This was 
   pretty straightforward, and this makes the worst-case exit() latency
   O(nr_children).

the per-task ptrace lists unearthed a bug that the previous code did not
take care of: tasks on the ptrace list have to be correctly reparented as
well. This patch passed my stresstests as well.

	Ingo

--- linux/arch/i386/kernel/irq.c.orig	Mon Aug 19 12:10:27 2002
+++ linux/arch/i386/kernel/irq.c	Mon Aug 19 18:12:27 2002
@@ -18,7 +18,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
--- linux/arch/i386/kernel/i8259.c.orig	Mon Aug 19 12:11:00 2002
+++ linux/arch/i386/kernel/i8259.c	Mon Aug 19 18:12:27 2002
@@ -1,5 +1,4 @@
 #include <linux/config.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
--- linux/arch/i386/kernel/process.c.orig	Mon Aug 19 12:38:47 2002
+++ linux/arch/i386/kernel/process.c	Mon Aug 19 18:12:27 2002
@@ -23,7 +23,6 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/user.h>
--- linux/arch/i386/kernel/signal.c.orig	Mon Aug 19 12:38:56 2002
+++ linux/arch/i386/kernel/signal.c	Mon Aug 19 18:12:27 2002
@@ -15,7 +15,6 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
-#include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
--- linux/arch/i386/kernel/traps.c.orig	Mon Aug 19 12:39:05 2002
+++ linux/arch/i386/kernel/traps.c	Mon Aug 19 18:12:27 2002
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/ptrace.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/init.h>
--- linux/arch/i386/kernel/vm86.c.orig	Mon Aug 19 12:39:17 2002
+++ linux/arch/i386/kernel/vm86.c	Mon Aug 19 18:12:27 2002
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/string.h>
-#include <linux/ptrace.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
--- linux/include/linux/sched.h.orig	Mon Aug 19 11:57:00 2002
+++ linux/include/linux/sched.h	Mon Aug 19 18:12:27 2002
@@ -270,6 +270,8 @@
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
+	struct list_head ptrace_children;
+	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
 	struct list_head local_pages;
--- linux/include/linux/mm.h.orig	Mon Aug 19 11:57:25 2002
+++ linux/include/linux/mm.h	Mon Aug 19 18:12:27 2002
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
+++ linux/include/linux/ptrace.h	Mon Aug 19 18:12:27 2002
@@ -3,6 +3,8 @@
 /* ptrace.h */
 /* structs and defines to help the user use the ptrace system call. */
 
+#include <linux/compiler.h>
+
 /* has the defines to get at the registers. */
 
 #define PTRACE_TRACEME		   0
@@ -22,5 +24,27 @@
 #define PTRACE_SYSCALL		  24
 
 #include <asm/ptrace.h>
+
+extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
+extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
+extern int ptrace_attach(struct task_struct *tsk);
+extern int ptrace_detach(struct task_struct *, unsigned int);
+extern void ptrace_disable(struct task_struct *);
+extern int ptrace_check_attach(struct task_struct *task, int kill);
+extern void __ptrace_link(struct task_struct *child,
+				struct task_struct *new_parent);
+extern void __ptrace_unlink(struct task_struct *child);
+
+static inline void ptrace_link(struct task_struct *child,
+				struct task_struct *new_parent)
+{
+	if (unlikely(child->ptrace))
+		__ptrace_link(child, new_parent);
+}
+static inline void ptrace_unlink(struct task_struct *child)
+{
+	if (unlikely(child->ptrace))
+		__ptrace_unlink(child);
+}
 
 #endif
--- linux/include/linux/binfmts.h.orig	Mon Aug 19 12:19:45 2002
+++ linux/include/linux/binfmts.h	Mon Aug 19 18:12:27 2002
@@ -1,7 +1,6 @@
 #ifndef _LINUX_BINFMTS_H
 #define _LINUX_BINFMTS_H
 
-#include <linux/ptrace.h>
 #include <linux/capability.h>
 
 /*
--- linux/include/linux/elfcore.h.orig	Mon Aug 19 12:22:38 2002
+++ linux/include/linux/elfcore.h	Mon Aug 19 18:12:27 2002
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 #include <linux/signal.h>
 #include <linux/time.h>
-#include <linux/ptrace.h>
 #include <linux/user.h>
 
 struct elf_siginfo
--- linux/include/linux/init_task.h.orig	Mon Aug 19 17:39:30 2002
+++ linux/include/linux/init_task.h	Mon Aug 19 18:12:27 2002
@@ -54,6 +54,8 @@
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
 	.time_slice	= HZ,						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
+	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
+	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
 	.real_parent	= &tsk,						\
 	.parent		= &tsk,						\
 	.children	= LIST_HEAD_INIT(tsk.children),			\
--- linux/include/asm-i386/smp.h.orig	Mon Aug 19 12:12:27 2002
+++ linux/include/asm-i386/smp.h	Mon Aug 19 18:12:27 2002
@@ -7,7 +7,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/ptrace.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
--- linux/include/asm-i386/user.h.orig	Mon Aug 19 12:22:19 2002
+++ linux/include/asm-i386/user.h	Mon Aug 19 18:12:27 2002
@@ -2,7 +2,6 @@
 #define _I386_USER_H
 
 #include <asm/page.h>
-#include <linux/ptrace.h>
 /* Core file format: The core file is written in such a way that gdb
    can understand it and provide useful information to the user (under
    linux we use the 'trad-core' bfd).  There are quite a number of
--- linux/kernel/exit.c.orig	Mon Aug 19 11:45:38 2002
+++ linux/kernel/exit.c	Mon Aug 19 18:12:27 2002
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
+	BUG_ON(p->ptrace || !list_empty(&p->ptrace_list) ||
+					!list_empty(&p->ptrace_children));
 	unhash_process(p);
 
 	release_thread(p);
@@ -177,6 +180,7 @@
 {
 	write_lock_irq(&tasklist_lock);
 
+	ptrace_unlink(current);
 	/* Reparent to init */
 	REMOVE_LINKS(current);
 	current->parent = child_reaper;
@@ -231,45 +235,20 @@
 	atomic_inc(&current->files->count);
 }
 
-/*
- * When we die, we re-parent all our children.
- * Try to give them to another thread in our thread
- * group, and if no such member exists, give it to
- * the global child reaper process (ie "init")
- */
-static inline void forget_original_parent(struct task_struct * father)
+static void reparent_thread(task_t *p, task_t *reaper, task_t *child_reaper)
 {
-	struct task_struct * p, *reaper;
-
-	read_lock(&tasklist_lock);
+	/* We dont want people slaying init */
+	p->exit_signal = SIGCHLD;
+	p->self_exec_id++;
+
+	/* Make sure we're not reparenting to ourselves */
+	if (p == reaper)
+		p->real_parent = child_reaper;
+	else
+		p->real_parent = reaper;
 
-	/* Next in our thread group, if they're not already exiting */
-	reaper = father;
-	do {
-		reaper = next_thread(reaper);
-		if (!(reaper->flags & PF_EXITING))
-			break;
-	} while (reaper != father);
-
-	if (reaper == father)
-		reaper = child_reaper;
-
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
-	}
-	read_unlock(&tasklist_lock);
+	if (p->pdeath_signal)
+		send_sig(p->pdeath_signal, p, 0);
 }
 
 static inline void close_files(struct files_struct * files)
@@ -420,12 +399,85 @@
 }
 
 /*
+ * When we die, we re-parent all our children.
+ * Try to give them to another thread in our thread
+ * group, and if no such member exists, give it to
+ * the global child reaper process (ie "init")
+ */
+static inline void forget_original_parent(struct task_struct * father)
+{
+	struct task_struct *p, *reaper;
+	list_t *_p;
+
+	read_lock(&tasklist_lock);
+
+	/* Next in our thread group, if they're not already exiting */
+	reaper = father;
+	do {
+		reaper = next_thread(reaper);
+		if (!(reaper->flags & PF_EXITING))
+			break;
+	} while (reaper != father);
+
+	if (reaper == father)
+		reaper = child_reaper;
+
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
+	list_for_each(_p, &father->ptrace_children) {
+		p = list_entry(_p,struct task_struct,ptrace_list);
+		reparent_thread(p, reaper, child_reaper);
+	}
+	read_unlock(&tasklist_lock);
+}
+
+static inline void zap_thread(task_t *p, task_t *father)
+{
+	ptrace_unlink(p);
+	list_del_init(&p->sibling);
+	p->ptrace = 0;
+
+	p->parent = p->real_parent;
+	list_add_tail(&p->sibling, &p->parent->children);
+	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
+		do_notify_parent(p, p->exit_signal);
+	/*
+	 * process group orphan check
+	 * Case ii: Our child is in a different pgrp
+	 * than we are, and it was the only connection
+	 * outside, so the child pgrp is now orphaned.
+	 */
+	if ((p->pgrp != current->pgrp) &&
+	    (p->session == current->session)) {
+		int pgrp = p->pgrp;
+
+		write_unlock_irq(&tasklist_lock);
+		if (is_orphaned_pgrp(pgrp) && has_stopped_jobs(pgrp)) {
+			kill_pg(pgrp,SIGHUP,1);
+			kill_pg(pgrp,SIGCONT,1);
+		}
+		write_lock_irq(&tasklist_lock);
+	}
+}
+
+/*
  * Send signals to all our closest relatives so that they know
  * to properly mourn us..
  */
 static void exit_notify(void)
 {
-	struct task_struct * p, *t;
+	struct task_struct *t;
+	list_t *_p, *_n;
 
 	forget_original_parent(current);
 	/*
@@ -484,33 +536,20 @@
 	current->state = TASK_ZOMBIE;
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
-	while ((p = eldest_child(current))) {
-		list_del_init(&p->sibling);
-		p->ptrace = 0;
-
-		p->parent = p->real_parent;
-		list_add_tail(&p->sibling,&p->parent->children);
-		if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
-			do_notify_parent(p, p->exit_signal);
-		/*
-		 * process group orphan check
-		 * Case ii: Our child is in a different pgrp
-		 * than we are, and it was the only connection
-		 * outside, so the child pgrp is now orphaned.
-		 */
-		if ((p->pgrp != current->pgrp) &&
-		    (p->session == current->session)) {
-			int pgrp = p->pgrp;
-
-			write_unlock_irq(&tasklist_lock);
-			if (is_orphaned_pgrp(pgrp) && has_stopped_jobs(pgrp)) {
-				kill_pg(pgrp,SIGHUP,1);
-				kill_pg(pgrp,SIGCONT,1);
-			}
-			write_lock_irq(&tasklist_lock);
-		}
-	}
 
+zap_again:
+	list_for_each_safe(_p, _n, &current->children)
+		zap_thread(list_entry(_p,struct task_struct,sibling), current);
+	list_for_each_safe(_p, _n, &current->ptrace_children)
+		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current);
+	/*
+	 * reparent_thread might drop the tasklist lock, thus we could
+	 * have new children queued back from the ptrace list into the
+	 * child list:
+	 */
+	if (unlikely(!list_empty(&current->children) ||
+			!list_empty(&current->ptrace_children)))
+		goto zap_again;
 	/*
 	 * No need to unlock IRQs, we'll schedule() immediately
 	 * anyway. In the preemption case this also makes it
@@ -623,6 +662,12 @@
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
@@ -667,7 +712,7 @@
 				if (retval)
 					goto end_wait4; 
 				retval = p->pid;
-				if (p->real_parent != p->parent) {
+				if (p->real_parent != p->parent || p->ptrace) {
 					write_lock_irq(&tasklist_lock);
 					remove_parent(p);
 					p->parent = p->real_parent;
--- linux/kernel/fork.c.orig	Mon Aug 19 11:53:22 2002
+++ linux/kernel/fork.c	Mon Aug 19 18:12:27 2002
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/futex.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -808,6 +809,8 @@
 	 */
 	p->tgid = p->pid;
 	INIT_LIST_HEAD(&p->thread_group);
+	INIT_LIST_HEAD(&p->ptrace_children);
+	INIT_LIST_HEAD(&p->ptrace_list);
 
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
@@ -827,6 +830,7 @@
 	}
 
 	SET_LINKS(p);
+	ptrace_link(p, p->parent);
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
--- linux/kernel/ptrace.c.orig	Mon Aug 19 11:58:06 2002
+++ linux/kernel/ptrace.c	Mon Aug 19 18:12:27 2002
@@ -13,11 +13,49 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
 /*
+ * ptrace a task: make the debugger its new parent and
+ * move it to the ptrace list.
+ *
+ * Must be called with the tasklist lock write-held.
+ */
+void __ptrace_link(task_t *child, task_t *new_parent)
+{
+	if (!list_empty(&child->ptrace_list))
+		BUG();
+	if (child->parent == new_parent)
+		BUG();
+	list_add(&child->ptrace_list, &child->parent->ptrace_children);
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
@@ -75,11 +113,7 @@
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
@@ -99,16 +133,15 @@
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
 

