Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWIVLxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWIVLxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWIVLxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:53:21 -0400
Received: from ozlabs.org ([203.10.76.45]:23276 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932309AbWIVLxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:53:20 -0400
Subject: [PATCH 1/7] Use per-cpu GDT tables from early in boot
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <1158925861.26261.3.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 21:53:17 +1000
Message-Id: <1158925997.26261.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we have 3 GDT tables: one for early boot (boot_gdt_table),
one for late boot (cpu_gdt_table), and a dynamically-allocated per-cpu
one (per-cpu cpu_gdt_table *).

Simplify this and reduce waste, by using the per-cpu GDT table
directly in boot.  This is done by using the table in the per-cpu
section until cpu_init() where the per-cpu copies have been set up.

This means we it's easier to define the cpu_gdt_table in C, otherwise
we'd need asm per-cpu definition macros.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Index: ak-pda-gs/arch/i386/kernel/setup.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/setup.c	2006-09-20 15:38:27.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/setup.c	2006-09-20 15:39:01.000000000 +1000
@@ -1437,6 +1437,50 @@
 	tsc_init();
 }
 
+/*
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
+ */
+__attribute__((aligned(L1_CACHE_BYTES)))
+DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]) =
+{
+	/* kernel 4GB code at 0x00000000 */
+	[GDT_ENTRY_KERNEL_CS] = { 0x0000ffff, 0x00cf9a00 },
+	/* kernel 4GB data at 0x00000000 */
+	[GDT_ENTRY_KERNEL_DS] = { 0x0000ffff, 0x00cf9200 },
+	/* user 4GB code at 0x00000000 */
+	[GDT_ENTRY_DEFAULT_USER_CS] = { 0x0000ffff, 0x00cffa00 },
+	/* user 4GB data at 0x00000000 */
+	[GDT_ENTRY_DEFAULT_USER_DS] = { 0x0000ffff, 0x00cff200 },
+	/*
+	 * Segments used for calling PnP BIOS have byte granularity.
+	 * They code segments and data segments have fixed 64k limits,
+	 * the transfer segment sizes are set at run time.
+	 */
+	[GDT_ENTRY_PNPBIOS_BASE] =
+	{ 0x0000ffff, 0x00409a00 }, /* 32-bit code */
+	{ 0x0000ffff, 0x00009a00 }, /* 16-bit code */
+	{ 0x0000ffff, 0x00009200 }, /* 16-bit data */
+	{ 0x00000000, 0x00009200 }, /* 16-bit data */
+	{ 0x00000000, 0x00009200 }, /* 16-bit data */
+
+	/*
+	 * The APM segments have byte granularity and their bases
+	 * are set at run time.  All have 64k limits.
+	 */
+	[GDT_ENTRY_APMBIOS_BASE] =
+	{ 0x0000ffff, 0x00409a00 }, /* APM CS    code */
+	{ 0x0000ffff, 0x00009a00 }, /* APM CS 16 code (16 bit) */
+	{ 0x0000ffff, 0x00409200 }, /* APM DS    data */
+
+	/* ESPFIX 16-bit SS */
+	[GDT_ENTRY_ESPFIX_SS] = { 0x00000000, 0x00009200 },
+};
+
+/* Early in boot we use the master per-cpu gdt_table directly. */
+DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr)
+= { .size = GDT_ENTRIES*8-1, .address = (long)&per_cpu__cpu_gdt_table };
+EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
+
 static __init int add_pcspkr(void)
 {
 	struct platform_device *pd;
Index: ak-pda-gs/arch/i386/kernel/cpu/common.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/cpu/common.c	2006-09-20 15:38:27.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/cpu/common.c	2006-09-20 15:39:01.000000000 +1000
@@ -21,9 +21,6 @@
 
 #include "cpu.h"
 
-DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
-EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
-
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
@@ -612,38 +609,8 @@
 		set_in_cr4(X86_CR4_TSD);
 	}
 
-	/* The CPU hotplug case */
-	if (cpu_gdt_descr->address) {
-		gdt = (struct desc_struct *)cpu_gdt_descr->address;
-		memset(gdt, 0, PAGE_SIZE);
-		goto old_gdt;
-	}
-	/*
-	 * This is a horrible hack to allocate the GDT.  The problem
-	 * is that cpu_init() is called really early for the boot CPU
-	 * (and hence needs bootmem) but much later for the secondary
-	 * CPUs, when bootmem will have gone away
-	 */
-	if (NODE_DATA(0)->bdata->node_bootmem_map) {
-		gdt = (struct desc_struct *)alloc_bootmem_pages(PAGE_SIZE);
-		/* alloc_bootmem_pages panics on failure, so no check */
-		memset(gdt, 0, PAGE_SIZE);
-	} else {
-		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
-		if (unlikely(!gdt)) {
-			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
-			for (;;)
-				local_irq_enable();
-		}
-	}
-old_gdt:
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
- 	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
-
 	/* Set up GDT entry for 16bit stack */
