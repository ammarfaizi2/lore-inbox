Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRKMH20>; Tue, 13 Nov 2001 02:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKMH2W>; Tue, 13 Nov 2001 02:28:22 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:28519 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281416AbRKMH2J>; Tue, 13 Nov 2001 02:28:09 -0500
Date: Tue, 13 Nov 2001 02:28:07 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] current changes vs 2.4.15-pre4
Message-ID: <20011113022807.C14409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey dudes,

Below is my current set of changes merged with Manfred base changes to 
split the task struct out into a slab.  I had to make a couple of changes 
to setup.c in how the processor id is determined which make smp_processor_id() 
and current completely independant of the stack the processor is using at 
the moment.  This makes it possible to use seperate stacks for irq context 
if we so desire.  The patch also adds an smp_per_cpu_data() macro that 
returns a pointer to the per cpu data area.  It required some inline asm 
to work around the fact that gcc doesn't know that the low order bits 
of get_TR will be zero and thus leaves an unneeded shrl in.  The workaround 
for preventing gcc from overoptimizing the inline asm is also included.  
Comments?

		-ben
-- 
Fish.

... v2.4.15-pre4-tr.diff ...

diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/entry.S tr-2.4.15-pre4.diff/arch/i386/kernel/entry.S
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/entry.S	Mon Nov 12 17:49:47 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/entry.S	Mon Nov 12 23:42:09 2001
@@ -45,6 +45,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/current_asm.h>
 
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
@@ -144,7 +141,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx,%bx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -165,7 +162,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx,%bx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
@@ -179,7 +176,7 @@
 	pushl %ebx
 	call SYMBOL_NAME(schedule_tail)
 	addl $4, %esp
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
 	jne tracesys_exit
 	jmp	ret_from_sys_call
@@ -194,7 +191,7 @@
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
 	jne tracesys
 	cmpl $(NR_syscalls),%eax
@@ -246,7 +243,7 @@
 
 	ALIGN
 ENTRY(ret_from_intr)
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 ret_from_exception:
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
 	movb CS(%esp),%al
@@ -286,9 +283,9 @@
 	movl $(__KERNEL_DS),%edx
 	movl %edx,%ds
 	movl %edx,%es
-	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
+	GET_CURRENT(%ebx,%bx)
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
@@ -304,7 +301,7 @@
 ENTRY(device_not_available)
 	pushl $-1		# mark this as an int
 	SAVE_ALL
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
 	jne device_not_available_emulate
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/head.S tr-2.4.15-pre4.diff/arch/i386/kernel/head.S
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/head.S	Tue Jul  3 21:15:01 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/head.S	Tue Nov 13 02:02:15 2001
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
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/init_task.c tr-2.4.15-pre4.diff/arch/i386/kernel/init_task.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/init_task.c	Mon Sep 24 02:16:02 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/init_task.c	Mon Nov 12 23:40:25 2001
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
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/irq.c tr-2.4.15-pre4.diff/arch/i386/kernel/irq.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/irq.c	Mon Nov 12 17:49:47 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/irq.c	Mon Nov 12 23:40:25 2001
@@ -223,7 +223,6 @@
 			continue;
 		}
 		esp &= ~(THREAD_SIZE-1);
-		esp += sizeof(struct task_struct);
 		show_stack((void*)esp);
  	}
 	printk("\nCPU %d:",cpu);
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/ldt.c tr-2.4.15-pre4.diff/arch/i386/kernel/ldt.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/ldt.c	Thu Nov  1 16:39:57 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/ldt.c	Mon Nov 12 23:40:39 2001
@@ -12,11 +12,13 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
+#include <linux/per_cpu.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <asm/descfn.h>
 
 /*
  * read_ldt() is not really atomic - this is not a problem since
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/nmi.c tr-2.4.15-pre4.diff/arch/i386/kernel/nmi.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/nmi.c	Mon Sep 24 02:16:02 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/nmi.c	Tue Nov 13 02:07:56 2001
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
+	int sum, cpu = hard_smp_processor_id();
 
 	sum = apic_timer_irqs[cpu];
 
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/process.c tr-2.4.15-pre4.diff/arch/i386/kernel/process.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/process.c	Fri Oct 12 03:11:49 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/process.c	Tue Nov 13 02:12:21 2001
@@ -569,6 +569,63 @@
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
+	struct full_task_struct *f = (struct full_task_struct*)&init_task;
+	atomic_set(&f->info.users, 1);
+	f->info.kstack = init_task_stack;
+	start_kernel();
+}
 /*
  * Save a segment.
  */
