Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933209AbWKSUbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbWKSUbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWKSUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:31:45 -0500
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:16525 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S933209AbWKSUbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:31:41 -0500
Date: Sun, 19 Nov 2006 14:31:37 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jeff@garzik.org
Cc: shemminger@osdl.org, romieu@fr.zoreil.com, csnook@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] atl1: Ancillary C files for Attansic L1 driver
Message-ID: <20061119203137.GE29736@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Cliburn <jacliburn@bellsouth.net>

This patch contains auxiliary C files for the Attansic L1 gigabit ethernet
adapter driver.

Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
---

 atl1_ethtool.c |  530 +++++++++++++++++++++++++++++++++++
 atl1_hw.c      |  840
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 atl1_param.c   |  203 +++++++++++++
 3 files changed, 1573 insertions(+)

diff --git a/drivers/net/atl1/atl1_ethtool.c b/drivers/net/atl1/atl1_ethtool.c
new file mode 100644
index 0000000..36da53a
--- /dev/null
+++ b/drivers/net/atl1/atl1_ethtool.c
@@ -0,0 +1,530 @@
+/** atl1_ethtool.c - atl1 ethtool support
+
+Copyright(c) 2005 - 2006 Attansic Corporation. All rights reserved.
+Copyright(c) 2006 Chris Snook <csnook@redhat.com>
+Copyright(c) 2006 Jay Cliburn <jcliburn@gmail.com>
+
+Derived from Intel e1000 driver
+Copyright(c) 1999 - 2005 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+*/
+
+#include <linux/netdevice.h>
+
+#include "atl1.h"
+
+#ifdef SIOCETHTOOL
+#include <asm/uaccess.h>
+
+extern char at_driver_name[];
+extern char at_driver_version[];
+extern s32 at_up(struct at_adapter *adapter);
+extern void at_down(struct at_adapter *adapter);
+extern void at_reset(struct at_adapter *adapter);
+extern s32 at_setup_ring_resources(struct at_adapter *adapter);
+extern void at_free_ring_resources(struct at_adapter *adapter);
+extern s32 at_phy_setup_autoneg_adv(struct at_hw *hw);
+extern s32 at_write_phy_reg(struct at_hw *hw, u32 reg_addr, u16 phy_data);
+extern s32 at_get_speed_and_duplex(struct at_hw *hw, u16 * speed, u16 * duplex);
+
+#ifdef	ETHTOOL_GSTATS
+struct at_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int sizeof_stat;
+	int stat_offset;
+};
+
+#define AT_STAT(m) sizeof(((struct at_adapter *)0)->m), \
+	offsetof(struct at_adapter, m)
+
+static struct at_stats at_gstrings_stats[] = {
+	{"rx_packets", AT_STAT(soft_stats.rx_packets)},
+	{"tx_packets", AT_STAT(soft_stats.tx_packets)},
+	{"rx_bytes", AT_STAT(soft_stats.rx_bytes)},
+	{"tx_bytes", AT_STAT(soft_stats.tx_bytes)},
+	{"rx_errors", AT_STAT(soft_stats.rx_errors)},
+	{"tx_errors", AT_STAT(soft_stats.tx_errors)},
+	{"rx_dropped", AT_STAT(net_stats.rx_dropped)},
+	{"tx_dropped", AT_STAT(net_stats.tx_dropped)},
+	{"multicast", AT_STAT(soft_stats.multicast)},
+	{"collisions", AT_STAT(soft_stats.collisions)},
+	{"rx_length_errors", AT_STAT(soft_stats.rx_length_errors)},
+	{"rx_over_errors", AT_STAT(soft_stats.rx_missed_errors)},
+	{"rx_crc_errors", AT_STAT(soft_stats.rx_crc_errors)},
+	{"rx_frame_errors", AT_STAT(soft_stats.rx_frame_errors)},
+	{"rx_fifo_errors", AT_STAT(soft_stats.rx_fifo_errors)},
+	{"rx_missed_errors", AT_STAT(soft_stats.rx_missed_errors)},
+	{"tx_aborted_errors", AT_STAT(soft_stats.tx_aborted_errors)},
+	{"tx_carrier_errors", AT_STAT(soft_stats.tx_carrier_errors)},
+	{"tx_fifo_errors", AT_STAT(soft_stats.tx_fifo_errors)},
+	{"tx_window_errors", AT_STAT(soft_stats.tx_window_errors)},
+	{"tx_abort_exce_coll", AT_STAT(soft_stats.excecol)},
+	{"tx_abort_late_coll", AT_STAT(soft_stats.latecol)},
+	{"tx_deferred_ok", AT_STAT(soft_stats.deffer)},
+	{"tx_single_coll_ok", AT_STAT(soft_stats.scc)},
+	{"tx_multi_coll_ok", AT_STAT(soft_stats.mcc)},
+	{"tx_underun", AT_STAT(soft_stats.tx_underun)},
+	{"tx_trunc", AT_STAT(soft_stats.tx_trunc)},
+	{"tx_pause", AT_STAT(soft_stats.tx_pause)},
+	{"rx_pause", AT_STAT(soft_stats.rx_pause)},
+	{"rx_rrd_ov", AT_STAT(soft_stats.rx_rrd_ov)},
+	{"rx_trunc", AT_STAT(soft_stats.rx_trunc)}
+};
+
+#define AT_STATS_LEN sizeof(at_gstrings_stats) / sizeof(struct at_stats)
+#endif				/* ETHTOOL_GSTATS */
+
+static int at_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+
+	ecmd->supported = (SUPPORTED_10baseT_Half |
+			   SUPPORTED_10baseT_Full |
+			   SUPPORTED_100baseT_Half |
+			   SUPPORTED_100baseT_Full |
+			   SUPPORTED_1000baseT_Full |
+			   SUPPORTED_Autoneg | SUPPORTED_TP);
+	ecmd->advertising = ADVERTISED_TP;
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		ecmd->advertising |= ADVERTISED_Autoneg;
+		if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR) {
+			ecmd->advertising |= ADVERTISED_Autoneg;
+			ecmd->advertising |=
+			    (ADVERTISED_10baseT_Half |
+			     ADVERTISED_10baseT_Full |
+			     ADVERTISED_100baseT_Half |
+			     ADVERTISED_100baseT_Full |
+			     ADVERTISED_1000baseT_Full);
+		} else {
+			ecmd->advertising |= (ADVERTISED_1000baseT_Full);
+		}
+	}
+	ecmd->port = PORT_TP;
+	ecmd->phy_address = 0;
+	ecmd->transceiver = XCVR_INTERNAL;
+
+	if (netif_carrier_ok(adapter->netdev)) {
+		u16 link_speed, link_duplex;
+		at_get_speed_and_duplex(hw, &link_speed, &link_duplex);
+		ecmd->speed = link_speed;
+		if (link_duplex == FULL_DUPLEX)
+			ecmd->duplex = DUPLEX_FULL;
+		else
+			ecmd->duplex = DUPLEX_HALF;
+	} else {
+		ecmd->speed = -1;
+		ecmd->duplex = -1;
+	}
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		ecmd->autoneg = AUTONEG_ENABLE;
+	} else {
+		ecmd->autoneg = AUTONEG_DISABLE;
+	}
+	
+	return 0;
+}
+
+static int at_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+	u16 phy_data;
+	int ret_val = 0;
+	u16 old_media_type = hw->media_type;
+
+	if (netif_running(adapter->netdev)) {
+		printk(KERN_DEBUG "%s: ethtool shutting down link adapter\n", 
+			at_driver_name);
+		at_down(adapter);
+	}
+
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		hw->media_type = MEDIA_TYPE_AUTO_SENSOR;
+	} else {
+		if (ecmd->speed == SPEED_1000) {
+			if (ecmd->duplex != DUPLEX_FULL) {
+				printk(KERN_WARNING
+				       "%s: can't force to 1000M half duplex\n",
+					at_driver_name);
+				ret_val = -EINVAL;
+				goto exit_sset;
+			}
+			hw->media_type = MEDIA_TYPE_1000M_FULL;
+		} else if (ecmd->speed == SPEED_100) {
+			if (ecmd->duplex == DUPLEX_FULL) {
+				hw->media_type = MEDIA_TYPE_100M_FULL;
+			} else {
+				hw->media_type = MEDIA_TYPE_100M_HALF;
+			}
+		} else {
+			if (ecmd->duplex == DUPLEX_FULL) {
+				hw->media_type = MEDIA_TYPE_10M_FULL;
+			} else {
+				hw->media_type = MEDIA_TYPE_10M_HALF;
+			}
+		}
+	}
+	switch (hw->media_type) {
+	case MEDIA_TYPE_AUTO_SENSOR:
+		ecmd->advertising =
+		    ADVERTISED_10baseT_Half |
+		    ADVERTISED_10baseT_Full |
+		    ADVERTISED_100baseT_Half |
+		    ADVERTISED_100baseT_Full |
+		    ADVERTISED_1000baseT_Full |
+		    ADVERTISED_Autoneg | ADVERTISED_TP;
+		break;
+	case MEDIA_TYPE_1000M_FULL:
+		ecmd->advertising =
+		    ADVERTISED_1000baseT_Full |
+		    ADVERTISED_Autoneg | ADVERTISED_TP;
+		break;
+	default:
+		ecmd->advertising = 0;
+		break;
+	}
+	if (at_phy_setup_autoneg_adv(hw)) {
+		ret_val = -EINVAL;
+		printk(KERN_WARNING 
+			"%s: invalid ethtool speed/duplex setting\n", 
+			at_driver_name);
+		goto exit_sset;
+	}
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		phy_data = MII_CR_RESET | MII_CR_AUTO_NEG_EN;
+	} else {
+		switch (hw->media_type) {
+		case MEDIA_TYPE_100M_FULL:
+			phy_data =
+			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_100 |
+			    MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_100M_HALF:
+			phy_data = MII_CR_SPEED_100 | MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_10M_FULL:
+			phy_data =
+			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		default:	/* MEDIA_TYPE_10M_HALF: */
+			phy_data = MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		}
+	}
+	at_write_phy_reg(hw, MII_BMCR, phy_data);
+exit_sset:
+	if (ret_val) {
+		hw->media_type = old_media_type;
+	}
+	if (netif_running(adapter->netdev)) {
+		printk(KERN_DEBUG "%s: ethtool starting link adapter\n", 
+			at_driver_name);
+		at_up(adapter);
+	} else if (!ret_val) {
+		printk(KERN_DEBUG "%s: ethtool resetting link adapter\n", 
+			at_driver_name);
+		at_reset(adapter);
+	}
+	return ret_val;
+}
+
+static void at_get_drvinfo(struct net_device *netdev,
+				struct ethtool_drvinfo *drvinfo)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+
+	strncpy(drvinfo->driver, at_driver_name, 32);
+	strncpy(drvinfo->version, at_driver_version, 32);
+	strncpy(drvinfo->fw_version, "N/A", 32);
+	strncpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
+#ifdef  ETHTOOL_GEEPROM
+	drvinfo->eedump_len = 48;
+#endif	/* ETHTOOL_GEEPROM */
+}
+
+static void at_get_wol(struct net_device *netdev,
+			    struct ethtool_wolinfo *wol)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_MAGIC;
+	wol->wolopts = 0;
+	if (adapter->wol & AT_WUFC_EX)
+		wol->wolopts |= WAKE_UCAST;
+	if (adapter->wol & AT_WUFC_MC)
+		wol->wolopts |= WAKE_MCAST;
+	if (adapter->wol & AT_WUFC_BC)
+		wol->wolopts |= WAKE_BCAST;
+	if (adapter->wol & AT_WUFC_MAG)
+		wol->wolopts |= WAKE_MAGIC;
+	return;
+}
+
+static int at_set_wol(struct net_device *netdev,
+			struct ethtool_wolinfo *wol)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+
+	if (wol->wolopts & (WAKE_PHY | WAKE_ARP | WAKE_MAGICSECURE))
+		return -EOPNOTSUPP;
+	adapter->wol = 0;
+	if (wol->wolopts & WAKE_UCAST)
+		adapter->wol |= AT_WUFC_EX;
+	if (wol->wolopts & WAKE_MCAST)
+		adapter->wol |= AT_WUFC_MC;
+	if (wol->wolopts & WAKE_BCAST)
+		adapter->wol |= AT_WUFC_BC;
+	if (wol->wolopts & WAKE_MAGIC)
+		adapter->wol |= AT_WUFC_MAG;
+	return 0;
+}
+
+static void at_get_ringparam(struct net_device *netdev,
+			    struct ethtool_ringparam *ring)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_tpd_ring *txdr = &adapter->tpd_ring;
+	struct at_rfd_ring *rxdr = &adapter->rfd_ring;
+
+	ring->rx_max_pending = 2048;
+	ring->tx_max_pending = 1024;
+	ring->rx_mini_max_pending = 0;
+	ring->rx_jumbo_max_pending = 0;
+	ring->rx_pending = rxdr->count;
+	ring->tx_pending = txdr->count;
+	ring->rx_mini_pending = 0;
+	ring->rx_jumbo_pending = 0;
+}
+
+static int at_set_ringparam(struct net_device *netdev,
+			    struct ethtool_ringparam *ring)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	int err;
+	struct at_tpd_ring *tpdr = &adapter->tpd_ring;
+	struct at_rrd_ring *rrdr = &adapter->rrd_ring;
+	struct at_rfd_ring *rfdr = &adapter->rfd_ring;
+
+	struct at_tpd_ring tpd_old, tpd_new;
+	struct at_rfd_ring rfd_old, rfd_new;
+	struct at_rrd_ring rrd_old, rrd_new;
+
+	tpd_old = adapter->tpd_ring;
+	rfd_old = adapter->rfd_ring;
+	rrd_old = adapter->rrd_ring;
+
+	if (netif_running(adapter->netdev))
+		at_down(adapter);
+
+	rfdr->count = (u16) max(ring->rx_pending, (u32) 32);
+	rfdr->count = rfdr->count > 2048 ? 2048 : rfdr->count;
+	rfdr->count = (rfdr->count + 3) & ~3;
+	rrdr->count = rfdr->count;
+
+	tpdr->count = (u16) max(ring->tx_pending, (u32) 16);
+	tpdr->count = tpdr->count > 1024 ? 1024 : tpdr->count;
+	tpdr->count = (tpdr->count + 3) & ~3;
+
+	if (netif_running(adapter->netdev)) {
+		/* try to get new resources before deleting old */
+		if ((err = at_setup_ring_resources(adapter)))
+			goto err_setup_ring;
+
+		/* save the new, restore the old in order to free it,
+		 * then restore the new back again */
+		rfd_new = adapter->rfd_ring;
+		rrd_new = adapter->rrd_ring;
+		tpd_new = adapter->tpd_ring;
+		adapter->rfd_ring = rfd_old;
+		adapter->rrd_ring = rrd_old;
+		adapter->tpd_ring = tpd_old;
+		at_free_ring_resources(adapter);
+		adapter->rfd_ring = rfd_new;
+		adapter->rrd_ring = rrd_new;
+		adapter->tpd_ring = tpd_new;
+
+		if ((err = at_up(adapter)))
+			return err;
+	}
+	return 0;
+
+      err_setup_ring:
+	adapter->rfd_ring = rfd_old;
+	adapter->rrd_ring = rrd_old;
+	adapter->tpd_ring = tpd_old;
+	at_up(adapter);
+	return err;
+}
+
+static void at_get_pauseparam(struct net_device *netdev,
+			     struct ethtool_pauseparam *epause)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		epause->autoneg = AUTONEG_ENABLE;
+	} else {
+		epause->autoneg = AUTONEG_DISABLE;
+	}
+	epause->rx_pause = 1;
+	epause->tx_pause = 1;
+}
+
+static int at_set_pauseparam(struct net_device *netdev,
+			     struct ethtool_pauseparam *epause)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		epause->autoneg = AUTONEG_ENABLE;
+	} else {
+		epause->autoneg = AUTONEG_DISABLE;
+	}
+
+	epause->rx_pause = 1;
+	epause->tx_pause = 1;
+
+	return 0;
+}
+
+static u32 at_get_tx_csum(struct net_device *netdev)
+{
+	return (netdev->features & NETIF_F_HW_CSUM) != 0;
+}
+
+static int at_set_tx_csum(struct net_device *netdev, u32 data)
+{
+	if (data)
+		netdev->features |= NETIF_F_HW_CSUM;
+	else
+		netdev->features &= ~NETIF_F_HW_CSUM;
+
+	return 0;
+}
+
+#ifdef NETIF_F_TSO
+static int at_set_tso(struct net_device *netdev, u32 data)
+{
+	if (data)
+		netdev->features |= NETIF_F_TSO;
+	else
+		netdev->features &= ~NETIF_F_TSO;
+	return 0;
+}
+#endif /* NETIF_F_TSO */
+
+static void at_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	u8 *p = data;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < AT_STATS_LEN; i++) {
+			memcpy(p, at_gstrings_stats[i].stat_string,
+				ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+		break;
+	}
+}
+
+static int at_nway_reset(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;	
+	
+	if (netif_running(netdev)) {
+		u16 phy_data;
+		at_down(adapter);
+
+		if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+			hw->media_type == MEDIA_TYPE_1000M_FULL) {
+			phy_data = MII_CR_RESET | MII_CR_AUTO_NEG_EN;
+		} else {
+			switch (hw->media_type) {
+			case MEDIA_TYPE_100M_FULL:
+				phy_data = MII_CR_FULL_DUPLEX |
+					MII_CR_SPEED_100 | MII_CR_RESET;
+				break;
+			case MEDIA_TYPE_100M_HALF:
+				phy_data = MII_CR_SPEED_100 | MII_CR_RESET;
+				break;	
+			case MEDIA_TYPE_10M_FULL:
+				phy_data = MII_CR_FULL_DUPLEX |
+					MII_CR_SPEED_10 | MII_CR_RESET;
+				break;
+			default:  /* MEDIA_TYPE_10M_HALF */
+				phy_data = MII_CR_SPEED_10 | MII_CR_RESET;
+			}
+		}
+		at_write_phy_reg(hw, MII_BMCR, phy_data);
+		at_up(adapter);
+	}
+	return 0;
+}
+
+static void at_get_ethtool_stats(struct net_device *netdev,
+		struct ethtool_stats *stats, u64 *data)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < AT_STATS_LEN; i++) {
+		char *p = (char *)adapter+at_gstrings_stats[i].stat_offset;
+		data[i] = (at_gstrings_stats[i].sizeof_stat ==
+			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+	}
+
+}
+
+static const struct ethtool_ops at_ethtool_ops = {
+	.get_settings		= at_get_settings,
+	.set_settings		= at_set_settings,
+	.get_drvinfo		= at_get_drvinfo,
+	.get_wol		= at_get_wol,
+	.set_wol		= at_set_wol,
+	.get_ringparam		= at_get_ringparam,
+	.set_ringparam		= at_set_ringparam,
+	.get_pauseparam		= at_get_pauseparam,
+	.set_pauseparam 	= at_set_pauseparam,
+	.get_tx_csum		= at_get_tx_csum,
+	.set_tx_csum		= at_set_tx_csum,
+	.get_link		= ethtool_op_get_link,
+	.get_sg			= ethtool_op_get_sg,
+	.set_sg			= ethtool_op_set_sg,
+	.get_strings		= at_get_strings,
+	.nway_reset		= at_nway_reset,
+	.get_ethtool_stats	= at_get_ethtool_stats,
+#ifdef NETIF_F_TSO
+	.get_tso		= ethtool_op_get_tso,
+	.set_tso		= at_set_tso,
+#endif
+};
+
+void at_set_ethtool_ops(struct net_device *netdev)
+{
+	SET_ETHTOOL_OPS(netdev, &at_ethtool_ops);
+}
+#endif	/* SIOCETHTOOL */
diff --git a/drivers/net/atl1/atl1_hw.c b/drivers/net/atl1/atl1_hw.c
new file mode 100644
index 0000000..74ec263
--- /dev/null
+++ b/drivers/net/atl1/atl1_hw.c
@@ -0,0 +1,840 @@
+/** atl1_hw.c - atl1 hardware operations
+
+Copyright(c) 2005 - 2006 Attansic Corporation. All rights reserved.
+Copyright(c) 2006 Chris Snook <csnook@redhat.com>
+Copyright(c) 2006 Jay Cliburn <jcliburn@gmail.com>
+
+Derived from Intel e1000 driver
+Copyright(c) 1999 - 2005 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+*/
+
+#include "atl1.h"
+
+#ifdef SIOCGMIIPHY
+#include <linux/mii.h>
+#endif
+
+extern char at_driver_name[];
+
+/**
+FIXME: are we keeping this?
+
+ * The little-endian AUTODIN II ethernet CRC calculations.
+ * A big-endian version is also available.
+ * This is slow but compact code.  Do not use this routine 
+ * for bulk data, use a table-based routine instead.
+ * This is common code and should be moved to net/core/crc.c.
+ * Chips may use the upper or lower CRC bits, and may reverse 
+ * and/or invert them.  Select the endian-ness that results 
+ * in minimal calculations.
+ */
+static u32 ether_crc_le(int length, unsigned char *data)
+{
+	u32 crc = ~0;		/* Initial value. */
+	while (--length >= 0) {
+		unsigned char current_octet = *data++;
+		int bit;
+		for (bit = 8; --bit >= 0; current_octet >>= 1) {
+			if ((crc ^ current_octet) & 1) {
+				crc >>= 1;
+				crc ^= 0xedb88320;
+			} else
+				crc >>= 1;
+		}
+	}
+	return ~crc;
+}
+
+void at_read_pci_cfg(struct at_hw *hw, u32 reg, u16 * value)
+{
+        struct at_adapter *adapter = hw->back;
+        pci_read_config_word(adapter->pdev, reg, value);
+}
+
+void at_write_pci_cfg(struct at_hw *hw, u32 reg, u16 * value)
+{
+        struct at_adapter *adapter = hw->back;
+        pci_write_config_word(adapter->pdev, reg, *value);
+}
+
+/**
+ * Reset the transmit and receive units; mask and clear all interrupts.
+ * hw - Struct containing variables accessed by shared code
+ * return : AT_SUCCESS  or  idle status (if error)
+ */
+s32 at_reset_hw(struct at_hw * hw)
+{
+	u32 icr;
+	u16 pci_cfg_cmd_word;
+	int i;
+
+	/* Workaround for PCI problem when BIOS sets MMRBC incorrectly. */
+	at_read_pci_cfg(hw, PCI_REG_COMMAND, &pci_cfg_cmd_word);
+	if ((pci_cfg_cmd_word &
+	     (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER))
+	    != (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER)) {
+		pci_cfg_cmd_word |=
+		    (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER);
+		at_write_pci_cfg(hw, PCI_REG_COMMAND, &pci_cfg_cmd_word);
+	}
+
+	/* Clear Interrupt mask to stop board from generating
+	 * interrupts & Clear any pending interrupt events 
+	 AT_WRITE_REG(hw, REG_IMR, 0);
+	 AT_WRITE_REG(hw, REG_ISR, 0xffffffff);
+	 */
+
+	/* Issue Soft Reset to the MAC.  This will reset the chip's
+	 * transmit, receive, DMA.  It will not effect
+	 * the current PCI configuration.  The global reset bit is self-
+	 * clearing, and should clear within a microsecond.
+	 */
+	AT_WRITE_REG(hw, REG_MASTER_CTRL, MASTER_CTRL_SOFT_RST);
+	wmb();
+
+	AT_WRITE_REGW(hw, REG_GPHY_ENABLE, 1);
+
+	msec_delay(1);		/* delay about 1ms */
+
+	/* Wait at least 10ms for All module to be Idle */
+	for (i = 0; i < 10; i++) {
+		icr = AT_READ_REG(hw, REG_IDLE_STATUS);
+		if (!icr)
+			break;
+		msec_delay(1);	/* delay 1 ms */
+		cpu_relax();	/* FIXME: is this still the right way to do this? */
+	}
+
+	if (icr) {
+		return icr;
+	}
+
+	return AT_SUCCESS;
+}
+
+static inline bool eth_address_valid(u8 * p_addr)
+{
+	/* Invalid PermanentAddress ? */
+	if (((p_addr[0] == 0) &&
+	     (p_addr[1] == 0) &&
+	     (p_addr[2] == 0) &&
+	     (p_addr[3] == 0) && (p_addr[4] == 0) && (p_addr[5] == 0)
+	    ) || (p_addr[0] & 1)) {	/* Multicast address or Broadcast Address */
+		return false;
+	}
+	return true;
+}
+
+/** function about EEPROM
+ *
+ * check_eeprom_exist
+ * return 0 if eeprom exist
+ */
+static int check_eeprom_exist(struct at_hw *hw)
+{
+	u32 value;
+	value = AT_READ_REG(hw, REG_SPI_FLASH_CTRL);
+	if (value & SPI_FLASH_CTRL_EN_VPD) {
+		value &= ~SPI_FLASH_CTRL_EN_VPD;
+		AT_WRITE_REG(hw, REG_SPI_FLASH_CTRL, value);
+	}
+	value = AT_READ_REGW(hw, REG_PCIE_CAP_LIST);
+	return ((value & 0xFF00) == 0x6C00) ? 0 : 1;
+}
+
+static bool read_eeprom(struct at_hw *hw, u32 offset, u32 * p_value)
+{
+	int i;
+	u32 control;
+
+	if (offset & 3)
+		return false;	/* address do not align */
+
+	AT_WRITE_REG(hw, REG_VPD_DATA, 0);
+	control = (offset & VPD_CAP_VPD_ADDR_MASK) << VPD_CAP_VPD_ADDR_SHIFT;
+	AT_WRITE_REG(hw, REG_VPD_CAP, control);
+
+	for (i = 0; i < 10; i++) {
+		msec_delay(2);
+		control = AT_READ_REG(hw, REG_VPD_CAP);
+		if (control & VPD_CAP_VPD_FLAG)
+			break;
+	}
+	if (control & VPD_CAP_VPD_FLAG) {
+		*p_value = AT_READ_REG(hw, REG_VPD_DATA);
+		return true;
+	}
+	return false;		/* timeout */
+}
+
+/**
+ * Reads the value from a PHY register
+ * hw - Struct containing variables accessed by shared code
+ * reg_addr - address of the PHY register to read
+ */
+s32 at_read_phy_reg(struct at_hw * hw, u16 reg_addr, u16 * phy_data)
+{
+	u32 val;
+	int i;
+
+	val = ((u32) (reg_addr & MDIO_REG_ADDR_MASK)) << MDIO_REG_ADDR_SHIFT |
+	    	MDIO_START | MDIO_SUP_PREAMBLE | MDIO_RW | MDIO_CLK_25_4 <<
+ 		MDIO_CLK_SEL_SHIFT;
+	AT_WRITE_REG(hw, REG_MDIO_CTRL, val);
+
+	wmb();
+
+	for (i = 0; i < MDIO_WAIT_TIMES; i++) {
+		usec_delay(2);
+		val = AT_READ_REG(hw, REG_MDIO_CTRL);
+		if (!(val & (MDIO_START | MDIO_BUSY))) {
+			break;
+		}
+		wmb();
+	}
+	if (!(val & (MDIO_START | MDIO_BUSY))) {
+		*phy_data = (u16) val;
+		return AT_SUCCESS;
+	}
+	return AT_ERR_PHY;
+}
+
+#define CUSTOM_SPI_CS_SETUP	2
+#define CUSTOM_SPI_CLK_HI	2
+#define CUSTOM_SPI_CLK_LO	2
+#define CUSTOM_SPI_CS_HOLD	2
+#define CUSTOM_SPI_CS_HI	3
+
+static bool spi_read(struct at_hw *hw, u32 addr, u32 * buf)
+{
+	int i;
+	u32 value;
+
+	AT_WRITE_REG(hw, REG_SPI_DATA, 0);
+	AT_WRITE_REG(hw, REG_SPI_ADDR, addr);
+
+	value = SPI_FLASH_CTRL_WAIT_READY |
+	    (CUSTOM_SPI_CS_SETUP & SPI_FLASH_CTRL_CS_SETUP_MASK) <<
+	    SPI_FLASH_CTRL_CS_SETUP_SHIFT | (CUSTOM_SPI_CLK_HI &
+					     SPI_FLASH_CTRL_CLK_HI_MASK) <<
+	    SPI_FLASH_CTRL_CLK_HI_SHIFT | (CUSTOM_SPI_CLK_LO &
+					   SPI_FLASH_CTRL_CLK_LO_MASK) <<
+	    SPI_FLASH_CTRL_CLK_LO_SHIFT | (CUSTOM_SPI_CS_HOLD &
+					   SPI_FLASH_CTRL_CS_HOLD_MASK) <<
+	    SPI_FLASH_CTRL_CS_HOLD_SHIFT | (CUSTOM_SPI_CS_HI &
+					    SPI_FLASH_CTRL_CS_HI_MASK) <<
+	    SPI_FLASH_CTRL_CS_HI_SHIFT | (1 & SPI_FLASH_CTRL_INS_MASK) <<
+	    SPI_FLASH_CTRL_INS_SHIFT;
+
+	AT_WRITE_REG(hw, REG_SPI_FLASH_CTRL, value);
+
+	value |= SPI_FLASH_CTRL_START;
+
+	AT_WRITE_REG(hw, REG_SPI_FLASH_CTRL, value);
+
+	for (i = 0; i < 10; i++) {
+		msec_delay(1);	/* 1ms */
+		value = AT_READ_REG(hw, REG_SPI_FLASH_CTRL);
+		if (!(value & SPI_FLASH_CTRL_START))
+			break;
+	}
+
+	if (value & SPI_FLASH_CTRL_START)
+		return false;
+
+	*buf = AT_READ_REG(hw, REG_SPI_DATA);
+
+	return true;
+}
+
+/**
+ * get_permanent_address
+ * return 0 if get valid mac address, 
+ */
+int get_permanent_address(struct at_hw *hw)
+{
+	u32 addr[2];
+	u32 i, control;
+	u16 reg;
+	u8 eth_addr[NODE_ADDRESS_SIZE];
+	bool key_valid;
+
+	if (eth_address_valid(hw->perm_mac_addr))
+		return 0;
+
+	/* init */
+	addr[0] = addr[1] = 0;
+
+	if (!check_eeprom_exist(hw)) {	/* eeprom exist */
+		reg = 0;
+		key_valid = false;
+		/* Read out all EEPROM content */
+		i = 0;
+		while (1) {
+			if (read_eeprom(hw, i + 0x100, &control)) {
+				if (key_valid) {
+					if (reg == REG_MAC_STA_ADDR)
+						addr[0] = control;
+					else if (reg == (REG_MAC_STA_ADDR + 4)) {
+						addr[1] = control;
+					}
+					key_valid = false;
+				} else if ((control & 0xff) == 0x5A) {
+					key_valid = true;
+					reg = (u16) (control >> 16);
+				} else {
+					break;	/* assume data end while encount an invalid KEYWORD */
+				}
+			} else {
+				break;	/* read error */
+			}
+			i += 4;
+		}
+
+		*(u32 *) & eth_addr[2] = LONGSWAP(addr[0]);
+		*(u16 *) & eth_addr[0] = SHORTSWAP(*(u16 *) & addr[1]);
+
+		if (eth_address_valid(eth_addr)) {
+			memcpy(hw->perm_mac_addr, eth_addr, NODE_ADDRESS_SIZE);
+			return 0;
+		}
+		return 1;
+	}
+
+	/* see if SPI FLAGS exist ? */
+	addr[0] = addr[1] = 0;
+	reg = 0;
+	key_valid = false;
+	i = 0;
+	while (1) {
+		if (spi_read(hw, i + 0x1f000, &control)) {
+			if (key_valid) {
+				if (reg == REG_MAC_STA_ADDR)
+					addr[0] = control;
+				else if (reg == (REG_MAC_STA_ADDR + 4)) {
+					addr[1] = control;
+				}
+				key_valid = false;
+			} else if ((control & 0xff) == 0x5A) {
+				key_valid = true;
+				reg = (u16) (control >> 16);
+			} else {
+				break;	/* data end */
+			}
+		} else {
+			break;	/* read error */
+		}
+		i += 4;
+	}
+
+	*(u32 *) & eth_addr[2] = LONGSWAP(addr[0]);
+	*(u16 *) & eth_addr[0] = SHORTSWAP(*(u16 *) & addr[1]);
+	if (eth_address_valid(eth_addr)) {
+		memcpy(hw->perm_mac_addr, eth_addr, NODE_ADDRESS_SIZE);
+		return 0;
+	}
+	return 1;
+}
+
+/**
+ * Reads the adapter's MAC address from the EEPROM 
+ * hw - Struct containing variables accessed by shared code
+ */
+s32 at_read_mac_addr(struct at_hw * hw)
+{
+	u16 i;
+
+	if (get_permanent_address(hw)) {
+		hw->perm_mac_addr[0] = 0x00;
+		hw->perm_mac_addr[1] = 0x13;
+		hw->perm_mac_addr[2] = 0x74;
+		hw->perm_mac_addr[3] = 0x00;
+		hw->perm_mac_addr[4] = 0x5c;
+		hw->perm_mac_addr[5] = 0x38;
+	}
+	for (i = 0; i < NODE_ADDRESS_SIZE; i++)
+		hw->mac_addr[i] = hw->perm_mac_addr[i];
+	return AT_SUCCESS;
+}
+
+/**
+ * Hashes an address to determine its location in the multicast table
+ * hw - Struct containing variables accessed by shared code
+ * mc_addr - the multicast address to hash
+ *
+ * at_hash_mc_addr
+ *  purpose
+ *      set hash value for a multicast address
+ *      hash calcu processing :
+ *          1. calcu 32bit CRC for multicast address
+ *          2. reverse crc with MSB to LSB
+ */
+u32 at_hash_mc_addr(struct at_hw * hw, u8 * mc_addr)
+{
+	u32 crc32, value = 0;
+	int i;
+
+	crc32 = ether_crc_le(6, mc_addr);
+	crc32 = ~crc32;
+	for (i = 0; i < 32; i++)
+		value |= (((crc32 >> i) & 1) << (31 - i));
+
+	return value;
+}
+
+/**
+ * Sets the bit in the multicast table corresponding to the hash value.
+ * hw - Struct containing variables accessed by shared code
+ * hash_value - Multicast address hash value
+ */
+void at_hash_set(struct at_hw *hw, u32 hash_value)
+{
+	u32 hash_bit, hash_reg;
+	u32 mta;
+
+	/* The HASH Table  is a register array of 2 32-bit registers.
+	 * It is treated like an array of 64 bits.  We want to set
+	 * bit BitArray[hash_value]. So we figure out what register
+	 * the bit is in, read it, OR in the new bit, then write
+	 * back the new value.  The register is determined by the
+	 * upper 7 bits of the hash value and the bit within that
+	 * register are determined by the lower 5 bits of the value.
+	 */
+	hash_reg = (hash_value >> 31) & 0x1;
+	hash_bit = (hash_value >> 26) & 0x1F;
+
+	mta = AT_READ_REG_ARRAY(hw, REG_RX_HASH_TABLE, hash_reg);
+
+	mta |= (1 << hash_bit);
+
+	AT_WRITE_REG_ARRAY(hw, REG_RX_HASH_TABLE, hash_reg, mta);
+}
+
+/**
+ * Writes a value to a PHY register
+ * hw - Struct containing variables accessed by shared code
+ * reg_addr - address of the PHY register to write
+ * data - data to write to the PHY
+ */
+s32 at_write_phy_reg(struct at_hw *hw, u32 reg_addr, u16 phy_data)
+{
+	int i;
+	u32 val;
+
+	val = ((u32) (phy_data & MDIO_DATA_MASK)) << MDIO_DATA_SHIFT |
+	    (reg_addr & MDIO_REG_ADDR_MASK) << MDIO_REG_ADDR_SHIFT |
+	    MDIO_SUP_PREAMBLE |
+	    MDIO_START | MDIO_CLK_25_4 << MDIO_CLK_SEL_SHIFT;
+	AT_WRITE_REG(hw, REG_MDIO_CTRL, val);
+
+	wmb();
+
+	for (i = 0; i < MDIO_WAIT_TIMES; i++) {
+		usec_delay(2);
+		val = AT_READ_REG(hw, REG_MDIO_CTRL);
+		if (!(val & (MDIO_START | MDIO_BUSY))) {
+			break;
+		}
+		wmb();
+	}
+
+	if (!(val & (MDIO_START | MDIO_BUSY)))
+		return AT_SUCCESS;
+
+	return AT_ERR_PHY;
+}
+
+/**
+ * Make L001's PHY out of Power Saving State (bug)
+ * hw - Struct containing variables accessed by shared code
+ * when power on, L001's PHY always on Power saving State
+ * (Gigabit Link forbidden)
+ */
+static s32 at_phy_leave_power_saving(struct at_hw *hw)
+{
+	s32 ret;
+	if ((ret = at_write_phy_reg(hw, 29, 0x0029)))
+		return ret;
+	return at_write_phy_reg(hw, 30, 0);
+}
+
+/**
+TODO: do something or get rid of this
+*/
+s32 at_phy_enter_power_saving(struct at_hw * hw)
+{
+/*    s32 ret_val;
+ *    u16 phy_data;
+ */
+
+/*
+    ret_val = at_write_phy_reg(hw, ...);
+    ret_val = at_write_phy_reg(hw, ...);
+    ....
+*/
+	return AT_SUCCESS;
+}
+
+/**
+ * Resets the PHY and make all config validate
+ * hw - Struct containing variables accessed by shared code
+ *
+ * Sets bit 15 and 12 of the MII Control regiser (for F001 bug)
+ */
+static s32 at_phy_reset(struct at_hw *hw)
+{
+	s32 ret_val;
+	u16 phy_data;
+
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
+		phy_data = MII_CR_RESET | MII_CR_AUTO_NEG_EN;
+	} else {
+		switch (hw->media_type) {
+		case MEDIA_TYPE_100M_FULL:
+			phy_data =
+			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_100 |
+			    MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_100M_HALF:
+			phy_data = MII_CR_SPEED_100 | MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_10M_FULL:
+			phy_data =
+			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		default:	/* MEDIA_TYPE_10M_HALF: */
+			phy_data = MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		}
+	}
+
+	ret_val = at_write_phy_reg(hw, MII_BMCR, phy_data);
+	if (ret_val) {
+		u32 val;
+		int i;
+		/**************************************
+		 * pcie serdes link may be down !
+		 **************************************/
+		printk(KERN_DEBUG "%s: autoneg caused pcie phy link down\n", 
+			at_driver_name);
+
+		for (i = 0; i < 25; i++) {
+			msec_delay(1);
+			val = AT_READ_REG(hw, REG_MDIO_CTRL);
+			if (!(val & (MDIO_START | MDIO_BUSY))) {
+				break;
+			}
+		}
+
+		if (0 != (val & (MDIO_START | MDIO_BUSY))) {
+			printk(KERN_WARNING 
+				"%s: pcie link down at least for 25ms\n", 
+				at_driver_name);
+			return ret_val;
+		}
+	}
+	return AT_SUCCESS;
+}
+
+/**
+ * Configures PHY autoneg and flow control advertisement settings
+ * hw - Struct containing variables accessed by shared code
+ */
+s32 at_phy_setup_autoneg_adv(struct at_hw * hw)
+{
+	s32 ret_val;
+	s16 mii_autoneg_adv_reg;
+	s16 mii_1000t_ctrl_reg;
+
+	/* Read the MII Auto-Neg Advertisement Register (Address 4). */
+	mii_autoneg_adv_reg = MII_AR_DEFAULT_CAP_MASK;
+
+	/* Read the MII 1000Base-T Control Register (Address 9). */
+	mii_1000t_ctrl_reg = MII_AT001_CR_1000T_DEFAULT_CAP_MASK;
+
+	/* First we clear all the 10/100 mb speed bits in the Auto-Neg
+	 * Advertisement Register (Address 4) and the 1000 mb speed bits in
+	 * the  1000Base-T Control Register (Address 9).
+	 */
+	mii_autoneg_adv_reg &= ~MII_AR_SPEED_MASK;
+	mii_1000t_ctrl_reg &= ~MII_AT001_CR_1000T_SPEED_MASK;
+
+	/* Need to parse media_type  and set up
+	 * the appropriate PHY registers.
+	 */
+	switch (hw->media_type) {
+	case MEDIA_TYPE_AUTO_SENSOR:
+		mii_autoneg_adv_reg |= (MII_AR_10T_HD_CAPS |
+					MII_AR_10T_FD_CAPS |
+					MII_AR_100TX_HD_CAPS |
+					MII_AR_100TX_FD_CAPS);
+		mii_1000t_ctrl_reg |= MII_AT001_CR_1000T_FD_CAPS;
+		break;
+
+	case MEDIA_TYPE_1000M_FULL:
+		mii_1000t_ctrl_reg |= MII_AT001_CR_1000T_FD_CAPS;
+		break;
+
+	case MEDIA_TYPE_100M_FULL:
+		mii_autoneg_adv_reg |= MII_AR_100TX_FD_CAPS;
+		break;
+
+	case MEDIA_TYPE_100M_HALF:
+		mii_autoneg_adv_reg |= MII_AR_100TX_HD_CAPS;
+		break;
+
+	case MEDIA_TYPE_10M_FULL:
+		mii_autoneg_adv_reg |= MII_AR_10T_FD_CAPS;
+		break;
+
+	default:
+		mii_autoneg_adv_reg |= MII_AR_10T_HD_CAPS;
+		break;
+	}
+
+	/* flow control fixed to enable all */
+	mii_autoneg_adv_reg |= (MII_AR_ASM_DIR | MII_AR_PAUSE);
+
+	hw->mii_autoneg_adv_reg = mii_autoneg_adv_reg;
+	hw->mii_1000t_ctrl_reg = mii_1000t_ctrl_reg;
+
+	ret_val = at_write_phy_reg(hw, MII_ADVERTISE, mii_autoneg_adv_reg);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = at_write_phy_reg(hw, MII_AT001_CR, mii_1000t_ctrl_reg);
+	if (ret_val)
+		return ret_val;
+
+	return AT_SUCCESS;
+}
+
+/**
+ * Configures link settings.
+ * hw - Struct containing variables accessed by shared code
+ * Assumes the hardware has previously been reset and the
+ * transmitter and receiver are not enabled.
+ */
+static s32 at_setup_link(struct at_hw *hw)
+{
+	s32 ret_val;
+
+	/* Options:
+	 *  PHY will advertise value(s) parsed from
+	 *  autoneg_advertised and fc
+	 *  no matter what autoneg is , We will not wait link result.
+	 */
+	ret_val = at_phy_setup_autoneg_adv(hw);
+	if (ret_val) {
+		printk(KERN_DEBUG "%s: error setting up autonegotiation\n", 
+			at_driver_name);
+		return ret_val;
+	}
+	/* SW.Reset , En-Auto-Neg if needed */
+	ret_val = at_phy_reset(hw);
+	if (ret_val) {
+		printk(KERN_DEBUG "%s: error resetting the phy\n", at_driver_name);
+		return ret_val;
+	}
+	hw->phy_configured = true;
+	return ret_val;
+}
+
+struct spi_flash_dev flash_table[] = {
+/*	manu_name WRSR  READ  PRGM  WREN  WRDI  RDSR  RDID  SECTOR_ERASE CHIP_ERASE */
+	{"Atmel", 0x00, 0x03, 0x02, 0x06, 0x04, 0x05, 0x15, 0x52,        0x62},
+	{"SST",   0x01, 0x03, 0x02, 0x06, 0x04, 0x05, 0x90, 0x20,        0x60},
+	{"ST",    0x01, 0x03, 0x02, 0x06, 0x04, 0x05, 0xAB, 0xD8,        0xC7},
+};
+
+static void init_flash_opcode(struct at_hw *hw)
+{
+	if (hw->flash_vendor >= sizeof(flash_table) / sizeof(flash_table[0])) {
+		hw->flash_vendor = 0;	/* ATMEL */
+	}
+	/* Init OP table */
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_PROGRAM,
+		      flash_table[hw->flash_vendor].cmd_program);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_SC_ERASE,
+		      flash_table[hw->flash_vendor].cmd_sector_erase);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_CHIP_ERASE,
+		      flash_table[hw->flash_vendor].cmd_chip_erase);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_RDID,
+		      flash_table[hw->flash_vendor].cmd_rdid);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_WREN,
+		      flash_table[hw->flash_vendor].cmd_wren);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_RDSR,
+		      flash_table[hw->flash_vendor].cmd_rdsr);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_WRSR,
+		      flash_table[hw->flash_vendor].cmd_wrsr);
+	AT_WRITE_REGB(hw, REG_SPI_FLASH_OP_READ,
+		      flash_table[hw->flash_vendor].cmd_read);
+}
+
+/**
+ * Performs basic configuration of the adapter.
+ * hw - Struct containing variables accessed by shared code
+ * Assumes that the controller has previously been reset and is in a
+ * post-reset uninitialized state. Initializes multicast table, 
+ * and  Calls routines to setup link
+ * Leaves the transmit and receive units disabled and uninitialized.
+ */
+s32 at_init_hw(struct at_hw *hw)
+{
+	u32 ret_val = 0;
+
+	/* Zero out the Multicast HASH table */
+	AT_WRITE_REG(hw, REG_RX_HASH_TABLE, 0);
+	/* clear the old settings from the multicast hash table */
+	AT_WRITE_REG_ARRAY(hw, REG_RX_HASH_TABLE, 1, 0);
+
+	init_flash_opcode(hw);
+
+	if (!hw->phy_configured) {
+		/* enable GPHY LinkChange Interrrupt */
+		ret_val = at_write_phy_reg(hw, 18, 0xC00);
+		if (ret_val)
+			return ret_val;
+		/* make PHY out of power-saving state */
+		ret_val = at_phy_leave_power_saving(hw);
+		if (ret_val)
+			return ret_val;
+		/* Call a subroutine to configure the link */
+		ret_val = at_setup_link(hw);
+	}
+	return ret_val;
+}
+
+/**
+ * Detects the current speed and duplex settings of the hardware.
+ * hw - Struct containing variables accessed by shared code
+ * speed - Speed of the connection
+ * duplex - Duplex setting of the connection
+ */
+s32 at_get_speed_and_duplex(struct at_hw * hw, u16 * speed, u16 * duplex)
+{
+	s32 ret_val;
+	u16 phy_data;
+
+	/* ; --- Read   PHY Specific Status Register (17) */
+	ret_val = at_read_phy_reg(hw, MII_AT001_PSSR, &phy_data);
+	if (ret_val)
+		return ret_val;
+
+	if (!(phy_data & MII_AT001_PSSR_SPD_DPLX_RESOLVED))
+		return AT_ERR_PHY_RES;
+
+	switch (phy_data & MII_AT001_PSSR_SPEED) {
+	case MII_AT001_PSSR_1000MBS:
+		*speed = SPEED_1000;
+		break;
+	case MII_AT001_PSSR_100MBS:
+		*speed = SPEED_100;
+		break;
+	case MII_AT001_PSSR_10MBS:
+		*speed = SPEED_10;
+		break;
+	default:
+		printk(KERN_DEBUG "%s: error getting speed\n", at_driver_name);
+		return AT_ERR_PHY_SPEED;
+		break;
+	}
+	if (phy_data & MII_AT001_PSSR_DPLX) {
+		*duplex = FULL_DUPLEX;
+	} else {
+		*duplex = HALF_DUPLEX;
+	}
+	return AT_SUCCESS;
+}
+
+void set_mac_addr(struct at_hw *hw)
+{
+	u32 value;
+	/* 00-0B-6A-F6-00-DC
+	   0:  6AF600DC   1: 000B
+	   low dword */
+	value = (((u32) hw->mac_addr[2]) << 24) |
+	    (((u32) hw->mac_addr[3]) << 16) |
+	    (((u32) hw->mac_addr[4]) << 8) | (((u32) hw->mac_addr[5]));
+	AT_WRITE_REG_ARRAY(hw, REG_MAC_STA_ADDR, 0, value);
+	/* hight dword */
+	value = (((u32) hw->mac_addr[0]) << 8) | (((u32) hw->mac_addr[1]));
+	AT_WRITE_REG_ARRAY(hw, REG_MAC_STA_ADDR, 1, value);
+}
+
+/*
+ * FIXME -- this function isn't called anywhere.
+ */
+s32 at_set_speed_and_duplex(struct at_hw *hw, u16 speed, u16 duplex)
+{
+	s32 ret_val;
+	u16 phy_data;
+	if (speed == SPEED_1000) {
+		hw->media_type = MEDIA_TYPE_1000M_FULL;
+		phy_data = MII_CR_SPEED_1000;
+	} else if ((speed == SPEED_100) && (duplex == FULL_DUPLEX)) {
+		hw->media_type = MEDIA_TYPE_100M_FULL;
+		phy_data = MII_CR_SPEED_100 | MII_CR_FULL_DUPLEX;
+	} else if ((speed == SPEED_100) && (duplex == HALF_DUPLEX)) {
+		hw->media_type = MEDIA_TYPE_100M_HALF;
+		phy_data = MII_CR_SPEED_100;
+	} else if ((speed == SPEED_10) && (duplex == FULL_DUPLEX)) {
+		hw->media_type = MEDIA_TYPE_10M_FULL;
+		phy_data = MII_CR_SPEED_10 | MII_CR_FULL_DUPLEX;
+	} else if ((speed == SPEED_10) && (duplex == HALF_DUPLEX)) {
+		hw->media_type = MEDIA_TYPE_10M_HALF;
+		phy_data = MII_CR_SPEED_10;
+	} else {
+		printk(KERN_WARNING "%s: speed=%d, duplex=%d not supported\n",
+		       at_driver_name, speed, duplex);
+		return AT_ERR_CONFIG;
+	}
+
+	/* add reset signal */
+	phy_data |= MII_CR_RESET;
+
+	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
+	    hw->media_type == MEDIA_TYPE_1000M_FULL)
+		phy_data |= MII_CR_AUTO_NEG_EN;
+
+	ret_val = at_write_phy_reg(hw, MII_BMCR, phy_data);
+	if (ret_val) {
+		u32 val;
+		int i;
+		/**************************************
+		 * pcie serdes link may be down !
+		 **************************************/
+		printk(KERN_DEBUG "%s: autoneg caused pcie phy link down\n", at_driver_name);
+
+		for (i = 0; i < 25; i++) {
+			msec_delay(1);
+			val = AT_READ_REG(hw, REG_MDIO_CTRL);
+			if (!(val & (MDIO_START | MDIO_BUSY))) {
+				break;
+			}
+		}
+
+		if (0 != (val & (MDIO_START | MDIO_BUSY))) {
+			printk(KERN_WARNING 
+				"%s: pcie link down at least for 25ms\n", 
+				at_driver_name);
+			return ret_val;
+		}
+	}
+	return AT_SUCCESS;
+}
diff --git a/drivers/net/atl1/atl1_param.c b/drivers/net/atl1/atl1_param.c
new file mode 100644
index 0000000..4f25a33
--- /dev/null
+++ b/drivers/net/atl1/atl1_param.c
@@ -0,0 +1,203 @@
+/** atl1_param.c - atl1 parameter parsing
+
+Copyright(c) 2005 - 2006 Attansic Corporation. All rights reserved.
+Copyright(c) 2006 Chris Snook <csnook@redhat.com>
+Copyright(c) 2006 Jay Cliburn <jcliburn@gmail.com>
+
+Derived from Intel e1000 driver
+Copyright(c) 1999 - 2005 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+*/
+
+#include "atl1.h"
+#include <linux/moduleparam.h>
+
+extern char at_driver_name[];
+
+/* This is the only thing that needs to be changed to adjust the
+ * maximum number of ports that the driver can manage.
+ */
+#define AT_MAX_NIC 4
+
+#define OPTION_UNSET    -1
+#define OPTION_DISABLED 0
+#define OPTION_ENABLED  1
+
+#define AT_PARAM_INIT { [0 ... AT_MAX_NIC] = OPTION_UNSET }
+
+/* Interrupt Moderate Timer in units of 2 us
+ *
+ * Valid Range: 10-65535
+ *
+ * Default Value: 100 (200us)
+ */
+static int __devinitdata int_mod_timer[AT_MAX_NIC+1] = AT_PARAM_INIT;
+static int num_int_mod_timer = 0;
+module_param_array_named(int_mod_timer, int_mod_timer, int, &num_int_mod_timer, 0);
+MODULE_PARM_DESC(int_mod_timer, "Interrupt moderator timer");
+
+/* flash_vendor
+ *
+ * Valid Range: 0-2
+ *
+ * 0 - Atmel
+ * 1 - SST
+ * 2 - ST
+ *
+ * Default Value: 0
+ */
+static int __devinitdata flash_vendor[AT_MAX_NIC+1] = AT_PARAM_INIT;
+static int num_flash_vendor = 0;
+module_param_array_named(flash_vendor, flash_vendor, int, &num_flash_vendor, 0);
+MODULE_PARM_DESC(flash_vendor, "SPI flash vendor");
+
+#define DEFAULT_INT_MOD_CNT	100	/* 200us */
+#define MAX_INT_MOD_CNT		65000
+#define MIN_INT_MOD_CNT		50
+
+#define FLASH_VENDOR_DEFAULT	0
+#define FLASH_VENDOR_MIN	0
+#define FLASH_VENDOR_MAX	2
+
+struct at_option {
+	enum { enable_option, range_option, list_option } type;
+	char *name;
+	char *err;
+	int def;
+	union {
+		struct {	/* range_option info */
+			int min;
+			int max;
+		} r;
+		struct {	/* list_option info */
+			int nr;
+			struct at_opt_list {
+				int i;
+				char *str;
+			} *p;
+		} l;
+	} arg;
+};
+
+static int __devinit at_validate_option(int *value, struct at_option *opt)
+{
+	if (*value == OPTION_UNSET) {
+		*value = opt->def;
+		return 0;
+	}
+
+	switch (opt->type) {
+	case enable_option:
+		switch (*value) {
+		case OPTION_ENABLED:
+			printk(KERN_INFO "%s: %s Enabled\n", at_driver_name, opt->name);
+			return 0;
+		case OPTION_DISABLED:
+			printk(KERN_INFO "%s: %s Disabled\n", at_driver_name, opt->name);
+			return 0;
+		}
+		break;
+	case range_option:
+		if (*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
+			printk(KERN_INFO "%s: %s set to %i\n", at_driver_name, opt->name, *value);
+			return 0;
+		}
+		break;
+	case list_option:{
+			int i;
+			struct at_opt_list *ent;
+
+			for (i = 0; i < opt->arg.l.nr; i++) {
+				ent = &opt->arg.l.p[i];
+				if (*value == ent->i) {
+					if (ent->str[0] != '\0')
+						printk(KERN_INFO "%s: %s\n",
+						       at_driver_name, ent->str);
+					return 0;
+				}
+			}
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	printk(KERN_INFO "%s: invalid %s specified (%i) %s\n",
+	       at_driver_name, opt->name, *value, opt->err);
+	*value = opt->def;
+	return -1;
+}
+
+/**
+ * at_check_options - Range Checking for Command Line Parameters
+ * @adapter: board private structure
+ *
+ * This routine checks all command line parameters for valid user
+ * input.  If an invalid value is given, or if no user specified
+ * value exists, a default value is used.  The final value is stored
+ * in a variable in the adapter structure.
+ **/
+void __devinit at_check_options(struct at_adapter *adapter)
+{
+	int bd = adapter->bd_number;
+	if (bd >= AT_MAX_NIC) {
+		printk(KERN_NOTICE "%s: warning: no configuration for board #%i\n", 
+			at_driver_name, bd);
+		printk(KERN_NOTICE "%s: using defaults for all values\n", 
+			at_driver_name);
+	}
+	{			/* Interrupt Moderate Timer */
+		struct at_option opt = {
+			.type = range_option,
+			.name = "Interrupt Moderator Timer",
+			.err = "using default of " 
+				__MODULE_STRING(DEFAULT_INT_MOD_CNT),
+			.def = DEFAULT_INT_MOD_CNT,
+			.arg = {.r =
+				{.min = MIN_INT_MOD_CNT,.max = MAX_INT_MOD_CNT}}
+		};
+		int val;
+		if (num_int_mod_timer > bd) {
+			val = int_mod_timer[bd];
+			at_validate_option(&val, &opt);
+			adapter->imt = (u16) val;
+		} else {
+			adapter->imt = (u16) (opt.def);
+		}
+	}
+
+	{			/* Flsh Vendor */
+		struct at_option opt = {
+			.type = range_option,
+			.name = "SPI Flash Vendor",
+			.err = "using default of "
+			    	__MODULE_STRING(FLASH_VENDOR_DEFAULT),
+			.def = DEFAULT_INT_MOD_CNT,
+			.arg = {.r =
+				{.min = FLASH_VENDOR_MIN,.max =
+				 FLASH_VENDOR_MAX}}
+		};
+		int val;
+		if (num_flash_vendor > bd) {
+			val = flash_vendor[bd];
+			at_validate_option(&val, &opt);
+			adapter->hw.flash_vendor = (u8) val;
+		} else {
+			adapter->hw.flash_vendor = (u8) (opt.def);
+		}
+	}
+}
