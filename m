Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUFCFq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUFCFq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 01:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUFCFq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 01:46:26 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:20324 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265509AbUFCFp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 01:45:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Date: Thu, 3 Jun 2004 00:45:47 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, bilotta78@hotpop.com,
       danlee@informatik.uni-freiburg.de, vojtech@suse.cz, tuukkat@ee.oulu.fi
References: <200406020218.42979.dtor_core@ameritech.net> <20040602003626.4d754944.akpm@osdl.org>
In-Reply-To: <20040602003626.4d754944.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030045.51102.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, new version:

- fixed return value logic in rawdev_write,
- rawdev_read and rawdev_write arguments marked with __user,
- some comments sprinkled around ;)



===================================================================


ChangeSet@1.1840, 2004-06-02 22:31:17-05:00, dtor_core@ameritech.net
  Input: Add rawdev driver that binds to serio ports marked as 'raw'
         and provides unobstructed access to the underlying serio port
         via a char device. The driver tries to register char device
         10,1 (/dev/psaux) first and if it fails goes for dynamically
         allocated minor.

  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/misc/Kconfig  |   12 +
 drivers/input/misc/Makefile |    1 
 drivers/input/misc/rawdev.c |  422 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serio.h       |    1 
 4 files changed, 436 insertions(+)


===================================================================



diff -Nru a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	2004-06-02 23:08:36 -05:00
+++ b/drivers/input/misc/Kconfig	2004-06-02 23:08:36 -05:00
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
+	  allocating minor 1 historically corresponding to /dev/psaux).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rawdev.
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- a/drivers/input/misc/Makefile	2004-06-02 23:08:36 -05:00
+++ b/drivers/input/misc/Makefile	2004-06-02 23:08:36 -05:00
@@ -9,3 +9,4 @@
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_RAWDEV)		+= rawdev.o
diff -Nru a/drivers/input/misc/rawdev.c b/drivers/input/misc/rawdev.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/misc/rawdev.c	2004-06-02 23:08:36 -05:00
@@ -0,0 +1,422 @@
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
+	spinlock_t lock;		/* protects queue, tail and head */
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
+static DECLARE_MUTEX(rawdev_sem);	/* protects rawdev_list, rawdev_no and rawdev->serio */
+static LIST_HEAD(rawdev_list);
+static unsigned int rawdev_no;
+
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
+/*
+ * Try to locate rawdev corresponding to a given minor.
+ * rawdev_sem has to be taken before calling rawdev_locate.
+ */
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
+	int retval;
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
+/*
+ * rawdev_cleanup() frees rawdev once last reference has been dropped.
+ * It has to be called with rawdev_sem already taken.
+ */
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
+
+	return 0;
+}
+
+static int rawdev_fetch_byte(struct rawdev *rawdev, unsigned char *c)
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
+static ssize_t rawdev_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+{
+	struct rawdev_list *list = file->private_data;
+	struct rawdev *rawdev = list->rawdev;
+	unsigned char c;
+	ssize_t retval;
+
+	/*
+	 * Unlike rawdev_write we do not have to take rawdev_sem here since
+	 * we do not access rawdev->serio itself, we just check if it is
+	 * present. And even if it goes away in the middle of copying data
+	 * to userspace it's OK because rawdev will stick around anyway.
+	 */
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
+static ssize_t rawdev_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
+{
+	struct rawdev_list *list = file->private_data;
+	ssize_t retval;
+	unsigned char c;
+
+	retval = down_interruptible(&rawdev_sem);
+	if (retval)
+		return retval;
+
+	/* Check if underlying serio went away while we were waiting */
+	if (!list->rawdev->serio) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * Do not hog the device for too long.
+	 * The same limit is used in 2.4 psaux implementation which we trying
+	 * to follow as close as possible
+	 */
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
+		/* Normally write returns number of bytes written */
+		retval++;
+	}
+
+out:
+	up(&rawdev_sem);
+	return retval;
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
+/*
+ * rawdev_interrupt gets a byte from the underlying serio port and stores
+ * it in rawdev's ring buffer for rawdev_fetch_byte to fetch.
+ */
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
+	init_waitqueue_head(&rawdev->wait);
+
+	serio->private = rawdev;
+	if (serio_open(serio, dev))
+		goto out_free;
+
+	list_add_tail(&rawdev->node, &rawdev_list);
+
+	/*
+	 * Try binding to char 10,1 (/dev/psaux) first. Assuming that average
+	 * system will have at most one port in raw mode it should keep thigs
+	 * pretty much the same as 2.4 and earlier kernels.
+	 * If 10,1 has already been taken retry with dynamically allocated
+	 * minor.
+	 */
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
--- a/include/linux/serio.h	2004-06-02 23:08:36 -05:00
+++ b/include/linux/serio.h	2004-06-02 23:08:36 -05:00
@@ -108,6 +108,7 @@
 #define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
 #define SERIO_8042_XL	0x06000000UL
+#define SERIO_8042_RAW	0x07000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
