Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDUQhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDUQhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:37:45 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:3856 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261706AbTDUQhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:37:34 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EISA/sysfs update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 21 Apr 2003 18:48:32 +0200
Message-ID: <wrpptnfeqzj.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The included patch cleans up the EISA code :

- Documentation update,
- Remove i386 EISA ID reservation (handled in the generic code),
- Add some preliminary support for EISA-like VLB cards (Adaptec 287x),
- Add some stricter dependancies on EISA_VIRTUAL_ROOT
- Preliminary support for EISA DMA,
- Much more conservative probing,
- EISA IDs list update (Compaq stuff).

Please apply.

        M.

diff -ruN linux/Documentation/eisa.txt linux-eisa/Documentation/eisa.txt
--- linux/Documentation/eisa.txt	2003-04-21 18:10:21.000000000 +0200
+++ linux-eisa/Documentation/eisa.txt	2003-04-21 18:21:26.000000000 +0200
@@ -79,8 +79,9 @@
 };
 
 id_table	: an array of NULL terminated EISA id strings,
-		  followed by an empty string. Each string can be
-		  paired with a driver-dependant value (driver_data).
+		  followed by an empty string. Each string can
+		  optionnaly be paired with a driver-dependant value
+		  (driver_data).
 
 driver		: a generic driver, such as described in
 		  Documentation/driver-model/driver.txt. Only .name,
@@ -88,19 +89,19 @@
 
 An example is the 3c509 driver :
 
