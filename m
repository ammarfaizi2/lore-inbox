Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130059AbRBVW52>; Thu, 22 Feb 2001 17:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131220AbRBVW5S>; Thu, 22 Feb 2001 17:57:18 -0500
Received: from cs.columbia.edu ([128.59.16.20]:44420 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S130059AbRBVW5I>;
	Thu, 22 Feb 2001 17:57:08 -0500
Date: Thu, 22 Feb 2001 14:57:05 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire fix for 2.4.2ac
Message-ID: <Pine.LNX.4.30.0102221446480.9770-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch fixes a problem doing ifconfig up, down and then up again, and
getting ENODEV. That broke pump, among other things.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------------------
--- /mnt/3/linux-2.4-ac/drivers/net/starfire.c	Mon Feb 19 14:35:01 2001
+++ linux-2.4/drivers/net/starfire.c	Thu Feb 22 14:19:33 2001
@@ -52,6 +52,9 @@
 	LK1.2.5 (Ion Badulescu)
 	- Several fixes from Manfred Spraul
 
+	LK1.2.6 (Ion Badulescu)
+	- Fixed ifup/ifdown/ifup problem in 2.4.x
+
 TODO:
 	- implement tx_timeout() properly
 	- support ethtool
@@ -64,7 +67,7 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";
 
 static const char version3[] =
-" (unofficial 2.4.x kernel port, version 1.2.5, February 15, 2001)\n";
+" (unofficial 2.4.x kernel port, version 1.2.6, February 22, 2001)\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -486,6 +489,9 @@
 			func(dev); \
 	}
 
+#define netif_start_if(dev)	dev->start = 1
+#define netif_stop_if(dev)	dev->start = 0
+
 #else  /* LINUX_VERSION_CODE > 0x20300 */
 
 #define COMPAT_MOD_INC_USE_COUNT
@@ -496,6 +502,8 @@
 	dev->watchdog_timeo = timeout;
 #define kick_tx_timer(dev, func, timeout)
 
+#define netif_start_if(dev)
+#define netif_stop_if(dev)
 
 #endif /* LINUX_VERSION_CODE > 0x20300 */
 /* end of compatibility code */
@@ -1041,6 +1049,7 @@
 	if (dev->if_port == 0)
 		dev->if_port = np->default_port;
 
+	netif_start_if(dev);
 	netif_start_queue(dev);
 
 	if (debug > 1)
@@ -1712,7 +1721,8 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	netif_device_detach(dev);
+	netif_stop_queue(dev);
+	netif_start_if(dev);
 
 	del_timer_sync(&np->timer);
 

