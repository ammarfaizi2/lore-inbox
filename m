Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752390AbWAFKSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbWAFKSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbWAFKSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:18:44 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:51685 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1752390AbWAFKSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:18:43 -0500
Message-ID: <43BE43B6.3010105@cosmosbay.com>
Date: Fri, 06 Jan 2006 11:17:26 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
Subject: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <20060105235845.967478000@sorel.sous-sol.org> <20060106004555.GD25207@sorel.sous-sol.org> <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030708050503000809030603"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 06 Jan 2006 11:17:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708050503000809030603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


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
example). If this limit is reached, free the oldest entry of this queue.

I assume that if a CPU queued 10.000 items in its RCU queue, then the oldest 
entry cannot still be in use by another CPU. This might sounds as a violation 
of RCU rules, (I'm not an RCU expert) but seems quite reasonable.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------030708050503000809030603
Content-Type: text/plain;
 name="RCU_OOM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RCU_OOM.patch"

--- linux-2.6.15/kernel/rcupdate.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/kernel/rcupdate.c	2006-01-06 11:10:45.000000000 +0100
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
@@ -110,9 +110,17 @@
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
 
-	if (unlikely(++rdp->count > 10000))
-		set_need_resched();
-
+/*
+ * OOM avoidance : If we queued too many items in this queue,
+ *  free the oldest entry
+ */
+	if (unlikely(++rdp->count > 10000)) {
+		rdp->count--;
+		head = rdp->donelist;
+		rdp->donelist = head->next;
+		local_irq_restore(flags);
+		return head->func(head);
+	}
 	local_irq_restore(flags);
 }
 
@@ -148,12 +156,17 @@
 	rdp = &__get_cpu_var(rcu_bh_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-	rdp->count++;
 /*
- *  Should we directly call rcu_do_batch() here ?
- *  if (unlikely(rdp->count > 10000))
- *      rcu_do_batch(rdp);
+ * OOM avoidance : If we queued too many items in this queue,
+ *  free the oldest entry
  */
+	if (unlikely(++rdp->count > 10000)) {
+		rdp->count--;
+		head = rdp->donelist;
+		rdp->donelist = head->next;
+		local_irq_restore(flags);
+		return head->func(head);
+	}
 	local_irq_restore(flags);
 }
 
@@ -209,7 +222,7 @@
 static void rcu_do_batch(struct rcu_data *rdp)
 {
 	struct rcu_head *next, *list;
-	int count = 0;
+	int count = maxbatch;
 
 	list = rdp->donelist;
 	while (list) {
@@ -217,7 +230,7 @@
 		list->func(list);
 		list = next;
 		rdp->count--;
-		if (++count >= maxbatch)
+		if (--count <= 0)
 			break;
 	}
 	if (!rdp->donelist)

--------------030708050503000809030603--
