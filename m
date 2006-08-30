Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWH3GYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWH3GYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWH3GYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:24:52 -0400
Received: from mail.suse.de ([195.135.220.2]:28313 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750860AbWH3GYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:24:50 -0400
Date: Tue, 29 Aug 2006 23:23:38 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060830062338.GA10285@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, Thomas and I were sitting in the back of a conference
presentation where the presenter was trying to describe what they did in
order to add the ability to write a userspace PCI driver.  As was usual
in a presentation like this, the presenter totaly ignored the real-world
needs for such a framework, and only got it up and working on a single
type of embedded system.  But the charts and graphs were quite pretty :)

Thomas and I lamented that we were getting tired of seeing stuff like
this, and it was about time that we added the proper code to the kernel
to provide everything that would be needed in order to write PCI drivers
in userspace in a sane manner.  Really all that is needed is a way to
handle the interrupt, everything else can already be done in userspace
(look at X for an example of this...)

Thomas mentioned that he had code to do all of this working in some
customer sites already and that he would get it to me.

Fast forward to OLS of this year, and I bugged Thomas to send me the
code.  He did, and then I sat on it for a while longer...

So, here's the code.  I think it does a bit too much all at once, but it
is an example of how this can be done.  This is working today in some
industrial environments, successfully handling hardware controls of very
large and scary machines.  So it is possible to use this interface to
successfully build your own laser wielding robot, all from userspace,
allowing you to keep your special-secret-how-to-control-the-laser
algorithm closed source if you so desire.

In looking at the proposed kevent interface, I think a few things in
this proposed interface can be dropped in favor of using kevents
instead, but I haven't looked at the latest version of that code to make
sure of this.

And the name is a bit ackward, anyone have a better suggestion?

Thomas has also promised to come up with some userspace code that uses
this interface to show how to use it, but seems to have forgotten.
Consider this a reminder :)

Comments?

thanks,

greg k-h

------------------------

From: Thomas Gleixner <tglx@linutronix.de>
To: Greg KH <gregkh@suse.de>
Subject: IIO subsystem

From: Thomas Gleixner <tglx@linutronix.de>

This allows userspace PCI drivers to be written in a sane manner.

From: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/DocBook/kernel-api.tmpl |    5 
 drivers/Kconfig                       |    2 
 drivers/Makefile                      |    1 
 drivers/iio/Kconfig                   |   11 
 drivers/iio/Makefile                  |    4 
 drivers/iio/iio_base.c                |  438 ++++++++++++++++++++++++++++++++++
 drivers/iio/iio_dev.c                 |  366 ++++++++++++++++++++++++++++
 drivers/iio/iio_dummy.c               |  269 ++++++++++++++++++++
 include/linux/iio.h                   |  108 ++++++++
 kernel/signal.c                       |    4 
 10 files changed, 1208 insertions(+)

--- gregkh-2.6.orig/Documentation/DocBook/kernel-api.tmpl
+++ gregkh-2.6/Documentation/DocBook/kernel-api.tmpl
@@ -430,6 +430,11 @@ X!Edrivers/pnp/system.c
 !Edrivers/pnp/manager.c
 !Edrivers/pnp/support.c
      </sect1>
+     <sect1><title>Industrial IO device driver</title>
+!Edrivers/iio/iio_base.c
+!Edrivers/iio/iio_dev.c
+!Iinclude/linux/iio.h
+     </sect1>
   </chapter>
 
   <chapter id="blkdev">
--- gregkh-2.6.orig/drivers/Kconfig
+++ gregkh-2.6/drivers/Kconfig
@@ -74,4 +74,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/iio/Kconfig"
+
 endmenu
--- gregkh-2.6.orig/drivers/Makefile
+++ gregkh-2.6/drivers/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
 obj-$(CONFIG_FUSION)		+= message/
 obj-$(CONFIG_IEEE1394)		+= ieee1394/
+obj-$(CONFIG_IIO)		+= iio/
 obj-y				+= cdrom/
 obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_SPI)		+= spi/
