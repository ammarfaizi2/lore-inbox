Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVDARla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVDARla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVDARj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:39:29 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:62085 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262841AbVDARhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:37:32 -0500
Date: Fri, 1 Apr 2005 12:37:27 -0500
From: Jason Davis <jason@righTThere.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jason Davis <jason.davis@unisys.com>
Subject: [PATCH] 2.6.12-rc1-mm4 x86_64 genapic update
Message-ID: <20050401173727.GA26638@righTThere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

x86_64 genapic mechanism should be aware of machines that use physical APIC mode regardless of how many clusters/processors are detected. ACPI 3.0 FADT makes this determination very simple by providing a feature flag "force_apic_physical_destination_mode" to state whether the machine unconditionally uses physical APIC mode. Unisys' next generation x86_64 ES7000 will need to utilize this FADT feature flag in order to boot the x86_64 kernel in the correct APIC mode. This patch has been tested on both x86_64 commodity and ES7000 boxes.

Signed-off-by: Jason Davis <jason.davis@unisys.com>

diff -Naurp linux-2.6.12-rc1-mm4/arch/i386/kernel/acpi/boot.c linux-2.6.12-rc1-mm4-genapic/arch/i386/kernel/acpi/boot.c
--- linux-2.6.12-rc1-mm4/arch/i386/kernel/acpi/boot.c	2005-03-02 02:38:25.000000000 -0500
+++ linux-2.6.12-rc1-mm4-genapic/arch/i386/kernel/acpi/boot.c	2005-03-31 18:15:09.606679144 -0500
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
diff -Naurp linux-2.6.12-rc1-mm4/arch/x86_64/kernel/genapic.c linux-2.6.12-rc1-mm4-genapic/arch/x86_64/kernel/genapic.c
--- linux-2.6.12-rc1-mm4/arch/x86_64/kernel/genapic.c	2005-03-02 02:38:37.000000000 -0500
+++ linux-2.6.12-rc1-mm4-genapic/arch/x86_64/kernel/genapic.c	2005-03-31 18:15:09.607678992 -0500
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
