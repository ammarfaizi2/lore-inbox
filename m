Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEDUUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEDUUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUEDUUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:20:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3815 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbUEDUTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:19:54 -0400
Message-ID: <4097FADB.4090105@pobox.com>
Date: Tue, 04 May 2004 16:19:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Pekka Pietikainen <pp@netppl.fi>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] b44 ethtool_ops
Content-Type: multipart/mixed;
 boundary="------------060008060903080904020905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008060903080904020905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Testing requested.

Should see no ethtool behavior change, positive or negative.

--------------060008060903080904020905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/04 16:17:04-04:00 jgarzik@redhat.com 
#   [netdrvr b44] ethtool_ops support
# 
# drivers/net/b44.c
#   2004/05/04 16:14:38-04:00 jgarzik@redhat.com +195 -210
#   [netdrvr b44] ethtool_ops support
# 
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	Tue May  4 16:18:27 2004
+++ b/drivers/net/b44.c	Tue May  4 16:18:27 2004
@@ -27,8 +27,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.93"
-#define DRV_MODULE_RELDATE	"Mar, 2004"
+#define DRV_MODULE_VERSION	"0.94"
+#define DRV_MODULE_RELDATE	"May 4, 2004"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -1382,247 +1382,234 @@
 	spin_unlock_irq(&bp->lock);
 }
 
-static int b44_ethtool_ioctl (struct net_device *dev, void __user *useraddr)
+static u32 b44_get_msglevel(struct net_device *dev)
 {
-	struct b44 *bp = dev->priv;
-	struct pci_dev *pci_dev = bp->pdev;
-	u32 ethcmd;
+	struct b44 *bp = netdev_priv(dev);
+	return bp->msg_enable;
+}
 
-	if (copy_from_user (&ethcmd, useraddr, sizeof (ethcmd)))
-		return -EFAULT;
+static void b44_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct b44 *bp = netdev_priv(dev);
+	bp->msg_enable = value;
+}
 
