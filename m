Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVLPILp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVLPILp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLPILp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:11:45 -0500
Received: from serv01.siteground.net ([70.85.91.68]:51619 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932176AbVLPILo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:11:44 -0500
Date: Fri, 16 Dec 2005 00:11:23 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] [patch 1/3] x86_64: Node local pda take 2 -- early cpu_to_node
Message-ID: <20051216081123.GB3736@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain> <20051215094437.GY23384@wotan.suse.de> <20051215190142.GB3882@localhost.localdomain> <20051216002001.GO23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216002001.GO23384@wotan.suse.de>
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

On Fri, Dec 16, 2005 at 01:20:01AM +0100, Andi Kleen wrote:
> On Thu, Dec 15, 2005 at 11:01:42AM -0800, Ravikiran G Thirumalai wrote:
> > On Thu, Dec 15, 2005 at 10:44:37AM +0100, Andi Kleen wrote:
> > > On Wed, Dec 14, 2005 at 06:33:45PM -0800, Ravikiran G Thirumalai wrote:
> > 
> > Sure!  I moved it to srat.c based on your suggestion to my earlier post.  
> > I will move this to numa.c.
> 
> Sorry for changing my mind on this. I hope you can bear with me.

No problem.  I hadn't done this earlier 'cause I didn't have a K8 box to
test.  Here is the modified patch.

Thanks,
Kiran

---
Patch enables early intialization of cpu_to_node.
apicid_to_node is built by reading the SRAT table, from acpi_numa_init with 
ACPI_NUMA and k8_scan_nodes with K8_NUMA.
x86_cpu_to_apicid is built by parsing the ACPI MADT table, from acpi_boot_init. We combine these two tables and setup cpu_to_node.

Early intialization helps the static per_cpu_areas in getting pages from 
correct node.

Patch tested on TYAN dual core 4P board with K8 only and then ACPI_NUMA.
Tested on EM64T NUMA too.
 
Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.15-rc5/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/kernel/setup.c	2005-12-14 17:02:14.000000000 -0800
+++ linux-2.6.15-rc5/arch/x86_64/kernel/setup.c	2005-12-14 17:16:07.000000000 -0800
@@ -669,6 +669,8 @@
 	acpi_boot_init();
 #endif
 
+	init_cpu_to_node();
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * get boot-time SMP configuration:
Index: linux-2.6.15-rc5/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/mm/numa.c	2005-12-15 12:44:39.000000000 -0800
+++ linux-2.6.15-rc5/arch/x86_64/mm/numa.c	2005-12-15 23:03:07.000000000 -0800
@@ -330,6 +330,16 @@
 	return 1;
 } 
 
+/*
+ * Setup early cpu_to_node.
+ */
+void __init init_cpu_to_node(void)
+{
+	int i;	
+ 	for (i = 0; i < NR_CPUS; i++)
+ 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
+}
+
 EXPORT_SYMBOL(cpu_to_node);
 EXPORT_SYMBOL(node_to_cpumask);
 EXPORT_SYMBOL(memnode_shift);
Index: linux-2.6.15-rc5/include/asm-x86_64/numa.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-x86_64/numa.h	2005-12-14 15:33:35.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-x86_64/numa.h	2005-12-15 23:11:35.000000000 -0800
@@ -21,6 +21,11 @@
 
 extern unsigned char apicid_to_node[256];
 
+#ifdef CONFIG_NUMA
+extern void __init init_cpu_to_node(void);
+#else
+#define init_cpu_to_node() do {} while (0)
+#endif
 #define NUMA_NO_NODE 0xff
 
 #endif
