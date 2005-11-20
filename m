Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKTGt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKTGt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKTGsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:48:55 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:46008 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750757AbVKTGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:13 -0500
Message-Id: <20051120064420.277354000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 08/14] Uinput: convert to dynalloc allocation
Content-Disposition: inline; filename=input-dynalloc-uinput.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: uinput - convert to dynalloc allocation

Also introduce proper locking when creating/deleting device.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |  308 +++++++++++++++++++++++---------------------
 include/linux/uinput.h      |   12 -
 2 files changed, 168 insertions(+), 152 deletions(-)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -152,67 +152,62 @@ static int uinput_dev_erase_effect(struc
 	return retval;
 }
 
-static int uinput_create_device(struct uinput_device *udev)
+static void uinput_destroy_device(struct uinput_device *udev)
 {
-	if (!udev->dev->name) {
-		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
-		return -EINVAL;
-	}
+	const char *name, *phys;
 
-	udev->dev->event = uinput_dev_event;
-	udev->dev->upload_effect = uinput_dev_upload_effect;
-	udev->dev->erase_effect = uinput_dev_erase_effect;
-	udev->dev->private = udev;
-
-	init_waitqueue_head(&udev->waitq);
-
-	input_register_device(udev->dev);
-
-	set_bit(UIST_CREATED, &udev->state);
+	if (udev->dev) {
+		name = udev->dev->name;
+		phys = udev->dev->phys;
+		if (udev->state == UIST_CREATED)
+			input_unregister_device(udev->dev);
+		else
+			input_free_device(udev->dev);
+		kfree(name);
+		kfree(phys);
+		udev->dev = NULL;
+	}
 
-	return 0;
+	udev->state = UIST_NEW_DEVICE;
 }
 
