Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWJ3DyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWJ3DyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWJ3DyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:54:15 -0500
Received: from ozlabs.org ([203.10.76.45]:6535 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030506AbWJ3DyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:54:14 -0500
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de
In-Reply-To: <200610290831.21062.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org>  <200610290831.21062.ak@suse.de>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 14:28:55 +1100
Message-Id: <1162178936.9802.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 08:31 -0800, Andi Kleen wrote:
> It would be nicer if you renamed the functions in apic.h to native_apic_*
> and then do

...

> This might apply to at least some of the other paravirt ops too.

Yes.  I've done the obvious candidates below (as well as responding to
some of your other points).  Many ops are one-liners, and I don't want
to cause too much additional churn.

Cheers!
Rusty.

Subject: Paravirtualization Kleenups

1) Add "cheatsheet" comments to entry.S about macros.
2) Use weak alias for init_IRQ -> native_init_IRQ in !CONFIG_PARAVIRT case.
   This removes an #ifdef.
3) Use shiny new start_kernel.h rather than another declaration.
4) Avoid duplication in paravirt.c: rename set_ldt to native_set_ldt,
   and use macro in !PARAVIRT case.
5) Same trick for apic ops.

There are other cases where we could use a renaming+macro similar
trick to avoid duplication, but they're generally one-liners.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r ea3bae5ebb37 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Oct 30 11:37:19 2006 +1100
+++ b/arch/i386/kernel/entry.S	Mon Oct 30 11:48:34 2006 +1100
@@ -52,6 +52,19 @@
 #include <asm/percpu.h>
 #include <asm/dwarf2.h>
 #include "irq_vectors.h"
+
+/*
+ * We use macros for low-level operations which need to be overridden
+ * for paravirtualization.  The following will never clobber any registers:
+ *   INTERRUPT_RETURN (aka. "iret")
+ *   GET_CR0_INTO_EAX (aka. "movl %cr0, %eax")
+ *   ENABLE_INTERRUPTS_SYSEXIT (aka "sti; sysexit").
+ *
+ * For DISABLE_INTERRUPTS/ENABLE_INTERRUPTS (aka "cli"/"sti"), you must
+ * specify what registers can be overwritten (CLBR_NONE, CLBR_EAX/EDX/ECX/ANY).
+ * Allowing a register to be clobbered can shrink the paravirt replacement
+ * enough to patch inline, increasing performance.
+ */
 
 #define nr_syscalls ((syscall_table_size)/4)
 
diff -r ea3bae5ebb37 arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	Mon Oct 30 11:37:19 2006 +1100
+++ b/arch/i386/kernel/i8259.c	Mon Oct 30 11:57:55 2006 +1100
@@ -392,6 +392,9 @@ void __init init_ISA_irqs (void)
 	}
 }
 
+/* Overridden in paravirt.c */
+void init_IRQ(void) __attribute__((weak, alias("native_init_IRQ")));
+
 void __init native_init_IRQ(void)
 {
 	int i;
diff -r ea3bae5ebb37 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Mon Oct 30 11:37:19 2006 +1100
+++ b/arch/i386/kernel/paravirt.c	Mon Oct 30 12:31:48 2006 +1100
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/efi.h>
 #include <linux/bcd.h>
+#include <linux/start_kernel.h>
 
 #include <asm/bug.h>
 #include <asm/paravirt.h>
@@ -135,6 +136,11 @@ static fastcall void native_set_debugreg
 	}
 }
 
+void init_IRQ(void)
+{
+	paravirt_ops.init_IRQ();
+}
+
 static fastcall void native_clts(void)
 {
 	asm volatile ("clts");
@@ -296,22 +302,6 @@ static fastcall void native_load_tr_desc
 	asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
 }
 
