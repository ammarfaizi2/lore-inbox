Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265769AbUFINIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUFINIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFINIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:08:10 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:55818 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265769AbUFINGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:06:50 -0400
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>
	 <20040608124215.291a7072@dell_ss3.pdx.osdl.net>
	 <1086725369.1806.1.camel@teapot.felipe-alfaro.com>
	 <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 09 Jun 2004 15:06:30 +0200
Message-Id: <1086786391.1692.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 14:02 -0700, Stephen Hemminger wrote:
> On Tue, 08 Jun 2004 22:09:29 +0200
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> 
> > On Tue, 2004-06-08 at 12:42 -0700, Stephen Hemminger wrote:
> > > On Tue, 08 Jun 2004 21:18:30 +0200
> > > Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> > > 
> > > > Hi!
> > > > 
> > > > On my laptop, when using a CardBus 3c59x-based NIC, I need to run
> > > > "cardctl eject" so the system won't freeze when resuming. "cardctl
> > > > eject" worked fine in 2.6.7-rc2-mm2, even when there were programs with
> > > > network sockets opened (for example, Evolution mantaining a connection
> > > > against an IMAP server): the card is ejected (well, not physically),
> > > > even when there are ESTABLISHED connections.
> > > > 
> > > > However, starting with 2.6.7-rc3, "cardctl eject" hangs if a program
> > > > holds any socket open. After a while the "unregister_netdevice: waiting
> > > > for eth0 to become free" message starts appearing on the kernel message
> > > > ring. The only apparent solution is killing that program, ejecting the
> > > > card from its slot and wait until 3c59x.o usage count reaches zero.
> > > > 
> > > > Can someone tell me what's going on here?
> > > > Thank you very much.
> > > 
> > > What protocols are you running? Is IPV6 loaded?
> > 
> > I'm using IPv4, IPv6 and IPSec ESP with AES/CBC.
> > Do you want .config?
> 
> Not really, could you see if it is an IPv6 vs IPSec problem by not running/loading
> one or the other.
> 
> What is happening is that some subsystem is holding a reference to the device (calling dev_hold())
> but not cleaning up (calling dev_put).  It can be a hard to track which of the many
> things routing, etc are not being cleared properly.  Look for routes that still
> get stuck (ip route) and neighbor cache entries.  Most of these end up being
> protocol bugs.

I think you were pointing me in the right direction. I've found the
following changes to net/ipv4/route.c and net/ipv6/route.c between
2.6.7-rc2-mm2 and 2.6.7-rc3-mm1:

diff -uNr linux-2.6.7-rc2-mm2/net/ipv4/route.c linux-2.6.7-rc3-mm1/net/
ipv4/route.c
--- linux-2.6.7-rc2-mm2/net/ipv4/route.c	2004-06-09 13:15:46.000000000
+0200
+++ linux-2.6.7-rc3-mm1/net/ipv4/route.c	2004-06-09 12:55:19.000000000
+0200
@@ -1040,6 +1040,8 @@
 				rt->u.dst.child		= NULL;
 				if (rt->u.dst.dev)
 					dev_hold(rt->u.dst.dev);
+				if (rt->idev)
+					in_dev_hold(rt->idev);
 				rt->u.dst.obsolete	= 0;
 				rt->u.dst.lastuse	= jiffies;
 				rt->u.dst.path		= &rt->u.dst;
@@ -1321,11 +1323,17 @@
 {
 	struct rtable *rt = (struct rtable *) dst;
 	struct inet_peer *peer = rt->peer;
+	struct in_device *idev = rt->idev;
 
 	if (peer) {
 		rt->peer = NULL;
 		inet_putpeer(peer);
 	}
+
+	if (idev) {
+		rt->idev = NULL;
+		in_dev_put(idev);
+	}
 }
 
 static void ipv4_link_failure(struct sk_buff *skb)
@@ -1339,8 +1347,10 @@
 		dst_set_expires(&rt->u.dst, 0);
 }
 
