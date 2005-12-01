Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVLAAIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVLAAIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVK3X6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:09 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56738
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751304AbVK3X6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:04 -0500
Subject: [patch 20/43] Convert sys_nanosleep to ktimer_nanosleep
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:36 +0100
Message-Id: <1133395416.32542.463.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-convert-sys-nanosleep.patch)
- convert sys_nanosleep() to use ktimer_nanosleep()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/ktimer.c |   14 ++++++++++++++
 kernel/timer.c  |   56 --------------------------------------------------------
 2 files changed, 14 insertions(+), 56 deletions(-)

Index: linux-2.6.15-rc2-rework/kernel/ktimer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/ktimer.c
+++ linux-2.6.15-rc2-rework/kernel/ktimer.c
@@ -969,6 +969,20 @@ long ktimer_nanosleep_real(struct timesp
 				nanosleep_restart_real);
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
+	return ktimer_nanosleep(&tu, rmtp, KTIMER_REL);
+}
+
 /*
  * Functions related to boot-time initialization:
  */
Index: linux-2.6.15-rc2-rework/kernel/timer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/timer.c
+++ linux-2.6.15-rc2-rework/kernel/timer.c
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

--

