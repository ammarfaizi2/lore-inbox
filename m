Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVBHBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVBHBeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVBHBeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:34:06 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:11270 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261379AbVBHBcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:32:07 -0500
Date: Tue, 8 Feb 2005 12:31:40 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: [IPSEC] Move dst->child loop from dst_ifdown to xfrm_dst_ifdown
Message-ID: <20050208013140.GB30659@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <20050204221344.247548cb.davem@davemloft.net> <20050205064643.GA29758@gondor.apana.org.au> <20050205201044.1b95f4e8.davem@davemloft.net> <20050206065117.GC16057@gondor.apana.org.au> <20050208012929.GA30659@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20050208012929.GA30659@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 08, 2005 at 12:29:29PM +1100, herbert wrote:
> 
> This one moves the dst->child processing from dst_ifdown into
> xfrm_dst_ifdown.

This patch adds a net_device argument to ifdown.  After all,
it's a bit silly to notify someone of an ifdown event without
telling them what which device it was for :)

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dst-patch-2

===== include/net/dst.h 1.25 vs edited =====
--- 1.25/include/net/dst.h	2005-02-06 14:23:59 +11:00
+++ edited/include/net/dst.h	2005-02-08 12:14:10 +11:00
@@ -89,7 +89,8 @@
 	int			(*gc)(void);
 	struct dst_entry *	(*check)(struct dst_entry *, __u32 cookie);
 	void			(*destroy)(struct dst_entry *);
-	void			(*ifdown)(struct dst_entry *, int how);
+	void			(*ifdown)(struct dst_entry *,
+					  struct net_device *dev, int how);
 	struct dst_entry *	(*negative_advice)(struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, u32 mtu);
===== net/core/dst.c 1.27 vs edited =====
--- 1.27/net/core/dst.c	2005-02-08 12:12:21 +11:00
+++ edited/net/core/dst.c	2005-02-08 12:15:03 +11:00
@@ -220,12 +220,14 @@
  *
  * Commented and originally written by Alexey.
  */
-static inline void dst_ifdown(struct dst_entry *dst, int unregister)
+static inline void dst_ifdown(struct dst_entry *dst, struct net_device *dev,
+			      int unregister)
 {
-	struct net_device *dev = dst->dev;
-
 	if (dst->ops->ifdown)
-		dst->ops->ifdown(dst, unregister);
+		dst->ops->ifdown(dst, dev, unregister);
+
+	if (dev != dst->dev)
+		return;
 
 	if (!unregister) {
 		dst->input = dst_discard_in;
@@ -252,8 +254,7 @@
 	case NETDEV_DOWN:
 		spin_lock_bh(&dst_lock);
 		for (dst = dst_garbage_list; dst; dst = dst->next) {
-			if (dst->dev == dev)
-				dst_ifdown(dst, event != NETDEV_DOWN);
+			dst_ifdown(dst, dev, event != NETDEV_DOWN);
 		}
 		spin_unlock_bh(&dst_lock);
 		break;
===== net/ipv4/route.c 1.101 vs edited =====
--- 1.101/net/ipv4/route.c	2005-02-03 07:43:48 +11:00
+++ edited/net/ipv4/route.c	2005-02-08 12:14:11 +11:00
@@ -138,7 +138,8 @@
 
 static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static void		 ipv4_dst_destroy(struct dst_entry *dst);
-static void		 ipv4_dst_ifdown(struct dst_entry *dst, int how);
+static void		 ipv4_dst_ifdown(struct dst_entry *dst,
+					 struct net_device *dev, int how);
 static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, u32 mtu);
@@ -1342,11 +1343,12 @@
 	}
 }
 
-static void ipv4_dst_ifdown(struct dst_entry *dst, int how)
+static void ipv4_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
+			    int how)
 {
 	struct rtable *rt = (struct rtable *) dst;
 	struct in_device *idev = rt->idev;
-	if (idev && idev->dev != &loopback_dev) {
+	if (dev != &loopback_dev && idev && idev->dev == dev) {
 		struct in_device *loopback_idev = in_dev_get(&loopback_dev);
 		if (loopback_idev) {
 			rt->idev = loopback_idev;
===== net/ipv6/route.c 1.105 vs edited =====
--- 1.105/net/ipv6/route.c	2005-01-15 19:44:48 +11:00
+++ edited/net/ipv6/route.c	2005-02-08 12:14:11 +11:00
@@ -84,7 +84,8 @@
 static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
-static void		ip6_dst_ifdown(struct dst_entry *, int how);
+static void		ip6_dst_ifdown(struct dst_entry *,
+				       struct net_device *dev, int how);
 static int		 ip6_dst_gc(void);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
@@ -153,12 +154,13 @@
 	}	
 }
 
-static void ip6_dst_ifdown(struct dst_entry *dst, int how)
+static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
+			   int how)
 {
 	struct rt6_info *rt = (struct rt6_info *)dst;
 	struct inet6_dev *idev = rt->rt6i_idev;
 
-	if (idev != NULL && idev->dev != &loopback_dev) {
+	if (dev != &loopback_dev && idev != NULL && idev->dev == dev) {
 		struct inet6_dev *loopback_idev = in6_dev_get(&loopback_dev);
 		if (loopback_idev != NULL) {
 			rt->rt6i_idev = loopback_idev;
===== net/xfrm/xfrm_policy.c 1.64 vs edited =====
--- 1.64/net/xfrm/xfrm_policy.c	2005-02-08 12:12:21 +11:00
+++ edited/net/xfrm/xfrm_policy.c	2005-02-08 12:15:35 +11:00
@@ -1027,10 +1027,9 @@
 	dst->xfrm = NULL;
 }
 
-static void xfrm_dst_ifdown(struct dst_entry *dst, int unregister)
+static void xfrm_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
+			    int unregister)
 {
-	struct net_device *dev = dst->dev;
-
 	if (!unregister)
 		return;
 

--8GpibOaaTibBMecb--
