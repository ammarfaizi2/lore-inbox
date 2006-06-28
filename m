Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWF1N5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWF1N5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423330AbWF1N5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:57:34 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:7328 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750877AbWF1N5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:57:34 -0400
Message-ID: <44A28AA2.6060306@interia.pl>
Date: Wed, 28 Jun 2006 15:56:50 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul
 by rw semaphores
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 46c48acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch will allow Longhaul cpufreq driver to change frequency
without breaking BMDMA. In order to work properly it needs:
- adding rw_semaphore to pci_device and bus structures - this is
patch below,
- Longhaul should find host bridge and lock write on bus before
frequency change,
- device driver support - device should lock read its bus before
starting DMA transfer. I have curently implemented this for ide
layer (tested with via82cxxx), libata (not tested, but this is similar
code to ide) and VIA Rhine network card driver.
	I don't know if this is acceptable infrastructure, but I hope it is
less horrible then last. Is this infrastructure at all?

	This patch is adding 2 functions to pci structures: "acquire" and
"release". Driver calls "acquire" before starting transfer, with
PCI_ACQUIRE_EXCLUSIVE if it needs exclusive access to device (bus is
always PCI_ACQUIRE_SHARED) or with PCI_ACQUIRE_SHARED if device have
own hardware queue. Ide and libata are using PCI_ACQUIRE_EXCLUSIVE.
VIA Rhine driver is using PCI_ACQUIRE_SHARED.
	Note: "acquire" may sleep. But in Linux 2.6 we can use
workqueues and I'm using them.

Signed-off-by: Rafa³ Bilski <rafalbilski@interia.pl>

---

diff -uprN -X linux-2.6.17-vanilla/Documentation/dontdiff linux-2.6.17-vanilla/drivers/pci/probe.c linux-2.6.17/drivers/pci/probe.c
--- linux-2.6.17-vanilla/drivers/pci/probe.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/pci/probe.c	2006-06-28 09:03:20.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/rwsem.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -315,6 +316,34 @@ void __devinit pci_read_bridge_bases(str
 	}
 }
 
+/**
+ * Generic bus locking
+ */
+
+#ifdef CONFIG_X86_LONGHAUL
+static void pci_bus_acquire(struct pci_bus *bus, int flags)
+{
+	if (bus->parent && bus->parent->acquire)
+		bus->parent->acquire(bus->parent, PCI_ACQUIRE_SHARED);
+	if (flags & PCI_ACQUIRE_EXCLUSIVE) {
+		down_write(&bus->access_sem);
+	} else {
+		down_read(&bus->access_sem);
+	}
+}
+
+static void pci_bus_release(struct pci_bus *bus, int flags)
+{
+	if (flags & PCI_ACQUIRE_EXCLUSIVE) {
+		up_write(&bus->access_sem);
+	} else {
+		up_read(&bus->access_sem);
+	}
+	if (bus->parent && bus->parent->release)
+		bus->parent->release(bus->parent, PCI_ACQUIRE_SHARED);
+}
+#endif
+
 static struct pci_bus * __devinit pci_alloc_bus(void)
 {
 	struct pci_bus *b;
@@ -324,6 +353,12 @@ static struct pci_bus * __devinit pci_al
 		INIT_LIST_HEAD(&b->node);
 		INIT_LIST_HEAD(&b->children);
 		INIT_LIST_HEAD(&b->devices);
+
+#ifdef CONFIG_X86_LONGHAUL
+		init_rwsem(&b->access_sem);
+		b->acquire = &pci_bus_acquire;
+	    	b->release = &pci_bus_release;
+#endif
 	}
 	return b;
 }
@@ -622,6 +657,34 @@ static void pci_read_irq(struct pci_dev 
 }
 
 /**
+ * Generic device locking
+ */
+
+#ifdef CONFIG_X86_LONGHAUL
+static void pci_generic_acquire(struct pci_dev *dev, int flags)
+{
+	if (dev->bus && dev->bus->acquire)
+		dev->bus->acquire(dev->bus, PCI_ACQUIRE_SHARED);
+	if (flags & PCI_ACQUIRE_EXCLUSIVE) {
+		down_write(&dev->access_sem);
+	} else {
+		down_read(&dev->access_sem);
+	}
+}
+
+static void pci_generic_release(struct pci_dev *dev, int flags)
+{
+	if (flags & PCI_ACQUIRE_EXCLUSIVE) {
+		up_write(&dev->access_sem);
+	} else {
+		up_read(&dev->access_sem);
+	}
+	if (dev->bus && dev->bus->release)
+		dev->bus->release(dev->bus, PCI_ACQUIRE_SHARED);
+}
+#endif
+
+/**
  * pci_setup_device - fill in class and map information of a device
  * @dev: the device structure to fill
  *
@@ -638,6 +701,11 @@ static int pci_setup_device(struct pci_d
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 
+#ifdef CONFIG_X86_LONGHAUL
+	init_rwsem(&dev->access_sem);
+	dev->acquire = &pci_generic_acquire;
+	dev->release = &pci_generic_release;
+#endif
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	class >>= 8;				    /* upper 3 bytes */
 	dev->class = class;
diff -uprN -X linux-2.6.17-vanilla/Documentation/dontdiff linux-2.6.17-vanilla/include/linux/pci.h linux-2.6.17/include/linux/pci.h
--- linux-2.6.17-vanilla/include/linux/pci.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/include/linux/pci.h	2006-06-28 08:49:46.000000000 +0200
@@ -52,6 +52,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/rwsem.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -169,6 +170,13 @@ struct pci_dev {
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
+#ifdef CONFIG_X86_LONGHAUL
+	struct rw_semaphore	access_sem;	/* Access control to device */
+	void (*acquire) (struct pci_dev *dev, int flags);
+	void (*release) (struct pci_dev *dev, int flags);
+#define PCI_ACQUIRE_SHARED		0
+#define PCI_ACQUIRE_EXCLUSIVE		(1 << 0)
+#endif
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -226,7 +234,6 @@ struct pci_bus {
 	struct pci_dev	*self;		/* bridge device as seen by parent */
 	struct resource	*resource[PCI_BUS_NUM_RESOURCES];
 					/* address space routed to this bus */
-
 	struct pci_ops	*ops;		/* configuration access functions */
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
@@ -244,6 +251,11 @@ struct pci_bus {
 	struct class_device	class_dev;
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem; /* legacy mem */
+#ifdef CONFIG_X86_LONGHAUL
+	struct rw_semaphore	access_sem;	/* Access control to bus */
+	void (*acquire) (struct pci_bus *bus, int flags);
+	void (*release) (struct pci_bus *bus, int flags);
+#endif
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)




----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

