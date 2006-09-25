Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWIYF0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWIYF0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWIYF0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:26:33 -0400
Received: from ozlabs.org ([203.10.76.45]:55981 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751528AbWIYF0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:26:32 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <1159147253.26986.34.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org> <20060923081337.GA10534@muc.de>
	 <45172BCE.4010708@goop.org>
	 <1159147253.26986.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 15:26:24 +1000
Message-Id: <1159161985.26986.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 11:20 +1000, Rusty Russell wrote:
> On Sun, 2006-09-24 at 18:07 -0700, Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > >> I managed to get all this done in head.S before going into C code; is 
> > >> that not still possible?  Or is there a later patch to do this.
> > >>     
> > >
> > > Why write in assembler what you can write in C?
> > >   
> > This stuff is very basic, and you could consider it as being part of the 
> > kernel's C runtime model, and therefore can be expected to be available 
> > everywhere.  In particular, the use of current is so prevalent that you 
> > really can't call anything without having the PDA set up.
> 
> Yeah, I agree with Jeremy.  It's nice if we can just use it everywhere,
> and he kindly explained to me that secondary CPUs we can do most of it
> before the CPU bringup (ie. in C): we just have to load the gs register
> in asm AFAICT.
> 
> I'll produce a patch, so we can see what we're talking about...

Actually, it's quite sweet!  We have a pointer to the currently booting
CPU's GDT descriptor and load that in asm (only one additional insn),
and the C code is significantly simpler.  Here is a replacement for
patch 5/7, and I'll post updated (simplified) 6/7 and 7/7 separately.

Thanks Jeremy!
Rusty.

====
This patch actually uses the gs register to implement the per-cpu
sections.  It's fairly straightforward: the gs segment starts at the
per-cpu offset for the particular cpu (or 0, in very early boot).  

Jeremy Fitzhardinge points out that if we set up %gs correctly in asm,
we can always use per-cpu variables (eg. smp_processor_id() and
current()) in C code.  As he intimated, this is quite clean.

We keep a "booting_cpu_gdt_desc_ptr".  It's statically initialized to
the master per-cpu gdt descriptor, and then updated to point to the
current cpu's GDT descriptor as CPUs come up.  This keeps the asm much
the same as before.

We also implement x86_64-inspired (via Jeremy Fitzhardinge) per-cpu
accesses where a general lvalue isn't needed.  These
single-instruction accesses are slightly more efficient, plus (being a
single insn) are atomic wrt. preemption so we can use them to
implement cpu_local_inc etc.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-fresh/arch/i386/kernel/cpu/common.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/cpu/common.c	2006-09-25 14:15:32.000000000 +1000
+++ ak-fresh/arch/i386/kernel/cpu/common.c	2006-09-25 14:21:40.000000000 +1000
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mtrr.h>
 #include <asm/mce.h>
+#include <asm/smp.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
@@ -601,12 +602,19 @@
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
-	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}
+
+	/* Set up GDT entry for 16bit stack */
+	gdt = __get_cpu_var(cpu_gdt_table);
+	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
+		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
+		(CPU_16BIT_STACK_SIZE - 1);
+
 	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
@@ -618,17 +626,6 @@
 		set_in_cr4(X86_CR4_TSD);
 	}
 
