Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUKTBDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUKTBDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUKTBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:01:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13240 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262820AbUKTA4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:56:08 -0500
Date: Fri, 19 Nov 2004 16:56:01 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: domen@coderock.org
Subject: [PATCH 2/2] include/delay.h: replace msleep() and msleep_interruptible() with macros
Message-ID: <20041120005601.GB7466@us.ibm.com>
References: <20041117024944.GB4218@us.ibm.com> <20041120004840.GA7466@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120004840.GA7466@us.ibm.com>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 04:48:41PM -0800, Nishanth Aravamudan wrote:
> On Tue, Nov 16, 2004 at 06:49:44PM -0800, Nishanth Aravamudan wrote:
> > Hi,
> > 
> > After some pretty heavy discussion on IRC, I felt that it may be
> > important / useful to bring the discussion of schedule_timeout() to
> > LKML. There are two issues being considered:
> > 
> > 1) msleep_interruptible()
> > 
> > For reference, here is the code for this function:
> > 
> > /**
> >  * msleep_interruptible - sleep waiting for waitqueue interruptions
> >  * @msecs: Time in milliseconds to sleep for
> >  */
> > unsigned long msleep_interruptible(unsigned int msecs)
> > {
> > 	unsigned long timeout = msecs_to_jiffies(msecs);
> > 
> > 	while (timeout && !signal_pending(current)) {
> > 		set_current_state(TASK_INTERRUPTIBLE);
> > 		timeout = schedule_timeout(timeout);
> > 	}
> > 	return jiffies_to_msecs(timeout);
> > }
> > 
> > The first issue deals with whether the while() loop is at all necessary.
> > From my understanding (primarily from how the code "should" behave, but
> > also backed up by code itself), I think the following code:
> > 
> > 	set_current_state(TASK_INTERRUPTIBLE);
> > 	timeout = schedule_timeout(timeout);
> > 
> > should be interpreted as:
> > 
> > 	a) I wish to sleep for timeout jiffies; however
> > 	b) If a signal occurs before timeout jiffies have gone by, I
> > 	would also like to wake up.
> > 	
> > With this interpretation, though, the while()-conditional becomes
> > questionable. I can see two cases (think inclusive OR not exclusive) for
> > schedule_timeout() returning:
> > 
> > 	a) A signal was received and thus signal_pending(current) will
> > 	be true, exiting the loop. In this case, timeout will be
> > 	some non-negative value (0 is a corner case, I believe, where
> > 	both the timer fires and a signal is received in the last jiffy).
> > 	b) The timer in schedule_timeout() has expired and thus it will
> > 	return 0. This indicates the function has delayed the requested
> > 	time (at least) and timeout will be set to 0, again exiting the
> > 	loop.
> > 	
> > Clearly, then, if my interpretion is correct, schedule_timeout() will
> > always return to a state in msleep_interruptible() which causes the loop
> > to only iterate the one time. Does this make sense? Is my interpretation
> > of schedule_timeout()s functioning somehow flawed? If not, we probably
> > can go ahead and change the msleep_interruptible() code, yes?
> 
> Ok, since nobody seems to have objected to my ideas as of yet, I went
> ahead and implemented them, with much help from Domen and others. I
> believe there are two options for these changes. One involves using
> macros instead, the other involves reworking the functions.

Here is patch 2/2, which modifies include/linux/delay.h to contain the
appropriate macros. Much consideration was given the various names and
calling syntax, but corrections/requests/changes are welcome.

-Nish

Description: Remove prototypes of msleep() and msleep_interruptible() to
prepare for the macro versions of these functions. Add macros for 4
types of sleeps:
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
+++ 2.6.10-rc2/include/linux/delay.h	2004-11-19 16:52:40.000000000 -0800
@@ -38,8 +38,56 @@ extern unsigned long loops_per_jiffy;
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
-void msleep(unsigned int msecs);
-unsigned long msleep_interruptible(unsigned int msecs);
+/*
+ * Sleep in state while condition is true
+ */
+#define __msleep_sig(unsigned int msecs, long state, int condition)	\
+	do {								\
+		unsigned long timeout = msecs_to_jiffies(msecs) + 1;	\
+									\
+		while (timeout && condition) {				\
+ 			set_current_state(state);			\
+			timeout = schedule_timeout(timeout);		\
+		}							\
+									\
+		return jiffies_to_msecs(timeout);			\
+	} while(0)
+
+/*
+ * Sleep in state until schedule_timeout() returns
+ */
+#define __msleep_wq(unsigned int msecs, long state)			\
+	do {								\
+		unsigned long timeout = msecs_to_jiffies(msecs) + 1;	\
+									\
+		set_current_state(condition);				\
+		timeout = schedule_timeout(timeout);			\
+									\
+		return jiffies_to_msecs(timeout);			\
+	} while(0)
+
+/*
+ * Sleep until at least msecs ms have elapsed
+ */ 
+#define msleep(msecs) (void)__msleep_sig(msecs, TASK_UNINTERRUPTIBLE, 1)
+
+/*
+ * Sleep until at least msecs ms have elapsed or a signal is received
+ */
+#define msleep_interruptible(msecs)		\
+	__msleep_sig(msecs, TASK_INTERRUPTIBLE, !signals_pending(current))
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
+	__msleep_wq_state(msecs, TASK_INTERRUPTIBLE);
 
 static inline void ssleep(unsigned int seconds)
 {
