Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSGYQDm>; Thu, 25 Jul 2002 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSGYQDm>; Thu, 25 Jul 2002 12:03:42 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:53738 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315120AbSGYQDm>;
	Thu, 25 Jul 2002 12:03:42 -0400
Date: Thu, 25 Jul 2002 18:06:55 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207251606.SAA19671@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] shrink check_nmi_watchdog stack frame
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.5.28 reduces the stack frame size of
arch/i386/kernel/nmi.c:check_nmi_watchdog() from 4096 bytes
in the worst case to 128 bytes. Linus, please apply.

The problem with the current code is that it copies the entire
irq_stat[] array, when only a single field (__nmi_count) is of
interest. The irq_stat_t element type is only 28 bytes, but it
is also ____cacheline_aligned, and that blows the array up to
4096 bytes on SMP P4 Xeons, 2048 bytes on SMP K7s, and 1024 bytes
on SMP P5/P6s. The patch reduces this to NR_CPUS*4==128 bytes.

/Mikael

diff -ruN linux-2.5.28/arch/i386/kernel/nmi.c linux-2.5.28.check-nmi/arch/i386/kernel/nmi.c
--- linux-2.5.28/arch/i386/kernel/nmi.c	Thu Jul 25 01:27:29 2002
+++ linux-2.5.28.check-nmi/arch/i386/kernel/nmi.c	Thu Jul 25 01:31:55 2002
@@ -72,19 +72,20 @@
 
 int __init check_nmi_watchdog (void)
 {
-	irq_cpustat_t tmp[NR_CPUS];
+	unsigned int prev_nmi_count[NR_CPUS];
 	int cpu;
 
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
-	memcpy(tmp, irq_stat, sizeof(tmp));
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (nmi_count(cpu) - tmp[cpu].__nmi_count <= 5) {
+		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			return -1;
 		}
