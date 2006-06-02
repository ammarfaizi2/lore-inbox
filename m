Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWFBEkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWFBEkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWFBEkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:40:23 -0400
Received: from mga06.intel.com ([134.134.136.21]:22907 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751119AbWFBEkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:40:23 -0400
X-IronPort-AV: i="4.05,201,1146466800"; 
   d="scan'208"; a="44718795:sNHT23633659"
Subject: Re: pci_walk_bus race condition
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1148889932.4377.537.camel@ymzhang-perf.sh.intel.com>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
	 <20060526135039.GA13280@kroah.com>
	 <1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
	 <1148889932.4377.537.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1149222942.8436.189.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 02 Jun 2006 12:35:43 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 16:05, Zhang, Yanmin wrote:
> On Mon, 2006-05-29 at 08:41, Zhang, Yanmin wrote:
> > On Fri, 2006-05-26 at 21:50, Greg KH wrote:
> > > On Fri, May 26, 2006 at 02:35:16PM +0800, Zhang, Yanmin wrote:
> > > > pci_walk_bus has a race with pci_destroy_dev. In the while loop,
> > > > when the callback function is called, dev pointed by next might be
> > > > freed and erased. So later on access to dev might cause kernel panic.
> > > 
> > > Have you seen this happen?  The only user of this function is the PPC64
> > > EEH handler, which last time I checked, didn't run on Intel based
> > > processors :)
> > I am enabling PCI-Express AER in kernel and want to use it. After
> > double-checking, I found the lock is not good.
> How about changing pci_bus_lock to a sema? I think it's the thorough
> approach. As the write lock is used only when initializing and uninitializing,
> the performance won't be hurted severely.
Here is the patch.

From: Zhang Yanmin <yanmin.zhang@intel.com>

pci_walk_bus has a race with pci_destroy_dev. When cb is called
in pci_walk_bus, pci_destroy_dev might unlink the dev pointed by next.
Later on in the next loop, pointer next becomes NULL and cause
kernel panic.

