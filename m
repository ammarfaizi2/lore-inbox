Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRFRIsd>; Mon, 18 Jun 2001 04:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263786AbRFRIsY>; Mon, 18 Jun 2001 04:48:24 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:15111 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S263780AbRFRIsN>;
	Mon, 18 Jun 2001 04:48:13 -0400
Date: Mon, 18 Jun 2001 10:47:58 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.5-ac15] Sony PI Vaio updates...
Message-ID: <20010618104758.E26725@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the Sony Programmable I/O Controller driver
for the Vaio laptops by:
	- adding support for newer R505 series (credits go to
	  Michael Ashley <m.ashley@unsw.edu.au>)

	- adding two ioctl commands for getting/setting the
	  brightness on those laptops

	- new module parameter for specifying if a camera should
	  be initialized (to be used on PictureBook series)

	- small fix in the event processing logic

Alan, please apply.

Thanks,

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.5-ac15.orig/Documentation/sonypi.txt linux-2.4.5-ac15/Documentation/sonypi.txt
--- linux-2.4.5-ac15.orig/Documentation/sonypi.txt	Fri Jun 15 14:17:12 2001
+++ linux-2.4.5-ac15/Documentation/sonypi.txt	Fri Jun 15 15:40:58 2001
@@ -1,6 +1,7 @@
 Sony Programmable I/O Control Device Driver Readme
 --------------------------------------------------
 	Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
 	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
 	Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
@@ -21,6 +22,9 @@
 A simple daemon which translates the jogdial movements into mouse wheel events
 can be downloaded at: <http://www.alcove-labs.org/en/software/sonypi/>
 
+This driver supports also some ioctl commands for setting the LCD screen
+brightness (some more commands may be added in the future).
+
 This driver can also be used to set the camera controls on Picturebook series
 (brightness, contrast etc), and is used by the video4linux driver for the 
 Motion Eye camera.
@@ -36,6 +40,10 @@
 			default is -1 (automatic allocation, see /proc/misc
 			or kernel logs)
 
+	camera:		if you have a PictureBook series Vaio (with the
+			integrated MotionEye camera), set this parameter to 1
+			in order to let the driver access to the camera
+
 	fnkeyinit:	on some Vaios (C1VE, C1VR etc), the Fn key events don't
 			get enabled unless you set this parameter to 1
 
@@ -60,9 +68,3 @@
 	- since all development was done by reverse engineering, there is
 	  _absolutely no guarantee_ that this driver will not crash your
 	  laptop. Permanently.
-
-	- newer Vaios (R505 series) have a different SPIC device, not yet
-	  recognized by this driver.
-
-	- should this driver also take care of setting Vaio brightness ?
-	  (it's a different set of ioports though).
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac15.orig/drivers/char/sonypi.c linux-2.4.5-ac15/drivers/char/sonypi.c
--- linux-2.4.5-ac15.orig/drivers/char/sonypi.c	Fri Jun 15 14:17:21 2001
+++ linux-2.4.5-ac15/drivers/char/sonypi.c	Mon Jun 18 10:25:18 2001
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
  *
+ * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
+ *
  * Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
  *
  * Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
@@ -45,6 +47,7 @@
 static int minor = -1;
 static int verbose; /* = 0 */
 static int fnkeyinit; /* = 0 */
+static int camera; /* = 0 */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -104,8 +107,38 @@
         return result;
 }
 
+static void sonypi_ecrset(u16 addr, u16 value) {
+	int n = 100;
+
+	while (n-- && (inw_p(SONYPI_CST_IOPORT) & 3))
+		udelay(1);
+	outw_p(0x81, SONYPI_CST_IOPORT);
+	while (inw_p(SONYPI_CST_IOPORT) & 2)
+		udelay(1);
+	outw_p(addr, SONYPI_DATA_IOPORT);
+	while (inw_p(SONYPI_CST_IOPORT) & 2)
+		udelay(1);
+	outw_p(value, SONYPI_DATA_IOPORT);
+	while (inw_p(SONYPI_CST_IOPORT) & 2)
+		udelay(1);
+}
+
+static u16 sonypi_ecrget(u16 addr) {
+	int n = 100;
+
+	while (n-- && (inw_p(SONYPI_CST_IOPORT) & 3))
+		udelay(1);
+	outw_p(0x80, SONYPI_CST_IOPORT);
+	while (inw_p(SONYPI_CST_IOPORT) & 2)
+		udelay(1);
+	outw_p(addr, SONYPI_DATA_IOPORT);
+	while (inw_p(SONYPI_CST_IOPORT) & 2)
+		udelay(1);
+	return inw_p(SONYPI_DATA_IOPORT);
+}
+
 /* Initializes the device - this comes from the AML code in the ACPI bios */
