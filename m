Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTGQQZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271322AbTGQQZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:25:16 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:47781 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S271313AbTGQQYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:24:07 -0400
Date: Thu, 17 Jul 2003 18:37:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/6): irq stats.
Message-ID: <20030717163755.GC2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable irq statistics for s390*. We defined NR_IRQS to 2, one for all i/o
interrupts and one for all external interrupts.

diffstat:
 arch/s390/kernel/entry.S    |    3 +++
 arch/s390/kernel/entry64.S  |    1 +
 arch/s390/kernel/s390_ext.c |    8 ++++++++
 arch/s390/kernel/setup.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/cio.c      |    3 +++
 fs/proc/proc_misc.c         |    8 +-------
 include/asm-s390/irq.h      |    7 ++-----
 include/linux/kernel_stat.h |    4 ----
 8 files changed, 58 insertions(+), 16 deletions(-)

diff -urN linux-2.6.0-test1/arch/s390/kernel/entry.S linux-2.6.0-s390/arch/s390/kernel/entry.S
--- linux-2.6.0-test1/arch/s390/kernel/entry.S	Mon Jul 14 05:31:21 2003
+++ linux-2.6.0-s390/arch/s390/kernel/entry.S	Thu Jul 17 17:27:30 2003
@@ -606,6 +606,8 @@
 	SAVE_ALL_BASE
         SAVE_ALL __LC_EXT_OLD_PSW,0
         GET_THREAD_INFO                # load pointer to task_struct to R9
+	l	%r1,BASED(.Ldo_extint)
+	basr	%r14,%r1
 	lh	%r6,__LC_EXT_INT_CODE  # get interruption code
 	lr	%r1,%r6		       # calculate index = code & 0xff
 	n	%r1,BASED(.Lc0xff)
@@ -694,6 +696,7 @@
  */
 .Ls390_mcck:   .long  s390_do_machine_check
 .Ldo_IRQ:      .long  do_IRQ
+.Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
 .Ldo_softirq:  .long  do_softirq
 .Lentry_base:  .long  entry_base
diff -urN linux-2.6.0-test1/arch/s390/kernel/entry64.S linux-2.6.0-s390/arch/s390/kernel/entry64.S
--- linux-2.6.0-test1/arch/s390/kernel/entry64.S	Mon Jul 14 05:31:21 2003
+++ linux-2.6.0-s390/arch/s390/kernel/entry64.S	Thu Jul 17 17:27:30 2003
@@ -637,6 +637,7 @@
 ext_int_handler:
         SAVE_ALL __LC_EXT_OLD_PSW,0
         GET_THREAD_INFO                # load pointer to task_struct to R9
+	brasl   %r14,do_extint
 	llgh	%r6,__LC_EXT_INT_CODE  # get interruption code
 	lgr	%r1,%r6		       # calculate index = code & 0xff
 	nill	%r1,0xff
diff -urN linux-2.6.0-test1/arch/s390/kernel/s390_ext.c linux-2.6.0-s390/arch/s390/kernel/s390_ext.c
--- linux-2.6.0-test1/arch/s390/kernel/s390_ext.c	Mon Jul 14 05:34:01 2003
+++ linux-2.6.0-s390/arch/s390/kernel/s390_ext.c	Thu Jul 17 17:27:30 2003
@@ -11,8 +11,11 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/kernel_stat.h>
+
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
+#include <asm/irq.h>
 
 /*
  * Simple hash strategy: index = code & 0xff;
@@ -98,6 +101,11 @@
 	return 0;
 }
 
+void do_extint(void)
+{
+	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
+}
+
 EXPORT_SYMBOL(register_external_interrupt);
 EXPORT_SYMBOL(unregister_external_interrupt);
 
diff -urN linux-2.6.0-test1/arch/s390/kernel/setup.c linux-2.6.0-s390/arch/s390/kernel/setup.c
--- linux-2.6.0-test1/arch/s390/kernel/setup.c	Mon Jul 14 05:30:37 2003
+++ linux-2.6.0-s390/arch/s390/kernel/setup.c	Thu Jul 17 17:27:30 2003
@@ -34,12 +34,15 @@
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
+#include <linux/kernel_stat.h>
+
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/cpcmd.h>
 #include <asm/lowcore.h>
+#include <asm/irq.h>
 
 /*
  * Machine setup..
@@ -600,3 +603,40 @@
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+
+/*
+ * show_interrupts is needed by /proc/interrupts.
+ */
+
+static const char *intrclass_names[] = {
+	"EXT",
+	"I/O",
+};
+
+int show_interrupts(struct seq_file *p, void *v)
+{
+        int i, j;
+	
+        seq_puts(p, "           ");
+	
+        for (j=0; j<NR_CPUS; j++)
+                if (cpu_online(j))
+                        seq_printf(p, "CPU%d       ",j);
+	
+        seq_putc(p, '\n');
+	
+        for (i = 0 ; i < NR_IRQS ; i++) {
+		seq_printf(p, "%s: ", intrclass_names[i]);
+#ifndef CONFIG_SMP
+		seq_printf(p, "%10u ", kstat_irqs(i));
+#else
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+#endif
+                seq_putc(p, '\n');
+		
+        }
+	
+        return 0;
+}
diff -urN linux-2.6.0-test1/drivers/s390/cio/cio.c linux-2.6.0-s390/drivers/s390/cio/cio.c
--- linux-2.6.0-test1/drivers/s390/cio/cio.c	Mon Jul 14 05:38:51 2003
+++ linux-2.6.0-s390/drivers/s390/cio/cio.c	Thu Jul 17 17:27:30 2003
@@ -16,10 +16,12 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/hardirq.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
+#include <asm/irq.h>
 
 #include "airq.h"
 #include "cio.h"
