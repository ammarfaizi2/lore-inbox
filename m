Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277183AbRJINPE>; Tue, 9 Oct 2001 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277182AbRJINO6>; Tue, 9 Oct 2001 09:14:58 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:4356 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S277173AbRJINOs>;
	Tue, 9 Oct 2001 09:14:48 -0400
Date: Tue, 9 Oct 2001 15:15:15 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mattia.dongili@kmatrix.it, crazy@wi.rr.com, stephane.frenot@insa-lyon.fr,
        kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH 2.4.10-ac10] sonypi driver update
Message-ID: <20011009151515.I15740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch enhances the existing sonypi driver:
	* new support for PCG-GR7/K (Mattia Dongili)
	* new support for PCG-SR21K/SR33 (Carl xxx and Stephane Frenot)
	* new support for lid events on Z600NE (Kai Germaschewski)
	* minor cleanups.

Alan, please apply.

Stelian.


diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/Documentation/sonypi.txt linux-2.4.10-ac10/Documentation/sonypi.txt
--- linux-2.4.10-ac10.orig/Documentation/sonypi.txt	Tue Aug 14 01:38:29 2001
+++ linux-2.4.10-ac10/Documentation/sonypi.txt	Mon Oct  8 15:44:44 2001
@@ -15,6 +15,8 @@
 	- capture button events (only on Vaio Picturebook series)
 	- Fn keys
 	- bluetooth button (only on C1VR model)
+	- back button (PCG-GR7/K model)
+	- lid open/close events (Z600NE model)
 
 Those events (see linux/sonypi.h) can be polled using the character device node
 /dev/sonypi (major 10, minor auto allocated or specified as a option).
@@ -36,6 +38,14 @@
 Module options:
 ---------------
 
+Several options can be passed to the sonypi driver, either by adding them
+to /etc/modules.conf file, when the driver is compiled as a module or by
+adding the following to the kernel command line (in your bootloader):
+
+	sonypi=minor[[[[,camera],fnkeyinit],verbose],compat]
+
+where:
+
 	minor: 		minor number of the misc device /dev/sonypi, 
 			default is -1 (automatic allocation, see /proc/misc
 			or kernel logs)
@@ -49,6 +59,11 @@
 
 	verbose:	print unknown events from the sonypi device
 
