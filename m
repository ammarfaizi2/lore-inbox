Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUFBOSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUFBOSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUFBOSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:18:40 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:5238 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262954AbUFBOPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:15:39 -0400
Subject: Re: [PATCH] 2.6.6 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <1086123064.2171.12.camel@deimos.microgate.com>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
	 <1086123064.2171.12.camel@deimos.microgate.com>
Content-Type: text/plain
Organization: 
Message-Id: <1086185730.3613.5.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2004 09:15:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a corrected patch that properly distinguishes
between pci_register_driver failure and the case of
finding no hardware.


--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.6/drivers/char/synclink.c	2004-06-02 09:07:40.452558825 -0500
+++ linux-2.6.6-mg1/drivers/char/synclink.c	2004-06-02 09:07:59.780003834 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.21 2004/03/08 15:29:22 paulkf Exp $
+ * $Id: synclink.c,v 4.23 2004/06/02 14:07:14 paulkf Exp $
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
@@ -866,6 +865,9 @@
 
 #define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
 
+/* set non-zero on successful registration with PCI subsystem */
+static int pci_registered;
+
 /*
  * Global linked list of SyncLink devices
  */
@@ -909,7 +911,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.21 $";
+static char *driver_version = "$Revision: 4.23 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -4484,9 +4486,10 @@
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
@@ -4503,9 +4506,13 @@
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
@@ -4515,7 +4522,7 @@
 
 /* enumerate user specified ISA adapters
  */
-int mgsl_enum_isa_devices()
+static void mgsl_enum_isa_devices(void)
 {
 	struct mgsl_struct *info;
 	int i;
@@ -4546,51 +4553,9 @@
 		
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
@@ -4598,11 +4563,13 @@
 
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
@@ -4620,7 +4587,45 @@
 		tmp_buf = NULL;
 	}
 	
-	pci_unregister_driver(&synclink_pci_driver);
+	if (pci_registered)
+		pci_unregister_driver(&synclink_pci_driver);
+}
+
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
+	if ((rc = pci_register_driver(&synclink_pci_driver)) < 0)
+		printk("%s:failed to register PCI driver, error=%d\n",__FILE__,rc);
+	else
+		pci_registered = 1;
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
 }
 
 module_init(synclink_init);



