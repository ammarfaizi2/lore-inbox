Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161380AbWJKVEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWJKVEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWJKVEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:04:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:9630 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161380AbWJKVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:33 -0400
Date: Wed, 11 Oct 2006 14:03:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/67] NET_SCHED: Fix fallout from dev->qdisc RCU change
Message-ID: <20061011210330.GB16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net_sched-fix-fallout-from-dev-qdisc-rcu-change.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

The move of qdisc destruction to a rcu callback broke locking in the
entire qdisc layer by invalidating previously valid assumptions about
the context in which changes to the qdisc tree occur.

The two assumptions were:

- since changes only happen in process context, read_lock doesn't need
  bottem half protection. Now invalid since destruction of inner qdiscs,
  classifiers, actions and estimators happens in the RCU callback unless
  they're manually deleted, resulting in dead-locks when read_lock in
  process context is interrupted by write_lock_bh in bottem half context.

- since changes only happen under the RTNL, no additional locking is
  necessary for data not used during packet processing (f.e. u32_list).
  Again, since destruction now happens in the RCU callback, this assumption
  is not valid anymore, causing races while using this data, which can
  result in corruption or use-after-free.

Instead of "fixing" this by disabling bottem halfs everywhere and adding
new locks/refcounting, this patch makes these assumptions valid again by
moving destruction back to process context. Since only the dev->qdisc
pointer is protected by RCU, but ->enqueue and the qdisc tree are still
protected by dev->qdisc_lock, destruction of the tree can be performed
immediately and only the final free needs to happen in the rcu callback
to make sure dev_queue_xmit doesn't access already freed memory.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/dev.c          |   14 +++++-----
 net/sched/cls_api.c     |    4 +-
 net/sched/sch_api.c     |   16 +++++------
 net/sched/sch_generic.c |   66 +++++++++++++++---------------------------------
 4 files changed, 39 insertions(+), 61 deletions(-)

--- linux-2.6.18.orig/net/core/dev.c
+++ linux-2.6.18/net/core/dev.c
@@ -1478,14 +1478,16 @@ gso:
 	if (q->enqueue) {
 		/* Grab device queue */
 		spin_lock(&dev->queue_lock);
+		q = dev->qdisc;
+		if (q->enqueue) {
+			rc = q->enqueue(skb, q);
+			qdisc_run(dev);
+			spin_unlock(&dev->queue_lock);
 
-		rc = q->enqueue(skb, q);
-
-		qdisc_run(dev);
-
+			rc = rc == NET_XMIT_BYPASS ? NET_XMIT_SUCCESS : rc;
+			goto out;
+		}
 		spin_unlock(&dev->queue_lock);
-		rc = rc == NET_XMIT_BYPASS ? NET_XMIT_SUCCESS : rc;
-		goto out;
 	}
 
 	/* The device has no queue. Common case for software devices:
--- linux-2.6.18.orig/net/sched/cls_api.c
+++ linux-2.6.18/net/sched/cls_api.c
@@ -401,7 +401,7 @@ static int tc_dump_tfilter(struct sk_buf
 	if ((dev = dev_get_by_index(tcm->tcm_ifindex)) == NULL)
 		return skb->len;
 
-	read_lock_bh(&qdisc_tree_lock);
+	read_lock(&qdisc_tree_lock);
 	if (!tcm->tcm_parent)
 		q = dev->qdisc_sleeping;
 	else
@@ -458,7 +458,7 @@ errout:
 	if (cl)
 		cops->put(q, cl);
 out:
-	read_unlock_bh(&qdisc_tree_lock);
+	read_unlock(&qdisc_tree_lock);
 	dev_put(dev);
 	return skb->len;
 }
--- linux-2.6.18.orig/net/sched/sch_api.c
+++ linux-2.6.18/net/sched/sch_api.c
@@ -195,14 +195,14 @@ struct Qdisc *qdisc_lookup(struct net_de
 {
 	struct Qdisc *q;
 
-	read_lock_bh(&qdisc_tree_lock);
+	read_lock(&qdisc_tree_lock);
 	list_for_each_entry(q, &dev->qdisc_list, list) {
 		if (q->handle == handle) {
-			read_unlock_bh(&qdisc_tree_lock);
+			read_unlock(&qdisc_tree_lock);
 			return q;
 		}
 	}
-	read_unlock_bh(&qdisc_tree_lock);
+	read_unlock(&qdisc_tree_lock);
 	return NULL;
 }
 
@@ -837,7 +837,7 @@ static int tc_dump_qdisc(struct sk_buff 
 			continue;
 		if (idx > s_idx)
 			s_q_idx = 0;
-		read_lock_bh(&qdisc_tree_lock);
+		read_lock(&qdisc_tree_lock);
 		q_idx = 0;
 		list_for_each_entry(q, &dev->qdisc_list, list) {
 			if (q_idx < s_q_idx) {
@@ -846,12 +846,12 @@ static int tc_dump_qdisc(struct sk_buff 
 			}
 			if (tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).pid,
 					  cb->nlh->nlmsg_seq, NLM_F_MULTI, RTM_NEWQDISC) <= 0) {
-				read_unlock_bh(&qdisc_tree_lock);
+				read_unlock(&qdisc_tree_lock);
 				goto done;
 			}
 			q_idx++;
 		}
-		read_unlock_bh(&qdisc_tree_lock);
+		read_unlock(&qdisc_tree_lock);
 	}
 
 done:
@@ -1074,7 +1074,7 @@ static int tc_dump_tclass(struct sk_buff
 	s_t = cb->args[0];
 	t = 0;
 
-	read_lock_bh(&qdisc_tree_lock);
+	read_lock(&qdisc_tree_lock);
 	list_for_each_entry(q, &dev->qdisc_list, list) {
 		if (t < s_t || !q->ops->cl_ops ||
 		    (tcm->tcm_parent &&
@@ -1096,7 +1096,7 @@ static int tc_dump_tclass(struct sk_buff
 			break;
 		t++;
 	}
-	read_unlock_bh(&qdisc_tree_lock);
+	read_unlock(&qdisc_tree_lock);
 
 	cb->args[0] = t;
 
--- linux-2.6.18.orig/net/sched/sch_generic.c
+++ linux-2.6.18/net/sched/sch_generic.c
@@ -45,11 +45,10 @@
    The idea is the following:
    - enqueue, dequeue are serialized via top level device
      spinlock dev->queue_lock.
-   - tree walking is protected by read_lock_bh(qdisc_tree_lock)
+   - tree walking is protected by read_lock(qdisc_tree_lock)
      and this lock is used only in process context.
-   - updates to tree are made under rtnl semaphore or
-     from softirq context (__qdisc_destroy rcu-callback)
-     hence this lock needs local bh disabling.
+   - updates to tree are made only under rtnl semaphore,
+     hence this lock may be made without local bh disabling.
 
    qdisc_tree_lock must be grabbed BEFORE dev->queue_lock!
  */
