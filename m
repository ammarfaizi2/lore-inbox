Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280433AbRJaT1h>; Wed, 31 Oct 2001 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280436AbRJaT11>; Wed, 31 Oct 2001 14:27:27 -0500
Received: from colorfullife.com ([216.156.138.34]:274 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S280433AbRJaT1C>;
	Wed, 31 Oct 2001 14:27:02 -0500
Message-ID: <3BE050AD.C6D7CE4B@colorfullife.com>
Date: Wed, 31 Oct 2001 20:27:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cache colour task_structs
Content-Type: multipart/mixed;
 boundary="------------795A83BE4F1F97B752A97962"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------795A83BE4F1F97B752A97962
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All tasks structs are 8 kB aligned, which results in very bad cache
behaviour when walking the task chains.

The attached patch moves the task structure into a slab, with normal
cache colouring.
It's tested with i386 SMP.(i.e. it boots and runs X)

'current=%esp&0xffffe000' was replaced with reusing %cr2.

There are 2 changes that might have side effects:

1) arch/i386/kernel/entry.S:
<<<<<<
error_code:
[...]
-       GET_CURRENT(%ebx)
        call *%edi
        addl $8,%esp
+       GET_CURRENT(%ebx)
<<<<<
The pointer to current was loaded into %ebx before the call to the error
handler, now that only happens after the call. As far as I can see the
load before the call is not required.

2) arch/i386/kernel/smpboot.c:
- stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+ stack_start.esp = (void *) (THREAD_SIZE + (char
*)TSK_TO_KSTACK(idle));

I don't understand why the top 3 kB of the stack are not used.

--
	Manfred
--------------795A83BE4F1F97B752A97962
Content-Type: text/plain; charset=us-ascii;
 name="patch-cr2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cr2"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 14
//  EXTRAVERSION =-pre3
diff -ur 2.4/include/asm-i386/current.h build-2.4/include/asm-i386/current.h
--- 2.4/include/asm-i386/current.h	Sat Aug 15 01:35:22 1998
+++ build-2.4/include/asm-i386/current.h	Wed Oct 31 17:19:41 2001
@@ -5,11 +5,27 @@
 
 static inline struct task_struct * get_current(void)
 {
-	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-	return current;
- }
- 
+	struct task_struct *tsk;
+	__asm__("movl %%cr2,%0;": "=r" (tsk));
+	return tsk;
+}
+
+/* for within NMI, do_page_fault, cpu_init */
+static inline struct task_struct * hard_get_current(void)
+{
+	struct task_struct **ptsk;
+	__asm__("andl %%esp,%0; ":"=r" (ptsk) : "0" (~8191UL));
+	return *ptsk;
+}
+
+static inline void set_current(struct task_struct *tsk)
+{
+	__asm__("movl %0,%%cr2;"
+			: /* no output */
+			:"r" (tsk));
+}
+   
+/* Note: the implementation is hardcoded into arch/i386/lib/getuser.S */
 #define current get_current()
 
 #endif /* !(_I386_CURRENT_H) */
diff -ur 2.4/include/asm-i386/processor.h build-2.4/include/asm-i386/processor.h
--- 2.4/include/asm-i386/processor.h	Sun Oct 28 02:12:45 2001
+++ build-2.4/include/asm-i386/processor.h	Wed Oct 31 18:32:01 2001
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <asm/atomic.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -383,6 +384,16 @@
 	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];
 };
 
+struct task_struct_info
+{
+	void *kstack;
+	atomic_t users;
+};
+
+/* the init task stack is allocated externally */
+#define INIT_TASK_SIZE	(sizeof(struct task_struct) + sizeof(struct task_struct_info))
+extern unsigned long init_task_stack[];
+
 #define INIT_THREAD  {						\
 	0,							\
 	0, 0, 0, 0, 						\
@@ -395,7 +406,7 @@
 
 #define INIT_TSS  {						\
 	0,0, /* back_link, __blh */				\
-	sizeof(init_stack) + (long) &init_stack, /* esp0 */	\
+	0, /* esp0 */ 						\
 	__KERNEL_DS, 0, /* ss0 */				\
 	0,0,0,0,0,0, /* stack1, stack2 */			\
 	0, /* cr3 */						\
@@ -444,16 +455,19 @@
 }
 
 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
+#define TSK_TO_KSTACK(tsk) \
+	((unsigned long *) ((struct task_struct_info*)(tsk+1))->kstack)
+
+#define KSTK_EIP(tsk)	(TSK_TO_KSTACK(tsk)[2043])
+#define KSTK_ESP(tsk)	(TSK_TO_KSTACK(tsk)[2046])
 
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
-#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
+void init_tsk_allocator(void);
+struct task_struct * alloc_task_struct(void);
+void get_task_struct(struct task_struct *tsk);
+void free_task_struct(struct task_struct *tsk);
 
 #define init_task	(init_task_union.task)
