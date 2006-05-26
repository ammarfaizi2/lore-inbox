Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWEZJEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWEZJEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWEZJEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:04:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13503 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751342AbWEZJEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:04:09 -0400
Date: Fri, 26 May 2006 18:05:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, ashok.raj@intel.com, steiner@sgi.com,
       tony.luck@intel.com
Subject: [RFC][PATCH] ia64 node hotplug -- cpu - node relationship fix [2/2]
 cpu-to-node map
Message-Id: <20060526180537.84480f0d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At node hotplug, cpu can be added before memory depends on evaluation order of
firmware(ACPI) information.

Current ia64's cpu hotplug make an assumption at binding cpu to node.
       /*
        * Assuming that the container driver would have set the proximity
        * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
        */
If nid is invalid here, cpu is bound to node 0.
So, all cpus on the new node goes to node 0 if cpu is evaluated before memory.

We have node hotplug in -mm now. The container doesn't fixes pxm<->nid
conversion but acpi_map_pxm_to_nid() does it. cpu hotplug should call
acpi_map_pxm_to_nid() to map cpu to new nid. This patch makes cpu hotplug
to call acpi_map_pxm_to_nid().

This fix will map cpus to the correct node.

As a side effect, this shows another problem. node_to_cpu_mask[] should be
updated correctly. This patch also fixes it.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 arch/ia64/kernel/acpi.c     |   10 +++++-----
 arch/ia64/kernel/numa.c     |   15 ++++++++++++---
 include/asm-ia64/topology.h |    1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6.17-rc4-mm3/arch/ia64/kernel/numa.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ia64/kernel/numa.c	2006-05-26 16:37:50.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/ia64/kernel/numa.c	2006-05-26 17:08:14.000000000 +0900
@@ -30,6 +30,17 @@
 
 cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 
+/* called by cpu hotplug. */
+void __cpuinit arch_update_cpu_to_node(int cpu, int newnode)
+{
+	int oldnode = cpu_to_node(cpu);
+	cpu_to_node_map[cpu] = (newnode >= 0)? newnode : 0;
+	cpu_clear(cpu, node_to_cpu_mask[oldnode]);
+	if (newnode >= 0)
+		cpu_set(cpu, node_to_cpu_mask[newnode]);
+}
+
+
 /**
  * build_cpu_to_node_map - setup cpu to node and node to cpumask arrays
  *
@@ -50,8 +61,6 @@
 				node = node_cpuid[i].nid;
 				break;
 			}
-		cpu_to_node_map[cpu] = (node >= 0) ? node : 0;
-		if (node >= 0)
-			cpu_set(cpu, node_to_cpu_mask[node]);
+		arch_update_cpu_to_node(cpu, node);
 	}
 }
Index: linux-2.6.17-rc4-mm3/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ia64/kernel/acpi.c	2006-05-26 16:38:35.000000000 +0900
+++ linux-2.6.17-rc4-mm3/arch/ia64/kernel/acpi.c	2006-05-26 17:05:35.000000000 +0900
@@ -812,16 +812,16 @@
 {
 #ifdef CONFIG_ACPI_NUMA
 	int pxm_id;
+	int nid;
 
 	pxm_id = acpi_get_pxm(handle);
+	nid = acpi_map_pxm_to_node(pxm_id);
 
-	/*
-	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
-	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_node(pxm_id);
+	node_cpuid[cpu].nid = nid;
 
 	node_cpuid[cpu].phys_id = physid;
+
+	arch_update_cpu_to_node(cpu, nid);
 #endif
 	return (0);
 }
Index: linux-2.6.17-rc4-mm3/include/asm-ia64/topology.h
===================================================================
--- linux-2.6.17-rc4-mm3.orig/include/asm-ia64/topology.h	2006-05-26 16:37:50.000000000 +0900
+++ linux-2.6.17-rc4-mm3/include/asm-ia64/topology.h	2006-05-26 17:05:35.000000000 +0900
@@ -54,6 +54,7 @@
  */
 #define pcibus_to_node(bus) PCI_CONTROLLER(bus)->node
 
+void arch_update_cpu_to_node(int cpu, int nid);
 void build_cpu_to_node_map(void);
 
 #define SD_CPU_INIT (struct sched_domain) {		\

