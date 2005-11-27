Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVK0KAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVK0KAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVK0KAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 05:00:18 -0500
Received: from fsmlabs.com ([168.103.115.128]:15516 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750969AbVK0KAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 05:00:17 -0500
X-ASG-Debug-ID: 1133085614-4704-18-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 27 Nov 2005 02:05:58 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Raj, Ashok" <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
X-ASG-Orig-Subj: [PATCH] i386/x86_64: Remove preempt disable calls in lowlevel IPI
 calls
Subject: [PATCH] i386/x86_64: Remove preempt disable calls in lowlevel IPI
 calls
Message-ID: <Pine.LNX.4.61.0511270015260.20046@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5613
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some lowlevel send_IPI_mask helpers had a hotplug/preempt 
race whereupon the cpu_online_map was read before disabling preemption;

...
cpumask_t mask = cpu_online_map;
int cpu = get_cpu();
cpu_clear(cpu, mask);
...

But then i realised that there is no need for these lowlevel functions to 
be going through all this trouble when all the callers are already made 
hotplug/preempt safe.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

 arch/x86_64/kernel/genapic_cluster.c     |    5 +----
 arch/x86_64/kernel/genapic_flat.c        |   10 ++++------
 include/asm-i386/mach-default/mach_ipi.h |    4 +---
 3 files changed, 6 insertions(+), 13 deletions(-)

diff -r 2c0d5afbfb94 arch/x86_64/kernel/genapic_cluster.c
--- a/arch/x86_64/kernel/genapic_cluster.c	Fri Nov 25 17:42:19 2005
+++ b/arch/x86_64/kernel/genapic_cluster.c	Sun Nov 27 00:10:53 2005
@@ -72,14 +72,11 @@
 static void cluster_send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	int me = get_cpu(); /* Ensure we are not preempted when we clear */
 
-	cpu_clear(me, mask);
+	cpu_clear(smp_processor_id(), mask);
 
 	if (!cpus_empty(mask))
 		cluster_send_IPI_mask(mask, vector);
-
-	put_cpu();
 }
 
 static void cluster_send_IPI_all(int vector)
diff -r 2c0d5afbfb94 arch/x86_64/kernel/genapic_flat.c
--- a/arch/x86_64/kernel/genapic_flat.c	Fri Nov 25 17:42:19 2005
+++ b/arch/x86_64/kernel/genapic_flat.c	Sun Nov 27 00:10:53 2005
@@ -83,12 +83,11 @@
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
 #else
 	cpumask_t allbutme = cpu_online_map;
-	int me = get_cpu(); /* Ensure we are not preempted when we clear */
-	cpu_clear(me, allbutme);
+
+	cpu_clear(smp_processor_id(), allbutme);
 
 	if (!cpus_empty(allbutme))
 		flat_send_IPI_mask(allbutme, vector);
-	put_cpu();
 #endif
 }
 
@@ -149,10 +148,9 @@
 static void physflat_send_IPI_allbutself(int vector)
 {
 	cpumask_t allbutme = cpu_online_map;
-	int me = get_cpu();
-	cpu_clear(me, allbutme);
+
+	cpu_clear(smp_processor_id(), allbutme);
 	physflat_send_IPI_mask(allbutme, vector);
-	put_cpu();
 }
 
 static void physflat_send_IPI_all(int vector)
diff -r 2c0d5afbfb94 include/asm-i386/mach-default/mach_ipi.h
--- a/include/asm-i386/mach-default/mach_ipi.h	Fri Nov 25 17:42:19 2005
+++ b/include/asm-i386/mach-default/mach_ipi.h	Sun Nov 27 00:10:53 2005
@@ -15,11 +15,9 @@
 {
 	if (no_broadcast) {
 		cpumask_t mask = cpu_online_map;
-		int this_cpu = get_cpu();
 
-		cpu_clear(this_cpu, mask);
+		cpu_clear(smp_processor_id(), mask);
 		send_IPI_mask(mask, vector);
-		put_cpu();
 	} else
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 }
