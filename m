Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293716AbSCAUYS>; Fri, 1 Mar 2002 15:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293714AbSCAUYJ>; Fri, 1 Mar 2002 15:24:09 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:3846 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293723AbSCAUXi>; Fri, 1 Mar 2002 15:23:38 -0500
Date: Fri, 1 Mar 2002 21:23:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] abstracting thread_info access
Message-ID: <Pine.LNX.4.21.0203012110160.32042-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces get_thread_info to access thread_info from the
task_structure. It also makes clear now that we actually split the
task_struct and the stack and leaves it up to the arch where to put
thread_info.
This patch depends on the previous task_struct patch.

bye, Roman

diff -Nur -X /opt/home/roman/nodiff linux-task_struct/arch/i386/kernel/process.c linux-thread_info/arch/i386/kernel/process.c
--- linux-task_struct/arch/i386/kernel/process.c	Mon Feb 25 00:14:54 2002
+++ linux-thread_info/arch/i386/kernel/process.c	Fri Mar  1 20:13:36 2002
@@ -591,7 +591,7 @@
 {
 	struct pt_regs * childregs;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->stack)) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -817,7 +817,7 @@
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)p->stack;
 	esp = p->thread.esp;
 	if (!stack_page || esp < stack_page || esp > 8188+stack_page)
 		return 0;
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/arch/i386/kernel/smpboot.c linux-thread_info/arch/i386/kernel/smpboot.c
--- linux-task_struct/arch/i386/kernel/smpboot.c	Mon Feb 25 00:14:55 2002
+++ linux-thread_info/arch/i386/kernel/smpboot.c	Fri Mar  1 20:13:36 2002
@@ -845,7 +845,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->stack);
 
 	/*
 	 * This grunge runs the startup process for
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/arch/i386/kernel/traps.c linux-thread_info/arch/i386/kernel/traps.c
--- linux-task_struct/arch/i386/kernel/traps.c	Fri Mar  1 19:59:29 2002
+++ linux-thread_info/arch/i386/kernel/traps.c	Fri Mar  1 20:13:36 2002
@@ -158,7 +158,7 @@
 	unsigned long esp = tsk->thread.esp;
 
 	/* User space on another CPU? */
-	if ((esp ^ (unsigned long)tsk->thread_info) & (PAGE_MASK<<1))
+	if ((esp ^ (unsigned long)tsk->stack) & (PAGE_MASK<<1))
 		return;
 	show_trace((unsigned long *)esp);
 }
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/fs/proc/array.c linux-thread_info/fs/proc/array.c
--- linux-task_struct/fs/proc/array.c	Mon Feb 25 00:11:06 2002
+++ linux-thread_info/fs/proc/array.c	Fri Mar  1 20:13:36 2002
@@ -387,7 +387,7 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->thread_info->cpu);
+		get_thread_info(task)->cpu);
 	if(mm)
 		mmput(mm);
 	return res;
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-alpha/thread_info.h linux-thread_info/include/asm-alpha/thread_info.h
--- linux-task_struct/include/asm-alpha/thread_info.h	Mon Feb 25 00:11:47 2002
+++ linux-thread_info/include/asm-alpha/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -45,11 +45,11 @@
 
 /* Thread information allocation.  */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() \
+#define alloc_thread_stack() \
   ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
