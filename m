Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSFPLmE>; Sun, 16 Jun 2002 07:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFPLmD>; Sun, 16 Jun 2002 07:42:03 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:59877 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316185AbSFPLmC>;
	Sun, 16 Jun 2002 07:42:02 -0400
Date: Sun, 16 Jun 2002 13:41:53 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206161141.NAA13660@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] shrink check_nmi_watchdog stack frame
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.5.21 reduces the stack frame size of
arch/i386/kernel/nmi.c:check_nmi_watchdog() from 4096 bytes
in the worst case to 128 bytes. Linus, please apply.

The problem with the current code is that it copies the entire
irq_stat[] array, when only a single field (__nmi_count) is of
interest. The irq_stat_t element type is only 28 bytes, but it
is also ____cacheline_aligned, and that blows the array up to
4096 bytes on SMP P4 Xeons, 2048 bytes on SMP K7s, and 1024 bytes
on SMP P5/P6s. The patch reduces this to NR_CPUS*4==128 bytes.

If you approve this patch I'll also send one to Marcelo for 2.4.

/Mikael

diff -ruN linux-2.5.21/arch/i386/kernel/nmi.c linux-2.5.21.check-nmi/arch/i386/kernel/nmi.c
--- linux-2.5.21/arch/i386/kernel/nmi.c	Mon Apr 15 00:32:51 2002
+++ linux-2.5.21.check-nmi/arch/i386/kernel/nmi.c	Sun Jun 16 12:16:55 2002
@@ -72,18 +72,19 @@
 
 int __init check_nmi_watchdog (void)
 {
-	irq_cpustat_t tmp[NR_CPUS];
+	unsigned int prev_nmi_count[NR_CPUS];
 	int j, cpu;
 
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
-	memcpy(tmp, irq_stat, sizeof(tmp));
+	for(j = 0; j < NR_CPUS; ++j)
+		prev_nmi_count[j] = irq_stat[j].__nmi_count;
 	sti();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (j = 0; j < smp_num_cpus; j++) {
 		cpu = cpu_logical_map(j);
-		if (nmi_count(cpu) - tmp[cpu].__nmi_count <= 5) {
+		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			return -1;
 		}
