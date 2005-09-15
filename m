Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbVIOHFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVIOHFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVIOHEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:20 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:55127 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030451AbVIOHEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:16 -0400
Message-Id: <20050915070305.448929000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 25/28] input core: implement class hierachy
Content-Disposition: inline; filename=input-subclass.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: create 'input' class hierarchy

Make 'input' a root class and add 'devices' and 'interfaces'
subclasses. 'devices' subclass will contain input_dev class
devices whereas 'interfaces' will have devices created by
input handlers, such as evdev, mousedev, etc.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c    |   12 +--
 drivers/input/input.c    |  178 +++++++++++++++++++++++++++++++++--------------
 drivers/input/joydev.c   |   12 +--
 drivers/input/mousedev.c |   70 +++++++++---------
 drivers/input/tsdev.c    |   23 ++----
 include/linux/input.h    |    9 +-
 6 files changed, 188 insertions(+), 116 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -32,6 +32,8 @@ EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
 EXPORT_SYMBOL(input_unregister_handler);
+EXPORT_SYMBOL(input_create_interface_device);
+EXPORT_SYMBOL(input_destroy_interface_device);
 EXPORT_SYMBOL(input_grab_device);
 EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
@@ -39,10 +41,14 @@ EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
-EXPORT_SYMBOL(input_class);
+EXPORT_SYMBOL(input_interface_class);
 
 #define INPUT_DEVICES	256
 
+static struct class input_class = {
+	.name	= "input",
+};
+
 static LIST_HEAD(input_dev_list);
 static LIST_HEAD(input_handler_list);
 
