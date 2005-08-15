Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVHOSJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVHOSJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVHOSJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:09:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32188 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964877AbVHOSJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:09:08 -0400
Date: Mon, 15 Aug 2005 11:08:40 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 3/32] kernel: fix-up schedule_timeout() usage
Message-ID: <20050815180840.GF2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_{,un}interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 kernel/compat.c |    9 +++------
 kernel/signal.c |    3 +--
 kernel/timer.c  |   18 ++++++------------
 3 files changed, 10 insertions(+), 20 deletions(-)


diff -urpN 2.6.13-rc5-mm1/kernel/compat.c 2.6.13-rc5-mm1-dev/kernel/compat.c
--- 2.6.13-rc5-mm1/kernel/compat.c	2005-08-07 09:57:38.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/kernel/compat.c	2005-08-10 15:21:46.000000000 -0700
@@ -48,8 +48,7 @@ static long compat_nanosleep_restart(str
 	if (!time_after(expire, now))
 		return 0;
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire - now);
+	expire = schedule_timeout_interruptible(expire - now);
 	if (expire == 0)
 		return 0;
 
@@ -82,8 +81,7 @@ asmlinkage long compat_sys_nanosleep(str
 		return -EINVAL;
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	expire = schedule_timeout_interruptible(expire);
 	if (expire == 0)
 		return 0;
 
@@ -795,8 +793,7 @@ compat_sys_rt_sigtimedwait (compat_sigse
 			recalc_sigpending();
 			spin_unlock_irq(&current->sighand->siglock);
 
-			current->state = TASK_INTERRUPTIBLE;
-			timeout = schedule_timeout(timeout);
+			timeout = schedule_timeout_interruptible(timeout);
 
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &s, &info);
diff -urpN 2.6.13-rc5-mm1/kernel/signal.c 2.6.13-rc5-mm1-dev/kernel/signal.c
--- 2.6.13-rc5-mm1/kernel/signal.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/kernel/signal.c	2005-08-10 15:22:29.000000000 -0700
@@ -2228,8 +2228,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 			recalc_sigpending();
 			spin_unlock_irq(&current->sighand->siglock);
 
-			current->state = TASK_INTERRUPTIBLE;
-			timeout = schedule_timeout(timeout);
+			timeout = schedule_timeout_interruptible(timeout);
 
 			try_to_freeze();
 			spin_lock_irq(&current->sighand->siglock);
diff -urpN 2.6.13-rc5-mm1/kernel/timer.c 2.6.13-rc5-mm1-dev/kernel/timer.c
--- 2.6.13-rc5-mm1/kernel/timer.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/kernel/timer.c	2005-08-10 15:23:18.000000000 -0700
@@ -1199,8 +1199,7 @@ static long __sched nanosleep_restart(st
 	if (!time_after(expire, now))
 		return 0;
 
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire - now);
+	expire = schedule_timeout_interruptible(expire - now);
 
 	ret = 0;
 	if (expire) {
@@ -1228,8 +1227,7 @@ asmlinkage long sys_nanosleep(struct tim
 		return -EINVAL;
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	expire = schedule_timeout_interruptible(expire);
 
 	ret = 0;
 	if (expire) {
@@ -1627,10 +1625,8 @@ void msleep(unsigned int msecs)
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
-	while (timeout) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	}
+	while (timeout)
+		timeout = schedule_timeout_uninterruptible(timeout);
 }
 
 EXPORT_SYMBOL(msleep);
@@ -1643,10 +1639,8 @@ unsigned long msleep_interruptible(unsig
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
-	while (timeout && !signal_pending(current)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	}
+	while (timeout && !signal_pending(current))
+		timeout = schedule_timeout_interruptible(timeout);
 	return jiffies_to_msecs(timeout);
 }
 
