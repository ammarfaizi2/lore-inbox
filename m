Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUFBOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUFBOOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUFBOOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:14:45 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:2934 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262960AbUFBOOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:14:19 -0400
Subject: Re: [PATCH] 2.6.6 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
In-Reply-To: <20040601215710.F31301@flint.arm.linux.org.uk>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
	 <1086123061.2171.10.camel@deimos.microgate.com>
	 <20040601215710.F31301@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1086185630.3613.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2004 09:13:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 15:57, Russell King wrote:
> If pci_register_driver fails, the driver is not, repeat not left
> registered.  Therefore it must not be unregistered after failure
> to register.

OK, here is a corrected patch that properly distinguishes
between pci_register_driver failure and the case
of finding no hardware.


--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.6/drivers/char/synclinkmp.c	2004-06-02 09:07:40.495553141 -0500
+++ linux-2.6.6-mg1/drivers/char/synclinkmp.c	2004-06-02 09:08:05.720218567 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.19 2004/03/08 15:29:23 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.21 2004/06/02 14:07:14 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -494,7 +494,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.19 $";
+static char *driver_version = "$Revision: 4.21 $";
 
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
@@ -3882,6 +3835,75 @@
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
+	if ((rc = pci_register_driver(&synclinkmp_pci_driver)) < 0) {
+		printk("%s:failed to register PCI driver, error=%d\n",__FILE__,rc);
+		return rc;
+	}
+
+	if (!synclinkmp_device_list) {
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
 



