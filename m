Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVGAXOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVGAXOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVGAXN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:13:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261640AbVGAXJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:09:49 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52534.420781.92366@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:09:42 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc | patch 5/6] netpoll: modify bonding driver to support netpoll
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement netpoll hooks in the bonding driver.  We register the following
netpoll specific routines:

bond_netpoll_setup
  This routine associates the struct netpoll_info of the master device with
  each of the slave devices.

bond_xmit_netpoll
  This routine sets bonding->netpoll to the struct netpoll provided by
  netpoll_send_skb.  This pointer is then passed along to netpoll_send_skb
  in bond_dev_queue_xmit, when we are ready to send the skb out over the
  real network device.

bond_poll_controller
  This routine calls netpoll_poll_dev for each of the slaves in the bond.

When a new slave is added to the bond, if it does not support netpoll, then
netpoll is disabled for the bond.  When a slave is released, that slave's
npinfo pointer is cleared.

I have tested this code extensively, and it works well in my environment.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/drivers/net/bonding/bond_main.c.orig	2005-06-29 14:28:08.000000000 -0400
+++ linux-2.6.12/drivers/net/bonding/bond_main.c	2005-06-30 19:33:50.641009622 -0400
@@ -821,8 +821,12 @@ int bond_dev_queue_xmit(struct bonding *
 	}
 
 	skb->priority = 1;
-	dev_queue_xmit(skb);
-
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	if (bond->netpoll)
+		netpoll_send_skb(bond->netpoll, skb);
+	else
+#endif
+		dev_queue_xmit(skb);
 	return 0;
 }
 
@@ -1567,6 +1571,45 @@ static void bond_detach_slave(struct bon
 	bond->slave_cnt--;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static int slaves_support_netpoll(struct net_device *bond_dev)
+{
+	struct bonding *bond = bond_dev->priv;
+	struct slave *slave;
+	int i;
+
+	bond_for_each_slave(bond, slave, i) {
+		if (!slave->dev->poll_controller)
+			return 0;
+	}
+
+	return 1;
+}
+
+static void bond_poll_controller(struct net_device *bond_dev)
+{
+	struct bonding *bond = bond_dev->priv;
+	struct slave *slave;
+	int i;
+
+	bond_for_each_slave(bond, slave, i) {
+		if (slave->dev->poll_controller)
+			netpoll_poll_dev(slave->dev);
+	}
+}
+
+static void bond_netpoll_setup(struct net_device *bond_dev,
+			       struct netpoll_info *npinfo)
+{
+	struct bonding *bond = bond_dev->priv;
+	struct slave *slave;
+	int i;
+
+	bond_for_each_slave(bond, slave, i)
+		slave->dev->npinfo = npinfo;
+}
+#endif
+
 /*---------------------------------- IOCTL ----------------------------------*/
 
 static int bond_sethwaddr(struct net_device *bond_dev, struct net_device *slave_dev)
@@ -1969,6 +2012,17 @@ static int bond_enslave(struct net_devic
 	       new_slave->state == BOND_STATE_ACTIVE ? "n active" : " backup",
 	       new_slave->link != BOND_LINK_DOWN ? "n up" : " down");
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	if (slaves_support_netpoll(bond_dev)) {
+		bond_dev->poll_controller = bond_poll_controller;
+		slave_dev->npinfo = bond_dev->npinfo;
+	} else if (bond_dev->poll_controller) {
+		bond_dev->poll_controller = NULL;
+		printk("New slave device %s does not support netpoll.\n",
+			slave_dev->name);
+		printk("netpoll disabled for %s.\n", bond_dev->name);
+	}
+#endif
 	/* enslave is successful */
 	return 0;
 
@@ -2173,6 +2227,9 @@ static int bond_release(struct net_devic
 		slave_dev->flags &= ~IFF_NOARP;
 	}
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	slave_dev->npinfo = NULL;
+#endif
 	kfree(slave);
 
 	return 0;  /* deletion OK */
@@ -4203,6 +4260,21 @@ out:
 	return 0;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+int bond_xmit_netpoll(struct netpoll *np, struct sk_buff *skb,
+		      struct net_device *bond_dev)
+{
+	struct bonding *bond = bond_dev->priv;
+	int ret;
+
+	bond->netpoll = np;
+	ret = bond_dev->hard_start_xmit(skb, bond_dev);
+	bond->netpoll = NULL;
+
+	return ret;
+}
+#endif
+
 /*------------------------- Device initialization ---------------------------*/
 
 /*
@@ -4277,6 +4349,10 @@ static int __init bond_init(struct net_d
 
 	bond_dev->destructor = free_netdev;
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	bond_dev->netpoll_setup = bond_netpoll_setup;
+	bond_dev->netpoll_start_xmit = bond_xmit_netpoll;
+#endif
 	/* Initialize the device options */
 	bond_dev->tx_queue_len = 0;
 	bond_dev->flags |= IFF_MASTER|IFF_MULTICAST;
--- linux-2.6.12/drivers/net/bonding/bonding.h.orig	2005-06-29 14:29:40.000000000 -0400
+++ linux-2.6.12/drivers/net/bonding/bonding.h	2005-06-30 19:02:54.000000000 -0400
@@ -33,6 +33,7 @@
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
 #include <linux/if_bonding.h>
+#include <linux/netpoll.h>
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
@@ -203,6 +204,9 @@ struct bonding {
 	struct   bond_params params;
 	struct   list_head vlan_list;
 	struct   vlan_group *vlgrp;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	struct   netpoll *netpoll;
+#endif
 };
 
 /**
