Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUFCMNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUFCMNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUFCMNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:13:18 -0400
Received: from ozlabs.org ([203.10.76.45]:40599 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263169AbUFCMNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:13:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.5403.663336.997345@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 22:10:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Make ppc32 PCI code more robust
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main thrust of this patch is to make the ppc32 PCI code more
robust by checking for bus->resource[] being NULL before using it.  We
can legitimately get elements of bus->resource being NULL and I have
actually hit that on some machines.  This patch also allows resources
starting at 0 to be accepted as assigned (we can and do get PCI
resources starting at 0 in I/O space on PPC machines) and provides a
sensible default for the case where Open Firmware doesn't give us a
bus-range property for a PCI bridge.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/pci.c pmac-2.5/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-04-01 06:59:36.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/pci.c	2004-06-03 22:02:19.161913200 +1000
@@ -128,7 +128,7 @@
 		struct resource *res = dev->resource + i;
 		if (!res->flags)
 			continue;
-		if (!res->start || res->end == 0xffffffff) {
+		if (res->end == 0xffffffff) {
 			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
 			    pci_name(dev), i, res->start, res->end);
 			res->end -= res->start;
@@ -347,6 +347,8 @@
 		return -1;
 	}
 	res = bus->resource[i];
+	if (res == NULL)
+		return -1;
 	pr = NULL;
 	for (j = 0; j < 4; j++) {
 		struct resource *r = parent->resource[j];
@@ -659,11 +661,11 @@
 		return;
 	bus_range = (int *) get_property(node, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING "Can't get bus-range for %s\n",
-		       node->full_name);
-		return;
-	}
-	pci_to_OF_bus_map[pci_bus] = bus_range[0];
+		printk(KERN_WARNING "Can't get bus-range for %s, "
+		       "assuming it starts at 0\n", node->full_name);
+		pci_to_OF_bus_map[pci_bus] = 0;
+	} else
+		pci_to_OF_bus_map[pci_bus] = bus_range[0];
 
 	for (node=node->child; node != 0;node = node->sibling) {
 		struct pci_dev* dev;
@@ -1073,6 +1075,8 @@
 	u16 w;
 	struct resource res;
 
+	if (bus->resource[0] == NULL)
+		return;
  	res = *(bus->resource[0]);
 
 	DBG("Remapping Bus %d, bridge: %s\n", bus->number, bridge->slot_name);
@@ -1168,7 +1172,8 @@
 	int has_vga = 0;
 
 	for (parent_io=0; parent_io<4; parent_io++)
-		if (bus->resource[parent_io]->flags & IORESOURCE_IO)
+		if (bus->resource[parent_io]
+		    && bus->resource[parent_io]->flags & IORESOURCE_IO)
 			break;
 	if (parent_io >= 4)
 		return;
