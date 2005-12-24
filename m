Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbVLXDa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbVLXDa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 22:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbVLXDa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 22:30:28 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:33713 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161164AbVLXDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 22:30:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: mgross <mgross@linux.intel.com>
Subject: Re: [PATCH] Re: [PATCH/RFT] tlclk: convert to the new platform device interface
Date: Fri, 23 Dec 2005 22:30:24 -0500
User-Agent: KMail/1.8.3
Cc: "Gross, Mark" <mark.gross@intel.com>, torvalds@osdl.org,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
References: <F760B14C9561B941B89469F59BA3A8470C36C8F9@orsmsx401.amr.corp.intel.com> <200512231443.36906.mgross@linux.intel.com>
In-Reply-To: <200512231443.36906.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512232230.25126.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 17:43, mgross wrote:
> Attached is a patch against 2.6.15-rc6-git4 to update the telecom clock to 
> match an update to the TPS.
> 
> This patch also includes a few clean ups.
> Signed-off-by: Mark Gross <mark.gross@intel.com>

And here is my patch, rediffed for your convenience.

-- 
Dmitry

tlclk: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
define dcdbas_driver and implement ->probe() and ->remove() functions
so manual binding and unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/tlclk.c |  124 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 80 insertions(+), 44 deletions(-)

Index: work/drivers/char/tlclk.c
===================================================================
--- work.orig/drivers/char/tlclk.c
+++ work/drivers/char/tlclk.c
@@ -718,78 +718,114 @@ static struct attribute_group tlclk_attr
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
+	}
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
 	}
 
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
+
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
 		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
 			TLCLK_BASE);
-		ret = -EBUSY;
-		goto out1;
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
-		goto out2;
+		error = -ENODEV;
+		goto err_release_region;
 	}
 
-	ret = misc_register(&tlclk_miscdev);
-	if (ret < 0) {
-		printk(KERN_ERR " misc_register retruns %d\n", ret);
-		ret = -EBUSY;
-		goto out2;
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
-		goto out3;
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
-		goto out4;
+	error = platform_device_add(tlclk_device);
+	if (error) {
+		printk(KERN_ERR "tlclk: failed to register platform device\n");
+		goto err_free_device;
 	}
 
 	return 0;
-out4:
-	platform_device_unregister(tlclk_device);
-out3:
-	misc_deregister(&tlclk_miscdev);
-out2:
+
+ err_free_device:
+	platform_device_put(tlclk_device);
+ err_unregister_driver:
+	platform_driver_unregister(&tlclk_driver);
+ err_release_region:
 	release_region(TLCLK_BASE, 8);
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
 }
 