+#define free_thread_stack(stk) free_pages((unsigned long) (stk), 1)
+
+#define get_thread_info(tsk) ((struct thread_info *)((tsk)->stack))
 
 #endif /* __ASSEMBLY__ */
 
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-i386/processor.h linux-thread_info/include/asm-i386/processor.h
--- linux-task_struct/include/asm-i386/processor.h	Mon Feb 25 00:11:41 2002
+++ linux-thread_info/include/asm-i386/processor.h	Fri Mar  1 20:13:36 2002
@@ -435,8 +435,8 @@
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
+#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->stack))[1019])
+#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->stack))[1022])
 
 struct microcode {
 	unsigned int hdrver;
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-i386/thread_info.h linux-thread_info/include/asm-i386/thread_info.h
--- linux-task_struct/include/asm-i386/thread_info.h	Mon Feb 11 19:44:47 2002
+++ linux-thread_info/include/asm-i386/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -73,10 +73,10 @@
 
 /* thread information allocation */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
+#define alloc_thread_stack()	((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk)	free_pages((unsigned long) (stk), 1)
+
+#define get_thread_info(tsk)	((struct thread_info *)((tsk)->stack))
 
 #else /* !__ASSEMBLY__ */
 
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-ppc/thread_info.h linux-thread_info/include/asm-ppc/thread_info.h
--- linux-task_struct/include/asm-ppc/thread_info.h	Mon Feb 25 00:11:58 2002
+++ linux-thread_info/include/asm-ppc/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -47,11 +47,12 @@
 }
 
 /* thread information allocation */
-#define alloc_thread_info() ((struct thread_info *) \
+#define alloc_thread_stack()	((struct thread_info *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
+#define free_thread_stack(stk)	free_pages((unsigned long) (stk), 1)
+
+#define get_thread_info(tsk)	((struct thread_info *)((tsk)->stack))
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-ppc64/thread_info.h linux-thread_info/include/asm-ppc64/thread_info.h
--- linux-task_struct/include/asm-ppc64/thread_info.h	Mon Feb 25 00:12:24 2002
+++ linux-thread_info/include/asm-ppc64/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -44,11 +44,11 @@
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_ORDER)
 #define THREAD_SHIFT		(PAGE_SHIFT + THREAD_ORDER)
 
-#define alloc_thread_info() ((struct thread_info *) \
+#define alloc_thread_stack()	((struct thread_info *) \
 				__get_free_pages(GFP_KERNEL, THREAD_ORDER))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), THREAD_ORDER)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
+#define free_thread_stack(stk)	free_pages((unsigned long) (stk), THREAD_ORDER)
+
+#define get_thread_info(tsk)	((struct thread_info *)((tsk)->stack))
 
 #if THREAD_SIZE != (4*PAGE_SIZE)
 #error update vmlinux.lds and current_thread_info to match
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-sparc64/thread_info.h linux-thread_info/include/asm-sparc64/thread_info.h
--- linux-task_struct/include/asm-sparc64/thread_info.h	Mon Feb 11 19:45:03 2002
+++ linux-thread_info/include/asm-sparc64/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -129,12 +129,14 @@
 
 /* thread information allocation */
 #if PAGE_SHIFT == 13
-#define alloc_thread_info()   ((struct thread_info *)__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
+#define alloc_thread_stack()	((struct thread_info *)__get_free_pages(GFP_KERNEL, 1))
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk),1)
 #else /* PAGE_SHIFT == 13 */
-#define alloc_thread_info()   ((struct thread_info *)__get_free_pages(GFP_KERNEL, 0))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),0)
+#define alloc_thread_stack()	((struct thread_info *)__get_free_pages(GFP_KERNEL, 0))
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk),0)
 #endif /* PAGE_SHIFT == 13 */
+
+#define get_thread_info(tsk)	((struct thread_info *)((tsk)->stack))
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/asm-x86_64/thread_info.h linux-thread_info/include/asm-x86_64/thread_info.h
--- linux-task_struct/include/asm-x86_64/thread_info.h	Mon Feb 25 00:12:24 2002
+++ linux-thread_info/include/asm-x86_64/thread_info.h	Fri Mar  1 20:13:36 2002
@@ -71,10 +71,10 @@
 
 /* thread information allocation */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
