Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTHQW4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271121AbTHQW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:56:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16907 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271120AbTHQW4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:56:05 -0400
Date: Mon, 18 Aug 2003 00:48:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Carlos Velasco <carlosev@newipnet.com>,
       Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030817224849.GB734@alpha.home.local>
References: <20030728213933.F81299@coredump.scriptkiddie.org> <200308171509570955.003E4FEC@192.168.128.16> <200308171516090038.0043F977@192.168.128.16> <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk> <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan !

On Sun, Aug 17, 2003 at 06:24:06PM +0100, Alan Cox wrote:
 
> So stick the address on eth0 not on lo since its not a loopback but an eth0
> address, then use arpfilter so you don't arp for the invalid magic shared IP
> address, or NAT it, or it may work to do
> 
>          ip route add nexthop-addr src my-virtual-addr dev eth0 scope local onlink
>          ip route add default src my-virtual-addr via nexthop-addr dev eth0 scope global
 
I have a case where this doesn't work, and which required me to apply Julian's
arp_prefsrc patch, because I couldn't resolve it with iproute alone. This is a
fairly simple and certainly common scenario :

   box A : client        router           box B
   +------------+     +---------+      +--------+
---+ eth0  eth1 +-----+ gateway +------+ server +
   +------------+     +---------+      +--------+
   10.1      11.1     11.2   12.2      12.3    <-- IP : 10.1 for 10.0.0.1, etc.

Network 11 is an interconnect network, it is not known from box B, but B knows
how to reach network 10 through the router (12.0.0.2), which also knows how to
reach 10 through 11.0.0.1 of course.

If I want to be able to reach box B from A (eg for debugging purposes), I need
it to join B from its 10.1 address, through gateway 11.2. I do the following
on Box A:
  ip route add 11.0.0.2 src 11.0.0.1 dev eth1 onlink
  ip route add 12.0.0.3 via 11.0.0.2 src 10.0.0.1 dev eth1

To me, it means that when talking to 12.0.0.3, I bind to source 10.0.0.1, and
route through 11.0.0.2, which I obtain the MAC address by asking with a source
of 11.0.0.1.

But it doesn't work this way : 11.0.0.2 receives ARP requests from 10.0.0.1
and obviously refuses them.

But now if I simply ping 11.0.0.2, this one won't work either because box A
will still try to request its MAC address with 10.0.0.1 as its source ! So I
manually delete the incomplete ARP entry, and ping 11.0.0.2 again. This time,
the valid address (11.0.0.1) is used, and I can reach 12.0.0.3 from 10.0.0.1
as long as the ARP entry stays valid.

Perhaps this is a standard arp_filter case, but I didn't find how to resolve
it, except by using Julian's arp_prefsrc patch which does a lookup of a valid
source address to send the ARP request. Now, each time I have these sort of
setup and I don't have a patched kernel, I prepare a background ping to feed
the ARP cache correctly.

And frankly, I don't understand what feature it brings to deliberately use a
wrong address as the source for ARP requests. I have searched a long time, but
still didn't find any advantage to this behaviour. Reading the code, I don't
think it was deliberate, but only a forgotten case. To me, the first route
entry above is explicit enough : use 11.0.0.1 as a source when trying to reach
11.0.0.2, so I don't see why ARP requests don't respect this.

If you want to reproduce the setup above, you only need ONE host and tcpdump.
Simply put the two addresses on the same NIC, add the routes and watch the ARP
requests go out with the wrong source.

Here is Julian's patch if you want to take a look at it. It seems fairly
logical to me, and I don't see what it could break. But again, if you have a
way to do something equivalent with iproute or any other standard method, I'd
be glad to try.

Cheers,
Willy

--- v2.4.12/linux/net/ipv4/arp.c	Tue Sep 25 02:38:23 2001
+++ linux/net/ipv4/arp.c	Mon Oct 22 22:58:49 2001
@@ -316,16 +316,19 @@
 
 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 {
+	struct rtable *rt;
 	u32 saddr;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
-		saddr = skb->nh.iph->saddr;
-	else
-		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+	if (ip_route_output(&rt, target, 0, 0, dev->ifindex) < 0)
+		return;
+	saddr = rt->rt_src;
+	ip_rt_put(rt);
+	if (!saddr)
+		return;
 
 	if ((probes -= neigh->parms->ucast_probes) < 0) {
 		if (!(neigh->nud_state&NUD_VALID))


