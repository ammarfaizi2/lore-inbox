Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVGMVOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVGMVOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVGMSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:24803 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262323AbVGMSo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:58 -0400
Date: Wed, 13 Jul 2005 11:42:04 -0700
From: Greg KH <gregkh@suse.de>
To: kaber@trash.net, dsd@gentoo.org, kernel@linuxace.com,
       netfilter-devel@lists.netfilter.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [02/11] [NETFILTER]: revert nf_reset change
Message-ID: <20050713184204.GC9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[NETFILTER]: Revert nf_reset change

Revert the nf_reset change that caused so much trouble, drop conntrack
references manually before packets are queued to packet sockets.

Adapted for 2.6.12 by Daniel Drake <dsd@gentoo.org>

Signed-off-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/ip_output.c                         |    3 ---
 net/ipv4/netfilter/ip_conntrack_standalone.c |    7 +++++++
 net/packet/af_packet.c                       |    6 ++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

--- linux-2.6.12.2.orig/net/ipv4/ip_output.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/net/ipv4/ip_output.c	2005-07-13 10:56:44.000000000 -0700
@@ -111,7 +111,6 @@
 #ifdef CONFIG_NETFILTER_DEBUG
 	nf_debug_ip_loopback_xmit(newskb);
 #endif
-	nf_reset(newskb);
 	netif_rx(newskb);
 	return 0;
 }
@@ -196,8 +195,6 @@
 	nf_debug_ip_finish_output2(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/
 
-	nf_reset(skb);
-
 	if (hh) {
 		int hh_alen;
 
--- linux-2.6.12.2.orig/net/ipv4/netfilter/ip_conntrack_standalone.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/net/ipv4/netfilter/ip_conntrack_standalone.c	2005-07-13 10:56:44.000000000 -0700
@@ -432,6 +432,13 @@
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
--- linux-2.6.12.2.orig/net/packet/af_packet.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/net/packet/af_packet.c	2005-07-13 10:56:44.000000000 -0700
@@ -274,6 +274,9 @@
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spkt = (struct sockaddr_pkt*)skb->cb;
 
 	skb_push(skb, skb->data-skb->mac.raw);
@@ -517,6 +520,9 @@
 	dst_release(skb->dst);
 	skb->dst = NULL;
 
+	/* drop conntrack reference */
+	nf_reset(skb);
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	po->stats.tp_packets++;
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
