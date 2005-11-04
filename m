Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030582AbVKDAx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbVKDAx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbVKDAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:53:56 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:9620 "EHLO
	mail.gnucash.org") by vger.kernel.org with ESMTP id S1030581AbVKDAxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:53:19 -0500
Date: Thu, 3 Nov 2005 18:53:07 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 25/42]: ppc64: Split out PCI address cache to its own file
Message-ID: <20051104005307.GA27041@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

25-pci-address-cache.patch

The core EEH files is rather large. This patch splits out a self-contained
chunk of it into its own file.  This is the chunk that performes the 
caching and lookup of pci devices based on the i/o addresses of thier
resoures.  This code is almos archiecture-independent and could be 
used by any system that wanted to find a pci device based only on 
the i/o address used by the device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/Makefile	2005-11-02 14:41:48.393250352 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/Makefile	2005-11-02 14:42:58.323443756 -0600
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_IBMVIO)	+= vio.o
 obj-$(CONFIG_XICS)	+= xics.o
-obj-$(CONFIG_EEH)    += eeh.o eeh_driver.o eeh_event.o
+obj-$(CONFIG_EEH)    += eeh.o eeh_cache.o eeh_driver.o eeh_event.o
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:41:18.427452474 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:42:38.986155538 -0600
@@ -77,9 +77,6 @@
  */
 #define EEH_MAX_FAILS	100000
 
-/* Misc forward declaraions */
-static void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn);
-
 /* RTAS tokens */
 static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
@@ -107,296 +104,8 @@
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
 static DEFINE_PER_CPU(unsigned long, slot_resets);
 
