Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbTBRD0i>; Mon, 17 Feb 2003 22:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTBRD0i>; Mon, 17 Feb 2003 22:26:38 -0500
Received: from fmr02.intel.com ([192.55.52.25]:22474 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267574AbTBRD0g>; Mon, 17 Feb 2003 22:26:36 -0500
Subject: [PATCH] [RESEND] PCI code cleanup
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302172055060.5217-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0302172055060.5217-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1045539216.1018.6.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 18 Feb 2003 11:33:37 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, if you're changing that anyway, you could as well use
> 
> {
> 	const struct pci_bus *b;
> 
> 	list_for_each_entry(b, list) {
> 		if (b->number ...
> 
> which looks even nicer ;-)
> 
> --Kai
How about following patch? ;-)

  - Louis

===== drivers/pci/probe.c 1.26 vs edited =====
--- 1.26/drivers/pci/probe.c	Mon Jan 13 11:44:26 2003
+++ edited/drivers/pci/probe.c	Tue Feb 18 11:14:13 2003
@@ -531,10 +531,9 @@
 
 int __devinit pci_bus_exists(const struct list_head *list, int nr)
 {
-	const struct list_head *l;
+	const struct pci_bus *b;
 
-	for(l=list->next; l != list; l = l->next) {
-		const struct pci_bus *b = pci_bus_b(l);
+	list_for_each_entry(b, list, node) {
 		if (b->number == nr || pci_bus_exists(&b->children, nr))
 			return 1;
 	}
===== drivers/pci/setup-bus.c 1.12 vs edited =====
--- 1.12/drivers/pci/setup-bus.c	Sun Dec 22 07:46:25 2002
+++ edited/drivers/pci/setup-bus.c	Tue Feb 18 11:27:06 2003
@@ -39,14 +39,13 @@
 static int __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 	struct resource *res;
 	struct resource_list head, *list, *tmp;
 	int idx, found_vga = 0;
 
 	head.next = NULL;
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
 		if (class == PCI_CLASS_DISPLAY_VGA
@@ -201,15 +200,14 @@
 static void __devinit
 pbus_size_io(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 	struct resource *b_res = bus->resource[0];
 	unsigned long size = 0, size1 = 0;
 
 	if (!(b_res->flags & IORESOURCE_IO))
 		return;
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 		
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -250,7 +248,7 @@
 static void __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 	unsigned long min_align, align, size;
 	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
@@ -261,8 +259,7 @@
 	max_order = 0;
 	size = 0;
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 		
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -322,11 +319,12 @@
 void __devinit
 pci_bus_size_bridges(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 	unsigned long mask, type;
 
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
-		pci_bus_size_bridges(pci_bus_b(ln));
+	list_for_each_entry(b, &bus->children, node) {
+		pci_bus_size_bridges(b);
+	}
 
 	/* The root bus? */
 	if (!bus->self)
@@ -350,20 +348,16 @@
 void __devinit
 pci_bus_assign_resources(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 	int found_vga = pbus_assign_resources_sorted(bus);
 
 	if (found_vga) {
-		struct pci_bus *b;
-
 		/* Propagate presence of the VGA to upstream bridges */
 		for (b = bus; b->parent; b = b->parent) {
 			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
 		}
 	}
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
-
+	list_for_each_entry(b, &bus->children, node) {
 		pci_bus_assign_resources(b);
 		pci_setup_bridge(b);
 	}


