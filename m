Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUFBHVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUFBHVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUFBHVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:21:13 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:16729 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265099AbUFBHSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:18:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/RFT] Raw access to serio ports (1/2)
Date: Wed, 2 Jun 2004 02:18:42 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Tuukka Toivonen <tuukkat@ee.oulu.fi>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406020218.42979.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is an implementation of rawdev driver. The driver will bind to serio
ports with type SERIO_8042_RAW and provides raw byte-oriented access to the
underlying serio device. I tried to keep behavior as close to 2.4 as possible
so multiple readers/writers are allowed and they will fight with each other
over access.

The driver will attempt to register char device 10,1 (/dev/psaux) and if that
fails will request dynamic minor. So if mousedev psaux support is turned off
and I expect only onle device requiring "special" handling to be present at
a time everything should work pretty much the same as in 2.4

The driver will happily co-exist with psmouse and atkbd loaded as they ignore
SERIO_8042_RAW ports, so it is possible to have one AUX port in raw mode and
other in standard 2.6 mode.

The patch to mark some of i8042 AUX ports as raw is in the next message.

Comments?

-- 
Dmitry

P.S. The patch is against Vojtech's tree so there is some nice if appllied to
Linus' tree but there should be no rejects.


===================================================================


ChangeSet@1.1840, 2004-06-02 01:57:12-05:00, dtor_core@ameritech.net
  Input: Add rawdev driver that binds to serio ports marked as 'raw'
         and provides unobstructed access to the underlying serio port
         via a char device. The driver tries to register char device
         10,1 (/dev/psaux) first and if it fails goes for dynamically
         allocated minor.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/misc/Kconfig  |   12 +
 drivers/input/misc/Makefile |    1 
 drivers/input/misc/rawdev.c |  388 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serio.h       |    1 
 4 files changed, 402 insertions(+)


===================================================================