-static void __devinit sonypi_srs(void) {
+static void __devinit sonypi_normal_srs(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -127,8 +160,15 @@
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 }
 
+static void __devinit sonypi_r505_srs(void) {
+	sonypi_ecrset(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8);
+	sonypi_ecrset(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF);
+	sonypi_ecrset(SONYPI_SIRQ,  sonypi_device.bits);
+	udelay(10);
+}
+
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void __devexit sonypi_dis(void) {
+static void __devexit sonypi_normal_dis(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -140,6 +180,12 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
+static void __devexit sonypi_r505_dis(void) {
+	sonypi_ecrset(SONYPI_SHIB, 0);
+	sonypi_ecrset(SONYPI_SLOB, 0);
+	sonypi_ecrset(SONYPI_SIRQ, 0);
+}
+
 static u8 sonypi_call1(u8 dev) {
 	u8 v1, v2;
 
@@ -218,6 +264,8 @@
 /* Turns the camera off */
 static void sonypi_camera_off(void) {
 
+	sonypi_set(SONYPI_CAMERA_PICTURE, SONYPI_CAMERA_MUTE_MASK);
+
 	if (!sonypi_device.camera_power)
 		return;
 
@@ -263,56 +311,64 @@
 void sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u8 v1, v2, event = 0;
 	int i;
+	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
+
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505) {
+		sonypi_jogger_ev = SONYPI_R505_JOGGER_EV;
+		sonypi_fnkey_ev = SONYPI_R505_FNKEY_EV;
+	}
+	else {
+		sonypi_jogger_ev = SONYPI_NORMAL_JOGGER_EV;
+		sonypi_fnkey_ev = SONYPI_NORMAL_FNKEY_EV;
+	}
 
 	v1 = inb_p(sonypi_device.ioport1);
-	v2 = inb_p(sonypi_device.ioport2) & 0xf0;
+	v2 = inb_p(sonypi_device.ioport2);
 
-	switch (v2) {
-		case SONYPI_JOGGER_EV:
-			for (i = 0; sonypi_joggerev[i].event; i++)
-				if (sonypi_joggerev[i].data == v1) {
-					event = sonypi_joggerev[i].event;
-					break;
-				}
-			break;
-		case SONYPI_CAPTURE_EV:
-			for (i = 0; sonypi_captureev[i].event; i++)
-				if (sonypi_captureev[i].data == v1) {
-					event = sonypi_captureev[i].event;
-					break;
-				}
-			break;
-		case SONYPI_FNKEY_EV:
-			for (i = 0; sonypi_fnkeyev[i].event; i++)
-				if (sonypi_fnkeyev[i].data == v1) {
-					event = sonypi_fnkeyev[i].event;
-					break;
-				}
-			break;
-		case SONYPI_BLUETOOTH_EV:
-			for (i = 0; sonypi_blueev[i].event; i++)
-				if (sonypi_blueev[i].data == v1) {
-					event = sonypi_blueev[i].event;
-					break;
-				}
-			break;
-		case 0x0c:
-		case 0x04:
-		case 0xff:
-			/* the answer event from the write reqest to ioport? */
-			return;
-	}
-	if (event)
-		sonypi_pushq(event);
-	else if (verbose)
+	if ((v2 & sonypi_jogger_ev) == sonypi_jogger_ev) {
+		for (i = 0; sonypi_joggerev[i].event; i++)
+			if (sonypi_joggerev[i].data == v1) {
+				event = sonypi_joggerev[i].event;
+				goto found;
+			}
+	}
+	if ((v2 & SONYPI_CAPTURE_EV) == SONYPI_CAPTURE_EV) {
+		for (i = 0; sonypi_captureev[i].event; i++)
+			if (sonypi_captureev[i].data == v1) {
+				event = sonypi_captureev[i].event;
+				goto found;
+			}
+	}
+	if ((v2 & sonypi_fnkey_ev) == sonypi_fnkey_ev) {
+		for (i = 0; sonypi_fnkeyev[i].event; i++)
+			if (sonypi_fnkeyev[i].data == v1) {
+				event = sonypi_fnkeyev[i].event;
+				goto found;
+			}
+	}
+	if ((v2 & SONYPI_BLUETOOTH_EV) == SONYPI_BLUETOOTH_EV) {
+		for (i = 0; sonypi_blueev[i].event; i++)
+			if (sonypi_blueev[i].data == v1) {
+				event = sonypi_blueev[i].event;
+				goto found;
+			}
+	}
+	if (verbose)
 		printk(KERN_WARNING 
 		       "sonypi: unknown event port1=0x%x,port2=0x%x\n",v1,v2);
+	return;
+
+found:
+	sonypi_pushq(event);
 }
 
-/* External camera command (exported to the motion eye v4l driver */
+/* External camera command (exported to the motion eye v4l driver) */
 u8 sonypi_camera_command(int command, u8 value) {
 	u8 ret = 0;
 
+	if (!camera)
+		return 0;
+
 	down(&sonypi_device.lock);
 
 	switch(command) {
@@ -451,6 +507,35 @@
 	return 0;
 }
 
+static int sonypi_misc_ioctl(struct inode *ip, struct file *fp, 
+			     unsigned int cmd, unsigned long arg) {
+	int ret = 0;
+	u8 val;
+
+	down(&sonypi_device.lock);
+	switch (cmd) {
+		case SONYPI_IOCGBRT:
+			val = sonypi_ecrget(0x96) & 0xff;
+			if (copy_to_user((u8 *)arg, &val, sizeof(val))) {
+				ret = -EFAULT;
+				goto out;
+			}
+			break;
+		case SONYPI_IOCSBRT:
+			if (copy_from_user(&val, (u8 *)arg, sizeof(val))) {
+				ret = -EFAULT;
+				goto out;
+			}
+			sonypi_ecrset(0x96, val);
+			break;
+	default:
+		ret = -EINVAL;
+	}
+out:
+	up(&sonypi_device.lock);
+	return ret;
+}
+
 static struct file_operations sonypi_misc_fops = {
 	owner:		THIS_MODULE,
 	read:		sonypi_misc_read,
@@ -458,6 +543,7 @@
 	open:		sonypi_misc_open,
 	release:	sonypi_misc_release,
 	fasync: 	sonypi_misc_fasync,
+	ioctl:		sonypi_misc_ioctl,
 };
 
 struct miscdevice sonypi_misc_device = {
@@ -467,6 +553,8 @@
 static int __devinit sonypi_probe(struct pci_dev *pcidev, 
 		                  const struct pci_device_id *ent) {
 	int i, ret;
+	struct sonypi_ioport_list *ioport_list;
+	struct sonypi_irq_list *irq_list;
 
 	if (sonypi_device.dev) {
 		printk(KERN_ERR "sonypi: only one device allowed!\n"),
@@ -474,6 +562,7 @@
 		goto out1;
 	}
 	sonypi_device.dev = pcidev;
+	sonypi_device.model = (int)ent->driver_data;
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
 	
@@ -490,12 +579,24 @@
 		goto out1;
 	}
 
-	for (i = 0; sonypi_ioport_list[i].port1; i++) {
-		if (request_region(sonypi_ioport_list[i].port1, 8, 
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505) {
+		ioport_list = sonypi_r505_ioport_list;
+		sonypi_device.region_size = SONYPI_R505_REGION_SIZE;
+		irq_list = sonypi_r505_irq_list;
+	}
+	else {
+		ioport_list = sonypi_normal_ioport_list;
+		sonypi_device.region_size = SONYPI_NORMAL_REGION_SIZE;
+		irq_list = sonypi_normal_irq_list;
+	}
+
+	for (i = 0; ioport_list[i].port1; i++) {
+		if (request_region(ioport_list[i].port1, 
+				   sonypi_device.region_size, 
 				   "Sony Programable I/O Device")) {
 			/* get the ioport */
-			sonypi_device.ioport1 = sonypi_ioport_list[i].port1;
-			sonypi_device.ioport2 = sonypi_ioport_list[i].port2;
+			sonypi_device.ioport1 = ioport_list[i].port1;
+			sonypi_device.ioport2 = ioport_list[i].port2;
 			break;
 		}
 	}
@@ -505,11 +606,11 @@
 		goto out2;
 	}
 
-	for (i = 0; sonypi_irq_list[i].irq; i++) {
-		if (!request_irq(sonypi_irq_list[i].irq, sonypi_irq, 
+	for (i = 0; irq_list[i].irq; i++) {
+		if (!request_irq(irq_list[i].irq, sonypi_irq, 
 				 SA_INTERRUPT, "sonypi", sonypi_irq)) {
-			sonypi_device.irq = sonypi_irq_list[i].irq;
-			sonypi_device.bits = sonypi_irq_list[i].bits;
+			sonypi_device.irq = irq_list[i].irq;
+			sonypi_device.bits = irq_list[i].bits;
 			break;
 		}
 	}
@@ -522,7 +623,11 @@
 	if (fnkeyinit)
 		outb(0xf0, 0xb2);
 
-	sonypi_srs();
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505)
+		sonypi_r505_srs();
+	else
+		sonypi_normal_srs();
+
 	sonypi_call1(0x82);
 	sonypi_call2(0x81, 0xff);
 	sonypi_call1(0x92); 
@@ -530,6 +635,10 @@
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
+	printk(KERN_INFO "sonypi: detected %s model, camera = %s\n",
+	       (sonypi_device.model == SONYPI_DEVICE_MODEL_NORMAL) ?
+	       "normal" : "R505",
+	       camera ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -540,7 +649,7 @@
 	return 0;
 
 out3:
-	release_region(sonypi_device.ioport1, 8);
+	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 out2:
 	misc_deregister(&sonypi_misc_device);
 out1:
@@ -548,19 +657,26 @@
 }
 
 static void __devexit sonypi_remove(struct pci_dev *pcidev) {
-	sonypi_set(SONYPI_CAMERA_PICTURE, SONYPI_CAMERA_MUTE_MASK);
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-	sonypi_camera_off();
-	sonypi_dis();
+	if (camera)
+		sonypi_camera_off();
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_R505)
+		sonypi_r505_dis();
+	else
+		sonypi_normal_dis();
 	free_irq(sonypi_device.irq, sonypi_irq);
-	release_region(sonypi_device.ioport1, 8);
+	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
 	printk(KERN_INFO "sonypi: removed.\n");
 }
 
 static struct pci_device_id sonypi_id_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 
-	  PCI_ANY_ID, PCI_ANY_ID, 0,0,0 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+	  (unsigned long) SONYPI_DEVICE_MODEL_NORMAL },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+	  (unsigned long) SONYPI_DEVICE_MODEL_R505 },
 	{ }
 };
 
@@ -594,5 +710,7 @@
 MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
 MODULE_PARM(fnkeyinit,"i");
 MODULE_PARM_DESC(fnkeyinit, "set this if your Fn keys do not generate any event");
+MODULE_PARM(camera,"i");
+MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac15.orig/drivers/char/sonypi.h linux-2.4.5-ac15/drivers/char/sonypi.h
--- linux-2.4.5-ac15.orig/drivers/char/sonypi.h	Fri Jun 15 14:17:21 2001
+++ linux-2.4.5-ac15/drivers/char/sonypi.h	Mon Jun 18 10:21:45 2001
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
  *
+ * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
+ *
  * Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
  *
  * Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
@@ -33,24 +35,36 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	1
+#define SONYPI_DRIVER_MINORVERSION	2
 
 #include <linux/types.h>
 #include <linux/pci.h>
 #include "linux/sonypi.h"
 
-#define SONYPI_IRQ_PORT		0x8034
-#define SONYPI_IRQ_SHIFT	22
-
-#define SONYPI_BASE		0x50
-
-#define SONYPI_G10A		(SONYPI_BASE+0x14)
+/* Normal models use those */
+#define SONYPI_IRQ_PORT			0x8034
+#define SONYPI_IRQ_SHIFT		22
+#define SONYPI_BASE			0x50
+#define SONYPI_G10A			(SONYPI_BASE+0x14)
+#define SONYPI_NORMAL_REGION_SIZE	0x08
+
+/* R505 series specifics */
+#define SONYPI_SIRQ		0x9b
+#define SONYPI_SLOB		0x9c
+#define SONYPI_SHIB		0x9d
+#define SONYPI_R505_REGION_SIZE	0x20
+
+/* ioports used for brightness and R505 events */
+#define SONYPI_DATA_IOPORT	0x62
+#define SONYPI_CST_IOPORT	0x66
 
 /* The set of possible ioports */
-static struct sonypi_ioport_list {
+struct sonypi_ioport_list {
 	u16	port1;
 	u16	port2;
-} sonypi_ioport_list[] = {
+};
+
+static struct sonypi_ioport_list sonypi_normal_ioport_list[] = {
 	{ 0x10c0, 0x10c4 },	/* looks like the default on C1Vx */
 	{ 0x1080, 0x1084 },
 	{ 0x1090, 0x1094 },
@@ -59,15 +73,33 @@
 	{ 0x0, 0x0 }
 };
 
+static struct sonypi_ioport_list sonypi_r505_ioport_list[] = {
+	{ 0x1080, 0x1084 },
+	{ 0x10a0, 0x10a4 },
+	{ 0x10c0, 0x10c4 },
+	{ 0x10e0, 0x10e4 },
+	{ 0x0, 0x0 }
+};
+
 /* The set of possible interrupts */
-static struct sonypi_irq_list {
+struct sonypi_irq_list {
 	u16	irq;
 	u16	bits;
-} sonypi_irq_list[] = {
+};
+
+static struct sonypi_irq_list sonypi_normal_irq_list[] = {
 	{ 11, 0x2 },	/* IRQ 11, GO22=0,GO23=1 in AML */
 	{ 10, 0x1 },	/* IRQ 10, GO22=1,GO23=0 in AML */
-	{ 05, 0x0 },	/* IRQ 05, GO22=0,GO23=0 in AML */
-	{ 00, 0x3 }	/* no IRQ, GO22=1,GO23=1 in AML */
+	{  5, 0x0 },	/* IRQ  5, GO22=0,GO23=0 in AML */
+	{  0, 0x3 }	/* no IRQ, GO22=1,GO23=1 in AML */
+};
+
+static struct sonypi_irq_list sonypi_r505_irq_list[] = {
+	{ 11, 0x80 },	/* IRQ 11, 0x80 in SIRQ in AML */
+	{ 10, 0x40 },	/* IRQ 10, 0x40 in SIRQ in AML */
+	{  9, 0x20 },	/* IRQ  9, 0x20 in SIRQ in AML */
+	{  6, 0x10 },	/* IRQ  6, 0x10 in SIRQ in AML */
+	{  0, 0x00 }	/* no IRQ, 0x00 in SIRQ in AML */
 };
 
 #define SONYPI_CAMERA_BRIGHTNESS		0
@@ -100,9 +132,11 @@
 #define SONYPI_CAMERA_ROMVERSION 		9
 
 /* key press event data (ioport2) */
-#define SONYPI_JOGGER_EV	0x10
+#define SONYPI_NORMAL_JOGGER_EV	0x10
+#define SONYPI_R505_JOGGER_EV	0x08
 #define SONYPI_CAPTURE_EV	0x60
-#define SONYPI_FNKEY_EV		0x20
+#define SONYPI_NORMAL_FNKEY_EV	0x20
+#define SONYPI_R505_FNKEY_EV	0x08
 #define SONYPI_BLUETOOTH_EV	0x30
 
 struct sonypi_event {
@@ -172,16 +206,21 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
+#define SONYPI_DEVICE_MODEL_NORMAL	1
+#define SONYPI_DEVICE_MODEL_R505	2
+
 struct sonypi_device {
 	struct pci_dev *dev;
 	u16 irq;
 	u16 bits;
 	u16 ioport1;
 	u16 ioport2;
+	u16 region_size;
 	int camera_power;
 	struct semaphore lock;
 	struct sonypi_queue queue;
 	int open_count;
+	int model;
 };
 
 #endif /* __KERNEL__ */
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac15.orig/include/linux/sonypi.h linux-2.4.5-ac15/include/linux/sonypi.h
--- linux-2.4.5-ac15.orig/include/linux/sonypi.h	Fri Jun 15 14:17:51 2001
+++ linux-2.4.5-ac15/include/linux/sonypi.h	Fri Jun 15 15:40:46 2001
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
  *
+ * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
+ *
  * Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
  *
  * Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
@@ -30,6 +32,8 @@
 #ifndef _SONYPI_H_ 
 #define _SONYPI_H_
 
+#include <linux/types.h>
+
 /* events the user application reading /dev/sonypi can use */
 
 #define SONYPI_EVENT_JOGDIAL_DOWN		 1
@@ -64,9 +68,11 @@
 #define SONYPI_EVENT_FNKEY_B			30
 #define SONYPI_EVENT_BLUETOOTH_PRESSED		31
 
-#ifdef __KERNEL__
+/* brightness etc. ioctls */
+#define SONYPI_IOCGBRT	_IOR('v', 0, __u8)
+#define SONYPI_IOCSBRT	_IOW('v', 0, __u8)
 
-#include <linux/types.h>
+#ifdef __KERNEL__
 
 /* used only for communication between v4l and sonypi */
 
	  
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
