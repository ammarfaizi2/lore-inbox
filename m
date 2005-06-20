Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVFUDmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVFUDmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFUDWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:22:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:3556 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261642AbVFTW7c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:32 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert drivers/* to use the new class api instead of class_simple
In-Reply-To: <11193083632673@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <1119308363226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert drivers/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 56b2293595b2eb52cc2aa2baf92c6cfa8265f9d5
tree 5cbada5b35b1b87dfd75852c9397a2b14dfbb9d9
parent 8874b414ffe037c39e73bb262ddf69653a13c0a4
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 10:01:41 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:09 -0700

 drivers/isdn/capi/capi.c            |   14 +++++++-------
 drivers/macintosh/adb.c             |    9 ++++-----
 drivers/media/dvb/dvb-core/dvbdev.c |   13 ++++++-------
 drivers/net/ppp_generic.c           |   14 +++++++-------
 drivers/net/wan/cosa.c              |   12 ++++++------
 drivers/s390/char/tape_class.c      |   10 +++++-----
 drivers/s390/char/vmlogrdr.c        |   10 +++++-----
 drivers/usb/core/file.c             |   12 ++++++------
 drivers/video/fbmem.c               |   10 +++++-----
 9 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -58,7 +58,7 @@ MODULE_LICENSE("GPL");
 
 /* -------- driver information -------------------------------------- */
 
-static struct class_simple *capi_class;
+static struct class *capi_class;
 
 static int capi_major = 68;		/* allocated */
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
@@ -1499,20 +1499,20 @@ static int __init capi_init(void)
 		return -EIO;
 	}
 
-	capi_class = class_simple_create(THIS_MODULE, "capi");
+	capi_class = class_create(THIS_MODULE, "capi");
 	if (IS_ERR(capi_class)) {
 		unregister_chrdev(capi_major, "capi20");
 		return PTR_ERR(capi_class);
 	}
 
-	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi");
+	class_device_create(capi_class, MKDEV(capi_major, 0), NULL, "capi");
 	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
 			"isdn/capi20");
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
-		class_simple_device_remove(MKDEV(capi_major, 0));
-		class_simple_destroy(capi_class);
+		class_device_destroy(capi_class, MKDEV(capi_major, 0));
+		class_destroy(capi_class);
 		unregister_chrdev(capi_major, "capi20");
 		return -ENOMEM;
 	}
@@ -1539,8 +1539,8 @@ static void __exit capi_exit(void)
 {
 	proc_exit();
 
-	class_simple_device_remove(MKDEV(capi_major, 0));
-	class_simple_destroy(capi_class);
+	class_device_destroy(capi_class, MKDEV(capi_major, 0));
+	class_destroy(capi_class);
 	unregister_chrdev(capi_major, "capi20");
 	devfs_remove("isdn/capi20");
 
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -77,7 +77,7 @@ static struct adb_driver *adb_driver_lis
 	NULL
 };
 
-static struct class_simple *adb_dev_class;
+static struct class *adb_dev_class;
 
 struct adb_driver *adb_controller;
 struct notifier_block *adb_client_list = NULL;
@@ -902,9 +902,8 @@ adbdev_init(void)
 
 	devfs_mk_cdev(MKDEV(ADB_MAJOR, 0), S_IFCHR | S_IRUSR | S_IWUSR, "adb");
 
