Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbSLMBVy>; Thu, 12 Dec 2002 20:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbSLMBVx>; Thu, 12 Dec 2002 20:21:53 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:56202 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267579AbSLMBVu>;
	Thu, 12 Dec 2002 20:21:50 -0500
Date: Fri, 13 Dec 2002 12:29:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: jim.houston@attbi.com
Cc: md@Linux.IT, julie.n.fleischer@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5.51 nanosleep fails
Message-Id: <20021213122904.5e3208bf.sfr@canb.auug.org.au>
In-Reply-To: <200212122227.gBCMRkT10652@linux.local>
References: <200212122227.gBCMRkT10652@linux.local>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Thu, 12 Dec 2002 17:27:46 -0500 Jim Houston <jim.houston@attbi.com> wrote:
>
> The problem is that nanosleep didn't check for the NULL pointer
> case and always tries to copy out the remaining time.  The attached
> patch will fix this problem.

Equivalent fix for the compatibility layer ...

Not compiled, not tested (I need to get a 64 bit machine ...)

Obviously correct (hopefully) :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51/kernel/compat.c 2.5.51-ns/kernel/compat.c
--- 2.5.51/kernel/compat.c	2002-12-10 15:10:41.000000000 +1100
+++ 2.5.51-ns/kernel/compat.c	2002-12-13 12:12:00.000000000 +1100
@@ -21,8 +21,7 @@
 static long compat_nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
-	struct timespec *rmtp = (struct timespec *) restart->arg1;
-	long ret;
+	struct compat_timespec *rmtp;
 
 	/* Did it expire while we handled signals? */
 	if (!time_after(expire, now))
@@ -30,22 +29,22 @@
 
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire - now);
+	if (expire == 0)
+		return 0;
 
-	ret = 0;
-	if (expire) {
+	rmtp = (struct compat_timespec *)restart->arg1;
+	if (rmtp) {
 		struct compat_timespec ct;
 		struct timespec t;
 
 		jiffies_to_timespec(expire, &t);
 		ct.tv_sec = t.tv_sec;
 		ct.tv_nsec = t.tv_nsec;
-
-		ret = -ERESTART_RESTARTBLOCK;
 		if (copy_to_user(rmtp, &ct, sizeof(ct)))
-			ret = -EFAULT;
-		/* The 'restart' block is already filled in */
+			return -EFAULT;
 	}
-	return ret;
+	/* The 'restart' block is already filled in */
+	return -ERESTART_RESTARTBLOCK;
 }
 
 asmlinkage long compat_sys_nanosleep(struct compat_timespec *rqtp,
@@ -53,8 +52,8 @@
 {
 	struct compat_timespec ct;
 	struct timespec t;
+	struct restart_block *restart;
 	unsigned long expire;
-	s32 ret;
 
 	if (copy_from_user(&ct, rqtp, sizeof(ct)))
 		return -EFAULT;
@@ -67,25 +66,21 @@
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
+	if (expire == 0)
+		return 0;
 
-	ret = 0;
-	if (expire) {
-		struct restart_block *restart;
-
+	if (rmtp) {
 		jiffies_to_timespec(expire, &t);
 		ct.tv_sec = t.tv_sec;
 		ct.tv_nsec = t.tv_nsec;
-
 		if (copy_to_user(rmtp, &ct, sizeof(ct)))
 			return -EFAULT;
-
-		restart = &current_thread_info()->restart_block;
-		restart->fn = compat_nanosleep_restart;
-		restart->arg0 = jiffies + expire;
-		restart->arg1 = (unsigned long) rmtp;
-		ret = -ERESTART_RESTARTBLOCK;
 	}
-	return ret;
+	restart = &current_thread_info()->restart_block;
+	restart->fn = compat_nanosleep_restart;
+	restart->arg0 = jiffies + expire;
+	restart->arg1 = (unsigned long) rmtp;
+	return -ERESTART_RESTARTBLOCK;
 }
 
 /*
