Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUKTAxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUKTAxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUKTAwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:52:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1257 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261793AbUKTAso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:48:44 -0500
Date: Fri, 19 Nov 2004 16:48:41 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: domen@coderock.org
Subject: [PATCH 1/2] kernel/timer.c: remove msleep() and msleep_interruptible()
Message-ID: <20041120004840.GA7466@us.ibm.com>
References: <20041117024944.GB4218@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117024944.GB4218@us.ibm.com>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 06:49:44PM -0800, Nishanth Aravamudan wrote:
> Hi,
> 
> After some pretty heavy discussion on IRC, I felt that it may be
> important / useful to bring the discussion of schedule_timeout() to
> LKML. There are two issues being considered:
> 
> 1) msleep_interruptible()
> 
> For reference, here is the code for this function:
> 
> /**
>  * msleep_interruptible - sleep waiting for waitqueue interruptions
>  * @msecs: Time in milliseconds to sleep for
>  */
> unsigned long msleep_interruptible(unsigned int msecs)
> {
> 	unsigned long timeout = msecs_to_jiffies(msecs);
> 
> 	while (timeout && !signal_pending(current)) {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		timeout = schedule_timeout(timeout);
> 	}
> 	return jiffies_to_msecs(timeout);
> }
> 
> The first issue deals with whether the while() loop is at all necessary.
> From my understanding (primarily from how the code "should" behave, but
> also backed up by code itself), I think the following code:
> 
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	timeout = schedule_timeout(timeout);
> 
> should be interpreted as:
> 
> 	a) I wish to sleep for timeout jiffies; however
> 	b) If a signal occurs before timeout jiffies have gone by, I
> 	would also like to wake up.
> 	
> With this interpretation, though, the while()-conditional becomes
> questionable. I can see two cases (think inclusive OR not exclusive) for
> schedule_timeout() returning:
> 
> 	a) A signal was received and thus signal_pending(current) will
> 	be true, exiting the loop. In this case, timeout will be
> 	some non-negative value (0 is a corner case, I believe, where
> 	both the timer fires and a signal is received in the last jiffy).
> 	b) The timer in schedule_timeout() has expired and thus it will
> 	return 0. This indicates the function has delayed the requested
> 	time (at least) and timeout will be set to 0, again exiting the
> 	loop.
> 	
> Clearly, then, if my interpretion is correct, schedule_timeout() will
> always return to a state in msleep_interruptible() which causes the loop
> to only iterate the one time. Does this make sense? Is my interpretation
> of schedule_timeout()s functioning somehow flawed? If not, we probably
> can go ahead and change the msleep_interruptible() code, yes?

Ok, since nobody seems to have objected to my ideas as of yet, I went
ahead and implemented them, with much help from Domen and others. I
believe there are two options for these changes. One involves using
macros instead, the other involves reworking the functions.

I have attached here the version with macros (1/2). I am sure there will be
much to correct, so please do so.

Also, I will hopefully submit soon a change to a driver that uses this
new msleep*() interface, so as to show how it should work.

-Nish

Description: Removes definitions of msleep() and msleep_interruptible()
from kernel/timer.c in preparation for their re-creation as macros in
include/linux/delay.h. There are significant issues with the current
implementation of msleep_interruptible(). Primarily, the comments given
do not reflect the actual results. The function, in fact, ignores
wait-queue events and only will respond to signals. The new versions of
these functions will correct and clarify this.


--- 2.6.10-rc2-vanilla/kernel/timer.c	2004-11-19 16:12:28.000000000 -0800
+++ 2.6.10-rc2/kernel/timer.c	2004-11-19 16:47:47.000000000 -0800
@@ -1609,36 +1609,3 @@ unregister_time_interpolator(struct time
 	spin_unlock(&time_interpolator_lock);
 }
 #endif /* CONFIG_TIME_INTERPOLATION */
-
-/**
- * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
- */
-void msleep(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	}
-}
-
-EXPORT_SYMBOL(msleep);
-
-/**
- * msleep_interruptible - sleep waiting for waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
- */
-unsigned long msleep_interruptible(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout && !signal_pending(current)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	}
-	return jiffies_to_msecs(timeout);
-}
-
-EXPORT_SYMBOL(msleep_interruptible);
