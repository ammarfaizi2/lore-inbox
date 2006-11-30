Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759000AbWK3EMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000AbWK3EMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759001AbWK3EMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:12:24 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:16858
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758994AbWK3EMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:12:23 -0500
Date: Wed, 29 Nov 2006 20:12:20 -0800 (PST)
Message-Id: <20061129.201220.88477321.davem@davemloft.net>
To: clem@clem.clem-digital.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 panic on boot -- i386
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
References: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Clements <clem@clem.clem-digital.net>
Date: Wed, 29 Nov 2006 22:13:09 -0500 (EST)

> 2.6.19 panics at boot. Good up through rc6-git11.
> Hand copied screen below.

Here is the fix, which was posted in response to a seperate
report of this problem here:

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
