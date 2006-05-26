Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWEZQcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWEZQcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWEZQ3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:29:36 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:28324 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751061AbWEZQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:29:23 -0400
Message-Id: <20060526162904.998470000@gmail.com>
References: <20060526161129.557416000@gmail.com>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 19:11:35 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 06/13] input: adapt uinput for the new force feedback interface
Content-Disposition: inline; filename=ff-refactoring-uinput-to-new-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the uinput driver for the new force feedback interface. The userspace
interface of the force feedback part is changed and documentation in uinput.h
is updated accordingly. MODULE_VERSION is also added to reflect the revision.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/misc/uinput.c |   76 +++++++++++++++++++++++++++++++++++---------
 include/linux/uinput.h      |   21 ++++++++----
 2 files changed, 77 insertions(+), 20 deletions(-)

Index: linux-2.6.17-rc4-git12/drivers/input/misc/uinput.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/misc/uinput.c	2006-05-26 16:59:59.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/misc/uinput.c	2006-05-26 17:11:20.000000000 +0300
@@ -20,6 +20,9 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  *
  * Changes/Revisions:
+ *	0.3	09/04/2006 (Anssi Hannula <anssi.hannula@gmail.com>)
+ *		- updated ff support for the changes in kernel interface
+ *		- added MODULE_VERSION
  *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
  *		- added force feedback support
  *              - added UI_SET_PHYS
@@ -107,18 +110,31 @@ static int uinput_request_submit(struct 
 	return request->retval;
 }
 
-static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
+static void uinput_dev_set_gain(struct input_dev *dev, u16 gain)
+{
+	uinput_dev_event(dev, EV_FF, FF_GAIN, gain);
+}
+
+static void uinput_dev_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	uinput_dev_event(dev, EV_FF, FF_AUTOCENTER, magnitude);
+}
+
+static int uinput_dev_playback(struct input_dev *dev, int effect_id, int value)
+{
+	return uinput_dev_event(dev, EV_FF, effect_id, value);
+}
+
+static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
 	struct uinput_request request;
 	int retval;
 
-	if (!test_bit(EV_FF, dev->evbit))
-		return -ENOSYS;
-
 	request.id = -1;
 	init_completion(&request.done);
 	request.code = UI_FF_UPLOAD;
-	request.u.effect = effect;
+	request.u.upload.effect = effect;
+	request.u.upload.old = old;
 
 	retval = uinput_request_reserve_slot(dev->private, &request);
 	if (!retval)
@@ -166,6 +182,14 @@ static void uinput_destroy_device(struct
 	udev->state = UIST_NEW_DEVICE;
 }
 
