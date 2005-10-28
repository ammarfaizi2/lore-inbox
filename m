Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVJ1Gdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVJ1Gdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVJ1Gb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:43242 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965142AbVJ1GbX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:23 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: export input_dev data via sysfs attributes
In-Reply-To: <11304810263972@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810264196@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: export input_dev data via sysfs attributes

Input: export various input device attributes via sysfs

The following structure is exported:

  input0/
	|-- name
	|-- phys
	|-- uniq
	|-- id/{bustype|vendor|product|version}
	`-- capabilities/{ev|abs|rel|key|led|msc|ff|sw}

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3792257a4fef9c098e39d2268fd31faf52b69200
tree 4678a7b8402693ce23c3af4cd1bcdc0dc7749b8a
parent 2870664a166086db34c99dfa2fc15e881131b45b
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:55 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |  156 ++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 133 insertions(+), 23 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ceaed63..57fbfd9 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -434,6 +434,23 @@ static void input_call_hotplug(char *ver
 
 #endif
 
+static int input_print_bitmap(char *buf, unsigned long *bitmap, int max)
+{
+	int i;
+	int len = 0;
+
+	for (i = NBITS(max) - 1; i > 0; i--)
+		if (bitmap[i])
+			break;
+
+	for (; i >= 0; i--)
+		len += sprintf(buf + len, "%lx%s", bitmap[i], i > 0 ? " " : "");
+
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
 #ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry *proc_bus_input_dir;
@@ -455,20 +472,17 @@ static unsigned int input_devices_poll(s
 	return 0;
 }
 
-#define SPRINTF_BIT_B(bit, name, max) \
-	do { \
-		len += sprintf(buf + len, "B: %s", name); \
-		for (i = NBITS(max) - 1; i >= 0; i--) \
-			if (dev->bit[i]) break; \
-		for (; i >= 0; i--) \
-			len += sprintf(buf + len, "%lx ", dev->bit[i]); \
-		len += sprintf(buf + len, "\n"); \
+#define SPRINTF_BIT_B(ev, bm)						\
+	do {								\
+		len += sprintf(buf + len, "B: %s=", #ev);		\
+		len += input_print_bitmap(buf + len,			\
+					dev->bm##bit, ev##_MAX);	\
 	} while (0)
 
-#define SPRINTF_BIT_B2(bit, name, max, ev) \
-	do { \
-		if (test_bit(ev, dev->evbit)) \
-			SPRINTF_BIT_B(bit, name, max); \
+#define SPRINTF_BIT_B2(ev, bm)						\
+	do {								\
+		if (test_bit(EV_##ev, dev->evbit))			\
+			SPRINTF_BIT_B(ev, bm);				\
 	} while (0)
 
 static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
@@ -478,7 +492,7 @@ static int input_devices_read(char *buf,
 	const char *path;
 
 	off_t at = 0;
-	int i, len, cnt = 0;
+	int len, cnt = 0;
 
 	list_for_each_entry(dev, &input_dev_list, node) {
 
@@ -497,15 +511,15 @@ static int input_devices_read(char *buf,
 
 		len += sprintf(buf + len, "\n");
 
-		SPRINTF_BIT_B(evbit, "EV=", EV_MAX);
-		SPRINTF_BIT_B2(keybit, "KEY=", KEY_MAX, EV_KEY);
-		SPRINTF_BIT_B2(relbit, "REL=", REL_MAX, EV_REL);
-		SPRINTF_BIT_B2(absbit, "ABS=", ABS_MAX, EV_ABS);
-		SPRINTF_BIT_B2(mscbit, "MSC=", MSC_MAX, EV_MSC);
-		SPRINTF_BIT_B2(ledbit, "LED=", LED_MAX, EV_LED);
-		SPRINTF_BIT_B2(sndbit, "SND=", SND_MAX, EV_SND);
-		SPRINTF_BIT_B2(ffbit,  "FF=",  FF_MAX, EV_FF);
-		SPRINTF_BIT_B2(swbit,  "SW=",  SW_MAX, EV_SW);
+		SPRINTF_BIT_B(EV, ev);
+		SPRINTF_BIT_B2(KEY, key);
+		SPRINTF_BIT_B2(REL, rel);
+		SPRINTF_BIT_B2(ABS, abs);
+		SPRINTF_BIT_B2(MSC, msc);
+		SPRINTF_BIT_B2(LED, led);
+		SPRINTF_BIT_B2(SND, snd);
+		SPRINTF_BIT_B2(FF, ff);
+		SPRINTF_BIT_B2(SW, sw);
 
 		len += sprintf(buf + len, "\n");
 
@@ -612,6 +626,96 @@ static inline int input_proc_init(void) 
 static inline void input_proc_exit(void) { }
 #endif
 
+#define INPUT_DEV_STRING_ATTR_SHOW(name)					\
+static ssize_t input_dev_show_##name(struct class_device *dev, char *buf)	\
+{										\
+	struct input_dev *input_dev = to_input_dev(dev);			\
+	int retval;								\
+										\
+	retval = down_interruptible(&input_dev->sem);				\
+	if (retval)								\
+		return retval;							\
+										\
+	retval = sprintf(buf, "%s\n", input_dev->name ? input_dev->name : "");	\
+										\
+	up(&input_dev->sem);							\
+										\
+	return retval;								\
+}
+
+INPUT_DEV_STRING_ATTR_SHOW(name);
+INPUT_DEV_STRING_ATTR_SHOW(phys);
+INPUT_DEV_STRING_ATTR_SHOW(uniq);
+
+static struct class_device_attribute input_dev_attrs[] = {
+	__ATTR(name, S_IRUGO, input_dev_show_name, NULL),
+	__ATTR(phys, S_IRUGO, input_dev_show_phys, NULL),
+	__ATTR(uniq, S_IRUGO, input_dev_show_uniq, NULL),
+	__ATTR_NULL
+};
+
+#define INPUT_DEV_ID_ATTR(name)							\
+static ssize_t input_dev_show_id_##name(struct class_device *dev, char *buf)	\
+{										\
+	struct input_dev *input_dev = to_input_dev(dev);			\
+	return sprintf(buf, "%04x\n", input_dev->id.name);			\
+}										\
+static CLASS_DEVICE_ATTR(name, S_IRUGO, input_dev_show_id_##name, NULL);
+
+INPUT_DEV_ID_ATTR(bustype);
+INPUT_DEV_ID_ATTR(vendor);
+INPUT_DEV_ID_ATTR(product);
+INPUT_DEV_ID_ATTR(version);
+
+static struct attribute *input_dev_id_attrs[] = {
+	&class_device_attr_bustype.attr,
+	&class_device_attr_vendor.attr,
+	&class_device_attr_product.attr,
+	&class_device_attr_version.attr,
+	NULL
+};
+
+static struct attribute_group input_dev_id_attr_group = {
+	.name	= "id",
+	.attrs	= input_dev_id_attrs,
+};
+
+#define INPUT_DEV_CAP_ATTR(ev, bm)						\
+static ssize_t input_dev_show_cap_##bm(struct class_device *dev, char *buf)	\
+{										\
+	struct input_dev *input_dev = to_input_dev(dev);			\
+	return input_print_bitmap(buf, input_dev->bm##bit, ev##_MAX);		\
+}										\
+static CLASS_DEVICE_ATTR(bm, S_IRUGO, input_dev_show_cap_##bm, NULL);
+
+INPUT_DEV_CAP_ATTR(EV, ev);
+INPUT_DEV_CAP_ATTR(KEY, key);
+INPUT_DEV_CAP_ATTR(REL, rel);
+INPUT_DEV_CAP_ATTR(ABS, abs);
+INPUT_DEV_CAP_ATTR(MSC, msc);
+INPUT_DEV_CAP_ATTR(LED, led);
+INPUT_DEV_CAP_ATTR(SND, snd);
+INPUT_DEV_CAP_ATTR(FF, ff);
+INPUT_DEV_CAP_ATTR(SW, sw);
+
+static struct attribute *input_dev_caps_attrs[] = {
+	&class_device_attr_ev.attr,
+	&class_device_attr_key.attr,
+	&class_device_attr_rel.attr,
+	&class_device_attr_abs.attr,
+	&class_device_attr_msc.attr,
+	&class_device_attr_led.attr,
+	&class_device_attr_snd.attr,
+	&class_device_attr_ff.attr,
+	&class_device_attr_sw.attr,
+	NULL
+};
+
+static struct attribute_group input_dev_caps_attr_group = {
+	.name	= "capabilities",
+	.attrs	= input_dev_caps_attrs,
+};
+
 static void input_dev_release(struct class_device *class_dev)
 {
 	struct input_dev *dev = to_input_dev(class_dev);
@@ -623,6 +727,7 @@ static void input_dev_release(struct cla
 static struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
+	.class_dev_attrs	= input_dev_attrs,
 };
 
 struct input_dev *input_allocate_device(void)
@@ -660,6 +765,8 @@ static void input_register_classdevice(s
 	kfree(path);
 
 	class_device_add(&dev->cdev);
+	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 }
 
 void input_register_device(struct input_dev *dev)
@@ -726,8 +833,11 @@ void input_unregister_device(struct inpu
 
 	list_del_init(&dev->node);
 
-	if (dev->dynalloc)
+	if (dev->dynalloc) {
+		sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+		sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
 		class_device_unregister(&dev->cdev);
+	}
 
 	input_wakeup_procfs_readers();
 }

