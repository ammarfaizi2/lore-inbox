Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUGIB4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUGIB4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGIBzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:55:51 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:38304 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S263003AbUGIByM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:54:12 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Jes Sorensen'" <jes@wildopensource.com>
Subject: [PATCH] PER_CPU [4/4] - PER_CPU-cpu_gdt_table
Date: Thu, 8 Jul 2004 18:54:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlV58FWGC1r4/FToO7H1Z/5RXvEA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S263003AbUGIByM/20040709015412Z+1746@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please find below one out of collection of patched that move NR_CPU array variables to the per-cpu area.  Please consider applying,
any comment will highly appreciated.

1/4. PER_CPU-cpu_tlbstate
2/4. PER_CPU-irq_stat
3/4. PER_CPU-init_tss
4/4. PER_CPU-cpu_gdt_table

PER_CPU-cpu_gdt_table:
 arch/i386/kernel/cpu/common.c |   21 +++++++++++++--------
 arch/i386/kernel/head.S       |    3 ---
 arch/i386/mm/fault.c          |    2 +-
 arch/i386/power/cpu.c         |    2 +-
 include/asm-i386/desc.h       |    9 +++++----
 5 files changed, 20 insertions(+), 17 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=================================================================================
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2004-07-08 14:43:05 -07:00
+++ b/arch/i386/kernel/cpu/common.c	2004-07-08 14:43:05 -07:00
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/percpu.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -11,6 +12,8 @@
 
 #include "cpu.h"
 
+DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
+
 static int cachesize_override __initdata = -1;
 static int disable_x86_fxsr __initdata = 0;
 static int disable_x86_serial_nr __initdata = 1;
@@ -523,15 +526,17 @@
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
 	 */
-	if (cpu) {
-		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
-		cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
-		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
-	}
+	memcpy(&per_cpu(cpu_gdt_table, cpu), cpu_gdt_table,
+	       GDT_SIZE);
+	cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
+	cpu_gdt_descr[cpu].address =
+	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
+
 	/*
 	 * Set up the per-thread TLS descriptor cache:
 	 */
-	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
+	memcpy(thread->tls_array, &per_cpu(cpu_gdt_table, cpu),
+		GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
@@ -552,13 +557,13 @@
 
 	load_esp0(t, thread);
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+	per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
+	per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2004-07-08 14:43:05 -07:00
+++ b/arch/i386/kernel/head.S	2004-07-08 14:43:05 -07:00
@@ -495,6 +495,3 @@
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
-#ifdef CONFIG_SMP
-	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
-#endif
diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	2004-07-08 14:43:05 -07:00
+++ b/arch/i386/mm/fault.c	2004-07-08 14:43:05 -07:00
@@ -108,7 +108,7 @@
 		desc = (void *)desc + (seg & ~7);
 	} else {
 		/* Must disable preemption while reading the GDT. */
-		desc = (u32 *)&cpu_gdt_table[get_cpu()];
+		desc = (u32 *)&per_cpu(cpu_gdt_table, get_cpu());
 		desc = (void *)desc + (seg & ~7);
 	}
 
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
--- a/arch/i386/power/cpu.c	2004-07-08 14:43:05 -07:00
+++ b/arch/i386/power/cpu.c	2004-07-08 14:43:05 -07:00
@@ -118,7 +118,7 @@
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386
hardware has concept of busy TSS or some similar stupidity. */
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+        per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
 	load_LDT(&current->active_mm->context);	/* This does lldt */
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	2004-07-08 14:43:05 -07:00
+++ b/include/asm-i386/desc.h	2004-07-08 14:43:05 -07:00
@@ -11,7 +11,8 @@
 
 #include <asm/mmu.h>
 
-extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
 struct Xgt_desc_struct {
 	unsigned short size;
@@ -44,14 +45,14 @@
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr, 235, 0x89);
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr, 235, 0x89);
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
 #define LDT_entry_a(info) \
@@ -85,7 +86,7 @@
 
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-#define C(i) cpu_gdt_table[cpu][GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
 	C(0); C(1); C(2);
 #undef C
 }
=================================================================================
 
-----------------
Shai Fultheim
Scalex86.org



