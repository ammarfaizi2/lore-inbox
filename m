Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUFGPul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUFGPul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:50:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264767AbUFGPuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:50:32 -0400
Date: Mon, 7 Jun 2004 11:50:18 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: PATCH: ethtool power manglement hooks
Message-ID: <20040607155018.GA5810@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several ethernet drivers have been broken by the ethtool support because
the ioctl code used to power the interface up and down as needed. Rather
than add this to each driver call Jeff Garzik suggested we add hooks
for before/after ethtool processing.

This patch implements them which makes fixing the PM stuff easier,
as the epic100 patch to follow will show. It also cleans up the 
via-velocity driver pm/ethtool logic a great deal. As per Jeff's
request the before handler is allowed to fail the operation.

--

The contribution herein included is a creation of Red Hat Inc. It is hereby
submitted under the license of the existing files and as a derivative work
thereof. I know of no reason for not having the right to submit the
work herein included.

(Bluff your way in legalese ;))

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/include/linux/ethtool.h linux-2.6.6/include/linux/ethtool.h
--- linux.vanilla-2.6.6/include/linux/ethtool.h	2004-05-10 03:32:26.000000000 +0100
+++ linux-2.6.6/include/linux/ethtool.h	2004-06-02 22:53:29.000000000 +0100
@@ -351,6 +351,8 @@
 	int	(*phys_id)(struct net_device *, u32);
 	int	(*get_stats_count)(struct net_device *);
 	void	(*get_ethtool_stats)(struct net_device *, struct ethtool_stats *, u64 *);
+	int	(*begin)(struct net_device *);
+	void	(*complete)(struct net_device *);
 };
 
 /* CMDs currently supported */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/net/core/ethtool.c linux-2.6.6/net/core/ethtool.c
--- linux.vanilla-2.6.6/net/core/ethtool.c	2004-05-10 03:32:26.000000000 +0100
+++ linux-2.6.6/net/core/ethtool.c	2004-06-02 22:54:28.000000000 +0100
@@ -652,6 +652,7 @@
 	struct net_device *dev = __dev_get_by_name(ifr->ifr_name);
 	void __user *useraddr = (void __user *) ifr->ifr_data;
 	u32 ethcmd;
+	int rc;
 
 	/*
 	 * XXX: This can be pushed down into the ethtool_* handlers that
@@ -669,70 +670,109 @@
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
 	case ETHTOOL_GTSO:
-		return ethtool_get_tso(dev, useraddr);
+		rc = ethtool_get_tso(dev, useraddr);
+		break;
 	case ETHTOOL_STSO:
-		return ethtool_set_tso(dev, useraddr);
+		rc = ethtool_set_tso(dev, useraddr);
+		break;
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
