Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317086AbSEXFVq>; Fri, 24 May 2002 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317088AbSEXFVp>; Fri, 24 May 2002 01:21:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27107 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317086AbSEXFVm>; Fri, 24 May 2002 01:21:42 -0400
Date: Fri, 24 May 2002 10:55:29 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: davej@suse.de, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.17 apic_timer_irqs cacheline bouncing
Message-ID: <20020524105529.A2518@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch extirpates cacheline bouncing due to 
apic_timer_irqs[NR_CPUS] array, by placing them in the irq_stat[] cacheline 
aligned array for i386, and cpu_pda[] array for x86_64. (irq_stat structure is
moved to cpu_pda in x86_64). apic_timer_irqs get updated at every local apic
timer interrput, causing the cacheline to bounce.  I could have used Rusty's
per-cpu area mechanism, but I wouldn't be able to make a patch for 2.4, and
irq_stat seemed like a good place for apic_timer_irqs.

This patch has been tested on a 4 way PIII xeon.  I hope I have got the
x86_64 stuff right.  The ia64 part is probably dead code lying around to
make irq.c platform independent in the future. Please consider for 2.5.18*

Kiran


diff -ruN -X dontdiff linux-2.5.17/arch/i386/kernel/apic.c apic_timer_irqs/arch/i386/kernel/apic.c
--- linux-2.5.17/arch/i386/kernel/apic.c	Tue May 21 10:37:39 2002
+++ apic_timer_irqs/arch/i386/kernel/apic.c	Thu May 23 15:59:25 2002
@@ -1063,7 +1063,6 @@
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
-unsigned int apic_timer_irqs [NR_CPUS];
 
 void smp_apic_timer_interrupt(struct pt_regs regs)
 {
@@ -1072,7 +1071,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	apic_timer_irqs[cpu]++;
+	irq_stat[cpu].apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -ruN -X dontdiff linux-2.5.17/arch/i386/kernel/irq.c apic_timer_irqs/arch/i386/kernel/irq.c
--- linux-2.5.17/arch/i386/kernel/irq.c	Tue May 21 10:37:31 2002
+++ apic_timer_irqs/arch/i386/kernel/irq.c	Thu May 23 13:00:12 2002
@@ -168,7 +168,8 @@
 #if CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ", apic_timer_irqs[cpu_logical_map(j)]);
+		seq_printf(p, "%10u ", 
+				irq_stat[cpu_logical_map(j)].apic_timer_irqs);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -ruN -X dontdiff linux-2.5.17/arch/i386/kernel/nmi.c apic_timer_irqs/arch/i386/kernel/nmi.c
--- linux-2.5.17/arch/i386/kernel/nmi.c	Tue May 21 10:37:40 2002
+++ apic_timer_irqs/arch/i386/kernel/nmi.c	Thu May 23 13:01:07 2002
@@ -344,7 +344,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = apic_timer_irqs[cpu];
+	sum = irq_stat[cpu].apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -ruN -X dontdiff linux-2.5.17/arch/ia64/kernel/irq.c apic_timer_irqs/arch/ia64/kernel/irq.c
--- linux-2.5.17/arch/ia64/kernel/irq.c	Tue May 21 10:37:36 2002
+++ apic_timer_irqs/arch/ia64/kernel/irq.c	Thu May 23 16:59:52 2002
@@ -189,7 +189,7 @@
 	seq_puts(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
 		seq_printf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
+			irq_stat[cpu_logical_map(j)].apic_timer_irqs);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -ruN -X dontdiff linux-2.5.17/arch/x86_64/kernel/apic.c apic_timer_irqs/arch/x86_64/kernel/apic.c
--- linux-2.5.17/arch/x86_64/kernel/apic.c	Tue May 21 10:37:32 2002
+++ apic_timer_irqs/arch/x86_64/kernel/apic.c	Fri May 24 09:57:53 2002
@@ -1044,7 +1044,6 @@
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
-unsigned int apic_timer_irqs [NR_CPUS];
 
 void smp_apic_timer_interrupt(struct pt_regs *regs)
 {
@@ -1053,7 +1052,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	apic_timer_irqs[cpu]++;
+	cpu_pda[cpu].apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -ruN -X dontdiff linux-2.5.17/arch/x86_64/kernel/irq.c apic_timer_irqs/arch/x86_64/kernel/irq.c
--- linux-2.5.17/arch/x86_64/kernel/irq.c	Tue May 21 10:37:38 2002
+++ apic_timer_irqs/arch/x86_64/kernel/irq.c	Fri May 24 09:58:14 2002
@@ -168,7 +168,7 @@
 #if CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ", apic_timer_irqs[cpu_logical_map(j)]);
+		seq_printf(p, "%10u ", cpu_pda[cpu_logical_map(j)].apic_timer_irqs);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -ruN -X dontdiff linux-2.5.17/arch/x86_64/kernel/nmi.c apic_timer_irqs/arch/x86_64/kernel/nmi.c
--- linux-2.5.17/arch/x86_64/kernel/nmi.c	Tue May 21 10:37:38 2002
+++ apic_timer_irqs/arch/x86_64/kernel/nmi.c	Fri May 24 09:59:11 2002
@@ -240,7 +240,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = apic_timer_irqs[cpu];
+	sum = cpu_pda[cpu].apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -ruN -X dontdiff linux-2.5.17/include/asm-i386/apic.h apic_timer_irqs/include/asm-i386/apic.h
--- linux-2.5.17/include/asm-i386/apic.h	Tue May 21 10:37:38 2002
+++ apic_timer_irqs/include/asm-i386/apic.h	Thu May 23 12:55:29 2002
@@ -86,7 +86,6 @@
 extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
 extern void apic_pm_unregister(struct pm_dev*);
 
-extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
 
 extern unsigned int nmi_watchdog;
diff -ruN -X dontdiff linux-2.5.17/include/asm-i386/hardirq.h apic_timer_irqs/include/asm-i386/hardirq.h
--- linux-2.5.17/include/asm-i386/hardirq.h	Tue May 21 10:37:41 2002
+++ apic_timer_irqs/include/asm-i386/hardirq.h	Thu May 23 17:01:22 2002
@@ -14,6 +14,7 @@
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned long idle_timestamp;
 	unsigned int __nmi_count;	/* arch dependent */
+	unsigned int apic_timer_irqs;	/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff -ruN -X dontdiff linux-2.5.17/include/asm-x86_64/apic.h apic_timer_irqs/include/asm-x86_64/apic.h
--- linux-2.5.17/include/asm-x86_64/apic.h	Tue May 21 10:37:36 2002
+++ apic_timer_irqs/include/asm-x86_64/apic.h	Thu May 23 17:08:07 2002
@@ -86,7 +86,6 @@
 extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
 extern void apic_pm_unregister(struct pm_dev*);
 
-extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
 
 extern unsigned int nmi_watchdog;
diff -ruN -X dontdiff linux-2.5.17/include/asm-x86_64/pda.h apic_timer_irqs/include/asm-x86_64/pda.h
--- linux-2.5.17/include/asm-x86_64/pda.h	Tue May 21 10:37:37 2002
+++ apic_timer_irqs/include/asm-x86_64/pda.h	Fri May 24 09:56:03 2002
@@ -23,6 +23,7 @@
 	unsigned int __local_irq_count;
 	unsigned int __local_bh_count;
 	unsigned int __nmi_count;	/* arch dependent */
+	unsigned int apic_timer_irqs;	/* arch dependent */
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned;
 
diff -ruN -X dontdiff linux-2.5.17/kernel/softirq.c apic_timer_irqs/kernel/softirq.c
--- linux-2.5.17/kernel/softirq.c	Tue May 21 10:37:34 2002
+++ apic_timer_irqs/kernel/softirq.c	Thu May 23 14:36:59 2002
@@ -40,7 +40,7 @@
    - Bottom halves: globally serialized, grr...
  */
 
-irq_cpustat_t irq_stat[NR_CPUS];
+irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 

