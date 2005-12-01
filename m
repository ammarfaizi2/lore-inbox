Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVLAALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVLAALE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLAALB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:11:01 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44962
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751288AbVK3X5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:30 -0500
Subject: [patch 11/43] Create timespec_valid macro
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:11 +0100
Message-Id: <1133395391.32542.454.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (introduce-timespec-valid.patch)
- add timespec_valid(ts) [returns false if the timespec is denorm]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/time.h  |    6 ++++++
 kernel/posix-timers.c |    5 ++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/time.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/time.h
+++ linux-2.6.15-rc2-rework/include/linux/time.h
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
Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
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

