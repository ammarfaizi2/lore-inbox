Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUFHS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUFHS34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbUFHS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 14:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265275AbUFHS3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 14:29:34 -0400
Message-ID: <40C6057F.9060509@pobox.com>
Date: Tue, 08 Jun 2004 14:29:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "David S. Miller" <davem@redhat.com>, Netdev <netdev@oss.sgi.com>
Subject: Re: PATCH: ethtool power manglement hooks
References: <20040607155018.GA5810@devserv.devel.redhat.com>
In-Reply-To: <20040607155018.GA5810@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010305080009080309070609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305080009080309070609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

applied to 2.6 verbatim, applied to 2.4 slightly modified (2.4 patch 
attached, and DaveM CC added).


--------------010305080009080309070609
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/08 14:27:21-04:00 jgarzik@pobox.com 
#   [netdrvr] fix ethtool_ops design bug, sync with 2.6.x ethtool_ops code
#   
#   In addition to merging Alan Cox's fix for an ethtool_ops design bug,
#   I took the opportunity to synchronize the source with 2.6.x, which
#   will make it easier to maintain in the long run.
#   
#   Description of the fix from Alan Cox <alan@redhat.com>:
#   
#     [PATCH] ethtool power manglement hooks
#     
#     Several ethernet drivers have been broken by the ethtool support because
#     the ioctl code used to power the interface up and down as needed. Rather
#     than add this to each driver call Jeff Garzik suggested we add hooks
#     for before/after ethtool processing.
#     
#     This patch implements them which makes fixing the PM stuff easier,
#     as the epic100 patch to follow will show. It also cleans up the
#     via-velocity driver pm/ethtool logic a great deal. As per Jeff's
#     request the before handler is allowed to fail the operation.
#     
#     --
#     
#     The contribution herein included is a creation of Red Hat Inc. It is hereby
#     submitted under the license of the existing files and as a derivative work
#     thereof. I know of no reason for not having the right to submit the
#     work herein included.
#     
#     (Bluff your way in legalese ;))
# 
diff -Nru a/include/linux/ethtool.h b/include/linux/ethtool.h
--- a/include/linux/ethtool.h	2004-06-08 14:27:33 -04:00
+++ b/include/linux/ethtool.h	2004-06-08 14:27:33 -04:00
@@ -345,6 +345,8 @@
 	int	(*phys_id)(struct net_device *, u32);
 	int	(*get_stats_count)(struct net_device *);
 	void	(*get_ethtool_stats)(struct net_device *, struct ethtool_stats *, u64 *);
+	int	(*begin)(struct net_device *);
+	void	(*complete)(struct net_device *);
 };
 
 /* CMDs currently supported */
diff -Nru a/net/core/Makefile b/net/core/Makefile
--- a/net/core/Makefile	2004-06-08 14:27:33 -04:00
+++ b/net/core/Makefile	2004-06-08 14:27:33 -04:00
@@ -9,7 +9,7 @@
 
 O_TARGET := core.o
 
-export-objs := netfilter.o profile.o
+export-objs := netfilter.o profile.o ethtool.o
 
 obj-y := sock.o skbuff.o iovec.o datagram.o scm.o
 
diff -Nru a/net/core/ethtool.c b/net/core/ethtool.c
--- a/net/core/ethtool.c	2004-06-08 14:27:33 -04:00
+++ b/net/core/ethtool.c	2004-06-08 14:27:33 -04:00
@@ -9,6 +9,7 @@
  * It's GPL, stupid.
  */
 
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/ethtool.h>
@@ -56,9 +57,26 @@
 	return 0;
 }
 
+#ifdef NETIF_F_TSO
+u32 ethtool_op_get_tso(struct net_device *dev)
+{
+	return (dev->features & NETIF_F_TSO) != 0;
+}
+
+int ethtool_op_set_tso(struct net_device *dev, u32 data)
+{
+	if (data)
+		dev->features |= NETIF_F_TSO;
+	else
+		dev->features &= ~NETIF_F_TSO;
+
+	return 0;
+}
+#endif /* NETIF_F_TSO */
+
 /* Handlers for each ethtool command */
 
-static int ethtool_get_settings(struct net_device *dev, void *useraddr)
+static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_cmd cmd = { ETHTOOL_GSET };
 	int err;
@@ -75,7 +93,7 @@
 	return 0;
 }
 
-static int ethtool_set_settings(struct net_device *dev, void *useraddr)
+static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_cmd cmd;
 
@@ -88,7 +106,7 @@
 	return dev->ethtool_ops->set_settings(dev, &cmd);
 }
 
-static int ethtool_get_drvinfo(struct net_device *dev, void *useraddr)
+static int ethtool_get_drvinfo(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_drvinfo info;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -114,7 +132,7 @@
 	return 0;
 }
 
-static int ethtool_get_regs(struct net_device *dev, char *useraddr)
+static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_regs regs;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -150,7 +168,7 @@
 	return ret;
 }
 
-static int ethtool_get_wol(struct net_device *dev, char *useraddr)
+static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_wolinfo wol = { ETHTOOL_GWOL };
 
@@ -164,7 +182,7 @@
 	return 0;
 }
 
-static int ethtool_set_wol(struct net_device *dev, char *useraddr)
+static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_wolinfo wol;
 
@@ -177,7 +195,7 @@
 	return dev->ethtool_ops->set_wol(dev, &wol);
 }
 
-static int ethtool_get_msglevel(struct net_device *dev, char *useraddr)
+static int ethtool_get_msglevel(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata = { ETHTOOL_GMSGLVL };
 
@@ -191,7 +209,7 @@
 	return 0;
 }
 
-static int ethtool_set_msglevel(struct net_device *dev, char *useraddr)
+static int ethtool_set_msglevel(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata;
 
@@ -213,7 +231,7 @@
 	return dev->ethtool_ops->nway_reset(dev);
 }
 
-static int ethtool_get_link(struct net_device *dev, void *useraddr)
+static int ethtool_get_link(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value edata = { ETHTOOL_GLINK };
 
@@ -227,7 +245,7 @@
 	return 0;
 }
 
-static int ethtool_get_eeprom(struct net_device *dev, void *useraddr)
+static int ethtool_get_eeprom(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_eeprom eeprom;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -272,7 +290,7 @@
 	return ret;
 }
 
-static int ethtool_set_eeprom(struct net_device *dev, void *useraddr)
+static int ethtool_set_eeprom(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_eeprom eeprom;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -313,7 +331,7 @@
 	return ret;
 }
 
-static int ethtool_get_coalesce(struct net_device *dev, void *useraddr)
+static int ethtool_get_coalesce(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_coalesce coalesce = { ETHTOOL_GCOALESCE };
 
@@ -327,7 +345,7 @@
 	return 0;
 }
 
-static int ethtool_set_coalesce(struct net_device *dev, void *useraddr)
+static int ethtool_set_coalesce(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_coalesce coalesce;
 
@@ -340,7 +358,7 @@
 	return dev->ethtool_ops->set_coalesce(dev, &coalesce);
 }
 
-static int ethtool_get_ringparam(struct net_device *dev, void *useraddr)
+static int ethtool_get_ringparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_ringparam ringparam = { ETHTOOL_GRINGPARAM };
 
@@ -354,7 +372,7 @@
 	return 0;
 }
 
-static int ethtool_set_ringparam(struct net_device *dev, void *useraddr)
+static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_ringparam ringparam;
 
@@ -367,7 +385,7 @@
 	return dev->ethtool_ops->set_ringparam(dev, &ringparam);
 }
 
-static int ethtool_get_pauseparam(struct net_device *dev, void *useraddr)
+static int ethtool_get_pauseparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_pauseparam pauseparam = { ETHTOOL_GPAUSEPARAM };
 
@@ -381,7 +399,7 @@
 	return 0;
 }
 
-static int ethtool_set_pauseparam(struct net_device *dev, void *useraddr)
+static int ethtool_set_pauseparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_pauseparam pauseparam;
 
@@ -394,7 +412,7 @@
 	return dev->ethtool_ops->set_pauseparam(dev, &pauseparam);
 }
 
-static int ethtool_get_rx_csum(struct net_device *dev, char *useraddr)
+static int ethtool_get_rx_csum(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata = { ETHTOOL_GRXCSUM };
 
@@ -408,7 +426,7 @@
 	return 0;
 }
 
-static int ethtool_set_rx_csum(struct net_device *dev, char *useraddr)
+static int ethtool_set_rx_csum(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata;
 
@@ -422,7 +440,7 @@
 	return 0;
 }
 
-static int ethtool_get_tx_csum(struct net_device *dev, char *useraddr)
+static int ethtool_get_tx_csum(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata = { ETHTOOL_GTXCSUM };
 
@@ -436,7 +454,7 @@
 	return 0;
 }
 
-static int ethtool_set_tx_csum(struct net_device *dev, char *useraddr)
+static int ethtool_set_tx_csum(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata;
 
@@ -449,7 +467,7 @@
 	return dev->ethtool_ops->set_tx_csum(dev, edata.data);
 }
 
-static int ethtool_get_sg(struct net_device *dev, char *useraddr)
+static int ethtool_get_sg(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata = { ETHTOOL_GSG };
 
@@ -463,7 +481,7 @@
 	return 0;
 }
 
-static int ethtool_set_sg(struct net_device *dev, char *useraddr)
+static int ethtool_set_sg(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata;
 
@@ -476,7 +494,39 @@
 	return dev->ethtool_ops->set_sg(dev, edata.data);
 }
 
-static int ethtool_self_test(struct net_device *dev, char *useraddr)
+#ifdef NETIF_F_TSO
+static int ethtool_get_tso(struct net_device *dev, char __user *useraddr)
+{
+	struct ethtool_value edata = { ETHTOOL_GTSO };
+
+	if (!dev->ethtool_ops->get_tso)
+		return -EOPNOTSUPP;
+
+	edata.data = dev->ethtool_ops->get_tso(dev);
+
+	if (copy_to_user(useraddr, &edata, sizeof(edata)))
+		return -EFAULT;
+	return 0;
+}
+
+static int ethtool_set_tso(struct net_device *dev, char __user *useraddr)
+{
+	struct ethtool_value edata;
+
+	if (!dev->ethtool_ops->set_tso)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&edata, useraddr, sizeof(edata)))
+		return -EFAULT;
+
+	return dev->ethtool_ops->set_tso(dev, edata.data);
+}
+
+EXPORT_SYMBOL(ethtool_op_get_tso);
+EXPORT_SYMBOL(ethtool_op_set_tso);
+#endif /* NETIF_F_TSO */
+
+static int ethtool_self_test(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_test test;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -509,7 +559,7 @@
 	return ret;
 }
 
-static int ethtool_get_strings(struct net_device *dev, void *useraddr)
+static int ethtool_get_strings(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_gstrings gstrings;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -556,7 +606,7 @@
 	return ret;
 }
 
-static int ethtool_phys_id(struct net_device *dev, void *useraddr)
+static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;
 
@@ -569,7 +619,7 @@
 	return dev->ethtool_ops->phys_id(dev, id.data);
 }
 
-static int ethtool_get_stats(struct net_device *dev, void *useraddr)
+static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_stats stats;
 	struct ethtool_ops *ops = dev->ethtool_ops;
@@ -607,8 +657,9 @@
 int dev_ethtool(struct ifreq *ifr)
 {
 	struct net_device *dev = __dev_get_by_name(ifr->ifr_name);
-	void *useraddr = (void *) ifr->ifr_data;
+	void __user *useraddr = ifr->ifr_data;
 	u32 ethcmd;
+	int rc;
 
 	/*
 	 * XXX: This can be pushed down into the ethtool_* handlers that
@@ -626,69 +677,121 @@
 	if (copy_from_user(&ethcmd, useraddr, sizeof (ethcmd)))
 		return -EFAULT;
 
+	if(dev->ethtool_ops->begin)
+		if ((rc = dev->ethtool_ops->begin(dev)) < 0)
+			return rc;
+
 	switch (ethcmd) {
 	case ETHTOOL_GSET:
-		return ethtool_get_settings(dev, useraddr);
+		rc = ethtool_get_settings(dev, useraddr);
+		break;
 	case ETHTOOL_SSET:
-		return ethtool_set_settings(dev, useraddr);
+		rc = ethtool_set_settings(dev, useraddr);
+		break;
 	case ETHTOOL_GDRVINFO:
-		return ethtool_get_drvinfo(dev, useraddr);
+		rc = ethtool_get_drvinfo(dev, useraddr);
+
+		break;
 	case ETHTOOL_GREGS:
-		return ethtool_get_regs(dev, useraddr);
+		rc = ethtool_get_regs(dev, useraddr);
+		break;
 	case ETHTOOL_GWOL:
-		return ethtool_get_wol(dev, useraddr);
+		rc = ethtool_get_wol(dev, useraddr);
+		break;
 	case ETHTOOL_SWOL:
-		return ethtool_set_wol(dev, useraddr);
+		rc = ethtool_set_wol(dev, useraddr);
+		break;
 	case ETHTOOL_GMSGLVL:
-		return ethtool_get_msglevel(dev, useraddr);
+		rc = ethtool_get_msglevel(dev, useraddr);
+		break;
 	case ETHTOOL_SMSGLVL:
-		return ethtool_set_msglevel(dev, useraddr);
+		rc = ethtool_set_msglevel(dev, useraddr);
+		break;
 	case ETHTOOL_NWAY_RST:
-		return ethtool_nway_reset(dev);
+		rc = ethtool_nway_reset(dev);
+		break;
 	case ETHTOOL_GLINK:
-		return ethtool_get_link(dev, useraddr);
+		rc = ethtool_get_link(dev, useraddr);
+		break;
 	case ETHTOOL_GEEPROM:
-		return ethtool_get_eeprom(dev, useraddr);
+		rc = ethtool_get_eeprom(dev, useraddr);
+		break;
 	case ETHTOOL_SEEPROM:
-		return ethtool_set_eeprom(dev, useraddr);
+		rc = ethtool_set_eeprom(dev, useraddr);
+		break;
 	case ETHTOOL_GCOALESCE:
-		return ethtool_get_coalesce(dev, useraddr);
+		rc = ethtool_get_coalesce(dev, useraddr);
+		break;
 	case ETHTOOL_SCOALESCE:
-		return ethtool_set_coalesce(dev, useraddr);
+		rc = ethtool_set_coalesce(dev, useraddr);
+		break;
 	case ETHTOOL_GRINGPARAM:
-		return ethtool_get_ringparam(dev, useraddr);
+		rc = ethtool_get_ringparam(dev, useraddr);
+		break;
 	case ETHTOOL_SRINGPARAM:
-		return ethtool_set_ringparam(dev, useraddr);
+		rc = ethtool_set_ringparam(dev, useraddr);
+		break;
 	case ETHTOOL_GPAUSEPARAM:
-		return ethtool_get_pauseparam(dev, useraddr);
+		rc = ethtool_get_pauseparam(dev, useraddr);
+		break;
 	case ETHTOOL_SPAUSEPARAM:
-		return ethtool_set_pauseparam(dev, useraddr);
+		rc = ethtool_set_pauseparam(dev, useraddr);
+		break;
 	case ETHTOOL_GRXCSUM:
-		return ethtool_get_rx_csum(dev, useraddr);
+		rc = ethtool_get_rx_csum(dev, useraddr);
+		break;
 	case ETHTOOL_SRXCSUM:
-		return ethtool_set_rx_csum(dev, useraddr);
+		rc = ethtool_set_rx_csum(dev, useraddr);
+		break;
 	case ETHTOOL_GTXCSUM:
-		return ethtool_get_tx_csum(dev, useraddr);
+		rc = ethtool_get_tx_csum(dev, useraddr);
+		break;
 	case ETHTOOL_STXCSUM:
-		return ethtool_set_tx_csum(dev, useraddr);
+		rc = ethtool_set_tx_csum(dev, useraddr);
+		break;
 	case ETHTOOL_GSG:
-		return ethtool_get_sg(dev, useraddr);
+		rc = ethtool_get_sg(dev, useraddr);
+		break;
 	case ETHTOOL_SSG:
-		return ethtool_set_sg(dev, useraddr);
+		rc = ethtool_set_sg(dev, useraddr);
+		break;
+#ifdef NETIF_F_TSO
+	case ETHTOOL_GTSO:
+		rc = ethtool_get_tso(dev, useraddr);
+		break;
+	case ETHTOOL_STSO:
+		rc = ethtool_set_tso(dev, useraddr);
+		break;
+#endif /* NETIF_F_TSO */
 	case ETHTOOL_TEST:
-		return ethtool_self_test(dev, useraddr);
+		rc = ethtool_self_test(dev, useraddr);
+		break;
 	case ETHTOOL_GSTRINGS:
-		return ethtool_get_strings(dev, useraddr);
+		rc = ethtool_get_strings(dev, useraddr);
+		break;
 	case ETHTOOL_PHYS_ID:
-		return ethtool_phys_id(dev, useraddr);
+		rc = ethtool_phys_id(dev, useraddr);
+		break;
 	case ETHTOOL_GSTATS:
-		return ethtool_get_stats(dev, useraddr);
+		rc = ethtool_get_stats(dev, useraddr);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		rc =  -EOPNOTSUPP;
 	}
+	
+	if(dev->ethtool_ops->complete)
+		dev->ethtool_ops->complete(dev);
+	return rc;
 
  ioctl:
 	if (dev->do_ioctl)
 		return dev->do_ioctl(dev, ifr, SIOCETHTOOL);
 	return -EOPNOTSUPP;
 }
+
+EXPORT_SYMBOL(dev_ethtool);
+EXPORT_SYMBOL(ethtool_op_get_link);
+EXPORT_SYMBOL(ethtool_op_get_sg);
+EXPORT_SYMBOL(ethtool_op_get_tx_csum);
+EXPORT_SYMBOL(ethtool_op_set_sg);
+EXPORT_SYMBOL(ethtool_op_set_tx_csum);
diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c	2004-06-08 14:27:33 -04:00
+++ b/net/netsyms.c	2004-06-08 14:27:33 -04:00
@@ -18,7 +18,6 @@
 #include <linux/fcdevice.h>
 #include <linux/ioport.h>
 #include <linux/tty.h>
-#include <linux/ethtool.h>
 #include <net/neighbour.h>
 #include <net/snmp.h>
 #include <net/dst.h>
@@ -621,12 +620,5 @@
 EXPORT_SYMBOL(iw_handler_get_thrspy);
 EXPORT_SYMBOL(wireless_spy_update);
 #endif /* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
-
-/* ethtool.c */
-EXPORT_SYMBOL(ethtool_op_get_link);
-EXPORT_SYMBOL(ethtool_op_get_tx_csum);
-EXPORT_SYMBOL(ethtool_op_set_tx_csum);
-EXPORT_SYMBOL(ethtool_op_get_sg);
-EXPORT_SYMBOL(ethtool_op_set_sg);
 
 #endif  /* CONFIG_NET */

--------------010305080009080309070609--
