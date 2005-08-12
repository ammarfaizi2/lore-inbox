Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVHLCTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVHLCTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVHLCTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:19:46 -0400
Received: from waste.org ([216.27.176.166]:61607 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964778AbVHLCTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:45 -0400
Date: Thu, 11 Aug 2005 21:19:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <7.502409567@selenic.com>
Message-Id: <8.502409567@selenic.com>
Subject: [PATCH 7/8] netpoll: fix initialization/NAPI race
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a race during initialization with the NAPI softirq
processing by using an RCU approach.

This race was discovered when refill_skbs() was added to
the setup code.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l/net/core/netpoll.c
===================================================================
--- l.orig/net/core/netpoll.c	2005-08-09 00:56:23.000000000 -0500
+++ l/net/core/netpoll.c	2005-08-11 01:50:24.000000000 -0500
@@ -731,6 +731,9 @@ int netpoll_setup(struct netpoll *np)
 	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
 
+	/* avoid racing with NAPI reading npinfo */
+	synchronize_rcu();
+
 	return 0;
 
  release:
Index: l/include/linux/netpoll.h
===================================================================
--- l.orig/include/linux/netpoll.h	2005-08-09 00:56:23.000000000 -0500
+++ l/include/linux/netpoll.h	2005-08-11 01:33:42.000000000 -0500
@@ -9,6 +9,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
+#include <linux/rcupdate.h>
 #include <linux/list.h>
 
 struct netpoll;
@@ -61,25 +62,31 @@ static inline int netpoll_rx(struct sk_b
 	return ret;
 }
 
-static inline void netpoll_poll_lock(struct net_device *dev)
+static inline void *netpoll_poll_lock(struct net_device *dev)
 {
+	rcu_read_lock(); /* deal with race on ->npinfo */
 	if (dev->npinfo) {
 		spin_lock(&dev->npinfo->poll_lock);
 		dev->npinfo->poll_owner = smp_processor_id();
+		return dev->npinfo;
 	}
+	return NULL;
 }
 
-static inline void netpoll_poll_unlock(struct net_device *dev)
+static inline void netpoll_poll_unlock(void *have)
 {
-	if (dev->npinfo) {
-		dev->npinfo->poll_owner = -1;
-		spin_unlock(&dev->npinfo->poll_lock);
+	struct netpoll_info *npi = have;
+
+	if (npi) {
+		npi->poll_owner = -1;
+		spin_unlock(&npi->poll_lock);
 	}
+	rcu_read_unlock();
 }
 
 #else
 #define netpoll_rx(a) 0
-#define netpoll_poll_lock(a)
+#define netpoll_poll_lock(a) 0
 #define netpoll_poll_unlock(a)
 #endif
 
Index: l/net/core/dev.c
===================================================================
--- l.orig/net/core/dev.c	2005-08-09 00:56:23.000000000 -0500
+++ l/net/core/dev.c	2005-08-11 01:34:08.000000000 -0500
@@ -1696,7 +1696,8 @@ static void net_rx_action(struct softirq
 	struct softnet_data *queue = &__get_cpu_var(softnet_data);
 	unsigned long start_time = jiffies;
 	int budget = netdev_budget;
-	
+	void *have;
+
 	local_irq_disable();
 
 	while (!list_empty(&queue->poll_list)) {
@@ -1709,10 +1710,10 @@ static void net_rx_action(struct softirq
 
 		dev = list_entry(queue->poll_list.next,
 				 struct net_device, poll_list);
-		netpoll_poll_lock(dev);
+		have = netpoll_poll_lock(dev);
 
 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
-			netpoll_poll_unlock(dev);
+			netpoll_poll_unlock(have);
 			local_irq_disable();
 			list_del(&dev->poll_list);
 			list_add_tail(&dev->poll_list, &queue->poll_list);
@@ -1721,7 +1722,7 @@ static void net_rx_action(struct softirq
 			else
 				dev->quota = dev->weight;
 		} else {
-			netpoll_poll_unlock(dev);
+			netpoll_poll_unlock(have);
 			dev_put(dev);
 			local_irq_disable();
 		}
