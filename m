Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTATL6k>; Mon, 20 Jan 2003 06:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTATL6k>; Mon, 20 Jan 2003 06:58:40 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:10703 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261836AbTATL6i>; Mon, 20 Jan 2003 06:58:38 -0500
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.5.59-A2
Date: Mon, 20 Jan 2003 13:07:55 +0100
User-Agent: KMail/1.4.3
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301201022540.2585-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301201022540.2585-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7PH02PBHA3FJC6EJWSFC"
Message-Id: <200301201307.55515.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_7PH02PBHA3FJC6EJWSFC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2003 10:28, Ingo Molnar wrote:
> On Sun, 19 Jan 2003, Erich Focht wrote:
> > The results:
> > - kernbench UserTime is best for the 2.5.59 scheduler (623s). IngoB0
> >   best value 627.33s for idle=3D20ms, busy=3D2000ms.
> > - hackbench: 2.5.59 scheduler is significantly better for all
> >   measurements.
> >
> > I suppose this comes from the fact that the 2.5.59 version has the
> > chance to load_balance across nodes when a cpu goes idle. No idea wha=
t
> > other reason it could be... Maybe anybody else?
>
> this shows that agressive idle-rebalancing is the most important factor=
=2E I
> think this means that the unification of the balancing code should go i=
nto
> the other direction: ie. applying the ->nr_balanced logic to the SMP
> balancer as well.

Could you please explain your idea? As far as I understand, the SMP
balancer (pre-NUMA) tries a global rebalance at each call. Maybe you
mean something different...

> kernelbench is the kind of benchmark that is most sensitive to over-eag=
er
> global balancing, and since the 2.5.59 ->nr_balanced logic produced the
> best results, it clearly shows it's not over-eager. hackbench is one th=
at
> is quite sensitive to under-balancing. Ie. trying to maximize both will
> lead us to a good balance.

Yes! Actually the currently implemented nr_balanced logic is pretty
dumb: the counter reaches the cross-node balance threshold after a
certain number of calls to intra-node lb, no matter whether these were
successfull or not. I'd like to try incrementing the counter only on
unsuccessfull load balances, this would give a clear priority to
intra-node balancing and a clear and controllable delay for cross-node
balancing. A tiny patch for this (for 2.5.59) is attached. As the name
nr_balanced would be misleading for this kind of usage, I renamed it
to nr_lb_failed.

Regards,
Erich

--------------Boundary-00=_7PH02PBHA3FJC6EJWSFC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="failed-lb-ctr-2.5.59"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="failed-lb-ctr-2.5.59"

diff -urNp 2.5.59-topo/kernel/sched.c 2.5.59-topo-succ/kernel/sched.c
--- 2.5.59-topo/kernel/sched.c	2003-01-17 03:22:29.000000000 +0100
+++ 2.5.59-topo-succ/kernel/sched.c	2003-01-20 13:06:04.000000000 +0100
@@ -156,7 +156,7 @@ struct runqueue {
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
-	unsigned int nr_balanced;
+	unsigned int nr_lb_failed;
 	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
@@ -770,11 +770,11 @@ static inline unsigned long cpus_to_bala
 	int this_node = __cpu_to_node(this_cpu);
 	/*
 	 * Avoid rebalancing between nodes too often.
-	 * We rebalance globally once every NODE_BALANCE_RATE load balances.
+	 * We rebalance globally after NODE_BALANCE_RATE failed load balances.
 	 */
-	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
+	if (this_rq->nr_lb_failed == NODE_BALANCE_RATE) {
 		int node = find_busiest_node(this_node);
-		this_rq->nr_balanced = 0;
+		this_rq->nr_lb_failed = 0;
 		if (node >= 0)
 			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
 	}
@@ -892,6 +892,10 @@ static inline runqueue_t *find_busiest_q
 		busiest = NULL;
 	}
 out:
+#ifdef CONFIG_NUMA
+	if (!busiest)
+		this_rq->nr_lb_failed++;
+#endif
 	return busiest;
 }
 

--------------Boundary-00=_7PH02PBHA3FJC6EJWSFC--