-#define init_stack	(init_task_union.stack)
 
 struct microcode {
 	unsigned int hdrver;
diff -ur 2.4/arch/i386/kernel/entry.S build-2.4/arch/i386/kernel/entry.S
--- 2.4/arch/i386/kernel/entry.S	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/entry.S	Wed Oct 31 17:34:54 2001
@@ -129,8 +129,7 @@
 .previous
 
 #define GET_CURRENT(reg) \
-	movl $-8192, reg; \
-	andl %esp, reg
+	movl %cr2, reg
 
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
@@ -144,7 +143,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -165,7 +164,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
@@ -286,9 +285,9 @@
 	movl $(__KERNEL_DS),%edx
 	movl %edx,%ds
 	movl %edx,%es
-	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
+	GET_CURRENT(%ebx)
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
diff -ur 2.4/arch/i386/kernel/head.S build-2.4/arch/i386/kernel/head.S
--- 2.4/arch/i386/kernel/head.S	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/head.S	Tue Oct 30 22:02:32 2001
@@ -261,13 +261,13 @@
 #ifdef CONFIG_SMP
 	movb ready, %cl	
 	cmpb $1,%cl
-	je 1f			# the first CPU calls start_kernel
+	je 1f			# the first CPU calls initialize_primary
 				# all other CPUs call initialize_secondary
 	call SYMBOL_NAME(initialize_secondary)
 	jmp L6
 1:
 #endif
-	call SYMBOL_NAME(start_kernel)
+	call SYMBOL_NAME(initialize_primary)
 L6:
 	jmp L6			# main should never return here, but
 				# just in case, we know what happens.
@@ -320,7 +320,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_task_union)+8192
+	.long SYMBOL_NAME(init_task_stack)+8192
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
diff -ur 2.4/arch/i386/kernel/init_task.c build-2.4/arch/i386/kernel/init_task.c
--- 2.4/arch/i386/kernel/init_task.c	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/init_task.c	Wed Oct 31 00:14:02 2001
@@ -13,14 +13,18 @@
 
 /*
  * Initial task structure.
- *
+ */
+union task_union init_task_union =
+		{ INIT_TASK(init_task_union.task) };
+/*
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
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
diff -ur 2.4/arch/i386/kernel/irq.c build-2.4/arch/i386/kernel/irq.c
--- 2.4/arch/i386/kernel/irq.c	Sun Oct 28 10:07:01 2001
+++ build-2.4/arch/i386/kernel/irq.c	Wed Oct 31 00:25:06 2001
@@ -223,7 +223,6 @@
 			continue;
 		}
 		esp &= ~(THREAD_SIZE-1);
-		esp += sizeof(struct task_struct);
 		show_stack((void*)esp);
  	}
 	printk("\nCPU %d:",cpu);
diff -ur 2.4/arch/i386/kernel/nmi.c build-2.4/arch/i386/kernel/nmi.c
--- 2.4/arch/i386/kernel/nmi.c	Sun Sep 30 16:25:06 2001
+++ build-2.4/arch/i386/kernel/nmi.c	Wed Oct 31 18:08:06 2001
@@ -261,12 +261,10 @@
 
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
-
 	/*
-	 * Since current-> is always on the stack, and we always switch
-	 * the stack NMI-atomically, it's safe to use smp_processor_id().
+	 * NMI can interrupt page faults, use hard_get_current.
 	 */
-	int sum, cpu = smp_processor_id();
+	int sum, cpu = hard_get_current()->processor;
 
 	sum = apic_timer_irqs[cpu];
 
@@ -282,6 +280,7 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
+			set_current(hard_get_current());
 			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
diff -ur 2.4/arch/i386/kernel/process.c build-2.4/arch/i386/kernel/process.c
--- 2.4/arch/i386/kernel/process.c	Thu Oct 11 15:19:41 2001
+++ build-2.4/arch/i386/kernel/process.c	Wed Oct 31 17:20:49 2001
@@ -569,6 +569,64 @@
 	new_mm->context.cpuvalid = ~0UL;	/* valid on all CPU's - they can't have stale data */
 }
 
