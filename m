Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbTFRVPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbTFRVPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:15:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36080 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265536AbTFRVPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:15:41 -0400
Date: Wed, 18 Jun 2003 14:29:21 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] PCI device list locking - take 2
Message-ID: <20030618212921.GA1807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks to Chris Wright and Andrew Morton's comments on my last patch to
add locking to the pci device lists, I've redone it.  Below is a patch
against 2.5.72 that should address everyone's previous concerns.

It adds a lock (pci_bus_lock) that is grabbed whenever the pci lists are
accessed, and two new functions, pci_get_device() and pci_get_subsys().
These functions work just like pci_find_device() and pci_find_subsys()
did, but they handle the proper reference counting of the pci devices
found and passed to them.  Then, the drivers/pci/proc.c code was
converted to use these functions instead of accessing the pci lists
directly.

Again, I'm ignoring the pci startup code, as that is a big rats nest
that is next on my list to look at.

Comments on this version?

thanks,

greg k-h


--- a/drivers/pci/bus.c	Wed Jun 18 14:22:15 2003
+++ b/drivers/pci/bus.c	Wed Jun 18 14:22:15 2003
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
--- a/drivers/pci/hotplug.c	Wed Jun 18 14:22:15 2003
+++ b/drivers/pci/hotplug.c	Wed Jun 18 14:22:15 2003
@@ -187,10 +187,15 @@
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
+	pci_put_dev(dev);
 	return 0;
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
@@ -237,14 +242,21 @@
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
--- a/drivers/pci/pci.h	Wed Jun 18 14:22:15 2003
+++ b/drivers/pci/pci.h	Wed Jun 18 14:22:15 2003
@@ -59,3 +59,6 @@
 extern int pci_visit_dev(struct pci_visit *fn,
 			 struct pci_dev_wrapped *wrapped_dev,
 			 struct pci_bus_wrapped *wrapped_parent);
+
+/* Lock for read/write access to pci device and bus lists */
+extern spinlock_t pci_bus_lock;
--- a/drivers/pci/proc.c	Wed Jun 18 14:22:15 2003
+++ b/drivers/pci/proc.c	Wed Jun 18 14:22:15 2003
@@ -12,6 +12,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/smp_lock.h>
+#include "pci.h"
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -308,39 +309,45 @@
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
-	struct list_head *p = &pci_devices;
+	struct pci_dev *dev = NULL;
 	loff_t n = *pos;
 
-	/* XXX: surely we need some locking for traversing the list? */
+	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
 	while (n--) {
-		p = p->next;
-		if (p == &pci_devices)
-			return NULL;
+		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
+		if (dev == NULL)
+			goto exit;
 	}
-	return p;
+exit:
+	return dev;
 }
+
 static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct list_head *p = v;
+	struct pci_dev *dev = v;
+
 	(*pos)++;
-	return p->next != &pci_devices ? (void *)p->next : NULL;
+	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
+	return dev;
 }
