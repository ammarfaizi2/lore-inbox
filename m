Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVIFNAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVIFNAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVIFNAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:00:10 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43759 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932455AbVIFNAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:00:08 -0400
Date: Tue, 6 Sep 2005 15:03:09 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/4] s390: claw driver fixes
Message-ID: <20050906130309.GD9265@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 1/4] s390: claw driver fixes

From: Andy Richter <richtera@us.ibm.com>
	- change memory allocation and move dbf from proc to debugfs
	- use dev_kfree_skb_any instead of dev_kfree_skb_irq

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 claw.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -Naupr linux-2.6-orig/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6-orig/drivers/s390/net/claw.c	2005-09-05 11:46:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/claw.c	2005-09-05 15:18:59.000000000 +0200
@@ -2,9 +2,9 @@
  *  drivers/s390/net/claw.c
  *    ESCON CLAW network driver
  *
- *    $Revision: 1.35 $ $Date: 2005/03/24 12:25:38 $
+ *    $Revision: 1.38 $ $Date: 2005/08/29 09:47:04 $
  *
- *  Linux fo zSeries version
+ *  Linux for zSeries version
  *    Copyright (C) 2002,2005 IBM Corporation
  *  Author(s) Original code written by:
  *              Kazuo Iimura (iimura@jp.ibm.com)
@@ -431,12 +431,12 @@ claw_pack_skb(struct claw_privbk *privpt
 	if (!skb_queue_empty(&p_ch->collect_queue)) {
 	/* some data */
 		held_skb = skb_dequeue(&p_ch->collect_queue);
-		if (p_env->packing != DO_PACKED)
-			return held_skb;
 		if (held_skb)
-			atomic_dec(&held_skb->users);
+			dev_kfree_skb_any(held_skb);
 		else
 			return NULL;
+		if (p_env->packing != DO_PACKED)
+			return held_skb;
 		/* get a new SKB we will pack at least one */
 		new_skb = dev_alloc_skb(p_env->write_size);
 		if (new_skb == NULL) {
@@ -455,7 +455,7 @@ claw_pack_skb(struct claw_privbk *privpt
 				privptr->stats.tx_packets++;
 				so_far += held_skb->len;
 				pkt_cnt++;
-				dev_kfree_skb_irq(held_skb);
+				dev_kfree_skb_any(held_skb);
 				held_skb = skb_dequeue(&p_ch->collect_queue);
 				if (held_skb)
 					atomic_dec(&held_skb->users);
@@ -1092,7 +1092,7 @@ claw_release(struct net_device *dev)
                 }
         }
 	if (privptr->pk_skb != NULL) {
-		dev_kfree_skb(privptr->pk_skb);
+		dev_kfree_skb_any(privptr->pk_skb);
 		privptr->pk_skb = NULL;
 	}
 	if(privptr->buffs_alloc != 1) {
@@ -2016,7 +2016,7 @@ claw_hw_tx(struct sk_buff *skb, struct n
         p_buf=(struct ccwbk*)privptr->p_end_ccw;
         dumpit((char *)p_buf, sizeof(struct endccw));
 #endif
-        dev_kfree_skb(skb);
+        dev_kfree_skb_any(skb);
 	if (linkid==0) {
         	lock=LOCK_NO;
         }
@@ -4061,7 +4061,7 @@ claw_purge_skb_queue(struct sk_buff_head
 
         while ((skb = skb_dequeue(q))) {
                 atomic_dec(&skb->users);
-                dev_kfree_skb_irq(skb);
+                dev_kfree_skb_any(skb);
         }
 }
 
@@ -4410,7 +4410,7 @@ claw_init(void)
 #else
                 "compiled into kernel "
 #endif
-                " $Revision: 1.35 $ $Date: 2005/03/24 12:25:38 $ \n");
+                " $Revision: 1.38 $ $Date: 2005/08/29 09:47:04 $ \n");
 
 
 #ifdef FUNCTRACE