+#define alloc_thread_stack()	((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk)	free_pages((unsigned long) (stk), 1)
+
+#define get_thread_info(tsk)	((struct thread_info *)((tsk)->stack))
 
 #else /* !__ASSEMBLY__ */
 
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/linux/init_task.h linux-thread_info/include/linux/init_task.h
--- linux-task_struct/include/linux/init_task.h	Mon Feb 25 00:11:37 2002
+++ linux-thread_info/include/linux/init_task.h	Fri Mar  1 20:13:36 2002
@@ -42,7 +42,7 @@
 #define INIT_TASK(tsk)	\
 {									\
     state:		0,						\
-    thread_info:	&init_thread_info,				\
+    stack:		&init_thread_info,				\
     flags:		0,						\
     lock_depth:		-1,						\
     prio:		120,						\
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/linux/sched.h linux-thread_info/include/linux/sched.h
--- linux-task_struct/include/linux/sched.h	Fri Mar  1 20:10:21 2002
+++ linux-thread_info/include/linux/sched.h	Fri Mar  1 20:13:37 2002
@@ -663,27 +663,27 @@
  */
 static inline void set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	set_ti_thread_flag(tsk->thread_info,flag);
+	set_ti_thread_flag(get_thread_info(tsk),flag);
 }
 
 static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	clear_ti_thread_flag(tsk->thread_info,flag);
+	clear_ti_thread_flag(get_thread_info(tsk),flag);
 }
 
 static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_set_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_set_ti_thread_flag(get_thread_info(tsk),flag);
 }
 
 static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_clear_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_clear_ti_thread_flag(get_thread_info(tsk),flag);
 }
 
 static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_ti_thread_flag(tsk->thread_info,flag);
+	return test_ti_thread_flag(get_thread_info(tsk),flag);
 }
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/include/linux/task_struct.h linux-thread_info/include/linux/task_struct.h
--- linux-task_struct/include/linux/task_struct.h	Fri Mar  1 20:16:24 2002
+++ linux-thread_info/include/linux/task_struct.h	Fri Mar  1 20:16:32 2002
@@ -17,7 +17,7 @@
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	struct thread_info *thread_info;
+	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
 	unsigned long ptrace;
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/kernel/exit.c linux-thread_info/kernel/exit.c
--- linux-task_struct/kernel/exit.c	Mon Feb 25 00:11:24 2002
+++ linux-thread_info/kernel/exit.c	Fri Mar  1 20:13:37 2002
@@ -514,7 +514,7 @@
 	if (current->leader)
 		disassociate_ctty(1);
 
-	put_exec_domain(tsk->thread_info->exec_domain);
+	put_exec_domain(get_thread_info(tsk)->exec_domain);
 	if (tsk->binfmt && tsk->binfmt->module)
 		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
 
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/kernel/fork.c linux-thread_info/kernel/fork.c
--- linux-task_struct/kernel/fork.c	Fri Mar  1 19:59:34 2002
+++ linux-thread_info/kernel/fork.c	Fri Mar  1 20:13:37 2002
@@ -96,21 +96,21 @@
 struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
-	struct thread_info *ti;
+	void *stack;
 
