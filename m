Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSKFSCH>; Wed, 6 Nov 2002 13:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265893AbSKFSCH>; Wed, 6 Nov 2002 13:02:07 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6404 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265890AbSKFSBP>; Wed, 6 Nov 2002 13:01:15 -0500
Date: Wed, 6 Nov 2002 21:07:47 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5-bk] PCI 2/3: misc fixes
Message-ID: <20021106210747.D686@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Use PCI_BUS_NUM_RESOURCES instead on `4' in pci_find_parent_resource;
- clean up pci_claim_resource() and make it a bit more informative;
- pdev_sort_resources() must be __devinit, as it's called from
  pbus_assign_resources_sorted(), which is __devinit now.

Ivan.

--- 2.5-bk/drivers/pci/pci.c	Wed Nov  6 17:38:46 2002
+++ linux/drivers/pci/pci.c	Wed Nov  6 19:54:01 2002
@@ -182,7 +182,7 @@ pci_find_parent_resource(const struct pc
 	int i;
 	struct resource *best = NULL;
 
-	for(i=0; i<4; i++) {
+	for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		struct resource *r = bus->resource[i];
 		if (!r)
 			continue;
--- 2.5-bk/drivers/pci/setup-res.c	Tue Nov  5 01:30:49 2002
+++ linux/drivers/pci/setup-res.c	Wed Nov  6 17:26:47 2002
@@ -38,19 +38,18 @@ pci_claim_resource(struct pci_dev *dev, 
 {
         struct resource *res = &dev->resource[resource];
 	struct resource *root = pci_find_parent_resource(dev, res);
+	char *dtype = resource < PCI_BRIDGE_RESOURCES ? "device" : "bridge";
 	int err;
 
 	err = -EINVAL;
-	if (root != NULL) {
+	if (root != NULL)
 		err = request_resource(root, res);
-		if (err) {
-			printk(KERN_ERR "PCI: Address space collision on "
-			       "region %d of device %s [%lx:%lx]\n",
-			       resource, dev->name, res->start, res->end);
-		}
-	} else {
-		printk(KERN_ERR "PCI: No parent found for region %d "
-		       "of device %s\n", resource, dev->name);
+
+	if (err) {
+		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",
+		       root ? "Address space collision on" :
+			      "No parent found for",
+		       resource, dtype, dev->slot_name, res->start, res->end);
 	}
 
 	return err;
@@ -137,7 +136,7 @@ pci_assign_resource(struct pci_dev *dev,
 }
 
 /* Sort resources by alignment */
-void __init
+void __devinit
 pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
 {
 	int i;
