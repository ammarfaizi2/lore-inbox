Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTJRSGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJRSGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:06:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:33428 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261788AbTJRSFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:05:45 -0400
Date: Sat, 18 Oct 2003 19:59:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Finding memory leak
Message-ID: <20031018175912.GC12461@wohnheim.fh-wedel.de>
References: <20031015032539.4cfe71c7.akpm@osdl.org> <Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de> <20031018172353.GA12461@wohnheim.fh-wedel.de> <20031018174636.GB12461@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031018174636.GB12461@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 October 2003 19:46:36 +0200, Jörn Engel wrote:
> On Sat, 18 October 2003 19:23:53 +0200, Jörn Engel wrote:
> > > 
> > >   - Could someone please check igmpv3_newpack() and assure me that there
> > >     is no leak.
> > 
> > There was a leak, found by the stanford checker team.  I've provided a
> > broken fix, DaveM wanted to write a decent one.  Not sure if it has
> > already found it's way into the official kernel.
> 
> If DaveM hasn't fixed it yet, you can also try this patch.  Since I'm
> pretty unaware of the networking code, this may be broken again, but
> it also can't make things much worse for you.

Or this one.  igmpv3_newpack() is to a large degree identical to
igmp_send_report().  The latter doesn't have a memleak, so I basically
adjusted the former to behave identical.  Should be foolproof, even
for me.

The space was added to make those two lines identical in both
functions as well.  If someone prefers 80 columns to 81, please adjust
both lines.

Andrew, DaveM, can this go into -test9?

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law

--- linux-2.6.0-test5/net/ipv4/igmp.c~igmp_memleak	2003-09-17 15:21:02.000000000 +0200
+++ linux-2.6.0-test5/net/ipv4/igmp.c	2003-10-18 19:51:37.000000000 +0200
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
@@ -288,12 +286,18 @@
 		return 0;
 	}
 
+	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
+	if (skb == NULL) {
+		ip_rt_put(rt);
+		return 0;
+	}
+
 	skb->dst = &rt->u.dst;
 	skb->dev = dev;
 
 	skb_reserve(skb, (dev->hard_header_len+15)&~15);
 
-	skb->nh.iph = pip =(struct iphdr *)skb_put(skb, sizeof(struct iphdr)+4);
+	skb->nh.iph = pip = (struct iphdr *)skb_put(skb, sizeof(struct iphdr)+4);
 
 	pip->version  = 4;
 	pip->ihl      = (sizeof(struct iphdr)+4)>>2;
