Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUG2Wk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUG2Wk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUG2WjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:39:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18050 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267501AbUG2WcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:32:19 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200407290843.46116.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	 <200407271140.29818.jbarnes@engr.sgi.com>
	 <1091059607.19459.69.camel@arrakis>
	 <200407290843.46116.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091139818.4070.7.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jul 2004 15:23:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 08:43, Jesse Barnes wrote:
> On Wednesday, July 28, 2004 5:06 pm, Matthew Dobson wrote:
> > Ok, so I'm no longer convinced that this will work as well as I once
> > thought.  It's pretty trivial to add a nodemask_t to the struct pci_bus,
> > and even initialize it to a reasonable value (ie: NODE_MASK_ALL) since
> > there's the convenient pci_alloc_bus() function in drivers/pci/probe.c.
> > The problem is where to put hooks for individual arches to put the
> > *real* nodemask in this field...  My only thought right now is to create
> > a per-arch callback function, arch_get_pcibus_nodemask() or something,
> 
> Yeah, that sounds reasonable.  You could protect a generic definition with 
> #ifndef ARCH_HAS_PCIBUS_TO_NODEMASK or something...
> 
> > and use the value it returns to populate pci_bus->nodemask.  We would
> > have to call this function anywhere a struct pci_bus is allocated, and
> > probably pass along the PCI bus number so the arch could determine which
> > nodes it belongs to.  Would that work for everyone that cares?  We could
> > overload that to return NODE_MASK_ALL for non-NUMA systems, and have it
> > do the right thing for arches that care...
> 
> Yeah, I think that would work.  The alternative is to simply add the field, 
> initialize it in pci_alloc_bus like you're doing, and leave it to the arches 
> to fill it in however they see fit.
> 
> Jesse

Ok...  Still an RFC, but moving closer to something that we can use. 
Anyone have any comments on this untested iteration? ;)

What I'm doing is basically ripping out all the old pcibus_to_cpumask()
calls.  The only arch that defined it to be anything other than
CPU_MASK_ALL was i386, and theirs should still work.  x86_64 had the
beginnings of a PCI bus to CPU mask mapping, but it was never filled in,
just populated with CPU_MASK_ALL, so it does the same with NODE_MASK_ALL
now.  Those two arches, in their include/asm-$ARCH/topology.h define
both ARCH_HAS_GET_PCIBUS_NODEMASK and get_pcibus_nodemask(bus). 
include/linux/topology.h defines a simple get_pcibus_nodemask(bus) if
there isn't an arch-specific one provided.  We then, in
drivers/pci/probe.c, populate the nodemask field of struct pci_bus with
this nodemask.  Lookup involves simply returning the nodemask stored in
the struct pci_bus.

[mcd@arrakis source]$ diffstat ~/linux/patches/pcibus_to_nodemask.patch
 arch/x86_64/kernel/mpparse.c          |    2 +-
 drivers/pci/probe.c                   |    6 ++++--
 include/asm-alpha/topology.h          |    2 --
 include/asm-generic/topology.h        |    3 ---
 include/asm-i386/topology.h           |    7 ++-----
 include/asm-mips/mach-ip27/topology.h |    1 -
 include/asm-ppc64/topology.h          |    2 --
 include/asm-x86_64/mpspec.h           |    2 +-
 include/asm-x86_64/topology.h         |   10 +++-------
 include/linux/pci.h                   |    2 ++
 include/linux/topology.h              |   22 ++++++++++++++++++++++
 11 files changed, 35 insertions(+), 24 deletions(-)

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/arch/x86_64/kernel/mpparse.c linux-2.6.8-rc2-mm1+pcibus_to_nodemask/arch/x86_64/kernel/mpparse.c
--- linux-2.6.8-rc2-mm1/arch/x86_64/kernel/mpparse.c	2004-07-28 10:50:34.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/arch/x86_64/kernel/mpparse.c	2004-07-29 14:53:27.000000000 -0700
@@ -44,7 +44,7 @@ int acpi_found_madt;
 int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-cpumask_t pci_bus_to_cpumask [256] = { [0 ... 255] = CPU_MASK_ALL };
+nodemask_t pci_bus_to_nodemask [256] = { [0 ... 255] = NODE_MASK_ALL };
 
 int mp_current_pci_id = 0;
 /* I/O APIC entries */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/drivers/pci/probe.c linux-2.6.8-rc2-mm1+pcibus_to_nodemask/drivers/pci/probe.c
--- linux-2.6.8-rc2-mm1/drivers/pci/probe.c	2004-07-28 10:49:45.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/drivers/pci/probe.c	2004-07-29 15:06:26.000000000 -0700
@@ -6,7 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/cpumask.h>
+#include <linux/topology.h>
 
 #undef DEBUG
 
