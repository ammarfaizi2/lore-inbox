Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbVBEGOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbVBEGOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbVBEGMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:12:41 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:9994 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263374AbVBEGLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:11:52 -0500
Date: Sat, 5 Feb 2005 17:11:10 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050205061110.GA18275@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20050204213813.4bd642ad.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2005 at 09:38:13PM -0800, David S. Miller wrote:
> 
> It is just the first such thing I found, scanning rt6i_idev uses
> will easily find several others.

You're right of course.  I thought they were all harmless but I was
obviously wrong about this one.

So here is a patch that essentially reverts the split devices
semantics introduced by these two changesets:

  [IPV6] addrconf_dst_alloc() to allocate new route for local address.
  [IPV6] take rt6i_idev into account when looking up routes.

Signed-off-by: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== include/net/ip6_route.h 1.21 vs edited =====
--- 1.21/include/net/ip6_route.h	2004-10-26 14:27:49 +10:00
+++ edited/include/net/ip6_route.h	2005-02-05 17:02:36 +11:00
@@ -74,8 +74,7 @@
 extern int ndisc_dst_gc(int *more);
 extern void fib6_force_start_gc(void);
 
-extern struct rt6_info *addrconf_dst_alloc(struct inet6_dev *idev,
-					   const struct in6_addr *addr,
+extern struct rt6_info *addrconf_dst_alloc(const struct in6_addr *addr,
 					   int anycast);
 
 /*
===== net/ipv6/addrconf.c 1.129 vs edited =====
--- 1.129/net/ipv6/addrconf.c	2005-01-18 08:13:31 +11:00
+++ edited/net/ipv6/addrconf.c	2005-02-05 17:02:00 +11:00
@@ -509,7 +509,7 @@
 		goto out;
 	}
 
-	rt = addrconf_dst_alloc(idev, addr, 0);
+	rt = addrconf_dst_alloc(addr, 0);
 	if (IS_ERR(rt)) {
 		err = PTR_ERR(rt);
 		goto out;
===== net/ipv6/anycast.c 1.19 vs edited =====
--- 1.19/net/ipv6/anycast.c	2005-01-15 08:30:07 +11:00
+++ edited/net/ipv6/anycast.c	2005-02-05 17:01:47 +11:00
@@ -340,7 +340,7 @@
 		goto out;
 	}
 
-	rt = addrconf_dst_alloc(idev, addr, 1);
+	rt = addrconf_dst_alloc(addr, 1);
 	if (IS_ERR(rt)) {
 		kfree(aca);
 		err = PTR_ERR(rt);
===== net/ipv6/ip6_fib.c 1.34 vs edited =====
--- 1.34/net/ipv6/ip6_fib.c	2005-01-14 15:41:06 +11:00
+++ edited/net/ipv6/ip6_fib.c	2005-02-05 17:04:02 +11:00
@@ -450,7 +450,6 @@
 			 */
 
 			if (iter->rt6i_dev == rt->rt6i_dev &&
-			    iter->rt6i_idev == rt->rt6i_idev &&
 			    ipv6_addr_equal(&iter->rt6i_gateway,
 					    &rt->rt6i_gateway)) {
 				if (!(iter->rt6i_flags&RTF_EXPIRES))
===== net/ipv6/route.c 1.105 vs edited =====
--- 1.105/net/ipv6/route.c	2005-01-15 19:44:48 +11:00
+++ edited/net/ipv6/route.c	2005-02-05 17:01:23 +11:00
@@ -189,17 +189,8 @@
 			struct net_device *dev = sprt->rt6i_dev;
 			if (dev->ifindex == oif)
 				return sprt;
-			if (dev->flags & IFF_LOOPBACK) {
-				if (sprt->rt6i_idev == NULL ||
-				    sprt->rt6i_idev->dev->ifindex != oif) {
-					if (strict && oif)
-						continue;
-					if (local && (!oif || 
-						      local->rt6i_idev->dev->ifindex == oif))
-						continue;
-				}
+			if (dev->flags & IFF_LOOPBACK)
 				local = sprt;
-			}
 		}
 
 		if (local)
@@ -1385,8 +1376,7 @@
  *	Allocate a dst for local (unicast / anycast) address.
  */
 
-struct rt6_info *addrconf_dst_alloc(struct inet6_dev *idev,
-				    const struct in6_addr *addr,
+struct rt6_info *addrconf_dst_alloc(const struct in6_addr *addr,
 				    int anycast)
 {
 	struct rt6_info *rt = ip6_dst_alloc();
@@ -1395,13 +1385,12 @@
 		return ERR_PTR(-ENOMEM);
 
 	dev_hold(&loopback_dev);
-	in6_dev_hold(idev);
 
 	rt->u.dst.flags = DST_HOST;
 	rt->u.dst.input = ip6_input;
 	rt->u.dst.output = ip6_output;
 	rt->rt6i_dev = &loopback_dev;
-	rt->rt6i_idev = idev;
+	rt->rt6i_idev = in6_dev_get(&loopback_dev);
 	rt->u.dst.metrics[RTAX_MTU-1] = ipv6_get_mtu(rt->rt6i_dev);
 	rt->u.dst.metrics[RTAX_ADVMSS-1] = ipv6_advmss(dst_pmtu(&rt->u.dst));
 	rt->u.dst.metrics[RTAX_HOPLIMIT-1] = ipv6_get_hoplimit(rt->rt6i_dev);

--5vNYLRcllDrimb99--
