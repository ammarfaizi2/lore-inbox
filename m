Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWBVXvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWBVXvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWBVXvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:51:53 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:39842 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751539AbWBVXvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:51:52 -0500
Subject: Re: [PATCH] fix broken x86 SMP boot sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FCA8B2.5040306@vmware.com>
References: <1140630504.3227.38.camel@mulgrave.il.steeleye.com>
	 <43FCA8B2.5040306@vmware.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 17:49:38 -0600
Message-Id: <1140652178.10417.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 10:08 -0800, Zachary Amsden wrote:
> I'm not adverse to making the gdt descriptors part of the per-cpu data.  
> But I think your patch is missing some necessary changes to 
> include/asm-i386/desc.h - what do you plan to do with the following 
> definition there?
> 
> extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];

Actually, I checked ... it looks like the externel definition of
cpu_gdt_descr can be dumped ... nothing's using it (well, at least in a
voyager build), so I updated the patch.

James

---

diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index cbc3206..d561a56 100644
Index: BUILD-2.6/arch/i386/kernel/cpu/common.c
===================================================================
--- BUILD-2.6.orig/arch/i386/kernel/cpu/common.c	2006-02-22 13:53:43.000000000 -0600
+++ BUILD-2.6/arch/i386/kernel/cpu/common.c	2006-02-22 15:28:37.000000000 -0600
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
 
@@ -571,8 +575,9 @@
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
-	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+	struct desc_struct *gdt;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -589,6 +594,22 @@
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
@@ -601,10 +622,10 @@
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
Index: BUILD-2.6/arch/i386/kernel/head.S
===================================================================
--- BUILD-2.6.orig/arch/i386/kernel/head.S	2006-02-22 13:53:43.000000000 -0600
+++ BUILD-2.6/arch/i386/kernel/head.S	2006-02-22 15:28:37.000000000 -0600
@@ -534,5 +534,3 @@
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
-	/* Be sure this is zeroed to avoid false validations in Xen */
-	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
Index: BUILD-2.6/arch/i386/kernel/smpboot.c
===================================================================
--- BUILD-2.6.orig/arch/i386/kernel/smpboot.c	2006-02-22 13:53:43.000000000 -0600
+++ BUILD-2.6/arch/i386/kernel/smpboot.c	2006-02-22 15:28:37.000000000 -0600
@@ -898,12 +898,6 @@
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
Index: BUILD-2.6/include/asm-i386/desc.h
===================================================================
--- BUILD-2.6.orig/include/asm-i386/desc.h	2006-02-22 13:53:47.000000000 -0600
+++ BUILD-2.6/include/asm-i386/desc.h	2006-02-22 15:28:37.000000000 -0600
@@ -24,11 +24,13 @@
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+extern struct Xgt_desc_struct idt_descr;
+DECLARE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
+
 
 static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
 {
-	return ((struct desc_struct *)cpu_gdt_descr[cpu].address);
+	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
Index: BUILD-2.6/arch/i386/kernel/i386_ksyms.c
===================================================================
--- BUILD-2.6.orig/arch/i386/kernel/i386_ksyms.c	2006-02-22 15:26:57.000000000 -0600
+++ BUILD-2.6/arch/i386/kernel/i386_ksyms.c	2006-02-22 15:28:54.000000000 -0600
@@ -3,8 +3,6 @@
 #include <asm/checksum.h>
 #include <asm/desc.h>
 
-EXPORT_SYMBOL_GPL(cpu_gdt_descr);
-
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);


