Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVEQXn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVEQXn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVEQXlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:41:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:38882 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262000AbVEQXhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:37:48 -0400
Date: Tue, 17 May 2005 16:37:39 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: [RFC][PATCH 3/4] convert sys_nanosleep() to use new soft-timer subsystem
Message-ID: <20050517233739.GH2735@us.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> <20050517233300.GE2735@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517233300.GE2735@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2005 [16:33:00 -0700], Nishanth Aravamudan wrote:
> On 13.05.2005 [17:16:35 -0700], john stultz wrote:
> > All,
> > 	This patch implements the architecture independent portion of the new
> > time of day subsystem. For a brief description on the rework, see here:
> > http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
> > easy to understand writeup!)
> > 
> > 	I intend this to be the last RFC release and to submit this patch to
> > Andrew for for testing near the end of this month. So please, if you
> > have any complaints, suggestions, or blocking issues, let me know.
> 
> I have been working closely with John to re-work the soft-timer subsytem
> to use the new timeofday() subsystem. The following patches attempts to
> begin this process. I would greatly appreciate any comments.

Description: Convert sys_nanosleep() to use the new timerinterval-based
soft-timer interfaces.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.12-rc4-tod-timer-a/kernel/timer.c 2.6.12-rc4-tod-timer-b/kernel/timer.c
--- 2.6.12-rc4-tod-timer-a/kernel/timer.c	2005-05-17 16:09:40.000000000 -0700
+++ 2.6.12-rc4-tod-timer-b/kernel/timer.c	2005-05-17 16:11:47.000000000 -0700
@@ -1460,21 +1460,21 @@ asmlinkage long sys_gettid(void)
 
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
+		t = ns_to_timespec(expire);
 
 		ret = -ERESTART_RESTARTBLOCK;
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
@@ -1487,7 +1487,7 @@ static long __sched nanosleep_restart(st
 asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
 {
 	struct timespec t;
-	unsigned long expire;
+	nsec_t expire;
 	long ret;
 
 	if (copy_from_user(&t, rqtp, sizeof(t)))
@@ -1496,20 +1496,20 @@ asmlinkage long sys_nanosleep(struct tim
 	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	expire = timespec_to_ns(&t);
+	set_current_state(TASK_INTERRUPTIBLE);
+	expire = schedule_timeout_nsecs(expire);
 
 	ret = 0;
 	if (expire) {
 		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
+		t = ns_to_timespec(expire);
 		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
 			return -EFAULT;
 
 		restart = &current_thread_info()->restart_block;
 		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
+		restart->arg0 = do_monotonic_clock() + expire;
 		restart->arg1 = (unsigned long) rmtp;
 		ret = -ERESTART_RESTARTBLOCK;
 	}
