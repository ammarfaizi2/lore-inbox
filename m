Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUKUIqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUKUIqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 03:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUKUIqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 03:46:17 -0500
Received: from [128.138.207.240] ([128.138.207.240]:17591 "EHLO navi.cx")
	by vger.kernel.org with ESMTP id S261920AbUKUIoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 03:44:08 -0500
Date: Sun, 21 Nov 2004 01:54:52 -0700
From: Micah Dowty <micah@navi.cx>
To: aris@cefetpr.br
Cc: aris@cathedrallabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Force feedback support for uinput
Message-ID: <20041121085452.GA26087@navi.cx>
References: <20041110163751.GA13361@navi.cx> <20041112120852.GA25736@cefetpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112120852.GA25736@cefetpr.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 10:09:12AM -0200, aris@cefetpr.br wrote:
> > +#define EV_UINPUT		0x0101
> I guess it should be moved to input.h with other types of events.

Done. I didn't do this before since it isn't used anywhere other than
between uinput and its applications. I added a short note to this effect
in input.h

> > +/* To write a force-feedback-capable driver, the upload_effect
> > + * and erase_effect callbacks in input_dev must be implemented.
> > + * The uinput driver will generate a fake input event when one of
> > + * these callbacks are invoked. The userspace code then uses
> > + * ioctls to retrieve additional parameters and send the return code.
> > + * The callback blocks until this return code is sent.
> (snip)
> what about moving this long comment to Documentation/input/uinput.txt?

Also done. Since uinput.txt didn't have any documentation at all,
I added a short section on basic usage. It should be expanded, but it's
better than nothing.

> (p.s.: sorry for the delay and the dup that will follow. my server is
> offline due adsl problems and the first answer is stuck there :)

No problem at all, I've been really busy lately.

Here's the revised patch, also including Andrew Morton's cleanups:

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Micah Dowty <micah@navi.cx>

diff -puNr linux-2.6.10-rc2-bk5/Documentation/input/uinput.txt linux-uinput-ff/Documentation/input/uinput.txt
--- linux-2.6.10-rc2-bk5/Documentation/input/uinput.txt	1969-12-31 17:00:00.000000000 -0700
+++ linux-uinput-ff/Documentation/input/uinput.txt	2004-11-20 20:41:08.794414600 -0700
@@ -0,0 +1,66 @@
+uinput: user level driver support for input subsystem
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Basic use
+~~~~~~~~~~~~
+
+The uinput driver creates a character device, usually at /dev/uinput, that can
+be used to create Linux input devices from userspace. The rest of this text
+assumes you are already familiar with writing input drivers in kernelspace.
+
+The device's capabilities and identity are established primarily by write()'ing
+a struct uinput_device. Information not contained in this structure is provided
+with the UI_SET_* family of ioctl()s. After all this, UI_DEV_CREATE actually
+registers a new device with the input subsystem. Between UI_DEV_CREATE and
+UI_DEV_DESTROY, the UI_SET_* ioctl()s can't be used.
+
+Once the device has been created, /dev/uinput acts much like an event device.
+write() sends a struct input_event out of the device, read() fetches input
+events sent back to the driver by applications. Note that events written will
+also be echoed back on read.
+
+2. Force Feedback
+~~~~~~~~~~~~~~~~~
+
+To write a force-feedback-capable driver, the upload_effect and erase_effect
+callbacks in input_dev must be implemented. The uinput driver will generate a
+fake input event when one of these callbacks are invoked. The userspace code
+then uses ioctls to retrieve additional parameters and send the return code.
+The callback blocks until this return code is sent.
+
+The described callback mechanism is only used if EV_FF is set. Otherwise,
+default implementations of upload_effect and erase_effect are used.
+
+To implement upload_effect():
+
+  1. Wait for an event with type==EV_UINPUT and code==UI_FF_UPLOAD. A request
+     ID will be given in 'value'.
+
+  2. Allocate a uinput_ff_upload struct, fill in request_id with the 'value'
+     from the EV_UINPUT event.
+
+  3. Issue a UI_BEGIN_FF_UPLOAD ioctl, giving it the uinput_ff_upload struct.
+     It will be filled in with the ff_effect passed to upload_effect().
+
+  4. Perform the effect upload. Place the modified ff_effect and a return
+     code back into the uinput_ff_upload struct.
+
+  5. Issue a UI_END_FF_UPLOAD ioctl, also giving it the uinput_ff_upload_effect
+     struct. This will complete execution of our upload_effect() handler.
+
+To implement erase_effect():
+
+  1. Wait for an event with type==EV_UINPUT and code==UI_FF_ERASE. A request
+     ID will be given in 'value'.
+
+  2. Allocate a uinput_ff_erase struct, fill in request_id with the 'value'
+     from the EV_UINPUT event.
+
+  3. Issue a UI_BEGIN_FF_ERASE ioctl, giving it the uinput_ff_erase struct.
+     It will be filled in with the effect ID passed to erase_effect().
+
+  4. Perform the effect erasure, and place a return code back into the
+     uinput_ff_erase struct.
+
+  5. Issue a UI_END_FF_ERASE ioctl, also giving it the uinput_ff_erase_effect
+     struct. This will complete execution of our erase_effect() handler.
diff -puNr linux-2.6.10-rc2-bk5/drivers/input/misc/uinput.c linux-uinput-ff/drivers/input/misc/uinput.c
--- linux-2.6.10-rc2-bk5/drivers/input/misc/uinput.c	2004-10-18 15:54:55.000000000 -0600
+++ linux-uinput-ff/drivers/input/misc/uinput.c	2004-11-20 20:40:04.583176192 -0700
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
@@ -47,7 +56,7 @@ static int uinput_dev_event(struct input
 {
 	struct uinput_device	*udev;
 
-	udev = (struct uinput_device *)dev->private;
+	udev = dev->private;
 
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
@@ -60,14 +69,93 @@ static int uinput_dev_event(struct input
 	return 0;
 }
 
+static int uinput_request_alloc_id(struct input_dev *dev, struct uinput_request *request)
+{
+	/* Atomically allocate an ID for the given request. Returns 0 on success. */
+	struct uinput_device *udev = dev->private;
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
+	struct uinput_device *udev = dev->private;
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
+	struct uinput_device *udev = dev->private;
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
@@ -116,6 +204,8 @@ static int uinput_open(struct inode *ino
 	if (!newdev)
 		goto error;
 	memset(newdev, 0, sizeof(struct uinput_device));
+	init_MUTEX(&newdev->requests_sem);
+	init_waitqueue_head(&newdev->requests_waitq);
 
 	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
 	if (!newinput)
@@ -176,7 +266,7 @@ static int uinput_alloc_device(struct fi
 
 	retval = count;
 
-	udev = (struct uinput_device *)file->private_data;
+	udev = file->private_data;
 	dev = udev->dev;
 
 	user_dev = kmalloc(sizeof(*user_dev), GFP_KERNEL);
@@ -228,7 +318,7 @@ exit:
 
 static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct uinput_device	*udev = file->private_data;
+	struct uinput_device *udev = file->private_data;
 
 	if (test_bit(UIST_CREATED, &(udev->state))) {
 		struct input_event	ev;
@@ -295,6 +382,11 @@ static int uinput_burn_device(struct uin
 	if (test_bit(UIST_CREATED, &(udev->state)))
 		uinput_destroy_device(udev);
 
+	if (NULL != udev->dev->name)
+		kfree(udev->dev->name);
+	if (NULL != udev->dev->phys)
+		kfree(udev->dev->phys);
+
 	kfree(udev->dev);
 	kfree(udev);
 
@@ -303,19 +395,35 @@ static int uinput_burn_device(struct uin
 
 static int uinput_close(struct inode *inode, struct file *file)
 {
-	return uinput_burn_device((struct uinput_device *)file->private_data);
+	return uinput_burn_device(file->private_data);
 }
 
 static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int			retval = 0;
 	struct uinput_device	*udev;
+	void __user             *p = (void __user *)arg;
+	struct uinput_ff_upload ff_up;
+	struct uinput_ff_erase  ff_erase;
+	struct uinput_request   *req;
+	int                     length;
 
-	udev = (struct uinput_device *)file->private_data;
+	udev = file->private_data;
 
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
@@ -390,8 +498,97 @@ static int uinput_ioctl(struct inode *in
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
diff -puNr linux-2.6.10-rc2-bk5/include/linux/input.h linux-uinput-ff/include/linux/input.h
--- linux-2.6.10-rc2-bk5/include/linux/input.h	2004-11-20 20:33:25.000000000 -0700
+++ linux-uinput-ff/include/linux/input.h	2004-11-20 20:40:49.000000000 -0700
@@ -94,6 +94,8 @@ struct input_absinfo {
 #define EV_FF_STATUS		0x17
 #define EV_MAX			0x1f
 
+#define EV_UINPUT		0x0101     /* Used only between /dev/uinput and applications */
+
 /*
  * Synchronization events.
  */
diff -puNr linux-2.6.10-rc2-bk5/include/linux/uinput.h linux-uinput-ff/include/linux/uinput.h
--- linux-2.6.10-rc2-bk5/include/linux/uinput.h	2004-10-18 15:54:40.000000000 -0600
+++ linux-uinput-ff/include/linux/uinput.h	2004-11-20 20:40:55.000000000 -0700
@@ -22,6 +22,9 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  * 
  * Changes/Revisions:
+ *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
+ *		- added force feedback support
+ *              - added UI_SET_PHYS
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
@@ -41,13 +59,30 @@ struct uinput_device {
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
@@ -56,6 +91,16 @@ struct uinput_device {
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
+/* 'code' values for EV_UINPUT */
+#define UI_FF_UPLOAD		1
+#define UI_FF_ERASE		2
 
 #ifndef NBITS
 #define NBITS(x) ((((x)-1)/(sizeof(long)*8))+1)


-- 
Only you can prevent creeping featurism!
