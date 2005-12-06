Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVLFAjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVLFAjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVLFAfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34766
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751542AbVLFAek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:40 -0500
Message-Id: <20051206000155.483516000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:45 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 19/21] Switch sys_nanosleep to hrtimer
Content-Disposition: inline; filename=hrtimer-convert-sys-nanosleep.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- convert sys_nanosleep() to use hrtimer_nanosleep()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/hrtimer.c |   14 +++++++++++++
 kernel/timer.c   |   56 -------------------------------------------------------
 2 files changed, 14 insertions(+), 56 deletions(-)

Index: linux-2.6.15-rc5/kernel/timer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/timer.c
+++ linux-2.6.15-rc5/kernel/timer.c
@@ -1119,62 +1119,6 @@ asmlinkage long sys_gettid(void)
 	return current->pid;
 }
 
-static long __sched nanosleep_restart(struct restart_block *restart)
-{
-	unsigned long expire = restart->arg0, now = jiffies;
-	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
-	long ret;
-
-	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
-		return 0;
-
-	expire = schedule_timeout_interruptible(expire - now);
-
-	ret = 0;
-	if (expire) {
-		struct timespec t;
-		jiffies_to_timespec(expire, &t);
-
-		ret = -ERESTART_RESTARTBLOCK;
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			ret = -EFAULT;
-		/* The 'restart' block is already filled in */
-	}
-	return ret;
-}
-
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
-{
-	struct timespec t;
-	unsigned long expire;
-	long ret;
-
-	if (copy_from_user(&t, rqtp, sizeof(t)))
-		return -EFAULT;
-
-	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
-		return -EINVAL;
-
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	expire = schedule_timeout_interruptible(expire);
-
-	ret = 0;
-	if (expire) {
-		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			return -EFAULT;
-
-		restart = &current_thread_info()->restart_block;
-		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
-		restart->arg1 = (unsigned long) rmtp;
-		ret = -ERESTART_RESTARTBLOCK;
-	}
-	return ret;
-}
-
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
Index: linux-2.6.15-rc5/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/hrtimer.c
+++ linux-2.6.15-rc5/kernel/hrtimer.c
@@ -707,6 +707,20 @@ long hrtimer_nanosleep(struct timespec *
 	return -ERESTART_RESTARTBLOCK;
 }
 
+asmlinkage long
+sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
+{
+	struct timespec tu;
+
+	if (copy_from_user(&tu, rqtp, sizeof(tu)))
+		return -EFAULT;
+
+	if (!timespec_valid(&tu))
+		return -EINVAL;
+
+	return hrtimer_nanosleep(&tu, rmtp, HRTIMER_REL, CLOCK_MONOTONIC);
+}
+
 /*
  * Functions related to boot-time initialization:
  */

--

