Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282986AbRLDCGH>; Mon, 3 Dec 2001 21:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRLDCEu>; Mon, 3 Dec 2001 21:04:50 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:11788 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283071AbRLDCDF>; Mon, 3 Dec 2001 21:03:05 -0500
Date: Mon, 3 Dec 2001 18:13:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] task_struct + kernel stack colouring ...
Message-ID: <Pine.LNX.4.40.0112031248260.1381-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implement task_struct plus kernel stack colouring for the x86
CPU family, and it can be easily adapted for other architectures.
The slab allocator for task_struct's ( Manfred ) is cacheline aligned and
gives us a free colouring w/out any other intervention.
The kernel stack frame jittering is done inside arch/??/kernel/process.c
and right now uses 8 colours ( STACK_COLOUR_BITS == 3 ).
The task_struct pointer is kept at the stack base for a fast seek.
The patch is briefly described here :

http://www.xmailserver.org/linux-patches/misc.html#TskStackCol



- Davide



[diffstat]
arch/i386/kernel/entry.S     |    7 ++---
arch/i386/kernel/head.S      |    2 -
arch/i386/kernel/init_task.c |   14 ++++++++--
arch/i386/kernel/irq.c       |    2 -
arch/i386/kernel/process.c   |   58 +++++++++++++++++++++++++++++++++++++++++--
arch/i386/kernel/smpboot.c   |    2 -
arch/i386/kernel/traps.c     |    2 -
arch/i386/lib/getuser.S      |    3 ++
include/asm-i386/current.h   |    6 ++--
include/asm-i386/hw_irq.h    |    3 +-
include/asm-i386/processor.h |   21 ++++++++++-----
include/linux/sched.h        |   16 ++++++++++-
init/main.c                  |    6 ++++
kernel/ksyms.c               |    2 -
14 files changed, 118 insertions, 26 deletions



diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/entry.S linux-2.5.0.sstc/arch/i386/kernel/entry.S
--- linux-2.5.0.vanilla/arch/i386/kernel/entry.S	Fri Nov  2 17:18:49 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/entry.S	Sun Dec  2 16:34:15 2001
@@ -130,7 +130,8 @@

 #define GET_CURRENT(reg) \
 	movl $-8192, reg; \
-	andl %esp, reg
+	andl %esp, reg;	\
+	movl (reg), reg;

 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
@@ -144,7 +145,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -165,7 +166,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/head.S linux-2.5.0.sstc/arch/i386/kernel/head.S
--- linux-2.5.0.vanilla/arch/i386/kernel/head.S	Wed Jun 20 11:00:53 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/head.S	Sun Dec  2 18:17:15 2001
@@ -320,7 +320,7 @@
 	ret

 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_task_union)+8192
+	.long SYMBOL_NAME(init_ts)+8192
 	.long __KERNEL_DS

 /* This is the default interrupt "handler" :-) */
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/init_task.c linux-2.5.0.sstc/arch/i386/kernel/init_task.c
--- linux-2.5.0.vanilla/arch/i386/kernel/init_task.c	Mon Sep 17 15:29:09 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/init_task.c	Sun Dec  2 21:49:14 2001
@@ -18,9 +18,17 @@
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
-union task_union init_task_union
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_TASK(init_task_union.task) };
+struct init_task_struct init_ts __attribute__((__section__(".data.init_task"))) =
+{
+	stack:	{(unsigned long) &init_ts.ftsk.task, 0, },
+	ftsk: {
+		task:	INIT_TASK(init_ts.ftsk.task),
+		count:	ATOMIC_INIT(1),
+		stack:	(unsigned long) init_ts.stack,
+		stack_top:	(unsigned long) init_ts.stack + INIT_TASK_SIZE
+	}
+};
+

 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/irq.c linux-2.5.0.sstc/arch/i386/kernel/irq.c
--- linux-2.5.0.vanilla/arch/i386/kernel/irq.c	Thu Oct 25 13:53:46 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/irq.c	Sun Dec  2 17:50:26 2001
@@ -223,7 +223,7 @@
 			continue;
 		}
 		esp &= ~(THREAD_SIZE-1);
-		esp += sizeof(struct task_struct);
+		esp += sizeof(long);
 		show_stack((void*)esp);
  	}
 	printk("\nCPU %d:",cpu);
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/process.c linux-2.5.0.sstc/arch/i386/kernel/process.c
--- linux-2.5.0.vanilla/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/process.c	Sun Dec  2 21:50:44 2001
@@ -575,18 +575,27 @@
 #define savesegment(seg,value) \
 	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))

