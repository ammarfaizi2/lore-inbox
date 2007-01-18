Return-Path: <linux-kernel-owner+w=401wt.eu-S1751081AbXARA3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXARA3H (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXARA3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:29:06 -0500
Received: from h155.mvista.com ([63.81.120.158]:6483 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbXARA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:29:05 -0500
Message-Id: <20070118002503.418478415@mvista.com>
User-Agent: quilt/0.46.mv-1
Date: Wed, 17 Jan 2007 16:25:03 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: tglx@linutronix.de
CC: khilman@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] futex null pointer timeout
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix is mostly from Thomas .. 

The problem was that a futex can be called with a zero timeout (0 seconds,
0 nanoseconds) and it's a valid expired timeout. However, the current futex
in -rt assumes a zero timeout is an infinite timeout. 

Kevin Hilman found this using LTP's nptl01 test case which would
soft hang occasionally. 

The patch reworks do_futex, and futex_wait* so a NULL pointer in the timeout
position is infinite, and anything else is evaluated as a real timeout.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/futex.c        |   14 ++++++++------
 kernel/futex_compat.c |    5 +++--
 2 files changed, 11 insertions(+), 8 deletions(-)

Index: linux-2.6.19/kernel/futex.c
===================================================================
--- linux-2.6.19.orig/kernel/futex.c
+++ linux-2.6.19/kernel/futex.c
@@ -1466,7 +1466,7 @@ static int futex_wait(u32 __user *uaddr,
 
 		current->flags &= ~PF_NOSCHED;
 
-		if (time->tv_sec == 0 && time->tv_nsec == 0)
+		if (!time)
 			schedule();
 		else {
 			to = &t;
@@ -3070,7 +3070,7 @@ static int futex_wait64(u64 __user *uadd
 
 		current->flags &= ~PF_NOSCHED;
 
-		if (time->tv_sec == 0 && time->tv_nsec == 0)
+		if (!time)
 			schedule();
 		else {
 			to = &t;
@@ -3560,7 +3560,7 @@ asmlinkage long
 sys_futex64(u64 __user *uaddr, int op, u64 val,
 	    struct timespec __user *utime, u64 __user *uaddr2, u64 val3)
 {
-	struct timespec t = {.tv_sec=0, .tv_nsec=0};
+	struct timespec t, *tp = NULL;
 	u64 val2 = 0;
 
 	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
@@ -3568,6 +3568,7 @@ sys_futex64(u64 __user *uaddr, int op, u
 			return -EFAULT;
 		if (!timespec_valid(&t))
 			return -EINVAL;
+		tp = &t;
 	}
 	/*
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
@@ -3576,7 +3577,7 @@ sys_futex64(u64 __user *uaddr, int op, u
 	    || op == FUTEX_CMP_REQUEUE_PI)
 		val2 = (unsigned long) utime;
 
-	return do_futex64(uaddr, op, val, &t, uaddr2, val2, val3);
+	return do_futex64(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
 #endif
@@ -3585,7 +3586,7 @@ asmlinkage long sys_futex(u32 __user *ua
 			  struct timespec __user *utime, u32 __user *uaddr2,
 			  u32 val3)
 {
-	struct timespec t = {.tv_sec=0, .tv_nsec=0};
+	struct timespec t, *tp = NULL;
 	u32 val2 = 0;
 
 	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
@@ -3593,6 +3594,7 @@ asmlinkage long sys_futex(u32 __user *ua
 			return -EFAULT;
 		if (!timespec_valid(&t))
 			return -EINVAL;
+		tp = &t;
 	}
 	/*
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
@@ -3601,7 +3603,7 @@ asmlinkage long sys_futex(u32 __user *ua
 	    || op == FUTEX_CMP_REQUEUE_PI)
 		val2 = (u32) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
 static int futexfs_get_sb(struct file_system_type *fs_type,
Index: linux-2.6.19/kernel/futex_compat.c
===================================================================
--- linux-2.6.19.orig/kernel/futex_compat.c
+++ linux-2.6.19/kernel/futex_compat.c
@@ -141,7 +141,7 @@ asmlinkage long compat_sys_futex(u32 __u
 		struct compat_timespec __user *utime, u32 __user *uaddr2,
 		u32 val3)
 {
-	struct timespec t = {.tv_sec = 0, .tv_nsec = 0};
+	struct timespec t, *tp = NULL;
 	int val2 = 0;
 
 	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
@@ -149,10 +149,11 @@ asmlinkage long compat_sys_futex(u32 __u
 			return -EFAULT;
 		if (!timespec_valid(&t))
 			return -EINVAL;
+		tp = &t;
 	}
 	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE
 	    || op == FUTEX_CMP_REQUEUE_PI)
 		val2 = (int) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
-- 