-struct eisa_device_id el3_eisa_ids[] = {
-        { "TCM5092" },
-        { "TCM5093" },
-        { "" }
+static struct eisa_device_id vortex_eisa_ids[] = {
+	{ "TCM5920", EISA_3C592_OFFSET },
+	{ "TCM5970", EISA_3C597_OFFSET },
+	{ "" }
 };
 
-struct eisa_driver el3_eisa_driver = {
-        .id_table = el3_eisa_ids,
-        .driver   = {
-                .name    = "3c509",
-                .probe   = el3_eisa_probe,
-                .remove  = __devexit_p (el3_device_remove)
-        }
+static struct eisa_driver vortex_eisa_driver = {
+	.id_table = vortex_eisa_ids,
+	.driver   = {
+		.name    = "3c59x",
+		.probe   = vortex_eisa_probe,
+		.remove  = vortex_eisa_remove
+	}
 };
 
 ** Device :
diff -ruN linux/arch/i386/kernel/traps.c linux-eisa/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	2003-04-21 18:07:11.000000000 +0200
+++ linux-eisa/arch/i386/kernel/traps.c	2003-04-21 18:19:26.000000000 +0200
@@ -833,7 +833,6 @@
 
 #ifdef CONFIG_EISA
 int EISA_bus;
-static struct resource eisa_id = { "EISA ID", 0xc80, 0xc83, IORESOURCE_BUSY };
 #endif
 
 void __init trap_init(void)
@@ -841,8 +840,6 @@
 #ifdef CONFIG_EISA
 	if (isa_readl(0x0FFFD9) == 'E'+('I'<<8)+('S'<<16)+('A'<<24)) {
 		EISA_bus = 1;
-		if (request_resource(&ioport_resource, &eisa_id) == -EBUSY)
-			printk ("EISA port was EBUSY :-(\n");
 	}
 #endif
 
diff -ruN linux/drivers/eisa/Kconfig linux-eisa/drivers/eisa/Kconfig
--- linux/drivers/eisa/Kconfig	2003-04-21 18:07:58.000000000 +0200
+++ linux-eisa/drivers/eisa/Kconfig	2003-04-21 18:20:23.000000000 +0200
@@ -1,6 +1,17 @@
 #
 # EISA configuration
 #
+config EISA_VLB_PRIMING
+	bool "Vesa Local Bus priming"
+	depends on X86_PC && EISA
+	default n
+	---help---
+	  Activate this option if your system contains a Vesa Local
+	  Bus (VLB) card that identify itself as an EISA card (such as
+	  the Adaptec AHA-284x).
+
+	  When in doubt, say N.
+
 config EISA_PCI_EISA
 	bool "Generic PCI/EISA bridge"
 	depends on PCI && EISA
@@ -12,9 +23,12 @@
 
 	  When in doubt, say Y.
 
+# Using EISA_VIRTUAL_ROOT on something other than an Alpha or
+# an X86_PC may lead to crashes...
+
 config EISA_VIRTUAL_ROOT
 	bool "EISA virtual root device"
-	depends on EISA
+	depends on EISA && (ALPHA || X86_PC)
 	default y
 	---help---
 	  Activate this option if your system only have EISA bus
diff -ruN linux/drivers/eisa/Makefile linux-eisa/drivers/eisa/Makefile
--- linux/drivers/eisa/Makefile	2003-04-21 18:09:25.000000000 +0200
+++ linux-eisa/drivers/eisa/Makefile	2003-04-21 18:21:18.000000000 +0200
@@ -1,5 +1,8 @@
 # Makefile for the Linux device tree
 
+# Being anal sometimes saves a crash/reboot cycle... ;-)
+EXTRA_CFLAGS    := -Werror
+
 obj-$(CONFIG_EISA)	        += eisa-bus.o
 obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
 
diff -ruN linux/drivers/eisa/eisa-bus.c linux-eisa/drivers/eisa/eisa-bus.c
--- linux/drivers/eisa/eisa-bus.c	2003-04-21 18:07:49.000000000 +0200
+++ linux-eisa/drivers/eisa/eisa-bus.c	2003-04-21 18:20:17.000000000 +0200
@@ -56,13 +56,22 @@
         u16 rev;
 	int i;
 
-	sig[0] = inb (addr);
-
-	if (sig[0] & 0x80)
-                return NULL;
-
-	for (i = 1; i < 4; i++)
+	for (i = 0; i < 4; i++) {
+#ifdef CONFIG_EISA_VLB_PRIMING
+		/*
+		 * This ugly stuff is used to wake up VL-bus cards
+		 * (AHA-284x is the only known example), so we can
+		 * read the EISA id.
+		 *
+		 * Thankfully, this only exists on x86...
+		 */
+		outb(0x80 + i, addr);
+#endif
 		sig[i] = inb (addr + i);
+
+		if (!i && (sig[0] & 0x80))
+			return NULL;
+	}
 	
         sig_str[0] = ((sig[0] >> 2) & 0x1f) + ('A' - 1);
         sig_str[1] = (((sig[0] & 3) << 3) | (sig[1] >> 5)) + ('A' - 1);
@@ -123,47 +132,28 @@
 
 static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
 
-static void __init eisa_register_device (struct eisa_root_device *root,
-					 char *sig, int slot)
+static int __init eisa_register_device (struct eisa_root_device *root,
+					struct eisa_device *edev,
+					char *sig, int slot)
 {
-	struct eisa_device *edev;
-
-	if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL)))
-		return;
-
-	memset (edev, 0, sizeof (*edev));
-	memcpy (edev->id.sig, sig, 7);
+	memcpy (edev->id.sig, sig, EISA_SIG_LEN);
 	edev->slot = slot;
 	edev->base_addr = SLOT_ADDRESS (root, slot);
+	edev->dma_mask = 0xffffffff; /* Default DMA mask */
 	eisa_name_device (edev);
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
+	edev->dev.dma_mask = &edev->dma_mask;
 	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
-	/* Don't register resource for slot 0, since this will surely
-	 * fail... :-( */
+	edev->res.name  = edev->dev.name;
 
-	if (slot) {
-		edev->res.name  = edev->dev.name;
-		edev->res.start = edev->base_addr;
-		edev->res.end   = edev->res.start + 0xfff;
-		edev->res.flags = IORESOURCE_IO;
-
-		if (request_resource (root->res, &edev->res)) {
-			printk (KERN_WARNING \
-				"Cannot allocate resource for EISA slot %d\n",
-				slot);
-			kfree (edev);
-			return;
-		}
-	}
-	
-	if (device_register (&edev->dev)) {
-		kfree (edev);
-		return;
-	}
+	if (device_register (&edev->dev))
+		return -1;
 
 	device_create_file (&edev->dev, &dev_attr_signature);
