Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbTCSCZ4>; Tue, 18 Mar 2003 21:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262890AbTCSCZ4>; Tue, 18 Mar 2003 21:25:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262886AbTCSCZz>;
	Tue, 18 Mar 2003 21:25:55 -0500
Date: Wed, 19 Mar 2003 02:36:51 +0000
From: Matthew Wilcox <willy@debian.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix remaining references to tx_inuse
Message-ID: <20030319023651.GP14520@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3 files still use it:

diff -urpNX ../dontdiff linux-2.5.65/drivers/atm/idt77252.c linux-2.5.65-atm/drivers/atm/idt77252.c
--- linux-2.5.65/drivers/atm/idt77252.c	2002-11-17 23:29:45.000000000 -0500
+++ linux-2.5.65-atm/drivers/atm/idt77252.c	2003-03-18 14:22:53.000000000 -0500
@@ -730,7 +730,7 @@ push_on_scq(struct idt77252_dev *card, s
 		struct atm_vcc *vcc = vc->tx_vcc;
 
 		vc->estimator->cells += (skb->len + 47) / 48;
-		if (atomic_read(&vcc->tx_inuse) > (vcc->sk->sndbuf >> 1)) {
+		if (atomic_read(&vcc->sk->wmem_alloc) > (vcc->sk->sndbuf >> 1)) {
 			u32 cps = vc->estimator->maxcps;
 
 			vc->estimator->cps = cps;
@@ -2025,7 +2025,7 @@ idt77252_send_oam(struct atm_vcc *vcc, v
 		atomic_inc(&vcc->stats->tx_err);
 		return -ENOMEM;
 	}
-	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->tx_inuse);
+	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 
 	memcpy(skb_put(skb, 52), cell, 52);
diff -urpNX ../dontdiff linux-2.5.65/net/atm/pppoatm.c linux-2.5.65-atm/net/atm/pppoatm.c
--- linux-2.5.65/net/atm/pppoatm.c	2002-11-17 23:29:50.000000000 -0500
+++ linux-2.5.65-atm/net/atm/pppoatm.c	2003-03-18 21:16:21.000000000 -0500
@@ -231,7 +231,7 @@ static int pppoatm_send(struct ppp_chann
 		kfree_skb(skb);
 		return 1;
 	}
-	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->tx_inuse);
+	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = ATM_SKB(skb)->vcc->atm_options;
 	DPRINTK("(unit %d): atm_skb(%p)->vcc(%p)->dev(%p)\n",
diff -urpNX ../dontdiff linux-2.5.65/net/sched/sch_atm.c linux-2.5.65-atm/net/sched/sch_atm.c
--- linux-2.5.65/net/sched/sch_atm.c	2003-02-25 09:33:34.000000000 -0500
+++ linux-2.5.65-atm/net/sched/sch_atm.c	2003-03-18 21:25:11.000000000 -0500
@@ -508,7 +508,7 @@ static void sch_atm_dequeue(unsigned lon
 			ATM_SKB(skb)->vcc = flow->vcc;
 			memcpy(skb_push(skb,flow->hdr_len),flow->hdr,
 			    flow->hdr_len);
-			atomic_add(skb->truesize,&flow->vcc->tx_inuse);
+			atomic_add(skb->truesize,&flow->vcc->sk->wmem_alloc);
 			ATM_SKB(skb)->iovcnt = 0;
 			/* atm.atm_options are already set by atm_tc_enqueue */
 			(void) flow->vcc->send(flow->vcc,skb);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
