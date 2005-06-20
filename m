Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFTTDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFTTDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFTS7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:59:43 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:59623
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261492AbVFTS5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:39 -0400
Date: Mon, 20 Jun 2005 11:57:36 -0700
From: Phil Oester <kernel@linuxace.com>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Patrick McHardy <kaber@trash.net>, Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       rankincj@yahoo.com, ebtables-devel@lists.sourceforge.net,
       netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050620185736.GA4883@linuxace.com>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1119293193.3381.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The changes were originally made to fix conntrack unload problems with
raw sockets.  My original patch performed the nf_reset in the socket
code, but Patrick suggested moving it to ip_output.  The below patch
reverts the ip_output changes, and implements the original suggested
changes to raw socket handling.  

While this is unlikely to be the permanent solution, it will fix the
current bridging problems while retaining the raw socket fixes.  I'd
suggest that this could be included in -stable while researching
other solutions.

Phil

Signed-off-by: Phil Oester <kernel@linuxace.com>



--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-fixbridge

diff -purN linux-orig/net/ipv4/ip_output.c linux-new/net/ipv4/ip_output.c
--- linux-orig/net/ipv4/ip_output.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-new/net/ipv4/ip_output.c	2005-06-20 14:47:58.000000000 -0400
@@ -196,8 +196,6 @@ static inline int ip_finish_output2(stru
 	nf_debug_ip_finish_output2(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
-	nf_reset(skb);
-
 	if (hh) {
 		int hh_alen;
 
diff -purN linux-orig/net/ipv4/netfilter/ip_conntrack_standalone.c linux-new/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux-orig/net/ipv4/netfilter/ip_conntrack_standalone.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-new/net/ipv4/netfilter/ip_conntrack_standalone.c	2005-06-20 14:47:58.000000000 -0400
@@ -432,6 +432,13 @@ static unsigned int ip_conntrack_defrag(
 				        const struct net_device *out,
 				        int (*okfn)(struct sk_buff *))
 {
+#if !defined(CONFIG_IP_NF_NAT) && !defined(CONFIG_IP_NF_NAT_MODULE)
+	/* Previously seen (loopback)?  Ignore.  Do this before
+           fragment check. */
+	if ((*pskb)->nfct)
+		return NF_ACCEPT;
+#endif
+
 	/* Gather fragments. */
 	if ((*pskb)->nh.iph->frag_off & htons(IP_MF|IP_OFFSET)) {
 		*pskb = ip_ct_gather_frags(*pskb,
diff -purN linux-orig/net/packet/af_packet.c linux-new/net/packet/af_packet.c
--- linux-orig/net/packet/af_packet.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-new/net/packet/af_packet.c	2005-06-20 14:48:38.000000000 -0400
@@ -274,6 +274,9 @@ static int packet_rcv_spkt(struct sk_buf
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spkt = (struct sockaddr_pkt*)skb->cb;
 
 	skb_push(skb, skb->data-skb->mac.raw);
@@ -517,6 +520,9 @@ static int packet_rcv(struct sk_buff *sk
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	po->stats.tp_packets++;
 	__skb_queue_tail(&sk->sk_receive_queue, skb);

--MGYHOYXEY6WxJCY8--