+	compat:		uses some compatibility code for enabling the sonypi
+			events. If the driver worked for you in the past
+			(prior to version 1.5) and does not work anymore,
+			add this option and report to the author.
+
 Module use:
 -----------
 
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/drivers/char/sonypi.c linux-2.4.10-ac10/drivers/char/sonypi.c
--- linux-2.4.10-ac10.orig/drivers/char/sonypi.c	Tue Oct  9 11:09:52 2001
+++ linux-2.4.10-ac10/drivers/char/sonypi.c	Tue Oct  9 11:34:31 2001
@@ -49,6 +49,7 @@
 static int verbose; /* = 0 */
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
+static int compat; /* = 0 */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -110,27 +111,27 @@
 
 static void sonypi_ecrset(u16 addr, u16 value) {
 
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 3);
+	wait_on_command(1, inw_p(SONYPI_CST_IOPORT) & 3);
 	outw_p(0x81, SONYPI_CST_IOPORT);
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
+	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
+	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(value, SONYPI_DATA_IOPORT);
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
+	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
 }
 
 static u16 sonypi_ecrget(u16 addr) {
 
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 3);
+	wait_on_command(1, inw_p(SONYPI_CST_IOPORT) & 3);
 	outw_p(0x80, SONYPI_CST_IOPORT);
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
+	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
+	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
 	return inw_p(SONYPI_DATA_IOPORT);
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
-static void __devinit sonypi_normal_srs(void) {
+static void __devinit sonypi_type1_srs(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -152,7 +153,7 @@
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 }
 
-static void __devinit sonypi_r505_srs(void) {
+static void __devinit sonypi_type2_srs(void) {
 	sonypi_ecrset(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8);
 	sonypi_ecrset(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF);
 	sonypi_ecrset(SONYPI_SIRQ,  sonypi_device.bits);
@@ -160,7 +161,7 @@
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void __devexit sonypi_normal_dis(void) {
+static void __devexit sonypi_type1_dis(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -172,7 +173,7 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void __devexit sonypi_r505_dis(void) {
+static void __devexit sonypi_type2_dis(void) {
 	sonypi_ecrset(SONYPI_SHIB, 0);
 	sonypi_ecrset(SONYPI_SLOB, 0);
 	sonypi_ecrset(SONYPI_SIRQ, 0);
@@ -181,7 +182,7 @@
 static u8 sonypi_call1(u8 dev) {
 	u8 v1, v2;
 
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
 	v1 = inb_p(sonypi_device.ioport2);
 	v2 = inb_p(sonypi_device.ioport1);
@@ -191,9 +192,9 @@
 static u8 sonypi_call2(u8 dev, u8 fn) {
 	u8 v1;
 
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(fn, sonypi_device.ioport1);
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
@@ -202,11 +203,11 @@
 static u8 sonypi_call3(u8 dev, u8 fn, u8 v) {
 	u8 v1;
 
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(fn, sonypi_device.ioport1);
-	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
 	outb(v, sonypi_device.ioport1);
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
@@ -228,7 +229,7 @@
 /* Set brightness, hue etc */
 static void sonypi_set(u8 fn, u8 v) {
 	
-	wait_on_command(sonypi_call3(0x90, fn, v));
+	wait_on_command(0, sonypi_call3(0x90, fn, v));
 }
 
 /* Tests if the camera is ready */
@@ -291,19 +292,19 @@
 	int i;
 	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505) {
-		sonypi_jogger_ev = SONYPI_R505_JOGGER_EV;
-		sonypi_fnkey_ev = SONYPI_R505_FNKEY_EV;
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
+		sonypi_jogger_ev = SONYPI_TYPE2_JOGGER_EV;
+		sonypi_fnkey_ev = SONYPI_TYPE2_FNKEY_EV;
 	}
 	else {
-		sonypi_jogger_ev = SONYPI_NORMAL_JOGGER_EV;
-		sonypi_fnkey_ev = SONYPI_NORMAL_FNKEY_EV;
+		sonypi_jogger_ev = SONYPI_TYPE1_JOGGER_EV;
+		sonypi_fnkey_ev = SONYPI_TYPE1_FNKEY_EV;
 	}
 
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
-	if ((v2 & SONYPI_NORMAL_PKEY_EV) == SONYPI_NORMAL_PKEY_EV) {
+	if ((v2 & SONYPI_TYPE1_PKEY_EV) == SONYPI_TYPE1_PKEY_EV) {
 		for (i = 0; sonypi_pkeyev[i].event; i++)
 			if (sonypi_pkeyev[i].data == v1) {
 				event = sonypi_pkeyev[i].event;
@@ -338,9 +339,23 @@
 				goto found;
 			}
 	}
+	if ((v2 & SONYPI_BACK_EV) == SONYPI_BACK_EV) {
+		for (i = 0; sonypi_backev[i].event; i++)
+			if (sonypi_backev[i].data == v1) {
+				event = sonypi_backev[i].event;
+				goto found;
+			}
+	}
+	if ((v2 & SONYPI_LID_EV) == SONYPI_LID_EV) {
+		for (i = 0; sonypi_lidev[i].event; i++)
+			if (sonypi_lidev[i].data == v1) {
+				event = sonypi_lidev[i].event;
+				goto found;
+			}
+	}
 	if (verbose)
 		printk(KERN_WARNING 
-		       "sonypi: unknown event port1=0x%x,port2=0x%x\n",v1,v2);
+		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",v1,v2);
 	return;
 
 found:
@@ -564,15 +579,15 @@
 		goto out1;
 	}
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505) {
-		ioport_list = sonypi_r505_ioport_list;
-		sonypi_device.region_size = SONYPI_R505_REGION_SIZE;
-		irq_list = sonypi_r505_irq_list;
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
+		ioport_list = sonypi_type2_ioport_list;
+		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
+		irq_list = sonypi_type2_irq_list;
 	}
 	else {
-		ioport_list = sonypi_normal_ioport_list;
-		sonypi_device.region_size = SONYPI_NORMAL_REGION_SIZE;
-		irq_list = sonypi_normal_irq_list;
+		ioport_list = sonypi_type1_ioport_list;
+		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
+		irq_list = sonypi_type1_irq_list;
 	}
 
 	for (i = 0; ioport_list[i].port1; i++) {
@@ -608,22 +623,28 @@
 	if (fnkeyinit)
 		outb(0xf0, 0xb2);
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505)
-		sonypi_r505_srs();
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+		sonypi_type2_srs();
 	else
-		sonypi_normal_srs();
+		sonypi_type1_srs();
 
 	sonypi_call1(0x82);
 	sonypi_call2(0x81, 0xff);
-	sonypi_call1(0x92); 
+	if (compat)
+		sonypi_call1(0x92); 
+	else
+		sonypi_call1(0x82);
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
-	printk(KERN_INFO "sonypi: detected %s model, camera = %s\n",
-	       (sonypi_device.model == SONYPI_DEVICE_MODEL_NORMAL) ?
-	       "normal" : "R505",
-	       camera ? "on" : "off");
+	printk(KERN_INFO "sonypi: detected %s model (%04x:%04x), "
+	       "camera = %s, compat = %s\n",
+	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
+			"type1" : "type2",
+	       sonypi_device.dev->vendor, sonypi_device.dev->device,
+	       camera ? "on" : "off",
+	       compat ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -645,10 +666,10 @@
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
 	if (camera)
 		sonypi_camera_off();
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505)
-		sonypi_r505_dis();
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+		sonypi_type2_dis();
 	else
-		sonypi_normal_dis();
+		sonypi_type1_dis();
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
@@ -658,10 +679,13 @@
 static struct pci_device_id sonypi_id_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-	  (unsigned long) SONYPI_DEVICE_MODEL_NORMAL },
+	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE1 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-	  (unsigned long) SONYPI_DEVICE_MODEL_R505 },
+	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE2 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+	  (unsigned long) SONYPI_DEVICE_MODEL_TYPE2 },
 	{ }
 };
 
@@ -685,6 +709,33 @@
 	pci_unregister_driver(&sonypi_driver);
 }
 
+#ifndef MODULE
+static int __init sonypi_setup(char *str)  {
+	int ints[6];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	if (ints[0] <= 0) 
+		goto out;
+	minor = ints[1];
+	if (ints[0] == 1)
+		goto out;
+	verbose = ints[2];
+	if (ints[0] == 2)
+		goto out;
+	fnkeyinit = ints[3];
+	if (ints[0] == 3)
+		goto out;
+	camera = ints[4];
+	if (ints[0] == 4)
+		goto out;
+	compat = ints[5];
+out:
+	return 1;
+}
+
+__setup("sonypi=", sonypi_setup);
+#endif /* !MODULE */
+	
 /* Module entry points */
 module_init(sonypi_init_module);
 module_exit(sonypi_cleanup_module);
@@ -702,5 +753,7 @@
 MODULE_PARM_DESC(fnkeyinit, "set this if your Fn keys do not generate any event");
 MODULE_PARM(camera,"i");
 MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
+MODULE_PARM(compat,"i");
+MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/drivers/char/sonypi.h linux-2.4.10-ac10/drivers/char/sonypi.h
--- linux-2.4.10-ac10.orig/drivers/char/sonypi.h	Tue Sep 18 07:52:35 2001
+++ linux-2.4.10-ac10/drivers/char/sonypi.h	Tue Oct  9 10:54:24 2001
@@ -35,26 +35,26 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	5
+#define SONYPI_DRIVER_MINORVERSION	6
 
 #include <linux/types.h>
 #include <linux/pci.h>
 #include "linux/sonypi.h"
 
-/* Normal models use those */
+/* type1 models use those */
 #define SONYPI_IRQ_PORT			0x8034
 #define SONYPI_IRQ_SHIFT		22
 #define SONYPI_BASE			0x50
 #define SONYPI_G10A			(SONYPI_BASE+0x14)
-#define SONYPI_NORMAL_REGION_SIZE	0x08
+#define SONYPI_TYPE1_REGION_SIZE	0x08
 
-/* R505 series specifics */
-#define SONYPI_SIRQ		0x9b
-#define SONYPI_SLOB		0x9c
-#define SONYPI_SHIB		0x9d
-#define SONYPI_R505_REGION_SIZE	0x20
+/* type2 series specifics */
+#define SONYPI_SIRQ			0x9b
+#define SONYPI_SLOB			0x9c
+#define SONYPI_SHIB			0x9d
+#define SONYPI_TYPE2_REGION_SIZE	0x20
 
-/* ioports used for brightness and R505 events */
+/* ioports used for brightness and type2 events */
 #define SONYPI_DATA_IOPORT	0x62
 #define SONYPI_CST_IOPORT	0x66
 
@@ -64,7 +64,7 @@
 	u16	port2;
 };
 
-static struct sonypi_ioport_list sonypi_normal_ioport_list[] = {
+static struct sonypi_ioport_list sonypi_type1_ioport_list[] = {
 	{ 0x10c0, 0x10c4 },	/* looks like the default on C1Vx */
 	{ 0x1080, 0x1084 },
 	{ 0x1090, 0x1094 },
@@ -73,7 +73,7 @@
 	{ 0x0, 0x0 }
 };
 
-static struct sonypi_ioport_list sonypi_r505_ioport_list[] = {
+static struct sonypi_ioport_list sonypi_type2_ioport_list[] = {
 	{ 0x1080, 0x1084 },
 	{ 0x10a0, 0x10a4 },
 	{ 0x10c0, 0x10c4 },
@@ -87,14 +87,14 @@
 	u16	bits;
 };
 
-static struct sonypi_irq_list sonypi_normal_irq_list[] = {
+static struct sonypi_irq_list sonypi_type1_irq_list[] = {
 	{ 11, 0x2 },	/* IRQ 11, GO22=0,GO23=1 in AML */
 	{ 10, 0x1 },	/* IRQ 10, GO22=1,GO23=0 in AML */
 	{  5, 0x0 },	/* IRQ  5, GO22=0,GO23=0 in AML */
 	{  0, 0x3 }	/* no IRQ, GO22=1,GO23=1 in AML */
 };
 
-static struct sonypi_irq_list sonypi_r505_irq_list[] = {
+static struct sonypi_irq_list sonypi_type2_irq_list[] = {
 	{ 11, 0x80 },	/* IRQ 11, 0x80 in SIRQ in AML */
 	{ 10, 0x40 },	/* IRQ 10, 0x40 in SIRQ in AML */
 	{  9, 0x20 },	/* IRQ  9, 0x20 in SIRQ in AML */
@@ -132,13 +132,15 @@
 #define SONYPI_CAMERA_ROMVERSION 		9
 
 /* key press event data (ioport2) */
-#define SONYPI_NORMAL_JOGGER_EV	0x10
-#define SONYPI_R505_JOGGER_EV	0x08
+#define SONYPI_TYPE1_JOGGER_EV	0x10
+#define SONYPI_TYPE2_JOGGER_EV	0x08
 #define SONYPI_CAPTURE_EV	0x60
-#define SONYPI_NORMAL_FNKEY_EV	0x20
-#define SONYPI_R505_FNKEY_EV	0x08
+#define SONYPI_TYPE1_FNKEY_EV	0x20
+#define SONYPI_TYPE2_FNKEY_EV	0x08
 #define SONYPI_BLUETOOTH_EV	0x30
-#define SONYPI_NORMAL_PKEY_EV	0x40
+#define SONYPI_TYPE1_PKEY_EV	0x40
+#define SONYPI_BACK_EV		0x08
+#define SONYPI_LID_EV		0x38
 
 struct sonypi_event {
 	u8	data;
@@ -204,6 +206,19 @@
 	{ 0x00, 0x00 }
 };
 
+/* The set of possible back button events */
+static struct sonypi_event sonypi_backev[] = {
+	{ 0x20, SONYPI_EVENT_BACK_PRESSED },
+	{ 0x00, 0x00 }
+};
+
+/* The set of possible lid events */
+static struct sonypi_event sonypi_lidev[] = {
+	{ 0x51, SONYPI_EVENT_LID_CLOSED },
+	{ 0x50, SONYPI_EVENT_LID_OPENED },
+	{ 0x00, 0x00 }
+};
+
 #define SONYPI_BUF_SIZE	128
 struct sonypi_queue {
 	unsigned long head;
@@ -215,8 +230,8 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
-#define SONYPI_DEVICE_MODEL_NORMAL	1
-#define SONYPI_DEVICE_MODEL_R505	2
+#define SONYPI_DEVICE_MODEL_TYPE1	1
+#define SONYPI_DEVICE_MODEL_TYPE2	2
 
 struct sonypi_device {
 	struct pci_dev *dev;
@@ -232,11 +247,11 @@
 	int model;
 };
 
-#define wait_on_command(command) { \
+#define wait_on_command(quiet, command) { \
 	unsigned int n = 10000; \
 	while (--n && (command)) \
 		udelay(1); \
-	if (!n) \
+	if (!n && (verbose || !quiet)) \
 		printk(KERN_WARNING "sonypi command failed at " __FILE__ " : " __FUNCTION__ "(line %d)\n", __LINE__); \
 }
 
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/include/linux/pci_ids.h linux-2.4.10-ac10/include/linux/pci_ids.h
--- linux-2.4.10-ac10.orig/include/linux/pci_ids.h	Tue Oct  9 11:13:00 2001
+++ linux-2.4.10-ac10/include/linux/pci_ids.h	Mon Oct  8 15:43:45 2001
@@ -1594,6 +1594,16 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
 #define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
+#define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
+#define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
+#define PCI_DEVICE_ID_INTEL_82801CA_4	0x2484
+#define PCI_DEVICE_ID_INTEL_82801CA_5	0x2485
+#define PCI_DEVICE_ID_INTEL_82801CA_6	0x2486
+#define PCI_DEVICE_ID_INTEL_82801CA_7	0x2487
+#define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
+#define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
+#define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/include/linux/sonypi.h linux-2.4.10-ac10/include/linux/sonypi.h
--- linux-2.4.10-ac10.orig/include/linux/sonypi.h	Fri Sep 21 05:57:25 2001
+++ linux-2.4.10-ac10/include/linux/sonypi.h	Mon Oct  8 16:01:08 2001
@@ -67,9 +67,12 @@
 #define SONYPI_EVENT_FNKEY_S			29
 #define SONYPI_EVENT_FNKEY_B			30
 #define SONYPI_EVENT_BLUETOOTH_PRESSED		31
-#define SONYPI_EVENT_PKEY_P1                    32
-#define SONYPI_EVENT_PKEY_P2                    33
-#define SONYPI_EVENT_PKEY_P3                    34
+#define SONYPI_EVENT_PKEY_P1			32
+#define SONYPI_EVENT_PKEY_P2			33
+#define SONYPI_EVENT_PKEY_P3			34
+#define SONYPI_EVENT_BACK_PRESSED		35
+#define SONYPI_EVENT_LID_CLOSED			36
+#define SONYPI_EVENT_LID_OPENED			37
 
 
 /* brightness etc. ioctls */
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
