Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUFGP54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUFGP54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUFGPz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:55:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64136 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264822AbUFGPxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:53:46 -0400
Date: Mon, 7 Jun 2004 11:53:34 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: epic100 fixes
Message-ID: <20040607155334.GA10637@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gee it works better if you turn the chip on before programming it"

The ioctl to ethtool change broke that little detail...


I made the changes, Jeff agreed in principle, Red Hat owns them and I know
no reason they can't be contributed under the GPL v2 or later.

Requires: ethtool change


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/net/epic100.c linux-2.6.6/drivers/net/epic100.c
--- linux.vanilla-2.6.6/drivers/net/epic100.c	2004-05-10 03:32:29.000000000 +0100
+++ linux-2.6.6/drivers/net/epic100.c	2004-06-02 23:05:21.000000000 +0100
@@ -66,12 +66,15 @@
 	LK1.1.14 (Kryzsztof Halasa):
 	* fix spurious bad initializations
 	* pound phy a la SMSC's app note on the subject
+	
+	AC1.1.14ac
+	* fix power up/down for ethtool that broke in 1.11
 
 */
 
 #define DRV_NAME        "epic100"
-#define DRV_VERSION     "1.11+LK1.1.14"
-#define DRV_RELDATE     "Aug 4, 2002"
+#define DRV_VERSION     "1.11+LK1.1.14+AC1.1.14"
+#define DRV_RELDATE     "June 2, 2004"
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -1424,6 +1427,27 @@
 	debug = value;
 }
 
+static int ethtool_begin(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	/* power-up, if interface is down */
+	if (! netif_running(dev)) {
+		outl(0x0200, ioaddr + GENCTL);
+		outl((inl(ioaddr + NVCTL) & ~0x003C) | 0x4800, ioaddr + NVCTL);
+	}
+	return 0;
+}
+
+static void ethtool_complete(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	/* power-down, if interface is down */
+	if (! netif_running(dev)) {
+		outl(0x0008, ioaddr + GENCTL);
+		outl((inl(ioaddr + NVCTL) & ~0x483C) | 0x0000, ioaddr + NVCTL);
+	}
+}
+
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
 	.get_settings		= netdev_get_settings,
@@ -1434,6 +1458,8 @@
 	.set_msglevel		= netdev_set_msglevel,
 	.get_sg			= ethtool_op_get_sg,
 	.get_tx_csum		= ethtool_op_get_tx_csum,
+	.begin			= ethtool_begin,
+	.complete		= ethtool_complete
 };
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
