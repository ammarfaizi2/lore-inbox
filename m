Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVBHBbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVBHBbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBHBbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:31:05 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:7686 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261375AbVBHBar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:30:47 -0500
Date: Tue, 8 Feb 2005 12:29:29 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: [IPSEC] Move dst->child loop from dst_ifdown to xfrm_dst_ifdown
Message-ID: <20050208012929.GA30659@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <20050204221344.247548cb.davem@davemloft.net> <20050205064643.GA29758@gondor.apana.org.au> <20050205201044.1b95f4e8.davem@davemloft.net> <20050206065117.GC16057@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20050206065117.GC16057@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 06, 2005 at 05:51:17PM +1100, herbert wrote:
> 
> The idea is to move the check into dst->ops->ifdown.  By definition
> ipv6_dst_ifdown will only see rt6_info entries.  So dst_dev_event
> will become

Here are the patches to do this.  Do they look sane?

This one moves the dst->child processing from dst_ifdown into
xfrm_dst_ifdown.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dst-patch-1

===== net/core/dst.c 1.26 vs edited =====
--- 1.26/net/core/dst.c	2005-02-06 14:23:59 +11:00
+++ edited/net/core/dst.c	2005-02-08 12:11:39 +11:00
@@ -220,31 +220,26 @@
  *
  * Commented and originally written by Alexey.
  */
-static void dst_ifdown(struct dst_entry *dst, int unregister)
+static inline void dst_ifdown(struct dst_entry *dst, int unregister)
 {
 	struct net_device *dev = dst->dev;
 
+	if (dst->ops->ifdown)
+		dst->ops->ifdown(dst, unregister);
+
 	if (!unregister) {
 		dst->input = dst_discard_in;
 		dst->output = dst_discard_out;
-	}
-
-	do {
-		if (unregister) {
-			dst->dev = &loopback_dev;
-			dev_hold(&loopback_dev);
+	} else {
+		dst->dev = &loopback_dev;
+		dev_hold(&loopback_dev);
+		dev_put(dev);
+		if (dst->neighbour && dst->neighbour->dev == dev) {
+			dst->neighbour->dev = &loopback_dev;
 			dev_put(dev);
-			if (dst->neighbour && dst->neighbour->dev == dev) {
-				dst->neighbour->dev = &loopback_dev;
-				dev_put(dev);
-				dev_hold(&loopback_dev);
-			}
+			dev_hold(&loopback_dev);
 		}
-
-		if (dst->ops->ifdown)
-			dst->ops->ifdown(dst, unregister);
-	} while ((dst = dst->child) && dst->flags & DST_NOHASH &&
-		 dst->dev == dev);
+	}
 }
 
 static int dst_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
===== net/xfrm/xfrm_policy.c 1.63 vs edited =====
--- 1.63/net/xfrm/xfrm_policy.c	2005-01-19 07:08:19 +11:00
+++ edited/net/xfrm/xfrm_policy.c	2005-02-08 12:10:47 +11:00
@@ -1027,6 +1027,20 @@
 	dst->xfrm = NULL;
 }
 
+static void xfrm_dst_ifdown(struct dst_entry *dst, int unregister)
+{
+	struct net_device *dev = dst->dev;
+
+	if (!unregister)
+		return;
+
+	while ((dst = dst->child) && dst->xfrm && dst->dev == dev) {
+		dst->dev = &loopback_dev;
+		dev_hold(&loopback_dev);
+		dev_put(dev);
+	}
+}
+
 static void xfrm_link_failure(struct sk_buff *skb)
 {
 	/* Impossible. Such dst must be popped before reaches point of failure. */
@@ -1150,6 +1164,8 @@
 			dst_ops->check = xfrm_dst_check;
 		if (likely(dst_ops->destroy == NULL))
 			dst_ops->destroy = xfrm_dst_destroy;
+		if (likely(dst_ops->ifdown == NULL))
+			dst_ops->ifdown = xfrm_dst_ifdown;
 		if (likely(dst_ops->negative_advice == NULL))
 			dst_ops->negative_advice = xfrm_negative_advice;
 		if (likely(dst_ops->link_failure == NULL))
@@ -1181,6 +1197,7 @@
 			dst_ops->kmem_cachep = NULL;
 			dst_ops->check = NULL;
 			dst_ops->destroy = NULL;
+			dst_ops->ifdown = NULL;
 			dst_ops->negative_advice = NULL;
 			dst_ops->link_failure = NULL;
 			dst_ops->get_mss = NULL;

--nFreZHaLTZJo0R7j--