+
 static void pci_seq_stop(struct seq_file *m, void *v)
 {
-	/* release whatever locks we need */
+	if (v) {
+		struct pci_dev *dev = v;
+		pci_put_dev(dev);
+	}
 }
 
 static int show_device(struct seq_file *m, void *v)
 {
-	struct list_head *p = v;
-	const struct pci_dev *dev;
+	const struct pci_dev *dev = v;
 	const struct pci_driver *drv;
 	int i;
 
-	if (p == &pci_devices)
+	if (dev == NULL)
 		return 0;
 
-	dev = pci_dev_g(p);
 	drv = pci_dev_driver(dev);
 	seq_printf(m, "%02x%02x\t%04x%04x\t%x",
 			dev->bus->number,
@@ -455,19 +462,18 @@
  */
 static int show_dev_config(struct seq_file *m, void *v)
 {
-	struct list_head *p = v;
-	struct pci_dev *dev;
+	struct pci_dev *dev = v;
+	struct pci_dev *first_dev;
 	struct pci_driver *drv;
 	u32 class_rev;
 	unsigned char latency, min_gnt, max_lat, *class;
 	int reg;
 
-	if (p == &pci_devices) {
+	first_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
+	if (dev == first_dev)
 		seq_puts(m, "PCI devices found:\n");
-		return 0;
-	}
+	pci_put_dev(first_dev);
 
-	dev = pci_dev_g(p);
 	drv = pci_dev_driver(dev);
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
--- a/drivers/pci/search.c	Wed Jun 18 14:22:15 2003
+++ b/drivers/pci/search.c	Wed Jun 18 14:22:15 2003
@@ -1,6 +1,17 @@
+/*
+ * 	PCI searching functions.
+ *
+ *	Copyright 1993 -- 1997 Drew Eckhardt, Frederic Potter,
+ *				David Mosberger-Tang
+ *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
+ *	Copyright 2003 -- Greg Kroah-Hartman <greg@kroah.com>
+ */
+
 #include <linux/pci.h>
 #include <linux/module.h>
 
+spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
+
 static struct pci_bus *
 pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)
 {
@@ -52,11 +63,15 @@
 struct pci_bus * 
 pci_find_next_bus(const struct pci_bus *from)
 {
-	struct list_head *n = from ? from->node.next : pci_root_buses.next;
+	struct list_head *n;
 	struct pci_bus *b = NULL;
 
+	WARN_ON(irqs_disabled());
+	spin_lock(&pci_bus_lock);
+	n = from ? from->node.next : pci_root_buses.next;
 	if (n != &pci_root_buses)
 		b = pci_bus_b(n);
+	spin_unlock(&pci_bus_lock);
 	return b;
 }
 
@@ -97,24 +112,36 @@
  * device structure is returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
  * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ *
+ * NOTE: Do not use this function anymore, use pci_get_subsys() instead, as
+ * the pci device returned by this function can disappear at any moment in
+ * time.
  */
 struct pci_dev *
 pci_find_subsys(unsigned int vendor, unsigned int device,
 		unsigned int ss_vendor, unsigned int ss_device,
 		const struct pci_dev *from)
 {
-	struct list_head *n = from ? from->global_list.next : pci_devices.next;
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	WARN_ON(irqs_disabled());
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
@@ -128,6 +155,10 @@
  * returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
  * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ * 
+ * NOTE: Do not use this function anymore, use pci_get_device() instead, as
+ * the pci device returned by this function can disappear at any moment in
+ * time.
  */
 struct pci_dev *
 pci_find_device(unsigned int vendor, unsigned int device, const struct pci_dev *from)
@@ -135,6 +166,79 @@
 	return pci_find_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from);
 }
 
+/**
+ * pci_get_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
+ * @ss_vendor: PCI subsystem vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all device ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
+ * device structure is returned, and the reference count to the device is
+ * incremented.  Otherwise, %NULL is returned.  A new search is initiated by
+ * passing %NULL to the @from argument.  Otherwise if @from is not %NULL,
+ * searches continue from next device on the global list.
+ * The reference count for @from is always decremented if it is not %NULL.
+ */
+struct pci_dev * 
+pci_get_subsys(unsigned int vendor, unsigned int device,
+	       unsigned int ss_vendor, unsigned int ss_device,
+	       struct pci_dev *from)
+{
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	WARN_ON(irqs_disabled());
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.next : pci_devices.next;
+
+	while (n != &pci_devices) {
+		dev = pci_dev_g(n);
+		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
+		    (device == PCI_ANY_ID || dev->device == device) &&
+		    (ss_vendor == PCI_ANY_ID || dev->subsystem_vendor == ss_vendor) &&
+		    (ss_device == PCI_ANY_ID || dev->subsystem_device == ss_device))
+			goto exit;
+		n = n->next;
+	}
+	dev = NULL;
+exit:
+	if (from)
+		pci_put_dev(from);
+	if (dev)
+		pci_get_dev(dev);
+	spin_unlock(&pci_bus_lock);
+	return dev;
+}
+
+/**
+ * pci_get_device - begin or continue searching for a PCI device by vendor/device id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @vendor and @device, a pointer to its device structure is
+ * returned.  Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @vendor and @device, the reference count to the
+ * device is incremented and a pointer to its device structure is returned.
+ * Otherwise, %NULL is returned.  A new search is initiated by passing %NULL
+ * to the @from argument.  Otherwise if @from is not %NULL, searches continue
+ * from next device on the global list.  The reference count for @from is
+ * always decremented if it is not %NULL.
+ */
+struct pci_dev *
+pci_get_device(unsigned int vendor, unsigned int device, struct pci_dev *from)
+{
+	return pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from);
+}
+
 
 /**
  * pci_find_device_reverse - begin or continue searching for a PCI device by vendor/device id
@@ -151,16 +255,24 @@
 struct pci_dev *
 pci_find_device_reverse(unsigned int vendor, unsigned int device, const struct pci_dev *from)
 {
-	struct list_head *n = from ? from->global_list.prev : pci_devices.prev;
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	WARN_ON(irqs_disabled());
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
 
 
@@ -179,15 +291,22 @@
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
--- a/include/linux/pci.h	Wed Jun 18 14:22:15 2003
+++ b/include/linux/pci.h	Wed Jun 18 14:22:15 2003
@@ -566,6 +566,10 @@
 int pci_find_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
+struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
+struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
+				unsigned int ss_vendor, unsigned int ss_device,
+				struct pci_dev *from);
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
 int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);
@@ -686,6 +690,13 @@
 
 static inline struct pci_dev *pci_find_subsys(unsigned int vendor, unsigned int device,
 unsigned int ss_vendor, unsigned int ss_device, const struct pci_dev *from)
+{ return NULL; }
+
+static inline struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from)
+{ return NULL; }
+
+static inline struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
+unsigned int ss_vendor, unsigned int ss_device, struct pci_dev *from)
 { return NULL; }
 
 static inline void pci_set_master(struct pci_dev *dev) { }