+static struct ff_driver uinput_ff_driver = {
+	.upload = uinput_dev_upload_effect,
+	.erase = uinput_dev_erase_effect,
+	.playback = uinput_dev_playback,
+	.set_gain = uinput_dev_set_gain,
+	.set_autocenter = uinput_dev_set_autocenter
+};
+
 static int uinput_create_device(struct uinput_device *udev)
 {
 	int error;
@@ -181,6 +205,14 @@ static int uinput_create_device(struct u
 		return error;
 	}
 
+	if (udev->dev->ff) {
+		error = input_ff_register(udev->dev, &uinput_ff_driver);
+		if (error) {
+			uinput_destroy_device(udev);
+			return error;
+		}
+	}
+
 	udev->state = UIST_CREATED;
 
 	return 0;
@@ -243,8 +275,6 @@ static int uinput_allocate_device(struct
 		return -ENOMEM;
 
 	udev->dev->event = uinput_dev_event;
-	udev->dev->upload_effect = uinput_dev_upload_effect;
-	udev->dev->erase_effect = uinput_dev_erase_effect;
 	udev->dev->private = udev;
 
 	return 0;
@@ -296,7 +326,12 @@ static int uinput_setup_device(struct ui
 	dev->id.vendor	= user_dev->id.vendor;
 	dev->id.product	= user_dev->id.product;
 	dev->id.version	= user_dev->id.version;
-	dev->ff_effects_max = user_dev->ff_effects_max;
+	if (user_dev->ff_effects_max) {
+		retval = input_ff_allocate(dev);
+		if (retval)
+			goto exit;
+		dev->ff_effects_max = user_dev->ff_effects_max;
+	}
 
 	size = sizeof(int) * (ABS_MAX + 1);
 	memcpy(dev->absmax, user_dev->absmax, size);
@@ -459,7 +494,12 @@ static long uinput_ioctl(struct file *fi
 			break;
 
 		case UI_SET_EVBIT:
-			retval = uinput_set_bit(arg, evbit, EV_MAX);
+			if (arg == EV_FF)
+				/* EV_FF shall not be touched by the driver
+				   it is set by force feedback subsystem */
+				retval = -EINVAL;
+			else
+				retval = uinput_set_bit(arg, evbit, EV_MAX);
 			break;
 
 		case UI_SET_KEYBIT:
@@ -487,7 +527,10 @@ static long uinput_ioctl(struct file *fi
 			break;
 
 		case UI_SET_FFBIT:
-			retval = uinput_set_bit(arg, ffbit, FF_MAX);
+			if (!udev->dev->ff)
+				retval = -EINVAL;
+			else
+				retval = uinput_set_bit(arg, ff->flags, FF_MAX);
 			break;
 
 		case UI_SET_SWBIT:
@@ -525,12 +568,17 @@ static long uinput_ioctl(struct file *fi
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
+			if (!(req && req->code == UI_FF_UPLOAD && req->u.upload.effect)) {
 				retval = -EINVAL;
 				break;
 			}
 			ff_up.retval = 0;
-			memcpy(&ff_up.effect, req->u.effect, sizeof(struct ff_effect));
+			memcpy(&ff_up.effect, req->u.upload.effect, sizeof(struct ff_effect));
+			if (req->u.upload.old)
+				memcpy(&ff_up.old, req->u.upload.old, sizeof(struct ff_effect));
+			else
+				memset(&ff_up.old, 0, sizeof(struct ff_effect));
+
 			if (copy_to_user(p, &ff_up, sizeof(ff_up))) {
 				retval = -EFAULT;
 				break;
@@ -561,12 +609,11 @@ static long uinput_ioctl(struct file *fi
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
+			if (!(req && req->code == UI_FF_UPLOAD && req->u.upload.effect)) {
 				retval = -EINVAL;
 				break;
 			}
 			req->retval = ff_up.retval;
-			memcpy(req->u.effect, &ff_up.effect, sizeof(struct ff_effect));
 			uinput_request_done(udev, req);
 			break;
 
@@ -622,6 +669,7 @@ static void __exit uinput_exit(void)
 MODULE_AUTHOR("Aristeu Sergio Rozanski Filho");
 MODULE_DESCRIPTION("User level driver support for input subsystem");
 MODULE_LICENSE("GPL");
+MODULE_VERSION("0.3");
 
 module_init(uinput_init);
 module_exit(uinput_exit);
Index: linux-2.6.17-rc4-git12/include/linux/uinput.h
===================================================================
--- linux-2.6.17-rc4-git12.orig/include/linux/uinput.h	2006-05-26 16:59:59.000000000 +0300
+++ linux-2.6.17-rc4-git12/include/linux/uinput.h	2006-05-26 17:09:01.000000000 +0300
@@ -22,12 +22,18 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  *
  * Changes/Revisions:
+ *	0.3	24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
+ *		- update ff support for the changes in kernel interface
+ *		- add UINPUT_VERSION
  *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
  *		- added force feedback support
  *             - added UI_SET_PHYS
  *	0.1	20/06/2002
  *		- first public version
  */
+
+#define UINPUT_VERSION		3
+
 #ifdef __KERNEL__
 #define UINPUT_MINOR		223
 #define UINPUT_NAME		"uinput"
@@ -45,7 +51,10 @@ struct uinput_request {
 
 	union {
 		int		effect_id;
-		struct ff_effect* effect;
+		struct {
+			struct ff_effect* effect;
+			struct ff_effect* old;
+		} upload;
 	} u;
 };
 
@@ -69,6 +78,7 @@ struct uinput_ff_upload {
 	int			request_id;
 	int			retval;
 	struct ff_effect	effect;
+	struct ff_effect	old;
 };
 
 struct uinput_ff_erase {
@@ -105,7 +115,7 @@ struct uinput_ff_erase {
  * ioctls to retrieve additional parameters and send the return code.
  * The callback blocks until this return code is sent.
  *
- * The described callback mechanism is only used if EV_FF is set.
+ * The described callback mechanism is only used if ff_effects_max is set.
  * Otherwise, default implementations of upload_effect and erase_effect
  * are used.
  *
@@ -116,9 +126,9 @@ struct uinput_ff_erase {
  *      the 'value' from the EV_UINPUT event.
  *   3. Issue a UI_BEGIN_FF_UPLOAD ioctl, giving it the
  *      uinput_ff_upload struct. It will be filled in with the
- *      ff_effect passed to upload_effect().
- *   4. Perform the effect upload, and place the modified ff_effect
- *      and a return code back into the uinput_ff_upload struct.
+ *      ff_effects passed to upload_effect().
+ *   4. Perform the effect upload, and place a return code back into
+        the uinput_ff_upload struct.
  *   5. Issue a UI_END_FF_UPLOAD ioctl, also giving it the
  *      uinput_ff_upload_effect struct. This will complete execution
  *      of our upload_effect() handler.
@@ -133,7 +143,6 @@ struct uinput_ff_erase {
  *      effect ID passed to erase_effect().
  *   4. Perform the effect erasure, and place a return code back
  *      into the uinput_ff_erase struct.
- *      and a return code back into the uinput_ff_erase struct.
  *   5. Issue a UI_END_FF_ERASE ioctl, also giving it the
  *      uinput_ff_erase_effect struct. This will complete execution
  *      of our erase_effect() handler.

--
Anssi Hannula
