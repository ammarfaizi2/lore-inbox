Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJNMtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJNMtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJNMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:49:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264085AbUJNMsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:48:52 -0400
Date: Thu, 14 Oct 2004 13:48:51 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] pci_bus_to_phys() for ia64 [2/2]
Message-ID: <20041014124851.GN16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Switch ia64 to the phys_to_bus / bus_to_phys method of converting PCI
BARs to and from resources.

Index: pci-2.6/arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/pci/pci.c,v
retrieving revision 1.15
diff -u -p -r1.15 pci.c
--- pci-2.6/arch/ia64/pci/pci.c	30 Sep 2004 12:07:43 -0000	1.15
+++ pci-2.6/arch/ia64/pci/pci.c	14 Oct 2004 12:38:32 -0000
@@ -328,35 +328,44 @@ out1:
 	return NULL;
 }
 
-void __init
-pcibios_fixup_device_resources (struct pci_dev *dev, struct pci_bus *bus)
+unsigned long pcibios_phys_to_bus(struct pci_controller *controller,
+		unsigned long addr, unsigned long flags)
 {
-	struct pci_controller *controller = PCI_CONTROLLER(dev);
-	struct pci_window *window;
-	int i, j;
-	int limit = (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) ? \
-		PCI_BRIDGE_RESOURCES : PCI_NUM_RESOURCES;
-
-	for (i = 0; i < limit; i++) {
-		if (!dev->resource[i].start)
-			continue;
-
-#define contains(win, res)	((res)->start >= (win)->start && \
-				 (res)->end   <= (win)->end)
-
-		for (j = 0; j < controller->windows; j++) {
-			window = &controller->window[j];
-			if (((dev->resource[i].flags & IORESOURCE_MEM &&
-			      window->resource.flags & IORESOURCE_MEM) ||
-			     (dev->resource[i].flags & IORESOURCE_IO &&
-			      window->resource.flags & IORESOURCE_IO)) &&
-			    contains(&window->resource, &dev->resource[i])) {
-				dev->resource[i].start += window->offset;
-				dev->resource[i].end   += window->offset;
-			}
-		}
-		pci_claim_resource(dev, i);
+	int i;
+
+	for (i = 0; i < controller->windows; i++) {
+		unsigned long bus_addr;
+		struct pci_window *window = &controller->window[i];
+		if (!(window->resource.flags & flags))
+			continue;
+		bus_addr = addr - window->offset;
+		if (window->resource.start > bus_addr)
+			continue;
+		if (window->resource.end < bus_addr)
+			continue;
+		return bus_addr;
 	}
+
+	return addr;
+}
+
+unsigned long pcibios_bus_to_phys(struct pci_controller *controller,
+		unsigned long addr, unsigned long flags)
+{
+	int i;
+
+	for (i = 0; i < controller->windows; i++) {
+		struct pci_window *window = &controller->window[i];
+		if (!(window->resource.flags & flags))
+			continue;
+		if (window->resource.start > addr)
+			continue;
+		if (window->resource.end < addr)
+			continue;
+		return addr + window->offset;
+	}
+
+	return addr;
 }
 
 /*
@@ -365,10 +374,18 @@ pcibios_fixup_device_resources (struct p
 void __devinit
 pcibios_fixup_bus (struct pci_bus *b)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 
-	for (ln = b->devices.next; ln != &b->devices; ln = ln->next)
-		pcibios_fixup_device_resources(pci_dev_b(ln), b);
+	list_for_each_entry(dev, &b->devices, bus_list) {
+		int i, limit = (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) ? \
+			    PCI_BRIDGE_RESOURCES : PCI_NUM_RESOURCES;
+
+		for (i = 0; i < limit; i++) {
+			if (!dev->resource[i].start)
+				continue;
+			pci_claim_resource(dev, i);
+		}
+	}
 
 	return;
 }
Index: pci-2.6/include/asm-ia64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ia64/pci.h,v
retrieving revision 1.6
diff -u -p -r1.6 pci.h
--- pci-2.6/include/asm-ia64/pci.h	16 Mar 2004 15:40:37 -0000	1.6
+++ pci-2.6/include/asm-ia64/pci.h	14 Oct 2004 12:38:38 -0000
@@ -119,6 +119,16 @@ static inline void pcibios_add_platform_
 {
 }
 
+extern unsigned long pcibios_phys_to_bus(struct pci_controller *,
+		unsigned long, unsigned long);
+extern unsigned long pcibios_bus_to_phys(struct pci_controller *,
+		unsigned long, unsigned long);
+
+#define pci_phys_to_bus(busdev, addr, flags)	\
+		pcibios_phys_to_bus(PCI_CONTROLLER(busdev), (addr), (flags))
+#define pci_bus_to_phys(busdev, addr, flags)	\
+		pcibios_bus_to_phys(PCI_CONTROLLER(busdev), (addr), (flags))
+
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
