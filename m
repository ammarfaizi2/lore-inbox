Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTFHQaX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 12:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFHQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 12:30:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262486AbTFHQaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 12:30:14 -0400
Date: Sun, 8 Jun 2003 17:43:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408203824.A27019@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Picking up this loose thread, here's a reimplementation of PCI domain
support.

 - Use pci_domain_nr() macro to determine which domain a bus or device
   is in.
 - Default implementation for architectures which don't support PCI
   domains.
 - Implementation for ia64.

I envisage ia64 will always turn on CONFIG_PCI_DOMAINS but x86 might
well have it as a user question.  I suspect most architectures would
never turn it on (yeah, I'm going to design an embedded ARM box with
multiple PCI domains.  sure.)

Index: arch/ia64/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/Kconfig,v
retrieving revision 1.12
diff -u -p -r1.12 Kconfig
--- arch/ia64/Kconfig	27 May 2003 17:21:18 -0000	1.12
+++ arch/ia64/Kconfig	8 Jun 2003 16:27:35 -0000
@@ -543,6 +543,10 @@ config PCI
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 source "drivers/pci/Kconfig"
 
 config HOTPLUG
Index: arch/ia64/hp/common/sba_iommu.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/hp/common/sba_iommu.c,v
retrieving revision 1.7
diff -u -p -r1.7 sba_iommu.c
--- arch/ia64/hp/common/sba_iommu.c	27 May 2003 17:21:18 -0000	1.7
+++ arch/ia64/hp/common/sba_iommu.c	8 Jun 2003 16:06:36 -0000
@@ -1889,7 +1889,7 @@ sba_connect_bus(struct pci_bus *bus)
 		handle = parent;
 	} while (ACPI_SUCCESS(status));
 
-	printk(KERN_WARNING "No IOC for PCI Bus %02x:%02x in ACPI\n", PCI_SEGMENT(bus), bus->number);
+	printk(KERN_WARNING "No IOC for PCI Bus %04x:%02x in ACPI\n", pci_domain_nr(bus), bus->number);
 }
 
 static int __init
Index: arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/pci/pci.c,v
retrieving revision 1.7
diff -u -p -r1.7 pci.c
--- arch/ia64/pci/pci.c	27 May 2003 17:21:22 -0000	1.7
+++ arch/ia64/pci/pci.c	8 Jun 2003 16:05:53 -0000
@@ -87,14 +87,14 @@ __pci_sal_write (int seg, int bus, int d
 static int
 pci_sal_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_sal_read(PCI_SEGMENT(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
+	return __pci_sal_read(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
 			      where, size, value);
 }
 
 static int
 pci_sal_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_sal_write(PCI_SEGMENT(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
+	return __pci_sal_write(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
 			       where, size, value);
 }
 
Index: drivers/pci/probe.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/pci/probe.c,v
retrieving revision 1.14
diff -u -p -r1.14 probe.c
--- drivers/pci/probe.c	27 May 2003 17:25:03 -0000	1.14
+++ drivers/pci/probe.c	8 Jun 2003 16:36:59 -0000
@@ -528,7 +528,8 @@ pci_scan_device(struct pci_bus *bus, int
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	strcpy(dev->dev.bus_id,dev->slot_name);
+	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
+			dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
Index: include/asm-ia64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-ia64/pci.h,v
retrieving revision 1.7
diff -u -p -r1.7 pci.h
--- include/asm-ia64/pci.h	27 May 2003 17:28:04 -0000	1.7
+++ include/asm-ia64/pci.h	6 Jun 2003 19:57:29 -0000
@@ -95,7 +95,7 @@ struct pci_controller {
 };
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
-#define PCI_SEGMENT(busdev)    (PCI_CONTROLLER(busdev)->segment)
+#define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
retrieving revision 1.16
diff -u -p -r1.16 pci.h
--- include/linux/pci.h	27 May 2003 17:29:00 -0000	1.16
+++ include/linux/pci.h	6 Jun 2003 19:32:08 -0000
@@ -868,5 +868,15 @@ extern int pci_pci_problems;
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+/*
+ * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
+ * a PCI domain is defined to be a set of PCI busses which share
+ * configuration space.
+ */
+
+#ifndef CONFIG_PCI_DOMAINS
+#define pci_domain_nr(pdev)	0
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
