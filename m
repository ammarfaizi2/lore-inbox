Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWGTUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWGTUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWGTUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:24:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50900 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964888AbWGTUYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:24:25 -0400
Subject: Re: [Patch] convert i386 Summint subarch to use SRAT info for
	apicid_to_node calls
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>
In-Reply-To: <1153354273.5775.41.camel@keithlap>
References: <1153354273.5775.41.camel@keithlap>
Content-Type: multipart/mixed; boundary="=-uNd9eliiCiqroTxp3G9I"
Organization: Linux Technology Center IBM
Date: Thu, 20 Jul 2006 13:24:20 -0700
Message-Id: <1153427061.5788.8.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uNd9eliiCiqroTxp3G9I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-07-19 at 17:11 -0700, keith mannthey wrote:
> Hello Andrew,
>   This patch converts the i386 summit subarch apicid_to_node to use node
> information provided by the SRAT.  It was discussed a little on LKML a
> few weeks ago and was seen as an acceptable fix.  The current way of
> obtaining the nodeid 
> 
>  static inline int apicid_to_node(int logical_apicid)
>  { 
>    return logical_apicid >> 5;
>  }
> 
> is just not correct for all summit systems/bios.  Assuming the apicid
> matches the Linux node number require a leap of faith that the bios
> mapped out the apicids a set way.  Modern summit HW (IBM x460) does not
> layout its bios in the manner for various reasons and is unable to boot
> i386 numa.
> 
>   The best way to get the correct apicid to node information is from the
> SRAT table during boot.  It lays out what apicid belongs to what node.
> I use this information to create a table for use at run time. 
> 
>   The attached patch was built against 2.6.18-rc1.  It only changes the
> summit subarch.  
> 

Attached updated patch to deal with non-numa Summit config options.   A
build error was reported when booting with numa off and Summit / Genarch
selected.  

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>


--=-uNd9eliiCiqroTxp3G9I
Content-Disposition: attachment; filename=patch-2.6.18-rc1-apicid_to_node_srat-v3
Content-Type: text/x-patch; name=patch-2.6.18-rc1-apicid_to_node_srat-v3; charset=utf-8
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
+++ linux-2.6.17-works/arch/i386/kernel/srat.c	2006-07-19 22:44:00.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/nodemask.h>
 #include <asm/srat.h>
 #include <asm/topology.h>
+#include <asm/smp.h>
 
 /*
  * proximity macros and definitions
@@ -56,6 +57,7 @@
 static int num_memory_chunks;		/* total number of memory chunks */
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
+static u8 apicid_to_pxm[MAX_APICID] = { [0 ... MAX_APICID-1] = 0 };
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -71,6 +73,8 @@
 	/* mark this node as "seen" in node bitmap */
 	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain);
 
+	apicid_to_pxm[cpu_affinity->apic_id] = cpu_affinity->proximity_domain;
+
 	printk("CPU 0x%02X in proximity domain 0x%02X\n",
 		cpu_affinity->apic_id, cpu_affinity->proximity_domain);
 }
@@ -282,6 +286,10 @@
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
+++ linux-2.6.17-works/include/asm-i386/mach-summit/mach_apic.h	2006-07-19 22:38:50.000000000 -0700
@@ -85,7 +85,7 @@
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return logical_apicid >> 5;          /* 2 clusterids per CEC */
+	return apicid_2_node[logical_apicid];
 }
 
 /* Mapping from cpu number to logical apicid */
diff -urN linux-2.6.17/include/asm-i386/smp.h linux-2.6.17-works/include/asm-i386/smp.h
--- linux-2.6.17/include/asm-i386/smp.h	2006-07-19 04:25:51.000000000 -0700
+++ linux-2.6.17-works/include/asm-i386/smp.h	2006-07-19 22:40:42.000000000 -0700
@@ -46,6 +46,8 @@
 
 #define cpu_physical_id(cpu)	x86_cpu_to_apicid[cpu]
 
+extern u8 apicid_2_node[];
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);

--=-uNd9eliiCiqroTxp3G9I--

