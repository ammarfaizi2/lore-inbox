Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030681AbWI0Tdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWI0Tdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030686AbWI0Tdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:33:53 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:9959 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030681AbWI0Tdv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:33:51 -0400
Date: Wed, 27 Sep 2006 15:33:40 -0400
From: dhollis@davehollis.com
Subject: Re: [PATCH 3/3] usbnet: improve generic ethtool support
In-reply-to: <200609170103.16415.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Helmling <supermihi@web.de>
Message-id: <20060927153340.xjj8zprcowwkwk44@web.davehollis.com>
MIME-version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Content-disposition: inline
References: <200609170055.34565.arnd@arndb.de>
	<200609170057.07460.arnd@arndb.de> <200609170103.16415.arnd@arndb.de>
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann <arnd@arndb.de>:

> This adds generic support for the ethtool commands get_settings,
> set_settings, get_link and nway_reset to usbnet. These are now
> implemented using mii functions when a low-level driver supports
> mdio_read/mdio_write and does not override the usbnet ethtool
> commands with its own.
>
> Currently, this applies to the asix and the mcs7830 drivers.
> I have tested it on mcs7830.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>

Acked-by: David Hollis <dhollis@davehollis.com>


>
> Index: linux-cg/drivers/usb/net/asix.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/asix.c	2006-09-17 00:05:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/asix.c	2006-09-17 00:09:43.000000000 +0200
> @@ -458,20 +458,6 @@
>  	info->eedump_len = 0x3e;
>  }
>
> -static int asix_get_settings(struct net_device *net, struct   
> ethtool_cmd *cmd)
> -{
> -	struct usbnet *dev = netdev_priv(net);
> -
> -	return mii_ethtool_gset(&dev->mii,cmd);
> -}
> -
> -static int asix_set_settings(struct net_device *net, struct   
> ethtool_cmd *cmd)
> -{
> -	struct usbnet *dev = netdev_priv(net);
> -
> -	return mii_ethtool_sset(&dev->mii,cmd);
> -}
> -
>  /* We need to override some ethtool_ops so we require our
>     own structure so we don't interfere with other usbnet
>     devices that may be connected at the same time. */
> @@ -484,8 +470,9 @@
>  	.set_wol		= asix_set_wol,
>  	.get_eeprom_len		= asix_get_eeprom_len,
>  	.get_eeprom		= asix_get_eeprom,
> -	.get_settings		= asix_get_settings,
> -	.set_settings		= asix_set_settings,
> +	.get_settings		= usbnet_get_settings,
> +	.set_settings		= usbnet_set_settings,
> +	.nway_reset		= usbnet_nway_reset,
>  };
>
>  static int asix_ioctl (struct net_device *net, struct ifreq *rq, int cmd)
> @@ -564,8 +551,9 @@
>  	.set_wol		= asix_set_wol,
>  	.get_eeprom_len		= asix_get_eeprom_len,
>  	.get_eeprom		= asix_get_eeprom,
> -	.get_settings		= asix_get_settings,
> -	.set_settings		= asix_set_settings,
> +	.get_settings		= usbnet_get_settings,
> +	.set_settings		= usbnet_set_settings,
> +	.nway_reset		= usbnet_nway_reset,
>  };
>
>  static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
> Index: linux-cg/drivers/usb/net/mcs7830.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-09-17   
> 00:05:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/mcs7830.c	2006-09-17 00:06:21.000000000 +0200
> @@ -430,8 +430,12 @@
>  	.get_regs		= mcs7830_get_regs,
>
>  	/* common usbnet calls */
> +	.get_link		= usbnet_get_link,
>  	.get_msglevel		= usbnet_get_msglevel,
>  	.set_msglevel		= usbnet_set_msglevel,
> +	.get_settings		= usbnet_get_settings,
> +	.set_settings		= usbnet_set_settings,
> +	.nway_reset		= usbnet_nway_reset,
>  };
>
>  static int mcs7830_bind(struct usbnet *dev, struct usb_interface *udev)
> Index: linux-cg/drivers/usb/net/usbnet.c
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/usbnet.c	2006-09-17   
> 00:05:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/usbnet.c	2006-09-17 00:07:45.000000000 +0200
> @@ -645,6 +645,29 @@
>   * they'll probably want to use this base set.
>   */
>
> +int usbnet_get_settings (struct net_device *net, struct ethtool_cmd *cmd)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	if (!dev->mii.mdio_read)
> +		return -EOPNOTSUPP;
> +
> +	return mii_ethtool_gset(&dev->mii, cmd);
> +}
> +EXPORT_SYMBOL_GPL(usbnet_get_settings);
> +
> +int usbnet_set_settings (struct net_device *net, struct ethtool_cmd *cmd)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	if (!dev->mii.mdio_write)
> +		return -EOPNOTSUPP;
> +
> +	return mii_ethtool_sset(&dev->mii, cmd);
> +}
> +EXPORT_SYMBOL_GPL(usbnet_set_settings);
> +
> +
>  void usbnet_get_drvinfo (struct net_device *net, struct   
> ethtool_drvinfo *info)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> @@ -658,7 +681,7 @@
>  }
>  EXPORT_SYMBOL_GPL(usbnet_get_drvinfo);
>
> -static u32 usbnet_get_link (struct net_device *net)
> +u32 usbnet_get_link (struct net_device *net)
>  {
>  	struct usbnet *dev = netdev_priv(net);
>
> @@ -666,9 +689,14 @@
>  	if (dev->driver_info->check_connect)
>  		return dev->driver_info->check_connect (dev) == 0;
>
> +	/* if the device has mii operations, use those */
> +	if (dev->mii.mdio_read)
> +		return mii_link_ok(&dev->mii);
> +
>  	/* Otherwise, say we're up (to avoid breaking scripts) */
>  	return 1;
>  }
> +EXPORT_SYMBOL_GPL(usbnet_get_link);
>
>  u32 usbnet_get_msglevel (struct net_device *net)
>  {
> @@ -686,10 +714,24 @@
>  }
>  EXPORT_SYMBOL_GPL(usbnet_set_msglevel);
>
> +int usbnet_nway_reset(struct net_device *net)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	if (!dev->mii.mdio_write)
> +		return -EOPNOTSUPP;
> +
> +	return mii_nway_restart(&dev->mii);
> +}
> +EXPORT_SYMBOL_GPL(usbnet_nway_reset);
> +
>  /* drivers may override default ethtool_ops in their bind() routine */
>  static struct ethtool_ops usbnet_ethtool_ops = {
> +	.get_settings		= usbnet_get_settings,
> +	.set_settings		= usbnet_set_settings,
>  	.get_drvinfo		= usbnet_get_drvinfo,
>  	.get_link		= usbnet_get_link,
> +	.nway_reset		= usbnet_nway_reset,
>  	.get_msglevel		= usbnet_get_msglevel,
>  	.set_msglevel		= usbnet_set_msglevel,
>  };
> Index: linux-cg/drivers/usb/net/usbnet.h
> ===================================================================
> --- linux-cg.orig/drivers/usb/net/usbnet.h	2006-09-17   
> 00:05:53.000000000 +0200
> +++ linux-cg/drivers/usb/net/usbnet.h	2006-09-17 00:07:53.000000000 +0200
> @@ -167,9 +167,13 @@
>  extern void usbnet_defer_kevent (struct usbnet *, int);
>  extern void usbnet_skb_return (struct usbnet *, struct sk_buff *);
>
> +extern int usbnet_get_settings (struct net_device *net, struct   
> ethtool_cmd *cmd);
> +extern int usbnet_set_settings (struct net_device *net, struct   
> ethtool_cmd *cmd);
> +extern u32 usbnet_get_link (struct net_device *net);
>  extern u32 usbnet_get_msglevel (struct net_device *);
>  extern void usbnet_set_msglevel (struct net_device *, u32);
>  extern void usbnet_get_drvinfo (struct net_device *, struct   
> ethtool_drvinfo *);
> +extern int usbnet_nway_reset(struct net_device *net);
>
>  /* messaging support includes the interface name, so it must not be
>   * used before it has one ... notably, in minidriver bind() calls.
>
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

