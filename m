Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVCFVJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVCFVJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVCFVJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:09:36 -0500
Received: from gw.goop.org ([64.81.55.164]:30382 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261504AbVCFVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:09:13 -0500
Message-ID: <422B7173.3010208@goop.org>
Date: Sun, 06 Mar 2005 13:09:07 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Implement compat_ioctl for joydev
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements compat_ioctl for joydev.  I've tested it with a
Logitech WingMan Rumblepad on an x86-64 machine, and on an ia32
machine to make sure I didn't break anything.

Patch against stock 2.6.11, but also tested with 2.6.11-mm1.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

Index: local-2.6/include/linux/joystick.h
===================================================================
--- local-2.6.orig/include/linux/joystick.h	2005-03-05 13:40:49.000000000 -0800
+++ local-2.6/include/linux/joystick.h	2005-03-06 11:25:42.000000000 -0800
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
--- local-2.6.orig/drivers/input/joydev.c	2005-03-05 13:40:49.000000000 -0800
+++ local-2.6/drivers/input/joydev.c	2005-03-06 11:39:00.000000000 -0800
@@ -286,48 +286,33 @@
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
 
-	if (!joydev->exist) return -ENODEV;
-
 	switch (cmd) {
 
 		case JS_SET_CAL:
 			return copy_from_user(&joydev->glue.JS_CORR, argp,
-				sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+				sizeof(joydev->glue.JS_CORR)) ? -EFAULT : 0;
 		case JS_GET_CAL:
 			return copy_to_user(argp, &joydev->glue.JS_CORR,
-				sizeof(struct JS_DATA_TYPE)) ? -EFAULT : 0;
+				sizeof(joydev->glue.JS_CORR)) ? -EFAULT : 0;
 		case JS_SET_TIMEOUT:
-			return get_user(joydev->glue.JS_TIMEOUT, (int __user *) arg);
+			return get_user(joydev->glue.JS_TIMEOUT, (s32 __user *) argp);
 		case JS_GET_TIMEOUT:
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
+			return put_user(joydev->glue.JS_TIMEOUT, (s32 __user *) argp);
 
 		case JSIOCGVERSION:
-			return put_user(JS_VERSION, (__u32 __user *) arg);
+			return put_user(JS_VERSION, (__u32 __user *) argp);
 		case JSIOCGAXES:
-			return put_user(joydev->nabs, (__u8 __user *) arg);
+			return put_user(joydev->nabs, (__u8 __user *) argp);
 		case JSIOCGBUTTONS:
-			return put_user(joydev->nkey, (__u8 __user *) arg);
+			return put_user(joydev->nkey, (__u8 __user *) argp);
 		case JSIOCSCORR:
 			if (copy_from_user(joydev->corr, argp,
-				      sizeof(struct js_corr) * joydev->nabs))
+				      sizeof(joydev->corr[0]) * joydev->nabs))
 			    return -EFAULT;
 			for (i = 0; i < joydev->nabs; i++) {
 				j = joydev->abspam[i];
@@ -336,7 +321,7 @@
 			return 0;
 		case JSIOCGCORR:
 			return copy_to_user(argp, joydev->corr,
-						sizeof(struct js_corr) * joydev->nabs) ? -EFAULT : 0;
+						sizeof(joydev->corr[0]) * joydev->nabs) ? -EFAULT : 0;
 		case JSIOCSAXMAP:
 			if (copy_from_user(joydev->abspam, argp, sizeof(__u8) * ABS_MAX))
 				return -EFAULT;
@@ -372,6 +357,84 @@
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
+	if (!joydev->exist) return -ENODEV;
+	switch(cmd) {
+	case JS_SET_TIMELIMIT:
+		err = get_user(tmp32, (s32 __user *) arg);
+		if (err == 0)
+			joydev->glue.JS_TIMELIMIT = tmp32;
+		break;
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
+	if (!joydev->exist) return -ENODEV;
+
+	switch(cmd) {
+		case JS_SET_TIMELIMIT:
+			return get_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+		case JS_GET_TIMELIMIT:
+			return put_user(joydev->glue.JS_TIMELIMIT, (long __user *) arg);
+		case JS_SET_ALL:
+			return copy_from_user(&joydev->glue, argp,
+						sizeof(joydev->glue)) ? -EFAULT : 0;
+		case JS_GET_ALL:
+			return copy_to_user(argp, &joydev->glue,
+						sizeof(joydev->glue)) ? -EFAULT : 0;
+		default:
+			return joydev_ioctl_common(joydev, cmd, argp);
+	}
+}
+
 static struct file_operations joydev_fops = {
 	.owner =	THIS_MODULE,
 	.read =		joydev_read,
@@ -380,6 +443,9 @@
 	.open =		joydev_open,
 	.release =	joydev_release,
 	.ioctl =	joydev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	joydev_compat_ioctl,
+#endif
 	.fasync =	joydev_fasync,
 };
 