-static int uinput_destroy_device(struct uinput_device *udev)
+static int uinput_create_device(struct uinput_device *udev)
 {
-	if (!test_bit(UIST_CREATED, &udev->state)) {
-		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
+	int error;
+
+	if (udev->state != UIST_SETUP_COMPLETE) {
+		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
 		return -EINVAL;
 	}
 
-	input_unregister_device(udev->dev);
+	error = input_register_device(udev->dev);
+	if (error) {
+		uinput_destroy_device(udev);
+		return error;
+	}
 
-	clear_bit(UIST_CREATED, &udev->state);
+	udev->state = UIST_CREATED;
 
 	return 0;
 }
 
 static int uinput_open(struct inode *inode, struct file *file)
 {
-	struct uinput_device	*newdev;
-	struct input_dev	*newinput;
+	struct uinput_device *newdev;
 
-	newdev = kmalloc(sizeof(struct uinput_device), GFP_KERNEL);
+	newdev = kzalloc(sizeof(struct uinput_device), GFP_KERNEL);
 	if (!newdev)
-		goto error;
-	memset(newdev, 0, sizeof(struct uinput_device));
+		return -ENOMEM;
+
+	init_MUTEX(&newdev->sem);
 	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
-
-	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
-	if (!newinput)
-		goto cleanup;
-	memset(newinput, 0, sizeof(struct input_dev));
-
-	newdev->dev = newinput;
+	init_waitqueue_head(&newdev->waitq);
+	newdev->state = UIST_NEW_DEVICE;
 
 	file->private_data = newdev;
 
 	return 0;
-cleanup:
-	kfree(newdev);
-error:
-	return -ENOMEM;
 }
 
 static int uinput_validate_absbits(struct input_dev *dev)
@@ -246,34 +241,55 @@ static int uinput_validate_absbits(struc
 	return retval;
 }
 
-static int uinput_alloc_device(struct file *file, const char __user *buffer, size_t count)
+static int uinput_allocate_device(struct uinput_device *udev)
+{
+	udev->dev = input_allocate_device();
+	if (!udev->dev)
+		return -ENOMEM;
+
+	udev->dev->event = uinput_dev_event;
+	udev->dev->upload_effect = uinput_dev_upload_effect;
+	udev->dev->erase_effect = uinput_dev_erase_effect;
+	udev->dev->private = udev;
+
+	return 0;
+}
+
+static int uinput_setup_device(struct uinput_device *udev, const char __user *buffer, size_t count)
 {
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
-	struct uinput_device	*udev;
 	char			*name;
 	int			size;
 	int			retval;
 
-	retval = count;
+	if (count != sizeof(struct uinput_user_dev))
+		return -EINVAL;
+
+	if (!udev->dev) {
+		retval = uinput_allocate_device(udev);
+		if (retval)
+			return retval;
+	}
 
-	udev = file->private_data;
 	dev = udev->dev;
 
 	user_dev = kmalloc(sizeof(struct uinput_user_dev), GFP_KERNEL);
-	if (!user_dev) {
-		retval = -ENOMEM;
-		goto exit;
-	}
+	if (!user_dev)
+		return -ENOMEM;
 
 	if (copy_from_user(user_dev, buffer, sizeof(struct uinput_user_dev))) {
 		retval = -EFAULT;
 		goto exit;
 	}
 
-	kfree(dev->name);
-
 	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
+	if (!size) {
+		retval = -EINVAL;
+		goto exit;
+	}
+
+	kfree(dev->name);
 	dev->name = name = kmalloc(size, GFP_KERNEL);
 	if (!name) {
 		retval = -ENOMEM;
@@ -296,32 +312,50 @@ static int uinput_alloc_device(struct fi
 	/* check if absmin/absmax/absfuzz/absflat are filled as
 	 * told in Documentation/input/input-programming.txt */
 	if (test_bit(EV_ABS, dev->evbit)) {
-		int err = uinput_validate_absbits(dev);
-		if (err < 0) {
-			retval = err;
-			kfree(dev->name);
-		}
+		retval = uinput_validate_absbits(dev);
+		if (retval < 0)
+			goto exit;
 	}
 
-exit:
+	udev->state = UIST_SETUP_COMPLETE;
+	retval = count;
+
+ exit:
 	kfree(user_dev);
 	return retval;
 }
 
+static inline ssize_t uinput_inject_event(struct uinput_device *udev, const char __user *buffer, size_t count)
+{
+	struct input_event ev;
+
+	if (count != sizeof(struct input_event))
+		return -EINVAL;
+
+	if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
+		return -EFAULT;
+
+	input_event(udev->dev, ev.type, ev.code, ev.value);
+
+	return sizeof(struct input_event);
+}
+
 static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
+	int retval;
 
-	if (test_bit(UIST_CREATED, &udev->state)) {
-		struct input_event	ev;
+	retval = down_interruptible(&udev->sem);
+	if (retval)
+		return retval;
 
-		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
-			return -EFAULT;
-		input_event(udev->dev, ev.type, ev.code, ev.value);
-	} else
-		count = uinput_alloc_device(file, buffer, count);
+	retval = udev->state == UIST_CREATED ?
+			uinput_inject_event(udev, buffer, count) :
+			uinput_setup_device(udev, buffer, count);
 
-	return count;
+	up(&udev->sem);
+
+	return retval;
 }
 
 static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
@@ -329,28 +363,38 @@ static ssize_t uinput_read(struct file *
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
 
-	if (!test_bit(UIST_CREATED, &udev->state))
+	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 
 	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(udev->waitq,
-			udev->head != udev->tail || !test_bit(UIST_CREATED, &udev->state));
+			udev->head != udev->tail || udev->state != UIST_CREATED);
 	if (retval)
 		return retval;
 
-	if (!test_bit(UIST_CREATED, &udev->state))
-		return -ENODEV;
+	retval = down_interruptible(&udev->sem);
+	if (retval)
+		return retval;
 
-	while ((udev->head != udev->tail) &&
-	    (retval + sizeof(struct input_event) <= count)) {
-		if (copy_to_user(buffer + retval, &udev->buff[udev->tail], sizeof(struct input_event)))
-			return -EFAULT;
+	if (udev->state != UIST_CREATED) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	while (udev->head != udev->tail && retval + sizeof(struct input_event) <= count) {
+		if (copy_to_user(buffer + retval, &udev->buff[udev->tail], sizeof(struct input_event))) {
+			retval = -EFAULT;
+			goto out;
+		}
 		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
 		retval += sizeof(struct input_event);
 	}
 
+ out:
+	up(&udev->sem);
+
 	return retval;
 }
 
@@ -366,28 +410,30 @@ static unsigned int uinput_poll(struct f
 	return 0;
 }
 
-static int uinput_burn_device(struct uinput_device *udev)
+static int uinput_release(struct inode *inode, struct file *file)
 {
-	if (test_bit(UIST_CREATED, &udev->state))
-		uinput_destroy_device(udev);
+	struct uinput_device *udev = file->private_data;
 
-	kfree(udev->dev->name);
-	kfree(udev->dev->phys);
-	kfree(udev->dev);
+	uinput_destroy_device(udev);
 	kfree(udev);
 
 	return 0;
 }
 
-static int uinput_close(struct inode *inode, struct file *file)
-{
-	uinput_burn_device(file->private_data);
-	return 0;
-}
+#define uinput_set_bit(_arg, _bit, _max)		\
+({							\
+	int __ret = 0;					\
+	if (udev->state == UIST_CREATED)		\
+		__ret =  -EINVAL;			\
+	else if ((_arg) > (_max))			\
+		__ret = -EINVAL;			\
+	else set_bit((_arg), udev->dev->_bit);		\
+	__ret;						\
+})
 
-static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int			retval = 0;
+	int			retval;
 	struct uinput_device	*udev;
 	void __user             *p = (void __user *)arg;
 	struct uinput_ff_upload ff_up;
@@ -398,19 +444,14 @@ static int uinput_ioctl(struct inode *in
 
 	udev = file->private_data;
 
-	/* device attributes can not be changed after the device is created */
-	switch (cmd) {
-		case UI_SET_EVBIT:
-		case UI_SET_KEYBIT:
-		case UI_SET_RELBIT:
-		case UI_SET_ABSBIT:
-		case UI_SET_MSCBIT:
-		case UI_SET_LEDBIT:
-		case UI_SET_SNDBIT:
-		case UI_SET_FFBIT:
-		case UI_SET_PHYS:
-			if (test_bit(UIST_CREATED, &udev->state))
-				return -EINVAL;
+	retval = down_interruptible(&udev->sem);
+	if (retval)
+		return retval;
+
+	if (!udev->dev) {
+		retval = uinput_allocate_device(udev);
+		if (retval)
+			goto out;
 	}
 
 	switch (cmd) {
@@ -419,74 +460,46 @@ static int uinput_ioctl(struct inode *in
 			break;
 
 		case UI_DEV_DESTROY:
-			retval = uinput_destroy_device(udev);
+			uinput_destroy_device(udev);
 			break;
 
 		case UI_SET_EVBIT:
-			if (arg > EV_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->evbit);
+			retval = uinput_set_bit(arg, evbit, EV_MAX);
 			break;
 
 		case UI_SET_KEYBIT:
-			if (arg > KEY_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->keybit);
+			retval = uinput_set_bit(arg, keybit, KEY_MAX);
 			break;
 
 		case UI_SET_RELBIT:
-			if (arg > REL_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->relbit);
+			retval = uinput_set_bit(arg, relbit, REL_MAX);
 			break;
 
 		case UI_SET_ABSBIT:
-			if (arg > ABS_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->absbit);
+			retval = uinput_set_bit(arg, absbit, ABS_MAX);
 			break;
 
 		case UI_SET_MSCBIT:
-			if (arg > MSC_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->mscbit);
+			retval = uinput_set_bit(arg, mscbit, MSC_MAX);
 			break;
 
 		case UI_SET_LEDBIT:
-			if (arg > LED_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->ledbit);
+			retval = uinput_set_bit(arg, ledbit, LED_MAX);
 			break;
 
 		case UI_SET_SNDBIT:
-			if (arg > SND_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->sndbit);
+			retval = uinput_set_bit(arg, sndbit, SND_MAX);
 			break;
 
 		case UI_SET_FFBIT:
-			if (arg > FF_MAX) {
-				retval = -EINVAL;
-				break;
-			}
-			set_bit(arg, udev->dev->ffbit);
+			retval = uinput_set_bit(arg, ffbit, FF_MAX);
 			break;
 
 		case UI_SET_PHYS:
+			if (udev->state == UIST_CREATED) {
+				retval = -EINVAL;
+				goto out;
+			}
 			length = strnlen_user(p, 1024);
 			if (length <= 0) {
 				retval = -EFAULT;
@@ -575,23 +588,26 @@ static int uinput_ioctl(struct inode *in
 		default:
 			retval = -EINVAL;
 	}
+
+ out:
+	up(&udev->sem);
 	return retval;
 }
 
 static struct file_operations uinput_fops = {
-	.owner =	THIS_MODULE,
-	.open =		uinput_open,
-	.release =	uinput_close,
-	.read =		uinput_read,
-	.write =	uinput_write,
-	.poll =		uinput_poll,
-	.ioctl =	uinput_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= uinput_open,
+	.release	= uinput_release,
+	.read		= uinput_read,
+	.write		= uinput_write,
+	.poll		= uinput_poll,
+	.unlocked_ioctl	= uinput_ioctl,
 };
 
 static struct miscdevice uinput_misc = {
-	.fops =		&uinput_fops,
-	.minor =	UINPUT_MINOR,
-	.name =		UINPUT_NAME,
+	.fops		= &uinput_fops,
+	.minor		= UINPUT_MINOR,
+	.name		= UINPUT_NAME,
 };
 
 static int __init uinput_init(void)
Index: work/include/linux/uinput.h
===================================================================
--- work.orig/include/linux/uinput.h
+++ work/include/linux/uinput.h
@@ -34,8 +34,7 @@
 #define UINPUT_BUFFER_SIZE	16
 #define UINPUT_NUM_REQUESTS	16
 
-/* state flags => bit index for {set|clear|test}_bit ops */
-#define UIST_CREATED		0
+enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
 
 struct uinput_request {
 	int			id;
@@ -52,11 +51,12 @@ struct uinput_request {
 
 struct uinput_device {
 	struct input_dev	*dev;
-	unsigned long		state;
+	struct semaphore	sem;
+	enum uinput_state	state;
 	wait_queue_head_t	waitq;
-	unsigned char		ready,
-				head,
-				tail;
+	unsigned char		ready;
+	unsigned char		head;
+	unsigned char		tail;
 	struct input_event	buff[UINPUT_BUFFER_SIZE];
 
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];

