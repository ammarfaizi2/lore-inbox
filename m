Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUG2AHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUG2AHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUG2AHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:07:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45493 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267365AbUG2AH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:07:27 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200407271140.29818.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	 <200407270822.43870.jbarnes@engr.sgi.com>
	 <1090953179.18747.19.camel@arrakis>
	 <200407271140.29818.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091059607.19459.69.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jul 2004 17:06:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 11:40, Jesse Barnes wrote:
> On Tuesday, July 27, 2004 11:32 am, Matthew Dobson wrote:
> > >   ...
> > > #ifdef CONFIG_NUMA
> > >   int node; /* or nodemask_t if necessary */
> > > #endif
> > >   ...
> > >
> > > to struct pci_bus instead?  That would make the existing code paths a
> > > little faster and avoid the need for a global array, which tends to lead
> > > to TLB misses.
> >
> > I like that idea!  Stick a nodemask_t in struct pci_bus, initialize it
> > to NODE_MASK_ALL.  If a particular arch wants to put something more
> > accurate in there, then great, if not, we're just in the same boat we're
> > in now.
> 
> Cool, sounds like that'll work well.

Ok, so I'm no longer convinced that this will work as well as I once
thought.  It's pretty trivial to add a nodemask_t to the struct pci_bus,
and even initialize it to a reasonable value (ie: NODE_MASK_ALL) since
there's the convenient pci_alloc_bus() function in drivers/pci/probe.c. 
The problem is where to put hooks for individual arches to put the
*real* nodemask in this field...  My only thought right now is to create
a per-arch callback function, arch_get_pcibus_nodemask() or something,
and use the value it returns to populate pci_bus->nodemask.  We would
have to call this function anywhere a struct pci_bus is allocated, and
probably pass along the PCI bus number so the arch could determine which
nodes it belongs to.  Would that work for everyone that cares?  We could
overload that to return NODE_MASK_ALL for non-NUMA systems, and have it
do the right thing for arches that care...

Current, nowhere near complete patch attached...

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/arch/x86_64/kernel/mpparse.c linux-2.6.8-rc2-mm1+pcibus_to_nodemask/arch/x86_64/kernel/mpparse.c
--- linux-2.6.8-rc2-mm1/arch/x86_64/kernel/mpparse.c	2004-07-28 10:50:34.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/arch/x86_64/kernel/mpparse.c	2004-07-28 16:23:50.000000000 -0700
@@ -44,7 +44,6 @@ int acpi_found_madt;
 int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-cpumask_t pci_bus_to_cpumask [256] = { [0 ... 255] = CPU_MASK_ALL };
 
 int mp_current_pci_id = 0;
 /* I/O APIC entries */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/drivers/pci/probe.c linux-2.6.8-rc2-mm1+pcibus_to_nodemask/drivers/pci/probe.c
--- linux-2.6.8-rc2-mm1/drivers/pci/probe.c	2004-07-28 10:49:45.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/drivers/pci/probe.c	2004-07-28 17:00:30.000000000 -0700
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
@@ -270,6 +270,7 @@ static struct pci_bus * __devinit pci_al
 		INIT_LIST_HEAD(&b->node);
 		INIT_LIST_HEAD(&b->children);
 		INIT_LIST_HEAD(&b->devices);
+		b->nodemask = NODE_MASK_ALL;
 	}
 	return b;
 }
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
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-i386/topology.h	2004-07-28 16:29:35.000000000 -0700
@@ -60,12 +60,6 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(mask);
 }
 
-/* Returns the number of the node containing PCI bus 'bus' */
-static inline cpumask_t pcibus_to_cpumask(int bus)
-{
-	return node_to_cpumask(mp_bus_id_to_node[bus]);
-}
-
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
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/mpspec.h	2004-07-28 16:27:01.000000000 -0700
@@ -166,7 +166,6 @@ enum mp_bustype {
 };
 extern unsigned char mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
-extern cpumask_t pci_bus_to_cpumask [256];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern int smp_found_config;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-x86_64/topology.h linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/topology.h
--- linux-2.6.8-rc2-mm1/include/asm-x86_64/topology.h	2004-07-28 10:50:50.000000000 -0700
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/asm-x86_64/topology.h	2004-07-28 16:30:17.000000000 -0700
@@ -20,13 +20,6 @@ extern cpumask_t     node_to_cpumask[];
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
 
 #endif
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
+++ linux-2.6.8-rc2-mm1+pcibus_to_nodemask/include/linux/topology.h	2004-07-28 17:00:26.000000000 -0700
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
@@ -61,4 +74,9 @@ static inline int __next_node_with_cpus(
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
 
+static inline nodemask_t pcibus_to_nodemask(struct pci_bus *bus)
+{
+	return bus->nodemask;
+}
+
 #endif /* _LINUX_TOPOLOGY_H */


