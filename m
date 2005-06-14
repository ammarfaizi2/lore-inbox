Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFNDvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFNDvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFNDvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:51:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50343 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261467AbVFNDt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:49:29 -0400
Date: Mon, 13 Jun 2005 20:49:16 -0700
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
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: [PATCH 2/4] 
Message-ID: <20050614034916.GC4180@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com> <20050614034655.GA4180@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614034655.GA4180@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2005 [20:46:55 -0700], Nishanth Aravamudan wrote:
> On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
> 
> Here is an update of my soft-timer rework to John's latest patches. I
> have made some major changes in this revision. I would still greatly
> appreciate any comments.

Description: Convert sys_nanosleep() to use the new timerinterval-based
soft-timer interfaces.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.12-rc6-tod-timer-base/kernel/timer.c 2.6.12-rc6-tod-timer-dev/kernel/timer.c
--- 2.6.12-rc6-tod-timer-base/kernel/timer.c	2005-06-13 19:47:40.000000000 -0700
+++ 2.6.12-rc6-tod-timer-dev/kernel/timer.c	2005-06-13 19:48:53.000000000 -0700
@@ -1484,21 +1484,21 @@ asmlinkage long sys_gettid(void)
 
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
@@ -1511,7 +1511,7 @@ static long __sched nanosleep_restart(st
 asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
 {
 	struct timespec t;
-	unsigned long expire;
+	nsec_t expire;
 	long ret;
 
 	if (copy_from_user(&t, rqtp, sizeof(t)))
@@ -1520,20 +1520,20 @@ asmlinkage long sys_nanosleep(struct tim
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
