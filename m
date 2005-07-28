Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVG1BPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVG1BPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVG1BPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:15:31 -0400
Received: from serv01.siteground.net ([70.85.91.68]:57259 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261463AbVG1BP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:15:28 -0400
Date: Wed, 27 Jul 2005 18:15:40 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch] x86_64: fix cpu_to_node setup for sparse apic_ids
Message-ID: <20050728011540.GA23923@localhost.localdomain>
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

While booting with SMT disabled in bios, when using acpi srat to setup
cpu_to_node[],  sparse apic_ids create problems.  Here's a fix for that.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.13-rc3/arch/x86_64/mm/srat.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/x86_64/mm/srat.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13-rc3/arch/x86_64/mm/srat.c	2005-07-27 15:36:23.000000000 -0700
@@ -20,6 +20,9 @@
 
 static struct acpi_table_slit *acpi_slit;
 
+/* Internal processor count */
+static unsigned int __initdata num_processors = 0;
+
 static nodemask_t nodes_parsed __initdata;
 static nodemask_t nodes_found __initdata;
 static struct node nodes[MAX_NUMNODES] __initdata;
@@ -101,16 +104,18 @@
 		bad_srat();
 		return;
 	}
-	if (pa->apic_id >= NR_CPUS) {
-		printk(KERN_ERR "SRAT: lapic %u too large.\n",
-		       pa->apic_id);
+	if (num_processors >= NR_CPUS) {
+		printk(KERN_ERR "SRAT: Processor #%d (lapic %u) INVALID. (Max ID: %d).\n",
+			num_processors, pa->apic_id, NR_CPUS);
 		bad_srat();
 		return;
 	}
-	cpu_to_node[pa->apic_id] = node;
+	cpu_to_node[num_processors] = node;
 	acpi_numa = 1;
-	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> Node %u\n",
-	       pxm, pa->apic_id, node);
+	printk(KERN_INFO "SRAT: PXM %u -> APIC %u -> CPU %u -> Node %u\n",
+	       pxm, pa->apic_id, num_processors, node);
+
+	num_processors++;
 }
 
 /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