-	adb_dev_class = class_simple_create(THIS_MODULE, "adb");
-	if (IS_ERR(adb_dev_class)) {
+	adb_dev_class = class_create(THIS_MODULE, "adb");
+	if (IS_ERR(adb_dev_class))
 		return;
-	}
-	class_simple_device_add(adb_dev_class, MKDEV(ADB_MAJOR, 0), NULL, "adb");
+	class_device_create(adb_dev_class, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 }
diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -56,8 +56,7 @@ static const char * const dnames[] = {
 #define nums2minor(num,type,id)	((num << 6) | (id << 4) | type)
 #define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS*64)
 
-struct class_simple *dvb_class;
-EXPORT_SYMBOL(dvb_class);
+static struct class *dvb_class;
 
 static struct dvb_device* dvbdev_find_device (int minor)
 {
@@ -236,8 +235,8 @@ int dvb_register_device(struct dvb_adapt
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			"dvb/adapter%d/%s%d", adap->num, dnames[type], id);
 
-	class_simple_device_add(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
-				NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
+	class_device_create(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
+			    NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
 
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, nums2minor(adap->num, type, id),
@@ -256,7 +255,7 @@ void dvb_unregister_device(struct dvb_de
 	devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
 			dnames[dvbdev->type], dvbdev->id);
 
-	class_simple_device_remove(MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num,
+	class_device_destroy(dvb_class, MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num,
 					dvbdev->type, dvbdev->id)));
 
 	list_del (&dvbdev->list_head);
@@ -412,7 +411,7 @@ static int __init init_dvbdev(void)
 
 	devfs_mk_dir("dvb");
 
-	dvb_class = class_simple_create(THIS_MODULE, "dvb");
+	dvb_class = class_create(THIS_MODULE, "dvb");
 	if (IS_ERR(dvb_class)) {
 		retval = PTR_ERR(dvb_class);
 		goto error;
@@ -429,7 +428,7 @@ error:
 static void __exit exit_dvbdev(void)
 {
         devfs_remove("dvb");
-	class_simple_destroy(dvb_class);
+	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
         unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
 }
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -273,7 +273,7 @@ static int ppp_connect_channel(struct ch
 static int ppp_disconnect_channel(struct channel *pch);
 static void ppp_destroy_channel(struct channel *pch);
 
-static struct class_simple *ppp_class;
+static struct class *ppp_class;
 
 /* Translates a PPP protocol number to a NP index (NP == network protocol) */
 static inline int proto_to_npindex(int proto)
@@ -858,12 +858,12 @@ static int __init ppp_init(void)
 	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
 	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
 	if (!err) {
-		ppp_class = class_simple_create(THIS_MODULE, "ppp");
+		ppp_class = class_create(THIS_MODULE, "ppp");
 		if (IS_ERR(ppp_class)) {
 			err = PTR_ERR(ppp_class);
 			goto out_chrdev;
 		}
-		class_simple_device_add(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
+		class_device_create(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
 		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
 		if (err)
@@ -876,8 +876,8 @@ out:
 	return err;
 
 out_class:
-	class_simple_device_remove(MKDEV(PPP_MAJOR,0));
-	class_simple_destroy(ppp_class);
+	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR,0));
+	class_destroy(ppp_class);
 out_chrdev:
 	unregister_chrdev(PPP_MAJOR, "ppp");
 	goto out;
@@ -2654,8 +2654,8 @@ static void __exit ppp_cleanup(void)
 	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	devfs_remove("ppp");
-	class_simple_device_remove(MKDEV(PPP_MAJOR, 0));
-	class_simple_destroy(ppp_class);
+	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
+	class_destroy(ppp_class);
 }
 
 /*
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -235,7 +235,7 @@ static int dma[MAX_CARDS+1];
 static int irq[MAX_CARDS+1] = { -1, -1, -1, -1, -1, -1, 0, };
 
 /* for class stuff*/
-static struct class_simple *cosa_class;
+static struct class *cosa_class;
 
 #ifdef MODULE
 module_param_array(io, int, NULL, 0);
@@ -394,19 +394,19 @@ static int __init cosa_init(void)
 		goto out;
 	}
 	devfs_mk_dir("cosa");
-	cosa_class = class_simple_create(THIS_MODULE, "cosa");
+	cosa_class = class_create(THIS_MODULE, "cosa");
 	if (IS_ERR(cosa_class)) {
 		err = PTR_ERR(cosa_class);
 		goto out_chrdev;
 	}
 	for (i=0; i<nr_cards; i++) {
-		class_simple_device_add(cosa_class, MKDEV(cosa_major, i),
+		class_device_create(cosa_class, MKDEV(cosa_major, i),
 				NULL, "cosa%d", i);
 		err = devfs_mk_cdev(MKDEV(cosa_major, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"cosa/%d", i);
 		if (err) {
-			class_simple_device_remove(MKDEV(cosa_major, i));
+			class_device_destroy(cosa_class, MKDEV(cosa_major, i));
 			goto out_chrdev;		
 		}
 	}
@@ -427,10 +427,10 @@ static void __exit cosa_exit(void)
 	printk(KERN_INFO "Unloading the cosa module\n");
 
 	for (i=0; i<nr_cards; i++) {
-		class_simple_device_remove(MKDEV(cosa_major, i));
+		class_device_destroy(cosa_class, MKDEV(cosa_major, i));
 		devfs_remove("cosa/%d", i);
 	}
-	class_simple_destroy(cosa_class);
+	class_destroy(cosa_class);
 	devfs_remove("cosa");
 	for (cosa=cosa_cards; nr_cards--; cosa++) {
 		/* Clean up the per-channel data */
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -16,7 +16,7 @@ MODULE_DESCRIPTION(
 );
 MODULE_LICENSE("GPL");
 
-struct class_simple *tape_class;
+static struct class *tape_class;
 
 /*
  * Register a tape device and return a pointer to the cdev structure.
@@ -70,7 +70,7 @@ struct tape_class_device *register_tape_
 	if (rc)
 		goto fail_with_cdev;
 
-	tcd->class_device = class_simple_device_add(
+	tcd->class_device = class_device_create(
 				tape_class,
 				tcd->char_device->dev,
 				device,
@@ -101,7 +101,7 @@ void unregister_tape_dev(struct tape_cla
 			&tcd->class_device->dev->kobj,
 			tcd->mode_name
 		);
-		class_simple_device_remove(tcd->char_device->dev);
+		class_device_destroy(tape_class, tcd->char_device->dev);
 		cdev_del(tcd->char_device);
 		kfree(tcd);
 	}
@@ -111,14 +111,14 @@ EXPORT_SYMBOL(unregister_tape_dev);
 
 static int __init tape_init(void)
 {
-	tape_class = class_simple_create(THIS_MODULE, "tape390");
+	tape_class = class_create(THIS_MODULE, "tape390");
 
 	return 0;
 }
 
 static void __exit tape_exit(void)
 {
-	class_simple_destroy(tape_class);
+	class_destroy(tape_class);
 	tape_class = NULL;
 }
 
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -703,7 +703,7 @@ static struct attribute_group vmlogrdr_a
 	.attrs = vmlogrdr_attrs,
 };
 
-static struct class_simple *vmlogrdr_class;
+static struct class *vmlogrdr_class;
 static struct device_driver vmlogrdr_driver = {
 	.name = "vmlogrdr",
 	.bus  = &iucv_bus,
@@ -727,7 +727,7 @@ vmlogrdr_register_driver(void) {
 		goto unregdriver;
 	}
 
-	vmlogrdr_class = class_simple_create(THIS_MODULE, "vmlogrdr");
+	vmlogrdr_class = class_create(THIS_MODULE, "vmlogrdr");
 	if (IS_ERR(vmlogrdr_class)) {
 		printk(KERN_ERR "vmlogrdr: failed to create class.\n");
 		ret=PTR_ERR(vmlogrdr_class);
@@ -746,7 +746,7 @@ unregdriver:
 
 static void
 vmlogrdr_unregister_driver(void) {
-	class_simple_destroy(vmlogrdr_class);
+	class_destroy(vmlogrdr_class);
 	vmlogrdr_class = NULL;
 	driver_remove_file(&vmlogrdr_driver, &driver_attr_recording_status);
 	driver_unregister(&vmlogrdr_driver);
@@ -786,7 +786,7 @@ vmlogrdr_register_device(struct vmlogrdr
 		device_unregister(dev);
 		return ret;
 	}
-	priv->class_device = class_simple_device_add(
+	priv->class_device = class_device_create(
 				vmlogrdr_class,
 				MKDEV(vmlogrdr_major, priv->minor_num),
 				dev,
@@ -806,7 +806,7 @@ vmlogrdr_register_device(struct vmlogrdr
 
 static int
 vmlogrdr_unregister_device(struct vmlogrdr_priv_t *priv ) {
-	class_simple_device_remove(MKDEV(vmlogrdr_major, priv->minor_num));
+	class_device_destroy(vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
 	if (priv->device != NULL) {
 		sysfs_remove_group(&priv->device->kobj, &vmlogrdr_attr_group);
 		device_unregister(priv->device);
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -68,7 +68,7 @@ static struct file_operations usb_fops =
 	.open =		usb_open,
 };
 
-static struct class_simple *usb_class;
+static struct class *usb_class;
 
 int usb_major_init(void)
 {
@@ -80,9 +80,9 @@ int usb_major_init(void)
 		goto out;
 	}
 
-	usb_class = class_simple_create(THIS_MODULE, "usb");
+	usb_class = class_create(THIS_MODULE, "usb");
 	if (IS_ERR(usb_class)) {
-		err("class_simple_create failed for usb devices");
+		err("class_create failed for usb devices");
 		unregister_chrdev(USB_MAJOR, "usb");
 		goto out;
 	}
@@ -95,7 +95,7 @@ out:
 
 void usb_major_cleanup(void)
 {
-	class_simple_destroy(usb_class);
+	class_destroy(usb_class);
 	devfs_remove("usb");
 	unregister_chrdev(USB_MAJOR, "usb");
 }
@@ -171,7 +171,7 @@ int usb_register_dev(struct usb_interfac
 		++temp;
 	else
 		temp = name;
-	intf->class_dev = class_simple_device_add(usb_class, MKDEV(USB_MAJOR, minor), &intf->dev, "%s", temp);
+	intf->class_dev = class_device_create(usb_class, MKDEV(USB_MAJOR, minor), &intf->dev, "%s", temp);
 	if (IS_ERR(intf->class_dev)) {
 		spin_lock (&minor_lock);
 		usb_minors[intf->minor] = NULL;
@@ -220,7 +220,7 @@ void usb_deregister_dev(struct usb_inter
 
 	snprintf(name, BUS_ID_SIZE, class_driver->name, intf->minor - minor_base);
 	devfs_remove (name);
-	class_simple_device_remove(MKDEV(USB_MAJOR, intf->minor));
+	class_device_destroy(usb_class, MKDEV(USB_MAJOR, intf->minor));
 	intf->class_dev = NULL;
 	intf->minor = -1;
 }
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1040,7 +1040,7 @@ static struct file_operations fb_fops = 
 #endif
 };
 
-static struct class_simple *fb_class;
+static struct class *fb_class;
 
 /**
  *	register_framebuffer - registers a frame buffer device
@@ -1066,7 +1066,7 @@ register_framebuffer(struct fb_info *fb_
 			break;
 	fb_info->node = i;
 
-	fb_info->class_device = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+	fb_info->class_device = class_device_create(fb_class, MKDEV(FB_MAJOR, i),
 				    fb_info->device, "fb%d", i);
 	if (IS_ERR(fb_info->class_device)) {
 		/* Not fatal */
@@ -1134,7 +1134,7 @@ unregister_framebuffer(struct fb_info *f
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	fb_cleanup_class_device(fb_info);
-	class_simple_device_remove(MKDEV(FB_MAJOR, i));
+	class_device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	return 0;
 }
 
@@ -1197,7 +1197,7 @@ fbmem_init(void)
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
-	fb_class = class_simple_create(THIS_MODULE, "graphics");
+	fb_class = class_create(THIS_MODULE, "graphics");
 	if (IS_ERR(fb_class)) {
 		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
 		fb_class = NULL;
@@ -1210,7 +1210,7 @@ module_init(fbmem_init);
 static void __exit
 fbmem_exit(void)
 {
-	class_simple_destroy(fb_class);
+	class_destroy(fb_class);
 }
 
 module_exit(fbmem_exit);

