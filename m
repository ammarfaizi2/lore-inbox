Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbTCQPeX>; Mon, 17 Mar 2003 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbTCQPeX>; Mon, 17 Mar 2003 10:34:23 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:53153 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261745AbTCQPeV>; Mon, 17 Mar 2003 10:34:21 -0500
Message-Id: <200303171543.h2HFhFGi012501@locutus.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@digeo.com>, davem@redhat.com,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] Re: 2.5.64-mm8: drivers/atm/idt77252.c doesn't compile 
In-reply-to: Your message of "Sun, 16 Mar 2003 16:44:14 +0100."
             <20030316154414.GB10253@fs.tum.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 17 Mar 2003 10:43:15 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030316154414.GB10253@fs.tum.de>,Adrian Bunk writes:
> tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
> drivers/atm/idt77252.c still needs it:

it doesnt need it -- it just needs to use the right member.  the following
patch should fix the current errors.  i missed these bits during my
earlier changes.


Index: linux/net/sched/sch_atm.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/sched/sch_atm.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- linux/net/sched/sch_atm.c	20 Feb 2003 13:46:33 -0000	1.1.1.1
+++ linux/net/sched/sch_atm.c	11 Mar 2003 15:20:25 -0000	1.2
@@ -508,7 +508,7 @@
 			ATM_SKB(skb)->vcc = flow->vcc;
 			memcpy(skb_push(skb,flow->hdr_len),flow->hdr,
 			    flow->hdr_len);
-			atomic_add(skb->truesize,&flow->vcc->tx_inuse);
+			atomic_add(skb->truesize,&flow->vcc->sk->wmem_alloc);
 			ATM_SKB(skb)->iovcnt = 0;
 			/* atm.atm_options are already set by atm_tc_enqueue */
 			(void) flow->vcc->send(flow->vcc,skb);
Index: linux/net/atm/pppoatm.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/pppoatm.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pppoatm.c
--- linux/net/atm/pppoatm.c	20 Feb 2003 13:46:30 -0000	1.1.1.1
+++ linux/net/atm/pppoatm.c	15 Mar 2003 14:35:27 -0000
@@ -231,7 +231,7 @@
 		kfree_skb(skb);
 		return 1;
 	}
-	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->tx_inuse);
+	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = ATM_SKB(skb)->vcc->atm_options;
 	DPRINTK("(unit %d): atm_skb(%p)->vcc(%p)->dev(%p)\n",
Index: linux/drivers/atm/idt77252.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/idt77252.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 idt77252.c
--- linux/drivers/atm/idt77252.c	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/idt77252.c	16 Mar 2003 13:17:56 -0000
@@ -730,7 +730,7 @@
 		struct atm_vcc *vcc = vc->tx_vcc;
 
 		vc->estimator->cells += (skb->len + 47) / 48;
-		if (atomic_read(&vcc->tx_inuse) > (vcc->sk->sndbuf >> 1)) {
+		if (atomic_read(&vcc->sk->wmem_alloc) > (vcc->sk->sndbuf >> 1)) {
 			u32 cps = vc->estimator->maxcps;
 
 			vc->estimator->cps = cps;
@@ -2025,7 +2025,7 @@
 		atomic_inc(&vcc->stats->tx_err);
 		return -ENOMEM;
 	}
-	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->tx_inuse);
+	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 
 	memcpy(skb_put(skb, 52), cell, 52);
