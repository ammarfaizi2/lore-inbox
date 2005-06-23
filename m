Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVFWBgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVFWBgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFWBfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:35:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261933AbVFWBav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:30:51 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17082.4295.439558.672081@segfault.boston.redhat.com>
Date: Wed, 22 Jun 2005 21:30:47 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [patch 3/3] netpoll: allow multiple netpoll_clients to register against one interface
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

This patch provides support for registering multiple netpoll clients to the
same network device.  Only one of these clients may register an rx_hook,
however.  In practice, this restriction has not been problematic.  It is
worth mentioning, though, that the current design can be easily extended to
allow for the registration of multiple rx_hooks.

The basic idea of the patch is that the rx_np pointer in the netpoll_info
structure points to the struct netpoll that has rx_hook filled in.  Aside
from this one case, there is no need for a pointer from the struct
net_device to an individual struct netpoll.

A lock is introduced to protect the setting and clearing of the np_rx
pointer.  The pointer will only be cleared upon netpoll client module
removal, and the lock should be uncontested.

-Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/net/core/netpoll.c.orig	2005-06-22 20:13:21.823259533 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-06-22 20:13:33.304353028 -0400
@@ -349,11 +349,15 @@ static void arp_reply(struct sk_buff *sk
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
+	unsigned long flags;
 	struct sk_buff *send_skb;
 	struct netpoll *np = NULL;
 
-	if (npinfo)
-		np = npinfo->np;
+	spin_lock_irqsave(&npinfo->rx_lock, flags);
+	if (npinfo->rx_np && npinfo->rx_np->dev == skb->dev)
+		np = npinfo->rx_np;
+	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+
 	if (!np)
 		return;
 
@@ -436,9 +440,9 @@ int __netpoll_rx(struct sk_buff *skb)
 	int proto, len, ulen;
 	struct iphdr *iph;
 	struct udphdr *uh;
-	struct netpoll *np = skb->dev->npinfo->np;
+	struct netpoll *np = skb->dev->npinfo->rx_np;
 
-	if (!np->rx_hook)
+	if (!np)
 		goto out;
 	if (skb->dev->type != ARPHRD_ETHER)
 		goto out;
@@ -619,6 +623,7 @@ int netpoll_setup(struct netpoll *np)
 	struct net_device *ndev = NULL;
 	struct in_device *in_dev;
 	struct netpoll_info *npinfo;
+	unsigned long flags;
 
 	if (np->dev_name)
 		ndev = dev_get_by_name(np->dev_name);
@@ -634,9 +639,10 @@ int netpoll_setup(struct netpoll *np)
 		if (!npinfo)
 			goto release;
 
-		npinfo->np = NULL;
+		npinfo->rx_np = NULL;
 		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
 		npinfo->poll_owner = -1;
+		npinfo->rx_lock = SPIN_LOCK_UNLOCKED;
 	} else
 		npinfo = ndev->npinfo;
 
@@ -706,9 +712,13 @@ int netpoll_setup(struct netpoll *np)
 		       np->name, HIPQUAD(np->local_ip));
 	}
 
-	if(np->rx_hook)
-		npinfo->rx_flags = NETPOLL_RX_ENABLED;
-	npinfo->np = np;
+	if (np->rx_hook) {
+		spin_lock_irqsave(&npinfo->rx_lock, flags);
+		npinfo->rx_flags |= NETPOLL_RX_ENABLED;
+		npinfo->rx_np = np;
+		spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+	}
+	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
 
 	return 0;
@@ -723,11 +733,20 @@ int netpoll_setup(struct netpoll *np)
 
 void netpoll_cleanup(struct netpoll *np)
 {
+	struct netpoll_info *npinfo;
+	unsigned long flags;
+
 	if (np->dev) {
-		if (np->dev->npinfo)
-			np->dev->npinfo->np = NULL;
+		npinfo = np->dev->npinfo;
+		if (npinfo && npinfo->rx_np == np) {
+			spin_lock_irqsave(&npinfo->rx_lock, flags);
+			npinfo->rx_np = NULL;
+			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
+			spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+		}
 		dev_put(np->dev);
 	}
+
 	np->dev = NULL;
 }
 
--- linux-2.6.12/include/linux/netpoll.h.orig	2005-06-22 20:11:59.119992646 -0400
+++ linux-2.6.12/include/linux/netpoll.h	2005-06-22 20:13:33.306352696 -0400
@@ -27,7 +27,8 @@ struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
 	int rx_flags;
-	struct netpoll *np;
+	spinlock_t rx_lock;
+	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
 };
 
 void netpoll_poll(struct netpoll *np);
@@ -44,11 +45,19 @@ void netpoll_queue(struct sk_buff *skb);
 static inline int netpoll_rx(struct sk_buff *skb)
 {
 	struct netpoll_info *npinfo = skb->dev->npinfo;
+	unsigned long flags;
+	int ret = 0;
 
-	if (!npinfo || !npinfo->rx_flags)
+	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
 		return 0;
 
-	return npinfo->np && __netpoll_rx(skb);
+	spin_lock_irqsave(&npinfo->rx_lock, flags);
+	/* check rx_flags again with the lock held */
+	if (npinfo->rx_flags && __netpoll_rx(skb))
+		ret = 1;
+	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+
+	return ret;
 }
 
 static inline void netpoll_poll_lock(struct net_device *dev)