@@ -496,7 +502,7 @@ static int input_devices_read(char *buf,
 
 	list_for_each_entry(dev, &input_dev_list, node) {
 
-		path = dev->dynalloc ? kobject_get_path(&dev->cdev.kobj, GFP_KERNEL) : NULL;
+		path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
 
 		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
 			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
@@ -725,7 +731,8 @@ static void input_dev_release(struct cla
 }
 
 static struct class input_dev_class = {
-	.name			= "input_dev",
+	.name			= "devices",
+	.parent			= &input_class,
 	.release		= input_dev_release,
 	.class_dev_attrs	= input_dev_attrs,
 };
@@ -737,8 +744,6 @@ struct input_dev *input_allocate_device(
 	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
 	if (dev) {
 		dev->dynalloc = 1;
-		dev->cdev.class = &input_dev_class;
-		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
 	}
@@ -746,38 +751,24 @@ struct input_dev *input_allocate_device(
 	return dev;
 }
 
-static void input_register_classdevice(struct input_dev *dev)
+int input_register_device(struct input_dev *dev)
 {
 	static atomic_t input_no = ATOMIC_INIT(0);
-	const char *path;
-
-	__module_get(THIS_MODULE);
-
-	dev->dev = dev->cdev.dev;
-
-	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
-		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
-
-	path = kobject_get_path(&dev->cdev.class->subsys.kset.kobj, GFP_KERNEL);
-	printk(KERN_INFO "input: %s/%s as %s\n",
-		dev->name ? dev->name : "Unspecified device",
-		path ? path : "", dev->cdev.class_id);
-	kfree(path);
-
-	class_device_add(&dev->cdev);
-	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
-	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
-}
-
-void input_register_device(struct input_dev *dev)
-{
 	struct input_handle *handle;
 	struct input_handler *handler;
 	struct input_device_id *id;
+	const char *path;
+	int error;
 
-	set_bit(EV_SYN, dev->evbit);
+	if (!dev->dynalloc) {
+		printk(KERN_WARNING "input: device %s is statically allocated, will not register\n"
+			"Please convert to input_allocate_device() or contact dtor_core@ameritech.net\n",
+			dev->name ? dev->name : "<Unknown>");
+		return -EINVAL;
+	}
 
 	init_MUTEX(&dev->sem);
+	set_bit(EV_SYN, dev->evbit);
 
 	/*
 	 * If delay and period are pre-set by the driver, then autorepeating
@@ -801,23 +792,46 @@ void input_register_device(struct input_
 				if ((handle = handler->connect(handler, dev, id)))
 					input_link_handle(handle);
 
+	dev->cdev.class = &input_dev_class;
+	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
+		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
 
-	if (dev->dynalloc)
-		input_register_classdevice(dev);
+	error = class_device_register(&dev->cdev);
+	if (error)
+		return error;
+
+	error = sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	if (error)
+		goto fail1;
+
+	error = sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+	if (error)
+		goto fail2;
+
+	path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
+	printk(KERN_INFO "input: %s as %s\n",
+		dev->name ? dev->name : "Unspecified device", path ? path : "N/A");
+	kfree(path);
 
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
 #endif
 
 	input_wakeup_procfs_readers();
+
+	__module_get(THIS_MODULE);
+
+	return 0;
+
+ fail2:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+ fail1:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	return error;
 }
 
 void input_unregister_device(struct input_dev *dev)
 {
 	struct list_head * node, * next;
 
-	if (!dev) return;
-
 	del_timer_sync(&dev->timer);
 
 	list_for_each_safe(node, next, &dev->h_list) {
@@ -833,11 +847,9 @@ void input_unregister_device(struct inpu
 
 	list_del_init(&dev->node);
 
-	if (dev->dynalloc) {
-		sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
-		sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
-		class_device_unregister(&dev->cdev);
-	}
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	class_device_unregister(&dev->cdev);
 
 	input_wakeup_procfs_readers();
 }
@@ -885,6 +897,63 @@ void input_unregister_handler(struct inp
 	input_wakeup_procfs_readers();
 }
 
+
+static void input_interface_dev_release(struct class_device *class_dev)
+{
+	kfree(class_dev);
+	module_put(THIS_MODULE);
+}
+
+struct class input_interface_class = {
+	.name			= "interfaces",
+	.parent			= &input_class,
+	.release		= input_interface_dev_release,
+};
+
+int input_create_interface_device(struct input_handle *handle, dev_t devt)
+{
+	struct class_device *dev;
+	int error;
+
+	dev = kzalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->devt = devt;
+	dev->class = &input_interface_class;
+	strlcpy(dev->class_id, handle->name, BUS_ID_SIZE);
+
+	error = class_device_register(dev);
+	if (error)
+		return error;
+
+	if (handle->dev) {
+		sysfs_create_link(&dev->kobj, &handle->dev->cdev.kobj, "device");
+		sysfs_create_link(&handle->dev->cdev.kobj, &dev->kobj,
+				  kobject_name(&dev->kobj));
+	}
+
+	handle->intf_dev = dev;
+
+	__module_get(THIS_MODULE);
+
+	return 0;
+}
+
+void input_destroy_interface_device(struct input_handle *handle)
+{
+	if (handle->intf_dev) {
+		if (handle->dev) {
+			sysfs_remove_link(&handle->dev->cdev.kobj,
+					  kobject_name(&handle->intf_dev->kobj));
+			sysfs_remove_link(&handle->intf_dev->kobj, "device");
+		}
+
+		class_device_unregister(handle->intf_dev);
+		handle->intf_dev = NULL;
+	}
+}
+
 static int input_open_file(struct inode *inode, struct file *file)
 {
 	struct input_handler *handler = input_table[iminor(inode) >> 5];
@@ -921,40 +990,44 @@ static struct file_operations input_fops
 	.open = input_open_file,
 };
 
-struct class *input_class;
-
 static int __init input_init(void)
 {
 	int err;
 
-	err = class_register(&input_dev_class);
+	err = class_register(&input_class);
 	if (err) {
-		printk(KERN_ERR "input: unable to register input_dev class\n");
+		printk(KERN_ERR "input: unable to register input class\n");
 		return err;
 	}
 
-	input_class = class_create(THIS_MODULE, "input");
-	if (IS_ERR(input_class)) {
-		printk(KERN_ERR "input: unable to register input class\n");
-		err = PTR_ERR(input_class);
+	err = class_register(&input_dev_class);
+	if (err) {
+		printk(KERN_ERR "input: unable to register device class\n");
 		goto fail1;
 	}
 
+	err = class_register(&input_interface_class);
+	if (err) {
+		printk(KERN_ERR "input: unable to register handler class\n");
+		goto fail2;
+	}
+
 	err = input_proc_init();
 	if (err)
-		goto fail2;
+		goto fail3;
 
 	err = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (err) {
 		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
-		goto fail3;
+		goto fail4;
 	}
 
 	return 0;
 
- fail3:	input_proc_exit();
- fail2:	class_destroy(input_class);
- fail1:	class_unregister(&input_dev_class);
+ fail4:	input_proc_exit();
+ fail3:	class_unregister(&input_interface_class);
+ fail2:	class_unregister(&input_dev_class);
+ fail1:	class_unregister(&input_class);
 	return err;
 }
 
@@ -962,8 +1035,9 @@ static void __exit input_exit(void)
 {
 	input_proc_exit();
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_destroy(input_class);
+	class_unregister(&input_interface_class);
 	class_unregister(&input_dev_class);
+	class_unregister(&input_class);
 }
 
 subsys_initcall(input_init);
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -891,7 +891,6 @@ struct input_dev {
 	unsigned int users;
 
 	struct class_device cdev;
-	struct device *dev;	/* will be removed soon */
 
 	int dynalloc;	/* temporarily */
 
@@ -970,6 +969,7 @@ struct input_handle {
 
 	int open;
 	char *name;
+	struct class_device *intf_dev;
 
 	struct input_dev *dev;
 	struct input_handler *handler;
@@ -1006,12 +1006,15 @@ static inline void input_put_device(stru
 	class_device_put(&dev->cdev);
 }
 
-void input_register_device(struct input_dev *);
+int input_register_device(struct input_dev *);
 void input_unregister_device(struct input_dev *);
 
 void input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
 
+int input_create_interface_device(struct input_handle *, dev_t);
+void input_destroy_interface_device(struct input_handle *);
+
 int input_grab_device(struct input_handle *);
 void input_release_device(struct input_handle *);
 
@@ -1074,7 +1077,7 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class *input_class;
+extern struct class input_interface_class;
 
 #endif
 #endif
Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -669,9 +669,9 @@ static struct input_handle *evdev_connec
 		return NULL;
 	}
 
-	if (!(evdev = kmalloc(sizeof(struct evdev), GFP_KERNEL)))
+	evdev = kzalloc(sizeof(struct evdev), GFP_KERNEL);
+	if (!evdev)
 		return NULL;
-	memset(evdev, 0, sizeof(struct evdev));
 
 	INIT_LIST_HEAD(&evdev->list);
 	init_waitqueue_head(&evdev->wait);
@@ -686,9 +686,8 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(input_class,
-			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			dev->dev, "event%d", minor);
+	input_create_interface_device(&evdev->handle,
+				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor));
 
 	return &evdev->handle;
 }
@@ -698,8 +697,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_device_destroy(input_class,
-			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	input_destroy_interface_device(handle);
 	evdev->exist = 0;
 
 	if (evdev->open) {
Index: work/drivers/input/joydev.c
===================================================================
--- work.orig/drivers/input/joydev.c
+++ work/drivers/input/joydev.c
@@ -456,9 +456,9 @@ static struct input_handle *joydev_conne
 		return NULL;
 	}
 
-	if (!(joydev = kmalloc(sizeof(struct joydev), GFP_KERNEL)))
+	joydev = kmalloc(sizeof(struct joydev), GFP_KERNEL);
+	if (!joydev)
 		return NULL;
-	memset(joydev, 0, sizeof(struct joydev));
 
 	INIT_LIST_HEAD(&joydev->list);
 	init_waitqueue_head(&joydev->wait);
@@ -513,10 +513,8 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	class_device_create(input_class,
-			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			dev->dev, "js%d", minor);
-
+	input_create_interface_device(&joydev->handle,
+				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor));
 	return &joydev->handle;
 }
 
@@ -525,7 +523,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	input_destroy_interface_device(handle);
 	joydev->exist = 0;
 
 	if (joydev->open) {
Index: work/drivers/input/mousedev.c
===================================================================
--- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
@@ -202,7 +202,7 @@ static void mousedev_key_event(struct mo
 		case BTN_SIDE:		index = 3; break;
 		case BTN_4:
 		case BTN_EXTRA:		index = 4; break;
-		default: 		return;
+		default:		return;
 	}
 
 	if (value) {
@@ -327,7 +327,7 @@ static void mousedev_event(struct input_
 					mousedev->pkt_count++;
 					/* Input system eats duplicate events, but we need all of them
 					 * to do correct averaging so apply present one forward
-			 		 */
+					 */
 					fx(0) = fx(1);
 					fy(0) = fy(1);
 				}
@@ -617,6 +617,33 @@ static struct file_operations mousedev_f
 	.fasync =	mousedev_fasync,
 };
 
+
+static void mousedev_init_mousedev(struct mousedev *mousedev, struct input_handler *handler,
+				   struct input_dev *dev, int minor)
+{
+	memset(mousedev, 0, sizeof(struct mousedev));
+
+	INIT_LIST_HEAD(&mousedev->list);
+	init_waitqueue_head(&mousedev->wait);
+
+	if (minor == MOUSEDEV_MIX)
+		strcpy(mousedev->name, "mice");
+	else
+		sprintf(mousedev->name, "mouse%d", minor);
+
+	mousedev->minor = minor;
+	mousedev->exist = 1;
+	mousedev->handle.dev = dev;
+	mousedev->handle.name = mousedev->name;
+	mousedev->handle.handler = handler;
+	mousedev->handle.private = mousedev;
+
+	mousedev_table[minor] = mousedev;
+
+	input_create_interface_device(&mousedev->handle,
+				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor));
+}
+
 static struct input_handle *mousedev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
 {
 	struct mousedev *mousedev;
@@ -628,30 +655,15 @@ static struct input_handle *mousedev_con
 		return NULL;
 	}
 
-	if (!(mousedev = kmalloc(sizeof(struct mousedev), GFP_KERNEL)))
+	mousedev = kmalloc(sizeof(struct mousedev), GFP_KERNEL);
+	if (!mousedev)
 		return NULL;
-	memset(mousedev, 0, sizeof(struct mousedev));
 
-	INIT_LIST_HEAD(&mousedev->list);
-	init_waitqueue_head(&mousedev->wait);
-
-	mousedev->minor = minor;
-	mousedev->exist = 1;
-	mousedev->handle.dev = dev;
-	mousedev->handle.name = mousedev->name;
-	mousedev->handle.handler = handler;
-	mousedev->handle.private = mousedev;
-	sprintf(mousedev->name, "mouse%d", minor);
+	mousedev_init_mousedev(mousedev, handler, dev, minor);
 
 	if (mousedev_mix.open)
 		input_open_device(&mousedev->handle);
 
-	mousedev_table[minor] = mousedev;
-
-	class_device_create(input_class,
-			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			dev->dev, "mouse%d", minor);
-
 	return &mousedev->handle;
 }
 