-static fastcall void native_set_ldt(const void *addr, unsigned int entries)
-{
-	if (likely(entries == 0))
-		__asm__ __volatile__("lldt %w0"::"q" (0));
-	else {
-		unsigned cpu = smp_processor_id();
-		__u32 a, b;
-
-		pack_descriptor(&a, &b, (unsigned long)addr,
-				entries * sizeof(struct desc_struct) - 1,
-				DESCTYPE_LDT, 0);
-		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
-		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
-	} 
-}
-
 static fastcall void native_load_gdt(const struct Xgt_desc_struct *dtr)
 {
 	asm volatile("lgdt %0"::"m" (*dtr));
@@ -385,26 +375,6 @@ static fastcall void native_io_delay(voi
 	asm volatile("outb %al,$0x80");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
-/*
- * Basic functions for reading and writing APIC registers
- */
-static fastcall void native_apic_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
-}
-
-static fastcall void native_apic_write_atomic(unsigned long reg, unsigned long v)
-{
-	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
-}
-
-static fastcall unsigned long native_apic_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(APIC_BASE+reg));
-}
-#endif /* CONFIG_X86_LOCAL_APIC */
-
 static fastcall void native_flush_tlb(void)
 {
 	__native_flush_tlb();
@@ -508,7 +478,6 @@ core_initcall(print_banner);
 core_initcall(print_banner);
 
 /* We simply declare start_kernel to be the paravirt probe of last resort. */
-asmlinkage void __init start_kernel(void);
 paravirt_probe(start_kernel);
   
 struct paravirt_ops paravirt_ops = {
diff -r ea3bae5ebb37 include/asm-i386/apic.h
--- a/include/asm-i386/apic.h	Mon Oct 30 11:37:19 2006 +1100
+++ b/include/asm-i386/apic.h	Mon Oct 30 12:41:07 2006 +1100
@@ -40,21 +40,27 @@ extern void generic_apic_probe(void);
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-static __inline void apic_write(unsigned long reg, unsigned long v)
+#define apic_write native_apic_write
+#define apic_write_atomic native_apic_write_atomic
+#define apic_read native_apic_read
+#endif
+
+static __inline fastcall void native_apic_write(unsigned long reg,
+						unsigned long v)
 {
 	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
 }
 
-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+static __inline fastcall void native_apic_write_atomic(unsigned long reg,
+						       unsigned long v)
 {
 	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
 }
 
-static __inline unsigned long apic_read(unsigned long reg)
+static __inline fastcall unsigned long native_apic_read(unsigned long reg)
 {
 	return *((volatile unsigned long *)(APIC_BASE+reg));
 }
-#endif
 
 static __inline__ void apic_wait_icr_idle(void)
 {
diff -r ea3bae5ebb37 include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Mon Oct 30 11:37:19 2006 +1100
+++ b/include/asm-i386/desc.h	Mon Oct 30 12:40:20 2006 +1100
@@ -92,7 +92,11 @@ static inline void write_dt_entry(void *
 	lp[1] = entry_high;
 }
 
-static inline void set_ldt(void *addr, unsigned int entries)
+#define set_ldt native_set_ldt
+#endif /* CONFIG_PARAVIRT */
+
+static inline fastcall void native_set_ldt(const void *addr,
+					   unsigned int entries)
 {
 	if (likely(entries == 0))
 		__asm__ __volatile__("lldt %w0"::"q" (0));
@@ -107,7 +111,6 @@ static inline void set_ldt(void *addr, u
 		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
 	}
 }
-#endif /* CONFIG_PARAVIRT */
 
 static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
 {
diff -r ea3bae5ebb37 include/asm-i386/irq.h
--- a/include/asm-i386/irq.h	Mon Oct 30 11:37:19 2006 +1100
+++ b/include/asm-i386/irq.h	Mon Oct 30 12:01:31 2006 +1100
@@ -41,14 +41,7 @@ extern void fixup_irqs(cpumask_t map);
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+void init_IRQ(void);
 void __init native_init_IRQ(void);
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#else
-static inline void init_IRQ(void)
-{
-	native_init_IRQ();
-}
-#endif /* CONFIG_PARAVIRT */
 
 #endif /* _ASM_IRQ_H */
diff -r ea3bae5ebb37 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Mon Oct 30 11:37:19 2006 +1100
+++ b/include/asm-i386/paravirt.h	Mon Oct 30 12:18:58 2006 +1100
@@ -153,11 +153,6 @@ extern struct paravirt_ops paravirt_ops;
 extern struct paravirt_ops paravirt_ops;
 
 #define paravirt_enabled() (paravirt_ops.paravirt_enabled)
-
-static inline void init_IRQ(void)
-{
-	paravirt_ops.init_IRQ();
-}
 
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)




