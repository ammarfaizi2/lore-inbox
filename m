Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWEaQgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWEaQgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWEaQgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:36:38 -0400
Received: from stinky.trash.net ([213.144.137.162]:21483 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751075AbWEaQgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:36:37 -0400
Message-ID: <447DC613.10102@trash.net>
Date: Wed, 31 May 2006 18:36:35 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus>
In-Reply-To: <20060531160611.GA25637@janus>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020608060405080105030900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608060405080105030900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Frank van Maarseveen wrote:
> On Wed, May 31, 2006 at 04:57:13PM +0200, Patrick McHardy wrote:
> 
>>The message means that there was recursion and netpoll fell back
>>to dev_queue_xmit This patch should fix the "protocol is buggy"
>>messages, netpoll didn't set skb->nh.raw. Please try if it also
>>makes the other problem go away.
> 
> 
> "protocol 0000 is buggy" is gone. The other problem is still there.


The messages might get dropped when the output queue is full.
Does one of the drop counters shown by "ip -s link list"
and "tc -s -d qdisc show" increase (the other counts might also
give some clues)? Otherwise please apply the attached patch
(should fix tcpdump, last patch was incomplete) and post a dump.



--------------020608060405080105030900
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e8e05ce..05ed18d 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -329,7 +329,7 @@ void netpoll_send_udp(struct netpoll *np
 	udph->len = htons(udp_len);
 	udph->check = 0;
 
-	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
+	skb->nh.iph = iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
 	/* iph->version = 4; iph->ihl = 5; */
 	put_unaligned(0x45, (unsigned char *)iph);
@@ -346,7 +346,7 @@ void netpoll_send_udp(struct netpoll *np
 
 	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
 
-	eth->h_proto = htons(ETH_P_IP);
+	eth->h_proto = skb->protocol = htons(ETH_P_IP);
 	memcpy(eth->h_source, np->local_mac, 6);
 	memcpy(eth->h_dest, np->remote_mac, 6);
 

--------------020608060405080105030900--
