Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVHAA7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVHAA7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHAA7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:59:07 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:35297 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262294AbVHAA7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:59:05 -0400
Date: Mon, 1 Aug 2005 02:59:00 +0200
From: Erik Waling <erikw@acc.umu.se>
To: linux-kernel@vger.kernel.org
Cc: stelian@popies.net
Subject: [PATCH] sonypi, kernel 2.6.12.3
Message-ID: <20050801005900.GB20370@shaka.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Sony VAIO models (VGN-S480, VGN-S460, VGN-S3XP etc) use a new method to
initialize the SPIC device. The new way to initialize (and disable) the device
comes directly from the AML code in the _CRS, _SRS and _DIS methods from the
DSDT table. This patch against 2.6.12.3 adds support for the new models.

-- Erik Waling  <erikw@acc.umu.se>



--- linux-2.6.12.3/drivers/char/sonypi.c	2005-07-15 16:18:57.000000000 -0500
+++ linux/drivers/char/sonypi.c	2005-07-31 16:55:41.000000000 -0500
@@ -98,12 +98,13 @@
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
+#define SONYPI_DEVICE_MODEL_TYPE3	3
 
 /* type1 models use those */
 #define SONYPI_IRQ_PORT			0x8034
 #define SONYPI_IRQ_SHIFT		22
-#define SONYPI_BASE			0x50
-#define SONYPI_G10A			(SONYPI_BASE+0x14)
+#define SONYPI_TYPE1_BASE		0x50
+#define SONYPI_G10A			(SONYPI_TYPE1_BASE+0x14)
 #define SONYPI_TYPE1_REGION_SIZE	0x08
 #define SONYPI_TYPE1_EVTYPE_OFFSET	0x04
 
@@ -114,6 +115,13 @@
 #define SONYPI_TYPE2_REGION_SIZE	0x20
 #define SONYPI_TYPE2_EVTYPE_OFFSET	0x12
 
+/* type3 series specifics */
+#define SONYPI_TYPE3_BASE		0x40
+#define SONYPI_TYPE3_GID2		(SONYPI_TYPE3_BASE+0x48) /* 16 bits */
+#define SONYPI_TYPE3_MISC		(SONYPI_TYPE3_BASE+0x6d) /* 8 bits  */
+#define SONYPI_TYPE3_REGION_SIZE	0x20
+#define SONYPI_TYPE3_EVTYPE_OFFSET	0x12
+
 /* battery / brightness addresses */
 #define SONYPI_BAT_FLAGS	0x81
 #define SONYPI_LCD_LIGHT	0x96
@@ -159,6 +167,10 @@
 	{ 0x0, 0x0 }
 };
 
+/* same as in type 2 models */
+static struct sonypi_ioport_list *sonypi_type3_ioport_list = 
+	sonypi_type2_ioport_list;
+
 /* The set of possible interrupts */
 struct sonypi_irq_list {
 	u16	irq;
@@ -180,6 +192,9 @@
 	{  0, 0x00 }	/* no IRQ, 0x00 in SIRQ in AML */
 };
 
+/* same as in type2 models */
+static struct sonypi_irq_list *sonypi_type3_irq_list = sonypi_type2_irq_list;
+
 #define SONYPI_CAMERA_BRIGHTNESS		0
 #define SONYPI_CAMERA_CONTRAST			1
 #define SONYPI_CAMERA_HUE			2
@@ -223,6 +238,7 @@
 #define SONYPI_MEYE_MASK			0x00000400
 #define SONYPI_MEMORYSTICK_MASK			0x00000800
 #define SONYPI_BATTERY_MASK			0x00001000
+#define SONYPI_WIRELESS_MASK			0x00002000
 
 struct sonypi_event {
 	u8	data;
@@ -305,6 +321,13 @@
 	{ 0, 0 }
 };
 
+/* The set of possible wireless events */
+static struct sonypi_event sonypi_wlessev[] = {
+	{ 0x59, SONYPI_EVENT_WIRELESS_ON },
+	{ 0x5a, SONYPI_EVENT_WIRELESS_OFF },
+	{ 0, 0 }
+};
+
 /* The set of possible back button events */
 static struct sonypi_event sonypi_backev[] = {
 	{ 0x20, SONYPI_EVENT_BACK_PRESSED },
@@ -391,6 +414,12 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
 
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0, 0xffffffff, sonypi_releaseev },
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0x31, SONYPI_WIRELESS_MASK, sonypi_wlessev },
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ SONYPI_DEVICE_MODEL_TYPE3, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ 0 }
 };
 
@@ -558,6 +587,23 @@
 	udelay(10);
 }
 
+static void sonypi_type3_srs(void)
+{
+	u16 v16;
+	u8  v8;
+
+	/* This model type uses the same initialiazation of 
+	 * the embedded controller as the type2 models. */
+	sonypi_type2_srs();
+
+	/* Initialization of PCI config space of the LPC interface bridge. */
+	v16 = (sonypi_device.ioport1 & 0xFFF0) | 0x01;
+	pci_write_config_word(sonypi_device.dev, SONYPI_TYPE3_GID2, v16);
+	pci_read_config_byte(sonypi_device.dev, SONYPI_TYPE3_MISC, &v8);
+	v8 = (v8 & 0xCF) | 0x10;
+	pci_write_config_byte(sonypi_device.dev, SONYPI_TYPE3_MISC, v8);
+}
+
 /* Disables the device - this comes from the AML code in the ACPI bios */
 static void sonypi_type1_dis(void)
 {
@@ -582,6 +628,13 @@
 		printk(KERN_WARNING "ec_write failed\n");
 }
 