-	/* Set up GDT entry for 16bit stack */
-	gdt = __get_cpu_var(cpu_gdt_table);
- 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
-		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
-		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
-		(CPU_16BIT_STACK_SIZE - 1);
-
-	cpu_gdt_descr->size = GDT_SIZE - 1;
- 	cpu_gdt_descr->address = (unsigned long)gdt;
-
-	load_gdt(cpu_gdt_descr);
 	load_idt(&idt_descr);
 
 	/*
Index: ak-fresh/arch/i386/kernel/smpboot.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/smpboot.c	2006-09-25 14:15:32.000000000 +1000
+++ ak-fresh/arch/i386/kernel/smpboot.c	2006-09-25 14:38:46.000000000 +1000
@@ -102,6 +102,9 @@
 			{ [0 ... NR_CPUS-1] = 0xff };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
 
+DEFINE_PER_CPU(unsigned long, this_cpu_off);
+EXPORT_PER_CPU_SYMBOL(this_cpu_off);
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -916,6 +919,31 @@
 #define alloc_idle_task(cpu) fork_idle(cpu)
 #endif
 
+static __cpuinit void setup_percpu_descriptor(struct desc_struct *gdt,
+					      unsigned long per_cpu_off)
+{
+	unsigned limit, flags;
+
+	limit = (1 << 20);
+	flags = 0x8;		/* 4k granularity */
+
+	/* present read-write data segment */
+	pack_descriptor((u32 *)&gdt->a, (u32 *)&gdt->b,
+			per_cpu_off, limit - 1,
+			0x80 | DESCTYPE_S | 0x2, flags);
+}
+
+static void __init setup_percpu(unsigned int cpu)
+{
+	struct desc_struct *gdt = per_cpu(cpu_gdt_table, cpu);
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+
+	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
+	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
+	cpu_gdt_descr->address = (unsigned long)gdt;
+	cpu_gdt_descr->size = GDT_SIZE - 1;
+}
+
 static int __devinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
@@ -940,6 +968,10 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	idle->thread.eip = (unsigned long) start_secondary;
+
+ 	setup_percpu(cpu);
+ 	booting_cpu_gdt_desc_ptr = &per_cpu(cpu_gdt_descr, cpu);
+
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
 
@@ -1303,6 +1335,14 @@
 		synchronize_tsc_bp();
 }
 
+static inline void set_kernel_gs(void)
+{
+	/* Set %gs for this CPU's per-cpu area.  Memory clobber is to create a
+	   barrier with respect to any per-cpu operations, so the compiler
+	   doesn't move any before here. */
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PERCPU) : "memory");
+}
+
 /* These are wrappers to interface to the new boot process.  Someone
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -1315,6 +1355,18 @@
 
 void __devinit smp_prepare_boot_cpu(void)
 {
+	/* Move over to our per-cpu area now it's allocated. */
+	unsigned int cpu = smp_processor_id();
+	struct desc_struct *gdt = per_cpu(cpu_gdt_table, cpu);
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+
+	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
+	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
+	cpu_gdt_descr->address = (unsigned long)gdt;
+	cpu_gdt_descr->size = GDT_SIZE - 1;
+	load_gdt(cpu_gdt_descr);
+	set_kernel_gs();
+
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_present_map);
Index: ak-fresh/include/asm-i386/percpu.h
===================================================================
--- ak-fresh.orig/include/asm-i386/percpu.h	2006-09-25 14:15:32.000000000 +1000
+++ ak-fresh/include/asm-i386/percpu.h	2006-09-25 14:21:40.000000000 +1000
@@ -1,6 +1,107 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__
 
+#ifdef CONFIG_SMP
+/* Same as generic implementation except for optimized local access. */
+#define __GENERIC_PER_CPU
+
+/* This is used for other cpus to find our section. */
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* Separate out the type, so (int[3], foo) works. */
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+
+/* We can use this directly for local CPU (faster). */
+DECLARE_PER_CPU(unsigned long, this_cpu_off);
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
+
+#define __raw_get_cpu_var(var) (*({					\
+	extern int simple_indentifier_##var(void);			\
+	RELOC_HIDE(&per_cpu__##var, x86_read_percpu(this_cpu_off));	\
+}))
+
+#define __get_cpu_var(var) __raw_get_cpu_var(var)
+
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)			\
+do {								\
+	unsigned int __i;					\
+	for_each_possible_cpu(__i)				\
+		memcpy((pcpudst)+__per_cpu_offset[__i],		\
+		       (src), (size));				\
+} while (0)
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
+/* gs segment starts at (positive) offset == __per_cpu_offset[cpu] */
+#define __percpu_seg "%%gs:"
+#else  /* !SMP */
 #include <asm-generic/percpu.h>