@@ -660,8 +672,7 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_device_destroy(input_class,
-			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	input_destroy_interface_device(handle);
 	mousedev->exist = 0;
 
 	if (mousedev->open) {
@@ -701,7 +712,7 @@ static struct input_device_id mousedev_i
 		.absbit = { BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_TOOL_WIDTH) },
 	},	/* A touchpad */
 
-	{ }, 	/* Terminating entry */
+	{ },	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(input, mousedev_ids);
@@ -727,15 +738,7 @@ static int __init mousedev_init(void)
 {
 	input_register_handler(&mousedev_handler);
 
-	memset(&mousedev_mix, 0, sizeof(struct mousedev));
-	INIT_LIST_HEAD(&mousedev_mix.list);
-	init_waitqueue_head(&mousedev_mix.wait);
-	mousedev_table[MOUSEDEV_MIX] = &mousedev_mix;
-	mousedev_mix.exist = 1;
-	mousedev_mix.minor = MOUSEDEV_MIX;
-
-	class_device_create(input_class,
-			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
+	mousedev_init_mousedev(&mousedev_mix, &mousedev_handler, NULL, MOUSEDEV_MIX);
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(psaux_registered = !misc_register(&psaux_mouse)))
@@ -753,8 +756,7 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	class_device_destroy(input_class,
-			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
+	input_destroy_interface_device(&mousedev_mix.handle);
 	input_unregister_handler(&mousedev_handler);
 }
 
Index: work/drivers/input/tsdev.c
===================================================================
--- work.orig/drivers/input/tsdev.c
+++ work/drivers/input/tsdev.c
@@ -35,7 +35,7 @@
  * e-mail - mail your message to <jsimmons@infradead.org>.
  */
 
-#define TSDEV_MINOR_BASE 	128
+#define TSDEV_MINOR_BASE	128
 #define TSDEV_MINORS		32
 /* First 16 devices are h3600_ts compatible; second 16 are h3600_tsraw */
 #define TSDEV_MINOR_MASK	15
@@ -378,9 +378,9 @@ static struct input_handle *tsdev_connec
 		return NULL;
 	}
 