+#define STACK_COLOUR_BITS	3
+#define STACK_COLOUR_MASK	((1 << STACK_COLOUR_BITS) - 1)
+#define STACK_SHIFT_BITS	(PAGE_SHIFT + 1)
+
+static inline unsigned long get_stack_jitter(struct task_struct *p)
+{
+	return ((TSK_TO_KSTACK(p) >> STACK_SHIFT_BITS) & STACK_COLOUR_MASK) << L1_CACHE_SHIFT;
+}
+
 int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;

-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + TSK_TO_KSTACK(p) - get_stack_jitter(p))) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;

-	p->thread.esp = (unsigned long) childregs;
+	p->thread.esp = TSK_KSTACK_TOP(p) = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);

 	p->thread.eip = (unsigned long) ret_from_fork;
@@ -821,3 +830,48 @@
 }
 #undef last_sched
 #undef first_sched
+
+
+/*
+ * this part should be moved in a system independent section.
+ */
+static kmem_cache_t * tsk_cache;
+
+void __init init_tsk_allocator(void)
+{
+	tsk_cache = kmem_cache_create("task_struct_cache",
+								  sizeof(struct full_task_struct),
+								  0,
+								  SLAB_HWCACHE_ALIGN,
+								  NULL, NULL);
+	if (!tsk_cache)
+		panic("Cannot create task struct cache");
+
+}
+
+struct task_struct *alloc_task_struct(void)
+{
+	struct full_task_struct *f = (struct full_task_struct *) kmem_cache_alloc(tsk_cache, GFP_KERNEL);
+
+	if (!f)
+		return NULL;
+	f->stack = __get_free_pages(GFP_KERNEL, 1);
+	if (!f->stack) {
+		kmem_cache_free(tsk_cache, f);
+		return NULL;
+	}
+	atomic_set(&f->count, 1);
+	*((struct task_struct **) f->stack) = (struct task_struct *) f;
+	return (struct task_struct *) f;
+}
+
+void free_task_struct(struct task_struct *p)
+{
+	struct full_task_struct *f = (struct full_task_struct *) p;
+
+	if (atomic_dec_and_test(&f->count)) {
+		free_pages(f->stack, 1);
+		kmem_cache_free(tsk_cache, f);
+	}
+}
+
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/smpboot.c linux-2.5.0.sstc/arch/i386/kernel/smpboot.c
--- linux-2.5.0.vanilla/arch/i386/kernel/smpboot.c	Wed Nov 21 10:35:48 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/smpboot.c	Sun Dec  2 19:31:23 2001
@@ -815,7 +815,7 @@

 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = (void *) (THREAD_SIZE + (char *) TSK_TO_KSTACK(idle));

 	/*
 	 * This grunge runs the startup process for
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/traps.c linux-2.5.0.sstc/arch/i386/kernel/traps.c
--- linux-2.5.0.vanilla/arch/i386/kernel/traps.c	Sun Sep 30 12:26:08 2001
+++ linux-2.5.0.sstc/arch/i386/kernel/traps.c	Sun Dec  2 19:37:15 2001
@@ -209,7 +209,7 @@
 	printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, stackpage=%08lx)",
-		current->comm, current->pid, 4096+(unsigned long)current);
+		current->comm, current->pid, TSK_TO_KSTACK(current));
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
diff -Nru linux-2.5.0.vanilla/arch/i386/lib/getuser.S linux-2.5.0.sstc/arch/i386/lib/getuser.S
--- linux-2.5.0.vanilla/arch/i386/lib/getuser.S	Mon Jan 12 13:42:52 1998
+++ linux-2.5.0.sstc/arch/i386/lib/getuser.S	Sun Dec  2 16:34:15 2001
@@ -29,6 +29,7 @@
 __get_user_1:
 	movl %esp,%edx
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -42,6 +43,7 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -55,6 +57,7 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -Nru linux-2.5.0.vanilla/include/asm-i386/current.h linux-2.5.0.sstc/include/asm-i386/current.h
--- linux-2.5.0.vanilla/include/asm-i386/current.h	Fri Aug 14 16:35:22 1998
+++ linux-2.5.0.sstc/include/asm-i386/current.h	Sun Dec  2 16:34:15 2001
@@ -5,9 +5,9 @@

 static inline struct task_struct * get_current(void)
 {
-	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-	return current;
+	unsigned long *tskptr;
+	__asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
+	return (struct task_struct *) *tskptr;
  }

 #define current get_current()
diff -Nru linux-2.5.0.vanilla/include/asm-i386/hw_irq.h linux-2.5.0.sstc/include/asm-i386/hw_irq.h
--- linux-2.5.0.vanilla/include/asm-i386/hw_irq.h	Thu Nov 22 11:46:18 2001
+++ linux-2.5.0.sstc/include/asm-i386/hw_irq.h	Sun Dec  2 22:22:06 2001
@@ -115,7 +115,8 @@

 #define GET_CURRENT \
 	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
+	"andl $-8192, %ebx\n\t" \
+	"movl (%ebx), %ebx\n\t"

 /*
  *	SMP has a few special interrupts for IPI messages
diff -Nru linux-2.5.0.vanilla/include/asm-i386/processor.h linux-2.5.0.sstc/include/asm-i386/processor.h
--- linux-2.5.0.vanilla/include/asm-i386/processor.h	Thu Nov 22 11:46:19 2001
+++ linux-2.5.0.sstc/include/asm-i386/processor.h	Sun Dec  2 22:22:06 2001
@@ -14,6 +14,8 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <asm/ptrace.h>
+#include <linux/kernel.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -444,16 +446,21 @@
 }

 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
+#define KSTK_EIP(tsk)	((unsigned long *) TSK_KSTACK_TOP(tsk))[EIP]
+#define KSTK_ESP(tsk)	((unsigned long *) TSK_KSTACK_TOP(tsk))[UESP]
+

 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
-#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)

-#define init_task	(init_task_union.task)
-#define init_stack	(init_task_union.stack)
+extern void init_tsk_allocator(void);
+extern struct task_struct *alloc_task_struct(void);
+extern void free_task_struct(struct task_struct *p);
+
+#define get_task_struct(tsk)      atomic_inc(&TSK_COUNT(tsk))
+
+#define init_task      (init_ts.ftsk.task)
+#define init_stack     (init_ts.stack)
+

 struct microcode {
 	unsigned int hdrver;
diff -Nru linux-2.5.0.vanilla/include/linux/sched.h linux-2.5.0.sstc/include/linux/sched.h
--- linux-2.5.0.vanilla/include/linux/sched.h	Thu Nov 22 11:46:19 2001
+++ linux-2.5.0.sstc/include/linux/sched.h	Sun Dec  2 22:22:06 2001
@@ -507,12 +507,24 @@
 # define INIT_TASK_SIZE	2048*sizeof(long)
 #endif

-union task_union {
+#define TSK_TO_KSTACK(p)	(((struct full_task_struct *) (p))->stack)
+#define TSK_KSTACK_TOP(p)	(((struct full_task_struct *) (p))->stack_top)
+#define TSK_COUNT(p)	(((struct full_task_struct *) (p))->count)
+
+struct full_task_struct {
 	struct task_struct task;
+	atomic_t count;
+	unsigned long stack;
+	unsigned long stack_top;
+};
+
+struct init_task_struct {
 	unsigned long stack[INIT_TASK_SIZE/sizeof(long)];
+	struct full_task_struct ftsk;
 };

-extern union task_union init_task_union;
+extern struct init_task_struct init_ts;
+

 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
diff -Nru linux-2.5.0.vanilla/init/main.c linux-2.5.0.sstc/init/main.c
--- linux-2.5.0.vanilla/init/main.c	Fri Nov  9 14:15:00 2001
+++ linux-2.5.0.sstc/init/main.c	Sun Dec  2 18:04:08 2001
@@ -594,6 +594,12 @@
 	mempages = num_physpages;

 	fork_init(mempages);
+	/*
+	 * task_struct/stack colouring is implemented only for x86 right now.
+	 */
+#ifdef __i386__
+	init_tsk_allocator();
+#endif
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
diff -Nru linux-2.5.0.vanilla/kernel/ksyms.c linux-2.5.0.sstc/kernel/ksyms.c
--- linux-2.5.0.vanilla/kernel/ksyms.c	Wed Nov 21 14:07:25 2001
+++ linux-2.5.0.sstc/kernel/ksyms.c	Sun Dec  2 18:11:17 2001
@@ -548,7 +548,7 @@

 /* init task, for moving kthread roots - ought to export a function ?? */

-EXPORT_SYMBOL(init_task_union);
+EXPORT_SYMBOL(init_ts);

 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);




