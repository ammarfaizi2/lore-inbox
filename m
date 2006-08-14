Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWHNQaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWHNQaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWHNQaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:30:35 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:37042 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751546AbWHNQad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:30:33 -0400
Message-ID: <44E0A526.2010704@de.ibm.com>
Date: Mon, 14 Aug 2006 18:30:30 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 4/7] ehea: ethtool interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/ehea/ehea_ethtool.c |  271 ++++++++++++++++++++++++++++++++++++++++
  1 file changed, 271 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_ethtool.c	2006-08-14 09:05:14.129553232 -0700
@@ -0,0 +1,271 @@
+/*
+ *  linux/drivers/net/ehea/ehea_ethtool.c
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Heiko-Joerg Schick <schickhj@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "ehea.h"
+#include "ehea_phyp.h"
+
+
+static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_4 *cb4 = NULL;
+
+	EDEB_EN(7, "net_device=%p", dev);
+
+	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if(!cb4) {
+		EDEB_ERR(4, "No memory for cb4");
+		goto get_settings_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB4,
+				      H_PORT_CB4_ALL,
+				      cb4);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_port failed for cb4");
+		kfree(cb4);
+		goto get_settings_exit;
+	}
+
+	EDEB_DMP(7, (u8*)cb4,
+		 sizeof(struct hcp_query_ehea_port_cb_4), "After HCALL");
+
+	if (netif_carrier_ok(dev)) {
+		switch(cb4->port_speed){
+		case H_PORT_SPEED_10M_H:
+			cmd->speed = SPEED_10;
+			cmd->duplex = DUPLEX_HALF;
+			break;
+		case H_PORT_SPEED_10M_F:
+			cmd->speed = SPEED_10;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_100M_H:
+			cmd->speed = SPEED_100;
+			cmd->duplex = DUPLEX_HALF;
+			break;
+		case H_PORT_SPEED_100M_F:
+			cmd->speed = SPEED_100;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_1G_F:
+			cmd->speed = SPEED_1000;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		case H_PORT_SPEED_10G_F:
+			cmd->speed = SPEED_10000;
+			cmd->duplex = DUPLEX_FULL;
+			break;
+		}
+	} else {
+		cmd->speed = -1;
+		cmd->duplex = -1;
+	}
+
+	cmd->supported =
+	    (SUPPORTED_10000baseT_Full | SUPPORTED_1000baseT_Full
+	     | SUPPORTED_100baseT_Full |  SUPPORTED_100baseT_Half
+	     | SUPPORTED_10baseT_Full | SUPPORTED_10baseT_Half
+	     | SUPPORTED_Autoneg | SUPPORTED_FIBRE);
+	cmd->advertising =
+	    (ADVERTISED_10000baseT_Full | ADVERTISED_Autoneg
+	     | ADVERTISED_FIBRE);
+	cmd->port = PORT_FIBRE;
+	cmd->autoneg = AUTONEG_ENABLE;
+
+	kfree(cb4);
+	return 0;
+
+get_settings_exit:
+	EDEB_EX(7, "");
+	return 1;
+}
+
+static void netdev_get_drvinfo(struct net_device *dev,
+			       struct ethtool_drvinfo *info)
+{
+	printk("get drvinfo\n");
+	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
+	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
+}
+
+static u32 netdev_get_msglevel(struct net_device *dev)
+{
+	EDEB(7, "");
+	return (u32)ehea_trace_level;
+}
+
+static void netdev_set_msglevel(struct net_device *dev, u32 value)
+{
+	EDEB(7, "trace level set to %x", value);
+	ehea_trace_level = (int)value;
+}
+
+
+static char ehea_ethtool_stats_keys[][ETH_GSTRING_LEN] = {
+	{"poll_max_processed"},
+	{"queue_stopped"},
+	{"min_swqe_avail"},
+	{"poll_receive_err"},
+	{"pkt_send"},
+	{"pkt_xmit"},
+	{"send_tasklet"},
+	{"ehea_poll"},
+	{"nwqe"},
+	{"swqe_available_0"},
+	{"rxo"},
+	{"rx64"},
+	{"rx65"},
+	{"rx128"},
+	{"rx256"},
+	{"rx512"},
+	{"rx1024"},
+	{"txo"},
+	{"tx64"},
+	{"tx65"},
+	{"tx128"},
+	{"tx256"},
+	{"tx512"},
+	{"tx1024"},
+};
+
+static void netdev_get_strings(struct net_device *dev,
+				     u32 stringset, u8 * data)
+{
+	switch (stringset) {
+	case ETH_SS_TEST:
+		break;
+	case ETH_SS_STATS:
+		memcpy(data, &ehea_ethtool_stats_keys,
+		       sizeof(ehea_ethtool_stats_keys));
+	}
+}
+
+static int netdev_get_stats_count(struct net_device *dev)
+{
+	return ARRAY_SIZE(ehea_ethtool_stats_keys);
+}
+
+
+static void netdev_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	int i = 0;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+	struct ehea_port_res *pr = &port->port_res[0];
+	struct port_state *p_state = &pr->p_state;
+	struct hcp_query_ehea_port_cb_6 *cb6 = NULL;
+
+	EDEB_EN(7, "net_device=%p", dev);
+
+	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if(!cb6) {
+		EDEB_ERR(4, "No memory for cb6");
+		goto stats_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB6,
+				      H_PORT_CB6_ALL,
+				      cb6);
+
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "query_ehea_port failed for cb6");
+
+	EDEB_DMP(7, (u8*)cb6,
+		 sizeof(struct hcp_query_ehea_port_cb_6), "After HCALL");
+	data[i++] = p_state->poll_max_processed;
+	data[i++] = p_state->queue_stopped;
+	data[i++] = p_state->min_swqe_avail;
+	data[i++] = p_state->poll_receive_errors;
+	data[i++] = p_state->pkt_send;
+	data[i++] = p_state->pkt_xmit;
+	data[i++] = p_state->send_tasklet;
+	data[i++] = p_state->ehea_poll;
+	data[i++] = p_state->nwqe;
+	data[i++] = atomic_read(&port->port_res[0].swqe_avail);
+
+	data[i++] = cb6->rxo;
+	data[i++] = cb6->rx64;
+	data[i++] = cb6->rx65;
+	data[i++] = cb6->rx128;
+	data[i++] = cb6->rx256;
+	data[i++] = cb6->rx512;
+	data[i++] = cb6->rx1024;
+	data[i++] = cb6->txo;
+	data[i++] = cb6->tx64;
+	data[i++] = cb6->tx65;
+	data[i++] = cb6->tx128;
+	data[i++] = cb6->tx256;
+	data[i++] = cb6->tx512;
+	data[i++] = cb6->tx1024;
+
+	kfree(cb6);
+stats_exit:
+	EDEB_EX(7, "");
+}
+
+struct ethtool_ops ehea_ethtool_ops = {
+	.get_settings = netdev_get_settings,
+	.get_drvinfo = netdev_get_drvinfo,
+	.get_msglevel = netdev_get_msglevel,
+	.set_msglevel = netdev_set_msglevel,
+        .get_link = ethtool_op_get_link,
+        .get_tx_csum = ethtool_op_get_tx_csum,
+	.set_tx_csum = ethtool_op_set_tx_csum,
+	.get_sg = ethtool_op_get_sg,
+	.set_sg = ethtool_op_set_sg,
+	.get_tso = ethtool_op_get_tso,
+	.set_tso = ethtool_op_set_tso,
+	.get_strings = netdev_get_strings,
+	.get_stats_count = netdev_get_stats_count,
+	.get_ethtool_stats = netdev_get_ethtool_stats,
+	.set_settings = NULL,
+	.nway_reset = NULL,
+	.get_pauseparam = NULL,
+	.set_pauseparam = NULL,
+	.get_rx_csum = NULL,
+	.set_rx_csum = NULL,
+	.phys_id = NULL,
+	.self_test = NULL,
+	.self_test_count = NULL
+};
+
+void ehea_set_ethtool_ops(struct net_device *netdev)
+{
+	SET_ETHTOOL_OPS(netdev, &ehea_ethtool_ops);
+}


