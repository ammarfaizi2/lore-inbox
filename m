Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSKIMQZ>; Sat, 9 Nov 2002 07:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbSKIMQZ>; Sat, 9 Nov 2002 07:16:25 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:12431 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264702AbSKIMQN>; Sat, 9 Nov 2002 07:16:13 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 9 Nov 2002 04:22:42 -0800
Message-Id: <200211091222.EAA26552@baldur.yggdrasil.com>
To: willy@debian.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Cc: andmike@us.ibm.com, hch@lst.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>On Fri, Nov 08, 2002 at 08:51:28PM -0800, Adam J. Richter wrote:
>> My patch is a net deletion of 57 lines and will allow simplification
>> of parisc DMA allocation.
>
>57 lines of clean elegant code, replacing them with overly generic ugly
>code and bloated data structures.

	You'd really have to gerrymander to pick a standard by which
my code is "ugly" and what it deletes is "clean and elegant."  I leave
it to other interested readers to look at my patch and judge.

>struct device is a round 256 bytes
>on x86.  more on 64-bit architectures.

	Here is an updated version of my completely untested patch
that replaces parisc_device.name[] with parisc_device.device.name[].

	sizeof(struct device), at least on x86	244 bytes
	5 pointers removed from parisc_device   -40 bytes
	parisc_device.name moved to .device	-80 bytes
						---------
	Size cost of using struct device	124 bytes per parisc_device

	There are ten drivers in drivers/parisc and arch/parisc that
define a struct parisc_driver.  Perhaps you'll have an average of ~1.5
of each such device in a parisc system or maybe ten struct
parisc_device's and a similar number of parisc_driver's.  So, you're
talking about perhaps 2kB of additional space for parisc_device's,
perhaps 3kB including the parisc_driver's.

	This space cost would be reduced somewhat by the shrinkage to
arch/parisc/kernel/drivers.c, and this code will enable other
simplifications.  Even without those other simplificatins, this code
may be a net space savings on some systems.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

diff -u -r linux-2.5.46/include/asm-parisc/hardware.h linux/include/asm-parisc/hardware.h
--- linux-2.5.46/include/asm-parisc/hardware.h	Wed Oct 30 21:32:15 2002
+++ linux/include/asm-parisc/hardware.h	Sat Nov  9 03:07:23 2002
@@ -1,6 +1,7 @@
 #ifndef _PARISC_HARDWARE_H
 #define _PARISC_HARDWARE_H
 