+struct full_task_struct
+{
+	struct task_struct tsk;
+	struct task_struct_info info;
+};
+
+static kmem_cache_t * tsk_cache;
+
+struct task_struct * alloc_task_struct(void)
+{
+	struct full_task_struct *f = kmem_cache_alloc(tsk_cache, GFP_KERNEL);
+	if (!f)
+		return NULL;
+	f->info.kstack = (void*)__get_free_pages(GFP_KERNEL,1);
+	if (!f->info.kstack) {
+		kmem_cache_free(tsk_cache, f);
+		return NULL;
+	}
+	*(void**)f->info.kstack = &f->tsk;
+	atomic_set(&f->info.users, 1);	
+	return &f->tsk;
+}
+
+void get_task_struct(struct task_struct *tsk)
+{
+	struct full_task_struct *f = (struct full_task_struct*)tsk;
+	atomic_inc(&f->info.users);
+}
+
+void free_task_struct(struct task_struct *tsk)
+{
+	struct full_task_struct *f = (struct full_task_struct*)tsk;
+	if(atomic_dec_and_test(&f->info.users)) {
+		free_pages((unsigned long) f->info.kstack, 1);
+		kmem_cache_free(tsk_cache, f);
+	}
+}
+
+void __init init_tsk_allocator(void)
+{
+	tsk_cache = kmem_cache_create("task_cache",
+					 sizeof(struct full_task_struct),
+					 0,
+					 SLAB_HWCACHE_ALIGN,
+					 NULL, NULL);
+	if (!tsk_cache)
+		panic("Cannot create task struct cache");
+}
+
+extern asmlinkage void start_kernel(void);
+void __init initialize_primary(void)
+{
+	struct full_task_struct *f = (struct full_task_struct*)hard_get_current();
+	atomic_set(&f->info.users, 1);
+	f->info.kstack = init_task_stack;
+	set_current(&f->tsk);
+	start_kernel();
+}
 /*
  * Save a segment.
  */
@@ -580,8 +638,9 @@
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
+	struct full_task_struct *f = (struct full_task_struct *)p;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) f->info.kstack)) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -685,6 +744,7 @@
 	 * Reload esp0, LDT and the page table pointer:
 	 */
 	tss->esp0 = next->esp0;
+	set_current(next_p);
 
 	/*
 	 * Save away %fs and %gs. No need to save %es and %ds, as
diff -ur 2.4/arch/i386/kernel/smpboot.c build-2.4/arch/i386/kernel/smpboot.c
--- 2.4/arch/i386/kernel/smpboot.c	Thu Oct 11 15:19:41 2001
+++ build-2.4/arch/i386/kernel/smpboot.c	Tue Oct 30 23:41:05 2001
@@ -482,6 +482,7 @@
 	 * We don't actually need to load the full TSS,
 	 * basically just the stack pointer and the eip.
 	 */
+	set_current(hard_get_current());
 
 	asm volatile(
 		"movl %0,%%esp\n\t"
@@ -815,7 +816,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = (void *) (THREAD_SIZE + (char *)TSK_TO_KSTACK(idle));
 
 	/*
 	 * This grunge runs the startup process for
diff -ur 2.4/arch/i386/kernel/traps.c build-2.4/arch/i386/kernel/traps.c
--- 2.4/arch/i386/kernel/traps.c	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/traps.c	Wed Oct 31 18:23:20 2001
@@ -209,7 +209,7 @@
 	printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, stackpage=%08lx)",
-		current->comm, current->pid, 4096+(unsigned long)current);
+		current->comm, current->pid, TSK_TO_KSTACK(current));
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
@@ -422,7 +422,7 @@
 {
 	unsigned char reason = inb(0x61);
 
-	++nmi_count(smp_processor_id());
+	++nmi_count(hard_get_current()->processor);
 
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
diff -ur 2.4/arch/i386/mm/fault.c build-2.4/arch/i386/mm/fault.c
--- 2.4/arch/i386/mm/fault.c	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/mm/fault.c	Wed Oct 31 17:37:18 2001
@@ -159,12 +159,13 @@
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
+	/* and restore current */
+	tsk = hard_get_current();
+	set_current(tsk);
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
-
-	tsk = current;
 
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
diff -ur 2.4/arch/i386/lib/getuser.S build-2.4/arch/i386/lib/getuser.S
--- 2.4/arch/i386/lib/getuser.S	Mon Jan 12 22:42:52 1998
+++ build-2.4/arch/i386/lib/getuser.S	Wed Oct 31 17:18:28 2001
@@ -27,8 +27,7 @@
 .align 4
 .globl __get_user_1
 __get_user_1:
-	movl %esp,%edx
-	andl $0xffffe000,%edx
+	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -39,9 +38,8 @@
 .globl __get_user_2
 __get_user_2:
 	addl $1,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -52,9 +50,8 @@
 .globl __get_user_4
 __get_user_4:
 	addl $3,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -u 2.4/init/main.c build-2.4/init/main.c
--- 2.4/init/main.c	Sun Oct 28 02:12:45 2001
+++ build-2.4/init/main.c	Wed Oct 31 17:16:17 2001
@@ -594,6 +594,9 @@
 	mempages = num_physpages;
 
 	fork_init(mempages);
+#ifdef __i386__
+	init_tsk_allocator();
+#endif
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);

--------------795A83BE4F1F97B752A97962--