-static int ip_rt_bug(struct sk_buff *skb)
+static int ip_rt_bug(struct sk_buff **pskb)
 {
+	struct sk_buff *skb = *pskb;
+
 	printk(KERN_DEBUG "ip_rt_bug: %u.%u.%u.%u -> %u.%u.%u.%u, %s\n",
 		NIPQUAD(skb->nh.iph->saddr), NIPQUAD(skb->nh.iph->daddr),
 		skb->dev ? skb->dev->name : "?");
@@ -1486,6 +1496,7 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= &loopback_dev;
 	dev_hold(rth->u.dst.dev);
+	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->fl.oif	= 0;
 	rth->rt_gateway	= daddr;
 	rth->rt_spec_dst= spec_dst;
@@ -1695,6 +1706,7 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= out_dev->dev;
 	dev_hold(rth->u.dst.dev);
+	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->fl.oif 	= 0;
 	rth->rt_spec_dst= spec_dst;
 
@@ -1774,6 +1786,7 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= &loopback_dev;
 	dev_hold(rth->u.dst.dev);
+	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->rt_gateway	= daddr;
 	rth->rt_spec_dst= spec_dst;
 	rth->u.dst.input= ip_local_deliver;
@@ -2157,6 +2170,7 @@
 	rth->rt_iif	= oldflp->oif ? : dev_out->ifindex;
 	rth->u.dst.dev	= dev_out;
 	dev_hold(dev_out);
+	rth->idev	= in_dev_get(dev_out);
 	rth->rt_gateway = fl.fl4_dst;
 	rth->rt_spec_dst= fl.fl4_src;

diff -uNr linux-2.6.7-rc2-mm2/net/ipv6/route.c linux-2.6.7-rc3-mm1/net/
ipv6/route.c
--- linux-2.6.7-rc2-mm2/net/ipv6/route.c	2004-06-09 13:15:46.000000000
+0200
+++ linux-2.6.7-rc3-mm1/net/ipv6/route.c	2004-06-09 12:55:19.000000000
+0200
@@ -83,9 +83,11 @@
 static struct rt6_info * ip6_rt_copy(struct rt6_info *ort);
 static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32
cookie);
 static struct dst_entry *ip6_negative_advice(struct dst_entry *);
+static void		ip6_dst_destroy(struct dst_entry *);
 static int		 ip6_dst_gc(void);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
+static int		ip6_pkt_discard_out(struct sk_buff **pskb);
 static void		ip6_link_failure(struct sk_buff *skb);
 static void		ip6_rt_update_pmtu(struct dst_entry *dst, u32 mtu);
 
@@ -95,6 +97,7 @@
 	.gc			=	ip6_dst_gc,
 	.gc_thresh		=	1024,
 	.check			=	ip6_dst_check,
+	.destroy		=	ip6_dst_destroy,
 	.negative_advice	=	ip6_negative_advice,
 	.link_failure		=	ip6_link_failure,
 	.update_pmtu		=	ip6_rt_update_pmtu,
@@ -111,7 +114,7 @@
 			.error		= -ENETUNREACH,
 			.metrics	= { [RTAX_HOPLIMIT - 1] = 255, },
 			.input		= ip6_pkt_discard,
-			.output		= ip6_pkt_discard,
+			.output		= ip6_pkt_discard_out,
 			.ops		= &ip6_dst_ops,
 			.path		= (struct dst_entry*)&ip6_null_entry,
 		}