@@ -580,8 +637,9 @@
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
+	struct full_task_struct *f = (struct full_task_struct *)p;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) f->info.kstack)) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/setup.c tr-2.4.15-pre4.diff/arch/i386/kernel/setup.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/setup.c	Mon Nov 12 17:51:05 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/setup.c	Tue Nov 13 02:14:06 2001
@@ -109,6 +109,7 @@
 #include <asm/cobalt.h>
 #include <asm/msr.h>
 #include <asm/desc.h>
+#include <asm/descfn.h>
 #include <asm/e820.h>
 #include <asm/dma.h>
 #include <asm/mpspec.h>
@@ -2806,6 +2807,7 @@
 };
 
 unsigned long cpu_initialized __initdata = 0;
+extern int cpucount;
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
@@ -2815,14 +2817,15 @@
  */
 void __init cpu_init (void)
 {
-	int nr = smp_processor_id();
+	int nr = cpucount;
+	struct task_struct *cur = init_tasks[nr];
 	struct tss_struct * t = &init_tss[nr];
 
 	if (test_and_set_bit(nr, &cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", nr);
 		for (;;) __sti();
 	}
-	printk(KERN_INFO "Initializing CPU#%d\n", nr);
+	printk(KERN_INFO "Initializing CPU#%d/%d\n", nr, cpucount);
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
@@ -2847,17 +2850,21 @@
 	 * set up and load the per-CPU TSS and LDT
 	 */
 	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-	if(current->mm)
+	cur->active_mm = &init_mm;
+	if(cur->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, current, nr);
+	enter_lazy_tlb(&init_mm, cur, nr);
 
-	t->esp0 = current->thread.esp0;
+	t->esp0 = cur->thread.esp0;
 	set_tss_desc(nr,t);
 	gdt_table[__TSS(nr)].b &= 0xfffffdff;
 	load_TR(nr);
 	load_LDT(&init_mm);
 
+	printk("cur: %p  processor: %d  smp_processor_id(): %d  current: %p",
+		cur, cur->processor, smp_processor_id(), current);
+	smp_per_cpu_data()->curr = cur;
+
 	/*
 	 * Clear all 6 debug registers:
 	 */
@@ -2871,8 +2878,8 @@
 	/*
 	 * Force FPU initialization:
 	 */
-	current->flags &= ~PF_USEDFPU;
-	current->used_math = 0;
+	cur->flags &= ~PF_USEDFPU;
+	cur->used_math = 0;
 	stts();
 }
 
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/smpboot.c tr-2.4.15-pre4.diff/arch/i386/kernel/smpboot.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/smpboot.c	Fri Oct 12 03:11:49 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/smpboot.c	Tue Nov 13 01:28:27 2001
@@ -476,6 +476,12 @@
  * from the task structure
  * This function must not return.
  */
+extern struct {
+	void * esp;
+	unsigned short ss;
+	unsigned long eip;
+} stack_start;
+
 void __init initialize_secondary(void)
 {
 	/*
@@ -487,14 +493,9 @@
 		"movl %0,%%esp\n\t"
 		"jmp *%1"
 		:
-		:"r" (current->thread.esp),"r" (current->thread.eip));
+		:"r" (stack_start.esp),"r" (stack_start.eip));
 }
 
-extern struct {
-	void * esp;
-	unsigned short ss;
-} stack_start;
-
 static int __init fork_by_hand(void)
 {
 	struct pt_regs regs;
@@ -506,14 +507,14 @@
 }
 
 /* which physical APIC ID maps to which logical CPU number */
-volatile int physical_apicid_2_cpu[MAX_APICID];
+volatile int physical_apicid_to_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
-volatile int cpu_2_physical_apicid[NR_CPUS];
+volatile int cpu_to_physical_apicid[NR_CPUS];
 
 /* which logical APIC ID maps to which logical CPU number */
-volatile int logical_apicid_2_cpu[MAX_APICID];
+volatile int logical_apicid_to_cpu[MAX_APICID];
 /* which logical CPU number maps to which logical APIC ID */
-volatile int cpu_2_logical_apicid[NR_CPUS];
+volatile int cpu_to_logical_apicid[NR_CPUS];
 
 static inline void init_cpu_to_apicid(void)
 /* Initialize all maps between cpu number and apicids */
@@ -521,12 +522,12 @@
 	int apicid, cpu;
 
 	for (apicid = 0; apicid < MAX_APICID; apicid++) {
-		physical_apicid_2_cpu[apicid] = -1;
-		logical_apicid_2_cpu[apicid] = -1;
+		physical_apicid_to_cpu[apicid] = -1;
+		logical_apicid_to_cpu[apicid] = -1;
 	}
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpu_2_physical_apicid[cpu] = -1;
-		cpu_2_logical_apicid[cpu] = -1;
+		cpu_to_physical_apicid[cpu] = -1;
+		cpu_to_logical_apicid[cpu] = -1;
 	}
 }
 
