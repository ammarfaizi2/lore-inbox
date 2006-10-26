Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWJZCWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWJZCWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWJZCWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:22:20 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:6308 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965285AbWJZCWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:22:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=UNTJnEMmYF5A1kYyR9zgUMZYP1glH2av5i/Hi9Cw7MmAX+q+y3D7APWGAHXlvzDdR0jELK2S/4etkWprrHHAyrZLBNGpCkBvogOiy6azmP9LrCDWXn69ZLkhT8950hMy3D/TijpYmbeM2ezq4J69liH9pBOKqyFtcDCrO2KhrKw=  ;
From: David Brownell <david-b@pacbell.net>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Wed, 25 Oct 2006 19:22:08 -0700
User-Agent: KMail/1.7.1
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061025165858.b76b4fd8.randy.dunlap@oracle.com>
In-Reply-To: <20061025165858.b76b4fd8.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251922.09692.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 4:58 pm, Randy Dunlap wrote:
> On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:
> 
> > Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
> > according to CONFIG_MII ... since it's completely legit to
> > use usbnet with peripherals that don't need MII.

I had in mind something simpler -- #ifdeffing the entire functions,
as in this patch.  It looks more complicated than it is, because
"diff" gets confused by moving two functions earlier in the file.

(Thanks for starting this, Randy ... these two patches should be merged
before RC4 ships.)

- Dave



The usbnet infrastructure must not reference MII symbols unless they're
provided in the kernel being built.  This extends also to the ethtool
hooks that reference those symbols.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/usb/net/usbnet.c
===================================================================
--- g26.orig/drivers/usb/net/usbnet.c	2006-10-24 18:29:28.000000000 -0700
+++ g26/drivers/usb/net/usbnet.c	2006-10-25 19:07:16.000000000 -0700
@@ -669,6 +669,9 @@ done:
  * they'll probably want to use this base set.
  */
 
+#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
+#define HAVE_MII
+
 int usbnet_get_settings (struct net_device *net, struct ethtool_cmd *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -699,20 +702,6 @@ int usbnet_set_settings (struct net_devi
 }
 EXPORT_SYMBOL_GPL(usbnet_set_settings);
 
-
-void usbnet_get_drvinfo (struct net_device *net, struct ethtool_drvinfo *info)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	/* REVISIT don't always return "usbnet" */
-	strncpy (info->driver, driver_name, sizeof info->driver);
-	strncpy (info->version, DRIVER_VERSION, sizeof info->version);
-	strncpy (info->fw_version, dev->driver_info->description,
-		sizeof info->fw_version);
-	usb_make_path (dev->udev, info->bus_info, sizeof info->bus_info);
-}
-EXPORT_SYMBOL_GPL(usbnet_get_drvinfo);
-
 u32 usbnet_get_link (struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -730,40 +719,57 @@ u32 usbnet_get_link (struct net_device *
 }
 EXPORT_SYMBOL_GPL(usbnet_get_link);
 
-u32 usbnet_get_msglevel (struct net_device *net)
+int usbnet_nway_reset(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
 
-	return dev->msg_enable;
+	if (!dev->mii.mdio_write)
+		return -EOPNOTSUPP;
+
+	return mii_nway_restart(&dev->mii);
 }
-EXPORT_SYMBOL_GPL(usbnet_get_msglevel);
+EXPORT_SYMBOL_GPL(usbnet_nway_reset);
 
-void usbnet_set_msglevel (struct net_device *net, u32 level)
+#endif	/* HAVE_MII */
+
+void usbnet_get_drvinfo (struct net_device *net, struct ethtool_drvinfo *info)
 {
 	struct usbnet *dev = netdev_priv(net);
 
-	dev->msg_enable = level;
+	/* REVISIT don't always return "usbnet" */
+	strncpy (info->driver, driver_name, sizeof info->driver);
+	strncpy (info->version, DRIVER_VERSION, sizeof info->version);
+	strncpy (info->fw_version, dev->driver_info->description,
+		sizeof info->fw_version);
+	usb_make_path (dev->udev, info->bus_info, sizeof info->bus_info);
 }
-EXPORT_SYMBOL_GPL(usbnet_set_msglevel);
+EXPORT_SYMBOL_GPL(usbnet_get_drvinfo);
 
-int usbnet_nway_reset(struct net_device *net)
+u32 usbnet_get_msglevel (struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
 
-	if (!dev->mii.mdio_write)
-		return -EOPNOTSUPP;
+	return dev->msg_enable;
+}
+EXPORT_SYMBOL_GPL(usbnet_get_msglevel);
 
-	return mii_nway_restart(&dev->mii);
+void usbnet_set_msglevel (struct net_device *net, u32 level)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	dev->msg_enable = level;
 }
-EXPORT_SYMBOL_GPL(usbnet_nway_reset);
+EXPORT_SYMBOL_GPL(usbnet_set_msglevel);
 
 /* drivers may override default ethtool_ops in their bind() routine */
 static struct ethtool_ops usbnet_ethtool_ops = {
+#ifdef	HAVE_MII
 	.get_settings		= usbnet_get_settings,
 	.set_settings		= usbnet_set_settings,
-	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= usbnet_get_link,
 	.nway_reset		= usbnet_nway_reset,
+#endif
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
 };
