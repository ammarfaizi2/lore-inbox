Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVDLVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVDLVWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVDLVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:19:22 -0400
Received: from graphe.net ([209.204.138.32]:20499 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262969AbVDLVQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:16:24 -0400
Date: Tue, 12 Apr 2005 14:16:17 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org, ak@suse.de
cc: shai@scalex86.org
Subject: Add pcibus_to_node
Message-ID: <Pine.LNX.4.58.0504121413510.10332@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define pcibus_to_node to be able to figure out which NUMA node contains a
given PCI device. This defines pcibus_to_node(bus) in
include/linux/topology.h and adjusts the macros for i386 and x86_64 that
already provided a way to determine the cpumask of a pci device.

x86_64 was changed to not build an array of cpumasks anymore. Instead an
array of nodes is build which can be used to generate the cpumask via
node_to_cpumask.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux-2.6.11.orig/arch/x86_64/kernel/mpparse.c	2005-04-11 16:55:44.000000000 -0700
+++ linux-2.6.11/arch/x86_64/kernel/mpparse.c	2005-04-11 16:55:56.000000000 -0700
@@ -44,7 +44,7 @@ int acpi_found_madt;
 int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-cpumask_t pci_bus_to_cpumask [256] = { [0 ... 255] = CPU_MASK_ALL };
+unsigned char pci_bus_to_node [256];

 static int mp_current_pci_id = 0;
 /* I/O APIC entries */
Index: linux-2.6.11/arch/x86_64/pci/k8-bus.c
===================================================================
--- linux-2.6.11.orig/arch/x86_64/pci/k8-bus.c	2005-04-11 16:55:44.000000000 -0700
+++ linux-2.6.11/arch/x86_64/pci/k8-bus.c	2005-04-11 16:55:56.000000000 -0700
@@ -53,25 +53,11 @@ fill_mp_bus_to_cpumask(void)
 				for (j = SECONDARY_LDT_BUS_NUMBER(ldtbus);
 				     j <= SUBORDINATE_LDT_BUS_NUMBER(ldtbus);
 				     j++)
-					pci_bus_to_cpumask[j] =
-						node_to_cpumask(NODE_ID(nid));
+					pci_bus_to_node[j] = NODE_ID(nid);
 			}
 		}
 	}

-	/* quick sanity check */
-	printed = 0;
-	for (i = 0; i < 256; i++) {
-		if (cpus_empty(pci_bus_to_cpumask[i])) {
-			pci_bus_to_cpumask[i] = CPU_MASK_ALL;
-			if (printed)
-				continue;
-			printk(KERN_ERR
-			       "k8-bus.c: some busses have empty cpu mask\n");
-			printed = 1;
-		}
-	}
-
 	return 0;
 }

Index: linux-2.6.11/include/asm-generic/topology.h
===================================================================
--- linux-2.6.11.orig/include/asm-generic/topology.h	2005-04-11 16:54:05.000000000 -0700
+++ linux-2.6.11/include/asm-generic/topology.h	2005-04-11 16:55:56.000000000 -0700
@@ -41,8 +41,12 @@
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
 #endif
+#ifndef pcibus_to_node
+#define pcibus_to_node(node)	(0)
+#endif
+
 #ifndef pcibus_to_cpumask
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
+#define pcibus_to_cpumask(bus)	(node_to_cpumask(pcibus_to_node(bus)))
 #endif

 #endif /* _ASM_GENERIC_TOPOLOGY_H */
Index: linux-2.6.11/include/asm-i386/topology.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/topology.h	2005-04-11 16:55:47.000000000 -0700
+++ linux-2.6.11/include/asm-i386/topology.h	2005-04-11 16:57:32.000000000 -0700
@@ -60,12 +60,8 @@ static inline int node_to_first_cpu(int
 	return first_cpu(mask);
 }

-/* Returns the number of the node containing PCI bus number 'busnr' */
-static inline cpumask_t __pcibus_to_cpumask(int busnr)
-{
-	return node_to_cpumask(mp_bus_id_to_node[busnr]);
-}
-#define pcibus_to_cpumask(bus)	__pcibus_to_cpumask(bus->number)
+#define pcibus_to_node(bus) mp_bus_id_to_node[(bus)->busnr]
+#define pcibus_to_cpumask(busnr) node_to_cpumask(pcibus_to_node(bus))

 /* sched_domains SD_NODE_INIT for NUMAQ machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
Index: linux-2.6.11/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.11.orig/include/asm-x86_64/topology.h	2005-04-11 16:55:47.000000000 -0700
+++ linux-2.6.11/include/asm-x86_64/topology.h	2005-04-11 16:55:56.000000000 -0700
@@ -13,8 +13,8 @@
 extern cpumask_t cpu_online_map;

 extern unsigned char cpu_to_node[];
+extern unsigned char pci_bus_to_node[];
 extern cpumask_t     node_to_cpumask[];
-extern cpumask_t pci_bus_to_cpumask[];

 #ifdef CONFIG_ACPI_NUMA
 extern int __node_distance(int, int);
@@ -26,16 +26,7 @@ extern int __node_distance(int, int);
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
-
-static inline cpumask_t __pcibus_to_cpumask(int bus)
-{
-	cpumask_t busmask = pci_bus_to_cpumask[bus];
-	cpumask_t online = cpu_online_map;
-	cpumask_t res;
-	cpus_and(res, busmask, online);
-	return res;
-}
-#define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus->number)
+#define pcibus_to_cpumask(bus)		node_to_cpumask(pci_bus_to_node[(bus)->number]);

 #ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */
