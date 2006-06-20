Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWFTO6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFTO6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWFTO6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:58:50 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:28810 "EHLO
	vitb.dev.rtsoft.ru") by vger.kernel.org with ESMTP id S1751193AbWFTO6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:58:49 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-embedded@ozlabs.org
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/3] FS_ENET: phydev pointer may be dereferenced without NULL check
Date: Tue, 20 Jun 2006 18:58:43 +0400
Message-Id: <20060620145843.24807.34893.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060620145825.24807.310.stgit@vitb.ru.mvista.com>
References: <20060620145825.24807.310.stgit@vitb.ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When interface is down, phy is "disconnected" from the bus and phydev is NULL.
But ethtool may try to get/set phy regs even at that time, which results in
NULL pointer dereference and OOPS hereby.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/net/fs_enet/fs_enet-main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 302ecaa..e475e22 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -882,12 +882,16 @@ static void fs_get_regs(struct net_devic
 static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	if (!fep->phydev)
+		return -EINVAL;
 	return phy_ethtool_gset(fep->phydev, cmd);
 }
 
 static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	if (!fep->phydev)
+		return -EINVAL;
 	phy_ethtool_sset(fep->phydev, cmd);
 	return 0;
 }