-	switch (ethcmd) {
-	case ETHTOOL_GDRVINFO:{
-		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
-		strcpy (info.driver, DRV_MODULE_NAME);
-		strcpy (info.version, DRV_MODULE_VERSION);
-		memset(&info.fw_version, 0, sizeof(info.fw_version));
-		strcpy (info.bus_info, pci_name(pci_dev));
-		info.eedump_len = 0;
-		info.regdump_len = 0;
-		if (copy_to_user (useraddr, &info, sizeof (info)))
-			return -EFAULT;
-		return 0;
-	}
+static void b44_get_drvinfo (struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	struct b44 *bp = netdev_priv(dev);
+	struct pci_dev *pci_dev = bp->pdev;
 
-	case ETHTOOL_GSET: {
-		struct ethtool_cmd cmd = { ETHTOOL_GSET };
+	strcpy (info->driver, DRV_MODULE_NAME);
+	strcpy (info->version, DRV_MODULE_VERSION);
+	strcpy (info->bus_info, pci_name(pci_dev));
+}
 
-		if (!(bp->flags & B44_FLAG_INIT_COMPLETE))
-			return -EAGAIN;
-		cmd.supported = (SUPPORTED_Autoneg);
-		cmd.supported |= (SUPPORTED_100baseT_Half |
-				  SUPPORTED_100baseT_Full |
-				  SUPPORTED_10baseT_Half |
-				  SUPPORTED_10baseT_Full |
-				  SUPPORTED_MII);
+static int b44_nway_reset(struct net_device *dev)
+{
+	struct b44 *bp = netdev_priv(dev);
+	u32 bmcr;
+	int r;
 
-		cmd.advertising = 0;
-		if (bp->flags & B44_FLAG_ADV_10HALF)
-			cmd.advertising |= ADVERTISE_10HALF;
-		if (bp->flags & B44_FLAG_ADV_10FULL)
-			cmd.advertising |= ADVERTISE_10FULL;
-		if (bp->flags & B44_FLAG_ADV_100HALF)
-			cmd.advertising |= ADVERTISE_100HALF;
-		if (bp->flags & B44_FLAG_ADV_100FULL)
-			cmd.advertising |= ADVERTISE_100FULL;
-		cmd.advertising |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
-		cmd.speed = (bp->flags & B44_FLAG_100_BASE_T) ?
-			SPEED_100 : SPEED_10;
-		cmd.duplex = (bp->flags & B44_FLAG_FULL_DUPLEX) ?
-			DUPLEX_FULL : DUPLEX_HALF;
-		cmd.port = 0;
-		cmd.phy_address = bp->phy_addr;
-		cmd.transceiver = (bp->flags & B44_FLAG_INTERNAL_PHY) ?
-			XCVR_INTERNAL : XCVR_EXTERNAL;
-		cmd.autoneg = (bp->flags & B44_FLAG_FORCE_LINK) ?
-			AUTONEG_DISABLE : AUTONEG_ENABLE;
-		cmd.maxtxpkt = 0;
-		cmd.maxrxpkt = 0;
-		if (copy_to_user(useraddr, &cmd, sizeof(cmd)))
-			return -EFAULT;
-		return 0;
+	spin_lock_irq(&bp->lock);
+	b44_readphy(bp, MII_BMCR, &bmcr);
+	b44_readphy(bp, MII_BMCR, &bmcr);
+	r = -EINVAL;
+	if (bmcr & BMCR_ANENABLE) {
+		b44_writephy(bp, MII_BMCR,
+			     bmcr | BMCR_ANRESTART);
+		r = 0;
 	}
-	case ETHTOOL_SSET: {
-		struct ethtool_cmd cmd;
+	spin_unlock_irq(&bp->lock);
 
-		if (!(bp->flags & B44_FLAG_INIT_COMPLETE))
-			return -EAGAIN;
+	return r;
+}
 
-		if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
-			return -EFAULT;
+static int b44_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		/* We do not support gigabit. */
-		if (cmd.autoneg == AUTONEG_ENABLE) {
-			if (cmd.advertising &
-			    (ADVERTISED_1000baseT_Half |
-			     ADVERTISED_1000baseT_Full))
-				return -EINVAL;
-		} else if ((cmd.speed != SPEED_100 &&
-			    cmd.speed != SPEED_10) ||
-			   (cmd.duplex != DUPLEX_HALF &&
-			    cmd.duplex != DUPLEX_FULL)) {
-				return -EINVAL;
-		}
+	if (!(bp->flags & B44_FLAG_INIT_COMPLETE))
+		return -EAGAIN;
+	cmd->supported = (SUPPORTED_Autoneg);
+	cmd->supported |= (SUPPORTED_100baseT_Half |
+			  SUPPORTED_100baseT_Full |
+			  SUPPORTED_10baseT_Half |
+			  SUPPORTED_10baseT_Full |
+			  SUPPORTED_MII);
+
+	cmd->advertising = 0;
+	if (bp->flags & B44_FLAG_ADV_10HALF)
+		cmd->advertising |= ADVERTISE_10HALF;
+	if (bp->flags & B44_FLAG_ADV_10FULL)
+		cmd->advertising |= ADVERTISE_10FULL;
+	if (bp->flags & B44_FLAG_ADV_100HALF)
+		cmd->advertising |= ADVERTISE_100HALF;
+	if (bp->flags & B44_FLAG_ADV_100FULL)
+		cmd->advertising |= ADVERTISE_100FULL;
+	cmd->advertising |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+	cmd->speed = (bp->flags & B44_FLAG_100_BASE_T) ?
+		SPEED_100 : SPEED_10;
+	cmd->duplex = (bp->flags & B44_FLAG_FULL_DUPLEX) ?
+		DUPLEX_FULL : DUPLEX_HALF;
+	cmd->port = 0;
+	cmd->phy_address = bp->phy_addr;
+	cmd->transceiver = (bp->flags & B44_FLAG_INTERNAL_PHY) ?
+		XCVR_INTERNAL : XCVR_EXTERNAL;
+	cmd->autoneg = (bp->flags & B44_FLAG_FORCE_LINK) ?
+		AUTONEG_DISABLE : AUTONEG_ENABLE;
+	cmd->maxtxpkt = 0;
+	cmd->maxrxpkt = 0;
+	return 0;
+}
 
-		spin_lock_irq(&bp->lock);
+static int b44_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		if (cmd.autoneg == AUTONEG_ENABLE) {
-			bp->flags &= ~B44_FLAG_FORCE_LINK;
-			bp->flags &= ~(B44_FLAG_ADV_10HALF |
-				       B44_FLAG_ADV_10FULL |
-				       B44_FLAG_ADV_100HALF |
-				       B44_FLAG_ADV_100FULL);
-			if (cmd.advertising & ADVERTISE_10HALF)
-				bp->flags |= B44_FLAG_ADV_10HALF;
-			if (cmd.advertising & ADVERTISE_10FULL)
-				bp->flags |= B44_FLAG_ADV_10FULL;
-			if (cmd.advertising & ADVERTISE_100HALF)
-				bp->flags |= B44_FLAG_ADV_100HALF;
-			if (cmd.advertising & ADVERTISE_100FULL)
-				bp->flags |= B44_FLAG_ADV_100FULL;
-		} else {
-			bp->flags |= B44_FLAG_FORCE_LINK;
-			if (cmd.speed == SPEED_100)
-				bp->flags |= B44_FLAG_100_BASE_T;
-			if (cmd.duplex == DUPLEX_FULL)
-				bp->flags |= B44_FLAG_FULL_DUPLEX;
-		}
+	if (!(bp->flags & B44_FLAG_INIT_COMPLETE))
+		return -EAGAIN;
 
-		b44_setup_phy(bp);
+	/* We do not support gigabit. */
+	if (cmd->autoneg == AUTONEG_ENABLE) {
+		if (cmd->advertising &
+		    (ADVERTISED_1000baseT_Half |
+		     ADVERTISED_1000baseT_Full))
+			return -EINVAL;
+	} else if ((cmd->speed != SPEED_100 &&
+		    cmd->speed != SPEED_10) ||
+		   (cmd->duplex != DUPLEX_HALF &&
+		    cmd->duplex != DUPLEX_FULL)) {
+			return -EINVAL;
+	}
 
-		spin_unlock_irq(&bp->lock);
+	spin_lock_irq(&bp->lock);
 
-		return 0;
+	if (cmd->autoneg == AUTONEG_ENABLE) {
+		bp->flags &= ~B44_FLAG_FORCE_LINK;
+		bp->flags &= ~(B44_FLAG_ADV_10HALF |
+			       B44_FLAG_ADV_10FULL |
+			       B44_FLAG_ADV_100HALF |
+			       B44_FLAG_ADV_100FULL);
+		if (cmd->advertising & ADVERTISE_10HALF)
+			bp->flags |= B44_FLAG_ADV_10HALF;
+		if (cmd->advertising & ADVERTISE_10FULL)
+			bp->flags |= B44_FLAG_ADV_10FULL;
+		if (cmd->advertising & ADVERTISE_100HALF)
+			bp->flags |= B44_FLAG_ADV_100HALF;
+		if (cmd->advertising & ADVERTISE_100FULL)
+			bp->flags |= B44_FLAG_ADV_100FULL;
+	} else {
+		bp->flags |= B44_FLAG_FORCE_LINK;
+		if (cmd->speed == SPEED_100)
+			bp->flags |= B44_FLAG_100_BASE_T;
+		if (cmd->duplex == DUPLEX_FULL)
+			bp->flags |= B44_FLAG_FULL_DUPLEX;
 	}
 
-	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = { ETHTOOL_GMSGLVL };
-		edata.data = bp->msg_enable;
-		if (copy_to_user(useraddr, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-	}
-	case ETHTOOL_SMSGLVL: {
-		struct ethtool_value edata;
-		if (copy_from_user(&edata, useraddr, sizeof(edata)))
-			return -EFAULT;
-		bp->msg_enable = edata.data;
-		return 0;
-	}
-	case ETHTOOL_NWAY_RST: {
-		u32 bmcr;
-		int r;
+	b44_setup_phy(bp);
 
-		spin_lock_irq(&bp->lock);
-		b44_readphy(bp, MII_BMCR, &bmcr);
-		b44_readphy(bp, MII_BMCR, &bmcr);
-		r = -EINVAL;
-		if (bmcr & BMCR_ANENABLE) {
-			b44_writephy(bp, MII_BMCR,
-				     bmcr | BMCR_ANRESTART);
-			r = 0;
-		}
-		spin_unlock_irq(&bp->lock);
+	spin_unlock_irq(&bp->lock);
 
-		return r;
-	}
-	case ETHTOOL_GLINK: {
-		struct ethtool_value edata = { ETHTOOL_GLINK };
-		edata.data = netif_carrier_ok(bp->dev) ? 1 : 0;
-		if (copy_to_user(useraddr, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-	}
-	case ETHTOOL_GRINGPARAM: {
-		struct ethtool_ringparam ering = { ETHTOOL_GRINGPARAM };
+	return 0;
+}
 
-		ering.rx_max_pending = B44_RX_RING_SIZE - 1;
-		ering.rx_pending = bp->rx_pending;
+static void b44_get_ringparam(struct net_device *dev,
+			      struct ethtool_ringparam *ering)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		/* XXX ethtool lacks a tx_max_pending, oops... */
+	ering->rx_max_pending = B44_RX_RING_SIZE - 1;
+	ering->rx_pending = bp->rx_pending;
 
-		if (copy_to_user(useraddr, &ering, sizeof(ering)))
-			return -EFAULT;
-		return 0;
-	}
-	case ETHTOOL_SRINGPARAM: {
-		struct ethtool_ringparam ering;
+	/* XXX ethtool lacks a tx_max_pending, oops... */
+}
 
-		if (copy_from_user(&ering, useraddr, sizeof(ering)))
-			return -EFAULT;
+static int b44_set_ringparam(struct net_device *dev,
+			     struct ethtool_ringparam *ering)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		if ((ering.rx_pending > B44_RX_RING_SIZE - 1) ||
-		    (ering.rx_mini_pending != 0) ||
-		    (ering.rx_jumbo_pending != 0) ||
-		    (ering.tx_pending > B44_TX_RING_SIZE - 1))
-			return -EINVAL;
+	if ((ering->rx_pending > B44_RX_RING_SIZE - 1) ||
+	    (ering->rx_mini_pending != 0) ||
+	    (ering->rx_jumbo_pending != 0) ||
+	    (ering->tx_pending > B44_TX_RING_SIZE - 1))
+		return -EINVAL;
 
-		spin_lock_irq(&bp->lock);
+	spin_lock_irq(&bp->lock);
 
-		bp->rx_pending = ering.rx_pending;
-		bp->tx_pending = ering.tx_pending;
+	bp->rx_pending = ering->rx_pending;
+	bp->tx_pending = ering->tx_pending;
 
-		b44_halt(bp);
-		b44_init_rings(bp);
-		b44_init_hw(bp);
-		netif_wake_queue(bp->dev);
-		spin_unlock_irq(&bp->lock);
+	b44_halt(bp);
+	b44_init_rings(bp);
+	b44_init_hw(bp);
+	netif_wake_queue(bp->dev);
+	spin_unlock_irq(&bp->lock);
 
-		b44_enable_ints(bp);
-		
-		return 0;
-	}
-	case ETHTOOL_GPAUSEPARAM: {
-		struct ethtool_pauseparam epause = { ETHTOOL_GPAUSEPARAM };
+	b44_enable_ints(bp);
+	
+	return 0;
+}
 
-		epause.autoneg =
-			(bp->flags & B44_FLAG_PAUSE_AUTO) != 0;
-		epause.rx_pause =
-			(bp->flags & B44_FLAG_RX_PAUSE) != 0;
-		epause.tx_pause =
-			(bp->flags & B44_FLAG_TX_PAUSE) != 0;
-		if (copy_to_user(useraddr, &epause, sizeof(epause)))
-			return -EFAULT;
-		return 0;
-	}
-	case ETHTOOL_SPAUSEPARAM: {
-		struct ethtool_pauseparam epause;
+static void b44_get_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		if (copy_from_user(&epause, useraddr, sizeof(epause)))
-			return -EFAULT;
+	epause->autoneg =
+		(bp->flags & B44_FLAG_PAUSE_AUTO) != 0;
+	epause->rx_pause =
+		(bp->flags & B44_FLAG_RX_PAUSE) != 0;
+	epause->tx_pause =
+		(bp->flags & B44_FLAG_TX_PAUSE) != 0;
+}
 
-		spin_lock_irq(&bp->lock);
-		if (epause.autoneg)
-			bp->flags |= B44_FLAG_PAUSE_AUTO;
-		else
-			bp->flags &= ~B44_FLAG_PAUSE_AUTO;
-		if (epause.rx_pause)
-			bp->flags |= B44_FLAG_RX_PAUSE;
-		else
-			bp->flags &= ~B44_FLAG_RX_PAUSE;
-		if (epause.tx_pause)
-			bp->flags |= B44_FLAG_TX_PAUSE;
-		else
-			bp->flags &= ~B44_FLAG_TX_PAUSE;
-		if (bp->flags & B44_FLAG_PAUSE_AUTO) {
-			b44_halt(bp);
-			b44_init_rings(bp);
-			b44_init_hw(bp);
-		} else {
-			__b44_set_flow_ctrl(bp, bp->flags);
-		}
-		spin_unlock_irq(&bp->lock);
+static int b44_set_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct b44 *bp = netdev_priv(dev);
 
-		b44_enable_ints(bp);
-		
-		return 0;
+	spin_lock_irq(&bp->lock);
+	if (epause->autoneg)
+		bp->flags |= B44_FLAG_PAUSE_AUTO;
+	else
+		bp->flags &= ~B44_FLAG_PAUSE_AUTO;
+	if (epause->rx_pause)
+		bp->flags |= B44_FLAG_RX_PAUSE;
+	else
+		bp->flags &= ~B44_FLAG_RX_PAUSE;
+	if (epause->tx_pause)
+		bp->flags |= B44_FLAG_TX_PAUSE;
+	else
+		bp->flags &= ~B44_FLAG_TX_PAUSE;
+	if (bp->flags & B44_FLAG_PAUSE_AUTO) {
+		b44_halt(bp);
+		b44_init_rings(bp);
+		b44_init_hw(bp);
+	} else {
+		__b44_set_flow_ctrl(bp, bp->flags);
 	}
-	};
+	spin_unlock_irq(&bp->lock);
 
-	return -EOPNOTSUPP;
+	b44_enable_ints(bp);
+	
+	return 0;
 }
 