@@ -537,11 +538,11 @@
  */
 {
 	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_logical_apicid[cpu] = apicid;
+		logical_apicid_to_cpu[apicid] = cpu;	
+		cpu_to_logical_apicid[cpu] = apicid;
 	} else {
-		physical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_physical_apicid[cpu] = apicid;
+		physical_apicid_to_cpu[apicid] = cpu;	
+		cpu_to_physical_apicid[cpu] = apicid;
 	}
 }
 
@@ -552,11 +553,11 @@
  */
 {
 	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_logical_apicid[cpu] = -1;
+		logical_apicid_to_cpu[apicid] = -1;	
+		cpu_to_logical_apicid[cpu] = -1;
 	} else {
-		physical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_physical_apicid[cpu] = -1;
+		physical_apicid_to_cpu[apicid] = -1;	
+		cpu_to_physical_apicid[cpu] = -1;
 	}
 }
 
@@ -804,7 +805,7 @@
 	map_cpu_to_boot_apicid(cpu, apicid);
 
 	idle->has_cpu = 1; /* we schedule the first task manually */
-	idle->thread.eip = (unsigned long) start_secondary;
+	stack_start.eip = idle->thread.eip = (unsigned long) start_secondary;
 
 	del_from_runqueue(idle);
 	unhash_process(idle);
