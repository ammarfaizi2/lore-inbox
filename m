Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUGIB4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUGIB4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUGIBzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:55:18 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:37024 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S262772AbUGIByE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:54:04 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Jes Sorensen'" <jes@wildopensource.com>
Subject: [PATCH] PER_CPU [3/4] - PER_CPU-init_tss
Date: Thu, 8 Jul 2004 18:53:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlV5m1c0Y65Q8uRCa5bUuOhxq/yg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S262772AbUGIByE/20040709015404Z+1745@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please find below one out of collection of patched that move NR_CPU array variables to the per-cpu area.  Please consider applying,
any comment will highly appreciated.

1/4. PER_CPU-cpu_tlbstate
2/4. PER_CPU-irq_stat
3/4. PER_CPU-init_tss
4/4. PER_CPU-cpu_gdt_table

PER_CPU-init_tss:
 arch/i386/kernel/cpu/common.c |    2 +-
 arch/i386/kernel/init_task.c  |    7 ++-----
 arch/i386/kernel/ioport.c     |    2 +-
 arch/i386/kernel/process.c    |    4 ++--
 arch/i386/kernel/sysenter.c   |    2 +-
 arch/i386/kernel/vm86.c       |    4 ++--
 arch/i386/power/cpu.c         |    2 +-
 include/asm-i386/processor.h  |    4 ++--
 8 files changed, 12 insertions(+), 15 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=================================================================================
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/cpu/common.c	2004-07-08 14:43:09 -07:00
@@ -501,7 +501,7 @@
 void __init cpu_init (void)
 {
 	int cpu = smp_processor_id();
-	struct tss_struct * t = init_tss + cpu;
+	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 
 	if (test_and_set_bit(cpu, &cpu_initialized)) {
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/init_task.c	2004-07-08 14:43:09 -07:00
@@ -39,10 +39,7 @@
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
- * no more per-task TSS's. The TSS size is kept cacheline-aligned
- * so they are allowed to end up in the .data.cacheline_aligned
- * section. Since TSS's are completely CPU-local, we want them
- * on exact cacheline boundaries, to eliminate cacheline ping-pong.
+ * no more per-task TSS's.
  */ 
-struct tss_struct init_tss[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1] = INIT_TSS };
+DEFINE_PER_CPU(struct tss_struct, init_tss) = INIT_TSS;
 
diff -Nru a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c
--- a/arch/i386/kernel/ioport.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/ioport.c	2004-07-08 14:43:09 -07:00
@@ -83,7 +83,7 @@
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->io_bitmap_ptr, from, num, !turn_on);
-	tss = init_tss + get_cpu();
+	tss = &per_cpu(init_tss, get_cpu());
 	if (tss->io_bitmap_base == IO_BITMAP_OFFSET) { /* already active? */
 		set_bitmap(tss->io_bitmap, from, num, !turn_on);
 	} else {
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/process.c	2004-07-08 14:43:09 -07:00
@@ -298,7 +298,7 @@
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
 		int cpu = get_cpu();
-		struct tss_struct *tss = init_tss + cpu;
+		struct tss_struct *tss = &per_cpu(init_tss, cpu);
 		kfree(tsk->thread.io_bitmap_ptr);
 		tsk->thread.io_bitmap_ptr = NULL;
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
@@ -507,7 +507,7 @@
 	struct thread_struct *prev = &prev_p->thread,
 				 *next = &next_p->thread;
 	int cpu = smp_processor_id();
-	struct tss_struct *tss = init_tss + cpu;
+	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
diff -Nru a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/sysenter.c	2004-07-08 14:43:09 -07:00
@@ -24,7 +24,7 @@
 void enable_sep_cpu(void *info)
 {
 	int cpu = get_cpu();
-	struct tss_struct *tss = init_tss + cpu;
+	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 	tss->ss1 = __KERNEL_CS;
 	tss->esp1 = sizeof(struct tss_struct) + (unsigned long) tss;
diff -Nru a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/kernel/vm86.c	2004-07-08 14:43:09 -07:00
@@ -122,7 +122,7 @@
 		do_exit(SIGSEGV);
 	}
 
-	tss = init_tss + get_cpu();
+	tss = &per_cpu(init_tss, get_cpu());
 	current->thread.esp0 = current->thread.saved_esp0;
 	current->thread.sysenter_cs = __KERNEL_CS;
 	load_esp0(tss, &current->thread);
@@ -301,7 +301,7 @@
 	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
 	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
 
-	tss = init_tss + get_cpu();
+	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
 	if (cpu_has_sep)
 		tsk->thread.sysenter_cs = 0;
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
--- a/arch/i386/power/cpu.c	2004-07-08 14:43:09 -07:00
+++ b/arch/i386/power/cpu.c	2004-07-08 14:43:09 -07:00
@@ -115,7 +115,7 @@
 static void fix_processor_context(void)
 {
 	int cpu = smp_processor_id();
-	struct tss_struct * t = init_tss + cpu;
+	struct tss_struct * t = &per_cpu(init_tss, cpu);
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386
hardware has concept of busy TSS or some similar stupidity. */
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	2004-07-08 14:43:09 -07:00
+++ b/include/asm-i386/processor.h	2004-07-08 14:43:09 -07:00
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <asm/percpu.h>
 
 /* flag for disabling the tsc */
 extern int tsc_disable;
@@ -84,8 +85,8 @@
 
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 extern struct tss_struct doublefault_tss;
+DECLARE_PER_CPU(struct tss_struct, init_tss);
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -445,7 +446,6 @@
 #define INIT_TSS  {							\
 	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
 	.ss0		= __KERNEL_DS,					\
-	.esp1		= sizeof(init_tss[0]) + (long)&init_tss[0],	\
 	.ss1		= __KERNEL_CS,					\
 	.ldt		= GDT_ENTRY_LDT,				\
 	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
=================================================================================
 
-----------------
Shai Fultheim
Scalex86.org