+
+	return 0;
 }
 
 static int __init eisa_probe (struct eisa_root_device *root)
@@ -171,54 +161,106 @@
         int i, c;
         char *str;
         unsigned long sig_addr;
+	struct eisa_device *edev;
 
         printk (KERN_INFO "EISA: Probing bus %d at %s\n",
 		root->bus_nr, root->dev->name);
 	
         for (c = 0, i = 0; i <= root->slots; i++) {
-                sig_addr = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
-                if ((str = decode_eisa_sig (sig_addr))) {
-			if (!i)
-				printk (KERN_INFO "EISA: Motherboard %s detected\n",
-					str);
-			else {
-				printk (KERN_INFO "EISA: slot %d : %s detected.\n",
-					i, str);
+		if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
+			printk (KERN_ERR "EISA: Out of memory for slot %d\n",
+				i);
+			continue;
+		}
+		
+		memset (edev, 0, sizeof (*edev));
 
-				c++;
-			}
+		/* Don't register resource for slot 0, since this is
+		 * very likely to fail... :-( Instead, grab the EISA
+		 * id, now we can display something in /proc/ioports.
+		 */
+
+		if (i) {
+			edev->res.name  = NULL;
+			edev->res.start = SLOT_ADDRESS (root, i);
+			edev->res.end   = edev->res.start + 0xfff;
+			edev->res.flags = IORESOURCE_IO;
+		} else {
+			edev->res.name  = NULL;
+			edev->res.start = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
+			edev->res.end   = edev->res.start + 3;
+			edev->res.flags = IORESOURCE_BUSY;
+		}
+	
+		if (request_resource (root->res, &edev->res)) {
+			printk (KERN_WARNING \
+				"Cannot allocate resource for EISA slot %d\n",
+				i);
+			kfree (edev);
+			continue;
+		}
+
+		sig_addr = SLOT_ADDRESS (root, i) + EISA_VENDOR_ID_OFFSET;
+
+                if (!(str = decode_eisa_sig (sig_addr))) {
+			release_resource (&edev->res);
+			kfree (edev);
+			continue;
+		}
+		
+		if (!i)
+			printk (KERN_INFO "EISA: Motherboard %s detected\n",
+				str);
+		else {
+			printk (KERN_INFO "EISA: slot %d : %s detected.\n",
+				i, str);
 
-			eisa_register_device (root, str, i);
-                }
+			c++;
+		}
+
+		if (eisa_register_device (root, edev, str, i)) {
+			printk (KERN_ERR "EISA: Failed to register %s\n", str);
+			release_resource (&edev->res);
+			kfree (edev);
+		}
         }
         printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c == 1 ? "" : "s");
 
 	return 0;
 }
 
-
-static LIST_HEAD (eisa_root_head);
+static struct resource eisa_root_res = {
+	.name  = "EISA root resource",
+	.start = 0,
+	.end   = 0xffffffff,
+	.flags = IORESOURCE_IO,
+};
 
 static int eisa_bus_count;
 
-int eisa_root_register (struct eisa_root_device *root)
+int __init eisa_root_register (struct eisa_root_device *root)
 {
-	struct list_head *node;
-	struct eisa_root_device *tmp_root;
+	int err;
 
-	/* Check if this bus base address has been already
-	 * registered. This prevents the virtual root device from
-	 * registering after the real one has, for example... */
-	
-	list_for_each (node, &eisa_root_head) {
-		tmp_root = list_entry (node, struct eisa_root_device, node);
-		if (tmp_root->bus_base_addr == root->bus_base_addr)
-			return -1; /* Space already taken, buddy... */
-	}
+	/* Use our own resources to check if this bus base address has
+	 * been already registered. This prevents the virtual root
+	 * device from registering after the real one has, for
+	 * example... */
+	
+	root->eisa_root_res.name  = eisa_root_res.name;
+	root->eisa_root_res.start = root->res->start;
+	root->eisa_root_res.end   = root->res->end;
+	root->eisa_root_res.flags = IORESOURCE_BUSY;
+
+	if ((err = request_resource (&eisa_root_res, &root->eisa_root_res)))
+		return err;
 	
 	root->bus_nr = eisa_bus_count++;
-	list_add_tail (&root->node, &eisa_root_head);
-	return eisa_probe (root);
+
+	if ((err = eisa_probe (root)))
+		release_resource (&root->eisa_root_res);
+
+	return err;
 }
 
 static int __init eisa_init (void)
