Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268410AbTBNNmY>; Fri, 14 Feb 2003 08:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268412AbTBNNmY>; Fri, 14 Feb 2003 08:42:24 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:37554 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S268410AbTBNNmR>; Fri, 14 Feb 2003 08:42:17 -0500
Date: Fri, 14 Feb 2003 14:52:00 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.60-bk] sonypi and input subsystem
Message-ID: <20030214145200.A32437@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch makes the sonypi driver forward the VAIO jogdial
events directly to the input subsystem as mouse wheel events. This
way one is not required anymore to have an external daemon polling
/dev/sonypi if interested only in jogdial events.

This new behaviour is controlled by a module option ("useinput"), which
is active by default.

Linus, please apply.

Thanks,

Stelian.

===== Documentation/sonypi.txt 1.10 vs edited =====
--- 1.10/Documentation/sonypi.txt	Mon Dec  2 12:18:17 2002
+++ edited/Documentation/sonypi.txt	Tue Jan 28 12:03:41 2003
@@ -44,7 +44,7 @@
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,mask]]]]]
+	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,mask[,useinput]]]]]]
 
 where:
 
@@ -96,6 +96,11 @@
 				SONYPI_THUMBPHRASE_MASK 	0x0200
 				SONYPI_MEYE_MASK		0x0400
 				SONYPI_MEMORYSTICK_MASK		0x0800
+
+	useinput:	if set (which is the default) jogdial events are
+			forwarded to the input subsystem as mouse wheel
+			events.
+			
 
 Module use:
 -----------
===== drivers/char/sonypi.h 1.14 vs edited =====
--- 1.14/drivers/char/sonypi.h	Wed Dec 11 16:33:00 2002
+++ edited/drivers/char/sonypi.h	Tue Jan 28 14:10:47 2003
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	17
+#define SONYPI_DRIVER_MINORVERSION	18
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -45,6 +45,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/input.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
 #include "linux/sonypi.h"
@@ -334,6 +335,9 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
+/* The name of the Jog Dial for the input device drivers */
+#define SONYPI_INPUTNAME	"Sony VAIO Jog Dial"
+
 struct sonypi_device {
 	struct pci_dev *dev;
 	u16 irq;
@@ -347,7 +351,10 @@
 	struct sonypi_queue queue;
 	int open_count;
 	int model;
-#if CONFIG_PM
+#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+	struct input_dev jog_dev;
+#endif
+#ifdef CONFIG_PM
 	struct pm_dev *pm;
 #endif
 };
@@ -363,7 +370,7 @@
 		printk(KERN_WARNING "sonypi command failed at %s : %s (line %d)\n", __FILE__, __FUNCTION__, __LINE__); \
 }
 
-#if !defined(CONFIG_ACPI)
+#ifndef CONFIG_ACPI
 extern int verbose;
 
 static inline int ec_write(u8 addr, u8 value) {
===== drivers/char/sonypi.c 1.13 vs edited =====
--- 1.13/drivers/char/sonypi.c	Wed Dec 11 13:34:17 2002
+++ edited/drivers/char/sonypi.c	Thu Feb  6 15:25:35 2003
@@ -33,6 +33,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/input.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/init.h>
@@ -56,6 +57,7 @@
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
 static int compat; /* = 0 */
+static int useinput = 1;
 static unsigned long mask = 0xffffffff;
 
 /* Inits the queue */
@@ -335,6 +337,22 @@
 	return;
 
 found:
+#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+	if (useinput) {
+		struct input_dev *jog_dev = &sonypi_device.jog_dev;
+		if (event == SONYPI_EVENT_JOGDIAL_PRESSED)
+			input_report_key(jog_dev, BTN_MIDDLE, 1);
+		else if (event == SONYPI_EVENT_ANYBUTTON_RELEASED)
+			input_report_key(jog_dev, BTN_MIDDLE, 0);
+		else if ((event == SONYPI_EVENT_JOGDIAL_UP) ||
+			 (event == SONYPI_EVENT_JOGDIAL_UP_PRESSED))
+			input_report_rel(jog_dev, REL_WHEEL, 1);
+		else if ((event == SONYPI_EVENT_JOGDIAL_DOWN) ||
+			 (event == SONYPI_EVENT_JOGDIAL_DOWN_PRESSED))
+			input_report_rel(jog_dev, REL_WHEEL, -1);
+		input_sync(jog_dev);
+	}
+#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
 	sonypi_pushq(event);
 }
 
