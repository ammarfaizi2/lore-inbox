Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWHTUNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWHTUNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHTUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:13:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:32455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751126AbWHTUNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:13:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Hollis <dhollis@davehollis.com>
Subject: [PATCH] usbnet: add a mutex around phy register access
Date: Sun, 20 Aug 2006 22:13:14 +0200
User-Agent: KMail/1.9.1
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608071811.09978.arnd.bergmann@de.ibm.com> <200608202207.39709.arnd@arndb.de>
In-Reply-To: <200608202207.39709.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608202213.15568.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When working on the mcs7830, I noticed the need for a mutex in its
mdio_read/mdio_write functions. A related problem seems to be present
in the asix driver in the respective functions.

This introduces a mutex in the common usbnet driver and uses it
from the two hardware specific drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

 drivers/usb/net/asix.c    |    4 ++++
 drivers/usb/net/mcs7830.c |    5 +++++
 drivers/usb/net/usbnet.c  |    1 +
 drivers/usb/net/usbnet.h  |    1 +
 4 files changed, 11 insertions(+)

Index: linux-cg/drivers/usb/net/asix.c
===================================================================
--- linux-cg.orig/drivers/usb/net/asix.c	2006-08-20 21:22:43.000000000 +0200
+++ linux-cg/drivers/usb/net/asix.c	2006-08-20 22:09:31.000000000 +0200
@@ -328,10 +328,12 @@
 	struct usbnet *dev = netdev_priv(netdev);
 	u16 res;
 
+	mutex_lock(&dev->phy_mutex);
 	asix_set_sw_mii(dev);
 	asix_read_cmd(dev, AX_CMD_READ_MII_REG, phy_id,
 				(__u16)loc, 2, (u16 *)&res);
 	asix_set_hw_mii(dev);
+	mutex_unlock(&dev->phy_mutex);
 
 	return res & 0xffff;
 }
@@ -348,10 +350,12 @@
 	struct usbnet *dev = netdev_priv(netdev);
 	u16 res = val;
 
+	mutex_lock(&dev->phy_mutex);
 	asix_set_sw_mii(dev);
 	asix_write_cmd(dev, AX_CMD_WRITE_MII_REG, phy_id,
 				(__u16)loc, 2, (u16 *)&res);
 	asix_set_hw_mii(dev);
+	mutex_unlock(&dev->phy_mutex);
 }
 
 /* same as above, but converts new value to le16 byte order before writing */
Index: linux-cg/drivers/usb/net/usbnet.c
===================================================================
--- linux-cg.orig/drivers/usb/net/usbnet.c	2006-08-20 21:22:43.000000000 +0200
+++ linux-cg/drivers/usb/net/usbnet.c	2006-08-20 22:09:31.000000000 +0200
@@ -1070,6 +1070,7 @@
 	dev->delay.function = usbnet_bh;
 	dev->delay.data = (unsigned long) dev;
 	init_timer (&dev->delay);
+	mutex_init (&dev->phy_mutex);
 
 	SET_MODULE_OWNER (net);
 	dev->net = net;
Index: linux-cg/drivers/usb/net/usbnet.h
===================================================================
--- linux-cg.orig/drivers/usb/net/usbnet.h	2006-08-20 21:22:43.000000000 +0200
+++ linux-cg/drivers/usb/net/usbnet.h	2006-08-20 22:09:31.000000000 +0200
@@ -30,6 +30,7 @@
 	struct usb_device	*udev;
 	struct driver_info	*driver_info;
 	wait_queue_head_t	*wait;
+	struct mutex		phy_mutex;
 
 	/* i/o info: pipes etc */
 	unsigned		in, out;
Index: linux-cg/drivers/usb/net/mcs7830.c
===================================================================
--- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-08-20 21:47:06.000000000 +0200
+++ linux-cg/drivers/usb/net/mcs7830.c	2006-08-20 22:09:31.000000000 +0200
@@ -178,6 +178,7 @@
 		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | index,
 	};
 
+	mutex_lock(&dev->phy_mutex);
 	/* write the MII command */
 	ret = mcs7830_set_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
 	if (ret < 0)
@@ -202,6 +203,7 @@
 	dev_dbg(&dev->udev->dev, "read PHY reg %02x: %04x (%d tries)\n",
 		index, val, i);
 out:
+	mutex_unlock(&dev->phy_mutex);
 	return ret;
 }
 
@@ -216,6 +218,8 @@
 		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | (index & 0x1F),
 	};
 
+	mutex_lock(&dev->phy_mutex);
+
 	/* write the new register contents */
 	le_val = cpu_to_le16(val);
 	ret = mcs7830_set_reg(dev, HIF_REG_PHY_DATA, 2, &le_val);
@@ -242,6 +246,7 @@
 	dev_dbg(&dev->udev->dev, "write PHY reg %02x: %04x (%d tries)\n",
 		index, val, i);
 out:
+	mutex_unlock(&dev->phy_mutex);
 	return ret;
 }
 
