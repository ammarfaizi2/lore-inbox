Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWBVRsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWBVRsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWBVRsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:48:35 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:33687 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751145AbWBVRse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:48:34 -0500
Subject: [PATCH] fix broken x86 SMP boot sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 11:48:24 -0600
Message-Id: <1140630504.3227.38.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

[PATCH] x86: GDT alignment fix

completely broke my voyager boot sequence.  The reason is that the patch
introduces a subtle dependence on the assumption that the boot CPU is
CPU0, which is untrue for voyager.  I think the most correct fix for
this is to use a per_cpu for cpu_gdt_descr and still allocate the actual
descriptors as page allocations.  I think it's also much more efficient
to do these allocations in cpu_init() where they'll be automatic for all
subarchitectures, rather than placing them in each do_boot_cpu
implementation.  Note, I've also fixed a potentially hard to trace bug
as well: the secondaries in the prior scheme were actually using the
Boot CPU's GDT to come up with ... whatever cpu_init() and subsequent
manipulations alter it to be.  This implementation goes back to using
the special (and now not altered) cpu_gdt_table for all booting CPUs.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index cbc3206..d561a56 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/bootmem.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -18,6 +19,9 @@
 
 #include "cpu.h"
 
+DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
+EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
+
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
@@ -559,8 +563,9 @@ void __devinit cpu_init(void)
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
-	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+	struct desc_struct *gdt;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -577,6 +582,22 @@ void __devinit cpu_init(void)
 		set_in_cr4(X86_CR4_TSD);
 	}
 
+	/* This is a horrible hack to allocate the GDT.  The problem
+	 * is that cpu_init() is called really early for the boot CPU
+	 * (and hence needs bootmem) but much later for the secondary
+	 * CPUs, when bootmem will have gone away */
+	if (NODE_DATA(0)->bdata->node_bootmem_map) {
+		gdt = (struct desc_struct *)alloc_bootmem_pages(PAGE_SIZE);
+		/* alloc_bootmem_pages panics on failure, so no check */
+		memset(gdt, 0, PAGE_SIZE);
+	} else {
+		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
+		if (unlikely(!gdt)) {
+			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
+			for (;;) local_irq_enable();
+		}
+	}
+
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
@@ -589,10 +610,10 @@ void __devinit cpu_init(void)
 		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
 		(CPU_16BIT_STACK_SIZE - 1);
 
-	cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
- 	cpu_gdt_descr[cpu].address = (unsigned long)gdt;
+	cpu_gdt_descr->size = GDT_SIZE - 1;
+ 	cpu_gdt_descr->address = (unsigned long)gdt;
 
-	load_gdt(&cpu_gdt_descr[cpu]);
+	load_gdt(cpu_gdt_descr);
 	load_idt(&idt_descr);
 
 	/*
diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index 870f20b..e437fb3 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -525,5 +525,3 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
-	/* Be sure this is zeroed to avoid false validations in Xen */
-	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index b3c2e2c..9ed449a 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -903,12 +903,6 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	if (!cpu_gdt_descr[cpu].address &&
-	    !(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
-		printk("Failed to allocate GDT for CPU %d\n", cpu);
-		return 1;
-	}
-
 	++cpucount;
 
 	/*
diff --git a/include/asm-i386/desc.h b/include/asm-i386/desc.h
index 494e73b..89b9c32 100644
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -25,10 +25,12 @@ struct Xgt_desc_struct {
 } __attribute__ ((packed));
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+DECLARE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
+
 
 static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
 {
-	return ((struct desc_struct *)cpu_gdt_descr[cpu].address);
+	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))


