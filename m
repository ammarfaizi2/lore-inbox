Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbUKJQ3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUKJQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUKJQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:29:10 -0500
Received: from navi.cs.colorado.edu ([128.138.207.240]:7120 "EHLO navi.cx")
	by vger.kernel.org with ESMTP id S261978AbUKJQ12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:27:28 -0500
Date: Wed, 10 Nov 2004 09:37:51 -0700
From: Micah Dowty <micah@navi.cx>
To: aris@cathedrallabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Force feedback support for uinput
Message-ID: <20041110163751.GA13361@navi.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds support to uinput for Linux's force feedback interface.
With these changes, it's possible to write drivers for force feedback
joysticks and similar devices in userspace. It also adds a way to set
the physical path of devices created via uinput, and it has a couple
trivial bugfixes.

As far as I know, this means it's possible to emulate every feature of
kernelspace input devices in userspace. The application I had in mind
while writing this was a tool to make any Linux input device network-
transparent; you can get the source to "inputpipe" from my Subversion
repository if you're curious to see a use-case for this patch:
    http://navi.cx/svn/misc/trunk/inputpipe/

The uinput driver doesn't provide a natural way to handle the effect
uploading callbacks required for force feedback. It would be nice if
uinput could simply let an application read() information about
callback invocations, but we're locked into having read() only return
input events.

My solution is to have a special input event, outside the range
defined by the input system, that uinput sends to the application
to signal when a callback has been entered. A particular callback
invocation is identified by a request ID stored in this event.

The process using uinput, upon receiving one of these special
input events, makes an ioctl() to get the parameters passed to
the callback. Once the callback has been run in userspace, another
ioctl() is performed to provide a return value and signal completion.
During this time, the original user of the force feedback callback
(typically another process making an ioctl() via evdev) sleeps.

This is fast, shoudln't break compatibility with anything, and
isn't all that awful. If anyone has a better method I'd love
to hear it, but this is the best I could come up with that wouldn't
break compatibility.

I've only tested this with "rumble"-type force feedback devices,
but it should support any type as it doesn't interpret the contents
of the ff_effect structure. This has had the most testing on 2.6.8,
but it doesn't look like anything has changed in uinput between
that and 2.6.10-rc1.

Signed-off-by: Micah Dowty <micah@navi.cx>

(Not subscribed, please CC: replies)

--Micah


--- linux/include/linux/uinput.h.orig	2004-11-10 08:51:51.898831904 -0700
+++ linux/include/linux/uinput.h	2004-11-10 08:51:58.955759088 -0700
@@ -22,6 +22,9 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  * 
  * Changes/Revisions:
+ *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
+ *		- added force feedback support
+ *             - added UI_SET_PHYS
  *	0.1	20/06/2002
  *		- first public version
  */
@@ -29,10 +32,25 @@
 #define UINPUT_MINOR		223
 #define UINPUT_NAME		"uinput"
 #define UINPUT_BUFFER_SIZE	16
+#define UINPUT_NUM_REQUESTS	16
 
 /* state flags => bit index for {set|clear|test}_bit ops */
 #define UIST_CREATED		0
 
+struct uinput_request {
+	int			id;
+	int			code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
+
+	int			retval;
+	wait_queue_head_t	waitq;
+	int			completed;
+
+	union {
+		int		effect_id;
+		struct ff_effect* effect;
+	} u;
+};
+
 struct uinput_device {
 	struct input_dev	*dev;
 	unsigned long		state;
@@ -41,13 +59,30 @@
 				head,
 				tail;
 	struct input_event	buff[UINPUT_BUFFER_SIZE];
+
+	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
+	wait_queue_head_t	requests_waitq;
+	struct semaphore	requests_sem;
 };
 #endif	/* __KERNEL__ */
 
+struct uinput_ff_upload {
+	int			request_id;
+	int			retval;
+	struct ff_effect	effect;
+};
+
+struct uinput_ff_erase {
+	int			request_id;
+	int			retval;
+	int			effect_id;
+};
+
 /* ioctl */
 #define UINPUT_IOCTL_BASE	'U'
 #define UI_DEV_CREATE		_IO(UINPUT_IOCTL_BASE, 1)
 #define UI_DEV_DESTROY		_IO(UINPUT_IOCTL_BASE, 2)
