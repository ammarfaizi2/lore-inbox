Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUFEHdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUFEHdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUFEHdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:33:41 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:3707 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264541AbUFEHbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:31:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2) - take 3
Date: Sat, 5 Jun 2004 02:31:26 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, bilotta78@hotpop.com, vojtech@suse.cz,
       tuukkat@ee.oulu.fi, Sau Dan Lee <danlee@informatik.uni-freiburg.de>
References: <200406020218.42979.dtor_core@ameritech.net> <200406030045.51102.dtor_core@ameritech.net> <xb7llj540o3.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7llj540o3.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406050231.27856.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, 3rd attempt... As Sau Dan Lee suggested renamed form rawdev to serio_raw
and adjsuted dependencies. Since it does not really need input subsystem,
just serio, moved to drivers/input/serio. 

-- 
Dmitry


===================================================================


ChangeSet@1.1825, 2004-06-05 00:47:44-05:00, dtor_core@ameritech.net
  Input: Add serio_raw driver that binds to serio ports marked as 'raw'
         and provides unobstructed access to the underlying serio port
         via a char device. The driver tries to register char device
         10,1 (/dev/psaux) first and if it fails goes for dynamically
         allocated minor.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/Kconfig     |   14 +
 drivers/input/serio/Makefile    |    1 
 drivers/input/serio/serio_raw.c |  388 ++++++++++++++++++++++++++++++++++++++++
 include/linux/serio.h           |    1 
 4 files changed, 404 insertions(+)


===================================================================



diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	2004-06-05 02:05:24 -05:00
+++ b/drivers/input/serio/Kconfig	2004-06-05 02:05:24 -05:00
@@ -140,3 +140,17 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called maceps2.
+
+config SERIO_RAW
+	tristate "Raw access to serio ports"
+	depends on SERIO
+	help
+	  Say Y here if you want to have raw access to serio ports, such as
+	  AUX ports on i8042 keyboard controller. Each serio port that is
+	  marked as providing raw access will be accessible via a char device
+	  with major 10 and dynamically allocated minor. The driver will try
+	  allocating minor 1 (that historically corresponds to /dev/psaux)
+	  first.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called serio_raw.
diff -Nru a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
--- a/drivers/input/serio/Makefile	2004-06-05 02:05:24 -05:00
+++ b/drivers/input/serio/Makefile	2004-06-05 02:05:24 -05:00
@@ -17,3 +17,4 @@
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
+obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
diff -Nru a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/serio/serio_raw.c	2004-06-05 02:05:24 -05:00
@@ -0,0 +1,388 @@
+/*
+ * Raw serio device providing access to a raw byte stream from underlying
+ * serio port. Closely emulates behavior of pre-2.6 /dev/psaux device
+ *
+ * Copyright (c) 2004 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/major.h>
+#include <linux/device.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/wait.h>
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION("Raw serio driver");
+MODULE_LICENSE("GPL");
+
+#define SERIO_RAW_QUEUE_LEN	64
+struct serio_raw {
+	unsigned char queue[SERIO_RAW_QUEUE_LEN];
+	unsigned int tail, head;
+	spinlock_t lock;
+
+	char name[16];
+	unsigned int refcnt;
+	struct serio *serio;
+	struct miscdevice dev;
+	wait_queue_head_t wait;
+	struct list_head list;
+	struct list_head node;
+};
+
+struct serio_raw_list {
+	struct fasync_struct *fasync;
+	struct serio_raw *serio_raw;
+	struct list_head node;
+};
+
+static DECLARE_MUTEX(serio_raw_sem);
+static LIST_HEAD(serio_raw_list);
+static unsigned int serio_raw_no;
+
+/*********************************************************************
+ *             Interface with userspace (file operations)            *
+ *********************************************************************/
+
+static int serio_raw_fasync(int fd, struct file *file, int on)
+{
+	struct serio_raw_list *list = file->private_data;
+	int retval;
+
+	retval = fasync_helper(fd, file, on, &list->fasync);
+	return retval < 0 ? retval : 0;
+}
+
+static struct serio_raw *serio_raw_locate(int minor)
+{
+	struct serio_raw *serio_raw;
+
+	list_for_each_entry(serio_raw, &serio_raw_list, node) {
+		if (serio_raw->dev.minor == minor)
+			return serio_raw;
+	}
+
+	return NULL;
+}
+
+static int serio_raw_open(struct inode *inode, struct file *file)
+{
+	struct serio_raw *serio_raw;
+	struct serio_raw_list *list;
+	int retval = 0;
+
+	retval = down_interruptible(&serio_raw_sem);
+	if (retval)
+		return retval;
+
+	if (!(serio_raw = serio_raw_locate(iminor(inode)))) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (!serio_raw->serio) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (!(list = kmalloc(sizeof(struct serio_raw_list), GFP_KERNEL))) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	memset(list, 0, sizeof(struct serio_raw_list));
+	list->serio_raw = serio_raw;
+	file->private_data = list;
+
+	serio_raw->refcnt++;
+	list_add_tail(&list->node, &serio_raw->list);
+
+out:
+	up(&serio_raw_sem);
+	return retval;
+}
+
+static int serio_raw_cleanup(struct serio_raw *serio_raw)
+{
+	if (--serio_raw->refcnt == 0) {
+		misc_deregister(&serio_raw->dev);
+		list_del_init(&serio_raw->node);
+		kfree(serio_raw);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int serio_raw_release(struct inode *inode, struct file *file)
+{
+	struct serio_raw_list *list = file->private_data;
+	struct serio_raw *serio_raw = list->serio_raw;
+
+	down(&serio_raw_sem);
+
+	serio_raw_fasync(-1, file, 0);
+	serio_raw_cleanup(serio_raw);
+
+	up(&serio_raw_sem);
+	return 0;
+}
+
+static int serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
+{
+	unsigned long flags;
+	int empty;
+
+	spin_lock_irqsave(&serio_raw->lock, flags);
+
+	empty = serio_raw->head == serio_raw->tail;
+	if (!empty) {
+		*c = serio_raw->queue[serio_raw->tail];
+		serio_raw->tail = (serio_raw->tail + 1) % SERIO_RAW_QUEUE_LEN;
+	}
+
+	spin_unlock_irqrestore(&serio_raw->lock, flags);
+
+	return !empty;
+}
+
+static ssize_t serio_raw_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
+{
+	struct serio_raw_list *list = file->private_data;
+	struct serio_raw *serio_raw = list->serio_raw;
+	char c;
+	ssize_t retval = 0;
+
+	if (!serio_raw->serio)
+		return -ENODEV;
+
+	if (serio_raw->head == serio_raw->tail && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval = wait_event_interruptible(list->serio_raw->wait,
+					  serio_raw->head != serio_raw->tail || !serio_raw->serio);
+	if (retval)
+		return retval;
+
+	if (!serio_raw->serio)
+		return -ENODEV;
+
+	while (retval < count && serio_raw_fetch_byte(serio_raw, &c)) {
+		if (put_user(c, buffer++))
+			return -EFAULT;
+		retval++;
+	}
+
+	return retval;
+}
+
+static ssize_t serio_raw_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+{
+	struct serio_raw_list *list = file->private_data;
+	ssize_t written = 0;
+	int retval;
+	unsigned char c;
+
+	retval = down_interruptible(&serio_raw_sem);
+	if (retval)
+		return retval;
+
+	if (!list->serio_raw->serio) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (count > 32)
+		count = 32;
+
+	while (count--) {
+		if (get_user(c, buffer++)) {
+			retval = -EFAULT;
+			goto out;
+		}
+		if (serio_write(list->serio_raw->serio, c)) {
+			retval = -EIO;
+			goto out;
+		}
+		written++;
+	};
+
+out:
+	up(&serio_raw_sem);
+	return written;
+}
+
+static unsigned int serio_raw_poll(struct file *file, poll_table *wait)
+{
+	struct serio_raw_list *list = file->private_data;
+
+	poll_wait(file, &list->serio_raw->wait, wait);
+
+	if (list->serio_raw->head != list->serio_raw->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+struct file_operations serio_raw_fops = {
+	.owner =	THIS_MODULE,
+	.open =		serio_raw_open,
+	.release =	serio_raw_release,
+	.read =		serio_raw_read,
+	.write =	serio_raw_write,
+	.poll =		serio_raw_poll,
+	.fasync =	serio_raw_fasync,
+};
+
+
+/*********************************************************************
+ *                   Interface with serio port   	             *
+ *********************************************************************/
+
+static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
+					unsigned int dfl, struct pt_regs *regs)
+{
+	struct serio_raw *serio_raw = serio->private;
+	struct serio_raw_list *list;
+	unsigned int head = serio_raw->head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_raw->lock, flags);
+
+	serio_raw->queue[head] = data;
+	head = (head + 1) % SERIO_RAW_QUEUE_LEN;
+	if (likely(head != serio_raw->tail)) {
+		serio_raw->head = head;
+		list_for_each_entry(list, &serio_raw->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+		wake_up_interruptible(&serio_raw->wait);
+	}
+
+	spin_unlock_irqrestore(&serio_raw->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void serio_raw_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct serio_raw *serio_raw;
+	int err;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_8042_RAW)
+		return;
+
+	if (!(serio_raw = kmalloc(sizeof(struct serio_raw), GFP_KERNEL))) {
+		printk(KERN_ERR "serio_raw.c: can't allocate memory for a device\n");
+		return;
+	}
+
+	down(&serio_raw_sem);
+
+	memset(serio_raw, 0, sizeof(struct serio_raw));
+	snprintf(serio_raw->name, sizeof(serio_raw->name), "serio_raw%d", serio_raw_no++);
+	serio_raw->refcnt = 1;
+	serio_raw->serio = serio;
+	INIT_LIST_HEAD(&serio_raw->list);
+        init_waitqueue_head(&serio_raw->wait);
+
+	serio->private = serio_raw;
+	if (serio_open(serio, dev))
+		goto out_free;
+
+	list_add_tail(&serio_raw->node, &serio_raw_list);
+
+	serio_raw->dev.minor = PSMOUSE_MINOR;
+	serio_raw->dev.name = serio_raw->name;
+	serio_raw->dev.fops = &serio_raw_fops;
+
+	err = misc_register(&serio_raw->dev);
+	if (err) {
+		serio_raw->dev.minor = MISC_DYNAMIC_MINOR;
+		err = misc_register(&serio_raw->dev);
+	}
+
+	if (err) {
+		printk(KERN_INFO "serio_raw: failed to register raw access device for %s\n",
+			serio->phys);
+		goto out_close;
+	}
+
+	printk(KERN_INFO "serio_raw: raw access enabled on %s (%s, minor %d)\n",
+		serio->phys, serio_raw->name, serio_raw->dev.minor);
+	goto out;
+
+out_close:
+	serio_close(serio);
+	list_del_init(&serio_raw->node);
+out_free:
+	serio->private = NULL;
+	kfree(serio_raw);
+out:
+	up(&serio_raw_sem);
+}
+
+static int serio_raw_reconnect(struct serio *serio)
+{
+	struct serio_raw *serio_raw = serio->private;
+	struct serio_dev *dev = serio->dev;
+
+	if (!dev || !serio_raw) {
+		printk(KERN_DEBUG "serio_raw: reconnect request, but serio is disconnected, ignoring...\n");
+		return -1;
+	}
+
+	/*
+	 * Nothing needs to be done here, we just need this method to
+	 * keep the same device.
+	 */
+	return 0;
+}
+
+static void serio_raw_disconnect(struct serio *serio)
+{
+	struct serio_raw *serio_raw;
+
+	down(&serio_raw_sem);
+
+	serio_raw = serio->private;
+
+	serio_close(serio);
+	serio->private = NULL;
+
+	serio_raw->serio = NULL;
+	if (!serio_raw_cleanup(serio_raw))
+		wake_up_interruptible(&serio_raw->wait);
+
+	up(&serio_raw_sem);
+}
+
+static struct serio_dev serio_raw_dev = {
+	.interrupt =	serio_raw_interrupt,
+	.connect =	serio_raw_connect,
+	.reconnect =	serio_raw_reconnect,
+	.disconnect =	serio_raw_disconnect,
+};
+
+int __init serio_raw_init(void)
+{
+	serio_register_device(&serio_raw_dev);
+	return 0;
+}
+
+void __exit serio_raw_exit(void)
+{
+	serio_unregister_device(&serio_raw_dev);
+}
+
+module_init(serio_raw_init);
+module_exit(serio_raw_exit);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-05 02:05:24 -05:00
+++ b/include/linux/serio.h	2004-06-05 02:05:24 -05:00
@@ -111,6 +111,7 @@
 #define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
 #define SERIO_8042_XL	0x06000000UL
+#define SERIO_8042_RAW	0x07000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
