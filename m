Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSAFVpw>; Sun, 6 Jan 2002 16:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAFVpo>; Sun, 6 Jan 2002 16:45:44 -0500
Received: from colorfullife.com ([216.156.138.34]:23301 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289046AbSAFVp1>;
	Sun, 6 Jan 2002 16:45:27 -0500
Message-ID: <3C38C563.ADCBC5F5@colorfullife.com>
Date: Sun, 06 Jan 2002 22:45:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] task struct colouring
Content-Type: multipart/mixed;
 boundary="------------D9BB4CAFED7F1C94F3461521"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D9BB4CAFED7F1C94F3461521
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

the -ac kernels contained task struct colouring for i386, but Linus
refused to merge it because he considers the 'str' trick as too ugly.

The attached patch is just the task struct colouring, with
bottom-of-stack for finding the current pointer.

I've moved the support functions from arch/i386 into kernel/fork.c,
within #ifdef ARCH_NEEDS_TASKSTRUCTCACHE.

Is that the correct approach for such helpers, or should I create a
CONFIG_ option?

Is the implementation generic enough that other architectures can use
it, too?

It boots i386 SMP, but I haven't checked other configurations yet.
--
	Manfred
--------------D9BB4CAFED7F1C94F3461521
Content-Type: text/plain; charset=us-ascii;
 name="patch-taskcolour"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-taskcolour"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 2
//  EXTRAVERSION =-pre9
diff -ur 2.5/include/asm-i386/current.h build-2.5/include/asm-i386/current.h
--- 2.5/include/asm-i386/current.h	Sat Aug 15 01:35:22 1998
+++ build-2.5/include/asm-i386/current.h	Sun Jan  6 21:47:04 2002
@@ -1,15 +1,24 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
+#ifdef __ASSEMBLY__
+#define GET_CURRENT(reg) \
+	movl %esp, reg;	\
+	andl $0xffffe000, reg; \
+	movl (reg), reg
+
+#else
+
 struct task_struct;
 
 static inline struct task_struct * get_current(void)
 {
-	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-	return current;
- }
- 
+	struct task_struct **ptsk;
+	__asm__("andl %%esp,%0; ":"=r" (ptsk) : "0" (~8191UL));
+	return *ptsk;
+}
+
 #define current get_current()
+#endif
 
 #endif /* !(_I386_CURRENT_H) */
diff -ur 2.5/include/asm-i386/processor.h build-2.5/include/asm-i386/processor.h
--- 2.5/include/asm-i386/processor.h	Sun Jan  6 21:12:37 2002
+++ build-2.5/include/asm-i386/processor.h	Sun Jan  6 21:47:19 2002
@@ -395,7 +395,7 @@
 
 #define INIT_TSS  {						\
 	0,0, /* back_link, __blh */				\
-	sizeof(init_stack) + (long) &init_stack, /* esp0 */	\
+	0, /* esp0 */ 						\
 	__KERNEL_DS, 0, /* ss0 */				\
 	0,0,0,0,0,0, /* stack1, stack2 */			\
 	0, /* cr3 */						\
@@ -444,16 +444,16 @@
 }
 
 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
 
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
-#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
+#define ARCH_NEEDS_TASKSTRUCTCACHE
+#define ARCH_STACK_ORDER	1
+
+#define KSTK_EIP(tsk)	((tsk)->thread.esp0 ? \
+		((unsigned long*)(tsk)->thread.esp0)[-5] : 0)
+#define KSTK_ESP(tsk)	((tsk)->thread.esp0 ? \
+		((unsigned long*)(tsk)->thread.esp0)[-2] : 0)
 
-#define init_task	(init_task_union.task)
-#define init_stack	(init_task_union.stack)
+#define THREAD_SIZE (2*PAGE_SIZE)
 
 struct microcode {
 	unsigned int hdrver;
diff -ur 2.5/include/linux/sched.h build-2.5/include/linux/sched.h
--- 2.5/include/linux/sched.h	Sat Jan  5 17:36:01 2002
+++ build-2.5/include/linux/sched.h	Sun Jan  6 22:05:53 2002
@@ -512,7 +512,26 @@
     journal_info:	NULL,						\
 }
 
+#ifdef ARCH_NEEDS_TASKSTRUCTCACHE
 
