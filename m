Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbUJ1KLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUJ1KLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUJ1KLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:11:43 -0400
Received: from sd291.sivit.org ([194.146.225.122]:40854 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262879AbUJ1KGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:06:31 -0400
Date: Thu, 28 Oct 2004 12:07:54 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/8] sonypi: power management related fixes
Message-ID: <20041028100754.GD3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2193, 2004-10-27 17:16:12+02:00, stelian@popies.net
  sonypi: power management related fixes
  	* switch from a sysdev to a platform device
  	* drop old style PM code
  	* use pci_get_device()/pci_dev_put() instead of pci_find_device()

  Patch originaly from Dmitry Torokhov <dtor@mail.ru>.

  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 sonypi.c |  216 +++++++++++++++++++++++++++------------------------------------
 sonypi.h |    5 -
 2 files changed, 95 insertions(+), 126 deletions(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:03:43 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:03:43 +02:00
@@ -44,7 +44,7 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/sysdev.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -608,81 +608,91 @@
 	-1, "sonypi", &sonypi_misc_fops
 };
 
-#ifdef CONFIG_PM
-static int old_camera_power;
-
-static int sonypi_suspend(struct sys_device *dev, u32 state) {
-	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-	if (camera) {
-		old_camera_power = sonypi_device.camera_power;
-		sonypi_camera_off();
-	}
+static void sonypi_enable(unsigned int camera_on)
+{
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_dis();
+		sonypi_type2_srs();
 	else
-		sonypi_type1_dis();
-	/* disable ACPI mode */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf1, 0xb2);
-	return 0;
-}
+		sonypi_type1_srs();
+
+	sonypi_call1(0x82);
+	sonypi_call2(0x81, 0xff);
+	sonypi_call1(compat ? 0x92 : 0x82);
 
-static int sonypi_resume(struct sys_device *dev) {
 	/* Enable ACPI mode to get Fn key events */
 	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf0, 0xb2);
+
+	if (camera && camera_on)
+		sonypi_camera_on();
+}
+
+static int sonypi_disable(void)
+{
+	sonypi_call2(0x81, 0);	/* make sure we don't get any more events */
+	if (camera)
+		sonypi_camera_off();
+
+	/* disable ACPI mode */
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
+		outb(0xf1, 0xb2);
+
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_srs();
-	else
-		sonypi_type1_srs();
-	sonypi_call1(0x82);
-	sonypi_call2(0x81, 0xff);
-	if (compat)
-		sonypi_call1(0x92); 
+		sonypi_type2_dis();
 	else
-		sonypi_call1(0x82);
-	if (camera && old_camera_power)
-		sonypi_camera_on();
+		sonypi_type1_dis();
 	return 0;
 }
 
-/* Old PM scheme */
-static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) {
+#ifdef CONFIG_PM
+static int old_camera_power;
 
-	switch (rqst) {
-		case PM_SUSPEND:
-			sonypi_suspend(NULL, 0);
-			break;
-		case PM_RESUME:
-			sonypi_resume(NULL);
-			break;
+static int sonypi_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_DISABLE) {
+		old_camera_power = sonypi_device.camera_power;
+		sonypi_disable();
 	}
 	return 0;
 }
 
-/* New PM scheme (device model) */
-static struct sysdev_class sonypi_sysclass = {
-	set_kset_name("sonypi"),
-	.suspend = sonypi_suspend,
-	.resume = sonypi_resume,
-};
+static int sonypi_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_ENABLE)
+		sonypi_enable(old_camera_power);
+	return 0;
+}
+#endif
 
-static struct sys_device sonypi_sysdev = {
-	.id = 0,
-	.cls = &sonypi_sysclass,
-};
+static void sonypi_shutdown(struct device *dev)
+{
+	sonypi_disable();
+}
+
+static struct device_driver sonypi_driver = {
+	.name		= "sonypi",
+	.bus		= &platform_bus_type,
+#ifdef CONFIG_PM
+	.suspend	= sonypi_suspend,
+	.resume		= sonypi_resume,
 #endif
+	.shutdown	= sonypi_shutdown,
+};
 
