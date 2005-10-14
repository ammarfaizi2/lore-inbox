Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVJNQqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVJNQqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJNQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 12:46:13 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:46571 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S1750795AbVJNQqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 12:46:13 -0400
Date: Fri, 14 Oct 2005 09:38:54 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510141638.j9EGcsJa000437@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc: g4klx@g4klx.demon.co.uk, hch@infradead.org, jreuter@yaina.de,
       paulmck@us.ibm.com, suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you and please consider the following patch to drivers/net/hamradio/bpqether.c.

> From: "Herbert Xu" 
> Sent: Friday, October 14, 2005 6:37 AM
>
> Suzanne Wood <suzannew@cs.pdx.edu> wrote:
>>
>> (1) bpq_new_device() calls list_add_rcu() labeled as 
>> "list protected by RTNL."  The comment may need to go 
>> since the only apparent rtnl_lock()/unlock() pair encloses 
>> the call to bpq_free_device() in bpq_cleanup_driver()
>> called upon module_exit().
> 
> The RTNL comment is correct actually.
> 
> bpq_new_device can only be called from bpq_device_event which
> is called from a netdev event handler.  All netdev event handlers
> must be called uner the RTNL.

Thank you very much.  I'll reinstate the comment and  
submit this corrected patch
Signed-off-by: suzannew@cs.pdx.edu

ChangeLog:
Because bpq_new_device() calls list_add_rcu()
and bpq_free_device() calls list_del_rcu(),
substitute list_for_each_entry_rcu() for 
list_for_each_entry() in bpq_get_ax25_dev().
This requires the insertion of rcu_read_lock()/unlock().

A consequence of list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list)
is that the future dereference of the pointer to the bpqdev 
struct bpq is rcu-protected.  But bpq_get_ax25_dev() 
returns bpq->axdev, a pointer to a net_device struct.  The 
rcu_read_lock() in bpq_rcv() likely implies that is another 
pointer to receive rcu-protected dereference.

The rcu_read_lock()/unlock() in bpq_device_event() 
are removed due to the following found by considering 
the cases of the switch statement: 

(1) bpq_new_device() calls list_add_rcu() labeled as 
"list protected by RTNL."  

(2) dev_close() as defined in net/core/dev.c 
employs a memory barrier.

(3) bpq_free_device() calls list_del_rcu() which, according 
to list.h, requires synchronize_rcu() which can block or 
call_rcu() or call_rcu_bh() which cannot block. 
None of these is called anywhere in the directory drivers/net,
so synchronize_irq() might address this.  

-------

 bpqether.c | 11 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-------

--- src/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-10 18:19:19.000000000 -0700
+++ patch/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-14 08:56:12.000000000 -0700
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
@@ -561,8 +564,6 @@ static int bpq_device_event(struct notif
 	if (!dev_is_ethdev(dev))
 		return NOTIFY_DONE;
 
-	rcu_read_lock();
-
 	switch (event) {
 	case NETDEV_UP:		/* new ethernet device -> new BPQ interface */
 		if (bpq_get_ax25_dev(dev) == NULL)
@@ -581,7 +582,6 @@ static int bpq_device_event(struct notif
 	default:
 		break;
 	}
-	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