@@ -54,7 +54,7 @@ postcore_initcall(pcibus_class_init);
  */
 static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
 {
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	cpumask_t cpumask = nodemask_to_cpumask(pcibus_to_nodemask(to_pci_bus(class_dev)));
 	int ret;
 
 	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
@@ -305,6 +305,7 @@ pci_alloc_child_bus(struct pci_bus *pare
 	child->number = child->secondary = busnr;
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
+	child->nodemask = get_pcibus_nodemask(busnr);
 
 	/* Set up default resource pointers and names.. */
 	for (i = 0; i < 4; i++) {
@@ -786,6 +787,7 @@ struct pci_bus * __devinit pci_scan_bus_
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
+	b->nodemask = get_pcibus_nodemask(bus);
 
 	b->subordinate = pci_scan_child_bus(b);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-alpha/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-alpha/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-alpha/topology.h	2004-07-28 10:49:58.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-alpha/topology.h	2004-07-28 16:42:29.000000000 -0700
@@ -42,8 +42,6 @@ static inline cpumask_t node_to_cpumask(
 /* Cross-node load balancing interval. */
 # define NODE_BALANCE_RATE 10
 
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-
 #else /* CONFIG_NUMA */
 # include <asm-generic/topology.h>
 #endif /* !CONFIG_NUMA */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-generic/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-generic/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-generic/topology.h	2004-06-15 22:18:58.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-generic/topology.h	2004-07-28 16:29:06.000000000 -0700
@@ -41,9 +41,6 @@
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
 #endif
-#ifndef pcibus_to_cpumask
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-#endif
 
 /* Cross-node load balancing interval. */
 #ifndef NODE_BALANCE_RATE
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-i386/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-i386/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-i386/topology.h	2004-06-15 22:19:01.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-i386/topology.h	2004-07-29 15:16:16.000000000 -0700
@@ -60,11 +60,8 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(mask);
 }
 
-/* Returns the number of the node containing PCI bus 'bus' */
-static inline cpumask_t pcibus_to_cpumask(int bus)
-{
-	return node_to_cpumask(mp_bus_id_to_node[bus]);
-}
+#define ARCH_HAS_GET_PCIBUS_NODEMASK
+#define get_pcibus_nodemask(bus)	(nodemask_of_node(mp_bus_id_to_node[bus]))
 
 /* Node-to-Node distance */
 #define node_distance(from, to) (from != to)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-mips/mach-ip27/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-mips/mach-ip27/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-mips/mach-ip27/topology.h	2004-06-15 22:20:26.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-mips/mach-ip27/topology.h	2004-07-28 16:07:38.000000000 -0700
@@ -7,7 +7,6 @@
 #define parent_node(node)	(node)
 #define node_to_cpumask(node)	(HUB_DATA(node)->h_cpus)
 #define node_to_first_cpu(node)	(first_cpu(node_to_cpumask(node)))
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
 
 extern int node_distance(nasid_t nasid_a, nasid_t nasid_b);
 #define node_distance(from, to)	node_distance(from, to)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-ppc64/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-ppc64/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-ppc64/topology.h	2004-06-15 22:20:16.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-ppc64/topology.h	2004-07-28 16:07:48.000000000 -0700
@@ -33,8 +33,6 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(tmp);
 }
 
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])
 
 /* Cross-node load balancing interval. */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-x86_64/mpspec.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/mpspec.h
--- linux-2.6.8-rc2-mm1/include/asm-x86_64/mpspec.h	2004-07-28 10:50:50.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/mpspec.h	2004-07-29 15:08:24.000000000 -0700
@@ -166,7 +166,7 @@ enum mp_bustype {
 };
 extern unsigned char mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
-extern cpumask_t pci_bus_to_cpumask [256];
+extern nodemask_t pci_bus_to_nodemask [256];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern int smp_found_config;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-x86_64/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-x86_64/topology.h	2004-07-28 10:50:50.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/topology.h	2004-07-29 15:09:58.000000000 -0700
@@ -20,15 +20,11 @@ extern cpumask_t     node_to_cpumask[];
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
 
-static inline cpumask_t pcibus_to_cpumask(int bus)
-{
-	cpumask_t res;
-	cpus_and(res,  pci_bus_to_cpumask[bus], cpu_online_map);
-	return res;
-}
-
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 
 
+#define ARCH_HAS_GET_PCIBUS_NODEMASK
+#define get_pcibus_nodemask(bus)	(pci_bus_to_nodemask[bus])
+
 #endif
 
 #include <asm-generic/topology.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/linux/pci.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/linux/pci.h
--- linux-2.6.8-rc2-mm1/include/linux/pci.h	2004-07-28 10:50:51.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/linux/pci.h	2004-07-28 16:58:46.000000000 -0700
@@ -590,6 +590,8 @@ struct pci_bus {
 	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
+	nodemask_t	nodemask;	/* For NUMA systems, we care about which 
+					   node(s) this PCI bus is on/close to. */
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/linux/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/linux/topology.h
--- linux-2.6.8-rc2-mm1/include/linux/topology.h	2004-07-28 16:25:59.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/linux/topology.h	2004-07-29 14:58:43.000000000 -0700
@@ -28,6 +28,7 @@
 #define _LINUX_TOPOLOGY_H
 
 #include <linux/cpumask.h>
+#include <linux/nodemask.h>
 #include <linux/bitops.h>
 #include <linux/mmzone.h>
 #include <linux/smp.h>
@@ -54,6 +55,18 @@ static inline int __next_node_with_cpus(
 #define for_each_node_with_cpus(node) \
 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
+static inline cpumask_t nodemask_to_cpumask(nodemask_t nodemask)
+{
+	cpumask_t ret, tmp;
+	int node;
+	cpus_clear(ret);
+	for_each_node_mask(node, nodemask) {
+		tmp = node_to_cpumask(node);
+		cpus_or(ret, ret, tmp);
+	}
+	return ret;
+}
+
 #ifndef node_distance
 #define node_distance(from,to)	(from != to)
 #endif
@@ -61,4 +74,13 @@ static inline int __next_node_with_cpus(
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
 
+static inline nodemask_t pcibus_to_nodemask(struct pci_bus *bus)
+{
+	return bus->nodemask;
+}
+
+#ifndef ARCH_HAS_GET_PCIBUS_NODEMASK
+#define get_pcibus_nodemask(busnr)		(NODE_MASK_ALL)
+#endif
+
 #endif /* _LINUX_TOPOLOGY_H */


