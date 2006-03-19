Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWCSUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWCSUCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWCSUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:02:00 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:26091
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750831AbWCSUB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:01:59 -0500
Message-Id: <20060319102013.581398000@localhost.localdomain>
References: <20060319102009.817820000@localhost.localdomain>
Date: Sun, 19 Mar 2006 20:02:17 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch 1/2] sys_alarm() unsigned signed conversion fixup
Content-Disposition: inline; filename=alarm-fixup-unsigned-signed.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alarm() calls the kernel with an unsigend int timeout in seconds.
The value is stored in the tv_sec field of a struct timeval to
setup the itimer. The tv_sec field of struct timeval is of type long,
which causes the tv_sec value to be negative on 32 bit machines if
seconds > INT_MAX.

Before the hrtimer merge (pre 2.6.16) such a negative value was
converted to the maximum jiffies timeout by the timeval_to_jiffies
conversion. It's not clear whether this was intended or just happened
to be done by the timeval_to_jiffies code.

hrtimers expect a timeval in canonical form and treat a negative 
timeout as already expired. This breaks the legitimate usage of
alarm() with a timeout value > INT_MAX seconds.

For 32 bit machines it is therefor necessary to limit the internal 
seconds value to avoid API breakage. Instead of doing this in all
implementations of sys_alarm the duplicated sys_alarm code is moved
into a common function in itimer.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 arch/ia64/ia32/sys_ia32.c   |   14 +-------------
 arch/mips/kernel/sysirix.c  |   22 +---------------------
 arch/x86_64/ia32/sys_ia32.c |   16 ++--------------
 include/linux/time.h        |    1 +
 kernel/itimer.c             |   37 +++++++++++++++++++++++++++++++++++++
 kernel/timer.c              |   14 +-------------
 6 files changed, 43 insertions(+), 61 deletions(-)

Index: linux-2.6.16-rc6-updates/kernel/itimer.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/kernel/itimer.c
+++ linux-2.6.16-rc6-updates/kernel/itimer.c
@@ -226,6 +226,43 @@ again:
 	return 0;
 }
 
+/**
+ * alarm_setitimer - set alarm in seconds
+ *
+ * @seconds:	number of seconds until alarm
+ *		0 disables the alarm
+ *
+ * Returns the remaining time in seconds of a pending timer or 0 when
+ * the timer is not active.
+ *
+ * On 32 bit machines the seconds value is limited to (INT_MAX/2) to avoid
+ * negative timeval settings which would cause immidiate expiry.
+ */
+unsigned int alarm_setitimer(unsigned int seconds)
+{
+	struct itimerval it_new, it_old;
+
+#if BITS_PER_LONG < 64
+	if (seconds > (INT_MAX >> 1))
+		seconds = (INT_MAX >> 1);
+#endif
+	it_new.it_value.tv_sec = seconds;
+	it_new.it_value.tv_usec = 0;
+	it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
+
+	do_setitimer(ITIMER_REAL, &it_new, &it_old);
+
+	/*
+	 * We can't return 0 if we have an alarm pending ...  And we'd
+	 * better return too much than too little anyway
+	 */
+	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_usec) ||
+	      it_old.it_value.tv_usec >= 500000)
+		it_old.it_value.tv_sec++;
+
+	return it_old.it_value.tv_sec;
+}
+
 asmlinkage long sys_setitimer(int which,
 			      struct itimerval __user *value,
 			      struct itimerval __user *ovalue)