-static int __devinit sonypi_probe(struct pci_dev *pcidev) {
+static int __devinit sonypi_probe(void)
+{
 	int i, ret;
 	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
+	struct pci_dev *pcidev;
+
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
 
 	sonypi_device.dev = pcidev;
-	if (pcidev)
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
-	else
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
+	sonypi_device.model = pcidev ?
+		SONYPI_DEVICE_MODEL_TYPE1 : SONYPI_DEVICE_MODEL_TYPE2;
+
 	sonypi_device.fifo_lock = SPIN_LOCK_UNLOCKED;
 	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
 					 &sonypi_device.fifo_lock);
@@ -743,29 +753,9 @@
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
-		/* Now try requesting the irq from the system */
-		if (!request_irq(sonypi_device.irq, sonypi_irq, 
+		if (!request_irq(sonypi_device.irq, sonypi_irq,
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
@@ -774,24 +764,14 @@
 		goto out3;
 	}
 
-#ifdef CONFIG_PM
-	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
-
-	if (sysdev_class_register(&sonypi_sysclass) != 0) {
-		printk(KERN_ERR "sonypi: sysdev_class_register failed\n");
-		ret = -ENODEV;
-		goto out4;
-	}
-	if (sysdev_register(&sonypi_sysdev) != 0) {
-		printk(KERN_ERR "sonypi: sysdev_register failed\n");
-		ret = -ENODEV;
-		goto out5;
+	sonypi_device.pdev = platform_device_register_simple("sonypi", -1,
+							     NULL, 0);
+	if (IS_ERR(sonypi_device.pdev)) {
+		ret = PTR_ERR(sonypi_device.pdev);
+		goto out_platformdev;
 	}
-#endif
 
-	/* Enable ACPI mode to get Fn key events */
-	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
-		outb(0xf0, 0xb2);
+	sonypi_enable(0);
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%s.\n",
 	       SONYPI_DRIVER_VERSION);
@@ -834,12 +814,7 @@
 
 	return 0;
 
-#ifdef CONFIG_PM
-out5:
-	sysdev_class_unregister(&sonypi_sysclass);
-out4:
-	free_irq(sonypi_device.irq, sonypi_irq);
-#endif
+out_platformdev:
 out3:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 out2:
@@ -847,20 +822,16 @@
 out1:
 	kfifo_free(sonypi_device.fifo);
 out_fifo:
+	pci_dev_put(sonypi_device.dev);
 	return ret;
 }
 
-static void __devexit sonypi_remove(void) {
-
-#ifdef CONFIG_PM
-	pm_unregister(sonypi_device.pm);
+static void __devexit sonypi_remove(void)
+{
+	sonypi_disable();
 
-	sysdev_unregister(&sonypi_sysdev);
-	sysdev_class_unregister(&sonypi_sysclass);
-#endif
+	platform_device_unregister(sonypi_device.pdev);
 
-	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
-	
 #ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		input_unregister_device(&sonypi_device.jog_dev);
@@ -868,19 +839,13 @@
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
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
+	if (sonypi_device.dev)
+		pci_disable_device(sonypi_device.dev);
 	kfifo_free(sonypi_device.fifo);
+	pci_dev_put(sonypi_device.dev);
 	printk(KERN_INFO "sonypi: removed.\n");
 }
 
@@ -904,18 +869,25 @@
 
 static int __init sonypi_init(void)
 {
-	struct pci_dev *pcidev = NULL;
-	if (dmi_check_system(sonypi_dmi_table)) {
-		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL, 
-					 PCI_DEVICE_ID_INTEL_82371AB_3, 
-					 NULL);
-		return sonypi_probe(pcidev);
-	}
-	else
+	int ret;
+
+	if (!dmi_check_system(sonypi_dmi_table))
 		return -ENODEV;
+
+	ret = driver_register(&sonypi_driver);
+	if (ret)
+		return ret;
+
+	ret = sonypi_probe();
+	if (ret)
+		driver_unregister(&sonypi_driver);
+
+	return ret;
 }
 
-static void __exit sonypi_exit(void) {
+static void __exit sonypi_exit(void)
+{
+	driver_unregister(&sonypi_driver);
 	sonypi_remove();
 }
 
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:03:43 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:03:43 +02:00
@@ -45,7 +45,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/input.h>
-#include <linux/pm.h>
 #include <linux/acpi.h>
 #include <linux/kfifo.h>
 #include <linux/sonypi.h>
@@ -355,6 +354,7 @@
 
 struct sonypi_device {
 	struct pci_dev *dev;
+	struct platform_device *pdev;
 	u16 irq;
 	u16 bits;
 	u16 ioport1;
@@ -372,9 +372,6 @@
 	int model;
 #ifdef SONYPI_USE_INPUT
 	struct input_dev jog_dev;
-#endif
-#ifdef CONFIG_PM
-	struct pm_dev *pm;
 #endif
 };
 
