Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJKKki>; Fri, 11 Oct 2002 06:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSJKKkh>; Fri, 11 Oct 2002 06:40:37 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9092 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262392AbSJKKkK>;
	Fri, 11 Oct 2002 06:40:10 -0400
Date: Fri, 11 Oct 2002 12:45:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fixes in uinput.c [4/5]
Message-ID: <20021011124550.C1763@ucw.cz>
References: <20021011124406.A1677@ucw.cz> <20021011124452.A1763@ucw.cz> <20021011124526.B1763@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021011124526.B1763@ucw.cz>; from vojtech@suse.cz on Fri, Oct 11, 2002 at 12:45:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.741, 2002-10-11 11:50:35+02:00, zw@superlucidity.net
  Several fixes in the uinput.c userspace input driver. Size of fifo,
  handling of flag bits, etc.


 drivers/input/misc/uinput.c |  132 +++++++++++++++++++++++++++-----------------
 include/linux/uinput.h      |    4 -
 2 files changed, 83 insertions(+), 53 deletions(-)

===================================================================

diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Fri Oct 11 12:43:13 2002
+++ b/drivers/input/misc/uinput.c	Fri Oct 11 12:43:13 2002
@@ -49,7 +49,7 @@
 
 	udev = (struct uinput_device *)dev->private;
 
-	udev->head = (udev->head + 1) & 0xF;
+	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
@@ -87,14 +87,14 @@
 
 	input_register_device(udev->dev);
 
