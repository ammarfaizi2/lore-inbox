Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUFAUv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUFAUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUFAUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:51:57 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:40289 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265214AbUFAUvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:51:35 -0400
Subject: [PATCH] 2.6.6 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <20040528160612.306c22ab.akpm@osdl.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1086123064.2171.12.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2004 15:51:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to drivers/char/synclink.c against 2.6.6
to cleanup properly on errors during
driver initialization.

In particular, call pci_unregister_driver if
driver init fails. This is in response to a bug
report by Dave Jones.

Please apply.

--
Paul Fulghum
paulkf@microgate.com



--- linux-2.6.6/drivers/char/synclink.c	2004-06-01 15:30:02.903257790 -0500
+++ linux-2.6.6-mg1/drivers/char/synclink.c	2004-06-01 15:28:24.166310318 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.21 2004/03/08 15:29:22 paulkf Exp $
+ * $Id: synclink.c,v 4.22 2004/06/01 20:27:46 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -782,7 +782,6 @@
 void mgsl_release_resources(struct mgsl_struct *info);
 void mgsl_add_device(struct mgsl_struct *info);
 struct mgsl_struct* mgsl_allocate_device(void);
-int mgsl_enum_isa_devices(void);
 
 /*
  * DMA buffer manupulation functions.
@@ -909,7 +908,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.21 $";
+static char *driver_version = "$Revision: 4.22 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -4484,9 +4483,10 @@
 /*
  * perform tty device initialization
  */
-int mgsl_init_tty(void);
-int mgsl_init_tty()
+static int mgsl_init_tty(void)
 {
+	int rc;
+
 	serial_driver = alloc_tty_driver(mgsl_device_count);
 	if (!serial_driver)
 		return -ENOMEM;
@@ -4503,9 +4503,13 @@
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &mgsl_ops);
-	if (tty_register_driver(serial_driver) < 0)
+	if ((rc = tty_register_driver(serial_driver)) < 0) {
 		printk("%s(%d):Couldn't register serial driver\n",
 			__FILE__,__LINE__);
+		put_tty_driver(serial_driver);
+		serial_driver = NULL;
+		return rc;
+	}
 			
  	printk("%s %s, tty major#%d\n",
 		driver_name, driver_version,
@@ -4515,7 +4519,7 @@
 
 /* enumerate user specified ISA adapters
  */
-int mgsl_enum_isa_devices()
+static void mgsl_enum_isa_devices(void)
 {
 	struct mgsl_struct *info;
 	int i;
@@ -4546,51 +4550,9 @@
 		
 		mgsl_add_device( info );
 	}
-	
-	return 0;
-}
-
-/* mgsl_init()
- * 
- * 	Driver initialization entry point.
- * 	
- * Arguments:	None
- * Return Value:	0 if success, otherwise error code
- */
-int __init mgsl_init(void)
-{
-	int rc;
-
- 	printk("%s %s\n", driver_name, driver_version);
-	
-	mgsl_enum_isa_devices();
-	pci_register_driver(&synclink_pci_driver);
-
-	if ( !mgsl_device_list ) {
-		printk("%s(%d):No SyncLink devices found.\n",__FILE__,__LINE__);
-		return -ENODEV;
-	}
-	if ((rc = mgsl_init_tty()))
-		return rc;
-	
-	return 0;
-}
-
-static int __init synclink_init(void)
-{
-/* Uncomment this to kernel debug module.
- * mgsl_get_text_ptr() leaves the .text address in eax
- * which can be used with add-symbol-file with gdb.
- */
-	if (break_on_load) {
-	 	mgsl_get_text_ptr();
-  		BREAKPOINT();
-	}
-	
-	return mgsl_init();
 }
 
-static void __exit synclink_exit(void) 
+static void synclink_cleanup(void) 
 {
 	int rc;
 	struct mgsl_struct *info;
@@ -4598,11 +4560,13 @@
 
 	printk("Unloading %s: %s\n", driver_name, driver_version);
 
-	if ((rc = tty_unregister_driver(serial_driver)))
-		printk("%s(%d) failed to unregister tty driver err=%d\n",
-		       __FILE__,__LINE__,rc);
+	if (serial_driver) {
+		if ((rc = tty_unregister_driver(serial_driver)))
+			printk("%s(%d) failed to unregister tty driver err=%d\n",
+			       __FILE__,__LINE__,rc);
+		put_tty_driver(serial_driver);
+	}
 
-	put_tty_driver(serial_driver);
 	info = mgsl_device_list;
 	while(info) {
 #ifdef CONFIG_SYNCLINK_SYNCPPP
@@ -4623,6 +4587,40 @@
 	pci_unregister_driver(&synclink_pci_driver);
 }
 
+static int __init synclink_init(void)
+{
+	int rc;
+
+	if (break_on_load) {
+	 	mgsl_get_text_ptr();
+  		BREAKPOINT();
+	}
+
+ 	printk("%s %s\n", driver_name, driver_version);
+	
+	mgsl_enum_isa_devices();
+	pci_register_driver(&synclink_pci_driver);
+
+	if ( !mgsl_device_list ) {
+		printk("%s(%d):No SyncLink devices found.\n",__FILE__,__LINE__);
+		rc = -ENODEV;
+		goto error;
+	}
+	if ((rc = mgsl_init_tty()) < 0)
+		goto error;
+	
+	return 0;
+
+error:
+	synclink_cleanup();
+	return rc;
+}
+
+static void __exit synclink_exit(void) 
+{
+	synclink_cleanup();
+}
+
 module_init(synclink_init);
 module_exit(synclink_exit);
 



