Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUIBKHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUIBKHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIBKHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:07:52 -0400
Received: from verein.lst.de ([213.95.11.210]:38046 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268115AbUIBKA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:00:57 -0400
Date: Thu, 2 Sep 2004 12:00:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] factor out common <asm/hardirq.h> code
Message-ID: <20040902100038.GA10991@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the irq handling rework in 2.5 lots of code in the individual
<asm/hardirq.h> files is the same.  This patch moves that common code
to <linux/hardirq.h>.  The following differences existed:

 - alpha, m68k, m68knommu and v850 were missing the ~PREEMPT_ACTIVE
   masking in the CONFIG_PREEMPT case of in_atomic().  These
   architectures don't support CONFIG_PREEMPT else this would have been
   an easily-spottbale bug
 - S390 didn't provide synchronize_irq as it doesn't fit into their
   I/O model.  They now get a spurious prototype/macro
 - ppc added a new preemptible() macro that is provided for all
   architectures now.

Most drivers were using <linux/interrupt.h> as they should, but a few
drivers and lots of architecture code has been updated to use
<linux/hardirq.h> instead of <asm/hardirq.h>


===== Documentation/DocBook/kernel-hacking.tmpl 1.17 vs edited =====
--- 1.17/Documentation/DocBook/kernel-hacking.tmpl	2004-05-19 18:02:52 +02:00
+++ edited/Documentation/DocBook/kernel-hacking.tmpl	2004-09-02 11:32:14 +02:00
@@ -145,7 +145,7 @@
     In user context, the <varname>current</varname> pointer (indicating 
     the task we are currently executing) is valid, and
     <function>in_interrupt()</function>
-    (<filename>include/asm/hardirq.h</filename>) is <returnvalue>false
+    (<filename>include/linux/interrupt.h</filename>) is <returnvalue>false
     </returnvalue>.  
    </para>
 
@@ -241,7 +241,7 @@
    <para>
     You can tell you are in a softirq (or bottom half, or tasklet)
     using the <function>in_softirq()</function> macro 
-    (<filename class="headerfile">include/asm/hardirq.h</filename>).
+    (<filename class="headerfile">include/linux/interrupt.h</filename>).
    </para>
    <caution>
     <para>
===== Documentation/firmware_class/firmware_sample_firmware_class.c 1.1 vs edited =====
--- 1.1/Documentation/firmware_class/firmware_sample_firmware_class.c	2003-06-15 13:11:53 +02:00
+++ edited/Documentation/firmware_class/firmware_sample_firmware_class.c	2004-09-02 11:31:32 +02:00
@@ -14,9 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
-#include <asm/hardirq.h>
+#include <linux/firmware.h>
 
-#include "linux/firmware.h"
 
 MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
 MODULE_DESCRIPTION("Hackish sample for using firmware class directly");
===== arch/alpha/kernel/smp.c 1.47 vs edited =====
--- 1.47/arch/alpha/kernel/smp.c	2004-08-27 08:30:31 +02:00
+++ edited/arch/alpha/kernel/smp.c	2004-09-01 16:52:13 +02:00
@@ -36,7 +36,6 @@
 #include <asm/bitops.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
===== arch/cris/kernel/crisksyms.c 1.7 vs edited =====
--- 1.7/arch/cris/kernel/crisksyms.c	2004-06-01 11:27:58 +02:00
+++ edited/arch/cris/kernel/crisksyms.c	2004-09-02 11:23:16 +02:00
@@ -16,7 +16,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
===== arch/h8300/kernel/asm-offsets.c 1.3 vs edited =====
--- 1.3/arch/h8300/kernel/asm-offsets.c	2004-04-12 19:55:03 +02:00
+++ edited/arch/h8300/kernel/asm-offsets.c	2004-09-02 11:29:22 +02:00
@@ -12,9 +12,9 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/ptrace.h>
+#include <linux/hardirq.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/ptrace.h>
 
 #define DEFINE(sym, val) \
===== arch/h8300/kernel/h8300_ksyms.c 1.4 vs edited =====
--- 1.4/arch/h8300/kernel/h8300_ksyms.c	2004-05-25 11:53:07 +02:00
+++ edited/arch/h8300/kernel/h8300_ksyms.c	2004-09-02 11:28:23 +02:00
@@ -15,7 +15,6 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
-#include <asm/hardirq.h>
 #include <asm/current.h>
 #include <asm/gpio.h>
 
===== arch/h8300/kernel/ints.c 1.10 vs edited =====
--- 1.10/arch/h8300/kernel/ints.c	2004-04-12 19:55:03 +02:00
+++ edited/arch/h8300/kernel/ints.c	2004-09-02 11:28:31 +02:00
@@ -22,13 +22,13 @@
 #include <linux/init.h>
 #include <linux/random.h>
 #include <linux/bootmem.h>
+#include <linux/hardirq.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
 #include <asm/io.h>
 #include <asm/setup.h>
-#include <asm/hardirq.h>
 #include <asm/errno.h>
 
 /*
===== arch/h8300/platform/h8s/ints.c 1.8 vs edited =====
--- 1.8/arch/h8300/platform/h8s/ints.c	2004-02-01 18:09:58 +01:00
+++ edited/arch/h8300/platform/h8s/ints.c	2004-09-02 11:28:39 +02:00
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/random.h>
+#include <linux/hardirq.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -29,7 +30,6 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/gpio.h>
-#include <asm/hardirq.h>
 #include <asm/regs267x.h>
 #include <asm/errno.h>
 
===== arch/i386/kernel/i386_ksyms.c 1.63 vs edited =====
--- 1.63/arch/i386/kernel/i386_ksyms.c	2004-08-31 09:55:10 +02:00
+++ edited/arch/i386/kernel/i386_ksyms.c	2004-09-02 11:23:18 +02:00
@@ -23,7 +23,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/mmx.h>
===== arch/i386/lib/mmx.c 1.8 vs edited =====
--- 1.8/arch/i386/lib/mmx.c	2003-02-25 11:41:19 +01:00
+++ edited/arch/i386/lib/mmx.c	2004-09-02 11:22:29 +02:00
@@ -2,9 +2,9 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/hardirq.h> 
 
 #include <asm/i387.h>
-#include <asm/hardirq.h> 
 
 
 /*
===== arch/i386/mm/fault.c 1.38 vs edited =====
--- 1.38/arch/i386/mm/fault.c	2004-08-31 09:55:10 +02:00
+++ edited/arch/i386/mm/fault.c	2004-09-02 11:22:33 +02:00
@@ -24,7 +24,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/desc.h>
 #include <asm/kdebug.h>
 
===== arch/ia64/kernel/traps.c 1.45 vs edited =====
--- 1.45/arch/ia64/kernel/traps.c	2004-05-11 08:44:41 +02:00
+++ edited/arch/ia64/kernel/traps.c	2004-09-02 11:23:25 +02:00
@@ -14,9 +14,9 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>       /* for EXPORT_SYMBOL */
+#include <linux/hardirq.h>
 
 #include <asm/fpswa.h>
