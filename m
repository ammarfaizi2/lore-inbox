Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTCEAcQ>; Tue, 4 Mar 2003 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTCEAbb>; Tue, 4 Mar 2003 19:31:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27922 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266810AbTCEAaP>; Tue, 4 Mar 2003 19:30:15 -0500
Date: Wed, 5 Mar 2003 00:40:42 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCI probing for cardbus (5/5)
Message-ID: <20030305004042.F25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305003635.A25251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305003635.A25251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 05, 2003 at 12:36:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u orig/drivers/pci/probe.c linux/drivers/pci/probe.c
--- orig/drivers/pci/probe.c	Tue Feb 25 23:46:00 2003
+++ linux/drivers/pci/probe.c	Tue Feb 25 23:47:51 2003
@@ -228,41 +228,57 @@
 	return b;
 }
 
-struct pci_bus * __devinit pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr)
+static struct pci_bus * __devinit
+pci_alloc_child_bus(struct pci_bus *parent, struct pci_dev *bridge, int busnr)
 {
 	struct pci_bus *child;
-	int i;
 
 	/*
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
 	child = pci_alloc_bus();
 
-	list_add_tail(&child->node, &parent->children);
-	child->self = dev;
-	dev->subordinate = child;
-	child->parent = parent;
-	child->ops = parent->ops;
-	child->sysdata = parent->sysdata;
-	child->dev = &dev->dev;
+	if (child) {
+		int i;
 
-	/*
-	 * Set up the primary, secondary and subordinate
-	 * bus numbers.
-	 */
-	child->number = child->secondary = busnr;
-	child->primary = parent->secondary;
-	child->subordinate = 0xff;
-
-	/* Set up default resource pointers and names.. */
-	for (i = 0; i < 4; i++) {
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
-		child->resource[i]->name = child->name;
+		child->self = bridge;
+		child->parent = parent;
+		child->ops = parent->ops;
+		child->sysdata = parent->sysdata;
+		child->dev = &bridge->dev;
+
+		/*
+		 * Set up the primary, secondary and subordinate
+		 * bus numbers.
+		 */
+		child->number = child->secondary = busnr;
+		child->primary = parent->secondary;
+		child->subordinate = 0xff;
+
+		/* Set up default resource pointers and names.. */
+		for (i = 0; i < 4; i++) {
+			child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
+			child->resource[i]->name = child->name;
+		}
+
+		bridge->subordinate = child;
 	}
 
 	return child;
 }
 
+struct pci_bus * __devinit pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr)
+{
+	struct pci_bus *child;
+
+	child = pci_alloc_child_bus(parent, dev, busnr);
+	if (child)
+		list_add_tail(&child->node, &parent->children);
+	return child;
+}
+
+static unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
+
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
@@ -289,12 +305,12 @@
 		 */
 		if (pass)
 			return max;
-		child = pci_add_new_bus(bus, dev, 0);
+		child = pci_alloc_child_bus(bus, dev, 0);
 		child->primary = buses & 0xFF;
 		child->secondary = (buses >> 8) & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
 		child->number = child->secondary;
-		cmax = pci_do_scan_bus(child);
+		cmax = pci_scan_child_bus(child);
 		if (cmax > max) max = cmax;
 	} else {
 		/*
@@ -307,18 +323,27 @@
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
-		child = pci_add_new_bus(bus, dev, ++max);
+		child = pci_alloc_child_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)
 		      | ((unsigned int)(child->subordinate) << 16);
+
+		/*
+		 * yenta.c forces a secondary latency timer of 176.
+		 * Copy that behaviour here.
+		 */
+		if (is_cardbus)
+			buses = (buses & 0x00ffffff) | (176 << 24);
+			
 		/*
 		 * We need to blast all three values with a single write.
 		 */
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
+
 		if (!is_cardbus) {
 			/* Now we can scan all subordinate buses... */
-			max = pci_do_scan_bus(child);
+			max = pci_scan_child_bus(child);
 		} else {
 			/*
 			 * For CardBus bridges, we leave 4 bus numbers

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

