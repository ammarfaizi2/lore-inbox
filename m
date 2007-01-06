Return-Path: <linux-kernel-owner+w=401wt.eu-S1751443AbXAFS0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXAFS0f (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbXAFS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:26:35 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:48926 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXAFS0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:26:34 -0500
Date: Sat, 06 Jan 2007 12:25:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] cx88xx: Fix lockup on suspend
In-reply-to: <fa.mPiA9bh9SZGXd2TrS/eQjWPc9oA@ifi.uio.no>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <459FE9B7.3070601@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------000703060708060805050607
References: <fa.zlXsUuWZNMJXOVESY6BoJRtki8Y@ifi.uio.no>
 <fa.mPiA9bh9SZGXd2TrS/eQjWPc9oA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000703060708060805050607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Ack,
>   
> but your patch was whitespace-damaged. Can you retry?
>   

Here's another try with it attached (Thunderbird is deciding to be a
pain unfortunately..)

---

Suspending with the cx88xx module loaded causes the system to lock up
because the cx88_audio_thread kthread was missing a try_to_freeze()
call, which caused it to go into a tight loop and result in softlockup
when suspending. Fix that.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>


--------------000703060708060805050607
Content-Type: text/plain;
 name="fix-cx88-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-cx88-suspend.patch"

--- linux-2.6.20-rc3-git4-orig/drivers/media/video/cx88/cx88-tvaudio.c	2007-01-04 19:51:45.000000000 -0600
+++ linux-2.6.20-rc3-git4/drivers/media/video/cx88/cx88-tvaudio.c	2007-01-04 19:25:19.000000000 -0600
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/errno.h>
+#include <linux/freezer.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -961,6 +962,7 @@ int cx88_audio_thread(void *data)
 		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
+		try_to_freeze();
 
 		/* just monitor the audio status for now ... */
 		memset(&t, 0, sizeof(t));


--------------000703060708060805050607--

