Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTE1Auz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTE1Auz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:50:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:59874 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264467AbTE1Auj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:50:39 -0400
Date: Tue, 27 May 2003 18:04:51 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: mochel@osdl.org, greg@kroah.com, hannal@us.ibm.com
Subject: [RFT/C 2.5.70] Input class hook up to driver model/sysfs 
Message-ID: <175110000.1054083891@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did this once before but due to some infrastructure changes 
it had to be written again. Here it is, pretty simple. Now
you can see your input devices (except keyboard) listed under
/sys/class/input like this (yes, I do have two mice attached).
At the moment the dev file is created and it contains the
hex value of the major and minor number.

root@w-hlinder2 root]# tree /sys/class/input
/sys/class/input
|-- mouse0
|   `-- dev
`-- mouse1
    `-- dev

2 directories, 2 files
[root@w-hlinder2 root]# more /sys/class/input/mouse0/dev
0d20
[root@w-hlinder2 root]# more /sys/class/input/mouse1/dev
0d21
[root@w-hlinder2 root]# ls -al /dev/input/mouse0
crw-------    1 root     root      13,  32 Apr 11  2002 /dev/input/mouse0
[root@w-hlinder2 root]# ls -al /dev/input/mouse1
crw-------    1 root     root      13,  33 Apr 11  2002 /dev/input/mouse1


Please review the code and/or run with the code to let me know
the rest works as planned. Thanks.

Hanna Linder
hannal@us.ibm.com
IBM Linux Technology Center
------------

 drivers/input/evdev.c    |   20 ++++++++++---
 drivers/input/input.c    |   69 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/joydev.c   |   22 ++++++++++----
 drivers/input/mousedev.c |   29 +++++++++++++------
 drivers/input/tsdev.c    |   22 ++++++++++----
 include/linux/input.h    |   15 ++++++++++
 6 files changed, 151 insertions(+), 26 deletions(-)


diff -Nrup -Xdontdiff linux-2.5.70/drivers/input/evdev.c linux-input/drivers/input/evdev.c
--- linux-2.5.70/drivers/input/evdev.c	Mon May 26 18:00:45 2003
+++ linux-input/drivers/input/evdev.c	Tue May 27 17:51:40 2003
@@ -79,7 +79,7 @@ static int evdev_flush(struct file * fil
 
 static void evdev_free(struct evdev *evdev)
 {
-	devfs_remove("input/event%d", evdev->minor);
+	input_unregister_class_dev("input/event%d", evdev->minor);
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -94,8 +94,10 @@ static int evdev_release(struct inode * 
 	if (!--list->evdev->open) {
 		if (list->evdev->exist)
 			input_close_device(&list->evdev->handle);
-		else
+		else{
+			input_unregister_class_dev("input/event%d", list->evdev->minor);
 			evdev_free(list->evdev);
+		}
 	}
 
 	kfree(list);
@@ -374,6 +376,12 @@ static struct file_operations evdev_fops
 	.flush =	evdev_flush
 };
 
+static struct input_class_interface intf = {
+	.name = 	"input/event%d",
+	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
+	.minor_base = 	EVDEV_MINOR_BASE,
+};
+
 static struct input_handle *evdev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct evdev *evdev;
@@ -402,8 +410,8 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
+	intf.minor = minor;
+	input_register_class_dev(dev, &intf);
 
 	return &evdev->handle;
 }
@@ -417,8 +425,10 @@ static void evdev_disconnect(struct inpu
 	if (evdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&evdev->wait);
-	} else
+	} else {
+		input_unregister_class_dev("input/event%d", evdev->minor);
 		evdev_free(evdev);
+	}
 }
 
 static struct input_device_id evdev_ids[] = {
diff -Nrup -Xdontdiff linux-2.5.70/drivers/input/input.c linux-input/drivers/input/input.c
--- linux-2.5.70/drivers/input/input.c	Mon May 26 18:00:40 2003
+++ linux-input/drivers/input/input.c	Tue May 27 17:51:40 2003
@@ -33,6 +33,8 @@ EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
 EXPORT_SYMBOL(input_unregister_handler);
+EXPORT_SYMBOL(input_register_class_dev);
+EXPORT_SYMBOL(input_unregister_class_dev);
 EXPORT_SYMBOL(input_open_device);
 EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
@@ -661,6 +663,73 @@ struct class input_class = {
 	.name		= "input",
 };
 
+#define to_input_dev(d) container_of(d, struct input_dev, class_dev)
+
+static ssize_t show_dev (struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = to_input_dev(class_dev);
+	dev_t base;
+
+	base = MKDEV(INPUT_MAJOR, dev->minor);
+	return sprintf(buf, "%04x\n", base + 32);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+void input_register_class_dev(struct input_dev *dev, struct input_class_interface *intf)
+{
+	char sysfs_name[16];
+	int err;
+	char *input_name = NULL;
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, intf->minor_base + intf->minor), intf->mode, intf->name, intf->minor);
+
+	sprintf(sysfs_name, intf->name, intf->minor);
+
+	input_name = strchr(sysfs_name, '/');
+	if(input_name)
+		++input_name;
+	else
+		input_name = sysfs_name;
+	/* create a class device for this input_dev */
+	memset(&dev->class_dev, 0x00, sizeof(struct class_device));
+	dev->class_dev.class = &input_class;
+	snprintf(dev->class_dev.class_id, BUS_ID_SIZE, "%s", input_name);
+	err = class_device_register(&dev->class_dev);
+	if(err)
+		goto error;
+	class_device_create_file (&dev->class_dev, &class_device_attr_dev);
+	dev->minor = intf->minor;
+	list_add(&dev->class_dev.node, &input_dev_list);
+	return;
+error:
+	kfree(input_name);
+	kfree(&dev->class_dev);
+}
+
+void input_unregister_class_dev(char *name, unsigned minor)
+{
+	struct input_dev *dev = NULL;
+	struct list_head *tmp;
+	char tmp_name[DEVICE_NAME_SIZE];
+	int found = 0;
+
+	snprintf(tmp_name, DEVICE_NAME_SIZE, name, minor);
+	devfs_remove(tmp_name, minor);
+
+	list_for_each (tmp, &input_dev_list) {
+		dev = list_entry(tmp, struct input_dev, node);
+		if (dev->minor == minor) {
+			found = 1;
+			break;
+		}
+	}
+	if(found) {
+		list_del(&dev->class_dev.node);
+		class_device_unregister(&dev->class_dev);
+		kfree(dev);
+	}
+}	
+
 static int __init input_init(void)
 {
 	struct proc_dir_entry *entry;
diff -Nrup -Xdontdiff linux-2.5.70/drivers/input/joydev.c linux-input/drivers/input/joydev.c
--- linux-2.5.70/drivers/input/joydev.c	Mon May 26 18:00:40 2003
+++ linux-input/drivers/input/joydev.c	Tue May 27 17:51:40 2003
@@ -143,7 +143,7 @@ static int joydev_fasync(int fd, struct 
 
 static void joydev_free(struct joydev *joydev)
 {
-	devfs_remove("js%d", joydev->minor);
+	input_unregister_class_dev("js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
 	kfree(joydev);
 }
@@ -159,8 +159,10 @@ static int joydev_release(struct inode *
 	if (!--list->joydev->open) {
 		if (list->joydev->exist)
 			input_close_device(&list->joydev->handle);
-		else
+		else{
+			input_unregister_class_dev("js%d", list->joydev->minor);
 			joydev_free(list->joydev);
+		}
 	}
 
 	kfree(list);
@@ -375,6 +377,12 @@ static struct file_operations joydev_fop
 	.fasync =	joydev_fasync,
 };
 
+static struct input_class_interface intf = {
+	.name = 	"js%d",
+	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
+	.minor_base = 	JOYDEV_MINOR_BASE,
+};
+
 static struct input_handle *joydev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct joydev *joydev;
@@ -445,9 +453,9 @@ static struct input_handle *joydev_conne
 	}
 
 	joydev_table[minor] = joydev;
-	
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "js%d", minor);
+
+	intf.minor = minor;
+	input_register_class_dev(dev, &intf); 	
 
 	return &joydev->handle;
 }
@@ -460,8 +468,10 @@ static void joydev_disconnect(struct inp
 
 	if (joydev->open)
 		input_close_device(handle);	
-	else
+	else{
+		input_unregister_class_dev("js%d", joydev->minor);
 		joydev_free(joydev);
+	}
 }
 
 static struct input_device_id joydev_ids[] = {
diff -Nrup -Xdontdiff linux-2.5.70/drivers/input/mousedev.c linux-input/drivers/input/mousedev.c
--- linux-2.5.70/drivers/input/mousedev.c	Mon May 26 18:00:57 2003
+++ linux-input/drivers/input/mousedev.c	Tue May 27 17:51:40 2003
@@ -173,7 +173,7 @@ static int mousedev_fasync(int fd, struc
 
 static void mousedev_free(struct mousedev *mousedev)
 {
-	devfs_remove("input/mouse%d", mousedev->minor);
+	input_unregister_class_dev("input/mouse%d", mousedev->minor);
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -188,8 +188,10 @@ static int mixdev_release(void)
 		if (!mousedev->open) {
 			if (mousedev->exist)
 				input_close_device(&mousedev->handle);
-			else
+			else {
+				input_unregister_class_dev("input/mouse%d",mousedev->minor);
 				mousedev_free(mousedev);
+			}
 		}
 	}
 
@@ -211,8 +213,10 @@ static int mousedev_release(struct inode
 		if (!mousedev_mix.open) {
 			if (list->mousedev->exist)
 				input_close_device(&list->mousedev->handle);
-			else
+			else{
+				input_unregister_class_dev("input/mouse%d", list->mousedev->minor);
 				mousedev_free(list->mousedev);
+			}
 		}
 	}
 	
@@ -402,6 +406,12 @@ struct file_operations mousedev_fops = {
 	.fasync =	mousedev_fasync,
 };
 
+static struct input_class_interface intf = {
+	.name =		"mouse%d",
+	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
+	.minor_base = 	MOUSEDEV_MINOR_BASE,
+};
+
 static struct input_handle *mousedev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct mousedev *mousedev;
@@ -433,8 +443,8 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
+	intf.minor = minor;
+	input_register_class_dev(dev, &intf);
 
 	return &mousedev->handle;
 }
@@ -450,6 +460,7 @@ static void mousedev_disconnect(struct i
 	} else {
 		if (mousedev_mix.open)
 			input_close_device(handle);
+		input_unregister_class_dev("input/mouse%d",mousedev->minor);
 		mousedev_free(mousedev);
 	}
 }
@@ -496,6 +507,7 @@ static struct miscdevice psaux_mouse = {
 
 static int __init mousedev_init(void)
 {
+
 	input_register_handler(&mousedev_handler);
 
 	memset(&mousedev_mix, 0, sizeof(struct mousedev));
@@ -505,9 +517,8 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-
+	intf.minor = mousedev_mix.minor;
+	input_register_class_dev (mousedev_mix.handler.dev, &intf);
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
@@ -525,7 +536,7 @@ static void __exit mousedev_exit(void)
 	if (mousedev_mix.misc)
 		misc_deregister(&psaux_mouse);
 #endif
-	devfs_remove("input/mice");
+	input_unregister_class_dev("mouse%d", mousedev_mix.minor);
 	input_unregister_handler(&mousedev_handler);
 }
 
diff -Nrup -Xdontdiff linux-2.5.70/drivers/input/tsdev.c linux-input/drivers/input/tsdev.c
--- linux-2.5.70/drivers/input/tsdev.c	Mon May 26 18:00:59 2003
+++ linux-input/drivers/input/tsdev.c	Tue May 27 17:51:40 2003
@@ -118,7 +118,7 @@ static int tsdev_open(struct inode *inod
 
 static void tsdev_free(struct tsdev *tsdev)
 {
-	devfs_remove("input/ts%d", tsdev->minor);
+	input_unregister_class_dev("input/ts%d", tsdev->minor);
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -133,8 +133,10 @@ static int tsdev_release(struct inode *i
 	if (!--list->tsdev->open) {
 		if (list->tsdev->exist)
 			input_close_device(&list->tsdev->handle);
-		else
+		else{
+			input_unregister_class_dev("input/ts%d",list->tsdev->minor);
 			tsdev_free(list->tsdev);
+		}
 	}
 	kfree(list);
 	return 0;
@@ -298,6 +300,12 @@ static void tsdev_event(struct input_han
 	wake_up_interruptible(&tsdev->wait);
 }
 
+static struct input_class_interface intf = {
+	.name =		"input/ts%d", 
+	.mode = 	S_IFCHRIS | S_IRUGO | S_IWUSR,
+	.minor_base = 	TSDEV_MINOR_BASE,
+};
+
 static struct input_handle *tsdev_connect(struct input_handler *handler,
 					  struct input_dev *dev,
 					  struct input_device_id *id)
@@ -330,9 +338,9 @@ static struct input_handle *tsdev_connec
 	tsdev->handle.private = tsdev;
 
 	tsdev_table[minor] = tsdev;
-	
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
+
+	intf.minor = minor;
+	input_register_class_dev(dev, &intf);	
 
 	return &tsdev->handle;
 }
@@ -346,8 +354,10 @@ static void tsdev_disconnect(struct inpu
 	if (tsdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&tsdev->wait);
-	} else
+	} else {
+		input_unregister_class_dev("input/ts%d",tsdev->minor);
 		tsdev_free(tsdev);
+	}
 }
 
 static struct input_device_id tsdev_ids[] = {
diff -Nrup -Xdontdiff linux-2.5.70/include/linux/input.h linux-input/include/linux/input.h
--- linux-2.5.70/include/linux/input.h	Mon May 26 18:00:39 2003
+++ linux-input/include/linux/input.h	Tue May 27 17:51:41 2003
@@ -12,6 +12,7 @@
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/device.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
@@ -800,6 +801,9 @@ struct input_dev {
 
 	struct list_head	h_list;
 	struct list_head	node;
+
+	struct class_device class_dev;
+	unsigned minor;
 };
 
 /*
@@ -877,6 +881,14 @@ struct input_handle {
 	struct list_head	h_node;
 };
 
+struct input_class_interface {
+
+	char *name;
+	mode_t mode;
+	unsigned minor;
+	int minor_base; 
+};
+
 #define to_dev(n) container_of(n,struct input_dev,node)
 #define to_handler(n) container_of(n,struct input_handler,node);
 #define to_handle(n) container_of(n,struct input_handle,d_node)
@@ -888,6 +900,9 @@ void input_unregister_device(struct inpu
 void input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
 
+void input_register_class_dev(struct input_dev *, struct input_class_interface *);
+void input_unregister_class_dev(char *, unsigned );
+
 int input_open_device(struct input_handle *);
 void input_close_device(struct input_handle *);
 



