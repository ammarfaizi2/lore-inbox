Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSHANb6>; Thu, 1 Aug 2002 09:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSHANb6>; Thu, 1 Aug 2002 09:31:58 -0400
Received: from serwus.bnet.pl ([217.97.249.1]:65286 "EHLO serwus.bnet.pl")
	by vger.kernel.org with ESMTP id <S318747AbSHANb4>;
	Thu, 1 Aug 2002 09:31:56 -0400
Date: Thu, 1 Aug 2002 15:35:06 +0200
From: Jacek Konieczny <jajcus@pld.org.pl>
To: maxk@qualcomm.com, vtun@office.satix.net
Cc: netdev@oss.sgi.com, underley@underley.eu.org, linux-kernel@vger.kernel.org
Subject: "new style" netdevice allocation patch for TUN driver (2.4.18 kernel)
Message-ID: <20020801133506.GA22073@serwus.bnet.pl>
Reply-To: jajcus@bnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a lot of problem with tun devices created with both openvpn and
vtund. When I wanted to shut down my system when the devices were in
use (eg. TCP connection established on tun0 interface), even if the
tunneling daemon was killed, it stopped while trying to deconfigure
network. And "unregister_netdevice: waiting for tun0 to become free"
message was displayed again and again. I tried to resolve this problem
using Google, but I have only found out, that this is behaviour of 2.4
kernels, and that it is proper. After further investigation, in kernel
sources, I found out, that there are "old style" and "new style" network
devices, and that only the "old style" devices have this problem.
I had similar problem with VLAN devices some time ago, so I checked VLAN
driver sources too. As I suspected, it was "new style" device now.
The patch below is my try to make tun device "new style" too. It seems
to work for me, but I am not sure if it is 100% proper. This is patch
against 2.4.18 sources.

Sorry, for spamming all those addresses, but I am not sure which one is
correct. Driver on URL given in MAINTAINERS file seems to be a bit
outdated.

Greets,
	Jacek


--- linux/drivers/net/tun.c.orig	Sun Sep 30 21:26:07 2001
+++ linux/drivers/net/tun.c	Thu Aug  1 14:41:12 2002
@@ -20,6 +20,14 @@
  *    Modifications for 2.3.99-pre5 kernel.
  */
 
+/*
+ *  01.08.2002
+ *  Jacek Konieczny <jajcus@pld.org.pl>
+ *    Modifications for "new style" device allocation
+ *    (fixes "wating for tunX to become free" problem)
+ */
+
+
 #define TUN_VER "1.4"
 
 #include <linux/config.h>
@@ -159,6 +167,17 @@
 	return 0;
 }
 
+void tun_net_destruct(struct net_device *dev)
+{
+	if (dev) {
+		if (dev->priv) {
+			kfree(dev->priv);
+			dev->priv=NULL;
+			MOD_DEC_USE_COUNT;
+		}
+	}
+}
+
 /* Character device part */
 
 /* Poll */
@@ -204,14 +223,14 @@
 	skb_reserve(skb, 2);
 	copy_from_user(skb_put(skb, len), ptr, len); 
 
-	skb->dev = &tun->dev;
+	skb->dev = tun->dev;
 	switch (tun->flags & TUN_TYPE_MASK) {
 	case TUN_TUN_DEV:
 		skb->mac.raw = skb->data;
 		skb->protocol = pi.proto;
 		break;
 	case TUN_TAP_DEV:
-		skb->protocol = eth_type_trans(skb, &tun->dev);
+		skb->protocol = eth_type_trans(skb, tun->dev);
 		break;
 	};
 
@@ -310,7 +329,7 @@
 			schedule();
 			continue;
 		}
-		netif_start_queue(&tun->dev);
+		netif_start_queue(tun->dev);
 
 		if (!verify_area(VERIFY_WRITE, buf, count))
 			ret = tun_put_user(tun, skb, buf, count);
@@ -357,8 +376,6 @@
 		init_waitqueue_head(&tun->read_wait);
 
 		tun->owner = -1;
-		tun->dev.init = tun_net_init;
-		tun->dev.priv = tun;
 
 		err = -EINVAL;
 
@@ -377,17 +394,21 @@
 		if (*ifr->ifr_name)
 			name = ifr->ifr_name;
 
-		if ((err = dev_alloc_name(&tun->dev, name)) < 0)
-			goto failed;
-		if ((err = register_netdevice(&tun->dev)))
-			goto failed;
-	
-		MOD_INC_USE_COUNT;
+		dev = dev_alloc(name, &err);
+		if (!dev) goto failed;
+		
+		tun->dev=dev;
+		dev->init = tun_net_init;
+		dev->priv = tun;
+		dev->destructor = tun_net_destruct;
+		dev->features |= NETIF_F_DYNALLOC;
+		tun->name = dev->name;
 
-		tun->name = tun->dev.name;
-	}
+	        err=register_netdevice(dev);
+		if (err<0) goto failed;
 
-	DBG(KERN_INFO "%s: tun_set_iff\n", tun->name);
+		MOD_INC_USE_COUNT;
+	}
 
 	if (ifr->ifr_flags & IFF_NO_PI)
 		tun->flags |= TUN_NO_PI;
@@ -402,6 +423,7 @@
 	return 0;
 
 failed:
+	kfree(dev);
 	kfree(tun);
 	return err;
 }
@@ -532,10 +554,8 @@
 	skb_queue_purge(&tun->readq);
 
 	if (!(tun->flags & TUN_PERSIST)) {
-		dev_close(&tun->dev);
-		unregister_netdevice(&tun->dev);
-		kfree(tun);
-		MOD_DEC_USE_COUNT;
+		dev_close(tun->dev);
+		unregister_netdevice(tun->dev);
 	}
 
 	rtnl_unlock();
--- linux/include/linux/if_tun.h.orig	Tue Jun 12 04:15:27 2001
+++ linux/include/linux/if_tun.h	Thu Aug  1 14:33:40 2002
@@ -40,7 +40,7 @@
 	wait_queue_head_t	read_wait;
 	struct sk_buff_head	readq;
 
-	struct net_device	dev;
+	struct net_device	*dev;
 	struct net_device_stats	stats;
 
 	struct fasync_struct    *fasync;
