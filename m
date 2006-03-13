Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWCMSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWCMSIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWCMSHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:07:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932240AbWCMSHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:07:44 -0500
Date: Mon, 13 Mar 2006 10:00:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Greg Scott" <GregScott@InfraSupportEtc.com>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Subject: Re: Router stops routing after changing MAC Address
Message-ID: <20060313100041.212cee08@localhost.localdomain>
In-Reply-To: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
References: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There still is a bug in the 3c59x driver.  It doesn't include any code
to handle changing the mac address.  It will work if you take the device
down, change address, then bring it up. But you shouldn't have to do that.

Also, if the driver handles setting mac address, it could have prevented
you from using a multicast address.

Something like this is needed (untested, I don't have that hardware).


--- linux-2.6/drivers/net/3c59x.c.orig	2006-03-13 09:58:25.000000000 -0800
+++ linux-2.6/drivers/net/3c59x.c	2006-03-13 09:52:47.000000000 -0800
@@ -895,6 +895,7 @@ static void dump_tx_ring(struct net_devi
 static void update_stats(void __iomem *ioaddr, struct net_device *dev);
 static struct net_device_stats *vortex_get_stats(struct net_device *dev);
 static void set_rx_mode(struct net_device *dev);
+static int set_rx_address(struct net_device *dev, void *addr);
 #ifdef CONFIG_PCI
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 #endif
@@ -1563,6 +1564,7 @@ static int __devinit vortex_probe1(struc
 #endif
 	dev->ethtool_ops = &vortex_ethtool_ops;
 	dev->set_multicast_list = set_rx_mode;
+	dev->set_mac_address = set_rx_address;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -3150,6 +3152,27 @@ static void set_rx_mode(struct net_devic
 	iowrite16(new_mode, ioaddr + EL3_CMD);
 }
 
+
+static int set_rx_address(struct net_device *dev, void *p)
+{
+	struct vortex_private *vp = netdev_priv(dev);
+	void __iomem *ioaddr = vp->ioaddr;
+	const struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	spin_lock_bh(&vp->lock);
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+
+	EL3WINDOW(2);
+	for (i = 0; i < ETH_ALEN; i++)
+		iowrite8(dev->dev_addr[i], ioaddr + i);
+	spin_unlock_bh(&vp->lock);
+	
+	return 0;
+}
+
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 /* Setup the card so that it can receive frames with an 802.1q VLAN tag.
    Note that this must be done after each RxReset due to some backwards
