Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWFAT1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWFAT1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbWFAT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:27:53 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:36531 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964939AbWFAT1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:27:52 -0400
Message-ID: <447F3FB8.2010003@vmware.com>
Date: Thu, 01 Jun 2006 12:27:52 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow TSO to be disabled for forcedeth driver
Content-Type: multipart/mixed;
 boundary="------------050104020302050201080909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104020302050201080909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

TSO can cause performance problems in certain environments, and being 
able to turn it on or off is helpful for debugging network issues.  Most 
other network drivers that support TSO allow it to be toggled, so add 
this feature to forcedeth.  Tested by Harald Dunkel, who reported that 
this fixed his network performance issue with VMware.



--------------050104020302050201080909
Content-Type: text/plain;
 name="forcedeth-tso-toggle"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forcedeth-tso-toggle"

Implement get / set tso for forcedeth driver.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/drivers/net/forcedeth.c
===================================================================
--- linux-2.6.17-rc.orig/drivers/net/forcedeth.c	2006-05-18 13:31:55.000000000 -0700
+++ linux-2.6.17-rc/drivers/net/forcedeth.c	2006-05-31 14:34:53.000000000 -0700
@@ -2615,6 +2615,21 @@ static int nv_nway_reset(struct net_devi
 	return ret;
 }
 
+static int nv_set_tso(struct net_device *dev, u32 value)
+{
+	struct fe_priv *np = netdev_priv(dev);
+	int ret;
+
+	spin_lock_irq(&np->lock);
+	if ((np->driver_data & DEV_HAS_CHECKSUM))
+		ret = ethtool_op_set_tso(dev, value);
+	else
+		ret = value ? -EOPNOTSUPP : 0;
+	spin_unlock_irq(&np->lock);
+
+	return ret;
+}
+
 static struct ethtool_ops ops = {
 	.get_drvinfo = nv_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -2626,6 +2641,8 @@ static struct ethtool_ops ops = {
 	.get_regs = nv_get_regs,
 	.nway_reset = nv_nway_reset,
 	.get_perm_addr = ethtool_op_get_perm_addr,
+	.get_tso = ethtool_op_get_tso,
+	.set_tso = nv_set_tso
 };
 
 static void nv_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)

--------------050104020302050201080909--
