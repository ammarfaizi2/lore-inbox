Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVANUQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVANUQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVANUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:13:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:62853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262127AbVANUK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:10:29 -0500
Date: Fri, 14 Jan 2005 12:10:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       nickpiggin@yahoo.com.au, lkml@s2y4n2c.de, rlrevell@joe-job.com,
       arjanv@redhat.com, joq@io.com, chrisw@osdl.org, hch@infradead.org,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050114121021.O24171@build.pdx.osdl.net>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org> <20050114065701.GG2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050114065701.GG2940@waste.org>; from mpm@selenic.com on Thu, Jan 13, 2005 at 10:57:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> The closest thing to concensus I've seen yet was a new rlimit for
> scheduling with code from Chris Wright. The version I last saw had
> some rough edges on the API (exposing the internal scheduler priority
> levels) but wasn't too bad in principle. We really ought not get in
> the habit of adding new rlimits though.
> 
> Perhaps he can post whatever he has again, I'm not sure what the
> current state is.

This is the latest version, with the idea from Utz to break nice and
rtprio apart.

The basic issue on the rlimit value is how to sanely encode nice values,
realtime prioroties and scheduler policies into a number.  The first
incarnation was the clumsiest, and tried to pack it all into a number
in range of [0,139].  This, as many agree, too closely reflects kernel
internal values.  This one gives 0-39 (nice values 19,-20) to RLIMIT_NICE,
and 0-99 (rt priorities) to RLIMIT_RTPRIO.  There's no distinction in rt
policy, and the traditional override (CAP_SYS_NICE) is still in place.
The defaults for both rlimits are 0, and behaviour should be backwards
compatible.  I tested this one a bit, and it worked as expected.  I've
got a patch to pam_limits as well, although it's untested.

thanks,
-chris
-- 

===== include/asm-i386/resource.h 1.5 vs edited =====
--- 1.5/include/asm-i386/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-i386/resource.h	2005-01-14 10:28:19 -08:00
@@ -18,8 +18,11 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO	14		/* maximum realtime priority */
 
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
===== include/linux/sched.h 1.291 vs edited =====
--- 1.291/include/linux/sched.h	2005-01-11 16:42:57 -08:00
+++ edited/include/linux/sched.h	2005-01-14 10:11:13 -08:00
@@ -767,6 +767,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern unsigned long nice_to_rlimit_nice(const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
===== kernel/sched.c 1.407 vs edited =====
--- 1.407/kernel/sched.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sched.c	2005-01-14 10:38:21 -08:00
@@ -68,6 +68,12 @@
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
@@ -3140,12 +3146,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3155,6 +3157,12 @@ asmlinkage long sys_nice(int increment)
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
@@ -3188,6 +3196,15 @@ int task_nice(const task_t *p)
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
@@ -3252,6 +3269,7 @@ recheck:
 		return -EINVAL;
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
===== kernel/sys.c 1.104 vs edited =====
--- 1.104/kernel/sys.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sys.c	2005-01-14 10:11:13 -08:00
@@ -225,7 +225,10 @@ static int set_one_prio(struct task_stru
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


-----
And the patch for pam.

--- Linux-PAM-0.77/modules/pam_limits/pam_limits.c.prio	2005-01-14 10:47:03.000000000 -0800
+++ Linux-PAM-0.77/modules/pam_limits/pam_limits.c	2005-01-14 10:55:13.000000000 -0800
@@ -39,6 +39,11 @@
 #include <grp.h>
 #include <pwd.h>
 
+/* Hack to test new rlimit values */
+#define RLIMIT_NICE	13
+#define RLIMIT_RTPRIO	14
+#define RLIM_NLIMITS	15
+
 /* Module defines */
 #define LINE_LENGTH 1024
 
@@ -293,6 +298,10 @@ static void process_limit(int source, co
     else if (strcmp(lim_item, "locks") == 0)
 	limit_item = RLIMIT_LOCKS;
 #endif
+    else if (strcmp(lim_item, "rt_priority") == 0)
+	limit_item = RLIMIT_RTPRIO;
+    else if (strcmp(lim_item, "nice") == 0)
+	limit_item = RLIMIT_NICE;
     else if (strcmp(lim_item, "maxlogins") == 0) {
 	limit_item = LIMIT_LOGIN;
 	pl->flag_numsyslogins = 0;
@@ -360,6 +369,19 @@ static void process_limit(int source, co
         case RLIMIT_AS:
             limit_value *= 1024;
             break;
+        case RLIMIT_NICE:
+            limit_value = 19 - limit_value;
+            if (limit_value > 39)
+		limit_value = 39;
+	    if (limit_value < 0);
+		limit_value = 0;
+            break;
+        case RLIMIT_RTPRIO:
+            if (limit_value > 99)
+		limit_value = 99;
+	    if (limit_value < 0);
+		limit_value = 0;
+            break;
     }
 
     if ( (limit_item != LIMIT_LOGIN)