-/**
- * The pci address cache subsystem.  This subsystem places
- * PCI device address resources into a red-black tree, sorted
- * according to the address range, so that given only an i/o
- * address, the corresponding PCI device can be **quickly**
- * found. It is safe to perform an address lookup in an interrupt
- * context; this ability is an important feature.
- *
- * Currently, the only customer of this code is the EEH subsystem;
- * thus, this code has been somewhat tailored to suit EEH better.
- * In particular, the cache does *not* hold the addresses of devices
- * for which EEH is not enabled.
- *
- * (Implementation Note: The RB tree seems to be better/faster
- * than any hash algo I could think of for this problem, even
- * with the penalty of slow pointer chases for d-cache misses).
- */
-struct pci_io_addr_range
-{
-	struct rb_node rb_node;
-	unsigned long addr_lo;
-	unsigned long addr_hi;
-	struct pci_dev *pcidev;
-	unsigned int flags;
-};
-
-static struct pci_io_addr_cache
-{
-	struct rb_root rb_root;
-	spinlock_t piar_lock;
-} pci_io_addr_cache_root;
-
-static inline struct pci_dev *__pci_get_device_by_addr(unsigned long addr)
-{
-	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
-
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-
-		if (addr < piar->addr_lo) {
-			n = n->rb_left;
-		} else {
-			if (addr > piar->addr_hi) {
-				n = n->rb_right;
-			} else {
-				pci_dev_get(piar->pcidev);
-				return piar->pcidev;
-			}
-		}
-	}
-
-	return NULL;
-}
-
-/**
- * pci_get_device_by_addr - Get device, given only address
- * @addr: mmio (PIO) phys address or i/o port number
- *
- * Given an mmio phys address, or a port number, find a pci device
- * that implements this address.  Be sure to pci_dev_put the device
- * when finished.  I/O port numbers are assumed to be offset
- * from zero (that is, they do *not* have pci_io_addr added in).
- * It is safe to call this function within an interrupt.
- */
-static struct pci_dev *pci_get_device_by_addr(unsigned long addr)
-{
-	struct pci_dev *dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	dev = __pci_get_device_by_addr(addr);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-	return dev;
-}
-
-#ifdef DEBUG
-/*
- * Handy-dandy debug print routine, does nothing more
- * than print out the contents of our addr cache.
- */
-static void pci_addr_cache_print(struct pci_io_addr_cache *cache)
-{
-	struct rb_node *n;
-	int cnt = 0;
-
-	n = rb_first(&cache->rb_root);
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-		printk(KERN_DEBUG "PCI: %s addr range %d [%lx-%lx]: %s\n",
-		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
-		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
-		cnt++;
-		n = rb_next(n);
-	}
-}
-#endif
-
-/* Insert address range into the rb tree. */
-static struct pci_io_addr_range *
-pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
-		      unsigned long ahi, unsigned int flags)
-{
-	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct pci_io_addr_range *piar;
-
-	/* Walk tree, find a place to insert into tree */
-	while (*p) {
-		parent = *p;
-		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (ahi < piar->addr_lo) {
-			p = &parent->rb_left;
-		} else if (alo > piar->addr_hi) {
-			p = &parent->rb_right;
-		} else {
-			if (dev != piar->pcidev ||
-			    alo != piar->addr_lo || ahi != piar->addr_hi) {
-				printk(KERN_WARNING "PIAR: overlapping address range\n");
-			}
-			return piar;
-		}
-	}
-	piar = (struct pci_io_addr_range *)kmalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
-	if (!piar)
-		return NULL;
-
-	piar->addr_lo = alo;
-	piar->addr_hi = ahi;
-	piar->pcidev = dev;
-	piar->flags = flags;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
-	                  alo, ahi, pci_name (dev));
-#endif
-
-	rb_link_node(&piar->rb_node, parent, p);
-	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
-
-	return piar;
-}
-
-static void __pci_addr_cache_insert_device(struct pci_dev *dev)
-{
-	struct device_node *dn;
-	struct pci_dn *pdn;
-	int i;
-	int inserted = 0;
-
-	dn = pci_device_to_OF_node(dev);
-	if (!dn) {
-		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n", pci_name(dev));
-		return;
-	}
-
-	/* Skip any devices for which EEH is not enabled. */
-	pdn = PCI_DN(dn);
-	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
-	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
-#ifdef DEBUG
-		printk(KERN_INFO "PCI: skip building address cache for=%s - %s\n",
-		       pci_name(dev), pdn->node->full_name);
-#endif
-		return;
-	}
-
-	/* The cache holds a reference to the device... */
-	pci_dev_get(dev);
-
-	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long start = pci_resource_start(dev,i);
-		unsigned long end = pci_resource_end(dev,i);
-		unsigned int flags = pci_resource_flags(dev,i);
-
-		/* We are interested only bus addresses, not dma or other stuff */
-		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
-			 continue;
-		pci_addr_cache_insert(dev, start, end, flags);
-		inserted = 1;
-	}
-
-	/* If there was nothing to add, the cache has no reference... */
-	if (!inserted)
-		pci_dev_put(dev);
-}
-
-/**
- * pci_addr_cache_insert_device - Add a device to the address cache
- * @dev: PCI device whose I/O addresses we are interested in.
- *
- * In order to support the fast lookup of devices based on addresses,
- * we maintain a cache of devices that can be quickly searched.
- * This routine adds a device to that cache.
- */
-static void pci_addr_cache_insert_device(struct pci_dev *dev)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	__pci_addr_cache_insert_device(dev);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-}
-
-static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
-{
-	struct rb_node *n;
-	int removed = 0;
-
-restart:
-	n = rb_first(&pci_io_addr_cache_root.rb_root);
-	while (n) {
-		struct pci_io_addr_range *piar;
-		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-
-		if (piar->pcidev == dev) {
-			rb_erase(n, &pci_io_addr_cache_root.rb_root);
-			removed = 1;
-			kfree(piar);
-			goto restart;
-		}
-		n = rb_next(n);
-	}
-
-	/* The cache no longer holds its reference to this device... */
-	if (removed)
-		pci_dev_put(dev);
-}
-
-/**
- * pci_addr_cache_remove_device - remove pci device from addr cache
- * @dev: device to remove
- *
- * Remove a device from the addr-cache tree.
- * This is potentially expensive, since it will walk
- * the tree multiple times (once per resource).
- * But so what; device removal doesn't need to be that fast.
- */
-static void pci_addr_cache_remove_device(struct pci_dev *dev)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	__pci_addr_cache_remove_device(dev);
-	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-}
-
-/**
- * pci_addr_cache_build - Build a cache of I/O addresses
- *
- * Build a cache of pci i/o addresses.  This cache will be used to
- * find the pci device that corresponds to a given address.
- * This routine scans all pci busses to build the cache.
- * Must be run late in boot process, after the pci controllers
- * have been scaned for devices (after all device resources are known).
- */
-void __init pci_addr_cache_build(void)
-{
-	struct device_node *dn;
-	struct pci_dev *dev = NULL;
-
-	if (!eeh_subsystem_enabled)
-		return;
-
-	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
-
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		/* Ignore PCI bridges ( XXX why ??) */
-		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
-			continue;
-		}
-		pci_addr_cache_insert_device(dev);
-
-		/* Save the BAR's; firmware doesn't restore these after EEH reset */
-		dn = pci_device_to_OF_node(dev);
-		eeh_save_bars(dev, PCI_DN(dn));
-	}
-
-#ifdef DEBUG
-	/* Verify tree built up above, echo back the list of addrs. */
-	pci_addr_cache_print(&pci_io_addr_cache_root);
-#endif
-}
-
 /* --------------------------------------------------------------- */
