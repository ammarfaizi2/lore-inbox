Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbTHTVgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTHTVgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:36:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5388 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262248AbTHTVgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:36:45 -0400
Date: Wed, 20 Aug 2003 23:34:43 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [RFC][2.4 PATCH] source address selection for ARP requests
Message-ID: <20030820213443.GA23939@alpha.home.local>
References: <1061320363.3744.14.camel@athena.fprintf.net> <Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com> <20030820100044.3127d612.davem@redhat.com> <3F43B389.5060602@candelatech.com> <20030820104831.6235f3b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820104831.6235f3b9.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Aug 20, 2003 at 10:48:31AM -0700, David S. Miller wrote:
> On Wed, 20 Aug 2003 10:44:41 -0700
> Ben Greear <greearb@candelatech.com> wrote:
> 
> > It seems that these reasons would not preclude the addition of a flag
> > that would default to the current behaviour but allow the behaviour that
> > other setups desire easily?
> 
> I would accept a patch that did something like
> the following in arp_solicit().
> 
> 	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
> 	    (in_dev->conf.shared_media ||
> 	     inet_addr_onlink(dev, skb->nh.iph->saddr, 0)))
> 		saddr = skb->nh.iph->saddr;
> 	else
> 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINE);
> 

I finally found some time to code and test both Alexey's idea and the one I
derived from it the other day.

1) Alexey's solution (above, patch below)

It solves most issues discussed previously, which showed up on somewhat common
setups like this one :

                Server                        Gateway
    eth0=10.0.0.1   eth1=11.0.0.1 --------- IP=11.0.0.2

When server receives a ping to 10.0.0.1 from Gateway or some host behind it, it
will now properly select 11.0.0.1 for the ARP request prior to sending its
echo reply. This behaviour requires the user to explicitly set
eth1/shared_media and all/shared_media to 0 (not too hard).

=> So the patch below fixes most problems.

-8<--------------------------

--- linux-2.4.22-rc2/net/ipv4/arp.c	Wed Jul 30 09:19:06 2003
+++ linux-2.4.22-rc2-arp/net/ipv4/arp.c	Wed Aug 20 21:19:42 2003
@@ -320,13 +320,22 @@
 	u32 saddr;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
+	struct in_device *in_dev = in_dev_get(dev);
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+	if (in_dev == NULL)
+		return;
+
+	if (in_dev->ifa_list == NULL ||
+	    (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
+	    (IN_DEV_SHARED_MEDIA(in_dev) ||
+	    inet_addr_onlink(in_dev, skb->nh.iph->saddr, 0))))
 		saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+
+	in_dev_put(in_dev);
 
 	if ((probes -= neigh->parms->ucast_probes) < 0) {
 		if (!(neigh->nud_state&NUD_VALID))

-8<--------------------------

However, there still is a case which is not covered : when the source address
is itself on the same interface. Let's take the previous example and add an
alias to eth1 :

                Server                        Gateway
    eth0=10.0.0.1   eth1=11.0.0.1 --------- IP=11.0.0.2
                         12.0.0.1

If gateway pings 12.0.0.1, Server will use this address to send its ARP
requests (because of the 'inet_addr_onlink' above). The workaround would
simply be to move the alias somewhere else...

Second, you were concerned about breaking setups with no IP address on eth1
because inet_addr_onlink() will return 0,  and inet_select_addr() will fail,
in the event they would run with shared_media=0 :

                Server                        Gateway
    eth0=10.0.0.1   eth1=*no IP* ---------- IP=11.0.0.2

In fact, inet_select_addr() is smarter than inet_addr_onlink() in that it can
also return non-loopback addresses set to the loopback interface. Moreover, if
it fails, it returns 0, which is a good test to drop back to the current
behaviour (use skb->nh.iph->saddr). I didn't manage to get my interface to
send ARP requests when I have no IP address on it, because I don't know how
to do, since I cannot add a route to it. I presume I could make it work with
SO_BINDTODEVICE + MSG_DONTROUTE, but I don't have time to try all this.

So please look at this code now :

-8<-------------------------------

diff -urN linux-2.4.22-rc2/net/ipv4/arp.c linux-2.4.22-rc2-arp3/net/ipv4/arp.c
--- linux-2.4.22-rc2/net/ipv4/arp.c	Wed Jul 30 09:19:06 2003
+++ linux-2.4.22-rc2-arp3/net/ipv4/arp.c	Wed Aug 20 23:11:53 2003
@@ -320,13 +320,21 @@
 	u32 saddr;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
+	struct in_device *in_dev = in_dev_get(dev);
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
-		saddr = skb->nh.iph->saddr;
+	if (in_dev == NULL)
+		return;
+
+	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
+	    (IN_DEV_SHARED_MEDIA(in_dev) ||
+	     (saddr = inet_select_addr(dev, target, RT_SCOPE_LINK)) == 0))
+			saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+
+	in_dev_put(in_dev);
 
 	if ((probes -= neigh->parms->ucast_probes) < 0) {
 		if (!(neigh->nud_state&NUD_VALID))


-8<-------------------------------

It will correctly pick the most appropriate address when shared_media=0, and
will also drop back to the current behaviour when there's no IP yet on the
device.

It also enhances an interesting point compared to the previous one : it allows
broken setups such as the one below to select the valid source IP depending on
source route :


                Server                        Gateway
    eth0=11.0.0.1   eth1=10.0.0.1 --------- IP=11.0.0.2

    ip addr  add 11.0.0.1/N dev eth0
    ip addr  add 10.0.0.1/M dev eth1 scope host
    ip route add 11.0.0.2 dev eth1 src 11.0.0.1

=> ARP requests sent to 11.0.0.2 "correctly" use 11.0.0.1 as the source IP.

I'm not sure this setup will concern anyone, but I came across it during my
tests of the patch, and thought that for evry setup which people will be able
to configure themselves without patching, there will be less whiners ;-)

I'd sincerely prefer the later patch to be tested and integrated, but Alexey's
first idea was the former, so I don't know which one you'll pick.

Of course, if you're willing to apply one of them, I'll try to port them to
2.6.

Cheers,
Willy

