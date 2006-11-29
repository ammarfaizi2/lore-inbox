Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758492AbWK2C2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbWK2C2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 21:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758456AbWK2C2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 21:28:31 -0500
Received: from stinky.trash.net ([213.144.137.162]:24765 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1758426AbWK2C2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 21:28:30 -0500
Message-ID: <456CF049.7040407@trash.net>
Date: Wed, 29 Nov 2006 03:28:25 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: David Miller <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely duplicate
 route_reverse function
References: <m3fyc3e84s.fsf@defiant.localdomain> <456C94D2.9000602@trash.net>	<m3wt5fb8lz.fsf@defiant.localdomain> <456CAE0D.2080209@trash.net> <m3slg3ktvw.fsf@defiant.localdomain>
In-Reply-To: <m3slg3ktvw.fsf@defiant.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------010903000604040803000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903000604040803000509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Krzysztof Halasa wrote:
> Patrick McHardy <kaber@trash.net> writes:
> 
> 
>>It might be the case that your network device has a
>>hard_header_len > LL_MAX_HEADER, which could trigger
>>a corruption.
> 
> 
> Hmm... GRE tunnels add 24 bytes... I just noticed the following code in
> include/linux/netdevice.h:
> 
> /*
>  *      Compute the worst case header length according to the protocols
>  *      used.
>  */
> #if !defined(CONFIG_NET_IPIP) && \
>     !defined(CONFIG_IPV6) && !defined(CONFIG_IPV6_MODULE)
> #define MAX_HEADER LL_MAX_HEADER
> #else
> #define MAX_HEADER (LL_MAX_HEADER + 48)
> #endif
> 
> I don't use AX25, Token Ring, the old IPIP tunnels nor IPv6 here, but
> I wonder if GRE tunnel (which is basically another, more compatible
> form of IPIP) need the same treatment as IPIP.

Both ipip and gre do this:

dev->hard_header_len    = LL_MAX_HEADER + sizeof(struct iphdr);



which explains it. It is a bug in the REJECT target, but I was
wondering whether you were really seeing this. It looks like
it makes sense to add GRE to the MAX_HEADER case above though.

>>Please try this patch on top of the REJECT patch (ideally after
>>verifying that the REJECT patch is really introducing the
>>corruption).
> 
> 
> That was certain. The patch fixed the problem, confirmed with current
> git tree as well. Thanks for looking at it.

Thanks. Dave, please apply this patch.

[NETFILTER]: ipt_REJECT: fix memory corruption

On devices with hard_header_len > LL_MAX_HEADER ip_route_me_harder()
reallocates the skb, leading to memory corruption when using the stale
tcph pointer to update the checksum.

Signed-off-by: Patrick McHardy <kaber@trash.net>


--------------010903000604040803000509
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/netfilter/ipt_REJECT.c b/net/ipv4/netfilter/ipt_REJECT.c
index ad0312d..264763a 100644
--- a/net/ipv4/netfilter/ipt_REJECT.c
+++ b/net/ipv4/netfilter/ipt_REJECT.c
@@ -114,6 +114,14 @@ static void send_reset(struct sk_buff *o
 	tcph->window = 0;
 	tcph->urg_ptr = 0;
 
+	/* Adjust TCP checksum */
+	tcph->check = 0;
+	tcph->check = tcp_v4_check(tcph, sizeof(struct tcphdr),
+				   nskb->nh.iph->saddr,
+				   nskb->nh.iph->daddr,
+				   csum_partial((char *)tcph,
+						sizeof(struct tcphdr), 0));
+
 	/* Set DF, id = 0 */
 	nskb->nh.iph->frag_off = htons(IP_DF);
 	nskb->nh.iph->id = 0;
@@ -129,14 +137,8 @@ #endif
 	if (ip_route_me_harder(&nskb, addr_type))
 		goto free_nskb;
 
-	/* Adjust TCP checksum */
 	nskb->ip_summed = CHECKSUM_NONE;
-	tcph->check = 0;
-	tcph->check = tcp_v4_check(tcph, sizeof(struct tcphdr),
-				   nskb->nh.iph->saddr,
-				   nskb->nh.iph->daddr,
-				   csum_partial((char *)tcph,
-						sizeof(struct tcphdr), 0));
+
 	/* Adjust IP TTL */
 	nskb->nh.iph->ttl = dst_metric(nskb->dst, RTAX_HOPLIMIT);
 

--------------010903000604040803000509--
