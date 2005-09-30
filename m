Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVI3FTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVI3FTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVI3FTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:19:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36001 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932208AbVI3FTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:19:24 -0400
Date: Fri, 30 Sep 2005 06:19:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cassini ethtool conversion
Message-ID: <20050930051918.GG7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Note: patch is untested and thus not for merge until ACKed.
It's more or less mechanical conversion to ethtool_ops; please,
review.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/drivers/net/cassini.c current/drivers/net/cassini.c
--- RC14-rc2-git6-base/drivers/net/cassini.c	2005-09-29 22:19:05.000000000 -0400
+++ current/drivers/net/cassini.c	2005-09-30 01:14:26.000000000 -0400
@@ -4423,18 +4423,14 @@
 #define CAS_REG_LEN 	(sizeof(ethtool_register_table)/sizeof(int))
 #define CAS_MAX_REGS 	(sizeof (u32)*CAS_REG_LEN)
 
-static u8 *cas_get_regs(struct cas *cp)
+static void cas_read_regs(struct cas *cp, u8 *ptr, int len)
 {
-	u8 *ptr = kmalloc(CAS_MAX_REGS, GFP_KERNEL);
 	u8 *p;
 	int i;
 	unsigned long flags;
 
-	if (!ptr)
-		return NULL;
-
 	spin_lock_irqsave(&cp->lock, flags);
-	for (i = 0, p = ptr; i < CAS_REG_LEN ; i ++, p += sizeof(u32)) {
+	for (i = 0, p = ptr; i < len ; i ++, p += sizeof(u32)) {
 		u16 hval;
 		u32 val;
 		if (ethtool_register_table[i].offsets < 0) {
@@ -4447,8 +4443,6 @@
 		memcpy(p, (u8 *)&val, sizeof(u32));
 	}
 	spin_unlock_irqrestore(&cp->lock, flags);
-
-	return ptr;
 }
 
 static struct net_device_stats *cas_get_stats(struct net_device *dev)
@@ -4561,316 +4555,251 @@
 	spin_unlock_irqrestore(&cp->lock, flags);
 }
 
-/* Eventually add support for changing the advertisement
- * on autoneg.
- */
-static int cas_ethtool_ioctl(struct net_device *dev, void __user *ep_user)
+static void cas_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct cas *cp = netdev_priv(dev);
+	strncpy(info->driver, DRV_MODULE_NAME, ETHTOOL_BUSINFO_LEN);
+	strncpy(info->version, DRV_MODULE_VERSION, ETHTOOL_BUSINFO_LEN);
+	info->fw_version[0] = '\0';
+	strncpy(info->bus_info, pci_name(cp->pdev), ETHTOOL_BUSINFO_LEN);
+	info->regdump_len = cp->casreg_len < CAS_MAX_REGS ?
+		cp->casreg_len : CAS_MAX_REGS;
+	info->n_stats = CAS_NUM_STAT_KEYS;
+}
+
+static int cas_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct cas *cp = netdev_priv(dev);
 	u16 bmcr;
 	int full_duplex, speed, pause;
-	struct ethtool_cmd ecmd;
 	unsigned long flags;
 	enum link_state linkstate = link_up;
 
-	if (copy_from_user(&ecmd, ep_user, sizeof(ecmd)))
-		return -EFAULT;
-		
-	switch(ecmd.cmd) {
-        case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = { .cmd = ETHTOOL_GDRVINFO };
-
-		strncpy(info.driver, DRV_MODULE_NAME,
-			ETHTOOL_BUSINFO_LEN);
-		strncpy(info.version, DRV_MODULE_VERSION,
-			ETHTOOL_BUSINFO_LEN);
-		info.fw_version[0] = '\0';
-		strncpy(info.bus_info, pci_name(cp->pdev),
-			ETHTOOL_BUSINFO_LEN);
-		info.regdump_len = cp->casreg_len < CAS_MAX_REGS ?
-			cp->casreg_len : CAS_MAX_REGS;
-		info.n_stats = CAS_NUM_STAT_KEYS;
-		if (copy_to_user(ep_user, &info, sizeof(info)))
-			return -EFAULT;
-
-		return 0;
-	}
-
-	case ETHTOOL_GSET:
-		ecmd.advertising = 0;
-		ecmd.supported = SUPPORTED_Autoneg;
-		if (cp->cas_flags & CAS_FLAG_1000MB_CAP) {
-			ecmd.supported |= SUPPORTED_1000baseT_Full;
-			ecmd.advertising |= ADVERTISED_1000baseT_Full;
-		}
+	cmd->advertising = 0;
+	cmd->supported = SUPPORTED_Autoneg;
+	if (cp->cas_flags & CAS_FLAG_1000MB_CAP) {
+		cmd->supported |= SUPPORTED_1000baseT_Full;
+		cmd->advertising |= ADVERTISED_1000baseT_Full;
+	}
 
