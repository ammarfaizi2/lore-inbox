Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270327AbUJUHIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbUJUHIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270290AbUJUHEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:04:46 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:13960 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270033AbUJUG7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Sonypi: switch from sysdev to platform device, drop old-style PM code
Date: Thu, 21 Oct 2004 01:58:10 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
References: <200410210154.58301.dtor_core@ameritech.net> <200410210156.27067.dtor_core@ameritech.net> <200410210157.22833.dtor_core@ameritech.net>
In-Reply-To: <200410210157.22833.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210158.12014.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1978, 2004-10-21 01:45:45-05:00, dtor_core@ameritech.net
  Sonypi: power management changes
          - convert from system device to platform device, it surely
            can suspend with interrupts enabled;
          - drop old style PM implementation as APM calls device_suspend
            anyway.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sonypi.c |  198 +++++++++++++++++++++++++--------------------------------------
 sonypi.h |    5 -
 2 files changed, 82 insertions(+), 121 deletions(-)


===================================================================



diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-21 01:54:27 -05:00
+++ b/drivers/char/sonypi.c	2004-10-21 01:54:27 -05:00
@@ -44,7 +44,7 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/sysdev.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -688,72 +688,78 @@
 	-1, "sonypi", &sonypi_misc_fops
 };
 
-#ifdef CONFIG_PM
-static int old_camera_power;
+static void sonypi_enable(unsigned int camera_on)
+{
+	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+		sonypi_type2_srs();
+	else
+		sonypi_type1_srs();
+
+	sonypi_call1(0x82);
+	sonypi_call2(0x81, 0xff);
+	sonypi_call1(compat ? 0x92 : 0x82);
+
+	/* Enable ACPI mode to get Fn key events */
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
+		outb(0xf0, 0xb2);
+
+	if (camera && camera_on)
+		sonypi_camera_on();
+}
 
-static int sonypi_suspend(struct sys_device *dev, u32 state)
+static void sonypi_disable(void)
 {
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-	if (camera) {
-		old_camera_power = sonypi_device.camera_power;
+
+	if (camera)
 		sonypi_camera_off();
-	}
+
+	/* disable ACPI mode */
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
+		outb(0xf1, 0xb2);
+
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
 		sonypi_type2_dis();
 	else
 		sonypi_type1_dis();
-	/* disable ACPI mode */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf1, 0xb2);
-	return 0;
 }
 
-static int sonypi_resume(struct sys_device *dev)
+#ifdef CONFIG_PM
+static int old_camera_power;
+
+static int sonypi_suspend(struct device *dev, u32 state, u32 level)
 {
-	/* Enable ACPI mode to get Fn key events */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf0, 0xb2);
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_srs();
-	else
-		sonypi_type1_srs();
-	sonypi_call1(0x82);
-	sonypi_call2(0x81, 0xff);
-	if (compat)
-		sonypi_call1(0x92);
-	else
-		sonypi_call1(0x82);
-	if (camera && old_camera_power)
-		sonypi_camera_on();
+	if (level == SUSPEND_DISABLE) {
+		old_camera_power = sonypi_device.camera_power;
+		sonypi_disable();
+	}
+
 	return 0;
 }
 
-/* Old PM scheme */
-static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+static int sonypi_resume(struct device *dev, u32 level)
 {
-	switch (rqst) {
-		case PM_SUSPEND:
-			sonypi_suspend(NULL, 0);
-			break;
-		case PM_RESUME:
-			sonypi_resume(NULL);
-			break;
-	}
+	if (level == RESUME_ENABLE)
+		sonypi_enable(old_camera_power);
+
 	return 0;
 }
+#endif
 
-/* New PM scheme (device model) */
-static struct sysdev_class sonypi_sysclass = {
-	set_kset_name("sonypi"),
-	.suspend = sonypi_suspend,
-	.resume = sonypi_resume,
-};
+static void sonypi_shutdown(struct device *dev)
+{
+	sonypi_disable();
+}
 
-static struct sys_device sonypi_sysdev = {
-	.id = 0,
-	.cls = &sonypi_sysclass,
-};
+static struct device_driver sonypi_driver = {
+	.name		= "sonypi",
+	.bus		= &platform_bus_type,
+#ifdef CONFIG_PM
+	.suspend	= sonypi_suspend,
+	.resume		= sonypi_resume,
 #endif
+	.shutdown	= sonypi_shutdown,
+};
 
 static int __devinit sonypi_probe(struct pci_dev *pcidev)
 {
@@ -762,10 +768,8 @@
 	struct sonypi_irq_list *irq_list;
 
 	sonypi_device.dev = pcidev;
-	if (pcidev)
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
-	else
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
+	sonypi_device.model = pcidev ?
+		SONYPI_DEVICE_MODEL_TYPE1 : SONYPI_DEVICE_MODEL_TYPE2;
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = 0;
@@ -788,8 +792,7 @@
 		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
 		sonypi_device.evtype_offset = SONYPI_TYPE2_EVTYPE_OFFSET;
 		irq_list = sonypi_type2_irq_list;
-	}
-	else {
+	} else {
 		ioport_list = sonypi_type1_ioport_list;
 		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
 		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
@@ -806,6 +809,7 @@
 			break;
 		}
 	}