-#include <asm/hardirq.h>
 #include <asm/ia32.h>
 #include <asm/intrinsics.h>
 #include <asm/processor.h>
===== arch/ia64/mm/fault.c 1.19 vs edited =====
--- 1.19/arch/ia64/mm/fault.c	2004-08-27 09:02:34 +02:00
+++ edited/arch/ia64/mm/fault.c	2004-09-02 11:22:44 +02:00
@@ -14,7 +14,6 @@
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 extern void die (char *, struct pt_regs *, long);
 
===== arch/m68k/kernel/m68k_ksyms.c 1.11 vs edited =====
--- 1.11/arch/m68k/kernel/m68k_ksyms.c	2003-04-01 00:29:49 +02:00
+++ edited/arch/m68k/kernel/m68k_ksyms.c	2004-09-02 11:22:47 +02:00
@@ -16,7 +16,6 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
-#include <asm/hardirq.h>
 
 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
===== arch/m68k/q40/q40ints.c 1.21 vs edited =====
--- 1.21/arch/m68k/q40/q40ints.c	2004-04-04 12:11:21 +02:00
+++ edited/arch/m68k/q40/q40ints.c	2004-09-02 11:22:55 +02:00
@@ -19,12 +19,12 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/hardirq.h>
 
 #include <asm/rtc.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/traps.h>
 
 #include <asm/q40_master.h>
===== arch/m68knommu/kernel/asm-offsets.c 1.3 vs edited =====
--- 1.3/arch/m68knommu/kernel/asm-offsets.c	2003-02-16 04:30:17 +01:00
+++ edited/arch/m68knommu/kernel/asm-offsets.c	2004-09-02 11:23:02 +02:00
@@ -12,9 +12,9 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/ptrace.h>
+#include <linux/hardirq.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
===== arch/m68knommu/kernel/m68k_ksyms.c 1.4 vs edited =====
--- 1.4/arch/m68knommu/kernel/m68k_ksyms.c	2004-05-10 15:51:25 +02:00
+++ edited/arch/m68knommu/kernel/m68k_ksyms.c	2004-09-02 11:23:11 +02:00
@@ -16,7 +16,6 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
-#include <asm/hardirq.h>
 #include <asm/current.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
===== arch/mips/au1000/common/time.c 1.6 vs edited =====
--- 1.6/arch/mips/au1000/common/time.c	2004-02-19 21:53:00 +01:00
+++ edited/arch/mips/au1000/common/time.c	2004-09-02 11:28:48 +02:00
@@ -38,11 +38,11 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/hardirq.h>
 
 #include <asm/mipsregs.h>
 #include <asm/ptrace.h>
 #include <asm/time.h>
-#include <asm/hardirq.h>
 #include <asm/div64.h>
 #include <asm/mach-au1x00/au1000.h>
 
===== arch/mips/kernel/smp.c 1.19 vs edited =====
--- 1.19/arch/mips/kernel/smp.c	2004-08-24 11:08:12 +02:00
+++ edited/arch/mips/kernel/smp.c	2004-09-02 11:28:52 +02:00
@@ -35,7 +35,6 @@
 #include <asm/cpu.h>
 #include <asm/processor.h>
 #include <asm/system.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
 
===== arch/mips/kernel/time.c 1.16 vs edited =====
--- 1.16/arch/mips/kernel/time.c	2004-08-27 08:30:31 +02:00
+++ edited/arch/mips/kernel/time.c	2004-09-02 11:28:54 +02:00
@@ -29,7 +29,6 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/div64.h>
-#include <asm/hardirq.h>
 #include <asm/sections.h>
 #include <asm/time.h>
 
===== arch/mips/mips-boards/generic/time.c 1.7 vs edited =====
--- 1.7/arch/mips/mips-boards/generic/time.c	2004-02-19 21:53:00 +01:00
+++ edited/arch/mips/mips-boards/generic/time.c	2004-09-02 11:28:58 +02:00
@@ -31,7 +31,6 @@
 
 #include <asm/mipsregs.h>
 #include <asm/ptrace.h>
-#include <asm/hardirq.h>
 #include <asm/div64.h>
 #include <asm/cpu.h>
 #include <asm/time.h>
===== arch/mips/mm/fault.c 1.10 vs edited =====
--- 1.10/arch/mips/mm/fault.c	2004-04-20 08:53:22 +02:00
+++ edited/arch/mips/mm/fault.c	2004-09-02 11:29:02 +02:00
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 
 #include <asm/branch.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== arch/parisc/kernel/asm-offsets.c 1.6 vs edited =====
--- 1.6/arch/parisc/kernel/asm-offsets.c	2004-05-10 11:18:36 +02:00
+++ edited/arch/parisc/kernel/asm-offsets.c	2004-09-02 11:29:12 +02:00
@@ -32,11 +32,11 @@
 #include <linux/thread_info.h>
 #include <linux/version.h>
 #include <linux/ptrace.h>
-#include <asm/pgtable.h>
+#include <linux/hardirq.h>
 
+#include <asm/pgtable.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
-#include <asm/hardirq.h>
 #include <asm/pdc.h>
 
 #define DEFINE(sym, val) \
===== arch/parisc/lib/debuglocks.c 1.1 vs edited =====
--- 1.1/arch/parisc/lib/debuglocks.c	2004-07-14 14:20:34 +02:00
+++ edited/arch/parisc/lib/debuglocks.c	2004-09-02 11:29:19 +02:00
@@ -25,8 +25,8 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/hardirq.h>	/* in_interrupt() */
 #include <asm/system.h>
-#include <asm/hardirq.h>	/* in_interrupt() */
 
 #undef INIT_STUCK
 #define INIT_STUCK 1L << 30
===== arch/ppc/kernel/dma-mapping.c 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/dma-mapping.c	2004-08-23 10:14:35 +02:00
+++ edited/arch/ppc/kernel/dma-mapping.c	2004-09-02 11:30:54 +02:00
@@ -41,11 +41,11 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/dma-mapping.h>
+#include <linux/hardirq.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
===== arch/ppc/kernel/process.c 1.55 vs edited =====
--- 1.55/arch/ppc/kernel/process.c	2004-08-27 09:02:36 +02:00
+++ edited/arch/ppc/kernel/process.c	2004-09-02 11:30:13 +02:00
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/mqueue.h>
+#include <linux/hardirq.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -44,7 +45,6 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/prom.h>
-#include <asm/hardirq.h>
 
 extern unsigned long _get_SP(void);
 
