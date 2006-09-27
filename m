Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030683AbWI0Tda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030683AbWI0Tda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030686AbWI0Tda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:33:30 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:42213 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030683AbWI0Td2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:33:28 -0400
Date: Wed, 27 Sep 2006 15:33:04 -0400
From: dhollis@davehollis.com
Subject: Re: [PATCH 2/3] usbnet: add a mutex around phy register access
In-reply-to: <200609170103.07280.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
Message-id: <20060927153304.ts21v9el80swcoww@web.davehollis.com>
MIME-version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Content-disposition: inline
References: <200609170055.34565.arnd@arndb.de>
	<200609170103.07280.arnd@arndb.de>
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann <arnd@arndb.de>:

> When working on the mcs7830, I noticed the need for a mutex in its
> mdio_read/mdio_write functions. A related problem seems to be present
> in the asix driver in the respective functions.
>
> This introduces a mutex in the common usbnet driver and uses it
> from the two hardware specific drivers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>

Acked-by: David Hollis <dhollis@davehollis.com>


> ---
> Index: linux-cg/drivers/usb/net/asix.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/asix.c	2006-09-17 00:10:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/asix.c	2006-09-17 00:18:08.000000000 +0200
> @@ -328,10 +328,12 @@
>  	struct usbnet *dev = netdev_priv(netdev);
>  	u16 res;
>
> +	mutex_lock(&dev->phy_mutex);
>  	asix_set_sw_mii(dev);
>  	asix_read_cmd(dev, AX_CMD_READ_MII_REG, phy_id,
>  				(__u16)loc, 2, (u16 *)&res);
>  	asix_set_hw_mii(dev);
> +	mutex_unlock(&dev->phy_mutex);
>
>  	return res & 0xffff;
>  }
> @@ -348,10 +350,12 @@
>  	struct usbnet *dev = netdev_priv(netdev);
>  	u16 res = val;
>
> +	mutex_lock(&dev->phy_mutex);
>  	asix_set_sw_mii(dev);
>  	asix_write_cmd(dev, AX_CMD_WRITE_MII_REG, phy_id,
>  				(__u16)loc, 2, (u16 *)&res);
>  	asix_set_hw_mii(dev);
> +	mutex_unlock(&dev->phy_mutex);
>  }
>
>  /* same as above, but converts new value to le16 byte order before   
> writing */
> Index: linux-cg/drivers/usb/net/usbnet.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/usbnet.c	2006-09-17   
> 00:10:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/usbnet.c	2006-09-17 00:18:08.000000000 +0200
> @@ -1112,6 +1112,7 @@
>  	dev->delay.function = usbnet_bh;
>  	dev->delay.data = (unsigned long) dev;
>  	init_timer (&dev->delay);
> +	mutex_init (&dev->phy_mutex);
>
>  	SET_MODULE_OWNER (net);
>  	dev->net = net;
> Index: linux-cg/drivers/usb/net/usbnet.h
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/usbnet.h	2006-09-17   
> 00:10:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/usbnet.h	2006-09-17 00:18:08.000000000 +0200
> @@ -30,6 +30,7 @@
>  	struct usb_device	*udev;
>  	struct driver_info	*driver_info;
>  	wait_queue_head_t	*wait;
> +	struct mutex		phy_mutex;
>
>  	/* i/o info: pipes etc */
>  	unsigned		in, out;
> Index: linux-cg/drivers/usb/net/mcs7830.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-09-17   
> 00:10:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/mcs7830.c	2006-09-17 00:18:08.000000000 +0200
> @@ -184,6 +184,7 @@
>  		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | index,
>  	};
>
> +	mutex_lock(&dev->phy_mutex);
>  	/* write the MII command */
>  	ret = mcs7830_set_reg(dev, HIF_REG_PHY_CMD1, 2, cmd);
>  	if (ret < 0)
> @@ -208,6 +209,7 @@
>  	dev_dbg(&dev->udev->dev, "read PHY reg %02x: %04x (%d tries)\n",
>  		index, val, i);
>  out:
> +	mutex_unlock(&dev->phy_mutex);
>  	return ret;
>  }
>
> @@ -222,6 +224,8 @@
>  		HIF_REG_PHY_CMD2_PEND_FLAG_BIT | (index & 0x1F),
>  	};
>
> +	mutex_lock(&dev->phy_mutex);
> +
>  	/* write the new register contents */
>  	le_val = cpu_to_le16(val);
>  	ret = mcs7830_set_reg(dev, HIF_REG_PHY_DATA, 2, &le_val);
> @@ -248,6 +252,7 @@
>  	dev_dbg(&dev->udev->dev, "write PHY reg %02x: %04x (%d tries)\n",
>  		index, val, i);
>  out:
> +	mutex_unlock(&dev->phy_mutex);
>  	return ret;
>  }
>
>
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

