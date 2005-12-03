Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVLCBkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLCBkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLCBkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:40:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:45216 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751137AbVLCBkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:40:06 -0500
Date: Fri, 2 Dec 2005 20:40:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ak@suse.de
Subject: [PATCH 2/3] x86 PCI domain support: struct pci_sysdata
Message-ID: <20051203014006.GB2663@havoc.gtf.org>
References: <20051203013904.GA2560@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203013904.GA2560@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



commit a5e17f3017ae2a4bd10454057bf63bd56bdd506c
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri Dec 2 20:12:52 2005 -0500

    [x86, PCI] Switch pci_bus::sysdata from NUMA node integer to a pointer
    
    On x86[-64], struct pci_bus::sysdata is only used on NUMA platforms,
    to store the associated NUMA node.
    
    Preparing for the future when we'll want to do other things with
    sysdata, struct pci_sysdata was created.  An allocated structure
    replaces the cast-pointer-to-int NUMA usage.  Updated all NUMA users.

 arch/i386/pci/acpi.c          |    7 ++++---
 arch/i386/pci/common.c        |   13 ++++++++++++-
 arch/x86_64/pci/k8-bus.c      |    6 +++++-
 include/asm-i386/pci.h        |    5 +++++
 include/asm-i386/topology.h   |    2 +-
 include/asm-x86_64/pci.h      |    4 ++++
 include/asm-x86_64/topology.h |    2 +-
 7 files changed, 32 insertions(+), 7 deletions(-)


a5e17f3017ae2a4bd10454057bf63bd56bdd506c
diff --git a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
index 4c4522b..107b18d 100644
--- a/arch/i386/pci/acpi.c
+++ b/arch/i386/pci/acpi.c
@@ -19,9 +19,10 @@ struct pci_bus * __devinit pci_acpi_scan
 	if (bus != NULL) {
 		int pxm = acpi_get_pxm(device->handle);
 		if (pxm >= 0) {
-			bus->sysdata = (void *)(unsigned long)pxm_to_node(pxm);
-			printk("bus %d -> pxm %d -> node %ld\n",
-				busnum, pxm, (long)(bus->sysdata));
+			struct pci_sysdata *sd = bus->sysdata;
+			sd->node = pxm_to_node(pxm);
+			printk("bus %d -> pxm %d -> node %d\n",
+				busnum, pxm, sd->node);
 		}
 	}
 #endif
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index 6a18a8a..ab48fc7 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -126,6 +126,7 @@ void __devinit  pcibios_fixup_bus(struct
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus = NULL;
+	struct pci_sysdata *sd;
 
 	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		if (bus->number == busnum) {
@@ -134,9 +135,19 @@ struct pci_bus * __devinit pcibios_scan_
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
index 78c8598..f56a158 100644
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -4,6 +4,11 @@
 #include <linux/config.h>
 
 #ifdef __KERNEL__
+
+struct pci_sysdata {
+	int		node;		/* NUMA node */
+};
+
 #include <linux/mm.h>		/* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/include/asm-i386/topology.h b/include/asm-i386/topology.h
index 0ec27c9..4dc8580 100644
--- a/include/asm-i386/topology.h
+++ b/include/asm-i386/topology.h
@@ -60,7 +60,7 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(mask);
 }
 
-#define pcibus_to_node(bus) ((long) (bus)->sysdata)
+#define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))->node
 #define pcibus_to_cpumask(bus) node_to_cpumask(pcibus_to_node(bus))
 
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
index eeb3088..424c1ee 100644
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -6,6 +6,10 @@
 
 #ifdef __KERNEL__
 
+struct pci_sysdata {
+	int		node;		/* NUMA node */
+};
+
 #include <linux/mm.h> /* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/include/asm-x86_64/topology.h b/include/asm-x86_64/topology.h
index d39ebd5..0d1d61c 100644
--- a/include/asm-x86_64/topology.h
+++ b/include/asm-x86_64/topology.h
@@ -25,7 +25,7 @@ extern int __node_distance(int, int);
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
-#define pcibus_to_node(bus)		((long)(bus->sysdata))	
+#define pcibus_to_node(bus)	((struct pci_sysdata *)((bus)->sysdata))->node
 #define pcibus_to_cpumask(bus)		node_to_cpumask(pcibus_to_node(bus));
 
 #define numa_node_id()			read_pda(nodenumber)