@@ -815,7 +816,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = (void *) (THREAD_SIZE + (char *)TSK_TO_KSTACK(idle));
 
 	/*
 	 * This grunge runs the startup process for
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/kernel/traps.c tr-2.4.15-pre4.diff/arch/i386/kernel/traps.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/kernel/traps.c	Fri Oct 12 03:11:49 2001
+++ tr-2.4.15-pre4.diff/arch/i386/kernel/traps.c	Tue Nov 13 02:13:26 2001
@@ -209,7 +209,7 @@
 	printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, stackpage=%08lx)",
-		current->comm, current->pid, 4096+(unsigned long)current);
+		current->comm, current->pid, (long)TSK_TO_KSTACK(current));
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/lib/getuser.S tr-2.4.15-pre4.diff/arch/i386/lib/getuser.S
--- kernels/2.4/v2.4.15-pre4/arch/i386/lib/getuser.S	Mon Jan 12 16:42:52 1998
+++ tr-2.4.15-pre4.diff/arch/i386/lib/getuser.S	Mon Nov 12 23:40:39 2001
@@ -8,6 +8,7 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <asm/current_asm.h>
 
 /*
  * __get_user_X
@@ -27,8 +28,6 @@
 .align 4
 .globl __get_user_1
 __get_user_1:
-	movl %esp,%edx
-	andl $0xffffe000,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -39,9 +38,7 @@
 .globl __get_user_2
 __get_user_2:
 	addl $1,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -52,9 +49,7 @@
 .globl __get_user_4
 __get_user_4:
 	addl $3,%eax
-	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -urN kernels/2.4/v2.4.15-pre4/arch/i386/mm/fault.c tr-2.4.15-pre4.diff/arch/i386/mm/fault.c
--- kernels/2.4/v2.4.15-pre4/arch/i386/mm/fault.c	Fri Oct 12 03:11:49 2001
+++ tr-2.4.15-pre4.diff/arch/i386/mm/fault.c	Tue Nov 13 02:00:20 2001
@@ -24,6 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/hardirq.h>
+#include <asm/desc.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -134,7 +135,6 @@
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
-extern unsigned long idt;
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -295,7 +295,7 @@
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt) >> 3;
+		nr = (address - (unsigned long)idt) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/current.h tr-2.4.15-pre4.diff/include/asm-i386/current.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/current.h	Fri Aug 14 19:35:22 1998
+++ tr-2.4.15-pre4.diff/include/asm-i386/current.h	Tue Nov 13 02:09:23 2001
@@ -1,15 +1,16 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-struct task_struct;
+#include <asm/smp.h>
+#include <linux/per_cpu.h>
 
-static inline struct task_struct * get_current(void)
+static inline struct task_struct *get_current(void) __attribute__((const));
+static inline struct task_struct *get_current(void)
 {
-	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-	return current;
- }
- 
+	return smp_per_cpu_data()->curr;
+}
+
+/* Note: the implementation is hardcoded into arch/i386/lib/getuser.S */
 #define current get_current()
 
 #endif /* !(_I386_CURRENT_H) */
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/current_asm.h tr-2.4.15-pre4.diff/include/asm-i386/current_asm.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/current_asm.h	Wed Dec 31 19:00:00 1969
+++ tr-2.4.15-pre4.diff/include/asm-i386/current_asm.h	Mon Nov 12 23:49:25 2001
@@ -0,0 +1,30 @@
+/* asm/current_asm.h
+ */
+#ifndef __ASM__CURRENT_ASM_H
+#define __ASM__CURRENT_ASM_H
+
+#include <linux/config.h>
+#include <linux/per_cpu.h>
+#include <asm/desc.h>
+
+#if 1 /*def CONFIG_SMP*/
+/* Pass in the long and short versions of the register.
+ * eg GET_CURRENT(%ebx,%bx)
+ * All of this braindamage comes to us c/o a bug in gas: the
+ * opcode we want should actually be generated by strl, but 
+ * unfortunately gas doesn't realize that the operand size 
+ * prefix applies to str.  Please take a wet noodle and thread 
+ * it into my eye as that will be less painful than dealing 
+ * with this mess.  -ben
+ */
+#define GET_CURRENT(reg,regw)				\
+	str regw					\
+	; shll $LOG2_PER_CPU_SIZE-5,reg			\
+	; aligned_data_adjusted = aligned_data-(__FIRST_TSS_ENTRY << (LOG2_PER_CPU_SIZE - 2))	\
+	; movl aligned_data_adjusted(reg),reg
+
+#else
+#define GET_CURRENT(reg,regw)	movl (aligned_data),reg
+#endif
+
+#endif /* __ASM__CURRENT_ASM_H */
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/desc.h tr-2.4.15-pre4.diff/include/asm-i386/desc.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/desc.h	Mon Aug 13 15:12:08 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/desc.h	Mon Nov 12 23:43:37 2001
@@ -34,7 +34,7 @@
  *
  * Entry into gdt where to find first TSS.
  */
