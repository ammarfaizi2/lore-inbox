Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVKHEcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVKHEcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVKHEcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:32:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:24083 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030287AbVKHEcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:32:50 -0500
Date: Mon, 7 Nov 2005 20:32:49 -0800
Message-Id: <200511080432.jA84WnnQ009915@zach-dev.vmware.com>
Subject: [PATCH 13/21] i386 Gdt page isolation
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:32:49.0222 (UTC) FILETIME=[796BCE60:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make GDT page aligned and page padded to support running inside of a
hypervisor.  This prevents false sharing of the GDT page with other
hot data, which is not allowed in Xen, and causes performance problems
in VMware.

Rather than go back to the old method of statically allocating the
GDT (which wastes unneded space for non-present CPUs), the GDT for
APs is allocated dynamically.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 17:45:31.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:06.000000000 -0800
@@ -15,9 +15,6 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-
-#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table,_cpu))
 
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
@@ -29,6 +26,11 @@ struct Xgt_desc_struct {
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
+static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
+{
+	return ((struct desc_struct *)cpu_gdt_descr[cpu].address);
+}
+  
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
Index: linux-2.6.14-zach-work/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/i386_ksyms.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-zach-work/arch/i386/kernel/i386_ksyms.c	2005-11-04 17:55:00.000000000 -0800
@@ -3,8 +3,7 @@
 #include <asm/checksum.h>
 #include <asm/desc.h>
 
-/* This is definitely a GPL-only symbol */
-EXPORT_SYMBOL_GPL(cpu_gdt_table);
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
Index: linux-2.6.14-zach-work/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/smpboot.c	2005-11-04 12:12:35.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/smpboot.c	2005-11-04 17:55:00.000000000 -0800
@@ -877,6 +877,12 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
+	if (!cpu_gdt_descr[cpu].address &&
+	    !(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
+		printk("Failed to allocate GDT for CPU %d\n", cpu);
+		return 1;
+	}
+
 	++cpucount;
 
 	/*
Index: linux-2.6.14-zach-work/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/head.S	2005-11-04 17:37:01.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/head.S	2005-11-04 17:55:00.000000000 -0800
@@ -530,3 +530,5 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
+	/* Be sure this is zeroed to avoid false validations in Xen */
+	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 17:45:31.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-04 17:55:24.000000000 -0800
@@ -2256,6 +2256,8 @@ static int __init apm_init(void)
 	 */
 	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
+ 		if (!gdt)
+ 			continue;
 		set_base(&gdt[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
 		set_base(&gdt[APM_CS_16 >> 3],
Index: linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/cpu/common.c	2005-11-04 17:45:31.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c	2005-11-04 17:55:00.000000000 -0800
@@ -18,9 +18,6 @@
 
 #include "cpu.h"
 
-DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
-
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 17:45:52.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 17:56:10.000000000 -0800
@@ -508,8 +508,10 @@ void pnpbios_calls_init(union pnp_bios_i
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
-	for(i=0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
+ 		if (!gdt)
+ 			continue;
 		set_base(&gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
 		set_base(&gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
 		set_base(&gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
