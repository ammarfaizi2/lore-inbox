Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBHVET>; Thu, 8 Feb 2001 16:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbRBHVEK>; Thu, 8 Feb 2001 16:04:10 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:4879 "EHLO tepid.osl.fast.no")
	by vger.kernel.org with ESMTP id <S129664AbRBHVDy>;
	Thu, 8 Feb 2001 16:03:54 -0500
Date: Thu, 8 Feb 2001 21:20:13 GMT
Message-Id: <200102082120.VAA87946@tepid.osl.fast.no>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
From: Dag Brattli <dag@brattli.net>
Reply-To: dag@brattli.net
Subject: [patch] patch-2.4.1-irda2 (irlan)
X-Mailer: Pygmy (v0.4.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch that fixes the problem of attaching to IrLAN
devices in Linux-2.4.1. 

The problem was that the IrLAN driver forgot to memorize the
hardware address of the remote device and instead used the
broadcast address, which sometimes did work, but not always
(since doing so is actually a bug)

Have also added the dynalloc flag to irlan, since it does 
allocate it's network devices dynamically.

-- Dag

diff -urpN linux-2.4.1/net/irda/irlan/irlan_client.c linux/net/irda/irlan/irlan_client.c
--- linux-2.4.1/net/irda/irlan/irlan_client.c	Sun Nov 12 03:11:23 2000
+++ linux/net/irda/irlan/irlan_client.c	Thu Feb  8 09:08:41 2001
@@ -120,8 +120,9 @@ void irlan_client_wakeup(struct irlan_cb
 			return;
 	}
 
-	/* Address may have changed! */
+	/* Addresses may have changed! */
 	self->saddr = saddr;
+	self->daddr = daddr;
 
 	if (self->disconnect_reason == LM_USER_REQUEST) {
 			IRDA_DEBUG(0, __FUNCTION__ "(), still stopped by user\n");
diff -urpN linux-2.4.1/net/irda/irlan/irlan_eth.c linux/net/irda/irlan/irlan_eth.c
--- linux-2.4.1/net/irda/irlan/irlan_eth.c	Sun Nov 12 03:11:23 2000
+++ linux/net/irda/irlan/irlan_eth.c	Thu Feb  8 09:08:41 2001
@@ -61,6 +61,7 @@ int irlan_eth_init(struct net_device *de
 	dev->hard_start_xmit    = irlan_eth_xmit; 
 	dev->get_stats	        = irlan_eth_get_stats;
 	dev->set_multicast_list = irlan_eth_set_multicast_list;
+	dev->features          |= NETIF_F_DYNALLOC;
 
 	ether_setup(dev);
 	

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