+struct task_struct * alloc_task_struct(void);
+void get_task_struct(struct task_struct *tsk);
+void free_task_struct(struct task_struct *tsk);
+
+#define init_task	(init_task_union.task)
+
+struct task_struct_info {
+	struct task_struct task;
+	atomic_t users;
+	void *kstack;
+};
+
+#define TSK_TO_KSTACK(tsk) \
+	((void*) ((struct task_struct_info*)(tsk))->kstack)
+
+extern struct task_struct_info init_task_union;
+
+#else
 #ifndef INIT_TASK_SIZE
 # define INIT_TASK_SIZE	2048*sizeof(long)
 #endif
@@ -523,6 +542,7 @@
 };
 
 extern union task_union init_task_union;
+#endif /* ARCH_NEEDS_TASKSTRUCTCACHE */
 
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
diff -ur 2.5/arch/i386/kernel/entry.S build-2.5/arch/i386/kernel/entry.S
--- 2.5/arch/i386/kernel/entry.S	Sun Nov 11 11:36:09 2001
+++ build-2.5/arch/i386/kernel/entry.S	Sun Jan  6 20:57:35 2002
@@ -45,6 +45,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/current.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -128,10 +129,6 @@
 	.long 3b,6b;	\
 .previous
 
-#define GET_CURRENT(reg) \
-	movl $-8192, reg; \
-	andl %esp, reg
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
@@ -142,9 +139,8 @@
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
-	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -163,9 +159,8 @@
 	movl %eax,EFLAGS(%esp)	#
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
-	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -ur 2.5/arch/i386/kernel/head.S build-2.5/arch/i386/kernel/head.S
--- 2.5/arch/i386/kernel/head.S	Sat Jul  7 13:05:48 2001
+++ build-2.5/arch/i386/kernel/head.S	Sun Jan  6 21:20:27 2002
@@ -320,7 +320,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_task_union)+8192
+	.long SYMBOL_NAME(init_task_stack)+8192
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
diff -ur 2.5/arch/i386/kernel/init_task.c build-2.5/arch/i386/kernel/init_task.c
--- 2.5/arch/i386/kernel/init_task.c	Sun Sep 30 16:25:06 2001
+++ build-2.5/arch/i386/kernel/init_task.c	Sun Jan  6 21:27:03 2002
@@ -12,15 +12,24 @@
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
- * Initial task structure.
- *
  * We need to make sure that this is 8192-byte aligned due to the
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
-union task_union init_task_union 
+
+unsigned long init_task_stack[THREAD_SIZE/sizeof(unsigned long)]
 	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_TASK(init_task_union.task) };
+	{ (unsigned long)&init_task_union,};
+
+/*
+ * Initial task structure.
+ */
+struct task_struct_info init_task_union =
+		{ 
+			task: INIT_TASK(init_task_union.task),
+			users: ATOMIC_INIT(1),
+			kstack: init_task_stack
+		};
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
diff -ur 2.5/arch/i386/kernel/irq.c build-2.5/arch/i386/kernel/irq.c
--- 2.5/arch/i386/kernel/irq.c	Fri Dec 21 17:52:26 2001
+++ build-2.5/arch/i386/kernel/irq.c	Sun Jan  6 21:35:47 2002
@@ -220,7 +220,7 @@
 			continue;
 		}
 		esp &= ~(THREAD_SIZE-1);
-		esp += sizeof(struct task_struct);
+		esp += sizeof(void*);
 		show_stack((void*)esp);
  	}
 	printk("\nCPU %d:",cpu);
diff -ur 2.5/arch/i386/kernel/process.c build-2.5/arch/i386/kernel/process.c
--- 2.5/arch/i386/kernel/process.c	Sun Jan  6 21:12:37 2002
+++ build-2.5/arch/i386/kernel/process.c	Sun Jan  6 21:43:22 2002
@@ -579,14 +579,17 @@
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
+	unsigned long esp0 = (unsigned long)TSK_TO_KSTACK(p);
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	/* cache colour the start of the stack. */
+	esp0 += THREAD_SIZE - SMP_CACHE_BYTES * ((unsigned long)p % (1504/SMP_CACHE_BYTES));
+	childregs = ((struct pt_regs *)esp0) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	p->thread.esp0 = esp0;
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
diff -ur 2.5/arch/i386/kernel/smpboot.c build-2.5/arch/i386/kernel/smpboot.c
--- 2.5/arch/i386/kernel/smpboot.c	Sat Jan  5 17:35:59 2002
+++ build-2.5/arch/i386/kernel/smpboot.c	Sun Jan  6 21:45:13 2002
@@ -819,7 +819,8 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = TSK_TO_KSTACK(idle);
+	stack_start.esp += THREAD_SIZE;
 
 	/*
 	 * This grunge runs the startup process for
diff -ur 2.5/arch/i386/kernel/traps.c build-2.5/arch/i386/kernel/traps.c
--- 2.5/arch/i386/kernel/traps.c	Fri Dec 21 17:52:26 2001
+++ build-2.5/arch/i386/kernel/traps.c	Sun Jan  6 20:57:35 2002
@@ -158,7 +158,7 @@
 	unsigned long esp = tsk->thread.esp;
 
 	/* User space on another CPU? */
