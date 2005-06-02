Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFBNBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFBNBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFBNBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:01:25 -0400
Received: from fmr19.intel.com ([134.134.136.18]:27828 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261400AbVFBNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:01:13 -0400
Message-Id: <20050602130112.044976000@araj-em64t>
References: <20050602125754.993470000@araj-em64t>
Date: Thu, 02 Jun 2005 05:57:59 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 4/5] x86_64: Dont use broadcast shortcut to make it cpu hotplug safe.
Content-Disposition: inline; filename=no_broadcast_ipi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andi doesn't like this simpler approach, and prefers to continue to use
 broadcast mode, with a more complex __cpu_up() to overcome the ill effects
 of broadcast. Hence based on his request the next patch (following this) 
 is provided to provide a run-time switch capability]

Broadcast IPI's provide un-expected behaviour for cpu hotplug. CPU's in offline
state also end up receiving the IPI. Once the cpus become online
they receive these stale IPI's which are bad and introduce unexpected
behaviour. 

This is easily avoided by not sending a broadcast and addressing just the 
CPU's in online map.  Doing prelim cycle counts it appears there is no big 
overhead and numbers seem around 0x3000-0x3900 on an average on x86 and x86_64 
systems with CPUS running 3G, both for broadcast and mask version of the API's. 

The shortcuts are useful only for flat mode (where the perf shows no 
degradation), and in cluster mode, its unicast anyway. Its simpler 
to just not use broadcast anymore.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------
 arch/x86_64/kernel/genapic_flat.c |   41 +++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 16 deletions(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
@@ -7,6 +7,8 @@
  * Hacked for x86-64 by James Cleverdon from i386 architecture code by
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
+ * Ashok Raj <ashok.raj@intel.com>
+ * 	Removed IPI broadcast shortcut to support CPU hotplug
  */
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -45,22 +47,6 @@ static void flat_init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
-static void flat_send_IPI_allbutself(int vector)
-{
-	/*
-	 * if there are no other CPUs in the system then
-	 * we get an APIC send error if we try to broadcast.
-	 * thus we have to avoid sending IPIs in this case.
-	 */
-	if (num_online_cpus() > 1)
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector, APIC_DEST_LOGICAL);
-}
-
-static void flat_send_IPI_all(int vector)
-{
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
-}
-
 static void flat_send_IPI_mask(cpumask_t cpumask, int vector)
 {
 	unsigned long mask = cpus_addr(cpumask)[0];
@@ -93,6 +79,29 @@ static void flat_send_IPI_mask(cpumask_t
 	local_irq_restore(flags);
 }
 
+static void flat_send_IPI_allbutself(int vector)
+{
+	cpumask_t mask;
+	/*
+	 * if there are no other CPUs in the system then
+	 * we get an APIC send error if we try to broadcast.
+	 * thus we have to avoid sending IPIs in this case.
+	 */
+	get_cpu();
+	mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
+
+	if (cpus_weight(mask) >= 1)
+		flat_send_IPI_mask(mask, vector);
+
+	put_cpu();
+}
+
+static void flat_send_IPI_all(int vector)
+{
+	flat_send_IPI_mask(cpu_online_map, vector);
+}
+
 static int flat_apic_id_registered(void)
 {
 	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);

--