-	if (!(tsdev = kmalloc(sizeof(struct tsdev), GFP_KERNEL)))
+	tsdev = kzalloc(sizeof(struct tsdev), GFP_KERNEL);
+	if (!tsdev)
 		return NULL;
-	memset(tsdev, 0, sizeof(struct tsdev));
 
 	INIT_LIST_HEAD(&tsdev->list);
 	init_waitqueue_head(&tsdev->wait);
@@ -395,24 +395,22 @@ static struct input_handle *tsdev_connec
 	tsdev->handle.private = tsdev;
 
 	/* Precompute the rough calibration matrix */
-	delta = dev->absmax [ABS_X] - dev->absmin [ABS_X] + 1;
+	delta = dev->absmax[ABS_X] - dev->absmin[ABS_X] + 1;
 	if (delta == 0)
 		delta = 1;
 	tsdev->cal.xscale = (xres << 8) / delta;
-	tsdev->cal.xtrans = - ((dev->absmin [ABS_X] * tsdev->cal.xscale) >> 8);
+	tsdev->cal.xtrans = - ((dev->absmin[ABS_X] * tsdev->cal.xscale) >> 8);
 
-	delta = dev->absmax [ABS_Y] - dev->absmin [ABS_Y] + 1;
+	delta = dev->absmax[ABS_Y] - dev->absmin[ABS_Y] + 1;
 	if (delta == 0)
 		delta = 1;
 	tsdev->cal.yscale = (yres << 8) / delta;
-	tsdev->cal.ytrans = - ((dev->absmin [ABS_Y] * tsdev->cal.yscale) >> 8);
+	tsdev->cal.ytrans = - ((dev->absmin[ABS_Y] * tsdev->cal.yscale) >> 8);
 
 	tsdev_table[minor] = tsdev;
 
-	class_device_create(input_class,
-			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			dev->dev, "ts%d", minor);
-
+	input_create_interface_device(&tsdev->handle,
+				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor));
 	return &tsdev->handle;
 }
 
@@ -421,8 +419,7 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_device_destroy(input_class,
-			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	input_destroy_interface_device(handle);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {

