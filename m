Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUL3I7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUL3I7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUL3I6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:58:21 -0500
Received: from smtp.knology.net ([24.214.63.101]:57306 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261584AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:36 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 12/22] ethtool: Add support for crypto offload
Message-Id: <20041230035000.21@ori.thedillows.org>
References: <20041230035000.20@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:51:19-05:00 dave@thedillows.org 
#   Add support for querying and changing the status of the
#   IPSEC crypto offload feature of a NIC.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/core/ethtool.c
#   2004/12/30 00:51:00-05:00 dave@thedillows.org +54 -0
#   Add support for querying and changing the status of the IPSEC
#   crypto offload feature of a NIC.
#   
#   Turn on/off the feature flag before informing the xfrm engine
#   of the change so that existing xfrms get the new settings.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/linux/ethtool.h
#   2004/12/30 00:51:00-05:00 dave@thedillows.org +8 -0
#   Add support for querying and changing the status of the
#   IPSEC crypto offload feature of a NIC.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/linux/ethtool.h b/include/linux/ethtool.h
--- a/include/linux/ethtool.h	2004-12-30 01:09:49 -05:00
+++ b/include/linux/ethtool.h	2004-12-30 01:09:49 -05:00
@@ -260,6 +260,8 @@
 int ethtool_op_set_sg(struct net_device *dev, u32 data);
 u32 ethtool_op_get_tso(struct net_device *dev);
 int ethtool_op_set_tso(struct net_device *dev, u32 data);
+u32 ethtool_op_get_ipsec(struct net_device *dev);
+int ethtool_op_set_ipsec(struct net_device *dev, u32 data);
 
 /**
  * &ethtool_ops - Alter and report network device settings
@@ -293,6 +295,8 @@
  * get_strings: Return a set of strings that describe the requested objects 
  * phys_id: Identify the device
  * get_stats: Return statistics about the device
+ * get_ipsec: Report whether IPSEC crypto offload is enabled
+ * set_ipsec: Turn IPSEC crypto offload on or off
  *
  * Description:
  *
@@ -345,6 +349,8 @@
 	int	(*set_sg)(struct net_device *, u32);
 	u32	(*get_tso)(struct net_device *);
 	int	(*set_tso)(struct net_device *, u32);
+	u32	(*get_ipsec)(struct net_device *);
+	int	(*set_ipsec)(struct net_device *, u32);
 	int	(*self_test_count)(struct net_device *);
 	void	(*self_test)(struct net_device *, struct ethtool_test *, u64 *);
 	void	(*get_strings)(struct net_device *, u32 stringset, u8 *);
@@ -388,6 +394,8 @@
 #define ETHTOOL_GSTATS		0x0000001d /* get NIC-specific statistics */
 #define ETHTOOL_GTSO		0x0000001e /* Get TSO enable (ethtool_value) */
 #define ETHTOOL_STSO		0x0000001f /* Set TSO enable (ethtool_value) */
+#define ETHTOOL_GIPSEC		0x00000020 /* Get IPSEC enable (ethtool_value) */
+#define ETHTOOL_SIPSEC		0x00000021 /* Set IPSEC enable (ethtool_value) */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
diff -Nru a/net/core/ethtool.c b/net/core/ethtool.c
--- a/net/core/ethtool.c	2004-12-30 01:09:49 -05:00
+++ b/net/core/ethtool.c	2004-12-30 01:09:49 -05:00
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <net/xfrm.h>
 #include <asm/uaccess.h>
 
 /* 
@@ -72,6 +73,24 @@
 	return 0;
 }
 
+u32 ethtool_op_get_ipsec(struct net_device *dev)
+{
+	return (dev->features & NETIF_F_IPSEC) != 0;
+}
+
+int ethtool_op_set_ipsec(struct net_device *dev, u32 data)
+{
+	if (data) {
+		dev->features |= NETIF_F_IPSEC;
+		xfrm_accel_add(dev);
+	} else {
+		dev->features &= ~NETIF_F_IPSEC;
+		xfrm_accel_flush(dev);
+	}
+
+	return 0;
+}
+
 /* Handlers for each ethtool command */
 
 static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
@@ -548,6 +567,33 @@
 	return dev->ethtool_ops->set_tso(dev, edata.data);
 }
 
+static int ethtool_get_ipsec(struct net_device *dev, char __user *useraddr)
+{
+	struct ethtool_value edata = { ETHTOOL_GIPSEC };
+
+	if (!dev->ethtool_ops->get_ipsec)
+		return -EOPNOTSUPP;
+
+	edata.data = dev->ethtool_ops->get_ipsec(dev);
+
+	if (copy_to_user(useraddr, &edata, sizeof(edata)))
+		return -EFAULT;
+	return 0;
+}
+
+static int ethtool_set_ipsec(struct net_device *dev, char __user *useraddr)
+{
+	struct ethtool_value edata;
+
+	if (!dev->ethtool_ops->set_ipsec)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&edata, useraddr, sizeof(edata)))
+		return -EFAULT;
+
+	return dev->ethtool_ops->set_ipsec(dev, edata.data);
+}
+
 static int ethtool_self_test(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_test test;
@@ -783,6 +829,12 @@
 	case ETHTOOL_STSO:
 		rc = ethtool_set_tso(dev, useraddr);
 		break;
+	case ETHTOOL_GIPSEC:
+		rc = ethtool_get_ipsec(dev, useraddr);
+		break;
+	case ETHTOOL_SIPSEC:
+		rc = ethtool_set_ipsec(dev, useraddr);
+		break;
 	case ETHTOOL_TEST:
 		rc = ethtool_self_test(dev, useraddr);
 		break;
@@ -813,7 +865,9 @@
 EXPORT_SYMBOL(ethtool_op_get_link);
 EXPORT_SYMBOL(ethtool_op_get_sg);
 EXPORT_SYMBOL(ethtool_op_get_tso);
+EXPORT_SYMBOL(ethtool_op_get_ipsec);
 EXPORT_SYMBOL(ethtool_op_get_tx_csum);
 EXPORT_SYMBOL(ethtool_op_set_sg);
 EXPORT_SYMBOL(ethtool_op_set_tso);
+EXPORT_SYMBOL(ethtool_op_set_ipsec);
 EXPORT_SYMBOL(ethtool_op_set_tx_csum);
