Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTBOMMa>; Sat, 15 Feb 2003 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTBOMMa>; Sat, 15 Feb 2003 07:12:30 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:3968 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261836AbTBOMMW>; Sat, 15 Feb 2003 07:12:22 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update, take #2
References: <1044241767.3924.14.camel@mulgrave>
	<wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
	<20030214173217.A17730@jurassic.park.msu.ru>
	<wrpisvmri71.fsf@hina.wild-wind.fr.eu.org>
	<20030214190538.A19355@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 15 Feb 2003 13:20:26 +0100
Message-ID: <wrp65rlu451.fsf_-_@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030214190538.A19355@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Folks,

Here is the updated EISA/sysfs patch, with the corrections discussed
yesterday (using PCI_CLASS_BRIDGE_EISA, moving quirk_eisa_bridge from
alpha to generic code, eisa_driver_register return value, as well as a
3C59x EISA probing fix).

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-drivers.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.994   -> 1.998  
#	 drivers/net/3c59x.c	1.31    -> 1.32   
#	drivers/parisc/eisa.c	1.4     -> 1.6    
#	drivers/pci/quirks.c	1.22    -> 1.23   
#	arch/alpha/kernel/pci.c	1.22    -> 1.23   
#	drivers/eisa/eisa-bus.c	1.2     -> 1.4    
#	drivers/eisa/Kconfig	1.1     -> 1.3    
#	drivers/eisa/Makefile	1.2     -> 1.4    
#	include/linux/eisa.h	1.1     -> 1.2    
#	               (new)	        -> 1.4     drivers/eisa/pci_eisa.c
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
# 03/02/15	maz@hina.wild-wind.fr.eu.org	1.996
#     Moved quirk_eisa_bridge from alpha to generic code, 
#     since the EISA code needs it now.
# --------------------------------------------
# 03/02/15	maz@hina.wild-wind.fr.eu.org	1.997
# Use PCI_CLASS_BRIDGE_EISA instead of i82375 ID.
# A few fixes all over the map.
# --------------------------------------------
# 03/02/15	maz@hina.wild-wind.fr.eu.org	1.998
# 3c59x :
# Prevent driver from returning ENODEV in case it has registered with the EISA
# framework, but no device has been found yet (it happends when the driver is
# built into the kernel, and the EISA bus root has not been discovered yet).
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	Sat Feb 15 12:56:07 2003
+++ b/arch/alpha/kernel/pci.c	Sat Feb 15 12:56:07 2003
@@ -57,12 +57,6 @@
  */
 
 static void __init
-quirk_eisa_bridge(struct pci_dev *dev)
-{
-	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
-}
-
-static void __init
 quirk_isa_bridge(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_ISA << 8;
@@ -125,8 +119,6 @@
 }
 
 struct pci_fixup pcibios_fixups[] __initdata = {
-	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82375,
-	  quirk_eisa_bridge },
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82378,
 	  quirk_isa_bridge },
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229,
diff -Nru a/drivers/eisa/Kconfig b/drivers/eisa/Kconfig
--- a/drivers/eisa/Kconfig	Sat Feb 15 12:56:07 2003
+++ b/drivers/eisa/Kconfig	Sat Feb 15 12:56:07 2003
@@ -1,6 +1,28 @@
 #
-# PCI configuration
+# EISA configuration
 #
+config EISA_PCI_EISA
+	bool "Generic PCI/EISA bridge"
+	depends on PCI && EISA
+	default y
+	---help---
+	  Activate this option if your system contains a PCI to EISA
+	  bridge. If your system have both PCI and EISA slots, you
+	  certainly need this option.
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
--- a/drivers/eisa/Makefile	Sat Feb 15 12:56:07 2003
+++ b/drivers/eisa/Makefile	Sat Feb 15 12:56:07 2003
@@ -1,6 +1,11 @@
 # Makefile for the Linux device tree
 
-obj-$(CONFIG_EISA)	+= eisa-bus.o
+obj-$(CONFIG_EISA)	        += eisa-bus.o
+obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
+
+# virtual_root.o should be the last EISA root device to initialize,
+# so leave it at the end of the list.
+obj-${CONFIG_EISA_VIRTUAL_ROOT} += virtual_root.o
 
 clean-files:= devlist.h
 
diff -Nru a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
--- a/drivers/eisa/eisa-bus.c	Sat Feb 15 12:56:07 2003
+++ b/drivers/eisa/eisa-bus.c	Sat Feb 15 12:56:07 2003
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
@@ -109,7 +105,7 @@
 	if ((r = driver_register (&edrv->driver)) < 0)
 		return r;
 
