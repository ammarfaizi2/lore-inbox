Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWBPHUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWBPHUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWBPHUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:20:38 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:31420 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932498AbWBPHUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:20:37 -0500
Date: Thu, 16 Feb 2006 08:20:25 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 4/4] s390: possible_cpus parameter
Message-ID: <20060216072025.GG9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce possible_cpus command line option. Hard sets the number of bits set
in cpu_possible_map. Unlike the additional_cpus parameter this one guarantees
that num_possible_cpus() will stay constant even if the system gets rebooted
and a different number of cpus are present at startup.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 Documentation/cpu-hotplug.txt |    6 ++++++
 arch/s390/kernel/smp.c        |   14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff -purN a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
--- a/Documentation/cpu-hotplug.txt	2006-02-16 07:56:45.000000000 +0100
+++ b/Documentation/cpu-hotplug.txt	2006-02-16 08:00:39.000000000 +0100
@@ -50,6 +50,12 @@ additional_cpus=n	[x86_64, s390 only] us
                         This option sets
 			cpu_possible_map = cpu_present_map + additional_cpus
 
+possible_cpus=n		[s390 only] use this to set hotpluggable cpus.
+			This option sets possible_cpus bits in
+			cpu_possible_map. Thus keeping the numbers of bits set
+			constant even if the machine gets rebooted.
+			This option overrides additional_cpus.
+
 CPU maps and such
 -----------------
 [More on cpumaps and primitive to manipulate, please check
diff -purN a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
--- a/arch/s390/kernel/smp.c	2006-02-16 07:56:45.000000000 +0100
+++ b/arch/s390/kernel/smp.c	2006-02-16 07:56:35.000000000 +0100
@@ -673,15 +673,16 @@ __cpu_up(unsigned int cpu)
 }
 
 static unsigned int __initdata additional_cpus;
+static unsigned int __initdata possible_cpus;
 
 void __init smp_setup_cpu_possible_map(void)
 {
 	unsigned int pcpus, cpu;
 
-	pcpus = smp_count_cpus() + additional_cpus;
+	pcpus = min(smp_count_cpus() + additional_cpus, (unsigned int) NR_CPUS);
 
-	if (pcpus > NR_CPUS)
-		pcpus = NR_CPUS;
+	if (possible_cpus)
+		pcpus = min(possible_cpus, (unsigned int) NR_CPUS);
 
 	for (cpu = 0; cpu < pcpus; cpu++)
 		cpu_set(cpu, cpu_possible_map);
@@ -698,6 +699,13 @@ static int __init setup_additional_cpus(
 }
 early_param("additional_cpus", setup_additional_cpus);
 
+static int __init setup_possible_cpus(char *s)
+{
+	possible_cpus = simple_strtoul(s, NULL, 0);
+	return 0;
+}
+early_param("possible_cpus", setup_possible_cpus);
+
 int
 __cpu_disable(void)
 {
