Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKIAG4>; Thu, 8 Nov 2001 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278841AbRKIAGs>; Thu, 8 Nov 2001 19:06:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:23480 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278879AbRKIAGo>; Thu, 8 Nov 2001 19:06:44 -0500
Date: Thu, 8 Nov 2001 19:06:43 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [bcrl@redhat.com: [PATCH] take 2 of the tr-based current]
Message-ID: <20011108190643.B29741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arrgh, forgot to cc l-k.

----- Forwarded message from Benjamin LaHaise <bcrl@redhat.com> -----

Date: Thu, 8 Nov 2001 19:05:46 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan Van de Ven <arjanv@redhat.com>
Subject: [PATCH] take 2 of the tr-based current

Hey folks,

Here's another take of the current-from-TR patch against 2.4.13-ac8.  This 
fixes the per_cpu_data array madness by taking schedule's per cpu array 
and moving it into linux/per_cpu.h.  The LOG2_PER_CPU_SIZE macro should 
probably be automatically generated, but I'm lazy and someone else can do 
that.  Also, I removed the assembly GET_CURRENT macro from get_user.S and 
put it into C code as a parameter to the __asm__ magic.  That part could 
just use the current_asm.h macro, but I'd rather let the compiler take care 
of it as optimizations across multiple calls would be nice.

If other people could bang on this a bit and post any problems, I'd 
appreciate it.  tia,

		-ben
-- 
Fish.


diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/kernel/entry.S v2.4.13-ac8+tr.2/arch/i386/kernel/entry.S
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/entry.S	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.2/arch/i386/kernel/entry.S	Wed Nov  7 02:58:41 2001
@@ -45,6 +45,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/current_asm.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -134,9 +135,6 @@
 	.long 3b,6b;	\
 .previous
 
-#define GET_CURRENT(reg) \
-	movl %cr2, reg
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
@@ -149,7 +147,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -170,7 +168,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
@@ -184,7 +182,7 @@
 	pushl %ebx
 	call SYMBOL_NAME(schedule_tail)
 	addl $4, %esp
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
 	jne tracesys_exit
 	jmp	ret_from_sys_call
@@ -199,7 +197,7 @@
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	cmpl $(NR_syscalls),%eax
 	jae badsys
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
@@ -251,7 +249,7 @@
 
 	ALIGN
 ENTRY(ret_from_intr)
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 ret_from_exception:
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
 	movb CS(%esp),%al
@@ -297,7 +295,7 @@
 	movl %edx,%ds
 2:	call *%edi
 	addl $8,%esp
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
@@ -313,7 +311,7 @@
 ENTRY(device_not_available)
 	pushl $-1		# mark this as an int
 	SAVE_ALL
-	GET_CURRENT(%ebx)
+	GET_CURRENT(%ebx,%bx)
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
 	jne device_not_available_emulate
diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/kernel/ldt.c v2.4.13-ac8+tr.2/arch/i386/kernel/ldt.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/ldt.c	Thu Nov  1 16:39:57 2001
+++ v2.4.13-ac8+tr.2/arch/i386/kernel/ldt.c	Thu Nov  8 18:25:56 2001
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
diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c v2.4.13-ac8+tr.2/arch/i386/kernel/nmi.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.2/arch/i386/kernel/nmi.c	Tue Nov  6 23:13:03 2001
@@ -264,7 +264,7 @@
 	/*
 	 * NMI can interrupt page faults, use hard_get_current.
 	 */
-	int sum, cpu = hard_get_current()->processor;
+	int sum, cpu = smp_processor_id();
 
 	sum = apic_timer_irqs[cpu];
 
@@ -280,7 +280,6 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
-			set_current(hard_get_current());
 			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/kernel/setup.c v2.4.13-ac8+tr.2/arch/i386/kernel/setup.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/setup.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.2/arch/i386/kernel/setup.c	Wed Nov  7 00:49:49 2001
@@ -108,6 +108,7 @@
 #include <asm/cobalt.h>
 #include <asm/msr.h>
 #include <asm/desc.h>
+#include <asm/descfn.h>
 #include <asm/e820.h>
 #include <asm/dma.h>
 #include <asm/mpspec.h>