+#include <linux/device.h>
 #include <asm/pdc.h>
 
 struct parisc_device_id {
@@ -26,14 +27,9 @@
 struct parisc_device {
 	unsigned long   hpa;		/* Hard Physical Address */
 	struct parisc_device_id id;
-	struct parisc_device *parent;
-	struct parisc_device *sibling;
-	struct parisc_device *child;
-	struct parisc_driver *driver;	/* Driver for this device */
-	void		*sysdata;	/* Driver instance private data */
-	char		name[80];	/* The hardware description */
 	int		irq;
 
+	struct device	device;
 	char		hw_path;        /* The module number on this bus */
 	unsigned int	num_addrs;	/* some devices have additional address ranges. */
 	unsigned long	*addr;          /* which will be stored here */
@@ -66,10 +62,9 @@
 extern char *cpu_name_version[][2]; /* mapping from enum cpu_type to strings */
 
 struct parisc_driver {
-	struct parisc_driver *next;
-	char *name; 
 	const struct parisc_device_id *id_table;
 	int (*probe) (struct parisc_device *dev); /* New device discovered */
+	struct device_driver driver;
 };
 
 struct io_module {
@@ -128,6 +123,26 @@
 #define HPHW_FAULTY    31
 
 
+static inline struct parisc_device *to_parisc_dev(struct device *dev)
+{
+	return container_of(dev, struct parisc_device, device);
+}
+
+static inline struct parisc_driver *to_parisc_drv(struct driver *dev)
+{
+	return container_of(drv, struct parisc_driver, driver);
+}
+
+static inline void *parisc_get_drvdata(struct parisc_device *pa_dev)
+{
+	return dev_get_drvdata(pa_dev->device);
+}
+
+static inline void parisc_set_drvdata(struct parisc_device *pa_dev, void *ptr)
+{
+	dev_set_drvdata(pa_dev->device, ptr);
+}
+
 /* hardware.c: */
 extern const char *parisc_hardware_description(struct parisc_device_id *id);
 extern enum cpu_type parisc_get_cpu_type(unsigned long hversion);
@@ -135,12 +150,13 @@
 struct pci_dev;
 
 /* drivers.c: */
+extern struct bus_type parisc_bus_type;
 extern struct parisc_device *alloc_pa_dev(unsigned long hpa,
 		struct hardware_path *path);
 extern int register_parisc_device(struct parisc_device *dev);
 extern int register_parisc_driver(struct parisc_driver *driver);
 extern int count_parisc_driver(struct parisc_driver *driver);
-extern int unregister_parisc_driver(struct parisc_driver *driver);
+extern void unregister_parisc_driver(struct parisc_driver *driver);
 extern void walk_central_bus(void);
 extern void fixup_child_irqs(struct parisc_device *parent, int irqbase,
 		int (*choose)(struct parisc_device *parent));
diff -u -r linux-2.5.46/arch/parisc/kernel/drivers.c linux/arch/parisc/kernel/drivers.c
--- linux-2.5.46/arch/parisc/kernel/drivers.c	Mon Nov  4 21:35:43 2002
+++ linux/arch/parisc/kernel/drivers.c	Sat Nov  9 03:21:25 2002
@@ -27,17 +27,8 @@
 /* See comments in include/asm-parisc/pci.h */
 struct pci_dma_ops *hppa_dma_ops;
 
-static struct parisc_driver *pa_drivers;
 static struct parisc_device root;
 
-/* This lock protects the pa_drivers list _only_ since all parisc_devices
- * are registered before smp_init() is called.  If you wish to add devices
- * after that, this muct be serialised somehow.  I recommend a semaphore
- * rather than a spinlock since driver ->probe functions are allowed to
- * sleep (for example when allocating memory).
- */
-static spinlock_t pa_lock = SPIN_LOCK_UNLOCKED;
-
 #define for_each_padev(dev) \
 	for (dev = root.child; dev != NULL; dev = next_dev(dev))
 
@@ -53,20 +44,13 @@
  */
 struct parisc_device *next_dev(struct parisc_device *dev)
 {
-	if (dev->child) {
-		return check_dev(dev->child);
-	} else if (dev->sibling) {
-		return dev->sibling;
-	}
+	struct device *next =
+		list_entry(dev->device.next, struct device, g_list);
 
-	/* Exhausted tree at this level, time to go up. */
-	do {
-		dev = dev->parent;
-		if (dev && dev->sibling)
-			return dev->sibling;
-	} while (dev != &root);
-
-	return NULL;
+	if (next->parent == NULL) /* end of list.  back at root */
+		return NULL;
+	else
+		return container_of(next, struct parisc_device, device);
 }
 
 /**
@@ -74,8 +58,11 @@
  * @driver: the PA-RISC driver to try
  * @dev: the PA-RISC device to try
  */
-static int match_device(struct parisc_driver *driver, struct parisc_device *dev)
+static int
+parisc_match_device(struct device_driver *gendrv, struct device *gendev)
 {
+	struct parisc_driver *driver = to_parisc_driver(gendrv);
+	struct parisc_device *dev = to_parisc_device(gendev);
 	const struct parisc_device_id *ids;
 
 	for (ids = driver->id_table; ids->sversion; ids++) {
@@ -96,10 +83,17 @@
 	return 0;
 }
 
-static void claim_device(struct parisc_driver *driver, struct parisc_device *dev)
+static int parisc_device_probe(struct device *dev)
 {
-	dev->driver = driver;
-	request_mem_region(dev->hpa, 0x1000, driver->name);
+	struct parisc_device *pa_dev = to_parisc_device(dev);
+	struct device_driver *drv = dev->driver;
+	struct parisc_driver *pa_drv = to_parisc_driver(drv);
+	int err = (*pa_drv->probe)(pa_dev);
+
+	if (!err)
+		request_mem_region(dev->hpa, 0x1000, drv->name);
+
+	return err;
 }
 
 /**
@@ -108,37 +102,22 @@
  */
 int register_parisc_driver(struct parisc_driver *driver)
 {
-	struct parisc_device *device;
-
-	if (driver->next) {
-		printk(KERN_WARNING 
-		       "BUG: Skipping previously registered driver: %s\n",
-		       driver->name);
-		return 1;
-	}
-
-	for_each_padev(device) {
-		if (device->driver)
-			continue;
-		if (!match_device(driver, device))
-			continue;
-
-		if (driver->probe(device) < 0)
-			continue;
-		claim_device(driver, device);
-	}
+	driver->driver.bus_type = &parisc_bus_type;
+	driver->driver.probe = parisc_device_probe;
+	return driver_register(&driver->driver);
+}
 
-	/* Note that the list is in reverse order of registration.  This
-	 * may be significant if we ever actually support hotplug and have
-	 * multiple drivers capable of claiming the same chip.
-	 */
-
-	spin_lock(&pa_lock);
-	driver->next = pa_drivers;
-	pa_drivers = driver;
-	spin_unlock(&pa_lock);
+struct count_arg {
+	struct driver *driver;
+	int count;
+};
 
-	return 0;
+static void count_callback(struct device *dev, void *data)
+{
+	struct count_arg *arg = data;
+	
+	if (parisc_match_device(&arg->driver, dev))
+		(arg->count)++;
 }
 
 /**
@@ -148,17 +127,14 @@
  * Use by IOMMU support to "guess" the right size IOPdir.
  * Formula is something like memsize/(num_iommu * entry_size).
  */
-int count_parisc_driver(struct parisc_driver *driver)
+int count_parisc_driver(struct parisc_driver *pa_driver)
 {
-	struct parisc_device *device;
-	int cnt = 0;
-
-	for_each_padev(device) {
-		if (match_device(driver, device))
-			cnt++;
-	}
-
-	return cnt;
+	struct count_arg arg;
+  
+	arg.driver = &pa_driver->driver;
+	arg.count = 0;
+	bus_for_each_dev(arg.driver->bus, &arg, count_callback);
+	return arg.count;
 }
 
 
@@ -167,42 +143,9 @@
  * unregister_parisc_driver - Unregister this driver from the list of drivers
  * @driver: the PA-RISC driver to unregister
  */
-int unregister_parisc_driver(struct parisc_driver *driver)
+void unregister_parisc_driver(struct parisc_driver *driver)
 {
-	struct parisc_device *dev;
-
-	spin_lock(&pa_lock);
-
-	if (pa_drivers == driver) {
-		/* was head of list - update head */
-		pa_drivers = driver->next;
-	} else {
-		struct parisc_driver *prev = pa_drivers;
-
-		while (prev && driver != prev->next) {
-			prev = prev->next;
-		}
-
-		if (!prev) {
-			printk(KERN_WARNING "unregister_parisc_driver: %s wasn't registered\n", driver->name);
-		} else {
-			/* Drop driver from list */
-			prev->next = driver->next;
-			driver->next = NULL;
-		}
-
-	}
-
-	spin_unlock(&pa_lock);
-
-	for_each_padev(dev) {
-		if (dev->driver != driver)
-			continue;
-		dev->driver = NULL;
-		release_mem_region(dev->hpa, 0x1000);
-	}
-
-	return 0;
+	driver_unregister(&driver->driver);
 }
 
 static struct parisc_device *find_device_by_addr(unsigned long hpa)
@@ -335,7 +278,8 @@
 	memset(dev, 0, sizeof(*dev));
 	dev->hw_path = id;
 	dev->id.hw_type = HPHW_FAULTY;
-	dev->parent = parent;
+	dev->device.bus_type = &parisc_bus_type;
+	dev->device.parent = &parent->device;
 	dev->sibling = *insert;
 	*insert = dev;
 	return dev;
@@ -417,7 +361,7 @@
 	dev->hpa = hpa;
 	name = parisc_hardware_description(&dev->id);
 	if (name) {
-		strncpy(dev->name, name, sizeof(dev->name)-1);
+		strncpy(dev->device.name, name, sizeof(dev->device.name)-1);
 	}
 
 	return dev;
@@ -429,32 +373,11 @@
  *
  * Search the driver list for a driver that is willing to manage
  * this device.
+ * WARNING: This routine now returns 0 on success. --Adam J. Richter 2002.11.08
  */
 int register_parisc_device(struct parisc_device *dev)
 {
-	struct parisc_driver *driver;
-
-	if (!dev)
-		return 0;
-
-	if (dev->driver)
-		return 1;
-	
-	spin_lock(&pa_lock);
-
-	/* Locate a driver which agrees to manage this device.  */
-	for (driver = pa_drivers; driver; driver = driver->next) {
-		if (!match_device(driver,dev))
-			continue;
-		if (driver->probe(dev) == 0)
-			break;
-	}
-
-	if (driver != NULL) {
-		claim_device(driver, dev);
-	}
-	spin_unlock(&pa_lock);
-	return driver != NULL;
+	return device_register(&dev->device);
 }
 
 #define BC_PORT_MASK 0x8
@@ -588,3 +511,8 @@
 		print_parisc_device(dev);
 	}
 }
+
+struct bus_type parisc_bus_type = {
+	.name =		"parisc",
+	.match =	parisc_match_device,
+};
diff -u -r linux-2.5.46/arch/parisc/kernel/perf.c linux/arch/parisc/kernel/perf.c
--- linux-2.5.46/arch/parisc/kernel/perf.c	Mon Nov  4 21:35:43 2002
+++ linux/arch/parisc/kernel/perf.c	Sat Nov  9 03:13:23 2002
@@ -527,7 +527,7 @@
 	/* TODO: this only lets us access the first cpu.. what to do for SMP? */
 	cpu_device = cpu_data[0].dev;
 	printk("Performance monitoring counters enabled for %s\n",
-		cpu_data[0].dev->name);
+		cpu_data[0].dev->device.name);
 
 	return 0;
 }