diff -ruN linux/drivers/eisa/eisa.ids linux-eisa/drivers/eisa/eisa.ids
--- linux/drivers/eisa/eisa.ids	2003-04-21 18:05:41.000000000 +0200
+++ linux-eisa/drivers/eisa/eisa.ids	2003-04-21 18:19:07.000000000 +0200
@@ -162,6 +162,17 @@
 CPQ0501 "Compaq DESKPRO/M System Board"
 CPQ0509 "Compaq DESKPRO/M System Board with Audio"
 CPQ0511 "Compaq SYSTEMPRO/LT System Board"
+CPQ0521 "Compaq DESKPRO XL System Board"
+CPQ0531 "Compaq ProSignia 500 System Board"
+CPQ0541 "Compaq ProSignia 300 System Board"
+CPQ0551 "Compaq ProLiant 2500 Server"
+CPQ0552 "Compaq ProLiant 2500 System Board"
+CPQ0553 "Compaq ProLiant 1600 System Board"
+CPQ0559 "Compaq ProLiant 1500 System Board"
+CPQ0561 "Compaq ProLiant 3000 System Board"
+CPQ0571 "Compaq ProSignia 200 Server"
+CPQ0579 "Compaq ProLiant 800 Server"
+CPQ0589 "Compaq ProLiant 850R"
 CPQ0601 "Compaq ProSignia Server"
 CPQ0609 "Compaq ProSignia Server"
 CPQ0611 "Compaq ProSignia Server"
@@ -169,6 +180,30 @@
 CPQ0629 "Compaq ProSignia Server (ASSY # 3154)"
 CPQ0631 "Compaq ProLiant 1000 Server"
 CPQ0639 "Compaq ProLiant 1000 Server"
+CPQ0671 "Compaq ProSignia 200"
+CPQ0679 "Compaq ProLiant 1850R"
+CPQ0680 "Compaq ProLiant CL1850 System Board"
+CPQ0681 "ProLiant CL380"
+CPQ0685 "Compaq ProLiant DL360"
+CPQ0686 "Compaq ProSignia 780"
+CPQ0687 "Compaq ProSignia 740"
+CPQ0688 "Compaq ProLiant 800 System Board"
+CPQ0689 "Compaq ProLiant 1600 System Board"
+CPQ0690 "Compaq ProLiant ML370"
+CPQ0691 "Compaq ProLiant 800"
+CPQ0692 "Compaq ProLiant DL380"
+CPQ0701 "Compaq ProSignia VS"
+CPQ0709 "Compaq ProLiant 3000 System Board"
+CPQ0711 "Compaq ProSignia VS"
+CPQ0712 "Compaq ProLiant ML530"
+CPQ0714 "Compaq ProLiant ML570"
+CPQ0715 "Compaq ProLiant DL580"
+CPQ0718 "Compaq TaskSmart N2400"
+CPQ071D "Compaq TaskSmart C2500"
+CPQ0808 "Compaq ProLiant 5500"
+CPQ0809 "Compaq ProLiant 6500 System Board"
+CPQ0810 "Compaq ProLiant 6400R System Board"
+CPQ0811 "Compaq ProLiant 1500 System Board"
 CPQ1001 "Compaq Portable 486"
 CPQ1009 "Compaq Portable 486/66"
 CPQ1201 "Compaq DESKPRO 486/25"
@@ -178,6 +213,16 @@
 CPQ1501 "Compaq SYSTEMPRO/XL Server"
 CPQ1509 "Compaq ProLiant 4000 Server"
 CPQ1519 "Compaq ProLiant 2000 Server"
