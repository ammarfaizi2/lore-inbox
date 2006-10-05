Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWJESXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWJESXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWJESXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:45 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751252AbWJESW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:22:59 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 6/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:05:51 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051105.51259.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:43.0140 (UTC) FILETIME=[3FA3F840:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Ethtool interface.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_ethtool.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_ethtool.c
--- linux-2.6.17/drivers/net/vioc/vioc_ethtool.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_ethtool.c	2006-10-04 
10:36:10.000000000 -0700
@@ -0,0 +1,309 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/errno.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+
+#include <linux/moduleparam.h>
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+#include "driver_version.h"
+
+/* ethtool support for vnic */
+
+#ifdef SIOCETHTOOL
+#include <asm/uaccess.h>
+
+#ifndef ETH_GSTRING_LEN
+#define ETH_GSTRING_LEN 32
+#endif
+
+#ifdef ETHTOOL_OPS_COMPAT
+#include "kcompat_ethtool.c"
+#endif
+
+#define VIOC_READ_REG(R, M, V, viocdev) (\
+       readl((viocdev->ba.virt + GETRELADDR(M, V, R))))
+
+#define VIOC_WRITE_REG(R, M, V, viocdev, value) (\
+       (writel(value, viocdev->ba.virt + GETRELADDR(M, V, R))))
+
+#ifdef ETHTOOL_GSTATS
+struct vnic_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int sizeof_stat;
+	int stat_offset;
+};
+
+#define VNIC_STAT(m) sizeof(((struct vnic_device *)0)->m), \
+                     offsetof(struct vnic_device, m)
+
+static const struct vnic_stats vnic_gstrings_stats[] = {
+	{"rx_packets", VNIC_STAT(net_stats.rx_packets)},
+	{"tx_packets", VNIC_STAT(net_stats.tx_packets)},
+	{"rx_bytes", VNIC_STAT(net_stats.rx_bytes)},
+	{"tx_bytes", VNIC_STAT(net_stats.tx_bytes)},
+	{"rx_errors", VNIC_STAT(net_stats.rx_errors)},
+	{"tx_errors", VNIC_STAT(net_stats.tx_errors)},
+	{"rx_dropped", VNIC_STAT(net_stats.rx_dropped)},
+	{"tx_dropped", VNIC_STAT(net_stats.tx_dropped)},
+	{"multicast", VNIC_STAT(net_stats.multicast)},
+	{"collisions", VNIC_STAT(net_stats.collisions)},
+	{"rx_length_errors", VNIC_STAT(net_stats.rx_length_errors)},
+	{"rx_over_errors", VNIC_STAT(net_stats.rx_over_errors)},
+	{"rx_crc_errors", VNIC_STAT(net_stats.rx_crc_errors)},
+	{"rx_frame_errors", VNIC_STAT(net_stats.rx_frame_errors)},
+	{"rx_fifo_errors", VNIC_STAT(net_stats.rx_fifo_errors)},
+	{"rx_missed_errors", VNIC_STAT(net_stats.rx_missed_errors)},
+	{"tx_aborted_errors", VNIC_STAT(net_stats.tx_aborted_errors)},
+	{"tx_carrier_errors", VNIC_STAT(net_stats.tx_carrier_errors)},
+	{"tx_fifo_errors", VNIC_STAT(net_stats.tx_fifo_errors)},
+	{"tx_heartbeat_errors", VNIC_STAT(net_stats.tx_heartbeat_errors)},
+	{"tx_window_errors", VNIC_STAT(net_stats.tx_window_errors)},
+	{"rx_fragment_errors", VNIC_STAT(vnic_stats.rx_fragment_errors)},
+	{"rx_dropped", VNIC_STAT(vnic_stats.rx_dropped)},
+	{"tx_skb_equeued", VNIC_STAT(vnic_stats.skb_enqueued)},
+	{"tx_skb_freed", VNIC_STAT(vnic_stats.skb_freed)},
+	{"netif_stops", VNIC_STAT(vnic_stats.netif_stops)},
+	{"tx_on_empty_intr", VNIC_STAT(vnic_stats.tx_on_empty_interrupts)},
+	{"tx_headroom_misses", VNIC_STAT(vnic_stats.headroom_misses)},
+	{"tx_headroom_miss_drops", VNIC_STAT(vnic_stats.headroom_miss_drops)},
+	{"tx_ring_size", VNIC_STAT(txq.count)},
+	{"tx_ring_capacity", VNIC_STAT(txq.empty)},
+	{"pkts_till_intr", VNIC_STAT(txq.tx_pkts_til_irq)},
+	{"pkts_till_bell", VNIC_STAT(txq.tx_pkts_til_bell)},
+	{"bells", VNIC_STAT(txq.bells)},
+	{"next_to_use", VNIC_STAT(txq.next_to_use)},
+	{"next_to_clean", VNIC_STAT(txq.next_to_clean)},
+	{"tx_frags", VNIC_STAT(txq.frags)},
+	{"tx_ring_wraps", VNIC_STAT(txq.wraps)},
+	{"tx_ring_fulls", VNIC_STAT(txq.full)}
+};
+
+#define VNIC_STATS_LEN \
+       sizeof(vnic_gstrings_stats) / sizeof(struct vnic_stats)
+#endif				/* ETHTOOL_GSTATS */
+#ifdef ETHTOOL_TEST
+static const char vnic_gstrings_test[][ETH_GSTRING_LEN] = {
+	"Register test  (offline)", "Eeprom test    (offline)",
+	"Interrupt test (offline)", "Loopback test  (offline)",
+	"Link test   (on/offline)"
+};
+
+#define VNIC_TEST_LEN sizeof(vnic_gstrings_test) / ETH_GSTRING_LEN
+#endif				/* ETHTOOL_TEST */
+
+static int vnic_get_settings(struct net_device *netdev,
+			     struct ethtool_cmd *ecmd)
+{
+	ecmd->supported = SUPPORTED_1000baseT_Full;
+	ecmd->advertising = ADVERTISED_TP;
+	ecmd->port = PORT_TP;
+	ecmd->phy_address = 0;	/* !!! Stole from e1000 */
+	ecmd->transceiver = XCVR_INTERNAL;
+	ecmd->duplex = DUPLEX_FULL;
+	ecmd->speed = 3;	/* !!! Stole from e1000 */
+	ecmd->autoneg = 0;
+	return 0;
+}
+
+int vioc_trace;
+
+static u32 vnic_get_msglevel(struct net_device *netdev)
+{
+	return vioc_trace;
+}
+
+static void vnic_set_msglevel(struct net_device *netdev, u32 data)
+{
+	vioc_trace = (int)data;
+}
+
+#define VNIC_REGS_CNT 12
+#define VNIC_REGS_LINE_LEN 80
+static int vnic_get_regs_len(struct net_device *netdev)
+{
+	return (VNIC_REGS_CNT * VNIC_REGS_LINE_LEN);
+}
+
+static void vnic_get_regs(struct net_device *netdev,
+			  struct ethtool_regs *regs, void *p)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct vioc_device *viocdev = vnicdev->viocdev;
+	char *regs_buff = p;
+
+	memset(regs_buff, 0, VNIC_REGS_CNT * VNIC_REGS_LINE_LEN);
+
+	regs->version = 1;
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_GLOBAL, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_GLOBAL, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_DEBUG, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_DEBUG, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_FABRIC, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_FABRIC, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_VNIC_EN, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_VNIC_EN, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_PORT_EN, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_PORT_EN, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_BMC_VNIC_CFG, VIOC_BMC, 0),
+		VIOC_READ_REG(VREG_BMC_VNIC_CFG, VIOC_BMC, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_IHCU_RXDQEN, VIOC_IHCU, 0),
+		VIOC_READ_REG(VREG_IHCU_RXDQEN, VIOC_IHCU, 0, viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id),
+		VIOC_READ_REG(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id,
+			      viocdev));
+	regs_buff += strlen(regs_buff);
+
+	sprintf(regs_buff, "%08Lx = %08x\n",
+		GETRELADDR(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id),
+		VIOC_READ_REG(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id,
+			      viocdev));
+	regs_buff += strlen(regs_buff);
+
+}
+
+static void vnic_get_drvinfo(struct net_device *netdev,
+			     struct ethtool_drvinfo *drvinfo)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct vioc_device *viocdev = vnicdev->viocdev;
+
+	sprintf(drvinfo->driver, VIOC_DRV_MODULE_NAME);
+	strncpy(drvinfo->version, VIOC_DISPLAY_VERSION, 32);
+	sprintf(drvinfo->fw_version, "%02X-%02X", viocdev->vioc_bits_version,
+		viocdev->vioc_bits_subversion);
+	strncpy(drvinfo->bus_info, pci_name(viocdev->pdev), 32);
+	drvinfo->n_stats = VNIC_STATS_LEN;
+	drvinfo->testinfo_len = VNIC_TEST_LEN;
+	drvinfo->regdump_len = vnic_get_regs_len(netdev);
+	drvinfo->eedump_len = 0;
+}
+
+static int vnic_get_stats_count(struct net_device *netdev)
+{
+	return VNIC_STATS_LEN;
+}
+
+static void vnic_get_ethtool_stats(struct net_device *netdev,
+				   struct ethtool_stats *stats, u64 * data)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	int i;
+
+	for (i = 0; i < VNIC_STATS_LEN; i++) {
+		char *p = (char *)vnicdev + vnic_gstrings_stats[i].stat_offset;
+		data[i] = (vnic_gstrings_stats[i].sizeof_stat ==
+			   sizeof(u64)) ? *(u64 *) p : *(u32 *) p;
+	}
+}
+
+static void vnic_get_strings(struct net_device *netdev, u32 stringset,
+			     u8 * data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_TEST:
+		memcpy(data, *vnic_gstrings_test,
+		       VNIC_TEST_LEN * ETH_GSTRING_LEN);
+		break;
+	case ETH_SS_STATS:
+		for (i = 0; i < VNIC_STATS_LEN; i++) {
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       vnic_gstrings_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+		}
+		break;
+	}
+}
+
+struct ethtool_ops vioc_ethtool_ops = {
+	.get_settings = vnic_get_settings,
+	.get_drvinfo = vnic_get_drvinfo,
+	.get_regs_len = vnic_get_regs_len,
+	.get_regs = vnic_get_regs,
+	.get_msglevel = vnic_get_msglevel,
+	.set_msglevel = vnic_set_msglevel,
+	.get_strings = vnic_get_strings,
+	.get_stats_count = vnic_get_stats_count,
+	.get_ethtool_stats = vnic_get_ethtool_stats,
+};
+
+#endif				/* SIOCETHTOOL */


-- 
Misha Tomushev
misha@fabric7.com


