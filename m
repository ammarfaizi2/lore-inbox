Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbSKLV1q>; Tue, 12 Nov 2002 16:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSKLV1q>; Tue, 12 Nov 2002 16:27:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27889 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266965AbSKLV1n>;
	Tue, 12 Nov 2002 16:27:43 -0500
Message-ID: <3DD172B8.8040802@us.ibm.com>
Date: Tue, 12 Nov 2002 13:29:28 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------020404030403070708020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404030403070708020008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bill,
	I know I just sent this to you, but I've been meaning to repost this to 
lkml anyway.  Here's something I wanted to add to the generic topology 
infrastructure for a while.  pcibus_to_node()

Have a look at this patch, and see if it might be useful to you, ok?

Cheers!

-Matt

William Lee Irwin III wrote:
> On Tue, Nov 12, 2002 at 04:37:46AM -0800, William Lee Irwin III wrote:
> 
>>This fixes a longstanding bug with respect to bridge handling as well as
>>a Linux PCI faux pas, namely an attempt to support PCI domains with bus
>>number mangling.
>>The end result is that bridges off of quad 0 now work, and the code now
>>follows Linux PCI conventions.
>>[1/4] NUMA-Q: use sysdata as quad numbers in pci_scan_bus()"
>>[2/4] NUMA-Q: fetch quad numbers from struct pci_bus"
>>[3/4] NUMA-Q: use quad numbers passed to low-level config cycles"
>>[4/4] NUMA-Q: remove last traces of bus number mangling"
> 
> 
> Follow on #1:
> 
> [5/4] NUMA-Q: use "quad" instead of node in arch/i386/pci/numa.c
> 
> 
> This renames all nonessential uses of the word "quad" in
> arch/i386/pci/numa.c with "node".
> 
>  numa.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
 >
 > <snip>
 >

--------------020404030403070708020008
Content-Type: text/plain;
 name="pcibus_to_node-2.5.47.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcibus_to_node-2.5.47.patch"

diff -Nur linux-2.5.47-vanilla/arch/i386/pci/numa.c linux-2.5.47-pcibus_to_node/arch/i386/pci/numa.c
--- linux-2.5.47-vanilla/arch/i386/pci/numa.c	Sun Nov 10 19:28:06 2002
+++ linux-2.5.47-pcibus_to_node/arch/i386/pci/numa.c	Tue Nov 12 13:25:15 2002
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
diff -Nur linux-2.5.47-vanilla/include/asm-generic/topology.h linux-2.5.47-pcibus_to_node/include/asm-generic/topology.h
--- linux-2.5.47-vanilla/include/asm-generic/topology.h	Sun Nov 10 19:28:04 2002
+++ linux-2.5.47-pcibus_to_node/include/asm-generic/topology.h	Tue Nov 12 13:25:15 2002
@@ -47,5 +47,8 @@
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)
 #endif
+#ifndef __pcibus_to_node
+#define __pcibus_to_node(bus)		(0)
+#endif
 
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -Nur linux-2.5.47-vanilla/include/asm-i386/topology.h linux-2.5.47-pcibus_to_node/include/asm-i386/topology.h
--- linux-2.5.47-vanilla/include/asm-i386/topology.h	Sun Nov 10 19:28:05 2002
+++ linux-2.5.47-pcibus_to_node/include/asm-i386/topology.h	Tue Nov 12 13:25:15 2002
@@ -83,6 +83,9 @@
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
+/* Returns the number of the node containing PCI bus 'bus' */
+#define __pcibus_to_node(bus) (mp_bus_id_to_node[bus])
+
 #else /* !CONFIG_X86_NUMAQ */
 /*
  * Other i386 platforms should define their own version of the 

--------------020404030403070708020008--

