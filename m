Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUG0AKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUG0AKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUG0AKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:10:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50657 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266189AbUG0AKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:10:25 -0400
Subject: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@sgi.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Rm+KkZJgsLqw//9BWLjL"
Organization: IBM LTC
Message-Id: <1090887007.16676.18.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 26 Jul 2004 17:10:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rm+KkZJgsLqw//9BWLjL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
a more generally useful function than pcibus_to_cpumask().  If anyone
disagrees with that, now would be a good time to let us know.

This is just a preliminary patch.  It needs review for x86_64, as I
don't know how to properly populate the mp_bus_to_node (which used to be
mp_bus_to_cpumask) array.

The main changes are as follows:

1) Replace instances of pcibus_to_cpumask(bus) with
node_to_cpumask(pcibus_to_node(bus)).  There are currently only 2 uses
of pcibus_to_cpumask(): flush_gart() in arch/x86_64/kernel/pci-gart.c
and pci_bus_show_cpuaffinity() in drivers/pci/probe.c.
2) Define the asm-generic version of pcibus_to_node() to always return
node 0, as this is the sensible non-NUMA behavior.
3) Drop the mips/mach-ip27 and ppc64 versions of pcibus_to_cpumask()
entirely, since they were simply defined to be identical to the
asm-generic version.
4) Define the i386 version of pcibus_to_node().

Future work:

1) Correctly map PCI buses to nodes for x86_64.
2) IA64 implementation?
3) Other arch implementations?

[mcd@arrakis source]$ diffstat ~/linux/patches/pcibus_to_node.patch
 arch/x86_64/kernel/mpparse.c          |    3 ++-
 arch/x86_64/kernel/pci-gart.c         |    2 +-
 drivers/pci/probe.c                   |    2 +-
 include/asm-generic/topology.h        |    4 ++--
 include/asm-i386/topology.h           |    4 ++--
 include/asm-mips/mach-ip27/topology.h |    1 -
 include/asm-ppc64/topology.h          |    2 --
 include/asm-x86_64/mpspec.h           |    2 +-
 include/asm-x86_64/topology.h         |    6 ++----
 9 files changed, 11 insertions(+), 15 deletions(-)

-Matt

--=-Rm+KkZJgsLqw//9BWLjL
Content-Disposition: attachment; filename=pcibus_to_node.patch
Content-Type: text/x-patch; name=pcibus_to_node.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/x86_64/kernel/mpparse.c linux-2.6.7-mm7+pcibus_to_node/arch/x86_64/kernel/mpparse.c
--- linux-2.6.7-mm7/arch/x86_64/kernel/mpparse.c	2004-07-12 10:39:11.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/arch/x86_64/kernel/mpparse.c	2004-07-26 15:09:30.000000000 -0700
@@ -44,7 +44,7 @@ int acpi_found_madt;
 int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-cpumask_t mp_bus_to_cpumask [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = CPU_MASK_ALL };
