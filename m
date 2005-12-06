Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVLFAih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVLFAih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbVLFAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31182
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751535AbVLFAeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:37 -0500
Message-Id: <20051206000154.292134000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:37 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 11/21] Create and use timespec_valid macro
Content-Disposition: inline; filename=introduce-timespec-valid.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- add timespec_valid(ts) [returns false if the timespec is denorm]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/time.h  |    6 ++++++
 kernel/posix-timers.c |    5 ++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -44,6 +44,12 @@ extern unsigned long mktime(const unsign
 
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
 
+/*
+ * Returns true if the timespec is norm, false if denorm:
+ */
+#define timespec_valid(ts) \
+	(((ts)->tv_sec >= 0) && (((unsigned) (ts)->tv_nsec) < NSEC_PER_SEC))
+
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
Index: linux-2.6.15-rc5/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc5/kernel/posix-timers.c
@@ -712,8 +712,7 @@ out:
  */
 static int good_timespec(const struct timespec *ts)
 {
-	if ((!ts) || (ts->tv_sec < 0) ||
-			((unsigned) ts->tv_nsec >= NSEC_PER_SEC))
+	if ((!ts) || !timespec_valid(ts))
 		return 0;
 	return 1;
 }
@@ -1406,7 +1405,7 @@ sys_clock_nanosleep(const clockid_t whic
 	if (copy_from_user(&t, rqtp, sizeof (struct timespec)))
 		return -EFAULT;
 
-	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+	if (!timespec_valid(&t))
 		return -EINVAL;
 
 	/*

--