+#define __percpu_seg ""
+#endif	/* SMP */
+
+/* For arch-specific code, we can use direct single-insn ops (they
+ * don't give an lvalue though). */
+extern void __bad_percpu_size(void);
+
+#define percpu_to_op(op,var,val)				\
+	do {							\
+		typedef typeof(var) T__;			\
+		if (0) { T__ tmp__; tmp__ = (val); }		\
+		switch (sizeof(var)) {				\
+		case 1:						\
+			asm(op "b %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		case 2:						\
+			asm(op "w %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		case 4:						\
+			asm(op "l %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		default: __bad_percpu_size();			\
+		}						\
+	} while (0)
+
+#define percpu_from_op(op,var)					\
+	({							\
+		typeof(var) ret__;				\
+		switch (sizeof(var)) {				\
+		case 1:						\
+			asm(op "b "__percpu_seg"%1,%0"		\
+			    : "=r" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		case 2:						\
+			asm(op "w "__percpu_seg"%1,%0"		\
+			    : "=r" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		case 4:						\
+			asm(op "l "__percpu_seg"%1,%0"		\
+			    : "=r" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		default: __bad_percpu_size();			\
+		}						\
+		ret__; })
+
+#define x86_read_percpu(var) percpu_from_op("mov", per_cpu__##var)
+#define x86_write_percpu(var,val) percpu_to_op("mov", per_cpu__##var, val)
+#define x86_add_percpu(var,val) percpu_to_op("add", per_cpu__##var, val)
+#define x86_sub_percpu(var,val) percpu_to_op("sub", per_cpu__##var, val)
+#define x86_or_percpu(var,val) percpu_to_op("or", per_cpu__##var, val)
 
 #endif /* __ARCH_I386_PERCPU__ */
Index: ak-fresh/include/asm-i386/smp.h
===================================================================
--- ak-fresh.orig/include/asm-i386/smp.h	2006-09-25 14:15:32.000000000 +1000
+++ ak-fresh/include/asm-i386/smp.h	2006-09-25 14:21:40.000000000 +1000
@@ -86,6 +86,8 @@
 extern void __cpu_die(unsigned int cpu);
 extern unsigned int num_processors;
 
+void setup_percpu_for_this_cpu(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
@@ -94,6 +96,8 @@
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
+#define setup_percpu_for_this_cpu(cpu)
+
 #endif
 
 #ifndef __ASSEMBLY__
Index: ak-fresh/arch/i386/kernel/setup.c
===================================================================
--- ak-fresh.orig/arch/i386/kernel/setup.c	2006-09-25 14:15:32.000000000 +1000
+++ ak-fresh/arch/i386/kernel/setup.c	2006-09-25 14:21:40.000000000 +1000
@@ -1474,6 +1474,8 @@
 
 	/* ESPFIX 16-bit SS */
 	[GDT_ENTRY_ESPFIX_SS] = { 0x00000000, 0x00009200 },
+	/* FIXME: We save/restore %gs even on UP: fix entry.S. */
+	[GDT_ENTRY_PERCPU] = { 0x0000ffff, 0x00cf9200 },
 };
 
 /* Early in boot we use the master per-cpu gdt_table directly. */
@@ -1481,6 +1483,8 @@
 = { .size = GDT_ENTRIES*8-1, .address = (long)&per_cpu__cpu_gdt_table };
 EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
 
+struct Xgt_desc_struct *booting_cpu_gdt_desc_ptr = &per_cpu__cpu_gdt_descr;
+
 static __init int add_pcspkr(void)
 {
 	struct platform_device *pd;
Index: ak-fresh/arch/i386/kernel/head.S
===================================================================
--- ak-fresh.orig/arch/i386/kernel/head.S	2006-09-25 14:13:34.000000000 +1000
+++ ak-fresh/arch/i386/kernel/head.S	2006-09-25 14:21:40.000000000 +1000
@@ -302,7 +302,8 @@
 	movl %eax,%cr0
 
 	call check_x87
-	lgdt per_cpu__cpu_gdt_descr
+	movl booting_cpu_gdt_desc_ptr, %eax
+	lgdt (%eax)
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
@@ -311,10 +312,11 @@
 	movl $(__USER_DS),%eax		# DS/ES contains default USER segment
 	movl %eax,%ds
 	movl %eax,%es
+	movl $(__KERNEL_PERCPU),%eax
+	mov  %eax,%gs
 
-	xorl %eax,%eax			# Clear FS/GS and LDT
+	xorl %eax,%eax			# Clear FS and LDT
 	movl %eax,%fs
-	movl %eax,%gs
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
 	pushl %eax		# fake return address

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

