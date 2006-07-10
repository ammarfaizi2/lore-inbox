Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWGJQwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWGJQwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWGJQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:52:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:15509 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422696AbWGJQwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:52:02 -0400
Date: Mon, 10 Jul 2006 09:51:18 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@us.ibm.com, akpm@osdl.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, stern@rowland.harvard.edu, mingo@elte.hu,
       tytso@us.ibm.com, dvhltc@us.ibm.com, jes@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060710165118.GC1446@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060706171401.GA1768@us.ibm.com> <20060706172022.GA1901@us.ibm.com> <20060709235029.GA194@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709235029.GA194@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 03:50:29AM +0400, Oleg Nesterov wrote:
> On 07/06, Paul E. McKenney wrote:
> >
> > Updated patch adding a variant of RCU that permits sleeping in read-side
> > critical sections.
> 
> I do not see any problems with this patch, but I have a couple of
> questions, so your help is needed again.

Thank you for looking it over!

> > +void synchronize_srcu(struct srcu_struct *sp)
> > +{
> > +	[... snip ...]
> > +
> > +	synchronize_sched();  /* Force memory barrier on all CPUs. */
> > +
> > +	/*
> > +	 * The preceding synchronize_sched() forces all srcu_read_unlock()
> > +	 * primitives that were executing concurrently with the preceding
> > +	 * for_each_possible_cpu() loop to have completed by this point.
> > +	 * More importantly, it also forces the corresponding SRCU read-side
> > +	 * critical sections to have also completed, and the corresponding
> > +	 * references to SRCU-protected data items to be dropped.
> > +	 */
> > +
> > +	mutex_unlock(&sp->mutex);
> > +}
> 
> Isn't it possible to unlock ->mutex earlier, before the last
> synchronize_sched()?

It seems possible, but I would like to think carefully about this one
first, and, if it still seems plausible, test it heavily.  If I understand
your line of reasoning, the thought is that the first synchronize_sched()
at the beginning of synchronize_srcu() ensures that all of the counter
updates pertaining to the last instance of synchronize_srcu() have
been committed.  The same reasoning might well cover the sp->completed
fastpath as well.

In any case, this is a performance boost off the fastpath.  A good boost,
if it works, but I will be much more excited if you find a way of speeding
up srcu_read_lock() or srcu_read_unlock().  ;-)

> Another question: what is the semantics of synchronize_sched() ?
> 
> I am not talking about the current implementation, it is very clear.
> The question is: what is the _definition_ of synchronize_sched()
> (which must be valid for "any" RCU implementation) ?
> 
> 1) The comment in include/linux/rcupdate.h states that "all preempt_disable
>    code sequences will have completed before this primitive returns".
> 
> 2) kernel/srcu.c claims that this primitive "forces memory barrier on all
>    CPUs". (so the comment in rcupdate.h is not complete).
> 
>    (I understand this so that each cpu does something which implies mb()
>     semantics).
> 
> As I see it, 1) + 2) is NOT enough for synchronize_srcu() to be correct
> (the 2-nd and 3-rd synchronize_sched() calls). I think synchronize_sched()
> should also guarantee the completion of mem ops on all CPUs before return,
> not just mb() (which does not have any timing guaranties).
> 
> Could you clarify this issue?
> 
> (Again, I do not see any problems with the current RCU implementation).

However, this -does- seem to be to be a problem with the comment headers
and the documentation.  Does the following patch make things better?

David, would it be worthwhile adding this global-memory-barrier effect
of synchronize_rcu(), synchronize_sched(), and synchronize_srcu() to
Documentation/memory-barriers.txt?

							Thanx, Paul

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/checklist.txt |    4 ++++
 include/linux/rcupdate.h        |    3 +++
 kernel/rcupdate.c               |    3 +++
 kernel/srcu.c                   |    3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-4/Documentation/RCU/checklist.txt linux-2.6.17-srcu-LKML-5/Documentation/RCU/checklist.txt
--- linux-2.6.17-srcu-LKML-4/Documentation/RCU/checklist.txt	2006-07-06 16:45:01.000000000 -0700
+++ linux-2.6.17-srcu-LKML-5/Documentation/RCU/checklist.txt	2006-07-10 09:43:19.000000000 -0700
@@ -221,3 +221,7 @@ over a rather long period of time, but i
 
 	Note that, rcu_assign_pointer() and rcu_dereference() relate to
 	SRCU just as they do to other forms of RCU.
+
+14.	The synchronize_rcu(), synchronize_sched(), and synchronize_srcu()
+	primitives force at least one memory barrier to be executed on
+	each active CPU before they return.
diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-4/include/linux/rcupdate.h linux-2.6.17-srcu-LKML-5/include/linux/rcupdate.h
--- linux-2.6.17-srcu-LKML-4/include/linux/rcupdate.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu-LKML-5/include/linux/rcupdate.h	2006-07-10 09:48:51.000000000 -0700
@@ -251,6 +251,9 @@ extern int rcu_needs_cpu(int cpu);
  * guarantees that rcu_read_lock() sections will have completed.
  * In "classic RCU", these two guarantees happen to be one and
  * the same, but can differ in realtime RCU implementations.
+ * 
+ * In addition, this primitive guarantees that every active CPU has
+ * executed at least one memory barrier before it returns.
  */
 #define synchronize_sched() synchronize_rcu()
 
diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-4/kernel/rcupdate.c linux-2.6.17-srcu-LKML-5/kernel/rcupdate.c
--- linux-2.6.17-srcu-LKML-4/kernel/rcupdate.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-srcu-LKML-5/kernel/rcupdate.c	2006-07-10 09:48:32.000000000 -0700
@@ -597,6 +597,9 @@ static void wakeme_after_rcu(struct rcu_
  * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
  * and may be nested.
  *
+ * This primitive also causes each active CPU to execute at least one
+ * memory barrier before it returns.
+ *
  * If your read-side code is not protected by rcu_read_lock(), do -not-
  * use synchronize_rcu().
  */
diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-4/kernel/srcu.c linux-2.6.17-srcu-LKML-5/kernel/srcu.c
--- linux-2.6.17-srcu-LKML-4/kernel/srcu.c	2006-07-06 16:50:23.000000000 -0700
+++ linux-2.6.17-srcu-LKML-5/kernel/srcu.c	2006-07-10 09:48:09.000000000 -0700
@@ -143,7 +143,8 @@ void srcu_read_unlock(struct srcu_struct
  * Flip the completed counter, and wait for the old count to drain to zero.
  * As with classic RCU, the updater must use some separate means of
  * synchronizing concurrent updates.  Can block; must be called from
- * process context.
+ * process context.  Has the side-effect of forcing a memory barrier on
+ * each active CPU before returning.
  *
  * Note that it is illegal to call synchornize_srcu() from the corresponding
  * SRCU read-side critical section; doing so will result in deadlock.
