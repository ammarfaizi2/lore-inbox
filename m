Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVASNtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVASNtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVASNtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:49:05 -0500
Received: from mail.suse.de ([195.135.220.2]:53933 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261721AbVASNsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:48:16 -0500
Message-ID: <41EE651E.1060201@suse.de>
Date: Wed, 19 Jan 2005 14:48:14 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Subject: [PATCH] remove input_call_hotplug (Take#2)
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030607070206000700000803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607070206000700000803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

attached is the reworked patch for removing the call to 
call_usermodehelper from input.c
I've used the 'phys' attribute to generate the device names, this way we 
don't need to touch all drivers and the patch itself is nice and small.

As usual, comments are welcome.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------030607070206000700000803
Content-Type: text/x-patch;
 name="bk-input-class-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk-input-class-device.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/19 14:34:05+01:00 hare@lammermuir.suse.de 
#   Remove left-over variables.
# 
# include/linux/input.h
#   2005/01/19 14:27:07+01:00 hare@lammermuir.suse.de +0 -2
#   Remove left-over variables.
# 
# ChangeSet
#   2005/01/19 14:21:57+01:00 hare@lammermuir.suse.de 
#   Implement sysfs class_device 'input_device' as abstraction of 
#   struct input_dev. This allows us to get rid of the explicit call 
#   to call_usermodehelper in drivers/input/input.c and makes the input
#   layer driver-model compliant.
# 
# drivers/input/input.c
#   2005/01/19 14:21:51+01:00 hare@lammermuir.suse.de +6 -6
#   Use ->phys as class_id for the device.
# 
# include/linux/input.h
#   2005/01/18 15:49:00+01:00 hare@lammermuir.suse.de +4 -0
#   Added class_device to the input_dev struct.
# 
# drivers/input/input.c
#   2005/01/18 15:47:37+01:00 hare@lammermuir.suse.de +147 -54
#   Implement 'input_device' class as abstraction of
#   struct input_dev. Default class IDs are being generated
#   if the driver does not provide one.
# 
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2005-01-19 14:37:05 +01:00
+++ b/drivers/input/input.c	2005-01-19 14:37:05 +01:00
@@ -332,52 +332,27 @@
 			SPRINTF_BIT_A(bit, name, max); \
 	} while (0)
 
-static void input_call_hotplug(char *verb, struct input_dev *dev)
+static int __input_hotplug(struct input_dev *dev, char **envp, int num_envp,
+			   char *buffer, int buffer_size)
 {
-	char *argv[3], **envp, *buf, *scratch;
-	int i = 0, j, value;
+	char *scratch;
+	int i = 0, j;
+	scratch = buffer;
 
-	if (!hotplug_path[0]) {
-		printk(KERN_ERR "input.c: calling hotplug without a hotplug agent defined\n");
-		return;
-	}
-	if (in_interrupt()) {
-		printk(KERN_ERR "input.c: calling hotplug from interrupt\n");
-		return;
-	}
-	if (!current->fs->root) {
-		printk(KERN_WARNING "input.c: calling hotplug without valid filesystem\n");
-		return;
-	}
-	if (!(envp = (char **) kmalloc(20 * sizeof(char *), GFP_KERNEL))) {
-		printk(KERN_ERR "input.c: not enough memory allocating hotplug environment\n");
-		return;
-	}
-	if (!(buf = kmalloc(1024, GFP_KERNEL))) {
-		kfree (envp);
-		printk(KERN_ERR "input.c: not enough memory allocating hotplug environment\n");
-		return;
-	}
-
-	argv[0] = hotplug_path;
-	argv[1] = "input";
-	argv[2] = NULL;
-
-	envp[i++] = "HOME=/";
-	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-	scratch = buf;
-
-	envp[i++] = scratch;
-	scratch += sprintf(scratch, "ACTION=%s", verb) + 1;
+	if (!dev)
+		return -ENODEV;
 
 	envp[i++] = scratch;
 	scratch += sprintf(scratch, "PRODUCT=%x/%x/%x/%x",
 		dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version) + 1;
 
+#ifdef INPUT_DEBUG
+	printk(KERN_DEBUG "%s: PRODUCT %x/%x/%x/%x\n", __FUNCTION__,
+	       dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
+#endif
 	if (dev->name) {
 		envp[i++] = scratch;
-		scratch += sprintf(scratch, "NAME=%s", dev->name) + 1;
+		scratch += sprintf(scratch, "NAME=\"%s\"", dev->name) + 1;
 	}
 
 	if (dev->phys) {
@@ -396,29 +371,143 @@
 
 	envp[i++] = NULL;
 
+	return 0;
+}
+
+int input_hotplug(struct class_device *cdev, char **envp, int num_envp,
+		  char *buffer, int buffer_size)
+{
+	struct input_dev *dev;
+
+	if (!cdev)
+		return -ENODEV;
 #ifdef INPUT_DEBUG
-	printk(KERN_DEBUG "input.c: calling %s %s [%s %s %s %s %s]\n",
-		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
+	printk(KERN_DEBUG "%s: entered for dev %p\n", __FUNCTION__, 
+	       &cdev->dev);
 #endif
 
-	value = call_usermodehelper(argv [0], argv, envp, 0);
+	dev = container_of(cdev,struct input_dev,cdev);
 
-	kfree(buf);
-	kfree(envp);
+	return __input_hotplug(dev, envp, num_envp, buffer, buffer_size);
+}
 
-#ifdef INPUT_DEBUG
-	if (value != 0)
-		printk(KERN_DEBUG "input.c: hotplug returned %d\n", value);
 #endif
+
+#define INPUT_ATTR_BIT_B(bit, max) \
+	do { \
+		for (i = NBITS(max) - 1; i >= 0; i--) \
+			if (dev->bit[i]) break; \
+		for (; i >= 0; i--) \
+			len += sprintf(buf + len, "%lx ", dev->bit[i]); \
+		if (len) len += sprintf(buf + len, "\n"); \
+	} while (0)
+
+#define INPUT_ATTR_BIT_B2(bit, max, ev) \
+	do { \
+		if (test_bit(ev, dev->evbit)) \
+			INPUT_ATTR_BIT_B(bit, max); \
+	} while (0)
+
+
+static ssize_t input_class_show_ev(struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = container_of(class_dev, struct input_dev,cdev);
+	int i, len = 0;
+
+	INPUT_ATTR_BIT_B(evbit, EV_MAX);
+	return len;
 }
 
-#endif
+#define INPUT_CLASS_ATTR_BIT(_name,_bit) \
+static ssize_t input_class_show_##_bit(struct class_device *class_dev, \
+				       char *buf) \
+{ \
+	struct input_dev *dev = container_of(class_dev,struct input_dev,cdev); \
+        int i, len = 0; \
+\
+	INPUT_ATTR_BIT_B2(_bit##bit, _name##_MAX, EV_##_name); \
+	return len; \
+}
+
+INPUT_CLASS_ATTR_BIT(KEY,key)
+INPUT_CLASS_ATTR_BIT(REL,rel)
+INPUT_CLASS_ATTR_BIT(ABS,abs)
+INPUT_CLASS_ATTR_BIT(MSC,msc)
+INPUT_CLASS_ATTR_BIT(LED,led)
+INPUT_CLASS_ATTR_BIT(SND,snd)
+INPUT_CLASS_ATTR_BIT(FF,ff)
+
+static ssize_t input_class_show_phys(struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = container_of(class_dev,struct input_dev,cdev);
+
+	return sprintf(buf, "%s\n", dev->phys ? dev->phys : "(none)" );
+}
+
+static ssize_t input_class_show_name(struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = container_of(class_dev,struct input_dev,cdev);
+
+	return sprintf(buf, "%s\n", dev->name ? dev->name : "(none)" );
+}
+
+static ssize_t input_class_show_product(struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = container_of(class_dev,struct input_dev,cdev);
+
+	return sprintf(buf, "%x/%x/%x/%x\n", dev->id.bustype, dev->id.vendor, 
+		       dev->id.product, dev->id.version);
+}
+
+static struct class_device_attribute input_device_class_attrs[] = {
+	__ATTR( product, S_IRUGO, input_class_show_product, NULL) ,
+	__ATTR( phys, S_IRUGO, input_class_show_phys, NULL ),
+	__ATTR( name, S_IRUGO, input_class_show_name, NULL) ,
+	__ATTR( ev, S_IRUGO, input_class_show_ev, NULL) ,
+	__ATTR( key, S_IRUGO, input_class_show_key, NULL) ,
+	__ATTR( rel, S_IRUGO, input_class_show_rel, NULL) ,
+	__ATTR( abs, S_IRUGO, input_class_show_abs, NULL) ,
+	__ATTR( msc, S_IRUGO, input_class_show_msc, NULL) ,
+	__ATTR( led, S_IRUGO, input_class_show_led, NULL) ,
+	__ATTR( snd, S_IRUGO, input_class_show_snd, NULL) ,
+	__ATTR( ff, S_IRUGO, input_class_show_ff, NULL) ,
+	__ATTR_NULL,
+};
+
+static void input_device_class_release( struct class_device *class_dev )
+{
+	put_device(class_dev->dev);
+}
+
+static struct class input_device_class = {
+	.name =		"input_device",
+	.hotplug = 	input_hotplug,
+	.release = 	input_device_class_release,
+	.class_dev_attrs = input_device_class_attrs,
+};
 
 void input_register_device(struct input_dev *dev)
 {
 	struct input_handle *handle;
 	struct input_handler *handler;
 	struct input_device_id *id;
+	char *ptr;
+
+	dev->cdev.class = &input_device_class;
+	
+	dev->cdev.dev = get_device(dev->dev);
+	sprintf(dev->cdev.class_id, dev->phys);
+	ptr = dev->cdev.class_id;
+	while ((ptr = strchr(ptr,'/')) != NULL) {
+		*ptr = '-';
+		ptr++;
+	}
+
+	if (class_device_register(&dev->cdev)) {
+		if (dev->dev)
+			put_device(dev->dev);
+		return;
+	}
 
 	set_bit(EV_SYN, dev->evbit);
 
@@ -444,10 +533,6 @@
 				if ((handle = handler->connect(handler, dev, id)))
 					input_link_handle(handle);
 
-#ifdef CONFIG_HOTPLUG
-	input_call_hotplug("add", dev);
-#endif
-
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -469,12 +554,10 @@
 		handle->handler->disconnect(handle);
 	}
 
-#ifdef CONFIG_HOTPLUG
-	input_call_hotplug("remove", dev);
-#endif
-
 	list_del_init(&dev->node);
 
+	class_device_unregister(&dev->cdev);
+
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -718,6 +801,13 @@
 	input_class = class_simple_create(THIS_MODULE, "input");
 	if (IS_ERR(input_class))
 		return PTR_ERR(input_class);
+
+	retval = class_register(&input_device_class);
+	if (retval) {
+		class_simple_destroy(input_class);
+		return retval;
+	}
+
 	input_proc_init();
 	retval = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (retval) {
@@ -725,6 +815,7 @@
 		remove_proc_entry("devices", proc_bus_input_dir);
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
+		class_unregister(&input_device_class);
 		class_simple_destroy(input_class);
 		return retval;
 	}
@@ -735,6 +826,7 @@
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		unregister_chrdev(INPUT_MAJOR, "input");
+		class_unregister(&input_device_class);
 		class_simple_destroy(input_class);
 	}
 	return retval;
@@ -748,6 +840,7 @@
 
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
+	class_unregister(&input_device_class);
 	class_simple_destroy(input_class);
 }
 
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2005-01-19 14:37:05 +01:00
+++ b/include/linux/input.h	2005-01-19 14:37:05 +01:00
@@ -12,6 +12,7 @@
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/device.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
@@ -855,6 +856,7 @@
 
 	struct input_handle *grab;
 	struct device *dev;
+	struct class_device cdev;
 
 	struct list_head	h_list;
 	struct list_head	node;

--------------030607070206000700000803--
