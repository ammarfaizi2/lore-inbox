Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVAWC7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVAWC7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAWC7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:59:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVAWC7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:59:07 -0500
Date: Sat, 22 Jan 2005 18:58:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jack O'Quin" <joq@io.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050122185847.R24171@build.pdx.osdl.net>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <41F306B0.7050306@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41F306B0.7050306@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sun, Jan 23, 2005 at 01:06:40PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> Jack O'Quin wrote:
> 
> > Chris Wright and Arjan van de Ven have outlined a proposal to address
> > the privilege issue using rlimits.  This is still the only workable
> > alternative to the realtime LSM on the table.  If the decision were up
> > to me, I would choose the simplicity and better security of the LSM.
> > But their approach is adequate, if implemented in a timely fashion.  I
> > would like to see some progress on this in addition to the scheduler
> > work.  People still need SCHED_FIFO for some applications.
> > 
> 
> I think this is a pretty sane and minimally intrusive (for the kernel)
> way to support what you want.

Here's an untested respin against current bk.

thanks,
-chris

===== include/asm-generic/resource.h 1.1 vs edited =====
--- 1.1/include/asm-generic/resource.h	2005-01-20 21:00:51 -08:00
+++ edited/include/asm-generic/resource.h	2005-01-22 18:54:58 -08:00
@@ -20,8 +20,11 @@
 #define RLIMIT_LOCKS		10	/* maximum file locks held */
 #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
 #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS		13
+#define RLIMIT_NICE		13	/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO		14	/* maximum realtime priority */
+  
+#define RLIM_NLIMITS		15
 #endif
 
 /*
@@ -53,6 +56,8 @@
 	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
 	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
 	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
+	[RLIMIT_NICE]		= {             0,             0 },	\
+	[RLIMIT_RTPRIO]		= {             0,             0 },	\
 }
 
 #endif	/* __KERNEL__ */
===== include/asm-alpha/resource.h 1.6 vs edited =====
--- 1.6/include/asm-alpha/resource.h	2005-01-20 21:00:50 -08:00
+++ edited/include/asm-alpha/resource.h	2005-01-22 18:58:04 -08:00
@@ -18,8 +18,11 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
+#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO	14		/* maximum realtime priority */
+ 
+#define RLIM_NLIMITS	15
 #define __ARCH_RLIMIT_ORDER
 
 /*
===== include/asm-mips/resource.h 1.8 vs edited =====
--- 1.8/include/asm-mips/resource.h	2005-01-20 21:00:50 -08:00
+++ edited/include/asm-mips/resource.h	2005-01-22 18:59:29 -08:00
@@ -25,8 +25,11 @@
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE 13			/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO 14		/* maximum realtime priority */
 
-#define RLIM_NLIMITS 13			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 15			/* Number of limit flavors.  */
 #define __ARCH_RLIMIT_ORDER
 
 /*
===== include/asm-sparc/resource.h 1.6 vs edited =====
--- 1.6/include/asm-sparc/resource.h	2005-01-20 21:00:50 -08:00
+++ edited/include/asm-sparc/resource.h	2005-01-22 19:00:07 -08:00
@@ -24,8 +24,11 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO	14		/* maximum realtime priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	15
 #define __ARCH_RLIMIT_ORDER
 
 /*
===== include/asm-sparc64/resource.h 1.6 vs edited =====
--- 1.6/include/asm-sparc64/resource.h	2005-01-20 21:00:50 -08:00
+++ edited/include/asm-sparc64/resource.h	2005-01-22 19:00:41 -08:00
@@ -24,8 +24,11 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO	14		/* maximum realtime priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	15
 #define __ARCH_RLIMIT_ORDER
 
 #include <asm-generic/resource.h>
===== include/linux/sched.h 1.274 vs edited =====
--- 1.274/include/linux/sched.h	2005-01-18 12:27:58 -08:00
+++ edited/include/linux/sched.h	2005-01-22 18:52:07 -08:00
@@ -767,6 +767,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int can_nice(const task_t *p, const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
===== kernel/sched.c 1.387 vs edited =====
--- 1.387/kernel/sched.c	2005-01-20 16:00:00 -08:00
+++ edited/kernel/sched.c	2005-01-22 18:52:07 -08:00
@@ -3220,6 +3220,19 @@ out_unlock:
 
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
@@ -3239,12 +3252,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3254,6 +3263,9 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && !can_nice(current, nice))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3369,6 +3381,7 @@ recheck:
 		return -EINVAL;
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
===== kernel/sys.c 1.104 vs edited =====
--- 1.104/kernel/sys.c	2005-01-11 16:42:35 -08:00
+++ edited/kernel/sys.c	2005-01-22 18:52:07 -08:00
@@ -225,7 +225,7 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) && !can_nice(p, niceval)) {
 		error = -EACCES;
 		goto out;
 	}