===== arch/ppc/kernel/smp.c 1.45 vs edited =====
--- 1.45/arch/ppc/kernel/smp.c	2004-08-24 11:08:12 +02:00
+++ edited/arch/ppc/kernel/smp.c	2004-09-02 11:30:16 +02:00
@@ -26,7 +26,6 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
===== arch/ppc/platforms/chrp_smp.c 1.10 vs edited =====
--- 1.10/arch/ppc/platforms/chrp_smp.c	2004-03-14 02:57:41 +01:00
+++ edited/arch/ppc/platforms/chrp_smp.c	2004-09-02 11:30:19 +02:00
@@ -24,7 +24,6 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/prom.h>
===== arch/ppc/platforms/pmac_cpufreq.c 1.13 vs edited =====
--- 1.13/arch/ppc/platforms/pmac_cpufreq.c	2004-07-30 17:41:37 +02:00
+++ edited/arch/ppc/platforms/pmac_cpufreq.c	2004-09-02 11:30:28 +02:00
@@ -24,10 +24,10 @@
 #include <linux/init.h>
 #include <linux/sysdev.h>
 #include <linux/i2c.h>
+#include <linux/hardirq.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/pmac_feature.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
===== arch/ppc/platforms/pmac_smp.c 1.19 vs edited =====
--- 1.19/arch/ppc/platforms/pmac_smp.c	2004-07-26 20:42:45 +02:00
+++ edited/arch/ppc/platforms/pmac_smp.c	2004-09-02 11:30:37 +02:00
@@ -32,13 +32,13 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/hardirq.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/prom.h>
===== arch/ppc/platforms/pmac_time.c 1.14 vs edited =====
--- 1.14/arch/ppc/platforms/pmac_time.c	2004-02-05 06:32:23 +01:00
+++ edited/arch/ppc/platforms/pmac_time.c	2004-09-02 11:30:47 +02:00
@@ -19,6 +19,7 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
+#include <linux/hardirq.h>
 
 #include <asm/sections.h>
 #include <asm/prom.h>
@@ -26,7 +27,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/machdep.h>
-#include <asm/hardirq.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
 
===== arch/ppc/syslib/open_pic.c 1.36 vs edited =====
--- 1.36/arch/ppc/syslib/open_pic.c	2004-07-29 07:48:21 +02:00
+++ edited/arch/ppc/syslib/open_pic.c	2004-09-02 11:30:49 +02:00
@@ -24,7 +24,6 @@
 #include <asm/sections.h>
 #include <asm/open_pic.h>
 #include <asm/i8259.h>
-#include <asm/hardirq.h>
 
 #include "open_pic_defs.h"
 
===== arch/ppc/syslib/open_pic2.c 1.2 vs edited =====
--- 1.2/arch/ppc/syslib/open_pic2.c	2004-02-13 07:10:06 +01:00
+++ edited/arch/ppc/syslib/open_pic2.c	2004-09-02 11:30:52 +02:00
@@ -28,7 +28,6 @@
 #include <asm/sections.h>
 #include <asm/open_pic.h>
 #include <asm/i8259.h>
-#include <asm/hardirq.h>
 
 #include "open_pic_defs.h"
 
===== arch/ppc64/kernel/asm-offsets.c 1.24 vs edited =====
--- 1.24/arch/ppc64/kernel/asm-offsets.c	2004-08-27 08:30:32 +02:00
+++ edited/arch/ppc64/kernel/asm-offsets.c	2004-09-01 16:54:11 +02:00
@@ -22,11 +22,11 @@
 #include <linux/types.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/hardirq.h>
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
-#include <asm/hardirq.h>
 
 #include <asm/naca.h>
 #include <asm/paca.h>
===== arch/ppc64/kernel/pmac_smp.c 1.4 vs edited =====
--- 1.4/arch/ppc64/kernel/pmac_smp.c	2004-07-02 07:23:46 +02:00
+++ edited/arch/ppc64/kernel/pmac_smp.c	2004-09-01 16:52:57 +02:00
@@ -38,7 +38,6 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/prom.h>
===== arch/ppc64/kernel/pmac_time.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/pmac_time.c	2004-03-21 11:27:41 +01:00
+++ edited/arch/ppc64/kernel/pmac_time.c	2004-09-01 16:53:12 +02:00
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/interrupt.h>
 
 #include <asm/sections.h>
 #include <asm/prom.h>
@@ -25,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/machdep.h>
-#include <asm/hardirq.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
 
===== arch/ppc64/kernel/process.c 1.61 vs edited =====
--- 1.61/arch/ppc64/kernel/process.c	2004-08-24 11:08:42 +02:00
+++ edited/arch/ppc64/kernel/process.c	2004-09-01 16:57:32 +02:00
@@ -34,6 +34,7 @@
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
+#include <linux/interrupt.h>
 #include <linux/version.h>
 
 #include <asm/pgtable.h>
@@ -47,7 +48,6 @@
 #include <asm/ppcdebug.h>
 #include <asm/machdep.h>
 #include <asm/iSeries/HvCallHpt.h>
-#include <asm/hardirq.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
===== arch/ppc64/kernel/rtc.c 1.14 vs edited =====
--- 1.14/arch/ppc64/kernel/rtc.c	2004-08-08 23:22:04 +02:00
+++ edited/arch/ppc64/kernel/rtc.c	2004-09-01 16:53:43 +02:00
@@ -34,8 +34,8 @@
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/bcd.h>
+#include <linux/interrupt.h>
 
-#include <asm/hardirq.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
===== arch/ppc64/kernel/smp.c 1.89 vs edited =====
--- 1.89/arch/ppc64/kernel/smp.c	2004-08-31 09:57:57 +02:00
+++ edited/arch/ppc64/kernel/smp.c	2004-09-01 16:53:58 +02:00
@@ -36,7 +36,6 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
===== arch/ppc64/kernel/viopath.c 1.10 vs edited =====
--- 1.10/arch/ppc64/kernel/viopath.c	2004-07-11 11:23:25 +02:00
+++ edited/arch/ppc64/kernel/viopath.c	2004-09-01 16:53:54 +02:00
@@ -38,8 +38,8 @@
 #include <linux/wait.h>
 #include <linux/seq_file.h>
 #include <linux/smp_lock.h>
+#include <linux/interrupt.h>
 
-#include <asm/hardirq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/iSeries/LparData.h>
===== arch/ppc64/mm/tlb.c 1.6 vs edited =====
--- 1.6/arch/ppc64/mm/tlb.c	2004-06-24 10:55:48 +02:00
+++ edited/arch/ppc64/mm/tlb.c	2004-09-01 16:54:08 +02:00
@@ -26,10 +26,10 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/hardirq.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
-#include <asm/hardirq.h>
 #include <linux/highmem.h>
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
===== arch/s390/mm/fault.c 1.20 vs edited =====
--- 1.20/arch/s390/mm/fault.c	2004-08-27 15:24:18 +02:00
+++ edited/arch/s390/mm/fault.c	2004-09-02 11:25:37 +02:00
@@ -25,11 +25,11 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/module.h>
+#include <linux/hardirq.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 
 #ifndef CONFIG_ARCH_S390X
 #define __FAIL_ADDR_MASK 0x7ffff000
