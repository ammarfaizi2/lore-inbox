Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSKJMlb>; Sun, 10 Nov 2002 07:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKJMlb>; Sun, 10 Nov 2002 07:41:31 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:31246
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264785AbSKJMla>; Sun, 10 Nov 2002 07:41:30 -0500
Date: Sun, 10 Nov 2002 07:45:49 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] Include NMI in /proc/stat
Message-ID: <Pine.LNX.4.44.0211100743360.13638-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.46-bochs/include/linux/irq_cpustat.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/include/linux/irq_cpustat.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq_cpustat.h
--- linux-2.5.46-bochs/include/linux/irq_cpustat.h	5 Nov 2002 01:46:49 -0000	1.1.1.1
+++ linux-2.5.46-bochs/include/linux/irq_cpustat.h	10 Nov 2002 12:33:45 -0000
@@ -10,14 +10,13 @@
  */
 
 #include <linux/config.h>
+#include <asm/hardirq.h>
 
 /*
  * Simple wrappers reducing source bloat.  Define all irq_stat fields
  * here, even ones that are arch dependent.  That way we get common
  * definitions instead of differing sets for each arch.
  */
-
-extern irq_cpustat_t irq_stat[];			/* defined in asm/hardirq.h */
 
 #ifndef __ARCH_IRQ_STAT /* Some architectures can do this more efficiently */ 
 #ifdef CONFIG_SMP
Index: linux-2.5.46-bochs/fs/proc/proc_misc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/fs/proc/proc_misc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 proc_misc.c
--- linux-2.5.46-bochs/fs/proc/proc_misc.c	5 Nov 2002 01:48:47 -0000	1.1.1.1
+++ linux-2.5.46-bochs/fs/proc/proc_misc.c	10 Nov 2002 12:23:59 -0000
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/profile.h>
 #include <linux/blkdev.h>
+#include <linux/irq_cpustat.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -340,7 +341,7 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
+	unsigned int nmi_sum = 0, sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 	int major, disk;
 
 	for (i = 0 ; i < NR_CPUS; i++) {
@@ -355,9 +356,11 @@
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat_cpu(i).irqs[j];
+		nmi_sum += nmi_count(i);
 #endif
 	}
 
+	sum += nmi_sum;
 	len = sprintf(page, "cpu  %u %u %u %u %u\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
@@ -374,11 +377,13 @@
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle));
 	}
+	
 	len += sprintf(page + len, "intr %u", sum);
 
 #if !defined(CONFIG_ARCH_S390)
 	for (i = 0 ; i < NR_IRQS ; i++)
 		len += sprintf(page + len, " %u", kstat_irqs(i));
+	len += sprintf(page + len, " %u", nmi_sum);
 #endif
 
 	len += sprintf(page + len, "\ndisk_io: ");

-- 
function.linuxpower.ca

