Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVGLTUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVGLTUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVGLTUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:20:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262264AbVGLTUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:20:12 -0400
Date: Tue, 12 Jul 2005 12:19:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: kaber@trash.net, dsd@gentoo.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
Message-ID: <20050712191945.GL9153@shell0.pdx.osdl.net>
References: <42CE8E96.1040905@trash.net> <42CEA5E4.40009@gentoo.org> <42D3B063.3000207@trash.net> <20050712.115835.42775885.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712.115835.42775885.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@davemloft.net) wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Tue, 12 Jul 2005 13:58:27 +0200
> 
> > Daniel Drake wrote:
> > > You'll have to forgive my lack of netfilter knowledge, I set up my firewall
> > > ages ago and haven't really touched it since :)
> > 
> > We decided to revert the responsible change because it caused problems
> > in other areas as well. This patch should fix your problem.
> 
> Applied.
> 
> Now the question is what to do about the 2.6.12.x stable
> tree.  I think we put the offending change there, now we
> need to revert it there too.  Patrick, could you push this
> patch to stable@kernel.org so we can resolve that too?

There's the first fix in the queue, I can either drop that one, or
patch on top of it.  Dropping what's in the queue[1] is fine for me.
Below's the backport that Daniel sent over this morning (which applies
if I drop what's in the queue).  Patrick, does that look ok?  I didn't
queue this change yet, as I'd prefer it came either from you or with you
Cc'd so you can ack it.

[1] http://www.kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=blob;h=77843604cf9af8cf5458d97eb56d5346e6d380b3;hb=9aaf5aa7c4e4b8309997d2b433bf7464280799eb;f=queue/netfilter-connection-tracking.patch

--

[NETFILTER]: Revert nf_reset change

Revert the nf_reset change that caused so much trouble, drop conntrack
references manually before packets are queued to packet sockets.

Adapted for 2.6.12 by Daniel Drake <dsd@gentoo.org>

Signed-off-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Patrick McHardy <kaber@trash.net>

--- linux-2.6.12/net/ipv4/ip_output.c_orig	2005-07-12 13:42:56.000000000 +0100
+++ linux-2.6.12/net/ipv4/ip_output.c	2005-07-12 13:46:03.000000000 +0100
@@ -111,7 +111,6 @@ static int ip_dev_loopback_xmit(struct s
 #ifdef CONFIG_NETFILTER_DEBUG
 	nf_debug_ip_loopback_xmit(newskb);
 #endif
-	nf_reset(newskb);
 	netif_rx(newskb);
 	return 0;
 }
@@ -196,8 +195,6 @@ static inline int ip_finish_output2(stru
 	nf_debug_ip_finish_output2(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
-	nf_reset(skb);
-
 	if (hh) {
 		int hh_alen;
 
--- linux-2.6.12/net/ipv4/netfilter/ip_conntrack_standalone.c_orig	2005-07-12 13:43:16.000000000 +0100
+++ linux-2.6.12/net/ipv4/netfilter/ip_conntrack_standalone.c	2005-07-12 13:47:44.000000000 +0100
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
--- linux-2.6.12/net/packet/af_packet.c_orig	2005-07-12 13:47:38.000000000 +0100
+++ linux-2.6.12/net/packet/af_packet.c	2005-07-12 13:47:44.000000000 +0100
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
