Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUFJUIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUFJUIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFJUIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:08:50 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11019 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262850AbUFJUIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:08:43 -0400
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610083652.6f3ba3a6@dell_ss3.pdx.osdl.net>
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>
	 <20040608124215.291a7072@dell_ss3.pdx.osdl.net>
	 <1086725369.1806.1.camel@teapot.felipe-alfaro.com>
	 <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>
	 <1086794282.1706.2.camel@teapot.felipe-alfaro.com>
	 <20040610083652.6f3ba3a6@dell_ss3.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-RnxxLieq1EmsPewn9/I0"
Date: Thu, 10 Jun 2004 22:08:46 +0200
Message-Id: <1086898126.2542.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RnxxLieq1EmsPewn9/I0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-06-10 at 08:36 -0700, Stephen Hemminger wrote:
> On Wed, 09 Jun 2004 17:18:02 +0200
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> 
> > On Tue, 2004-06-08 at 14:02 -0700, Stephen Hemminger wrote:
> > > On Tue, 08 Jun 2004 22:09:29 +0200
> > > Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> > > 
> > > > On Tue, 2004-06-08 at 12:42 -0700, Stephen Hemminger wrote:
> > > > > On Tue, 08 Jun 2004 21:18:30 +0200
> > > > > Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> > > > > 
> > > > > > Hi!
> > > > > > 
> > > > > > On my laptop, when using a CardBus 3c59x-based NIC, I need to run
> > > > > > "cardctl eject" so the system won't freeze when resuming. "cardctl
> > > > > > eject" worked fine in 2.6.7-rc2-mm2, even when there were programs with
> > > > > > network sockets opened (for example, Evolution mantaining a connection
> > > > > > against an IMAP server): the card is ejected (well, not physically),
> > > > > > even when there are ESTABLISHED connections.
> > > > > > 
> > > > > > However, starting with 2.6.7-rc3, "cardctl eject" hangs if a program
> > > > > > holds any socket open. After a while the "unregister_netdevice: waiting
> > > > > > for eth0 to become free" message starts appearing on the kernel message
> > > > > > ring. The only apparent solution is killing that program, ejecting the
> > > > > > card from its slot and wait until 3c59x.o usage count reaches zero.
> > > > > > 
> > > > > > Can someone tell me what's going on here?
> > > > > > Thank you very much.
> > > > > 
> > > > > What protocols are you running? Is IPV6 loaded?
> > > > 
> > > > I'm using IPv4, IPv6 and IPSec ESP with AES/CBC.
> > > > Do you want .config?
> > > 
> > > Not really, could you see if it is an IPv6 vs IPSec problem by not running/loading
> > > one or the other.
> > > 
> > > What is happening is that some subsystem is holding a reference to the device (calling dev_hold())
> > > but not cleaning up (calling dev_put).  It can be a hard to track which of the many
> > > things routing, etc are not being cleared properly.  Look for routes that still
> > > get stuck (ip route) and neighbor cache entries.  Most of these end up being
> > > protocol bugs.
> > 
> > The two attached patches, one for net/ipv4/route.c, the other for net/
> > ipv6/route.c fix all my problems when running "cardctl eject" while a
> > program mantains an open network socket (ESTABLISHED).
> > 
> > Both patches apply cleanly against 2.6.7-rc3 and 2.6.7-rc3-mm1.
> > I'm not completely sure what has changed in 2.6.7-rc3 that is breaking
> > cardctl for me, as it Just Worked(TM) fine in 2.6.7-rc2.
> > 
> > Hope this can throw some light at this issue.
> 
> Since you effectively remove rth->idev, why not remove it from the structure
> to make sure no code is still expecting it to be set.

What about the following one? Tested on 2.6.7-rc3-mm1.

--=-RnxxLieq1EmsPewn9/I0
Content-Disposition: attachment; filename=ip-route-fix-refcount.patch
Content-Type: text/x-patch; name=ip-route-fix-refcount.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.7-rc3-mm1.old/include/net/route.h linux-2.6.7-rc3-mm1/include/net/route.h
--- linux-2.6.7-rc3-mm1.old/include/net/route.h	2004-06-10 21:22:15.877298171 +0200
+++ linux-2.6.7-rc3-mm1/include/net/route.h	2004-06-10 21:09:34.000000000 +0200
@@ -55,8 +55,6 @@
 		struct rtable		*rt_next;
 	} u;
 
-	struct in_device	*idev;
-	
 	unsigned		rt_flags;
 	unsigned		rt_type;
 