-	return 1;
+	return 0;
 }
 
 void eisa_driver_unregister (struct eisa_driver *edrv)
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
diff -Nru a/drivers/eisa/pci_eisa.c b/drivers/eisa/pci_eisa.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/eisa/pci_eisa.c	Sat Feb 15 12:56:07 2003
@@ -0,0 +1,64 @@
+/*
+ * Minimalist driver for a generic PCI-to-EISA bridge.
+ *
+ * (C) 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ *
+ * This code is released under the GPL version 2.
+ *
+ * Ivan Kokshaysky <ink@jurassic.park.msu.ru> :
+ * Generalisation from i82375 to PCI_CLASS_BRIDGE_EISA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+/* There is only *one* pci_eisa device per machine, right ? */
+static struct eisa_root_device pci_eisa_root;
+
+static int __devinit pci_eisa_init (struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
+{
+	int rc;
+
+	if ((rc = pci_enable_device (pdev))) {
+		printk (KERN_ERR "pci_eisa : Could not enable device %s\n",
+			pdev->slot_name);
+		return rc;
+	}
+
+	pci_eisa_root.dev              = &pdev->dev;
+	pci_eisa_root.dev->driver_data = &pci_eisa_root;
+	pci_eisa_root.res	       = pdev->bus->resource[0];
+	pci_eisa_root.bus_base_addr    = pdev->bus->resource[0]->start;
+	pci_eisa_root.slots	       = EISA_MAX_SLOTS;
+
+	if (eisa_root_register (&pci_eisa_root)) {
+		printk (KERN_ERR "pci_eisa : Could not register EISA root\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct pci_device_id pci_eisa_pci_tbl[] = {
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_BRIDGE_EISA << 8, 0xffff00, 0 },
+	{ 0, }
+};
+
+static struct pci_driver pci_eisa_driver = {
+	.name		= "pci_eisa",
+	.id_table	= pci_eisa_pci_tbl,
+	.probe		= pci_eisa_init,
+};
+
+static int __init pci_eisa_init_module (void)
+{
+	return pci_module_init (&pci_eisa_driver);
+}
+
+device_initcall(pci_eisa_init_module);
diff -Nru a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/eisa/virtual_root.c	Sat Feb 15 12:56:07 2003
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
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Sat Feb 15 12:56:07 2003
+++ b/drivers/net/3c59x.c	Sat Feb 15 12:56:07 2003
@@ -1007,6 +1007,7 @@
 /* returns count found (>= 0), or negative on error */
 static int __init vortex_eisa_init (void)
 {
+	int eisa_found = 0;
 	int orig_cards_found = vortex_cards_found;
 
 	/* Now check all slots of the EISA bus. */
@@ -1014,8 +1015,14 @@
 		return 0;
 
 #ifdef CONFIG_EISA
-	if (eisa_driver_register (&vortex_eisa_driver) < 0) {
-		eisa_driver_unregister (&vortex_eisa_driver);
+	if (eisa_driver_register (&vortex_eisa_driver) >= 0) {
+			/* Because of the way EISA bus is probed, we cannot assume
+			 * any device have been found when we exit from
+			 * eisa_driver_register (the bus root driver may not be
+			 * initialized yet). So we blindly assume something was
+			 * found, and let the sysfs magic happend... */
+			
+			eisa_found = 1;
 	}
 #endif
 	
@@ -1025,7 +1032,7 @@
 					  compaq_device_id, vortex_cards_found++);
 	}
 
-	return vortex_cards_found - orig_cards_found;
+	return vortex_cards_found - orig_cards_found + eisa_found;
 }
 
 /* returns count (>= 0), or negative on error */
diff -Nru a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
--- a/drivers/parisc/eisa.c	Sat Feb 15 12:56:07 2003
+++ b/drivers/parisc/eisa.c	Sat Feb 15 12:56:07 2003
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
@@ -376,6 +378,18 @@
 	eisa_eeprom_init(eisa_dev.eeprom_addr);
 	eisa_enumerator(eisa_dev.eeprom_addr, &eisa_dev.hba.io_space, &eisa_dev.hba.lmmio_space);
 	init_eisa_pic();
+
+	/* FIXME : Get the number of slots from the enumerator, not a
+	 * hadcoded value. Also don't enumerate the bus twice. */
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
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Sat Feb 15 12:56:07 2003
+++ b/drivers/pci/quirks.c	Sat Feb 15 12:56:07 2003
@@ -535,6 +535,15 @@
 	}
 }
 
+/* This was originally an Alpha specific thing, but it really fits here.
+ * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
+ */
+
+static void __init quirk_eisa_bridge(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
+}
+
 /*
  *  The main table of quirks.
  */
@@ -604,6 +613,7 @@
 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
 	
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge },
 
 	{ 0 }
 };
diff -Nru a/include/linux/eisa.h b/include/linux/eisa.h
--- a/include/linux/eisa.h	Sat Feb 15 12:56:07 2003
+++ b/include/linux/eisa.h	Sat Feb 15 12:56:07 2003
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
