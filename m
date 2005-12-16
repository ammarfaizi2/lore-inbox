Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVLPGfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVLPGfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVLPGfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:35:22 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:40068 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932140AbVLPGfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:35:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFT] dcdbas: convert to the new platform device interface
Date: Fri, 16 Dec 2005 01:35:16 -0500
User-Agent: KMail/1.8.3
Cc: Douglas_Warzecha@dell.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160135.17185.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dcdbas: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
define dcdbas_driver and implement ->probe() and ->remove() functions
so manual binding and unbinding will work with this driver.

Also switch to using attribute_group when creating sysfs attributes
and make sure to check and handle errors; explicitely remove attributes
when detaching driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/firmware/dcdbas.c |  110 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 87 insertions(+), 23 deletions(-)

Index: work/drivers/firmware/dcdbas.c
===================================================================
--- work.orig/drivers/firmware/dcdbas.c
+++ work/drivers/firmware/dcdbas.c
@@ -530,30 +530,27 @@ static DCDBAS_DEV_ATTR_RW(host_control_a
 static DCDBAS_DEV_ATTR_RW(host_control_smi_type);
 static DCDBAS_DEV_ATTR_RW(host_control_on_shutdown);
 
-static struct device_attribute *dcdbas_dev_attrs[] = {
-	&dev_attr_smi_data_buf_size,
-	&dev_attr_smi_data_buf_phys_addr,
-	&dev_attr_smi_request,
-	&dev_attr_host_control_action,
-	&dev_attr_host_control_smi_type,
-	&dev_attr_host_control_on_shutdown,
+static struct attribute *dcdbas_dev_attrs[] = {
+	&dev_attr_smi_data_buf_size.attr,
+	&dev_attr_smi_data_buf_phys_addr.attr,
+	&dev_attr_smi_request.attr,
+	&dev_attr_host_control_action.attr,
+	&dev_attr_host_control_smi_type.attr,
+	&dev_attr_host_control_on_shutdown.attr,
 	NULL
 };
 
-/**
- * dcdbas_init: initialize driver
- */
-static int __init dcdbas_init(void)
+static struct attribute_group dcdbas_attr_group = {
+	.attrs = dcdbas_dev_attrs,
+};
+
+static int __devinit dcdbas_probe(struct platform_device *dev)
 {
-	int i;
+	int i, error;
 
 	host_control_action = HC_ACTION_NONE;
 	host_control_smi_type = HC_SMITYPE_NONE;
 
-	dcdbas_pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
-	if (IS_ERR(dcdbas_pdev))
-		return PTR_ERR(dcdbas_pdev);
-
 	/*
 	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
 	 * This is done by setting the DMA mask below.
@@ -561,19 +558,79 @@ static int __init dcdbas_init(void)
 	dcdbas_pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
 	dcdbas_pdev->dev.dma_mask = &dcdbas_pdev->dev.coherent_dma_mask;
 
+	error = sysfs_create_group(&dev->dev.kobj, &dcdbas_attr_group);
+	if (error)
+		return error;
+
+	for (i = 0; dcdbas_bin_attrs[i]; i++) {
+		error = sysfs_create_bin_file(&dev->dev.kobj,
+					      dcdbas_bin_attrs[i]);
+		if (error) {
+			while (--i >= 0)
+				sysfs_remove_bin_file(&dev->dev.kobj,
+						      dcdbas_bin_attrs[i]);
+			sysfs_create_group(&dev->dev.kobj, &dcdbas_attr_group);
+			return error;
+		}
+	}
+
 	register_reboot_notifier(&dcdbas_reboot_nb);
 
+	dev_info(&dev->dev, "%s (version %s)\n",
+		 DRIVER_DESCRIPTION, DRIVER_VERSION);
+
+	return 0;
+}
+
+static int __devexit dcdbas_remove(struct platform_device *dev)
+{
+	int i;
+
+	unregister_reboot_notifier(&dcdbas_reboot_nb);
 	for (i = 0; dcdbas_bin_attrs[i]; i++)
-		sysfs_create_bin_file(&dcdbas_pdev->dev.kobj,
-				      dcdbas_bin_attrs[i]);
+		sysfs_remove_bin_file(&dev->dev.kobj, dcdbas_bin_attrs[i]);
+	sysfs_remove_group(&dev->dev.kobj, &dcdbas_attr_group);
 
-	for (i = 0; dcdbas_dev_attrs[i]; i++)
-		device_create_file(&dcdbas_pdev->dev, dcdbas_dev_attrs[i]);
+	return 0;
+}
 
-	dev_info(&dcdbas_pdev->dev, "%s (version %s)\n",
-		 DRIVER_DESCRIPTION, DRIVER_VERSION);
+static struct platform_driver dcdbas_driver = {
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= dcdbas_probe,
+	.remove		= __devexit_p(dcdbas_remove),
+};
+
+/**
+ * dcdbas_init: initialize driver
+ */
+static int __init dcdbas_init(void)
+{
+	int error;
+
+	error = platform_driver_register(&dcdbas_driver);
+	if (error)
+		return error;
+
+	dcdbas_pdev = platform_device_alloc(DRIVER_NAME, -1);
+	if (!dcdbas_pdev) {
+		error = -ENOMEM;
+		goto err_unregister_driver;
+	}
+
+	error = platform_device_add(dcdbas_pdev);
+	if (error)
+		goto err_free_device;
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(dcdbas_pdev);
+ err_unregister_driver:
+	platform_driver_unregister(&dcdbas_driver);
+	return error;
 }
 
 /**
@@ -582,7 +639,14 @@ static int __init dcdbas_init(void)
 static void __exit dcdbas_exit(void)
 {
 	platform_device_unregister(dcdbas_pdev);
-	unregister_reboot_notifier(&dcdbas_reboot_nb);
+	platform_driver_unregister(&dcdbas_driver);
+
+	/*
+	 * We have to free the buffer here instead of dcdbas_remove
+	 * because only in module exit function we can be sure that
+	 * all sysfs attributes belonging to this module have been
+	 * released.
+	 */
 	smi_data_buf_free();
 }
 
