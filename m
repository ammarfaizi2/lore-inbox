Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWIZTPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWIZTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWIZTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:15:15 -0400
Received: from havoc.gtf.org ([69.61.125.42]:3490 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932480AbWIZTPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:15:13 -0400
Date: Tue, 26 Sep 2006 15:15:08 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86[-64] PCI domain support
Message-ID: <20060926191508.GA6350@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The x86[-64] PCI domain effort needs to be restarted, because we've got
machines out in the field that need this in order for some devices to
work.

RHEL is shipping it now, apparently without any problems.

The 'pciseg' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git pciseg

to receive the following updates:

 arch/i386/pci/acpi.c          |   25 +++++++++++++++++++++----
 arch/i386/pci/common.c        |   19 ++++++++++++++++---
 arch/x86_64/pci/k8-bus.c      |    6 +++++-
 include/asm-i386/pci.h        |   19 +++++++++++++++++++
 include/asm-i386/topology.h   |    2 +-
 include/asm-x86_64/pci.h      |   18 ++++++++++++++++++
 include/asm-x86_64/topology.h |    2 +-
 7 files changed, 81 insertions(+), 10 deletions(-)

Jeff Garzik:
      [x86, PCI] pass PCI domain number to PCI config read/write hooks
      [x86, PCI] Switch pci_bus::sysdata from NUMA node integer to a pointer
      [x86, PCI] add PCI domain support

diff --git a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
index b33aea8..e4f4828 100644
--- a/arch/i386/pci/acpi.c
+++ b/arch/i386/pci/acpi.c
@@ -8,20 +8,37 @@ #include "pci.h"
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
 {
 	struct pci_bus *bus;
+	struct pci_sysdata *sd;
 
+	/* Allocate per-root-bus (not per bus) arch-specific data.
+	 * TODO: leak; this memory is never freed.
+	 * It's arguable whether it's worth the trouble to care.
+	 */
+	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd) {
+		printk(KERN_ERR "PCI: OOM, not probing PCI bus %02x\n", busnum);
+		return NULL;
+	}
+
+#ifdef CONFIG_PCI_DOMAINS
+	sd->domain = domain;
+#else
 	if (domain != 0) {
 		printk(KERN_WARNING "PCI: Multiple domains not supported\n");
 		return NULL;
 	}
+#endif /* CONFIG_PCI_DOMAINS */
 
-	bus = pcibios_scan_root(busnum);
+	bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
+	if (!bus)
+		kfree(sd);
 #ifdef CONFIG_ACPI_NUMA
 	if (bus != NULL) {
 		int pxm = acpi_get_pxm(device->handle);
 		if (pxm >= 0) {
-			bus->sysdata = (void *)(unsigned long)pxm_to_node(pxm);
-			printk("bus %d -> pxm %d -> node %ld\n",
-				busnum, pxm, (long)(bus->sysdata));
+			sd->node = pxm_to_node(pxm);
+			printk("bus %d -> pxm %d -> node %d\n",
+				busnum, pxm, sd->node);
 		}
 	}
 #endif
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index 0a362e3..21bf223 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -28,12 +28,14 @@ struct pci_raw_ops *raw_pci_ops;
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return raw_pci_ops->read(0, bus->number, devfn, where, size, value);
+	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
+				 devfn, where, size, value);
 }
 
 static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
+	return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
+				  devfn, where, size, value);
 }
 
 struct pci_ops pci_root_ops = {
@@ -150,6 +152,7 @@ #endif		/* __i386__ */
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus = NULL;
+	struct pci_sysdata *sd;
 
 	dmi_check_system(pciprobe_dmi_table);
 
@@ -160,9 +163,19 @@ struct pci_bus * __devinit pcibios_scan_
 		}
 	}
 
+	/* Allocate per-root-bus (not per bus) arch-specific data.
+	 * TODO: leak; this memory is never freed.
+	 * It's arguable whether it's worth the trouble to care.
+	 */
+	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd) {
+		printk(KERN_ERR "PCI: OOM, not probing PCI bus %02x\n", busnum);
+		return NULL;
+	}
+
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
 
-	return pci_scan_bus_parented(NULL, busnum, &pci_root_ops, NULL);
+	return pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
 }
 
 extern u8 pci_cache_line_size;
diff --git a/arch/x86_64/pci/k8-bus.c b/arch/x86_64/pci/k8-bus.c
index 3acf60d..9cc813e 100644
--- a/arch/x86_64/pci/k8-bus.c
+++ b/arch/x86_64/pci/k8-bus.c
@@ -59,6 +59,8 @@ fill_mp_bus_to_cpumask(void)
 				     j <= SUBORDINATE_LDT_BUS_NUMBER(ldtbus);
 				     j++) { 
 					struct pci_bus *bus;
+					struct pci_sysdata *sd;
+
 					long node = NODE_ID(nid);
 					/* Algorithm a bit dumb, but
  					   it shouldn't matter here */
@@ -67,7 +69,9 @@ fill_mp_bus_to_cpumask(void)
 						continue;
 					if (!node_online(node))
 						node = 0;
-					bus->sysdata = (void *)node;
+
+					sd = bus->sysdata;
+					sd->node = node;
 				}		
 			}
 		}
diff --git a/include/asm-i386/pci.h b/include/asm-i386/pci.h
index 64b6d0b..2c8b5e9 100644
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -3,6 +3,25 @@ #define __i386_PCI_H
 
 
 #ifdef __KERNEL__
+
+struct pci_sysdata {
+	int		domain;		/* PCI domain */
+	int		node;		/* NUMA node */
+};
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
 #include <linux/mm.h>		/* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/include/asm-i386/topology.h b/include/asm-i386/topology.h
index 6adbd9b..9234497 100644
--- a/include/asm-i386/topology.h
+++ b/include/asm-i386/topology.h
@@ -67,7 +67,7 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(mask);
 }
 
-#define pcibus_to_node(bus) ((long) (bus)->sysdata)
+#define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))->node
 #define pcibus_to_cpumask(bus) node_to_cpumask(pcibus_to_node(bus))
 
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
index 49c5e92..e7a863c 100644
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -5,6 +5,24 @@ #include <asm/io.h>
 
 #ifdef __KERNEL__
 
+struct pci_sysdata {
+	int		domain;		/* PCI domain */
+	int		node;		/* NUMA node */
+};
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
 #include <linux/mm.h> /* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/include/asm-x86_64/topology.h b/include/asm-x86_64/topology.h
index 6e7a2e9..cd24646 100644
--- a/include/asm-x86_64/topology.h
+++ b/include/asm-x86_64/topology.h
@@ -22,7 +22,7 @@ #define cpu_to_node(cpu)		(cpu_to_node[c
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(first_cpu(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
-#define pcibus_to_node(bus)		((long)(bus->sysdata))	
+#define pcibus_to_node(bus)	((struct pci_sysdata *)((bus)->sysdata))->node
 #define pcibus_to_cpumask(bus)		node_to_cpumask(pcibus_to_node(bus));
 
 #define numa_node_id()			read_pda(nodenumber)
