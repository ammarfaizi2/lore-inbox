Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbUKTBV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUKTBV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUKTBVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:21:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:48280 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263023AbUKTBRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:17:55 -0500
Date: Fri, 19 Nov 2004 17:17:51 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: domen@coderock.org
Subject: [PATCH 1/2] kernel/timer: remove msleep{,_interruptible}(); add __msleep_{sig,wq}()
Message-ID: <20041120011751.GD6181@us.ibm.com>
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

Here is the function variant of the previous patches.

Description: Remove msleep() and msleep_interruptible(). Add function
definitions for __msleep_sig() and __msleep_wq(). These functions are
the "hidden" backends to the new implementations of the msleep() class
of functions. They should avoid many of the problems with the existing
system by being clearer on what they are sleeping for.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc2-vanilla/kernel/timer.c	2004-11-19 16:12:28.000000000 -0800
+++ 2.6.10-rc2/kernel/timer.c	2004-11-19 17:13:13.000000000 -0800
@@ -1610,35 +1610,30 @@ unregister_time_interpolator(struct time
 }
 #endif /* CONFIG_TIME_INTERPOLATION */
 
-/**
- * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
+/*
+ * Sleep in state and, if check sigs, until signal received
  */
-void msleep(unsigned int msecs)
+unsigned int __msleep_sig(unsigned int msecs, long state, int check_sigs)
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+	
+	while (timeout && (check_sigs ? !signals_pending(current) : 1)) {
+		set_current_state(state);
 		timeout = schedule_timeout(timeout);
 	}
-}
 
-EXPORT_SYMBOL(msleep);
+	return jiffies_to_msecs(timeout);
+}
 
-/**
- * msleep_interruptible - sleep waiting for waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
+/*
+ * Sleep in state until schedule_timeout() returns
  */
-unsigned long msleep_interruptible(unsigned int msecs)
+unsigned int __msleep_wq(unsigned int msecs, long state)
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout && !signal_pending(current)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	}
+	
+	set_current_state(state);
+	timeout = schedule_timeout(timeout);
+	
 	return jiffies_to_msecs(timeout);
 }
-
-EXPORT_SYMBOL(msleep_interruptible);
