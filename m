Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLQAmM>; Mon, 16 Dec 2002 19:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSLQAmM>; Mon, 16 Dec 2002 19:42:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262821AbSLQAl4>; Mon, 16 Dec 2002 19:41:56 -0500
Date: Mon, 16 Dec 2002 16:47:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021209193649.GC10316@suse.de>
Message-ID: <Pine.LNX.4.44.0212161639310.1623-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Dec 2002, Dave Jones wrote:
> 
> Time to look into an alternative like SYSCALL perhaps ?

Well, here's a very raw first try at using intel sysenter/sysexit.

It does actually work, I've done a "hello world" program that used 
sysenter to enter the kernel, but kernel exit requires knowing where to 
return to (the SYSENTER_RETURN define in entry.S), and I didn't set up a 
fixmap entry for this yet, so I don't have a good value to return to yet.

But this, together with a fixmap entry that is user-readable (and thus
executable) that contains the "sysenter" instruction (and enough setup so
that %ebp points to the stack we want to return with), and together with
some debugging should get you there.

WARNING! I may be setting up the stack slightly incorrectly, since this
also hurls chunks when debugging. Dunno. Ingo, care to take a look?

Btw, that per-CPU sysenter entry-point is really clever of me, but it's 
not strictly NMI-safe. There's a single-instruction window between having 
started "sysenter" and having a valid kernel stack, and if an NMI comes in 
at that point, the NMI will now have a bogus stack pointer.

That NMI problem is pretty fundamentally unfixable due to the stupid
sysenter semantics, but we could just make the NMI handlers be real
careful about it and fix it up if it happens.

Most of the diff here is actually moving around some of the segments, 
since sysenter/sysexit wants them in one particular order. The setup code 
to initialize sysenter is itself pretty trivial.

		Linus

----
===== arch/i386/kernel/sysenter.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/sysenter.c	Sat Dec 14 04:38:56 2002
+++ edited/arch/i386/kernel/sysenter.c	2002-12-16 16:37:32.000000000 -0800
@@ -0,0 +1,52 @@
+/*
+ * linux/arch/i386/kernel/sysenter.c
+ *
+ * (C) Copyright 2002 Linus Torvalds
+ *
+ * This file contains the needed initializations to support sysenter.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/thread_info.h>
+#include <linux/gfp.h>
+
+#include <asm/cpufeature.h>
+#include <asm/msr.h>
+
+extern asmlinkage void sysenter_entry(void);
+
+static void __init enable_sep_cpu(void *info)
+{
+	unsigned long page = __get_free_page(GFP_ATOMIC);
+	int cpu = get_cpu();
+	unsigned long *esp0_ptr = &(init_tss + cpu)->esp0;
+	unsigned long rel32;
+
+	rel32 = (unsigned long) sysenter_entry - (page+11);
+
+	
+	*(short *) (page+0) = 0x258b;		/* movl xxxxx,%esp */
+	*(long **) (page+2) = esp0_ptr;
+	*(char *)  (page+6) = 0xe9;		/* jmp rl32 */
+	*(long *)  (page+7) = rel32;
+
+	wrmsr(0x174, __KERNEL_CS, 0);		/* SYSENTER_CS_MSR */
+	wrmsr(0x175, page+PAGE_SIZE, 0);	/* SYSENTER_ESP_MSR */
+	wrmsr(0x176, page, 0);			/* SYSENTER_EIP_MSR */
+
+	printk("Enabling SEP on CPU %d\n", cpu);
+	put_cpu();	
+}
+
+static int __init sysenter_setup(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SEP))
+		return 0;
+
+	enable_sep_cpu(NULL);
+	smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	return 0;
+}
+
+__initcall(sysenter_setup);
===== arch/i386/kernel/Makefile 1.30 vs edited =====
--- 1.30/arch/i386/kernel/Makefile	Sat Dec 14 04:38:56 2002
+++ edited/arch/i386/kernel/Makefile	Mon Dec 16 13:43:57 2002
@@ -29,6 +29,7 @@
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
+obj-y				+= sysenter.o
 
 EXTRA_AFLAGS   := -traditional
 
===== arch/i386/kernel/entry.S 1.41 vs edited =====
--- 1.41/arch/i386/kernel/entry.S	Fri Dec  6 09:43:43 2002
+++ edited/arch/i386/kernel/entry.S	Mon Dec 16 16:17:47 2002
@@ -94,7 +94,7 @@
 	movl %edx, %ds; \
 	movl %edx, %es;
 
-#define RESTORE_ALL	\
+#define RESTORE_REGS	\
 	popl %ebx;	\
 	popl %ecx;	\
 	popl %edx;	\
@@ -104,14 +104,25 @@
 	popl %eax;	\
 1:	popl %ds;	\
 2:	popl %es;	\
-	addl $4, %esp;	\
-3:	iret;		\
 .section .fixup,"ax";	\
-4:	movl $0,(%esp);	\
+3:	movl $0,(%esp);	\
 	jmp 1b;		\
-5:	movl $0,(%esp);	\
+4:	movl $0,(%esp);	\
 	jmp 2b;		\
-6:	pushl %ss;	\
+.previous;		\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,3b;	\
+	.long 2b,4b;	\
+.previous
+
+
+#define RESTORE_ALL	\
+	RESTORE_REGS	\
+	addl $4, %esp;	\
+1:	iret;		\
+.section .fixup,"ax";   \
+2:	pushl %ss;	\
 	popl %ds;	\
 	pushl %ss;	\
 	popl %es;	\
@@ -120,11 +131,11 @@
 .previous;		\
 .section __ex_table,"a";\
 	.align 4;	\
-	.long 1b,4b;	\
-	.long 2b,5b;	\
-	.long 3b,6b;	\
+	.long 1b,2b;	\
 .previous
 