@@ -134,7 +137,15 @@
 /* allocate dst with ip6_dst_ops */
 static __inline__ struct rt6_info *ip6_dst_alloc(void)
 {
-	return dst_alloc(&ip6_dst_ops);
+	return (struct rt6_info *)dst_alloc(&ip6_dst_ops);
+}
+
+static void ip6_dst_destroy(struct dst_entry *dst)
+{
+	struct rt6_info *rt = (struct rt6_info *)dst;
+	if (rt->rt6i_idev != NULL)
+		in6_dev_put(rt->rt6i_idev);
+	
 }
 
 /*
@@ -566,21 +577,21 @@
 struct dst_entry *ndisc_dst_alloc(struct net_device *dev, 
 				  struct neighbour *neigh,
 				  struct in6_addr *addr,
-				  int (*output)(struct sk_buff *))
+				  int (*output)(struct sk_buff **))
 {
 	struct rt6_info *rt = ip6_dst_alloc();
 
 	if (unlikely(rt == NULL))
 		goto out;
 
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	if (neigh)
 		neigh_hold(neigh);
 	else
 		neigh = ndisc_get_neigh(dev, addr);
 
 	rt->rt6i_dev	  = dev;
+	rt->rt6i_idev     = in6_dev_get(dev);
 	rt->rt6i_nexthop  = neigh;
 	rt->rt6i_expires  = 0;
 	rt->rt6i_flags    = RTF_LOCAL;
@@ -714,6 +725,12 @@
 	if (rtmsg->rtmsg_src_len)
 		return -EINVAL;
 #endif
+	if (rtmsg->rtmsg_ifindex) {
+		dev = dev_get_by_index(rtmsg->rtmsg_ifindex);
+		if (!dev)
+			return -ENODEV;
+	}
+
 	if (rtmsg->rtmsg_metric == 0)
 		rtmsg->rtmsg_metric = IP6_RT_PRIO_USER;
 
@@ -739,13 +756,6 @@
 
 	rt->u.dst.output = ip6_output;
 
-	if (rtmsg->rtmsg_ifindex) {
-		dev = dev_get_by_index(rtmsg->rtmsg_ifindex);
-		err = -ENODEV;
-		if (dev == NULL)
-			goto out;
-	}
-
 	ipv6_addr_prefix(&rt->rt6i_dst.addr, 
 			 &rtmsg->rtmsg_dst, rtmsg->rtmsg_dst_len);
 	rt->rt6i_dst.plen = rtmsg->rtmsg_dst_len;
@@ -769,7 +779,7 @@
 			dev_put(dev);
 		dev = &loopback_dev;
 		dev_hold(dev);
-		rt->u.dst.output = ip6_pkt_discard;
+		rt->u.dst.output = ip6_pkt_discard_out;
 		rt->u.dst.input = ip6_pkt_discard;
 		rt->u.dst.error = -ENETUNREACH;
 		rt->rt6i_flags = RTF_REJECT|RTF_NONEXTHOP;
@@ -872,6 +882,7 @@
 	if (!rt->u.dst.metrics[RTAX_ADVMSS-1])
 		rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.dev = dev;
+	rt->rt6i_idev = in6_dev_get(dev);
 	return rt6_ins(rt, nlh, _rtattr);
 
 out:
@@ -1138,6 +1149,9 @@
 		rt->u.dst.dev = ort->u.dst.dev;
 		if (rt->u.dst.dev)
 			dev_hold(rt->u.dst.dev);
+		rt->rt6i_idev = ort->rt6i_idev;
+		if (rt->rt6i_idev)
+			in6_dev_hold(rt->rt6i_idev);
 		rt->u.dst.lastuse = jiffies;
 		rt->rt6i_expires = 0;
 
@@ -1259,12 +1273,17 @@
 
 int ip6_pkt_discard(struct sk_buff *skb)
 {
-	IP6_INC_STATS(Ip6OutNoRoutes);
+	IP6_INC_STATS(OutNoRoutes);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_NOROUTE, 0, skb->dev);
 	kfree_skb(skb);
 	return 0;
 }
 
+int ip6_pkt_discard_out(struct sk_buff **pskb)
+{
+	return ip6_pkt_discard(*pskb);
+}
+
 /*
  *	Add address
  */
@@ -1282,6 +1301,7 @@
 	rt->u.dst.input = ip6_input;
 	rt->u.dst.output = ip6_output;
 	rt->rt6i_dev = &loopback_dev;
+	rt->rt6i_idev = in6_dev_get(&loopback_dev);
 	rt->u.dst.metrics[RTAX_MTU-1] = ipv6_get_mtu(rt->rt6i_dev);
 	rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.metrics[RTAX_HOPLIMIT-1] = ipv6_get_hoplimit(rt->rt6i_dev);


It seems there is some kind of misreferencing, which was introduced by
the previous changes. I'm still trying to figure out what's going on.

Reverting these changes allows "cardctl eject" to proceed even when a
userspace process has an active open socket. However, reverting these
changes breaks IPv6 a little bit for me.

I don't have access to BK, but it could be interesting to look at the
changesets that caused these changes.

Any other ideas?