+
 	if (!sonypi_device.ioport1) {
 		printk(KERN_ERR "sonypi: request_region failed\n");
 		ret = -ENODEV;
@@ -817,29 +821,10 @@
 		sonypi_device.irq = irq_list[i].irq;
 		sonypi_device.bits = irq_list[i].bits;
 
-		/* Enable sonypi IRQ settings */
-		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-			sonypi_type2_srs();
-		else
-			sonypi_type1_srs();
-
-		sonypi_call1(0x82);
-		sonypi_call2(0x81, 0xff);
-		if (compat)
-			sonypi_call1(0x92);
-		else
-			sonypi_call1(0x82);
-
 		/* Now try requesting the irq from the system */
 		if (!request_irq(sonypi_device.irq, sonypi_irq,
 				 SA_SHIRQ, "sonypi", sonypi_irq))
 			break;
-
-		/* If request_irq failed, disable sonypi IRQ settings */
-		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-			sonypi_type2_dis();
-		else
-			sonypi_type1_dis();
 	}
 
 	if (!irq_list[i].irq) {
@@ -848,24 +833,13 @@
 		goto out3;
 	}
 
-#ifdef CONFIG_PM
-	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
-
-	if (sysdev_class_register(&sonypi_sysclass) != 0) {
-		printk(KERN_ERR "sonypi: sysdev_class_register failed\n");
-		ret = -ENODEV;
+	sonypi_device.pdev = platform_device_register_simple("sonypi", -1, NULL, 0);
+	if (IS_ERR(sonypi_device.pdev)) {
+		ret = PTR_ERR(sonypi_device.pdev);
 		goto out4;
 	}
-	if (sysdev_register(&sonypi_sysdev) != 0) {
-		printk(KERN_ERR "sonypi: sysdev_register failed\n");
-		ret = -ENODEV;
-		goto out5;
-	}
-#endif
 
-	/* Enable ACPI mode to get Fn key events */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf0, 0xb2);
+	sonypi_enable(0);
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
 	       SONYPI_DRIVER_MAJORVERSION,
@@ -909,12 +883,8 @@
 
 	return 0;
 
-#ifdef CONFIG_PM
-out5:
-	sysdev_class_unregister(&sonypi_sysclass);
 out4:
 	free_irq(sonypi_device.irq, sonypi_irq);
-#endif
 out3:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 out2:
@@ -925,15 +895,6 @@
 
 static void __devexit sonypi_remove(void)
 {
-#ifdef CONFIG_PM
-	pm_unregister(sonypi_device.pm);
-
-	sysdev_unregister(&sonypi_sysdev);
-	sysdev_class_unregister(&sonypi_sysclass);
-#endif
-
-	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-
 #ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		input_unregister_device(&sonypi_device.jog_dev);
@@ -941,15 +902,7 @@
 	}
 #endif /* SONYPI_USE_INPUT */
 
-	if (camera)
-		sonypi_camera_off();
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_dis();
-	else
-		sonypi_type1_dis();
-	/* disable ACPI mode */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf1, 0xb2);
+	platform_device_unregister(sonypi_device.pdev);
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
@@ -976,20 +929,31 @@
 
 static int __init sonypi_init_module(void)
 {
-	struct pci_dev *pcidev = NULL;
-	if (dmi_check_system(sonypi_dmi_table)) {
-		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					 PCI_DEVICE_ID_INTEL_82371AB_3,
-					 NULL);
-		return sonypi_probe(pcidev);
-	}
-	else
+	struct pci_dev *pcidev;
+	int ret;
+
+	if (!dmi_check_system(sonypi_dmi_table))
 		return -ENODEV;
+
+	ret = driver_register(&sonypi_driver);
+	if (ret)
+		return ret;
+
+	pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
+				 PCI_DEVICE_ID_INTEL_82371AB_3,
+				 NULL);
+	ret = sonypi_probe(pcidev);
+	if (ret)
+		driver_unregister(&sonypi_driver);
+
+	return ret;
 }
 
 static void __exit sonypi_cleanup_module(void)
 {
+	sonypi_disable();
 	sonypi_remove();
+	driver_unregister(&sonypi_driver);
 }
 
 /* Module entry points */
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-21 01:54:27 -05:00
+++ b/drivers/char/sonypi.h	2004-10-21 01:54:27 -05:00
@@ -46,7 +46,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/input.h>
-#include <linux/pm.h>
 #include <linux/acpi.h>
 #include "linux/sonypi.h"
 
@@ -364,6 +363,7 @@
 
 struct sonypi_device {
 	struct pci_dev *dev;
+	struct platform_device *pdev;
 	u16 irq;
 	u16 bits;
 	u16 ioport1;
@@ -378,9 +378,6 @@
 	int model;
 #ifdef SONYPI_USE_INPUT
 	struct input_dev jog_dev;
-#endif
-#ifdef CONFIG_PM
-	struct pm_dev *pm;
 #endif
 };
 
