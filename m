Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWCBXRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWCBXRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWCBXRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:17:01 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:60104 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1752077AbWCBXRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:17:00 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Philip Blundell <philb@gnu.org>
Subject: [PATCH] hp300: fix driver_register() return handling, remove dio_module_init()
Date: Thu, 2 Mar 2006 16:16:56 -0700
User-Agent: KMail/1.8.3
Cc: Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021616.56578.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that driver_register() returns the number of
devices bound to the driver.  In fact, it returns zero for success
or a negative error value.

dio_module_init() used the device count to automatically unregister
and unload drivers that found no devices.  That might have worked at
one time, but has been broken for some time because dio_register_driver()
returned either a negative error or a positive count (never zero).  So
it could only unregister on failure, when it's not needed anyway.

This functionality could be resurrected in individual drivers by
counting devices in their .probe() methods.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/dio/dio-driver.c
===================================================================
--- work-mm4.orig/drivers/dio/dio-driver.c	2006-03-01 15:37:15.000000000 -0700
+++ work-mm4/drivers/dio/dio-driver.c	2006-03-02 10:50:40.000000000 -0700
@@ -71,22 +71,17 @@
 	 *  @drv: the driver structure to register
 	 *
 	 *  Adds the driver structure to the list of registered drivers
-	 *  Returns the number of DIO devices which were claimed by the driver
-	 *  during registration.  The driver remains registered even if the
-	 *  return value is zero.
+	 *  Returns zero or a negative error value.
 	 */
 
 int dio_register_driver(struct dio_driver *drv)
 {
-	int count = 0;
-
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &dio_bus_type;
 
 	/* register with core */
-	count = driver_register(&drv->driver);
-	return count ? count : 1;
+	return driver_register(&drv->driver);
 }
 
 
Index: work-mm4/drivers/net/hplance.c
===================================================================
--- work-mm4.orig/drivers/net/hplance.c	2006-03-01 15:37:16.000000000 -0700
+++ work-mm4/drivers/net/hplance.c	2006-03-02 12:22:59.000000000 -0700
@@ -217,7 +217,7 @@
 
 int __init hplance_init_module(void)
 {
-	return dio_module_init(&hplance_driver);
+	return dio_register_driver(&hplance_driver);
 }
 
 void __exit hplance_cleanup_module(void)
Index: work-mm4/drivers/serial/8250_hp300.c
===================================================================
--- work-mm4.orig/drivers/serial/8250_hp300.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/drivers/serial/8250_hp300.c	2006-03-02 12:36:23.000000000 -0700
@@ -55,6 +55,8 @@
 
 #endif
 
+static unsigned int num_ports;
+
 extern int hp300_uart_scode;
 
 /* Offset to UART registers from base of DCA */
@@ -199,6 +201,8 @@
 	out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);
 	udelay(100);
 
+	num_ports++;
+
 	return 0;
 }
 #endif
@@ -206,7 +210,6 @@
 static int __init hp300_8250_init(void)
 {
 	static int called = 0;
-	int num_ports;
 #ifdef CONFIG_HPAPCI
 	int line;
 	unsigned long base;
@@ -221,11 +224,8 @@
 	if (!MACH_IS_HP300)
 		return -ENODEV;
 
-	num_ports = 0;
-
 #ifdef CONFIG_HPDCA
-	if (dio_module_init(&hpdca_driver) == 0)
-		num_ports++;
+	dio_register_driver(&hpdca_driver);
 #endif
 #ifdef CONFIG_HPAPCI
 	if (hp300_model < HP_400) {
Index: work-mm4/include/linux/dio.h
===================================================================
--- work-mm4.orig/include/linux/dio.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/include/linux/dio.h	2006-03-02 12:36:50.000000000 -0700
@@ -276,37 +276,5 @@
 	dev_set_drvdata(&d->dev, data);
 }
 
-/*
- * A helper function which helps ensure correct dio_driver
- * setup and cleanup for commonly-encountered hotplug/modular cases
- *
- * This MUST stay in a header, as it checks for -DMODULE
- */
-static inline int dio_module_init(struct dio_driver *drv)
-{
-	int rc = dio_register_driver(drv);
-
-	if (rc > 0)
-		return 0;
-
-	/* iff CONFIG_HOTPLUG and built into kernel, we should
-	 * leave the driver around for future hotplug events.
-	 * For the module case, a hotplug daemon of some sort
-	 * should load a module in response to an insert event. */
-#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
-	if (rc == 0)
-		return 0;
-#else
-	if (rc == 0)
-		rc = -ENODEV;
-#endif
-
-	/* if we get here, we need to clean up DIO driver instance
-	 * and return some sort of error */
-	dio_unregister_driver(drv);
-
-	return rc;
-}
-
 #endif /* __KERNEL__ */
 #endif /* ndef _LINUX_DIO_H */
Index: work-mm4/drivers/video/hpfb.c
===================================================================
--- work-mm4.orig/drivers/video/hpfb.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/drivers/video/hpfb.c	2006-03-02 12:33:53.000000000 -0700
@@ -386,7 +386,9 @@
 	if (fb_get_options("hpfb", NULL))
 		return -ENODEV;
 
-	dio_module_init(&hpfb_driver);
+	err = dio_register_driver(&hpfb_driver);
+	if (err)
+		return err;
 
 	fs = get_fs();
 	set_fs(KERNEL_DS);
