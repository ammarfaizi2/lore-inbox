Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVBEVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVBEVvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbVBEVvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:51:39 -0500
Received: from soundwarez.org ([217.160.171.123]:12259 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S265612AbVBEVt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:49:56 -0500
Date: Sat, 5 Feb 2005 22:49:52 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] driver core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050205214952.GA17499@vrfy.org>
References: <20050123041911.GA9209@vrfy.org> <20050201225625.GA14962@kroah.com> <20050202004812.GA29888@vrfy.org> <20050205061636.GA1185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205061636.GA1185@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:16:36PM -0800, Greg KH wrote:
> On Wed, Feb 02, 2005 at 01:48:12AM +0100, Kay Sievers wrote:
> > On Tue, Feb 01, 2005 at 02:56:25PM -0800, Greg KH wrote:
> > > Hm, that class_simple interface is looking like the way we should move
> > > toward, as it's "simple" to use, instead of the more complex class code.
> > > I'll have to look at migrating more code to use it over time, or move
> > > that interface back into the class code itself...
> > 
> > Nice idea! What about keeping a list of devices belonging to a
> > specific class in an own list in 'struct class' and maintaining that list
> > with class_device_add(), class_device_del()?
> 
> What would that help out with?
> 
> > A class driver may use that list to keep track of its own devices if
> > wanted and class_simple would not be needed anymore as everything
> > would be available in the core.
> 
> I must be tired, but I don't see how class_simple could be dropped if
> that was done.  Care to explain it with pseudo-code or something?

Sure, here is a patch for illustration. The needed class_simple logic
is moved to the core. It uses the class's children list to keep track of
the created devices. The tty and the input layer are changed to use the
new interface.

With this change, a driver still has the convenient class support without
the need to care about allocation and release functions. But it uses the
same data structures like a full featured class implementation.

Thanks,
Kay


===== drivers/base/class.c 1.58 vs edited =====
--- 1.58/drivers/base/class.c	2005-02-05 19:35:12 +01:00
+++ edited/drivers/base/class.c	2005-02-05 22:23:45 +01:00
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/err.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -161,6 +162,52 @@ void class_unregister(struct class * cls
 	subsystem_unregister(&cls->subsys);
 }
 
