Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVGYG7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVGYG7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVGYFyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:31 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:22655 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261635AbVGYFxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:20 -0400
Message-Id: <20050725054531.608247000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 07/24] input: rearrange procfs code
Content-Disposition: inline; filename=input-proc-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: rearrange procfs code to reduce number of #ifdefs

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |  389 +++++++++++++++++++++++++-------------------------
 1 files changed, 198 insertions(+), 191 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -48,12 +48,6 @@ static LIST_HEAD(input_handler_list);
 
 static struct input_handler *input_table[8];
 
-#ifdef CONFIG_PROC_FS
-static struct proc_dir_entry *proc_bus_input_dir;
-static DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
-static int input_devices_state;
-#endif
-
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct input_handle *handle;
@@ -312,6 +306,7 @@ static struct input_device_id *input_mat
 	return NULL;
 }
 
+
 /*
  * Input hotplugging interface - loading event handlers based on
  * device bitfields.
@@ -428,6 +423,177 @@ static void input_call_hotplug(char *ver
 
 #endif
 
+#ifdef CONFIG_PROC_FS
+
+static struct proc_dir_entry *proc_bus_input_dir;
+static DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
+static int input_devices_state;
+
+static inline void input_wakeup_procfs_readers(void)
+{
+	input_devices_state++;
+	wake_up(&input_devices_poll_wait);
+}
+
+static unsigned int input_devices_poll(struct file *file, poll_table *wait)
+{
+	int state = input_devices_state;
+	poll_wait(file, &input_devices_poll_wait, wait);
+	if (state != input_devices_state)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+#define SPRINTF_BIT_B(bit, name, max) \
+	do { \
+		len += sprintf(buf + len, "B: %s", name); \
+		for (i = NBITS(max) - 1; i >= 0; i--) \
+			if (dev->bit[i]) break; \
+		for (; i >= 0; i--) \
+			len += sprintf(buf + len, "%lx ", dev->bit[i]); \
+		len += sprintf(buf + len, "\n"); \
+	} while (0)
+
+#define SPRINTF_BIT_B2(bit, name, max, ev) \
+	do { \
+		if (test_bit(ev, dev->evbit)) \
+			SPRINTF_BIT_B(bit, name, max); \
+	} while (0)
+
+static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+{
+	struct input_dev *dev;
+	struct input_handle *handle;
+
+	off_t at = 0;
+	int i, len, cnt = 0;
+
+	list_for_each_entry(dev, &input_dev_list, node) {
+
+		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
+			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
+
+		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
+		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
+		len += sprintf(buf + len, "H: Handlers=");
+
+		list_for_each_entry(handle, &dev->h_list, d_node)
+			len += sprintf(buf + len, "%s ", handle->name);
+
+		len += sprintf(buf + len, "\n");
+
+		SPRINTF_BIT_B(evbit, "EV=", EV_MAX);
+		SPRINTF_BIT_B2(keybit, "KEY=", KEY_MAX, EV_KEY);
+		SPRINTF_BIT_B2(relbit, "REL=", REL_MAX, EV_REL);
+		SPRINTF_BIT_B2(absbit, "ABS=", ABS_MAX, EV_ABS);
+		SPRINTF_BIT_B2(mscbit, "MSC=", MSC_MAX, EV_MSC);
+		SPRINTF_BIT_B2(ledbit, "LED=", LED_MAX, EV_LED);
+		SPRINTF_BIT_B2(sndbit, "SND=", SND_MAX, EV_SND);
+		SPRINTF_BIT_B2(ffbit,  "FF=",  FF_MAX, EV_FF);
+
+		len += sprintf(buf + len, "\n");
+
+		at += len;
+
+		if (at >= pos) {
+			if (!*start) {
+				*start = buf + (pos - (at - len));
+				cnt = at - pos;
+			} else  cnt += len;
+			buf += len;
+			if (cnt >= count)
+				break;
+		}
+	}
+
+	if (&dev->node == &input_dev_list)
+		*eof = 1;
+
+	return (count > cnt) ? cnt : count;
+}
+
+static int input_handlers_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+{
+	struct input_handler *handler;
+
+	off_t at = 0;
+	int len = 0, cnt = 0;
+	int i = 0;
+
+	list_for_each_entry(handler, &input_handler_list, node) {
+
+		if (handler->fops)
+			len = sprintf(buf, "N: Number=%d Name=%s Minor=%d\n",
+				i++, handler->name, handler->minor);
+		else
+			len = sprintf(buf, "N: Number=%d Name=%s\n",
+				i++, handler->name);
+
+		at += len;
+
+		if (at >= pos) {
+			if (!*start) {
+				*start = buf + (pos - (at - len));
+				cnt = at - pos;
+			} else  cnt += len;
+			buf += len;
+			if (cnt >= count)
+				break;
+		}
+	}
+	if (&handler->node == &input_handler_list)
+		*eof = 1;
+
+	return (count > cnt) ? cnt : count;
+}
+
+static struct file_operations input_fileops;
+
+static int __init input_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	proc_bus_input_dir = proc_mkdir("input", proc_bus);
+	if (!proc_bus_input_dir)
+		return -ENOMEM;
+
+	proc_bus_input_dir->owner = THIS_MODULE;
+
+	entry = create_proc_read_entry("devices", 0, proc_bus_input_dir, input_devices_read, NULL);
+	if (!entry)
+		goto fail1;
+
+	entry->owner = THIS_MODULE;
+	input_fileops = *entry->proc_fops;
+	entry->proc_fops = &input_fileops;
+	entry->proc_fops->poll = input_devices_poll;
+
+	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
+	if (!entry)
+		goto fail2;
+
+	entry->owner = THIS_MODULE;
+
+	return 0;
+
+ fail2:	remove_proc_entry("devices", proc_bus_input_dir);
+ fail1: remove_proc_entry("input", proc_bus);
+	return -ENOMEM;
+}
+
+static void __exit input_proc_exit(void)
+{
+	remove_proc_entry("devices", proc_bus_input_dir);
+	remove_proc_entry("handlers", proc_bus_input_dir);
+	remove_proc_entry("input", proc_bus);
+}
+
+#else /* !CONFIG_PROC_FS */
+static inline void input_wakeup_procfs_readers(void) { }
+static inline int input_proc_init(void) { return 0; }
+static inline void input_proc_exit(void) { }
+#endif
+
 void input_register_device(struct input_dev *dev)
 {
 	struct input_handle *handle;
@@ -464,10 +630,7 @@ void input_register_device(struct input_
 	input_call_hotplug("add", dev);
 #endif
 
-#ifdef CONFIG_PROC_FS
-	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
-#endif
+	input_wakeup_procfs_readers();
 }
 
 void input_unregister_device(struct input_dev *dev)
@@ -491,10 +654,7 @@ void input_unregister_device(struct inpu
 
 	list_del_init(&dev->node);
 
-#ifdef CONFIG_PROC_FS
-	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
-#endif
+	input_wakeup_procfs_readers();
 }
 
 void input_register_handler(struct input_handler *handler)
@@ -518,10 +678,7 @@ void input_register_handler(struct input
 				if ((handle = handler->connect(handler, dev, id)))
 					input_link_handle(handle);
 
-#ifdef CONFIG_PROC_FS
-	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
-#endif
+	input_wakeup_procfs_readers();
 }
 
 void input_unregister_handler(struct input_handler *handler)
@@ -540,10 +697,7 @@ void input_unregister_handler(struct inp
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = NULL;
 
-#ifdef CONFIG_PROC_FS
-	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
-#endif
+	input_wakeup_procfs_readers();
 }
 
 static int input_open_file(struct inode *inode, struct file *file)
@@ -582,190 +736,43 @@ static struct file_operations input_fops
 	.open = input_open_file,
 };
 