@@ -57,14 +56,14 @@ DEFINE_RWLOCK(qdisc_tree_lock);
 
 void qdisc_lock_tree(struct net_device *dev)
 {
-	write_lock_bh(&qdisc_tree_lock);
+	write_lock(&qdisc_tree_lock);
 	spin_lock_bh(&dev->queue_lock);
 }
 
 void qdisc_unlock_tree(struct net_device *dev)
 {
 	spin_unlock_bh(&dev->queue_lock);
-	write_unlock_bh(&qdisc_tree_lock);
+	write_unlock(&qdisc_tree_lock);
 }
 
 /* 
@@ -483,20 +482,6 @@ void qdisc_reset(struct Qdisc *qdisc)
 static void __qdisc_destroy(struct rcu_head *head)
 {
 	struct Qdisc *qdisc = container_of(head, struct Qdisc, q_rcu);
-	struct Qdisc_ops  *ops = qdisc->ops;
-
-#ifdef CONFIG_NET_ESTIMATOR
-	gen_kill_estimator(&qdisc->bstats, &qdisc->rate_est);
-#endif
-	write_lock(&qdisc_tree_lock);
-	if (ops->reset)
-		ops->reset(qdisc);
-	if (ops->destroy)
-		ops->destroy(qdisc);
-	write_unlock(&qdisc_tree_lock);
-	module_put(ops->owner);
-
-	dev_put(qdisc->dev);
 	kfree((char *) qdisc - qdisc->padded);
 }
 
@@ -504,32 +489,23 @@ static void __qdisc_destroy(struct rcu_h
 
 void qdisc_destroy(struct Qdisc *qdisc)
 {
-	struct list_head cql = LIST_HEAD_INIT(cql);
-	struct Qdisc *cq, *q, *n;
+	struct Qdisc_ops  *ops = qdisc->ops;
 
 	if (qdisc->flags & TCQ_F_BUILTIN ||
-		!atomic_dec_and_test(&qdisc->refcnt))
+	    !atomic_dec_and_test(&qdisc->refcnt))
 		return;
 
-	if (!list_empty(&qdisc->list)) {
-		if (qdisc->ops->cl_ops == NULL)
-			list_del(&qdisc->list);
-		else
-			list_move(&qdisc->list, &cql);
-	}
-
-	/* unlink inner qdiscs from dev->qdisc_list immediately */
-	list_for_each_entry(cq, &cql, list)
-		list_for_each_entry_safe(q, n, &qdisc->dev->qdisc_list, list)
-			if (TC_H_MAJ(q->parent) == TC_H_MAJ(cq->handle)) {
-				if (q->ops->cl_ops == NULL)
-					list_del_init(&q->list);
-				else
-					list_move_tail(&q->list, &cql);
-			}
-	list_for_each_entry_safe(cq, n, &cql, list)
-		list_del_init(&cq->list);
+	list_del(&qdisc->list);
+#ifdef CONFIG_NET_ESTIMATOR
+	gen_kill_estimator(&qdisc->bstats, &qdisc->rate_est);
+#endif
+	if (ops->reset)
+		ops->reset(qdisc);
+	if (ops->destroy)
+		ops->destroy(qdisc);
 
+	module_put(ops->owner);
+	dev_put(qdisc->dev);
 	call_rcu(&qdisc->q_rcu, __qdisc_destroy);
 }
 
@@ -549,15 +525,15 @@ void dev_activate(struct net_device *dev
 				printk(KERN_INFO "%s: activation failed\n", dev->name);
 				return;
 			}
-			write_lock_bh(&qdisc_tree_lock);
+			write_lock(&qdisc_tree_lock);
 			list_add_tail(&qdisc->list, &dev->qdisc_list);
-			write_unlock_bh(&qdisc_tree_lock);
+			write_unlock(&qdisc_tree_lock);
 		} else {
 			qdisc =  &noqueue_qdisc;
 		}
-		write_lock_bh(&qdisc_tree_lock);
+		write_lock(&qdisc_tree_lock);
 		dev->qdisc_sleeping = qdisc;
-		write_unlock_bh(&qdisc_tree_lock);
+		write_unlock(&qdisc_tree_lock);
 	}
 
 	if (!netif_carrier_ok(dev))

--