===== arch/sh/kernel/sh_ksyms.c 1.13 vs edited =====
--- 1.13/arch/sh/kernel/sh_ksyms.c	2004-06-24 10:56:13 +02:00
+++ edited/arch/sh/kernel/sh_ksyms.c	2004-09-02 11:24:35 +02:00
@@ -16,7 +16,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
===== arch/sh/kernel/smp.c 1.4 vs edited =====
--- 1.4/arch/sh/kernel/smp.c	2004-08-24 11:08:12 +02:00
+++ edited/arch/sh/kernel/smp.c	2004-09-02 11:24:37 +02:00
@@ -26,7 +26,6 @@
 #include <asm/atomic.h>
 #include <asm/processor.h>
 #include <asm/system.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
 
===== arch/sh/mm/fault-nommu.c 1.1 vs edited =====
--- 1.1/arch/sh/mm/fault-nommu.c	2003-05-04 17:29:54 +02:00
+++ edited/arch/sh/mm/fault-nommu.c	2004-09-02 11:24:41 +02:00
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh/mm/fault.c 1.12 vs edited =====
--- 1.12/arch/sh/mm/fault.c	2004-02-13 16:19:29 +01:00
+++ edited/arch/sh/mm/fault.c	2004-09-02 11:24:44 +02:00
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/kgdb.h>
===== arch/sh/mm/tlb-sh3.c 1.3 vs edited =====
--- 1.3/arch/sh/mm/tlb-sh3.c	2004-06-24 10:56:13 +02:00
+++ edited/arch/sh/mm/tlb-sh3.c	2004-09-02 11:24:57 +02:00
@@ -25,7 +25,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh/mm/tlb-sh4.c 1.2 vs edited =====
--- 1.2/arch/sh/mm/tlb-sh4.c	2004-03-23 11:05:26 +01:00
+++ edited/arch/sh/mm/tlb-sh4.c	2004-09-02 11:25:04 +02:00
@@ -25,7 +25,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
===== arch/sh64/kernel/sh_ksyms.c 1.1 vs edited =====
--- 1.1/arch/sh64/kernel/sh_ksyms.c	2004-06-29 16:44:46 +02:00
+++ edited/arch/sh64/kernel/sh_ksyms.c	2004-09-02 11:25:09 +02:00
@@ -25,7 +25,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 
===== arch/sh64/mm/fault.c 1.1 vs edited =====
--- 1.1/arch/sh64/mm/fault.c	2004-06-29 16:44:46 +02:00
+++ edited/arch/sh64/mm/fault.c	2004-09-02 11:25:13 +02:00
@@ -30,7 +30,6 @@
 #include <asm/tlb.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/registers.h>		/* required by inline asm statements */
 
===== arch/sh64/mm/tlbmiss.c 1.1 vs edited =====
--- 1.1/arch/sh64/mm/tlbmiss.c	2004-06-29 16:44:46 +02:00
+++ edited/arch/sh64/mm/tlbmiss.c	2004-09-02 11:25:18 +02:00
@@ -40,7 +40,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/registers.h>		/* required by inline asm statements */
 
===== arch/sparc/kernel/irq.c 1.31 vs edited =====
--- 1.31/arch/sparc/kernel/irq.c	2004-07-13 15:06:21 +02:00
+++ edited/arch/sparc/kernel/irq.c	2004-09-02 11:27:18 +02:00
@@ -45,7 +45,6 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/hardirq.h>
 #include <asm/pcic.h>
 #include <asm/cacheflush.h>
 
===== arch/sparc/kernel/setup.c 1.30 vs edited =====
--- 1.30/arch/sparc/kernel/setup.c	2004-07-12 08:09:37 +02:00
+++ edited/arch/sparc/kernel/setup.c	2004-09-02 11:26:37 +02:00
@@ -44,7 +44,6 @@
 #include <asm/kdebug.h>
 #include <asm/mbus.h>
 #include <asm/idprom.h>
-#include <asm/hardirq.h>
 #include <asm/machines.h>
 #include <asm/cpudata.h>
 #include <asm/setup.h>
===== arch/sparc/kernel/smp.c 1.19 vs edited =====
--- 1.19/arch/sparc/kernel/smp.c	2004-08-07 20:03:28 +02:00
+++ edited/arch/sparc/kernel/smp.c	2004-09-02 11:26:40 +02:00
@@ -30,7 +30,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
-#include <asm/hardirq.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/cpudata.h>
===== arch/sparc/kernel/sparc_ksyms.c 1.34 vs edited =====
--- 1.34/arch/sparc/kernel/sparc_ksyms.c	2004-08-31 10:09:37 +02:00
+++ edited/arch/sparc/kernel/sparc_ksyms.c	2004-09-02 11:26:42 +02:00
@@ -41,7 +41,6 @@
 #include <asm/smp.h>
 #include <asm/mostek.h>
 #include <asm/ptrace.h>
-#include <asm/hardirq.h>
 #include <asm/user.h>
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
===== arch/sparc/kernel/sun4d_smp.c 1.24 vs edited =====
--- 1.24/arch/sparc/kernel/sun4d_smp.c	2004-08-27 08:30:31 +02:00
+++ edited/arch/sparc/kernel/sun4d_smp.c	2004-09-02 11:26:46 +02:00
@@ -30,7 +30,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
-#include <asm/hardirq.h>
 #include <asm/sbus.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
===== arch/sparc/kernel/sun4m_smp.c 1.21 vs edited =====
--- 1.21/arch/sparc/kernel/sun4m_smp.c	2004-08-27 08:30:31 +02:00
+++ edited/arch/sparc/kernel/sun4m_smp.c	2004-09-02 11:26:48 +02:00
@@ -29,7 +29,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
-#include <asm/hardirq.h>
 #include <asm/cpudata.h>
 
 #define IRQ_RESCHEDULE		13
===== arch/sparc64/kernel/irq.c 1.45 vs edited =====
--- 1.45/arch/sparc64/kernel/irq.c	2004-07-13 15:08:20 +02:00
+++ edited/arch/sparc64/kernel/irq.c	2004-09-02 11:26:52 +02:00
@@ -33,7 +33,6 @@
 #include <asm/oplib.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
-#include <asm/hardirq.h>
 #include <asm/starfire.h>
 #include <asm/uaccess.h>
 #include <asm/cache.h>
===== arch/sparc64/kernel/setup.c 1.54 vs edited =====
--- 1.54/arch/sparc64/kernel/setup.c	2004-06-27 09:19:38 +02:00
+++ edited/arch/sparc64/kernel/setup.c	2004-09-02 11:26:54 +02:00
@@ -43,7 +43,6 @@
 #include <asm/idprom.h>
 #include <asm/head.h>
 #include <asm/starfire.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/timer.h>
 #include <asm/sections.h>
