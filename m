Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVKTHF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVKTHF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVKTHF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:05:59 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:57211 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750859AbVKTHF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:05:58 -0500
Message-Id: <20051120064420.502528000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 10/14] Uinput: dont use "interruptible" in FF code
Content-Disposition: inline; filename=uinput-dont-use-wait-completion-interruptible.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: uinput - don't use "interruptible" in FF code

If thread that submitted FF request gets interrupted somehow it
will release request structure and ioctl handler will work with
freed memory. TO prevent that from happening switch to using
wait_for_completion instead of wait_for_completion_interruptible.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -92,24 +92,19 @@ static void uinput_request_done(struct u
 {
 	/* Mark slot as available */
 	udev->requests[request->id] = NULL;
-	wake_up_interruptible(&udev->requests_waitq);
+	wake_up(&udev->requests_waitq);
 
 	complete(&request->done);
 }
 
 static int uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
 {
-	int retval;
-
 	/* Tell our userspace app about this new request by queueing an input event */
 	uinput_dev_event(dev, EV_UINPUT, request->code, request->id);
 
 	/* Wait for the request to complete */
-	retval = wait_for_completion_interruptible(&request->done);
-	if (!retval)
-		retval = request->retval;
-
-	return retval;
+	wait_for_completion(&request->done);
+	return request->retval;
 }
 
 static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)

