Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVAGWb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVAGWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVAGWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:31:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:53174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261676AbVAGW30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:29:26 -0500
Date: Fri, 7 Jan 2005 14:29:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107142920.K2357@build.pdx.osdl.net>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107221059.GA17392@infradead.org>; from hch@infradead.org on Fri, Jan 07, 2005 at 10:10:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> On Fri, Jan 07, 2005 at 01:49:41PM -0800, Andrew Morton wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > >
> > > ...
> > > Last I checked they could be controlled separately in that module.  It
> > > has been suggested (by me and others) that one possible solution would
> > > be to expand it to be generic for all caps.
> > 
> > Maybe this is the way?
> 
> It's at least not as bad as the current hack (when properly done in
> the capabilities modules instead of adding one ontop).
> 
> I must say I'm not exactly happy with that idea still.  It ties the
> privilegues we have been separating from a special uid (0) to filesystem
> permissions again.  It's not nessecarily a bad idea per, but it doesn't
> really fit into the model we've been working to.  I'd expect quite a few
> unpleasant devices when a user detects that the distibution had been
> binding various capabilities to uids/gids behinds his back.

I agree, it's still a hack, just a generic and complete hack ;-)

> So to make forward progress I'd like the audio people to confirm whether
> the mlock bits in 2.6.9+ do help that half of their requirement first

It sure should, but I guess they can reply on that.

> (and if not find a way to fix it) and then tackle the scheduling part.
> For that one I really wonder whether the combination of the now actually
> working nicelevels (see Mingo's post) and a simple wrapper for the really
> high requirements cases doesn't work.

I saw Jack (I think) post some numbers showing that it wasn't enough.
What about making priority level protected via rlimit?

Here's an uncompiled, untested patch doing that (probably has some math
error or logic hole in it, but idea seems sound enough).  I think it has
at least one problem, where nice 19 process, could renice itself back to
0.  And it doesn't really handle the different scheduling policies,
other than implicit 40 - 139 being used for SCHED_FIFO/SCHED_RR.

It takes the 140 priority levels (0-139), inverts their priority
order, and then uses that number as the basis for the rlimit (so that a
larger rlimit means higher priority, to fall inline with normal rlimit
semantics).  Defaults to 19 (which should be niceval of 0).  And allows
CAP_SYS_NICE to continue to override if the rlimit is too low.

===== kernel/sched.c 1.386 vs edited =====
--- 1.386/kernel/sched.c	2005-01-04 18:48:21 -08:00
+++ edited/kernel/sched.c	2005-01-07 14:23:32 -08:00
@@ -3009,12 +3009,8 @@ asmlinkage long sys_nice(int increment)
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
 
@@ -3024,6 +3020,11 @@ asmlinkage long sys_nice(int increment)
 	if (nice > 19)
 		nice = 19;
 
+	if ((MAX_PRIO-1) - NICE_TO_PRIO(nice) > 
+	    current->signal->rlim[RLIMIT_PRIO].rlim_cur &&
+	    !capable(CAP_SYS_NICE))
+		return -EPERM;
+
 	retval = security_task_setnice(current, nice);
 	if (retval)
 		return retval;
@@ -3057,6 +3058,15 @@ int task_nice(const task_t *p)
 }
 
 /**
+ * nice_to_prio - return priority of give nice value
+ * @nice: nice value
+ */
+int nice_to_prio(const int nice)
+{
+	return NICE_TO_PRIO(nice);
+}
+
+/**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
  */
@@ -3140,6 +3150,7 @@ recheck:
 
 	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
+	    lp.sched_priority+40 > p->signal->rlim[RLIMIT_PRIO].rlim_cur && 
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
===== kernel/sys.c 1.102 vs edited =====
--- 1.102/kernel/sys.c	2005-01-06 23:25:46 -08:00
+++ edited/kernel/sys.c	2005-01-07 14:13:37 -08:00
@@ -225,7 +225,9 @@ static int set_one_prio(struct task_stru
 		error = -EPERM;
 		goto out;
 	}
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+	if ((MAX_PRIO-1) - nice_to_prio(niceval) > 
+	    p->signal->rlim[RLIMIT_PRIO].rlim_cur &&
+	    !capable(CAP_SYS_NICE)) {
 		error = -EACCES;
 		goto out;
 	}
===== include/asm-i386/resource.h 1.5 vs edited =====
--- 1.5/include/asm-i386/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-i386/resource.h	2005-01-07 13:55:37 -08:00
@@ -18,8 +18,9 @@
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
 #define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+#define RLIMIT_PRIO	13		/* maximum scheduling priority */
 
-#define RLIM_NLIMITS	13
+#define RLIM_NLIMITS	14
 
 
 /*
@@ -45,6 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+	{           19,	            19 },		\
 }
 
 #endif /* __KERNEL__ */
===== include/linux/sched.h 1.280 vs edited =====
--- 1.280/include/linux/sched.h	2005-01-04 18:48:20 -08:00
+++ edited/include/linux/sched.h	2005-01-07 14:14:16 -08:00
@@ -760,6 +760,7 @@ extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
+extern int nice_to_prio(const int nice);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
