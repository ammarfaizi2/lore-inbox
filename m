Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWCSUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWCSUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWCSUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:02:27 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:27115
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750831AbWCSUCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:02:01 -0500
Message-Id: <20060319102013.976854000@localhost.localdomain>
References: <20060319102009.817820000@localhost.localdomain>
Date: Sun, 19 Mar 2006 20:02:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch 2/2] Validate and sanitze itimer timeval from userspace
Content-Disposition: inline; filename=itimer-validate-uservalue.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to the specification the timevals must be validated and
an errorcode -EINVAL returned in case the timevals are not in canonical
form. This check was never done in Linux.

The pre 2.6.16 code converted invalid timevals silently. Negative
timeouts were converted by the timeval_to_jiffies conversion to
the maximum timeout.

hrtimers and the ktime_t operations expect timevals in canonical form.
Otherwise random results might happen on 32 bits machines due to the
optimized ktime_add/sub operations. Negative timeouts are treated
as already expired. This might break applications which work on
pre 2.6.16. 

To prevent random behaviour and API breakage the timevals are checked
and invalid timevals sanitized in a simliar way as the pre 2.6.16 code
did.

Invalid timevals are reported with a per boot limited number of kernel
messages so applications which use this misfeature can be corrected.

After a grace period of one year the sanitizing should be replaced by
a correct validation check. This is also documented in
Documentation/feature-removal-schedule.txt

The validation and sanitizing is done inside do_setitimer so all
callers (sys_setitimer, compat_sys_setitimer, osf_setitimer) are catched.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 Documentation/feature-removal-schedule.txt |   12 +++++
 kernel/itimer.c                            |   64 +++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

Index: linux-2.6.16-rc6-updates/kernel/itimer.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/kernel/itimer.c
+++ linux-2.6.16-rc6-updates/kernel/itimer.c
@@ -143,6 +143,58 @@ int it_real_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+/*
+ * We do not care about correctness. We just sanitize the values so
+ * the ktime_t operations which expect normalized values do not
+ * break. This converts negative values to long timeouts similar to
+ * the code in kernel versions < 2.6.16
+ *
+ * Print a limited number of warning messages when an invalid timeval
+ * is detected.
+ */
+static void fixup_timeval(struct timeval *tv, int interval)
+{
+	static int warnlimit = 10;
+	unsigned long tmp;
+
+	if (warnlimit > 0) {
+		warnlimit--;
+		printk(KERN_WARNING
+		       "setitimer: %s (pid = %d) provided "
+		       "invalid timeval %s: tv_sec = %ld tv_usec = %ld\n",
+		       current->comm, current->pid,
+		       interval ? "it_interval" : "it_value",
+		       tv->tv_sec, (long) tv->tv_usec);
+	}
+
+	tmp = (unsigned long) tv->tv_usec;
+	if (tmp >= USEC_PER_SEC)
+		tv->tv_usec = USEC_PER_SEC - 1;
+
+	tmp = (unsigned long) tv->tv_sec;
+	if (tmp > (LONG_MAX >> 1))
+		tv->tv_sec = (LONG_MAX >> 1);
+}
+
+/*
+ * Returns true if the timeval is in canonical form
+ */
+#define timeval_valid(t) \
+	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
+
+/*
+ * Check for invalid timevals, sanitize them and print a limited
+ * number of warnings.
+ */
+static void check_itimerval(struct itimerval *value) {
+
+	if (unlikely(!timeval_valid(&value->it_value)))
+		fixup_timeval(&value->it_value, 0);
+
+	if (unlikely(!timeval_valid(&value->it_interval)))
+		fixup_timeval(&value->it_interval, 1);
+}
+
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
@@ -150,6 +202,18 @@ int do_setitimer(int which, struct itime
 	ktime_t expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
+	/*
+	 * Validate the timevals in value.
+	 *
+	 * Note: Although the spec requires that invalid values shall
+	 * return -EINVAL, we just fixup the value and print a limited
+	 * number of warnings in order not to break users of this
+	 * historical misfeature.
+	 *
+	 * Scheduled for replacement in March 2007
+	 */
+	check_itimerval(value);
+
 	switch (which) {
 	case ITIMER_REAL:
 again:
Index: linux-2.6.16-rc6-updates/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.16-rc6-updates.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6.16-rc6-updates/Documentation/feature-removal-schedule.txt
@@ -189,3 +189,15 @@ Why:	Board specific code doesn't build a
 	users have complained indicating there is no more need for these
 	boards.  This should really be considered a last call.
 Who:	Ralf Baechle <ralf@linux-mips.org>
+
+---------------------------
+
+What:	Usage of invalid timevals in setitimer
+When:	March 2007
+Why:	POSIX requires to validate timevals in the setitimer call. This
+	was never done by Linux. The invalid (e.g. negative timevals) were
+	silently converted to more or less random timeouts and intervals.
+	Until the removal a per boot limited number of warnings is printed
+	and the timevals are sanitized.
+
+Who:	Thomas Gleixner <tglx@linutronix.de>

--