@@ -2852,8 +2853,9 @@
  */
 void __init cpu_init (void)
 {
-	int nr = smp_processor_id();
+	int nr = hard_smp_processor_id();
 	struct tss_struct * t = &init_tss[nr];
+	struct task_struct *cur;
 
 	if (test_and_set_bit(nr, &cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", nr);
@@ -2884,17 +2886,19 @@
 	 * set up and load the per-CPU TSS and LDT
 	 */
 	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-	if(current->mm)
-		BUG();
-	enter_lazy_tlb(&init_mm, current, nr);
+	cur = hard_get_current();
 
-	t->esp0 = current->thread.esp0;
+	t->esp0 = cur->thread.esp0;
 	set_tss_desc(nr,t);
 	gdt_table[__TSS(nr)].b &= 0xfffffdff;
 	load_TR(nr);
 	load_LDT(&init_mm);
 
+	cur->active_mm = &init_mm;
+	if(cur->mm)
+		BUG();
+	enter_lazy_tlb(&init_mm, cur, nr);
+
 	/*
 	 * Clear all 6 debug registers:
 	 */
diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/lib/getuser.S v2.4.13-ac8+tr.2/arch/i386/lib/getuser.S
--- kernels/2.4/v2.4.13-ac8/arch/i386/lib/getuser.S	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.2/arch/i386/lib/getuser.S	Wed Nov  7 22:33:07 2001
@@ -8,6 +8,7 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <asm/current_asm.h>
 
 /*
  * __get_user_X
@@ -27,7 +28,6 @@
 .align 4
 .globl __get_user_1
 __get_user_1:
-	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -39,7 +39,6 @@
 __get_user_2:
 	addl $1,%eax
 	jc bad_get_user
-	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -51,7 +50,6 @@
 __get_user_4:
 	addl $3,%eax
 	jc bad_get_user
-	movl %cr2,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -urN kernels/2.4/v2.4.13-ac8/arch/i386/mm/fault.c v2.4.13-ac8+tr.2/arch/i386/mm/fault.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/mm/fault.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.2/arch/i386/mm/fault.c	Wed Nov  7 15:56:01 2001
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/hardirq.h>
+#include <asm/desc.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -148,7 +149,6 @@
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
-extern unsigned long idt;
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -173,14 +173,13 @@
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
-	/* and restore current */
-	tsk = hard_get_current();
-	set_current(tsk);
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
 
+	tsk = current;
+
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -309,7 +308,7 @@
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt) >> 3;
+		nr = (address - (unsigned long)idt) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/current.h v2.4.13-ac8+tr.2/include/asm-i386/current.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/current.h	Tue Nov  6 20:43:27 2001
+++ v2.4.13-ac8+tr.2/include/asm-i386/current.h	Wed Nov  7 17:58:08 2001
@@ -1,28 +1,22 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-struct task_struct;
+#include <linux/per_cpu.h>
 
 static inline struct task_struct * get_current(void)
 {
-	struct task_struct *tsk;
-	__asm__("movl %%cr2,%0;": "=r" (tsk));
-	return tsk;
+	return per_data(smp_processor_id())->curr;
 }
 
 /* for within NMI, do_page_fault, cpu_init */
 static inline struct task_struct * hard_get_current(void)
 {
-	struct task_struct **ptsk;
-	__asm__("andl %%esp,%0; ":"=r" (ptsk) : "0" (~8191UL));
-	return *ptsk;
+	return per_data(hard_smp_processor_id())->curr;
 }
 
 static inline void set_current(struct task_struct *tsk)
 {
-	__asm__("movl %0,%%cr2;"
-			: /* no output */
-			:"r" (tsk));
+	per_data(hard_smp_processor_id())->curr = tsk;
 }
    
 /* Note: the implementation is hardcoded into arch/i386/lib/getuser.S */
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/current_asm.h v2.4.13-ac8+tr.2/include/asm-i386/current_asm.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/current_asm.h	Wed Dec 31 19:00:00 1969
+++ v2.4.13-ac8+tr.2/include/asm-i386/current_asm.h	Thu Nov  8 18:26:14 2001
@@ -0,0 +1,15 @@
+/* asm/current_asm.h
+ */
+#include <asm/desc.h>
+#include <linux/per_cpu.h>
+
+/* Pass in the long and word versions of the registers.
+ * eg GET_CURRENT(%ebx,%bx)
+ * Note: str does clear the high 16 bits of the register.
+ */
+#define GET_CURRENT(reg, regw)				\
+	str regw					\
+	; shll $LOG2_PER_CPU_SIZE-2,reg			\
+	; aligned_data_adjusted = aligned_data-(__FIRST_TSS_ENTRY << (3 + LOG2_PER_CPU_SIZE - 2))	\
+	; movl aligned_data_adjusted(reg),reg
+
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/desc.h v2.4.13-ac8+tr.2/include/asm-i386/desc.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/desc.h	Tue Nov  6 20:43:27 2001
+++ v2.4.13-ac8+tr.2/include/asm-i386/desc.h	Tue Nov  6 21:21:32 2001
@@ -68,40 +68,6 @@
 
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
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/descfn.h v2.4.13-ac8+tr.2/include/asm-i386/descfn.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/descfn.h	Wed Dec 31 19:00:00 1969
+++ v2.4.13-ac8+tr.2/include/asm-i386/descfn.h	Tue Nov  6 21:23:59 2001
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
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/mmu_context.h v2.4.13-ac8+tr.2/include/asm-i386/mmu_context.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/mmu_context.h	Tue Nov  6 21:23:24 2001
+++ v2.4.13-ac8+tr.2/include/asm-i386/mmu_context.h	Thu Nov  8 18:57:00 2001
@@ -5,6 +5,7 @@
 #include <asm/desc.h>
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
+#include <asm/descfn.h>
 
 /*
  * possibly do the LDT unload here?
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/smp.h v2.4.13-ac8+tr.2/include/asm-i386/smp.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/smp.h	Tue Nov  6 21:00:35 2001
+++ v2.4.13-ac8+tr.2/include/asm-i386/smp.h	Thu Nov  8 18:56:50 2001
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/ptrace.h>
+#include <asm/desc.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -101,7 +102,14 @@
  * so this is correct in the x86 case.
  */
 
-#define smp_processor_id() (current->processor)
+static unsigned get_TR(void) __attribute__ ((pure))
+{
+	unsigned tr;
+	__asm__("str %w0" : "=g" (tr));
+	return tr;
+}
+
+#define smp_processor_id()	( ((get_TR() >> 3) - __FIRST_TSS_ENTRY) >> 2 )
 
 static __inline int hard_smp_processor_id(void)
 {
diff -urN kernels/2.4/v2.4.13-ac8/include/asm-i386/uaccess.h v2.4.13-ac8+tr.2/include/asm-i386/uaccess.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/uaccess.h	Wed Nov  7 18:09:12 2001
+++ v2.4.13-ac8+tr.2/include/asm-i386/uaccess.h	Thu Nov  8 18:59:41 2001
@@ -109,7 +109,7 @@
 #define __get_user_x(size,ret,x,ptr) \
 	__asm__ __volatile__("call __get_user_" #size \
 		:"=a" (ret),"=d" (x) \
-		:"0" (ptr))
+		:"0" (ptr), "1" (current))
 
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
 #define get_user(x,ptr)							\
diff -urN kernels/2.4/v2.4.13-ac8/include/linux/per_cpu.h v2.4.13-ac8+tr.2/include/linux/per_cpu.h
--- kernels/2.4/v2.4.13-ac8/include/linux/per_cpu.h	Wed Dec 31 19:00:00 1969
+++ v2.4.13-ac8+tr.2/include/linux/per_cpu.h	Thu Nov  8 18:27:10 2001
@@ -0,0 +1,26 @@
+#ifndef __LINUX__PER_CPU__H
+#define __LINUX__PER_CPU__H
+
+#define LOG2_PER_CPU_SIZE	8
+
+#ifndef __ASSEMBLY__
+struct task_struct;
+
+struct per_cpu_data {
+	struct task_struct	*curr;
+	cycles_t		last_schedule;
+};
+
+union aligned_data {
+	struct per_cpu_data	data;
+	char __pad [1 << LOG2_PER_CPU_SIZE];
+
+	/* Make sure the padding is large enough */
+	char __pad2 [(1 << LOG2_PER_CPU_SIZE) - sizeof(struct per_cpu_data)];
+};
+
+extern union aligned_data aligned_data[];
+
+#define per_data(nr)	(&aligned_data[nr].data)
+#endif
+#endif
diff -urN kernels/2.4/v2.4.13-ac8/kernel/sched.c v2.4.13-ac8+tr.2/kernel/sched.c
--- kernels/2.4/v2.4.13-ac8/kernel/sched.c	Tue Nov  6 20:43:28 2001
+++ v2.4.13-ac8+tr.2/kernel/sched.c	Wed Nov  7 17:49:00 2001
@@ -28,6 +28,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>
 #include <linux/prefetch.h>
+#include <linux/per_cpu.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -97,16 +98,12 @@
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
+union aligned_data aligned_data[NR_CPUS] __cacheline_aligned = {
+	{{&init_task,0}}
+};
 
-#define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
-#define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#define cpu_curr(cpu)		per_data(cpu)->curr
+#define last_schedule(cpu)	per_data(cpu)->last_schedule
 
 struct kernel_stat kstat;
 extern struct task_struct *child_reaper;
@@ -532,7 +529,7 @@
  */
 asmlinkage void schedule(void)
 {
-	struct schedule_data * sched_data;
+	struct per_cpu_data * sched_data;
 	struct task_struct *prev, *next, *p;
 	struct list_head *tmp;
 	int this_cpu, c;
@@ -543,7 +540,7 @@
 	if (!current->active_mm) BUG();
 need_resched_back:
 	prev = current;
-	this_cpu = prev->processor;
+	this_cpu = smp_processor_id();	/* This better than current->processor on up */
 
 	if (in_interrupt())
 		goto scheduling_in_interrupt;
@@ -554,7 +551,7 @@
 	 * 'sched_data' is protected by the fact that we can run
 	 * only one process per CPU.
 	 */
-	sched_data = & aligned_data[this_cpu].schedule_data;
+	sched_data = per_data(this_cpu);
 
 	spin_lock_irq(&runqueue_lock);
 
@@ -1057,7 +1054,7 @@
 	// Subtract non-idle processes running on other CPUs.
 	for (i = 0; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i);
-		if (aligned_data[cpu].schedule_data.curr != idle_task(cpu))
+		if (per_data(cpu)->curr != idle_task(cpu))
 			nr_pending--;
 	}
 #else
@@ -1309,17 +1306,18 @@
 
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

----- End forwarded message -----

-- 
Fish.
