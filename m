Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVIOHEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVIOHEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVIOHEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:35 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:9661 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030433AbVIOHEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:14 -0400
Message-Id: <20050915070305.708994000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 27/28] Input: convert input handlers to class interfaces
Content-Disposition: inline; filename=input-handlers-as-interfaces.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert input handlers to class interfaces

Thit is exactly why class interfaces were created - to provide
several different 'views' for the same hardware.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |  455 +++++++++++++++++++++++++-------------------------
 include/linux/input.h |    8 
 2 files changed, 232 insertions(+), 231 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -49,9 +49,6 @@ static struct class input_class = {
 	.name	= "input",
 };
 
-static LIST_HEAD(input_dev_list);
-static LIST_HEAD(input_handler_list);
-
 static struct input_handler *input_table[8];
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -271,12 +268,6 @@ void input_close_device(struct input_han
 	up(&dev->sem);
 }
 
-static void input_link_handle(struct input_handle *handle)
-{
-	list_add_tail(&handle->d_node, &handle->dev->h_list);
-	list_add_tail(&handle->h_node, &handle->handler->h_list);
-}
-
 #define MATCH_BIT(bit, max) \
 		for (i = 0; i < NBITS(max); i++) \
 			if ((id->bit[i] & dev->bit[i]) != id->bit[i]) \
@@ -337,182 +328,6 @@ static int input_print_bitmap(char *buf,
 	return len;
 }
 
