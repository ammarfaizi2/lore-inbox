Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWFVBy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWFVBy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWFVBy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:54:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38293 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030499AbWFVBy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:54:57 -0400
Subject: [RFC] patch [1/1]  convert i386 summit subarch to use SRAT data
	for apicid_to_node
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-SQNwSJ2oEDCnIKvv2cbW"
Organization: Linux Technology Center IBM
Date: Wed, 21 Jun 2006 18:54:55 -0700
Message-Id: <1150941296.10001.25.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SQNwSJ2oEDCnIKvv2cbW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,
  This patch converts the i386 summit subarch apicid_to_node to use node
information provided by the SRAT.  The current way of obtaining the
nodeid 

 static inline int apicid_to_node(int logical_apicid)
 { 
   return logical_apicid >> 5;
 }

is just not correct for all summit systems/bios.  Assuming the apicid
matches the Linux node number require a leap of faith that the bios lay-
ed out the apicids a set way.  Modern summit HW does not layout its bios
in the manner for various reasons and is unable to boot i386 numa.

  The best way to get the correct apicid to node information is from the
SRAT table.  It lays out what apicid belongs to what node.  I use this
information to create a table for use at run time. 

  The attached patch was built against 2.6.17-rc2 but applies and runs
against 2.6.17 just fine.  It only changes the summit subarch although
since a global data structure is created it might make sense to change
all the subarches.  All comments welcome. 

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>


--=-SQNwSJ2oEDCnIKvv2cbW
Content-Disposition: attachment; filename=patch-2.6.17-rc2-git6-apicid_to_node_v1.patch
Content-Type: text/x-patch; name=patch-2.6.17-rc2-git6-apicid_to_node_v1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.17-rc2-git6.orig/arch/i386/kernel/smpboot.c linux-2.6.17-rc2-git6/arch/i386/kernel/smpboot.c
--- linux-2.6.17-rc2-git6.orig/arch/i386/kernel/smpboot.c	2006-04-25 15:14:30.000000000 -0600
+++ linux-2.6.17-rc2-git6/arch/i386/kernel/smpboot.c	2006-04-25 12:02:45.000000000 -0600
@@ -108,6 +108,8 @@
 			{ [0 ... NR_CPUS-1] = 0xff };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
 
+u8 apicid_2_node[MAX_APICID] = { [0 ... MAX_APICID-1] = 0 };
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -640,7 +642,7 @@
 	int apicid = logical_smp_processor_id();
 
 	cpu_2_logical_apicid[cpu] = apicid;
-	map_cpu_to_node(cpu, apicid_to_node(apicid));
+	map_cpu_to_node(cpu, apicid_to_node(hard_smp_processor_id()));
 }
 
 static void unmap_cpu_to_logical_apicid(int cpu)
@@ -943,6 +945,7 @@
 
 	irq_ctx_init(cpu);
 
+	x86_cpu_to_apicid[cpu] = apicid;
 	/*
 	 * This grunge runs the startup process for
 	 * the targeted processor.
diff -urN linux-2.6.17-rc2-git6.orig/arch/i386/kernel/srat.c linux-2.6.17-rc2-git6/arch/i386/kernel/srat.c
--- linux-2.6.17-rc2-git6.orig/arch/i386/kernel/srat.c	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.17-rc2-git6/arch/i386/kernel/srat.c	2006-04-25 11:56:45.000000000 -0600
@@ -58,6 +58,8 @@
 static int num_memory_chunks;		/* total number of memory chunks */
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
+static u8 apicid_to_pxm[MAX_APICID] = { [0 ... MAX_APICID-1] = 0 };
+extern u8 apicid_2_node[];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -73,6 +75,8 @@
 	/* mark this node as "seen" in node bitmap */
 	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain);
 
+	apicid_to_pxm[cpu_affinity->apic_id] = cpu_affinity->proximity_domain;
+
 	printk("CPU 0x%02X in proximity domain 0x%02X\n",
 		cpu_affinity->apic_id, cpu_affinity->proximity_domain);
 }
@@ -298,6 +302,10 @@
 	printk("Number of logical nodes in system = %d\n", num_online_nodes());
 	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
 
+	for (i = 0; i < MAX_APICID; i++) {
+		apicid_2_node[i] = pxm_to_nid_map[apicid_to_pxm[i]];
+	}
+	
 	for (j = 0; j < num_memory_chunks; j++){
 		struct node_memory_chunk_s * chunk = &node_memory_chunk[j];
 		printk("chunk %d nid %d start_pfn %08lx end_pfn %08lx\n",
diff -urN linux-2.6.17-rc2-git6.orig/include/asm-i386/mach-summit/mach_apic.h linux-2.6.17-rc2-git6/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.17-rc2-git6.orig/include/asm-i386/mach-summit/mach_apic.h	2006-03-19 22:53:29.000000000 -0700
+++ linux-2.6.17-rc2-git6/include/asm-i386/mach-summit/mach_apic.h	2006-04-25 11:56:45.000000000 -0600
@@ -43,6 +43,7 @@
 
 extern u8 bios_cpu_apicid[];
 extern u8 cpu_2_logical_apicid[];
+extern u8 apicid_2_node[];
 
 static inline void init_apic_ldr(void)
 {
@@ -86,7 +87,7 @@
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return logical_apicid >> 5;          /* 2 clusterids per CEC */
+	return apicid_2_node[logical_apicid];
 }
 
 /* Mapping from cpu number to logical apicid */

--=-SQNwSJ2oEDCnIKvv2cbW--

