Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTDVUxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTDVUxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:53:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54177 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263869AbTDVUqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:46:20 -0400
Date: Tue, 22 Apr 2003 13:57:49 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [2/5]
Message-ID: <20030422205749.GC4701@kroah.com>
References: <20030422205545.GA4701@kroah.com> <20030422205719.GB4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422205719.GB4701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:55:45PM -0700, Greg KH wrote:
>  - Fixes for the input core to build properly.  I've not converted the
>    input core to the new class model yet, but will after this.


diff -Nru a/drivers/input/evbug.c b/drivers/input/evbug.c
--- a/drivers/input/evbug.c	Tue Apr 22 13:07:49 2003
+++ b/drivers/input/evbug.c	Tue Apr 22 13:07:49 2003
@@ -88,19 +88,8 @@
 	.id_table =	evbug_ids,
 };
 
-static struct device_interface evbug_intf = {
-	.name		= "debug",
-	.devclass	= &input_devclass,
-};
-
 int __init evbug_init(void)
 {
-	int retval;
-
-	retval = interface_register(&evbug_intf);
-	if(retval < 0)
-		return retval;
-
 	input_register_handler(&evbug_handler);
 	return 0;
 }
@@ -108,7 +97,6 @@
 void __exit evbug_exit(void)
 {
 	input_unregister_handler(&evbug_handler);
-	interface_unregister(&evbug_intf);
 }
 
 module_init(evbug_init);
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Tue Apr 22 13:07:53 2003
+++ b/drivers/input/evdev.c	Tue Apr 22 13:07:53 2003
@@ -435,19 +435,8 @@
 	.id_table =	evdev_ids,
 };
 
-static struct device_interface evdev_intf = {
-	.name		= "event",
-	.devclass	= &input_devclass,
-};
-
 static int __init evdev_init(void)
 {
-	int retval;
-
-	retval = interface_register(&evdev_intf);
-	if(retval < 0)
-		return retval;
-
 	input_register_handler(&evdev_handler);
 	return 0;
 }
@@ -455,7 +444,6 @@
 static void __exit evdev_exit(void)
 {
 	input_unregister_handler(&evdev_handler);
-	interface_unregister(&evdev_intf);
 }
 
 module_init(evdev_init);
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Apr 22 13:07:58 2003
+++ b/drivers/input/input.c	Tue Apr 22 13:07:58 2003
@@ -38,7 +38,7 @@
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL(input_devclass);
+EXPORT_SYMBOL(input_class);
 
 #define INPUT_MAJOR	13
 #define INPUT_DEVICES	256
@@ -675,7 +675,7 @@
 
 #endif
 
-struct device_class input_devclass = {
+struct class input_class = {
 	.name		= "input",
 };
 
@@ -683,7 +683,7 @@
 {
 	struct proc_dir_entry *entry;
 
-	devclass_register(&input_devclass);
+	class_register(&input_class);
 
 #ifdef CONFIG_PROC_FS
 	proc_bus_input_dir = proc_mkdir("input", proc_bus);
@@ -714,7 +714,7 @@
 	devfs_unregister(input_devfs_handle);
         if (unregister_chrdev(INPUT_MAJOR, "input"))
                 printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);
-	devclass_unregister(&input_devclass);
+	class_unregister(&input_class);
 }
 
 subsys_initcall(input_init);
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Tue Apr 22 13:08:02 2003
+++ b/drivers/input/mousedev.c	Tue Apr 22 13:08:02 2003
@@ -487,18 +487,8 @@
 };
 #endif
 
-static struct device_interface mousedev_intf = {
-	.name		= "mouse",
-	.devclass	= &input_devclass,
-};
-
 static int __init mousedev_init(void)
 {
-	int retval;
-
-	if((retval = interface_register(&mousedev_intf)) < 0)
-		return retval;
-
 	input_register_handler(&mousedev_handler);
 
 	memset(&mousedev_mix, 0, sizeof(struct mousedev));
@@ -527,7 +517,6 @@
 #endif
 	input_unregister_minor(mousedev_mix.devfs);
 	input_unregister_handler(&mousedev_handler);
-	interface_unregister(&mousedev_intf);
 }
 
 module_init(mousedev_init);
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Apr 22 13:07:59 2003
+++ b/drivers/usb/input/hid-core.c	Tue Apr 22 13:07:59 2003
@@ -1664,9 +1664,6 @@
 	.probe =	hid_probe,
 	.disconnect =	hid_disconnect,
 	.id_table =	hid_usb_ids,
-	.driver	= {
-		.devclass = &input_devclass,
-	},
 };
 
 static int __init hid_init(void)
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Apr 22 13:07:53 2003
+++ b/include/linux/input.h	Tue Apr 22 13:07:53 2003
@@ -909,7 +909,7 @@
 #define input_regs(a,b)		do { (a)->regs = (b); } while (0)
 #define input_sync(a)		do { input_event(a, EV_SYN, SYN_REPORT, 0); (a)->regs = NULL; } while (0)
 
-extern struct device_class input_devclass;
+extern struct class input_class;
 
 #endif
 #endif
