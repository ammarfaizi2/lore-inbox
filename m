Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVGYFyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVGYFyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVGYFxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:53:21 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:6055 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261604AbVGYFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:18 -0400
Message-Id: <20050725054530.798684000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 02/24] uinput: use completions
Content-Disposition: inline; filename=uinput-use-completion.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: uinput - use completions instead of events and manual
       wakeups in force feedback code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |   81 +++++++++++++++++++++++---------------------
 include/linux/uinput.h      |    5 +-
 2 files changed, 45 insertions(+), 41 deletions(-)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -53,24 +53,23 @@ static int uinput_dev_event(struct input
 	return 0;
 }
 
-static int uinput_request_alloc_id(struct input_dev *dev, struct uinput_request *request)
+static int uinput_request_alloc_id(struct uinput_device *udev, struct uinput_request *request)
 {
 	/* Atomically allocate an ID for the given request. Returns 0 on success. */
-	struct uinput_device *udev = dev->private;
 	int id;
 	int err = -1;
 
-	down(&udev->requests_sem);
+	spin_lock(&udev->requests_lock);
 
 	for (id = 0; id < UINPUT_NUM_REQUESTS; id++)
 		if (!udev->requests[id]) {
-			udev->requests[id] = request;
 			request->id = id;
+			udev->requests[id] = request;
 			err = 0;
 			break;
 		}
 
-	up(&udev->requests_sem);
+	spin_unlock(&udev->requests_lock);
 	return err;
 }
 
@@ -79,70 +78,78 @@ static struct uinput_request* uinput_req
 	/* Find an input request, by ID. Returns NULL if the ID isn't valid. */
 	if (id >= UINPUT_NUM_REQUESTS || id < 0)
 		return NULL;
-	if (udev->requests[id]->completed)
-		return NULL;
 	return udev->requests[id];
 }
 
-static void uinput_request_init(struct input_dev *dev, struct uinput_request *request, int code)
+static inline int uinput_request_reserve_slot(struct uinput_device *udev, struct uinput_request *request)
 {
-	struct uinput_device *udev = dev->private;
+	/* Allocate slot. If none are available right away, wait. */
+	return wait_event_interruptible(udev->requests_waitq,
+					!uinput_request_alloc_id(udev, request));
+}
 
-	memset(request, 0, sizeof(struct uinput_request));
-	request->code = code;
-	init_waitqueue_head(&request->waitq);
+static void uinput_request_done(struct uinput_device *udev, struct uinput_request *request)
+{
+	complete(&request->done);
 
-	/* Allocate an ID. If none are available right away, wait. */
-	request->retval = wait_event_interruptible(udev->requests_waitq,
-					!uinput_request_alloc_id(dev, request));
+	/* Mark slot as available */
+	udev->requests[request->id] = NULL;
+	wake_up_interruptible(&udev->requests_waitq);
 }
 
-static void uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
+static int uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
 {
-	struct uinput_device *udev = dev->private;
 	int retval;
 
 	/* Tell our userspace app about this new request by queueing an input event */
 	uinput_dev_event(dev, EV_UINPUT, request->code, request->id);
 
 	/* Wait for the request to complete */
-	retval = wait_event_interruptible(request->waitq, request->completed);
-	if (retval)
-		request->retval = retval;
+	retval = wait_for_completion_interruptible(&request->done);
+	if (!retval)
+		retval = request->retval;
 
-	/* Release this request's ID, let others know it's available */
-	udev->requests[request->id] = NULL;
-	wake_up_interruptible(&udev->requests_waitq);
+	return retval;
 }
 
 static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
 {
 	struct uinput_request request;
+	int retval;
 
 	if (!test_bit(EV_FF, dev->evbit))
 		return -ENOSYS;
 
-	uinput_request_init(dev, &request, UI_FF_UPLOAD);
-	if (request.retval)
-		return request.retval;
+	request.id = -1;
+	init_completion(&request.done);
+	request.code = UI_FF_UPLOAD;
 	request.u.effect = effect;
-	uinput_request_submit(dev, &request);
-	return request.retval;
+
+	retval = uinput_request_reserve_slot(dev->private, &request);
+	if (!retval)
+		retval = uinput_request_submit(dev, &request);
+
+	return retval;
 }
 
 static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
 {
 	struct uinput_request request;
+	int retval;
 
 	if (!test_bit(EV_FF, dev->evbit))
 		return -ENOSYS;
 
-	uinput_request_init(dev, &request, UI_FF_ERASE);
-	if (request.retval)
-		return request.retval;
+	request.id = -1;
+	init_completion(&request.done);
+	request.code = UI_FF_ERASE;
 	request.u.effect_id = effect_id;
-	uinput_request_submit(dev, &request);
-	return request.retval;
+
+	retval = uinput_request_reserve_slot(dev->private, &request);
+	if (!retval)
+		retval = uinput_request_submit(dev, &request);
+
+	return retval;
 }
 
 static int uinput_create_device(struct uinput_device *udev)
@@ -189,7 +196,7 @@ static int uinput_open(struct inode *ino
 	if (!newdev)
 		goto error;
 	memset(newdev, 0, sizeof(struct uinput_device));
-	init_MUTEX(&newdev->requests_sem);
+	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
 
 	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
@@ -551,8 +558,7 @@ static int uinput_ioctl(struct inode *in
 			}
 			req->retval = ff_up.retval;
 			memcpy(req->u.effect, &ff_up.effect, sizeof(struct ff_effect));
-			req->completed = 1;
-			wake_up_interruptible(&req->waitq);
+			uinput_request_done(udev, req);
 			break;
 
 		case UI_END_FF_ERASE:
@@ -566,8 +572,7 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req->retval = ff_erase.retval;
-			req->completed = 1;
-			wake_up_interruptible(&req->waitq);
+			uinput_request_done(udev, req);
 			break;
 
 		default:
Index: work/include/linux/uinput.h
===================================================================
--- work.orig/include/linux/uinput.h
+++ work/include/linux/uinput.h
@@ -42,8 +42,7 @@ struct uinput_request {
 	int			code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
 
 	int			retval;
-	wait_queue_head_t	waitq;
-	int			completed;
+	struct completion	done;
 
 	union {
 		int		effect_id;
@@ -62,7 +61,7 @@ struct uinput_device {
 
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
 	wait_queue_head_t	requests_waitq;
-	struct semaphore	requests_sem;
+	spinlock_t		requests_lock;
 };
 #endif	/* __KERNEL__ */
 

