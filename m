Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVDMCZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVDMCZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDLTsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:48:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:62664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262173AbVDLKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:02 -0400
Message-Id: <200504121031.j3CAVln9005407@shell0.pdx.osdl.net>
Subject: [patch 070/198] x86_64 genapic update
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason@rightthere.net,
       ak@suse.de, jason.davis@unisys.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Davis <jason@rightthere.net>

x86_64 genapic mechanism should be aware of machines that use physical APIC
mode regardless of how many clusters/processors are detected.

ACPI 3.0 FADT makes this determination very simple by providing a feature
flag "force_apic_physical_destination_mode" to state whether the machine
unconditionally uses physical APIC mode.

Unisys' next generation x86_64 ES7000 will need to utilize this FADT
feature flag in order to boot the x86_64 kernel in the correct APIC mode. 
This patch has been tested on both x86_64 commodity and ES7000 boxes.

Signed-off-by: Jason Davis <jason.davis@unisys.com>
Acked-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/acpi/boot.c |    4 ++++
 25-akpm/arch/x86_64/kernel/genapic.c |   16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff -puN arch/i386/kernel/acpi/boot.c~x86_64-genapic-update arch/i386/kernel/acpi/boot.c
--- 25/arch/i386/kernel/acpi/boot.c~x86_64-genapic-update	2005-04-12 03:21:20.212064200 -0700
+++ 25-akpm/arch/i386/kernel/acpi/boot.c	2005-04-12 03:21:20.217063440 -0700
@@ -608,6 +608,10 @@ static int __init acpi_parse_fadt(unsign
 	acpi_fadt.sci_int = fadt->sci_int;
 #endif
 
+	/* initialize rev and apic_phys_dest_mode for x86_64 genapic */
+	acpi_fadt.revision = fadt->revision;
+	acpi_fadt.force_apic_physical_destination_mode = fadt->force_apic_physical_destination_mode;
+
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
 	if (fadt->revision >= FADT2_REVISION_ID) {
diff -puN arch/x86_64/kernel/genapic.c~x86_64-genapic-update arch/x86_64/kernel/genapic.c
--- 25/arch/x86_64/kernel/genapic.c~x86_64-genapic-update	2005-04-12 03:21:20.214063896 -0700
+++ 25-akpm/arch/x86_64/kernel/genapic.c	2005-04-12 03:21:20.218063288 -0700
@@ -20,6 +20,10 @@
 #include <asm/smp.h>
 #include <asm/ipi.h>
 
+#if defined(CONFIG_ACPI_BUS)
+#include <acpi/acpi_bus.h>
+#endif
+
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 u8 x86_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
@@ -47,6 +51,18 @@ void __init clustered_apic_check(void)
 		goto print;
 	}
 
+#if defined(CONFIG_ACPI_BUS)
+	/*
+	 * Some x86_64 machines use physical APIC mode regardless of how many
+	 * procs/clusters are present (x86_64 ES7000 is an example).
+	 */
+	if (acpi_fadt.revision > FADT2_REVISION_ID)
+		if (acpi_fadt.force_apic_physical_destination_mode) {
+			genapic = &apic_cluster;
+			goto print;
+		}
+#endif
+
 	memset(cluster_cnt, 0, sizeof(cluster_cnt));
 
 	for (i = 0; i < NR_CPUS; i++) {
_