+CPQ1529 "Compaq ProLiant 4500 Server"
+CPQ1561 "Compaq ProLiant 5000 System Board"
+CPQ1563 "Compaq ProLiant 6000 System Board"
+CPQ1565 "Compaq ProLiant 6500 System Board"
+CPQ1601 "Compaq ProLiant 7000"
+CPQ1602 "Compaq ProLiant 6000"
+CPQ1603 "Compaq Standard Peripherals Board"
+CPQ1608 "Compaq ProLiant 8500"
+CPQ1609 "Compaq ProLiant 8000"
+CPQ1669 "Compaq ProLiant 7000 System Board"
 CPQ3001 "Compaq Advanced VGA"
 CPQ3011 "Compaq QVision 1024/E Video Controller"
 CPQ3021 "Compaq QVision 1024/I Video Controller"
@@ -189,27 +234,43 @@
 CPQ4002 "Compaq Intelligent Drive Array Controller-2"
 CPQ4010 "Compaq 32-Bit Intelligent Drive Array Expansion Controller"
 CPQ4020 "Compaq SMART Array Controller"
+CPQ4030 "Compaq SMART-2/E Array Controller"
 CPQ4300 "Compaq Advanced ESDI Fixed Disk Controller"
 CPQ4401 "Compaq Integrated SCSI-2 Options Port"
 CPQ4410 "Compaq Integrated 32-Bit Fast-SCSI-2 Controller"
 CPQ4411 "Compaq 32-Bit Fast-SCSI-2 Controller"
 CPQ4420 "Compaq 6260 SCSI-2 Controller"
+CPQ4430 "Compaq 32-Bit Fast-Wide SCSI-2/E Controller"
+CPQ4431 "Compaq 32-Bit Fast-Wide SCSI-2/E Controller"
 CPQ5000 "Compaq 386/33 System Processor Board used as Secondary"
+CPQ5251 "Compaq 5/133 System Processor Board-2MB"
+CPQ5253 "Compaq 5/166 System Processor Board-2MB"
+CPQ5255 "Compaq 5/133 System Processor Board-1MB"
+CPQ525D "Compaq 5/100 System Processor Board-1MB"
 CPQ5281 "Compaq 486/50 System Processor Board used as Secondary"
 CPQ5282 "Compaq 486/50 System Processor Board used as Secondary"
 CPQ5287 "Compaq 5/66 System Processor Board used as Secondary"
+CPQ528A "Compaq 5/100 System Processor Board w/ Transaction Blaster"
+CPQ528B "Compaq 5/100 System Processor Board"
 CPQ528F "Compaq 486DX2/66 System Processor Board used as Secondary"
+CPQ529B "Compaq 5/90 System Processor Board"
+CPQ529F "Compaq 5/133 System Processor Board"
+CPQ52A0 "Compaq System Processor"
 CPQ5900 "Compaq 486/33 System Processor Board used as Secondary"
 CPQ5A00 "Compaq 486/33 System Processor Board (ASSY # 002013) used as Secondary"
 CPQ5B00 "Compaq 486DX2/66 System Processor Board used as Secondary"
 CPQ5C00 "Compaq 486/33 System Processor Board used as Secondary"
 CPQ6000 "Compaq 32-Bit DualSpeed Token Ring Controller"
 CPQ6001 "Compaq 32-Bit DualSpeed Token Ring Controller"
-CPQ6100 "Compaq 32-Bit NetFlex Controller"
+CPQ6002 "Compaq NetFlex-2 TR"
+CPQ6100 "Compaq NetFlex ENET-TR"
 CPQ6101 "Compaq NetFlex-2 Controller"
 CPQ6200 "Compaq DualPort Ethernet Controller"
+CPQ6300 "Compaq NetFlex-2 DualPort TR"
 CPQ7000 "Compaq 32-Bit Server Manager/R Board"
 CPQ7001 "Compaq 32-Bit Server Manager/R Board"
