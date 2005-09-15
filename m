Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVIOGwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVIOGwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIOGvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:51:46 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:59995 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965174AbVIOGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:39 -0400
Message-Id: <20050915064946.697820000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 28/28] Input: convert to seq_file
Content-Disposition: inline; filename=input-proc-seq-file.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: convert /proc handling to seq_file

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |  239 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 150 insertions(+), 89 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/kobject_uevent.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
@@ -537,7 +538,7 @@ static inline void input_wakeup_procfs_r
 	wake_up(&input_devices_poll_wait);
 }
 
-static unsigned int input_devices_poll(struct file *file, poll_table *wait)
+static unsigned int input_proc_devices_poll(struct file *file, poll_table *wait)
 {
 	int state = input_devices_state;
 	poll_wait(file, &input_devices_poll_wait, wait);
@@ -546,121 +547,182 @@ static unsigned int input_devices_poll(s
 	return 0;
 }
 
-#define SPRINTF_BIT(ev, bm)						\
+static struct list_head *list_get_nth_element(struct list_head *list, loff_t *pos)
+{
+	struct list_head *node;
+	loff_t i = 0;
+
+	list_for_each(node, list)
+		if (i++ == *pos)
+			return node;
+
+	return NULL;
+}
+
+static struct list_head *list_get_next_element(struct list_head *list, struct list_head *element, loff_t *pos)
+{
+	if (element->next == list)
+		return NULL;
+
+	++(*pos);
+	return element->next;
+}
+
+static void *input_devices_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	down(&input_dev_class.sem);
+	return list_get_nth_element(&input_dev_class.children, pos);
+}
+
+static void *input_devices_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return list_get_next_element(&input_dev_class.children, v, pos);
+}
+
+static void input_devices_seq_stop(struct seq_file *seq, void *v)
+{
+	up(&input_dev_class.sem);
+}
+
+static void input_seq_print_bitmap(struct seq_file *seq, const char *name,
+				   unsigned long *bitmap, int max)
+{
+	int i;
+
+	for (i = NBITS(max) - 1; i > 0; i--)
+		if (bitmap[i])
+			break;
+
+	seq_printf(seq, "B: %s=", name);
+	for (; i >= 0; i--)
+		seq_printf(seq, "%lx%s", bitmap[i], i > 0 ? " " : "");
+	seq_putc(seq, '\n');
+}
+
+#define SEQ_PRINTF_BIT(ev, bm)						\
 	do {								\
-		len += sprintf(buf + len, "B: %s=", #ev);		\
-		len += input_print_bitmap(buf + len, INT_MAX,		\
-					dev->bm##bit, ev##_MAX);	\
-		len += sprintf(buf + len, "\n");			\
+		input_seq_print_bitmap(seq, #ev,			\
+				       dev->bm##bit, ev##_MAX);		\
 	} while (0)
 
-#define TEST_AND_SPRINTF_BIT(ev, bm)					\
+#define TEST_AND_SEQ_PRINTF_BIT(ev, bm)					\
 	do {								\
 		if (test_bit(EV_##ev, dev->evbit))			\
-			SPRINTF_BIT(ev, bm);				\
+			SEQ_PRINTF_BIT(ev, bm);				\
 	} while (0)
 
-static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+static int input_devices_seq_show(struct seq_file *seq, void *v)
 {
-	struct list_head *node;
-	struct input_dev *dev;
+	struct class_device *cdev = container_of(v, struct class_device, node);
+	struct input_dev *dev = to_input_dev(cdev);
+	const char *path = kobject_get_path(&cdev->kobj, GFP_KERNEL);
 	struct input_handle *handle;
-	const char *path;
 
-	off_t at = 0;
-	int len, cnt = 0;
+	seq_printf(seq, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
+		   dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
 
-	list_for_each(node, &input_dev_class.children) {
+	seq_printf(seq, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
+	seq_printf(seq, "P: Phys=%s\n", dev->phys ? dev->phys : "");
+	seq_printf(seq, "S: Sysfs=%s\n", path ? path : "");
+	seq_printf(seq, "H: Handlers=");
+
+	list_for_each_entry(handle, &dev->h_list, d_node)
+		seq_printf(seq, "%s ", handle->name);
+	seq_putc(seq, '\n');
+
+	SEQ_PRINTF_BIT(EV, ev);
+	TEST_AND_SEQ_PRINTF_BIT(KEY, key);
+	TEST_AND_SEQ_PRINTF_BIT(REL, rel);
+	TEST_AND_SEQ_PRINTF_BIT(ABS, abs);
+	TEST_AND_SEQ_PRINTF_BIT(MSC, msc);
+	TEST_AND_SEQ_PRINTF_BIT(LED, led);
+	TEST_AND_SEQ_PRINTF_BIT(SND, snd);
+	TEST_AND_SEQ_PRINTF_BIT(FF, ff);
+	TEST_AND_SEQ_PRINTF_BIT(SW, sw);
 
-		dev = to_input_dev(container_of(node, struct class_device, node));
-		path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
+	seq_putc(seq, '\n');
 
-		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
-			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
-
-		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
-		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
-		len += sprintf(buf + len, "S: Sysfs=%s\n", path ? path : "");
-		len += sprintf(buf + len, "H: Handlers=");
+	kfree(path);
+	return 0;
+}
 
-		list_for_each_entry(handle, &dev->h_list, d_node)
-			len += sprintf(buf + len, "%s ", handle->name);
+static struct seq_operations input_devices_seq_ops = {
+	.start	= input_devices_seq_start,
+	.next	= input_devices_seq_next,
+	.stop	= input_devices_seq_stop,
+	.show	= input_devices_seq_show,
+};
 
-		len += sprintf(buf + len, "\n");
+static int input_proc_devices_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &input_devices_seq_ops);
+}
 
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
+static struct file_operations input_devices_fileops = {
+	.owner		= THIS_MODULE,
+	.open		= input_proc_devices_open,
+	.poll		= input_proc_devices_poll,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 
-		kfree(path);
-	}
+static void *input_handlers_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	down(&input_dev_class.sem);
+	return list_get_nth_element(&input_dev_class.interfaces, pos);
+}
 
-	if (node == &input_dev_class.children)
-		*eof = 1;
+static void *input_handlers_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return list_get_next_element(&input_dev_class.interfaces, v, pos);
+}
 
-	return (count > cnt) ? cnt : count;
+static void input_handlers_seq_stop(struct seq_file *seq, void *v)
+{
+	up(&input_dev_class.sem);
 }
 
-static int input_handlers_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
+static int input_handlers_seq_show(struct seq_file *seq, void *v)
 {
+	struct class_interface *intf = container_of(v, struct class_interface, node);
+	struct input_handler *handler = to_input_handler(intf);
 	struct list_head *node;
-	struct input_handler *handler;
-
-	off_t at = 0;
-	int len = 0, cnt = 0;
 	int i = 0;
 
 	list_for_each(node, &input_dev_class.interfaces) {
+		if (node == v)
+			break;
+		i++;
+	}
 
-		handler = to_input_handler(container_of(node, struct class_interface, node));
+	seq_printf(seq, "N: Number=%d Name=%s", i, handler->name);
+	if (handler->fops)
+		seq_printf(seq, " Minor=%d", handler->minor);
+	seq_putc(seq, '\n');
 
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
+	return 0;
+}
 
-	if (node == &input_dev_class.interfaces)
-		*eof = 1;
+static struct seq_operations input_handlers_seq_ops = {
+	.start	= input_handlers_seq_start,
+	.next	= input_handlers_seq_next,
+	.stop	= input_handlers_seq_stop,
+	.show	= input_handlers_seq_show,
+};
 
-	return (count > cnt) ? cnt : count;
+static int input_proc_handlers_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &input_handlers_seq_ops);
 }
 
-static struct file_operations input_fileops;
+static struct file_operations input_handlers_fileops = {
+	.owner		= THIS_MODULE,
+	.open		= input_proc_handlers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 
 static int __init input_proc_init(void)
 {
@@ -672,20 +734,19 @@ static int __init input_proc_init(void)
 
 	proc_bus_input_dir->owner = THIS_MODULE;
 
-	entry = create_proc_read_entry("devices", 0, proc_bus_input_dir, input_devices_read, NULL);
+	entry = create_proc_entry("devices", 0, proc_bus_input_dir);
 	if (!entry)
 		goto fail1;
 
 	entry->owner = THIS_MODULE;
-	input_fileops = *entry->proc_fops;
-	entry->proc_fops = &input_fileops;
-	entry->proc_fops->poll = input_devices_poll;
+	entry->proc_fops = &input_devices_fileops;
 
-	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
+	entry = create_proc_entry("handlers", 0, proc_bus_input_dir);
 	if (!entry)
 		goto fail2;
 
 	entry->owner = THIS_MODULE;
+	entry->proc_fops = &input_handlers_fileops;
 
 	return 0;
 

