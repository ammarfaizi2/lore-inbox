Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTKTX0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTKTX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:26:12 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61133 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263891AbTKTXYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:24:52 -0500
Date: Thu, 20 Nov 2003 15:18:37 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Hanna Linder <hannal@us.ibm.com>, Greg KH <greg@kroah.com>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: driver model for inputs
Message-ID: <56710000.1069370317@w-hlinder>
In-Reply-To: <20031120225504.GG196@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com>
 <20031120222825.GE196@elf.ucw.cz> <55080000.1069368524@w-hlinder> <20031120225504.GG196@elf.ucw.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, November 20, 2003 11:55:04 PM +0100 Pavel Machek <pavel@ucw.cz> wrote:

> If you could post -test8 version, that would be great.
> 									Pavel

It is actually test5. Ive been working on multiple sysfs patches, the parport one is test8. 
Ill get started on this one again and send out a cleaned up test9 version in a bit. This 
one is pretty ugly because it's got lots of printks in it. I was going to break it up before
submitting it too. But here ya go...

Hanna

---
diff -Nrup -Xdontdiff linux-2.6.0-test5/Makefile linux-260t5-ic/Makefile
--- linux-2.6.0-test5/Makefile	Mon Sep  8 12:50:12 2003
+++ linux-260t5-ic/Makefile	Thu Sep 11 11:39:16 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test5
+EXTRAVERSION = -test5ic
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/base/bus.c linux-260t5-ic/drivers/base/bus.c
--- linux-2.6.0-test5/drivers/base/bus.c	Mon Sep  8 12:49:58 2003
+++ linux-260t5-ic/drivers/base/bus.c	Wed Sep 10 15:02:46 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/base/class.c linux-260t5-ic/drivers/base/class.c
--- linux-2.6.0-test5/drivers/base/class.c	Mon Sep  8 12:50:41 2003
+++ linux-260t5-ic/drivers/base/class.c	Wed Sep 10 15:02:46 2003
@@ -10,7 +10,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/module.h>
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/base/core.c linux-260t5-ic/drivers/base/core.c
--- linux-2.6.0-test5/drivers/base/core.c	Mon Sep  8 12:49:52 2003
+++ linux-260t5-ic/drivers/base/core.c	Wed Sep 10 15:02:46 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/err.h>
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/evdev.c linux-260t5-ic/drivers/input/evdev.c
--- linux-2.6.0-test5/drivers/input/evdev.c	Mon Sep  8 12:50:18 2003
+++ linux-260t5-ic/drivers/input/evdev.c	Wed Sep 10 15:02:46 2003
@@ -27,7 +27,7 @@ struct evdev {
 	int open;
 	int minor;
 	char name[16];
-	struct input_handle handle;
+	struct input_handle *handle;
 	wait_queue_head_t wait;
 	struct evdev_list *grab;
 	struct list_head list;
@@ -86,12 +86,13 @@ static int evdev_flush(struct file * fil
 {
 	struct evdev_list *list = file->private_data;
 	if (!list->evdev->exist) return -ENODEV;
-	return input_flush_device(&list->evdev->handle, file);
+	return input_flush_device(list->evdev->handle, file);
 }
 
 static void evdev_free(struct evdev *evdev)
 {
-	devfs_remove("input/event%d", evdev->minor);
+printk(KERN_WARNING "in evdev_free\n");
+	//input_unregister_class_dev(intf.name, evdev->minor);
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -99,9 +100,10 @@ static void evdev_free(struct evdev *evd
 static int evdev_release(struct inode * inode, struct file * file)
 {
 	struct evdev_list *list = file->private_data;
+printk(KERN_WARNING "in evdev_release \n");
 
 	if (list->evdev->grab == list) {
-		input_release_device(&list->evdev->handle);
+		input_release_device(list->evdev->handle);
 		list->evdev->grab = NULL;
 	}
 
@@ -110,9 +112,11 @@ static int evdev_release(struct inode * 
 
 	if (!--list->evdev->open) {
 		if (list->evdev->exist)
-			input_close_device(&list->evdev->handle);
-		else
+			input_close_device(list->evdev->handle);
+		else{
+	//		input_unregister_class_dev(intf.name, list->evdev->minor);
 			evdev_free(list->evdev);
+		}
 	}
 
 	kfree(list);
@@ -141,7 +145,7 @@ static int evdev_open(struct inode * ino
 
 	if (!list->evdev->open++)
 		if (list->evdev->exist)
-			input_open_device(&list->evdev->handle);
+			input_open_device(list->evdev->handle);
 
 	return 0;
 }
@@ -158,7 +162,7 @@ static ssize_t evdev_write(struct file *
 
 		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
 			return -EFAULT;
-		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
+		input_event(list->evdev->handle->dev, event.type, event.code, event.value);
 		retval += sizeof(struct input_event);
 	}
 
@@ -206,7 +210,7 @@ static int evdev_ioctl(struct inode *ino
 {
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
-	struct input_dev *dev = evdev->handle.dev;
+	struct input_dev *dev = evdev->handle->dev;
 	struct input_absinfo abs;
 	int i, t, u;
 
@@ -278,14 +282,14 @@ static int evdev_ioctl(struct inode *ino
 			if (arg) {
 				if (evdev->grab)
 					return -EBUSY;
-				if (input_grab_device(&evdev->handle))
+				if (input_grab_device(evdev->handle))
 					return -EBUSY;
 				evdev->grab = list;
 				return 0;
 			} else {
 				if (evdev->grab != list)
 					return -EINVAL;
-				input_release_device(&evdev->handle);
+				input_release_device(evdev->handle);
 				evdev->grab = NULL;
 				return 0;
 			}
@@ -408,10 +412,17 @@ static struct file_operations evdev_fops
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
 	int minor;
+printk(KERN_WARNING "in evdev_connect\n");
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
 	if (minor == EVDEV_MINORS) {
@@ -423,36 +434,43 @@ static struct input_handle *evdev_connec
 		return NULL;
 	memset(evdev, 0, sizeof(struct evdev));
 
+	if (!(evdev->handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
+		return NULL;
+	memset(evdev->handle, 0, sizeof(struct input_handle));
+
 	INIT_LIST_HEAD(&evdev->list);
 	init_waitqueue_head(&evdev->wait);
 
 	evdev->exist = 1;
 	evdev->minor = minor;
-	evdev->handle.dev = dev;
-	evdev->handle.name = evdev->name;
-	evdev->handle.handler = handler;
-	evdev->handle.private = evdev;
+	evdev->handle->dev = dev;
+	evdev->handle->name = evdev->name;
+	evdev->handle->handler = handler;
+	evdev->handle->private = evdev;
 	sprintf(evdev->name, "event%d", minor);
 
 	evdev_table[minor] = evdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
+	intf.minor = minor;
+//	input_register_class_dev(dev, &intf);
 
-	return &evdev->handle;
+	return evdev->handle;
 }
 
 static void evdev_disconnect(struct input_handle *handle)
 {
 	struct evdev *evdev = handle->private;
+printk(KERN_WARNING "in evdev_disconnect\n");
 
 	evdev->exist = 0;
 
 	if (evdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&evdev->wait);
-	} else
+	} else {
+//		input_unregister_class_dev(intf.name, evdev->minor);
 		evdev_free(evdev);
+	}
 }
 
 static struct input_device_id evdev_ids[] = {
@@ -474,13 +492,17 @@ static struct input_handler evdev_handle
 
 static int __init evdev_init(void)
 {
+printk(KERN_WARNING "in evdev_init\n");
 	input_register_handler(&evdev_handler);
+	input_register_class_dev(dev, &intf);
 	return 0;
 }
 
 static void __exit evdev_exit(void)
 {
+printk(KERN_WARNING "in evdev_exit \n");
 	input_unregister_handler(&evdev_handler);
+	input_unregister_class_dev(intf.name, evdev->minor);
 }
 
 module_init(evdev_init);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/input.c linux-260t5-ic/drivers/input/input.c
--- linux-2.6.0-test5/drivers/input/input.c	Mon Sep  8 12:50:06 2003
+++ linux-260t5-ic/drivers/input/input.c	Fri Sep 12 14:55:49 2003
@@ -33,6 +33,10 @@ EXPORT_SYMBOL(input_register_device);
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
 EXPORT_SYMBOL(input_unregister_handler);
+EXPORT_SYMBOL(input_register_class_dev);
+EXPORT_SYMBOL(input_unregister_class_dev);
+EXPORT_SYMBOL(input_dev_get);
+EXPORT_SYMBOL(input_dev_put);
 EXPORT_SYMBOL(input_grab_device);
 EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
@@ -217,6 +221,7 @@ int input_grab_device(struct input_handl
 
 void input_release_device(struct input_handle *handle)
 {
+printk(KERN_WARNING "in input_release_device\n");
 	if (handle->dev->grab == handle)
 		handle->dev->grab = NULL;
 }
@@ -678,10 +683,120 @@ static int input_handlers_read(char *buf
 
 #endif
 
+#define to_input_dev(d) container_of(d, struct input_dev, class_dev)
+
+static ssize_t show_dev (struct class_device *class_dev, char *buf)
+{
+	struct input_dev *dev = to_input_dev(class_dev);
+	dev_t base;
+
+	base = MKDEV(INPUT_MAJOR, dev->minor);
+	return sprintf(buf, "%04x\n", base + 32 );
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static void release_class_dev(struct class_device *class_dev)
+{
+
+	struct input_dev *dev = to_input_dev(class_dev);
+printk(KERN_WARNING "in release_class_dev\n");
+	if(dev)
+		kfree(dev);
+}
+
 struct class input_class = {
 	.name		= "input",
+	.release	= &release_class_dev,
 };
 
+struct input_dev * input_dev_get(struct input_dev *dev)
+{
+	struct class_device *tmp;
+
+	if(!dev)
+		return NULL;
+
+	tmp = class_device_get(&dev->class_dev);
+	if(tmp)
+		return to_input_dev(tmp);
+	else
+		return NULL;
+}
+
+void input_dev_put(struct input_dev *dev)
+{
+	if(dev)
+		class_device_put(&dev->class_dev);
+}
+
+void input_register_class_dev(struct input_dev *dev, struct input_class_interface *intf)
+{
+	char sysfs_name[16];
+	int err;
+	char *input_name = NULL;
+
+printk(KERN_WARNING "in input_register_class_dev\n");
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, intf->minor_base + intf->minor), intf->mode, intf->name, intf->minor);
+
+	sprintf(sysfs_name, intf->name, intf->minor);
+
+	input_name = strchr(sysfs_name, '/');
+	if(input_name)
+		++input_name;
+	else
+	input_name = sysfs_name;
+	memset(&dev->class_dev, 0x00, sizeof(struct class_device));
+	dev->class_dev.class = &input_class;
+	dev->class_dev.dev = NULL;
+	snprintf(dev->class_dev.class_id, BUS_ID_SIZE, "%s", input_name);
+	err = class_device_register(&dev->class_dev);
+	if (err)	
+		goto error;
+	class_device_create_file(&dev->class_dev, &class_device_attr_dev);
+	dev->minor = intf->minor;
+printk(KERN_WARNING "in input_register_class_dev setting minor to: %d\n",dev->minor);
+	list_add(&dev->node, &input_dev_list);
+	return;
+error:
+printk(KERN_WARNING "in input_register_class_dev error registering class dev: \n");
+	kfree(input_name);
+	return;
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
+printk(KERN_WARNING "in input_unregister_class_dev \n");
+
+	list_for_each (tmp, &input_dev_list) {
+
+		dev = list_entry(tmp, struct input_dev, node);
+printk(KERN_WARNING "dev name in unregister is: %s\n",dev->name);
+		if (dev->minor == minor) {
+			found = 1;
+			break;
+		}
+		else{
+printk(KERN_WARNING "given minor: %d dne dev->minor: %d\n",minor,dev->minor);
+		}
+	}
+	if(found) {
+printk(KERN_WARNING "found in input_dev_list minor is: %d \n",dev->minor);
+		list_del(&dev->node);
+		class_device_unregister(&dev->class_dev);
+//              kfree(dev);
+//              input_dev_put(dev);
+	}
+}
+
 static int __init input_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -730,6 +845,7 @@ static int __init input_init(void)
 
 static void __exit input_exit(void)
 {
+printk(KERN_WARNING "in input_exit\n");
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("devices", proc_bus_input_dir);
 	remove_proc_entry("handlers", proc_bus_input_dir);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/joydev.c linux-260t5-ic/drivers/input/joydev.c
--- linux-2.6.0-test5/drivers/input/joydev.c	Mon Sep  8 12:50:06 2003
+++ linux-260t5-ic/drivers/input/joydev.c	Wed Sep 10 15:02:46 2003
@@ -143,7 +143,7 @@ static int joydev_fasync(int fd, struct 
 
 static void joydev_free(struct joydev *joydev)
 {
-	devfs_remove("js%d", joydev->minor);
+	//input_unregister_class_dev(intf.name, joydev->minor);
 	joydev_table[joydev->minor] = NULL;
 	kfree(joydev);
 }
@@ -159,8 +159,10 @@ static int joydev_release(struct inode *
 	if (!--list->joydev->open) {
 		if (list->joydev->exist)
 			input_close_device(&list->joydev->handle);
-		else
+		else{
+	//		input_unregister_class_dev(intf.name, list->joydev->minor);
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
+	//input_register_class_dev(dev, &intf); 	
 
 	return &joydev->handle;
 }
@@ -460,8 +468,10 @@ static void joydev_disconnect(struct inp
 
 	if (joydev->open)
 		input_close_device(handle);	
-	else
+	else{
+		//input_unregister_class_dev(intf.name, joydev->minor);
 		joydev_free(joydev);
+	}
 }
 
 static struct input_device_id joydev_ids[] = {
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/mouse/logips2pp.c linux-260t5-ic/drivers/input/mouse/logips2pp.c
--- linux-2.6.0-test5/drivers/input/mouse/logips2pp.c	Mon Sep  8 12:50:08 2003
+++ linux-260t5-ic/drivers/input/mouse/logips2pp.c	Wed Sep 10 15:02:46 2003
@@ -19,7 +19,7 @@
 
 void ps2pp_process_packet(struct psmouse *psmouse)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
         unsigned char *packet = psmouse->packet;
 
 	if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02) {
@@ -155,9 +155,9 @@ int ps2pp_detect_model(struct psmouse *p
 	psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
 
 	if (param[1] < 3)
-		clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
+		clear_bit(BTN_MIDDLE, psmouse->dev->keybit);
 	if (param[1] < 2)
-		clear_bit(BTN_RIGHT, psmouse->dev.keybit);
+		clear_bit(BTN_RIGHT, psmouse->dev->keybit);
 
 	psmouse->type = PSMOUSE_PS2;
 
@@ -169,21 +169,21 @@ int ps2pp_detect_model(struct psmouse *p
 
 		for (i = 0; logitech_4btn[i] != -1; i++)
 			if (logitech_4btn[i] == psmouse->model)
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
+				set_bit(BTN_SIDE, psmouse->dev->keybit);
 
 		for (i = 0; logitech_wheel[i] != -1; i++)
 			if (logitech_wheel[i] == psmouse->model) {
-				set_bit(REL_WHEEL, psmouse->dev.relbit);
+				set_bit(REL_WHEEL, psmouse->dev->relbit);
 				psmouse->name = "Wheel Mouse";
 			}
 
 		for (i = 0; logitech_mx[i] != -1; i++)
 			if (logitech_mx[i]  == psmouse->model) {
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
-				set_bit(BTN_EXTRA, psmouse->dev.keybit);
-				set_bit(BTN_BACK, psmouse->dev.keybit);
-				set_bit(BTN_FORWARD, psmouse->dev.keybit);
-				set_bit(BTN_TASK, psmouse->dev.keybit);
+				set_bit(BTN_SIDE, psmouse->dev->keybit);
+				set_bit(BTN_EXTRA, psmouse->dev->keybit);
+				set_bit(BTN_BACK, psmouse->dev->keybit);
+				set_bit(BTN_FORWARD, psmouse->dev->keybit);
+				set_bit(BTN_TASK, psmouse->dev->keybit);
 				psmouse->name = "MX Mouse";
 			}
 
@@ -193,8 +193,8 @@ int ps2pp_detect_model(struct psmouse *p
 
 		if (psmouse->model == 97) { /* TouchPad 3 */
 
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			set_bit(REL_HWHEEL, psmouse->dev.relbit);
+			set_bit(REL_WHEEL, psmouse->dev->relbit);
+			set_bit(REL_HWHEEL, psmouse->dev->relbit);
 
 			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
 			psmouse_command(psmouse, param, 0x30d1);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/mouse/psmouse-base.c linux-260t5-ic/drivers/input/mouse/psmouse-base.c
--- linux-2.6.0-test5/drivers/input/mouse/psmouse-base.c	Mon Sep  8 12:49:58 2003
+++ linux-260t5-ic/drivers/input/mouse/psmouse-base.c	Wed Sep 10 15:02:46 2003
@@ -46,7 +46,7 @@ static char *psmouse_protocols[] = { "No
 
 static void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
 	input_regs(dev, regs);
@@ -283,9 +283,9 @@ static int psmouse_extensions(struct psm
 
 	if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
 
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(BTN_EXTRA, psmouse->dev->keybit);
+		set_bit(BTN_SIDE, psmouse->dev->keybit);
+		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 		psmouse->vendor = "Genius";
 		psmouse->name = "Wheel Mouse";
@@ -324,7 +324,7 @@ static int psmouse_extensions(struct psm
 	
 	if (param[0] == 3) {
 
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 /*
  * Try IntelliMouse/Explorer magic init.
@@ -340,8 +340,8 @@ static int psmouse_extensions(struct psm
 
 		if (param[0] == 4) {
 
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+			set_bit(BTN_SIDE, psmouse->dev->keybit);
+			set_bit(BTN_EXTRA, psmouse->dev->keybit);
 
 			psmouse->name = "Explorer Mouse";
 			return PSMOUSE_IMEX;
@@ -478,7 +478,7 @@ static void psmouse_cleanup(struct serio
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
-	input_unregister_device(&psmouse->dev);
+	input_unregister_device(psmouse->dev);
 	serio_close(serio);
 	synaptics_disconnect(psmouse);
 	kfree(psmouse);
@@ -501,13 +501,18 @@ static void psmouse_connect(struct serio
 
 	memset(psmouse, 0, sizeof(struct psmouse));
 
-	init_input_dev(&psmouse->dev);
-	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	if (!(psmouse->dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL)))
+		return;
+
+	memset(psmouse->dev, 0, sizeof(struct input_dev));
+
+	init_input_dev(psmouse->dev);
+	psmouse->dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	psmouse->dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	psmouse->dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
 	psmouse->serio = serio;
-	psmouse->dev.private = psmouse;
+	psmouse->dev->private = psmouse;
 
 	serio->private = psmouse;
 
@@ -527,14 +532,14 @@ static void psmouse_connect(struct serio
 	sprintf(psmouse->phys, "%s/input0",
 		serio->phys);
 
-	psmouse->dev.name = psmouse->devname;
-	psmouse->dev.phys = psmouse->phys;
-	psmouse->dev.id.bustype = BUS_I8042;
-	psmouse->dev.id.vendor = 0x0002;
-	psmouse->dev.id.product = psmouse->type;
-	psmouse->dev.id.version = psmouse->model;
+	psmouse->dev->name = psmouse->devname;
+	psmouse->dev->phys = psmouse->phys;
+	psmouse->dev->id.bustype = BUS_I8042;
+	psmouse->dev->id.vendor = 0x0002;
+	psmouse->dev->id.product = psmouse->type;
+	psmouse->dev->id.version = psmouse->model;
 
-	input_register_device(&psmouse->dev);
+	input_register_device(psmouse->dev);
 	
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/mouse/psmouse.h linux-260t5-ic/drivers/input/mouse/psmouse.h
--- linux-2.6.0-test5/drivers/input/mouse/psmouse.h	Mon Sep  8 12:50:23 2003
+++ linux-260t5-ic/drivers/input/mouse/psmouse.h	Wed Sep 10 15:02:46 2003
@@ -18,7 +18,7 @@
 
 struct psmouse {
 	void *private;
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct serio *serio;
 	char *vendor;
 	char *name;
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/mouse/synaptics.c linux-260t5-ic/drivers/input/mouse/synaptics.c
--- linux-2.6.0-test5/drivers/input/mouse/synaptics.c	Mon Sep  8 12:50:01 2003
+++ linux-260t5-ic/drivers/input/mouse/synaptics.c	Wed Sep 10 15:02:46 2003
@@ -230,23 +230,23 @@ int synaptics_init(struct psmouse *psmou
 	 * which says that they should be valid regardless of the actual size of
 	 * the senser.
 	 */
-	set_bit(EV_ABS, psmouse->dev.evbit);
-	set_abs_params(&psmouse->dev, ABS_X, 1472, 5472, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_Y, 1408, 4448, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 255, 0, 0);
-
-	set_bit(EV_MSC, psmouse->dev.evbit);
-	set_bit(MSC_GESTURE, psmouse->dev.mscbit);
-
-	set_bit(EV_KEY, psmouse->dev.evbit);
-	set_bit(BTN_LEFT, psmouse->dev.keybit);
-	set_bit(BTN_RIGHT, psmouse->dev.keybit);
-	set_bit(BTN_FORWARD, psmouse->dev.keybit);
-	set_bit(BTN_BACK, psmouse->dev.keybit);
-
-	clear_bit(EV_REL, psmouse->dev.evbit);
-	clear_bit(REL_X, psmouse->dev.relbit);
-	clear_bit(REL_Y, psmouse->dev.relbit);
+	set_bit(EV_ABS, psmouse->dev->evbit);
+	set_abs_params(psmouse->dev, ABS_X, 1472, 5472, 0, 0);
+	set_abs_params(psmouse->dev, ABS_Y, 1408, 4448, 0, 0);
+	set_abs_params(psmouse->dev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	set_bit(EV_MSC, psmouse->dev->evbit);
+	set_bit(MSC_GESTURE, psmouse->dev->mscbit);
+
+	set_bit(EV_KEY, psmouse->dev->evbit);
+	set_bit(BTN_LEFT, psmouse->dev->keybit);
+	set_bit(BTN_RIGHT, psmouse->dev->keybit);
+	set_bit(BTN_FORWARD, psmouse->dev->keybit);
+	set_bit(BTN_BACK, psmouse->dev->keybit);
+
+	clear_bit(EV_REL, psmouse->dev->evbit);
+	clear_bit(REL_X, psmouse->dev->relbit);
+	clear_bit(REL_Y, psmouse->dev->relbit);
 
 	return 0;
 
@@ -303,7 +303,7 @@ static void synaptics_parse_hw_state(str
  */
 static void synaptics_process_packet(struct psmouse *psmouse)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
 
@@ -353,7 +353,7 @@ static void synaptics_process_packet(str
 
 void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
-	struct input_dev *dev = &psmouse->dev;
+	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char *pBuf = priv->proto_buf;
 	unsigned char u = psmouse->packet[0];
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/mousedev.c linux-260t5-ic/drivers/input/mousedev.c
--- linux-2.6.0-test5/drivers/input/mousedev.c	Mon Sep  8 12:50:28 2003
+++ linux-260t5-ic/drivers/input/mousedev.c	Wed Sep 10 15:02:46 2003
@@ -46,7 +46,7 @@ struct mousedev {
 	char name[16];
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct input_handle handle;
+	struct input_handle *handle;
 };
 
 struct mousedev_list {
@@ -171,9 +171,16 @@ static int mousedev_fasync(int fd, struc
 	return retval < 0 ? retval : 0;
 }
 
+static struct input_class_interface intf = {
+	.name =		"input/mouse%d",
+	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
+	.minor_base = 	MOUSEDEV_MINOR_BASE,
+};
+
 static void mousedev_free(struct mousedev *mousedev)
 {
-	devfs_remove("input/mouse%d", mousedev->minor);
+printk(KERN_WARNING "in mousedev_free \n");
+	//input_unregister_class_dev(intf.name, mousedev->minor);
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -181,15 +188,18 @@ static void mousedev_free(struct mousede
 static int mixdev_release(void)
 {
 	struct input_handle *handle;
+printk(KERN_WARNING "in mixdev_release \n");
 
 	list_for_each_entry(handle, &mousedev_handler.h_list, h_node) {
 		struct mousedev *mousedev = handle->private;
 
 		if (!mousedev->open) {
 			if (mousedev->exist)
-				input_close_device(&mousedev->handle);
-			else
+				input_close_device(mousedev->handle);
+			else {
+				//input_unregister_class_dev(intf.name,mousedev->minor);
 				mousedev_free(mousedev);
+			}
 		}
 	}
 
@@ -199,20 +209,25 @@ static int mixdev_release(void)
 static int mousedev_release(struct inode * inode, struct file * file)
 {
 	struct mousedev_list *list = file->private_data;
+printk(KERN_WARNING "in mousedev_release \n");
 
 	mousedev_fasync(-1, file, 0);
 
 	list_del(&list->node);
 
 	if (!--list->mousedev->open) {
-		if (list->mousedev->minor == MOUSEDEV_MIX)
+		if (list->mousedev->minor == MOUSEDEV_MIX){
+//input_unregister_class_dev(intf.name, list->mousedev->minor);
 			return mixdev_release();
+		}
 
 		if (!mousedev_mix.open) {
 			if (list->mousedev->exist)
-				input_close_device(&list->mousedev->handle);
-			else
+				input_close_device(list->mousedev->handle);
+			else{
+			//	input_unregister_class_dev(intf.name, list->mousedev->minor);
 				mousedev_free(list->mousedev);
+			}
 		}
 	}
 	
@@ -254,7 +269,7 @@ static int mousedev_open(struct inode * 
 			}
 		} else 
 			if (!mousedev_mix.open && list->mousedev->exist)	
-				input_open_device(&list->mousedev->handle);
+				input_open_device(list->mousedev->handle);
 	}
 
 	return 0;
@@ -406,6 +421,9 @@ static struct input_handle *mousedev_con
 {
 	struct mousedev *mousedev;
 	int minor = 0;
+int seen = 0;
+
+printk(KERN_WARNING "in mousedev_connect \n");
 
 	for (minor = 0; minor < MOUSEDEV_MINORS && mousedev_table[minor]; minor++);
 	if (minor == MOUSEDEV_MINORS) {
@@ -417,31 +435,39 @@ static struct input_handle *mousedev_con
 		return NULL;
 	memset(mousedev, 0, sizeof(struct mousedev));
 
+	if (!(mousedev->handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
+		return NULL;
+	memset(mousedev->handle, 0, sizeof(struct input_handle));
+
 	INIT_LIST_HEAD(&mousedev->list);
 	init_waitqueue_head(&mousedev->wait);
 
 	mousedev->minor = minor;
 	mousedev->exist = 1;
-	mousedev->handle.dev = dev;
-	mousedev->handle.name = mousedev->name;
-	mousedev->handle.handler = handler;
-	mousedev->handle.private = mousedev;
+	mousedev->handle->dev = dev;
+	mousedev->handle->name = mousedev->name;
+	mousedev->handle->handler = handler;
+	mousedev->handle->private = mousedev;
 	sprintf(mousedev->name, "mouse%d", minor);
 
 	if (mousedev_mix.open)
-		input_open_device(&mousedev->handle);
+		input_open_device(mousedev->handle);
 
 	mousedev_table[minor] = mousedev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
+	intf.minor = minor;
+printk(KERN_WARNING "in mousedev connect minor before is: %d\n", intf.minor);
+	input_register_class_dev(dev, &intf);
+//	seen++;
+printk(KERN_WARNING "in mousedev connect minor after is: %d seen is %d\n", intf.minor, seen);
 
-	return &mousedev->handle;
+	return mousedev->handle;
 }
 
 static void mousedev_disconnect(struct input_handle *handle)
 {
 	struct mousedev *mousedev = handle->private;
+printk(KERN_WARNING "in mousedev_disconnect \n");
 
 	mousedev->exist = 0;
 
@@ -450,6 +476,7 @@ static void mousedev_disconnect(struct i
 	} else {
 		if (mousedev_mix.open)
 			input_close_device(handle);
+		input_unregister_class_dev(intf.name,mousedev->minor);
 		mousedev_free(mousedev);
 	}
 }
@@ -494,8 +521,17 @@ static struct miscdevice psaux_mouse = {
 };
 #endif
 
+static struct input_class_interface intf2 = {
+	.name =		"input/mice",
+	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
+	.minor_base = 	MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX,
+};
+
 static int __init mousedev_init(void)
 {
+	struct input_dev *dev; /* need an input_dev to hold the class_device */
+
+printk(KERN_WARNING "in mousedev_init \n");
 	input_register_handler(&mousedev_handler);
 
 	memset(&mousedev_mix, 0, sizeof(struct mousedev));
@@ -505,9 +541,12 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-
+	intf2.minor = MOUSEDEV_MIX;
+	dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+	if(!dev)
+		return -ENOMEM;
+	memset(dev, 0x00, sizeof(struct input_dev));
+	input_register_class_dev(dev, &intf2);
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
@@ -521,12 +560,14 @@ static int __init mousedev_init(void)
 
 static void __exit mousedev_exit(void)
 {
+printk(KERN_WARNING "in mousedev_exit\n");
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (mousedev_mix.misc)
 		misc_deregister(&psaux_mouse);
 #endif
-	devfs_remove("input/mice");
+	/*devfs_remove("input/mice");*/
 	input_unregister_handler(&mousedev_handler);
+	input_unregister_class_dev(intf2.name,MOUSEDEV_MIX);
 }
 
 module_init(mousedev_init);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/input/tsdev.c linux-260t5-ic/drivers/input/tsdev.c
--- linux-2.6.0-test5/drivers/input/tsdev.c	Mon Sep  8 12:50:32 2003
+++ linux-260t5-ic/drivers/input/tsdev.c	Wed Sep 10 15:02:46 2003
@@ -118,7 +118,7 @@ static int tsdev_open(struct inode *inod
 
 static void tsdev_free(struct tsdev *tsdev)
 {
-	devfs_remove("input/ts%d", tsdev->minor);
+	//input_unregister_class_dev(intf.name, tsdev->minor);
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -133,8 +133,10 @@ static int tsdev_release(struct inode *i
 	if (!--list->tsdev->open) {
 		if (list->tsdev->exist)
 			input_close_device(&list->tsdev->handle);
-		else
+		else{
+	//		input_unregister_class_dev(intf.name,list->tsdev->minor);
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
+	//input_register_class_dev(dev, &intf);	
 
 	return &tsdev->handle;
 }
@@ -346,8 +354,10 @@ static void tsdev_disconnect(struct inpu
 	if (tsdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&tsdev->wait);
-	} else
+	} else {
+		//input_unregister_class_dev(intf.name,tsdev->minor);
 		tsdev_free(tsdev);
+	}
 }
 
 static struct input_device_id tsdev_ids[] = {
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/hid-input.c linux-260t5-ic/drivers/usb/input/hid-input.c
--- linux-2.6.0-test5/drivers/usb/input/hid-input.c	Mon Sep  8 12:50:02 2003
+++ linux-260t5-ic/drivers/usb/input/hid-input.c	Wed Sep 10 15:02:46 2003
@@ -75,13 +75,13 @@ static struct input_dev *find_input(stru
 
 		for (i = 0; i < hidinput->report->maxfield; i++)
 			if (hidinput->report->field[i] == field)
-				return &hidinput->input;
+				return hidinput->input;
 	}
 
 	/* Assume we only have one input and use it */
 	if (!list_empty(&hid->inputs)) {
 		hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-		return &hidinput->input;
+		return hidinput->input;
 	}
 
 	/* This is really a bug */
@@ -91,8 +91,8 @@ static struct input_dev *find_input(stru
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
-	struct input_dev *input = &hidinput->input;
-	struct hid_device *device = hidinput->input.private;
+	struct input_dev *input = hidinput->input;
+	struct hid_device *device = hidinput->input->private;
 	int max;
 	int is_abs = 0;
 	unsigned long *bit;
@@ -500,7 +500,7 @@ void hidinput_report_event(struct hid_de
 
 	list_for_each (lh, &hid->inputs) {
 		hidinput = list_entry(lh, struct hid_input, list);
-		input_sync(&hidinput->input);
+		input_sync(hidinput->input);
 	}
 }
 
@@ -577,21 +577,27 @@ int hidinput_connect(struct hid_device *
 					return -1;
 				}
 				memset(hidinput, 0, sizeof(*hidinput));
+				hidinput->input = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+				if (!(hidinput->input)) {
+					err("Out of memory during hid input_dev probe");
+					return -1;
+				}
+				memset(hidinput->input, 0, sizeof(struct input_dev));
 
 				list_add_tail(&hidinput->list, &hid->inputs);
 
-				hidinput->input.private = hid;
-				hidinput->input.event = hidinput_input_event;
-				hidinput->input.open = hidinput_open;
-				hidinput->input.close = hidinput_close;
-
-				hidinput->input.name = hid->name;
-				hidinput->input.phys = hid->phys;
-				hidinput->input.uniq = hid->uniq;
-				hidinput->input.id.bustype = BUS_USB;
-				hidinput->input.id.vendor = dev->descriptor.idVendor;
-				hidinput->input.id.product = dev->descriptor.idProduct;
-				hidinput->input.id.version = dev->descriptor.bcdDevice;
+				hidinput->input->private = hid;
+				hidinput->input->event = hidinput_input_event;
+				hidinput->input->open = hidinput_open;
+				hidinput->input->close = hidinput_close;
+
+				hidinput->input->name = hid->name;
+				hidinput->input->phys = hid->phys;
+				hidinput->input->uniq = hid->uniq;
+				hidinput->input->id.bustype = BUS_USB;
+				hidinput->input->id.vendor = dev->descriptor.idVendor;
+				hidinput->input->id.product = dev->descriptor.idProduct;
+				hidinput->input->id.version = dev->descriptor.bcdDevice;
 			}
 
 			for (i = 0; i < report->maxfield; i++)
@@ -606,7 +612,7 @@ int hidinput_connect(struct hid_device *
 				 * UGCI) cram a lot of unrelated inputs into the
 				 * same interface. */
 				hidinput->report = report;
-				input_register_device(&hidinput->input);
+				input_register_device(hidinput->input);
 				hidinput = NULL;
 			}
 
@@ -619,7 +625,7 @@ int hidinput_connect(struct hid_device *
 	 * only useful in this case, and not for multi-input quirks. */
 	if (hidinput) {
 		hid_ff_init(hid);
-		input_register_device(&hidinput->input);
+		input_register_device(hidinput->input);
 	}
 
 	return 0;
@@ -632,7 +638,7 @@ void hidinput_disconnect(struct hid_devi
 
 	list_for_each_safe (lh, next, &hid->inputs) {
 		hidinput = list_entry(lh, struct hid_input, list);
-		input_unregister_device(&hidinput->input);
+		input_unregister_device(hidinput->input);
 		list_del(&hidinput->list);
 		kfree(hidinput);
 	}
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/hid-lgff.c linux-260t5-ic/drivers/usb/input/hid-lgff.c
--- linux-2.6.0-test5/drivers/usb/input/hid-lgff.c	Mon Sep  8 12:50:20 2003
+++ linux-260t5-ic/drivers/usb/input/hid-lgff.c	Wed Sep 10 15:02:46 2003
@@ -262,15 +262,15 @@ static void hid_lgff_input_init(struct h
 	ff = dev->ff;
 
 	while (*ff >= 0) {
-		set_bit(*ff, hidinput->input.ffbit);
+		set_bit(*ff, hidinput->input->ffbit);
 		++ff;
 	}
 
-	hidinput->input.upload_effect = hid_lgff_upload_effect;
-	hidinput->input.flush = hid_lgff_flush;
+	hidinput->input->upload_effect = hid_lgff_upload_effect;
+	hidinput->input->flush = hid_lgff_flush;
 
-	set_bit(EV_FF, hidinput->input.evbit);
-	hidinput->input.ff_effects_max = LGFF_EFFECTS;
+	set_bit(EV_FF, hidinput->input->evbit);
+	hidinput->input->ff_effects_max = LGFF_EFFECTS;
 }
 
 static void hid_lgff_exit(struct hid_device* hid)
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/hid-tmff.c linux-260t5-ic/drivers/usb/input/hid-tmff.c
--- linux-2.6.0-test5/drivers/usb/input/hid-tmff.c	Mon Sep  8 12:50:08 2003
+++ linux-260t5-ic/drivers/usb/input/hid-tmff.c	Wed Sep 10 15:02:46 2003
@@ -155,7 +155,7 @@ int hid_tmff_init(struct hid_device *hid
 					private->report = report;
 					private->rumble = field;
 
-					set_bit(FF_RUMBLE, hidinput->input.ffbit);
+					set_bit(FF_RUMBLE, hidinput->input->ffbit);
 					break;
 
 				default:
@@ -164,11 +164,11 @@ int hid_tmff_init(struct hid_device *hid
 			}
 
 			/* Fallthrough to here only when a valid usage is found */
-			hidinput->input.upload_effect = hid_tmff_upload_effect;
-			hidinput->input.flush = hid_tmff_flush;
+			hidinput->input->upload_effect = hid_tmff_upload_effect;
+			hidinput->input->flush = hid_tmff_flush;
 
-			set_bit(EV_FF, hidinput->input.evbit);
-			hidinput->input.ff_effects_max = TMFF_EFFECTS;
+			set_bit(EV_FF, hidinput->input->evbit);
+			hidinput->input->ff_effects_max = TMFF_EFFECTS;
 		}
 	}
 
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/hid.h linux-260t5-ic/drivers/usb/input/hid.h
--- linux-2.6.0-test5/drivers/usb/input/hid.h	Mon Sep  8 12:49:51 2003
+++ linux-260t5-ic/drivers/usb/input/hid.h	Wed Sep 10 15:02:46 2003
@@ -327,7 +327,7 @@ struct hid_control_fifo {
 struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
-	struct input_dev input;
+	struct input_dev *input;
 };
 
 struct hid_device {							/* device report descriptor */
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/kbtab.c linux-260t5-ic/drivers/usb/input/kbtab.c
--- linux-2.6.0-test5/drivers/usb/input/kbtab.c	Mon Sep  8 12:49:51 2003
+++ linux-260t5-ic/drivers/usb/input/kbtab.c	Wed Sep 10 15:02:46 2003
@@ -32,7 +32,7 @@ MODULE_PARM_DESC(kb_pressure_click,
 struct kbtab {
 	signed char *data;
 	dma_addr_t data_dma;
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct usb_device *usbdev;
 	struct urb *irq;
 	int open;
@@ -47,7 +47,7 @@ static void kbtab_irq(struct urb *urb, s
 {
 	struct kbtab *kbtab = urb->context;
 	unsigned char *data = kbtab->data;
-	struct input_dev *dev = &kbtab->dev;
+	struct input_dev *dev = kbtab->dev;
 	int retval;
 
 	switch (urb->status) {
@@ -130,6 +130,10 @@ static int kbtab_probe(struct usb_interf
 		return -ENOMEM;
 	memset(kbtab, 0, sizeof(struct kbtab));
 
+	if (!(kbtab->dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL)))
+		return -ENOMEM;
+	memset(kbtab->dev, 0, sizeof(struct input_dev));
+
 	kbtab->data = usb_buffer_alloc(dev, 8, SLAB_ATOMIC, &kbtab->data_dma);
 	if (!kbtab->data) {
 		kfree(kbtab);
@@ -143,35 +147,35 @@ static int kbtab_probe(struct usb_interf
 		return -ENOMEM;
 	}
 
-	kbtab->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_MSC);
-	kbtab->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	kbtab->dev->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_MSC);
+	kbtab->dev->absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
 
-	kbtab->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
+	kbtab->dev->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
 
-	kbtab->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH);
+	kbtab->dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH);
 
-	kbtab->dev.mscbit[0] |= BIT(MSC_SERIAL);
+	kbtab->dev->mscbit[0] |= BIT(MSC_SERIAL);
 
-	kbtab->dev.absmax[ABS_X] = 0x2000;
-	kbtab->dev.absmax[ABS_Y] = 0x1750;
-	kbtab->dev.absmax[ABS_PRESSURE] = 0xff;
+	kbtab->dev->absmax[ABS_X] = 0x2000;
+	kbtab->dev->absmax[ABS_Y] = 0x1750;
+	kbtab->dev->absmax[ABS_PRESSURE] = 0xff;
 	
-	kbtab->dev.absfuzz[ABS_X] = 4;
-	kbtab->dev.absfuzz[ABS_Y] = 4;
+	kbtab->dev->absfuzz[ABS_X] = 4;
+	kbtab->dev->absfuzz[ABS_Y] = 4;
 
-	kbtab->dev.private = kbtab;
-	kbtab->dev.open = kbtab_open;
-	kbtab->dev.close = kbtab_close;
+	kbtab->dev->private = kbtab;
+	kbtab->dev->open = kbtab_open;
+	kbtab->dev->close = kbtab_close;
 
 	usb_make_path(dev, path, 64);
 	sprintf(kbtab->phys, "%s/input0", path);
 
-	kbtab->dev.name = "KB Gear Tablet";
-	kbtab->dev.phys = kbtab->phys;
-	kbtab->dev.id.bustype = BUS_USB;
-	kbtab->dev.id.vendor = dev->descriptor.idVendor;
-	kbtab->dev.id.product = dev->descriptor.idProduct;
-	kbtab->dev.id.version = dev->descriptor.bcdDevice;
+	kbtab->dev->name = "KB Gear Tablet";
+	kbtab->dev->phys = kbtab->phys;
+	kbtab->dev->id.bustype = BUS_USB;
+	kbtab->dev->id.vendor = dev->descriptor.idVendor;
+	kbtab->dev->id.product = dev->descriptor.idProduct;
+	kbtab->dev->id.version = dev->descriptor.bcdDevice;
 	kbtab->usbdev = dev;
 
 	endpoint = &intf->altsetting[0].endpoint[0].desc;
@@ -183,7 +187,7 @@ static int kbtab_probe(struct usb_interf
 	kbtab->irq->transfer_dma = kbtab->data_dma;
 	kbtab->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	input_register_device(&kbtab->dev);
+	input_register_device(kbtab->dev);
 
 	printk(KERN_INFO "input: KB Gear Tablet on %s\n",  path);
 
@@ -199,7 +203,7 @@ static void kbtab_disconnect(struct usb_
 	usb_set_intfdata(intf, NULL);
 	if (kbtab) {
 		usb_unlink_urb(kbtab->irq);
-		input_unregister_device(&kbtab->dev);
+		input_unregister_device(kbtab->dev);
 		usb_free_urb(kbtab->irq);
 		usb_buffer_free(interface_to_usbdev(intf), 10, kbtab->data, kbtab->data_dma);
 		kfree(kbtab);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/pid.c linux-260t5-ic/drivers/usb/input/pid.c
--- linux-2.6.0-test5/drivers/usb/input/pid.c	Mon Sep  8 12:50:23 2003
+++ linux-260t5-ic/drivers/usb/input/pid.c	Wed Sep 10 15:02:46 2003
@@ -290,11 +290,11 @@ int hid_pid_init(struct hid_device *hid)
     }
 
     usb_fill_control_urb(private->urbffout, hid->dev,0,(void *) &private->ffcr,private->ctrl_buffer,8,hid_pid_ctrl_out,hid);
-    hidinput->input.upload_effect = hid_pid_upload_effect;
-    hidinput->input.flush = hid_pid_flush;
-    hidinput->input.ff_effects_max = 8;  // A random default
-    set_bit(EV_FF, hidinput->input.evbit);
-    set_bit(EV_FF_STATUS, hidinput->input.evbit);
+    hidinput->input->upload_effect = hid_pid_upload_effect;
+    hidinput->input->flush = hid_pid_flush;
+    hidinput->input->ff_effects_max = 8;  // A random default
+    set_bit(EV_FF, hidinput->input->evbit);
+    set_bit(EV_FF_STATUS, hidinput->input->evbit);
 
     spin_lock_init(&private->lock);
 
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/powermate.c linux-260t5-ic/drivers/usb/input/powermate.c
--- linux-2.6.0-test5/drivers/usb/input/powermate.c	Mon Sep  8 12:50:07 2003
+++ linux-260t5-ic/drivers/usb/input/powermate.c	Wed Sep 10 15:02:46 2003
@@ -62,7 +62,7 @@ struct powermate_device {
 	struct usb_ctrlrequest *configcr;
 	dma_addr_t configcr_dma;
 	struct usb_device *udev;
-	struct input_dev input;
+	struct input_dev *input;
 	struct semaphore lock;
 	int static_brightness;
 	int pulse_speed;
@@ -100,10 +100,10 @@ static void powermate_irq(struct urb *ur
 	}
 
 	/* handle updates to device state */
-	input_regs(&pm->input, regs);
-	input_report_key(&pm->input, BTN_0, pm->data[0] & 0x01);
-	input_report_rel(&pm->input, REL_DIAL, pm->data[1]);
-	input_sync(&pm->input);
+	input_regs(pm->input, regs);
+	input_report_key(pm->input, BTN_0, pm->data[0] & 0x01);
+	input_report_rel(pm->input, REL_DIAL, pm->data[1]);
+	input_sync(pm->input);
 
 exit:
 	retval = usb_submit_urb (urb, GFP_ATOMIC);
@@ -317,6 +317,11 @@ static int powermate_probe(struct usb_in
 		return -ENOMEM;
 
 	memset(pm, 0, sizeof(struct powermate_device));
+
+	if (!(pm->input = kmalloc(sizeof(struct input_dev), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(pm->input, 0, sizeof(struct input_dev));
 	pm->udev = udev;
 
 	if (powermate_alloc_buffers(udev, pm)) {
@@ -341,7 +346,7 @@ static int powermate_probe(struct usb_in
 	}
 
 	init_MUTEX(&pm->lock);
-	init_input_dev(&pm->input);
+	init_input_dev(pm->input);
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
@@ -365,29 +370,29 @@ static int powermate_probe(struct usb_in
 	}
 
 	switch (udev->descriptor.idProduct) {
-	case POWERMATE_PRODUCT_NEW: pm->input.name = pm_name_powermate; break;
-	case POWERMATE_PRODUCT_OLD: pm->input.name = pm_name_soundknob; break;
+	case POWERMATE_PRODUCT_NEW: pm->input->name = pm_name_powermate; break;
+	case POWERMATE_PRODUCT_OLD: pm->input->name = pm_name_soundknob; break;
 	default: 
-	  pm->input.name = pm_name_soundknob;
+	  pm->input->name = pm_name_soundknob;
 	  printk(KERN_WARNING "powermate: unknown product id %04x\n", udev->descriptor.idProduct);
 	}
 
-	pm->input.private = pm;
-	pm->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_MSC);
-	pm->input.keybit[LONG(BTN_0)] = BIT(BTN_0);
-	pm->input.relbit[LONG(REL_DIAL)] = BIT(REL_DIAL);
-	pm->input.mscbit[LONG(MSC_PULSELED)] = BIT(MSC_PULSELED);
-	pm->input.id.bustype = BUS_USB;
-	pm->input.id.vendor = udev->descriptor.idVendor;
-	pm->input.id.product = udev->descriptor.idProduct;
-	pm->input.id.version = udev->descriptor.bcdDevice;
-	pm->input.event = powermate_input_event;
+	pm->input->private = pm;
+	pm->input->evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_MSC);
+	pm->input->keybit[LONG(BTN_0)] = BIT(BTN_0);
+	pm->input->relbit[LONG(REL_DIAL)] = BIT(REL_DIAL);
+	pm->input->mscbit[LONG(MSC_PULSELED)] = BIT(MSC_PULSELED);
+	pm->input->id.bustype = BUS_USB;
+	pm->input->id.vendor = udev->descriptor.idVendor;
+	pm->input->id.product = udev->descriptor.idProduct;
+	pm->input->id.version = udev->descriptor.bcdDevice;
+	pm->input->event = powermate_input_event;
 
-	input_register_device(&pm->input);
+	input_register_device(pm->input);
 
 	usb_make_path(udev, path, 64);
 	snprintf(pm->phys, 64, "%s/input0", path);
-	printk(KERN_INFO "input: %s on %s\n", pm->input.name, pm->input.phys);
+	printk(KERN_INFO "input: %s on %s\n", pm->input->name, pm->input->phys);
 	
 	/* force an update of everything */
 	pm->requires_update = UPDATE_PULSE_ASLEEP | UPDATE_PULSE_AWAKE | UPDATE_PULSE_MODE | UPDATE_STATIC_BRIGHTNESS;
@@ -407,7 +412,7 @@ static void powermate_disconnect(struct 
 		down(&pm->lock);
 		pm->requires_update = 0;
 		usb_unlink_urb(pm->irq);
-		input_unregister_device(&pm->input);
+		input_unregister_device(pm->input);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/usbkbd.c linux-260t5-ic/drivers/usb/input/usbkbd.c
--- linux-2.6.0-test5/drivers/usb/input/usbkbd.c	Mon Sep  8 12:50:32 2003
+++ linux-260t5-ic/drivers/usb/input/usbkbd.c	Wed Sep 10 15:02:46 2003
@@ -65,7 +65,7 @@ static unsigned char usb_kbd_keycode[256
 };
 
 struct usb_kbd {
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct usb_device *usbdev;
 	unsigned char old[8];
 	struct urb *irq, *led;
@@ -99,29 +99,29 @@ static void usb_kbd_irq(struct urb *urb,
 		goto resubmit;
 	}
 
-	input_regs(&kbd->dev, regs);
+	input_regs(kbd->dev, regs);
 
 	for (i = 0; i < 8; i++)
-		input_report_key(&kbd->dev, usb_kbd_keycode[i + 224], (kbd->new[0] >> i) & 1);
+		input_report_key(kbd->dev, usb_kbd_keycode[i + 224], (kbd->new[0] >> i) & 1);
 
 	for (i = 2; i < 8; i++) {
 
 		if (kbd->old[i] > 3 && memscan(kbd->new + 2, kbd->old[i], 6) == kbd->new + 8) {
 			if (usb_kbd_keycode[kbd->old[i]])
-				input_report_key(&kbd->dev, usb_kbd_keycode[kbd->old[i]], 0);
+				input_report_key(kbd->dev, usb_kbd_keycode[kbd->old[i]], 0);
 			else
 				info("Unknown key (scancode %#x) released.", kbd->old[i]);
 		}
 
 		if (kbd->new[i] > 3 && memscan(kbd->old + 2, kbd->new[i], 6) == kbd->old + 8) {
 			if (usb_kbd_keycode[kbd->new[i]])
-				input_report_key(&kbd->dev, usb_kbd_keycode[kbd->new[i]], 1);
+				input_report_key(kbd->dev, usb_kbd_keycode[kbd->new[i]], 1);
 			else
 				info("Unknown key (scancode %#x) pressed.", kbd->new[i]);
 		}
 	}
 
-	input_sync(&kbd->dev);
+	input_sync(kbd->dev);
 
 	memcpy(kbd->old, kbd->new, 8);
 
@@ -258,6 +258,11 @@ static int usb_kbd_probe(struct usb_inte
 		return -ENOMEM;
 	memset(kbd, 0, sizeof(struct usb_kbd));
 
+	/*move to usb_kbd_alloc_mem*/
+	if (!(kbd->dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL)))
+		return -ENOMEM;
+	memset(kbd->dev, 0, sizeof(struct input_dev));
+
 	if (usb_kbd_alloc_mem(dev, kbd)) {
 		usb_kbd_free_mem(dev, kbd);
 		kfree(kbd);
@@ -266,17 +271,17 @@ static int usb_kbd_probe(struct usb_inte
 
 	kbd->usbdev = dev;
 
-	kbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
-	kbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL) | BIT(LED_COMPOSE) | BIT(LED_KANA);
+	kbd->dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+	kbd->dev->ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL) | BIT(LED_COMPOSE) | BIT(LED_KANA);
 
 	for (i = 0; i < 255; i++)
-		set_bit(usb_kbd_keycode[i], kbd->dev.keybit);
+		set_bit(usb_kbd_keycode[i], kbd->dev->keybit);
 	clear_bit(0, kbd->dev.keybit);
 	
-	kbd->dev.private = kbd;
-	kbd->dev.event = usb_kbd_event;
-	kbd->dev.open = usb_kbd_open;
-	kbd->dev.close = usb_kbd_close;
+	kbd->dev->private = kbd;
+	kbd->dev->event = usb_kbd_event;
+	kbd->dev->open = usb_kbd_open;
+	kbd->dev->close = usb_kbd_close;
 
 	usb_fill_int_urb(kbd->irq, dev, pipe,
 			 kbd->new, (maxp > 8 ? 8 : maxp),
@@ -293,12 +298,12 @@ static int usb_kbd_probe(struct usb_inte
 	usb_make_path(dev, path, 64);
 	sprintf(kbd->phys, "%s/input0", path);
 
-	kbd->dev.name = kbd->name;
-	kbd->dev.phys = kbd->phys;	
-	kbd->dev.id.bustype = BUS_USB;
-	kbd->dev.id.vendor = dev->descriptor.idVendor;
-	kbd->dev.id.product = dev->descriptor.idProduct;
-	kbd->dev.id.version = dev->descriptor.bcdDevice;
+	kbd->dev->name = kbd->name;
+	kbd->dev->phys = kbd->phys;	
+	kbd->dev->id.bustype = BUS_USB;
+	kbd->dev->id.vendor = dev->descriptor.idVendor;
+	kbd->dev->id.product = dev->descriptor.idProduct;
+	kbd->dev->id.version = dev->descriptor.bcdDevice;
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
 		usb_free_urb(kbd->irq);
@@ -316,7 +321,7 @@ static int usb_kbd_probe(struct usb_inte
 
 	if (!strlen(kbd->name))
 		sprintf(kbd->name, "USB HIDBP Keyboard %04x:%04x",
-			kbd->dev.id.vendor, kbd->dev.id.product);
+			kbd->dev->id.vendor, kbd->dev->id.product);
 
 	kfree(buf);
 
@@ -328,7 +333,7 @@ static int usb_kbd_probe(struct usb_inte
 	kbd->led->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP
 				| URB_NO_SETUP_DMA_MAP);
 
-	input_register_device(&kbd->dev);
+	input_register_device(kbd->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", kbd->name, path);
 
@@ -343,7 +348,7 @@ static void usb_kbd_disconnect(struct us
 	usb_set_intfdata(intf, NULL);
 	if (kbd) {
 		usb_unlink_urb(kbd->irq);
-		input_unregister_device(&kbd->dev);
+		input_unregister_device(kbd->dev);
 		usb_kbd_free_mem(interface_to_usbdev(intf), kbd);
 		kfree(kbd);
 	}
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/usbmouse.c linux-260t5-ic/drivers/usb/input/usbmouse.c
--- linux-2.6.0-test5/drivers/usb/input/usbmouse.c	Mon Sep  8 12:50:29 2003
+++ linux-260t5-ic/drivers/usb/input/usbmouse.c	Wed Sep 10 15:02:46 2003
@@ -49,7 +49,7 @@ struct usb_mouse {
 	char name[128];
 	char phys[64];
 	struct usb_device *usbdev;
-	struct input_dev dev;
+	struct input_dev *dev;
 	struct urb *irq;
 	int open;
 
@@ -61,7 +61,7 @@ static void usb_mouse_irq(struct urb *ur
 {
 	struct usb_mouse *mouse = urb->context;
 	signed char *data = mouse->data;
-	struct input_dev *dev = &mouse->dev;
+	struct input_dev *dev = mouse->dev;
 	int status;
 
 	switch (urb->status) {
@@ -149,6 +149,10 @@ static int usb_mouse_probe(struct usb_in
 		return -ENOMEM;
 	memset(mouse, 0, sizeof(struct usb_mouse));
 
+	if (!(mouse->dev = kmalloc(sizeof(struct input_dev), GFP_KERNEL))) 
+		return -ENOMEM;
+	memset(mouse->dev, 0, sizeof(struct input_dev));
+
 	mouse->data = usb_buffer_alloc(dev, 8, SLAB_ATOMIC, &mouse->data_dma);
 	if (!mouse->data) {
 		kfree(mouse);
@@ -164,25 +168,25 @@ static int usb_mouse_probe(struct usb_in
 
 	mouse->usbdev = dev;
 
-	mouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	mouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
-	mouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	mouse->dev.keybit[LONG(BTN_MOUSE)] |= BIT(BTN_SIDE) | BIT(BTN_EXTRA);
-	mouse->dev.relbit[0] |= BIT(REL_WHEEL);
-
-	mouse->dev.private = mouse;
-	mouse->dev.open = usb_mouse_open;
-	mouse->dev.close = usb_mouse_close;
+	mouse->dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	mouse->dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
+	mouse->dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	mouse->dev->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_SIDE) | BIT(BTN_EXTRA);
+	mouse->dev->relbit[0] |= BIT(REL_WHEEL);
+
+	mouse->dev->private = mouse;
+	mouse->dev->open = usb_mouse_open;
+	mouse->dev->close = usb_mouse_close;
 
 	usb_make_path(dev, path, 64);
 	sprintf(mouse->phys, "%s/input0", path);
 
-	mouse->dev.name = mouse->name;
-	mouse->dev.phys = mouse->phys;
-	mouse->dev.id.bustype = BUS_USB;
-	mouse->dev.id.vendor = dev->descriptor.idVendor;
-	mouse->dev.id.product = dev->descriptor.idProduct;
-	mouse->dev.id.version = dev->descriptor.bcdDevice;
+	mouse->dev->name = mouse->name;
+	mouse->dev->phys = mouse->phys;
+	mouse->dev->id.bustype = BUS_USB;
+	mouse->dev->id.vendor = dev->descriptor.idVendor;
+	mouse->dev->id.product = dev->descriptor.idProduct;
+	mouse->dev->id.version = dev->descriptor.bcdDevice;
 
 	if (!(buf = kmalloc(63, GFP_KERNEL))) {
 		usb_buffer_free(dev, 8, mouse->data, mouse->data_dma);
@@ -199,7 +203,7 @@ static int usb_mouse_probe(struct usb_in
 
 	if (!strlen(mouse->name))
 		sprintf(mouse->name, "USB HIDBP Mouse %04x:%04x",
-			mouse->dev.id.vendor, mouse->dev.id.product);
+			mouse->dev->id.vendor, mouse->dev->id.product);
 
 	kfree(buf);
 
@@ -209,7 +213,7 @@ static int usb_mouse_probe(struct usb_in
 	mouse->irq->transfer_dma = mouse->data_dma;
 	mouse->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	input_register_device(&mouse->dev);
+	input_register_device(mouse->dev);
 	printk(KERN_INFO "input: %s on %s\n", mouse->name, path);
 
 	usb_set_intfdata(intf, mouse);
@@ -223,7 +227,7 @@ static void usb_mouse_disconnect(struct 
 	usb_set_intfdata(intf, NULL);
 	if (mouse) {
 		usb_unlink_urb(mouse->irq);
-		input_unregister_device(&mouse->dev);
+		input_unregister_device(mouse->dev);
 		usb_free_urb(mouse->irq);
 		usb_buffer_free(interface_to_usbdev(intf), 8, mouse->data, mouse->data_dma);
 		kfree(mouse);
diff -Nrup -Xdontdiff linux-2.6.0-test5/drivers/usb/input/xpad.c linux-260t5-ic/drivers/usb/input/xpad.c
--- linux-2.6.0-test5/drivers/usb/input/xpad.c	Mon Sep  8 12:50:06 2003
+++ linux-260t5-ic/drivers/usb/input/xpad.c	Wed Sep 10 15:02:46 2003
@@ -102,7 +102,7 @@ static struct usb_device_id xpad_table [
 MODULE_DEVICE_TABLE (usb, xpad_table);
 
 struct usb_xpad {
-	struct input_dev dev;			/* input device interface */
+	struct input_dev *dev;			/* input device interface */
 	struct usb_device *udev;		/* usb device */
 	
 	struct urb *irq_in;			/* urb for interrupt in report */
@@ -236,6 +236,12 @@ static int xpad_probe(struct usb_interfa
 		return -ENOMEM;
 	}
 	memset(xpad, 0, sizeof(struct usb_xpad));
+
+	if ((xpad->dev = kmalloc (sizeof(struct input_dev), GFP_KERNEL)) == NULL) {
+		err("cannot allocate memory for new pad");
+		return -ENOMEM;
+	}
+	memset(xpad->dev, 0, sizeof(struct input_dev));
 	
 	xpad->idata = usb_buffer_alloc(udev, XPAD_PKT_LEN,
 				       SLAB_ATOMIC, &xpad->idata_dma);
@@ -263,20 +269,20 @@ static int xpad_probe(struct usb_interfa
 	
 	xpad->udev = udev;
 	
-	xpad->dev.id.bustype = BUS_USB;
-	xpad->dev.id.vendor = udev->descriptor.idVendor;
-	xpad->dev.id.product = udev->descriptor.idProduct;
-	xpad->dev.id.version = udev->descriptor.bcdDevice;
-	xpad->dev.private = xpad;
-	xpad->dev.name = xpad_device[i].name;
-	xpad->dev.phys = xpad->phys;
-	xpad->dev.open = xpad_open;
-	xpad->dev.close = xpad_close;
+	xpad->dev->id.bustype = BUS_USB;
+	xpad->dev->id.vendor = udev->descriptor.idVendor;
+	xpad->dev->id.product = udev->descriptor.idProduct;
+	xpad->dev->id.version = udev->descriptor.bcdDevice;
+	xpad->dev->private = xpad;
+	xpad->dev->name = xpad_device[i].name;
+	xpad->dev->phys = xpad->phys;
+	xpad->dev->open = xpad_open;
+	xpad->dev->close = xpad_close;
 	
 	usb_make_path(udev, path, 64);
 	snprintf(xpad->phys, 64,  "%s/input0", path);
 	
-	xpad->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	xpad->dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	
 	for (i = 0; xpad_btn[i] >= 0; i++)
 		set_bit(xpad_btn[i], xpad->dev.keybit);
@@ -285,34 +291,34 @@ static int xpad_probe(struct usb_interfa
 		
 		signed short t = xpad_abs[i];
 		
-		set_bit(t, xpad->dev.absbit);
+		set_bit(t, xpad->dev->absbit);
 		
 		switch (t) {
 			case ABS_X:
 			case ABS_Y:
 			case ABS_RX:
 			case ABS_RY:	/* the two sticks */
-				xpad->dev.absmax[t] =  32767;
-				xpad->dev.absmin[t] = -32768;
-				xpad->dev.absflat[t] = 128;
-				xpad->dev.absfuzz[t] = 16;
+				xpad->dev->absmax[t] =  32767;
+				xpad->dev->absmin[t] = -32768;
+				xpad->dev->absflat[t] = 128;
+				xpad->dev->absfuzz[t] = 16;
 				break;
 			case ABS_Z:
 			case ABS_RZ:	/* the triggers */
-				xpad->dev.absmax[t] = 255;
-				xpad->dev.absmin[t] = 0;
+				xpad->dev->absmax[t] = 255;
+				xpad->dev->absmin[t] = 0;
 				break;
 			case ABS_HAT0X:
 			case ABS_HAT0Y:	/* the d-pad */
-				xpad->dev.absmax[t] =  1;
-				xpad->dev.absmin[t] = -1;
+				xpad->dev->absmax[t] =  1;
+				xpad->dev->absmin[t] = -1;
 				break;
 		}
 	}
 	
-	input_register_device(&xpad->dev);
+	input_register_device(xpad->dev);
 	
-	printk(KERN_INFO "input: %s on %s", xpad->dev.name, path);
+	printk(KERN_INFO "input: %s on %s", xpad->dev->name, path);
 	
 	usb_set_intfdata(intf, xpad);
 	return 0;
@@ -325,7 +331,7 @@ static void xpad_disconnect(struct usb_i
 	usb_set_intfdata(intf, NULL);
 	if (xpad) {
 		usb_unlink_urb(xpad->irq_in);
-		input_unregister_device(&xpad->dev);
+		input_unregister_device(xpad->dev);
 		usb_free_urb(xpad->irq_in);
 		usb_buffer_free(interface_to_usbdev(intf), XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
 		kfree(xpad);
diff -Nrup -Xdontdiff linux-2.6.0-test5/include/linux/input.h linux-260t5-ic/include/linux/input.h
--- linux-2.6.0-test5/include/linux/input.h	Mon Sep  8 12:50:03 2003
+++ linux-260t5-ic/include/linux/input.h	Wed Sep 10 15:02:46 2003
@@ -12,12 +12,16 @@
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/device.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
 #include <asm/types.h>
 #endif
 
+#define DEBUG 1
+#define INPUT_DEBUG
+
 /*
  * The event structure itself
  */
@@ -811,6 +815,9 @@ struct input_dev {
 
 	struct list_head	h_list;
 	struct list_head	node;
+
+	struct class_device class_dev;
+	unsigned minor;
 };
 
 /*
@@ -888,6 +895,14 @@ struct input_handle {
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
@@ -902,6 +917,12 @@ void input_unregister_handler(struct inp
 int input_grab_device(struct input_handle *);
 void input_release_device(struct input_handle *);
 
+void input_register_class_dev(struct input_dev *, struct input_class_interface *);
+void input_unregister_class_dev(char *, unsigned );
+
+struct input_dev * input_dev_get(struct input_dev *);
+void input_dev_put(struct input_dev *);
+
 int input_open_device(struct input_handle *);
 void input_close_device(struct input_handle *);
 
diff -Nrup -Xdontdiff linux-2.6.0-test5/lib/kobject.c linux-260t5-ic/lib/kobject.c
--- linux-2.6.0-test5/lib/kobject.c	Mon Sep  8 12:50:27 2003
+++ linux-260t5-ic/lib/kobject.c	Wed Sep 10 15:02:46 2003
@@ -10,7 +10,7 @@
  * about using the kobject interface.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/kobject.h>
 #include <linux/string.h>