+CPQ7100 "Compaq Remote Insight Board"
+CPQ7200 "Compaq StorageWorks Fibre Channel Host Bus Adapter/E"
 CPQ9004 "Compaq 386/33 Processor Board"
 CPQ9005 "Compaq 386/25 Processor Board"
 CPQ9013 "Compaq 486DX2/66 System Processor Board used as Primary"
@@ -232,16 +293,60 @@
 CPQ9045 "Compaq 5/60 Processor Board"
 CPQ9046 "Compaq 5/60 Processor Board"
 CPQ9047 "Compaq 5/60 Processor Board"
+CPQ9251 "Compaq 5/133 System Processor Board-2MB"
+CPQ9253 "Compaq 5/166 System Processor Board-2MB"
+CPQ9255 "Compaq 5/133 System Processor Board-1MB"
+CPQ925D "Compaq 5/100 System Processor Board-1MB"
+CPQ925F "ProLiant 2500 Dual Pentium Pro Processor Board"
+CPQ9267 "Compaq Pentium II Processor Board"
+CPQ9278 "Compaq Processor Board"
+CPQ9279 "Compaq Processor Board"
+CPQ9280 "Compaq Processor Board"
 CPQ9281 "Compaq 486/50 System Processor Board used as Primary"
 CPQ9282 "Compaq 486/50 System Processor Board used as Primary"
+CPQ9283 "Processor Modules"
+CPQ9285 "Processor Modules"
+CPQ9286 "Compaq Slot-1 Terminator Board"
 CPQ9287 "Compaq 5/66 System Processor Board used as Primary"
+CPQ928A "Compaq 5/100 System Processor Board w/ Transaction Blaster"
+CPQ928B "Compaq 5/100 System Processor Board"
 CPQ928F "Compaq 486DX2/66 System Processor Board used as Primary"
+CPQ929B "Compaq 5/90 System Processor Board"
+CPQ929F "Compaq 5/133 System Processor Board"
+CPQ92A0 "Compaq ProLiant 1500 Processor Board"
+CPQ92A4 "Compaq System Processor Board"
+CPQ92B0 "Compaq Processor Board"
+CPQ92B1 "Compaq FRC Processor Board"
+CPQ92B2 "Compaq Terminator Board"
+CPQ92B3 "6/200 FlexSMP Dual Processor Board"
+CPQ92B4 "Compaq Processor Board"
+CPQ92B5 "Compaq Terminator Board"
+CPQ92B6 "Compaq Processor Board"
+CPQ92B7 "Compaq Processor(s)"
+CPQ92B8 "Compaq Terminator Board"
+CPQ92B9 "Compaq Terminator Board"
+CPQ9351 "Compaq 5/133 System Processor Board-2MB"
+CPQ9353 "Compaq 5/166 System Processor Board-2MB"
+CPQ9355 "Compaq 5/133 System Processor Board-1MB"
+CPQ935D "Compaq 5/100 System Processor Board-1MB"
 CPQ9381 "Compaq 486/50 System Processor Board"
 CPQ9382 "Compaq 486/50 System Processor Board"
 CPQ9387 "Compaq 5/66 System Processor Board"
+CPQ938A "Compaq 5/100 System Processor Board w/ Transaction Blaster"
+CPQ938B "Compaq 5/100 System Processor Board"
+CPQ939B "Compaq 5/90 System Processor Board"
+CPQ939F "Compaq 5/133 System Processor Board"
+CPQ9451 "Compaq 5/133 System Processor Board-2MB"
+CPQ9453 "Compaq 5/166 System Processor Board-2MB"
+CPQ9455 "Compaq 5/133 System Processor Board-1MB"
+CPQ945D "Compaq 5/100 System Processor Board-1MB"
 CPQ9481 "Compaq 486/50 System Processor Board"
 CPQ9482 "Compaq 486/50 System Processor Board"
 CPQ9487 "Compaq 5/66 System Processor Board"
+CPQ948A "Compaq 5/100 System Processor Board w/ Transaction Blaster"
+CPQ948B "Compaq 5/100 System Processor Board"
+CPQ949B "Compaq 5/90 System Processor Board"
+CPQ949F "Compaq 5/133 System Processor Board"
 CPQ9901 "Compaq 486SX/16 Processor Board"
 CPQ9902 "Compaq 486SX/16 Processor Board"
 CPQ9903 "Compaq 486SX/25 Processor Board"