-#ifdef CONFIG_PROC_FS
-
-static struct proc_dir_entry *proc_bus_input_dir;
-static DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
-static int input_devices_state;
-
-static inline void input_wakeup_procfs_readers(void)
-{
-	input_devices_state++;
-	wake_up(&input_devices_poll_wait);
-}
-
-static unsigned int input_devices_poll(struct file *file, poll_table *wait)
-{
-	int state = input_devices_state;
-	poll_wait(file, &input_devices_poll_wait, wait);
-	if (state != input_devices_state)
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
-
-#define SPRINTF_BIT(ev, bm)						\
-	do {								\
-		len += sprintf(buf + len, "B: %s=", #ev);		\
-		len += input_print_bitmap(buf + len, INT_MAX,		\
-					dev->bm##bit, ev##_MAX);	\
-		len += sprintf(buf + len, "\n");			\
-	} while (0)
-
-#define TEST_AND_SPRINTF_BIT(ev, bm)					\
-	do {								\
-		if (test_bit(EV_##ev, dev->evbit))			\
-			SPRINTF_BIT(ev, bm);				\
-	} while (0)
-
-static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
-{
-	struct input_dev *dev;
-	struct input_handle *handle;
-	const char *path;
-
-	off_t at = 0;
-	int len, cnt = 0;
-
-	list_for_each_entry(dev, &input_dev_list, node) {
-
-		path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
-
-		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
-			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
-
-		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
-		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
-		len += sprintf(buf + len, "S: Sysfs=%s\n", path ? path : "");
-		len += sprintf(buf + len, "H: Handlers=");
-
-		list_for_each_entry(handle, &dev->h_list, d_node)
-			len += sprintf(buf + len, "%s ", handle->name);
-
-		len += sprintf(buf + len, "\n");
-
-		SPRINTF_BIT(EV, ev);
-		TEST_AND_SPRINTF_BIT(KEY, key);
-		TEST_AND_SPRINTF_BIT(REL, rel);
-		TEST_AND_SPRINTF_BIT(ABS, abs);
-		TEST_AND_SPRINTF_BIT(MSC, msc);
-		TEST_AND_SPRINTF_BIT(LED, led);
-		TEST_AND_SPRINTF_BIT(SND, snd);
-		TEST_AND_SPRINTF_BIT(FF, ff);
-		TEST_AND_SPRINTF_BIT(SW, sw);
-
-		len += sprintf(buf + len, "\n");
-
-		at += len;
-
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else  cnt += len;
-			buf += len;
-			if (cnt >= count)
-				break;
-		}
-
-		kfree(path);
-	}
-
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
-
-		if (at >= pos) {
-			if (!*start) {
-				*start = buf + (pos - (at - len));
-				cnt = at - pos;
-			} else  cnt += len;
-			buf += len;
-			if (cnt >= count)
-				break;
-		}
-	}
-	if (&handler->node == &input_handler_list)
-		*eof = 1;
-
-	return (count > cnt) ? cnt : count;
-}
-
-static struct file_operations input_fileops;
-
-static int __init input_proc_init(void)
-{
-	struct proc_dir_entry *entry;
-
-	proc_bus_input_dir = proc_mkdir("input", proc_bus);
-	if (!proc_bus_input_dir)
-		return -ENOMEM;
-
-	proc_bus_input_dir->owner = THIS_MODULE;
-
-	entry = create_proc_read_entry("devices", 0, proc_bus_input_dir, input_devices_read, NULL);
-	if (!entry)
-		goto fail1;
-
-	entry->owner = THIS_MODULE;
-	input_fileops = *entry->proc_fops;
-	entry->proc_fops = &input_fileops;
-	entry->proc_fops->poll = input_devices_poll;
-
-	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
-	if (!entry)
-		goto fail2;
-
-	entry->owner = THIS_MODULE;
-
-	return 0;
-
- fail2:	remove_proc_entry("devices", proc_bus_input_dir);
- fail1: remove_proc_entry("input", proc_bus);
-	return -ENOMEM;
-}
-
-static void input_proc_exit(void)
-{
-	remove_proc_entry("devices", proc_bus_input_dir);
-	remove_proc_entry("handlers", proc_bus_input_dir);
-	remove_proc_entry("input", proc_bus);
-}
-
-#else /* !CONFIG_PROC_FS */
-static inline void input_wakeup_procfs_readers(void) { }
-static inline int input_proc_init(void) { return 0; }
-static inline void input_proc_exit(void) { }
-#endif
-
 #define INPUT_DEV_STRING_ATTR_SHOW(name)					\
 static ssize_t input_dev_show_##name(struct class_device *dev, char *buf)	\
 {										\
@@ -710,6 +525,188 @@ static struct class input_dev_class = {
 	.class_dev_attrs	= input_dev_attrs,
 };
 
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
+#define SPRINTF_BIT(ev, bm)						\
+	do {								\
+		len += sprintf(buf + len, "B: %s=", #ev);		\
+		len += input_print_bitmap(buf + len, INT_MAX,		\
+					dev->bm##bit, ev##_MAX);	\
+		len += sprintf(buf + len, "\n");			\
+	} while (0)
+
+#define TEST_AND_SPRINTF_BIT(ev, bm)					\
+	do {								\
+		if (test_bit(EV_##ev, dev->evbit))			\
+			SPRINTF_BIT(ev, bm);				\
+	} while (0)
+
+static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+{
+	struct list_head *node;
+	struct input_dev *dev;
+	struct input_handle *handle;
+	const char *path;
+
+	off_t at = 0;
+	int len, cnt = 0;
+
+	list_for_each(node, &input_dev_class.children) {
+
+		dev = to_input_dev(container_of(node, struct class_device, node));
+		path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
+
+		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
+			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
+
+		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
+		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
+		len += sprintf(buf + len, "S: Sysfs=%s\n", path ? path : "");
+		len += sprintf(buf + len, "H: Handlers=");
+
+		list_for_each_entry(handle, &dev->h_list, d_node)
+			len += sprintf(buf + len, "%s ", handle->name);
+
+		len += sprintf(buf + len, "\n");
+
+		SPRINTF_BIT(EV, ev);
+		TEST_AND_SPRINTF_BIT(KEY, key);
+		TEST_AND_SPRINTF_BIT(REL, rel);
+		TEST_AND_SPRINTF_BIT(ABS, abs);
+		TEST_AND_SPRINTF_BIT(MSC, msc);
+		TEST_AND_SPRINTF_BIT(LED, led);
+		TEST_AND_SPRINTF_BIT(SND, snd);
+		TEST_AND_SPRINTF_BIT(FF, ff);
+		TEST_AND_SPRINTF_BIT(SW, sw);
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
+
+		kfree(path);
+	}
+
+	if (node == &input_dev_class.children)
+		*eof = 1;
+
+	return (count > cnt) ? cnt : count;
+}
+
+static int input_handlers_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+{
+	struct list_head *node;
+	struct input_handler *handler;
+
+	off_t at = 0;
+	int len = 0, cnt = 0;
+	int i = 0;
+
+	list_for_each(node, &input_dev_class.interfaces) {
+
+		handler = to_input_handler(container_of(node, struct class_interface, node));
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
+
+	if (node == &input_dev_class.interfaces)
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
+static void input_proc_exit(void)
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
 struct input_dev *input_allocate_device(void)
 {
 	struct input_dev *dev;
@@ -718,7 +715,6 @@ struct input_dev *input_allocate_device(
 	if (dev) {
 		dev->dynalloc = 1;
 		INIT_LIST_HEAD(&dev->h_list);
-		INIT_LIST_HEAD(&dev->node);
 	}
 
 	return dev;
@@ -727,9 +723,6 @@ struct input_dev *input_allocate_device(
 int input_register_device(struct input_dev *dev)
 {
 	static atomic_t input_no = ATOMIC_INIT(0);
-	struct input_handle *handle;
-	struct input_handler *handler;
-	struct input_device_id *id;
 	const char *path;
 	int error;
 
@@ -757,13 +750,6 @@ int input_register_device(struct input_d
 	}
 
 	INIT_LIST_HEAD(&dev->h_list);
-	list_add_tail(&dev->node, &input_dev_list);
-
-	list_for_each_entry(handler, &input_handler_list, node)
-		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
-			if ((id = input_match_device(handler->id_table, dev)))
-				if ((handle = handler->connect(handler, dev, id)))
-					input_link_handle(handle);
 
 	dev->cdev.class = &input_dev_class;
 	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
@@ -799,19 +785,8 @@ int input_register_device(struct input_d
 
 void input_unregister_device(struct input_dev *dev)
 {
-	struct list_head * node, * next;
-
 	del_timer_sync(&dev->timer);
 
-	list_for_each_safe(node, next, &dev->h_list) {
-		struct input_handle * handle = to_handle(node);
-		list_del_init(&handle->d_node);
-		list_del_init(&handle->h_node);
-		handle->handler->disconnect(handle);
-	}
-
-	list_del_init(&dev->node);
-
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
 	class_device_unregister(&dev->cdev);
@@ -819,46 +794,72 @@ void input_unregister_device(struct inpu
 	input_wakeup_procfs_readers();
 }
 
-void input_register_handler(struct input_handler *handler)
+static int input_handler_add_device(struct class_device *cdev, struct class_interface *intf)
 {
-	struct input_dev *dev;
+	struct input_dev *dev = to_input_dev(cdev);
+	struct input_handler *handler = to_input_handler(intf);
 	struct input_handle *handle;
 	struct input_device_id *id;
 
-	if (!handler) return;
+	if (!handler->blacklist || !input_match_device(handler->blacklist, dev)) {
+		id = input_match_device(handler->id_table, dev);
+		if (id) {
+			handle = handler->connect(handler, dev, id);
+			if (handle) {
+				list_add_tail(&handle->d_node, &dev->h_list);
+				list_add_tail(&handle->h_node, &handler->h_list);
+				return 0;
+			}
+		}
+	}
+
+	return -ENODEV;
+}
+
+static void input_handler_remove_device(struct class_device *cdev, struct class_interface *intf)
+{
+	struct input_dev *dev = to_input_dev(cdev);
+	struct input_handler *handler = to_input_handler(intf);
+	struct input_handle *handle, *next;
+
+	list_for_each_entry_safe(handle, next, &dev->h_list, d_node) {
+		if (handle->handler == handler) {
+			list_del_init(&handle->h_node);
+			list_del_init(&handle->d_node);
+			handler->disconnect(handle);
+		}
+	}
+}
+
+int input_register_handler(struct input_handler *handler)
+{
+	int error;
 
 	INIT_LIST_HEAD(&handler->h_list);
 
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = handler;
 
-	list_add_tail(&handler->node, &input_handler_list);
+	handler->intf.class = &input_dev_class;
+	handler->intf.add = input_handler_add_device;
+	handler->intf.remove = input_handler_remove_device;
 
-	list_for_each_entry(dev, &input_dev_list, node)
-		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
-			if ((id = input_match_device(handler->id_table, dev)))
-				if ((handle = handler->connect(handler, dev, id)))
-					input_link_handle(handle);
+	error = class_interface_register(&handler->intf);
+	if (error)
+		return error;
 
 	input_wakeup_procfs_readers();
+
+	return 0;
 }
 
 void input_unregister_handler(struct input_handler *handler)
 {
-	struct list_head * node, * next;
-
-	list_for_each_safe(node, next, &handler->h_list) {
-		struct input_handle * handle = to_handle_h(node);
-		list_del_init(&handle->h_node);
-		list_del_init(&handle->d_node);
-		handler->disconnect(handle);
-	}
-
-	list_del_init(&handler->node);
-
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = NULL;
 
+	class_interface_unregister(&handler->intf);
+
 	input_wakeup_procfs_readers();
 }
 
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -895,7 +895,6 @@ struct input_dev {
 	int dynalloc;	/* temporarily */
 
 	struct list_head	h_list;
-	struct list_head	node;
 };
 #define to_input_dev(d) container_of(d, struct input_dev, cdev)
 
@@ -960,8 +959,10 @@ struct input_handler {
 	struct input_device_id *blacklist;
 
 	struct list_head	h_list;
-	struct list_head	node;
+
+	struct class_interface intf;
 };
+#define to_input_handler(h) container_of(h, struct input_handler, intf)
 
 struct input_handle {
 
@@ -986,7 +987,6 @@ struct input_handle {
 static inline void init_input_dev(struct input_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->h_list);
-	INIT_LIST_HEAD(&dev->node);
 }
 
 struct input_dev *input_allocate_device(void);
@@ -1009,7 +1009,7 @@ static inline void input_put_device(stru
 int input_register_device(struct input_dev *);
 void input_unregister_device(struct input_dev *);
 
-void input_register_handler(struct input_handler *);
+int input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
 
 int input_create_interface_device(struct input_handle *, dev_t);

