Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVANXMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVANXMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVANXHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:07:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:3227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261573AbVANXEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:04:21 -0500
Date: Fri, 14 Jan 2005 15:04:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, nickpiggin@yahoo.com.au,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       hch@infradead.org, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050114150418.S24171@build.pdx.osdl.net>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org> <20050114065701.GG2940@waste.org> <20050114121021.O24171@build.pdx.osdl.net> <20050114205512.GD3823@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050114205512.GD3823@waste.org>; from mpm@selenic.com on Fri, Jan 14, 2005 at 12:55:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Fri, Jan 14, 2005 at 12:10:21PM -0800, Chris Wright wrote:
> > The basic issue on the rlimit value is how to sanely encode nice values,
> > realtime prioroties and scheduler policies into a number.  The first
> > incarnation was the clumsiest, and tried to pack it all into a number
> > in range of [0,139].  This, as many agree, too closely reflects kernel
> > internal values.  This one gives 0-39 (nice values 19,-20) to RLIMIT_NICE,
> > and 0-99 (rt priorities) to RLIMIT_RTPRIO.  There's no distinction in rt
> > policy, and the traditional override (CAP_SYS_NICE) is still in place.
> > The defaults for both rlimits are 0, and behaviour should be backwards
> > compatible.  I tested this one a bit, and it worked as expected.  I've
> > got a patch to pam_limits as well, although it's untested.
> 
> This is looking pretty good.
> 
> > +#define NICE_TO_RLIMIT_NICE(nice)	(19 - nice)
> ...
> > +unsigned long nice_to_rlimit_nice(const int nice)
> > +{
> > +	return NICE_TO_RLIMIT_NICE(nice);
> > +}
> 
> This is a bit silly.

Heh, I wondered what comment that would get ;-)  It's gone.

> > -	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
> > +	if (niceval < task_nice(p) &&
> > +		nice_to_rlimit_nice(niceval) >
> > +		p->signal->rlim[RLIMIT_NICE].rlim_cur &&
> > +		!capable(CAP_SYS_NICE)) {
> 
> Perhaps we want another helper function to do the rlim and
> CAP_SYS_NICE check together.

Sure.
-chris
-- 

===== include/asm-i386/resource.h 1.5 vs edited =====
--- 1.5/include/asm-i386/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-i386/resource.h	2005-01-14 13:48:53 -08:00
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
===== include/asm-x86_64/resource.h 1.5 vs edited =====
--- 1.5/include/asm-x86_64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-x86_64/resource.h	2005-01-14 14:17:38 -08:00
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
  * SuS says limits have to be unsigned.
@@ -44,6 +47,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{             0,             0 },		\
+	{             0,             0 },		\
 }
 
 #endif /* __KERNEL__ */
===== include/linux/sched.h 1.291 vs edited =====
--- 1.291/include/linux/sched.h	2005-01-11 16:42:57 -08:00
+++ edited/include/linux/sched.h	2005-01-14 13:58:32 -08:00
@@ -767,6 +767,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int can_nice(const task_t *p, const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
===== kernel/sched.c 1.407 vs edited =====
--- 1.407/kernel/sched.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sched.c	2005-01-14 15:03:44 -08:00
@@ -3121,6 +3121,19 @@ out_unlock:
 
 EXPORT_SYMBOL(set_user_nice);
 
+/**
+ * can_nice - check if a task can reduce its nice value
+   @p: task
+ * @nice: nice value
+ */
+int can_nice(const task_t *p, const int nice)
+{
+	/* convert nice value [19,-20] to rlimit style value [0,39] */
+	int nice_rlim = 19 - nice;
+	return (nice_rlim <= p->signal->rlim[RLIMIT_NICE].rlim_cur || 
+		capable(CAP_SYS_NICE));
+}
+
 #ifdef __ARCH_WANT_SYS_NICE
 
 /*
@@ -3140,12 +3153,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3155,6 +3164,9 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && !can_nice(current, nice))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3252,6 +3264,7 @@ recheck:
 		return -EINVAL;
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
===== kernel/sys.c 1.104 vs edited =====
--- 1.104/kernel/sys.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sys.c	2005-01-14 14:10:11 -08:00
@@ -225,7 +225,7 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) && !can_nice(p, niceval)) {
 		error = -EACCES;
 		goto out;
 	}

