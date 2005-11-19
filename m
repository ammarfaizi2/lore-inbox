Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVKSEof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVKSEof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKSEoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:44:14 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:925 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751335AbVKSEoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:44:12 -0500
Message-Id: <20051119044255.131569000.dtor_core@ameritech.net>
References: <20051119043840.747384000.dtor_core@ameritech.net>
Date: Fri, 18 Nov 2005 23:38:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mark Vojkovich <mvojkovi@XFree86.Org>,
       Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
       Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch 3/3] Uinput: dont use "interruptible" in FF code
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

