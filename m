Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUHMFNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUHMFNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUHMFNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:13:49 -0400
Received: from ozlabs.org ([203.10.76.45]:17608 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268995AbUHMFNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:13:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.19797.872649.322449@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 15:10:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (3/4) Rework secondary SMT thread setup at boot
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our (ab)use of cpu_possible_map in setup_system to start secondary SMT
threads bothers me.  Mark such threads in cpu_possible_map during
early boot; let RTAS tell us which present cpus are still offline
later so we can start them.

I'm not totally sure about this one, it might be better to set up
cpu_sibling_map in prom_hold_cpus and use that in setup_system.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/prom.c~ppc64-fix-secondary-smt-thread-setup arch/ppc64/kernel/prom.c
--- 2.6-tip/arch/ppc64/kernel/prom.c~ppc64-fix-secondary-smt-thread-setup	2004-08-03 18:07:13.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/prom.c	2004-08-03 18:07:13.000000000 -0500
@@ -1076,6 +1076,8 @@ next:
 				cpu_set(cpuid, RELOC(cpu_available_map));
 				cpu_set(cpuid, RELOC(cpu_present_at_boot));
 				cpu_set(cpuid, RELOC(cpu_present_map));
+				cpu_set(cpuid, RELOC(cpu_possible_map));
+				_systemcfg->processorCount++;
 				prom_printf("available\n");
 			} else {
 				prom_printf("not available\n");
diff -puN arch/ppc64/kernel/setup.c~ppc64-fix-secondary-smt-thread-setup arch/ppc64/kernel/setup.c
--- 2.6-tip/arch/ppc64/kernel/setup.c~ppc64-fix-secondary-smt-thread-setup	2004-08-03 18:07:13.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/setup.c	2004-08-03 18:07:13.000000000 -0500
@@ -232,16 +232,17 @@ void setup_system(unsigned long r3, unsi
 		chrp_init(r3, r4, r5, r6, r7);
 
 #ifdef CONFIG_SMP
-		/* Start secondary threads on SMT systems */
-		for (i = 0; i < NR_CPUS; i++) {
-			if (cpu_available(i) && !cpu_possible(i)) {
+		/* Start secondary threads on SMT systems; primary threads
+		 * are already in the running state.
+		 */
+		for_each_present_cpu(i) {
+			if (query_cpu_stopped
+			    (get_hard_smp_processor_id(i)) == 0) {
 				printk("%16.16x : starting thread\n", i);
 				rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
 					  get_hard_smp_processor_id(i), 
 					  (u32)*((unsigned long *)pseries_secondary_smp_init),
 					  i);
-				cpu_set(i, cpu_possible_map);
-				systemcfg->processorCount++;
 			}
 		}
 #endif /* CONFIG_SMP */
diff -puN arch/ppc64/kernel/smp.c~ppc64-fix-secondary-smt-thread-setup arch/ppc64/kernel/smp.c
--- 2.6-tip/arch/ppc64/kernel/smp.c~ppc64-fix-secondary-smt-thread-setup	2004-08-03 18:07:13.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/smp.c	2004-08-03 18:07:13.000000000 -0500
@@ -225,7 +225,6 @@ static void __devinit smp_openpic_setup_
 	do_openpic_setup_cpu();
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 /* Get state of physical CPU.
  * Return codes:
  *	0	- The processor is in the RTAS stopped state
@@ -234,13 +233,14 @@ static void __devinit smp_openpic_setup_
  *	-1	- Hardware Error
  *	-2	- Hardware Busy, Try again later.
  */
-static int query_cpu_stopped(unsigned int pcpu)
+int query_cpu_stopped(unsigned int pcpu)
 {
 	int cpu_status;
 	int status, qcss_tok;
 
 	qcss_tok = rtas_token("query-cpu-stopped-state");
-	BUG_ON(qcss_tok == RTAS_UNKNOWN_SERVICE);
+	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
+		return -1;
 	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
 	if (status != 0) {
 		printk(KERN_ERR
@@ -251,6 +251,8 @@ static int query_cpu_stopped(unsigned in
 	return cpu_status;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
 int __cpu_disable(void)
 {
 	/* FIXME: go put this in a header somewhere */
diff -puN include/asm-ppc64/smp.h~ppc64-fix-secondary-smt-thread-setup include/asm-ppc64/smp.h
--- 2.6-tip/include/asm-ppc64/smp.h~ppc64-fix-secondary-smt-thread-setup	2004-08-03 18:07:13.000000000 -0500
+++ 2.6-tip-nathanl/include/asm-ppc64/smp.h	2004-08-03 18:07:13.000000000 -0500
@@ -73,6 +73,7 @@ void smp_init_pSeries(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void) __attribute__((noreturn));
+extern int query_cpu_stopped(unsigned int pcpu);
 #endif /* !(CONFIG_SMP) */
 
 #define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
