Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWBPQkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBPQkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWBPQkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:40:21 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59187 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932324AbWBPQkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:40:19 -0500
Date: Thu, 16 Feb 2006 17:40:17 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/3] s390: smp initialization speed
Message-ID: <20060216164017.GH9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The last changes that introduced the additional_cpus command line parameter
also introduced a regression regarding smp initialization speed. In
smp_setup_cpu_possible_map() cpu_present_map is set to the same value
as cpu_possible_map. Especially that means that bits in the present map
will be set for cpus that are not present. This will cause a slow down
in the initial cpu_up() loop in smp_init() since trying to take cpus online
that aren't present takes a while.
Fix this by setting only bits for present cpus in cpu_present_map and
set cpu_present_map to cpu_possible_map in smp_cpus_done().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/smp.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-02-16 17:10:59.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-02-16 17:10:59.000000000 +0100
@@ -677,17 +677,21 @@ static unsigned int __initdata possible_
 
 void __init smp_setup_cpu_possible_map(void)
 {
-	unsigned int pcpus, cpu;
+	unsigned int phy_cpus, pos_cpus, cpu;
 
-	pcpus = min(smp_count_cpus() + additional_cpus, (unsigned int) NR_CPUS);
+	phy_cpus = smp_count_cpus();
+	pos_cpus = min(phy_cpus + additional_cpus, (unsigned int) NR_CPUS);
 
 	if (possible_cpus)
-		pcpus = min(possible_cpus, (unsigned int) NR_CPUS);
+		pos_cpus = min(possible_cpus, (unsigned int) NR_CPUS);
 
-	for (cpu = 0; cpu < pcpus; cpu++)
+	for (cpu = 0; cpu < pos_cpus; cpu++)
 		cpu_set(cpu, cpu_possible_map);
 
-	cpu_present_map = cpu_possible_map;
+	phy_cpus = min(phy_cpus, pos_cpus);
+
+	for (cpu = 0; cpu < phy_cpus; cpu++)
+		cpu_set(cpu, cpu_present_map);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -843,6 +847,7 @@ void __devinit smp_prepare_boot_cpu(void
 
 void smp_cpus_done(unsigned int max_cpus)
 {
+	cpu_present_map = cpu_possible_map;
 }
 
 /*
