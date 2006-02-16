Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWBPXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWBPXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBPXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:22:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4879 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932497AbWBPXWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:22:08 -0500
Date: Fri, 17 Feb 2006 00:22:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] make INPUT a bool
Message-ID: <20060216232205.GC4422@stusta.de>
References: <20060214152218.GI10701@stusta.de> <200602150120.58844.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602150120.58844.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:20:58AM -0500, Dmitry Torokhov wrote:
> On Tuesday 14 February 2006 10:22, Adrian Bunk wrote:
> > Make INPUT a bool.
> > 
> > INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
> > make that much sense to make it modular.
> >
> 
> Adrian,
> 
> We also need to get rid of input_register_device pinning input module
> and input_dev release function decrementing module's refcount.

Is the patch below OK?

> Thanks!
> Dmitry

cu
Adrian


<--  snip  -->


Make INPUT a bool.

INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
make that much sense to make it modular.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/Kconfig |    2 +-
 drivers/input/input.c |   21 ---------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

--- linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig.old	2006-02-03 22:42:18.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig	2006-02-03 22:42:29.000000000 +0100
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
+	bool "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
--- linux-2.6.16-rc3-mm1-full/drivers/input/input.c.old	2006-02-16 23:59:47.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/drivers/input/input.c	2006-02-17 00:06:06.000000000 +0100
@@ -23,10 +23,6 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
-MODULE_DESCRIPTION("Input core");
-MODULE_LICENSE("GPL");
-
 EXPORT_SYMBOL(input_allocate_device);
 EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
@@ -470,13 +466,10 @@
 	if (!proc_bus_input_dir)
 		return -ENOMEM;
 
-	proc_bus_input_dir->owner = THIS_MODULE;
-
 	entry = create_proc_read_entry("devices", 0, proc_bus_input_dir, input_devices_read, NULL);
 	if (!entry)
 		goto fail1;
 
-	entry->owner = THIS_MODULE;
 	input_fileops = *entry->proc_fops;
 	input_fileops.poll = input_devices_poll;
 	entry->proc_fops = &input_fileops;
@@ -485,8 +478,6 @@
 	if (!entry)
 		goto fail2;
 
-	entry->owner = THIS_MODULE;
-
 	return 0;
 
  fail2:	remove_proc_entry("devices", proc_bus_input_dir);
@@ -662,7 +653,6 @@
 	struct input_dev *dev = to_input_dev(class_dev);
 
 	kfree(dev);
-	module_put(THIS_MODULE);
 }
 
 /*
@@ -830,8 +820,6 @@
 	if (error)
 		goto fail3;
 
-	__module_get(THIS_MODULE);
-
 	path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
 	printk(KERN_INFO "input: %s as %s\n",
 		dev->name ? dev->name : "Unspecified device", path ? path : "N/A");
@@ -953,7 +941,6 @@
 }
 
 static struct file_operations input_fops = {
-	.owner = THIS_MODULE,
 	.open = input_open_file,
 };
 
@@ -984,12 +971,4 @@
 	return err;
 }
 
-static void __exit input_exit(void)
-{
-	input_proc_exit();
-	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_class);
-}
-
 subsys_initcall(input_init);
-module_exit(input_exit);

