Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVIVHuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVIVHuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIVHuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:20659 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932184AbVIVHtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:49 -0400
Date: Thu, 22 Sep 2005 00:49:24 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       kevin@realmsys.com
Subject: [patch 14/18] USB: fix pegasus driver
Message-ID: <20050922074920.GO15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-pegasus-fix.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Vigor <kevin@realmsys.com>

Addresses some small bugs in the pegasus ethernet-over-USB driver. 
Specifically, malformed long packets from the adapter could cause a kernel
panic; the interrupt interval calculation was inappropriate for high-speed
devices; the return code from read_mii_word was tested incorrectly; and
failure to unlink outstanding URBs before freeing them could lead to kernel
panics when unloading the driver.

Signed-off-by: Kevin Vigor <kevin@realmsys.com>
Cc: Petko Manolov <petkan@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/net/pegasus.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--- scsi-2.6.orig/drivers/usb/net/pegasus.c	2005-09-20 06:00:04.000000000 -0700
+++ scsi-2.6/drivers/usb/net/pegasus.c	2005-09-21 17:29:48.000000000 -0700
@@ -648,6 +648,13 @@
 	}
 
 	/*
+	 * If the packet is unreasonably long, quietly drop it rather than
+	 * kernel panicing by calling skb_put.
+	 */
+	if (pkt_len > PEGASUS_MTU)
+		goto goon;
+
+	/*
 	 * at this point we are sure pegasus->rx_skb != NULL
 	 * so we go ahead and pass up the packet.
 	 */
@@ -886,15 +893,17 @@
 	__u8 data[2];
 
 	read_eprom_word(pegasus, 4, (__u16 *) data);
-	if (data[1] < 0x80) {
-		if (netif_msg_timer(pegasus))
-			dev_info(&pegasus->intf->dev,
-				"intr interval changed from %ums to %ums\n",
-				data[1], 0x80);
-		data[1] = 0x80;
-#ifdef	PEGASUS_WRITE_EEPROM
-		write_eprom_word(pegasus, 4, *(__u16 *) data);
+	if (pegasus->usb->speed != USB_SPEED_HIGH) {
+		if (data[1] < 0x80) {
+			if (netif_msg_timer(pegasus))
+				dev_info(&pegasus->intf->dev, "intr interval "
+					"changed from %ums to %ums\n",
+					data[1], 0x80);
+			data[1] = 0x80;
+#ifdef PEGASUS_WRITE_EEPROM
+			write_eprom_word(pegasus, 4, *(__u16 *) data);
 #endif
+		}
 	}
 	pegasus->intr_interval = data[1];
 }
@@ -904,8 +913,9 @@
 	pegasus_t *pegasus = netdev_priv(net);
 	u16 tmp;
 
-	if (read_mii_word(pegasus, pegasus->phy, MII_BMSR, &tmp))
+	if (!read_mii_word(pegasus, pegasus->phy, MII_BMSR, &tmp))
 		return;
+
 	if (tmp & BMSR_LSTATUS)
 		netif_carrier_on(net);
 	else
@@ -1355,6 +1365,7 @@
 	cancel_delayed_work(&pegasus->carrier_check);
 	unregister_netdev(pegasus->net);
 	usb_put_dev(interface_to_usbdev(intf));
+	unlink_all_urbs(pegasus);
 	free_all_urbs(pegasus);
 	free_skb_pool(pegasus);
 	if (pegasus->rx_skb)

--