Below patch against 2.6.17-rc4 fixes it by changing pci_bus_lock (spin_lock)
to pci_bus_sem (rw_semaphore).

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.17-rc4/drivers/pci/bus.c linux-2.6.17-rc4_pci_bus_lock/drivers/pci/bus.c
--- linux-2.6.17-rc4/drivers/pci/bus.c	2006-04-20 21:19:24.000000000 +0800
+++ linux-2.6.17-rc4_pci_bus_lock/drivers/pci/bus.c	2006-06-01 09:24:56.000000000 +0800
@@ -81,9 +81,9 @@ void __devinit pci_bus_add_device(struct
 {
 	device_add(&dev->dev);
 
-	spin_lock(&pci_bus_lock);
+	down_write(&pci_bus_sem);
 	list_add_tail(&dev->global_list, &pci_devices);
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
@@ -125,10 +125,10 @@ void __devinit pci_bus_add_devices(struc
 		 */
 		if (dev->subordinate) {
 		       if (list_empty(&dev->subordinate->node)) {
-			       spin_lock(&pci_bus_lock);
+			       down_write(&pci_bus_sem);
 			       list_add_tail(&dev->subordinate->node,
 					       &dev->bus->children);
-			       spin_unlock(&pci_bus_lock);
+			       up_write(&pci_bus_sem);
 		       }
 			pci_bus_add_devices(dev->subordinate);
 
@@ -168,7 +168,7 @@ void pci_walk_bus(struct pci_bus *top, v
 	struct list_head *next;
 
 	bus = top;
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -180,22 +180,19 @@ void pci_walk_bus(struct pci_bus *top, v
 			continue;
 		}
 		dev = list_entry(next, struct pci_dev, bus_list);
-		pci_dev_get(dev);
 		if (dev->subordinate) {
 			/* this is a pci-pci bridge, do its devices next */
 			next = dev->subordinate->devices.next;
 			bus = dev->subordinate;
 		} else
 			next = dev->bus_list.next;
-		spin_unlock(&pci_bus_lock);
 
-		/* Run device routines with the bus unlocked */
+		/* Run device routines with the device locked */
+		down(&dev->dev.sem);
 		cb(dev, userdata);
-
-		spin_lock(&pci_bus_lock);
-		pci_dev_put(dev);
+		up(&dev->dev.sem);
 	}
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
diff -Nraup linux-2.6.17-rc4/drivers/pci/pci.h linux-2.6.17-rc4_pci_bus_lock/drivers/pci/pci.h
--- linux-2.6.17-rc4/drivers/pci/pci.h	2006-05-17 17:16:24.000000000 +0800
+++ linux-2.6.17-rc4_pci_bus_lock/drivers/pci/pci.h	2006-05-31 15:07:48.000000000 +0800
@@ -40,7 +40,7 @@ extern int pci_bus_find_capability (stru
 extern void pci_remove_legacy_files(struct pci_bus *bus);
 
 /* Lock for read/write access to pci device and bus lists */
-extern spinlock_t pci_bus_lock;
+extern struct rw_semaphore pci_bus_sem;
 
 #ifdef CONFIG_X86_IO_APIC
 extern int pci_msi_quirk;
diff -Nraup linux-2.6.17-rc4/drivers/pci/probe.c linux-2.6.17-rc4_pci_bus_lock/drivers/pci/probe.c
--- linux-2.6.17-rc4/drivers/pci/probe.c	2006-05-17 17:16:24.000000000 +0800
+++ linux-2.6.17-rc4_pci_bus_lock/drivers/pci/probe.c	2006-05-31 15:13:38.000000000 +0800
@@ -377,9 +377,9 @@ struct pci_bus * __devinit pci_add_new_b
 
 	child = pci_alloc_child_bus(parent, dev, busnr);
 	if (child) {
-		spin_lock(&pci_bus_lock);
+		down_write(&pci_bus_sem);
 		list_add_tail(&child->node, &parent->children);
-		spin_unlock(&pci_bus_lock);
+		up_write(&pci_bus_sem);
 	}
 	return child;
 }
@@ -838,9 +838,9 @@ void __devinit pci_device_add(struct pci
 	 * and the bus list for fixup functions, etc.
 	 */
 	INIT_LIST_HEAD(&dev->global_list);
-	spin_lock(&pci_bus_lock);
+	down_write(&pci_bus_sem);
 	list_add_tail(&dev->bus_list, &bus->devices);
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 }
 
 struct pci_dev * __devinit
@@ -975,9 +975,10 @@ struct pci_bus * __devinit pci_create_bu
 		pr_debug("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
-	spin_lock(&pci_bus_lock);
+
+	down_write(&pci_bus_sem);
 	list_add_tail(&b->node, &pci_root_buses);
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 
 	memset(dev, 0, sizeof(*dev));
 	dev->parent = parent;
@@ -1017,9 +1018,9 @@ class_dev_create_file_err:
 class_dev_reg_err:
 	device_unregister(dev);
 dev_reg_err:
-	spin_lock(&pci_bus_lock);
+	down_write(&pci_bus_sem);
 	list_del(&b->node);
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 err_out:
 	kfree(dev);
 	kfree(b);
diff -Nraup linux-2.6.17-rc4/drivers/pci/remove.c linux-2.6.17-rc4_pci_bus_lock/drivers/pci/remove.c
--- linux-2.6.17-rc4/drivers/pci/remove.c	2006-04-20 21:19:24.000000000 +0800
+++ linux-2.6.17-rc4_pci_bus_lock/drivers/pci/remove.c	2006-05-31 15:15:26.000000000 +0800
@@ -22,18 +22,18 @@ static void pci_destroy_dev(struct pci_d
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		device_unregister(&dev->dev);
-		spin_lock(&pci_bus_lock);
+		down_write(&pci_bus_sem);
 		list_del(&dev->global_list);
 		dev->global_list.next = dev->global_list.prev = NULL;
-		spin_unlock(&pci_bus_lock);
+		up_write(&pci_bus_sem);
 	}
 
 	/* Remove the device from the device lists, and prevent any further
 	 * list accesses from this device */
-	spin_lock(&pci_bus_lock);
+	down_write(&pci_bus_sem);
 	list_del(&dev->bus_list);
 	dev->bus_list.next = dev->bus_list.prev = NULL;
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 
 	pci_free_resources(dev);
 	pci_dev_put(dev);
@@ -62,9 +62,9 @@ void pci_remove_bus(struct pci_bus *pci_
 {
 	pci_proc_detach_bus(pci_bus);
 
-	spin_lock(&pci_bus_lock);
+	down_write(&pci_bus_sem);
 	list_del(&pci_bus->node);
-	spin_unlock(&pci_bus_lock);
+	up_write(&pci_bus_sem);
 	pci_remove_legacy_files(pci_bus);
 	class_device_remove_file(&pci_bus->class_dev,
 		&class_device_attr_cpuaffinity);
diff -Nraup linux-2.6.17-rc4/drivers/pci/search.c linux-2.6.17-rc4_pci_bus_lock/drivers/pci/search.c
--- linux-2.6.17-rc4/drivers/pci/search.c	2006-05-17 17:16:24.000000000 +0800
+++ linux-2.6.17-rc4_pci_bus_lock/drivers/pci/search.c	2006-05-31 11:03:45.000000000 +0800
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include "pci.h"
 
-DEFINE_SPINLOCK(pci_bus_lock);
+DECLARE_RWSEM(pci_bus_sem);
 
 static struct pci_bus * __devinit
 pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)
@@ -72,11 +72,11 @@ pci_find_next_bus(const struct pci_bus *
 	struct pci_bus *b = NULL;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	n = from ? from->node.next : pci_root_buses.next;
 	if (n != &pci_root_buses)
 		b = pci_bus_b(n);
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	return b;
 }
 
@@ -124,7 +124,7 @@ struct pci_dev * pci_get_slot(struct pci
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 
 	list_for_each(tmp, &bus->devices) {
 		dev = pci_dev_b(tmp);
@@ -135,7 +135,7 @@ struct pci_dev * pci_get_slot(struct pci
 	dev = NULL;
  out:
 	pci_dev_get(dev);
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	return dev;
 }
 
@@ -167,7 +167,7 @@ static struct pci_dev * pci_find_subsys(
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
 	while (n && (n != &pci_devices)) {
@@ -181,7 +181,7 @@ static struct pci_dev * pci_find_subsys(
 	}
 	dev = NULL;
 exit:
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	return dev;
 }
 
@@ -232,7 +232,7 @@ pci_get_subsys(unsigned int vendor, unsi
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
 	while (n && (n != &pci_devices)) {
@@ -247,7 +247,7 @@ pci_get_subsys(unsigned int vendor, unsi
 	dev = NULL;
 exit:
 	dev = pci_dev_get(dev);
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	pci_dev_put(from);
 	return dev;
 }
@@ -292,7 +292,7 @@ pci_find_device_reverse(unsigned int ven
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	n = from ? from->global_list.prev : pci_devices.prev;
 
 	while (n && (n != &pci_devices)) {
@@ -304,7 +304,7 @@ pci_find_device_reverse(unsigned int ven
 	}
 	dev = NULL;
 exit:
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	return dev;
 }
 
@@ -328,7 +328,7 @@ struct pci_dev *pci_get_class(unsigned i
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
 	while (n && (n != &pci_devices)) {
@@ -340,7 +340,7 @@ struct pci_dev *pci_get_class(unsigned i
 	dev = NULL;
 exit:
 	dev = pci_dev_get(dev);
-	spin_unlock(&pci_bus_lock);
+	up_read(&pci_bus_sem);
 	pci_dev_put(from);
 	return dev;
 }
@@ -362,7 +362,7 @@ int pci_dev_present(const struct pci_dev
 	int found = 0;
 
 	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
+	down_read(&pci_bus_sem);
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
 		list_for_each_entry(dev, &pci_devices, global_list) {
 			if (pci_match_one_device(ids, dev)) {
@@ -372,8 +372,8 @@ int pci_dev_present(const struct pci_dev
 		}
 		ids++;
 	}
-exit:				
-	spin_unlock(&pci_bus_lock);
+exit:
+	up_read(&pci_bus_sem);
 	return found;
 }
 EXPORT_SYMBOL(pci_dev_present);
