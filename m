Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVKFWn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVKFWn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKFWn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:43:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:25302 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751261AbVKFWn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:43:57 -0500
Date: Sun, 6 Nov 2005 14:43:56 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051106224356.GA22876@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051106134945.0e10cb60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106134945.0e10cb60.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 01:49:45PM -0800, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > ...
> > 
> > RCU signal handling: send signals RCU-read-locked instead of 
> > tasklist_lock read-locked. This is a scalability improvement on SMP and 
> > a preemption-latency improvement under PREEMPT_RCU.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> > ...
> > +static inline int get_task_struct_rcu(struct task_struct *t)
> > +{
> > +	int oldusage;
> > +
> > +	do {
> > +		oldusage = atomic_read(&t->usage);
> > +		if (oldusage == 0) {
> > +			return 0;
> > +		}
> > +	} while (cmpxchg(&t->usage.counter,
> > +		 oldusage, oldusage + 1) != oldusage);
> > +	return 1;
> > +}
> 
> arm (at least) does not implement cmpxchg.
> 
> I think Nick is working on patches which implement cmpxchg on all
> architectures?

That he is, but the latest set of signal-RCU patches does not use
get_task_struct_rcu().  Attached is a patch that removes it.

That said, it would be good if there was a set of cmpxchg functions
for all architectures.

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

---

diff -urpNa -X dontdiff linux-2.6.14-rt6/include/linux/sched.h linux-2.6.14-rt6-nocmpxchg/include/linux/sched.h
--- linux-2.6.14-rt6/include/linux/sched.h	2005-11-04 12:38:05.000000000 -0800
+++ linux-2.6.14-rt6-nocmpxchg/include/linux/sched.h	2005-11-06 14:41:26.000000000 -0800
@@ -1057,20 +1057,6 @@ extern void free_task(struct task_struct
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
-static inline int get_task_struct_rcu(struct task_struct *t)
-{
-	int oldusage;
-
-	do {
-		oldusage = atomic_read(&t->usage);
-		if (oldusage == 0) {
-			return 0;
-		}
-	} while (cmpxchg(&t->usage.counter,
-		 oldusage, oldusage + 1) != oldusage);
-	return 1;
-}
-
 extern void __put_task_struct_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
