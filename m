Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265090AbUFAUvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbUFAUvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUFAUvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:51:42 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:40033 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265090AbUFAUve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:51:34 -0400
Subject: [PATCH] 2.6.6 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <20040528160612.306c22ab.akpm@osdl.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1086123061.2171.10.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2004 15:51:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to drivers/char/synclinkmp.c against 2.6.6
to cleanup properly on errors during
driver initialization.

In particular, call pci_unregister_driver if
driver init fails. This is in response to a bug
report by Dave Jones.

Please apply.
--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.6/drivers/char/synclinkmp.c	2004-06-01 15:30:02.967249331 -0500
+++ linux-2.6.6-mg1/drivers/char/synclinkmp.c	2004-06-01 15:28:31.022403976 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.19 2004/03/08 15:29:23 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.20 2004/06/01 20:27:46 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -494,7 +494,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.19 $";
+static char *driver_version = "$Revision: 4.20 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -3781,56 +3781,7 @@
 	.tiocmset = tiocmset,
 };
 
-/* Driver initialization entry point.
- */
-
-static int __init synclinkmp_init(void)
-{
-	if (break_on_load) {
-	 	synclinkmp_get_text_ptr();
-  		BREAKPOINT();
-	}
-
- 	printk("%s %s\n", driver_name, driver_version);
-
-	synclinkmp_adapter_count = -1;
-	pci_register_driver(&synclinkmp_pci_driver);
-
-	if ( !synclinkmp_device_list ) {
-		printk("%s(%d):No SyncLink devices found.\n",__FILE__,__LINE__);
-		return -ENODEV;
-	}
-
-	serial_driver = alloc_tty_driver(synclinkmp_device_count);
-	if (!serial_driver)
-		return -ENOMEM;
-
-	/* Initialize the tty_driver structure */
-
-	serial_driver->owner = THIS_MODULE;
-	serial_driver->driver_name = "synclinkmp";
-	serial_driver->name = "ttySLM";
-	serial_driver->major = ttymajor;
-	serial_driver->minor_start = 64;
-	serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	serial_driver->subtype = SERIAL_TYPE_NORMAL;
-	serial_driver->init_termios = tty_std_termios;
-	serial_driver->init_termios.c_cflag =
-		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	serial_driver->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(serial_driver, &ops);
-	if (tty_register_driver(serial_driver) < 0)
-		printk("%s(%d):Couldn't register serial driver\n",
-			__FILE__,__LINE__);
-
- 	printk("%s %s, tty major#%d\n",
-		driver_name, driver_version,
-		serial_driver->major);
-
-	return 0;
-}
-
-static void __exit synclinkmp_exit(void)
+static void synclinkmp_cleanup(void)
 {
 	unsigned long flags;
 	int rc;
@@ -3839,10 +3790,12 @@
 
 	printk("Unloading %s %s\n", driver_name, driver_version);
 
-	if ((rc = tty_unregister_driver(serial_driver)))
-		printk("%s(%d) failed to unregister tty driver err=%d\n",
-		       __FILE__,__LINE__,rc);
-	put_tty_driver(serial_driver);
+	if (serial_driver) {
+		if ((rc = tty_unregister_driver(serial_driver)))
+			printk("%s(%d) failed to unregister tty driver err=%d\n",
+			       __FILE__,__LINE__,rc);
+		put_tty_driver(serial_driver);
+	}
 
 	info = synclinkmp_device_list;
 	while(info) {
@@ -3882,6 +3835,73 @@
 	pci_unregister_driver(&synclinkmp_pci_driver);
 }
 
+/* Driver initialization entry point.
+ */
+
+static int __init synclinkmp_init(void)
+{
+	int rc;
+
+	if (break_on_load) {
+	 	synclinkmp_get_text_ptr();
+  		BREAKPOINT();
+	}
+
+ 	printk("%s %s\n", driver_name, driver_version);
+
+	synclinkmp_adapter_count = -1;
+	rc = pci_register_driver(&synclinkmp_pci_driver);
+
+	if (rc <= 0 || !synclinkmp_device_list) {
+		printk("%s(%d):No SyncLink devices found.\n",__FILE__,__LINE__);
+		rc = -ENODEV;
+		goto error;
+	}
+
+	serial_driver = alloc_tty_driver(synclinkmp_device_count);
+	if (!serial_driver) {
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	/* Initialize the tty_driver structure */
+
+	serial_driver->owner = THIS_MODULE;
+	serial_driver->driver_name = "synclinkmp";
+	serial_driver->name = "ttySLM";
+	serial_driver->major = ttymajor;
+	serial_driver->minor_start = 64;
+	serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	serial_driver->subtype = SERIAL_TYPE_NORMAL;
+	serial_driver->init_termios = tty_std_termios;
+	serial_driver->init_termios.c_cflag =
+		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(serial_driver, &ops);
+	if ((rc = tty_register_driver(serial_driver)) < 0) {
+		printk("%s(%d):Couldn't register serial driver\n",
+			__FILE__,__LINE__);
+		put_tty_driver(serial_driver);
+		serial_driver = NULL;
+		goto error;
+	}
+
+ 	printk("%s %s, tty major#%d\n",
+		driver_name, driver_version,
+		serial_driver->major);
+
+	return 0;
+
+error:
+	synclinkmp_cleanup();
+	return rc;
+}
+
+static void __exit synclinkmp_exit(void)
+{
+	synclinkmp_cleanup();
+}
+
 module_init(synclinkmp_init);
 module_exit(synclinkmp_exit);
 