===== arch/sparc64/kernel/smp.c 1.78 vs edited =====
--- 1.78/arch/sparc64/kernel/smp.c	2004-08-27 08:30:31 +02:00
+++ edited/arch/sparc64/kernel/smp.c	2004-09-02 11:26:57 +02:00
@@ -32,7 +32,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
-#include <asm/hardirq.h>
 #include <asm/uaccess.h>
 #include <asm/timer.h>
 #include <asm/starfire.h>
===== arch/sparc64/kernel/sparc64_ksyms.c 1.81 vs edited =====
--- 1.81/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-28 01:10:13 +02:00
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	2004-09-02 11:27:01 +02:00
@@ -34,7 +34,6 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/idprom.h>
 #include <asm/svr4.h>
 #include <asm/elf.h>
===== arch/um/drivers/stdio_console.c 1.14 vs edited =====
--- 1.14/arch/um/drivers/stdio_console.c	2004-08-24 11:08:22 +02:00
+++ edited/arch/um/drivers/stdio_console.c	2004-09-01 16:55:01 +02:00
@@ -17,8 +17,8 @@
 #include "linux/init.h"
 #include "linux/interrupt.h"
 #include "linux/slab.h"
+#include "linux/hardirq.h"
 #include "asm/current.h"
-#include "asm/hardirq.h"
 #include "asm/irq.h"
 #include "stdio_console.h"
 #include "line.h"
===== arch/um/kernel/irq.c 1.18 vs edited =====
--- 1.18/arch/um/kernel/irq.c	2004-08-31 09:57:57 +02:00
+++ edited/arch/um/kernel/irq.c	2004-09-01 16:54:38 +02:00
@@ -19,9 +19,9 @@
 #include "linux/init.h"
 #include "linux/seq_file.h"
 #include "linux/profile.h"
+#include "linux/hardirq.h"
 #include "asm/irq.h"
 #include "asm/hw_irq.h"
-#include "asm/hardirq.h"
 #include "asm/atomic.h"
 #include "asm/signal.h"
 #include "asm/system.h"
===== arch/um/kernel/smp.c 1.13 vs edited =====
--- 1.13/arch/um/kernel/smp.c	2004-08-24 11:08:29 +02:00
+++ edited/arch/um/kernel/smp.c	2004-09-01 16:54:58 +02:00
@@ -18,10 +18,10 @@
 #include "linux/threads.h"
 #include "linux/interrupt.h"
 #include "linux/err.h"
+#include "linux/hardirq.h"
 #include "asm/smp.h"
 #include "asm/processor.h"
 #include "asm/spinlock.h"
-#include "asm/hardirq.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
===== arch/v850/kernel/asm-consts.c 1.2 vs edited =====
--- 1.2/arch/v850/kernel/asm-consts.c	2003-02-16 04:30:17 +01:00
+++ edited/arch/v850/kernel/asm-consts.c	2004-09-02 11:25:31 +02:00
@@ -12,8 +12,8 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/ptrace.h>
+#include <linux/hardirq.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/errno.h>
 
 #define DEFINE(sym, val) \
===== arch/v850/kernel/v850_ksyms.c 1.4 vs edited =====
--- 1.4/arch/v850/kernel/v850_ksyms.c	2003-07-25 04:24:25 +02:00
+++ edited/arch/v850/kernel/v850_ksyms.c	2004-09-02 11:25:35 +02:00
@@ -14,7 +14,6 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
-#include <asm/hardirq.h>
 #include <asm/current.h>
 
 
===== arch/x86_64/kernel/asm-offsets.c 1.4 vs edited =====
--- 1.4/arch/x86_64/kernel/asm-offsets.c	2003-06-07 11:36:51 +02:00
+++ edited/arch/x86_64/kernel/asm-offsets.c	2004-09-02 11:27:09 +02:00
@@ -7,8 +7,8 @@
 #include <linux/sched.h> 
 #include <linux/stddef.h>
 #include <linux/errno.h> 
+#include <linux/hardirq.h>
 #include <asm/pda.h>
-#include <asm/hardirq.h>
 #include <asm/processor.h>
 #include <asm/segment.h>
 #include <asm/thread_info.h>
===== arch/x86_64/kernel/x8664_ksyms.c 1.34 vs edited =====
--- 1.34/arch/x86_64/kernel/x8664_ksyms.c	2004-08-24 11:08:31 +02:00
+++ edited/arch/x86_64/kernel/x8664_ksyms.c	2004-09-02 11:27:12 +02:00
@@ -21,7 +21,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/mmx.h>
===== arch/x86_64/mm/fault.c 1.26 vs edited =====
--- 1.26/arch/x86_64/mm/fault.c	2004-08-24 11:08:31 +02:00
+++ edited/arch/x86_64/mm/fault.c	2004-09-02 11:27:16 +02:00
@@ -27,7 +27,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
-#include <asm/hardirq.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 #include <asm/proto.h>
===== crypto/internal.h 1.20 vs edited =====
--- 1.20/crypto/internal.h	2004-03-02 04:01:26 +01:00
+++ edited/crypto/internal.h	2004-09-01 16:51:50 +02:00
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
-#include <asm/hardirq.h>
 #include <asm/kmap_types.h>
 
 extern enum km_type crypto_km_types[];
===== drivers/base/firmware_class.c 1.18 vs edited =====
--- 1.18/drivers/base/firmware_class.c	2004-06-10 08:34:24 +02:00
+++ edited/drivers/base/firmware_class.c	2004-09-01 16:51:24 +02:00
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
-#include <asm/hardirq.h>
+#include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <asm/semaphore.h>
 
===== drivers/char/rio/linux_compat.h 1.3 vs edited =====
--- 1.3/drivers/char/rio/linux_compat.h	2002-02-05 16:23:17 +01:00
+++ edited/drivers/char/rio/linux_compat.h	2004-09-01 16:51:32 +02:00
@@ -16,7 +16,7 @@
  *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <asm/hardirq.h>
+#include <linux/interrupt.h>
 
 
 #define disable(oldspl) save_flags (oldspl)
===== drivers/macintosh/via-pmu.c 1.35 vs edited =====
--- 1.35/drivers/macintosh/via-pmu.c	2004-07-27 00:05:13 +02:00
+++ edited/drivers/macintosh/via-pmu.c	2004-09-01 16:51:37 +02:00
@@ -52,7 +52,6 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
-#include <asm/hardirq.h>
 #include <asm/pmac_feature.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
===== drivers/s390/cio/cio.c 1.25 vs edited =====
--- 1.25/drivers/s390/cio/cio.c	2004-07-02 07:23:50 +02:00
+++ edited/drivers/s390/cio/cio.c	2004-09-01 16:51:47 +02:00
@@ -17,8 +17,8 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
 
