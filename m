Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVDSKyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDSKyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 06:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVDSKyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 06:54:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:27033 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261389AbVDSKyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 06:54:52 -0400
Date: Tue, 19 Apr 2005 12:54:24 +0200 (MEST)
Message-Id: <200504191054.j3JAsO5g013833@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: x86_64 NMI watchdog breakage in 2.6.12-rc2-mm3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi & Andrew,

The "x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state.patch" in
2.6.12-rc2-mm3 appears to have broken the NMI watchdog. Specifically:

diff -puN arch/x86_64/kernel/nmi.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state arch/x86_64/kernel/nmi.c
--- 25/arch/x86_64/kernel/nmi.c~x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state	Thu Apr  7 15:15:01 2005
+++ 25-akpm/arch/x86_64/kernel/nmi.c	Thu Apr  7 15:15:01 2005
@@ -133,12 +133,6 @@ static int __init check_nmi_watchdog (vo
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-#ifdef CONFIG_SMP
-		/* Check cpu_callin_map here because that is set
-		   after the timer is started. */
-		if (!cpu_isset(cpu, cpu_callin_map))
-			continue;
-#endif
 		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck (%d)!\n", 
 			       cpu,

This is wrong because in general the number of actual CPUs is _less_
than the number of configured CPUs (== NR_CPUS). Hence the code will
now check the NMI counts of non-existent CPUs, complain that they are
stuck, and disable the NMI watchdog. Actually the disablement is broken
in this case, but that's a different issue.

The error is easily reproducible by booting an SMP kernel on a UP box.

/Mikael
