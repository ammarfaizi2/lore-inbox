Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVJPREA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVJPREA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVJPRD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 13:03:59 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:56496 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S1751327AbVJPRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 13:03:59 -0400
Date: Sun, 16 Oct 2005 10:03:40 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510161703.j9GH3e2T020226@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au, ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > Date: Sun, 16 Oct 2005 17:21:36 +1000
  > From: Herbert Xu <herbert@gondor.apana.org.au>

  > On Sat, Oct 15, 2005 at 03:24:57PM -0700, Suzanne Wood wrote:
  > > 
  > > Please find attached a patch to drivers/net/hamradio/bpqether.c
  > > that might finally merit being
  > > Signed-off-by: suzannew@cs.pdx.edu

  > Looks good to me.

  > Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

  > You might want to send this patch to ralf@linux-mips.org who
  > is the current maintainer.

Thank you for providing the next step, too.

-------

ChangeLog: clarify RCU implementation in 
drivers/net/hamradio/bpqether.c 

Because bpq_new_device() calls list_add_rcu()
and bpq_free_device() calls list_del_rcu(),
substitute list_for_each_entry_rcu() for 
list_for_each_entry() in bpq_get_ax25_dev()
and in bpq_seq_start().

Add rcu dereference protection in bpq_seq_next().

The rcu_read_lock()/unlock() in bpq_device_event() 
are removed because netdev event handlers are called 
with RTNL locking in place.

FYI: bpq_free_device() calls list_del_rcu() which, per 
list.h, requires synchronize_rcu() which can block or 
call_rcu() or call_rcu_bh() which cannot block. 
Herbert Xu notes that synchronization is done here by 
unregister_netdevice().  This calls synchronize_net()
which in turn uses synchronize_rcu().

-------

 bpqether.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

-------

--- src/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-10 18:19:19.000000000 -0700
+++ patch/linux-2.6.14-rc4/drivers/net/hamradio/bpqether.c	2005-10-15 15:12:15.000000000 -0700
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
@@ -418,7 +418,7 @@ static void *bpq_seq_next(struct seq_fil
 		p = ((struct bpqdev *)v)->bpq_list.next;
 
 	return (p == &bpq_devices) ? NULL 
-		: list_entry(p, struct bpqdev, bpq_list);
+		: rcu_dereference(list_entry(p, struct bpqdev, bpq_list));
 }
 
 static void bpq_seq_stop(struct seq_file *seq, void *v)
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

