Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280740AbRKJWeN>; Sat, 10 Nov 2001 17:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280736AbRKJWd4>; Sat, 10 Nov 2001 17:33:56 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20727 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280740AbRKJWde>; Sat, 10 Nov 2001 17:33:34 -0500
Date: Sat, 10 Nov 2001 17:33:31 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] final cur of tr based current for -ac8
Message-ID: <20011110173331.F17437@redhat.com>
In-Reply-To: <20011110141440.C17437@redhat.com> <20011110203348.A98674@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011110203348.A98674@compsoc.man.ac.uk>; from moz@compsoc.man.ac.uk on Sat, Nov 10, 2001 at 08:33:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 08:33:48PM +0000, John Levon wrote:
> I'm running with the patch now. Seems stable (ac8 crashed pretty quickly for me).

Thanks...  I seem to have blotched the SMP side of things (again) which this 
might fix (including the symbol export from you).  Also, Michael Barabanov 
came up with a patch using the same trick, although I haven't seen it.

		-ben

... v2.4.13-ac8+tr.4.diff ...
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/entry.S v2.4.13-ac8+tr.4/arch/i386/kernel/entry.S
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/entry.S	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/kernel/entry.S	Thu Nov  8 22:27:30 2001
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
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/ldt.c v2.4.13-ac8+tr.4/arch/i386/kernel/ldt.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/ldt.c	Thu Nov  1 16:39:57 2001
+++ v2.4.13-ac8+tr.4/arch/i386/kernel/ldt.c	Thu Nov  8 18:25:56 2001
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
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c v2.4.13-ac8+tr.4/arch/i386/kernel/nmi.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/nmi.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/kernel/nmi.c	Sat Nov 10 14:00:33 2001
@@ -264,7 +264,7 @@
 	/*
 	 * NMI can interrupt page faults, use hard_get_current.
 	 */
-	int sum, cpu = hard_get_current()->processor;
+	int sum, cpu = hard_smp_processor_id();
 
 	sum = apic_timer_irqs[cpu];
 
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/setup.c v2.4.13-ac8+tr.4/arch/i386/kernel/setup.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/setup.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/kernel/setup.c	Sat Nov 10 16:56:23 2001
@@ -108,6 +108,7 @@
 #include <asm/cobalt.h>
 #include <asm/msr.h>
 #include <asm/desc.h>
+#include <asm/descfn.h>
 #include <asm/e820.h>
 #include <asm/dma.h>
 #include <asm/mpspec.h>
@@ -2852,7 +2853,8 @@
  */
 void __init cpu_init (void)
 {
-	int nr = smp_processor_id();
+	struct task_struct *cur = hard_get_current();
+	int nr = cur->processor;
 	struct tss_struct * t = &init_tss[nr];
 
 	if (test_and_set_bit(nr, &cpu_initialized)) {
@@ -2884,17 +2886,19 @@
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
 
+	set_current(cur);
+
 	/*
 	 * Clear all 6 debug registers:
 	 */
@@ -2908,8 +2912,8 @@
 	/*
 	 * Force FPU initialization:
 	 */
-	current->flags &= ~PF_USEDFPU;
-	current->used_math = 0;
+	cur->flags &= ~PF_USEDFPU;
+	cur->used_math = 0;
 	stts();
 }
 
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/kernel/smpboot.c v2.4.13-ac8+tr.4/arch/i386/kernel/smpboot.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/kernel/smpboot.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/kernel/smpboot.c	Sat Nov 10 15:56:44 2001
@@ -507,14 +507,14 @@
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
@@ -522,12 +522,12 @@
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
 
@@ -538,11 +538,11 @@
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
 
@@ -553,11 +553,11 @@
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
 
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/lib/getuser.S v2.4.13-ac8+tr.4/arch/i386/lib/getuser.S
--- kernels/2.4/v2.4.13-ac8/arch/i386/lib/getuser.S	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/lib/getuser.S	Wed Nov  7 22:33:07 2001
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
diff -ur kernels/2.4/v2.4.13-ac8/arch/i386/mm/fault.c v2.4.13-ac8+tr.4/arch/i386/mm/fault.c
--- kernels/2.4/v2.4.13-ac8/arch/i386/mm/fault.c	Tue Nov  6 20:43:22 2001
+++ v2.4.13-ac8+tr.4/arch/i386/mm/fault.c	Sat Nov 10 14:03:13 2001
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
@@ -173,9 +173,11 @@
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
+
 	/* and restore current */
-	tsk = hard_get_current();
-	set_current(tsk);
+	set_current(hard_get_current());
+	tsk = current;
+
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
@@ -309,7 +311,7 @@
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt) >> 3;
+		nr = (address - (unsigned long)idt) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/current.h v2.4.13-ac8+tr.4/include/asm-i386/current.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/current.h	Tue Nov  6 20:43:27 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/current.h	Sat Nov 10 16:32:06 2001
@@ -1,18 +1,22 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-struct task_struct;
+#include <linux/per_cpu.h>
 