+
+
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
@@ -219,6 +230,39 @@
 	cli
 	jmp need_resched
 #endif
+
+#define SYSENTER_RETURN 0
+
+	# sysenter call handler stub
+	ALIGN
+ENTRY(sysenter_entry)
+	sti
+	pushl $(__USER_DS)
+	pushl %ebp
+	pushfl
+	pushl $(__USER_CS)
+	pushl $SYSENTER_RETURN
+
+	pushl %eax
+	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+	cmpl $(NR_syscalls), %eax
+	jae syscall_badsys
+
+	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
+	jnz syscall_trace_entry
+	call *sys_call_table(,%eax,4)
+	movl %eax,EAX(%esp)
+	cli
+	movl TI_FLAGS(%ebx), %ecx
+	testw $_TIF_ALLWORK_MASK, %cx
+	jne syscall_exit_work
+	RESTORE_REGS
+	movl 4(%esp),%edx
+	movl 16(%esp),%ecx
+	sti
+	sysexit
+
 
 	# system call handler stub
 	ALIGN
===== arch/i386/kernel/head.S 1.18 vs edited =====
--- 1.18/arch/i386/kernel/head.S	Thu Dec  5 18:56:49 2002
+++ edited/arch/i386/kernel/head.S	Mon Dec 16 14:14:44 2002
@@ -414,8 +414,8 @@
 	.quad 0x0000000000000000	/* 0x0b reserved */
 	.quad 0x0000000000000000	/* 0x13 reserved */
 	.quad 0x0000000000000000	/* 0x1b reserved */
-	.quad 0x00cffa000000ffff	/* 0x23 user 4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x2b user 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x20 unused */
+	.quad 0x0000000000000000	/* 0x28 unused */
 	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
 	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
 	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
@@ -425,22 +425,25 @@
 
 	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
-	.quad 0x0000000000000000	/* 0x70 TSS descriptor */
-	.quad 0x0000000000000000	/* 0x78 LDT descriptor */
+	.quad 0x00cffa000000ffff	/* 0x73 user 4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x7b user 4GB data at 0x00000000 */
+
+	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
+	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
 
 	/* Segments used for calling PnP BIOS */
-	.quad 0x00c09a0000000000	/* 0x80 32-bit code */
-	.quad 0x00809a0000000000	/* 0x88 16-bit code */
-	.quad 0x0080920000000000	/* 0x90 16-bit data */
-	.quad 0x0080920000000000	/* 0x98 16-bit data */
+	.quad 0x00c09a0000000000	/* 0x90 32-bit code */
+	.quad 0x00809a0000000000	/* 0x98 16-bit code */
 	.quad 0x0080920000000000	/* 0xa0 16-bit data */
+	.quad 0x0080920000000000	/* 0xa8 16-bit data */
+	.quad 0x0080920000000000	/* 0xb0 16-bit data */
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x00409a0000000000	/* 0xa8 APM CS    code */
-	.quad 0x00009a0000000000	/* 0xb0 APM CS 16 code (16 bit) */
-	.quad 0x0040920000000000	/* 0xb8 APM DS    data */
+	.quad 0x00409a0000000000	/* 0xb8 APM CS    code */
+	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
+	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
 #if CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
===== include/asm-i386/segment.h 1.2 vs edited =====
--- 1.2/include/asm-i386/segment.h	Mon Aug 12 10:56:27 2002
+++ edited/include/asm-i386/segment.h	Mon Dec 16 14:08:09 2002
@@ -9,8 +9,8 @@
  *   2 - reserved
  *   3 - reserved
  *
- *   4 - default user CS		<==== new cacheline
- *   5 - default user DS
+ *   4 - unused			<==== new cacheline
+ *   5 - unused
  *
  *  ------- start of TLS (Thread-Local Storage) segments:
  *
@@ -25,16 +25,18 @@
  *
  *  12 - kernel code segment		<==== new cacheline
  *  13 - kernel data segment
- *  14 - TSS
- *  15 - LDT
- *  16 - PNPBIOS support (16->32 gate)
- *  17 - PNPBIOS support
- *  18 - PNPBIOS support
+ *  14 - default user CS
+ *  15 - default user DS
+ *  16 - TSS
+ *  17 - LDT
+ *  18 - PNPBIOS support (16->32 gate)
  *  19 - PNPBIOS support
  *  20 - PNPBIOS support
- *  21 - APM BIOS support
- *  22 - APM BIOS support
- *  23 - APM BIOS support 
+ *  21 - PNPBIOS support
+ *  22 - PNPBIOS support
+ *  23 - APM BIOS support
+ *  24 - APM BIOS support
+ *  25 - APM BIOS support 
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
 #define GDT_ENTRY_TLS_MIN	6
@@ -42,10 +44,10 @@
 
 #define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
 
-#define GDT_ENTRY_DEFAULT_USER_CS	4
+#define GDT_ENTRY_DEFAULT_USER_CS	14
 #define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
 
-#define GDT_ENTRY_DEFAULT_USER_DS	5
+#define GDT_ENTRY_DEFAULT_USER_DS	15
 #define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
 
 #define GDT_ENTRY_KERNEL_BASE	12
@@ -56,14 +58,14 @@
 #define GDT_ENTRY_KERNEL_DS		(GDT_ENTRY_KERNEL_BASE + 1)
 #define __KERNEL_DS (GDT_ENTRY_KERNEL_DS * 8)
 
-#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 2)
-#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 3)
+#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 4)
+#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 5)
 
-#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 4)
-#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 9)
+#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
+#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
 /*
- * The GDT has 21 entries but we pad it to cacheline boundary:
+ * The GDT has 23 entries but we pad it to cacheline boundary:
  */
 #define GDT_ENTRIES 24
 