diff -uNr linux-2.6.7-rc3-mm1.old/net/ipv4/route.c linux-2.6.7-rc3-mm1/net/ipv4/route.c
--- linux-2.6.7-rc3-mm1.old/net/ipv4/route.c	2004-06-10 21:22:16.042259029 +0200
+++ linux-2.6.7-rc3-mm1/net/ipv4/route.c	2004-06-10 21:18:14.280624151 +0200
@@ -1040,8 +1040,6 @@
 				rt->u.dst.child		= NULL;
 				if (rt->u.dst.dev)
 					dev_hold(rt->u.dst.dev);
-				if (rt->idev)
-					in_dev_hold(rt->idev);
 				rt->u.dst.obsolete	= 0;
 				rt->u.dst.lastuse	= jiffies;
 				rt->u.dst.path		= &rt->u.dst;
@@ -1323,17 +1321,11 @@
 {
 	struct rtable *rt = (struct rtable *) dst;
 	struct inet_peer *peer = rt->peer;
-	struct in_device *idev = rt->idev;
 
 	if (peer) {
 		rt->peer = NULL;
 		inet_putpeer(peer);
 	}
-
-	if (idev) {
-		rt->idev = NULL;
-		in_dev_put(idev);
-	}
 }
 
 static void ipv4_link_failure(struct sk_buff *skb)
@@ -1496,7 +1488,6 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= &loopback_dev;
 	dev_hold(rth->u.dst.dev);
-	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->fl.oif	= 0;
 	rth->rt_gateway	= daddr;
 	rth->rt_spec_dst= spec_dst;
@@ -1706,7 +1697,6 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= out_dev->dev;
 	dev_hold(rth->u.dst.dev);
-	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->fl.oif 	= 0;
 	rth->rt_spec_dst= spec_dst;
 
@@ -1786,7 +1776,6 @@
 	rth->fl.iif	= dev->ifindex;
 	rth->u.dst.dev	= &loopback_dev;
 	dev_hold(rth->u.dst.dev);
-	rth->idev	= in_dev_get(rth->u.dst.dev);
 	rth->rt_gateway	= daddr;
 	rth->rt_spec_dst= spec_dst;
 	rth->u.dst.input= ip_local_deliver;
@@ -2170,7 +2159,6 @@
 	rth->rt_iif	= oldflp->oif ? : dev_out->ifindex;
 	rth->u.dst.dev	= dev_out;
 	dev_hold(dev_out);
-	rth->idev	= in_dev_get(dev_out);
 	rth->rt_gateway = fl.fl4_dst;
 	rth->rt_spec_dst= fl.fl4_src;
 
diff -uNr linux-2.6.7-rc3-mm1.old/net/ipv6/route.c linux-2.6.7-rc3-mm1/net/ipv6/route.c
--- linux-2.6.7-rc3-mm1.old/net/ipv6/route.c	2004-06-10 21:22:16.068252861 +0200
+++ linux-2.6.7-rc3-mm1/net/ipv6/route.c	2004-06-10 00:07:10.000000000 +0200
@@ -584,14 +584,14 @@
 	if (unlikely(rt == NULL))
 		goto out;
 
-	dev_hold(dev);
+	if(dev)
+		dev_hold(dev);
 	if (neigh)
 		neigh_hold(neigh);
 	else
 		neigh = ndisc_get_neigh(dev, addr);
 
 	rt->rt6i_dev	  = dev;
-	rt->rt6i_idev     = in6_dev_get(dev);
 	rt->rt6i_nexthop  = neigh;
 	rt->rt6i_expires  = 0;
 	rt->rt6i_flags    = RTF_LOCAL;
@@ -882,7 +882,6 @@
 	if (!rt->u.dst.metrics[RTAX_ADVMSS-1])
 		rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.dev = dev;
-	rt->rt6i_idev = in6_dev_get(dev);
 	return rt6_ins(rt, nlh, _rtattr);
 
 out:
@@ -1301,7 +1300,6 @@
 	rt->u.dst.input = ip6_input;
 	rt->u.dst.output = ip6_output;
 	rt->rt6i_dev = &loopback_dev;
-	rt->rt6i_idev = in6_dev_get(&loopback_dev);
 	rt->u.dst.metrics[RTAX_MTU-1] = ipv6_get_mtu(rt->rt6i_dev);
 	rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.metrics[RTAX_HOPLIMIT-1] = ipv6_get_hoplimit(rt->rt6i_dev);

--=-RnxxLieq1EmsPewn9/I0--