-static inline struct task_struct * get_current(void)
+//static inline struct task_struct *get_current(void) __attribute__((pure));
+static inline struct task_struct *get_current(void)
 {
-	struct task_struct *tsk;
-	__asm__("movl %%cr2,%0;": "=r" (tsk));
-	return tsk;
+	return per_data(smp_processor_id())->curr;
 }
 
 /* for within NMI, do_page_fault, cpu_init */
 static inline struct task_struct * hard_get_current(void)
 {
+#if 0
+	int nr = hard_smp_processor_id();
+	nr = physical_apicid_to_cpu[nr];
+	return per_data(nr)->curr;
+#endif
 	struct task_struct **ptsk;
 	__asm__("andl %%esp,%0; ":"=r" (ptsk) : "0" (~8191UL));
 	return *ptsk;
@@ -20,9 +24,7 @@
 
 static inline void set_current(struct task_struct *tsk)
 {
-	__asm__("movl %0,%%cr2;"
-			: /* no output */
-			:"r" (tsk));
+	per_data(smp_processor_id())->curr = tsk;
 }
    
 /* Note: the implementation is hardcoded into arch/i386/lib/getuser.S */
Only in v2.4.13-ac8+tr.4/include/asm-i386: current_asm.h
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/desc.h v2.4.13-ac8+tr.4/include/asm-i386/desc.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/desc.h	Tue Nov  6 20:43:27 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/desc.h	Tue Nov  6 21:21:32 2001
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
Only in v2.4.13-ac8+tr.4/include/asm-i386: descfn.h
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/mmu_context.h v2.4.13-ac8+tr.4/include/asm-i386/mmu_context.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/mmu_context.h	Tue Nov  6 21:23:24 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/mmu_context.h	Sat Nov 10 16:02:56 2001
@@ -5,6 +5,7 @@
 #include <asm/desc.h>
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
+#include <asm/descfn.h>
 
 /*
  * possibly do the LDT unload here?
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/smp.h v2.4.13-ac8+tr.4/include/asm-i386/smp.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/smp.h	Tue Nov  6 21:00:35 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/smp.h	Sat Nov 10 16:02:52 2001
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/ptrace.h>
+#include <asm/desc.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -83,10 +84,10 @@
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
@@ -101,7 +102,20 @@
  * so this is correct in the x86 case.
  */
 
-#define smp_processor_id() (current->processor)
+static unsigned get_TR(void) __attribute__ ((pure));
+static unsigned get_TR(void)
+{
+	unsigned tr;
+	/* The PAIN!  The HORROR!
+	 * Technically this is wrong, wrong, wrong, but 
+	 * gas doesn't know about strl.  *sigh*  Please 
+	 * flog them with a wet noodle repeatedly.  -ben
+	 */
+	__asm__ __volatile__("str %w0" : "=r" (tr));
+	return tr;
+}
+
+#define smp_processor_id()	( ((get_TR() >> 3) - __FIRST_TSS_ENTRY) >> 2 )
 
 static __inline int hard_smp_processor_id(void)
 {
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/smpboot.h v2.4.13-ac8+tr.4/include/asm-i386/smpboot.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/smpboot.h	Fri Nov  9 23:55:07 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/smpboot.h	Sat Nov 10 15:57:58 2001
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
 
 
diff -ur kernels/2.4/v2.4.13-ac8/include/asm-i386/uaccess.h v2.4.13-ac8+tr.4/include/asm-i386/uaccess.h
--- kernels/2.4/v2.4.13-ac8/include/asm-i386/uaccess.h	Wed Nov  7 18:09:12 2001
+++ v2.4.13-ac8+tr.4/include/asm-i386/uaccess.h	Sat Nov 10 16:32:09 2001
@@ -109,7 +109,7 @@
 #define __get_user_x(size,ret,x,ptr) \
 	__asm__ __volatile__("call __get_user_" #size \
 		:"=a" (ret),"=d" (x) \
-		:"0" (ptr))
+		:"0" (ptr), "1" (current))
 
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
 #define get_user(x,ptr)							\
Only in v2.4.13-ac8+tr.4/include/linux: per_cpu.h
diff -ur kernels/2.4/v2.4.13-ac8/init/main.c v2.4.13-ac8+tr.4/init/main.c
--- kernels/2.4/v2.4.13-ac8/init/main.c	Tue Nov  6 20:43:28 2001
+++ v2.4.13-ac8+tr.4/init/main.c	Sat Nov 10 13:11:06 2001
@@ -635,7 +635,6 @@
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
-	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
 	printk("Kernel command line: %s\n", saved_command_line);
@@ -646,6 +645,13 @@
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
diff -ur kernels/2.4/v2.4.13-ac8/kernel/ksyms.c v2.4.13-ac8+tr.4/kernel/ksyms.c
--- kernels/2.4/v2.4.13-ac8/kernel/ksyms.c	Tue Nov  6 20:43:28 2001
+++ v2.4.13-ac8+tr.4/kernel/ksyms.c	Sat Nov 10 16:57:06 2001
@@ -447,6 +447,7 @@
 #endif
 EXPORT_SYMBOL(kstat);
 EXPORT_SYMBOL(nr_running);
+EXPORT_SYMBOL(aligned_data);
 
 /* misc */
 EXPORT_SYMBOL(panic);
diff -ur kernels/2.4/v2.4.13-ac8/kernel/sched.c v2.4.13-ac8+tr.4/kernel/sched.c
--- kernels/2.4/v2.4.13-ac8/kernel/sched.c	Tue Nov  6 20:43:28 2001
+++ v2.4.13-ac8+tr.4/kernel/sched.c	Sat Nov 10 16:29:58 2001
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
@@ -1334,6 +1330,7 @@
 	int nr;
 
 	init_task.processor = cpu;
+	set_current(&init_task);
 
 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
