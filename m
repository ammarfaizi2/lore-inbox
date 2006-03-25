Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCYEK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCYEK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWCYEK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:10:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64926
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750772AbWCYEKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:10:24 -0500
Date: Fri, 24 Mar 2006 20:10:01 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, davem@davemloft.net,
       tgraf@suug.ch, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 02/08] Netfilter ip_queue: Fix wrong skb->len == nlmsg_len assumption
Message-ID: <20060325041001.GC16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

The size of the skb carrying the netlink message is not
equivalent to the length of the actual netlink message
due to padding. ip_queue matches the length of the payload
against the original packet size to determine if packet
mangling is desired, due to the above wrong assumption
arbitary packets may not be mangled depening on their
original size.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/ipv4/netfilter/ip_queue.c  |    2 +-
 net/ipv6/netfilter/ip6_queue.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.6.orig/net/ipv4/netfilter/ip_queue.c
+++ linux-2.6.15.6/net/ipv4/netfilter/ip_queue.c
@@ -524,7 +524,7 @@ ipq_rcv_skb(struct sk_buff *skb)
 	write_unlock_bh(&queue_lock);
 	
 	status = ipq_receive_peer(NLMSG_DATA(nlh), type,
-	                          skblen - NLMSG_LENGTH(0));
+	                          nlmsglen - NLMSG_LENGTH(0));
 	if (status < 0)
 		RCV_SKB_FAIL(status);
 		
--- linux-2.6.15.6.orig/net/ipv6/netfilter/ip6_queue.c
+++ linux-2.6.15.6/net/ipv6/netfilter/ip6_queue.c
@@ -522,7 +522,7 @@ ipq_rcv_skb(struct sk_buff *skb)
 	write_unlock_bh(&queue_lock);
 	
 	status = ipq_receive_peer(NLMSG_DATA(nlh), type,
-	                          skblen - NLMSG_LENGTH(0));
+	                          nlmsglen - NLMSG_LENGTH(0));
 	if (status < 0)
 		RCV_SKB_FAIL(status);
 		
