Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936124AbWK3CPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936124AbWK3CPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 21:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936125AbWK3CPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 21:15:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:61072
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S936124AbWK3CPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 21:15:38 -0500
Date: Wed, 29 Nov 2006 18:15:37 -0800 (PST)
Message-Id: <20061129.181537.38322733.davem@davemloft.net>
To: kernel@linuxace.com
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: Re: Linux 2.6.19
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130014904.GA1405@linuxace.com>
References: <20061129151111.6bd440f9.rdunlap@xenotime.net>
	<20061130005631.GA3896@yggdrasil.localdomain>
	<20061130014904.GA1405@linuxace.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Oester <kernel@linuxace.com>
Date: Wed, 29 Nov 2006 17:49:04 -0800

> Getting an oops on boot here, caused by commit
> e81c73596704793e73e6dbb478f41686f15a4b34 titled
> "[NET]: Fix MAX_HEADER setting".
> 
> Reverting that patch fixes things up for me.  Dave?

I suspect that it might be because I removed the IPV6
ifdef from the list,  but I can't imagine why that would
matter other than due to a bug in the IPV6 stack....

Indeed.

Looking at ndisc_send_rs() I wonder if it miscalculates
'len' or similar and the old MAX_HEADER setting was
merely papering around this bug....

In fact it does, the NDISC code is using MAX_HEADER incorrectly.  It
needs to explicitly allocate space for the struct ipv6hdr in 'len'.
Luckily the TCP ipv6 code was doing it right.

What a horrible bug, this patch should fix it.  Let me know
if it doesn't, thanks:

commit c28728decc37fe52c8cdf48b3e0c0cf9b0c2fefb
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Nov 29 18:14:47 2006 -0800

    [IPV6] NDISC: Calculate packet length correctly for allocation.
    
    MAX_HEADER does not include the ipv6 header length in it,
    so we need to add it in explicitly.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 73eb8c3..c42d4c2 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -441,7 +441,8 @@ static void ndisc_send_na(struct net_dev
         struct sk_buff *skb;
 	int err;
 
-	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
+	len = sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr) +
+		sizeof(struct in6_addr);
 
 	/* for anycast or proxy, solicited_addr != src_addr */
 	ifp = ipv6_get_ifaddr(solicited_addr, dev, 1);
@@ -556,7 +557,8 @@ void ndisc_send_ns(struct net_device *de
 	if (err < 0)
 		return;
 
-	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
+	len = sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr) +
+		sizeof(struct in6_addr);
 	send_llinfo = dev->addr_len && !ipv6_addr_any(saddr);
 	if (send_llinfo)
 		len += ndisc_opt_addr_space(dev);
@@ -632,7 +634,7 @@ void ndisc_send_rs(struct net_device *de
 	if (err < 0)
 		return;
 
-	len = sizeof(struct icmp6hdr);
+	len = sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr);
 	if (dev->addr_len)
 		len += ndisc_opt_addr_space(dev);
 
@@ -1381,7 +1383,8 @@ void ndisc_send_redirect(struct sk_buff 
 			 struct in6_addr *target)
 {
 	struct sock *sk = ndisc_socket->sk;
-	int len = sizeof(struct icmp6hdr) + 2 * sizeof(struct in6_addr);
+	int len = sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr) +
+		2 * sizeof(struct in6_addr);
 	struct sk_buff *buff;
 	struct icmp6hdr *icmph;
 	struct in6_addr saddr_buf;