-#ifdef CONFIG_PROC_FS
-
-#define SPRINTF_BIT_B(bit, name, max) \
-	do { \
-		len += sprintf(buf + len, "B: %s", name); \
-		for (i = NBITS(max) - 1; i >= 0; i--) \
-			if (dev->bit[i]) break; \
-		for (; i >= 0; i--) \
-			len += sprintf(buf + len, "%lx ", dev->bit[i]); \
-		len += sprintf(buf + len, "\n"); \
-	} while (0)
-
-#define SPRINTF_BIT_B2(bit, name, max, ev) \
-	do { \
-		if (test_bit(ev, dev->evbit)) \
-			SPRINTF_BIT_B(bit, name, max); \
-	} while (0)
-
-
-static unsigned int input_devices_poll(struct file *file, poll_table *wait)
-{
-	int state = input_devices_state;
-	poll_wait(file, &input_devices_poll_wait, wait);
-	if (state != input_devices_state)
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
+struct class *input_class;
 
-static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+static int __init input_init(void)
 {
-	struct input_dev *dev;
-	struct input_handle *handle;
-
-	off_t at = 0;
-	int i, len, cnt = 0;
-
-	list_for_each_entry(dev, &input_dev_list, node) {
-
-		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
-			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
-
-		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
-		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
-		len += sprintf(buf + len, "H: Handlers=");
-
-		list_for_each_entry(handle, &dev->h_list, d_node)
-			len += sprintf(buf + len, "%s ", handle->name);
-
-		len += sprintf(buf + len, "\n");
-
-		SPRINTF_BIT_B(evbit, "EV=", EV_MAX);
-		SPRINTF_BIT_B2(keybit, "KEY=", KEY_MAX, EV_KEY);
-		SPRINTF_BIT_B2(relbit, "REL=", REL_MAX, EV_REL);
-		SPRINTF_BIT_B2(absbit, "ABS=", ABS_MAX, EV_ABS);
-		SPRINTF_BIT_B2(mscbit, "MSC=", MSC_MAX, EV_MSC);
-		SPRINTF_BIT_B2(ledbit, "LED=", LED_MAX, EV_LED);
-		SPRINTF_BIT_B2(sndbit, "SND=", SND_MAX, EV_SND);
-		SPRINTF_BIT_B2(ffbit,  "FF=",  FF_MAX, EV_FF);
-
-		len += sprintf(buf + len, "\n");
-
-		at += len;
+	int err;
 
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else  cnt += len;
-			buf += len;
-			if (cnt >= count)
-				break;
-		}
+	input_class = class_create(THIS_MODULE, "input");
+	if (IS_ERR(input_class)) {
+		printk(KERN_ERR "input: unable to register input class\n");
+		return PTR_ERR(input_class);
 	}
 
-	if (&dev->node == &input_dev_list)
-		*eof = 1;
-
-	return (count > cnt) ? cnt : count;
-}
-
-static int input_handlers_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
-{
-	struct input_handler *handler;
-
-	off_t at = 0;
-	int len = 0, cnt = 0;
-	int i = 0;
-
-	list_for_each_entry(handler, &input_handler_list, node) {
-
-		if (handler->fops)
-			len = sprintf(buf, "N: Number=%d Name=%s Minor=%d\n",
-				i++, handler->name, handler->minor);
-		else
-			len = sprintf(buf, "N: Number=%d Name=%s\n",
-				i++, handler->name);
-
-		at += len;
+	err = input_proc_init();
+	if (err)
+		goto fail1;
 
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else  cnt += len;
-			buf += len;
-			if (cnt >= count)
-				break;
-		}
+	err = register_chrdev(INPUT_MAJOR, "input", &input_fops);
+	if (err) {
+		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
+		goto fail2;
 	}
-	if (&handler->node == &input_handler_list)
-		*eof = 1;
 
-	return (count > cnt) ? cnt : count;
-}
-
-static struct file_operations input_fileops;
-
-static int __init input_proc_init(void)
-{
-	struct proc_dir_entry *entry;
+	err = devfs_mk_dir("input");
+	if (err)
+		goto fail3;
 
-	proc_bus_input_dir = proc_mkdir("input", proc_bus);
-	if (proc_bus_input_dir == NULL)
-		return -ENOMEM;
-	proc_bus_input_dir->owner = THIS_MODULE;
-	entry = create_proc_read_entry("devices", 0, proc_bus_input_dir, input_devices_read, NULL);
-	if (entry == NULL) {
-		remove_proc_entry("input", proc_bus);
-		return -ENOMEM;
-	}
-	entry->owner = THIS_MODULE;
-	input_fileops = *entry->proc_fops;
-	entry->proc_fops = &input_fileops;
-	entry->proc_fops->poll = input_devices_poll;
-	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
-	if (entry == NULL) {
-		remove_proc_entry("devices", proc_bus_input_dir);
-		remove_proc_entry("input", proc_bus);
-		return -ENOMEM;
-	}
-	entry->owner = THIS_MODULE;
 	return 0;
-}
-#else /* !CONFIG_PROC_FS */
-static inline int input_proc_init(void) { return 0; }
-#endif
-
-struct class *input_class;
-
-static int __init input_init(void)
-{
-	int retval = -ENOMEM;
 
-	input_class = class_create(THIS_MODULE, "input");
-	if (IS_ERR(input_class))
-		return PTR_ERR(input_class);
-	input_proc_init();
-	retval = register_chrdev(INPUT_MAJOR, "input", &input_fops);
-	if (retval) {
-		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
-		remove_proc_entry("devices", proc_bus_input_dir);
-		remove_proc_entry("handlers", proc_bus_input_dir);
-		remove_proc_entry("input", proc_bus);
-		class_destroy(input_class);
-		return retval;
-	}
-
-	retval = devfs_mk_dir("input");
-	if (retval) {
-		remove_proc_entry("devices", proc_bus_input_dir);
-		remove_proc_entry("handlers", proc_bus_input_dir);
-		remove_proc_entry("input", proc_bus);
-		unregister_chrdev(INPUT_MAJOR, "input");
-		class_destroy(input_class);
-	}
-	return retval;
+ fail3:	unregister_chrdev(INPUT_MAJOR, "input");
+ fail2:	input_proc_exit();
+ fail1:	class_destroy(input_class);
+	return err;
 }
 
 static void __exit input_exit(void)
 {
-	remove_proc_entry("devices", proc_bus_input_dir);
-	remove_proc_entry("handlers", proc_bus_input_dir);
-	remove_proc_entry("input", proc_bus);
-
+	input_proc_exit();
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_destroy(input_class);

