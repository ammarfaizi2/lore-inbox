Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJRRrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTJRRrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:47:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:11668 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261750AbTJRRrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:47:03 -0400
Date: Sat, 18 Oct 2003 19:46:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Finding memory leak
Message-ID: <20031018174636.GB12461@wohnheim.fh-wedel.de>
References: <20031015032539.4cfe71c7.akpm@osdl.org> <Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de> <20031018172353.GA12461@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031018172353.GA12461@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 October 2003 19:23:53 +0200, Jörn Engel wrote:
> > 
> >   - Could someone please check igmpv3_newpack() and assure me that there
> >     is no leak.
> 
> There was a leak, found by the stanford checker team.  I've provided a
> broken fix, DaveM wanted to write a decent one.  Not sure if it has
> already found it's way into the official kernel.

If DaveM hasn't fixed it yet, you can also try this patch.  Since I'm
pretty unaware of the networking code, this may be broken again, but
it also can't make things much worse for you.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy

--- linux-2.6.0-test5/net/ipv4/igmp.c~igmp_memleak	2003-09-17 15:21:02.000000000 +0200
+++ linux-2.6.0-test5/net/ipv4/igmp.c	2003-10-18 19:46:17.000000000 +0200
@@ -70,6 +70,8 @@
  *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
  *		David L Stevens:	IGMPv3 support, with help from
  *					Vinay Kulkarni
+ *		Jörn Engel:		Fix memleak in igmpv3_newpack, reported
+ *					by David Yu Chen (stanford checker)
  */
 
 
@@ -280,8 +282,10 @@
 				    .nl_u = { .ip4_u = {
 				    .daddr = IGMPV3_ALL_MCR } },
 				    .proto = IPPROTO_IGMP };
-		if (ip_route_output_key(&rt, &fl))
+		if (ip_route_output_key(&rt, &fl)) {
+			kfree_skb(skb);
 			return 0;
+		}
 	}
 	if (rt->rt_src == 0) {
 		ip_rt_put(rt);
