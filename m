Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTIABgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTIABgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:36:09 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:49116 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S261507AbTIABfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:35:45 -0400
To: marcelo@conectiva.com.br
Subject: [PATCH 2.4.23-pre2] User level driver support for input subsystem
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Message-Id: <20030901012940.6E1939ADE3@home.holtmann.net>
Date: Mon,  1 Sep 2003 03:29:40 +0200 (CEST)
From: marcel@holtmann.org (Marcel Holtmann)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this is the backport of the 2.5 user level driver support for the
input subsystem. It would be nice if you can include it into 2.4.23.

Regards

Marcel


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1117, 2003-09-01 03:25:18+02:00, marcel@holtmann.org
  [PATCH] User level driver support for input subsystem
  
  This driver adds support for user level drivers for input
  subsystem accessible under char device /dev/input/uinput.


 CREDITS                      |    1 
 Documentation/Configure.help |    9 
 Documentation/devices.txt    |    1 
 drivers/input/Config.in      |    1 
 drivers/input/Makefile       |    1 
 drivers/input/uinput.c       |  428 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/uinput.h       |   79 +++++++
 7 files changed, 520 insertions(+)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Mon Sep  1 03:26:23 2003
+++ b/CREDITS	Mon Sep  1 03:26:23 2003
@@ -2655,6 +2655,7 @@
 N: Aristeu Sergio Rozanski Filho
 E: aris@conectiva.com.br
 D: Support for EtherExpress 10 ISA (i82595) in eepro driver
+D: User level driver support for input
 S: Conectiva S.A.
 S: R. Tocantins, 89 - Cristo Rei
 S: 80050-430 - Curitiba - Paraná
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Sep  1 03:26:23 2003
+++ b/Documentation/Configure.help	Mon Sep  1 03:26:23 2003
@@ -14684,6 +14684,15 @@
   accessible under char device 13:64+ - /dev/input/eventX in a generic
   way.  This is the future ...
 
+CONFIG_INPUT_UINPUT
+  Say Y here if you want to support user level drivers for input
+  subsystem accessible under char device 10:223 - /dev/input/uinput.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called uinput.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.	    
+
 USB Scanner support
 CONFIG_USB_SCANNER
   Say Y here if you want to connect a USB scanner to your computer's
diff -Nru a/Documentation/devices.txt b/Documentation/devices.txt
--- a/Documentation/devices.txt	Mon Sep  1 03:26:23 2003
+++ b/Documentation/devices.txt	Mon Sep  1 03:26:23 2003
@@ -419,6 +419,7 @@
 		220 = /dev/mptctl	Message passing technology (MPT) control
 		221 = /dev/mvista/hssdsi	Montavista PICMG hot swap system driver
 		222 = /dev/mvista/hasi		Montavista PICMG high availability
+		223 = /dev/input/uinput		User level driver support for input
 		240-255			Reserved for local use
 
  11 char	Raw keyboard device
diff -Nru a/drivers/input/Config.in b/drivers/input/Config.in
--- a/drivers/input/Config.in	Mon Sep  1 03:26:23 2003
+++ b/drivers/input/Config.in	Mon Sep  1 03:26:23 2003
@@ -14,5 +14,6 @@
 fi
 dep_tristate '  Joystick support' CONFIG_INPUT_JOYDEV $CONFIG_INPUT
 dep_tristate '  Event interface support' CONFIG_INPUT_EVDEV $CONFIG_INPUT
+dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INPUT
 
 endmenu
diff -Nru a/drivers/input/Makefile b/drivers/input/Makefile
--- a/drivers/input/Makefile	Mon Sep  1 03:26:23 2003
+++ b/drivers/input/Makefile	Mon Sep  1 03:26:23 2003
@@ -24,6 +24,7 @@
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
 obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
+obj-$(CONFIG_INPUT_UINPUT)	+= uinput.o
 
 # The global Rules.make.
 
