Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEBOMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbTEBOMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:12:33 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:39629 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S261414AbTEBOM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:12:29 -0400
Message-ID: <3EB27FAB.3040102@quark.didntduck.org>
Date: Fri, 02 May 2003 10:24:43 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix alignment of i386 interrupt entry stubs
Content-Type: multipart/mixed;
 boundary="------------070607040900040609050709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607040900040609050709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch provides for improved alignment of the entry stubs, to avoid 
crossing cache lines.  This is accomplished by using a fixed size for 
each stub (16 bytes for IO-APIC, 8 bytes otherwise).  The fixed size 
allows for removal of the pointer table.  Also, subtracting 256 from the 
irq number is no longer necessary.  orig_eax is no longer used by the 
exit code to distinguish between interrupts and system calls.

--
				Brian Gerst

--------------070607040900040609050709
Content-Type: text/plain;
 name="intentry-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intentry-3"

diff -ur linux-2.5.68-bk/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.68-bk/arch/i386/kernel/entry.S	2003-04-07 13:30:58.000000000 -0400
+++ linux/arch/i386/kernel/entry.S	2003-04-30 10:36:53.000000000 -0400
@@ -374,27 +374,17 @@
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
-/*
- * Build the entry stubs and pointer table with
- * some assembler magic.
- */
-.data
-ENTRY(interrupt)
-.text
-
+/* Build the IRQ entry stubs */
 vector=0
-ENTRY(irq_entries_start)
+	.align IRQ_STUB_SIZE,0x90
+ENTRY(irq_entries)
 .rept NR_IRQS
-	ALIGN
-1:	pushl $vector-256
+1:	pushl $vector
 	jmp common_interrupt
-.data
-	.long 1b
-.text
+	.align IRQ_STUB_SIZE,0x90
 vector=vector+1
 .endr
 
-	ALIGN
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
diff -ur linux-2.5.68-bk/arch/i386/kernel/i8259.c linux/arch/i386/kernel/i8259.c
--- linux-2.5.68-bk/arch/i386/kernel/i8259.c	2003-04-30 11:35:36.000000000 -0400
+++ linux/arch/i386/kernel/i8259.c	2003-04-30 10:04:52.000000000 -0400
@@ -425,7 +425,7 @@
 	for (i = 0; i < NR_IRQS; i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (vector != SYSCALL_VECTOR) 
-			set_intr_gate(vector, interrupt[i]);
+			set_intr_gate(vector, &irq_entries[i]);
 	}
 
 	/* setup after call gates are initialised (usually add in
diff -ur linux-2.5.68-bk/arch/i386/kernel/io_apic.c linux/arch/i386/kernel/io_apic.c
--- linux-2.5.68-bk/arch/i386/kernel/io_apic.c	2003-04-30 11:35:36.000000000 -0400
+++ linux/arch/i386/kernel/io_apic.c	2003-04-30 10:04:52.000000000 -0400
@@ -1190,7 +1190,7 @@
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
-			set_intr_gate(vector, interrupt[irq]);
+			set_intr_gate(vector, &irq_entries[irq]);
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -2024,7 +2024,7 @@
 	 */
 	disable_8259A_irq(0);
 	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
+	set_intr_gate(vector, &irq_entries[0]);
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -2312,7 +2312,7 @@
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate(entry.vector, interrupt[irq]);
+	set_intr_gate(entry.vector, &irq_entries[irq]);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
diff -ur linux-2.5.68-bk/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux-2.5.68-bk/arch/i386/kernel/irq.c	2003-04-30 11:35:36.000000000 -0400
+++ linux/arch/i386/kernel/irq.c	2003-04-30 10:04:52.000000000 -0400
@@ -354,7 +354,7 @@
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs.orig_eax;
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
diff -ur linux-2.5.68-bk/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.68-bk/arch/i386/kernel/smpboot.c	2003-04-20 05:13:04.000000000 -0400
+++ linux/arch/i386/kernel/smpboot.c	2003-04-30 10:04:52.000000000 -0400
@@ -1159,7 +1159,7 @@
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
+	set_intr_gate(FIRST_DEVICE_VECTOR, &irq_entries[0]);
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
diff -ur linux-2.5.68-bk/include/asm-i386/hw_irq.h linux/include/asm-i386/hw_irq.h
--- linux-2.5.68-bk/include/asm-i386/hw_irq.h	2003-04-07 13:32:58.000000000 -0400
+++ linux/include/asm-i386/hw_irq.h	2003-04-30 10:35:55.000000000 -0400
@@ -27,7 +27,7 @@
 extern int irq_vector[NR_IRQS];
 #define IO_APIC_VECTOR(irq)	irq_vector[irq]
 
-extern void (*interrupt[NR_IRQS])(void);
+extern char irq_entries[NR_IRQS][IRQ_STUB_SIZE];
 
 #ifdef CONFIG_SMP
 extern asmlinkage void reschedule_interrupt(void);
diff -ur linux-2.5.68-bk/include/asm-i386/mach-default/irq_vectors.h linux/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.5.68-bk/include/asm-i386/mach-default/irq_vectors.h	2003-04-20 05:13:14.000000000 -0400
+++ linux/include/asm-i386/mach-default/irq_vectors.h	2003-04-30 10:33:52.000000000 -0400
@@ -78,8 +78,10 @@
  */
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 8
 #endif
 
 #define FPU_IRQ			13
diff -ur linux-2.5.68-bk/include/asm-i386/mach-pc9800/irq_vectors.h linux/include/asm-i386/mach-pc9800/irq_vectors.h
--- linux-2.5.68-bk/include/asm-i386/mach-pc9800/irq_vectors.h	2003-04-20 05:13:14.000000000 -0400
+++ linux/include/asm-i386/mach-pc9800/irq_vectors.h	2003-04-30 10:34:06.000000000 -0400
@@ -78,8 +78,10 @@
  */
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 8
 #endif
 
 #define FPU_IRQ			8
diff -ur linux-2.5.68-bk/include/asm-i386/mach-visws/irq_vectors.h linux/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.68-bk/include/asm-i386/mach-visws/irq_vectors.h	2003-04-20 05:13:14.000000000 -0400
+++ linux/include/asm-i386/mach-visws/irq_vectors.h	2003-04-30 10:34:12.000000000 -0400
@@ -50,6 +50,7 @@
  * 
  */
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 
 #define FPU_IRQ			13
 
diff -ur linux-2.5.68-bk/include/asm-i386/mach-voyager/irq_vectors.h linux/include/asm-i386/mach-voyager/irq_vectors.h
--- linux-2.5.68-bk/include/asm-i386/mach-voyager/irq_vectors.h	2003-04-20 05:13:14.000000000 -0400
+++ linux/include/asm-i386/mach-voyager/irq_vectors.h	2003-04-30 10:34:17.000000000 -0400
@@ -56,6 +56,7 @@
 #define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
 
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 
 #define FPU_IRQ				13
 

--------------070607040900040609050709--

