Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTG2Nfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTG2Nfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:35:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37284 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S271738AbTG2Ner
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:34:47 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Tue, 29 Jul 2003 08:33:05 -0500
User-Agent: KMail/1.4.3
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <200307282124.28378.habanero@us.ibm.com> <200307291208.30332.efocht@hpce.nec.com>
In-Reply-To: <200307291208.30332.efocht@hpce.nec.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5BGSIRIDQK97UQHUP81G"
Message-Id: <200307290833.05216.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5BGSIRIDQK97UQHUP81G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 29 July 2003 05:08, Erich Focht wrote:
> On Tuesday 29 July 2003 04:24, Andrew Theurer wrote:
> > On Monday 28 July 2003 15:37, Martin J. Bligh wrote:
> > > > But the Hammer is a NUMA architecture and a working NUMA schedule=
r
> > > > should be flexible enough to deal with it. And: the corner case o=
f 1
> > > > CPU per node is possible also on any other NUMA platform, when in
> > > > some of the nodes (or even just one) only one CPU is configured i=
n.
> > > > Solving that problem automatically gives the Hammer what it needs=
=2E
> >
> > I am going to ask a silly question, do we have any data showing this
> > really is a problem on AMD?  I would think, even if we have an idle c=
pu,
> > sometimes a little delay on task migration (on NUMA) may not be a bad
> > thing.   If it is too long, can we just make the rebalance ticks arch
> > specific?
>
> The fact that global rebalances are done only in the timer interrupt
> is simply bad!=20

Even with this patch it still seems that most balances are still timer ba=
sed,=20
because we still call load_balance in rebalance_tick.  Granted, we may=20
inter-node balance more often, well, maybe less often since=20
node_busy_rebalance_tick was busy_rebalance_tick*2.  I do see the advanta=
ge=20
of doing this at idle, but idle only, that's why I'd would be more inclin=
ed a=20
only a much more aggressive idle rebalance.

> It complicates rebalance_tick() and wastes the
> opportunity to get feedback from the failed local balance attempts.

What does "failed" really mean?  To me, when *busiest=3Dnull, that means =
we=20
passed, the node itself is probably balanced, and there's nothing to do. =
 It=20
gives no indication at all of the global load [im]balance.  Shouldn't the=
=20
thing we are looking for is the imbalance among node_nr_running[]?  Would=
 it=20
make sense to go forward with a global balance based on that only?

> If you want data supporting my assumptions: Ted Ts'o's talk at OLS
> shows the necessity to rebalance ASAP (even in try_to_wake_up).=20

If this is the patch I am thinking of, it was the (attached) one I sent t=
hem,=20
which did a light "push" rebalance at try_to_wake_up.  Calling load_balan=
ce=20
at try_to_wake_up seems very heavy-weight.  This patch only looks for an =
idle=20
cpu (within the same node) to wake up on before task activation, only if =
the=20
task_rq(p)->nr_running is too long.  So, yes, I do believe this can be=20
important, but I think it's only called for when we have an idle cpu. =20

> There
> are plenty of arguments towards this, starting with the steal delay
> parameter scans from the early days of multi-queue schedulers (Davide
> Libenzi), over my experiments with NUMA schedulers and the observation
> of Andi Kleen that on Opteron you better run from the wrong CPU than
> wait (if the tasks returns to the right cpu, all's fine anyway).
>
> > I'd much rather have info related to the properties of the NUMA arch =
than
> > something that makes decisions based on nr_cpus_node().  For example,=
 we
> > may want to inter-node balance as much or more often on ppc64 than ev=
en
> > AMD, but it has 8 cpus per node.  On this patch it would has the lowe=
st
> > inter-node balance frequency, even though it probably has one of the
> > lowest latencies between nodes and highest throughput interconnects.
>
> We can still discuss on the formula. Currently there's a bug in the
> scheduler and the corner case of 1 cpu/node is just broken. The
> function local_balance_retries(attempts, cpus_in_this_node) must
> return 0 for cpus_in_this_node=3D1 and should return larger values for
> larger cpus_in_this_node. To have an upper limit is fine, but maybe
> not necessary.
>
> Regarding the ppc64 interconnect, I'm glad that you said "probably"
> and "one of the ...". No need to point you to better ones ;-)

OK, we wont get into a pissing match :)  I just wanted to base the schedu=
ler=20
decisions on data related to the hardware NUMA properties, not the cpu co=
unt. =20

