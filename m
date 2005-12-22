Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVLVVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVLVVGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVLVVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:06:42 -0500
Received: from cpc2-lanc3-5-1-cust221.brig.cable.ntl.com ([86.14.33.221]:34265
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030320AbVLVVGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:06:42 -0500
Date: Thu, 22 Dec 2005 21:06:28 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, greg@kroah.com, mbligh@google.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: [PATCH] pci device ensure sysdata initialised
Message-ID: <20051222210628.GA16797@shadowen.org>
References: <20051220151609.565160d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20051220151609.565160d9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci device ensure sysdata initialised

[Ok, here is a patch to ensure sysdata is valid for all busses.]

We have been seeing panic's on NUMA systems in pci_call_probe() in
2.6.15-rc5-mm2 and -mm3.  It seems that some changes have occured
to the meaning of the 'sysdata' for a device such that it is no
longer just an integer containing the node, it is now a structure
containing the node and other data.  However, it seems that we do not
always initialise this sysdata before we probe the device.

Below are three examples from a boot with this checked for.
The attached patch ensures that we supply a valid sysdata for system
busses.  Currently we take no account of the node for this bus for
no ACPI configured systems.  This is unchanged from the -mm1 code.

	Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
	Copyright (c) 1999-2005 Intel Corporation.
	pci_call_probe: starting drv<c03d4be0> dev<dfd16800> id<c03d4734>
	pci_call_probe: dev->bus<dfce6800>
	pci_call_probe: dev->bus->sysdata<00000000>
	pci_call_probe: node<-1>
	e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

	pci_call_probe: starting drv<c03ef220> dev<dfd17400> id<c03eed00>
	pci_call_probe: dev->bus<dfce6800>
	pci_call_probe: dev->bus->sysdata<00000000>
	pci_call_probe: node<-1>
	Linux Tulip driver version 1.1.13 (December 15, 2004)
	input: AT Translated Set 2 keyboard as /class/input/input0
	tulip0:  EEPROM default media type Autosense.
	tulip0:  Index #0 - Media 10baseT (#0) described by a
		21140 non-MII (0) block.
	tulip0:  Index #1 - Media 100baseTx (#3) described by a
		21140 non-MII (0) block.
	tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a
		21140 non-MII (0) block.
	tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a
		21140 non-MII (0) block.
	eth1: Digital DS21140 Tulip rev 33 at 0001fc00,
		00:00:BC:0F:08:96, IRQ 28.

	pci_call_probe: starting drv<c040a360> dev<dfd14400> id<c040a0fc>
	pci_call_probe: dev->bus<dfce6600>
	pci_call_probe: dev->bus->sysdata<dfffafa0>
	pci_call_probe: node<0>
	qla1280: QLA1040 found on PCI bus 0, dev 11

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 arch/i386/pci/common.c |    2 ++
 arch/i386/pci/fixup.c  |    8 +++++---
 arch/i386/pci/legacy.c |    3 ++-
 arch/i386/pci/numa.c   |    8 +++++---
 arch/i386/pci/visws.c  |    4 ++--
 include/asm-i386/pci.h |    1 +
 6 files changed, 17 insertions(+), 9 deletions(-)
diff -upN reference/arch/i386/pci/common.c current/arch/i386/pci/common.c
--- reference/arch/i386/pci/common.c
+++ current/arch/i386/pci/common.c
@@ -29,6 +29,8 @@ unsigned long pirq_table_addr;
 struct pci_bus *pci_root_bus;
 struct pci_raw_ops *raw_pci_ops;
 
+struct pci_sysdata pci_default_sysdata = { .node = -1 };
+
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
diff -upN reference/arch/i386/pci/fixup.c current/arch/i386/pci/fixup.c
--- reference/arch/i386/pci/fixup.c
+++ current/arch/i386/pci/fixup.c
@@ -25,9 +25,11 @@ static void __devinit pci_fixup_i450nx(s
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(busno, &pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(busno, &pci_root_ops,
+					&pci_default_sysdata);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(suba+1, &pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(suba+1, &pci_root_ops,
+					&pci_default_sysdata);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -42,7 +44,7 @@ static void __devinit pci_fixup_i450gx(s
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
 	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", pci_name(d), busno);
-	pci_scan_bus(busno, &pci_root_ops, NULL);
+	pci_scan_bus(busno, &pci_root_ops, &pci_default_sysdata);
 	pcibios_last_bus = -1;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454GX, pci_fixup_i450gx);
diff -upN reference/arch/i386/pci/legacy.c current/arch/i386/pci/legacy.c
--- reference/arch/i386/pci/legacy.c
+++ current/arch/i386/pci/legacy.c
@@ -26,7 +26,8 @@ static void __devinit pcibios_fixup_peer
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, devfn, l);
 				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
-				pci_scan_bus(n, &pci_root_ops, NULL);
+				pci_scan_bus(n, &pci_root_ops, 
+						&pci_default_sysdata);
 				break;
 			}
 		}
diff -upN reference/arch/i386/pci/numa.c current/arch/i386/pci/numa.c
--- reference/arch/i386/pci/numa.c
+++ current/arch/i386/pci/numa.c
@@ -97,9 +97,11 @@ static void __devinit pci_fixup_i450nx(s
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), &pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(QUADLOCAL2BUS(quad,busno), &pci_root_ops,
+					&pci_default_sysdata);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), &pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), &pci_root_ops,
+					&pci_default_sysdata);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -124,7 +126,7 @@ static int __init pci_numa_init(void)
 			printk("Scanning PCI bus %d for quad %d\n", 
 				QUADLOCAL2BUS(quad,0), quad);
 			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				&pci_root_ops, NULL);
+				&pci_root_ops, &pci_default_sysdata);
 		}
 	return 0;
 }
diff -upN reference/arch/i386/pci/visws.c current/arch/i386/pci/visws.c
--- reference/arch/i386/pci/visws.c
+++ current/arch/i386/pci/visws.c
@@ -102,8 +102,8 @@ static int __init pcibios_init(void)
 		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);
 
 	raw_pci_ops = &pci_direct_conf1;
-	pci_scan_bus(pci_bus0, &pci_root_ops, NULL);
-	pci_scan_bus(pci_bus1, &pci_root_ops, NULL);
+	pci_scan_bus(pci_bus0, &pci_root_ops, &pci_default_sysdata);
+	pci_scan_bus(pci_bus1, &pci_root_ops, &pci_default_sysdata);
 	pci_fixup_irqs(visws_swizzle, visws_map_irq);
 	pcibios_resource_survey();
 	return 0;
diff -upN reference/include/asm-i386/pci.h current/include/asm-i386/pci.h
--- reference/include/asm-i386/pci.h
+++ current/include/asm-i386/pci.h
@@ -9,6 +9,7 @@ struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 };
+extern struct pci_sysdata pci_default_sysdata;
 
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
