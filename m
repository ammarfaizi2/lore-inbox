Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUIZWoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUIZWoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUIZWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:44:23 -0400
Received: from mail.dif.dk ([193.138.115.101]:35490 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264665AbUIZWoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:44:10 -0400
Date: Mon, 27 Sep 2004 00:51:09 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: [PATCH] add sysfs attribute 'carrier' for net devices
Message-ID: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch that adds a new sysfs attribute for net devices. The new 
attribute 'carrier' exposes the result of netif_carrier_ok() so that when 
a network device has carrier the attribute value is 1 and when there is no 
carrier the attribute value is 0.
Very rellevant attribute for network devices in my oppinion, and sysfs is 
the logical place for it.

I've tested this only on my own machine, but I get the expected results:

With network cable plugged into eth0 : 

juhl@dragon:~$ cat /sys/class/net/eth0/carrier
1
juhl@dragon:~$

With network cable unplugged : 

juhl@dragon:~$ cat /sys/class/net/eth0/carrier
0
juhl@dragon:~$

Please review and consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.9-rc2-bk5-orig/net/core/net-sysfs.c linux-2.6.9-rc2-bk5/net/core/net-sysfs.c
--- linux-2.6.9-rc2-bk5-orig/net/core/net-sysfs.c	2004-09-14 23:19:53.000000000 +0200
+++ linux-2.6.9-rc2-bk5/net/core/net-sysfs.c	2004-09-27 00:24:01.000000000 +0200
@@ -126,8 +126,21 @@
 	return -EINVAL;
 }
 
+static ssize_t show_carrier(struct class_device *dev, char *buf)
+{
+	struct net_device *net = to_net_dev(dev);
+	if (netif_running(net)) {
+		if (netif_carrier_ok(net))
+			return snprintf(buf, 3, "%d\n", 1);
+		else
+			return snprintf(buf, 3, "%d\n", 0);
+	}
+	return -EINVAL;
+}
+
 static CLASS_DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
 static CLASS_DEVICE_ATTR(broadcast, S_IRUGO, show_broadcast, NULL);
+static CLASS_DEVICE_ATTR(carrier, S_IRUGO, show_carrier, NULL);
 
 /* read-write attributes */
 NETDEVICE_SHOW(mtu, fmt_dec);
@@ -186,6 +199,7 @@
 	&class_device_attr_type,
 	&class_device_attr_address,
 	&class_device_attr_broadcast,
+	&class_device_attr_carrier,
 	NULL
 };
 

