Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWJYX7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWJYX7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWJYX7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:59:06 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:10561 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964838AbWJYX7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:59:05 -0400
Date: Wed, 25 Oct 2006 16:58:58 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David Brownell <david-b@pacbell.net>
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-Id: <20061025165858.b76b4fd8.randy.dunlap@oracle.com>
In-Reply-To: <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061025201341.GH21200@miggy.org>
	<20061025151737.1bf4898c.randy.dunlap@oracle.com>
	<20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:

> Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
> according to CONFIG_MII ... since it's completely legit to
> use usbnet with peripherals that don't need MII.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

usbnet driver should use mii_*() interfaces if they are available
in the kernel (config enabled) but usbnet does not require or depend
on these interfaces.

Build tested with CONFIG_MII=y, m, n.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/usb/net/usbnet.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linux-2619-rc3-pv.orig/drivers/usb/net/usbnet.c
+++ linux-2619-rc3-pv/drivers/usb/net/usbnet.c
@@ -47,6 +47,12 @@
 
 #define DRIVER_VERSION		"22-Aug-2005"
 
+#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
+#define HAVE_MII		1
+#else
+#define HAVE_MII		0
+#endif
+
 
 /*-------------------------------------------------------------------------*/
 
@@ -676,7 +682,10 @@ int usbnet_get_settings (struct net_devi
 	if (!dev->mii.mdio_read)
 		return -EOPNOTSUPP;
 
+#if HAVE_MII
 	return mii_ethtool_gset(&dev->mii, cmd);
+#endif
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_settings);
 
@@ -688,7 +697,11 @@ int usbnet_set_settings (struct net_devi
 	if (!dev->mii.mdio_write)
 		return -EOPNOTSUPP;
 
+#if HAVE_MII
 	retval = mii_ethtool_sset(&dev->mii, cmd);
+#else
+	retval = -EOPNOTSUPP;
+#endif
 
 	/* link speed/duplex might have changed */
 	if (dev->driver_info->link_reset)
@@ -721,9 +734,11 @@ u32 usbnet_get_link (struct net_device *
 	if (dev->driver_info->check_connect)
 		return dev->driver_info->check_connect (dev) == 0;
 
+#if HAVE_MII
 	/* if the device has mii operations, use those */
 	if (dev->mii.mdio_read)
 		return mii_link_ok(&dev->mii);
+#endif
 
 	/* Otherwise, say we're up (to avoid breaking scripts) */
 	return 1;
@@ -753,7 +768,10 @@ int usbnet_nway_reset(struct net_device 
 	if (!dev->mii.mdio_write)
 		return -EOPNOTSUPP;
 
+#if HAVE_MII
 	return mii_nway_restart(&dev->mii);
+#endif
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(usbnet_nway_reset);
 