-	if ((esp ^ (unsigned long)tsk) & (PAGE_MASK<<1))
+	if (esp < TSK_TO_KSTACK(tsk) || esp > tsk->thread.esp0)
 		return;
 	show_trace((unsigned long *)esp);
 }
@@ -209,7 +209,7 @@
 	printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, stackpage=%08lx)",
-		current->comm, current->pid, 4096+(unsigned long)current);
+		current->comm, current->pid, TSK_TO_KSTACK(current));
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
diff -ur 2.5/arch/i386/lib/getuser.S build-2.5/arch/i386/lib/getuser.S
--- 2.5/arch/i386/lib/getuser.S	Mon Jan 12 22:42:52 1998
+++ build-2.5/arch/i386/lib/getuser.S	Sun Jan  6 20:57:35 2002
@@ -21,14 +21,14 @@
  * as they get called from within inline assembly.
  */
 
+#include <asm/current.h>
 addr_limit = 12
 
 .text
 .align 4
 .globl __get_user_1
 __get_user_1:
-	movl %esp,%edx
-	andl $0xffffe000,%edx
+	GET_CURRENT(%edx)
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -39,9 +39,8 @@
 .globl __get_user_2
 __get_user_2:
 	addl $1,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	GET_CURRENT(%edx)
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -52,9 +51,8 @@
 .globl __get_user_4
 __get_user_4:
 	addl $3,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	GET_CURRENT(%edx)
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -u 2.5/kernel/fork.c build-2.5/kernel/fork.c
--- 2.5/kernel/fork.c	Sun Jan  6 21:12:37 2002
+++ build-2.5/kernel/fork.c	Sun Jan  6 21:49:04 2002
@@ -66,6 +66,52 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
+#ifdef ARCH_NEEDS_TASKSTRUCTCACHE
+static kmem_cache_t * tsk_cache;
+
+struct task_struct * alloc_task_struct(void)
+{
+	struct task_struct_info *f = kmem_cache_alloc(tsk_cache, GFP_KERNEL);
+	if (!f)
+		return NULL;
+	f->kstack = (void*)__get_free_pages(GFP_KERNEL,ARCH_STACK_ORDER);
+	if (!f->kstack) {
+		kmem_cache_free(tsk_cache, f);
+		return NULL;
+	}
+	*(void**)f->kstack = &f->task;
+	atomic_set(&f->users, 1);	
+	return &f->task;
+}
+
+void get_task_struct(struct task_struct *tsk)
+{
+	struct task_struct_info *f = (struct task_struct_info*)tsk;
+	atomic_inc(&f->users);
+}
+
+void free_task_struct(struct task_struct *tsk)
+{
+	struct task_struct_info *f = (struct task_struct_info*)tsk;
+	if(atomic_dec_and_test(&f->users)) {
+		free_pages((unsigned long) f->kstack, ARCH_STACK_ORDER);
+		kmem_cache_free(tsk_cache, f);
+	}
+}
+
+void __init init_tsk_allocator(void)
+{
+	tsk_cache = kmem_cache_create("task_cache",
+					 sizeof(struct task_struct_info),
+					 0,
+					 SLAB_HWCACHE_ALIGN,
+					 NULL, NULL);
+	if (!tsk_cache)
+		panic("Cannot create task struct cache");
+}
+
+#endif
+
 void __init fork_init(unsigned long mempages)
 {
 	/*
@@ -77,6 +123,9 @@
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+#ifdef ARCH_NEEDS_TASKSTRUCTCACHE
+	init_tsk_allocator();
+#endif
 }
 
 /* Protects next_safe and last_pid. */



--------------D9BB4CAFED7F1C94F3461521--


