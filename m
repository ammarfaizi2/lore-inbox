Return-Path: <linux-kernel-owner+w=401wt.eu-S1030264AbXAECOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbXAECOg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbXAECOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:14:36 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33785 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030264AbXAECOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:14:36 -0500
Date: Thu, 04 Jan 2007 20:12:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH] cx88xx: Fix lockup on suspend
To: linux-kernel <linux-kernel@vger.kernel.org>, mchehab@infradead.org,
       v4l-dvb-maintainer@linuxtv.org
Message-id: <459DB421.4040408@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspending with the cx88xx module loaded causes the system to lock up 
because the cx88_audio_thread kthread was missing a try_to_freeze() 
call, which caused it to go into a tight loop and result in softlockup 
when suspending. Fix that.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

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