-/* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
+/* Below lies the EEH event infrastructure */
 
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity)
 {
@@ -880,7 +589,7 @@
  * PCI devices are added individuallly; but, for the restore,
  * an entire slot is reset at a time.
  */
-static void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn)
+void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn)
 {
 	int i;
 
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_cache.c	2005-11-02 14:42:38.994154417 -0600
@@ -0,0 +1,317 @@
+/*
+ * eeh_cache.c
+ * PCI address cache; allows the lookup of PCI devices based on I/O address
+ *
+ * Copyright (C) 2004 Linas Vepstas <linas@austin.ibm.com> IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/systemcfg.h>
+
+#undef DEBUG
+
+/**
+ * The pci address cache subsystem.  This subsystem places
+ * PCI device address resources into a red-black tree, sorted
+ * according to the address range, so that given only an i/o
+ * address, the corresponding PCI device can be **quickly**
+ * found. It is safe to perform an address lookup in an interrupt
+ * context; this ability is an important feature.
+ *
+ * Currently, the only customer of this code is the EEH subsystem;
+ * thus, this code has been somewhat tailored to suit EEH better.
+ * In particular, the cache does *not* hold the addresses of devices
+ * for which EEH is not enabled.
+ *
+ * (Implementation Note: The RB tree seems to be better/faster
+ * than any hash algo I could think of for this problem, even
+ * with the penalty of slow pointer chases for d-cache misses).
+ */
+struct pci_io_addr_range
+{
+	struct rb_node rb_node;
+	unsigned long addr_lo;
+	unsigned long addr_hi;
+	struct pci_dev *pcidev;
+	unsigned int flags;
+};
+
+static struct pci_io_addr_cache
+{
+	struct rb_root rb_root;
+	spinlock_t piar_lock;
+} pci_io_addr_cache_root;
+
+static inline struct pci_dev *__pci_get_device_by_addr(unsigned long addr)
+{
+	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
+
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		if (addr < piar->addr_lo) {
+			n = n->rb_left;
+		} else {
+			if (addr > piar->addr_hi) {
+				n = n->rb_right;
+			} else {
+				pci_dev_get(piar->pcidev);
+				return piar->pcidev;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * pci_get_device_by_addr - Get device, given only address
+ * @addr: mmio (PIO) phys address or i/o port number
+ *
+ * Given an mmio phys address, or a port number, find a pci device
+ * that implements this address.  Be sure to pci_dev_put the device
+ * when finished.  I/O port numbers are assumed to be offset
+ * from zero (that is, they do *not* have pci_io_addr added in).
+ * It is safe to call this function within an interrupt.
+ */
+struct pci_dev *pci_get_device_by_addr(unsigned long addr)
+{
+	struct pci_dev *dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	dev = __pci_get_device_by_addr(addr);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+	return dev;
+}
+
+#ifdef DEBUG
+/*
+ * Handy-dandy debug print routine, does nothing more
+ * than print out the contents of our addr cache.
+ */
+static void pci_addr_cache_print(struct pci_io_addr_cache *cache)
+{
+	struct rb_node *n;
+	int cnt = 0;
+
+	n = rb_first(&cache->rb_root);
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+		printk(KERN_DEBUG "PCI: %s addr range %d [%lx-%lx]: %s\n",
+		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
+		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
+		cnt++;
+		n = rb_next(n);
+	}
+}
+#endif
+
+/* Insert address range into the rb tree. */
+static struct pci_io_addr_range *
+pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
+		      unsigned long ahi, unsigned int flags)
+{
+	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct pci_io_addr_range *piar;
+
+	/* Walk tree, find a place to insert into tree */
+	while (*p) {
+		parent = *p;
+		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
+		if (ahi < piar->addr_lo) {
+			p = &parent->rb_left;
+		} else if (alo > piar->addr_hi) {
+			p = &parent->rb_right;
+		} else {
+			if (dev != piar->pcidev ||
+			    alo != piar->addr_lo || ahi != piar->addr_hi) {
+				printk(KERN_WARNING "PIAR: overlapping address range\n");
+			}
+			return piar;
+		}
+	}
+	piar = (struct pci_io_addr_range *)kmalloc(sizeof(struct pci_io_addr_range), GFP_ATOMIC);
+	if (!piar)
+		return NULL;
+
+	piar->addr_lo = alo;
+	piar->addr_hi = ahi;
+	piar->pcidev = dev;
+	piar->flags = flags;
+
+#ifdef DEBUG
+	printk(KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
+	                  alo, ahi, pci_name (dev));
+#endif
+
+	rb_link_node(&piar->rb_node, parent, p);
+	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
+
+	return piar;
+}
+
+static void __pci_addr_cache_insert_device(struct pci_dev *dev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+	int i;
+	int inserted = 0;
+
+	dn = pci_device_to_OF_node(dev);
+	if (!dn) {
+		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n", pci_name(dev));
+		return;
+	}
+
+	/* Skip any devices for which EEH is not enabled. */
+	pdn = PCI_DN(dn);
+	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
+	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
+#ifdef DEBUG
+		printk(KERN_INFO "PCI: skip building address cache for=%s - %s\n",
+		       pci_name(dev), pdn->node->full_name);
+#endif
+		return;
+	}
+
+	/* The cache holds a reference to the device... */
+	pci_dev_get(dev);
+
+	/* Walk resources on this device, poke them into the tree */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long start = pci_resource_start(dev,i);
+		unsigned long end = pci_resource_end(dev,i);
+		unsigned int flags = pci_resource_flags(dev,i);
+
+		/* We are interested only bus addresses, not dma or other stuff */
+		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
+			 continue;
+		pci_addr_cache_insert(dev, start, end, flags);
+		inserted = 1;
+	}
+
+	/* If there was nothing to add, the cache has no reference... */
+	if (!inserted)
+		pci_dev_put(dev);
+}
+
+/**
+ * pci_addr_cache_insert_device - Add a device to the address cache
+ * @dev: PCI device whose I/O addresses we are interested in.
+ *
+ * In order to support the fast lookup of devices based on addresses,
+ * we maintain a cache of devices that can be quickly searched.
+ * This routine adds a device to that cache.
+ */
+void pci_addr_cache_insert_device(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	__pci_addr_cache_insert_device(dev);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+}
+
+static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
+{
+	struct rb_node *n;
+	int removed = 0;
+
+restart:
+	n = rb_first(&pci_io_addr_cache_root.rb_root);
+	while (n) {
+		struct pci_io_addr_range *piar;
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		if (piar->pcidev == dev) {
+			rb_erase(n, &pci_io_addr_cache_root.rb_root);
+			removed = 1;
+			kfree(piar);
+			goto restart;
+		}
+		n = rb_next(n);
+	}
+
+	/* The cache no longer holds its reference to this device... */
+	if (removed)
+		pci_dev_put(dev);
+}
+
+/**
+ * pci_addr_cache_remove_device - remove pci device from addr cache
+ * @dev: device to remove
+ *
+ * Remove a device from the addr-cache tree.
+ * This is potentially expensive, since it will walk
+ * the tree multiple times (once per resource).
+ * But so what; device removal doesn't need to be that fast.
+ */
+void pci_addr_cache_remove_device(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
+	__pci_addr_cache_remove_device(dev);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
+}
+
+/**
+ * pci_addr_cache_build - Build a cache of I/O addresses
+ *
+ * Build a cache of pci i/o addresses.  This cache will be used to
+ * find the pci device that corresponds to a given address.
+ * This routine scans all pci busses to build the cache.
+ * Must be run late in boot process, after the pci controllers
+ * have been scaned for devices (after all device resources are known).
+ */
+void __init pci_addr_cache_build(void)
+{
+	struct device_node *dn;
+	struct pci_dev *dev = NULL;
+
+	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
+
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		/* Ignore PCI bridges */
+		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+			continue;
+
+		pci_addr_cache_insert_device(dev);
+
+		/* Save the BAR's; firmware doesn't restore these after EEH reset */
+		dn = pci_device_to_OF_node(dev);
+		eeh_save_bars(dev, PCI_DN(dn));
+	}
+
+#ifdef DEBUG
+	/* Verify tree built up above, echo back the list of addrs. */
+	pci_addr_cache_print(&pci_io_addr_cache_root);
+#endif
+}
+
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-11-02 14:41:18.454448689 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-11-02 14:42:38.998153856 -0600
@@ -53,6 +53,14 @@
 
 /* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
+
+void pci_addr_cache_insert_device(struct pci_dev *dev);
+void pci_addr_cache_remove_device(struct pci_dev *dev);
+void pci_addr_cache_build(void);
+struct pci_dev *pci_get_device_by_addr(unsigned long addr);
+
+void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn);
+
 /**
  * eeh_slot_error_detail -- record and EEH error condition to the log
  * @severity: 1 if temporary, 2 if permanent failure.
