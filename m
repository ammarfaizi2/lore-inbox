Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTAPBau>; Wed, 15 Jan 2003 20:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTAPBau>; Wed, 15 Jan 2003 20:30:50 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:47402 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S266958AbTAPBas>; Wed, 15 Jan 2003 20:30:48 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
References: <52of6ihrk1.fsf@topspin.com>
	<20030115.161337.14085475.davem@redhat.com>
	<52adi1999k.fsf@topspin.com>
	<20030115.172358.66314347.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 15 Jan 2003 17:39:40 -0800
In-Reply-To: <20030115.172358.66314347.davem@redhat.com>
Message-ID: <5265sp98kj.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jan 2003 01:39:22.0406 (UTC) FILETIME=[183C7460:01C2BD00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added EXPORT_SYMBOL for call_netdevice_notifiers().

Thanks,
  Roland


 include/linux/netdevice.h |    1 +
 net/core/dev.c            |   12 ++++++++++++
 net/core/rtnetlink.c      |   17 +++++++++++++++--
 net/netsyms.c             |    1 +
 4 files changed, 29 insertions(+), 2 deletions(-)


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
===== net/netsyms.c 1.40 vs edited =====
--- 1.40/net/netsyms.c	Wed Dec  4 11:42:20 2002
+++ edited/net/netsyms.c	Wed Jan 15 17:35:56 2003
@@ -500,6 +500,7 @@
 /* Device callback registration */
 EXPORT_SYMBOL(register_netdevice_notifier);
 EXPORT_SYMBOL(unregister_netdevice_notifier);
+EXPORT_SYMBOL(call_netdevice_notifiers);
 
 /* support for loadable net drivers */
 #ifdef CONFIG_NET
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
