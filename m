Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992501AbWKAOlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992501AbWKAOlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992511AbWKAOlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:41:51 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:27104
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S2992501AbWKAOlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:41:50 -0500
Date: Wed, 1 Nov 2006 14:37:46 +0000
To: jgarzik@pobox.com, Greg KH <gregkh@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@mbligh.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sukadev@us.ibm.com
Subject: [PATCH] pci device ensure sysdata initialised v2
Message-ID: <2026c73e8887d52443f750c2885a9f2e@pinky>
References: <20061020173757.GA21427@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20061020173757.GA21427@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've gone over the patches and retested them.  Other than having
to extend them to cover x86_64 they still seem to work as planned.  I
have updated the commentry to better explain the problem and the
fix as encapsulated here.

When this was proposed last time there was push back to get the
nodes right.  Whist this is clearly a good thing, I think we need
this as a first step if the underlying patches are going to stay
in.

-apw
=== 8< ===
pci device ensure sysdata initialised v2

We have been seeing panic's on NUMA systems in pci_call_probe() in
2.6.19-rc1-mm1 and later.  This is related to the changes introduced
in the commit below:

    [x86, PCI] Switch pci_bus::sysdata from NUMA node integer to a pointer
    0a247a58fc3e2ecfc17654301033e8b8d08df2a2

In this change the sysdata has changed from directly representing
a value (the node number in NUMA) to a pointer to a structure.
However, it seems that we do not always initialise this sysdata
before we probe the device.

Prior to the changes above the node was defaulted to 'NULL'
allocating the devices to node 0 unconditionally.  This patch adds
a default sysdata entry (pci_default_sysdata), this is then used
where 'NULL' was used previously.  pci_default_sysdata defaults
the node to unknown (-1).  This is a more accurate assignment,
mirroring the value returned where no topology support is provided
and no locality information is available.

There are only two uses of this value in the affected architectures
(x86, x86_64) and generic code:

1) in x86_64, dma_alloc_pages() looks up the node in order to
   allocate node local memory.  Here if the node is invalid we
   will default to the first online node.  Behaviour here should
   be unchanged.
2) in generic, pci_call_probe() looks up the node in order to
   restrict execution of the probe on the card local node, to
   favor node local allocation.  Where this is unknown previously
   we would force execution (and thereby allocation) to node 0,
   this is arguably wrong and using -1 releases this restriction.

In an ideal world we should be supplying a sysdata for the
appropriate node where it is known.  Where it is not known defaulting
to -1 seems a better course, and would help us where node 0 is
short of memory.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index aa0ac44..d3b8feb 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -27,6 +27,8 @@ unsigned long pirq_table_addr;
 struct pci_bus *pci_root_bus;
 struct pci_raw_ops *raw_pci_ops;
 
+struct pci_sysdata pci_default_sysdata = { .node = -1 };
+
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index 2bcd0a4..1ba35b3 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
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
diff --git a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
index 149a958..b076b25 100644
--- a/arch/i386/pci/legacy.c
+++ b/arch/i386/pci/legacy.c
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
diff --git a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
index adbe17a..8d2fd6c 100644
--- a/arch/i386/pci/numa.c
+++ b/arch/i386/pci/numa.c
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
diff --git a/arch/i386/pci/visws.c b/arch/i386/pci/visws.c
index f1b486d..2539371 100644
--- a/arch/i386/pci/visws.c
+++ b/arch/i386/pci/visws.c
@@ -101,8 +101,8 @@ static int __init pcibios_init(void)
 		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);
 
 	raw_pci_ops = &pci_direct_conf1;
-	pci_scan_bus(pci_bus0, &pci_root_ops, NULL);
-	pci_scan_bus(pci_bus1, &pci_root_ops, NULL);
+	pci_scan_bus(pci_bus0, &pci_root_ops, &pci_default_sysdata);
+	pci_scan_bus(pci_bus1, &pci_root_ops, &pci_default_sysdata);
 	pci_fixup_irqs(visws_swizzle, visws_map_irq);
 	pcibios_resource_survey();
 	return 0;
diff --git a/include/asm-i386/pci.h b/include/asm-i386/pci.h
index 2c8b5e9..d280b7f 100644
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -8,6 +8,7 @@ struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 };
+extern struct pci_sysdata pci_default_sysdata;
 
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
index 550207f..5dc9aa5 100644
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -10,6 +10,7 @@ struct pci_sysdata {
 	int		node;		/* NUMA node */
 	void*		iommu;		/* IOMMU private data */
 };
+extern struct pci_sysdata pci_default_sysdata;
 
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
