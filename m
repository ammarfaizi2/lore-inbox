Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVJNIJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVJNIJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 04:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJNIJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 04:09:45 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:21239 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S932466AbVJNIJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 04:09:44 -0400
Date: Fri, 14 Oct 2005 01:04:49 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510140804.j9E84nwG026920@rastaban.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: g4klx@g4klx.demon.co.uk, hch@infradead.org, jreuter@yaina.de,
       paulmck@us.ibm.com, suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: [RFC][PATCH] rcu in drivers/net/hamradio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a prior submittal [RFC][PATCH] identify rcu-protected ptr
posted Thu Oct 06 2005 - 01:08:25 EST, the usage of RCU in 
drivers/net/hamradio/bpqether.c was addressed in

> Please consider the effective addition of an
> rcu_dereference() in bpq_get_ax25_dev() in recognition 
> of each use being nested in an rcu critical section.

> diff a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
> --- a/drivers/net/hamradio/bpqether.c 2005-09-30 14:17:35.000000000 -0700
> +++ b/drivers/net/hamradio/bpqether.c 2005-10-05 22:32:53.000000000 -0700
. . .
> - list_for_each_entry(bpq, &bpq_devices, bpq_list) {
> + list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {

Please let me know if any assumptions below are false.
Thank you.

The similarity to drivers/net/wan/lapbether.c supports 
the suggestion above, but the reason used earlier fails 
because I suggest now that the rcu_read_lock()/unlock() 
in bpq_device_event() should be moved due to the 
following found by considering the cases of the 
switch statement: 

(1) bpq_new_device() calls list_add_rcu() labeled as 
"list protected by RTNL."  The comment may need to go 
since the only apparent rtnl_lock()/unlock() pair encloses 
the call to bpq_free_device() in bpq_cleanup_driver()
called upon module_exit().

(2) dev_close() as defined in net/core/dev.c 
employs a memory barrier.

(3) bpq_free_device() calls list_del_rcu() which, according 
to list.h, requires synchronize_rcu() which can block or 
call_rcu() or call_rcu_bh() which cannot block. 
None of these is called anywhere in the directory drivers/net,
so synchronize_irq() may address this.  
(synchronize_sched() is called in drivers/net/sis190.c and 
r8169.c with FIXME comment about synchronize_irq().)

Because the rcu read-side critical section marked by 
rcu_read_lock()/unlock() disables preemption, it is not 
suitable in bpq_device_event() in the context of update.

If RCU is indeed appropriate in bpq_new_device() and 
bpq_free_device() of bpqether.c, then, substituting 
list_for_each_entry_rcu() for list_for_each_entry()
introduces an rcu_dereference on bpq.  This requires the 
marking of the read-side critical section, raising the 
question of the rcu_assign_pointer(), but the list_add_rcu()
introduces the corresponding write memory barrier.

We consider the statements in bpq_rcv()
	rcu_read_lock();
	dev = bpq_get_ax25_dev(dev);

and see that a result of the rcu_dereference() in
list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list)
is that the future dereference of the pointer to the bpqdev 
struct bpq is rcu-protected.  But bpq_get_ax25_dev() 
returns bpq->axdev, a pointer to a net_device struct.  The 
rcu_read_lock() in bpq_rcv() likely implies that is another 
pointer to receive rcu-protected dereference.

As a starting point, please consider the following patch.
Thank you.

-------

 bpqether.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-------


--- src/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-10 18:19:19.000000000 -0700
+++ patch/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-14 00:18:14.000000000 -0700
@@ -144,10 +144,13 @@ static inline struct net_device *bpq_get
 {
 	struct bpqdev *bpq;
 
-	list_for_each_entry(bpq, &bpq_devices, bpq_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {
 		if (bpq->ethdev == dev)
+			rcu_read_unlock();
 			return bpq->axdev;
 	}
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -179,7 +182,7 @@ static int bpq_rcv(struct sk_buff *skb, 
 		goto drop;
 
 	rcu_read_lock();
-	dev = bpq_get_ax25_dev(dev);
+	dev = rcu_dereference(bpq_get_ax25_dev(dev));
 
 	if (dev == NULL || !netif_running(dev)) 
 		goto drop_unlock;
@@ -530,7 +533,6 @@ static int bpq_new_device(struct net_dev
 	if (err)
 		goto error;
 
-	/* List protected by RTNL */
 	list_add_rcu(&bpq->bpq_list, &bpq_devices);
 	return 0;
 
@@ -561,8 +563,6 @@ static int bpq_device_event(struct notif
 	if (!dev_is_ethdev(dev))
 		return NOTIFY_DONE;
 
-	rcu_read_lock();
-
 	switch (event) {
 	case NETDEV_UP:		/* new ethernet device -> new BPQ interface */
 		if (bpq_get_ax25_dev(dev) == NULL)
@@ -581,7 +581,6 @@ static int bpq_device_event(struct notif
 	default:
 		break;
 	}
-	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
