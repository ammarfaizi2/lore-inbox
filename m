Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbTCaXBq>; Mon, 31 Mar 2003 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCaXBq>; Mon, 31 Mar 2003 18:01:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261896AbTCaXBm>;
	Mon, 31 Mar 2003 18:01:42 -0500
Subject: [PATCH 2.5.66] sychronize_net patch (1/2)
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@redhat.com>
Cc: linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1049152378.2204.22.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 15:12:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several places are all doing the same thing to synchronize with network
receive BH.  This patch for 2.5.66 moves this into a new function
synchronize_net.

By putting it in one place, it gets the brlock semantics out of several
places. The motivation is that eventually on 2.5 based kernels the
function can call synchronize_kernel for RCU but leave the 2.4 code
alone. 

diff -urN -X dontdiff linux-2.4/include/linux/netdevice.h linux-2.4-netsync/include/linux/netdevice.h
--- linux-2.4/include/linux/netdevice.h	2003-03-31 11:09:07.000000000 -0800
+++ linux-2.4-netsync/include/linux/netdevice.h	2003-03-31 06:25:34.000000000 -0800
@@ -474,6 +474,7 @@
 extern int		dev_queue_xmit(struct sk_buff *skb);
 extern int		register_netdevice(struct net_device *dev);
 extern int		unregister_netdevice(struct net_device *dev);
+extern void		synchronize_net(void);
 extern int 		register_netdevice_notifier(struct notifier_block *nb);
 extern int		unregister_netdevice_notifier(struct notifier_block *nb);
 extern int		dev_new_index(void);
diff -urN -X dontdiff linux-2.4/net/core/dev.c linux-2.4-netsync/net/core/dev.c
--- linux-2.4/net/core/dev.c	2003-03-31 11:09:09.000000000 -0800
+++ linux-2.4-netsync/net/core/dev.c	2003-03-31 14:26:11.000000000 -0800
@@ -2508,6 +2508,12 @@
 	return 0;
 }
 
+/* Synchronize with packet receive processing. */
+void synchronize_net() {
+	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_unlock_bh(BR_NETPROTO_LOCK);
+}
+
 /**
  *	unregister_netdevice - remove device from the kernel
  *	@dev: device
@@ -2547,9 +2553,7 @@
 		return -ENODEV;
 	}
 
-	/* Synchronize to net_rx_action. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+ 	synchronize_net();
 
 	if (dev_boot_phase == 0) {
 #ifdef CONFIG_NET_FASTROUTE
diff -urN -X dontdiff linux-2.4/net/netsyms.c linux-2.4-netsync/net/netsyms.c
--- linux-2.4/net/netsyms.c	2003-03-31 11:09:08.000000000 -0800
+++ linux-2.4-netsync/net/netsyms.c	2003-03-31 06:25:34.000000000 -0800
@@ -478,6 +478,7 @@
 EXPORT_SYMBOL(loopback_dev);
 EXPORT_SYMBOL(register_netdevice);
 EXPORT_SYMBOL(unregister_netdevice);
+EXPORT_SYMBOL(synchronize_net);
 EXPORT_SYMBOL(netdev_state_change);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_index);



