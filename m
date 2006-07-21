Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWGUVN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWGUVN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGUVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:13:59 -0400
Received: from mail1.cenara.com ([193.111.152.3]:40405 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S1751191AbWGUVN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:13:58 -0400
From: Magnus =?ISO-8859-1?Q?=20Vigerl=F6f?= <wigge@bigfoot.com>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org,
       Magnus =?ISO-8859-1?Q?=20Vigerl=F6f?= <wigge@bigfoot.com>
Date: Fri, 21 Jul 2006 23:13:41 +0200
Message-Id: <20060721211341.5366.93270.sendpatchset@pipe>
Subject: [RFC] input: Wacom tablet driver for simple X hotplugging
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a device driver that simplifies hotplugging Wacom
tablets when running X.

I've posted the driver on the linuxwacom m-l and the response so far
has been positive as it makes hot-plugging Wacom tablets even easier,
but questions has been rised if this couldn't be made into a generic
module for other devices than Wacom tablets.

The 'problem' is that the normal evdev-driver removes the inputX
device when the physical device is unplugged and this causes the
X-server to close the device and not re-open it until the user
switches VT.

My device driver (patch attached below) works pretty much like the
evdev-driver except that it it registers one device when it is loaded
and simulates a Wacom tablet even when none is connected to the
system. This way the X-server will never notice the absence of a
tablet and whenever a tablet is (re)connected it will work without any
tricks.


I'd appreciate whether you think this is a viable idea to make it as a
generic driver instead or should I continue with the Wacom-specific
one. I know the 'right' thing would be to make X truly hot-plug aware,
but this driver is something that would be possible to use in current
systems without any problems.

If it is a viable idea; Which other devices/types of device do you
think could be of interest to handle in a similar fashion? Tablets of
different makes/models are obvious, but are there any others that
would benefit from a similar driver?

And third, should something like this be a separate driver or should
the functionallity be included in the evdev-driver?


Note, the patch is included for idea visualization and not by any
means something I consider ready to be submitted. I know I have a few
issues that I must sort out first, however it does work in its current
state.

BR
  Magnus

---

--
diff -uprN -X linux-2.6.17.5/Documentation/dontdiff linux-2.6.17.5-vanilla/drivers/input/Kconfig linux-2.6.17.5/drivers/input/Kconfig
--- linux-2.6.17.5-vanilla/drivers/input/Kconfig	2006-07-15 04:38:43.000000000 +0200
+++ linux-2.6.17.5/drivers/input/Kconfig	2006-07-16 22:22:53.000000000 +0200
@@ -117,6 +117,25 @@ config INPUT_EVDEV
 	  To compile this driver as a module, choose M here: the
 	  module will be called evdev.
 
+config INPUT_WACOMPROXY
+	tristate "Wacom tablet proxy device"
+	default y
+	depends on EXPERIMENTAL
+	---help---
+	  Say Y here if you want a proxy device that will emulate the
+	  latest connected Wacom device when no Wacom tablet is connected.
+	  The initial device it will emulate is a Wacom Penpartner. Only
+	  one Wacom tablet will be available at a time, and the tablets
+	  are opened in the order they are connected. The device is
+	  accessible as a single char device 10:xx - /dev/input/wacomproxy.
+
+	  The minor device used can be found in the
+	  /sys/class/input/wacomproxy/dev file once the module has
+	  been loaded.
+
+	  To compile this driver as a module, choose M here, the module
+	  will be called wacomproxy.
+
 config INPUT_EVBUG
 	tristate "Event debugging"
 	---help---
diff -uprN -X linux-2.6.17.5/Documentation/dontdiff linux-2.6.17.5-vanilla/drivers/input/Makefile linux-2.6.17.5/drivers/input/Makefile
--- linux-2.6.17.5-vanilla/drivers/input/Makefile	2006-07-15 04:38:43.000000000 +0200
+++ linux-2.6.17.5/drivers/input/Makefile	2006-07-16 23:38:05.000000000 +0200
@@ -11,6 +11,7 @@ obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
 obj-$(CONFIG_INPUT_TSDEV)	+= tsdev.o
 obj-$(CONFIG_INPUT_POWER)	+= power.o
 obj-$(CONFIG_INPUT_EVBUG)	+= evbug.o
+obj-$(CONFIG_INPUT_WACOMPROXY)	+= wacomproxy.o
 
 obj-$(CONFIG_INPUT_KEYBOARD)	+= keyboard/
 obj-$(CONFIG_INPUT_MOUSE)	+= mouse/
diff -uprN -X linux-2.6.17.5/Documentation/dontdiff linux-2.6.17.5-vanilla/drivers/input/wacomproxy.c linux-2.6.17.5/drivers/input/wacomproxy.c
--- linux-2.6.17.5-vanilla/drivers/input/wacomproxy.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17.5/drivers/input/wacomproxy.c	2006-07-16 23:17:14.000000000 +0200
@@ -0,0 +1,732 @@
+/* -*- linux-c -*-
+ *
+ * Copyright (c) 2006 Magnus Vigerlöf
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/*
+ * ChangeLog:
+ *
+ * 20060702: First version. Based on the work on tabletsdev kernel
+ *           module.
+ *
+ * 20060710: Added parameter to make the module act like evdev when
+ *           grabbing the device. Fixed a grab-issue, it sometimes
+ *           didn't marked the device as grabbed. Updated/fixed the
+ *           ioctl-method. Made the whole thing SMP-safe (hopefully).
+ *           Fixed a crash when copying data to the dummy-device,
+ *
+ * 20060715: Changed the coding standard to 'Linux kernel coding
+ *           style'. Removed a memory leak when disconnecting the
+ *           tablet. Removed lots of debug-printk. Parameterized
+ *           whether to print the name of an input device that is
+ *           skipped.
+ *
+ * 200607XX: Fixed compilation issue with kernel 2.6.17 (wp_ioctl).
+
+ */
+/*
+ * wacomproxy.c: A module that acts like a proxy for one tablet
+ * connected to the system, all other tablets will be put into a list
+ * and when the first connected tablet is unplugged, the next in the
+ * list be used. The device will be accessible as
+ * /dev/input/wacomproxy as long as the module is loaded. Initially
+ * when there's no tablet connected it will emulate a 'Wacom
+ * Penpartner', but as soon as a different tablet is connected it will
+ * automatically change its id to that model (telling all that has the
+ * device open at the time about this). When the tablet is unplugged
+ * the device will retain the id of the last connected tablet so it
+ * will be possible to plug in a tablet of the same model without
+ * affecting the application that has this device open.
+ */
+/*
+ * What needs to be investigated and maybe changed/corrected:
+ *
+ * FINDOUT: GRAB, what should the semantics be?
+ * FINDOUT: Should the device really be registered in 'misc'-major?
+ * FINDOUT: Is there a need to support several connected tablets?
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <linux/major.h>
+#include <linux/miscdevice.h>
+
+#include <linux/input.h>
+#include <linux/list.h>
+
+#include <linux/poll.h>
+
+#include <asm/semaphore.h>
+
+#define WP_MODNAME "wacomproxy"
+#define WP_DEVNAME "wacomproxy"
+#define WP_BUFFER_SIZE 64
+
+#define WP_FLAG_OPEN 0x01
+#define WP_FLAG_GRAB 0x02
+
+/** Additional features, define to turn them on **/
+/* Add the possibillity to force return of ENODEV when opening, */
+/* reading, polling, etc */
+#define OPENFAILCOUNT
+
+/* ################################################################### */
+/*                  Module Information                                 */
+/* ################################################################### */
+MODULE_AUTHOR("Magnus Vigerlöf <wigge@bigfoot.com>");
+MODULE_DESCRIPTION("Wacom tablet proxy module");
+MODULE_LICENSE("GPL");
+
+/* ################################################################### */
+/*                  Module Parameters                                  */
+/* ################################################################### */
+static int exclusivegrab = 0;
+module_param(exclusivegrab, bool, 0444);
+MODULE_PARM_DESC(exclusivegrab, "Defines behaviour of the GRAB ioctl, y "
+		 "gives the same behaviour as eventX.");
+
+static int debugconnect = 0;
+module_param(debugconnect, bool, 0644);
+MODULE_PARM_DESC(debugconnect, "Defines whether to print the names of "
+		 "the ignored devices, y will print the names.");
+
+static short openfailcount = 0;
+#ifdef OPENFAILCOUNT
+module_param(openfailcount, short, 0644);
+MODULE_PARM_DESC(openfailcount, "Number of upcoming open that will fail"
+		 " with -ENODEV.");
+#endif
+
+/* ################################################################### */
+/*                  Module Structures                                  */
+/* ################################################################### */
+/* struct used for keeping track of those who has opened our device */
+struct wp_filenode {
+	struct list_head node;
+
+	int flags;
+	int tabletid;
+
+	struct input_event buffer[WP_BUFFER_SIZE];
+	int head;
+	int tail;
+
+	struct fasync_struct *fasync;
+};
+
+/* struct for keeping track of the connected devices */
+struct wp_devnode {
+	struct list_head node;
+	struct input_handle handle;
+
+	int flags;
+	int tabletid;
+	const char* devdesc;
+};
+
+/* ################################################################### */
+/*                  Internal Module Variables                          */
+/* ################################################################### */
+/* List of accepted tablets */
+static const char* wp_tabletlist[] = {
+	"Wacom Penpartner",
+	"Wacom Graphire",
+	"Wacom Graphire2 4x5",
+	"Wacom Graphire2 5x7",
+	"Wacom Graphire3",
+	"Wacom Graphire3 6x8",
+	"Wacom Graphire4 4x5",
+	"Wacom Graphire4 6x8",
+	"Wacom Volito",
+	"Wacom PenStation2",
+	"Wacom Volito2 4x5",
+	"Wacom Volito2 2x3",
+	"Wacom PenPartner2",
+	"Wacom Intuos 4x5",
+	"Wacom Intuos 6x8",
+	"Wacom Intuos 9x12",
+	"Wacom Intuos 12x12",
+	"Wacom Intuos 12x18",
+	"Wacom PL400",
+	"Wacom PL500",
+	"Wacom PL600",
+	"Wacom PL600SX",
+	"Wacom PL550",
+	"Wacom PL800",
+	"Wacom PL700",
+	"Wacom PL510",
+	"Wacom DTU710",
+	"Wacom DTF521",
+	"Wacom DTF720",
+	"Wacom Cintiq Partner",
+	"Wacom Intuos2 4x5",
+	"Wacom Intuos2 6x8",
+	"Wacom Intuos2 9x12",
+	"Wacom Intuos2 12x12",
+	"Wacom Intuos2 12x18",
+	"Wacom Intuos3 4x5",
+	"Wacom Intuos3 6x8",
+	"Wacom Intuos3 9x12",
+	"Wacom Intuos3 12x12",
+	"Wacom Intuos3 12x19",
+	"Wacom Intuos3 6x11",
+	"Wacom Cintiq 21UX",
+	"Wacom Intuos2 6x8",
+	NULL
+};
+
+/* Proxy device/handler data for emulation of tablet */
+static struct input_dev  wp_proxydev;
+static struct wp_devnode wp_proxyhndl;
+
+/* Wait queue for blocking operations */
+static wait_queue_head_t wp_waitq;
+
+/* List of those who has opened our device */
+static struct list_head wp_users;
+
+/* List of connected devices */
+static struct list_head wp_tablets;
+
+/* Counter on how many has grabbed the device */
+static int wp_devgrabcount;
+
+/* Misc-dev registering info */
+static struct miscdevice wp_miscdev;
+
+/* Current tablet that provides data to the system */
+static struct wp_devnode* wp_currenthndl;
+
+/* Mutex that serialize all SMP-unsafe activities */
+static struct semaphore wp_sema;
+
+/* ################################################################### */
+/*                  Module IOCTL Helper Methods                        */
+/* ################################################################### */
+static int bits_to_user(unsigned long *bits, unsigned int maxbit,
+                        unsigned int maxlen, void __user *p)
+{
+	int len = NBITS(maxbit) * sizeof(long);
+
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_to_user(p, bits, len) ? -EFAULT : len;
+}
+
+static int str_to_user(const char *str, unsigned int maxlen,
+		       void __user *p)
+{
+	int len;
+
+	if (!str)
+		return -ENOENT;
+
+	len = strlen(str) + 1;
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_to_user(p, str, len) ? -EFAULT : len;
+}
+
+/* ################################################################### */
+/*                  Module File Methods                                */
+/* ################################################################### */
+static int wp_open(struct inode *inodp, struct file *filp)
+{
+	struct wp_filenode *list;
+
+	if (openfailcount > 0) {
+		openfailcount--;
+		return -ENODEV;
+	}
+
+	if (!(list = kzalloc(sizeof(*list), GFP_KERNEL)))
+		return -ENOMEM;
+
+	filp->private_data = list;
+	list->tabletid = wp_proxyhndl.tabletid;
+
+	down(&wp_sema);
+	list_add_tail(&list->node, &wp_users);
+	if (wp_currenthndl != &wp_proxyhndl) {
+		if (!(wp_currenthndl->flags & WP_FLAG_OPEN)) {
+			if (!input_open_device(&wp_currenthndl->handle))
+				wp_currenthndl->flags |= WP_FLAG_OPEN;
+			else
+				printk(KERN_WARNING WP_MODNAME
+				       ": Failed to open '%s'\n",
+				       wp_currenthndl->devdesc);
+		}
+	}
+	up(&wp_sema);
+	return 0;
+}
+
+static int wp_fasync(int fd, struct file *filp, int on)
+{
+	struct wp_filenode *list = filp->private_data;
+
+	int retval = fasync_helper(fd, filp, on, &list->fasync);
+	return retval < 0 ? retval : 0;
+}
+
+static int wp_release(struct inode *inodp, struct file *filp)
+{
+	struct wp_filenode *list = filp->private_data;
+
+	down(&wp_sema);
+	list_del(&list->node);
+	if (list->flags & WP_FLAG_GRAB) {
+		wp_devgrabcount--;
+		if (wp_devgrabcount <= 0) {
+			if (wp_currenthndl->flags & WP_FLAG_GRAB) {
+				input_release_device(&wp_currenthndl->handle);
+				wp_currenthndl->flags &= ~WP_FLAG_GRAB;
+			}
+		}
+	}
+	if (list_empty(&wp_users)) {
+		if (wp_currenthndl->flags & WP_FLAG_OPEN) {
+			input_close_device(&wp_currenthndl->handle);
+			wp_currenthndl->flags &= ~WP_FLAG_OPEN;
+		}
+	}
+	up(&wp_sema);
+
+	wp_fasync(-1, filp, 0);
+	kfree(list);
+	return 0;
+}
+
+static ssize_t wp_read(struct file *filp, char __user *buffer,
+		       size_t count, loff_t *ppos)
+{
+	struct wp_filenode *list = filp->private_data;
+	struct input_event *event;
+	int retval;
+
+	if (openfailcount > 0)
+		return -ENODEV;
+
+	/* Ensure that the tablet id is the same as we had when we */
+	/* opened it */
+	if (wp_proxyhndl.tabletid != list->tabletid)
+		return -ENODEV;
+
+	if (count < sizeof(*event))
+		return -EINVAL;
+
+	if (list->head == list->tail && (filp->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval = wait_event_interruptible(wp_waitq,
+			(list->head != list->tail
+			 || wp_proxyhndl.tabletid != list->tabletid));
+	if (retval)
+		return retval;
+
+	/* Ensure that the tablet id is still the same as we had when */
+	/* we opened it */
+	if (wp_proxyhndl.tabletid != list->tabletid)
+		return -ENODEV;
+
+	while (list->head != list->tail && retval + sizeof(*event) <= count) {
+		event = (struct input_event *) list->buffer + list->tail;
+		if (copy_to_user(buffer + retval, event, sizeof(*event)))
+			return -EFAULT;
+		list->tail = (list->tail + 1) & (WP_BUFFER_SIZE - 1);
+		retval += sizeof(*event);
+	}
+	return retval;
+}
+
+static int wp_ioctl(struct inode *inodp, struct file *filp,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct wp_filenode *list = filp->private_data;
+	struct input_absinfo abs;
+	int __user *ip = (int __user *)arg;
+
+	if (openfailcount > 0)
+		return -ENODEV;
+
+	/* Ensure that the tablet id is the same as we had when we */
+	/* opened it */
+	if (wp_proxyhndl.tabletid != list->tabletid)
+		return -ENODEV;
+
+	switch (cmd) {
+	case EVIOCGVERSION:
+		return put_user(EV_VERSION, ip);
+
+	case EVIOCGID:
+		if(copy_to_user(ip, &wp_proxydev.id, sizeof(struct input_id)))
+			return -EFAULT;
+		return 0;
+
+	case EVIOCGRAB:
+		if (arg) {
+			/* Check if only one may grab the device at a time */
+			if (exclusivegrab && wp_devgrabcount > 0)
+				return -EBUSY;
+			if (list->flags & WP_FLAG_GRAB)
+				return -EBUSY;
+			down(&wp_sema);
+			list->flags |= WP_FLAG_GRAB;
+			wp_devgrabcount++;
+			if (wp_currenthndl != &wp_proxyhndl) {
+				if (!(wp_currenthndl->flags & WP_FLAG_GRAB)) {
+					if (!input_grab_device(&wp_currenthndl->handle))
+						wp_currenthndl->flags |= WP_FLAG_GRAB;
+					else
+						printk(KERN_WARNING WP_MODNAME
+						       ": Failed to grab device\n");
+				}
+			}
+			up(&wp_sema);
+		}
+		else {
+			if (!(list->flags & WP_FLAG_GRAB))
+				return -EINVAL;
+			down(&wp_sema);
+			list->flags &= ~WP_FLAG_GRAB;
+			wp_devgrabcount--;
+			if (wp_currenthndl != &wp_proxyhndl) {
+				if (!wp_devgrabcount) {
+					input_release_device(&wp_currenthndl->handle);
+					wp_currenthndl->flags &= ~WP_FLAG_GRAB;
+				}
+			}
+			up(&wp_sema);
+		}
+		return 0;
+
+	default:
+		if (_IOC_TYPE(cmd) != 'E')
+			return -EINVAL;
+		if (_IOC_DIR(cmd) == _IOC_READ) {
+			if ((_IOC_NR(cmd) & ~EV_MAX) == _IOC_NR(EVIOCGBIT(0,0))) {
+				long *bits;
+				int len;
+				switch (_IOC_NR(cmd) & EV_MAX) {
+				case      0:
+					bits = wp_proxydev.evbit;
+					len = EV_MAX;
+					break;
+				case EV_KEY:
+					bits = wp_proxydev.keybit;
+					len = KEY_MAX;
+					break;
+				case EV_REL:
+					bits = wp_proxydev.relbit;
+					len = REL_MAX;
+					break;
+				case EV_ABS:
+					bits = wp_proxydev.absbit;
+					len = ABS_MAX;
+					break;
+				case EV_MSC:
+					bits = wp_proxydev.mscbit;
+					len = MSC_MAX;
+					break;
+				default:
+					return -EINVAL;
+				}
+				return bits_to_user(bits, len, _IOC_SIZE(cmd), ip);
+			}
+
+			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
+				return str_to_user(wp_proxydev.name,
+						   _IOC_SIZE(cmd), ip);
+
+			if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCGABS(0))) {
+				int t = _IOC_NR(cmd) & ABS_MAX;
+				abs.value =   wp_proxydev.abs[t];
+				abs.minimum = wp_proxydev.absmin[t];
+				abs.maximum = wp_proxydev.absmax[t];
+				abs.fuzz =    wp_proxydev.absfuzz[t];
+				abs.flat =    wp_proxydev.absflat[t];
+				if (copy_to_user(ip, &abs, sizeof(abs)))
+					return -EFAULT;
+				return 0;
+			}
+		}
+	}
+	return -EINVAL;
+}
+
+static unsigned int wp_poll(struct file *filp, poll_table *wait)
+{
+	struct wp_filenode *list = filp->private_data;
+	int rval = 0;
+
+	poll_wait(filp, &wp_waitq, wait);
+	if (list->head != list->tail)
+		rval = POLLIN | POLLRDNORM;
+
+	/* Add info that we're closed if we've changed tablet id, or */
+	/* failcount > 0 */
+	if (wp_proxyhndl.tabletid != list->tabletid || openfailcount > 0)
+		rval |= POLLIN | POLLRDNORM | POLLHUP | POLLERR;
+
+	return rval;
+}
+
+static struct file_operations wp_fops = {
+	.owner =   THIS_MODULE,
+	.open =    wp_open,
+	.fasync =  wp_fasync,
+	.release = wp_release,
+	.read =    wp_read,
+	.ioctl =   wp_ioctl,
+	.poll =    wp_poll,
+};
+
+/* ################################################################### */
+/*                  Module Input Methods                               */
+/* ################################################################### */
+static void wp_event(struct input_handle *handle, unsigned int type,
+		     unsigned int code, int value)
+{
+	struct wp_filenode *list;
+
+	down(&wp_sema);
+	list_for_each_entry(list, &wp_users, node) {
+		if (!exclusivegrab || !wp_devgrabcount
+		    || list->flags & WP_FLAG_GRAB) {
+			do_gettimeofday(&list->buffer[list->head].time);
+			list->buffer[list->head].type = type;
+			list->buffer[list->head].code = code;
+			list->buffer[list->head].value = value;
+			list->head = (list->head + 1) & (WP_BUFFER_SIZE - 1);
+			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+		}
+	}
+	up(&wp_sema);
+	wake_up_interruptible(&wp_waitq);
+}
+
+static void wp_open_first_dev(void)
+{
+	struct input_dev *dev;
+	struct wp_devnode *devh;
+	struct wp_filenode *list;
+
+	if (wp_currenthndl != &wp_proxyhndl)
+		return;
+
+	if (list_empty(&wp_tablets))
+		return;
+
+	devh = list_entry(wp_tablets.next, struct wp_devnode, node);
+	dev = devh->handle.dev;
+	wp_currenthndl = devh;
+
+	/* Check if the first tablet in the list has the same */
+	/* identification (= the same properties) if so, no need to */
+	/* tell the users that they need to reconnect */
+	if (wp_proxyhndl.tabletid != devh->tabletid) {
+		/* Copy the values we use to the proxy dev struct so */
+		/* we can emulate this dev when it's disconnected */
+		wp_proxydev.name = devh->devdesc;
+		memcpy(&wp_proxydev.id, &dev->id, sizeof(dev->id));
+		memcpy(&wp_proxydev.evbit, &dev->evbit, sizeof(dev->evbit));
+		memcpy(&wp_proxydev.keybit, &dev->keybit, sizeof(dev->keybit));
+		memcpy(&wp_proxydev.relbit, &dev->relbit, sizeof(dev->relbit));
+		memcpy(&wp_proxydev.absbit, &dev->absbit, sizeof(dev->absbit));
+		memcpy(&wp_proxydev.mscbit, &dev->mscbit, sizeof(dev->mscbit));
+		memcpy(&wp_proxydev.absmax, &dev->absmax, sizeof(dev->absmax));
+		memcpy(&wp_proxydev.absmin, &dev->absmin, sizeof(dev->absmin));
+		memcpy(&wp_proxydev.absfuzz, &dev->absfuzz, sizeof(dev->absfuzz));
+		memcpy(&wp_proxydev.absflat, &dev->absflat, sizeof(dev->absflat));
+		/* Tell the world that we're using a new tablet model */
+		wp_proxyhndl.tabletid = devh->tabletid;
+		list_for_each_entry(list, &wp_users, node)
+			kill_fasync(&list->fasync, SIGIO, POLL_HUP);
+		wake_up_interruptible(&wp_waitq);
+	}
+
+	/* No need to open the device if there's a change in */
+	/* the id as all must close/reopen again anyway. */
+	else if (!list_empty(&wp_users)) {
+		if (!input_open_device(&devh->handle)) {
+			devh->flags |= WP_FLAG_OPEN;
+			if (wp_devgrabcount > 0) {
+				if (!input_grab_device(&devh->handle))
+					devh->flags |= WP_FLAG_GRAB;
+				else
+					printk(KERN_WARNING WP_MODNAME
+					       ": Failed to grab '%s'\n",
+					       dev->name);
+			}
+		}
+		else
+			printk(KERN_WARNING WP_MODNAME
+			       ": Failed to open '%s'\n", dev->name);
+	}
+}
+
+static struct input_handle *wp_connect(struct input_handler *handler,
+				       struct input_dev *dev,
+				       struct input_device_id *id)
+{
+	struct wp_devnode *devh;
+	int c, tab=-1;
+
+	if (!dev->name) {
+		printk(KERN_ERR WP_MODNAME ": Attempting to attach unnamed "
+		       "tablet device.\n");
+		return NULL;
+	}
+
+	for (c=0; wp_tabletlist[c]; c++) {
+		if(!strcmp(dev->name, wp_tabletlist[c])) {
+			tab = c;
+			break;
+		}
+	}
+	if (tab == -1) {
+		if (debugconnect)
+			printk(KERN_INFO WP_MODNAME ": Skipping unknown device "
+			       "'%s'.\n", dev->name);
+		return NULL;
+	}
+
+ 	printk(KERN_INFO WP_MODNAME ": Attaching '%s'\n", dev->name);
+	if (!(devh = kzalloc(sizeof(*devh), GFP_KERNEL)))
+		return NULL;
+
+	devh->handle.dev = dev;
+	devh->handle.name = WP_DEVNAME;
+	devh->handle.handler = handler;
+	devh->handle.private = devh;
+	devh->tabletid = tab;
+	devh->devdesc = wp_tabletlist[tab];
+
+	down(&wp_sema);
+	list_add_tail(&devh->node, &wp_tablets);
+	wp_open_first_dev();
+	up(&wp_sema);
+	return &devh->handle;
+}
+
+static void wp_disconnect(struct input_handle *handle)
+{
+	struct wp_devnode *devh = handle->private;
+
+	down(&wp_sema);
+	if (wp_currenthndl == devh) {
+		wp_currenthndl = &wp_proxyhndl;
+		if (devh->flags & WP_FLAG_GRAB) {
+			input_release_device(handle);
+			devh->flags &= ~WP_FLAG_GRAB;
+		}
+		if (devh->flags & WP_FLAG_OPEN) {
+			input_close_device(handle);
+			devh->flags &= ~WP_FLAG_OPEN;
+		}
+	}
+	list_del(&devh->node);
+	wp_open_first_dev();
+	up(&wp_sema);
+	kfree(devh);
+}
+
+static struct input_device_id wp_ids[] = {
+	{ .driver_info = 1 },   /* Matches all devices, name match later */
+	{ }, /* Terminating Z-entry */
+};
+
+static struct input_handler wp_handler = {
+	.event =      wp_event,
+	.connect =    wp_connect,
+	.disconnect = wp_disconnect,
+	.name =       WP_MODNAME,
+	.id_table =   wp_ids,
+};
+
+/* ################################################################### */
+/*                  Module Initialization Methods                      */
+/* ################################################################### */
+static void __init wp_moduledatainit(void)
+{
+	init_waitqueue_head(&wp_waitq);
+	INIT_LIST_HEAD(&wp_tablets);
+	INIT_LIST_HEAD(&wp_users);
+	init_MUTEX(&wp_sema);
+
+	/* Initialize proxy device to initially emulate a */
+	/* 'Wacom Penpartner' */
+	wp_proxydev.name = wp_tabletlist[0];
+	wp_proxydev.id.bustype = BUS_USB;
+	wp_proxydev.id.vendor  = 0x056a;
+	wp_proxydev.id.product = 0x0000;
+	wp_proxydev.id.version = 0x0001;
+	wp_proxydev.evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
+	wp_proxydev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
+	wp_proxydev.keybit[LONG(BTN_TOOL_PEN)]    |= BIT(BTN_TOOL_PEN);
+	wp_proxydev.keybit[LONG(BTN_TOUCH)]       |= BIT(BTN_TOUCH);
+	wp_proxydev.keybit[LONG(BTN_STYLUS)]      |= BIT(BTN_STYLUS);
+	wp_proxydev.keybit[LONG(BTN_TOOL_RUBBER)] |= BIT(BTN_TOOL_RUBBER);
+	wp_proxydev.absbit[LONG(ABS_MISC)]        |= BIT(ABS_MISC);
+	input_set_abs_params(&wp_proxydev, ABS_X, 0, 5040, 4, 0);
+	input_set_abs_params(&wp_proxydev, ABS_Y, 0, 3780, 4, 0);
+	input_set_abs_params(&wp_proxydev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	wp_proxyhndl.handle.dev = &wp_proxydev;
+	wp_proxyhndl.handle.name = WP_DEVNAME;
+	wp_proxyhndl.handle.private = &wp_proxyhndl;
+	wp_proxyhndl.devdesc = wp_tabletlist[0];
+
+	wp_currenthndl = &wp_proxyhndl;
+}
+
+static int __init wp_init(void)
+{
+	struct class_device *cls;
+	int c;
+
+	wp_moduledatainit();
+
+	wp_miscdev.minor = MISC_DYNAMIC_MINOR;
+	wp_miscdev.name = WP_DEVNAME;
+	wp_miscdev.fops = &wp_fops;
+	if ((c = misc_register(&wp_miscdev)))
+		return c;
+
+	input_register_handler(&wp_handler);
+
+	cls = class_device_create(&input_class, NULL,
+				  MKDEV(MISC_MAJOR, wp_miscdev.minor),
+				  NULL, WP_DEVNAME);
+	if (IS_ERR(cls)) {
+		input_unregister_handler(&wp_handler);
+		misc_deregister(&wp_miscdev);
+		return PTR_ERR(cls);
+	}
+	return 0;
+}
+
+static void __exit wp_exit(void)
+{
+	class_device_destroy(&input_class,
+			     MKDEV(MISC_MAJOR, wp_miscdev.minor));
+	input_unregister_handler(&wp_handler);
+	misc_deregister(&wp_miscdev);
+}
+
+module_init(wp_init);
+module_exit(wp_exit);
+/* Fini */