-#define __FIRST_TSS_ENTRY 12
+#define __FIRST_TSS_ENTRY 12	/* Note!  Must be divisible by 4!  See smp.h. */
 #define __FIRST_LDT_ENTRY (__FIRST_TSS_ENTRY+1)
 
 #define __TSS(n) (((n)<<2) + __FIRST_TSS_ENTRY)
@@ -60,40 +60,6 @@
 
 #define __load_LDT(n) __asm__ __volatile__("lldt %%ax"::"a" (__LDT(n)<<3))
 
-/*
- * This is the ldt that every process will get unless we need
- * something other than this.
- */
-extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
-extern void set_ldt_desc(unsigned int n, void *addr, unsigned int size);
-extern void set_tss_desc(unsigned int n, void *addr);
-
-static inline void clear_LDT(void)
-{
-	int cpu = smp_processor_id();
-	set_ldt_desc(cpu, &default_ldt[0], 5);
-	__load_LDT(cpu);
-}
-
-/*
- * load one particular LDT into the current CPU
- */
-static inline void load_LDT (struct mm_struct *mm)
-{
-	int cpu = smp_processor_id();
-	void *segments = mm->context.segments;
-	int count = LDT_ENTRIES;
-
-	if (!segments) {
-		segments = &default_ldt[0];
-		count = 5;
-	}
-		
-	set_ldt_desc(cpu, segments, count);
-	__load_LDT(cpu);
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/descfn.h tr-2.4.15-pre4.diff/include/asm-i386/descfn.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/descfn.h	Wed Dec 31 19:00:00 1969
+++ tr-2.4.15-pre4.diff/include/asm-i386/descfn.h	Mon Nov 12 23:45:28 2001
@@ -0,0 +1,42 @@
+#ifndef __ARCH_DESCFN_H
+#define __ARCH_DESCFN_H
+
+#ifndef __ARCH_DESC_H
+#include <asm/desc.h>
+#endif
+
+/*
+ * This is the ldt that every process will get unless we need
+ * something other than this.
+ */
+extern struct desc_struct default_ldt[];
+extern void set_intr_gate(unsigned int irq, void * addr);
+extern void set_ldt_desc(unsigned int n, void *addr, unsigned int size);
+extern void set_tss_desc(unsigned int n, void *addr);
+
+static inline void clear_LDT(void)
+{
+	int cpu = smp_processor_id();
+	set_ldt_desc(cpu, &default_ldt[0], 5);
+	__load_LDT(cpu);
+}
+
+/*
+ * load one particular LDT into the current CPU
+ */
+static inline void load_LDT (struct mm_struct *mm)
+{
+	int cpu = smp_processor_id();
+	void *segments = mm->context.segments;
+	int count = LDT_ENTRIES;
+
+	if (!segments) {
+		segments = &default_ldt[0];
+		count = 5;
+	}
+		
+	set_ldt_desc(cpu, segments, count);
+	__load_LDT(cpu);
+}
+
+#endif /* __ARCH_DESCFN_H */
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/mmu_context.h tr-2.4.15-pre4.diff/include/asm-i386/mmu_context.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/mmu_context.h	Mon Nov 12 20:10:02 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/mmu_context.h	Tue Nov 13 00:26:42 2001
@@ -5,6 +5,7 @@
 #include <asm/desc.h>
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
+#include <asm/descfn.h>
 
 /*
  * possibly do the LDT unload here?
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/processor.h tr-2.4.15-pre4.diff/include/asm-i386/processor.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/processor.h	Wed Oct 17 15:14:07 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/processor.h	Tue Nov 13 00:19:34 2001
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <asm/atomic.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -76,7 +77,7 @@
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
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
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/smp.h tr-2.4.15-pre4.diff/include/asm-i386/smp.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/smp.h	Mon Nov 12 20:07:58 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/smp.h	Tue Nov 13 00:26:36 2001
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/ptrace.h>
+#include <asm/desc.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -33,6 +34,7 @@
 #else
 # define INT_DELIVERY_MODE 1     /* logical delivery */
 # define TARGET_CPUS 0x01
+# define smp_per_cpu_data()	per_data(0)
 #endif
 
 #ifndef clustered_apic_mode
@@ -83,10 +85,10 @@
  * the real APIC ID <-> CPU # mapping.
  */
 #define MAX_APICID 256
-extern volatile int cpu_to_physical_apicid[NR_CPUS];
-extern volatile int physical_apicid_to_cpu[MAX_APICID];
-extern volatile int cpu_to_logical_apicid[NR_CPUS];
-extern volatile int logical_apicid_to_cpu[MAX_APICID];
+extern volatile int physical_apicid_to_cpu[];
+extern volatile int cpu_to_physical_apicid[];
+extern volatile int cpu_to_logical_apicid[];
+extern volatile int logical_apicid_to_cpu[];
 
 /*
  * General functions that each host system must provide.
@@ -100,8 +102,39 @@
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
+extern int dummy_cpu_id;
 
-#define smp_processor_id() (current->processor)
+static inline unsigned get_TR(void) __attribute__ ((pure));
+static inline unsigned get_TR(void)
+{
+	unsigned tr;
+	/* The PAIN!  The HORROR!
+	 * Technically this is wrong, wrong, wrong, but 
+	 * gas doesn't know about strl.  *sigh*  Please 
+	 * flog them with a wet noodle repeatedly.
+	 * The extra parameter is a dummy value to prevent
+	 * gcc from assuming that the value is const across
+	 * function calls.  Fun!  -ben
+	 */
+	__asm__ ("str %w0" : "=r" (tr) : "m" (dummy_cpu_id));
+	return tr;
+}
+
+#define smp_processor_id()	( (get_TR() >> 5) - (__FIRST_TSS_ENTRY >> 2) )
+
+/* There is no way to tell gcc that the low bits of get_TR 
+ * are always 0, hence the following macro to produce 
+ * optimal code.  -ben
+ */
+#define smp_per_cpu_data()	\
+	( (struct per_cpu_data *)					\
+	  ({	long idx;						\
+		__asm__("str %w0 ; shll %1,%0"				\
+			: "=r" (idx)					\
+			: "i" (LOG2_PER_CPU_SIZE - 5)			\
+			, "m" (dummy_cpu_id));				\
+		(long)&aligned_data + idx -				\
+			(__FIRST_TSS_ENTRY << (LOG2_PER_CPU_SIZE - 2)); }) )
 
 static __inline int hard_smp_processor_id(void)
 {
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/smpboot.h tr-2.4.15-pre4.diff/include/asm-i386/smpboot.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/smpboot.h	Fri Nov  9 23:55:07 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/smpboot.h	Tue Nov 13 00:30:46 2001
@@ -36,21 +36,21 @@
  * Mappings between logical cpu number and logical / physical apicid
  * The first four macros are trivial, but it keeps the abstraction consistent
  */
-extern volatile int logical_apicid_2_cpu[];
-extern volatile int cpu_2_logical_apicid[];
-extern volatile int physical_apicid_2_cpu[];
-extern volatile int cpu_2_physical_apicid[];
+extern volatile int logical_apicid_to_cpu[];
+extern volatile int cpu_to_logical_apicid[];
+extern volatile int physical_apicid_to_cpu[];
+extern volatile int cpu_to_physical_apicid[];
 
-#define logical_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
-#define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
+#define logical_apicid_to_cpu(apicid) logical_apicid_to_cpu[apicid]
+#define cpu_to_logical_apicid(cpu) cpu_to_logical_apicid[cpu]
+#define physical_apicid_to_cpu(apicid) physical_apicid_to_cpu[apicid]
+#define cpu_to_physical_apicid(cpu) cpu_to_physical_apicid[cpu]
 #ifdef CONFIG_MULTIQUAD			/* use logical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
+#define boot_apicid_to_cpu(apicid) logical_apicid_to_cpu[apicid]
+#define cpu_to_boot_apicid(cpu) cpu_to_logical_apicid[cpu]
 #else /* !CONFIG_MULTIQUAD */		/* use physical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
+#define boot_apicid_to_cpu(apicid) physical_apicid_to_cpu[apicid]
+#define cpu_to_boot_apicid(cpu) cpu_to_physical_apicid[cpu]
 #endif /* CONFIG_MULTIQUAD */
 
 
diff -urN kernels/2.4/v2.4.15-pre4/include/asm-i386/uaccess.h tr-2.4.15-pre4.diff/include/asm-i386/uaccess.h
--- kernels/2.4/v2.4.15-pre4/include/asm-i386/uaccess.h	Mon Nov 12 20:14:41 2001
+++ tr-2.4.15-pre4.diff/include/asm-i386/uaccess.h	Tue Nov 13 02:09:39 2001
@@ -109,7 +109,7 @@
 #define __get_user_x(size,ret,x,ptr) \
 	__asm__ __volatile__("call __get_user_" #size \
 		:"=a" (ret),"=d" (x) \
-		:"0" (ptr))
+		:"0" (ptr), "1" (current))
 
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
 #define get_user(x,ptr)							\