+static struct ethtool_ops b44_ethtool_ops = {
+	.get_drvinfo		= b44_get_drvinfo,
+	.get_settings		= b44_get_settings,
+	.set_settings		= b44_set_settings,
+	.nway_reset		= b44_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.get_ringparam		= b44_get_ringparam,
+	.set_ringparam		= b44_set_ringparam,
+	.get_pauseparam		= b44_get_pauseparam,
+	.set_pauseparam		= b44_set_pauseparam,
+	.get_msglevel		= b44_get_msglevel,
+	.set_msglevel		= b44_set_msglevel,
+};
+
 static int b44_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct mii_ioctl_data __user *data = (struct mii_ioctl_data __user *)&ifr->ifr_data;
@@ -1630,9 +1617,6 @@
 	int err;
 
 	switch (cmd) {
-	case SIOCETHTOOL:
-		return b44_ethtool_ioctl(dev, (void __user*) ifr->ifr_data);
-
 	case SIOCGMIIPHY:
 		data->phy_id = bp->phy_addr;
 
@@ -1806,6 +1790,7 @@
 	dev->watchdog_timeo = B44_TX_TIMEOUT;
 	dev->change_mtu = b44_change_mtu;
 	dev->irq = pdev->irq;
+	SET_ETHTOOL_OPS(dev, &b44_ethtool_ops);
 
 	err = b44_get_invariants(bp);
 	if (err) {

--------------060008060903080904020905--

