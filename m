Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUG1Oyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUG1Oyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUG1Oyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:54:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:51408 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267185AbUG1Oyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:54:44 -0400
Date: Wed, 28 Jul 2004 16:53:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Pedro Roque <roque@di.fc.ul.pt>
Cc: Andrew Morton <akpm@osdl.org>, John Cherry <cherry@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix inlining of ipv6_advmss  (Was: IA32 (2.6.8-rc2 -
 2004-07-26.22.30) - 1 New warnings (gcc 3.2.2))
In-Reply-To: <200407271333.i6RDXtGI008250@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.60.0407281645440.18921@jjulnx.backbone.dif.dk>
References: <200407271333.i6RDXtGI008250@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, John Cherry wrote:

> net/ipv6/route.c:696: warning: `ipv6_advmss' declared inline after being called

Following is a patch to fix that warning by moving the inline function up 
a bit before the point of its first use.
I also removed the forward declaration since it's no longer needed with 
the new location of the function.
Patch is against 2.6.8-rc2 - please review and consider for inclusion.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc2-orig/net/ipv6/route.c linux-2.6.8-rc2/net/ipv6/route.c
--- linux-2.6.8-rc2-orig/net/ipv6/route.c	2004-07-27 16:45:09.000000000 +0200
+++ linux-2.6.8-rc2/net/ipv6/route.c	2004-07-28 16:42:48.000000000 +0200
@@ -584,7 +584,24 @@ static void ip6_rt_update_pmtu(struct ds
  /* Protected by rt6_lock.  */
  static struct dst_entry *ndisc_dst_gc_list;
  static int ipv6_get_mtu(struct net_device *dev);
-static inline unsigned int ipv6_advmss(unsigned int mtu);
+
+static inline unsigned int ipv6_advmss(unsigned int mtu)
+{
+	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
+
+	if (mtu < ip6_rt_min_advmss)
+		mtu = ip6_rt_min_advmss;
+
+	/*
+	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and 
+	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size. 
+	 * IPV6_MAXPLEN is also valid and means: "any MSS, 
+	 * rely only on pmtu discovery"
+	 */
+	if (mtu > IPV6_MAXPLEN - sizeof(struct tcphdr))
+		mtu = IPV6_MAXPLEN;
+	return mtu;
+}

  struct dst_entry *ndisc_dst_alloc(struct net_device *dev,
  				  struct neighbour *neigh,
@@ -692,24 +709,6 @@ static int ipv6_get_mtu(struct net_devic
  	return mtu;
  }

-static inline unsigned int ipv6_advmss(unsigned int mtu)
-{
-	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
-
-	if (mtu < ip6_rt_min_advmss)
-		mtu = ip6_rt_min_advmss;
-
-	/*
-	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and 
-	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size. 
-	 * IPV6_MAXPLEN is also valid and means: "any MSS, 
-	 * rely only on pmtu discovery"
-	 */
-	if (mtu > IPV6_MAXPLEN - sizeof(struct tcphdr))
-		mtu = IPV6_MAXPLEN;
-	return mtu;
-}
-
  static int ipv6_get_hoplimit(struct net_device *dev)
  {
  	int hoplimit = ipv6_devconf.hop_limit;



