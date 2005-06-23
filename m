Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVFWBdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVFWBdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVFWBdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:33:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51099 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261962AbVFWBaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:30:13 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17082.4256.681873.542300@segfault.boston.redhat.com>
Date: Wed, 22 Jun 2005 21:30:08 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [patch 2/3] netpoll: Introduce a netpoll_info struct
In-Reply-To: <17082.4037.875432.648439@segfault.boston.redhat.com>
References: <17082.4037.875432.648439@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces a netpoll_info structure, which the struct net_device
will now point to instead of pointing to a struct netpoll.  The reason for
this is two-fold: 1) fields such as the rx_flags, poll_owner, and poll_lock
should be maintained per net_device, not per netpoll;  and 2) this is a first
step in providing support for multiple netpoll clients to register against the
same net_device.

The struct netpoll is now pointed to by the netpoll_info structure.  As
such, the previous behaviour of the code is preserved.

-Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/net/core/netpoll.c.orig	2005-06-22 20:11:06.673701253 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-06-22 20:11:45.323283581 -0400
@@ -130,19 +130,20 @@ static int checksum_udp(struct sk_buff *
  */
 static void poll_napi(struct netpoll *np)
 {
+	struct netpoll_info *npinfo = np->dev->npinfo;
 	int budget = 16;
 
 	if (test_bit(__LINK_STATE_RX_SCHED, &np->dev->state) &&
-	    np->poll_owner != smp_processor_id() &&
-	    spin_trylock(&np->poll_lock)) {
-		np->rx_flags |= NETPOLL_RX_DROP;
+	    npinfo->poll_owner != smp_processor_id() &&
+	    spin_trylock(&npinfo->poll_lock)) {
+		npinfo->rx_flags |= NETPOLL_RX_DROP;
 		atomic_inc(&trapped);
 
 		np->dev->poll(np->dev, &budget);
 
 		atomic_dec(&trapped);
-		np->rx_flags &= ~NETPOLL_RX_DROP;
-		spin_unlock(&np->poll_lock);
+		npinfo->rx_flags &= ~NETPOLL_RX_DROP;
+		spin_unlock(&npinfo->poll_lock);
 	}
 }
 
@@ -245,6 +246,7 @@ repeat:
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status;
+	struct netpoll_info *npinfo;
 
 repeat:
 	if(!np || !np->dev || !netif_running(np->dev)) {
@@ -253,8 +255,9 @@ repeat:
 	}
 
 	/* avoid recursion */
-	if(np->poll_owner == smp_processor_id() ||
-	   np->dev->xmit_lock_owner == smp_processor_id()) {
+	npinfo = np->dev->npinfo;
+	if (npinfo->poll_owner == smp_processor_id() ||
+	    np->dev->xmit_lock_owner == smp_processor_id()) {
 		if (np->drop)
 			np->drop(skb);
 		else
@@ -341,14 +344,18 @@ void netpoll_send_udp(struct netpoll *np
 
 static void arp_reply(struct sk_buff *skb)
 {
+	struct netpoll_info *npinfo = skb->dev->npinfo;
 	struct arphdr *arp;
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
 	struct sk_buff *send_skb;
-	struct netpoll *np = skb->dev->np;
+	struct netpoll *np = NULL;
 
-	if (!np) return;
+	if (npinfo)
+		np = npinfo->np;
+	if (!np)
+		return;
 
 	/* No arp on this interface */
 	if (skb->dev->flags & IFF_NOARP)
@@ -429,7 +436,7 @@ int __netpoll_rx(struct sk_buff *skb)
 	int proto, len, ulen;
 	struct iphdr *iph;
 	struct udphdr *uh;
-	struct netpoll *np = skb->dev->np;
+	struct netpoll *np = skb->dev->npinfo->np;
 
 	if (!np->rx_hook)
 		goto out;
@@ -611,9 +618,7 @@ int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
 	struct in_device *in_dev;
-
-	np->poll_lock = SPIN_LOCK_UNLOCKED;
-	np->poll_owner = -1;
+	struct netpoll_info *npinfo;
 
 	if (np->dev_name)
 		ndev = dev_get_by_name(np->dev_name);
@@ -624,7 +629,16 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	np->dev = ndev;
-	ndev->np = np;
+	if (!ndev->npinfo) {
+		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
+		if (!npinfo)
+			goto release;
+
+		npinfo->np = NULL;
+		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
+		npinfo->poll_owner = -1;
+	} else
+		npinfo = ndev->npinfo;
 
 	if (!ndev->poll_controller) {
 		printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
@@ -693,12 +707,15 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	if(np->rx_hook)
-		np->rx_flags = NETPOLL_RX_ENABLED;
+		npinfo->rx_flags = NETPOLL_RX_ENABLED;
+	npinfo->np = np;
+	ndev->npinfo = npinfo;
 
 	return 0;
 
  release:
-	ndev->np = NULL;
+	if (!ndev->npinfo)
+		kfree(npinfo);
 	np->dev = NULL;
 	dev_put(ndev);
 	return -1;
@@ -706,9 +723,11 @@ int netpoll_setup(struct netpoll *np)
 
 void netpoll_cleanup(struct netpoll *np)
 {
-	if (np->dev)
-		np->dev->np = NULL;
-	dev_put(np->dev);
+	if (np->dev) {
+		if (np->dev->npinfo)
+			np->dev->npinfo->np = NULL;
+		dev_put(np->dev);
+	}
 	np->dev = NULL;
 }
 
--- linux-2.6.12/include/linux/netpoll.h.orig	2005-06-22 20:11:15.326264524 -0400
+++ linux-2.6.12/include/linux/netpoll.h	2005-06-22 20:11:59.119992646 -0400
@@ -16,14 +16,18 @@ struct netpoll;
 struct netpoll {
 	struct net_device *dev;
 	char dev_name[16], *name;
-	int rx_flags;
 	void (*rx_hook)(struct netpoll *, int, char *, int);
 	void (*drop)(struct sk_buff *skb);
 	u32 local_ip, remote_ip;
 	u16 local_port, remote_port;
 	unsigned char local_mac[6], remote_mac[6];
+};
+
+struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
+	int rx_flags;
+	struct netpoll *np;
 };
 
 void netpoll_poll(struct netpoll *np);
@@ -39,22 +43,27 @@ void netpoll_queue(struct sk_buff *skb);
 #ifdef CONFIG_NETPOLL
 static inline int netpoll_rx(struct sk_buff *skb)
 {
-	return skb->dev->np && skb->dev->np->rx_flags && __netpoll_rx(skb);
+	struct netpoll_info *npinfo = skb->dev->npinfo;
+
+	if (!npinfo || !npinfo->rx_flags)
+		return 0;
+
+	return npinfo->np && __netpoll_rx(skb);
 }
 
 static inline void netpoll_poll_lock(struct net_device *dev)
 {
-	if (dev->np) {
-		spin_lock(&dev->np->poll_lock);
-		dev->np->poll_owner = smp_processor_id();
+	if (dev->npinfo) {
+		spin_lock(&dev->npinfo->poll_lock);
+		dev->npinfo->poll_owner = smp_processor_id();
 	}
 }
 
 static inline void netpoll_poll_unlock(struct net_device *dev)
 {
-	if (dev->np) {
-		dev->np->poll_owner = -1;
-		spin_unlock(&dev->np->poll_lock);
+	if (dev->npinfo) {
+		dev->npinfo->poll_owner = -1;
+		spin_unlock(&dev->npinfo->poll_lock);
 	}
 }
 
--- linux-2.6.12/include/linux/netdevice.h.orig	2005-06-22 20:11:24.277778150 -0400
+++ linux-2.6.12/include/linux/netdevice.h	2005-06-22 20:11:45.325283249 -0400
@@ -41,7 +41,7 @@
 struct divert_blk;
 struct vlan_group;
 struct ethtool_ops;
-struct netpoll;
+struct netpoll_info;
 					/* source back-compat hooks */
 #define SET_ETHTOOL_OPS(netdev,ops) \
 	( (netdev)->ethtool_ops = (ops) )
@@ -468,7 +468,7 @@ struct net_device
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 #ifdef CONFIG_NETPOLL
-	struct netpoll		*np;
+	struct netpoll_info	*npinfo;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void                    (*poll_controller)(struct net_device *dev);