+	gdt = __get_cpu_var(cpu_gdt_table);
  	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
 		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
 		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
Index: ak-pda-gs/arch/i386/kernel/head.S
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/head.S	2006-09-20 15:38:27.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/head.S	2006-09-20 15:39:01.000000000 +1000
@@ -302,7 +302,7 @@
 	movl %eax,%cr0
 
 	call check_x87
-	lgdt cpu_gdt_descr
+	lgdt per_cpu__cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
@@ -456,12 +456,6 @@
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
 	.long idt_table
 
-# boot GDT descriptor (later on used by CPU#0):
-	.word 0				# 32 bit align gdt_desc.address
-cpu_gdt_descr:
-	.word GDT_ENTRIES*8-1
-	.long cpu_gdt_table
-
 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
  * used only for booting.
@@ -472,55 +466,3 @@
 	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
 
-/*
- * The Global Descriptor Table contains 28 quadwords, per-CPU.
- */
-	.align L1_CACHE_BYTES
-ENTRY(cpu_gdt_table)
-	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* 0x0b reserved */
-	.quad 0x0000000000000000	/* 0x13 reserved */
-	.quad 0x0000000000000000	/* 0x1b reserved */
-	.quad 0x0000000000000000	/* 0x20 unused */
-	.quad 0x0000000000000000	/* 0x28 unused */
-	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
-	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
-	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
-	.quad 0x0000000000000000	/* 0x4b reserved */
-	.quad 0x0000000000000000	/* 0x53 reserved */
-	.quad 0x0000000000000000	/* 0x5b reserved */
-
-	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
-	.quad 0x00cffa000000ffff	/* 0x73 user 4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x7b user 4GB data at 0x00000000 */
-
-	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
-	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
-
-	/*
-	 * Segments used for calling PnP BIOS have byte granularity.
-	 * They code segments and data segments have fixed 64k limits,
-	 * the transfer segment sizes are set at run time.
-	 */
-	.quad 0x00409a000000ffff	/* 0x90 32-bit code */
-	.quad 0x00009a000000ffff	/* 0x98 16-bit code */
-	.quad 0x000092000000ffff	/* 0xa0 16-bit data */
-	.quad 0x0000920000000000	/* 0xa8 16-bit data */
-	.quad 0x0000920000000000	/* 0xb0 16-bit data */
-
-	/*
-	 * The APM segments have byte granularity and their bases
-	 * are set at run time.  All have 64k limits.
-	 */
-	.quad 0x00409a000000ffff	/* 0xb8 APM CS    code */
-	.quad 0x00009a000000ffff	/* 0xc0 APM CS 16 code (16 bit) */
-	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
-
-	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
-	.quad 0x0000000000000000	/* 0xe0 - unused */
-	.quad 0x0000000000000000	/* 0xe8 - unused */
-	.quad 0x0000000000000000	/* 0xf0 - unused */
-	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
-
Index: ak-pda-gs/arch/i386/kernel/smpboot.c
===================================================================
--- ak-pda-gs.orig/arch/i386/kernel/smpboot.c	2006-09-20 15:38:27.000000000 +1000
+++ ak-pda-gs/arch/i386/kernel/smpboot.c	2006-09-20 15:39:01.000000000 +1000
@@ -1058,7 +1058,6 @@
 	struct warm_boot_cpu_info info;
 	struct work_struct task;
 	int	apicid, ret;
-	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	apicid = x86_cpu_to_apicid[cpu];
 	if (apicid == BAD_APICID) {
@@ -1066,18 +1065,6 @@
 		goto exit;
 	}
 
-	/*
-	 * the CPU isn't initialized at boot time, allocate gdt table here.
-	 * cpu_init will initialize it
-	 */
-	if (!cpu_gdt_descr->address) {
-		cpu_gdt_descr->address = get_zeroed_page(GFP_KERNEL);
-		if (!cpu_gdt_descr->address)
-			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
-			ret = -ENOMEM;
-			goto exit;
-	}
-
 	info.complete = &done;
 	info.apicid = apicid;
 	info.cpu = cpu;
Index: ak-pda-gs/include/asm-i386/desc.h
===================================================================
--- ak-pda-gs.orig/include/asm-i386/desc.h	2006-09-20 15:27:51.000000000 +1000
+++ ak-pda-gs/include/asm-i386/desc.h	2006-09-20 15:39:01.000000000 +1000
@@ -14,8 +14,7 @@
 
 #include <asm/mmu.h>
 
-extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
 struct Xgt_desc_struct {

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