Index: linux-2.6.16-rc6-updates/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/arch/ia64/ia32/sys_ia32.c
+++ linux-2.6.16-rc6-updates/arch/ia64/ia32/sys_ia32.c
@@ -1166,19 +1166,7 @@ put_tv32 (struct compat_timeval __user *
 asmlinkage unsigned long
 sys32_alarm (unsigned int seconds)
 {
-	struct itimerval it_new, it_old;
-	unsigned int oldalarm;
-
-	it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
-	it_new.it_value.tv_sec = seconds;
-	it_new.it_value.tv_usec = 0;
-	do_setitimer(ITIMER_REAL, &it_new, &it_old);
-	oldalarm = it_old.it_value.tv_sec;
-	/* ehhh.. We can't return 0 if we have an alarm pending.. */
-	/* And we'd better return too much than too little anyway */
-	if (it_old.it_value.tv_usec)
-		oldalarm++;
-	return oldalarm;
+	return alarm_setitimer(seconds);
 }
 
 /* Translations due to time_t size differences.  Which affects all
Index: linux-2.6.16-rc6-updates/arch/mips/kernel/sysirix.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/arch/mips/kernel/sysirix.c
+++ linux-2.6.16-rc6-updates/arch/mips/kernel/sysirix.c
@@ -645,27 +645,7 @@ static inline void getitimer_real(struct
 
 asmlinkage unsigned int irix_alarm(unsigned int seconds)
 {
-	struct itimerval it_new, it_old;
-	unsigned int oldalarm;
-
-	if (!seconds) {
-		getitimer_real(&it_old);
-		del_timer(&current->real_timer);
-	} else {
-		it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
-		it_new.it_value.tv_sec = seconds;
-		it_new.it_value.tv_usec = 0;
-		do_setitimer(ITIMER_REAL, &it_new, &it_old);
-	}
-	oldalarm = it_old.it_value.tv_sec;
-	/*
-	 * ehhh.. We can't return 0 if we have an alarm pending ...
-	 * And we'd better return too much than too little anyway
-	 */
-	if (it_old.it_value.tv_usec)
-		oldalarm++;
-
-	return oldalarm;
+	return alarm_setitimer(seconds);
 }
 
 asmlinkage int irix_pause(void)
Index: linux-2.6.16-rc6-updates/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/arch/x86_64/ia32/sys_ia32.c
+++ linux-2.6.16-rc6-updates/arch/x86_64/ia32/sys_ia32.c
@@ -430,24 +430,12 @@ put_tv32(struct compat_timeval __user *o
 	return err; 
 }
 
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
+extern unsigned int alarm_setitimer(unsigned int seconds);
 
 asmlinkage long
 sys32_alarm(unsigned int seconds)
 {
-	struct itimerval it_new, it_old;
-	unsigned int oldalarm;
-
-	it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
-	it_new.it_value.tv_sec = seconds;
-	it_new.it_value.tv_usec = 0;
-	do_setitimer(ITIMER_REAL, &it_new, &it_old);
-	oldalarm = it_old.it_value.tv_sec;
-	/* ehhh.. We can't return 0 if we have an alarm pending.. */
-	/* And we'd better return too much than too little anyway */
-	if (it_old.it_value.tv_usec)
-		oldalarm++;
-	return oldalarm;
+	return alarm_setitimer(seconds);
 }
 
 /* Translations due to time_t size differences.  Which affects all
Index: linux-2.6.16-rc6-updates/kernel/timer.c
===================================================================
--- linux-2.6.16-rc6-updates.orig/kernel/timer.c
+++ linux-2.6.16-rc6-updates/kernel/timer.c
@@ -955,19 +955,7 @@ void do_timer(struct pt_regs *regs)
  */
 asmlinkage unsigned long sys_alarm(unsigned int seconds)
 {
-	struct itimerval it_new, it_old;
-	unsigned int oldalarm;
-
-	it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
-	it_new.it_value.tv_sec = seconds;
-	it_new.it_value.tv_usec = 0;
-	do_setitimer(ITIMER_REAL, &it_new, &it_old);
-	oldalarm = it_old.it_value.tv_sec;
-	/* ehhh.. We can't return 0 if we have an alarm pending.. */
-	/* And we'd better return too much than too little anyway */
-	if ((!oldalarm && it_old.it_value.tv_usec) || it_old.it_value.tv_usec >= 500000)
-		oldalarm++;
-	return oldalarm;
+	return alarm_setitimer(seconds);
 }
 
 #endif
Index: linux-2.6.16-rc6-updates/include/linux/time.h
===================================================================
--- linux-2.6.16-rc6-updates.orig/include/linux/time.h
+++ linux-2.6.16-rc6-updates/include/linux/time.h
@@ -95,6 +95,7 @@ extern long do_utimes(int dfd, char __us
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value,
 			struct itimerval *ovalue);
+extern unsigned int alarm_setitimer(unsigned int seconds);
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday(struct timespec *tv);
 

--

