Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVFFT1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVFFT1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVFFT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:26:03 -0400
Received: from fmr19.intel.com ([134.134.136.18]:20409 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261641AbVFFTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:23:03 -0400
Message-Id: <20050606192113.433566000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
Date: Mon, 06 Jun 2005 12:14:38 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>, Ashok Raj <ashok.raj@intel.com>,
       Andi Kleen <ak@muc.de>
Subject: [patch 5/5] try2: x86_64: Provide ability to choose using shortcuts for IPI in flat mode.
Content-Disposition: inline; filename=choose_mask_or_broadcast.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides an option to switch broadcast or use mask version 
for sending IPI's. If CONFIG_HOTPLUG_CPU is defined, we choose not to 
use broadcast shortcuts by default, otherwise we choose broadcast mode
as default.

both cases, one can change this via startup cmd line option, to choose
no-broadcast mode.

	no_ipi_broadcast=1

This is provided on request from Andi Kleen, since he doesnt agree with 
replacing IPI shortcuts as a solution for CPU hotplug. Without removing
broadcast IPI's, it would mean lots of new code for __cpu_up() path, 
which would acheive the same results.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Acked-by: Andi Kleen <ak@muc.de>
Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
----------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |   84 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 80 insertions(+), 4 deletions(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
@@ -20,6 +20,46 @@
 #include <asm/smp.h>
 #include <asm/ipi.h>
 
+/*
+ * The following permit choosing broadcast IPI shortcut v.s sending IPI only
+ * to online cpus via the send_IPI_mask varient.
+ * The mask version is my preferred option, since it eliminates a lot of
+ * other extra code that would need to be written to cleanup intrs sent
+ * to a CPU while offline.
+ *
+ * Sending broadcast introduces lots of trouble in CPU hotplug situations.
+ * These IPI's are delivered to cpu's irrespective of their offline status
+ * and could pickup stale intr data when these CPUS are turned online.
+ *
+ * Not using broadcast is a cleaner approach IMO, but Andi Kleen disagrees with
+ * the idea of not using broadcast IPI's anymore. Hence the run time check
+ * is introduced, on his request so we can choose an alternate mechanism.
+ *
+ * Initial wacky performance tests that collect cycle counts show
+ * no increase in using mask v.s broadcast version. In fact they seem
+ * identical in terms of cycle counts.
+ *
+ * if we need to use broadcast, we need to do the following.
+ *
+ * cli;
+ * hold call_lock;
+ * clear any pending IPI, just ack and clear all pending intr
+ * set cpu_online_map;
+ * release call_lock;
+ * sti;
+ *
+ * The complicated dummy irq processing shown above is not required if
+ * we didnt sent IPI's to wrong CPU's in the first place.
+ *
+ * - Ashok Raj <ashok.raj@intel.com>
+ */
+#ifdef CONFIG_HOTPLUG_CPU
+#define DEFAULT_SEND_IPI	(1)
+#else
+#define DEFAULT_SEND_IPI	(0)
+#endif
+
+static int no_broadcast=DEFAULT_SEND_IPI;
 
 static cpumask_t flat_target_cpus(void)
 {
@@ -79,27 +119,44 @@ static void flat_send_IPI_mask(cpumask_t
 	local_irq_restore(flags);
 }
 
+static inline void __local_flat_send_IPI_allbutself(cpumask_t mask, int vector)
+{
+	if (no_broadcast)
+		flat_send_IPI_mask(mask, vector);
+	else
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector, APIC_DEST_LOGICAL);
+}
+
+static inline void __local_flat_send_IPI_all(cpumask_t mask, int vector)
+{
+	if (no_broadcast)
+		flat_send_IPI_mask(mask, vector);
+	else
+		__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
+}
+
 static void flat_send_IPI_allbutself(int vector)
 {
 	cpumask_t mask;
+	int this_cpu;
 	/*
 	 * if there are no other CPUs in the system then
 	 * we get an APIC send error if we try to broadcast.
 	 * thus we have to avoid sending IPIs in this case.
 	 */
-	get_cpu();
+	this_cpu = get_cpu();
 	mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	cpu_clear(this_cpu, mask);
 
 	if (cpus_weight(mask) >= 1)
-		flat_send_IPI_mask(mask, vector);
+		__local_flat_send_IPI_allbutself(mask, vector);
 
 	put_cpu();
 }
 
 static void flat_send_IPI_all(int vector)
 {
-	flat_send_IPI_mask(cpu_online_map, vector);
+	__local_flat_send_IPI_all(cpu_online_map, vector);
 }
 
 static int flat_apic_id_registered(void)
@@ -120,6 +177,16 @@ static unsigned int phys_pkg_id(int inde
 	return ((ebx >> 24) & 0xFF) >> index_msb;
 }
 
+static __init int no_ipi_broadcast(char *str)
+{
+	get_option(&str, &no_broadcast);
+	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
+											"IPI Broadcast");
+	return 1;
+}
+
+__setup("no_ipi_broadcast", no_ipi_broadcast);
+
 struct genapic apic_flat =  {
 	.name = "flat",
 	.int_delivery_mode = dest_LowestPrio,
@@ -134,3 +201,12 @@ struct genapic apic_flat =  {
 	.cpu_mask_to_apicid = flat_cpu_mask_to_apicid,
 	.phys_pkg_id = phys_pkg_id,
 };
+
+int print_ipi_mode(void)
+{
+	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
+											"Shortcut");
+	return 0;
+}
+
+late_initcall(print_ipi_mode);

--