+
 #define UI_SET_EVBIT		_IOW(UINPUT_IOCTL_BASE, 100, int)
 #define UI_SET_KEYBIT		_IOW(UINPUT_IOCTL_BASE, 101, int)
 #define UI_SET_RELBIT		_IOW(UINPUT_IOCTL_BASE, 102, int)
@@ -56,6 +91,63 @@
 #define UI_SET_LEDBIT		_IOW(UINPUT_IOCTL_BASE, 105, int)
 #define UI_SET_SNDBIT		_IOW(UINPUT_IOCTL_BASE, 106, int)
 #define UI_SET_FFBIT		_IOW(UINPUT_IOCTL_BASE, 107, int)
+#define UI_SET_PHYS		_IOW(UINPUT_IOCTL_BASE, 108, char*)
+
+#define UI_BEGIN_FF_UPLOAD	_IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload)
+#define UI_END_FF_UPLOAD	_IOW(UINPUT_IOCTL_BASE, 201, struct uinput_ff_upload)
+#define UI_BEGIN_FF_ERASE	_IOWR(UINPUT_IOCTL_BASE, 202, struct uinput_ff_erase)
+#define UI_END_FF_ERASE		_IOW(UINPUT_IOCTL_BASE, 203, struct uinput_ff_erase)
+
+/* To write a force-feedback-capable driver, the upload_effect
+ * and erase_effect callbacks in input_dev must be implemented.
+ * The uinput driver will generate a fake input event when one of
+ * these callbacks are invoked. The userspace code then uses
+ * ioctls to retrieve additional parameters and send the return code.
+ * The callback blocks until this return code is sent.
+ *
+ * The described callback mechanism is only used if EV_FF is set.
+ * Otherwise, default implementations of upload_effect and erase_effect
+ * are used.
+ *
+ * To implement upload_effect():
+ *   1. Wait for an event with type==EV_UINPUT and code==UI_FF_UPLOAD.
+ *      A request ID will be given in 'value'.
+ *   2. Allocate a uinput_ff_upload struct, fill in request_id with
+ *      the 'value' from the EV_UINPUT event.
+ *   3. Issue a UI_BEGIN_FF_UPLOAD ioctl, giving it the
+ *      uinput_ff_upload struct. It will be filled in with the
+ *      ff_effect passed to upload_effect().
+ *   4. Perform the effect upload, and place the modified ff_effect
+ *      and a return code back into the uinput_ff_upload struct.
+ *   5. Issue a UI_END_FF_UPLOAD ioctl, also giving it the
+ *      uinput_ff_upload_effect struct. This will complete execution
+ *      of our upload_effect() handler.
+ *
+ * To implement erase_effect():
+ *   1. Wait for an event with type==EV_UINPUT and code==UI_FF_ERASE.
+ *      A request ID will be given in 'value'.
+ *   2. Allocate a uinput_ff_erase struct, fill in request_id with
+ *      the 'value' from the EV_UINPUT event.
+ *   3. Issue a UI_BEGIN_FF_ERASE ioctl, giving it the
+ *      uinput_ff_erase struct. It will be filled in with the
+ *      effect ID passed to erase_effect().
+ *   4. Perform the effect erasure, and place a return code back
+ *      into the uinput_ff_erase struct.
+ *      and a return code back into the uinput_ff_erase struct.
+ *   5. Issue a UI_END_FF_ERASE ioctl, also giving it the
+ *      uinput_ff_erase_effect struct. This will complete execution
+ *      of our erase_effect() handler.
+ */
+
+/* This is the new event type, used only by uinput.
+ * 'code' is UI_FF_UPLOAD or UI_FF_ERASE, and 'value'
+ * is the unique request ID. This number was picked
+ * arbitrarily, above EV_MAX (since the input system
+ * never sees it) but in the range of a 16-bit int.
+ */
+#define EV_UINPUT		0x0101
+#define UI_FF_UPLOAD		1
+#define UI_FF_ERASE		2
 
 #ifndef NBITS
 #define NBITS(x) ((((x)-1)/(sizeof(long)*8))+1)
--- linux/drivers/input/misc/uinput.c.orig	2004-11-10 08:51:07.370601224 -0700
+++ linux/drivers/input/misc/uinput.c	2004-11-10 08:57:53.822811096 -0700
@@ -20,6 +20,9 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  *
  * Changes/Revisions:
