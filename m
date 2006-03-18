Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWCRPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWCRPSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWCRPSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:18:14 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:45275
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932760AbWCRPSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:18:13 -0500
Message-Id: <20060318142830.607556000@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
Date: Sat, 18 Mar 2006 15:18:25 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch 1/2] Validate itimer timeval from userspace
Content-Disposition: inline; filename=itimer-validate-uservalue.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to the specification the timeval must be validated and
an errorcode -EINVAL returned in case the timeval is not in canonical
form. Before the hrtimer merge this was silently ignored by the 
timeval to jiffies conversion. The validation is done inside 
do_setitimer so all callers are catched.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |    6 ++++++
 kernel/itimer.c      |    8 ++++++++
 2 files changed, 14 insertions(+)

Index: linux-2.6.16-rc6-updates/include/linux/time.h
===================================================================
--- linux-2.6.16-rc6-updates.orig/include/linux/time.h
+++ linux-2.6.16-rc6-updates/include/linux/time.h
@@ -73,6 +73,12 @@ extern void set_normalized_timespec(stru
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
 
+/*
+ * Returns true if the timeval is in canonical form
+ */
+#define timeval_valid(t) \
+	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
+
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
Index: linux-2.6.16-rc6-updates/kernel/itimer.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/kernel/itimer.c
+++ linux-2.6.16-rc6-updates/kernel/itimer.c
@@ -150,6 +150,14 @@ int do_setitimer(int which, struct itime
 	ktime_t expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
+	/*
+	 * Validate the timeval. This catches all users of
+	 * do_setitimer.
+	 */
+	if (!timeval_valid(&value->it_value) ||
+	    !timeval_valid(&value->it_interval))
+		return -EINVAL;
+
 	switch (which) {
 	case ITIMER_REAL:
 again:

--

