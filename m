Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbTGDWx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbTGDWx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:53:29 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:26640 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266213AbTGDWw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:52:58 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [1/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:04:29 +0200
Message-ID: <wrpel15vqpu.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core changes :

- Now reserves I/O ranges according to EISA specs (four 256 bytes
regions instead of a single 4KB region).

- By default, do not try to probe the bus if the mainboard does not
seems to support EISA (allow this behaviour to be changed through a
command-line option).

- Use parent bridge device dma_mask as default for each discovered
device.

- Allow devices to be enabled or disabled from the kernel command line
(usefull for non-x86 platforms where the firmware simply disable
devices it doesn't know about...).

        M.

diff -ruN linux-latest/drivers/eisa/eisa-bus.c linux-eisa/drivers/eisa/eisa-bus.c
--- linux-latest/drivers/eisa/eisa-bus.c	2003-07-04 09:40:00.000000000 +0200
+++ linux-eisa/drivers/eisa/eisa-bus.c	2003-07-04 09:41:28.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * EISA bus support functions for sysfs.
  *
- * (C) 2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ * (C) 2002, 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
  *
  * This code is released under the GPL version 2.
  */
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/eisa.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
@@ -24,7 +25,7 @@
 	char name[DEVICE_NAME_SIZE];
 };
 
-struct eisa_device_info __initdata eisa_table[] = {
+static struct eisa_device_info __initdata eisa_table[] = {
 #ifdef CONFIG_EISA_NAMES
 #include "devlist.h"
 #endif
@@ -32,6 +33,30 @@
 
 #define EISA_INFOS (sizeof (eisa_table) / (sizeof (struct eisa_device_info)))
 
+#define EISA_MAX_FORCED_DEV 16
+#define EISA_FORCED_OFFSET  2
+
+static int enable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET]  = { 1, EISA_MAX_FORCED_DEV, };
+static int disable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET] = { 1, EISA_MAX_FORCED_DEV, };
+
+static int is_forced_dev (int *forced_tab,
+			  struct eisa_root_device *root,
+			  struct eisa_device *edev)
+{
+	int i, x;
+
+	for (i = 0; i < EISA_MAX_FORCED_DEV; i++) {
+		if (!forced_tab[EISA_FORCED_OFFSET + i])
+			return 0;
+
+		x = (root->bus_nr << 8) | edev->slot;
+		if (forced_tab[EISA_FORCED_OFFSET + i] == x)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void __init eisa_name_device (struct eisa_device *edev)
 {
 	int i;
@@ -92,7 +117,8 @@
 		return 0;
 
 	while (strlen (eids->sig)) {
-		if (!strcmp (eids->sig, edev->id.sig)) {
+		if (!strcmp (eids->sig, edev->id.sig) &&
+		    edev->state & EISA_CONFIG_ENABLED) {
 			edev->id.driver_data = eids->driver_data;
 			return 1;
 		}
@@ -132,41 +158,160 @@
 
 static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
 
-static int __init eisa_register_device (struct eisa_root_device *root,
-					struct eisa_device *edev,
-					char *sig, int slot)
+static ssize_t eisa_show_state (struct device *dev, char *buf)
+{
+        struct eisa_device *edev = to_eisa_device (dev);
+        return sprintf (buf,"%d\n", edev->state & EISA_CONFIG_ENABLED);
+}
+
+static DEVICE_ATTR(enabled, S_IRUGO, eisa_show_state, NULL);
+
+static int __init eisa_init_device (struct eisa_root_device *root,
+				    struct eisa_device *edev,
+				    int slot)
 {
+	char *sig;
+        unsigned long sig_addr;
+	int i;
+
+	sig_addr = SLOT_ADDRESS (root, slot) + EISA_VENDOR_ID_OFFSET;
+
+	if (!(sig = decode_eisa_sig (sig_addr)))
+		return -1;	/* No EISA device here */
+	
 	memcpy (edev->id.sig, sig, EISA_SIG_LEN);
 	edev->slot = slot;
+	edev->state = inb (SLOT_ADDRESS (root, slot) + EISA_CONFIG_OFFSET) & EISA_CONFIG_ENABLED;
 	edev->base_addr = SLOT_ADDRESS (root, slot);
-	edev->dma_mask = 0xffffffff; /* Default DMA mask */
+	edev->dma_mask = root->dma_mask; /* Default DMA mask */
 	eisa_name_device (edev);
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
 	edev->dev.dma_mask = &edev->dma_mask;
 	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
-	edev->res.name  = edev->dev.name;
+	for (i = 0; i < EISA_MAX_RESOURCES; i++)
+		edev->res[i].name  = edev->dev.name;
+
+	if (is_forced_dev (enable_dev, root, edev))
+		edev->state = EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED;
+	
+	if (is_forced_dev (disable_dev, root, edev))
+		edev->state = EISA_CONFIG_FORCED;
+
+	return 0;
+}
 
+static int __init eisa_register_device (struct eisa_device *edev)
+{
 	if (device_register (&edev->dev))
 		return -1;
 
 	device_create_file (&edev->dev, &dev_attr_signature);
+	device_create_file (&edev->dev, &dev_attr_enabled);
+
+	return 0;
+}
+
+static int __init eisa_request_resources (struct eisa_root_device *root,
+					  struct eisa_device *edev,
+					  int slot)
+{
+	int i;
+
+	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
+		/* Don't register resource for slot 0, since this is
+		 * very likely to fail... :-( Instead, grab the EISA
+		 * id, now we can display something in /proc/ioports.
+		 */
+
+		/* Only one region for mainboard */
+		if (!slot && i > 0) {
+			edev->res[i].start = edev->res[i].end = 0;
+			continue;
+		}
+		
+		if (slot) {
+			edev->res[i].name  = NULL;
+			edev->res[i].start = SLOT_ADDRESS (root, slot) + (i * 0x400);
+			edev->res[i].end   = edev->res[i].start + 0xff;
+			edev->res[i].flags = IORESOURCE_IO;
+		} else {
+			edev->res[i].name  = NULL;
+			edev->res[i].start = SLOT_ADDRESS (root, slot) + EISA_VENDOR_ID_OFFSET;
+			edev->res[i].end   = edev->res[i].start + 3;
+			edev->res[i].flags = IORESOURCE_BUSY;
+		}
+
+		if (request_resource (root->res, &edev->res[i]))
+			goto failed;
+	}
 
 	return 0;
+	
+ failed:
+	while (--i >= 0)
+		release_resource (&edev->res[i]);
+
+	return -1;
+}
+
+static void __init eisa_release_resources (struct eisa_device *edev)
+{
+	int i;
+
+	for (i = 0; i < EISA_MAX_RESOURCES; i++)
+		if (edev->res[i].start || edev->res[i].end)
+			release_resource (&edev->res[i]);
 }
 
 static int __init eisa_probe (struct eisa_root_device *root)
 {
         int i, c;
-        char *str;
-        unsigned long sig_addr;
 	struct eisa_device *edev;
 
         printk (KERN_INFO "EISA: Probing bus %d at %s\n",
 		root->bus_nr, root->dev->name);
+
+	/* First try to get hold of slot 0. If there is no device
+	 * here, simply fail, unless root->force_probe is set. */
+	
+	if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
+		printk (KERN_ERR "EISA: Couldn't allocate mainboard slot\n");
+		return -ENOMEM;
+	}
+		
+	memset (edev, 0, sizeof (*edev));
+
+	if (eisa_request_resources (root, edev, 0)) {
+		printk (KERN_WARNING \
+			"EISA: Cannot allocate resource for mainboard\n");
+		kfree (edev);
+		if (!root->force_probe)
+			return -EBUSY;
+		goto force_probe;
+	}
+
+	if (eisa_init_device (root, edev, 0)) {
+		eisa_release_resources (edev);
+		kfree (edev);
+		if (!root->force_probe)
+			return -ENODEV;
+		goto force_probe;
+	}
+
+	printk (KERN_INFO "EISA: Mainboard %s detected.\n", edev->id.sig);
+
+	if (eisa_register_device (edev)) {
+		printk (KERN_ERR "EISA: Failed to register %s\n",
+			edev->id.sig);
+		eisa_release_resources (edev);
+		kfree (edev);
+	}
 	
-        for (c = 0, i = 0; i <= root->slots; i++) {
+ force_probe:
+	
+        for (c = 0, i = 1; i <= root->slots; i++) {
 		if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
 			printk (KERN_ERR "EISA: Out of memory for slot %d\n",
 				i);
@@ -175,24 +320,7 @@
 		
 		memset (edev, 0, sizeof (*edev));
 
-		/* Don't register resource for slot 0, since this is
-		 * very likely to fail... :-( Instead, grab the EISA
-		 * id, now we can display something in /proc/ioports.
-		 */
-
-		if (i) {
-			edev->res.name  = NULL;
-			edev->res.start = SLOT_ADDRESS (root, i);
-			edev->res.end   = edev->res.start + 0xfff;
-			edev->res.flags = IORESOURCE_IO;
-		} else {
-			edev->res.name  = NULL;
-			edev->res.start = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
-			edev->res.end   = edev->res.start + 3;
-			edev->res.flags = IORESOURCE_BUSY;
-		}
-	
-		if (request_resource (root->res, &edev->res)) {
+		if (eisa_request_resources (root, edev, i)) {
 			printk (KERN_WARNING \
 				"Cannot allocate resource for EISA slot %d\n",
 				i);
@@ -200,30 +328,41 @@
 			continue;
 		}
 
-		sig_addr = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
-
-                if (!(str = decode_eisa_sig (sig_addr))) {
-			release_resource (&edev->res);
+                if (eisa_init_device (root, edev, i)) {
+			eisa_release_resources (edev);
 			kfree (edev);
 			continue;
 		}
 		
-		if (!i)
-			printk (KERN_INFO "EISA: Motherboard %s detected\n",
-				str);
-		else {
-			printk (KERN_INFO "EISA: slot %d : %s detected.\n",
-				i, str);
-
-			c++;
+		printk (KERN_INFO "EISA: slot %d : %s detected",
+			i, edev->id.sig);
+			
+		switch (edev->state) {
+		case EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED:
+			printk (" (forced enabled)");
+			break;
+
+		case EISA_CONFIG_FORCED:
+			printk (" (forced disabled)");
+			break;
+
+		case 0:
+			printk (" (disabled)");
+			break;
 		}
+			
+		printk (".\n");
+
+		c++;
 
-		if (eisa_register_device (root, edev, str, i)) {
-			printk (KERN_ERR "EISA: Failed to register %s\n", str);
-			release_resource (&edev->res);
+		if (eisa_register_device (edev)) {
+			printk (KERN_ERR "EISA: Failed to register %s\n",
+				edev->id.sig);
+			eisa_release_resources (edev);
 			kfree (edev);
 		}
         }
+
         printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c == 1 ? "" : "s");
 
 	return 0;
@@ -274,6 +413,13 @@
 	return 0;
 }
 
+/* Couldn't use intarray with checking on... :-( */
+#undef  param_check_intarray
+#define param_check_intarray(name, p)
+
+module_param(enable_dev,  intarray, 0444);
+module_param(disable_dev, intarray, 0444);
+
 postcore_initcall (eisa_init);
 
 EXPORT_SYMBOL (eisa_bus_type);
diff -ruN linux-latest/include/linux/eisa.h linux-eisa/include/linux/eisa.h
--- linux-latest/include/linux/eisa.h	2003-07-04 09:44:00.000000000 +0200
+++ linux-eisa/include/linux/eisa.h	2003-07-04 09:46:02.000000000 +0200
@@ -4,6 +4,8 @@
 #define EISA_SIG_LEN   8
 #define EISA_MAX_SLOTS 8
 
+#define EISA_MAX_RESOURCES 4
+
 /* A few EISA constants/offsets... */
 
 #define EISA_DMA1_STATUS            8
@@ -17,6 +19,10 @@
 #define EISA_INT1_EDGE_LEVEL    0x4D0
 #define EISA_INT2_EDGE_LEVEL    0x4D1
 #define EISA_VENDOR_ID_OFFSET   0xC80
+#define EISA_CONFIG_OFFSET      0xC84
+
+#define EISA_CONFIG_ENABLED         1
+#define EISA_CONFIG_FORCED          2
 
 /* The EISA signature, in ASCII form, null terminated */
 struct eisa_device_id {
@@ -26,19 +32,28 @@
 
 /* There is not much we can say about an EISA device, apart from
  * signature, slot number, and base address. dma_mask is set by
- * default to 32 bits.*/
+ * default to parent device mask..*/
 
 struct eisa_device {
 	struct eisa_device_id id;
 	int                   slot;
+	int                   state;
 	unsigned long         base_addr;
-	struct resource       res;
+	struct resource       res[EISA_MAX_RESOURCES];
 	u64                   dma_mask;
 	struct device         dev; /* generic device */
 };
 
 #define to_eisa_device(n) container_of(n, struct eisa_device, dev)
 
+static inline int eisa_get_region_index (void *addr)
+{
+	unsigned long x = (unsigned long) addr;
+
+	x &= 0xc00;
+	return (x >> 12);
+}
+
 struct eisa_driver {
 	const struct eisa_device_id *id_table;
 	struct device_driver         driver;
@@ -69,6 +84,8 @@
 	struct resource *res;
 	unsigned long    bus_base_addr;
 	int		 slots;  /* Max slot number */
+	int		 force_probe; /* Probe even when no slot 0 */
+	u64		 dma_mask; /* from bridge device */
 	int              bus_nr; /* Set by eisa_root_register */
 	struct resource  eisa_root_res;	/* ditto */
 };

-- 
Places change, faces change. Life is so very strange.
