Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTFQVNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbTFQVNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:13:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23452 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264987AbTFQVMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:12:54 -0400
Date: Tue, 17 Jun 2003 14:26:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] PCI device list locking
Message-ID: <20030617212628.GA12723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Below is a patch against 2.5.72 that adds a pci_bus_lock to protect the
pci device and pci bus lists.  This is one of the final steps in finally
getting proper locking for these lists (which previously had none.)
I've been stressing it pretty hard on some pci hotplug boxes I have
here, with no problems, but I wanted to get everyone's opinion first,
before sending it off to Linus.

I know pci_find_bus() isn't properly protected right now, but the number
of callers of this function are pretty small (only pci hotplug drivers),
so the risk is quite low.

Comments?  Places I missed protecting?

thanks,

greg k-h


# PCI: add locking for when we touch the pci device lists.

diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Tue Jun 17 12:47:27 2003
+++ b/drivers/pci/bus.c	Tue Jun 17 12:47:27 2003
@@ -93,7 +93,11 @@
 			continue;
 
 		device_add(&dev->dev);
+
+		spin_lock(&pci_bus_lock);
 		list_add_tail(&dev->global_list, &pci_devices);
+		spin_unlock(&pci_bus_lock);
+
 		pci_proc_attach_device(dev);
 		pci_create_sysfs_dev_files(dev);
 
@@ -108,7 +112,9 @@
 		 * it and then scan for unattached PCI devices.
 		 */
 		if (dev->subordinate && list_empty(&dev->subordinate->node)) {
+			spin_lock(&pci_bus_lock);
 			list_add_tail(&dev->subordinate->node, &dev->bus->children);
+			spin_unlock(&pci_bus_lock);
 			pci_bus_add_devices(dev->subordinate);
 		}
 	}
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Tue Jun 17 12:47:27 2003
+++ b/drivers/pci/hotplug.c	Tue Jun 17 12:47:27 2003
@@ -187,8 +187,12 @@
 	if (pci_dev_driver(dev))
 		return -EBUSY;
 	device_unregister(&dev->dev);
+
+	spin_lock(&pci_bus_lock);
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
+	spin_unlock(&pci_bus_lock);
+
 	pci_free_resources(dev);
 	pci_proc_detach_device(dev);
 	return 0;
@@ -237,14 +241,21 @@
 		pci_remove_behind_bridge(dev);
 		pci_proc_detach_bus(b);
 
+		spin_lock(&pci_bus_lock);
 		list_del(&b->node);
+		spin_unlock(&pci_bus_lock);
+
 		kfree(b);
 		dev->subordinate = NULL;
 	}
 
 	device_unregister(&dev->dev);
+
+	spin_lock(&pci_bus_lock);
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
+	spin_unlock(&pci_bus_lock);
+
 	pci_free_resources(dev);
 	pci_proc_detach_device(dev);
 	pci_put_dev(dev);
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Tue Jun 17 12:47:27 2003
+++ b/drivers/pci/pci.h	Tue Jun 17 12:47:27 2003
@@ -59,3 +59,6 @@
 extern int pci_visit_dev(struct pci_visit *fn,
 			 struct pci_dev_wrapped *wrapped_dev,
 			 struct pci_bus_wrapped *wrapped_parent);
+
+/* Lock for read/write access to pci device and bus lists */
+extern spinlock_t pci_bus_lock;
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
+++ b/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
@@ -12,6 +12,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/smp_lock.h>
+#include "pci.h"
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -311,20 +312,32 @@
 	struct list_head *p = &pci_devices;
 	loff_t n = *pos;
 
-	/* XXX: surely we need some locking for traversing the list? */
+	spin_lock(&pci_bus_lock);
 	while (n--) {
 		p = p->next;
-		if (p == &pci_devices)
-			return NULL;
+		if (p == &pci_devices) {
+			p = NULL;
+			goto exit;
+		}
 	}
+exit:
+	spin_unlock(&pci_bus_lock);
 	return p;
 }
+
 static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct list_head *p = v;
+	void *ret = NULL;
+
 	(*pos)++;
-	return p->next != &pci_devices ? (void *)p->next : NULL;
+	spin_lock(&pci_bus_lock);
+	if (p->next != &pci_devices)
+	       ret = (void *)p->next;
+	spin_unlock(&pci_bus_lock);
+	return ret;
 }
+
 static void pci_seq_stop(struct seq_file *m, void *v)
 {
 	/* release whatever locks we need */
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Tue Jun 17 12:47:27 2003
+++ b/drivers/pci/search.c	Tue Jun 17 12:47:27 2003
@@ -1,6 +1,8 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 
+spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
+
 static struct pci_bus *
 pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)
 {
@@ -52,11 +54,14 @@
 struct pci_bus * 
 pci_find_next_bus(const struct pci_bus *from)
 {
-	struct list_head *n = from ? from->node.next : pci_root_buses.next;
+	struct list_head *n;
 	struct pci_bus *b = NULL;
 
+	spin_lock(&pci_bus_lock);
+	n = from ? from->node.next : pci_root_buses.next;
 	if (n != &pci_root_buses)
 		b = pci_bus_b(n);
+	spin_unlock(&pci_bus_lock);
 	return b;
 }
 
@@ -103,18 +108,25 @@
 		unsigned int ss_vendor, unsigned int ss_device,
 		const struct pci_dev *from)
 {
-	struct list_head *n = from ? from->global_list.next : pci_devices.next;
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.next : pci_devices.next;
 
 	while (n != &pci_devices) {
-		struct pci_dev *dev = pci_dev_g(n);
+		dev = pci_dev_g(n);
 		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
 		    (device == PCI_ANY_ID || dev->device == device) &&
 		    (ss_vendor == PCI_ANY_ID || dev->subsystem_vendor == ss_vendor) &&
 		    (ss_device == PCI_ANY_ID || dev->subsystem_device == ss_device))
-			return dev;
+			goto exit;
 		n = n->next;
 	}
-	return NULL;
+	dev = NULL;
+exit:
+	spin_unlock(&pci_bus_lock);
+	return dev;
 }
 
 /**
@@ -151,16 +163,23 @@
 struct pci_dev *
 pci_find_device_reverse(unsigned int vendor, unsigned int device, const struct pci_dev *from)
 {
-	struct list_head *n = from ? from->global_list.prev : pci_devices.prev;
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.prev : pci_devices.prev;
 
 	while (n != &pci_devices) {
-		struct pci_dev *dev = pci_dev_g(n);
+		dev = pci_dev_g(n);
 		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
 		    (device == PCI_ANY_ID || dev->device == device))
-			return dev;
+			goto exit;
 		n = n->prev;
 	}
-	return NULL;
+	dev = NULL;
+exit:
+	spin_unlock(&pci_bus_lock);
+	return dev;
 }
 
 
@@ -179,15 +198,22 @@
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)
 {
-	struct list_head *n = from ? from->global_list.next : pci_devices.next;
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.next : pci_devices.next;
 
 	while (n != &pci_devices) {
-		struct pci_dev *dev = pci_dev_g(n);
+		dev = pci_dev_g(n);
 		if (dev->class == class)
-			return dev;
+			goto exit;
 		n = n->next;
 	}
-	return NULL;
+	dev = NULL;
+exit:
+	spin_unlock(&pci_bus_lock);
+	return dev;
 }
 
 EXPORT_SYMBOL(pci_find_bus);
