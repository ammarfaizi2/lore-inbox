Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTBUAnc>; Thu, 20 Feb 2003 19:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTBUAnb>; Thu, 20 Feb 2003 19:43:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22022 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267308AbTBUAmY>;
	Thu, 20 Feb 2003 19:42:24 -0500
Date: Thu, 20 Feb 2003 16:45:18 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.62
Message-ID: <20030221004518.GE26723@kroah.com>
References: <20030221004344.GA26723@kroah.com> <20030221004424.GB26723@kroah.com> <20030221004442.GC26723@kroah.com> <20030221004500.GD26723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221004500.GD26723@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1006, 2003/02/20 16:32:48-08:00, louis.zhuang@linux.co.intel.com

[PATCH] PCI: list code cleanup

Cleans up the list handling in a few places within the pci core.


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Feb 20 16:46:23 2003
+++ b/drivers/pci/probe.c	Thu Feb 20 16:46:23 2003
@@ -556,10 +556,9 @@
 
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
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Thu Feb 20 16:46:23 2003
+++ b/drivers/pci/setup-bus.c	Thu Feb 20 16:46:23 2003
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