+ *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
+ *		- added force feedback support
+ *              - added UI_SET_PHYS
  *	0.1	20/06/2002
  *		- first public version
  */
@@ -60,14 +63,93 @@
 	return 0;
 }
 
+static int uinput_request_alloc_id(struct input_dev *dev, struct uinput_request *request)
+{
+	/* Atomically allocate an ID for the given request. Returns 0 on success. */
+	struct uinput_device *udev = (struct uinput_device *)dev->private;
+	int id;
+
+	down(&udev->requests_sem);
+	for (id=0; id<UINPUT_NUM_REQUESTS; id++)
+		if (!udev->requests[id]) {
+			udev->requests[id] = request;
+			request->id = id;
+			up(&udev->requests_sem);
+			return 0;
+		}
+	up(&udev->requests_sem);
+	return -1;
+}
+
+static struct uinput_request* uinput_request_find(struct uinput_device *udev, int id)
+{
+	/* Find an input request, by ID. Returns NULL if the ID isn't valid. */
+	if (id >= UINPUT_NUM_REQUESTS || id < 0)
+		return NULL;
+	if (udev->requests[id]->completed)
+		return NULL;
+	return udev->requests[id];
+}
+
+static void uinput_request_init(struct input_dev *dev, struct uinput_request *request, int code)
+{
+	struct uinput_device *udev = (struct uinput_device *)dev->private;
+
+	memset(request, 0, sizeof(struct uinput_request));
+	request->code = code;
+	init_waitqueue_head(&request->waitq);
+
+	/* Allocate an ID. If none are available right away, wait. */
+	request->retval = wait_event_interruptible(udev->requests_waitq,
+				       !uinput_request_alloc_id(dev, request));
+}
+
+static void uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
+{
+	struct uinput_device *udev = (struct uinput_device *)dev->private;
+	int retval;
+
+	/* Tell our userspace app about this new request by queueing an input event */
+	uinput_dev_event(dev, EV_UINPUT, request->code, request->id);
+
+	/* Wait for the request to complete */
+	retval = wait_event_interruptible(request->waitq, request->completed);
+	if (retval)
+		request->retval = retval;
+
+	/* Release this request's ID, let others know it's available */
+	udev->requests[request->id] = NULL;
+	wake_up_interruptible(&udev->requests_waitq);
+}
+
 static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
 {
-	return 0;
+	struct uinput_request request;
+
+	if (!test_bit(EV_FF, dev->evbit))
+		return -ENOSYS;
+
+	uinput_request_init(dev, &request, UI_FF_UPLOAD);
+	if (request.retval)
+		return request.retval;
+	request.u.effect = effect;
+	uinput_request_submit(dev, &request);
+	return request.retval;
 }
 
 static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
 {
-	return 0;
+	struct uinput_request request;
+
+	if (!test_bit(EV_FF, dev->evbit))
+		return -ENOSYS;
+
+	uinput_request_init(dev, &request, UI_FF_ERASE);
+	if (request.retval)
+		return request.retval;
+	request.u.effect_id = effect_id;
+	uinput_request_submit(dev, &request);
+	return request.retval;
 }
 
 static int uinput_create_device(struct uinput_device *udev)
@@ -116,6 +198,8 @@
 	if (!newdev)
 		goto error;
 	memset(newdev, 0, sizeof(struct uinput_device));
+	init_MUTEX(&newdev->requests_sem);
+	init_waitqueue_head(&newdev->requests_waitq);
 
 	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
 	if (!newinput)
