Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbUKTBa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUKTBa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUKTB2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:28:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:47500 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263059AbUKTB00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:26:26 -0500
Date: Fri, 19 Nov 2004 17:26:23 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: domen@coderock.org
Subject: [PATCH 2/2] include/delay: replace msleep{,_interruptible}() with macros
Message-ID: <20041120012623.GH6181@us.ibm.com>
References: <20041117024944.GB4218@us.ibm.com> <20041120011751.GD6181@us.ibm.com> <20041120012153.GE6181@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120012153.GE6181@us.ibm.com>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 05:21:53PM -0800, Nishanth Aravamudan wrote:
> On Fri, Nov 19, 2004 at 05:17:51PM -0800, Nishanth Aravamudan wrote:
> > On Tue, Nov 16, 2004 at 06:49:44PM -0800, Nishanth Aravamudan wrote:
> > > Hi,
> > > 
> > > After some pretty heavy discussion on IRC, I felt that it may be
> > > important / useful to bring the discussion of schedule_timeout() to
> > > LKML. There are two issues being considered:
> > > 
> > > 1) msleep_interruptible()
> > > 
> > > For reference, here is the code for this function:
> > > 
> > > /**
> > >  * msleep_interruptible - sleep waiting for waitqueue interruptions
> > >  * @msecs: Time in milliseconds to sleep for
> > >  */
> > > unsigned long msleep_interruptible(unsigned int msecs)
> > > {
> > > 	unsigned long timeout = msecs_to_jiffies(msecs);
> > > 
> > > 	while (timeout && !signal_pending(current)) {
> > > 		set_current_state(TASK_INTERRUPTIBLE);
> > > 		timeout = schedule_timeout(timeout);
> > > 	}
> > > 	return jiffies_to_msecs(timeout);
> > > }
> > > 
> > > The first issue deals with whether the while() loop is at all necessary.
> > > From my understanding (primarily from how the code "should" behave, but
> > > also backed up by code itself), I think the following code:
> > > 
> > > 	set_current_state(TASK_INTERRUPTIBLE);
> > > 	timeout = schedule_timeout(timeout);
> > > 
> > > should be interpreted as:
> > > 
> > > 	a) I wish to sleep for timeout jiffies; however
> > > 	b) If a signal occurs before timeout jiffies have gone by, I
> > > 	would also like to wake up.
> > > 	
> > > With this interpretation, though, the while()-conditional becomes
> > > questionable. I can see two cases (think inclusive OR not exclusive) for
> > > schedule_timeout() returning:
> > > 
> > > 	a) A signal was received and thus signal_pending(current) will
> > > 	be true, exiting the loop. In this case, timeout will be
> > > 	some non-negative value (0 is a corner case, I believe, where
> > > 	both the timer fires and a signal is received in the last jiffy).
> > > 	b) The timer in schedule_timeout() has expired and thus it will
> > > 	return 0. This indicates the function has delayed the requested
> > > 	time (at least) and timeout will be set to 0, again exiting the
> > > 	loop.
> > > 	
> > > Clearly, then, if my interpretion is correct, schedule_timeout() will
> > > always return to a state in msleep_interruptible() which causes the loop
> > > to only iterate the one time. Does this make sense? Is my interpretation
> > > of schedule_timeout()s functioning somehow flawed? If not, we probably
> > > can go ahead and change the msleep_interruptible() code, yes?
> > 
> > Here is the function variant of the previous patches.
> 
> Here is the corresponding change to delay.h. The major difference from
> the macro version is that a flag is now passed to __msleep_sig() to
> determine whether an extra condition is necessary in the while() loop.
> 
> -Nish
> 
> Description: Add macros for various sleep functions, one for each case
> of:
> 
> Description: Remove prototypes of msleep() and msleep_interruptible() to
> prepare for the macro versions of these functions. Add prototypes for
> __msleep_wq() and __msleep_sig(). Add macros for 4 types of sleeps:
>         1) Unconditional sleep (msleep)
>         2) Sleep until signalled (msleep_interruptible)
>         3) Sleep until wait-queue event (msleep_wq)
>         4) Sleep until either signalled or wait-queue event 
> 	(msleep_wq_interruptible)
> These 4 cases are all distinct and handled separately by passing
> appropriate flags to __msleep_sig and __msleep_wq, which should *not*
> ever be called directly by kernel code.
> 					
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> 
> --- 2.6.10-rc2-vanilla/include/linux/delay.h	2004-11-19 16:11:52.000000000 -0800
> +++ 2.6.10-rc2/include/linux/delay.h	2004-11-19 17:12:47.000000000 -0800
> @@ -38,8 +38,31 @@ extern unsigned long loops_per_jiffy;
>  #define ndelay(x)	udelay(((x)+999)/1000)
>  #endif
>  
> -void msleep(unsigned int msecs);
> -unsigned long msleep_interruptible(unsigned int msecs);
> +unsigned int __msleep_sig(unsigned int msecs, long state, int check_sigs);
> +unsigned int __msleep_wq(unsigned int msecs, long state);
> +
> +/*
> + * Sleep until at least msecs ms have elapsed
> + */ 
> +#define msleep(msecs) (void)__msleep_sig(msecs, TASK_UNINTERRUPTIBLE, 0)
> +
> +/*
> + * Sleep until at least msecs ms have elapsed or a signal is received
> + */
> +#define msleep_interruptible(msecs)		\
> +	__msleep_sig(msecs, TASK_INTERRUPTIBLE, 1))
> +
> +/*
> + * Sleep until at least msecs ms have elapsed or a wait-queue event occurs
> + */
> +#define msleep_wq(msecs) __msleep_wq_state(msecs, TASK_UNINTERRUPTIBLE)
> +
> +/*
> + * Sleep until at least msecs ms have elapsed or a wait-queue event occurs
> + * or a signal is received
> + */
> +#define msleep_wq_interruptible(msecs)		\
> +	__msleep_wq_state(msecs, TASK_INTERRUPTIBLE);

