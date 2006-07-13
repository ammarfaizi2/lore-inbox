Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWGMIyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWGMIyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWGMIyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:54:40 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:6638 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751508AbWGMIyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:54:40 -0400
Mime-Version: 1.0 (Apple Message framework v624)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <722c432be3ba8eca595fb03cb78b2815@cl.cam.ac.uk>
Content-Type: multipart/mixed; boundary=Apple-Mail-7-527502685
Cc: schwidefsky@de.ibm.com, Zachary Amsden <zach@vmware.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: [PATCH] next_timer_interrupt: simpler overflow handling
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Date: Thu, 13 Jul 2006 09:54:38 +0100
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-7-527502685
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Having seen the patch applied to 2.6.17 to fix the overflowing 
comparison in next_timer_interrupt() it occurred to me that a much 
simpler fix is to not set hr_expires to MAX_JIFFY_OFFSET. It's way 
further out from jiffies than necessary, which is why it's caused 
problems. I instead propose that we initialise it to LONG_MAX>>1, just 
as we already do for the non-hr expires variable. This will allow safe 
comparison with any timer value in the range jiffies+/-(LONG_MAX>>1) 
which is plenty of range around jiffies (+/- 12 days if HZ=1000 and 
long is 32 bits).

The advantages are simpler code, and uniform initialisation of expires 
and hr_expires variables.

  -- Keir

Replace a fix for a comparison overflow in next_timer_interrupt() with 
a simpler alternative. We can be sure that the interesting range of 
timer values around jiffies is safe to compare with 
jiffies+(LONG_MAX>>1), unlike jiffies+MAX_JIFFY_OFFSET.

Signed-off-by: Keir Fraser <keir@xensource.com>


--Apple-Mail-7-527502685
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="fix-next-timer-interrupt.patch"
Content-Disposition: attachment;
	filename=fix-next-timer-interrupt.patch

diff -urp linux-2.6.18-rc1-git4/kernel/timer.c linux-2.6.18-rc1-git4-new/kernel/timer.c
--- linux-2.6.18-rc1-git4/kernel/timer.c	2006-07-12 11:24:21.287626294 +0100
+++ linux-2.6.18-rc1-git4-new/kernel/timer.c	2006-07-12 11:40:30.327700658 +0100
@@ -471,7 +471,7 @@ unsigned long next_timer_interrupt(void)
 	struct list_head *list;
 	struct timer_list *nte;
 	unsigned long expires;
-	unsigned long hr_expires = MAX_JIFFY_OFFSET;
+	unsigned long hr_expires = LONG_MAX >> 1;
 	ktime_t hr_delta;
 	tvec_t *varray[4];
 	int i, j;
@@ -537,22 +537,6 @@ found:
 	}
 	spin_unlock(&base->lock);
 
-	/*
-	 * It can happen that other CPUs service timer IRQs and increment
-	 * jiffies, but we have not yet got a local timer tick to process
-	 * the timer wheels.  In that case, the expiry time can be before
-	 * jiffies, but since the high-resolution timer here is relative to
-	 * jiffies, the default expression when high-resolution timers are
-	 * not active,
-	 *
-	 *   time_before(MAX_JIFFY_OFFSET + jiffies, expires)
-	 *
-	 * would falsely evaluate to true.  If that is the case, just
-	 * return jiffies so that we can immediately fire the local timer
-	 */
-	if (time_before(expires, jiffies))
-		return jiffies;
-
 	if (time_before(hr_expires, expires))
 		return hr_expires;
 

--Apple-Mail-7-527502685--

