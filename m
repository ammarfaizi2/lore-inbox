Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129579AbQKSGGc>; Sun, 19 Nov 2000 01:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQKSGGW>; Sun, 19 Nov 2000 01:06:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129579AbQKSGGO>; Sun, 19 Nov 2000 01:06:14 -0500
Date: Sat, 18 Nov 2000 21:36:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Ford <david@linux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A1765D6.C1E45E36@linux.com>
Message-ID: <Pine.LNX.4.10.10011182133240.3061-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, David Ford wrote:
> Linus Torvalds wrote:
> 
> > Can you (you've probably done this before, but anyway) enable DEBUG in
> > arch/i386/kernel/pci-i386.h? I wonder if the kernel for some strange
> > reason doesn't find your router, even though "dump_pirq" obviously does..
> > If there's something wrong with the checksumming for example..
> 
> ..building now.

Actually, try this patch first. It adds the PCI_DEVICE_ID_INTEL_82371MX
router type, and also makes the PCI router search fall back more
gracefully on the device it actually found if there is not an exact match
on the "compatible router" entry...

It should make Linux find and accept the chip you have. Knock wood.

		Linus

--- v2.4.0-test10/linux/arch/i386/kernel/pci-irq.c	Tue Oct 31 12:42:26 2000
+++ linux/arch/i386/kernel/pci-irq.c	Sat Nov 18 21:11:19 2000
@@ -283,12 +297,19 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
+
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
+
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set },
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set },
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set },
+
 	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },
+
+	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
+
 	{ "default", 0, 0, NULL, NULL }
 };
 
@@ -298,7 +319,6 @@
 static void __init pirq_find_router(void)
 {
 	struct irq_routing_table *rt = pirq_table;
-	u16 rvendor, rdevice;
 	struct irq_router *r;
 
 #ifdef CONFIG_PCI_BIOS
@@ -308,32 +328,31 @@
 		return;
 	}
 #endif
-	if (!(pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn))) {
+	/* fall back to default router if nothing else found */
+	pirq_router = pirq_routers + sizeof(pirq_routers) / sizeof(pirq_routers[0]) - 1;
+
+	pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
+	if (!pirq_router_dev) {
 		DBG("PCI: Interrupt router not found at %02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		/* fall back to default router */
-		pirq_router = pirq_routers + sizeof(pirq_routers) / sizeof(pirq_routers[0]) - 1;
 		return;
 	}
-	if (rt->rtr_vendor) {
-		rvendor = rt->rtr_vendor;
-		rdevice = rt->rtr_device;
-	} else {
-		/*
-		 * Several BIOSes forget to set the router type. In such cases, we
-		 * use chip vendor/device. This doesn't guarantee us semantics of
-		 * PIRQ values, but was found to work in practice and it's still
-		 * better than not trying.
-		 */
-		DBG("PCI: Guessed interrupt router ID from %s\n", pirq_router_dev->slot_name);
-		rvendor = pirq_router_dev->vendor;
-		rdevice = pirq_router_dev->device;
-	}
-	for(r=pirq_routers; r->vendor; r++)
-		if (r->vendor == rvendor && r->device == rdevice)
+
+	for(r=pirq_routers; r->vendor; r++) {
+		/* Exact match against router table entry? Use it! */
+		if (r->vendor == rt->rtr_vendor && r->device == rt->rtr_device) {
+			pirq_router = r;
 			break;
-	pirq_router = r;
-	printk("PCI: Using IRQ router %s [%04x/%04x] at %s\n", r->name,
-	       rvendor, rdevice, pirq_router_dev->slot_name);
+		}
+		/* Match against router device entry? Use it as a fallback */
+		if (r->vendor == pirq_router_dev->vendor && r->device == pirq_router_dev->device) {
+			pirq_router = r;
+		}
+	}
+	printk("PCI: Using IRQ router %s [%04x/%04x] at %s\n",
+		pirq_router->name,
+		pirq_router_dev->vendor,
+		pirq_router_dev->device,
+		pirq_router_dev->slot_name);
 }
 
 static struct irq_info *pirq_get_info(struct pci_dev *dev, int pin)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
