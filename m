Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRJOL4k>; Mon, 15 Oct 2001 07:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277437AbRJOL4a>; Mon, 15 Oct 2001 07:56:30 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:44305 "EHLO
	smtp.alcove-fr") by vger.kernel.org with ESMTP id <S277435AbRJOL4Q>;
	Mon, 15 Oct 2001 07:56:16 -0400
Date: Mon, 15 Oct 2001 13:56:42 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: sonypi wrongly claims ownership of ISA and ACPI bridges
Message-ID: <20011015135642.L4523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011015102110.A21699@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011015102110.A21699@caldera.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 10:21:10AM +0200, Marcus Meissner wrote:

> Your sonypi driver claims the ownership of 2 Intel ACPI bridges and 1 ISA 
> bridge.
> 
> All 3 are used in standard Intel chipsets, not just in Sony VAIOs.
> 
> Please do not use them, it confuses the hell out of the autoprobing and
> automatic PCI driver registration.
> 
> I suggest checking up if this device has PnPBIOS entries and using them,
> or using a different method of autoprobing.

Testing against is_sony_vaio_laptop should be sufficient here.

Alan, please apply the following patch (instead of Marcus' one).
It changes the initialisation sequence (first the ISA bridge for
the older hardware, then it supposes newer hardware), and doesn't
registers itself in the kernel pci device table.

A little documentation update is also included.

Thanks,

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.12-ac2.orig/Documentation/sonypi.txt linux-2.4.12-ac2/Documentation/sonypi.txt
--- linux-2.4.12-ac2.orig/Documentation/sonypi.txt	Mon Oct 15 12:36:00 2001
+++ linux-2.4.12-ac2/Documentation/sonypi.txt	Mon Oct 15 12:32:35 2001
@@ -55,7 +55,9 @@
 			in order to let the driver access to the camera
 
 	fnkeyinit:	on some Vaios (C1VE, C1VR etc), the Fn key events don't
-			get enabled unless you set this parameter to 1
+			get enabled unless you set this parameter to 1.
+			Do not use this option unless it's actually necessary,
+			some Vaio models don't deal well with this option.
 
 	verbose:	print unknown events from the sonypi device
 
@@ -71,7 +73,7 @@
 lines in your /etc/modules.conf file:
 
 	alias char-major-10-250 sonypi
-	options sonypi minor=250 fnkeyinit=1
+	options sonypi minor=250
 
 This supposes the use of minor 250 for the sonypi device:
 
diff -uNr --exclude-from=dontdiff linux-2.4.12-ac2.orig/drivers/char/sonypi.c linux-2.4.12-ac2/drivers/char/sonypi.c
--- linux-2.4.12-ac2.orig/drivers/char/sonypi.c	Mon Oct 15 12:36:13 2001
+++ linux-2.4.12-ac2/drivers/char/sonypi.c	Mon Oct 15 12:36:39 2001
@@ -550,23 +550,20 @@
 	-1, "sonypi", &sonypi_misc_fops
 };
 
-static int __devinit sonypi_probe(struct pci_dev *pcidev, 
-		                  const struct pci_device_id *ent) {
+static int __devinit sonypi_probe(struct pci_dev *pcidev) {
 	int i, ret;
 	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
 
-	if (sonypi_device.dev) {
-		printk(KERN_ERR "sonypi: only one device allowed!\n"),
-		ret = -EBUSY;
-		goto out1;
-	}
 	sonypi_device.dev = pcidev;
-	sonypi_device.model = (int)ent->driver_data;
+	if (pcidev)
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
+	else
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
 	
-	if (pci_enable_device(pcidev)) {
+	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
 		ret = -EIO;
 		goto out1;
@@ -638,11 +635,10 @@
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
-	printk(KERN_INFO "sonypi: detected %s model (%04x:%04x), "
+	printk(KERN_INFO "sonypi: detected %s model, "
 	       "camera = %s, compat = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
-	       sonypi_device.dev->vendor, sonypi_device.dev->device,
 	       camera ? "on" : "off",
 	       compat ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
@@ -662,7 +658,7 @@
 	return ret;
 }
 
-static void __devexit sonypi_remove(struct pci_dev *pcidev) {
+static void __devexit sonypi_remove(void) {
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
 	if (camera)
 		sonypi_camera_off();
@@ -676,37 +672,21 @@
 	printk(KERN_INFO "sonypi: removed.\n");
 }
 
-static struct pci_device_id sonypi_id_tbl[] __devinitdata = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE1 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE2 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE2 },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(pci, sonypi_id_tbl);
-
-static struct pci_driver sonypi_driver = {
-	name:		"sonypi",
-	id_table:	sonypi_id_tbl,
-	probe:		sonypi_probe,
-	remove:		sonypi_remove,
-};
-
 static int __init sonypi_init_module(void) {
-	if (is_sony_vaio_laptop)
-		return pci_module_init(&sonypi_driver);
+	struct pci_dev *pcidev = NULL;
+
+	if (is_sony_vaio_laptop) {
+		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL, 
+					 PCI_DEVICE_ID_INTEL_82371AB_3, 
+					 NULL);
+		return sonypi_probe(pcidev);
+	}
 	else
 		return -ENODEV;
 }
 
 static void __exit sonypi_cleanup_module(void) {
-	pci_unregister_driver(&sonypi_driver);
+	sonypi_remove();
 }
 
 #ifndef MODULE
diff -uNr --exclude-from=dontdiff linux-2.4.12-ac2.orig/drivers/char/sonypi.h linux-2.4.12-ac2/drivers/char/sonypi.h
--- linux-2.4.12-ac2.orig/drivers/char/sonypi.h	Mon Oct 15 12:36:13 2001
+++ linux-2.4.12-ac2/drivers/char/sonypi.h	Mon Oct 15 12:33:42 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	6
+#define SONYPI_DRIVER_MINORVERSION	7
 
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
