Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVJPVMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJPVMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJPVMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 17:12:52 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:29870 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751150AbVJPVMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 17:12:51 -0400
Date: Sun, 16 Oct 2005 23:12:52 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: uinput crash and NO FIX YET
Message-ID: <20051016211252.GA21557@tink>
References: <20051015212911.GA25752@tink> <20051015225157.GA7146@tink> <20051016115139.GB2084@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20051016115139.GB2084@tink>
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems the crash is coming from bad locking

I have located exact place where the problem is manifested and
did this patch:

--- drivers/input/misc/uinput.c.orig	2005-10-15 10:09:38.000000000 +0200
+++ drivers/input/misc/uinput.c	2005-10-16 22:19:20.000000000 +0200
@@ -93,7 +93,8 @@ static void uinput_request_done(struct u
 	complete(&request->done);
 
 	/* Mark slot as available */
-	udev->requests[request->id] = NULL;
+	if(request->id >= 0 && request->id < UINPUT_NUM_REQUESTS)
+		udev->requests[request->id] = NULL;
 	wake_up_interruptible(&udev->requests_waitq);
 }
 
This checks wether request id has some sane value.
This way I have avoided crashes but now I'm running
of request[ ] slots, sometimes they tend to leak and
when all the slots are exhausted no more effects can
be accepted.

