Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265122AbUENL71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbUENL71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbUENL71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:59:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30339 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S265122AbUENL7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:59:20 -0400
Date: Fri, 14 May 2004 13:59:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: hch@infradead.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (6/6): network driver.
Message-ID: <20040514115909.GA12049@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> Btw, what about the s390/ipv6 releated patch suse is carrying around
> but which apparently never escaped to a public list?

I assume that you are referring to the patch at the end of this mail.
This has been sent to the netdev list sometime ago (well without the
ndisc.c part about deleting route objects) but it didn't get picked
up for mainline. I'll have to ask our network guys if they tried
again to get it accepted. Last thing I heared was that someone
(David Miller?) was worried about RFC compliance.

blue skies,
  Martin.
---

[PATCH] ipv6: eui64 callback, delete route objects on NETDEV_UNREGISTER.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

IPv6 changes:
 - Add generate_eui64 callback to struct net_device to create unique
   ids for shared network cards.
 - Delete route objects related to netdevices on NETDEV_UNREGISTER events.

diffstat:
 drivers/net/net_init.c    |    7 ++++++-
 include/linux/netdevice.h |    5 +++++
 include/net/addrconf.h    |    1 +
 net/8021q/vlan.c          |    4 ++++
 net/ipv6/addrconf.c       |   12 +++++++-----
 net/ipv6/ndisc.c          |    3 +++
 6 files changed, 26 insertions(+), 6 deletions(-)

diff -urN linux-2.6/drivers/net/net_init.c linux-2.6-s390/drivers/net/net_init.c
--- linux-2.6/drivers/net/net_init.c	Mon May 10 04:31:59 2004
+++ linux-2.6-s390/drivers/net/net_init.c	Thu May 13 21:01:09 2004
@@ -279,7 +279,8 @@
 	dev->hard_header_cache	= eth_header_cache;
 	dev->header_cache_update= eth_header_cache_update;
 	dev->hard_header_parse	= eth_header_parse;
-
+	dev->generate_eui64     = NULL;
+	dev->dev_id             = 0;
 	dev->type		= ARPHRD_ETHER;
 	dev->hard_header_len 	= ETH_HLEN;
 	dev->mtu		= 1500; /* eth_mtu */
@@ -305,6 +306,8 @@
 	dev->change_mtu			= fddi_change_mtu;
 	dev->hard_header		= fddi_header;
 	dev->rebuild_header		= fddi_rebuild_header;
+	dev->generate_eui64             = NULL;
+	dev->dev_id                     = 0;
 
 	dev->type				= ARPHRD_FDDI;
 	dev->hard_header_len	= FDDI_K_SNAP_HLEN+3;	/* Assume 802.2 SNAP hdr len + 3 pad bytes */
@@ -415,6 +418,8 @@
 	
 	dev->hard_header	= tr_header;
 	dev->rebuild_header	= tr_rebuild_header;
+	dev->generate_eui64     = NULL;
+	dev->dev_id             = 0;
 
 	dev->type		= ARPHRD_IEEE802_TR;
 	dev->hard_header_len	= TR_HLEN;
diff -urN linux-2.6/include/linux/netdevice.h linux-2.6-s390/include/linux/netdevice.h
--- linux-2.6/include/linux/netdevice.h	Mon May 10 04:33:20 2004
+++ linux-2.6-s390/include/linux/netdevice.h	Thu May 13 21:01:09 2004
@@ -457,6 +457,7 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
+	int                     (*generate_eui64)(u8 *eui, struct net_device *dev);
 #ifdef CONFIG_NETPOLL_RX
 	int			netpoll_rx;
 #endif
@@ -481,6 +482,10 @@
 	/* class/net/name entry */
 	struct class_device	class_dev;
 	struct net_device_stats* (*last_stats)(struct net_device *);
+
+	/* use dev_id in conjunction with shared network cards*/
+	unsigned short           dev_id;
+
 	/* how much padding had been added by alloc_netdev() */
 	int padded;
 };
