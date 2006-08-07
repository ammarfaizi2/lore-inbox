Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWHGNBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWHGNBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWHGNBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:01:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57780 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750943AbWHGNBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:01:01 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: dbrownell@users.sourceforge.net
Subject: [PATCH] please review mcs7830 (DeLOCK USB etherner) driver
Date: Mon, 7 Aug 2006 15:00:55 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       support@moschip.com, Michael Helmling <supermihi@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071500.55903.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been unfortunate to stumble over the MosChip 7830 USB2 10/100
Ethernet adapter. There was a driver for it provided on the manufacturer's
web site, but since I intend need to use the device in the future, I
decided to clean that driver up and get it into shape for inclusion.

The code below should fix the style issues that the original had, but
still has the same bug that it creates a storm of error interrupts
and transfers less than 10kb/s of data on average. I hope to
be able to fix that soon.

There was no copyright information or contact address in the 
vendor-provided driver, but it was obviously provided under
the terms of the GPL.

I copied over some code from the asix driver, maybe there is
potential to share the common code in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/usb/net/mcs7830.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/drivers/usb/net/mcs7830.c	2006-08-07 02:40:04.000000000 +0200
@@ -0,0 +1,514 @@
+/*
+ * MosChips MCS7830 based USB 2.0 Ethernet Devices
+ *
+ * based on usbnet.c, asix.c and the vendor provided mcs7830 driver
+ *
+ * Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>
+ * Copyright (C) 2003-2005 David Hollis <dhollis@davehollis.com>
+ * Copyright (C) 2005 Phil Chang <pchang23@sbcglobal.net>
+ * Copyright (c) 2002-2003 TiVo Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/init.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+
+#include "usbnet.h"
+
+/* requests */
+#define MCS7830_RD_BMREQ	(USB_DIR_IN  | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define MCS7830_WR_BMREQ	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define MCS7830_RD_BREQ		0x0E
+#define MCS7830_WR_BREQ		0x0D
+
+#define MCS7830_CTRL_TIMEOUT	1000
+#define MCS7830_MAX_MCAST	64
+
+#define MCS7830_VENDOR_ID	0x9710
+#define MCS7830_PRODUCT_ID	0x7830
+
+/* HIF_REG_XX coressponding index value */
+enum {
+	HIF_REG_MULTICAST_HASH			= 0x00,
+	HIF_REG_PACKET_GAP1			= 0x08,
+	HIF_REG_PACKET_GAP2			= 0x09,
+	HIF_REG_PHY_DATA			= 0x0a,
+	HIF_REG_PHY_CMD1			= 0x0c,
+	   HIF_REG_PHY_CMD1_READ		= 0x40,
+	   HIF_REG_PHY_CMD1_WRITE		= 0x20,
+	   HIF_REG_PHY_CMD1_PHYADDR		= 0x01,
+	HIF_REG_PHY_CMD2			= 0x0d,
+	   HIF_REG_PHY_CMD2_PEND_FLAG_BIT	= 0x80,
+	   HIF_REG_PHY_CMD2_READY_FLAG_BIT	= 0x40,
+	HIF_REG_CONFIG				= 0x0e,
+	   HIF_REG_CONFIG_CFG			= 0x80,
+	   HIF_REG_CONFIG_SPEED100		= 0x40,
+	   HIF_REG_CONFIG_FULLDUPLEX_ENABLE	= 0x20,
+	   HIF_REG_CONFIG_RXENABLE		= 0x10,
+	   HIF_REG_CONFIG_TXENABLE		= 0x08,
+	   HIF_REG_CONFIG_SLEEPMODE		= 0x04,
+	   HIF_REG_CONFIG_ALLMULTICAST		= 0x02,
+	   HIF_REG_CONFIG_PROMISCIOUS		= 0x01,
+	HIF_REG_ETHERNET_ADDR			= 0x0f,
+	HIF_REG_22				= 0x15,
+	HIF_REG_PAUSE_THRESHOLD			= 0x16,
+	   HIF_REG_PAUSE_THRESHOLD_DEFAULT	= 0,
+};
+
+/* index for PHY registers */
+enum {
+	PHY_CONTROL_REG_INDEX			=  0,
+	PHY_STATUS_REG_INDEX			=  1,
+	PHY_IDENTIFICATION1_REG_INDEX		=  2,
+	PHY_IDENTIFICATION2_REG_INDEX		=  3,
+	PHY_AUTONEGADVT_REG_INDEX		=  4,
+	PHY_AUTONEGLINK_REG_INDEX		=  5,
+	PHY_AUTONEGEXP_REG_INDEX		=  6,
+	PHY_MIRROR_REG_INDEX			= 16,
+	PHY_INTERRUPTENABLE_REG_INDEX		= 17,
+	PHY_INTERRUPTSTATUS_REG_INDEX		= 18,
+	PHY_CONFIG_REG_INDEX			= 19,
+	PHY_CHIPSTATUS_REG_INDEX		= 20,
+};
+
+struct mcs7830_data {
+	u8 multi_filter[8];
+	u8 config;
+};
+
+static DEFINE_MUTEX(mcs7830_phy_mutex);
+
+static const char driver_name[] = "MOSCHIP usb-ethernet driver";
+
+static int mcs7830_get_reg(struct usbnet *dev, u16 index, u16 size, void *data)
+{
+	struct usb_device *xdev = dev->udev;
+	int ret;
+
+	ret = usb_control_msg(xdev, usb_rcvctrlpipe(xdev, 0), MCS7830_RD_BREQ,
+			      MCS7830_RD_BMREQ, 0x0000, index, data,
+			      size, msecs_to_jiffies(MCS7830_CTRL_TIMEOUT));
+	return ret;
+}
+
+static int mcs7830_set_reg(struct usbnet *dev, u16 index, u16 size, void *data)
+{
+	struct usb_device *xdev = dev->udev;
+	int ret;
+
+	ret = usb_control_msg(xdev, usb_sndctrlpipe(xdev, 0), MCS7830_WR_BREQ,
+			      MCS7830_WR_BMREQ, 0x0000, index, data,
+			      size, msecs_to_jiffies(MCS7830_CTRL_TIMEOUT));
+	return ret;
+}
+
+static void mcs7830_async_cmd_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_ctrlrequest *req = (struct usb_ctrlrequest *)urb->context;
+
+	if (urb->status < 0)
+		printk(KERN_DEBUG "mcs7830_async_cmd_callback() failed with %d",
+			urb->status);
+
+	kfree(req);
+	usb_free_urb(urb);
+}
+
+static void mcs7830_set_reg_async(struct usbnet *dev, u16 index, u16 size, void *data)
+{
+	struct usb_ctrlrequest *req;
+	int ret;
+	struct urb *urb;
+
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		dev_dbg(&dev->udev->dev, "Error allocating URB "
+				"in write_cmd_async!");
+		return;
+	}
+
+	req = kmalloc(sizeof *req, GFP_ATOMIC);
+	if (!req) {
+		dev_err(&dev->udev->dev, "Failed to allocate memory for "
+				"control request");
+		goto out;
+	}
+	req->bRequestType = MCS7830_WR_BMREQ;
+	req->bRequest = MCS7830_WR_BREQ;
+	req->wValue = 0;
+	req->wIndex = cpu_to_le16(index);
+	req->wLength = cpu_to_le16(size);
+
+	usb_fill_control_urb(urb, dev->udev,
+			     usb_sndctrlpipe(dev->udev, 0),
+			     (void *)req, data, size,
+			     mcs7830_async_cmd_callback, req);
+
+	if ((ret = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
+		dev_err(&dev->udev->dev, "Error submitting the control "
+				"message: ret=%d", ret);
+		goto out;
+	}
+	return;
+out:
+	kfree(req);
+	usb_free_urb(urb);
+}
+
+static int mcs7830_get_address(struct usbnet *dev)
+{
+	int ret;
+	ret = mcs7830_get_reg(dev, HIF_REG_ETHERNET_ADDR, ETH_ALEN,
+				   dev->net->dev_addr);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int mcs7830_read_phy(struct usbnet *dev, u8 index)
+{
+	int ret;
+	int i;
+	__le16 val;
+
+	u8 cmd[2] = {
+		HIF_REG_PHY_CMD1_READ | HIF_REG_PHY_CMD1_PHYADDR,
+		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | index,
+	};
+
+	mutex_lock(&mcs7830_phy_mutex);
+	/* write the MII command */
+	ret = mcs7830_set_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
+	if (ret < 0)
+		goto out;
+
+	/* wait for the data to become valid, should be within < 1ms */
+	for (i = 0; i < 10; i++) {
+		ret = mcs7830_get_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
+		if ((ret < 0) || (cmd[1] & HIF_REG_PHY_CMD2_READY_FLAG_BIT))
+			break;
+		ret = -EIO;
+		msleep(1);
+	}
+	if (ret < 0)
+		goto out;
+
+	/* read actual register contents */
+	ret = mcs7830_get_reg(dev, HIF_REG_PHY_DATA, 2, &val);
+	if (ret < 0)
+		goto out;
+	ret = le16_to_cpu(val);
+	dev_dbg(&dev->udev->dev, "read PHY reg %02x: %04x (%d tries)\n",
+		index, val, i);
+out:
+	mutex_unlock(&mcs7830_phy_mutex);
+	return ret;
+}
+
+static int mcs7830_write_phy(struct usbnet *dev, u8 index, u16 val)
+{
+	int ret;
+	int i;
+	__le16 le_val;
+
+	u8 cmd[2] = {
+		HIF_REG_PHY_CMD1_WRITE | HIF_REG_PHY_CMD1_PHYADDR,
+		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | (index & 0x1F),
+	};
+
+	mutex_lock(&mcs7830_phy_mutex);
+
+	/* write the new register contents */
+	le_val = cpu_to_le16(val);
+	ret = mcs7830_set_reg(dev, HIF_REG_PHY_DATA, 2, &le_val);
+	if (ret < 0)
+		goto out;
+
+	/* write the MII command */
+	ret = mcs7830_set_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
+	if (ret < 0)
+		goto out;
+
+	/* wait for the command to be accepted by the PHY */
+	for (i = 0; i < 10; i++) {
+		ret = mcs7830_get_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
+		if ((ret < 0) || (cmd[1] & HIF_REG_PHY_CMD2_READY_FLAG_BIT))
+			break;
+		ret = -EIO;
+		msleep(1);
+	}
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+	dev_dbg(&dev->udev->dev, "write PHY reg %02x: %04x (%d tries)\n",
+		index, val, i);
+out:
+	mutex_unlock(&mcs7830_phy_mutex);
+	return ret;
+}
+
+/*
+ * This algorithm comes from the original mcs7830 version 1.4 driver,
+ * not sure if it is needed.
+ */
+static int mcs7830_set_autoneg(struct usbnet *dev, int ptrUserPhyMode)
+{
+	int ret;
+	/* Enable all media types */
+	ret = mcs7830_write_phy(dev, PHY_AUTONEGADVT_REG_INDEX, 0x05e1);
+	/* First Disable All */
+	if (!ret)
+		ret = mcs7830_write_phy(dev, PHY_CONTROL_REG_INDEX, 0x0000);
+	/* Enable Auto Neg */
+	if (!ret)
+		ret = mcs7830_write_phy(dev, PHY_CONTROL_REG_INDEX, 0x1000);
+	/* Restart Auto Neg (Keep the Enable Auto Neg Bit Set) */
+	if (!ret)
+		ret = mcs7830_write_phy(dev, PHY_CONTROL_REG_INDEX, 0x1200);
+	return ret < 0 ? : 0;
+}
+
+/*
+ * if we can read register 22, the chip revision is C
+ * or higher, and we need to set the pause threshold
+ */
+static void mcs7830_rev_C_fixup(struct usbnet *dev)
+{
+	u8 pause_threshold = HIF_REG_PAUSE_THRESHOLD_DEFAULT;
+	int retry;
+	u8 dummy[2];
+
+	for (retry = 0; retry < 2; retry ++) {
+		int ret;
+		ret = mcs7830_get_reg(dev, HIF_REG_22, 2, dummy);
+		if (ret > 0) {
+			dev_info(&dev->udev->dev, "applying rev.C fixup\n");
+			mcs7830_set_reg(dev, HIF_REG_PAUSE_THRESHOLD,
+					1, &pause_threshold);
+		}
+		msleep(1);
+	}
+}
+
+static int mcs7830_init_dev(struct usbnet *dev)
+{
+	int ret;
+	int retry;
+
+	/* Read MAC address from EEPROM */
+	ret = -EINVAL;
+	for (retry = 0; retry < 5 && ret; retry++)
+		ret = mcs7830_get_address(dev);
+	if (ret) {
+		dev_warn(&dev->udev->dev, "Cannot read MAC address\n");
+		goto out;
+	}
+
+	/* Set up PHY */
+	ret = mcs7830_set_autoneg(dev, 0);
+	if (ret) {
+		dev_info(&dev->udev->dev, "Cannot set autoneg\n");
+		goto out;
+	}
+
+	mcs7830_rev_C_fixup(dev);
+	ret = 0;
+out:
+	return ret;
+}
+
+static int mcs7830_mdio_read(struct net_device *netdev, int phy_id,
+			     int location)
+{
+	struct usbnet *dev = netdev->priv;
+	return mcs7830_read_phy(dev, location);
+}
+
+static void mcs7830_mdio_write(struct net_device *netdev, int phy_id,
+				int location, int val)
+{
+	struct usbnet *dev = netdev->priv;
+	mcs7830_write_phy(dev, location, val);
+}
+
+static int mcs7830_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
+{
+	struct usbnet *dev = netdev_priv(net);
+	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
+}
+
+/* credits go to asix_set_multicast */
+static void mcs7830_set_multicast(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct mcs7830_data *data = (struct mcs7830_data *)&dev->data;
+
+	data->config = HIF_REG_CONFIG_TXENABLE;
+
+	/* this should not be needed, but it doesn't work otherwise */
+	data->config |= HIF_REG_CONFIG_ALLMULTICAST;
+
+	if (net->flags & IFF_PROMISC) {
+		data->config |= HIF_REG_CONFIG_PROMISCIOUS;
+	} else if (net->flags & IFF_ALLMULTI
+		   || net->mc_count > MCS7830_MAX_MCAST) {
+		data->config |= HIF_REG_CONFIG_ALLMULTICAST;
+	} else if (net->mc_count == 0) {
+		/* just broadcast and directed */
+	} else {
+		/* We use the 20 byte dev->data
+		 * for our 8 byte filter buffer
+		 * to avoid allocating memory that
+		 * is tricky to free later */
+		struct dev_mc_list *mc_list = net->mc_list;
+		u32 crc_bits;
+		int i;
+
+		memset(data->multi_filter, 0, sizeof data->multi_filter);
+
+		/* Build the multicast hash filter. */
+		for (i = 0; i < net->mc_count; i++) {
+			crc_bits = ether_crc(ETH_ALEN, mc_list->dmi_addr) >> 26;
+			data->multi_filter[crc_bits >> 3] |= 1 << (crc_bits & 7);
+			mc_list = mc_list->next;
+		}
+
+		mcs7830_set_reg_async(dev, HIF_REG_MULTICAST_HASH,
+				sizeof data->multi_filter,
+				data->multi_filter);
+	}
+
+	mcs7830_set_reg_async(dev, HIF_REG_CONFIG, 1, &data->config);
+}
+
+static int mcs7830_bind(struct usbnet *dev, struct usb_interface *udev)
+{
+	struct net_device *net = dev->net;
+	int ret;
+
+	ret = mcs7830_init_dev(dev);
+	if (ret)
+		goto out;
+
+	net->do_ioctl = mcs7830_ioctl;
+	net->set_multicast_list = mcs7830_set_multicast;
+	mcs7830_set_multicast(net);
+
+	dev->mii.mdio_read = mcs7830_mdio_read;
+	dev->mii.mdio_write = mcs7830_mdio_write;
+	dev->mii.dev = net;
+	dev->mii.phy_id_mask = 0x3f;
+	dev->mii.reg_num_mask = 0x1f;
+	dev->mii.phy_id = *((u8 *) net->dev_addr + 1);
+
+	dev->in = usb_rcvbulkpipe(dev->udev, 1);
+	dev->out = usb_sndbulkpipe(dev->udev, 2);
+out:
+	return ret;
+}
+
+static int mcs7830_check_connect(struct usbnet *dev)
+{
+	int ret;
+	ret = mcs7830_mdio_read(dev->net, dev->mii.phy_id, 1);
+	return !ret;
+}
+
+static void mcs7830_status(struct usbnet *dev, struct urb *urb)
+{
+	u16 *event;
+	int link;
+	int count, i;
+
+	if (urb->actual_length != 16) {
+		dev_info(&dev->udev->dev, "unexpected irq packet length %d\n",
+			 urb->actual_length);
+		return;
+	}
+
+	event = urb->transfer_buffer;
+
+	dev_dbg(&dev->udev->dev, "%04x %04x %04x %04x %04x %04x %04x %04x\n",
+		event[0], event[1], event[2], event[3],
+		event[4], event[5], event[6], event[7]);
+
+	/* count number of packets to receive */
+	for (count = 0, i = 0; i < 8; i++)
+		if (event[i] & 0x8000)
+			count++;
+	if (count)
+		dev_info(&dev->udev->dev, "received %d packets", count);
+
+	link = !!(event[0] & 0x2000);
+	if (netif_carrier_ok(dev->net) != link) {
+		if (link) {
+			netif_carrier_on(dev->net);
+			usbnet_defer_kevent(dev, EVENT_LINK_RESET);
+		} else
+			netif_carrier_off(dev->net);
+		dev_dbg(&dev->udev->dev, "link status is: %d", link);
+	}
+
+	return;
+}
+
+static const struct driver_info moschip_info = {
+	.description	= "MOSCHIP 7830 usb-NET adapter",
+	.bind		= mcs7830_bind,
+	.check_connect	= mcs7830_check_connect,
+	.status		= mcs7830_status,
+	.flags		= FLAG_ETHER,
+};
+
+static const struct usb_device_id products[] = {
+	{ USB_DEVICE(MCS7830_VENDOR_ID, MCS7830_PRODUCT_ID),
+	 .driver_info = (unsigned long) &moschip_info, },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, products);
+
+static struct usb_driver mcs7830_driver = {
+	.name = driver_name,
+	.id_table = products,
+	.probe = usbnet_probe,
+	.disconnect = usbnet_disconnect,
+	.suspend = usbnet_suspend,
+	.resume = usbnet_resume,
+};
+
+static int __init mcs7830_init(void)
+{
+	return usb_register(&mcs7830_driver);
+}
+
+module_init(mcs7830_init);
+
+static void __exit mcs7830_exit(void)
+{
+	usb_deregister(&mcs7830_driver);
+}
+
+module_exit(mcs7830_exit);
+
+MODULE_DESCRIPTION("USB to network adapter MCS7830)");
+MODULE_LICENSE("GPL");
Index: linux-cg/drivers/usb/net/Kconfig
===================================================================
--- linux-cg.orig/drivers/usb/net/Kconfig	2006-08-07 02:40:31.000000000 +0200
+++ linux-cg/drivers/usb/net/Kconfig	2006-08-07 02:40:43.000000000 +0200
@@ -207,6 +207,14 @@
 	  Choose this option if you're using a host-to-host cable
 	  with one of these chips.
 
+config USB_NET_MCS7830
+	tristate "MosChip MCS7830 based Ethernet adapters"
+	depends on USB_USBNET
+	help
+	  Choose this option if you're using a 10/100 Ethernet USB2
+	  adapter based on the MosChip 7830 controller. This includes
+	  adapters marketed under the DeLOCK brand.
+
 config USB_NET_RNDIS_HOST
 	tristate "Host for RNDIS devices (EXPERIMENTAL)"
 	depends on USB_USBNET && EXPERIMENTAL
Index: linux-cg/drivers/usb/net/Makefile
===================================================================
--- linux-cg.orig/drivers/usb/net/Makefile	2006-08-07 02:40:31.000000000 +0200
+++ linux-cg/drivers/usb/net/Makefile	2006-08-07 02:40:43.000000000 +0200
@@ -14,6 +14,7 @@
 obj-$(CONFIG_USB_NET_RNDIS_HOST)	+= rndis_host.o
 obj-$(CONFIG_USB_NET_CDC_SUBSET)	+= cdc_subset.o
 obj-$(CONFIG_USB_NET_ZAURUS)	+= zaurus.o
+obj-$(CONFIG_USB_NET_MCS7830)	+= mcs7830.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
