Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbRGSMb1>; Thu, 19 Jul 2001 08:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGSMbS>; Thu, 19 Jul 2001 08:31:18 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:410 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S267541AbRGSMbI>; Thu, 19 Jul 2001 08:31:08 -0400
Reply-To: mostrows@speakeasy.net
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Friedley <saai@swbell.net>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com, prefect_@gmx.net,
        moritz@chaosdorf.de, egger@suse.de, srwalter@yahoo.com,
        kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
	<15189.2408.59953.395204@pizda.ninka.net>
From: Michal Ostrowski <mostrows@us.ibm.com>
Date: 19 Jul 2001 08:30:37 -0400
In-Reply-To: <15189.2408.59953.395204@pizda.ninka.net>
Message-ID: <sb6r8vdgkya.fsf@slug.watson.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


After sleeping on it a bit I've come to the realization that are
still some issues outstanding.

Essentially, if __pppoe_xmit has been forced to make a copy of the skb
(because netfilter did not leave enough room for PPPoE headers), and
dev_queue_xmit fails, the copy of the skb is not freed and we have a
memory leak.

The generic PPP layer assumes that if a PPP-channel's xmit routine
fails then the skb is still available to it (for retransmission) and
otherwise the skb is gone -- handled by the channel.  These are the
semantics that must be implemented by __pppoe_xmit.

The patch below (which requires David Miller's patch from 17/07/01)
implements these semantics.

Michal Ostrowski
mostrows@speakeasy.net

--- drivers/net/pppoe.c~	Wed Jul 18 10:24:25 2001
+++ drivers/net/pppoe.c	Thu Jul 19 08:28:56 2001
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
@@ -849,6 +853,7 @@
 	struct pppoe_hdr *ph;
 	int headroom = skb_headroom(skb);
 	int data_len = skb->len;
+	struct sk_buff *old_skb = NULL;
 
 	if (sk->dead  || !(sk->state & PPPOX_CONNECTED))
 		goto abort;
@@ -876,17 +881,12 @@
 		skb_reserve(skb2, dev->hard_header_len + sizeof(struct pppoe_hdr));
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
 
-		skb_unlink(skb);
-		kfree_skb(skb);
+		/* Keep a reference to the original */
+		old_skb = skb;
+
 		skb = skb2;
 	}
 
-	/* We may not return error beyond this point.  Potentially this
-	 * is a new SKB and in such a case we've already freed the
-	 * original SKB.  So if we were to return error, our caller would
-	 * double free that original SKB. -DaveM
-	 */
-
 	ph = (struct pppoe_hdr *) skb_push(skb, sizeof(struct pppoe_hdr));
 	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
 	skb->protocol = __constant_htons(ETH_P_PPP_SES);
@@ -899,7 +899,34 @@
 			 sk->protinfo.pppox->pppoe_pa.remote,
 			 NULL, data_len);
 
-	dev_queue_xmit(skb);
+	/* The skb we are to transmit may be a copy (see above).  If
+	 * this fails, then the caller is responsible for the original
+	 * skb, otherwise we must free it.  Also if this fails we must
+	 * free the copy that we made.
+	 */
+
+	if (dev_queue_xmit(skb)<0) {
+		if (old_skb) {
+			/* The skb we tried to send was a copy.  We
+			 * have to free it (the copy) and let the
+			 * caller deal with the original one.
+			 */
+			skb_unlink(skb);
+			kfree_skb(skb);
+		}
+		goto abort;
+	}
+
+	/* Free original skb now that we know dev_queue_xmit
+	 * succeeded.  We free only "old_skb" because dev_queue_xmit
+	 * actually sent a copy, not the original.
+	 */
+
+	if (old_skb) {
+		skb_unlink(old_skb);
+		kfree_skb(old_skb);
+	}
+
 	return 1;
 
 abort:
@@ -1049,7 +1076,6 @@
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
 

