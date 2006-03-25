Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCYM4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCYM4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCYM4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:56:55 -0500
Received: from www.osadl.org ([213.239.205.134]:24797 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751378AbWCYM4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:56:54 -0500
Subject: [PATCH] Check and validate futex timeval
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 13:57:38 +0100
Message-Id: <1143291458.5344.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The futex timeval is not checked for correctness. The change does not
break existing applications as the timeval is supplied by glibc (and
glibc always passes a correct value), but the glibc-internal tests for
this functionality fail.

Signed-off-by: Thomas Gleixner <tglx@tglx.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/futex.c        |    4 +++-
 kernel/futex_compat.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c
+++ linux/kernel/futex.c
@@ -1039,9 +1039,11 @@ asmlinkage long sys_futex(u32 __user *ua
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	int val2 = 0;
 
-	if ((op == FUTEX_WAIT) && utime) {
+	if (utime && (op == FUTEX_WAIT)) {
 		if (copy_from_user(&t, utime, sizeof(t)) != 0)
 			return -EFAULT;
+		if (!timespec_valid(&t))
+			return -EINVAL;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
 	/*
Index: linux/kernel/futex_compat.c
===================================================================
--- linux.orig/kernel/futex_compat.c
+++ linux/kernel/futex_compat.c
@@ -129,9 +129,11 @@ asmlinkage long compat_sys_futex(u32 __u
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	int val2 = 0;
 
-	if ((op == FUTEX_WAIT) && utime) {
+	if (utime && (op == FUTEX_WAIT)) {
 		if (get_compat_timespec(&t, utime))
 			return -EFAULT;
+		if (!timespec_valid(&t))
+			return -EINVAL;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
 	if (op >= FUTEX_REQUEUE)