+int mp_bus_to_node [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 
 int mp_current_pci_id = 0;
 /* I/O APIC entries */
@@ -169,6 +169,7 @@ static void __init MP_bus_info (struct m
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
 		mp_bus_id_to_pci_bus[m->mpc_busid] = mp_current_pci_id;
 		mp_current_pci_id++;
+		/* FIXME: Setup PCI bus to Node mapping here? */
 	} else if (strncmp(str, "MCA", 3) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
 	} else {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/arch/x86_64/kernel/pci-gart.c linux-2.6.7-mm7+pcibus_to_node/arch/x86_64/kernel/pci-gart.c
--- linux-2.6.7-mm7/arch/x86_64/kernel/pci-gart.c	2004-07-12 10:39:11.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/arch/x86_64/kernel/pci-gart.c	2004-07-26 15:12:55.000000000 -0700
@@ -148,7 +148,7 @@ static void flush_gart(struct pci_dev *d
 { 
 	unsigned long flags;
 	int bus = dev ? dev->bus->number : -1;
-	cpumask_t bus_cpumask = pcibus_to_cpumask(bus);
+	cpumask_t bus_cpumask = node_to_cpumask(pcibus_to_node(bus));
 	int flushed = 0;
 	int i;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/drivers/pci/probe.c linux-2.6.7-mm7+pcibus_to_node/drivers/pci/probe.c
--- linux-2.6.7-mm7/drivers/pci/probe.c	2004-07-12 10:39:18.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/drivers/pci/probe.c	2004-07-23 07:49:24.000000000 -0700
@@ -54,7 +54,7 @@ postcore_initcall(pcibus_class_init);
  */
 static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
 {
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	cpumask_t cpumask = node_to_cpumask(pcibus_to_node((to_pci_bus(class_dev))->number));
 	int ret;
 
 	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-generic/topology.h linux-2.6.7-mm7+pcibus_to_node/include/asm-generic/topology.h
--- linux-2.6.7-mm7/include/asm-generic/topology.h	2004-06-15 22:18:58.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-generic/topology.h	2004-07-26 15:11:27.000000000 -0700
@@ -41,8 +41,8 @@
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
 #endif
-#ifndef pcibus_to_cpumask
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
+#ifndef pcibus_to_node
+#define pcibus_to_node(bus)	(0)
 #endif
 
 /* Cross-node load balancing interval. */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-i386/topology.h linux-2.6.7-mm7+pcibus_to_node/include/asm-i386/topology.h
--- linux-2.6.7-mm7/include/asm-i386/topology.h	2004-06-15 22:19:01.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-i386/topology.h	2004-07-23 07:56:16.000000000 -0700
@@ -61,9 +61,9 @@ static inline int node_to_first_cpu(int 
 }
 
 /* Returns the number of the node containing PCI bus 'bus' */
-static inline cpumask_t pcibus_to_cpumask(int bus)
+static inline int pcibus_to_node(int bus)
 {
-	return node_to_cpumask(mp_bus_id_to_node[bus]);
+	return mp_bus_id_to_node[bus];
 }
 
 /* Node-to-Node distance */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-mips/mach-ip27/topology.h linux-2.6.7-mm7+pcibus_to_node/include/asm-mips/mach-ip27/topology.h
--- linux-2.6.7-mm7/include/asm-mips/mach-ip27/topology.h	2004-06-15 22:20:26.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-mips/mach-ip27/topology.h	2004-07-23 07:54:20.000000000 -0700
@@ -7,7 +7,6 @@
 #define parent_node(node)	(node)
 #define node_to_cpumask(node)	(HUB_DATA(node)->h_cpus)
 #define node_to_first_cpu(node)	(first_cpu(node_to_cpumask(node)))
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
 
 extern int node_distance(nasid_t nasid_a, nasid_t nasid_b);
 #define node_distance(from, to)	node_distance(from, to)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-ppc64/topology.h linux-2.6.7-mm7+pcibus_to_node/include/asm-ppc64/topology.h
--- linux-2.6.7-mm7/include/asm-ppc64/topology.h	2004-06-15 22:20:16.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-ppc64/topology.h	2004-07-23 07:54:30.000000000 -0700
@@ -33,8 +33,6 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(tmp);
 }
 
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])
 
 /* Cross-node load balancing interval. */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-x86_64/mpspec.h linux-2.6.7-mm7+pcibus_to_node/include/asm-x86_64/mpspec.h
--- linux-2.6.7-mm7/include/asm-x86_64/mpspec.h	2004-07-12 10:39:40.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-x86_64/mpspec.h	2004-07-23 07:57:53.000000000 -0700
@@ -166,7 +166,7 @@ enum mp_bustype {
 };
 extern unsigned char mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
-extern cpumask_t mp_bus_to_cpumask [MAX_MP_BUSSES];
+extern cpumask_t mp_bus_to_node [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern int smp_found_config;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.7-mm7/include/asm-x86_64/topology.h linux-2.6.7-mm7+pcibus_to_node/include/asm-x86_64/topology.h
--- linux-2.6.7-mm7/include/asm-x86_64/topology.h	2004-07-12 10:39:40.000000000 -0700
+++ linux-2.6.7-mm7+pcibus_to_node/include/asm-x86_64/topology.h	2004-07-23 07:59:29.000000000 -0700
@@ -20,11 +20,9 @@ extern cpumask_t     node_to_cpumask[];
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
 
-static inline cpumask_t pcibus_to_cpumask(int bus)
+static inline int pcibus_to_node(int bus)
 {
-	cpumask_t tmp;
-	cpus_and(tmp, mp_bus_to_cpumask[bus], cpu_online_map);
-	return tmp;
+	return mp_bus_to_node[bus];
 }
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 

--=-Rm+KkZJgsLqw//9BWLjL--

