Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSEXGoH>; Fri, 24 May 2002 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSEXGoG>; Fri, 24 May 2002 02:44:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9906 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314227AbSEXGoF>;
	Fri, 24 May 2002 02:44:05 -0400
Date: Fri, 24 May 2002 12:17:56 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] 2.4.19-pre8 apic_timer_irqs cacheline bouncing
Message-ID: <20020524121756.A16139@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
The following patch extirpates cacheline bouncing due to 
apic_timer_irqs[NR_CPUS] array, by placing them in the irq_stat[] 
cacheline aligned array for i386; irq_stat seemed like a good 
place for apic_timer_irqs.

This patch has been tested on a 4 way PIII xeon. The ia64 part 
is probably dead code lying around to make irq.c platform 
independent in the future. Please consider for 2.4.19*

Kiran


diff -X dontdiff -ruN linux-2.4.19-pre8/arch/i386/kernel/apic.c 2419pre8-k/arch/i386/kernel/apic.c
--- linux-2.4.19-pre8/arch/i386/kernel/apic.c	Fri May 24 12:09:43 2002
+++ 2419pre8-k/arch/i386/kernel/apic.c	Fri May 24 12:03:08 2002
@@ -1055,7 +1055,6 @@
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
-unsigned int apic_timer_irqs [NR_CPUS];
 
 void smp_apic_timer_interrupt(struct pt_regs * regs)
 {
@@ -1064,7 +1063,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	apic_timer_irqs[cpu]++;
+	irq_stat[cpu].apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -X dontdiff -ruN linux-2.4.19-pre8/arch/i386/kernel/irq.c 2419pre8-k/arch/i386/kernel/irq.c
--- linux-2.4.19-pre8/arch/i386/kernel/irq.c	Fri Oct 26 02:23:46 2001
+++ 2419pre8-k/arch/i386/kernel/irq.c	Fri May 24 12:03:08 2002
@@ -170,7 +170,7 @@
 	p += sprintf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
 		p += sprintf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
+			irq_stat[cpu_logical_map(j)].apic_timer_irqs);
 	p += sprintf(p, "\n");
 #endif
 	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -X dontdiff -ruN linux-2.4.19-pre8/arch/i386/kernel/nmi.c 2419pre8-k/arch/i386/kernel/nmi.c
--- linux-2.4.19-pre8/arch/i386/kernel/nmi.c	Fri May 24 12:09:43 2002
+++ 2419pre8-k/arch/i386/kernel/nmi.c	Fri May 24 12:03:08 2002
@@ -343,7 +343,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = apic_timer_irqs[cpu];
+	sum = irq_stat[cpu].apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -X dontdiff -ruN linux-2.4.19-pre8/arch/ia64/kernel/irq.c 2419pre8-k/arch/ia64/kernel/irq.c
--- linux-2.4.19-pre8/arch/ia64/kernel/irq.c	Fri May 24 12:09:43 2002
+++ 2419pre8-k/arch/ia64/kernel/irq.c	Fri May 24 12:03:08 2002
@@ -172,7 +172,7 @@
 	p += sprintf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
 		p += sprintf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
+			irq_stat[cpu_logical_map(j)].apic_timer_irqs);
 	p += sprintf(p, "\n");
 #endif
 	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -X dontdiff -ruN linux-2.4.19-pre8/include/asm-i386/apic.h 2419pre8-k/include/asm-i386/apic.h
--- linux-2.4.19-pre8/include/asm-i386/apic.h	Fri May 24 12:09:48 2002
+++ 2419pre8-k/include/asm-i386/apic.h	Fri May 24 12:06:16 2002
@@ -85,7 +85,6 @@
 extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
 extern void apic_pm_unregister(struct pm_dev*);
 
-extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
 
 extern unsigned int nmi_watchdog;
diff -X dontdiff -ruN linux-2.4.19-pre8/include/asm-i386/hardirq.h 2419pre8-k/include/asm-i386/hardirq.h
--- linux-2.4.19-pre8/include/asm-i386/hardirq.h	Fri Nov 23 01:16:19 2001
+++ 2419pre8-k/include/asm-i386/hardirq.h	Fri May 24 12:06:16 2002
@@ -13,6 +13,9 @@
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned int __nmi_count;	/* arch dependent */
+#if CONFIG_X86_LOCAL_APIC 	
+	unsigned int apic_timer_irqs;	/* arch dependent */
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff -X dontdiff -ruN linux-2.4.19-pre8/kernel/softirq.c 2419pre8-k/kernel/softirq.c
--- linux-2.4.19-pre8/kernel/softirq.c	Wed Oct 31 23:56:02 2001
+++ 2419pre8-k/kernel/softirq.c	Fri May 24 12:03:08 2002
@@ -40,7 +40,7 @@
    - Bottom halves: globally serialized, grr...
  */
 
-irq_cpustat_t irq_stat[NR_CPUS];
+irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned;
 
