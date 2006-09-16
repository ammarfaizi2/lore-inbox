Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIPXDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIPXDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWIPXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:03:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:12238 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964830AbWIPXDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:03:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2/3] usbnet: add a mutex around phy register access
Date: Sun, 17 Sep 2006 01:03:06 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net,
       David Hollis <dhollis@davehollis.com>, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
References: <200609170055.34565.arnd@arndb.de>
In-Reply-To: <200609170055.34565.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609170103.07280.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Index: linux-cg/drivers/usb/net/asix.c
===================================================================
--- linux-cg.orig/drivers/usb/net/asix.c	2006-09-17 00:10:53.000000000 +0200
+++ linux-cg/drivers/usb/net/asix.c	2006-09-17 00:18:08.000000000 +0200
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
--- linux-cg.orig/drivers/usb/net/usbnet.c	2006-09-17 00:10:53.000000000 +0200
+++ linux-cg/drivers/usb/net/usbnet.c	2006-09-17 00:18:08.000000000 +0200
@@ -1112,6 +1112,7 @@
 	dev->delay.function = usbnet_bh;
 	dev->delay.data = (unsigned long) dev;
 	init_timer (&dev->delay);
+	mutex_init (&dev->phy_mutex);
 
 	SET_MODULE_OWNER (net);
 	dev->net = net;
Index: linux-cg/drivers/usb/net/usbnet.h
===================================================================
--- linux-cg.orig/drivers/usb/net/usbnet.h	2006-09-17 00:10:53.000000000 +0200
+++ linux-cg/drivers/usb/net/usbnet.h	2006-09-17 00:18:08.000000000 +0200
@@ -30,6 +30,7 @@
 	struct usb_device	*udev;
 	struct driver_info	*driver_info;
 	wait_queue_head_t	*wait;
+	struct mutex		phy_mutex;
 
 	/* i/o info: pipes etc */
 	unsigned		in, out;
Index: linux-cg/drivers/usb/net/mcs7830.c
===================================================================
--- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-09-17 00:10:53.000000000 +0200
+++ linux-cg/drivers/usb/net/mcs7830.c	2006-09-17 00:18:08.000000000 +0200
@@ -184,6 +184,7 @@
 		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | index,
 	};
 
+	mutex_lock(&dev->phy_mutex);
 	/* write the MII command */
 	ret = mcs7830_set_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
 	if (ret < 0)
@@ -208,6 +209,7 @@
 	dev_dbg(&dev->udev->dev, "read PHY reg %02x: %04x (%d tries)\n",
 		index, val, i);
 out:
+	mutex_unlock(&dev->phy_mutex);
 	return ret;
 }
 
@@ -222,6 +224,8 @@
 		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | (index & 0x1F),
 	};
 
+	mutex_lock(&dev->phy_mutex);
+
 	/* write the new register contents */
 	le_val = cpu_to_le16(val);
 	ret = mcs7830_set_reg(dev, HIF_REG_PHY_DATA, 2, &le_val);
@@ -248,6 +252,7 @@
 	dev_dbg(&dev->udev->dev, "write PHY reg %02x: %04x (%d tries)\n",
 		index, val, i);
 out:
+	mutex_unlock(&dev->phy_mutex);
 	return ret;
 }
 