-		/* Record PHY settings if HW is on. */
-		spin_lock_irqsave(&cp->lock, flags);
-		bmcr = 0;
-		linkstate = cp->lstate;
-		if (CAS_PHY_MII(cp->phy_type)) {
-			ecmd.port = PORT_MII;
-			ecmd.transceiver = (cp->cas_flags & CAS_FLAG_SATURN) ?
-				XCVR_INTERNAL : XCVR_EXTERNAL;
-			ecmd.phy_address = cp->phy_addr;
-			ecmd.advertising |= ADVERTISED_TP | ADVERTISED_MII |
-				ADVERTISED_10baseT_Half | 
-				ADVERTISED_10baseT_Full | 
-				ADVERTISED_100baseT_Half | 
-				ADVERTISED_100baseT_Full;
-
-			ecmd.supported |=
-				(SUPPORTED_10baseT_Half | 
-				 SUPPORTED_10baseT_Full |
-				 SUPPORTED_100baseT_Half | 
-				 SUPPORTED_100baseT_Full |
-				 SUPPORTED_TP | SUPPORTED_MII);
-
-			if (cp->hw_running) {
-				cas_mif_poll(cp, 0);
-				bmcr = cas_phy_read(cp, MII_BMCR);
-				cas_read_mii_link_mode(cp, &full_duplex, 
-						       &speed, &pause);
-				cas_mif_poll(cp, 1);
-			}
+	/* Record PHY settings if HW is on. */
+	spin_lock_irqsave(&cp->lock, flags);
+	bmcr = 0;
+	linkstate = cp->lstate;
+	if (CAS_PHY_MII(cp->phy_type)) {
+		cmd->port = PORT_MII;
+		cmd->transceiver = (cp->cas_flags & CAS_FLAG_SATURN) ?
+			XCVR_INTERNAL : XCVR_EXTERNAL;
+		cmd->phy_address = cp->phy_addr;
+		cmd->advertising |= ADVERTISED_TP | ADVERTISED_MII |
+			ADVERTISED_10baseT_Half | 
+			ADVERTISED_10baseT_Full | 
+			ADVERTISED_100baseT_Half | 
+			ADVERTISED_100baseT_Full;
+
+		cmd->supported |=
+			(SUPPORTED_10baseT_Half | 
+			 SUPPORTED_10baseT_Full |
+			 SUPPORTED_100baseT_Half | 
+			 SUPPORTED_100baseT_Full |
+			 SUPPORTED_TP | SUPPORTED_MII);
+
+		if (cp->hw_running) {
+			cas_mif_poll(cp, 0);
+			bmcr = cas_phy_read(cp, MII_BMCR);
+			cas_read_mii_link_mode(cp, &full_duplex, 
+					       &speed, &pause);
+			cas_mif_poll(cp, 1);
+		}
 
-		} else {
-			ecmd.port = PORT_FIBRE;
-			ecmd.transceiver = XCVR_INTERNAL;
-			ecmd.phy_address = 0;
-			ecmd.supported   |= SUPPORTED_FIBRE;
-			ecmd.advertising |= ADVERTISED_FIBRE;
-
-			if (cp->hw_running) {
-				/* pcs uses the same bits as mii */ 
-				bmcr = readl(cp->regs + REG_PCS_MII_CTRL);
-				cas_read_pcs_link_mode(cp, &full_duplex, 
-						       &speed, &pause);
-			}
+	} else {
+		cmd->port = PORT_FIBRE;
+		cmd->transceiver = XCVR_INTERNAL;
+		cmd->phy_address = 0;
+		cmd->supported   |= SUPPORTED_FIBRE;
+		cmd->advertising |= ADVERTISED_FIBRE;
+
+		if (cp->hw_running) {
+			/* pcs uses the same bits as mii */ 
+			bmcr = readl(cp->regs + REG_PCS_MII_CTRL);
+			cas_read_pcs_link_mode(cp, &full_duplex, 
+					       &speed, &pause);
 		}
-		spin_unlock_irqrestore(&cp->lock, flags);
+	}
+	spin_unlock_irqrestore(&cp->lock, flags);
 
-		if (bmcr & BMCR_ANENABLE) {
-			ecmd.advertising |= ADVERTISED_Autoneg;
-			ecmd.autoneg = AUTONEG_ENABLE;
-			ecmd.speed = ((speed == 10) ?
-				      SPEED_10 :
-				      ((speed == 1000) ?
-				       SPEED_1000 : SPEED_100));
-			ecmd.duplex = full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
+	if (bmcr & BMCR_ANENABLE) {
+		cmd->advertising |= ADVERTISED_Autoneg;
+		cmd->autoneg = AUTONEG_ENABLE;
+		cmd->speed = ((speed == 10) ?
+			      SPEED_10 :
+			      ((speed == 1000) ?
+			       SPEED_1000 : SPEED_100));
+		cmd->duplex = full_duplex ? DUPLEX_FULL : DUPLEX_HALF;
+	} else {
+		cmd->autoneg = AUTONEG_DISABLE;
+		cmd->speed =
+			(bmcr & CAS_BMCR_SPEED1000) ?
+			SPEED_1000 : 
+			((bmcr & BMCR_SPEED100) ? SPEED_100: 
+			 SPEED_10);
+		cmd->duplex =
+			(bmcr & BMCR_FULLDPLX) ?
+			DUPLEX_FULL : DUPLEX_HALF;
+	}
+	if (linkstate != link_up) {
+		/* Force these to "unknown" if the link is not up and
+		 * autonogotiation in enabled. We can set the link 
+		 * speed to 0, but not cmd->duplex,
+		 * because its legal values are 0 and 1.  Ethtool will
+		 * print the value reported in parentheses after the
+		 * word "Unknown" for unrecognized values.
+		 *
+		 * If in forced mode, we report the speed and duplex
+		 * settings that we configured.
+		 */
+		if (cp->link_cntl & BMCR_ANENABLE) {
+			cmd->speed = 0;
+			cmd->duplex = 0xff;
 		} else {
-			ecmd.autoneg = AUTONEG_DISABLE;
-			ecmd.speed =
-				(bmcr & CAS_BMCR_SPEED1000) ?
-				SPEED_1000 : 
-				((bmcr & BMCR_SPEED100) ? SPEED_100: 
-				 SPEED_10);
-			ecmd.duplex =
-				(bmcr & BMCR_FULLDPLX) ?
-				DUPLEX_FULL : DUPLEX_HALF;
-		}
-		if (linkstate != link_up) {
-			/* Force these to "unknown" if the link is not up and
-			 * autonogotiation in enabled. We can set the link 
-			 * speed to 0, but not ecmd.duplex,
-			 * because its legal values are 0 and 1.  Ethtool will
-			 * print the value reported in parentheses after the
-			 * word "Unknown" for unrecognized values.
-			 *
-			 * If in forced mode, we report the speed and duplex
-			 * settings that we configured.
-			 */
-			if (cp->link_cntl & BMCR_ANENABLE) {
-				ecmd.speed = 0;
-				ecmd.duplex = 0xff;
-			} else {
-				ecmd.speed = SPEED_10;
-				if (cp->link_cntl & BMCR_SPEED100) {
-					ecmd.speed = SPEED_100;
-				} else if (cp->link_cntl & CAS_BMCR_SPEED1000) {
-					ecmd.speed = SPEED_1000;
-				}
-				ecmd.duplex = (cp->link_cntl & BMCR_FULLDPLX)?
-					DUPLEX_FULL : DUPLEX_HALF;
+			cmd->speed = SPEED_10;
+			if (cp->link_cntl & BMCR_SPEED100) {
+				cmd->speed = SPEED_100;
+			} else if (cp->link_cntl & CAS_BMCR_SPEED1000) {
+				cmd->speed = SPEED_1000;
 			}
+			cmd->duplex = (cp->link_cntl & BMCR_FULLDPLX)?
+				DUPLEX_FULL : DUPLEX_HALF;
 		}
-		if (copy_to_user(ep_user, &ecmd, sizeof(ecmd)))
-			return -EFAULT;
-		return 0;
-
-	case ETHTOOL_SSET:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-
-		/* Verify the settings we care about. */
-		if (ecmd.autoneg != AUTONEG_ENABLE &&
-		    ecmd.autoneg != AUTONEG_DISABLE)
-			return -EINVAL;
-
-		if (ecmd.autoneg == AUTONEG_DISABLE &&
-		    ((ecmd.speed != SPEED_1000 &&
-		      ecmd.speed != SPEED_100 &&
-		      ecmd.speed != SPEED_10) ||
-		     (ecmd.duplex != DUPLEX_HALF &&
-		      ecmd.duplex != DUPLEX_FULL)))
-			return -EINVAL;
+	}
+	return 0;
+}
 
-		/* Apply settings and restart link process. */
-		spin_lock_irqsave(&cp->lock, flags);
-		cas_begin_auto_negotiation(cp, &ecmd);
-		spin_unlock_irqrestore(&cp->lock, flags);
-		return 0;
+static int cas_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct cas *cp = netdev_priv(dev);
+	unsigned long flags;
 
-	case ETHTOOL_NWAY_RST:
-		if ((cp->link_cntl & BMCR_ANENABLE) == 0)
-			return -EINVAL;
+	/* Verify the settings we care about. */
+	if (cmd->autoneg != AUTONEG_ENABLE &&
+	    cmd->autoneg != AUTONEG_DISABLE)
+		return -EINVAL;
+
+	if (cmd->autoneg == AUTONEG_DISABLE &&
+	    ((cmd->speed != SPEED_1000 &&
+	      cmd->speed != SPEED_100 &&
+	      cmd->speed != SPEED_10) ||
+	     (cmd->duplex != DUPLEX_HALF &&
+	      cmd->duplex != DUPLEX_FULL)))
+		return -EINVAL;
 
-		/* Restart link process. */
-		spin_lock_irqsave(&cp->lock, flags);
-		cas_begin_auto_negotiation(cp, NULL);
-		spin_unlock_irqrestore(&cp->lock, flags);
+	/* Apply settings and restart link process. */
+	spin_lock_irqsave(&cp->lock, flags);
+	cas_begin_auto_negotiation(cp, cmd);
+	spin_unlock_irqrestore(&cp->lock, flags);
+	return 0;
+}
+
+static int cas_nway_reset(struct net_device *dev)
+{
+	struct cas *cp = netdev_priv(dev);
+	unsigned long flags;
 
-		return 0;
+	if ((cp->link_cntl & BMCR_ANENABLE) == 0)
+		return -EINVAL;
 
-	case ETHTOOL_GWOL:
-	case ETHTOOL_SWOL:
-		break; /* doesn't exist */
+	/* Restart link process. */
+	spin_lock_irqsave(&cp->lock, flags);
+	cas_begin_auto_negotiation(cp, NULL);
+	spin_unlock_irqrestore(&cp->lock, flags);
 
-	/* get link status */
-	case ETHTOOL_GLINK: {
-		struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
+	return 0;
+}
 
-		edata.data = (cp->lstate == link_up);
-		if (copy_to_user(ep_user, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-	}
+static u32 cas_get_link(struct net_device *dev)
+{
+	struct cas *cp = netdev_priv(dev);
+	return cp->lstate == link_up;
+}
 
-	/* get message-level */
-	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = { .cmd = ETHTOOL_GMSGLVL };
+static u32 cas_get_msglevel(struct net_device *dev)
+{
+	struct cas *cp = netdev_priv(dev);
+	return cp->msg_enable;
+}
 
-		edata.data = cp->msg_enable;
-		if (copy_to_user(ep_user, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-	}
+static void cas_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct cas *cp = netdev_priv(dev);
+	cp->msg_enable = value;
+}
 
-	/* set message-level */
-	case ETHTOOL_SMSGLVL: {
-		struct ethtool_value edata;
+static int cas_get_regs_len(struct net_device *dev)
+{
+	struct cas *cp = netdev_priv(dev);
+	return cp->casreg_len < CAS_MAX_REGS ? cp->casreg_len: CAS_MAX_REGS;
+}
 
-		if (!capable(CAP_NET_ADMIN)) {
-			return (-EPERM);
-		}
-		if (copy_from_user(&edata, ep_user, sizeof(edata)))
-			return -EFAULT;
-		cp->msg_enable = edata.data;
-		return 0;
-	}
-
-	case ETHTOOL_GREGS: {
-		struct ethtool_regs edata;
-		u8 *ptr;
-		int len = cp->casreg_len < CAS_MAX_REGS ?
-			cp->casreg_len: CAS_MAX_REGS;
-
-		if (copy_from_user(&edata, ep_user, sizeof (edata)))
-			return -EFAULT;
-
-		if (edata.len > len)
-			edata.len = len;
-		edata.version = 0;
-		if (copy_to_user (ep_user, &edata, sizeof(edata)))
-			return -EFAULT;
-
-		/* cas_get_regs handles locks (cp->lock).  */
-		ptr = cas_get_regs(cp);
-		if (ptr == NULL)
-			return -ENOMEM;
-		if (copy_to_user(ep_user + sizeof (edata), ptr, edata.len))
-			return -EFAULT;
-
-		kfree(ptr);
-		return (0);
-	}
-	case ETHTOOL_GSTRINGS: {
-		struct ethtool_gstrings edata;
-		int len;
-
-		if (copy_from_user(&edata, ep_user, sizeof(edata)))
-			return -EFAULT;
-
-		len = edata.len;
-		switch(edata.string_set) {
-		case ETH_SS_STATS:
-			edata.len = (len < CAS_NUM_STAT_KEYS) ?
-				len : CAS_NUM_STAT_KEYS;
-			if (copy_to_user(ep_user, &edata, sizeof(edata)))
-				return -EFAULT;
-
-			if (copy_to_user(ep_user + sizeof(edata),
-					 &ethtool_cassini_statnames, 
-					 (edata.len * ETH_GSTRING_LEN)))
-				return -EFAULT;
-			return 0;
-		default:
-			return -EINVAL;
-		}
-	}
-	case ETHTOOL_GSTATS: {
-		int i = 0;
-		u64 *tmp;
-		struct ethtool_stats edata;
-		struct net_device_stats *stats;
-		int len;
-
-		if (copy_from_user(&edata, ep_user, sizeof(edata)))
-			return -EFAULT;
-
-		len = edata.n_stats;
-		stats = cas_get_stats(cp->dev);
-		edata.cmd = ETHTOOL_GSTATS;
-		edata.n_stats = (len < CAS_NUM_STAT_KEYS) ?
-			len : CAS_NUM_STAT_KEYS;
-		if (copy_to_user(ep_user, &edata, sizeof (edata)))
-			return -EFAULT;
-
-		tmp = kmalloc(sizeof(u64)*CAS_NUM_STAT_KEYS, GFP_KERNEL);
-		if (tmp) {
-			tmp[i++] = stats->collisions;
-			tmp[i++] = stats->rx_bytes;
-			tmp[i++] = stats->rx_crc_errors;
-			tmp[i++] = stats->rx_dropped;
-			tmp[i++] = stats->rx_errors;
-			tmp[i++] = stats->rx_fifo_errors;
-			tmp[i++] = stats->rx_frame_errors;
-			tmp[i++] = stats->rx_length_errors;
-			tmp[i++] = stats->rx_over_errors;
-			tmp[i++] = stats->rx_packets;
-			tmp[i++] = stats->tx_aborted_errors;
-			tmp[i++] = stats->tx_bytes;
-			tmp[i++] = stats->tx_dropped;
-			tmp[i++] = stats->tx_errors;
-			tmp[i++] = stats->tx_fifo_errors;
-			tmp[i++] = stats->tx_packets;
-			BUG_ON(i != CAS_NUM_STAT_KEYS);
-
-			i = copy_to_user(ep_user + sizeof(edata),
-					 tmp, sizeof(u64)*edata.n_stats);
-			kfree(tmp);
-		} else {
-			return -ENOMEM;
-		}
-		if (i)
-			return -EFAULT;
-		return 0;
-	}
-	}
+static void cas_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+			     void *p)
+{
+	struct cas *cp = netdev_priv(dev);
+	regs->version = 0;
+	/* cas_read_regs handles locks (cp->lock).  */
+	cas_read_regs(cp, p, regs->len / sizeof(u32));
+}
 
-	return -EOPNOTSUPP;
+static int cas_get_stats_count(struct net_device *dev)
+{
+	return CAS_NUM_STAT_KEYS;
 }
 
+static void cas_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	 memcpy(data, &ethtool_cassini_statnames, 
+					 CAS_NUM_STAT_KEYS * ETH_GSTRING_LEN);
+}
+
+static void cas_get_ethtool_stats(struct net_device *dev,
+				      struct ethtool_stats *estats, u64 *data)
+{
+	struct cas *cp = netdev_priv(dev);
+	struct net_device_stats *stats = cas_get_stats(cp->dev);
+	int i = 0;
+	data[i++] = stats->collisions;
+	data[i++] = stats->rx_bytes;
+	data[i++] = stats->rx_crc_errors;
+	data[i++] = stats->rx_dropped;
+	data[i++] = stats->rx_errors;
+	data[i++] = stats->rx_fifo_errors;
+	data[i++] = stats->rx_frame_errors;
+	data[i++] = stats->rx_length_errors;
+	data[i++] = stats->rx_over_errors;
+	data[i++] = stats->rx_packets;
+	data[i++] = stats->tx_aborted_errors;
+	data[i++] = stats->tx_bytes;
+	data[i++] = stats->tx_dropped;
+	data[i++] = stats->tx_errors;
+	data[i++] = stats->tx_fifo_errors;
+	data[i++] = stats->tx_packets;
+	BUG_ON(i != CAS_NUM_STAT_KEYS);
+}
+
+static struct ethtool_ops cas_ethtool_ops = {
+	.get_drvinfo		= cas_get_drvinfo,
+	.get_settings		= cas_get_settings,
+	.set_settings		= cas_set_settings,
+	.nway_reset		= cas_nway_reset,
+	.get_link		= cas_get_link,
+	.get_msglevel		= cas_get_msglevel,
+	.set_msglevel		= cas_set_msglevel,
+	.get_regs_len		= cas_get_regs_len,
+	.get_regs		= cas_get_regs,
+	.get_stats_count	= cas_get_stats_count,
+	.get_strings		= cas_get_strings,
+	.get_ethtool_stats	= cas_get_ethtool_stats,
+};
+
 static int cas_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct cas *cp = netdev_priv(dev);
@@ -4883,10 +4812,6 @@
 	 */
 	down(&cp->pm_sem);
 	switch (cmd) {
-	case SIOCETHTOOL:
-		rc = cas_ethtool_ioctl(dev, ifr->ifr_data);
-		break;
-
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
 		data->phy_id = cp->phy_addr;
 		/* Fallthrough... */
@@ -5112,6 +5037,7 @@
 	dev->get_stats = cas_get_stats;
 	dev->set_multicast_list = cas_set_multicast;
 	dev->do_ioctl = cas_ioctl;
+	dev->ethtool_ops = &cas_ethtool_ops;
 	dev->tx_timeout = cas_tx_timeout;
 	dev->watchdog_timeo = CAS_TX_TIMEOUT;
 	dev->change_mtu = cas_change_mtu;