@@ -579,7 +597,7 @@
 	-1, "sonypi", &sonypi_misc_fops
 };
 
-#if CONFIG_PM
+#ifdef CONFIG_PM
 static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) {
 	static int old_camera_power;
 
@@ -594,14 +612,14 @@
 			sonypi_type2_dis();
 		else
 			sonypi_type1_dis();
-#if !defined(CONFIG_ACPI)
+#ifndef CONFIG_ACPI
 		/* disable ACPI mode */
 		if (fnkeyinit)
 			outb(0xf1, 0xb2);
 #endif
 		break;
 	case PM_RESUME:
-#if !defined(CONFIG_ACPI)
+#ifndef CONFIG_ACPI
 		/* Enable ACPI mode to get Fn key events */
 		if (fnkeyinit)
 			outb(0xf0, 0xb2);
@@ -692,7 +710,7 @@
 		goto out3;
 	}
 
-#if !defined(CONFIG_ACPI)
+#ifndef CONFIG_ACPI
 	/* Enable ACPI mode to get Fn key events */
 	if (fnkeyinit)
 		outb(0xf0, 0xb2);
@@ -715,14 +733,15 @@
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
-	       "compat = %s, mask = 0x%08lx\n",
+	       "compat = %s, mask = 0x%08lx, useinput = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
 	       verbose,
 	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
-	       mask);
+	       mask,
+	       useinput ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -730,7 +749,24 @@
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
 
-#if CONFIG_PM
+#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+	if (useinput) {
+		/* Initialize the Input Drivers: */
+		sonypi_device.jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		sonypi_device.jog_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_MIDDLE);
+		sonypi_device.jog_dev.relbit[0] = BIT(REL_WHEEL);
+		sonypi_device.jog_dev.name = (char *) kmalloc(
+			sizeof(SONYPI_INPUTNAME), GFP_KERNEL);
+		sprintf(sonypi_device.jog_dev.name, SONYPI_INPUTNAME);
+		sonypi_device.jog_dev.id.bustype = BUS_ISA;
+		sonypi_device.jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
+	  
+		input_register_device(&sonypi_device.jog_dev);
+		printk(KERN_INFO "%s installed.\n", sonypi_device.jog_dev.name);
+	}
+#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
+
+#ifdef CONFIG_PM
 	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
 #endif
 
@@ -746,18 +782,26 @@
 
 static void __devexit sonypi_remove(void) {
 
-#if CONFIG_PM
+#ifdef CONFIG_PM
 	pm_unregister(sonypi_device.pm);
 #endif
 
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
+	
+#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+	if (useinput) {
+		input_unregister_device(&sonypi_device.jog_dev);
+		kfree(sonypi_device.jog_dev.name);
+	}
+#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
+
 	if (camera)
 		sonypi_camera_off();
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
 		sonypi_type2_dis();
 	else
 		sonypi_type1_dis();
-#if !defined(CONFIG_ACPI)
+#ifndef CONFIG_ACPI
 	/* disable ACPI mode */
 	if (fnkeyinit)
 		outb(0xf1, 0xb2);
@@ -787,7 +831,7 @@
 
 #ifndef MODULE
 static int __init sonypi_setup(char *str)  {
-	int ints[7];
+	int ints[8];
 
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 	if (ints[0] <= 0) 
@@ -808,6 +852,9 @@
 	if (ints[0] == 5)
 		goto out;
 	mask = ints[6];
+	if (ints[0] == 6)
+		goto out;
+	useinput = ints[7];
 out:
 	return 1;
 }
@@ -836,5 +883,7 @@
 MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
 MODULE_PARM(mask, "i");
 MODULE_PARM_DESC(mask, "set this to the mask of event you want to enable (see doc)");
+MODULE_PARM(useinput, "i");
+MODULE_PARM_DESC(useinput, "if you have a jogdial, set this if you would like it to use the modern Linux Input Driver system");
 
 EXPORT_SYMBOL(sonypi_camera_command);

-- 
Stelian Pop <stelian@popies.net>
