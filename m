Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLLNyc>; Thu, 12 Dec 2002 08:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLLNyc>; Thu, 12 Dec 2002 08:54:32 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:12506 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264631AbSLLNyb>;
	Thu, 12 Dec 2002 08:54:31 -0500
Date: Thu, 12 Dec 2002 15:02:19 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212121402.PAA12918@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.21-pre1] check_nmi_watchdog() excessive stack usage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch fixes a problem with excessive stack usage in
arch/i386/kernel/nmi.c:check_nmi_watchdog(). It's a backport
of a fix that has been in the 2.5 kernel for quite a while.
There are no behavioural changes.

The problem is that the code copies NR_CPUS irq_cpustat_t values
to the stack, even though only NR_CPUS ints actually are needed.
irq_cpustat_t values are 24 bytes large, but they are also
____cacheline_aligned, which makes them blow up to 128 bytes
on P4s. That's 128*32 == 4 kilobytes of stack on a P4 SMP kernel,
when 4*32 == 128 bytes suffices.

/Mikael

diff -ruN linux-2.4.21-pre1/arch/i386/kernel/nmi.c linux-2.4.21-pre1.check_nmi/arch/i386/kernel/nmi.c
--- linux-2.4.21-pre1/arch/i386/kernel/nmi.c	2002-08-07 00:52:18.000000000 +0200
+++ linux-2.4.21-pre1.check_nmi/arch/i386/kernel/nmi.c	2002-12-12 14:19:10.000000000 +0100
@@ -72,18 +72,21 @@
 
 int __init check_nmi_watchdog (void)
 {
-	irq_cpustat_t tmp[NR_CPUS];
+	unsigned int prev_nmi_count[NR_CPUS];
 	int j, cpu;
 
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
-	memcpy(tmp, irq_stat, sizeof(tmp));
+	for (j = 0; j < smp_num_cpus; j++) {
+		cpu = cpu_logical_map(j);
+		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+	}
 	sti();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (j = 0; j < smp_num_cpus; j++) {
 		cpu = cpu_logical_map(j);
-		if (nmi_count(cpu) - tmp[cpu].__nmi_count <= 5) {
+		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			return -1;
 		}