--- /dev/null
+++ gregkh-2.6/drivers/iio/Kconfig
@@ -0,0 +1,11 @@
+menu "Industrial IO"
+config IIO
+	tristate "Industrial IO"
+	help
+	  base driver for industrial IO
+
+config IIO_DUMMY
+	tristate "Industrial IO dummy driver"
+	help
+	  example/dummy driver for industrial IO
+endmenu
--- /dev/null
+++ gregkh-2.6/drivers/iio/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_IIO) += iio.o
+obj-$(CONFIG_IIO_DUMMY) += iio_dummy.o
+
+iio-objs := iio_base.o iio_dev.o
--- /dev/null
+++ gregkh-2.6/drivers/iio/iio_base.c
@@ -0,0 +1,438 @@
+/*
+ * driver/iio/iio_base.c
+ *
+ * Copyright(C) 2005, Benedikt Spranger <b.spranger@linutronix.de>
+ * Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Industrial IO
+ *
+ * Base Functions
+ *
+ * Licensed under the GPLv2 only.
+ */
+
+#define DEBUG
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/iio.h>
+#include <linux/hrtimer.h>
+
+/*
+ * The iio class.
+ */
+
+static struct class *iio_class;
+
+static const char version[] = "0.00";
+static struct list_head iio_devices = LIST_HEAD_INIT(iio_devices);
+static struct rw_semaphore iio_list_sem;
+
+static const char *iio_dev_ext[] = {
+	"",
+	"_in",
+	"_out",
+	"_event"
+};
+
+struct iio_class_dev {
+	struct list_head list;
+	int dev_nr;
+	struct class_device *cdev [4];
+	dev_t dev;
+};
+
+extern struct file_operations iio_event_fops;
+
+/*
+ * attributes
+ */
+static ssize_t show_iio_version(struct class *cd, char *buf)
+{
+	sprintf(buf, "%s\n", version);
+	return strlen(buf) + 1;
+}
+static CLASS_ATTR(version, S_IRUGO, show_iio_version, NULL);
+
+static ssize_t show_addr(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "0x%lx\n", idev->physaddr);
+}
+static DEVICE_ATTR(physaddr, S_IRUGO, show_addr, NULL);
+
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "%s\n", idev->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static ssize_t show_read_offset(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "0x%lx\n", idev->read_offset);
+}
+static DEVICE_ATTR(read_offset, S_IRUGO, show_read_offset, NULL);
+
+static ssize_t show_size(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "0x%lx\n", idev->size);
+}
+static DEVICE_ATTR(size, S_IRUGO, show_size, NULL);
+
+static ssize_t show_version(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "%s\n", idev->version);
+}
+static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
+
+static ssize_t show_write_offset(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "0x%lx\n", idev->write_offset);
+}
+static DEVICE_ATTR(write_offset, S_IRUGO, show_write_offset, NULL);
+
+static ssize_t show_listener(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "%ld\n", idev->event_listener);
+}
+static DEVICE_ATTR(listener, S_IRUGO, show_listener, NULL);
+
+static ssize_t show_event(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct iio_device *idev = to_iio_device(dev);
+	return sprintf(buf, "%d\n", atomic_read(&idev->event));
+}
+static DEVICE_ATTR(event, S_IRUGO, show_event, NULL);
+
+/*
+ * device functions
+ */
+static void iio_dev_release(struct device *dev)
+{
+	pr_debug("%s\n", __FUNCTION__);
+}
+
+static void iio_dev_create(dev_t dev, struct iio_device *idev)
+{
+	int ret;
+	pr_debug("%s\n", __FUNCTION__);
+
+	cdev_init(&idev->cdev, idev->fops);
+	idev->cdev.owner = THIS_MODULE;
+	idev->cdev.ops = idev->fops;
+	ret = cdev_add(&idev->cdev, dev, 3);
+	if (ret)
+		printk(KERN_ERR "%s: cdev_add failed (%d)\n", __FUNCTION__, ret);
+
+	cdev_init(&idev->event_cdev, &iio_event_fops);
+	idev->event_cdev.owner = THIS_MODULE;
+	idev->event_cdev.ops = &iio_event_fops;
+	ret = cdev_add(&idev->event_cdev, dev + 3, 1);
+	if (ret)
+		printk(KERN_ERR "%s: cdev_add failed (%d)\n", __FUNCTION__, ret);
+}
+
+static void iio_dev_remove(struct iio_device *idev)
+{
+	pr_debug("%s\n", __FUNCTION__);
+
+	cdev_del(&idev->cdev);
+	cdev_del(&idev->event_cdev);
+}
+
+static void iio_dev_add_attributes(struct iio_device *idev)
+{
+	int ret;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	ret = device_create_file(&idev->dev, &dev_attr_name);
+	ret |= device_create_file(&idev->dev, &dev_attr_version);
+	ret |= device_create_file(&idev->dev, &dev_attr_listener);
+	ret |= device_create_file(&idev->dev, &dev_attr_event);
+	if (idev->physaddr)
+		ret |= device_create_file(&idev->dev, &dev_attr_physaddr);
+	if (idev->size)
+		ret |= device_create_file(&idev->dev, &dev_attr_size);
+	if (idev->read_offset >= 0)
+		ret |= device_create_file(&idev->dev, &dev_attr_read_offset);
+	if (idev->write_offset >= 0)
+		ret |= device_create_file(&idev->dev, &dev_attr_write_offset);
+	if (ret)
+		pr_debug("%s: error creating sysfs files\n", __FUNCTION__);
+}
+
+static void iio_dev_del_attributes(struct iio_device *idev)
+{
+	pr_debug("%s\n", __FUNCTION__);
+
+	device_remove_file(&idev->dev, &dev_attr_name);
+	device_remove_file(&idev->dev, &dev_attr_version);
+	device_remove_file(&idev->dev, &dev_attr_listener);
+	device_remove_file(&idev->dev, &dev_attr_event);
+	if (idev->physaddr)
+		device_remove_file(&idev->dev, &dev_attr_physaddr);
+	if (idev->size)
+		device_remove_file(&idev->dev, &dev_attr_size);
+	if (idev->read_offset >= 0)
+		device_remove_file(&idev->dev, &dev_attr_read_offset);
+	if (idev->write_offset >= 0)
+		device_remove_file(&idev->dev, &dev_attr_write_offset);
+}
+
+/*
+ * polling mode
+ */
+
+static void iio_do_poll(unsigned long data)
+{
+	struct iio_device *idev = (struct iio_device *)data;
+
+	iio_interrupt(-1, idev, NULL);
+	mod_timer(&idev->poll_timer, jiffies + idev->freq);
+}
+
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
+ * one shot mode
+ */
+
+int iio_do_oneshot(void *data)
+{
+	struct iio_device *idev = (struct iio_device *)data;
+//	struct timespec next;
+
+	atomic_inc(&idev->running);
+	daemonize("iio_oneshot");
+	set_user_nice(current, -10);
+	current->flags |= PF_NOFREEZE;
+//FIXME: Bene: new API
+# if 0
+	while (!atomic_read(&idev->terminate)) {
+		while (ktime_cmp_val(idev->next_event, == , KTIME_ZERO))
+			schedule();
+		ktime_to_timespec(&next, idev->next_event);
+		ktimer_nanosleep(&next, NULL, KTIMER_ABS);
+		ktime_set_scalar(idev->next_event, KTIME_ZERO);
+		iio_interrupt(-2, idev, NULL);
+	}
+# endif
+	atomic_dec(&idev->running);
+	return 0;
+}
+#endif
+/*
+ * class device functions
+ */
+
+static int iio_assign_free_devnr(void)
+{
+	int dev_nr = 0;
+	struct iio_class_dev *entry;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	if (list_empty(&iio_devices))
+		goto out;
+
+	list_for_each_entry(entry, &iio_devices, list) {
+		if ((entry->dev_nr > dev_nr + 1) && (dev_nr != 0))
+			break;
+		dev_nr = entry->dev_nr;
+	}
+out:
+	return dev_nr + 1;
+}
+
+/**
+ * iio_register_device - register a new industrial IO device
+ *
+ * @parent:	parent device
+ * @idev:	device capabilities
+ *
+ * returns IIO device driver identifier
+ */
+
+int __devinit iio_register_device(struct device *parent,
+				  struct iio_device *idev) {
+	int i, ret = -ENOMEM;
+	struct iio_class_dev *cdev;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	if (!idev->name || !idev->version)
+		return -EINVAL;
+
+	cdev = kmalloc(sizeof(struct iio_class_dev), GFP_KERNEL);
+	if (!cdev)
+		goto out;
+
+	if (parent) {
+		idev->dev.bus = parent->bus;
+		idev->dev.parent = parent;
+	}
+	idev->dev.release = iio_dev_release;
+
+	down_write(&iio_list_sem);
+	cdev->dev_nr = iio_assign_free_devnr();
+
+	sprintf(idev->dev.bus_id, "iio%d", cdev->dev_nr);
+	if ((ret = device_register(&idev->dev)))
+		goto no_dev;
+
+	alloc_chrdev_region(&cdev->dev, 0, 4, idev->dev.bus_id);
+	iio_dev_create(cdev->dev, idev);
+	iio_dev_add_attributes(idev);
+	list_add_tail(&cdev->list, &iio_devices);
+
+	for (i = 0; i < 4; i++) {
+		cdev->cdev [i] = class_device_create(iio_class, NULL,
+						     cdev->dev + i,
+						     &idev->dev, "iio%d%s",
+						     cdev->dev_nr, iio_dev_ext [i]);
+		if (IS_ERR(cdev->cdev [i])) {
+			printk(KERN_ERR "IIO: device register_failed\n");
+			device_unregister(&idev->dev);
+			iio_dev_remove(idev);
+			unregister_chrdev_region(cdev->dev, 4);
+			ret = PTR_ERR(cdev->cdev [i]);
+			kfree(cdev);
+			break;
+		}
+	}
+
+no_dev:
+	up_write(&iio_list_sem);
+
+	idev->dev.driver_data = (void *)cdev->dev_nr;
+	atomic_set(&idev->running, 0);
+	atomic_set(&idev->terminate, 0);
+
+	if (idev->irq && idev->handler) {
+		init_waitqueue_head(&idev->wait);
+		atomic_set(&idev->event, 0);
+
+		switch (idev->irq) {
+#ifdef CONFIG_HIGH_RES_TIMERS
+		case -2: /* one shot mode */
+			kernel_thread(iio_do_oneshot, idev, CLONE_KERNEL);
+			break;
+#endif
+		case -1: /* cyclic */
+			init_timer(&idev->poll_timer);
+			idev->poll_timer.data = (unsigned long)idev;
+			idev->poll_timer.function = iio_do_poll;
+			mod_timer(&idev->poll_timer, jiffies + idev->freq);
+			break;
+
+		default:
+			/* Make this configurable !!! */
+			ret = request_irq(idev->irq, iio_interrupt,
+					  IRQF_SHARED, idev->name, idev);
+		}
+	}
+
+	if (!ret)
+		ret = cdev->dev_nr;
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_register_device);
+
+/**
+ * iio_unregister_device - unregister a industrial IO device
+ * @dev_nr:	IIO device driver identifier
+ *
+ * returns 0 on success
+ */
+
+int __devexit iio_unregister_device(int dev_nr)
+{
+	int i, ret = -ENODEV;
+	struct iio_class_dev *entry, *tmp;
+	struct iio_device *idev;
+
+	pr_debug("%s (%d)\n", __FUNCTION__, dev_nr);
+
+	down_write(&iio_list_sem);
+
+	list_for_each_entry_safe(entry, tmp, &iio_devices, list) {
+		if (entry->dev_nr == dev_nr) {
+
+			idev = to_iio_device(entry->cdev [0]->dev);
+
+			atomic_inc(&idev->terminate);
+			while (atomic_read(&idev->running))
+				schedule();
+
+			if (idev->irq == -1)
+				del_timer_sync(&idev->poll_timer);
+
+			iio_dev_remove(idev);
+			unregister_chrdev_region(entry->dev, 4);
+			iio_dev_del_attributes(idev);
+			for (i = 0; i < 4; i++) {
+				class_device_unregister(entry->cdev [i]);
+			}
+			device_unregister(&idev->dev);
+			list_del(&entry->list);
+
+			kfree(entry);
+			break;
+		}
+	}
+
+	up_write(&iio_list_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_unregister_device);
+
+/*
+ * module
+ */
+
+static int __init iio_init(void)
+{
+	int ret;
+
+	init_rwsem(&iio_list_sem);
+	iio_class = class_create(THIS_MODULE, "iio");
+
+	if (IS_ERR(iio_class))
+		return PTR_ERR(iio_class);
+
+	ret = class_create_file(iio_class, &class_attr_version);
+	if (ret)
+		class_destroy(iio_class);
+	return ret;
+}
+
+void __exit iio_exit(void)
+{
+	class_remove_file(iio_class, &class_attr_version);
+	class_destroy(iio_class);
+}
+
+module_init(iio_init)
+module_exit(iio_exit)
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Benedikt Spranger");
--- /dev/null
+++ gregkh-2.6/drivers/iio/iio_dev.c
@@ -0,0 +1,366 @@
+/*
+ * drivers/iio/iio_dev.c
+ *
+ * Copyright(C) 2005, Benedikt Spranger <b.spranger@linutronix.de>
+ * Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Industrial IO
+ *
+ * Character Device related functions
+ *
+ * Licensed under the GPLv2 only.
+ */
+
+#define DEBUG 1
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mman.h>
+#include <linux/poll.h>
+#include <linux/iio.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+/**
+ * iio_lseek - IIO framework lseek implementation
+ *
+ */
+loff_t iio_lseek(struct file *filep, loff_t offset, int orig)
+{
+	struct iio_device *idev = filep->private_data;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	switch (orig) {
+	case 0:
+		filep->f_pos = offset;
+		break;
+	case 1:
+		filep->f_pos += offset;
+		break;
+	case 2:
+		filep->f_pos = idev->size + offset;
+		break;
+	}
+
+	return (filep->f_pos >= idev->size) ? -EINVAL : filep->f_pos;
+}
+EXPORT_SYMBOL_GPL(iio_lseek);
+
+/**
+ * iio_read - IIO framework read implementation
+ *
+ */
+ssize_t iio_read(struct file *filep, char __user *buf,
+		 size_t count, loff_t *ppos)
+{
+	unsigned int minor = iminor(filep->f_dentry->d_inode);
+	struct iio_device *idev = filep->private_data;
+	int offset;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	switch (minor) {
+	case 0: if (filep->f_pos + count >= idev->size)
+			count = idev->size - filep->f_pos;
+		offset = 0;
+		break;
+	case 1: if (filep->f_pos + count >= idev->read_len)
+			count = idev->read_len - filep->f_pos;
+		offset = idev->read_offset;
+		break;
+	case 2: if (filep->f_pos + count >= idev->write_len)
+			count = idev->write_len - filep->f_pos;
+		offset = idev->write_offset;
+		break;
+	default: return -EFAULT;
+	}
+
+	if (count < 0)
+		return 0;
+
+	if (!idev->virtaddr) {
+		/* IO Ports */
+		size_t i;
+
+		for (i = 0; i < count; i++)
+			if (__put_user(inb(idev->physaddr + offset + i),
+					buf + i) < 0)
+				return -EFAULT;
+	} else {
+		/* IO Mem */
+		if (copy_to_user(buf, idev->virtaddr + offset +
+				  filep->f_pos, count))
+			return -EFAULT;
+	}
+
+	*ppos += count;
+	return count;
+}
+EXPORT_SYMBOL_GPL(iio_read);
+
+/**
+ * iio_write - IIO framework write implementation
+ *
+ */
+ssize_t iio_write(struct file *filep, const char __user * buf, size_t count,
+		  loff_t *ppos)
+{
+	unsigned int minor = iminor(filep->f_dentry->d_inode);
+	struct iio_device *idev = filep->private_data;
+	int offset;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	switch (minor) {
+	case 0: if (filep->f_pos + count >= idev->size)
+			count = idev->size - filep->f_pos;
+		offset = 0;
+		break;
+	case 1: if (filep->f_pos + count >= idev->read_len)
+			count = idev->read_len - filep->f_pos;
+		offset = idev->read_offset;
+		break;
+	case 2: if (filep->f_pos + count >= idev->write_len)
+			count = idev->write_len - filep->f_pos;
+		offset = idev->write_offset;
+		break;
+	default: return -EFAULT;
+	}
+
+	if (count < 0)
+		return 0;
+
+	if (!idev->virtaddr) {
+		/* IO Ports */
+		size_t i;
+		char c;
+
+		for (i = 0; i < count; i++) {
+			if (__get_user(c, buf + i))
+				return -EFAULT;
+			outb(c, idev->physaddr + offset + i);
+		}
+	} else {
+		/* IO Mem */
+		if (copy_from_user(idev->virtaddr + offset + filep->f_pos,
+				   buf, count))
+			return -EFAULT;
+	}
+
+	*ppos += count;
+	return count;
+}
+EXPORT_SYMBOL_GPL(iio_write);
+
+/**
+ * iio_open - IIO framework open implementation
+ *
+ */
+int iio_open(struct inode *inode, struct file *filep)
+{
+	struct iio_device *idev;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	idev = container_of(inode->i_cdev, struct iio_device, cdev);
+	filep->private_data = idev;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_open);
+
+/**
+ * iio_mmap - IIO framework mmap implementation
+ *
+ */
+int iio_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	unsigned int minor = iminor(filep->f_dentry->d_inode);
+	struct iio_device *idev = filep->private_data;
+	unsigned long size = (unsigned long)(vma->vm_end - vma->vm_start);
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	switch (minor) {
+	case 0: if (size > idev->size)
+			return -EINVAL;
+		vma->vm_pgoff = idev->physaddr;
+		break;
+	case 1: if (size > idev->read_len)
+			return -EINVAL;
+		vma->vm_pgoff = idev->physaddr + idev->read_offset;
+		break;
+	case 2: if (size > idev->write_len)
+			return -EINVAL;
+		vma->vm_pgoff = idev->physaddr + idev->write_offset;
+		break;
+	default: return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_LOCKED | VM_IO;
+
+	return remap_pfn_range(vma,
+			       vma->vm_start,
+			       idev->physaddr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+EXPORT_SYMBOL_GPL(iio_mmap);
+
+/**
+ * iio_release - IIO framework release implementation
+ *
+ */
+int iio_release(struct inode *inode, struct file *filep)
+{
+	pr_debug("%s\n", __FUNCTION__);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_release);
+
+
+/*
+ * event interface
+ */
+int iio_event_open(struct inode *inode, struct file *filep)
+{
+	struct iio_device *idev;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	idev = container_of(inode->i_cdev, struct iio_device, event_cdev);
+	filep->private_data = idev;
+	idev->event_listener++;
+
+	return 0;
+}
+
+int iio_event_release(struct inode *inode, struct file *filep)
+{
+	struct iio_device *idev = filep->private_data;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	idev->event_listener--;
+	if (filep->f_flags & FASYNC) {
+		if (idev->fops->fasync)
+			idev->fops->fasync(-1, filep, 0);
+	}
+
+	return 0;
+}
+
+irqreturn_t iio_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct iio_device *idev = (struct iio_device *)dev_id;
+
+	if (idev->handler)
+		idev->handler(irq, dev_id, regs);
+
+	if (idev->event_listener) {
+		atomic_inc(&idev->event);
+		wake_up_interruptible(&idev->wait);
+		kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int iio_event_fasync(int fd, struct file *filep, int on)
+{
+	struct iio_device *idev = filep->private_data;
+
+	return fasync_helper(fd, filep, on, &idev->async_queue);
+}
+
+static unsigned int iio_event_poll(struct file *filep, poll_table *wait)
+{
+	struct iio_device *idev = filep->private_data;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	if (!idev->irq)
+		return -EIO;
+
+	poll_wait(filep, &idev->wait, wait);
+
+	return POLLIN | POLLRDNORM;
+}
+
+static ssize_t iio_event_read(struct file *filep, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct iio_device *idev = filep->private_data;
+	DECLARE_WAITQUEUE(wait, current);
+	ssize_t retval;
+	int event_count;
+
+	if (!idev->irq)
+		return -EIO;
+
+	if (count > sizeof(int))
+		count = sizeof(int);
+
+	add_wait_queue(&idev->wait, &wait);
+
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		event_count = atomic_read(&idev->event);
+		if (event_count)
+			break;
+
+		if (filep->f_flags & O_NONBLOCK) {
+			retval = -EAGAIN;
+			goto out;
+		}
+
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			goto out;
+		}
+		schedule();
+	} while (1);
+
+	atomic_dec(&idev->event);
+
+	if (copy_to_user(buf, &event_count, count))
+		retval = -EFAULT;
+	else
+		retval = sizeof(int);
+
+out:
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&idev->wait, &wait);
+
+	return retval;
+}
+
+ssize_t iio_event_write(struct file *filep, const char __user * buf,
+			size_t count, loff_t *ppos)
+{
+	struct iio_device *idev = filep->private_data;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	if (!idev->event_write)
+		return -EFAULT;
+
+	return idev->event_write(filep, buf, count, ppos);
+}
+
+struct file_operations iio_event_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= iio_event_read,
+	.write		= iio_event_write,
+	.poll		= iio_event_poll,
+	.open		= iio_event_open,
+	.release	= iio_event_release,
+	.fasync		= iio_event_fasync,
+};
--- /dev/null
+++ gregkh-2.6/drivers/iio/iio_dummy.c
@@ -0,0 +1,269 @@
+/*
+ * IIO dummy driver
+ *
+ * GPLv2 only.
+ */
+
+#define DEBUG 1
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/iio.h>
+
+#include <asm/io.h>
+
+#define MEMSIZE 8192
+
+static irqreturn_t iio_dummy_handler(int irq, void *dev_id,
+				     struct pt_regs *reg);
+
+static struct file_operations iio_dummy_fops = {
+	.open = iio_open,
+	.release = iio_release,
+	.read = iio_read,
+	.write = iio_write,
+	.llseek = iio_lseek,
+	.mmap = iio_mmap,
+};
+
+static struct iio_device iio_dummy_idev = {
+	.name = "IIO dummy",
+	.version = "0.00",
+	.fops = &iio_dummy_fops,
+	.size = MEMSIZE,
+	.read_offset = 0,
+	.read_len = MEMSIZE/2,
+	.write_offset = MEMSIZE/2,
+	.write_len = MEMSIZE/2,
+	.irq = -1,		/* cyclic timer */
+	.freq = HZ,
+	.irq_type = IIO_EVENT,
+	.handler = iio_dummy_handler,
+};
+
+struct iio_dummy_sig {
+	long pid;
+	int it_sigev_notify;		/* notify word of sigevent struct */
+	int it_sigev_signo;		/* signo word of sigevent struct */
+	sigval_t it_sigev_value;	/* value word of sigevent struct */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct sigqueue *sigq;		/* signal queue entry. */
+};
+
+static struct iio_dummy_sig iio_dummy_signal;
+static long iio_dummy_count;
+
+static ssize_t show_count(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	return sprintf(buf, "%ld\n", iio_dummy_count);
+}
+
+static ssize_t store_count(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	iio_dummy_count = simple_strtol(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(count, S_IRUGO|S_IWUSR|S_IWGRP, show_count, store_count);
+
+static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	return sprintf(buf, "%ld\n", iio_dummy_idev.freq);
+}
+static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	iio_dummy_idev.freq = simple_strtol(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(freq, S_IRUGO|S_IWUSR|S_IWGRP, show_freq, store_freq);
+
+static ssize_t show_sig_pid(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+		return sprintf(buf, "%ld\n", iio_dummy_signal.pid);
+}
+
+static ssize_t store_sig_pid(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	iio_dummy_signal.pid = simple_strtol(buf, NULL, 10);
+	if (iio_dummy_signal.pid == 0) {
+		if (iio_dummy_signal.it_process) {
+			put_task_struct(iio_dummy_signal.it_process);
+			iio_dummy_signal.it_process = NULL;
+		}
+
+		iio_dummy_signal.pid = 0;
+		return count;
+	}
+
+	if (iio_dummy_signal.pid == 1)
+		goto out;
+
+	iio_dummy_signal.it_process = find_task_by_pid(iio_dummy_signal.pid);
+	if (iio_dummy_signal.it_process) {
+		get_task_struct(iio_dummy_signal.it_process);
+		iio_dummy_signal.it_sigev_notify = SIGEV_SIGNAL;
+		iio_dummy_signal.it_sigev_signo = SIGALRM;
+		iio_dummy_signal.it_sigev_value.sival_int = 0;
+
+		return count;
+	}
+out:
+	iio_dummy_signal.pid = 0;
+	return -EINVAL;
+}
+
+static DEVICE_ATTR(sig_pid, S_IRUGO|S_IWUSR|S_IWGRP, show_sig_pid, store_sig_pid);
+
+static int iio_dummy_irqsig(struct iio_dummy_sig *io_sig, int si_private)
+{
+	int ret;
+	struct task_struct *leader;
+
+	if (!io_sig->it_process || !io_sig->sigq)
+		return 0;
+
+	memset(&io_sig->sigq->info, 0, sizeof(siginfo_t));
+	io_sig->sigq->info.si_sys_private = si_private;
+
+	/*
+	 * Send signal to a process waiting for an interrupt
+	 */
+	io_sig->sigq->info.si_signo = io_sig->it_sigev_signo;
+	io_sig->sigq->info.si_errno = 0;
+	io_sig->sigq->info.si_code = SI_TIMER;
+	io_sig->sigq->info.si_value = io_sig->it_sigev_value;
+
+	ret = send_sigqueue(io_sig->it_sigev_signo, io_sig->sigq,
+			    io_sig->it_process);
+
+	if (likely(ret >= 0))
+		return ret;
+
+	io_sig->it_sigev_notify = SIGEV_SIGNAL;
+	leader = io_sig->it_process->group_leader;
+	put_task_struct(io_sig->it_process);
+	io_sig->it_process = leader;
+
+	return send_group_sigqueue(io_sig->it_sigev_signo, io_sig->sigq,
+				   io_sig->it_process);
+}
+
+static irqreturn_t iio_dummy_handler(int irq, void *dev_id, struct pt_regs *reg)
+{
+	struct iio_device *idev = (struct iio_device *)dev_id;
+	iio_dummy_count++;
+
+	*((long *) idev->physaddr) = iio_dummy_count;
+	iio_dummy_irqsig(&iio_dummy_signal, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit iio_dummy_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	iio_dummy_idev.physaddr = (unsigned long)kmalloc(MEMSIZE, GFP_KERNEL);
+	if (!iio_dummy_idev.physaddr)
+		return -ENOMEM;
+
+	pdev->dev.driver_data = (void *)iio_register_device(NULL, &iio_dummy_idev);
+
+	iio_dummy_signal.sigq = sigqueue_alloc();
+
+	return (pdev->dev.driver_data) ? 0 : -ENODEV;
+}
+
+static int __devexit iio_dummy_remove(struct device *dev)
+{
+	pr_debug("%s\n", __FUNCTION__);
+	sigqueue_free(iio_dummy_signal.sigq);
+	iio_dummy_signal.sigq = NULL;
+
+	return 0;
+}
+
+static void iio_dummy_shutdown(struct device *dev)
+{
+	pr_debug("%s\n", __FUNCTION__);
+}
+
+struct platform_device *iio_dummy_device;
+
+static struct device_driver iio_dummy_driver = {
+	.name		= "iio_dummy",
+	.bus		= &platform_bus_type,
+	.probe		= iio_dummy_probe,
+	.remove		= __devexit_p(iio_dummy_remove),
+	.shutdown	= iio_dummy_shutdown,
+};
+
+/*
+ * Main initialization/remove routines
+ */
+
+static int __init iio_dummy_init(void)
+{
+	int ret;
+
+	pr_debug("%s\n", __FUNCTION__);
+
+	iio_dummy_device = platform_device_register_simple("iio_dummy", -1,
+							   NULL, 0);
+	if (IS_ERR(iio_dummy_device)) {
+		ret = PTR_ERR(iio_dummy_device);
+		goto out;
+	}
+
+	ret = device_create_file(&iio_dummy_device->dev, &dev_attr_count);
+	if (ret)
+		goto error_register;
+	ret = device_create_file(&iio_dummy_device->dev, &dev_attr_freq);
+	if (ret)
+		goto error_file_count;
+	ret = device_create_file(&iio_dummy_device->dev, &dev_attr_sig_pid);
+	if (ret)
+		goto error_file_freq;
+
+	ret = driver_register(&iio_dummy_driver);
+	if (ret)
+		goto error_file_sig;
+
+	goto out;
+
+error_file_sig:
+	device_remove_file(&iio_dummy_device->dev, &dev_attr_sig_pid);
+error_file_freq:
+	device_remove_file(&iio_dummy_device->dev, &dev_attr_freq);
+error_file_count:
+	device_remove_file(&iio_dummy_device->dev, &dev_attr_count);
+error_register:
+	platform_device_unregister(iio_dummy_device);
+out:
+	return ret;
+}
+
+void __exit iio_dummy_exit(void)
+{
+	pr_debug("%s\n", __FUNCTION__);
+
+	iio_unregister_device((int) iio_dummy_device->dev.driver_data);
+	kfree((void *) iio_dummy_idev.physaddr);
+
+	platform_device_unregister(iio_dummy_device);
+	driver_unregister(&iio_dummy_driver);
+}
+
+module_init(iio_dummy_init);
+module_exit(iio_dummy_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Benedikt Spranger");
+MODULE_DESCRIPTION("IIO dummy driver");
--- /dev/null
+++ gregkh-2.6/include/linux/iio.h
@@ -0,0 +1,108 @@
+/*
+ * include/linux/iio.h
+ *
+ * Copyright(C) 2005, Benedikt Spranger <b.spranger@linutronix.de>
+ * Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Industrial IO
+ *
+ * header
+ *
+ * Licensed under the GPLv2 only.
+ */
+
+#ifndef _LINUX_IIO_H_
+#define _LINUX_IIO_H_
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+
+enum iio_irq_type {
+	IIO_EVENT,
+	IIO_THREADED,
+	IIO_NODELAY,
+};
+
+/*
+ * iio_device - IIO device capabilities
+ *
+ * @name:		device name
+ * @version:		device driver version
+ * @physaddr:		physical address
+ * @virtaddr:		iomaped address (optional)
+ * @size:		size of IO
+ * read_offset:		offset to inputs
+ * read_len:		input length
+ * write_offset:	offset to outputs
+ * write_len:		output length
+ * irq:			interrupt, -1 for cyclic mode, -2 for oneshot mode
+ * freq:		frequency for cyclic mode
+ * next_event:		next event for oneshot mode
+ * irq_type:		interrupt type
+ */
+
+struct iio_device {
+	/* internals */
+	struct device           dev;
+	struct cdev		cdev;
+	struct cdev		event_cdev;
+	long			event_listener;
+	atomic_t		event;
+	struct timer_list	poll_timer;
+	struct fasync_struct	*async_queue;
+	wait_queue_head_t	wait;
+	atomic_t		event_count;
+	atomic_t		waiters;
+	atomic_t		running;
+	atomic_t		terminate;
+
+	/* attributes */
+	char			*name;
+	char			*version;
+	unsigned long		physaddr;
+	void			*virtaddr;
+	unsigned long           size;
+	long			read_offset;
+	long			read_len;
+	long			write_offset;
+	long			write_len;
+	long			irq;
+	long			freq;
+	ktime_t			next_event;
+	enum iio_irq_type	irq_type;
+
+	/* callbacks */
+	irqreturn_t (*handler)(int irq, void *dev_id, struct pt_regs *regs);
+	ssize_t (*event_write)(struct file *filep, const char __user * buf,
+			       size_t count, loff_t *ppos);
+
+	/* fops */
+	struct file_operations	*fops;
+
+	/* driver private */
+	void			*priv;
+};
+
+int iio_register_device(struct device *parent, struct iio_device *idev);
+int iio_unregister_device(int dev_nr);
+
+#define to_iio_device(n) container_of(n, struct iio_device, dev)
+
+/* char device funktions */
+
+loff_t iio_lseek(struct file *filep, loff_t offset, int orig);
+ssize_t iio_read(struct file *filep, char __user *buf, size_t count, loff_t *ppos);
+ssize_t iio_write(struct file *filep, const char __user * buf, size_t count,
+		   loff_t *ppos);
+int iio_open(struct inode *inode, struct file *filep);
+int iio_mmap(struct file *filep, struct vm_area_struct *vma);
+int iio_release(struct inode *inode, struct file *filep);
+
+/* event */
+irqreturn_t iio_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern struct file_operations iio_event_fops;
+
+#endif /* _LINUX_IIO_H_ */
--- gregkh-2.6.orig/kernel/signal.c
+++ gregkh-2.6/kernel/signal.c
@@ -1296,6 +1296,7 @@ struct sigqueue *sigqueue_alloc(void)
 		q->flags |= SIGQUEUE_PREALLOC;
 	return(q);
 }
+EXPORT_SYMBOL_GPL(sigqueue_alloc);
 
 void sigqueue_free(struct sigqueue *q)
 {
@@ -1317,6 +1318,7 @@ void sigqueue_free(struct sigqueue *q)
 	q->flags &= ~SIGQUEUE_PREALLOC;
 	__sigqueue_free(q);
 }
+EXPORT_SYMBOL_GPL(sigqueue_free);
 
 int send_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
 {
@@ -1367,6 +1369,7 @@ out_err:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(send_sigqueue);
 
 int
 send_group_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
@@ -1412,6 +1415,7 @@ out:
 	read_unlock(&tasklist_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(send_group_sigqueue);
 
 /*
  * Wake up any threads in the parent blocked in wait* syscalls.

