Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUIOFrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUIOFrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 01:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUIOFrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 01:47:48 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:29363
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267633AbUIOFro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 01:47:44 -0400
Date: Tue, 14 Sep 2004 22:45:09 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lincoln Dale <ltd@cisco.com>
Cc: i@stingr.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-Id: <20040914224509.685cd2c6.davem@davemloft.net>
In-Reply-To: <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14>
References: <20040913051706.GB26337@stingr.sgu.ru>
	<20040911194108.GS28258@stingr.sgu.ru>
	<20040912170505.62916147.davem@davemloft.net>
	<20040913051706.GB26337@stingr.sgu.ru>
	<5.1.0.14.2.20040914184652.03e24de0@171.71.163.14>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 18:48:20 +1000
Lincoln Dale <ltd@cisco.com> wrote:

> the logic is correct, but it may make sense to call the appropriate 
> netfilter hook again with the "unwrapped" GRE packet, as otherwise 
> packets-inside-GRE represent a possible security hole where one can inject 
> packets externally and bypass firewall rules.

This will occur when we push the packet back into the
RX path via the netif_rx() call.

Paul if you want to fix up the comment, that's fine.
But please send such a patch relative to what I put
into the tree already which is the following:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/13 16:04:36-07:00 i@stingr.net 
#   [IPV4]: Add wccp v1/v2 support to ip_gre.c
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/ip_gre.c
#   2004/09/13 16:04:06-07:00 i@stingr.net +12 -1
#   [IPV4]: Add wccp v1/v2 support to ip_gre.c
# 
# include/linux/if_ether.h
#   2004/09/13 16:04:06-07:00 i@stingr.net +2 -0
#   [IPV4]: Add wccp v1/v2 support to ip_gre.c
# 
diff -Nru a/include/linux/if_ether.h b/include/linux/if_ether.h
--- a/include/linux/if_ether.h	2004-09-14 22:27:39 -07:00
+++ b/include/linux/if_ether.h	2004-09-14 22:27:39 -07:00
@@ -59,6 +59,8 @@
 #define ETH_P_8021Q	0x8100          /* 802.1Q VLAN Extended Header  */
 #define ETH_P_IPX	0x8137		/* IPX over DIX			*/
 #define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
+#define ETH_P_WCCP	0x883E		/* Web-cache coordination protocol
+					 * defined in draft-wilson-wrec-wccp-v2-00.txt */
 #define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
 #define ETH_P_PPP_SES	0x8864		/* PPPoE session messages	*/
 #define ETH_P_MPLS_UC	0x8847		/* MPLS Unicast traffic		*/
diff -Nru a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
--- a/net/ipv4/ip_gre.c	2004-09-14 22:27:39 -07:00
+++ b/net/ipv4/ip_gre.c	2004-09-14 22:27:39 -07:00
@@ -603,13 +603,24 @@
 	if ((tunnel = ipgre_tunnel_lookup(iph->saddr, iph->daddr, key)) != NULL) {
 		secpath_reset(skb);
 
+		skb->protocol = *(u16*)(h + 2);
+		/* WCCP version 1 and 2 protocol decoding.
+		 * - Change protocol to IP
+		 * - When dealing with WCCPv2, Skip extra 4 bytes in GRE header
+		 */
+		if (flags == 0 &&
+		    skb->protocol == __constant_htons(ETH_P_WCCP)) {
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
