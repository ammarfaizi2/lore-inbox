Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWBUXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWBUXsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWBUXsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:48:11 -0500
Received: from fnord.at ([217.160.110.113]:4105 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S1030178AbWBUXsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:48:09 -0500
Date: Wed, 22 Feb 2006 00:48:07 +0100
From: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] netdev/uevent
Message-ID: <20060221234807.GA27776@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds userspace notification for register/unregister and
plug/unplug events for netdevices. It calls kobject_uevent to let
userspace applications (via netlink-interface) know that e.g. the
ethernet-cable was plugged in (or plugged out) and thus the ethernet
device may have to be reconfigured.

Common scenario:
A userspace application is notified that the ethernet cable was plugged
out and later plugged in. It now checks whether the ethernet card is now
connected to an other network and reassigns it's IP-Address via DHCP.

BTW: Of course I know that the constant KOBJ_ONLINE actually has an other
meaning than what I used it for. I just didn't want to introduce a new
constant and it just seems perfect for my purpose.

Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="netdev_uevent.diff"

diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/net/core/dev.c linux-2.6.15.4/net/core/dev.c
--- linux-2.6.15/net/core/dev.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/net/core/dev.c	2006-02-21 20:14:27.000000000 +0100
@@ -104,6 +104,7 @@
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
+#include <linux/kobject_uevent.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/netpoll.h>
@@ -742,6 +743,34 @@
 }
 
 /**
+ *	netdev_uevent - notify userspace of netdev events
+ *	@dev: device
+ *	@event: event for device
+ *
+ *	Called to notify userspace of (de-)registering and status events
+ *	of netdevices
+ */
+static inline void
+netdev_uevent(struct net_device *dev, int event)
+{
+	kobject_action_t action = 0;
+
+	switch (event) {
+	case NETDEV_CHANGE:
+		action = netif_carrier_ok (dev) ? KOBJ_ONLINE : KOBJ_OFFLINE;
+		break;
+	case NETDEV_REGISTER:
+		action = KOBJ_ADD;
+		break;
+	case NETDEV_UNREGISTER:
+		action = KOBJ_REMOVE;
+		break;
+	}
+	if (action)
+		kobject_uevent (&dev->class_dev.kobj, action, NULL);
+}
+
+/**
  *	netdev_features_change - device changes fatures
  *	@dev: device to cause notification
  *
@@ -765,6 +794,7 @@
 {
 	if (dev->flags & IFF_UP) {
 		notifier_call_chain(&netdev_chain, NETDEV_CHANGE, dev);
+		netdev_uevent(dev, NETDEV_CHANGE);
 		rtmsg_ifinfo(RTM_NEWLINK, dev, 0);
 	}
 }
@@ -2937,6 +2967,7 @@
 			if (err)
 				printk(KERN_ERR "%s: failed sysfs registration (%d)\n",
 				       dev->name, err);
+			netdev_uevent (dev, NETDEV_REGISTER);
 			dev->reg_state = NETREG_REGISTERED;
 			break;
 
@@ -3108,6 +3139,7 @@
 	   this device. They should clean all the things.
 	*/
 	notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
+	netdev_uevent (dev, NETDEV_UNREGISTER);
 	
 	/*
 	 *	Flush the multicast chain

--Nq2Wo0NMKNjxTN9z--
