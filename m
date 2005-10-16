Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVJPWGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJPWGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJPWGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:06:08 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:30379 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751309AbVJPWGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:06:07 -0400
Date: Mon, 17 Oct 2005 00:06:06 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] uinput crash maybe this is the FIX
Message-ID: <20051016220606.GA30260@tink>
References: <20051015212911.GA25752@tink> <20051015225157.GA7146@tink> <20051016115139.GB2084@tink> <20051016211252.GA21557@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20051016211252.GA21557@tink>
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

THanks for all the hints.

Here's my fix for the situation in the uinput.
It generally breaks when Force feedback is removed,
sometimes request id slot is not freed correctly and
it can lead to crash and/or running out of slots.

Without knowing much what I'm doing, I added one
lock and it seems to fix the problem.

Please check is this the right approach on how to do
this locks....

--- linux-2.6.13.4/drivers/input/misc/uinput.c.orig	2005-10-15 10:09:38.000000000 +0200
+++ linux-2.6.13.4/drivers/input/misc/uinput.c	2005-10-16 23:54:20.000000000 +0200
@@ -90,10 +90,16 @@ static inline int uinput_request_reserve
 
 static void uinput_request_done(struct uinput_device *udev, struct uinput_request *request)
 {
+	int id;
+	
+	spin_lock(&udev->requests_lock);
+	id = request->id;
+	spin_unlock(&udev->requests_lock);
 	complete(&request->done);
 
 	/* Mark slot as available */
-	udev->requests[request->id] = NULL;
+	if(id >= 0 && id < UINPUT_NUM_REQUESTS)
+		udev->requests[id] = NULL;
 	wake_up_interruptible(&udev->requests_waitq);
 }
 
