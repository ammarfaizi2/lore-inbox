Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTAOGw2>; Wed, 15 Jan 2003 01:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAOGw1>; Wed, 15 Jan 2003 01:52:27 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:36091 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S265725AbTAOGwJ>; Wed, 15 Jan 2003 01:52:09 -0500
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix up RTM_SETLINK handling
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 14 Jan 2003 23:01:00 -0800
Message-ID: <52smvukic3.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Jan 2003 07:00:42.0390 (UTC) FILETIME=[D196CB60:01C2BC63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes up some oversights I noticed with my code for
handling RTM_SETLINK messages and brings do_setlink() more in line
with SIOCSIFHWADDR handling in net/core/dev.c.  In particular, the
patch adds some checks that were missing, uses the set_mac_address
method rather than memcpy() directly into dev->dev_addr, and calls the
netdev notifier chain.

To call the netdev notifier chain I had to make netdev_chain not be
static.  I added the declaration to <linux/netdevice.h> but I am open
to other ways to give rtnetlink.c access to netdev_chain.

Best,
  Roland


 include/linux/netdevice.h |    1 +
 net/core/dev.c            |    2 +-
 net/core/rtnetlink.c      |   18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)


===== include/linux/netdevice.h 1.27 vs edited =====
--- 1.27/include/linux/netdevice.h	Tue Jan  7 14:33:37 2003
+++ edited/include/linux/netdevice.h	Tue Jan 14 19:19:59 2003
@@ -462,6 +462,7 @@
 extern struct net_device		loopback_dev;		/* The loopback */
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */
+extern struct notifier_block		*netdev_chain;
 
 extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
 extern int 			netdev_boot_setup_check(struct net_device *dev);
===== net/core/dev.c 1.52 vs edited =====
--- 1.52/net/core/dev.c	Tue Jan  7 14:33:37 2003
+++ edited/net/core/dev.c	Tue Jan 14 19:07:44 2003
@@ -188,7 +188,7 @@
  *	Our notifier list
  */
 
-static struct notifier_block *netdev_chain;
+struct notifier_block *netdev_chain;
 
 /*
  *	Device drivers call our routines to queue packets here. We empty the
===== net/core/rtnetlink.c 1.6 vs edited =====
--- 1.6/net/core/rtnetlink.c	Tue Jan  7 01:05:42 2003
+++ edited/net/core/rtnetlink.c	Tue Jan 14 19:36:43 2003
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
@@ -250,6 +260,10 @@
 	err = 0;
 
 out:
+	if (!err)
+		notifier_call_chain(&netdev_chain,
+				    NETDEV_CHANGEADDR, dev);
+
 	dev_put(dev);
 	return err;
 }