diff -urN kernels/2.4/v2.4.15-pre4/include/linux/per_cpu.h tr-2.4.15-pre4.diff/include/linux/per_cpu.h
--- kernels/2.4/v2.4.15-pre4/include/linux/per_cpu.h	Wed Dec 31 19:00:00 1969
+++ tr-2.4.15-pre4.diff/include/linux/per_cpu.h	Mon Nov 12 23:40:39 2001
@@ -0,0 +1,32 @@
+#ifndef __LINUX__PER_CPU__H
+#define __LINUX__PER_CPU__H
+
+#define LOG2_PER_CPU_SIZE	8
+#define PER_CPU_SIZE		(1 << LOG2_PER_CPU_SIZE)
+
+#ifndef __ASSEMBLY__
+struct task_struct;
+
+struct per_cpu_data {
+	/* Assembly code relies on curr being the first member of this 
+	 * structure.  Please change it if this gets rearranged.
+	 */
+	struct task_struct	*curr;
+	cycles_t		last_schedule;
+};
+
+union aligned_data {
+	struct per_cpu_data	data;
+	char __pad [PER_CPU_SIZE];
+
+	/* Make sure the padding is large enough by forcing an error 
+	 * if it isn't.  -ben
+	 */
+	char __pad2 [PER_CPU_SIZE - sizeof(struct per_cpu_data)];
+};
+
+extern union aligned_data aligned_data[];
+
+#define per_data(nr)	(&aligned_data[nr].data)
+#endif
+#endif
diff -urN kernels/2.4/v2.4.15-pre4/init/main.c tr-2.4.15-pre4.diff/init/main.c
--- kernels/2.4/v2.4.15-pre4/init/main.c	Mon Nov 12 17:51:08 2001
+++ tr-2.4.15-pre4.diff/init/main.c	Mon Nov 12 23:40:39 2001
@@ -548,7 +548,6 @@
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
-	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
 	printk("Kernel command line: %s\n", saved_command_line);