-	ti = alloc_thread_info();
-	if (!ti) return NULL;
+	stack = alloc_thread_stack();
+	if (!stack) return NULL;
 
 	tsk = kmem_cache_alloc(task_struct_cachep,GFP_ATOMIC);
 	if (!tsk) {
-		free_thread_info(ti);
+		free_thread_stack(stack);
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
-	tsk->thread_info = ti;
-	ti->task = tsk;
+	tsk->stack = stack;
+	*get_thread_info(tsk) = *get_thread_info(orig);
+	get_thread_info(tsk)->task = tsk;
 	atomic_set(&tsk->usage,1);
 
 	return tsk;
@@ -118,7 +118,7 @@
 
 void __put_task_struct(struct task_struct *tsk)
 {
-	free_thread_info(tsk->thread_info);
+	free_thread_stack(tsk->stack);
 	kmem_cache_free(task_struct_cachep,tsk);
 }
 
@@ -645,7 +645,7 @@
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 	
-	get_exec_domain(p->thread_info->exec_domain);
+	get_exec_domain(get_thread_info(p)->exec_domain);
 
 	if (p->binfmt && p->binfmt->module)
 		__MOD_INC_USE_COUNT(p->binfmt->module);
@@ -655,7 +655,7 @@
 	 * schedule_tail drops this_rq()->lock so we compensate with a count
 	 * of 1.  Also, we want to start with kernel preemption disabled.
 	 */
-	p->thread_info->preempt_count = 1;
+	get_thread_info(p)->preempt_count = 1;
 #endif
 	p->did_exec = 0;
 	p->swappable = 0;
@@ -812,7 +812,7 @@
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup:
-	put_exec_domain(p->thread_info->exec_domain);
+	put_exec_domain(get_thread_info(p)->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
 bad_fork_cleanup_count:
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/kernel/sched.c linux-thread_info/kernel/sched.c
--- linux-task_struct/kernel/sched.c	Fri Mar  1 19:59:34 2002
+++ linux-thread_info/kernel/sched.c	Fri Mar  1 20:13:37 2002
@@ -152,7 +152,7 @@
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
-#define task_rq(p)		cpu_rq((p)->thread_info->cpu)
+#define task_rq(p)		cpu_rq(get_thread_info(p)->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
@@ -263,8 +263,8 @@
 	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
 	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
 
-	if (!need_resched && !nrpolling && (p->thread_info->cpu != smp_processor_id()))
-		smp_send_reschedule(p->thread_info->cpu);
+	if (!need_resched && !nrpolling && (get_thread_info(p)->cpu != smp_processor_id()))
+		smp_send_reschedule(get_thread_info(p)->cpu);
 	preempt_enable();
 #else
 	set_tsk_need_resched(p);
@@ -365,7 +365,7 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	p->thread_info->cpu = smp_processor_id();
+	get_thread_info(p)->cpu = smp_processor_id();
 	activate_task(p, rq);
 
 	spin_unlock_irq(&rq->lock);
@@ -606,7 +606,7 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
-	next->thread_info->cpu = this_cpu;
+	get_thread_info(next)->cpu = this_cpu;
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
 	if (next->prio < current->prio)
@@ -1425,7 +1425,7 @@
 
 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->thread_info->cpu);
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(get_thread_info(idle)->cpu);
 	unsigned long flags;
 
 	__save_flags(flags);
@@ -1437,7 +1437,7 @@
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
-	idle->thread_info->cpu = cpu;
+	get_thread_info(idle)->cpu = cpu;
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
@@ -1541,7 +1541,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << p->thread_info->cpu)) {
+	if (new_mask & (1UL << get_thread_info(p)->cpu)) {
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -1623,16 +1623,16 @@
 		cpu_dest = __ffs(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
-		cpu_src = p->thread_info->cpu;
+		cpu_src = get_thread_info(p)->cpu;
 		rq_src = cpu_rq(cpu_src);
 
 		double_rq_lock(rq_src, rq_dest);
-		if (p->thread_info->cpu != cpu_src) {
+		if (get_thread_info(p)->cpu != cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
 			goto repeat;
 		}
 		if (rq_src == rq) {
-			p->thread_info->cpu = cpu_dest;
+			get_thread_info(p)->cpu = cpu_dest;
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);
diff -Nur -X /opt/home/roman/nodiff linux-task_struct/kernel/signal.c linux-thread_info/kernel/signal.c
--- linux-task_struct/kernel/signal.c	Mon Feb 25 00:11:25 2002
+++ linux-thread_info/kernel/signal.c	Fri Mar  1 20:13:37 2002
@@ -508,7 +508,7 @@
 	 * process of changing - but no harm is done by that
 	 * other than doing an extra (lightweight) IPI interrupt.
 	 */
-	if ((t->state == TASK_RUNNING) && (t->thread_info->cpu != smp_processor_id()))
+	if ((t->state == TASK_RUNNING) && (get_thread_info(t)->cpu != smp_processor_id()))
 		kick_if_running(t);
 #endif
 	if (t->state & TASK_INTERRUPTIBLE) {


