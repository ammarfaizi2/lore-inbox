Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRGSS6B>; Thu, 19 Jul 2001 14:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbRGSS5x>; Thu, 19 Jul 2001 14:57:53 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:48797 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S265810AbRGSS5e>; Thu, 19 Jul 2001 14:57:34 -0400
Reply-To: mostrows@us.ibm.com
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
	<15189.2408.59953.395204@pizda.ninka.net>
From: Michal Ostrowski <mostrows@us.ibm.com>
Date: 19 Jul 2001 14:57:21 -0400
In-Reply-To: <15189.2408.59953.395204@pizda.ninka.net>
Message-ID: <sb6r8vcg31q.fsf@slug.watson.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alexey replied to my last post with some valuable comments and in
response I have a new patch (that goes on top of David Miller's patch
from yesterday).

The approach here is that in case we don't have room in the skb for
PPPoE headers, we create a new one (skb2) and copy the entire thing.
If we do have space, we clone it.  We always give dev_queue_xmit the
copy/clone pointer and let it free it.  We then kfree_skb the original
skb depending on the return value of dev_queue_xmit (to conform to the
expectations of ppp_generic).

Michal Ostrowski
mostrows@speakeasy.net

--- drivers/net/pppoe.c~	Wed Jul 18 10:24:25 2001
+++ drivers/net/pppoe.c	Thu Jul 19 14:49:36 2001
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.7
+ * Version:    0.6.8
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :	Fixed potential SMP problems; we must protect against
@@ -25,8 +25,12 @@
  *		locked. (DaveM)
  *		Ignore return value of dev_queue_xmit in __pppoe_xmit
  *		or else we may kfree an SKB twice. (DaveM)
+ * 190701 :	When doing copies of skb's in __pppoe_xmit, always delete
+ *		the original skb that was passed in on success, never on
+ *		failure.  Delete the copy of the skb on failure to avoid
+ *		a memory leak.
  *
- * Author:	Michal Ostrowski <mostrows@styx.uwaterloo.ca>
+ * Author:	Michal Ostrowski <mostrows@speakeasy.net>
  * Contributors:
  * 		Arnaldo Carvalho de Melo <acme@xconectiva.com.br>
  *		David S. Miller (davem@redhat.com)
@@ -837,6 +841,7 @@
 	return error;
 }
 
+
 /************************************************************************
  *
  * xmit function for internal use.
@@ -849,6 +854,7 @@
 	struct pppoe_hdr *ph;
 	int headroom = skb_headroom(skb);
 	int data_len = skb->len;
+	struct sk_buff *skb2;
 
 	if (sk->dead  || !(sk->state & PPPOX_CONNECTED))
 		goto abort;
@@ -864,7 +870,6 @@
 
 	/* Copy the skb if there is no space for the header. */
 	if (headroom < (sizeof(struct pppoe_hdr) + dev->hard_header_len)) {
-		struct sk_buff *skb2;
 
 		skb2 = dev_alloc_skb(32+skb->len +
 				     sizeof(struct pppoe_hdr) +
@@ -876,30 +881,36 @@
 		skb_reserve(skb2, dev->hard_header_len + sizeof(struct pppoe_hdr));
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
 
-		skb_unlink(skb);
-		kfree_skb(skb);
-		skb = skb2;
+	} else {
+		/* Make a clone so as to not disturb the original skb,
+		 * give dev_queue_xmit something it can free.
+		 */
+		skb2 = skb_clone(skb, GFP_ATOMIC);
 	}
 
-	/* We may not return error beyond this point.  Potentially this
-	 * is a new SKB and in such a case we've already freed the
-	 * original SKB.  So if we were to return error, our caller would
-	 * double free that original SKB. -DaveM
-	 */
-
-	ph = (struct pppoe_hdr *) skb_push(skb, sizeof(struct pppoe_hdr));
+	ph = (struct pppoe_hdr *) skb_push(skb2, sizeof(struct pppoe_hdr));
 	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
-	skb->protocol = __constant_htons(ETH_P_PPP_SES);
+	skb2->protocol = __constant_htons(ETH_P_PPP_SES);
 
-	skb->nh.raw = skb->data;
+	skb2->nh.raw = skb2->data;
 
-	skb->dev = dev;
+	skb2->dev = dev;
 
-	dev->hard_header(skb, dev, ETH_P_PPP_SES,
+	dev->hard_header(skb2, dev, ETH_P_PPP_SES,
 			 sk->protinfo.pppox->pppoe_pa.remote,
 			 NULL, data_len);
 
-	dev_queue_xmit(skb);
+	/* We're transmitting skb2, and assuming that dev_queue_xmit
+	 * will free it.  The generic ppp layer however, is expecting
+	 * that we give back the skb in case of failure,
+	 * but free it in case of success.
+	 */
+
+	if (dev_queue_xmit(skb2)<0) {
+		goto abort;
+	}
+
+	kfree_skb(skb);
 	return 1;
 
 abort:
@@ -1049,7 +1060,6 @@
  	int err = register_pppox_proto(PX_PROTO_OE, &pppoe_proto);
 
 	if (err == 0) {
-		printk(KERN_INFO "Registered PPPoE v0.6.5\n");
 
 		dev_add_pack(&pppoes_ptype);
 		dev_add_pack(&pppoed_ptype);
--- drivers/net/pppox.c~	Tue Feb 13 16:15:05 2001
+++ drivers/net/pppox.c	Wed Jul 18 10:27:25 2001
@@ -148,10 +148,6 @@
 
 	err = sock_register(&pppox_proto_family);
 
-	if (err == 0) {
-		printk(KERN_INFO "Registered PPPoX v0.5\n");
-	}
-
 	return err;
 }
 

