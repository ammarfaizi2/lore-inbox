Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUFAUyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUFAUyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUFAUyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:54:20 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:46689 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265228AbUFAUxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:53:14 -0400
Subject: [PATCH] 2.6.6 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040528160612.306c22ab.akpm@osdl.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1086123182.2171.15.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2004 15:53:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to drivers/char/pcmcia/synclink_cs.c against 2.6.6
to cleanup properly on errors during
driver initialization.

Please apply.

--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.6/drivers/char/pcmcia/synclink_cs.c	2004-06-01 15:30:02.945252239 -0500
+++ linux-2.6.6-mg1/drivers/char/pcmcia/synclink_cs.c	2004-06-01 15:28:41.033080615 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.21 2004/03/08 15:29:23 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.22 2004/06/01 20:27:46 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -489,7 +489,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.21 $";
+static char *driver_version = "$Revision: 4.22 $";
 
 static struct tty_driver *serial_driver;
 
@@ -3130,9 +3130,35 @@
 	.tiocmset = tiocmset,
 };
 
+static void synclink_cs_cleanup(void) 
+{
+	int rc;
+
+	printk("Unloading %s: version %s\n", driver_name, driver_version);
+
+	while(mgslpc_device_list)
+		mgslpc_remove_device(mgslpc_device_list);
+
+	if (serial_driver) {
+		if ((rc = tty_unregister_driver(serial_driver)))
+			printk("%s(%d) failed to unregister tty driver err=%d\n",
+			       __FILE__,__LINE__,rc);
+		put_tty_driver(serial_driver);
+	}
+
+	pcmcia_unregister_driver(&mgslpc_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL) {
+		if (dev_list->state & DEV_CONFIG)
+			mgslpc_release((u_long)dev_list);
+		mgslpc_detach(dev_list);
+	}
+}
+
 static int __init synclink_cs_init(void)
 {
-    int error;
+    int rc;
 
     if (break_on_load) {
 	    mgslpc_get_text_ptr();
@@ -3141,14 +3167,13 @@
 
     printk("%s %s\n", driver_name, driver_version);
 
-    serial_driver = alloc_tty_driver(MAX_DEVICE_COUNT);
-    if (!serial_driver)
-	    return -ENOMEM;
+    if ((rc = pcmcia_register_driver(&mgslpc_driver)) < 0)
+	    return rc;
 
-    error = pcmcia_register_driver(&mgslpc_driver);
-    if (error) {
-	    put_tty_driver(serial_driver);
-	    return error;
+    serial_driver = alloc_tty_driver(MAX_DEVICE_COUNT);
+    if (!serial_driver) {
+	    rc = -ENOMEM;
+	    goto error;
     }
 
     /* Initialize the tty_driver structure */
@@ -3166,39 +3191,28 @@
     serial_driver->flags = TTY_DRIVER_REAL_RAW;
     tty_set_operations(serial_driver, &mgslpc_ops);
 
-    if (tty_register_driver(serial_driver) < 0)
+    if ((rc = tty_register_driver(serial_driver)) < 0) {
 	    printk("%s(%d):Couldn't register serial driver\n",
 		   __FILE__,__LINE__);
+	    put_tty_driver(serial_driver);
+	    serial_driver = NULL;
+	    goto error;
+    }
 			
     printk("%s %s, tty major#%d\n",
 	   driver_name, driver_version,
 	   serial_driver->major);
 	
     return 0;
+
+error:
+    synclink_cs_cleanup();
+    return rc;
 }
 
 static void __exit synclink_cs_exit(void) 
 {
-	int rc;
-
-	printk("Unloading %s: version %s\n", driver_name, driver_version);
-
-	while(mgslpc_device_list)
-		mgslpc_remove_device(mgslpc_device_list);
-
-	if ((rc = tty_unregister_driver(serial_driver)))
-		printk("%s(%d) failed to unregister tty driver err=%d\n",
-		       __FILE__,__LINE__,rc);
-	put_tty_driver(serial_driver);
-
-	pcmcia_unregister_driver(&mgslpc_driver);
-
-	/* XXX: this really needs to move into generic code.. */
-	while (dev_list != NULL) {
-		if (dev_list->state & DEV_CONFIG)
-			mgslpc_release((u_long)dev_list);
-		mgslpc_detach(dev_list);
-	}
+	synclink_cs_cleanup();
 }
 
 module_init(synclink_cs_init);



