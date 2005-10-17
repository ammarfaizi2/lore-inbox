Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVJQFzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJQFzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 01:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVJQFzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 01:55:50 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:47271 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932273AbVJQFzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 01:55:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uinput crash maybe this is the FIX
Date: Mon, 17 Oct 2005 00:55:47 -0500
User-Agent: KMail/1.8.2
Cc: emard@softhome.net
References: <20051015212911.GA25752@tink> <20051016211252.GA21557@tink> <20051016220606.GA30260@tink>
In-Reply-To: <20051016220606.GA30260@tink>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170055.47342.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 October 2005 17:06, emard@softhome.net wrote:
> HI
> 
> THanks for all the hints.
> 
> Here's my fix for the situation in the uinput.
> It generally breaks when Force feedback is removed,
> sometimes request id slot is not freed correctly and
> it can lead to crash and/or running out of slots.
> 
> Without knowing much what I'm doing, I added one
> lock and it seems to fix the problem.
>

The lock is not really needed, please try the patch below.

-- 
Dmitry

Input: uniput - fix crash on SMP

Only signal completion after marking request slot as free,
otherwise other processor can free request structure before
we finish using it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -90,11 +90,11 @@ static inline int uinput_request_reserve
 
 static void uinput_request_done(struct uinput_device *udev, struct uinput_request *request)
 {
-	complete(&request->done);
-
 	/* Mark slot as available */
 	udev->requests[request->id] = NULL;
 	wake_up_interruptible(&udev->requests_waitq);
+
+	complete(&request->done);
 }
 
 static int uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
