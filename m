Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSF0P6e>; Thu, 27 Jun 2002 11:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSF0P6d>; Thu, 27 Jun 2002 11:58:33 -0400
Received: from mons.uio.no ([129.240.130.14]:48003 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316795AbSF0P6c>;
	Thu, 27 Jun 2002 11:58:32 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
Subject: Fragment flooding in 2.4.x/2.5.x
Date: Thu, 27 Jun 2002 17:57:39 +0200
User-Agent: KMail/1.4.1
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3CGD5AIS88TX9N8JDLPN"
Message-Id: <200206271757.39577.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_3CGD5AIS88TX9N8JDLPN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi David,

  I have a question about the case of non-blocking sends in 
ip_build_xmit_slow(). While investigating a problem with the RH7.3 kernel 
causing the Netapp filer IP stack to blow up, we've observed that use of the 
MSG_DONTWAIT flag causes some pretty nasty behaviour.

The fact that fragments are immediately queued for sending means that if 
sock_alloc_send_skb() fails at some point in the middle of the process of 
building the message, then you've ended up sending off a bunch of fragments 
for which there is not even a header (can be a large source of wasted 
bandwidth given heavy NFS traffic).

The appended patch which was originally designed purely to test inverting the 
sending order of fragments (on the hypothesis that the receiving devices were 
making buffer management assumptions based on ordering), removes this effect 
because it delays sending off the fragments until the entire message has been 
built.
Would such a patch be acceptable, or is there a better way of doing this?

Cheers,
  Trond
--------------Boundary-00=_3CGD5AIS88TX9N8JDLPN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ip_build_xmit_slow.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ip_build_xmit_slow.dif"

--- linux-2.4.19-smp/net/ipv4/ip_output.c.orig	Mon May 13 23:34:37 2002
+++ linux-2.4.19-smp/net/ipv4/ip_output.c	Mon Jun 17 23:13:28 2002
@@ -437,6 +437,8 @@
 		  struct rtable *rt,
 		  int flags)
 {
+	struct sk_buff_head frags;
+	struct sk_buff * skb;
 	unsigned int fraglen, maxfraglen, fragheaderlen;
 	int err;
 	int offset, mf;
@@ -512,10 +514,10 @@
 	 */
 
 	id = sk->protinfo.af_inet.id++;
+	skb_queue_head_init(&frags);
 
 	do {
 		char *data;
-		struct sk_buff * skb;
 
 		/*
 		 *	Get the memory we require with some space left for alignment.
@@ -599,7 +601,11 @@
 		fraglen = maxfraglen;
 
 		nfrags++;
+		__skb_queue_head(&frags, skb);
+	} while (offset >= 0);
 
+	/* Ensure we send fragments in order of increasing offset */
+	while ((skb = __skb_dequeue(&frags)) != NULL) {
 		err = NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, 
 			      skb->dst->dev, output_maybe_reroute);
 		if (err) {
@@ -608,7 +614,7 @@
 			if (err)
 				goto error;
 		}
-	} while (offset >= 0);
+	}
 
 	if (nfrags>1)
 		ip_statistics[smp_processor_id()*2 + !in_softirq()].IpFragCreates += nfrags;
@@ -617,6 +623,10 @@
 
 error:
 	IP_INC_STATS(IpOutDiscards);
+	while ((skb = __skb_dequeue(&frags)) != NULL) {
+		kfree_skb(skb);
+		nfrags--;
+	}
 	if (nfrags>1)
 		ip_statistics[smp_processor_id()*2 + !in_softirq()].IpFragCreates += nfrags;
 	return err; 

--------------Boundary-00=_3CGD5AIS88TX9N8JDLPN--