diff -Nru a/drivers/input/uinput.c b/drivers/input/uinput.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/uinput.c	Mon Sep  1 03:26:23 2003
@@ -0,0 +1,428 @@
+/*
+ *  User level driver support for input subsystem
+ *
+ * Heavily based on evdev.c by Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
+ * 
+ * Changes/Revisions:
+ *	0.1	20/06/2002
+ *		- first public version
+ */
+
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/smp_lock.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/uinput.h>
+
+static int uinput_dev_open(struct input_dev *dev)
+{
+	return 0;
+}
+
+static void uinput_dev_close(struct input_dev *dev)
+{
+}
+
+static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct uinput_device	*udev;
+
+	udev = (struct uinput_device *)dev->private;
+
+	udev->buff[udev->head].type = type;
+	udev->buff[udev->head].code = code;
+	udev->buff[udev->head].value = value;
+	do_gettimeofday(&udev->buff[udev->head].time);
+	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
+
+	wake_up_interruptible(&udev->waitq);
+
+	return 0;
+}
+
+static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
+{
+	return 0;
+}
+
+static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
+{
+	return 0;
+}					
+
+static int uinput_create_device(struct uinput_device *udev)
+{
+	if (!udev->dev->name) {
+		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
+		return -EINVAL;
+	}
+
+	udev->dev->open = uinput_dev_open;
+	udev->dev->close = uinput_dev_close;
+	udev->dev->event = uinput_dev_event;
+	udev->dev->upload_effect = uinput_dev_upload_effect;
+	udev->dev->erase_effect = uinput_dev_erase_effect;
+	udev->dev->private = udev;
+
+	init_waitqueue_head(&(udev->waitq));
+
+	input_register_device(udev->dev);
+
+	set_bit(UIST_CREATED, &(udev->state));
+
+	return 0;
+}
+
+static int uinput_destroy_device(struct uinput_device *udev)
+{
+	if (!test_bit(UIST_CREATED, &(udev->state))) {
+		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
+		return -EINVAL;
+	}
+
+	input_unregister_device(udev->dev);
+
+	clear_bit(UIST_CREATED, &(udev->state));
+
+	return 0;
+}
+
+static int uinput_open(struct inode *inode, struct file *file)
+{
+	struct uinput_device	*newdev;
+	struct input_dev	*newinput;
+
+	newdev = kmalloc(sizeof(struct uinput_device), GFP_KERNEL);
+	if (!newdev)
+		goto error;
+	memset(newdev, 0, sizeof(struct uinput_device));
+
+	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+	if (!newinput)
+		goto cleanup;
+	memset(newinput, 0, sizeof(struct input_dev));
+
+	newdev->dev = newinput;
+	
+	file->private_data = newdev;
+
+	return 0;
+cleanup:
+	kfree(newdev);
+error:
+	return -ENOMEM;
+}
+
+static int uinput_validate_absbits(struct input_dev *dev)
+{
+	unsigned int cnt;
+	int retval = 0;
+	
+	for (cnt = 0; cnt < ABS_MAX; cnt++) {
+		if (!test_bit(cnt, dev->absbit)) 
+			continue;
+		
+		if (/*!dev->absmin[cnt] || !dev->absmax[cnt] || */
+		    (dev->absmax[cnt] <= dev->absmin[cnt])) {
+			printk(KERN_DEBUG 
+				"%s: invalid abs[%02x] min:%d max:%d\n",
+				UINPUT_NAME, cnt, 
+				dev->absmin[cnt], dev->absmax[cnt]);
+			retval = -EINVAL;
+			break;
+		}
+
+		if ((dev->absflat[cnt] < dev->absmin[cnt]) ||
+		    (dev->absflat[cnt] > dev->absmax[cnt])) {
+			printk(KERN_DEBUG 
+				"%s: absflat[%02x] out of range: %d "
+				"(min:%d/max:%d)\n",
+				UINPUT_NAME, cnt, dev->absflat[cnt],
+				dev->absmin[cnt], dev->absmax[cnt]);
+			retval = -EINVAL;
+			break;
+		}
+	}
+	return retval;
+}
+
+static int uinput_alloc_device(struct file *file, const char *buffer, size_t count)
+{
+	struct uinput_user_dev	*user_dev;
+	struct input_dev	*dev;
+	struct uinput_device	*udev;
+	int			size,
+				retval;
+
+	retval = count;
+
+	udev = (struct uinput_device *)file->private_data;
+	dev = udev->dev;
+
+	user_dev = kmalloc(sizeof(*user_dev), GFP_KERNEL);
+	if (!user_dev) {
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	if (copy_from_user(user_dev, buffer, sizeof(struct uinput_user_dev))) {
+		retval = -EFAULT;
+		goto exit;
+	}
+
+	if (NULL != dev->name) 
+		kfree(dev->name);
+
+	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
+	dev->name = kmalloc(size, GFP_KERNEL);
+	if (!dev->name) {
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	strncpy(dev->name, user_dev->name, size);
+	dev->idbus	= user_dev->idbus;
+	dev->idvendor	= user_dev->idvendor;
+	dev->idproduct	= user_dev->idproduct;
+	dev->idversion	= user_dev->idversion;
+	dev->ff_effects_max = user_dev->ff_effects_max;
+
+	size = sizeof(int) * (ABS_MAX + 1);
+	memcpy(dev->absmax, user_dev->absmax, size);
+	memcpy(dev->absmin, user_dev->absmin, size);
+	memcpy(dev->absfuzz, user_dev->absfuzz, size);
+	memcpy(dev->absflat, user_dev->absflat, size);
+
+	/* check if absmin/absmax/absfuzz/absflat are filled as
+	 * told in Documentation/input/input-programming.txt */
+	if (test_bit(EV_ABS, dev->evbit)) {
+		retval = uinput_validate_absbits(dev);
+		if (retval < 0)
+			kfree(dev->name);
+	}
+
+exit:
+	kfree(user_dev);
+	return retval;
+}
+
+static ssize_t uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+{
+	struct uinput_device	*udev = file->private_data;
+	
+	if (test_bit(UIST_CREATED, &(udev->state))) {
+		struct input_event	ev;
+
+		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
+			return -EFAULT;
+		input_event(udev->dev, ev.type, ev.code, ev.value);
+	}
+	else
+		count = uinput_alloc_device(file, buffer, count);
+
+	return count;
+}
+
+static ssize_t uinput_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
+{
+	struct uinput_device *udev = file->private_data;
+	int retval = 0;
+	
+	if (!test_bit(UIST_CREATED, &(udev->state)))
+		return -ENODEV;
+
+	if ((udev->head == udev->tail) && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval = wait_event_interruptible(udev->waitq,
+			(udev->head != udev->tail) || 
+			!test_bit(UIST_CREATED, &(udev->state)));
+	
+	if (retval)
+		return retval;
+
+	if (!test_bit(UIST_CREATED, &(udev->state)))
+		return -ENODEV;
+
+	while ((udev->head != udev->tail) && 
+	    (retval + sizeof(struct input_event) <= count)) {
+		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
+		    sizeof(struct input_event))) return -EFAULT;
+		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
+		retval += sizeof(struct input_event);
+	}
+
+	return retval;
+}
+
+static unsigned int uinput_poll(struct file *file, poll_table *wait)
+{
+	struct uinput_device *udev = file->private_data;
+
+	poll_wait(file, &udev->waitq, wait);
+
+	if (udev->head != udev->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;			
+}
+
+static int uinput_burn_device(struct uinput_device *udev)
+{
+	if (test_bit(UIST_CREATED, &(udev->state)))
+		uinput_destroy_device(udev);
+
+	kfree(udev->dev);
+	kfree(udev);
+
+	return 0;
+}
+
+static int uinput_close(struct inode *inode, struct file *file)
+{
+	return uinput_burn_device((struct uinput_device *)file->private_data);
+}
+
+static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int			retval = 0;
+	struct uinput_device	*udev;
+
+	udev = (struct uinput_device *)file->private_data;
+
+	/* device attributes can not be changed after the device is created */
+	if (cmd >= UI_SET_EVBIT && test_bit(UIST_CREATED, &(udev->state)))
+		return -EINVAL;
+
+	switch (cmd) {
+		case UI_DEV_CREATE:
+			retval = uinput_create_device(udev);
+			break;
+			
+		case UI_DEV_DESTROY:
+			retval = uinput_destroy_device(udev);
+			break;
+
+		case UI_SET_EVBIT:
+			if (arg > EV_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->evbit);
+			break;
+			
+		case UI_SET_KEYBIT:
+			if (arg > KEY_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->keybit);
+			break;
+			
+		case UI_SET_RELBIT:
+			if (arg > REL_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->relbit);
+			break;
+			
+		case UI_SET_ABSBIT:
+			if (arg > ABS_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->absbit);
+			break;
+			
+		case UI_SET_MSCBIT:
+			if (arg > MSC_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->mscbit);
+			break;
+			
+		case UI_SET_LEDBIT:
+			if (arg > LED_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->ledbit);
+			break;
+			
+		case UI_SET_SNDBIT:
+			if (arg > SND_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->sndbit);
+			break;
+			
+		case UI_SET_FFBIT:
+			if (arg > FF_MAX) {
+				retval = -EINVAL;
+				break;
+			}
+			set_bit(arg, udev->dev->ffbit);
+			break;
+			
+		default:
+			retval = -EFAULT;
+	}
+	return retval;
+}
+
+struct file_operations uinput_fops = {
+	owner:		THIS_MODULE,
+	open:		uinput_open,
+	release:	uinput_close,
+	read:		uinput_read,
+	write:		uinput_write,
+	poll:		uinput_poll,
+	ioctl:		uinput_ioctl,
+};
+
+static struct miscdevice uinput_misc = {
+	fops:		&uinput_fops,
+	minor:		UINPUT_MINOR,
+	name:		UINPUT_NAME,
+};
+
+static int __init uinput_init(void)
+{
+	return misc_register(&uinput_misc);
+}
+
+static void __exit uinput_exit(void)
+{
+	misc_deregister(&uinput_misc);
+}
+
+MODULE_AUTHOR("Aristeu Sergio Rozanski Filho");
+MODULE_DESCRIPTION("User level driver support for input subsystem");
+MODULE_LICENSE("GPL");
+
+module_init(uinput_init);
+module_exit(uinput_exit);
+
diff -Nru a/include/linux/uinput.h b/include/linux/uinput.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/uinput.h	Mon Sep  1 03:26:23 2003
@@ -0,0 +1,79 @@
+/*
+ *  User level driver support for input subsystem
+ *
+ * Heavily based on evdev.c by Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
+ * 
+ * Changes/Revisions:
+ *	0.1	20/06/2002
+ *		- first public version
+ */
+
+#ifndef __UINPUT_H_
+#define __UINPUT_H_
+
+#ifdef __KERNEL__
+#define UINPUT_MINOR		223
+#define UINPUT_NAME		"uinput"
+#define UINPUT_BUFFER_SIZE	16
+
+/* state flags => bit index for {set|clear|test}_bit ops */
+#define UIST_CREATED		0
+
+struct uinput_device {
+	struct input_dev	*dev;
+	unsigned long		state;
+	wait_queue_head_t	waitq;
+	unsigned char		ready,
+				head,
+				tail;
+	struct input_event	buff[UINPUT_BUFFER_SIZE];
+};
+#endif	/* __KERNEL__ */
+
+/* ioctl */
+#define UINPUT_IOCTL_BASE	'U'
+#define UI_DEV_CREATE		_IO(UINPUT_IOCTL_BASE, 1)
+#define UI_DEV_DESTROY		_IO(UINPUT_IOCTL_BASE, 2)
+#define UI_SET_EVBIT		_IOW(UINPUT_IOCTL_BASE, 100, int)
+#define UI_SET_KEYBIT		_IOW(UINPUT_IOCTL_BASE, 101, int)
+#define UI_SET_RELBIT		_IOW(UINPUT_IOCTL_BASE, 102, int)
+#define UI_SET_ABSBIT		_IOW(UINPUT_IOCTL_BASE, 103, int)
+#define UI_SET_MSCBIT		_IOW(UINPUT_IOCTL_BASE, 104, int)
+#define UI_SET_LEDBIT		_IOW(UINPUT_IOCTL_BASE, 105, int)
+#define UI_SET_SNDBIT		_IOW(UINPUT_IOCTL_BASE, 106, int)
+#define UI_SET_FFBIT		_IOW(UINPUT_IOCTL_BASE, 107, int)
+
+#ifndef NBITS
+#define NBITS(x) ((((x)-1)/(sizeof(long)*8))+1)
+#endif	/* NBITS */
+
+#define UINPUT_MAX_NAME_SIZE	80
+struct uinput_user_dev {
+	char name[UINPUT_MAX_NAME_SIZE];
+	unsigned short idbus;
+	unsigned short idvendor;
+	unsigned short idproduct;
+	unsigned short idversion;
+	int ff_effects_max;
+	int absmax[ABS_MAX + 1];
+	int absmin[ABS_MAX + 1];
+	int absfuzz[ABS_MAX + 1];
+	int absflat[ABS_MAX + 1];
+};
+#endif	/* __UINPUT_H_ */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


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
/55K1&KKX/Y8S7T0*2@  
 
