Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274929AbSITElP>; Fri, 20 Sep 2002 00:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274931AbSITElP>; Fri, 20 Sep 2002 00:41:15 -0400
Received: from sr1.terra.com.br ([200.176.3.16]:12988 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S274929AbSITElO>;
	Fri, 20 Sep 2002 00:41:14 -0400
Subject: [PATCH] 8139cp: SIOCGMIIPHY and SIOCGMIIREG
From: Felipe W Damasio <felipewd@terra.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 01:49:12 +0000
Message-Id: <1032486552.206.3.camel@tank>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This patch adds support to the GMIIPHY and GMIIREG ioctls to the 2.4
version of the 8139cp ethernet driver.

	This is required so we don't break apps (eg mii-diag, mii-tools) who
rely on these ioctls to get the NIC's settings.

	Patch against 2.4.20-pre7.

	Please consider pulling it from:

http://cscience.org/~felipewd/linux/patches-fwd/2.4/8139cp-gmii.patch

Felipe

--- ./8139cp.c.orig	Fri Sep 20 00:20:19 2002
+++ ./8139cp.c	Fri Sep 20 00:29:01 2002
@@ -1641,14 +1641,29 @@
 static int cp_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct cp_private *cp = dev->priv;
+	struct mii_ioctl_data *mii;
 	int rc = 0;
 
+	mii = (struct mii_ioctl_data *) &rq->ifr_data;
 	if (!netif_running(dev))
 		return -EINVAL;
 
+	if (cmd != SIOCETHTOOL) 
+		mii->reg_num &= 0x1f;
+	
 	switch (cmd) {
 	case SIOCETHTOOL:
 		return cp_ethtool_ioctl(cp, (void *) rq->ifr_data);
+		
+ 	case SIOCGMIIPHY:	/* Get the address of the PHY in use. */
+	case SIOCDEVPRIVATE:	/* binary compat, remove in 2.5 */
+		mii->phy_id = CP_INTERNAL_PHY;
+		/* Fall Through */
+
+	case SIOCGMIIREG:	/* Read the specified MII register. */
+	case SIOCDEVPRIVATE+1:	/* binary compat, remove in 2.5 */
+		mii->val_out = mdio_read (dev, CP_INTERNAL_PHY, mii->reg_num);
+		break;
 
 	default:
 		rc = -EOPNOTSUPP;