@@ -608,6 +610,7 @@
 	tpi_info = (struct tpi_info *) __LC_SUBCHANNEL_ID;
 	irb = (struct irb *) __LC_IRB;
 	do {
+		kstat_cpu(smp_processor_id()).irqs[IO_INTERRUPT]++;
 		/*
 		 * Non I/O-subchannel thin interrupts are processed differently
 		 */
diff -urN linux-2.6.0-test1/fs/proc/proc_misc.c linux-2.6.0-s390/fs/proc/proc_misc.c
--- linux-2.6.0-test1/fs/proc/proc_misc.c	Thu Jul 17 17:27:27 2003
+++ linux-2.6.0-s390/fs/proc/proc_misc.c	Thu Jul 17 17:27:30 2003
@@ -388,10 +388,8 @@
 		system += kstat_cpu(i).cpustat.system;
 		idle += kstat_cpu(i).cpustat.idle;
 		iowait += kstat_cpu(i).cpustat.iowait;
-#if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat_cpu(i).irqs[j];
-#endif
 	}
 
 	len = sprintf(page, "cpu  %u %u %u %u %u\n",
@@ -412,7 +410,7 @@
 	}
 	len += sprintf(page + len, "intr %u", sum);
 
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
 	for (i = 0 ; i < NR_IRQS ; i++)
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
@@ -440,7 +438,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-#if !defined(CONFIG_ARCH_S390)
 extern int show_interrupts(struct seq_file *p, void *v);
 static int interrupts_open(struct inode *inode, struct file *file)
 {
@@ -466,7 +463,6 @@
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -646,9 +642,7 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
-#if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
-#endif
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
diff -urN linux-2.6.0-test1/include/asm-s390/irq.h linux-2.6.0-s390/include/asm-s390/irq.h
--- linux-2.6.0-test1/include/asm-s390/irq.h	Mon Jul 14 05:37:26 2003
+++ linux-2.6.0-s390/include/asm-s390/irq.h	Thu Jul 17 17:27:30 2003
@@ -8,16 +8,13 @@
  * the definition of irqs has changed in 2.5.46:
  * NR_IRQS is no longer the number of i/o
  * interrupts (65536), but rather the number
- * of interrupt classes (6).
+ * of interrupt classes (2).
+ * Only external and i/o interrupts make much sense here (CH).
  */
 
 enum interruption_class {
 	EXTERNAL_INTERRUPT,
 	IO_INTERRUPT,
-	MACHINE_CHECK_INTERRUPT,
-	PROGRAM_INTERRUPT,
-	RESTART_INTERRUPT,
-	SUPERVISOR_CALL,
 
 	NR_IRQS,
 };
diff -urN linux-2.6.0-test1/include/linux/kernel_stat.h linux-2.6.0-s390/include/linux/kernel_stat.h
--- linux-2.6.0-test1/include/linux/kernel_stat.h	Mon Jul 14 05:38:41 2003
+++ linux-2.6.0-s390/include/linux/kernel_stat.h	Thu Jul 17 17:27:30 2003
@@ -23,9 +23,7 @@
 
 struct kernel_stat {
 	struct cpu_usage_stat	cpustat;
-#if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_IRQS];
-#endif
 };
 
 DECLARE_PER_CPU(struct kernel_stat, kstat);
@@ -36,7 +34,6 @@
 
 extern unsigned long nr_context_switches(void);
 
-#if !defined(CONFIG_ARCH_S390)
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
@@ -50,6 +47,5 @@
 
 	return sum;
 }
-#endif
 
 #endif /* _LINUX_KERNEL_STAT_H */
