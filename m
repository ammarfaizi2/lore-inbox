Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbQLNVKP>; Thu, 14 Dec 2000 16:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133100AbQLNVKF>; Thu, 14 Dec 2000 16:10:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S133040AbQLNVJv>;
	Thu, 14 Dec 2000 16:09:51 -0500
Date: Thu, 14 Dec 2000 12:23:19 -0800
Message-Id: <200012142023.MAA12823@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mhaque@haque.net
CC: ionut@cs.columbia.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012141535310.12994-100000@viper.haque.net>
	(mhaque@haque.net)
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141535310.12994-100000@viper.haque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 14 Dec 2000 15:35:48 -0500 (EST)
   From: "Mohammad A. Haque" <mhaque@haque.net>

   I'll be trying in a few hours.

Meanwhile for people wanting the crashes to be fixed, please
apply this patch.

This was _always_ broken, and really what netfilter is doing
should have never worked.  The only theory I have right now
is that people using netfilter never had IP fragments timeout.
:-)

So the patch below restores previous behavior exactly.
Ie. netfilter sources fragments cannot send ICMP errors
on frag queue timeout :-)

(The line numbers may be off a bit, but "patch" should still
 eat it).

--- net/ipv4/ip_fragment.c.~1~	Wed Dec 13 10:31:48 2000
+++ net/ipv4/ip_fragment.c	Thu Dec 14 12:20:09 2000
@@ -258,7 +258,8 @@
 	if ((qp->last_in&FIRST_IN) && qp->fragments != NULL) {
 		struct sk_buff *head = qp->fragments;
 		/* Send an ICMP "Fragment Reassembly Timeout" message. */
-		if ((head->dev = dev_get_by_index(qp->iif)) != NULL) {
+		if (qp->iif != -1 &&
+		    (head->dev = dev_get_by_index(qp->iif)) != NULL) {
 			icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
 			dev_put(head->dev);
 		}
@@ -487,8 +488,12 @@
 	else
 		qp->fragments = skb;
 
-	qp->iif = skb->dev->ifindex;
-	skb->dev = NULL;
+	if (skb->dev != NULL) {
+		qp->iif = skb->dev->ifindex;
+		skb->dev = NULL;
+	} else
+		qp->iif = -1;
+
 	qp->stamp = skb->stamp;
 	qp->meat += skb->len;
 	atomic_add(skb->truesize, &ip_frag_mem);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
