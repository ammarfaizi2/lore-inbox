Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWH3AkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWH3AkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWH3AkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 20:40:15 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32932 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751309AbWH3AkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 20:40:13 -0400
Date: Tue, 29 Aug 2006 17:40:55 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dipankar@in.ibm.com, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       josht@us.ibm.com
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060830004055.GA2845@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <20060828120611.afad8b0f.akpm@osdl.org> <20060828191642.GA32697@in.ibm.com> <20060828124058.cca5f5ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828124058.cca5f5ab.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:40:58PM -0700, Andrew Morton wrote:
> On Tue, 29 Aug 2006 00:46:42 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > srcu (sleepable rcu) patches independent of the core RCU implementation
> > changes in the patchset. You can queue these up either before
> > or after srcu.
> > 
> > ...
> >
> > rcutorture fix patches independent of rcu implementation changes
> > in this patchset.
> 
> So this patchset is largely orthogonal to the presently-queued stuff?
>  
> > > 
> > > Now what?
> > 
> > Heh. I can always re-submit against -mm after I wait for a day or two
> > for comments :)
> 
> That would be good, thanks.  We were seriously considering merging all the
> SRCU stuff for 2.6.18, because
> cpufreq-make-the-transition_notifier-chain-use-srcu.patch fixes a cpufreq
> down()-in-irq-disabled warning at suspend time.
> 
> But that's a lot of new stuff just to fix a warning about something which
> won't actually cause any misbehaviour.  We could just as well do
> 
> 	if (irqs_disabled())
> 		down_read_trylock(...);	/* suspend */
> 	else
> 		down_read(...);
> 
> in cpufreq to temporarily shut the thing up.

I re-reviewed SRCU and found no issues.  So I am OK with it going upstream
if it is useful.

I do have a comment patch below to flag an "attractive nuisance".
Several people have asked about moving the final synchronize_sched()
out of the critical section, but this turns out to be not just scary,
but actually unsafe.  ;-)

Again, this patch just adds verbiage to an existing comment.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

diff -urpNa -X dontdiff linux-2.6.18-rc2-mm1/kernel/srcu.c linux-2.6.18-rc2-mm1-srcu-comment/kernel/srcu.c
--- linux-2.6.18-rc2-mm1/kernel/srcu.c	2006-08-05 16:30:19.000000000 -0700
+++ linux-2.6.18-rc2-mm1-srcu-comment/kernel/srcu.c	2006-08-29 17:29:30.000000000 -0700
@@ -212,6 +212,25 @@ void synchronize_srcu(struct srcu_struct
 	 * More importantly, it also forces the corresponding SRCU read-side
 	 * critical sections to have also completed, and the corresponding
 	 * references to SRCU-protected data items to be dropped.
+	 *
+	 * Note:
+	 *
+	 *	Despite what you might think at first glance, the
+	 *	preceding synchronize_sched() -must- be within the
+	 *	critical section ended by the following mutex_unlock().
+	 *	Otherwise, a task taking the early exit can race
+	 *	with a srcu_read_unlock(), which might have executed
+	 *	just before the preceding srcu_readers_active() check,
+	 *	and whose CPU might have reordered the srcu_read_unlock()
+	 *	with the preceding critical section.  In this case, there
+	 *	is nothing preventing the synchronize_sched() task that is
+	 *	taking the early exit from freeing a data structure that
+	 *	is still being referenced (out of order) by the task
+	 *	doing the srcu_read_unlock().
+	 *
+	 *	Alternatively, the comparison with "2" on the early exit
+	 *	could be changed to "3", but this increases synchronize_srcu()
+	 *	latency for bulk loads.  So the current code is preferred.
 	 */
 
 	mutex_unlock(&sp->mutex);
