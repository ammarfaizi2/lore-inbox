Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVLPGzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVLPGzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLPGzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:55:52 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:5546 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932145AbVLPGzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:55:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFT] tlclk: convert to the new platform device interface
Date: Fri, 16 Dec 2005 01:55:48 -0500
User-Agent: KMail/1.8.3
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       torvalds@osdl.org, mark.gross@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160155.49219.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tlclk: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
define dcdbas_driver and implement ->probe() and ->remove() functions
so manual binding and unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/tlclk.c |  143 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 89 insertions(+), 54 deletions(-)

Index: work/drivers/char/tlclk.c
===================================================================
--- work.orig/drivers/char/tlclk.c
+++ work/drivers/char/tlclk.c
@@ -202,6 +202,10 @@ static int tlclk_open(struct inode *inod
 {
 	int result;
 
+	alarm_events = kzalloc(sizeof(struct tlclk_alarms), GFP_KERNEL);
+	if (!alarm_events)
+		return -ENOMEM;
+
 	/* Make sure there is no interrupt pending while
 	 * initialising interrupt handler */
 	inb(TLCLK_REG6);
@@ -212,6 +216,8 @@ static int tlclk_open(struct inode *inod
 			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
 	if (result == -EBUSY) {
 		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+		kfree(alarm_events);
+		alarm_events = NULL;
 		return -EBUSY;
 	}
 	inb(TLCLK_REG6);	/* Clear interrupt events */
@@ -222,6 +228,9 @@ static int tlclk_open(struct inode *inod
 static int tlclk_release(struct inode *inode, struct file *filp)
 {
 	free_irq(telclk_interrupt, tlclk_interrupt);
+	del_timer_sync(&switchover_timer);
+	kfree(alarm_events);
+	alarm_events = NULL;
 
 	return 0;
 }
@@ -733,89 +742,115 @@ static struct attribute_group tlclk_attr
 	.attrs = tlclk_sysfs_entries,
 };
 
-static struct platform_device *tlclk_device;
-
-static int __init tlclk_init(void)
+static int __devinit tlclk_probe(struct platform_device *dev)
 {
-	int ret;
+	int error;
 
-	ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
-	if (ret < 0) {
+	init_timer(&switchover_timer);
+
+	error = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
+	if (error < 0) {
 		printk(KERN_ERR "telco_clock: can't get major! %d\n", tlclk_major);
-		return ret;
+		return error;
 	}
-	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
-	if (!alarm_events)
-		goto out1;
+
+	error = misc_register(&tlclk_miscdev);
+	if (error < 0) {
+		printk(KERN_ERR "tlclk: misc_register retruns %d\n", error);
+		goto err_unregister_chrdev;
+	}
+
+	error = sysfs_create_group(&dev->dev.kobj, &tlclk_attribute_group);
+	if (error) {
+		printk(KERN_ERR
+			"tlclk: failed to create sysfs device attributes\n");
+		goto err_misc_deregister;
+	}
+
+	return 0;
+
+ err_misc_deregister:
+	misc_deregister(&tlclk_miscdev);
+ err_unregister_chrdev:
+	unregister_chrdev(tlclk_major, "telco_clock");
+	return error;
+}
+
+static int __devexit tlclk_remove(struct platform_device *dev)
+{
+	sysfs_remove_group(&dev->dev.kobj, &tlclk_attribute_group);
+	misc_deregister(&tlclk_miscdev);
+	unregister_chrdev(tlclk_major, "telco_clock");
+
+	return 0;
+}
+
+static struct platform_driver tlclk_driver = {
+	.driver		= {
+		.name	= "telco_clock",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tlclk_probe,
+	.remove		= __devexit_p(tlclk_remove),
+};
+
+static struct platform_device *tlclk_device;
+
+static int __init tlclk_init(void)
+{
+	int error;
 
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
 		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
 			TLCLK_BASE);
-		ret = -EBUSY;
-		goto out2;
+		return -EBUSY;
 	}
-	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
-	if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
-		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw\n",
+	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
+	if (0x0F == telclk_interrupt) { /* not MCPBL0010 ? */
+		printk(KERN_ERR
+			"tlclk: telclk_interrupt = 0x%x non-mcpbl0010 hw\n",
 			telclk_interrupt);
-		ret = -ENXIO;
-		goto out3;
+		error = -ENODEV;
+		goto err_release_region;
 	}
 
-	init_timer(&switchover_timer);
-
-	ret = misc_register(&tlclk_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR " misc_register retruns %d\n", ret);
-		ret = -EBUSY;
-		goto out3;
+	error = platform_driver_register(&tlclk_driver);
+	if (error) {
+		printk(KERN_ERR "tlclk: failed to register platform driver\n");
+		goto err_free_device;
 	}
 
-	tlclk_device = platform_device_register_simple("telco_clock",
-				-1, NULL, 0);
+	tlclk_device = platform_device_alloc("telco_clock", -1);
 	if (!tlclk_device) {
-		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
-			(unsigned int) tlclk_device);
-		ret = -EBUSY;
-		goto out4;
+		printk(KERN_ERR "tlclk: failed to allocate platform device\n");
+		error = -ENOMEM;
+		goto err_unregister_driver;
 	}
 
-	ret = sysfs_create_group(&tlclk_device->dev.kobj,
-			&tlclk_attribute_group);
-	if (ret) {
-		printk(KERN_ERR "failed to create sysfs device attributes\n");
-		sysfs_remove_group(&tlclk_device->dev.kobj,
-			&tlclk_attribute_group);
-		goto out5;
+	error = platform_device_add(tlclk_device);
+	if (error) {
+		printk(KERN_ERR "tlclk: failed to register platform device\n");
+		goto err_free_device;
 	}
 
 	return 0;
-out5:
-	platform_device_unregister(tlclk_device);
-out4:
-	misc_deregister(&tlclk_miscdev);
-out3:
+
+ err_free_device:
+	platform_device_put(tlclk_device);
+ err_unregister_driver:
+	platform_driver_unregister(&tlclk_driver);
+ err_release_region:
 	release_region(TLCLK_BASE, 8);
-out2:
-	kfree(alarm_events);
-out1:
-	unregister_chrdev(tlclk_major, "telco_clock");
-	return ret;
+	return error;
 }
 
 static void __exit tlclk_cleanup(void)
 {
-	sysfs_remove_group(&tlclk_device->dev.kobj, &tlclk_attribute_group);
 	platform_device_unregister(tlclk_device);
-	misc_deregister(&tlclk_miscdev);
-	unregister_chrdev(tlclk_major, "telco_clock");
-
+	platform_driver_unregister(&tlclk_driver);
 	release_region(TLCLK_BASE, 8);
-	del_timer_sync(&switchover_timer);
-	kfree(alarm_events);
-
 }
 
 static void switchover_timeout(unsigned long data)