-#include <asm/hardirq.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
===== include/asm-alpha/hardirq.h 1.8 vs edited =====
--- 1.8/include/asm-alpha/hardirq.h	2003-05-13 03:59:24 +02:00
+++ edited/include/asm-alpha/hardirq.h	2004-09-01 16:38:27 +02:00
@@ -39,20 +39,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially nestable IRQ sources in the system
@@ -64,28 +50,7 @@
 #error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-
-#ifdef CONFIG_PREEMPT
-#define in_atomic()	(preempt_count() != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-#define in_atomic()	(preempt_count() != 0)
-#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-# endif
 #define irq_exit()						\
 do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;		\
@@ -94,11 +59,5 @@
 			do_softirq();				\
 		preempt_enable_no_resched();			\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* _ALPHA_HARDIRQ_H */
===== include/asm-arm/hardirq.h 1.12 vs edited =====
--- 1.12/include/asm-arm/hardirq.h	2004-08-20 10:06:19 +02:00
+++ edited/include/asm-arm/hardirq.h	2004-09-01 16:38:35 +02:00
@@ -41,20 +41,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK|SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have space
  * for potentially all IRQ sources in the system nesting
@@ -64,29 +50,9 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #ifndef CONFIG_SMP
-
 extern asmlinkage void __do_softirq(void);
 
 #define irq_exit()							\
@@ -96,10 +62,6 @@
 			__do_softirq();					\
 		preempt_enable_no_resched();				\
 	} while (0)
-
-#define synchronize_irq(irq)	barrier()
-#else
-extern void synchronize_irq(unsigned int irq);
 #endif
 
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-arm26/hardirq.h 1.2 vs edited =====
--- 1.2/include/asm-arm26/hardirq.h	2003-09-24 08:15:36 +02:00
+++ edited/include/asm-arm26/hardirq.h	2004-09-01 16:38:46 +02:00
@@ -32,20 +32,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK|SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have space
  * for potentially all IRQ sources in the system nesting
@@ -55,26 +41,8 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
-# define in_atomic()    ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()    (preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #ifndef CONFIG_SMP
 #define irq_exit()							\
 	do {								\
@@ -84,9 +52,6 @@
 		preempt_enable_no_resched();				\
 	} while (0)
 
-#define synchronize_irq(irq)	barrier()
-#else
-#error SMP not supported
 #endif
 
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-cris/hardirq.h 1.3 vs edited =====
--- 1.3/include/asm-cris/hardirq.h	2003-04-09 09:25:27 +02:00
+++ edited/include/asm-cris/hardirq.h	2004-09-01 16:38:52 +02:00
@@ -40,20 +40,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -63,27 +49,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -91,7 +57,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#define synchronize_irq(irq)	barrier()
 
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-generic/local.h 1.2 vs edited =====
--- 1.2/include/asm-generic/local.h	2004-02-14 06:24:01 +01:00
+++ edited/include/asm-generic/local.h	2004-09-01 16:48:15 +02:00
@@ -3,8 +3,8 @@
 
 #include <linux/config.h>
 #include <linux/percpu.h>
+#include <linux/hardirq.h>
 #include <asm/types.h>
-#include <asm/hardirq.h>
 
 /* An unsigned long type for operations which are atomic for a single
  * CPU.  Usually used in combination with per-cpu variables. */
===== include/asm-h8300/hardirq.h 1.4 vs edited =====
--- 1.4/include/asm-h8300/hardirq.h	2004-05-15 04:00:16 +02:00
+++ edited/include/asm-h8300/hardirq.h	2004-09-01 16:42:07 +02:00
@@ -38,20 +38,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -61,27 +47,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -89,11 +55,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-# error h8300 SMP is not available
-#endif /* CONFIG_SMP */
 
 #endif
===== include/asm-i386/hardirq.h 1.21 vs edited =====
--- 1.21/include/asm-i386/hardirq.h	2003-08-05 19:36:52 +02:00
+++ edited/include/asm-i386/hardirq.h	2004-09-01 16:43:30 +02:00
@@ -37,20 +37,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -60,30 +46,10 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
-# include <linux/smp_lock.h>
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -91,11 +57,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-ia64/hardirq.h 1.15 vs edited =====
--- 1.15/include/asm-ia64/hardirq.h	2004-03-01 21:25:25 +01:00
+++ edited/include/asm-ia64/hardirq.h	2004-09-01 16:39:11 +02:00
@@ -52,20 +52,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have space for potentially all IRQ sources
  * in the system nesting on a single CPU:
@@ -73,32 +59,5 @@
 #if (1 << HARDIRQ_BITS) < NR_IRQS
 # error HARDIRQ_BITS is too low!
 #endif
-
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context?
- * Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#ifdef CONFIG_PREEMPT
-# include <linux/smp_lock.h>
-# define in_atomic()		((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()		(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
-#ifdef CONFIG_SMP
-  extern void synchronize_irq (unsigned int irq);
-#else
-# define synchronize_irq(irq)	barrier()
-#endif /* CONFIG_SMP */
 
 #endif /* _ASM_IA64_HARDIRQ_H */
