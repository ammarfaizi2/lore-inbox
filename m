Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTLPRg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLPRg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:36:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40174 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261914AbTLPRg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:36:56 -0500
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: rusty@rustcorp.com.au, piggin@cyberone.com.au,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] HT scheduler
Date: Tue, 16 Dec 2003 11:37:55 -0600
User-Agent: KMail/1.5
References: <200312161127.13691.habanero@us.ibm.com>
In-Reply-To: <200312161127.13691.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zL03/CDMmU/2Xat"
Message-Id: <200312161137.55034.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zL03/CDMmU/2Xat
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> In message <3FD7F1B9.5080100@cyberone.com.au> you write:
> > http://www.kerneltrap.org/~npiggin/w26/
> > Against 2.6.0-test11
> >
> > This includes the SMT description for P4. Initial results shows
> > comparable performance to Ingo's shared runqueue's patch on a dual P4
> > Xeon.
>
> I'm still not convinced.  Sharing runqueues is simple, and in fact
> exactly what you want for HT: you want to balance *runqueues*, not
> CPUs.  In fact, it can be done without a CONFIG_SCHED_SMT addition.
>
> Your patch is more general, more complex, but doesn't actually seem to
> buy anything.  It puts a general domain structure inside the
> scheduler, without putting it anywhere else which wants it (eg. slab
> cache balancing).  My opinion is either (1) produce a general NUMA
> topology which can then be used by the scheduler, or (2) do the
> minimal change in the scheduler which makes HT work well.

FWIW, here is a patch I was working on a while back, to have multilevel NUMA 
heirarchies (based on arch specific NUMA topology) and more importantly, a 
runqueue centric point of view for all the load balance routines.  This patch 
is quite rough, and I have not looked at this patch in a while, but maybe it 
could help someone?

Also, with runqueue centric approach, shared runqueues should just "work", so 
adding that to this patch should be fairly clean.  

One more thing, we are missing some stuff in the NUMA topology, which Rusty 
mentions in another email, like core arrangement, arch states, cache 
locations/types -all that stuff eventually should make it into some sort of 
topology, be it NUMA topology stuff or a more generic thing like sysfs.  
Right now we are a bit limited at what the scheduler looks at, just 
cpu_to_node type stuff...

-Andrew Theurer
--Boundary-00=_zL03/CDMmU/2Xat
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-numasched.260-test3-bk8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-numasched.260-test3-bk8"

diff -Naurp linux-2.6.0-test3-bk8-numasched/kernel/sched.c linux-2.6.0-test3-bk8-numasched2/kernel/sched.c
--- linux-2.6.0-test3-bk8-numasched/kernel/sched.c	2003-08-22 12:03:30.000000000 -0500
+++ linux-2.6.0-test3-bk8-numasched2/kernel/sched.c	2003-08-22 12:14:09.000000000 -0500
@@ -1261,7 +1261,7 @@ static void rebalance_tick(runqueue_t *t
 
 	if (idle) {
 		while (node) {
-			if (!(j % node->idle_rebalance_tick))
+			if (!(j % node->idle_rebalance_tick) && (node->nr_cpus > 1))
 				balance_node(this_rq, idle, last_node, node);
 			last_node = node;
 			node = node->parent_node;
@@ -1269,7 +1269,7 @@ static void rebalance_tick(runqueue_t *t
 		return;
 	}
 	while (node) {
-		if (!(j % node->busy_rebalance_tick))
+		if (!(j % node->busy_rebalance_tick) && (node->nr_cpus > 1))
 			balance_node(this_rq, idle, last_node, node);
 		last_node = node;
 		node = node->parent_node;
@@ -1405,6 +1405,7 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
+	struct node_t *node;
 	int idx;
 
 	/*
@@ -1449,8 +1450,10 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
-		if (rq->node)
-			load_balance(rq, 1, rq->node);
+		node = rq->node;
+		while (node->nr_cpus < 2 && node != top_node)
+			node = node->parent_node;
+		load_balance(rq, 1, node);
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif

--Boundary-00=_zL03/CDMmU/2Xat--

