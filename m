Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbVLBIKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbVLBIKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 03:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVLBIKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 03:10:36 -0500
Received: from serv01.siteground.net ([70.85.91.68]:63438 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751754AbVLBIKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 03:10:36 -0500
Date: Fri, 2 Dec 2005 00:10:28 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, shai@scalex86.org
Subject: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202081028.GA5312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset is to allocate node local memory for the x86_64 
processor PDA.

Andrew, can you pls include this in -mm for testing?

Thanks,
Kiran

---

Patch enables early initialization of cpu_to_node. apicid_to_node is built by 
reading the SRAT table, from acpi_numa_init, and x86_cpu_to_apicid is built 
by parsing the ACPI MADT table, from acpi_boot_init. Combine these two tables 
and setup cpu_to_node.  Thanks to Andi for suggesting this.

Early initialization helps the static per-cpu areas in getting pages from 
correct node, and sets up cpu_to_node early for node local PDA allocations.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.15-rc3/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.15-rc3.orig/arch/x86_64/kernel/setup.c	2005-11-30 11:32:53.000000000 -0800
+++ linux-2.6.15-rc3/arch/x86_64/kernel/setup.c	2005-11-30 16:49:19.000000000 -0800
@@ -528,6 +528,7 @@
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
+	unsigned i;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
@@ -669,6 +670,15 @@
 	acpi_boot_init();
 #endif
 
+#ifdef CONFIG_ACPI_NUMA
+ 	/*
+ 	 * Setup cpu_to_node using the SRAT lapcis & ACPI MADT table
+ 	 * info.
+ 	 */
+ 	for (i = 0; i < NR_CPUS; i++)
+ 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * get boot-time SMP configuration:
@@ -687,12 +697,9 @@
 
 	request_resource(&iomem_resource, &video_ram_resource);
 
-	{
-	unsigned i;
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
 		request_resource(&ioport_resource, &standard_io_resources[i]);
-	}
 
 	e820_setup_gap();
 
