Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbSJNXMr>; Mon, 14 Oct 2002 19:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbSJNXMr>; Mon, 14 Oct 2002 19:12:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16612 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262060AbSJNXMp>; Mon, 14 Oct 2002 19:12:45 -0400
Message-ID: <3DAB5011.8070804@us.ibm.com>
Date: Mon, 14 Oct 2002 16:15:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
CC: Martin Bligh <mjbligh@us.ibm.com>, Patrick Mansfield <patmans@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [patch] Add __pcibus_to_node() call to In-Kernel Topology
Content-Type: multipart/mixed;
 boundary="------------010807000609070109000702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807000609070109000702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	This patch adds a new call to the In-Kernel Topology API: pcibus_to_node. 
  This call is used in the NUMAQ PCI code, as well as the pending MPIO 
code and driverfs topology.

Changelog:

1. Add new __pcibus_to_node(bus) call to include/asm-generic/topology.h
2. Implement this call for i386 in include/asm-i386/topology.h
3. Clean up PCI code in arch/i386/pci/numa.c to use this new call.

Please apply.

Cheers!

-Matt

--------------010807000609070109000702
Content-Type: text/plain;
 name="pcibus_to_node-2.5.42.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcibus_to_node-2.5.42.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.42-vanilla/arch/i386/pci/numa.c linux-2.5.42-pcibus_to_node/arch/i386/pci/numa.c
--- linux-2.5.42-vanilla/arch/i386/pci/numa.c	Fri Oct 11 21:21:34 2002
+++ linux-2.5.42-pcibus_to_node/arch/i386/pci/numa.c	Mon Oct 14 16:03:26 2002
@@ -5,13 +5,10 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include "pci.h"
-
-#define BUS2QUAD(global) (mp_bus_id_to_node[global])
-#define BUS2LOCAL(global) (mp_bus_id_to_local[global])
-#define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
+#include <asm/topology.h>
 
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+	(0x80000000 | mp_bus_id_to_local[bus] << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
 static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
@@ -22,17 +19,17 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, __pcibus_to_node(bus));
 
 	switch (len) {
 	case 1:
-		*value = inb_quad(0xCFC + (reg & 3), BUS2QUAD(bus));
+		*value = inb_quad(0xCFC + (reg & 3), __pcibus_to_node(bus));
 		break;
 	case 2:
-		*value = inw_quad(0xCFC + (reg & 2), BUS2QUAD(bus));
+		*value = inw_quad(0xCFC + (reg & 2), __pcibus_to_node(bus));
 		break;
 	case 4:
-		*value = inl_quad(0xCFC, BUS2QUAD(bus));
+		*value = inl_quad(0xCFC, __pcibus_to_node(bus));
 		break;
 	}
 
@@ -50,17 +47,17 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, __pcibus_to_node(bus));
 
 	switch (len) {
 	case 1:
-		outb_quad((u8)value, 0xCFC + (reg & 3), BUS2QUAD(bus));
+		outb_quad((u8)value, 0xCFC + (reg & 3), __pcibus_to_node(bus));
 		break;
 	case 2:
-		outw_quad((u16)value, 0xCFC + (reg & 2), BUS2QUAD(bus));
+		outw_quad((u16)value, 0xCFC + (reg & 2), __pcibus_to_node(bus));
 		break;
 	case 4:
-		outl_quad((u32)value, 0xCFC, BUS2QUAD(bus));
+		outl_quad((u32)value, 0xCFC, __pcibus_to_node(bus));
 		break;
 	}
 
@@ -96,7 +93,7 @@
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
-	int quad = BUS2QUAD(d->bus->number);
+	int quad = __pcibus_to_node(d->bus->number);
 
 	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
@@ -106,9 +103,9 @@
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(quad_local_to_mp_bus_id[quad][busno], pci_root_ops, NULL);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(quad_local_to_mp_bus_id[quad][suba+1], pci_root_ops, NULL);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -130,8 +127,8 @@
 	if (clustered_apic_mode && (numnodes > 1)) {
 		for (quad = 1; quad < numnodes; ++quad) {
 			printk("Scanning PCI bus %d for quad %d\n", 
-				QUADLOCAL2BUS(quad,0), quad);
-			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
+				quad_local_to_mp_bus_id[quad][0], quad);
+			pci_scan_bus(quad_local_to_mp_bus_id[quad][0], 
 				pci_root_ops, NULL);
 		}
 	}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.42-vanilla/include/asm-generic/topology.h linux-2.5.42-pcibus_to_node/include/asm-generic/topology.h
--- linux-2.5.42-vanilla/include/asm-generic/topology.h	Fri Oct 11 21:21:31 2002
+++ linux-2.5.42-pcibus_to_node/include/asm-generic/topology.h	Mon Oct 14 15:49:21 2002
@@ -47,5 +47,8 @@
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)
 #endif
+#ifndef __pcibus_to_node
+#define __pcibus_to_node(bus)		(0)
+#endif
 
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.42-vanilla/include/asm-i386/topology.h linux-2.5.42-pcibus_to_node/include/asm-i386/topology.h
--- linux-2.5.42-vanilla/include/asm-i386/topology.h	Fri Oct 11 21:21:34 2002
+++ linux-2.5.42-pcibus_to_node/include/asm-i386/topology.h	Mon Oct 14 15:58:41 2002
@@ -83,6 +83,9 @@
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
+/* Returns the number of the node containing PCI bus 'bus' */
+#define __pcibus_to_node(bus) (mp_bus_id_to_node[bus])
+
 #else /* !CONFIG_X86_NUMAQ */
 /*
  * Other i386 platforms should define their own version of the 

--------------010807000609070109000702--

