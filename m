Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVCHHB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVCHHB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVCHG6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:58:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:28305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbVCHG4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:56:34 -0500
Date: Mon, 7 Mar 2005 22:55:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050307225535.146f8162.akpm@osdl.org>
In-Reply-To: <20050308043349.GG3120@waste.org>
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308043349.GG3120@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  Add a pair of rlimits for allowing non-root tasks to raise nice and rt
>  priorities. Defaults to traditional behavior. Originally written by
>  Chris Wright.

It needs some dinking with because Ingo has been playing games in my
resource.h.  Here's the end result.  Unlike yours, this will work on alpha,
mips and sparc[64], too ;)




From: Matt Mackall <mpm@selenic.com>

Add a pair of rlimits for allowing non-root tasks to raise nice and rt
priorities. Defaults to traditional behavior. Originally written by
Chris Wright.

The patch implements a simple rlimit ceiling for the RT (and nice) priorities
a task can set.  The rlimit defaults to 0, meaning no change in behavior by
default.  A value of 50 means RT priority levels 1-50 are allowed.  A value of
100 means all 99 privilege levels from 1 to 99 are allowed.  CAP_SYS_NICE is
blanket permission.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-generic/resource.h |    7 ++++++-
 25-akpm/include/linux/sched.h          |    1 +
 25-akpm/kernel/sched.c                 |   25 +++++++++++++++++++------
 25-akpm/kernel/sys.c                   |    2 +-
 4 files changed, 27 insertions(+), 8 deletions(-)

diff -puN include/asm-generic/resource.h~nice-and-rt-prio-rlimits include/asm-generic/resource.h
--- 25/include/asm-generic/resource.h~nice-and-rt-prio-rlimits	2005-03-07 22:50:45.000000000 -0800
+++ 25-akpm/include/asm-generic/resource.h	2005-03-07 22:52:10.000000000 -0800
@@ -41,8 +41,11 @@
 #define RLIMIT_LOCKS		10	/* maximum file locks held */
 #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
 #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
+#define RLIMIT_NICE		13	/* max nice prio allowed to raise to
+					   0-39 for nice level 19 .. -20 */
+#define RLIMIT_RTPRIO		14	/* maximum realtime priority */
 
-#define RLIM_NLIMITS		13
+#define RLIM_NLIMITS		15
 
 /*
  * SuS says limits have to be unsigned.
@@ -81,6 +84,8 @@
 	[RLIMIT_LOCKS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_SIGPENDING]	= { 		0,	       0 },	\
 	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
+	[RLIMIT_NICE]		= { 0, 0 },				\
+	[RLIMIT_RTPRIO]		= { 0, 0 },				\
 }
 
 #endif	/* __KERNEL__ */
diff -puN include/linux/sched.h~nice-and-rt-prio-rlimits include/linux/sched.h
--- 25/include/linux/sched.h~nice-and-rt-prio-rlimits	2005-03-07 22:50:45.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2005-03-07 22:50:45.000000000 -0800
@@ -872,6 +872,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int can_nice(const task_t *p, const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
diff -puN kernel/sched.c~nice-and-rt-prio-rlimits kernel/sched.c
--- 25/kernel/sched.c~nice-and-rt-prio-rlimits	2005-03-07 22:50:45.000000000 -0800
+++ 25-akpm/kernel/sched.c	2005-03-07 22:50:45.000000000 -0800
@@ -3304,6 +3304,19 @@ struct task_struct *kgdb_get_idle(int th
 }
 #endif
 
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
@@ -3323,12 +3336,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3338,6 +3347,9 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if (increment < 0 && !can_nice(current, nice))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3453,6 +3465,7 @@ recheck:
 		return -EINVAL;
 
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur &&
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
diff -puN kernel/sys.c~nice-and-rt-prio-rlimits kernel/sys.c
--- 25/kernel/sys.c~nice-and-rt-prio-rlimits	2005-03-07 22:50:45.000000000 -0800
+++ 25-akpm/kernel/sys.c	2005-03-07 22:50:45.000000000 -0800
@@ -229,7 +229,7 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if (niceval < task_nice(p) && !can_nice(p, niceval)) {
 		error = -EACCES;
 		goto out;
 	}
_