-	udev->state |= UIST_CREATED;
+	set_bit(UIST_CREATED, &(udev->state));
 
 	return 0;
 }
 
 static int uinput_destroy_device(struct uinput_device *udev)
 {
-	if (!(udev->state & UIST_CREATED)) {
+	if (!test_bit(UIST_CREATED, &(udev->state))) {
 		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
 		return -EINVAL;
 	}
@@ -135,6 +135,39 @@
 	return -ENOMEM;
 }
 
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
 static int uinput_alloc_device(struct file *file, const char *buffer, size_t count)
 {
 	struct uinput_user_dev	user_dev;
@@ -145,14 +178,17 @@
 
 	retval = count;
 
+	udev = (struct uinput_device *)file->private_data;
+	dev = udev->dev;
+
 	if (copy_from_user(&user_dev, buffer, sizeof(struct uinput_user_dev))) {
 		retval = -EFAULT;
 		goto exit;
 	}
 
-	udev = (struct uinput_device *)file->private_data;
-	dev = udev->dev;
-
+	if (NULL != dev->name) 
+		kfree(dev->name);
+		
 	size = strnlen(user_dev.name, UINPUT_MAX_NAME_SIZE);
 	dev->name = kmalloc(size + 1, GFP_KERNEL);
 	if (!dev->name) {
@@ -168,7 +204,7 @@
 	dev->id.version	= user_dev.id.version;
 	dev->ff_effects_max = user_dev.ff_effects_max;
 
-	size = sizeof(unsigned long) * NBITS(ABS_MAX + 1);
+	size = sizeof(int) * (ABS_MAX + 1);
 	memcpy(dev->absmax, user_dev.absmax, size);
 	memcpy(dev->absmin, user_dev.absmin, size);
 	memcpy(dev->absfuzz, user_dev.absfuzz, size);
@@ -177,33 +213,20 @@
 	/* check if absmin/absmax/absfuzz/absflat are filled as
 	 * told in Documentation/input/input-programming.txt */
 	if (test_bit(EV_ABS, dev->evbit)) {
-		unsigned int cnt;
-		for (cnt = 1; cnt < ABS_MAX; cnt++)
-			if (test_bit(cnt, dev->absbit) &&
-					(!dev->absmin[cnt] ||
-					 !dev->absmax[cnt] ||
-					 !dev->absfuzz[cnt] ||
-					 !dev->absflat[cnt])) {
-				printk(KERN_DEBUG "%s: set abs fields "
-					"first\n", UINPUT_NAME);
-				retval = -EINVAL;
-				goto free_name;
-			}
+		retval = uinput_validate_absbits(dev);
+		if (retval < 0)
+			kfree(dev->name);
 	}
 
 exit:
 	return retval;
-free_name:
-	kfree(dev->name);
-	goto exit;
 }
 
 static int uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device	*udev = file->private_data;
 	
-
-	if (udev->state & UIST_CREATED) {
+	if (test_bit(UIST_CREATED, &(udev->state))) {
 		struct input_event	ev;
 
 		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
@@ -220,23 +243,28 @@
 {
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
+	
+	if (!test_bit(UIST_CREATED, &(udev->state)))
+		return -ENODEV;
 
-	if (udev->head == udev->tail && (udev->state & UIST_CREATED) && (file->f_flags & O_NONBLOCK))
+	if ((udev->head == udev->tail) && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(udev->waitq,
-		udev->head != udev->tail && (udev->state & UIST_CREATED));
-
+			(udev->head != udev->tail) || 
+			!test_bit(UIST_CREATED, &(udev->state)));
+	
 	if (retval)
 		return retval;
 
-	if (!(udev->state & UIST_CREATED))
+	if (!test_bit(UIST_CREATED, &(udev->state)))
 		return -ENODEV;
 
-	while (udev->head != udev->tail && retval + sizeof(struct uinput_device) <= count) {
+	while ((udev->head != udev->tail) && 
+	    (retval + sizeof(struct uinput_device) <= count)) {
 		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
 		    sizeof(struct input_event))) return -EFAULT;
-		udev->tail = (udev->tail + 1) % (UINPUT_BUFFER_SIZE - 1);
+		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
 		retval += sizeof(struct input_event);
 	}
 
@@ -245,7 +273,7 @@
 
 static unsigned int uinput_poll(struct file *file, poll_table *wait)
 {
-        struct uinput_device *udev = file->private_data;
+	struct uinput_device *udev = file->private_data;
 
 	poll_wait(file, &udev->waitq, wait);
 
@@ -257,7 +285,7 @@
 
 static int uinput_burn_device(struct uinput_device *udev)
 {
-	if (udev->state & UIST_CREATED)
+	if (test_bit(UIST_CREATED, &(udev->state)))
 		uinput_destroy_device(udev);
 
 	kfree(udev->dev);
@@ -282,50 +310,52 @@
 
 	udev = (struct uinput_device *)file->private_data;
 
-	if (cmd >= UI_SET_EVBIT && (udev->state & UIST_CREATED))
+	/* device attributes can not be changed after the device is created */
+	if (cmd >= UI_SET_EVBIT && test_bit(UIST_CREATED, &(udev->state)))
 		return -EINVAL;
 
 	switch (cmd) {
 		case UI_DEV_CREATE:
 			retval = uinput_create_device(udev);
-
 			break;
+			
 		case UI_DEV_DESTROY:
 			retval = uinput_destroy_device(udev);
-
 			break;
+
+
 		case UI_SET_EVBIT:
 			set_bit(arg, udev->dev->evbit);
-
-		break;
+			break;
+			
 		case UI_SET_KEYBIT:
 			set_bit(arg, udev->dev->keybit);
-
-		break;
+			break;
+			
 		case UI_SET_RELBIT:
 			set_bit(arg, udev->dev->relbit);
-
-		break;
+			break;
+			
 		case UI_SET_ABSBIT:
 			set_bit(arg, udev->dev->absbit);
-
-		break;
+			break;
+			
 		case UI_SET_MSCBIT:
 			set_bit(arg, udev->dev->mscbit);
-
-		break;
+			break;
+			
 		case UI_SET_LEDBIT:
 			set_bit(arg, udev->dev->ledbit);
-
-		break;
+			break;
+			
 		case UI_SET_SNDBIT:
 			set_bit(arg, udev->dev->sndbit);
-
-		break;
+			break;
+			
 		case UI_SET_FFBIT:
 			set_bit(arg, udev->dev->ffbit);
-
-		break;
+			break;
+			
 		default:
 			retval = -EFAULT;
 	}
diff -Nru a/include/linux/uinput.h b/include/linux/uinput.h
--- a/include/linux/uinput.h	Fri Oct 11 12:43:13 2002
+++ b/include/linux/uinput.h	Fri Oct 11 12:43:13 2002
@@ -29,9 +29,9 @@
 #define UINPUT_MINOR		223
 #define UINPUT_NAME		"uinput"
 #define UINPUT_BUFFER_SIZE	16
-#define U_MAX_NAME_SIZE		50
 
-#define UIST_CREATED		1
+/* state flags => bit index for {set|clear|test}_bit ops */
+#define UIST_CREATED		0
 
 struct uinput_device {
 	struct input_dev	*dev;

===================================================================

This BitKeeper patch contains the following changesets:
1.741
## Wrapped with gzip_uu ##


begin 664 bkpatch1720
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
?/U<,@RS^21",>'"932=-.R2AC[%G_@VLXD3-?Q``````
`
end
