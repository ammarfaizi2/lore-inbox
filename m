Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268330AbTBNKIR>; Fri, 14 Feb 2003 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268336AbTBNKIR>; Fri, 14 Feb 2003 05:08:17 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:37851 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S268335AbTBNKIE>; Fri, 14 Feb 2003 05:08:04 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EISA/sysfs update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 14 Feb 2003 11:16:24 +0100
Message-ID: <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1044241767.3924.14.camel@mulgrave>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

James, LKML,

Here is the latest round of EISA/sysfs hacking.

>From the changelog :

# EISA/sysfs update.
# 
# - Separate bus root code from generic code.
# - Add driver for i82375 PCI/EISA bridge.
# - Hacked parisc eisa driver so it can act as a root device.
# - Add driver for so-called virtual root (for bridge-less systems).
# - Allow multiple roots.

I tested it on alpha (AS1000-4/200 and Jensen) and parisc (C100). The
parisc part really needs more work (I don't like the double probing at
all), but at least it is now useable.

I'd be happy to read any comment about this code.

Thanks,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-drivers.patch
Content-Description: EISA/sysfs update

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.994   -> 1.995  
#	drivers/parisc/eisa.c	1.4     -> 1.5    
#	drivers/eisa/eisa-bus.c	1.2     -> 1.3    
#	drivers/eisa/Kconfig	1.1     -> 1.2    
#	drivers/eisa/Makefile	1.2     -> 1.3    
#	include/linux/eisa.h	1.1     -> 1.2    
#	               (new)	        -> 1.2     drivers/eisa/i82375.c
#	               (new)	        -> 1.2     drivers/eisa/virtual_root.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/14	maz@hina.wild-wind.fr.eu.org	1.995
# EISA/sysfs update.
# 
# - Separate bus root code from generic code.
# - Add driver for i82375 PCI/EISA bridge.
# - Hacked parisc eisa driver so it can act as a root device.
# - Add driver for so-called virtual root (for bridge-less systems).
# - Allow multiple roots.
# --------------------------------------------
#
diff -Nru a/drivers/eisa/Kconfig b/drivers/eisa/Kconfig
--- a/drivers/eisa/Kconfig	Fri Feb 14 11:14:39 2003
+++ b/drivers/eisa/Kconfig	Fri Feb 14 11:14:39 2003
@@ -1,6 +1,27 @@
 #
-# PCI configuration
+# EISA configuration
 #
+config EISA_I82375
+	bool "Intel 82375 PCI/EISA bridge"
+	depends on PCI && EISA
+	default y
+	---help---
+	  Activate this option if your system contains an Intel 82375
+	  PCI to EISA bridge.
+
+	  When in doubt, say Y.
+
+config EISA_VIRTUAL_ROOT
+	bool "EISA virtual root device"
+	depends on EISA
+	default y
+	---help---
+	  Activate this option if your system only have EISA bus
+	  (no PCI slots). The Alpha Jensen is an example of such
+	  a system.
+
+	  When in doubt, say Y.
+
 config EISA_NAMES
 	bool "EISA device name database"
 	depends on EISA
diff -Nru a/drivers/eisa/Makefile b/drivers/eisa/Makefile
--- a/drivers/eisa/Makefile	Fri Feb 14 11:14:39 2003
+++ b/drivers/eisa/Makefile	Fri Feb 14 11:14:39 2003
@@ -1,6 +1,11 @@
 # Makefile for the Linux device tree
 
-obj-$(CONFIG_EISA)	+= eisa-bus.o
+obj-$(CONFIG_EISA)	        += eisa-bus.o
+obj-${CONFIG_EISA_I82375}       += i82375.o
+
+# virtual_root.o should be the last EISA root device to initialize,
+# so leave it at the end of the list.
+obj-${CONFIG_EISA_VIRTUAL_ROOT} += virtual_root.o
 
 clean-files:= devlist.h
 
diff -Nru a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
--- a/drivers/eisa/eisa-bus.c	Fri Feb 14 11:14:39 2003
+++ b/drivers/eisa/eisa-bus.c	Fri Feb 14 11:14:39 2003
@@ -15,6 +15,8 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 
+#define SLOT_ADDRESS(r,n) (r->bus_base_addr + (0x1000 * n))
+
 #define EISA_DEVINFO(i,s) { .id = { .sig = i }, .name = s }
 
 struct eisa_device_info {
@@ -95,12 +97,6 @@
 	.match = eisa_bus_match,
 };
 
