Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVIOHRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVIOHRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVIOHQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:16:56 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:32680 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030436AbVIOHQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:16:01 -0400
Message-Id: <20050915064946.441302000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 26/28] input core: remove custom-made hotplug handler
Content-Disposition: inline; filename=input-sysfs-hotplug.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: remove custom-made hotplug handler

Now that all input devices are registered with sysfs we can remove
old custom-made hotplug handler and crate a standard one.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |  255 +++++++++++++++++++++-----------------------------
 1 files changed, 110 insertions(+), 145 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -322,125 +322,7 @@ static struct input_device_id *input_mat
 	return NULL;
 }
 
-
-/*
- * Input hotplugging interface - loading event handlers based on
- * device bitfields.
- */
-
-#ifdef CONFIG_HOTPLUG
-
-/*
- * Input hotplugging invokes what /proc/sys/kernel/hotplug says
- * (normally /sbin/hotplug) when input devices get added or removed.
- *
- * This invokes a user mode policy agent, typically helping to load driver
- * or other modules, configure the device, and more.  Drivers can provide
- * a MODULE_DEVICE_TABLE to help with module loading subtasks.
- *
- */
-
-#define SPRINTF_BIT_A(bit, name, max) \
-	do { \
-		envp[i++] = scratch; \
-		scratch += sprintf(scratch, name); \
-		for (j = NBITS(max) - 1; j >= 0; j--) \
-			if (dev->bit[j]) break; \
-		for (; j >= 0; j--) \
-			scratch += sprintf(scratch, "%lx ", dev->bit[j]); \
-		scratch++; \
-	} while (0)
-
-#define SPRINTF_BIT_A2(bit, name, max, ev) \
-	do { \
-		if (test_bit(ev, dev->evbit)) \
-			SPRINTF_BIT_A(bit, name, max); \
-	} while (0)
-
-static void input_call_hotplug(char *verb, struct input_dev *dev)
-{
-	char *argv[3], **envp, *buf, *scratch;
-	int i = 0, j, value;
-
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
-
-	envp[i++] = scratch;
-	scratch += sprintf(scratch, "PRODUCT=%x/%x/%x/%x",
-		dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version) + 1;
-
-	if (dev->name) {
-		envp[i++] = scratch;
-		scratch += sprintf(scratch, "NAME=%s", dev->name) + 1;
-	}
-
-	if (dev->phys) {
-		envp[i++] = scratch;
-		scratch += sprintf(scratch, "PHYS=%s", dev->phys) + 1;
-	}
-
-	SPRINTF_BIT_A(evbit, "EV=", EV_MAX);
-	SPRINTF_BIT_A2(keybit, "KEY=", KEY_MAX, EV_KEY);
-	SPRINTF_BIT_A2(relbit, "REL=", REL_MAX, EV_REL);
-	SPRINTF_BIT_A2(absbit, "ABS=", ABS_MAX, EV_ABS);
-	SPRINTF_BIT_A2(mscbit, "MSC=", MSC_MAX, EV_MSC);
-	SPRINTF_BIT_A2(ledbit, "LED=", LED_MAX, EV_LED);
-	SPRINTF_BIT_A2(sndbit, "SND=", SND_MAX, EV_SND);
-	SPRINTF_BIT_A2(ffbit,  "FF=",  FF_MAX, EV_FF);
-	SPRINTF_BIT_A2(swbit,  "SW=",  SW_MAX, EV_SW);
-
-	envp[i++] = NULL;
-
-#ifdef INPUT_DEBUG
-	printk(KERN_DEBUG "input.c: calling %s %s [%s %s %s %s %s]\n",
-		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
-#endif
-
-	value = call_usermodehelper(argv [0], argv, envp, 0);
-
-	kfree(buf);
-	kfree(envp);
-
-#ifdef INPUT_DEBUG
-	if (value != 0)
-		printk(KERN_DEBUG "input.c: hotplug returned %d\n", value);
-#endif
-}
-
-#endif
-
-static int input_print_bitmap(char *buf, unsigned long *bitmap, int max)
+static int input_print_bitmap(char *buf, int buf_size, unsigned long *bitmap, int max)
 {
 	int i;
 	int len = 0;
@@ -450,10 +332,8 @@ static int input_print_bitmap(char *buf,
 			break;
 
 	for (; i >= 0; i--)
-		len += sprintf(buf + len, "%lx%s", bitmap[i], i > 0 ? " " : "");
-
-	len += sprintf(buf + len, "\n");
-
+		len += snprintf(buf + len, max(buf_size - len, 0),
+				"%lx%s", bitmap[i], i > 0 ? " " : "");
 	return len;
 }
 
@@ -478,17 +358,18 @@ static unsigned int input_devices_poll(s
 	return 0;
 }
 
-#define SPRINTF_BIT_B(ev, bm)						\
+#define SPRINTF_BIT(ev, bm)						\
 	do {								\
 		len += sprintf(buf + len, "B: %s=", #ev);		\
-		len += input_print_bitmap(buf + len,			\
+		len += input_print_bitmap(buf + len, INT_MAX,		\
 					dev->bm##bit, ev##_MAX);	\
+		len += sprintf(buf + len, "\n");			\
 	} while (0)
 
-#define SPRINTF_BIT_B2(ev, bm)						\
+#define TEST_AND_SPRINTF_BIT(ev, bm)					\
 	do {								\
 		if (test_bit(EV_##ev, dev->evbit))			\
-			SPRINTF_BIT_B(ev, bm);				\
+			SPRINTF_BIT(ev, bm);				\
 	} while (0)
 
 static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
@@ -517,15 +398,15 @@ static int input_devices_read(char *buf,
 
 		len += sprintf(buf + len, "\n");
 
-		SPRINTF_BIT_B(EV, ev);
-		SPRINTF_BIT_B2(KEY, key);
-		SPRINTF_BIT_B2(REL, rel);
-		SPRINTF_BIT_B2(ABS, abs);
-		SPRINTF_BIT_B2(MSC, msc);
-		SPRINTF_BIT_B2(LED, led);
-		SPRINTF_BIT_B2(SND, snd);
-		SPRINTF_BIT_B2(FF, ff);
-		SPRINTF_BIT_B2(SW, sw);
+		SPRINTF_BIT(EV, ev);
+		TEST_AND_SPRINTF_BIT(KEY, key);
+		TEST_AND_SPRINTF_BIT(REL, rel);
+		TEST_AND_SPRINTF_BIT(ABS, abs);
+		TEST_AND_SPRINTF_BIT(MSC, msc);
+		TEST_AND_SPRINTF_BIT(LED, led);
+		TEST_AND_SPRINTF_BIT(SND, snd);
+		TEST_AND_SPRINTF_BIT(FF, ff);
+		TEST_AND_SPRINTF_BIT(SW, sw);
 
 		len += sprintf(buf + len, "\n");
 
@@ -690,7 +571,7 @@ static struct attribute_group input_dev_
 static ssize_t input_dev_show_cap_##bm(struct class_device *dev, char *buf)	\
 {										\
 	struct input_dev *input_dev = to_input_dev(dev);			\
-	return input_print_bitmap(buf, input_dev->bm##bit, ev##_MAX);		\
+	return input_print_bitmap(buf, PAGE_SIZE, input_dev->bm##bit, ev##_MAX);\
 }										\
 static CLASS_DEVICE_ATTR(bm, S_IRUGO, input_dev_show_cap_##bm, NULL);
 
@@ -730,10 +611,102 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
+#ifdef CONFIG_HOTPLUG
+
+/*
+ * Input hotplugging interface - loading event handlers based on
+ * device bitfields.
+ */
+
+static int input_add_hotplug_bm_var(char **envp, int num_envp, int *cur_index, char *buffer, int buffer_size,
+				    int *cur_len, const char *name, unsigned long *bitmap, int max)
+{
+	if (*cur_index >= num_envp - 1)
+		return -ENOMEM;
+
+	envp[*cur_index] = buffer + *cur_len;
+
+	*cur_len += snprintf(buffer + *cur_len, max(buffer_size - *cur_len, 0), name);
+	if (*cur_len > buffer_size)
+		return -ENOMEM;
+
+	*cur_len += input_print_bitmap(buffer + *cur_len, max(buffer_size - *cur_len, 0),
+					bitmap, max) + 1;
+	if (*cur_len > buffer_size)
+		return -ENOMEM;
+
+	(*cur_index)++;
+	return 0;
+}
+
+#define INPUT_ADD_HOTPLUG_VAR(fmt, val...)				\
+	do {								\
+		int err = add_hotplug_env_var(envp, num_envp, &i,	\
+					buffer, buffer_size, &len,	\
+					fmt, val);			\
+		if (err)						\
+			return err;					\
+	} while (0)
+
+#define INPUT_ADD_HOTPLUG_BM_VAR(name, bm, max)				\
+	do {								\
+		int err = input_add_hotplug_bm_var(envp, num_envp, &i,	\
+					buffer, buffer_size, &len,	\
+					name, bm, max);			\
+		if (err)						\
+			return err;					\
+	} while (0)
+
+static int input_dev_hotplug(struct class_device *cdev, char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	struct input_dev *dev = to_input_dev(cdev);
+	int i = 0;
+	int len = 0;
+
+	INPUT_ADD_HOTPLUG_VAR("PRODUCT=%x/%x/%x/%x",
+				dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
+	if (dev->name)
+		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);
+	if (dev->phys)
+		INPUT_ADD_HOTPLUG_VAR("PHYS=\"%s\"", dev->phys);
+	if (dev->phys)
+		INPUT_ADD_HOTPLUG_VAR("UNIQ=\"%s\"", dev->uniq);
+
+	INPUT_ADD_HOTPLUG_BM_VAR("EV=", dev->evbit, EV_MAX);
+	if (test_bit(EV_KEY, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("KEY=", dev->keybit, KEY_MAX);
+	if (test_bit(EV_REL, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("REL=", dev->relbit, REL_MAX);
+	if (test_bit(EV_ABS, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("ABS=", dev->absbit, ABS_MAX);
+	if (test_bit(EV_MSC, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("MSC=", dev->mscbit, MSC_MAX);
+	if (test_bit(EV_LED, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("LED=", dev->ledbit, LED_MAX);
+	if (test_bit(EV_SND, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("SND=", dev->sndbit, SND_MAX);
+	if (test_bit(EV_FF, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("FF=", dev->ffbit, FF_MAX);
+	if (test_bit(EV_SW, dev->evbit))
+		INPUT_ADD_HOTPLUG_BM_VAR("SW=", dev->swbit, SW_MAX);
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
+#else
+static int input_dev_hotplug(struct class_device *cdev, char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	return 0;
+}
+#endif
+
 static struct class input_dev_class = {
 	.name			= "devices",
 	.parent			= &input_class,
 	.release		= input_dev_release,
+	.hotplug		= input_dev_hotplug,
 	.class_dev_attrs	= input_dev_attrs,
 };
 
@@ -813,10 +786,6 @@ int input_register_device(struct input_d
 		dev->name ? dev->name : "Unspecified device", path ? path : "N/A");
 	kfree(path);
 
-#ifdef CONFIG_HOTPLUG
-	input_call_hotplug("add", dev);
-#endif
-
 	input_wakeup_procfs_readers();
 
 	__module_get(THIS_MODULE);
@@ -841,10 +810,6 @@ void input_unregister_device(struct inpu
 		handle->handler->disconnect(handle);
 	}
 
-#ifdef CONFIG_HOTPLUG
-	input_call_hotplug("remove", dev);
-#endif
-
 	list_del_init(&dev->node);
 
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);

