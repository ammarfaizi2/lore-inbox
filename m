Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUINUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUINUSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269766AbUINUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:15:49 -0400
Received: from stingr.net ([212.193.32.15]:3257 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S269763AbUINUMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:12:10 -0400
Date: Wed, 15 Sep 2004 00:12:06 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Lincoln Dale <ltd@cisco.com>
Cc: Paul P Komkoff Jr <i@stingr.net>, "David S. Miller" <davem@davemloft.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-ID: <20040914201206.GM4141@stingr.sgu.ru>
Mail-Followup-To: Lincoln Dale <ltd@cisco.com>,
	Paul P Komkoff Jr <i@stingr.net>,
	"David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14> <20040913051706.GB26337@stingr.sgu.ru> <20040911194108.GS28258@stingr.sgu.ru> <20040912170505.62916147.davem@davemloft.net> <20040913051706.GB26337@stingr.sgu.ru> <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14> <5.1.0.14.2.20040914225341.03c31a08@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040914225341.03c31a08@171.71.163.14>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Lincoln Dale:
> >From what I observe, netfilter hooks *are* called for unwrapped packets.
> >Either for usual IP packets  passed from GRE tunnel, or for demangled
> >wccp packets.
> 
> you probably want to ensure that the order of netfilter events are:

Basically all surroinding stuff was untouched. I just enabled further
processing (by kernel IP stack) of GRE-WCCP encapsulated packets.

>   1. [packet comes in]
>   2. netfilter INPUT
>   3. [GRE decap]
>   4. [addressed to us?]
>       Yes => netfilter INPUT
>       No => netfilter FORWARD
> 
> i don't think that both (2) and (4) are done.

I think (2) is done before ipgre_rcv, and (4) is done because after
decapsulation
                skb->dev = tunnel->dev;
                netif_rx(skb);
this packet reenters the building from matched gre interface.

> also just a minor nit: not all WCCP needs to be GRE-encoded; on 
> high-performance switch/router platforms, only a layer-2 rewrite of the dst 
> MAC addr is used instead of a layer-3 GRE tunnel.  you may want the comment 
> at line 609 to explicitly mention "WCCPv1 and WCCPv2 GRE Forwarding mode".

Yes I know this :) L2 case do not need any extra processing, but not
all routers support it. For example, my 4500 don't.

Here is updated patch with if(1) removed and comment changed.


diff -urN /usr/src/linux-2.6.8-1.521/include/linux/if_ether.h linux-2.6.8-1.521wccp/include/linux/if_ether.h
--- /usr/src/linux-2.6.8-1.521/include/linux/if_ether.h	2004-08-14 09:37:15.000000000 +0400
+++ linux-2.6.8-1.521wccp/include/linux/if_ether.h	2004-09-13 08:51:02.000000000 +0400
@@ -59,6 +59,8 @@
 #define ETH_P_8021Q	0x8100          /* 802.1Q VLAN Extended Header  */
 #define ETH_P_IPX	0x8137		/* IPX over DIX			*/
 #define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
+#define ETH_P_WCCP	0x883E		/* Web-cache coordination protocol
+					 * defined in draft-wilson-wrec-wccp-v2-00.txt */
 #define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
 #define ETH_P_PPP_SES	0x8864		/* PPPoE session messages	*/
 #define ETH_P_MPLS_UC	0x8847		/* MPLS Unicast traffic		*/
diff -urN /usr/src/linux-2.6.8-1.521/net/ipv4/ip_gre.c linux-2.6.8-1.521wccp/net/ipv4/ip_gre.c
--- /usr/src/linux-2.6.8-1.521/net/ipv4/ip_gre.c	2004-08-14 09:37:37.000000000 +0400
+++ linux-2.6.8-1.521wccp/net/ipv4/ip_gre.c	2004-09-15 00:03:45.586135760 +0400
@@ -605,13 +605,23 @@
 	if ((tunnel = ipgre_tunnel_lookup(iph->saddr, iph->daddr, key)) != NULL) {
 		secpath_reset(skb);
 
+		skb->protocol = *(u16*)(h + 2);
+		/* WCCP version 1 and 2 (in GRE forwarding mode) protocol decoding.
+		 * - Change protocol to IP
+		 * - When dealing with WCCPv2, skip extra 4 bytes in GRE header
+		 */
+		if ((flags == 0) && (skb->protocol == __constant_htons(ETH_P_WCCP))) {
+			skb->protocol = __constant_htons(ETH_P_IP);
+			if ((*(h + offset) & 0xF0) != 0x40) 
+				offset += 4;
+		}
+
 		skb->mac.raw = skb->nh.raw;
 		skb->nh.raw = __pskb_pull(skb, offset);
 		memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
 		if (skb->ip_summed == CHECKSUM_HW)
 			skb->csum = csum_sub(skb->csum,
 					     csum_partial(skb->mac.raw, skb->nh.raw-skb->mac.raw, 0));
-		skb->protocol = *(u16*)(h + 2);
 		skb->pkt_type = PACKET_HOST;
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 		if (MULTICAST(iph->daddr)) {

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