> > > Right, I realise that the 1 cpu per node case is broken. However,
> > > doesn't this also affect the multi-cpu per node case in the manner =
I
> > > suggested above? So even if we turn off NUMA scheduler for Hammer, =
this
> > > still needs fixing, right?
> >
> > Maybe so, but if we start making idle rebalance more aggressive, I th=
ink
> > we would need to make CAN_MIGRATE more restrictive, taking memory
> > placement of the tasks in to account.  On AMD with interleaved memory
> > allocation, tasks would move very easily, since their memory is sprea=
d
> > out anyway.  On "home node" or node-local policy, we may not move a t=
ask
> > (or maybe not on the first attempt), even if there is an idle cpu in
> > another node.
>
> Aehm, that's another story and I'm sure we will fix that too. There
> are a few ideas around. But you shouldn't expect to solve all problems
> at once, after all optimal NUMA scheduling can still be considered a
> research area.
>
> > Personally, I'd like to see all systems use NUMA sched, non NUMA syst=
ems
> > being a single node (no policy difference from non-numa sched), allow=
ing
> > us to remove all NUMA ifdefs.  I think the code would be much more
> > readable.
> >
> :-) Then you expect that everybody who reads the scheduler code knows
>
> what NUMA stands for and what it means? Pretty optimistic, but yes,
> I'd like that, too.

Yes, at some point we have to.  We cannot have two different schedulers. =
 Non=20
numa should have the exact same scheduling policy as a numa system with o=
ne=20
node.  I don't know if that's acceptable for 2.6, but I really want to go=
 for=20
that in 2.7. =20

-Andrew Theurer

--------------Boundary-00=_5BGSIRIDQK97UQHUP81G
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-wakey2-2567"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-wakey2-2567"

diff -Naur 2.5.67-BK-9-4-2003/Makefile 2.5.67-BK-9-4-2003-wakey2/Makefile
--- 2.5.67-BK-9-4-2003/Makefile	2003-04-15 13:42:53.000000000 -0700
+++ 2.5.67-BK-9-4-2003-wakey2/Makefile	2003-04-15 13:57:14.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 67
-EXTRAVERSION = -BK-9-4-2003
+EXTRAVERSION = -BK-9-4-2003-wakey2
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -Naur 2.5.67-BK-9-4-2003/kernel/sched.c 2.5.67-BK-9-4-2003-wakey2/kernel/sched.c
--- 2.5.67-BK-9-4-2003/kernel/sched.c	2003-04-13 15:04:34.000000000 -0700
+++ 2.5.67-BK-9-4-2003-wakey2/kernel/sched.c	2003-04-15 14:00:01.000000000 -0700
@@ -486,11 +486,32 @@
  */
 static int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
-	int success = 0, requeue_waker = 0;
-	unsigned long flags;
+	int success = 0, target_cpu, i;
+	unsigned long flags, cpumask;
 	long old_state;
 	runqueue_t *rq;
 
+	target_cpu = smp_processor_id();
+
+	/* change task_cpu to an idle cpu if its
+	 * default rq is really busy and sync
+	 * wakeup is not requested */
+	if (!sync && ((nr_running()*4) <= (num_online_cpus()*5)) &&
+		(task_rq(p)->nr_running > 0)) {
+		cpumask = node_to_cpumask(cpu_to_node(task_cpu(p)));
+		for (i=0; i<NR_CPUS; i++) {
+			if (!(cpumask & (1UL << i)))
+				continue;
+			if (!(cpu_online(i)))
+				continue;
+			if (idle_cpu(i)) {
+				sync = 1;
+				target_cpu = i;
+				break;
+			}
+		}
+	}
+
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -501,43 +522,25 @@
 			 * currently. Do not violate hard affinity.
 			 */
 			if (unlikely(sync && !task_running(rq, p) &&
-				(task_cpu(p) != smp_processor_id()) &&
-				(p->cpus_allowed & (1UL << smp_processor_id())))) {
+				(task_cpu(p) != target_cpu) &&
+				(p->cpus_allowed & (1UL << target_cpu)))) {
 
-				set_task_cpu(p, smp_processor_id());
+				set_task_cpu(p, target_cpu);
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			if (sync)
-				__activate_task(p, rq);
-			else {
-				requeue_waker = activate_task(p, rq);
-				if (p->prio < rq->curr->prio)
+			activate_task(p, rq);
+
+			if (p->prio < rq->curr->prio)
 					resched_task(rq->curr);
-			}
 			success = 1;
 		}
 		p->state = TASK_RUNNING;
 	}
 	task_rq_unlock(rq, &flags);
 
-	/*
-	 * We have to do this outside the other spinlock, the two
-	 * runqueues might be different:
-	 */
-	if (requeue_waker) {
-		prio_array_t *array;
-
-		rq = task_rq_lock(current, &flags);
-		array = current->array;
-		dequeue_task(current, array);
-		current->prio = effective_prio(current);
-		enqueue_task(current, array);
-		task_rq_unlock(rq, &flags);
-	}
-
 	return success;
 }
 

--------------Boundary-00=_5BGSIRIDQK97UQHUP81G--

