Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTHTXBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTHTXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:01:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27916 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262316AbTHTXBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:01:35 -0400
Date: Thu, 21 Aug 2003 00:59:37 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][2.4 PATCH] source address selection for ARP requests
Message-ID: <20030820225937.GB25311@alpha.home.local>
References: <1061320363.3744.14.camel@athena.fprintf.net> <Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com> <20030820100044.3127d612.davem@redhat.com> <3F43B389.5060602@candelatech.com> <20030820104831.6235f3b9.davem@redhat.com> <20030820213443.GA23939@alpha.home.local> <20030820144711.13ea5f38.davem@redhat.com> <20030820222710.GC734@alpha.home.local> <20030820153548.60e0cbd8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820153548.60e0cbd8.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 03:35:48PM -0700, David S. Miller wrote:
> On Thu, 21 Aug 2003 00:27:10 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > +	if (in_dev == NULL)
> > +		in_dev_put(in_dev);
> 
> What the heck is this? :-)

Hmmm... don't you see ? A copy-paste bug, of course ! Sorry for this, I hope
noone's fool enough to use it as-is. I guess it's becoming late, and I'm a bit
weak in front of my temptations to use 'dd' .... 'P' in vi !

Here's the fixed one (hand-edited, not tested). At least, I'm happy to see that
I'm not the only one reading other's patches :-)

BTW, you didn't tell me if it's necessary to test in_dev->ifa_list. I see that
I kept the test in patch 1 but removed it in patch 2.

Willy

patch 1 :

diff -urN linux-2.4.22-rc2/net/ipv4/arp.c linux-2.4.22-rc2-arp/net/ipv4/arp.c
--- linux-2.4.22-rc2/net/ipv4/arp.c	Fri Aug  1 23:06:29 2003
+++ linux-2.4.22-rc2-arp/net/ipv4/arp.c	Thu Aug 21 00:20:19 2003
@@ -320,13 +320,20 @@
 	u32 saddr;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
+	struct in_device *in_dev = in_dev_get(dev);
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+	if (in_dev == NULL || in_dev->ifa_list == NULL ||
+	    (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
+	    (IN_DEV_SHARED_MEDIA(in_dev) ||
+	    inet_addr_onlink(in_dev, skb->nh.iph->saddr, 0))))
 		saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+
+	if (in_dev != NULL)
+		in_dev_put(in_dev);
 
 	if ((probes -= neigh->parms->ucast_probes) < 0) {
 		if (!(neigh->nud_state&NUD_VALID))


patch 2 :

diff -urN linux-2.4.22-rc2/net/ipv4/arp.c linux-2.4.22-rc2-arp2/net/ipv4/arp.c
--- linux-2.4.22-rc2/net/ipv4/arp.c	Fri Aug  1 23:06:29 2003
+++ linux-2.4.22-rc2-arp2/net/ipv4/arp.c	Thu Aug 21 00:24:25 2003
@@ -320,13 +320,19 @@
 	u32 saddr;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
+	struct in_device *in_dev = in_dev_get(dev);
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
-		saddr = skb->nh.iph->saddr;
+	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
+	    (in_dev == NULL || IN_DEV_SHARED_MEDIA(in_dev) ||
+	     (saddr = inet_select_addr(dev, target, RT_SCOPE_LINK)) == 0))
+			saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+
+	if (in_dev != NULL)
+		in_dev_put(in_dev);
 
 	if ((probes -= neigh->parms->ucast_probes) < 0) {
 		if (!(neigh->nud_state&NUD_VALID))