diff -Nru a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	2004-06-02 02:15:20 -05:00
+++ b/drivers/input/misc/Kconfig	2004-06-02 02:15:20 -05:00
@@ -54,3 +54,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+config INPUT_RAWDEV
+	tristate "Raw access to serio ports"
+	depends on INPUT && INPUT_MISC
+	help
+	  Say Y here if you want to have raw access to serio ports, such as
+	  AUX ports on i8042 keyboard controller. Each serio port that is
+	  marked as providing raw access will be accessible via a char device
+	  with major 10 and dynamically allocated minor (it will first try
+	  allocating minor 1 historically corrsponding to /dev/psaux).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rawdev.
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- a/drivers/input/misc/Makefile	2004-06-02 02:15:20 -05:00
+++ b/drivers/input/misc/Makefile	2004-06-02 02:15:20 -05:00
@@ -9,3 +9,4 @@
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_RAWDEV)		+= rawdev.o
diff -Nru a/drivers/input/misc/rawdev.c b/drivers/input/misc/rawdev.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/misc/rawdev.c	2004-06-02 02:15:20 -05:00
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
+#define RAWDEV_QUEUE_LEN	64
+struct rawdev {
+	unsigned char queue[RAWDEV_QUEUE_LEN];
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
+struct rawdev_list {
+	struct fasync_struct *fasync;
+	struct rawdev *rawdev;
+	struct list_head node;
+};
+
+static DECLARE_MUTEX(rawdev_sem);
+static LIST_HEAD(rawdev_list);
+static unsigned int rawdev_no;
+
+/*********************************************************************
+ *             Interface with userspace (file operations)            *
+ *********************************************************************/
+
+static int rawdev_fasync(int fd, struct file *file, int on)
+{
+	struct rawdev_list *list = file->private_data;
+	int retval;
+
+	retval = fasync_helper(fd, file, on, &list->fasync);
+	return retval < 0 ? retval : 0;
+}
+
+static struct rawdev *rawdev_locate(int minor)
+{
+	struct rawdev *rawdev;
+
+	list_for_each_entry(rawdev, &rawdev_list, node) {
+		if (rawdev->dev.minor == minor)
+			return rawdev;
+	}
+
+	return NULL;
+}
+
+static int rawdev_open(struct inode *inode, struct file *file)
+{
+	struct rawdev *rawdev;
+	struct rawdev_list *list;
+	int retval = 0;
+
+	retval = down_interruptible(&rawdev_sem);
+	if (retval)
+		return retval;
+
+	if (!(rawdev = rawdev_locate(iminor(inode)))) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (!rawdev->serio) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (!(list = kmalloc(sizeof(struct rawdev_list), GFP_KERNEL))) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	memset(list, 0, sizeof(struct rawdev_list));
+	list->rawdev = rawdev;
+	file->private_data = list;
+
+	rawdev->refcnt++;
+	list_add_tail(&list->node, &rawdev->list);
+
+out:
+	up(&rawdev_sem);
+	return retval;
+}
+
+static int rawdev_cleanup(struct rawdev *rawdev)
+{
+	if (--rawdev->refcnt == 0) {
+		misc_deregister(&rawdev->dev);
+		list_del_init(&rawdev->node);
+		kfree(rawdev);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int rawdev_release(struct inode *inode, struct file *file)
+{
+	struct rawdev_list *list = file->private_data;
+	struct rawdev *rawdev = list->rawdev;
+
+	down(&rawdev_sem);
+
+	rawdev_fasync(-1, file, 0);
+	rawdev_cleanup(rawdev);
+
+	up(&rawdev_sem);
+	return 0;
+}
+
+static int rawdev_fetch_byte(struct rawdev *rawdev, char *c)
+{
+	unsigned long flags;
+	int empty;
+
+	spin_lock_irqsave(&rawdev->lock, flags);
+
+	empty = rawdev->head == rawdev->tail;
+	if (!empty) {
+		*c = rawdev->queue[rawdev->tail];
+		rawdev->tail = (rawdev->tail + 1) % RAWDEV_QUEUE_LEN;
+	}
+
+	spin_unlock_irqrestore(&rawdev->lock, flags);
+
+	return !empty;
+}
+
+static ssize_t rawdev_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
+{
+	struct rawdev_list *list = file->private_data;
+	struct rawdev *rawdev = list->rawdev;
+	char c;
+	ssize_t retval = 0;
+
+	if (!rawdev->serio)
+		return -ENODEV;
+
+	if (rawdev->head == rawdev->tail && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval = wait_event_interruptible(list->rawdev->wait,
+					  rawdev->head != rawdev->tail || !rawdev->serio);
+	if (retval)
+		return retval;
+
+	if (!rawdev->serio)
+		return -ENODEV;
+
+	while (retval < count && rawdev_fetch_byte(rawdev, &c)) {
+		if (put_user(c, buffer++))
+			return -EFAULT;
+		retval++;
+	}
+
+	return retval;
+}
+
+static ssize_t rawdev_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+{
+	struct rawdev_list *list = file->private_data;
+	ssize_t written = 0;
+	int retval;
+	unsigned char c;
+
+	retval = down_interruptible(&rawdev_sem);
+	if (retval)
+		return retval;
+
+	if (!list->rawdev->serio) {
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
+		if (serio_write(list->rawdev->serio, c)) {
+			retval = -EIO;
+			goto out;
+		}
+		written++;
+	};
+
+out:
+	up(&rawdev_sem);
+	return written;
+}
+
+static unsigned int rawdev_poll(struct file *file, poll_table *wait)
+{
+	struct rawdev_list *list = file->private_data;
+
+	poll_wait(file, &list->rawdev->wait, wait);
+
+	if (list->rawdev->head != list->rawdev->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+struct file_operations rawdev_fops = {
+	.owner =	THIS_MODULE,
+	.open =		rawdev_open,
+	.release =	rawdev_release,
+	.read =		rawdev_read,
+	.write =	rawdev_write,
+	.poll =		rawdev_poll,
+	.fasync =	rawdev_fasync,
+};
+
+
+/*********************************************************************
+ *                   Interface with serio port   	             *
+ *********************************************************************/
+
+static irqreturn_t rawdev_interrupt(struct serio *serio, unsigned char data,
+				    unsigned int dfl, struct pt_regs *regs)
+{
+	struct rawdev *rawdev = serio->private;
+	struct rawdev_list *list;
+	unsigned int head = rawdev->head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rawdev->lock, flags);
+
+	rawdev->queue[head] = data;
+	head = (head + 1) % RAWDEV_QUEUE_LEN;
+	if (likely(head != rawdev->tail)) {
+		rawdev->head = head;
+		list_for_each_entry(list, &rawdev->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+		wake_up_interruptible(&rawdev->wait);
+	}
+
+	spin_unlock_irqrestore(&rawdev->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void rawdev_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct rawdev *rawdev;
+	int err;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_8042_RAW)
+		return;
+
+	if (!(rawdev = kmalloc(sizeof(struct rawdev), GFP_KERNEL))) {
+		printk(KERN_ERR "rawdev.c: can't allocate memory for a device\n");
+		return;
+	}
+
+	down(&rawdev_sem);
+
+	memset(rawdev, 0, sizeof(struct rawdev));
+	snprintf(rawdev->name, sizeof(rawdev->name), "serio_raw%d", rawdev_no++);
+	rawdev->refcnt = 1;
+	rawdev->serio = serio;
+	INIT_LIST_HEAD(&rawdev->list);
+        init_waitqueue_head(&rawdev->wait);
+
+	serio->private = rawdev;
+	if (serio_open(serio, dev))
+		goto out_free;
+
+	list_add_tail(&rawdev->node, &rawdev_list);
+
+	rawdev->dev.minor = PSMOUSE_MINOR;
+	rawdev->dev.name = rawdev->name;
+	rawdev->dev.fops = &rawdev_fops;
+
+	err = misc_register(&rawdev->dev);
+	if (err) {
+		rawdev->dev.minor = MISC_DYNAMIC_MINOR;
+		err = misc_register(&rawdev->dev);
+	}
+
+	if (err) {
+		printk(KERN_INFO "rawdev: failed to register raw access device for %s\n",
+			serio->phys);
+		goto out_close;
+	}
+
+	printk(KERN_INFO "rawdev: raw access enabled on %s (%s, minor %d)\n",
+		serio->phys, rawdev->name, rawdev->dev.minor);
+	goto out;
+
+out_close:
+	serio_close(serio);
+	list_del_init(&rawdev->node);
+out_free:
+	serio->private = NULL;
+	kfree(rawdev);
+out:
+	up(&rawdev_sem);
+}
+
+static int rawdev_reconnect(struct serio *serio)
+{
+	struct rawdev *rawdev = serio->private;
+	struct serio_dev *dev = serio->dev;
+
+	if (!dev || !rawdev) {
+		printk(KERN_DEBUG "rawdev: reconnect request, but serio is disconnected, ignoring...\n");
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
+static void rawdev_disconnect(struct serio *serio)
+{
+	struct rawdev *rawdev;
+
+	down(&rawdev_sem);
+
+	rawdev = serio->private;
+
+	serio_close(serio);
+	serio->private = NULL;
+
+	rawdev->serio = NULL;
+	if (!rawdev_cleanup(rawdev))
+		wake_up_interruptible(&rawdev->wait);
+
+	up(&rawdev_sem);
+}
+
+static struct serio_dev rawdev_dev = {
+	.interrupt =	rawdev_interrupt,
+	.connect =	rawdev_connect,
+	.reconnect =	rawdev_reconnect,
+	.disconnect =	rawdev_disconnect,
+};
+
+int __init rawdev_init(void)
+{
+	serio_register_device(&rawdev_dev);
+	return 0;
+}
+
+void __exit rawdev_exit(void)
+{
+	serio_unregister_device(&rawdev_dev);
+}
+
+module_init(rawdev_init);
+module_exit(rawdev_exit);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-02 02:15:20 -05:00
+++ b/include/linux/serio.h	2004-06-02 02:15:20 -05:00
@@ -108,6 +108,7 @@
 #define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
 #define SERIO_8042_XL	0x06000000UL
+#define SERIO_8042_RAW	0x07000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