A stupid typo...

Description: Remove prototypes of msleep() and msleep_interruptible() to
prepare for the macro versions of these functions. Add prototypes for
__msleep_wq() and __msleep_sig(). Add macros for 4 types of sleeps:
        1) Unconditional sleep (msleep)
        2) Sleep until signalled (msleep_interruptible)
        3) Sleep until wait-queue event (msleep_wq)
        4) Sleep until either signalled or wait-queue event 
	(msleep_wq_interruptible)
These 4 cases are all distinct and handled separately by passing
appropriate flags to __msleep_sig and __msleep_wq, which should *not*
ever be called directly by kernel code.
 
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc2-vanilla/include/linux/delay.h	2004-11-19 16:11:52.000000000 -0800
+++ 2.6.10-rc2/include/linux/delay.h	2004-11-19 17:12:47.000000000 -0800
@@ -38,8 +38,31 @@ extern unsigned long loops_per_jiffy;
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
-void msleep(unsigned int msecs);
-unsigned long msleep_interruptible(unsigned int msecs);
+unsigned int __msleep_sig(unsigned int msecs, long state, int check_sigs);
+unsigned int __msleep_wq(unsigned int msecs, long state);
+
+/*
+ * Sleep until at least msecs ms have elapsed
+ */ 
+#define msleep(msecs) (void)__msleep_sig(msecs, TASK_UNINTERRUPTIBLE, 0)
+
+/*
+ * Sleep until at least msecs ms have elapsed or a signal is received
+ */
+#define msleep_interruptible(msecs)		\
+	__msleep_sig(msecs, TASK_INTERRUPTIBLE, 1))
+
+/*
+ * Sleep until at least msecs ms have elapsed or a wait-queue event occurs
+ */
+#define msleep_wq(msecs) __msleep_wq_state(msecs, TASK_UNINTERRUPTIBLE)
+
+/*
+ * Sleep until at least msecs ms have elapsed or a wait-queue event occurs
+ * or a signal is received
+ */
+#define msleep_wq_interruptible(msecs)		\
+	__msleep_wq_state(msecs, TASK_INTERRUPTIBLE)
 
 static inline void ssleep(unsigned int seconds)
 {
