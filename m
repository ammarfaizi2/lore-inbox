Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVCHGuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVCHGuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCHGuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:50:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:39823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261833AbVCHGpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:45:41 -0500
Date: Mon, 7 Mar 2005 22:45:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       joq@io.com, cfriesen@nortelnetworks.com, chrisw@osdl.org,
       hch@infradead.org, rlrevell@joe-job.com, arjanv@redhat.com,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308064505.GJ5389@shell0.pdx.osdl.net>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308043349.GG3120@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Mon, Mar 07, 2005 at 07:50:20PM -0800, Andrew Morton wrote:
> > Consider this a prod in the direction of those who were pushing
> > alternatives ;)
> 
> I think Chris Wright's last rlimit patch is more sensible and ready to
> go. And I think I may have even convinced Ingo on this point before
> the conversation died last time around. So here's that patch again,
> updated to 2.6.11. Compiles cleanly. Chris, please add a signed-off-by.

Only very minor nits below.

> Add a pair of rlimits for allowing non-root tasks to raise nice and rt
> priorities. Defaults to traditional behavior. Originally written by
> Chris Wright.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: rlimits/include/asm-generic/resource.h
> ===================================================================
> --- rlimits.orig/include/asm-generic/resource.h	2005-03-02 18:30:27.000000000 -0800
> +++ rlimits/include/asm-generic/resource.h	2005-03-07 20:21:04.000000000 -0800
> @@ -20,8 +20,10 @@
>  #define RLIMIT_LOCKS		10	/* maximum file locks held */
>  #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
>  #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
> -
> -#define RLIM_NLIMITS		13
> +#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
> +					   0-39 for nice level 19 .. -20 */
> +#define RLIMIT_RTPRIO	14		/* maximum realtime priority */

Needs one more tab to keep in line with rest.

> +#define RLIM_NLIMITS		15


>  #endif
>  
>  /*
> @@ -53,6 +55,8 @@
>  	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
>  	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
>  	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
> +	[RLIMIT_NICE]		= { 0, 0 }, \
> +	[RLIMIT_RTPRIO]		= { 0, 0 }, \

Might as well fit in with rest of file on these too.

Also, missed alpha, sparc, sparc64, and mips.  BTW, where's that last
cleanup from Ingo to consolidate these?  Ah, just saw these are inflight
to Linus' tree, nevermind.

Below fixes those nits, and rediffs against that inflight cleanup so it
should apply cleanly on top of that.

thanks,
-chris
-- 

Add a pair of rlimits for allowing non-root tasks to raise nice and rt
priorities. Defaults to traditional behavior. Originally written by
Chris Wright.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/asm-generic/resource.h 1.1 vs edited =====
--- 1.1/include/asm-generic/resource.h	2005-01-20 21:00:51 -08:00
+++ edited/include/asm-generic/resource.h	2005-03-07 21:15:00 -08:00
@@ -41,8 +41,10 @@
 #define RLIMIT_LOCKS		10	/* maximum file locks held */
 #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
 #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS		13
+#define RLIMIT_NICE		13	/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO		14	/* maximum realtime priority */
+#define RLIM_NLIMITS		15
 
 /*
  * SuS says limits have to be unsigned.
@@ -81,6 +83,8 @@
 	[RLIMIT_LOCKS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
 	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
+	[RLIMIT_NICE]		= {              0,              0 },	\
+	[RLIMIT_RTPRIO]		= {              0,              0 },	\
 }
 
 #endif	/* __KERNEL__ */
===== include/linux/sched.h 1.279 vs edited =====
--- 1.279/include/linux/sched.h	2005-03-04 22:41:13 -08:00
+++ edited/include/linux/sched.h	2005-03-07 21:43:39 -08:00
@@ -792,6 +792,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int can_nice(const task_t *p, const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
===== kernel/sched.c 1.394 vs edited =====
--- 1.394/kernel/sched.c	2005-03-04 22:41:14 -08:00
+++ edited/kernel/sched.c	2005-03-07 21:43:39 -08:00
@@ -3278,6 +3278,19 @@ out_unlock:
 
 EXPORT_SYMBOL(set_user_nice);
 
+/*
+ * can_nice - check if a task can reduce its nice value
+ * @p: task
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
@@ -3297,12 +3310,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3312,6 +3321,9 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && !can_nice(current, nice))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3427,6 +3439,7 @@ recheck:
 		return -EINVAL;
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
===== kernel/sys.c 1.104 vs edited =====
--- 1.104/kernel/sys.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sys.c	2005-03-07 21:10:23 -08:00
@@ -225,7 +225,7 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) && !can_nice(p, niceval)) {
 		error = -EACCES;
 		goto out;
 	}