@@ -559,6 +558,13 @@
 	softirq_init();
 	time_init();
 
+	/* At the very least, this has to come after trap_init as x86
+	 * needs to perform CPU setup before current is valid.  This 
+	 * should be okay as we're still running with interrupts disabled 
+	 * and no other CPUs are up yet.  -ben
+	 */
+	lock_kernel();
+
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
 	 * we've done PCI setups etc, and console_init() must be aware of
@@ -594,6 +600,9 @@
 	mempages = num_physpages;
 
 	fork_init(mempages);
+#ifdef __i386__
+	init_tsk_allocator();
+#endif
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
diff -urN kernels/2.4/v2.4.15-pre4/kernel/ksyms.c tr-2.4.15-pre4.diff/kernel/ksyms.c
--- kernels/2.4/v2.4.15-pre4/kernel/ksyms.c	Mon Nov 12 17:49:51 2001
+++ tr-2.4.15-pre4.diff/kernel/ksyms.c	Mon Nov 12 23:40:39 2001
@@ -446,6 +446,7 @@
 
 EXPORT_SYMBOL(kstat);
 EXPORT_SYMBOL(nr_running);
+EXPORT_SYMBOL(aligned_data);
 
 /* misc */
 EXPORT_SYMBOL(panic);
diff -urN kernels/2.4/v2.4.15-pre4/kernel/sched.c tr-2.4.15-pre4.diff/kernel/sched.c
--- kernels/2.4/v2.4.15-pre4/kernel/sched.c	Mon Nov 12 17:51:08 2001
+++ tr-2.4.15-pre4.diff/kernel/sched.c	Tue Nov 13 02:07:32 2001
@@ -28,6 +28,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>
 #include <linux/prefetch.h>