===== include/asm-m68k/hardirq.h 1.6 vs edited =====
--- 1.6/include/asm-m68k/hardirq.h	2004-07-29 06:58:43 +02:00
+++ edited/include/asm-m68k/hardirq.h	2004-09-01 16:39:22 +02:00
@@ -35,20 +35,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -58,27 +44,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	(preempt_count() != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -86,7 +52,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#define synchronize_irq(irq)	barrier()
 
 #endif
===== include/asm-m68k/system.h 1.12 vs edited =====
--- 1.12/include/asm-m68k/system.h	2004-02-23 06:24:08 +01:00
+++ edited/include/asm-m68k/system.h	2004-09-01 16:47:13 +02:00
@@ -51,7 +51,7 @@
 #if 0
 #define local_irq_enable() asm volatile ("andiw %0,%%sr": : "i" (ALLOWINT) : "memory")
 #else
-#include <asm/hardirq.h>
+#include <linux/hardirq.h>
 #define local_irq_enable() ({							\
 	if (MACH_IS_Q40 || !hardirq_count())					\
 		asm volatile ("andiw %0,%%sr": : "i" (ALLOWINT) : "memory");	\
===== include/asm-m68knommu/hardirq.h 1.3 vs edited =====
--- 1.3/include/asm-m68knommu/hardirq.h	2003-05-13 03:59:23 +02:00
+++ edited/include/asm-m68knommu/hardirq.h	2004-09-01 16:39:27 +02:00
@@ -36,20 +36,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -59,33 +45,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	(preempt_count() != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -93,11 +53,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-# error m68knommu SMP is not available
-#endif /* CONFIG_SMP */
 
 #endif /* __M68K_HARDIRQ_H */
===== include/asm-mips/hardirq.h 1.8 vs edited =====
--- 1.8/include/asm-mips/hardirq.h	2004-04-20 08:53:22 +02:00
+++ edited/include/asm-mips/hardirq.h	2004-09-01 16:39:32 +02:00
@@ -43,20 +43,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -66,27 +52,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# include <linux/smp_lock.h>
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()                                                     \
 do {                                                                   \
 	preempt_count() -= IRQ_EXIT_OFFSET;                     \
@@ -94,11 +60,5 @@
 		do_softirq();                                   \
 	preempt_enable_no_resched();                            \
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* _ASM_HARDIRQ_H */
===== include/asm-parisc/hardirq.h 1.3 vs edited =====
--- 1.3/include/asm-parisc/hardirq.h	2003-05-13 03:59:23 +02:00
+++ edited/include/asm-parisc/hardirq.h	2004-09-01 16:39:37 +02:00
@@ -51,20 +51,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have space for potentially all IRQ sources
  * in the system nesting on a single CPU:
@@ -73,29 +59,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context?
- * Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# error CONFIG_PREEMT currently not supported.
-# define in_atomic()	 BUG()
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()								\
 do {										\
 		preempt_count() -= IRQ_EXIT_OFFSET;				\
@@ -103,11 +67,5 @@
 			do_softirq();						\
 		preempt_enable_no_resched();					\
 } while (0)
-
-#ifdef CONFIG_SMP
-  extern void synchronize_irq (unsigned int irq);
-#else
-# define synchronize_irq(irq)	barrier()
-#endif /* CONFIG_SMP */
 
 #endif /* _PARISC_HARDIRQ_H */
===== include/asm-ppc/hardirq.h 1.24 vs edited =====
--- 1.24/include/asm-ppc/hardirq.h	2004-06-03 13:36:46 +02:00
+++ edited/include/asm-ppc/hardirq.h	2004-09-01 16:39:44 +02:00
@@ -44,20 +44,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -67,31 +53,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define preemptible()	0
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
@@ -99,12 +61,6 @@
 		do_softirq();						\
 	preempt_enable_no_resched();					\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* __ASM_HARDIRQ_H */
 #endif /* __KERNEL__ */
===== include/asm-ppc64/hardirq.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/hardirq.h	2004-06-10 08:21:41 +02:00
+++ edited/include/asm-ppc64/hardirq.h	2004-09-01 16:40:02 +02:00
@@ -1,4 +1,3 @@
-#ifdef __KERNEL__
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
@@ -43,20 +42,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __HARDIRQ_MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__HARDIRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define SOFTIRQ_MASK	(__HARDIRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-#define HARDIRQ_MASK	(__HARDIRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -66,29 +51,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define preemptible()	0
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -97,12 +60,4 @@
 		preempt_enable_no_resched();				\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
-
-#endif /* __KERNEL__ */
-	
 #endif /* __ASM_HARDIRQ_H */
===== include/asm-s390/hardirq.h 1.13 vs edited =====
--- 1.13/include/asm-s390/hardirq.h	2004-01-19 07:35:53 +01:00
+++ edited/include/asm-s390/hardirq.h	2004-09-01 16:40:31 +02:00
@@ -61,51 +61,15 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
+extern void do_call_softirq(void);
+extern void account_ticks(struct pt_regs *);
 
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
+#define invoke_softirq() do_call_softirq()
 
 #define irq_enter()							\
 do {									\
 	(preempt_count() += HARDIRQ_OFFSET);				\
 } while(0)
-	
-
-extern void do_call_softirq(void);
-extern void account_ticks(struct pt_regs *);
-
-#define invoke_softirq() do_call_softirq()
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
===== include/asm-s390/irq.h 1.11 vs edited =====
--- 1.11/include/asm-s390/irq.h	2004-04-12 19:54:45 +02:00
+++ edited/include/asm-s390/irq.h	2004-09-01 16:47:27 +02:00
@@ -2,7 +2,7 @@
 #define _ASM_IRQ_H
 
 #ifdef __KERNEL__
-#include <asm/hardirq.h>
+#include <linux/hardirq.h>
 
 /*
  * the definition of irqs has changed in 2.5.46:
===== include/asm-sh/hardirq.h 1.6 vs edited =====
--- 1.6/include/asm-sh/hardirq.h	2004-02-19 04:42:45 +01:00
+++ edited/include/asm-sh/hardirq.h	2004-09-01 16:40:45 +02:00
@@ -35,20 +35,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -58,29 +44,10 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we in an interrupt context? Either doing bottom half
- * or hardware interrupt processing?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -88,11 +55,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* __ASM_SH_HARDIRQ_H */
===== include/asm-sparc/hardirq.h 1.14 vs edited =====
--- 1.14/include/asm-sparc/hardirq.h	2004-06-01 04:07:59 +02:00
+++ edited/include/asm-sparc/hardirq.h	2004-09-01 16:40:54 +02:00
@@ -42,42 +42,7 @@
 #define SOFTIRQ_SHIFT   (PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT   (SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)       ((1UL << (x))-1)
-
-#define PREEMPT_MASK    (__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK    (__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK    (__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count() (preempt_count() & HARDIRQ_MASK)
-#define softirq_count() (preempt_count() & SOFTIRQ_MASK)
-#define irq_count()     (preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET  (1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET  (1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET  (1UL << HARDIRQ_SHIFT)
-
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()                (hardirq_count())
-#define in_softirq()            (softirq_count())
-#define in_interrupt()          (irq_count())
-
-
-#define hardirq_trylock()       (!in_interrupt())
-#define hardirq_endlock()       do { } while (0)
-
 #define irq_enter()             (preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-#include <linux/smp_lock.h>
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()                                                      \
 do {                                                                    \
                 preempt_count() -= IRQ_EXIT_OFFSET;                     \
@@ -85,11 +50,5 @@
                         do_softirq();                                   \
                 preempt_enable_no_resched();                            \
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else /* SMP */
-extern void synchronize_irq(unsigned int irq);
-#endif /* SMP */
 
 #endif /* __SPARC_HARDIRQ_H */
===== include/asm-sparc64/hardirq.h 1.18 vs edited =====
--- 1.18/include/asm-sparc64/hardirq.h	2004-05-31 22:05:58 +02:00
+++ edited/include/asm-sparc64/hardirq.h	2004-09-01 16:41:05 +02:00
@@ -41,42 +41,7 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# include <linux/smp_lock.h>
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()	(preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -84,11 +49,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* !(__SPARC64_HARDIRQ_H) */
===== include/asm-v850/hardirq.h 1.4 vs edited =====
--- 1.4/include/asm-v850/hardirq.h	2003-06-17 07:23:12 +02:00
+++ edited/include/asm-v850/hardirq.h	2004-09-01 16:41:11 +02:00
@@ -36,20 +36,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -59,27 +45,7 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
-#ifdef CONFIG_PREEMPT
-# define in_atomic()    (preempt_count() != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()    (preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
-
 #define irq_exit()							      \
 do {									      \
 	preempt_count() -= IRQ_EXIT_OFFSET;				      \
@@ -87,11 +53,5 @@
 		do_softirq();						      \
 	preempt_enable_no_resched();					      \
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-# error v850nommu SMP is not available
-#endif /* CONFIG_SMP */
 
 #endif /* __V850_HARDIRQ_H__ */
===== include/asm-x86_64/hardirq.h 1.6 vs edited =====
--- 1.6/include/asm-x86_64/hardirq.h	2004-03-19 19:03:21 +01:00
+++ edited/include/asm-x86_64/hardirq.h	2004-09-01 16:41:16 +02:00
@@ -37,20 +37,6 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
@@ -60,31 +46,10 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-/*
- * Are we doing bottom half or hardware interrupt processing?
- * Are we in a softirq context? Interrupt context?
- */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-
-#ifdef CONFIG_PREEMPT
-# include <linux/smp_lock.h>
-# define in_atomic()   ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
-# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
-#else
-# define in_atomic()   (preempt_count() != 0)
-# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
-#endif
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -92,11 +57,5 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
-
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
 
 #endif /* __ASM_HARDIRQ_H */
===== include/linux/interrupt.h 1.29 vs edited =====
--- 1.29/include/linux/interrupt.h	2004-06-24 10:55:53 +02:00
+++ edited/include/linux/interrupt.h	2004-09-01 16:45:39 +02:00
@@ -8,8 +8,8 @@
 #include <linux/bitops.h>
 #include <linux/preempt.h>
 #include <linux/cpumask.h>
+#include <linux/hardirq.h>
 #include <asm/atomic.h>
-#include <asm/hardirq.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 
===== include/net/ipv6.h 1.38 vs edited =====
--- 1.38/include/net/ipv6.h	2004-07-19 16:16:25 +02:00
+++ edited/include/net/ipv6.h	2004-09-01 16:48:10 +02:00
@@ -16,7 +16,7 @@
 #define _NET_IPV6_H
 
 #include <linux/ipv6.h>
-#include <asm/hardirq.h>
+#include <linux/hardirq.h>
 #include <net/ndisc.h>
 #include <net/flow.h>
 #include <net/snmp.h>
===== sound/oss/ali5455.c 1.11 vs edited =====
--- 1.11/sound/oss/ali5455.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/ali5455.c	2004-09-01 16:50:39 +02:00
@@ -65,7 +65,6 @@
 #include <linux/ac97_codec.h>
 #include <linux/interrupt.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 #ifndef PCI_DEVICE_ID_ALI_5455
 #define PCI_DEVICE_ID_ALI_5455	0x5455
===== sound/oss/au1000.c 1.9 vs edited =====
--- 1.9/sound/oss/au1000.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/au1000.c	2004-09-01 16:49:22 +02:00
@@ -67,9 +67,9 @@
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/au1000.h>
 #include <asm/au1000_dma.h>
 
===== sound/oss/cs46xx.c 1.43 vs edited =====
--- 1.43/sound/oss/cs46xx.c	2004-08-26 04:01:30 +02:00
+++ edited/sound/oss/cs46xx.c	2004-09-01 16:49:35 +02:00
@@ -94,7 +94,6 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 #include "cs46xxpm-24.h"
 #include "cs46xx_wrapper-24.h"
===== sound/oss/forte.c 1.8 vs edited =====
--- 1.8/sound/oss/forte.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/forte.c	2004-09-01 16:49:40 +02:00
@@ -45,7 +45,6 @@
 #include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/io.h>
 
 #define DRIVER_NAME	"forte"
===== sound/oss/i810_audio.c 1.69 vs edited =====
--- 1.69/sound/oss/i810_audio.c	2004-08-23 10:14:51 +02:00
+++ edited/sound/oss/i810_audio.c	2004-09-01 16:49:45 +02:00
@@ -101,7 +101,6 @@
 #include <linux/ac97_codec.h>
 #include <linux/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 #define DRIVER_VERSION "1.01"
 
===== sound/oss/ite8172.c 1.28 vs edited =====
--- 1.28/sound/oss/ite8172.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/ite8172.c	2004-09-01 16:49:59 +02:00
@@ -70,10 +70,10 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/it8172/it8172.h>
 
 /* --------------------------------------------------------------------- */
===== sound/oss/nec_vrc5477.c 1.22 vs edited =====
--- 1.22/sound/oss/nec_vrc5477.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/nec_vrc5477.c	2004-09-01 16:50:06 +02:00
@@ -82,7 +82,6 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 /* -------------------debug macros -------------------------------------- */
 /* #undef VRC5477_AC97_DEBUG */
===== sound/oss/rme96xx.c 1.22 vs edited =====
--- 1.22/sound/oss/rme96xx.c	2004-08-08 23:07:47 +02:00
+++ edited/sound/oss/rme96xx.c	2004-09-01 16:50:16 +02:00
@@ -54,7 +54,7 @@
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <asm/hardirq.h>
+#include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
===== sound/oss/swarm_cs4297a.c 1.8 vs edited =====
--- 1.8/sound/oss/swarm_cs4297a.c	2004-08-08 23:07:48 +02:00
+++ edited/sound/oss/swarm_cs4297a.c	2004-09-01 16:50:30 +02:00
@@ -70,6 +70,7 @@
 #include <linux/ac97_codec.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
@@ -77,7 +78,6 @@
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
===== sound/oss/trident.c 1.53 vs edited =====
--- 1.53/sound/oss/trident.c	2004-08-08 23:07:48 +02:00
+++ edited/sound/oss/trident.c	2004-09-01 16:50:35 +02:00
@@ -217,7 +217,6 @@
 #include <linux/gameport.h>
 #include <linux/kernel.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 
--- /dev/null	2004-08-20 00:05:11.000000000 +0200
+++ edited/include/linux/hardirq.h	2004-09-02 11:43:32.523962632 +0200
@@ -0,0 +1,51 @@
+#ifndef LINUX_HARDIRQ_H
+#define LINUX_HARDIRQ_H
+
+#include <linux/config.h>
+#ifdef CONFIG_PREEPT
+#include <linux/smp_lock.h>
+#endif
+#include <asm/hardirq.h>
+
+#define __IRQ_MASK(x)	((1UL << (x))-1)
+
+#define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+#define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+
+#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
+
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
+
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#define in_interrupt()		(irq_count())
+
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
+
+#ifdef CONFIG_PREEMPT
+# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
+# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
+#else
+# define in_atomic()	(preempt_count() != 0)
+# define preemptible()	0
+# define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+#endif
+
+#ifdef CONFIG_SMP
+extern void synchronize_irq(unsigned int irq);
+#else
+# define synchronize_irq(irq)	barrier()
+#endif
+
+#endif /* LINUX_HARDIRQ_H */