+static void sonypi_type3_dis(void)
+{
+	sonypi_type2_dis();
+	udelay(10);
+	pci_write_config_word(sonypi_device.dev, SONYPI_TYPE3_GID2, 0);
+}
+
 static u8 sonypi_call1(u8 dev)
 {
 	u8 v1, v2;
@@ -1066,10 +1119,17 @@
 
 static void sonypi_enable(unsigned int camera_on)
 {
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_srs();
-	else
+	switch (sonypi_device.model) {
+	case SONYPI_DEVICE_MODEL_TYPE1:
 		sonypi_type1_srs();
+		break;
+	case SONYPI_DEVICE_MODEL_TYPE2:
+		sonypi_type2_srs();
+		break;
+	case SONYPI_DEVICE_MODEL_TYPE3:
+		sonypi_type3_srs();
+		break;
+	}
 
 	sonypi_call1(0x82);
 	sonypi_call2(0x81, 0xff);
@@ -1093,10 +1153,18 @@
 	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf1, 0xb2);
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_dis();
-	else
+	switch (sonypi_device.model) {
+	case SONYPI_DEVICE_MODEL_TYPE1:
 		sonypi_type1_dis();
+		break;
+	case SONYPI_DEVICE_MODEL_TYPE2:
+		sonypi_type2_dis();
+		break;
+	case SONYPI_DEVICE_MODEL_TYPE3:
+		sonypi_type3_dis();
+		break;
+	}
+	
 	return 0;
 }
 
@@ -1142,12 +1210,16 @@
 	struct sonypi_irq_list *irq_list;
 	struct pci_dev *pcidev;
 
-	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, 
+				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
+	else
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 
 	sonypi_device.dev = pcidev;
-	sonypi_device.model = pcidev ?
-		SONYPI_DEVICE_MODEL_TYPE1 : SONYPI_DEVICE_MODEL_TYPE2;
 
 	spin_lock_init(&sonypi_device.fifo_lock);
 	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
@@ -1175,16 +1247,22 @@
 		goto out_miscreg;
 	}
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
+	
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) {
+		ioport_list = sonypi_type1_ioport_list;
+		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
+		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
+		irq_list = sonypi_type1_irq_list;
+	} else if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
 		ioport_list = sonypi_type2_ioport_list;
 		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
 		sonypi_device.evtype_offset = SONYPI_TYPE2_EVTYPE_OFFSET;
 		irq_list = sonypi_type2_irq_list;
 	} else {
-		ioport_list = sonypi_type1_ioport_list;
-		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
-		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
-		irq_list = sonypi_type1_irq_list;
+		ioport_list = sonypi_type3_ioport_list;
+		sonypi_device.region_size = SONYPI_TYPE3_REGION_SIZE;
+		sonypi_device.evtype_offset = SONYPI_TYPE3_EVTYPE_OFFSET;
+		irq_list = sonypi_type3_irq_list;
 	}
 
 	for (i = 0; ioport_list[i].port1; i++) {
@@ -1287,11 +1365,10 @@
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver"
 	       "v%s.\n", SONYPI_DRIVER_VERSION);
-	printk(KERN_INFO "sonypi: detected %s model, "
+	printk(KERN_INFO "sonypi: detected type%d model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
 	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
-	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
-			"type1" : "type2",
+	       sonypi_device.model,
 	       verbose,
 	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
--- linux-2.6.12.3/include/linux/sonypi.h	2005-07-15 16:18:57.000000000 -0500
+++ linux/include/linux/sonypi.h	2005-07-31 18:10:37.000000000 -0500
@@ -99,6 +99,8 @@
 #define SONYPI_EVENT_BATTERY_INSERT		57
 #define SONYPI_EVENT_BATTERY_REMOVE		58
 #define SONYPI_EVENT_FNKEY_RELEASED		59
+#define SONYPI_EVENT_WIRELESS_ON		60
+#define SONYPI_EVENT_WIRELESS_OFF		61
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
--- linux-2.6.12.3/Documentation/sonypi.txt	2005-07-15 16:18:57.000000000 -0500
+++ linux/Documentation/sonypi.txt	2005-07-31 18:12:20.000000000 -0500
@@ -99,6 +99,7 @@
 				SONYPI_MEYE_MASK		0x0400
 				SONYPI_MEMORYSTICK_MASK		0x0800
 				SONYPI_BATTERY_MASK		0x1000
+				SONYPI_WIRELESS_MASK		0x2000
 
 	useinput:	if set (which is the default) two input devices are
 			created, one which interprets the jogdial events as
@@ -137,6 +138,13 @@
 	  speed handling etc). Use ACPI instead of APM if it works on your
 	  laptop.
 
+	- sonypi lacks the ability to distinguish between certain key 
+	  events on some models.
+
+	- some models with the nvidia card (geforce go 6200 tc) uses a 
+	  different way to adjust the backlighting of the screen. There
+	  is a userspace utility to adjust the brightness on those models.
+	
 	- since all development was done by reverse engineering, there is
 	  _absolutely no guarantee_ that this driver will not crash your
 	  laptop. Permanently.