+#include <linux/per_cpu.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -97,16 +98,10 @@
  * We align per-CPU scheduling data on cacheline boundaries,
  * to prevent cacheline ping-pong.
  */
-static union {
-	struct schedule_data {
-		struct task_struct * curr;
-		cycles_t last_schedule;
-	} schedule_data;
-	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+union aligned_data aligned_data[NR_CPUS] __cacheline_aligned;
 
-#define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
-#define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#define cpu_curr(cpu)		per_data(cpu)->curr
+#define last_schedule(cpu)	per_data(cpu)->last_schedule
 
 struct kernel_stat kstat;
 extern struct task_struct *child_reaper;
@@ -532,7 +527,7 @@
  */
 asmlinkage void schedule(void)
 {
-	struct schedule_data * sched_data;
+	struct per_cpu_data * sched_data;
 	struct task_struct *prev, *next, *p;
 	struct list_head *tmp;
 	int this_cpu, c;
@@ -543,7 +538,7 @@
 	if (!current->active_mm) BUG();
 need_resched_back:
 	prev = current;
-	this_cpu = prev->processor;
+	this_cpu = smp_processor_id();	/* This better than current->processor on up */
 
 	if (in_interrupt())
 		goto scheduling_in_interrupt;
@@ -554,7 +549,7 @@
 	 * 'sched_data' is protected by the fact that we can run
 	 * only one process per CPU.
 	 */
-	sched_data = & aligned_data[this_cpu].schedule_data;
+	sched_data = per_data(this_cpu);
 
 	spin_lock_irq(&runqueue_lock);
 
@@ -1057,7 +1052,7 @@
 	// Subtract non-idle processes running on other CPUs.
 	for (i = 0; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i);
-		if (aligned_data[cpu].schedule_data.curr != idle_task(cpu))
+		if (per_data(cpu)->curr != idle_task(cpu))
 			nr_pending--;
 	}
 #else
@@ -1309,17 +1304,18 @@
 
 void __init init_idle(void)
 {
-	struct schedule_data * sched_data;
-	sched_data = &aligned_data[smp_processor_id()].schedule_data;
+	struct per_cpu_data * sched_data;
+	int cpu = smp_processor_id();
+	sched_data = per_data(cpu);
 
 	if (current != &init_task && task_on_runqueue(current)) {
 		printk("UGH! (%d:%d) was on the runqueue, removing.\n",
-			smp_processor_id(), current->pid);
+			cpu, current->pid);
 		del_from_runqueue(current);
 	}
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
-	clear_bit(current->processor, &wait_init_idle);
+	clear_bit(cpu, &wait_init_idle);
 }
 
 extern void init_timervecs (void);
