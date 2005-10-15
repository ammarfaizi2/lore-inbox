Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVJOH5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVJOH5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVJOH5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:57:42 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:60063 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S1751113AbVJOH5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:57:41 -0400
Date: Sat, 15 Oct 2005 00:57:23 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510150757.j9F7vNv8006813@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, suzannew@cs.pdx.edu,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you and sorry if I'm belaboring this.

  > From herbert@gondor.apana.org.au  Fri Oct 14 15:36:36 2005

  > On Fri, Oct 14, 2005 at 09:38:54AM -0700, Suzanne Wood wrote:
  > > 
  > > ChangeLog:
  > > Because bpq_new_device() calls list_add_rcu()
  > > and bpq_free_device() calls list_del_rcu(),
  > > substitute list_for_each_entry_rcu() for 
  > > list_for_each_entry() in bpq_get_ax25_dev().
  > > This requires the insertion of rcu_read_lock()/unlock().

  > The rcu_read_lock/unlock is unnecessary because the only caller that
  > doesn't hold RTNL (bpq_rcv) already takes that lock.  In fact it's
  > better to take it there since you need to hold the lock for the duration
  > of the use of the device.

  > > A consequence of list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list)
  > > is that the future dereference of the pointer to the bpqdev 
  > > struct bpq is rcu-protected.  But bpq_get_ax25_dev() 
  > > returns bpq->axdev, a pointer to a net_device struct.  The 
  > > rcu_read_lock() in bpq_rcv() likely implies that is another 
  > > pointer to receive rcu-protected dereference.

Thought this was an example of protecting a pointer dereference of an object
and then wanting deferred destruction to extend to a field of that object 
which is pointer to a different object, similar to traversing a list.
So I guess the dereference being protected is bpq->axdev and not a deref
of that pointer to the net_device struct, since we see the fields of dev
being assigned within the rcu read-side critical section.  Thank you for
correcting me on this.

  > The rcu_dereference should be provided by list_for_each_entry_rcu.
  > In fact there is a bug in the list_*_rcu macros where the first
  > element is not put through rcu_dereference.  I'll fix that up.

This is very significant.

  > > The rcu_read_lock()/unlock() in bpq_device_event() 
  > > are removed due to the following found by considering 
  > > the cases of the switch statement: 

  > Agreed.

Another list_for_each_entry() in bpq_seq_start() in a marked rcu 
read-side critical section becomes the rcu version.

Please consider a corrected patch attached.
Thank you.


-------

 bpqether.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

-------

--- src/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-10 18:19:19.000000000 -0700
+++ patch/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-15 00:42:14.000000000 -0700
@@ -144,7 +144,7 @@ static inline struct net_device *bpq_get
 {
 	struct bpqdev *bpq;
 
-	list_for_each_entry(bpq, &bpq_devices, bpq_list) {
+	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {
 		if (bpq->ethdev == dev)
 			return bpq->axdev;
 	}
@@ -399,7 +399,7 @@ static void *bpq_seq_start(struct seq_fi
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 	
-	list_for_each_entry(bpqdev, &bpq_devices, bpq_list) {
+	list_for_each_entry_rcu(bpqdev, &bpq_devices, bpq_list) {
 		if (i == *pos)
 			return bpqdev;
 	}
@@ -561,8 +561,6 @@ static int bpq_device_event(struct notif
 	if (!dev_is_ethdev(dev))
 		return NOTIFY_DONE;
 
-	rcu_read_lock();
-
 	switch (event) {
 	case NETDEV_UP:		/* new ethernet device -> new BPQ interface */
 		if (bpq_get_ax25_dev(dev) == NULL)
@@ -581,7 +579,6 @@ static int bpq_device_event(struct notif
 	default:
 		break;
 	}
-	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