@@ -261,12 +366,21 @@
 CPQ9991 "Compaq 386/33 Desktop Processor Board"
 CPQ9999 "Compaq 486/33 System Processor Board used as Primary"
 CPQ999A "Compaq 486/33 Desktop Processor Board"
+CPQ9A83 "Compaq DESKPRO XL Processor Board"
+CPQ9AA1 "Compaq ProSignia 500 Processor Board"
+CPQ9AA2 "Compaq ProSignia 300 Processor Board"
 CPQA000 "Compaq Enhanced Option Slot Serial Board"
 CPQA010 "Compaq Enhanced Option Slot Modem Board"
+CPQA015 "Compaq Integrated Remote Console (IRC)"
 CPQA020 "Compaq Integrated CD Rom Adapter"
 CPQA030 "Compaq Integrated CD Rom Adapter"
+CPQA040 "Compaq Automatic Server Recovery (ASR)"
+CPQA045 "Compaq Integrated Management Display Information"
 CPQF000 "Compaq Fixed Disk Drive Feature"
 CPQF100 "Compaq Ethernet 16TP Controller"
+CPQF110 "Compaq Token Ring 16TR Controller"
+CPQF120 "Compaq NetFlex-3/E Controller"
+CPQF140 "Compaq NetFlex-3/E Controller"
 CPQFA0D "Compaq SYSTEMPRO 4-Socket System Memory Board"
 CPQFA0E "Compaq SYSTEMPRO 6-Socket System Memory Board"
 CPQFA0F "Compaq DESKPRO 486/25 System Memory Board"
@@ -274,8 +388,11 @@
 CPQFA1B "Compaq DESKPRO 486/50 System Memory Board"
 CPQFA1C "Compaq System Memory Expansion Board"
 CPQFA1D "Compaq SYSTEMPRO/XL Memory Expansion Board"
+CPQFA1E "Compaq Memory Expansion Board"
 CPQFB03 "Compaq Async/Parallel Printer Intf Assy 000990"
 CPQFB07 "Compaq DESKPRO 2400 Baud Modem"
+CPQFB09 "Compaq SpeedPaq 144/I Modem"
+CPQFB11 "Compaq Internal 28.8/33.6 Data+Fax Modem"
 CPQFC0B "Compaq Advanced Graphics 1024 Board"
 CPQFD08 "Compaq 135Mb, 150/250Mb Tape Adapter"
 CPQFD13 "Compaq 15MHz ESDI Fixed Disk Controller 001283"
diff -ruN linux/include/linux/eisa.h linux-eisa/include/linux/eisa.h
--- linux/include/linux/eisa.h	2003-04-21 18:11:17.000000000 +0200
+++ linux-eisa/include/linux/eisa.h	2003-04-21 18:22:28.000000000 +0200
@@ -25,13 +25,15 @@
 };
 
 /* There is not much we can say about an EISA device, apart from
- * signature, slot number, and base address. */
+ * signature, slot number, and base address. dma_mask is set by
+ * default to 32 bits.*/
 
 struct eisa_device {
 	struct eisa_device_id id;
 	int                   slot;
 	unsigned long         base_addr;
 	struct resource       res;
+	u64                   dma_mask;
 	struct device         dev; /* generic device */
 };
 
@@ -63,12 +65,12 @@
  * busses (PA-RISC ?), so we try to handle that. */
 
 struct eisa_root_device {
-	struct list_head node;
 	struct device   *dev;	 /* Pointer to bridge device */
 	struct resource *res;
 	unsigned long    bus_base_addr;
 	int		 slots;  /* Max slot number */
 	int              bus_nr; /* Set by eisa_root_register */
+	struct resource  eisa_root_res;	/* ditto */
 };
 
 int eisa_root_register (struct eisa_root_device *root);

-- 
Places change, faces change. Life is so very strange.