@@ -279,9 +363,6 @@
 {
 	struct uinput_device *udev = file->private_data;
 
-	if (!test_bit(UIST_CREATED, &(udev->state)))
-		return 0;
-
 	poll_wait(file, &udev->waitq, wait);
 
 	if (udev->head != udev->tail)
@@ -295,6 +376,11 @@
 	if (test_bit(UIST_CREATED, &(udev->state)))
 		uinput_destroy_device(udev);
 
+	if (NULL != udev->dev->name)
+		kfree(udev->dev->name);
+	if (NULL != udev->dev->phys)
+		kfree(udev->dev->phys);
+
 	kfree(udev->dev);
 	kfree(udev);
 
@@ -310,12 +396,28 @@
 {
 	int			retval = 0;
 	struct uinput_device	*udev;
+	void __user             *p = (void __user *)arg;
+	struct uinput_ff_upload ff_up;
+	struct uinput_ff_erase  ff_erase;
+	struct uinput_request   *req;
+	int                     length;
 
 	udev = (struct uinput_device *)file->private_data;
 
 	/* device attributes can not be changed after the device is created */
-	if (cmd >= UI_SET_EVBIT && test_bit(UIST_CREATED, &(udev->state)))
-		return -EINVAL;
+	switch (cmd) {
+		case UI_SET_EVBIT:
+		case UI_SET_KEYBIT:
+		case UI_SET_RELBIT:
+		case UI_SET_ABSBIT:
+		case UI_SET_MSCBIT:
+		case UI_SET_LEDBIT:
+		case UI_SET_SNDBIT:
+		case UI_SET_FFBIT:
+		case UI_SET_PHYS:
+			if (test_bit(UIST_CREATED, &(udev->state)))
+				return -EINVAL;
+	}
 
 	switch (cmd) {
 		case UI_DEV_CREATE:
@@ -390,8 +492,97 @@
 			set_bit(arg, udev->dev->ffbit);
 			break;
 
+		case UI_SET_PHYS:
+			length = strnlen_user(p, 1024);
+			if (length <= 0) {
+				retval = -EFAULT;
+				break;
+			}
+			if (NULL != udev->dev->phys)
+				kfree(udev->dev->phys);
+			udev->dev->phys = kmalloc(length, GFP_KERNEL);
+			if (!udev->dev->phys) {
+				retval = -ENOMEM;
+				break;
+			}
+			if (copy_from_user(udev->dev->phys, p, length)) {
+				retval = -EFAULT;
+				kfree(udev->dev->phys);
+				udev->dev->phys = NULL;
+				break;
+			}
+			udev->dev->phys[length-1] = '\0';
+			break;
+
+		case UI_BEGIN_FF_UPLOAD:
+			if (copy_from_user(&ff_up, p, sizeof(ff_up))) {
+				retval = -EFAULT;
+				break;
+			}
+			req = uinput_request_find(udev, ff_up.request_id);
+			if (!(req && req->code==UI_FF_UPLOAD && req->u.effect)) {
+				retval = -EINVAL;
+				break;
+			}
+			ff_up.retval = 0;
+			memcpy(&ff_up.effect, req->u.effect, sizeof(struct ff_effect));
+			if (copy_to_user(p, &ff_up, sizeof(ff_up))) {
+				retval = -EFAULT;
+				break;
+			}
+			break;
+
+		case UI_BEGIN_FF_ERASE:
+			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
+				retval = -EFAULT;
+				break;
+			}
+			req = uinput_request_find(udev, ff_erase.request_id);
+			if (!(req && req->code==UI_FF_ERASE)) {
+				retval = -EINVAL;
+				break;
+			}
+			ff_erase.retval = 0;
+			ff_erase.effect_id = req->u.effect_id;
+			if (copy_to_user(p, &ff_erase, sizeof(ff_erase))) {
+				retval = -EFAULT;
+				break;
+			}
+			break;
+
+		case UI_END_FF_UPLOAD:
+			if (copy_from_user(&ff_up, p, sizeof(ff_up))) {
+				retval = -EFAULT;
+				break;
+			}
+			req = uinput_request_find(udev, ff_up.request_id);
+			if (!(req && req->code==UI_FF_UPLOAD && req->u.effect)) {
+				retval = -EINVAL;
+				break;
+			}
+			req->retval = ff_up.retval;
+			memcpy(req->u.effect, &ff_up.effect, sizeof(struct ff_effect));
+			req->completed = 1;
+			wake_up_interruptible(&req->waitq);
+			break;
+
+		case UI_END_FF_ERASE:
+			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
+				retval = -EFAULT;
+				break;
+			}
+			req = uinput_request_find(udev, ff_erase.request_id);
+			if (!(req && req->code==UI_FF_ERASE)) {
+				retval = -EINVAL;
+				break;
+			}
+			req->retval = ff_erase.retval;
+			req->completed = 1;
+			wake_up_interruptible(&req->waitq);
+			break;
+
 		default:
-			retval = -EFAULT;
+			retval = -EINVAL;
 	}
 	return retval;
 }

-- 
Only you can prevent creeping featurism!
