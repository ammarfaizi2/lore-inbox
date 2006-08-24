Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWHXXEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWHXXEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWHXXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:04:42 -0400
Received: from gw.goop.org ([64.81.55.164]:12517 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1422764AbWHXXEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:04:41 -0400
Message-ID: <44EE308B.8000304@goop.org>
Date: Thu, 24 Aug 2006 16:04:43 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Remove default_ldt, and simplify ldt-setting.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is the replacement for kill-default_ldt.patch.)

Remove default_ldt, and simplify ldt-setting.

This patch removes the default_ldt[] array, as it has been unused
since iBCS stopped being supported.  This means it is now possible to
actually set an empty LDT segment.

In order to deal with this, the set_ldt_desc/load_LDT pair has been
replaced with a single set_ldt() operation which is responsible for
both setting up the LDT descriptor in the GDT, and reloading the LDT
register.  If there are no LDT entries, the LDT register is loaded
with a NULL descriptor.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/ldt.c         |    4 ---
 arch/i386/kernel/traps.c       |    3 --
 include/asm-i386/desc.h        |   50 +++++++++++++++-------------------------
 include/asm-i386/mmu_context.h |    4 +--
 4 files changed, 22 insertions(+), 39 deletions(-)


diff -r 9d2218382a52 arch/i386/kernel/ldt.c
--- a/arch/i386/kernel/ldt.c	Wed Aug 23 16:36:34 2006 -0700
+++ b/arch/i386/kernel/ldt.c	Thu Aug 24 15:41:50 2006 -0700
@@ -160,16 +160,14 @@ static int read_default_ldt(void __user 
 {
 	int err;
 	unsigned long size;
-	void *address;
 
 	err = 0;
-	address = &default_ldt[0];
 	size = 5*sizeof(struct desc_struct);
 	if (size > bytecount)
 		size = bytecount;
 
 	err = size;
-	if (copy_to_user(ptr, address, size))
+	if (clear_user(ptr, size))
 		err = -EFAULT;
 
 	return err;
diff -r 9d2218382a52 arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Wed Aug 23 16:36:34 2006 -0700
+++ b/arch/i386/kernel/traps.c	Thu Aug 24 15:40:45 2006 -0700
@@ -58,9 +58,6 @@
 #include "mach_traps.h"
 
 asmlinkage int system_call(void);
-
-struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
-		{ 0, 0 }, { 0, 0 } };
 
 /* Do we ignore FPU interrupts ? */
 char ignore_fpu_irq = 0;
diff -r 9d2218382a52 include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Wed Aug 23 16:36:34 2006 -0700
+++ b/include/asm-i386/desc.h	Thu Aug 24 15:48:49 2006 -0700
@@ -33,11 +33,6 @@ static inline struct desc_struct *get_cp
 	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
-/*
- * This is the ldt that every process will get unless we need
- * something other than this.
- */
-extern struct desc_struct default_ldt[];
 extern struct desc_struct idt_table[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
@@ -65,7 +60,6 @@ static inline void pack_gate(__u32 *a, _
 #define DESCTYPE_S	0x10	/* !system */
 
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
 #define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
 #define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
@@ -115,13 +109,20 @@ static inline void __set_tss_desc(unsign
 	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
 }
 
-static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int entries)
+static inline void set_ldt(void *addr, unsigned int entries)
 {
-	__u32 a, b;
-	pack_descriptor(&a, &b, (unsigned long)addr,
-			entries * sizeof(struct desc_struct) - 1,
-			DESCTYPE_LDT, 0);
-	write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
+	if (likely(entries == 0))
+		__asm__ __volatile__("lldt %w0"::"q" (0));
+	else {
+		unsigned cpu = smp_processor_id();
+		__u32 a, b;
+
+		pack_descriptor(&a, &b, (unsigned long)addr,
+				entries * sizeof(struct desc_struct) - 1,
+				DESCTYPE_LDT, 0);
+		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
+		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
+	} 
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
@@ -153,35 +154,22 @@ static inline void set_ldt_desc(unsigned
 
 static inline void clear_LDT(void)
 {
-	int cpu = get_cpu();
-
-	set_ldt_desc(cpu, &default_ldt[0], 5);
-	load_LDT_desc();
-	put_cpu();
+	set_ldt(NULL, 0);
 }
 
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
+static inline void load_LDT_nolock(mm_context_t *pc)
 {
-	void *segments = pc->ldt;
-	int count = pc->size;
-
-	if (likely(!count)) {
-		segments = &default_ldt[0];
-		count = 5;
-	}
-		
-	set_ldt_desc(cpu, segments, count);
-	load_LDT_desc();
+	set_ldt(pc->ldt, pc->size);
 }
 
 static inline void load_LDT(mm_context_t *pc)
 {
-	int cpu = get_cpu();
-	load_LDT_nolock(pc, cpu);
-	put_cpu();
+	preempt_disable();
+	load_LDT_nolock(pc);
+	preempt_enable();
 }
 
 static inline unsigned long get_desc_base(unsigned long *desc)
diff -r 9d2218382a52 include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	Wed Aug 23 16:36:34 2006 -0700
+++ b/include/asm-i386/mmu_context.h	Thu Aug 24 15:39:32 2006 -0700
@@ -44,7 +44,7 @@ static inline void switch_mm(struct mm_s
 		 * load the LDT, if the LDT is different:
 		 */
 		if (unlikely(prev->context.ldt != next->context.ldt))
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -56,7 +56,7 @@ static inline void switch_mm(struct mm_s
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
 			load_cr3(next->pgd);
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 		}
 	}
 #endif

