Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTCERFE>; Wed, 5 Mar 2003 12:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTCERFE>; Wed, 5 Mar 2003 12:05:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19851 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267274AbTCERE6>; Wed, 5 Mar 2003 12:04:58 -0500
Date: Wed, 05 Mar 2003 09:15:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/6 Make CONFIG_NUMA work on non-numa machines.
Message-ID: <155040000.1046884524@[10.10.2.4]>
In-Reply-To: <154390000.1046884457@[10.10.2.4]>
References: <154390000.1046884457@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andy Whitcroft

A few very simple changes in order to make CONFIG_NUMA work everywhere, so 
the distros can build one common binary kernel for distributions.

diff -urpN -X /home/fletch/.diff.exclude 012-pfn_valid/arch/i386/Kconfig
013-numa_x86_pc/arch/i386/Kconfig
--- 012-pfn_valid/arch/i386/Kconfig	Wed Mar  5 07:36:57 2003
+++ 013-numa_x86_pc/arch/i386/Kconfig	Wed Mar  5 07:41:54 2003
@@ -488,7 +488,7 @@ config NR_CPUS
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
-	depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI &&
!ACPI_HT_ONLY)))
+	depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI &&
!ACPI_HT_ONLY))) || X86_PC
 
 config DISCONTIGMEM
 	bool
diff -urpN -X /home/fletch/.diff.exclude
012-pfn_valid/arch/i386/kernel/smpboot.c
013-numa_x86_pc/arch/i386/kernel/smpboot.c
--- 012-pfn_valid/arch/i386/kernel/smpboot.c	Wed Mar  5 07:36:57 2003
+++ 013-numa_x86_pc/arch/i386/kernel/smpboot.c	Wed Mar  5 07:41:54 2003
@@ -966,6 +966,7 @@ static void __init smp_boot_cpus(unsigne
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
+		map_cpu_to_logical_apicid();
 		return;
 	}
 
diff -urpN -X /home/fletch/.diff.exclude
012-pfn_valid/arch/i386/mm/discontig.c
013-numa_x86_pc/arch/i386/mm/discontig.c
--- 012-pfn_valid/arch/i386/mm/discontig.c	Wed Mar  5 07:41:52 2003
+++ 013-numa_x86_pc/arch/i386/mm/discontig.c	Wed Mar  5 07:41:54 2003
@@ -82,6 +82,36 @@ void *node_remap_start_vaddr[MAX_NUMNODE
 void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
 /*
+ * FLAT - support for basic PC memory model with discontig enabled,
essentially
+ *        a single node with all available processors in it with a flat
+ *        memory map.
+ */
+void __init get_memcfg_numa_flat(void)
+{
+	int pfn;
+
+	printk("NUMA - single node, flat memory mode\n");
+
+	/* Run the memory configuration and find the top of memory. */
+	find_max_pfn();
+	node_start_pfn[0]  = 0;
+	node_end_pfn[0]	  = max_pfn;
+
+	/* Fill in the physnode_map with our simplistic memory model,
+	* all memory is in node 0.
+	*/
+	for (pfn = node_start_pfn[0]; pfn <= node_end_pfn[0];
+	       pfn += PAGES_PER_ELEMENT)
+	{
+		physnode_map[pfn / PAGES_PER_ELEMENT] = 0;
+	}
+
+         /* Indicate there is one node available. */
+	node_set_online(0);
+	numnodes = 1;
+}
+
+/*
  * Find the highest page frame number we have available for the node
  */
 static void __init find_max_pfn_node(int nid)
diff -urpN -X /home/fletch/.diff.exclude
012-pfn_valid/include/asm-i386/mmzone.h
013-numa_x86_pc/include/asm-i386/mmzone.h
--- 012-pfn_valid/include/asm-i386/mmzone.h	Wed Mar  5 07:41:53 2003
+++ 013-numa_x86_pc/include/asm-i386/mmzone.h	Wed Mar  5 07:41:54 2003
@@ -123,6 +123,9 @@ static inline struct pglist_data *pfn_to
 #include <asm/numaq.h>
 #elif CONFIG_X86_SUMMIT
 #include <asm/srat.h>
+#elif CONFIG_X86_PC
+#define get_memcfg_numa get_memcfg_numa_flat
+#define get_zholes_size(n) (0)
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif /* CONFIG_X86_NUMAQ */

