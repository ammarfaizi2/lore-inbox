Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFBFtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFBFtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWFBFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:49:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:49028 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751132AbWFBFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:49:03 -0400
Message-ID: <447FD14E.2020800@vmware.com>
Date: Thu, 01 Jun 2006 22:49:02 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Ayaz Abdulla <aabdulla@nvidia.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: manfred@colorfullife.com
Subject: Re: [PATCH] Allow TSO to be disabled for forcedeth driver
References: <DBFABB80F7FD3143A911F9E6CFD477B00BA5E36B@hqemmail02.nvidia.com> <20060601142909.369cf12f.akpm@osdl.org> <447F6E13.8030904@vmware.com> <447F472E.5060808@nvidia.com>
In-Reply-To: <447F472E.5060808@nvidia.com>
Content-Type: multipart/mixed;
 boundary="------------060708020005070903050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060708020005070903050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ayaz Abdulla wrote:
>
> However, please change your patch to account for the ifdef NETIF_F_TSO 
> and you don't need spin lock around this change. For example, here are 
> the snippets:

Done

--------------060708020005070903050203
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
+++ linux-2.6.17-rc/drivers/net/forcedeth.c	2006-06-01 16:00:58.000000000 -0700
@@ -2615,6 +2615,23 @@ static int nv_nway_reset(struct net_devi
 	return ret;
 }
 
+#ifdef NETIF_F_TSO
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
+#endif
+
 static struct ethtool_ops ops = {
 	.get_drvinfo = nv_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -2626,6 +2643,10 @@ static struct ethtool_ops ops = {
 	.get_regs = nv_get_regs,
 	.nway_reset = nv_nway_reset,
 	.get_perm_addr = ethtool_op_get_perm_addr,
+#ifdef NETIF_F_TSO
+	.get_tso = ethtool_op_get_tso,
+	.set_tso = nv_set_tso
+#endif
 };
 
 static void nv_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)

--------------060708020005070903050203--
