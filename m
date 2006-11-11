Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWKKPP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWKKPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 10:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965942AbWKKPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 10:15:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3282 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966129AbWKKPP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 10:15:28 -0500
Date: Sat, 11 Nov 2006 16:14:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061111151414.GA32507@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

this patch fixes a couple of inconsistencies/problems i found while 
reviewing the x86_64 genapic code (when i was chasing mysterious eth0 
timeouts that would only trigger if CPU_HOTPLUG is enabled):

 - AMD systems defaulted to the slower flat-physical mode instead
   of the flat-logical mode. The only restriction on AMD systems
   is that they should not use clustered APIC mode.

 - removed the CPU hotplug hacks, switching the default for small
   systems back from phys-flat to logical-flat. The switching to logical 
   flat mode on small systems fixed sporadic ethernet driver timeouts i 
   was getting on a dual-core Athlon64 system:

    NETDEV WATCHDOG: eth0: transmit timed out
    eth0: Transmit timeout, status 0c 0005 c07f media 80.
    eth0: Tx queue start entry 32  dirty entry 28.
    eth0:  Tx descriptor 0 is 0008a04a. (queue head)
    eth0:  Tx descriptor 1 is 0008a04a.
    eth0:  Tx descriptor 2 is 0008a04a.
    eth0:  Tx descriptor 3 is 0008a04a.
    eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1

 - The use of '<= 8' was a bug by itself (the valid APIC ids
   for logical flat mode go from 0 to 7, not 0 to 8). The new logic
   is to use logical flat mode on both AMD and Intel systems, and
   to only switch to physical mode when logical mode cannot be used.
   If CPU hotplug is racy wrt. APIC shutdown then CPU hotplug needs
   fixing, not the whole IRQ system be made inconsistent and slowed
   down.

 - minor cleanups: simplified some code constructs

build & booted on a couple of AMD and Intel SMP systems.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/genapic.c |   54 ++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

Index: linux/arch/x86_64/kernel/genapic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic.c
+++ linux/arch/x86_64/kernel/genapic.c
@@ -32,30 +32,26 @@ extern struct genapic apic_cluster;
 extern struct genapic apic_flat;
 extern struct genapic apic_physflat;
 
-struct genapic *genapic = &apic_flat;
-
+struct genapic __read_mostly *genapic = &apic_flat;
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
  */
 void __init clustered_apic_check(void)
 {
-	long i;
-	u8 clusters, max_cluster;
-	u8 id;
-	u8 cluster_cnt[NUM_APIC_CLUSTERS];
-	int max_apic = 0;
+	u8 id, clusters, max_cluster, cluster_cnt[NUM_APIC_CLUSTERS];
+	int i, max_apic = 0;
 
-#if defined(CONFIG_ACPI)
+#ifdef CONFIG_ACPI
 	/*
 	 * Some x86_64 machines use physical APIC mode regardless of how many
 	 * procs/clusters are present (x86_64 ES7000 is an example).
 	 */
-	if (acpi_fadt.revision > FADT2_REVISION_ID)
-		if (acpi_fadt.force_apic_physical_destination_mode) {
-			genapic = &apic_cluster;
-			goto print;
-		}
+	if (acpi_fadt.revision > FADT2_REVISION_ID &&
+			acpi_fadt.force_apic_physical_destination_mode) {
+		genapic = &apic_cluster;
+		goto print;
+	}
 #endif
 
 	memset(cluster_cnt, 0, sizeof(cluster_cnt));
@@ -68,20 +64,17 @@ void __init clustered_apic_check(void)
 		cluster_cnt[APIC_CLUSTERID(id)]++;
 	}
 
-	/* Don't use clustered mode on AMD platforms. */
+	/*
+	 * Don't use clustered mode on AMD platforms, default
+	 * to flat logical mode.
+	 */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		genapic = &apic_physflat;
-#ifndef CONFIG_HOTPLUG_CPU
-		/* In the CPU hotplug case we cannot use broadcast mode
-		   because that opens a race when a CPU is removed.
-		   Stay at physflat mode in this case.
-		   It is bad to do this unconditionally though. Once
-		   we have ACPI platform support for CPU hotplug
-		   we should detect hotplug capablity from ACPI tables and
-		   only do this when really needed. -AK */
-		if (max_apic <= 8)
-			genapic = &apic_flat;
-#endif
+		/*
+		 * Switch to physical flat mode if more than 8 APICs
+		 * (In the case of 8 CPUs APIC ID goes from 0 to 7):
+		 */
+		if (max_apic >= 8)
+			genapic = &apic_physflat;
  		goto print;
  	}
 
@@ -103,14 +96,9 @@ void __init clustered_apic_check(void)
 	 * (We don't use lowest priority delivery + HW APIC IRQ steering, so
 	 * can ignore the clustered logical case and go straight to physical.)
 	 */
-	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster) {
-#ifdef CONFIG_HOTPLUG_CPU
-		/* Don't use APIC shortcuts in CPU hotplug to avoid races */
-		genapic = &apic_physflat;
-#else
+	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
 		genapic = &apic_flat;
-#endif
-	} else
+	else
 		genapic = &apic_cluster;
 
 print:
