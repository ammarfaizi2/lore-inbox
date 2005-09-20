Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVITWXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVITWXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbVITWXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:23:09 -0400
Received: from 207.88.121.47.ptr.us.xo.net ([207.88.121.47]:6820 "EHLO
	ba.realmsys.com") by vger.kernel.org with ESMTP id S932441AbVITWXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:23:07 -0400
Date: Tue, 20 Sep 2005 16:27:52 -0600 (MDT)
From: Kevin Vigor <kevin@realmsys.com>
X-X-Sender: kvigor@mojo.inrealm.net
To: petkan@users.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pegasus ethernet over USB driver
Message-ID: <Pine.LNX.4.63.0509201626460.8737@mojo.inrealm.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.13.2 addresses some small bugs in the pegasus
ethernet-over-USB driver. Specifically, malformed long packets from the
adapter could cause a kernel panic; the interrupt interval calculation was
inappropriate for high-speed devices; the return code from read_mii_word was
tested incorrectly; and failure to unlink outstanding URBs before freeing
them could lead to kernel panics when unloading the driver.

Signed-off-by: Kevin Vigor <kevin@realmsys.com>


--- drivers/usb/net/pegasus.c-pristine	2005-07-27 14:48:54.000000000 -0600
+++ drivers/usb/net/pegasus.c	2005-09-20 15:45:42.000000000 -0600
@@ -648,6 +648,12 @@ static void read_bulk_callback(struct ur
  		pkt_len -= 8;
  	}

+    /* If packet is unreasonably long, quietly drop it
+     * rather than kernel panicing by calling skb_put.
+     */
+	if (pkt_len > PEGASUS_MTU)
+		goto goon; 
+
  	/*
  	 * at this point we are sure pegasus->rx_skb != NULL
  	 * so we go ahead and pass up the packet.
@@ -888,15 +894,17 @@ static inline void get_interrupt_interva
  	__u8 data[2];

  	read_eprom_word(pegasus, 4, (__u16 *) data);
-	if (data[1] < 0x80) {
-		if (netif_msg_timer(pegasus))
-			dev_info(&pegasus->intf->dev,
-				"intr interval changed from %ums to %ums\n",
-				data[1], 0x80);
-		data[1] = 0x80;
+    if (pegasus->usb->speed != USB_SPEED_HIGH) {
+		if (data[1] < 0x80) {
+			if (netif_msg_timer(pegasus))
+				dev_info(&pegasus->intf->dev,
+						"intr interval changed from %ums to %ums\n",
+						data[1], 0x80);
+			data[1] = 0x80;
  #ifdef	PEGASUS_WRITE_EEPROM
-		write_eprom_word(pegasus, 4, *(__u16 *) data);
+			write_eprom_word(pegasus, 4, *(__u16 *) data);
  #endif
+		}
  	}
  	pegasus->intr_interval = data[1];
  }
@@ -906,8 +914,9 @@ static void set_carrier(struct net_devic
  	pegasus_t *pegasus = netdev_priv(net);
  	u16 tmp;

-	if (read_mii_word(pegasus, pegasus->phy, MII_BMSR, &tmp))
+	if (!read_mii_word(pegasus, pegasus->phy, MII_BMSR, &tmp))
  		return;
+
  	if (tmp & BMSR_LSTATUS)
  		netif_carrier_on(net);
  	else
@@ -1357,6 +1366,7 @@ static void pegasus_disconnect(struct us
  	cancel_delayed_work(&pegasus->carrier_check);
  	unregister_netdev(pegasus->net);
  	usb_put_dev(interface_to_usbdev(intf));
+	unlink_all_urbs(pegasus);
  	free_all_urbs(pegasus);
  	free_skb_pool(pegasus);
  	if (pegasus->rx_skb)
