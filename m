Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUGBOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUGBOIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGBOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:08:17 -0400
Received: from sd291.sivit.org ([194.146.225.122]:41132 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264562AbUGBOHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:07:55 -0400
Date: Fri, 2 Jul 2004 16:07:42 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] sonypi driver update (PM and DMI VGN-)
Message-ID: <20040702140741.GC2942@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the sonypi driver by:
	* fixing the power management handling, using the new device 
	  model PM scheme.

	* adds "VGN-" as a DMI search pattern for a Sony Vaio laptop.

Florian Lohoff reported the power management issue and tested the
patch.

Many users reported the DMI name issue, including Till Busch who
made a patch for dmi_scan.c.

Linus, Andrew, please apply.

Thanks,

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

===== drivers/char/sonypi.h 1.22 vs edited =====
--- 1.22/drivers/char/sonypi.h	2004-03-21 06:28:40 +01:00
+++ edited/drivers/char/sonypi.h	2004-07-01 14:39:18 +02:00
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	22
+#define SONYPI_DRIVER_MINORVERSION	23
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
===== drivers/char/sonypi.c 1.21 vs edited =====
--- 1.21/drivers/char/sonypi.c	2004-06-27 09:19:29 +02:00
+++ edited/drivers/char/sonypi.c	2004-07-02 11:01:27 +02:00
@@ -44,6 +44,7 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/sysdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -603,44 +604,68 @@
 };
 
 #ifdef CONFIG_PM
+static int old_camera_power;
+
+static int sonypi_suspend(struct sys_device *dev, u32 state) {
+	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
+	if (camera) {
+		old_camera_power = sonypi_device.camera_power;
+		sonypi_camera_off();
+	}
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+		sonypi_type2_dis();
+	else
+		sonypi_type1_dis();
+	/* disable ACPI mode */
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
+		outb(0xf1, 0xb2);
+	return 0;
+}
+
+static int sonypi_resume(struct sys_device *dev) {
+	/* Enable ACPI mode to get Fn key events */
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
+		outb(0xf0, 0xb2);
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+		sonypi_type2_srs();
+	else
+		sonypi_type1_srs();
+	sonypi_call1(0x82);
+	sonypi_call2(0x81, 0xff);
+	if (compat)
+		sonypi_call1(0x92); 
+	else
+		sonypi_call1(0x82);
+	if (camera && old_camera_power)
+		sonypi_camera_on();
+	return 0;
+}
+
+/* Old PM scheme */
 static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) {
-	static int old_camera_power;
 
 	switch (rqst) {
-	case PM_SUSPEND:
-		sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-		if (camera) {
-			old_camera_power = sonypi_device.camera_power;
-			sonypi_camera_off();
-		}
-		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-			sonypi_type2_dis();
-		else
-			sonypi_type1_dis();
-		/* disable ACPI mode */
-		if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-			outb(0xf1, 0xb2);
-		break;
-	case PM_RESUME:
-		/* Enable ACPI mode to get Fn key events */
-		if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-			outb(0xf0, 0xb2);
-		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-			sonypi_type2_srs();
-		else
-			sonypi_type1_srs();
-		sonypi_call1(0x82);
-		sonypi_call2(0x81, 0xff);
-		if (compat)
-			sonypi_call1(0x92); 
-		else
-			sonypi_call1(0x82);
-		if (camera && old_camera_power)
-			sonypi_camera_on();
-		break;
+		case PM_SUSPEND:
+			sonypi_suspend(NULL, 0);
+			break;
+		case PM_RESUME:
+			sonypi_resume(NULL);
+			break;
 	}
 	return 0;
 }
+
+/* New PM scheme (device model) */
+static struct sysdev_class sonypi_sysclass = {
+	set_kset_name("sonypi"),
+	.suspend = sonypi_suspend,
+	.resume = sonypi_resume,
+};
+
+static struct sys_device sonypi_sysdev = {
+	.id = 0,
+	.cls = &sonypi_sysclass,
+};
 #endif
 
 static int __devinit sonypi_probe(struct pci_dev *pcidev) {
@@ -735,6 +760,21 @@
 		goto out3;
 	}
 
+#ifdef CONFIG_PM
+	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
+
+	if (sysdev_class_register(&sonypi_sysclass) != 0) {
+		printk(KERN_ERR "sonypi: sysdev_class_register failed\n");
+		ret = -ENODEV;
+		goto out4;
+	}
+	if (sysdev_register(&sonypi_sysdev) != 0) {
+		printk(KERN_ERR "sonypi: sysdev_register failed\n");
+		ret = -ENODEV;
+		goto out5;
+	}
+#endif
+
 	/* Enable ACPI mode to get Fn key events */
 	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf0, 0xb2);
@@ -744,7 +784,7 @@
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
-	       "compat = %s, mask = 0x%08lx, useinput = %s\n",
+	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
 	       verbose,
@@ -752,10 +792,12 @@
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
 	       mask,
-	       useinput ? "on" : "off");
+	       useinput ? "on" : "off",
+	       SONYPI_ACPI_ACTIVE ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
+
 	if (minor == -1)
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
@@ -777,12 +819,14 @@
 	}
 #endif /* SONYPI_USE_INPUT */
 
-#ifdef CONFIG_PM
-	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
-#endif
-
 	return 0;
 
+#ifdef CONFIG_PM
+out5:
+	sysdev_class_unregister(&sonypi_sysclass);
+out4:
+	free_irq(sonypi_device.irq, sonypi_irq);
+#endif
 out3:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 out2:
@@ -795,6 +839,9 @@
 
 #ifdef CONFIG_PM
 	pm_unregister(sonypi_device.pm);
+
+	sysdev_unregister(&sonypi_sysdev);
+	sysdev_class_unregister(&sonypi_sysclass);
 #endif
 
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
@@ -827,6 +874,13 @@
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
+		},
+	},
+	{
+		.ident = "Sony Vaio",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-"),
 		},
 	},
 	{ }
-- 
Stelian Pop <stelian@popies.net>    
