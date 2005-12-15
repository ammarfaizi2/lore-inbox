Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVLOCdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVLOCdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVLOCdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:33:55 -0500
Received: from serv01.siteground.net ([70.85.91.68]:32129 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030297AbVLOCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:33:55 -0500
Date: Wed, 14 Dec 2005 18:33:45 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 1/3] x86_64: Node local pda take 2 -- early cpu_to_node
Message-ID: <20051215023345.GB3787@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is take 2 on x86_64 node local pda allocation.

This patchset does away with the extra memory reference for non CONFIG_NUMA
case.  The early cpu_to_node helps AMD and EM64T systems which work well
with CONFIG_ACPI_NUMA.  cpu_to_node is not inited early for AMD systems
which work only with old style K8_NUMA. (Tested on EM64 NUMA and Tyan K8
dual core 4 cpu boxes)

Andi, I could not eliminate the need for a initial static pda array, since
sched_init needs the static per-cpu offset array for NR_CPUS early.  Hope
this is OK.

Thanks,
Kiran

---

Patch enables early intialization of cpu_to_node. apicid_to_node is built by reading
the SRAT table, from acpi_numa_init, and x86_cpu_to_apicid is built by parsing the ACPI
MADT table, from acpi_boot_init. We combine these two tables and setup cpu_to_node.

Early intialization helps the static per_cpu_areas in getting pages from correct node.

Tested on EM64T NUMA and Tyan K8 dual core board (with CONFIG_ACPI_NUMA + K8)

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.15-rc4/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/x86_64/kernel/setup.c	2005-12-02 16:25:19.000000000 -0800
+++ linux-2.6.15-rc4/arch/x86_64/kernel/setup.c	2005-12-12 01:49:00.000000000 -0800
@@ -669,6 +669,8 @@
 	acpi_boot_init();
 #endif
 
+	init_cpu_to_node();
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * get boot-time SMP configuration:
Index: linux-2.6.15-rc4/arch/x86_64/mm/srat.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/x86_64/mm/srat.c	2005-12-01 17:09:51.000000000 -0800
+++ linux-2.6.15-rc4/arch/x86_64/mm/srat.c	2005-12-12 01:19:00.000000000 -0800
@@ -226,4 +226,15 @@
 	return acpi_slit->entry[index + node_to_pxm(b)];
 }
 
+/*
+ * Setup cpu_to_node using the SRAT lapcis & ACPI MADT table
+ * info.
+ */
+void __init init_cpu_to_node(void)
+{
+	int i;	
+ 	for (i = 0; i < NR_CPUS; i++)
+ 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
+}
+
 EXPORT_SYMBOL(__node_distance);
Index: linux-2.6.15-rc4/include/linux/acpi.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/acpi.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc4/include/linux/acpi.h	2005-12-12 01:52:28.000000000 -0800
@@ -519,11 +519,16 @@
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
+void __init init_cpu_to_node();
 #else
 static inline int acpi_get_pxm(acpi_handle handle)
 {
 	return 0;
 }
+
+static inline void init_cpu_to_node(void)
+{
+}
 #endif
 
 extern int pnpacpi_disabled;
