Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSKLUs0>; Tue, 12 Nov 2002 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSKLUs0>; Tue, 12 Nov 2002 15:48:26 -0500
Received: from holomorphy.com ([66.224.33.161]:47292 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266943AbSKLUsY>;
	Tue, 12 Nov 2002 15:48:24 -0500
Date: Tue, 12 Nov 2002 12:52:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112205241.GS23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	colpatch@us.ibm.com, hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18BaIc-0006Zs-00@holomorphy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:37:46AM -0800, William Lee Irwin III wrote:
> This fixes a longstanding bug with respect to bridge handling as well as
> a Linux PCI faux pas, namely an attempt to support PCI domains with bus
> number mangling.
> The end result is that bridges off of quad 0 now work, and the code now
> follows Linux PCI conventions.
> [1/4] NUMA-Q: use sysdata as quad numbers in pci_scan_bus()"
> [2/4] NUMA-Q: fetch quad numbers from struct pci_bus"
> [3/4] NUMA-Q: use quad numbers passed to low-level config cycles"
> [4/4] NUMA-Q: remove last traces of bus number mangling"

Follow on #1:

[5/4] NUMA-Q: use "quad" instead of node in arch/i386/pci/numa.c


This renames all nonessential uses of the word "quad" in
arch/i386/pci/numa.c with "node".

 numa.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)


diff -urpN pci-2.5.47-4/arch/i386/pci/numa.c pci-2.5.47-5/arch/i386/pci/numa.c
--- pci-2.5.47-4/arch/i386/pci/numa.c	2002-11-12 03:32:13.000000000 -0800
+++ pci-2.5.47-5/arch/i386/pci/numa.c	2002-11-12 12:06:22.000000000 -0800
@@ -6,9 +6,9 @@
 #include <linux/init.h>
 #include "pci.h"
 
-#define BUS2QUAD(global) (mp_bus_id_to_node[global])
+#define BUS2NODE(global) (mp_bus_id_to_node[global])
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
-#define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
+#define NODELOCAL2BUS(node,local) (quad_local_to_mp_bus_id[node][local])
 
 #define __PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
@@ -16,7 +16,7 @@
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	__PCI_CONF1_MQ_ADDRESS(BUS2LOCAL(bus), dev, fn, reg)
 
-static int bus2quad(struct pci_bus *bus)
+static int bus2node(struct pci_bus *bus)
 {
 	return (int)bus->sysdata;
 }
@@ -81,13 +81,13 @@ static int __pci_conf1_mq_write (int seg
 
 static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_conf1_mq_read(bus2quad(bus), bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_read(bus2node(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
 static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_conf1_mq_write(bus2quad(bus), bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_write(bus2node(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
@@ -104,7 +104,7 @@ static void __devinit pci_fixup_i450nx(s
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
-	int quad = bus2quad(d->bus);
+	int node = bus2node(d->bus);
 
 	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
@@ -114,9 +114,9 @@ static void __devinit pci_fixup_i450nx(s
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(busno, pci_root_ops, (void *)quad);	/* Bus A */
+			pci_scan_bus(busno, pci_root_ops, (void *)node);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(suba+1, pci_root_ops, (void *)quad);	/* Bus B */
+			pci_scan_bus(suba+1, pci_root_ops, (void *)node);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -127,7 +127,7 @@ struct pci_fixup pcibios_fixups[] = {
 
 static int __init pci_numa_init(void)
 {
-	int quad;
+	int node;
 
 	pci_root_ops = &pci_direct_conf1_mq;
 
@@ -136,9 +136,9 @@ static int __init pci_numa_init(void)
 
 	pci_root_bus = pcibios_scan_root(0);
 	if (clustered_apic_mode && (numnodes > 1)) {
-		for (quad = 1; quad < numnodes; ++quad) {
-			printk("Scanning PCI bus %d for quad %d\n", 0, quad);
-			pci_scan_bus(0, pci_root_ops, (void *)quad);
+		for (node = 1; node < numnodes; ++node) {
+			printk("Scanning PCI bus %d for node %d\n", 0, node);
+			pci_scan_bus(0, pci_root_ops, (void *)node);
 		}
 	}
 	return 0;
