Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWAFMxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWAFMxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWAFMxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:53:42 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:32914 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751480AbWAFMxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:53:40 -0500
Message-ID: <43BE680F.40902@cosmosbay.com>
Date: Fri, 06 Jan 2006 13:52:31 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency (Version 2),
 HOTPLUG_CPU fix
References: <20060105235845.967478000@sorel.sous-sol.org> <20060106004555.GD25207@sorel.sous-sol.org> <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org> <43BE43B6.3010105@cosmosbay.com>
In-Reply-To: <43BE43B6.3010105@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------090801060707070300030002"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 06 Jan 2006 13:52:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801060707070300030002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

First patch was buggy, sorry :(

This 2nd version makes no more RCU assumptions, because only the 'donelist' 
queue is fetched for an item to be deleted. Items from the donelist are ready 
to be freed.

This V2 also corrects a problem in case of a CPU hotplug, we forgot to update 
the ->count variable when transfering a queue to another one.

-------------------------------------------------------------------------
In order to avoid some OOM triggered by a flood of call_rcu() calls, we 
increased in linux 2.6.14 maxbatch from 10 to 10000, and conditionally call 
set_need_resched() in call_rcu().

This solution doesnt solve all the problems and has drawbacks.

1) Using a big maxbatch has a bad impact on latency.
2) A flood of call_rcu_bh() still can OOM

I have some servers that once in a while crashes when the ip route cache is 
flushed. After raising /proc/sys/net/ipv4/route/secret_interval (so that *no* 
flush is done), I got better uptime for these servers. But in some cases I 
think the network stack can floods call_rcu_bh(), and a fatal OOM occurs.

I suggest in this patch :

1) To lower maxbatch to a more reasonable value (as far as the latency is 
concerned)

2) To be able to guard a RCU cpu queue against a maximal count (10.000 for 
example). If this limit is reached, free the oldest entry (if available from 
the donelist queue).

3) Bug correction in __rcu_offline_cpu() where we forgot to adjust ->count 
field when transfering a queue to another one.

In my stress tests, I could not reproduce OOM anymore after applying this patch.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------090801060707070300030002
Content-Type: text/plain;
 name="RCU_OOM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RCU_OOM.patch"

--- linux-2.6.15/kernel/rcupdate.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/kernel/rcupdate.c	2006-01-06 13:32:02.000000000 +0100
@@ -71,14 +71,14 @@
 
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-static int maxbatch = 10000;
+static int maxbatch = 100;
 
 #ifndef __HAVE_ARCH_CMPXCHG
 /*
  * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
  * 32 bit atomic_t implementations, and a hash function similar to that
  * for our refcounting needs.
- * Can't help multiprocessors which donot have cmpxchg :(
+ * Can't help multiprocessors which dont have cmpxchg :(
  */
 
 spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
@@ -110,9 +110,19 @@
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
 
-	if (unlikely(++rdp->count > 10000))
-		set_need_resched();
-
+/*
+ * OOM avoidance : If we queued too many items in this queue,
+ *  free the oldest entry (from the donelist only to respect
+ *  RCU constraints)
+ */
+	if (unlikely(++rdp->count > 10000 && (head = rdp->donelist))) {
+		rdp->count--;
+		rdp->donelist = head->next;
+		if (!rdp->donelist)
+			rdp->donetail = &rdp->donelist;
+		local_irq_restore(flags);
+		return head->func(head);
+	}
 	local_irq_restore(flags);
 }
 
@@ -148,12 +158,19 @@
 	rdp = &__get_cpu_var(rcu_bh_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-	rdp->count++;
 /*
- *  Should we directly call rcu_do_batch() here ?
- *  if (unlikely(rdp->count > 10000))
- *      rcu_do_batch(rdp);
+ * OOM avoidance : If we queued too many items in this queue,
+ *  free the oldest entry (from the donelist only to respect
+ *  RCU constraints)
  */
+	if (unlikely(++rdp->count > 10000 && (head = rdp->donelist))) {
+		rdp->count--;
+		rdp->donelist = head->next;
+		if (!rdp->donelist)
+			rdp->donetail = &rdp->donelist;
+		local_irq_restore(flags);
+		return head->func(head);
+	}
 	local_irq_restore(flags);
 }
 
@@ -208,19 +225,20 @@
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
-	struct rcu_head *next, *list;
-	int count = 0;
+	struct rcu_head *next = NULL, *list;
+	int count = maxbatch;
 
 	list = rdp->donelist;
 	while (list) {
-		next = rdp->donelist = list->next;
+		next = list->next;
 		list->func(list);
 		list = next;
 		rdp->count--;
-		if (++count >= maxbatch)
+		if (--count <= 0)
 			break;
 	}
-	if (!rdp->donelist)
+	rdp->donelist = next;
+	if (!next)
 		rdp->donetail = &rdp->donelist;
 	else
 		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
@@ -344,11 +362,9 @@
 static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
 				struct rcu_head **tail)
 {
-	local_irq_disable();
 	*this_rdp->nxttail = list;
 	if (list)
 		this_rdp->nxttail = tail;
-	local_irq_enable();
 }
 
 static void __rcu_offline_cpu(struct rcu_data *this_rdp,
@@ -362,9 +378,12 @@
 	if (rcp->cur != rcp->completed)
 		cpu_quiet(rdp->cpu, rcp, rsp);
 	spin_unlock_bh(&rsp->lock);
+	local_irq_disable();
 	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
 	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-
+	this_rdp->count += rdp->count;
+	rdp->count = 0;
+	local_irq_enable();
 }
 static void rcu_offline_cpu(int cpu)
 {

--------------090801060707070300030002--
