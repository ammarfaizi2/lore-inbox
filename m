Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTIPJIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIPJII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:08:08 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:13801 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261798AbTIPJH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:07:58 -0400
Date: Tue, 16 Sep 2003 11:07:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, davem@redhat.com,
       netdev@oss.sgi.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916090748.GE27703@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 September 2003 21:35:46 -0700, David Yu Chen wrote:
> 
> [FILE:  2.6.0-test5/net/ipv4/igmp.c]
> [FUNC:  igmpv3_newpack]
> [LINES: 274-284]
> [VAR:   skb]
>  269:	struct sk_buff *skb;
>  270:	struct rtable *rt;
>  271:	struct iphdr *pip;
>  272:	struct igmpv3_report *pig;
>  273:
> START -->
>  274:	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
>  275:	if (skb == NULL)
>  276:		return 0;
>  277:
>  278:	{
>  279:		struct flowi fl = { .oif = dev->ifindex,
>  280:				    .nl_u = { .ip4_u = {
>  281:				    .daddr = IGMPV3_ALL_MCR } },
>  282:				    .proto = IPPROTO_IGMP };
>  283:		if (ip_route_output_key(&rt, &fl))
> END -->
>  284:			return 0;
>  285:	}
>  286:	if (rt->rt_src == 0) {
>  287:		ip_rt_put(rt);
>  288:		return 0;
>  289:	}

Looks valid.  And since skb isn't really needed until after these
returns, moving four lines down a bit fixes the problem.

Davem, is this correct?

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike

--- linux-2.6.0-test3/net/ipv4/igmp.c~igmp_memleak	2003-07-15 23:09:02.000000000 +0200
+++ linux-2.6.0-test3/net/ipv4/igmp.c	2003-09-16 10:29:47.000000000 +0200
@@ -70,6 +70,8 @@
  *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
  *		David L Stevens:	IGMPv3 support, with help from
  *					Vinay Kulkarni
+ *		Jörn Engel:		Fix memleak in igmpv3_newpack, reported
+ *					by David Yu Chen (stanford checker)
  */
 
 
@@ -271,10 +273,6 @@
 	struct iphdr *pip;
 	struct igmpv3_report *pig;
 
-	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
-	if (skb == NULL)
-		return 0;
-
 	{
 		struct flowi fl = { .oif = dev->ifindex,
 				    .nl_u = { .ip4_u = {
@@ -288,6 +286,10 @@
 		return 0;
 	}
 
+	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
+	if (skb == NULL)
+		return 0;
+
 	skb->dst = &rt->u.dst;
 	skb->dev = dev;
 
