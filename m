Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTJQAOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTJQAOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:14:43 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:24823 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S263238AbTJQAOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:14:41 -0400
Date: Thu, 16 Oct 2003 10:10:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK to set PF_MEMDIE on cleanup tasks?
Message-ID: <20031016171045.GA3012@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20031014151759.GA2188@us.ibm.com> <20031014171227.014f0d2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014171227.014f0d2f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew,

On Tue, Oct 14, 2003 at 05:12:27PM -0700, Andrew Morton wrote:
> > So...  Is it considered legit to simply set PF_MEMDIE when creating
> > the cleanup task?  Or is there some reason that one should deal with
> > signal 15?
> 
> Well it's all very unconventional.  Catching SIGTERM seems like a suitable
> way to do what you want to do.

OK, since this particular case is a strictly in-kernel task, SIGTERM
should be a no-op anyway.  Unless I am missing something in the signal
delivery code, which is quite probable.  ;-)

So the magic code would then be:

	cap_raise(current->cap_effective, CAP_SYS_RAWIO);

perhaps with:

	cap_raise(current->cap_effective, CAP_SYS_ADMIN);

thrown in for good measure.

> Possibly your special process should also run as PF_MEMALLOC.  I've seen
> that done before, with success.  There is no existing API with which this
> can be set.

This would certainly head off at least some OOM deadlock situations.
On the (perhaps unlikely) chance that this was an invitation, here
is a patch to create an API.

					Thanx, Paul

diff -urN -X /home/linux/2.5/dontdiff linux-2.6.0-test7-mm1/include/linux/sched.h linux-2.6.0-test7-mm1-PF_MEMALLOC/include/linux/sched.h
--- linux-2.6.0-test7-mm1/include/linux/sched.h	2003-10-16 07:16:05.000000000 -0700
+++ linux-2.6.0-test7-mm1-PF_MEMALLOC/include/linux/sched.h	2003-10-16 09:20:34.000000000 -0700
@@ -508,6 +508,27 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 
+/**
+ * mark_task_memalloc - mark the specified task as deserving of preferential
+ * access to free memory.  Note that with great power comes great
+ * responsibility.
+ * @p: the task structure to be granted preferential access.
+ */
+static inline void mark_task_memalloc(task_t *p)
+{
+	p->flags |= PF_MEMALLOC;
+}
+
+/**
+ * unmark_task_memalloc - mark the specified task as no longer deserving
+ * of preferential access to free memory.
+ * @p: the task structure to have its preferential access revoked.
+ */
+static inline void unmark_task_memalloc(task_t *p)
+{
+	p->flags &= ~PF_MEMALLOC;
+}
+
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
 #else