diff -u -r linux-2.5.46/arch/parisc/kernel/processor.c linux/arch/parisc/kernel/processor.c
--- linux-2.5.46/arch/parisc/kernel/processor.c	Mon Nov  4 21:35:44 2002
+++ linux/arch/parisc/kernel/processor.c	Sat Nov  9 03:13:04 2002
@@ -344,7 +344,7 @@
 				"model name\t: %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
 				 cpu_data[n].dev ? 
-				 cpu_data[n].dev->name : "Unknown" );
+				 cpu_data[n].dev->device.name : "Unknown" );
 
 		seq_printf(m, "hversion\t: 0x%08x\n"
 			        "sversion\t: 0x%08x\n",
@@ -370,9 +370,11 @@
 };
 
 static struct parisc_driver cpu_driver = {
-	name:		"CPU",
-	id_table:	processor_tbl,
-	probe:		processor_probe
+	.id_table =	processor_tbl,
+	.probe =	processor_probe
+	.driver = {
+		.name =		"CPU",
+	},
 };
 
 /**
diff -u -r linux-2.5.46/arch/parisc/kernel/setup.c linux/arch/parisc/kernel/setup.c
--- linux-2.5.46/arch/parisc/kernel/setup.c	Mon Nov  4 21:35:44 2002
+++ linux/arch/parisc/kernel/setup.c	Sat Nov  9 03:10:26 2002
@@ -216,24 +216,24 @@
 }
 
 static struct resource central_bus = {
-	name:	"Central Bus",
-	start:	(unsigned long)0xfffffffffff80000,
-	end:    (unsigned long)0xfffffffffffaffff,
-	flags:	IORESOURCE_MEM,
+	.name =		"Central Bus",
+	.start =	(unsigned long)0xfffffffffff80000,
+	.end =		(unsigned long)0xfffffffffffaffff,
+	.flags =	IORESOURCE_MEM,
 };
 
 static struct resource local_broadcast = {
-	name:	"Local Broadcast",
-	start:	(unsigned long)0xfffffffffffb0000,
-	end:	(unsigned long)0xfffffffffffdffff,
-	flags:	IORESOURCE_MEM,
+	.name =		"Local Broadcast",
+	.start =	(unsigned long)0xfffffffffffb0000,
+	.end =		(unsigned long)0xfffffffffffdffff,
+	.flags =	IORESOURCE_MEM,
 };
 
 static struct resource global_broadcast = {
-	name:	"Global Broadcast",
-	start:	(unsigned long)0xfffffffffffe0000,
-	end:	(unsigned long)0xffffffffffffffff,
-	flags:	IORESOURCE_MEM,
+	.name =		"Global Broadcast",
+	.start =	(unsigned long)0xfffffffffffe0000,
+	.end =		(unsigned long)0xffffffffffffffff,
+	.flags =	IORESOURCE_MEM,
 };
 
 int __init parisc_init_resources(void)
diff -u -r linux-2.5.46/drivers/parisc/sba_iommu.c linux/drivers/parisc/sba_iommu.c
--- linux-2.5.46/drivers/parisc/sba_iommu.c	Fri Nov  8 01:28:15 2002
+++ linux/drivers/parisc/sba_iommu.c	Fri Nov  8 01:43:35 2002
@@ -1988,7 +1988,7 @@
 		return(1);
 	}
 
-	dev->sysdata = (void *) sba_dev;
+	parisc_set_drvdata(dev, sba_dev);
 	memset(sba_dev, 0, sizeof(struct sba_device));
 
 	for(i=0; i<MAX_IOC; i++)
@@ -2041,7 +2041,7 @@
  */
 void * sba_get_iommu(struct parisc_device *pci_hba)
 {
-	struct sba_device *sba = (struct sba_device *) pci_hba->parent->sysdata;
+	struct sba_device *sba = parisc_get_drvdata(pci_hba->parent);
 	char t = pci_hba->parent->id.hw_type;
 	int iocnum = (pci_hba->hw_path >> 3);	/* rope # */
 
