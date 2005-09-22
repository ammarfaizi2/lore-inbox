Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVIVHw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVIVHw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVIVHtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:38917 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751446AbVIVHtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:24 -0400
Date: Thu, 22 Sep 2005 00:49:18 -0700
Message-Id: <200509220749.j8M7nINV001001@zach-dev.vmware.com>
Subject: [PATCH 3/3] Gdt page isolation
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 22 Sep 2005 07:49:20.0726 (UTC) FILETIME=[244A4760:01C5BF4A]
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
Index: linux-2.6.14-rc1/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-rc1.orig/include/asm-i386/desc.h	2005-09-20 20:19:57.000000000 -0700
+++ linux-2.6.14-rc1/include/asm-i386/desc.h	2005-09-20 20:20:50.000000000 -0700
@@ -15,9 +15,6 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-
-#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table,_cpu))
 
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
@@ -29,6 +26,8 @@ struct Xgt_desc_struct {
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
+#define get_cpu_gdt_table(_cpu) ((struct desc_struct *)cpu_gdt_descr[(_cpu)].address)
+
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
Index: linux-2.6.14-rc1/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/i386_ksyms.c	2005-09-20 20:19:57.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/i386_ksyms.c	2005-09-20 20:28:51.000000000 -0700
@@ -3,8 +3,7 @@
 #include <asm/checksum.h>
 #include <asm/desc.h>
 
-/* This is definitely a GPL-only symbol */
-EXPORT_SYMBOL_GPL(cpu_gdt_table);
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
Index: linux-2.6.14-rc1/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/smpboot.c	2005-09-20 20:19:57.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/smpboot.c	2005-09-20 20:38:22.000000000 -0700
@@ -898,6 +898,7 @@ static int __devinit do_boot_cpu(int api
 	 * This grunge runs the startup process for
 	 * the targeted processor.
 	 */
+	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
 
 	atomic_set(&init_deasserted, 0);
 
Index: linux-2.6.14-rc1/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/head.S	2005-09-20 14:32:16.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/head.S	2005-09-20 20:44:38.000000000 -0700
@@ -525,3 +525,5 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
+	/* Be sure this is zeroed to avoid false validations in Xen */
+	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
Index: linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/cpu/common.c	2005-09-20 20:19:57.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c	2005-09-20 20:37:31.000000000 -0700
@@ -18,9 +18,6 @@
 
 #include "cpu.h"
 
-DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
-
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
