Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVCGKJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVCGKJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVCGKJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:09:11 -0500
Received: from gw.goop.org ([64.81.55.164]:43139 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261731AbVCGKHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:07:50 -0500
Message-ID: <422C27F2.6030601@goop.org>
Date: Mon, 07 Mar 2005 02:07:46 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: [PATCH] Re: Implement compat_ioctl for joydev (updated)
References: <422B7173.3010208@goop.org> <20050306173358.1a70ffdc.akpm@osdl.org>
In-Reply-To: <20050306173358.1a70ffdc.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090804040303030406020006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804040303030406020006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>  
>
>>+	if (!joydev->exist) return -ENODEV;
>>    
>>
>
>eww.
>  
>
How's this?  First patch is a (not particularly thorough) 
indentation/whitespace cleanup, second implements compat_ioctl.

    J

--------------090804040303030406020006
Content-Type: text/x-patch;
 name="indent-joydev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="indent-joydev.patch"

Index: local-2.6/drivers/input/joydev.c
===================================================================
--- local-2.6.orig/drivers/input/joydev.c	2005-03-07 01:48:33.000000000 -0800
+++ local-2.6/drivers/input/joydev.c	2005-03-07 01:53:10.000000000 -0800
@@ -72,20 +72,22 @@
 
 static int joydev_correct(int value, struct js_corr *corr)
 {
-	switch (corr->type) {
-		case JS_CORR_NONE:
-			break;
-		case JS_CORR_BROKEN:
-			value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
-				((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
-				((corr->coef[2] * (value - corr->coef[0])) >> 14);
-			break;
-		default:
-			return 0;
+	switch(corr->type) {
+	case JS_CORR_NONE:
+		break;
+	case JS_CORR_BROKEN:
+		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
+						 ((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
+			((corr->coef[2] * (value - corr->coef[0])) >> 14);
+		break;
+	default:
+		return 0;
 	}
 
-	if (value < -32767) return -32767;
-	if (value >  32767) return  32767;
+	if (value < -32767)
+		return -32767;
+	if (value >  32767)
+		return  32767;
 
 	return value;
 }
@@ -97,24 +99,23 @@
 	struct js_event event;
 
 	switch (type) {
+	case EV_KEY:
+		if (code < BTN_MISC || value == 2) return;
+		event.type = JS_EVENT_BUTTON;
+		event.number = joydev->keymap[code - BTN_MISC];
+		event.value = value;
+		break;
+
+	case EV_ABS:
+		event.type = JS_EVENT_AXIS;
+		event.number = joydev->absmap[code];
+		event.value = joydev_correct(value, joydev->corr + event.number);
+		if (event.value == joydev->abs[event.number]) return;
+		joydev->abs[event.number] = event.value;
+		break;
 
-		case EV_KEY:
-			if (code < BTN_MISC || value == 2) return;
-			event.type = JS_EVENT_BUTTON;
-			event.number = joydev->keymap[code - BTN_MISC];
-			event.value = value;
-			break;
-
-		case EV_ABS:
-			event.type = JS_EVENT_AXIS;
-			event.number = joydev->absmap[code];
-			event.value = joydev_correct(value, joydev->corr + event.number);
-			if (event.value == joydev->abs[event.number]) return;
-			joydev->abs[event.number] = event.value;
-			break;
-
-		default:
-			return;
+	default:
+		return;
 	}
 
 	event.time = MSECS(jiffies);
@@ -294,80 +295,97 @@
 	void __user *argp = (void __user *)arg;
 	int i, j;
 
-	if (!joydev->exist) return -ENODEV;
+	if (!joydev->exist)
+		return -ENODEV;
 
 	switch (cmd) {
+	case JS_SET_CAL:
+		return copy_from_user(&joydev->glue.JS_CORR, argp,
+				      sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+
+	case JS_GET_CAL:
+		return copy_to_user(argp, &joydev->glue.JS_CORR,
+				    sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+
+	case JS_SET_TIMEOUT:
+		return get_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
+
+	case JS_GET_TIMEOUT:
+		return put_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
+
+	case JS_SET_TIMELIMIT:
+		return get_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+
+	case JS_GET_TIMELIMIT:
+		return put_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+
+	case JS_SET_ALL:
+		return copy_from_user(&joydev->glue, argp,
+				      sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
+
+	case JS_GET_ALL:
+		return copy_to_user(argp, &joydev->glue,
+				    sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
+
+
+	case JSIOCGVERSION:
+		return put_user(JS_VERSION, (__u32 __user *) arg);
+
+	case JSIOCGAXES:
+		return put_user(joydev->nabs, (__u8 __user *) arg);
+
+	case JSIOCGBUTTONS:
+		return put_user(joydev->nkey, (__u8 __user *) arg);
 
-		case JS_SET_CAL:
-			return copy_from_user(&joydev->glue.JS_CORR, argp,
-				sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
-		case JS_GET_CAL:
-			return copy_to_user(argp, &joydev->glue.JS_CORR,
-				sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
-		case JS_SET_TIMEOUT:
-			return get_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
-		case JS_GET_TIMEOUT:
-			return put_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
-		case JS_SET_TIMELIMIT:
-			return get_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
-		case JS_GET_TIMELIMIT:
-			return put_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
-		case JS_SET_ALL:
-			return copy_from_user(&joydev->glue, argp,
-						sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
-		case JS_GET_ALL:
-			return copy_to_user(argp, &joydev->glue,
-						sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
-
-		case JSIOCGVERSION:
-			return put_user(JS_VERSION, (__u32 __user *) arg);
-		case JSIOCGAXES:
-			return put_user(joydev->nabs, (__u8 __user *) arg);
-		case JSIOCGBUTTONS:
-			return put_user(joydev->nkey, (__u8 __user *) arg);
-		case JSIOCSCORR:
-			if (copy_from_user(joydev->corr, argp,
-				      sizeof(struct js_corr) * joydev->nabs))
-			    return -EFAULT;
-			for (i = 0; i < joydev->nabs; i++) {
-				j = joydev->abspam[i];
-			        joydev->abs[i] = joydev_correct(dev->abs[j], joydev->corr + i);
-			}
-			return 0;
-		case JSIOCGCORR:
-			return copy_to_user(argp, joydev->corr,
-						sizeof(struct js_corr) * joydev->nabs) ? -EFAULT : 0;
-		case JSIOCSAXMAP:
-			if (copy_from_user(joydev->abspam, argp, sizeof(__u8) * ABS_MAX))
-				return -EFAULT;
-			for (i = 0; i < joydev->nabs; i++) {
-				if (joydev->abspam[i] > ABS_MAX) return -EINVAL;
-				joydev->absmap[joydev->abspam[i]] = i;
-			}
-			return 0;
-		case JSIOCGAXMAP:
-			return copy_to_user(argp, joydev->abspam,
-						sizeof(__u8) * ABS_MAX) ? -EFAULT : 0;
-		case JSIOCSBTNMAP:
-			if (copy_from_user(joydev->keypam, argp, sizeof(__u16) * (KEY_MAX - BTN_MISC)))
-				return -EFAULT;
-			for (i = 0; i < joydev->nkey; i++) {
-				if (joydev->keypam[i] > KEY_MAX || joydev->keypam[i] < BTN_MISC) return -EINVAL;
-				joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
-			}
-			return 0;
-		case JSIOCGBTNMAP:
-			return copy_to_user(argp, joydev->keypam,
-						sizeof(__u16) * (KEY_MAX - BTN_MISC)) ? -EFAULT : 0;
-		default:
-			if ((cmd & ~(_IOC_SIZEMASK << _IOC_SIZESHIFT)) == JSIOCGNAME(0)) {
-				int len;
-				if (!dev->name) return 0;
-				len = strlen(dev->name) + 1;
-				if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-				if (copy_to_user(argp, dev->name, len)) return -EFAULT;
-				return len;
-			}
+	case JSIOCSCORR:
+		if (copy_from_user(joydev->corr, argp,
+				   sizeof(struct js_corr) * joydev->nabs))
+			return -EFAULT;
+		for (i = 0; i < joydev->nabs; i++) {
+			j = joydev->abspam[i];
+			joydev->abs[i] = joydev_correct(dev->abs[j], joydev->corr + i);
+		}
+		return 0;
+
+	case JSIOCGCORR:
+		return copy_to_user(argp, joydev->corr,
+				    sizeof(struct js_corr) * joydev->nabs) ? -EFAULT : 0;
+
+	case JSIOCSAXMAP:
+		if (copy_from_user(joydev->abspam, argp, sizeof(__u8) * ABS_MAX))
+			return -EFAULT;
+		for (i = 0; i < joydev->nabs; i++) {
+			if (joydev->abspam[i] > ABS_MAX) return -EINVAL;
+			joydev->absmap[joydev->abspam[i]] = i;
+		}
+		return 0;
+
+	case JSIOCGAXMAP:
+		return copy_to_user(argp, joydev->abspam,
+				    sizeof(__u8) * ABS_MAX) ? -EFAULT : 0;
+
+	case JSIOCSBTNMAP:
+		if (copy_from_user(joydev->keypam, argp, sizeof(__u16) * (KEY_MAX - BTN_MISC)))
+			return -EFAULT;
+		for (i = 0; i < joydev->nkey; i++) {
+			if (joydev->keypam[i] > KEY_MAX || joydev->keypam[i] < BTN_MISC) return -EINVAL;
+			joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
+		}
+		return 0;
+
+	case JSIOCGBTNMAP:
+		return copy_to_user(argp, joydev->keypam,
+				    sizeof(__u16) * (KEY_MAX - BTN_MISC)) ? -EFAULT : 0;
+
+	default:
+		if ((cmd & ~(_IOC_SIZEMASK << _IOC_SIZESHIFT)) == JSIOCGNAME(0)) {
+			int len;
+			if (!dev->name) return 0;
+			len = strlen(dev->name) + 1;
+			if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
+			if (copy_to_user(argp, dev->name, len)) return -EFAULT;
+			return len;
+		}
 	}
 	return -EINVAL;
 }
@@ -383,12 +401,15 @@
 	.fasync =	joydev_fasync,
 };
 
-static struct input_handle *joydev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
+static struct input_handle *joydev_connect(struct input_handler *handler, 
+					   struct input_dev *dev, struct input_device_id *id)
 {
 	struct joydev *joydev;
 	int i, j, t, minor;
 
-	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
+	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++)
+		;
+
 	if (minor == JOYDEV_MINORS) {
 		printk(KERN_ERR "joydev: no more free joydev devices\n");
 		return NULL;

--------------090804040303030406020006
Content-Type: text/x-patch;
 name="joydev-ioctl32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="joydev-ioctl32.patch"

This patch implements compat_ioctl for joydev.  I've tested it with a
Logitech WingMan Rumblepad on an x86-64 machine, and on an ia32
machine to make sure I didn't break anything.

Patch against stock 2.6.11, but also tested with 2.6.11-mm1.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

Index: local-2.6/include/linux/joystick.h
===================================================================
--- local-2.6.orig/include/linux/joystick.h	2005-03-07 01:46:38.000000000 -0800
+++ local-2.6/include/linux/joystick.h	2005-03-07 01:54:25.000000000 -0800
@@ -111,18 +111,35 @@
 #define JS_SET_ALL		8
 
 struct JS_DATA_TYPE {
-	int buttons;
-	int x;
-	int y;
+	__s32 buttons;
+	__s32 x;
+	__s32 y;
 };
 
-struct JS_DATA_SAVE_TYPE {
-	int JS_TIMEOUT;
-	int BUSY;
-	long JS_EXPIRETIME;
-	long JS_TIMELIMIT;
+struct JS_DATA_SAVE_TYPE_32 {
+	__s32 JS_TIMEOUT;
+	__s32 BUSY;
+	__s32 JS_EXPIRETIME;
+	__s32 JS_TIMELIMIT;
 	struct JS_DATA_TYPE JS_SAVE;
 	struct JS_DATA_TYPE JS_CORR;
 };
 
+struct JS_DATA_SAVE_TYPE_64 {
+	__s32 JS_TIMEOUT;
+	__s32 BUSY;
+	__s64 JS_EXPIRETIME;
+	__s64 JS_TIMELIMIT;
+	struct JS_DATA_TYPE JS_SAVE;
+	struct JS_DATA_TYPE JS_CORR;
+};
+
+#if BITS_PER_LONG == 64
+#define JS_DATA_SAVE_TYPE JS_DATA_SAVE_TYPE_64
+#elif BITS_PER_LONG == 32
+#define JS_DATA_SAVE_TYPE JS_DATA_SAVE_TYPE_32
+#else
+#error Unexpected BITS_PER_LONG
+#endif
+
 #endif /* _LINUX_JOYSTICK_H */
Index: local-2.6/drivers/input/joydev.c
===================================================================
--- local-2.6.orig/drivers/input/joydev.c	2005-03-07 01:53:10.000000000 -0800
+++ local-2.6/drivers/input/joydev.c	2005-03-07 01:59:35.000000000 -0800
@@ -287,59 +287,39 @@
 	return 0;
 }
 
-static int joydev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int joydev_ioctl_common(struct joydev *joydev, unsigned int cmd, void __user *argp)
 {
-	struct joydev_list *list = file->private_data;
-	struct joydev *joydev = list->joydev;
 	struct input_dev *dev = joydev->handle.dev;
-	void __user *argp = (void __user *)arg;
 	int i, j;
 
-	if (!joydev->exist)
-		return -ENODEV;
-
 	switch (cmd) {
 	case JS_SET_CAL:
 		return copy_from_user(&joydev->glue.JS_CORR, argp,
-				      sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+				      sizeof(joydev->glue.JS_CORR)) ? -EFAULT : 0;
 
 	case JS_GET_CAL:
 		return copy_to_user(argp, &joydev->glue.JS_CORR,
-				    sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+				    sizeof(joydev->glue.JS_CORR)) ? -EFAULT : 0;
 
 	case JS_SET_TIMEOUT:
-		return get_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
+		return get_user(joydev->glue.JS_TIMEOUT, (s32 __user *) argp);
 
 	case JS_GET_TIMEOUT:
-		return put_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
-
-	case JS_SET_TIMELIMIT:
-		return get_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
-
-	case JS_GET_TIMELIMIT:
-		return put_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
-
-	case JS_SET_ALL:
-		return copy_from_user(&joydev->glue, argp,
-				      sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
-
-	case JS_GET_ALL:
-		return copy_to_user(argp, &joydev->glue,
-				    sizeof(struct JS_DATA_SAVE_TYPE)) ? -EFAULT : 0;
+		return put_user(joydev->glue.JS_TIMEOUT, (s32 __user *) argp);
 
 
 	case JSIOCGVERSION:
-		return put_user(JS_VERSION, (__u32 __user *) arg);
+		return put_user(JS_VERSION, (__u32 __user *) argp);
 
 	case JSIOCGAXES:
-		return put_user(joydev->nabs, (__u8 __user *) arg);
+		return put_user(joydev->nabs, (__u8 __user *) argp);
 
 	case JSIOCGBUTTONS:
-		return put_user(joydev->nkey, (__u8 __user *) arg);
+		return put_user(joydev->nkey, (__u8 __user *) argp);
 
 	case JSIOCSCORR:
 		if (copy_from_user(joydev->corr, argp,
-				   sizeof(struct js_corr) * joydev->nabs))
+				   sizeof(joydev->corr[0]) * joydev->nabs))
 			return -EFAULT;
 		for (i = 0; i < joydev->nabs; i++) {
 			j = joydev->abspam[i];
@@ -390,6 +370,92 @@
 	return -EINVAL;
 }
 
+#ifdef CONFIG_COMPAT
+static long joydev_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	struct joydev_list *list = file->private_data;
+	struct joydev *joydev = list->joydev;
+	void __user *argp = (void __user *)arg;
+	s32 tmp32;
+	struct JS_DATA_SAVE_TYPE_32 ds32;
+	int err;
+
+	if (!joydev->exist)
+		return -ENODEV;
+
+	switch(cmd) {
+	case JS_SET_TIMELIMIT:
+		err = get_user(tmp32, (s32 __user *) arg);
+		if (err == 0)
+			joydev->glue.JS_TIMELIMIT = tmp32;
+		break;
+
+	case JS_GET_TIMELIMIT:
+		tmp32 = joydev->glue.JS_TIMELIMIT;
+		err = put_user(tmp32, (s32 __user *) arg);
+		break;
+
+	case JS_SET_ALL:
+		err = copy_from_user(&ds32, argp,
+				     sizeof(ds32)) ? -EFAULT : 0;
+		if (err == 0) {
+			joydev->glue.JS_TIMEOUT    = ds32.JS_TIMEOUT;
+			joydev->glue.BUSY          = ds32.BUSY;
+			joydev->glue.JS_EXPIRETIME = ds32.JS_EXPIRETIME;
+			joydev->glue.JS_TIMELIMIT  = ds32.JS_TIMELIMIT;
+			joydev->glue.JS_SAVE       = ds32.JS_SAVE;
+			joydev->glue.JS_CORR       = ds32.JS_CORR;
+		}
+		break;
+
+	case JS_GET_ALL:
+		ds32.JS_TIMEOUT    = joydev->glue.JS_TIMEOUT;
+		ds32.BUSY          = joydev->glue.BUSY;
+		ds32.JS_EXPIRETIME = joydev->glue.JS_EXPIRETIME;
+		ds32.JS_TIMELIMIT  = joydev->glue.JS_TIMELIMIT;
+		ds32.JS_SAVE       = joydev->glue.JS_SAVE;
+		ds32.JS_CORR       = joydev->glue.JS_CORR;
+
+		err = copy_to_user(argp, &ds32,
+					  sizeof(ds32)) ? -EFAULT : 0;
+		break;
+
+	default:
+		err = joydev_ioctl_common(joydev, cmd, argp);
+	}
+	return err;
+}
+#endif /* CONFIG_COMPAT */
+
+static int joydev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct joydev_list *list = file->private_data;
+	struct joydev *joydev = list->joydev;
+	void __user *argp = (void __user *)arg;
+
+	if (!joydev->exist)
+		return -ENODEV;
+
+	switch(cmd) {
+	case JS_SET_TIMELIMIT:
+		return get_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+
+	case JS_GET_TIMELIMIT:
+		return put_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+
+	case JS_SET_ALL:
+		return copy_from_user(&joydev->glue, argp,
+				      sizeof(joydev->glue)) ? -EFAULT : 0;
+
+	case JS_GET_ALL:
+		return copy_to_user(argp, &joydev->glue,
+				    sizeof(joydev->glue)) ? -EFAULT : 0;
+
+	default:
+		return joydev_ioctl_common(joydev, cmd, argp);
+	}
+}
+
 static struct file_operations joydev_fops = {
 	.owner =	THIS_MODULE,
 	.read =		joydev_read,
@@ -398,6 +464,9 @@
 	.open =		joydev_open,
 	.release =	joydev_release,
 	.ioctl =	joydev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	joydev_compat_ioctl,
+#endif
 	.fasync =	joydev_fasync,
 };
 

--------------090804040303030406020006--
