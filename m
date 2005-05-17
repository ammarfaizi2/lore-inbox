Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVEQWEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEQWEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEQWCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:02:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:64923 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262000AbVEQVo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:58 -0400
Cc: scottm@somanetworks.com
Subject: [PATCH] PCI Hotplug: remove pci_visit_dev
In-Reply-To: <11163663062856@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:06 -0700
Message-Id: <1116366306935@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: remove pci_visit_dev

If my CPCI hotplug update patch is applied, then there are no longer any
in tree users of the pci_visit_dev API, and it and its related code can be
removed.

Signed-off-by: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c22610dadc0452b1273494f2b5157123c6cd60e1
tree 150d5315df21f02605ad5a6541ef7cb00176d023
parent 43b7d7cfb157b5c8c5cc0933f4e96fd81adc81ca
author Scott Murray <scottm@somanetworks.com> Mon, 09 May 2005 17:36:27 -0400
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:11 -0700

 drivers/pci/hotplug.c |  109 --------------------------------------------------
 drivers/pci/pci.h     |   27 ------------
 2 files changed, 136 deletions(-)

Index: drivers/pci/hotplug.c
===================================================================
--- 2af3b43ed8ee9468b1e0418c10275f33d23ced19/drivers/pci/hotplug.c  (mode:100644)
+++ 150d5315df21f02605ad5a6541ef7cb00176d023/drivers/pci/hotplug.c  (mode:100644)
@@ -56,112 +56,3 @@
 
 	return 0;
 }
-
-static int pci_visit_bus (struct pci_visit * fn, struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_parent)
-{
-	struct list_head *ln;
-	struct pci_dev *dev;
-	struct pci_dev_wrapped wrapped_dev;
-	int result = 0;
-
-	pr_debug("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(wrapped_bus->bus),
-		wrapped_bus->bus->number);
-
-	if (fn->pre_visit_pci_bus) {
-		result = fn->pre_visit_pci_bus(wrapped_bus, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	ln = wrapped_bus->bus->devices.next; 
-	while (ln != &wrapped_bus->bus->devices) {
-		dev = pci_dev_b(ln);
-		ln = ln->next;
-
-		memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-		wrapped_dev.dev = dev;
-
-		result = pci_visit_dev(fn, &wrapped_dev, wrapped_bus);
-		if (result)
-			return result;
-	}
-
-	if (fn->post_visit_pci_bus)
-		result = fn->post_visit_pci_bus(wrapped_bus, wrapped_parent);
-
-	return result;
-}
-
-static int pci_visit_bridge (struct pci_visit * fn,
-			     struct pci_dev_wrapped *wrapped_dev,
-			     struct pci_bus_wrapped *wrapped_parent)
-{
-	struct pci_bus *bus;
-	struct pci_bus_wrapped wrapped_bus;
-	int result = 0;
-
-	pr_debug("PCI: Scanning bridge %s\n", pci_name(wrapped_dev->dev));
-
-	if (fn->visit_pci_dev) {
-		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	bus = wrapped_dev->dev->subordinate;
-	if (bus) {
-		memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-		wrapped_bus.bus = bus;
-
-		result = pci_visit_bus(fn, &wrapped_bus, wrapped_dev);
-	}
-	return result;
-}
-
-/**
- * pci_visit_dev - scans the pci buses.
- * @fn: callback functions that are called while visiting
- * @wrapped_dev: the device to scan
- * @wrapped_parent: the bus where @wrapped_dev is connected to
- *
- * Every bus and every function is presented to a custom
- * function that can act upon it.
- */
-int pci_visit_dev(struct pci_visit *fn, struct pci_dev_wrapped *wrapped_dev,
-		  struct pci_bus_wrapped *wrapped_parent)
-{
-	struct pci_dev* dev = wrapped_dev ? wrapped_dev->dev : NULL;
-	int result = 0;
-
-	if (!dev)
-		return 0;
-
-	if (fn->pre_visit_pci_dev) {
-		result = fn->pre_visit_pci_dev(wrapped_dev, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
-			result = pci_visit_bridge(fn, wrapped_dev,
-						  wrapped_parent);
-			if (result)
-				return result;
-			break;
-		default:
-			pr_debug("PCI: Scanning device %s\n", pci_name(dev));
-			if (fn->visit_pci_dev) {
-				result = fn->visit_pci_dev (wrapped_dev,
-							    wrapped_parent);
-				if (result)
-					return result;
-			}
-	}
-
-	if (fn->post_visit_pci_dev)
-		result = fn->post_visit_pci_dev(wrapped_dev, wrapped_parent);
-
-	return result;
-}
-EXPORT_SYMBOL(pci_visit_dev);
Index: drivers/pci/pci.h
===================================================================
--- 2af3b43ed8ee9468b1e0418c10275f33d23ced19/drivers/pci/pci.h  (mode:100644)
+++ 150d5315df21f02605ad5a6541ef7cb00176d023/drivers/pci/pci.h  (mode:100644)
@@ -32,33 +32,6 @@
 extern unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
 
-struct pci_dev_wrapped {
-	struct pci_dev	*dev;
-	void		*data;
-};
-
-struct pci_bus_wrapped {
-	struct pci_bus	*bus;
-	void		*data;
-};
-
-struct pci_visit {
-	int (* pre_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-	int (* post_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-
-	int (* pre_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* visit_pci_dev)		(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* post_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-};
-
-extern int pci_visit_dev(struct pci_visit *fn,
-			 struct pci_dev_wrapped *wrapped_dev,
-			 struct pci_bus_wrapped *wrapped_parent);
 extern void pci_remove_legacy_files(struct pci_bus *bus);
 
 /* Lock for read/write access to pci device and bus lists */