-/* The default EISA device parent (virtual root device). */
-static struct device eisa_bus_root = {
-       .name           = "EISA Bridge",
-       .bus_id         = "eisa",
-};
-
 int eisa_driver_register (struct eisa_driver *edrv)
 {
 	int r;
@@ -125,7 +121,8 @@
 
 static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
 
-static void __init eisa_register_device (char *sig, int slot)
+static void __init eisa_register_device (struct eisa_root_device *root,
+					 char *sig, int slot)
 {
 	struct eisa_device *edev;
 
@@ -135,11 +132,11 @@
 	memset (edev, 0, sizeof (*edev));
 	memcpy (edev->id.sig, sig, 7);
 	edev->slot = slot;
-	edev->base_addr = 0x1000 * slot;
+	edev->base_addr = SLOT_ADDRESS (root, slot);
 	eisa_name_device (edev);
-	edev->dev.parent = &eisa_bus_root;
+	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
-	sprintf (edev->dev.bus_id, "00:%02X", slot);
+	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
 	/* Don't register resource for slot 0, since this will surely
 	 * fail... :-( */
@@ -150,7 +147,7 @@
 		edev->res.end   = edev->res.start + 0xfff;
 		edev->res.flags = IORESOURCE_IO;
 
-		if (request_resource (&ioport_resource, &edev->res)) {
+		if (request_resource (root->res, &edev->res)) {
 			printk (KERN_WARNING \
 				"Cannot allocate resource for EISA slot %d\n",
 				slot);
@@ -167,16 +164,18 @@
 	device_create_file (&edev->dev, &dev_attr_signature);
 }
 
-static int __init eisa_probe (void)
+static int __init eisa_probe (struct eisa_root_device *root)
 {
         int i, c;
         char *str;
-        unsigned long slot_addr;
+        unsigned long sig_addr;
 
-        printk (KERN_INFO "EISA: Probing bus...\n");
-        for (c = 0, i = 0; i <= EISA_MAX_SLOTS; i++) {
-                slot_addr = (0x1000 * i) + EISA_VENDOR_ID_OFFSET;
-                if ((str = decode_eisa_sig (slot_addr))) {
+        printk (KERN_INFO "EISA: Probing bus %d at %s\n",
+		root->bus_nr, root->dev->name);
+	
+        for (c = 0, i = 0; i <= root->slots; i++) {
+                sig_addr = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
+                if ((str = decode_eisa_sig (sig_addr))) {
 			if (!i)
 				printk (KERN_INFO "EISA: Motherboard %s detected\n",
 					str);
@@ -187,7 +186,7 @@
 				c++;
 			}
 
-			eisa_register_device (str, i);
+			eisa_register_device (root, str, i);
                 }
         }
         printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c < 2 ? "" : "s");
@@ -195,20 +194,40 @@
 	return 0;
 }
 
+
+static LIST_HEAD (eisa_root_head);
+
+static int eisa_bus_count;
+
+int eisa_root_register (struct eisa_root_device *root)
+{
+	struct list_head *node;
+	struct eisa_root_device *tmp_root;
+
+	/* Check if this bus base address has been already
+	 * registered. This prevents the virtual root device from
+	 * registering after the real one has, for example... */
+	
+	list_for_each (node, &eisa_root_head) {
+		tmp_root = list_entry (node, struct eisa_root_device, node);
+		if (tmp_root->bus_base_addr == root->bus_base_addr)
+			return -1; /* Space already taken, buddy... */
+	}
+	
+	root->bus_nr = eisa_bus_count++;
+	list_add_tail (&root->node, &eisa_root_head);
+	return eisa_probe (root);
+}
+
 static int __init eisa_init (void)
 {
 	int r;
 	
 	if ((r = bus_register (&eisa_bus_type)))
 		return r;
-	
-	if ((r = device_register (&eisa_bus_root))) {
-		bus_unregister (&eisa_bus_type);
-		return r;
-	}
 
 	printk (KERN_INFO "EISA bus registered\n");
-	return eisa_probe ();
+	return 0;
 }
 
 postcore_initcall (eisa_init);
diff -Nru a/drivers/eisa/i82375.c b/drivers/eisa/i82375.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/eisa/i82375.c	Fri Feb 14 11:14:39 2003
@@ -0,0 +1,61 @@
+/*
+ * Minimalist driver for the Intel 82375 PCI-to-EISA bridge.
+ *
+ * (C) 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ *
+ * This code is released under the GPL version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+/* There is only *one* i82375 device per machine, right ? */
+static struct eisa_root_device i82375_root;
+
+static int __devinit i82375_init (struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
+{
+	int rc;
+
+	if ((rc = pci_enable_device (pdev))) {
+		printk (KERN_INFO "i82375 : Could not enable device %s\n",
+			pdev->slot_name);
+		return rc;
+	}
+
+	i82375_root.dev              = &pdev->dev;
+	i82375_root.dev->driver_data = &i82375_root;
+	i82375_root.bus_base_addr    = 0; /* Warning, this is a x86-ism */
+	i82375_root.res		     = &ioport_resource;
+	i82375_root.slots	     = EISA_MAX_SLOTS;
+
+	if (eisa_root_register (&i82375_root)) {
+		printk (KERN_INFO "i82375 : Could not register EISA root\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct pci_device_id i82375_pci_tbl[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82375,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+static struct pci_driver i82375_driver = {
+	.name		= "i82375",
+	.id_table	= i82375_pci_tbl,
+	.probe		= i82375_init,
+};
+
+static int __init i82375_init_module (void)
+{
+	return pci_module_init (&i82375_driver);
+}
+
+device_initcall(i82375_init_module);
diff -Nru a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/eisa/virtual_root.c	Fri Feb 14 11:14:39 2003
@@ -0,0 +1,49 @@
+/*
+ * Virtual EISA root driver.
+ * Acts as a placeholder if we don't have a proper EISA bridge.
+ *
+ * (C) 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ *
+ * This code is released under the GPL version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+/* The default EISA device parent (virtual root device). */
+static struct device eisa_root_dev = {
+       .name        = "Virtual EISA Bridge",
+       .bus_id      = "eisa",
+};
+
+static struct eisa_root_device eisa_bus_root = {
+	.dev           = &eisa_root_dev,
+	.bus_base_addr = 0,
+	.res	       = &ioport_resource,
+	.slots	       = EISA_MAX_SLOTS,
+};
+
+static int virtual_eisa_root_init (void)
+{
+	int r;
+	
+        if ((r = device_register (&eisa_root_dev))) {
+                return r;
+        }
+
+	eisa_root_dev.driver_data = &eisa_bus_root;
+
+	if (eisa_root_register (&eisa_bus_root)) {
+		/* A real bridge may have been registered before
+		 * us. So quietly unregister. */
+		device_unregister (&eisa_root_dev);
+		return -1;
+	}
+
+	return 0;
+}
+
+device_initcall (virtual_eisa_root_init);
diff -Nru a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
--- a/drivers/parisc/eisa.c	Fri Feb 14 11:14:39 2003
+++ b/drivers/parisc/eisa.c	Fri Feb 14 11:14:39 2003
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/eisa.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -61,6 +62,7 @@
 static struct eisa_ba {
 	struct pci_hba_data	hba;
 	unsigned long eeprom_addr;
+	struct eisa_root_device root;
 } eisa_dev;
 
 /* Port ops */
@@ -376,6 +378,20 @@
 	eisa_eeprom_init(eisa_dev.eeprom_addr);
 	eisa_enumerator(eisa_dev.eeprom_addr, &eisa_dev.hba.io_space, &eisa_dev.hba.lmmio_space);
 	init_eisa_pic();
+
+	/* FIXME : Maybe we could get rid of io_space and only rely on
+	 * lmmio_space, since all operations are already going through
+	 * this region... Also get the number of slots from the
+	 * enumerator, not a hadcoded value.*/
+	eisa_dev.root.dev = &dev->dev;
+	dev->dev.driver_data = &eisa_dev.root;
+	eisa_dev.root.bus_base_addr = 0;
+	eisa_dev.root.res = &eisa_dev.hba.io_space;
+	eisa_dev.root.slots = EISA_MAX_SLOTS;
+	if (eisa_root_register (&eisa_dev.root)) {
+		printk(KERN_ERR "EISA: Failed to register EISA root\n");
+		return -1;
+	}
 	
 	return 0;
 }
diff -Nru a/include/linux/eisa.h b/include/linux/eisa.h
--- a/include/linux/eisa.h	Fri Feb 14 11:14:39 2003
+++ b/include/linux/eisa.h	Fri Feb 14 11:14:39 2003
@@ -24,7 +24,8 @@
 };
 
 /* There is not much we can say about an EISA device, apart from
- * signature, slot number, and base address */
+ * signature, slot number, and base address. */
+
 struct eisa_device {
 	struct eisa_device_id id;
 	int                   slot;
@@ -56,5 +57,19 @@
 {
         edev->dev.driver_data = data;
 }
+
+/* The EISA root device. There's rumours about machines with multiple
+ * busses (PA-RISC ?), so we try to handle that. */
+
+struct eisa_root_device {
+	struct list_head node;
+	struct device   *dev;	 /* Pointer to bridge device */
+	struct resource *res;
+	unsigned long    bus_base_addr;
+	int		 slots;  /* Max slot number */
+	int              bus_nr; /* Set by eisa_root_register */
+};
+
+int eisa_root_register (struct eisa_root_device *root);
 
 #endif

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
