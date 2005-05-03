Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVECVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVECVrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVECVrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:47:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42661 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261821AbVECVrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:47:12 -0400
Date: Tue, 3 May 2005 14:47:07 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] new timeofday-based soft-timer subsystem
Message-ID: <20050503214707.GE3372@us.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com> <20050429233546.GB2664@us.ibm.com> <20050503170224.GA2776@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503170224.GA2776@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc3-mm2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.2005 [10:02:24 -0700], Nishanth Aravamudan wrote:
> On 29.04.2005 [16:35:46 -0700], Nishanth Aravamudan wrote:
> > * john stultz <johnstul@us.ibm.com> [2005-0429 15:45:47 -0700]:
> > 
> > > All,
> > >         This patch implements the architecture independent portion of
> > > the time of day subsystem. For a brief description on the rework, see
> > > here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
> > > that clear writeup!)
> > 
> > I have been working closely with John to re-work the soft-timer subsytem
> > to use the new timeofday() subsystem. The following patch attempts to
> > being this process. I would greatly appreciate any comments.
> 
> I am not sure if anyone has looked at this patch closely, but I have
> noticed one issue: My code assumes that all the rounding will be done
> internally (rounding up on addition to find to the nearest
> timerinterval); however, current interfaces do much of the rounding
> before passing on structures on to the soft-timer subsystem, because the
> jiffies-based one always rounds down.

A for instance: sys_nanosleep() assumes (correctly) that the
jiffies-based soft-timer subsystem rounds down, so it rounds up (twice).
But since I now round-up internally, that is not necessary. Fix
sys_nanosleep() to do this right.

Still todo: change restart->arg0 to be a pointer to an nsec_t.

diff -urpN 2.6.12-rc2-tod/kernel/timer.c 2.6.12-rc2-tod-timer/kernel/timer.c
--- 2.6.12-rc2-tod/kernel/timer.c	2005-05-02 12:59:04.000000000 -0700
+++ 2.6.12-rc2-tod-timer/kernel/timer.c	2005-05-03 09:13:43.000000000 -0700
@@ -1141,21 +1311,21 @@ asmlinkage long sys_gettid(void)
 
 static long __sched nanosleep_restart(struct restart_block *restart)
 {
-	unsigned long expire = restart->arg0, now = jiffies;
+	nsec_t expire = restart->arg0, now = do_monotonic_clock();
 	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
 	long ret;
 
 	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
+	if (now > expire)
 		return 0;
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire - now);
+	set_current_state(TASK_INTERRUPTIBLE);
+	expire = schedule_timeout_nsecs(expire - now);
 
 	ret = 0;
 	if (expire) {
 		struct timespec t;
-		jiffies_to_timespec(expire, &t);
+		t = ns2timespec(expire);
 
 		ret = -ERESTART_RESTARTBLOCK;
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
@@ -1168,7 +1338,7 @@ static long __sched nanosleep_restart(st
 asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
 {
 	struct timespec t;
-	unsigned long expire;
+	nsec_t expire;
 	long ret;
 
 	if (copy_from_user(&t, rqtp, sizeof(t)))
@@ -1177,20 +1347,20 @@ asmlinkage long sys_nanosleep(struct tim
 	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	expire = timespec2ns(&t);
+	set_current_state(TASK_INTERRUPTIBLE);
+	expire = schedule_timeout_nsecs(expire);
 
 	ret = 0;
 	if (expire) {
 		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
+		t = ns2timespec(expire);
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
 			return -EFAULT;
 
 		restart = &current_thread_info()->restart_block;
 		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
+		restart->arg0 = do_monotonic_clock() + expire;
 		restart->arg1 = (unsigned long) rmtp;
 		ret = -ERESTART_RESTARTBLOCK;
 	}


