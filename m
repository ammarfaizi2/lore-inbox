Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWGTALQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWGTALQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWGTALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:11:16 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:18304 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964878AbWGTALP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:11:15 -0400
Subject: [Patch] convert i386 Summint subarch to use SRAT info for
	apicid_to_node calls
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-f3JH+9NH+r/eD3uC6QAc"
Organization: Linux Technology Center IBM
Date: Wed, 19 Jul 2006 17:11:13 -0700
Message-Id: <1153354273.5775.41.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f3JH+9NH+r/eD3uC6QAc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrew,
  This patch converts the i386 summit subarch apicid_to_node to use node
information provided by the SRAT.  It was discussed a little on LKML a
few weeks ago and was seen as an acceptable fix.  The current way of
obtaining the nodeid 

 static inline int apicid_to_node(int logical_apicid)
 { 
   return logical_apicid >> 5;
 }

is just not correct for all summit systems/bios.  Assuming the apicid
matches the Linux node number require a leap of faith that the bios
mapped out the apicids a set way.  Modern summit HW (IBM x460) does not
layout its bios in the manner for various reasons and is unable to boot
i386 numa.

  The best way to get the correct apicid to node information is from the
SRAT table during boot.  It lays out what apicid belongs to what node.
I use this information to create a table for use at run time. 

  The attached patch was built against 2.6.18-rc1.  It only changes the
summit subarch.  


Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-f3JH+9NH+r/eD3uC6QAc
Content-Disposition: attachment; filename=patch-2.6.18-rc1-apicid_to_node_srat-v2
Content-Type: text/x-patch; name=patch-2.6.18-rc1-apicid_to_node_srat-v2; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.17/arch/i386/kernel/smpboot.c linux-2.6.17-works/arch/i386/kernel/smpboot.c
--- linux-2.6.17/arch/i386/kernel/smpboot.c	2006-07-19 04:25:40.000000000 -0700
+++ linux-2.6.17-works/arch/i386/kernel/smpboot.c	2006-07-18 20:30:10.000000000 -0700
@@ -102,6 +102,8 @@
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
diff -urN linux-2.6.17/arch/i386/kernel/srat.c linux-2.6.17-works/arch/i386/kernel/srat.c
--- linux-2.6.17/arch/i386/kernel/srat.c	2006-07-19 04:25:40.000000000 -0700
+++ linux-2.6.17-works/arch/i386/kernel/srat.c	2006-07-19 04:36:18.000000000 -0700
@@ -56,6 +56,7 @@
 static int num_memory_chunks;		/* total number of memory chunks */
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
+static u8 apicid_to_pxm[MAX_APICID] = { [0 ... MAX_APICID-1] = 0 };
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -71,6 +72,8 @@
 	/* mark this node as "seen" in node bitmap */
 	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain);
 
+	apicid_to_pxm[cpu_affinity->apic_id] = cpu_affinity->proximity_domain;
+
 	printk("CPU 0x%02X in proximity domain 0x%02X\n",
 		cpu_affinity->apic_id, cpu_affinity->proximity_domain);
 }
@@ -282,6 +285,10 @@
 	printk("Number of logical nodes in system = %d\n", num_online_nodes());
 	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
 
+	for (i = 0; i < MAX_APICID; i++) {
+		apicid_2_node[i] = pxm_to_node(apicid_to_pxm[i]);
+	}
+	
 	for (j = 0; j < num_memory_chunks; j++){
 		struct node_memory_chunk_s * chunk = &node_memory_chunk[j];
 		printk("chunk %d nid %d start_pfn %08lx end_pfn %08lx\n",
diff -urN linux-2.6.17/include/asm-i386/mach-summit/mach_apic.h linux-2.6.17-works/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.17/include/asm-i386/mach-summit/mach_apic.h	2006-07-19 04:25:51.000000000 -0700
+++ linux-2.6.17-works/include/asm-i386/mach-summit/mach_apic.h	2006-07-18 20:45:23.000000000 -0700
@@ -2,6 +2,7 @@
 #define __ASM_MACH_APIC_H
 
 #include <asm/smp.h>
+#include <asm/srat.h>
 
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
@@ -85,7 +86,7 @@
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return logical_apicid >> 5;          /* 2 clusterids per CEC */
+	return apicid_2_node[logical_apicid];
 }
 
 /* Mapping from cpu number to logical apicid */
diff -urN linux-2.6.17/include/asm-i386/srat.h linux-2.6.17-works/include/asm-i386/srat.h
--- linux-2.6.17/include/asm-i386/srat.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-works/include/asm-i386/srat.h	2006-07-18 21:26:38.000000000 -0700
@@ -33,5 +33,6 @@
 
 extern int get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
+extern u8 apicid_2_node[];
 
 #endif /* _ASM_SRAT_H_ */

--=-f3JH+9NH+r/eD3uC6QAc--

