Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVAJSFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVAJSFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVAJSE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:04:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:38097 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262379AbVAJSBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:01:51 -0500
Subject: Re: [PATCH] scheduling priorities with rlimit
From: utz lehmann <lkml@s2y4n2c.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050109123441.O469@build.pdx.osdl.net>
References: <1105290936.24812.29.camel@segv.aura.of.mankind>
	 <1105297598.4173.52.camel@laptopd505.fenrus.org>
	 <20050109123441.O469@build.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 19:01:27 +0100
Message-Id: <1105380087.5819.13.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 12:34 -0800, Chris Wright wrote: 
> * Arjan van de Ven (arjan@infradead.org) wrote:

> > I much rather have the rlimit match the exact nice values we communicate
> > to userspace elsewhere, both to be consistent and to not expose
> > scheduler internals to userpsace.
> 
> The problem is the numbers are inconsistent between user interfaces already.
> RT priorities are [0, 99], nice vaules are [-20, 19].  Perhaps it'd be
> simpler to break it down to just three values for the rlimit.
> 
> 0: Same as now, raise nice value only.
> 1: Can lower nice value.
> 2: Can set RT policy (this includes any priority [1, 99], or optionally
> max out at something lower than 99, reserving full CAP_SYS_NICE to 99).
> 
> Each level inherits the permissions of the lower level, and none of them
> allow the CAP_SYS_NICE ability to affect processes other than your own.

I dont like this. I dont what to give user the ability to renice there
jobs to -20. I need numeric limits.

But i think it's mainly a problem of userspace to present userfriendly
values. There are already conversions of rlimit values in pam_limits and
ulimit.

What about this. Separate the rlimit in RLIMIT_NICE and LIMIT_RT.
Putting both into one value is not a good idea, confusing and error
prone. Setting (by fault) RLIMIT_NICE to unlimited is not so risky as
doing it for the old RLIMIT_PRIO.

RLIMIT_RT has the same values like RT priorities 0-99
For RLIMIT_NICE is not possible because the negative nice levels.
Using 0-39 for the nice levels 19 .. -20. It has the advantage that has
the same meaning like the other rlimits, greater value means more
resources.

With a patched PAM you can simply do this in /etc/security/limits.conf

@student	hard	nice		5
@stuff		hard	nice		0
@stuff		soft	nice		5
@admin		hard	nice		-10
@admin		soft	nice		-10

@admin		hard	realtime	10
@admin		soft	realtime	10

The nice values are converted by pam_limits to 0-39.


diff -Nrup linux-2.6.10/include/linux/sched.h linux-2.6.10-prio4/include/linux/sched.h
--- linux-2.6.10/include/linux/sched.h	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-prio4/include/linux/sched.h	2005-01-10 17:28:51.699861886 +0100
@@ -738,6 +738,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern unsigned long nice_to_rlimit_nice(const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
diff -Nrup linux-2.6.10/kernel/sched.c linux-2.6.10-prio4/kernel/sched.c
--- linux-2.6.10/kernel/sched.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-prio4/kernel/sched.c	2005-01-10 17:25:28.079188450 +0100
@@ -73,6 +73,12 @@
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
 /*
+ * convert nice to RLIMIT_NICE values ([ 19 ... -20 ] to [ 0 ... 39 ])
+ */
+
+#define NICE_TO_RLIMIT_NICE(nice)	(19 - nice)
+
+/*
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
@@ -3008,12 +3014,8 @@ asmlinkage long sys_nice(int increment)
 	 * We don't have to worry. Conceptually one call occurs first
 	 * and we have a single winner.
 	 */
-	if (increment < 0) {
-		if (!capable(CAP_SYS_NICE))
-			return -EPERM;
-		if (increment < -40)
-			increment = -40;
-	}
+	if (increment < -40)
+		increment = -40;
 	if (increment > 40)
 		increment = 40;
 
@@ -3023,6 +3025,12 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && 
+		NICE_TO_RLIMIT_NICE(nice) >
+		current->signal->rlim[RLIMIT_NICE].rlim_cur &&
+		!capable(CAP_SYS_NICE))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3056,6 +3064,15 @@ int task_nice(const task_t *p)
 }
 
 /**
+ * nice_to_rlimit_nice - return rlimit_nice priority of give nice value
+ * @nice: nice value
+ */
+unsigned long nice_to_rlimit_nice(const int nice)
+{
+	return NICE_TO_RLIMIT_NICE(nice);
+}
+
+/**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
  */
@@ -3139,6 +3156,7 @@ recheck:
 
 	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    lp.sched_priority > p->signal->rlim[RLIMIT_RT].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
diff -Nrup linux-2.6.10/kernel/sys.c linux-2.6.10-prio4/kernel/sys.c
--- linux-2.6.10/kernel/sys.c	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-prio4/kernel/sys.c	2005-01-10 17:29:50.378989385 +0100
@@ -224,7 +224,10 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) &&
+		nice_to_rlimit_nice(niceval) >
+		p->signal->rlim[RLIMIT_NICE].rlim_cur &&
+		!capable(CAP_SYS_NICE)) {
 		error = -EACCES;
 		goto out;
 	}
diff -Nrup linux-2.6.10/include/asm-i386/resource.h linux-2.6.10-prio4/include/asm-i386/resource.h
--- linux-2.6.10/include/asm-i386/resource.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-prio4/include/asm-i386/resource.h	2005-01-10 16:55:43.480164770 +0100
@@ -18,8 +18,11 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RT	14		/* maximum realtime priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	15
 
 
 /*
@@ -45,6 +48,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{            0,	             0 },		\
+	{            0,	             0 },		\
 }
 
 #endif /* __KERNEL__ */