+static void class_create_release(struct class *cls)
+{
+	kfree(cls);
+}
+
+static void class_device_create_release(struct class_device *class_dev)
+{
+	kfree(class_dev);
+}
+
+struct class *class_create(char *name)
+{
+	struct class *cls;
+	int retval;
+
+	cls = kmalloc(sizeof(struct class), GFP_KERNEL);
+	if (!cls) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(cls, 0x00, sizeof(struct class));
+
+	cls->name = name;
+	cls->class_release = class_create_release;
+	cls->release = class_device_create_release;
+
+	retval = class_register(cls);
+	if (retval)
+		goto error;
+
+	return cls;
+
+error:
+	kfree(cls);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL_GPL(class_create);
+
+void class_destroy(struct class *cls)
+{
+	if ((cls == NULL) || (IS_ERR(cls)))
+		return;
+
+	class_unregister(cls);
+}
+EXPORT_SYMBOL_GPL(class_destroy);
 
 /* Class Device Stuff */
 
@@ -468,6 +515,42 @@ int class_device_register(struct class_d
 	return class_device_add(class_dev);
 }
 
+struct class_device *class_device_create(struct class *cls, dev_t devt,
+					 struct device *device, char *fmt, ...)
+{
+	va_list args;
+	struct class_device *class_dev;
+	int retval;
+
+	if (cls == NULL || IS_ERR(cls))
+		return ERR_PTR(-ENODEV);
+
+	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!class_dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(class_dev, 0x00, sizeof(struct class_device));
+
+	class_dev->devt = devt;
+	class_dev->dev = device;
+	class_dev->class = cls;
+
+	va_start(args, fmt);
+	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
+	va_end(args);
+	retval = class_device_register(class_dev);
+	if (retval)
+		goto error;
+
+	return 0;
+
+error:
+	kfree(class_dev);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL_GPL(class_device_create);
+
 void class_device_del(struct class_device *class_dev)
 {
 	struct class * parent = class_dev->class;
@@ -499,6 +582,25 @@ void class_device_unregister(struct clas
 	class_device_del(class_dev);
 	class_device_put(class_dev);
 }
+
+void class_device_destroy(struct class *cls, dev_t devt)
+{
+	struct class_device *class_dev = NULL;
+	struct class_device *class_dev_tmp;
+
+	down_write(&cls->subsys.rwsem);
+	list_for_each_entry(class_dev_tmp, &cls->children, node) {
+		if (class_dev_tmp->devt == devt) {
+			class_dev = class_dev_tmp;
+			break;
+		}
+	}
+	up_write(&cls->subsys.rwsem);
+
+	if (class_dev)
+		class_device_unregister(class_dev);
+}
+EXPORT_SYMBOL_GPL(class_device_destroy);
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
===== drivers/char/tty_io.c 1.159 vs edited =====
--- 1.159/drivers/char/tty_io.c	2005-01-31 07:33:45 +01:00
+++ edited/drivers/char/tty_io.c	2005-02-05 21:50:52 +01:00
@@ -2650,7 +2650,7 @@ static void tty_default_put_char(struct 
 	tty->driver->write(tty, &ch, 1);
 }
 
-static struct class_simple *tty_class;
+static struct class *tty_class;
 
 /**
  * tty_register_device - register a tty device
@@ -2683,7 +2683,7 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_simple_device_add(tty_class, dev, device, name);
+	class_device_create(tty_class, dev, device, name);
 }
 
 /**
@@ -2697,7 +2697,7 @@ void tty_register_device(struct tty_driv
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
-	class_simple_device_remove(MKDEV(driver->major, driver->minor_start) + index);
+	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2914,7 +2914,7 @@ extern int vty_init(void);
 
 static int __init tty_class_init(void)
 {
-	tty_class = class_simple_create(THIS_MODULE, "tty");
+	tty_class = class_create("tty");
 	if (IS_ERR(tty_class))
 		return PTR_ERR(tty_class);
 	return 0;
@@ -2943,14 +2943,14 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
@@ -2958,7 +2958,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 
 #ifdef CONFIG_VT
@@ -2967,7 +2967,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
 #endif
===== drivers/input/evdev.c 1.42 vs edited =====
--- 1.42/drivers/input/evdev.c	2004-12-27 10:21:12 +01:00
+++ edited/drivers/input/evdev.c	2005-02-05 22:13:55 +01:00
@@ -428,9 +428,9 @@ static struct input_handle *evdev_connec
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-				dev->dev, "event%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
+			dev->dev, "event%d", minor);
 
 	return &evdev->handle;
 }
@@ -439,7 +439,8 @@ static void evdev_disconnect(struct inpu
 {
 	struct evdev *evdev = handle->private;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
===== drivers/input/input.c 1.49 vs edited =====
--- 1.49/drivers/input/input.c	2005-01-15 23:31:06 +01:00
+++ edited/drivers/input/input.c	2005-02-05 22:19:20 +01:00
@@ -709,13 +709,13 @@ static int __init input_proc_init(void)
 static inline int input_proc_init(void) { return 0; }
 #endif
 
-struct class_simple *input_class;
+struct class *input_class;
 
 static int __init input_init(void)
 {
 	int retval = -ENOMEM;
 
-	input_class = class_simple_create(THIS_MODULE, "input");
+	input_class = class_create("input");
 	if (IS_ERR(input_class))
 		return PTR_ERR(input_class);
 	input_proc_init();
@@ -725,7 +725,7 @@ static int __init input_init(void)
 		remove_proc_entry("devices", proc_bus_input_dir);
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 		return retval;
 	}
 
@@ -735,7 +735,7 @@ static int __init input_init(void)
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		unregister_chrdev(INPUT_MAJOR, "input");
-		class_simple_destroy(input_class);
+		class_destroy(input_class);
 	}
 	return retval;
 }
@@ -748,7 +748,7 @@ static void __exit input_exit(void)
 
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
-	class_simple_destroy(input_class);
+	class_destroy(input_class);
 }
 
 subsys_initcall(input_init);
===== drivers/input/joydev.c 1.28 vs edited =====
--- 1.28/drivers/input/joydev.c	2004-12-27 10:21:12 +01:00
+++ edited/drivers/input/joydev.c	2005-02-05 22:14:57 +01:00
@@ -453,9 +453,9 @@ static struct input_handle *joydev_conne
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-				dev->dev, "js%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
+			dev->dev, "js%d", minor);
 
 	return &joydev->handle;
 }
@@ -464,7 +464,7 @@ static void joydev_disconnect(struct inp
 {
 	struct joydev *joydev = handle->private;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
===== drivers/input/mousedev.c 1.46 vs edited =====
--- 1.46/drivers/input/mousedev.c	2004-12-27 10:21:12 +01:00
+++ edited/drivers/input/mousedev.c	2005-02-05 22:20:07 +01:00
@@ -633,9 +633,9 @@ static struct input_handle *mousedev_con
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-				dev->dev, "mouse%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
+			dev->dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -644,7 +644,8 @@ static void mousedev_disconnect(struct i
 {
 	struct mousedev *mousedev = handle->private;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
@@ -717,8 +718,8 @@ static int __init mousedev_init(void)
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-	class_simple_device_add(input_class, MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-				NULL, "mice");
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(psaux_registered = !misc_register(&psaux_mouse)))
@@ -737,7 +738,8 @@ static void __exit mousedev_exit(void)
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
 
===== drivers/input/tsdev.c 1.20 vs edited =====
--- 1.20/drivers/input/tsdev.c	2004-12-27 10:21:12 +01:00
+++ edited/drivers/input/tsdev.c	2005-02-05 22:15:43 +01:00
@@ -416,9 +416,9 @@ static struct input_handle *tsdev_connec
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
-	class_simple_device_add(input_class,
-				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-				dev->dev, "ts%d", minor);
+	class_device_create(input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
+			dev->dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
@@ -427,7 +427,8 @@ static void tsdev_disconnect(struct inpu
 {
 	struct tsdev *tsdev = handle->private;
 
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	class_device_destroy(input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	devfs_remove("input/ts%d", tsdev->minor);
 	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
===== include/linux/device.h 1.136 vs edited =====
--- 1.136/include/linux/device.h	2005-02-05 19:35:12 +01:00
+++ edited/include/linux/device.h	2005-02-05 21:23:36 +01:00
@@ -245,6 +245,12 @@ struct class_interface {
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
+extern struct class *class_create(char *name);
+extern void class_destroy(struct class *cls);
+extern struct class_device *class_device_create(struct class *cls, dev_t devt,
+						struct device *device, char *fmt, ...);
+extern void class_device_destroy(struct class *cls, dev_t devt);
+
 /* interface for class simple stuff */
 extern struct class_simple *class_simple_create(struct module *owner, char *name);
 extern void class_simple_destroy(struct class_simple *cs);
===== include/linux/input.h 1.54 vs edited =====
--- 1.54/include/linux/input.h	2004-11-01 20:44:12 +01:00
+++ edited/include/linux/input.h	2005-02-05 22:18:17 +01:00
@@ -1010,7 +1010,7 @@ static inline void input_set_abs_params(
 	dev->absbit[LONG(axis)] |= BIT(axis);
 }
 
-extern struct class_simple *input_class;
+extern struct class *input_class;
 
 #endif
 #endif

