Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHHDFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHHDFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHHDFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:05:50 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:28893
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751228AbWHHDFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:05:49 -0400
Date: Mon, 7 Aug 2006 20:05:24 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Robert Crocombe <rcrocomb@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060808030524.GA20530@gnuppy.monkey.org>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20060808025615.GA20364@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2006 at 07:56:15PM -0700, Bill Huey wrote:
> On Thu, Aug 03, 2006 at 10:27:41AM -0400, Steven Rostedt wrote:
> 
> ...(output and commentary a log deleted)...
> 
> > This could also have a side effect that messes things up.
> > 
> > Unfortunately, right now I'm assigned to other tasks and I cant spend
> > much more time on this at the moment.  So hopefully, Ingo, Thomas or
> > Bill, or someone else can help you find the reason for this problem.
> 
> Steve and company,
> 
> Speaking of which, after talking to Steve about this and confirming this
> with a revert of changes. put_task_struct() can't deallocated memory from
> either the zone or SLAB cache without taking a sleeping lock. It can't
> be called directly from finish_task_switch to reap the thread because of
> that (violation in atomic).
> 
> It is for this reason the RCU call back to delay processing was put into
> place to reap threads and was, seemingly by accident, missing from
> patch-2.6.17-rt7 to -rt8. That is what broke it in the first place.
> 
> I tested it with a "make -j4" which triggers the warning and it they all
> go away now.
> 
> Reverse patch attached:

Resend with instrumentation code removed:

bill


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t.diff"

============================================================
--- include/linux/sched.h	0ed8993484be9c13728f4ebdaa51fc0f0c229018
+++ include/linux/sched.h	db79c6b458b0776d3768141ff993a7c9e64d5794
@@ -1105,6 +1110,15 @@
 extern void free_task(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
+#ifdef CONFIG_PREEMPT_RT
+extern void __put_task_struct_cb(struct rcu_head *rhp);
+
+static inline void put_task_struct(struct task_struct *t)
+{
+	if (atomic_dec_and_test(&t->usage))
+		call_rcu(&t->rcu, __put_task_struct_cb);
+}
+#else
 extern void __put_task_struct(struct task_struct *t);
 
 static inline void put_task_struct(struct task_struct *t)
@@ -1112,6 +1126,7 @@
 	if (atomic_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
+#endif
 
 /*
  * Per process flags
============================================================
--- kernel/fork.c	506dabd42d242f78e0321594c7723481e0cd87dc
+++ kernel/fork.c	d07df07ac627dd27933b4bfb83768461ef28731c
@@ -54,6 +54,8 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#include <linux/dobject.h>
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -120,6 +122,26 @@
 }
 EXPORT_SYMBOL(free_task);
 
+#ifdef CONFIG_PREEMPT_RT
+void __put_task_struct_cb(struct rcu_head *rhp)
+{
+	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
+
+	BUG_ON(atomic_read(&tsk->usage));
+	WARN_ON(!(tsk->flags & PF_DEAD));
+	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
+	WARN_ON(tsk == current);
+
+	security_task_free(tsk);
+	free_uid(tsk->user);
+	put_group_info(tsk->group_info);
+
+	if (!profile_handoff_task(tsk))
+		free_task(tsk);
+}
+
+#else
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
@@ -134,6 +156,7 @@
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
+#endif
 
 void __init fork_init(unsigned long mempages)
 {
 

--OXfL5xGRrasGEqWY--
