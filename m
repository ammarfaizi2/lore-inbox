Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHYWqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHYWqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHYWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:46:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:39323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266473AbUHYWhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:06 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733882615@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:29 -0700
Message-Id: <10934733893547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1877, 2004/08/25 13:23:54-07:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: create pci_remove_bus()

The following patch implements a pci_remove_bus() that can be used by
hotplug drivers for the removal of root buses.  It also defines a
release function that frees the device struct for pci_bus->bridge when a
root bus class device is unregistered.

Signed-off-by:  John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c  |    6 ++++++
 drivers/pci/remove.c |   20 +++++++++++++-------
 include/linux/pci.h  |    2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-08-25 14:51:47 -07:00
+++ b/drivers/pci/probe.c	2004-08-25 14:51:47 -07:00
@@ -571,6 +571,11 @@
 	return PCI_CFG_SPACE_SIZE;
 }
 
+static void pci_release_bus_bridge_dev(struct device *dev)
+{
+	kfree(dev);
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -772,6 +777,7 @@
 
 	memset(dev, 0, sizeof(*dev));
 	dev->parent = parent;
+	dev->release = pci_release_bus_bridge_dev;
 	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
 	device_register(dev);
 	b->bridge = get_device(dev);
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2004-08-25 14:51:47 -07:00
+++ b/drivers/pci/remove.c	2004-08-25 14:51:47 -07:00
@@ -59,6 +59,18 @@
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
+void pci_remove_bus(struct pci_bus *b)
+{
+	pci_proc_detach_bus(b);
+
+	spin_lock(&pci_bus_lock);
+	list_del(&b->node);
+	spin_unlock(&pci_bus_lock);
+
+	class_device_unregister(&b->class_dev);
+}
+EXPORT_SYMBOL(pci_remove_bus);
+
 /**
  * pci_remove_bus_device - remove a PCI device and any children
  * @dev: the device to remove
@@ -77,13 +89,7 @@
 		struct pci_bus *b = dev->subordinate;
 
 		pci_remove_behind_bridge(dev);
-		pci_proc_detach_bus(b);
-
-		spin_lock(&pci_bus_lock);
-		list_del(&b->node);
-		spin_unlock(&pci_bus_lock);
-
-		class_device_unregister(&b->class_dev);
+		pci_remove_bus(b);
 		dev->subordinate = NULL;
 	}
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-08-25 14:51:47 -07:00
+++ b/include/linux/pci.h	2004-08-25 14:51:47 -07:00
@@ -712,7 +712,7 @@
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
-
+extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_remove_bus_device(struct pci_dev *dev);
 
 /* Generic PCI functions exported to card drivers */

