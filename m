Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTAPBPt>; Wed, 15 Jan 2003 20:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTAPBPt>; Wed, 15 Jan 2003 20:15:49 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:60457 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S266948AbTAPBPs>; Wed, 15 Jan 2003 20:15:48 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
References: <52smvukic3.fsf@topspin.com>
	<20030115.160716.23576593.davem@redhat.com>
	<52of6ihrk1.fsf@topspin.com>
	<20030115.161337.14085475.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 15 Jan 2003 17:24:39 -0800
In-Reply-To: <20030115.161337.14085475.davem@redhat.com>
Message-ID: <52adi1999k.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jan 2003 01:24:22.0062 (UTC) FILETIME=[FF96DCE0:01C2BCFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's a new version of my RTM_SETLINK fixups.  I added a function
call_netdevice_notifiers() instead of making netdev_chain not static.

Thanks,
  Roland


 include/linux/netdevice.h |    1 +
 net/core/dev.c            |   12 ++++++++++++
 net/core/rtnetlink.c      |   17 +++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)


===== include/linux/netdevice.h 1.27 vs edited =====
--- 1.27/include/linux/netdevice.h	Tue Jan  7 14:33:37 2003
+++ edited/include/linux/netdevice.h	Wed Jan 15 17:07:08 2003
@@ -480,6 +480,7 @@
 extern int		unregister_netdevice(struct net_device *dev);
 extern int 		register_netdevice_notifier(struct notifier_block *nb);
 extern int		unregister_netdevice_notifier(struct notifier_block *nb);
+extern int		call_netdevice_notifiers(unsigned long val, void *v);
 extern int		dev_new_index(void);
 extern struct net_device	*dev_get_by_index(int ifindex);
 extern struct net_device	*__dev_get_by_index(int ifindex);
===== net/core/dev.c 1.52 vs edited =====
--- 1.52/net/core/dev.c	Tue Jan  7 14:33:37 2003
+++ edited/net/core/dev.c	Wed Jan 15 17:19:13 2003
@@ -877,6 +877,18 @@
 	return notifier_chain_unregister(&netdev_chain, nb);
 }
 
+/**
+ *	call_netdevice_notifiers - call all network notifier blocks
+ *
+ *	Call all network notifier blocks.  Parameters and return value
+ *	are as for notifier_call_chain().
+ */
+
+int call_netdevice_notifiers(unsigned long val, void *v)
+{
+	return notifier_call_chain(&netdev_chain, val, v);
+}
+
 /*
  *	Support routine. Sends outgoing frames to any network
  *	taps currently in use.
===== net/core/rtnetlink.c 1.6 vs edited =====
--- 1.6/net/core/rtnetlink.c	Tue Jan  7 01:05:42 2003
+++ edited/net/core/rtnetlink.c	Wed Jan 15 17:10:37 2003
@@ -234,10 +234,20 @@
 	err = -EINVAL;
 
 	if (ida[IFLA_ADDRESS - 1]) {
+		if (!dev->set_mac_address) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		if (!netif_device_present(dev)) {
+			err = -ENODEV;
+			goto out;
+		}
 		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
 			goto out;
-		memcpy(dev->dev_addr, RTA_DATA(ida[IFLA_ADDRESS - 1]),
-		       dev->addr_len);
+
+		err = dev->set_mac_address(dev, RTA_DATA(ida[IFLA_ADDRESS - 1]));
+		if (err)
+			goto out;
 	}
 
 	if (ida[IFLA_BROADCAST - 1]) {
@@ -250,6 +260,9 @@
 	err = 0;
 
 out:
+	if (!err)
+		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
+
 	dev_put(dev);
 	return err;
 }
