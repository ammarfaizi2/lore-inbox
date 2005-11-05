Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVKESTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKESTH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVKESSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:18:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932162AbVKESSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:18:20 -0500
Date: Sat, 5 Nov 2005 18:18:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert input drivers
Message-ID: <20051105181815.GO14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- b/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -912,7 +912,7 @@
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, pm_message_t state)
+static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
 	del_timer_sync(&i8042_timer);
 	i8042_controller_reset();
@@ -925,7 +925,7 @@
  * Here we try to reset everything back to a state in which suspended
  */
 
-static int i8042_resume(struct device *dev)
+static int i8042_resume(struct platform_device *dev)
 {
 	int i;
 
@@ -964,7 +964,7 @@
  * because otherwise BIOSes will be confused.
  */
 
-static void i8042_shutdown(struct device *dev)
+static void i8042_shutdown(struct platform_device *dev)
 {
 	i8042_controller_cleanup();
 }
@@ -969,12 +969,13 @@
 	i8042_controller_cleanup();
 }
 
-static struct device_driver i8042_driver = {
-	.name		= "i8042",
-	.bus		= &platform_bus_type,
+static struct platform_driver i8042_driver = {
 	.suspend	= i8042_suspend,
 	.resume		= i8042_resume,
 	.shutdown	= i8042_shutdown,
+	.driver		= {
+		.name	= "i8042",
+	},
 };
 
 static int __init i8042_create_kbd_port(void)
@@ -1078,7 +1079,7 @@
 		goto err_platform_exit;
 	}
 
-	err = driver_register(&i8042_driver);
+	err = platform_driver_register(&i8042_driver);
 	if (err)
 		goto err_controller_cleanup;
 
@@ -1126,7 +1127,7 @@
  err_unregister_device:
 	platform_device_unregister(i8042_platform_device);
  err_unregister_driver:
-	driver_unregister(&i8042_driver);
+	platform_driver_unregister(&i8042_driver);
  err_controller_cleanup:
 	i8042_controller_cleanup();
  err_platform_exit:
@@ -1148,7 +1149,7 @@
 	del_timer_sync(&i8042_timer);
 
 	platform_device_unregister(i8042_platform_device);
-	driver_unregister(&i8042_driver);
+	platform_driver_unregister(&i8042_driver);
 
 	i8042_platform_exit();
 
diff -u b/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- b/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -107,7 +107,7 @@
  * Allocate and initialize serio structure for subsequent registration
  * with serio core.
  */
-static int __devinit rpckbd_probe(struct device *dev)
+static int __devinit rpckbd_probe(struct platform_device *dev)
 {
 	struct serio *serio;
 
@@ -120,37 +120,38 @@
 	serio->write		= rpckbd_write;
 	serio->open		= rpckbd_open;
 	serio->close		= rpckbd_close;
-	serio->dev.parent	= dev;
+	serio->dev.parent	= &dev->dev;
 	strlcpy(serio->name, "RiscPC PS/2 kbd port", sizeof(serio->name));
 	strlcpy(serio->phys, "rpckbd/serio0", sizeof(serio->phys));
 
-	dev_set_drvdata(dev, serio);
+	platform_set_drvdata(dev, serio);
 	serio_register_port(serio);
 	return 0;
 }
 
-static int __devexit rpckbd_remove(struct device *dev)
+static int __devexit rpckbd_remove(struct platform_device *dev)
 {
-	struct serio *serio = dev_get_drvdata(dev);
+	struct serio *serio = platform_get_drvdata(dev);
 	serio_unregister_port(serio);
 	return 0;
 }
 
-static struct device_driver rpckbd_driver = {
-	.name		= "kart",
-	.bus		= &platform_bus_type,
+static struct platform_driver rpckbd_driver = {
 	.probe		= rpckbd_probe,
 	.remove		= __devexit_p(rpckbd_remove),
+	.driver		= {
+		.name	= "kart",
+	},
 };
 
 static int __init rpckbd_init(void)
 {
-	return driver_register(&rpckbd_driver);
+	return platform_driver_register(&rpckbd_driver);
 }
 
 static void __exit rpckbd_exit(void)
 {
-	driver_unregister(&rpckbd_driver);
+	platform_driver_unregister(&rpckbd_driver);
 }
 
 module_init(rpckbd_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