diff -urN linux-2.6/include/net/addrconf.h linux-2.6-s390/include/net/addrconf.h
--- linux-2.6/include/net/addrconf.h	Mon May 10 04:33:12 2004
+++ linux-2.6-s390/include/net/addrconf.h	Thu May 13 21:01:09 2004
@@ -70,6 +70,7 @@
 					       struct in6_addr *saddr,
 					       int onlink);
 extern int			ipv6_get_lladdr(struct net_device *dev, struct in6_addr *);
+extern int                      ipv6_generate_eui64(u8 *eui, struct net_device *dev);
 extern int			ipv6_rcv_saddr_equal(const struct sock *sk, 
 						      const struct sock *sk2);
 extern void			addrconf_join_solict(struct net_device *dev,
diff -urN linux-2.6/net/8021q/vlan.c linux-2.6-s390/net/8021q/vlan.c
--- linux-2.6/net/8021q/vlan.c	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/net/8021q/vlan.c	Thu May 13 21:01:09 2004
@@ -471,6 +471,10 @@
 	new_dev->flags = real_dev->flags;
 	new_dev->flags &= ~IFF_UP;
 
+	/* ipv6 shared card related stuff */
+	new_dev->dev_id = real_dev->dev_id;
+	new_dev->generate_eui64 = real_dev->generate_eui64;
+
 	/* need 4 bytes for extra VLAN header info,
 	 * hope the underlying device can handle it.
 	 */
diff -urN linux-2.6/net/ipv6/addrconf.c linux-2.6-s390/net/ipv6/addrconf.c
--- linux-2.6/net/ipv6/addrconf.c	Mon May 10 04:33:20 2004
+++ linux-2.6-s390/net/ipv6/addrconf.c	Thu May 13 21:01:09 2004
@@ -1057,7 +1057,7 @@
 }
 
 
-static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
+int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
 {
 	switch (dev->type) {
 	case ARPHRD_ETHER:
@@ -1115,7 +1115,7 @@
 
 	dev = idev->dev;
 
-	if (ipv6_generate_eui64(idev->work_eui64, dev)) {
+	if (dev->generate_eui64(idev->work_eui64, dev)) {
 		printk(KERN_INFO
 			"__ipv6_regen_rndid(idev=%p): cannot get EUI64 identifier; use random bytes.\n",
 			idev);
@@ -1379,7 +1379,7 @@
 
 		if (pinfo->prefix_len == 64) {
 			memcpy(&addr, &pinfo->prefix, 8);
-			if (ipv6_generate_eui64(addr.s6_addr + 8, dev) &&
+			if (dev->generate_eui64(addr.s6_addr + 8, dev) &&
 			    ipv6_inherit_eui64(addr.s6_addr + 8, in6_dev)) {
 				in6_dev_put(in6_dev);
 				return;
@@ -1783,14 +1783,16 @@
 		return;
 	}
 
+	if (!dev->generate_eui64)
+		dev->generate_eui64 = ipv6_generate_eui64;
+
 	idev = addrconf_add_dev(dev);
 	if (idev == NULL)
 		return;
 
 	memset(&addr, 0, sizeof(struct in6_addr));
 	addr.s6_addr32[0] = htonl(0xFE800000);
-
-	if (ipv6_generate_eui64(addr.s6_addr + 8, dev) == 0)
+	if (dev->generate_eui64(addr.s6_addr + 8, dev) == 0)
 		addrconf_add_linklocal(idev, &addr);
 }
 
diff -urN linux-2.6/net/ipv6/ndisc.c linux-2.6-s390/net/ipv6/ndisc.c
--- linux-2.6/net/ipv6/ndisc.c	Mon May 10 04:32:39 2004
+++ linux-2.6-s390/net/ipv6/ndisc.c	Thu May 13 21:01:09 2004
@@ -1411,6 +1411,9 @@
 		neigh_ifdown(&nd_tbl, dev);
 		fib6_run_gc(0);
 		break;
+	case NETDEV_UNREGISTER:
+		fib6_run_gc(0);
+		break;
 	default:
 		break;
 	}
