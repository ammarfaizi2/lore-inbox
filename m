Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVIOGzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVIOGzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVIOGxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:53:48 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:17841 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030378AbVIOGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:43 -0400
Message-Id: <20050915064943.737442000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 08/28] Input: prepare to sysfs integration
Content-Disposition: inline; filename=input-dynalloc-prepare.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: prepare to sysfs integration

Add struct class_device to input_dev; add input_allocate_dev()
to dynamically allocate input devices; dynamically allocated
devices are automatically registered with sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/input.h |   24 ++++++++++++++-
 2 files changed, 95 insertions(+), 6 deletions(-)

Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -12,6 +12,7 @@
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/device.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
@@ -889,11 +890,15 @@ struct input_dev {
 	struct semaphore sem;	/* serializes open and close operations */
 	unsigned int users;
 
-	struct device *dev;
+	struct class_device cdev;
+	struct device *dev;	/* will be removed soon */
+
+	int dynalloc;	/* temporarily */
 
 	struct list_head	h_list;
 	struct list_head	node;
 };
+#define to_input_dev(d) container_of(d, struct input_dev, cdev)
 
 /*
  * Structure for hotplug & device<->driver matching.
@@ -984,6 +989,23 @@ static inline void init_input_dev(struct
 	INIT_LIST_HEAD(&dev->node);
 }
 
+struct input_dev *input_allocate_device(void);
+
+static inline void input_free_device(struct input_dev *dev)
+{
+	kfree(dev);
+}
+
+static inline struct input_dev *input_get_device(struct input_dev *dev)
+{
+	return to_input_dev(class_device_get(&dev->cdev));
+}
+
+static inline void input_put_device(struct input_dev *dev)
+{
+	class_device_put(&dev->cdev);
+}
+
 void input_register_device(struct input_dev *);
 void input_unregister_device(struct input_dev *);
 
Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -27,6 +27,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@s
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL(input_allocate_device);
 EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
@@ -604,6 +605,56 @@ static inline int input_proc_init(void) 
 static inline void input_proc_exit(void) { }
 #endif
 
+static void input_dev_release(struct class_device *class_dev)
+{
+	struct input_dev *dev = to_input_dev(class_dev);
+
+	kfree(dev);
+	module_put(THIS_MODULE);
+}
+
+static struct class input_dev_class = {
+	.name			= "input_dev",
+	.release		= input_dev_release,
+};
+
+struct input_dev *input_allocate_device(void)
+{
+	struct input_dev *dev;
+
+	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
+	if (dev) {
+		dev->dynalloc = 1;
+		dev->cdev.class = &input_dev_class;
+		class_device_initialize(&dev->cdev);
+		INIT_LIST_HEAD(&dev->h_list);
+		INIT_LIST_HEAD(&dev->node);
+	}
+
+	return dev;
+}
+
+static void input_register_classdevice(struct input_dev *dev)
+{
+	static atomic_t input_no = ATOMIC_INIT(0);
+	const char *path;
+
+	__module_get(THIS_MODULE);
+
+	dev->dev = dev->cdev.dev;
+
+	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
+		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
+
+	path = kobject_get_path(&dev->cdev.class->subsys.kset.kobj, GFP_KERNEL);
+	printk(KERN_INFO "input: %s/%s as %s\n",
+		dev->name ? dev->name : "Unspecified device",
+		path ? path : "", dev->cdev.class_id);
+	kfree(path);
+
+	class_device_add(&dev->cdev);
+}
+
 void input_register_device(struct input_dev *dev)
 {
 	struct input_handle *handle;
@@ -636,6 +687,10 @@ void input_register_device(struct input_
 				if ((handle = handler->connect(handler, dev, id)))
 					input_link_handle(handle);
 
+
+	if (dev->dynalloc)
+		input_register_classdevice(dev);
+
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
 #endif
@@ -664,6 +719,9 @@ void input_unregister_device(struct inpu
 
 	list_del_init(&dev->node);
 
+	if (dev->dynalloc)
+		class_device_unregister(&dev->cdev);
+
 	input_wakeup_procfs_readers();
 }
 
@@ -752,26 +810,34 @@ static int __init input_init(void)
 {
 	int err;
 
+	err = class_register(&input_dev_class);
+	if (err) {
+		printk(KERN_ERR "input: unable to register input_dev class\n");
+		return err;
+	}
+
 	input_class = class_create(THIS_MODULE, "input");
 	if (IS_ERR(input_class)) {
 		printk(KERN_ERR "input: unable to register input class\n");
-		return PTR_ERR(input_class);
+		err = PTR_ERR(input_class);
+		goto fail1;
 	}
 
 	err = input_proc_init();
 	if (err)
-		goto fail1;
+		goto fail2;
 
 	err = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (err) {
 		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
-		goto fail2;
+		goto fail3;
 	}
 
 	return 0;
 
- fail2:	input_proc_exit();
- fail1:	class_destroy(input_class);
+ fail3:	input_proc_exit();
+ fail2:	class_destroy(input_class);
+ fail1:	class_unregister(&input_dev_class);
 	return err;
 }
 
@@ -780,6 +846,7 @@ static void __exit input_exit(void)
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_destroy(input_class);
+	class_unregister(&input_dev_class);
 }
 
 subsys_initcall(input_init);

