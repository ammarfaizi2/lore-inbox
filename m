Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTLWXwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLWXwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:52:38 -0500
Received: from fmr99.intel.com ([192.55.52.32]:58258 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262827AbTLWXwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:52:33 -0500
Date: Tue, 23 Dec 2003 16:29:15 -0800 (PST)
From: "Feldman, Scott" <scott.feldman@intel.com>
X-X-Sender: scott.feldman@localhost.localdomain
Reply-To: "Feldman, Scott" <scott.feldman@intel.com>
To: Ethan Weinstein <lists@stinkfoot.org>
cc: Hans-Peter Jansen <hpj@urpla.net>, <linux-kernel@vger.kernel.org>
Subject: Re: minor e1000 bug
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103424209@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0312231618590.28409-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003, Ethan Weinstein wrote:

> It'd be fantastic if we could get this implememted. I'm very pleased
> with the quality of this driver save for this one small issue.  I'd be
> glad to help test code if necessary as I have multiple systems using
> e1000's, and several are testboxes.  It'd be nice to have some
> semi-realtime stats from these cards.

Ok, this is against 2.6.0, so you'll need to hand adjust it for other 
kernels.  Let me know if you see any issues.

-scott


--- linux-2.6.0/drivers/net/e1000/e1000_main.c.orig	2003-12-23 15:24:20.000000000 -0800
+++ linux-2.6.0/drivers/net/e1000/e1000_main.c	2003-12-23 16:12:39.000000000 -0800
@@ -119,6 +119,7 @@
 void e1000_down(struct e1000_adapter *adapter);
 void e1000_reset(struct e1000_adapter *adapter);
 int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
+void e1000_update_stats(struct e1000_adapter *adapter);
 
 static int e1000_init_module(void);
 static void e1000_exit_module(void);
@@ -144,7 +145,6 @@
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
 static int e1000_change_mtu(struct net_device *netdev, int new_mtu);
 static int e1000_set_mac(struct net_device *netdev, void *p);
-static void e1000_update_stats(struct e1000_adapter *adapter);
 static inline void e1000_irq_disable(struct e1000_adapter *adapter);
 static inline void e1000_irq_enable(struct e1000_adapter *adapter);
 static irqreturn_t e1000_intr(int irq, void *data, struct pt_regs *regs);
@@ -1415,6 +1415,17 @@
 	}
 
 	e1000_update_stats(adapter);
+
+	adapter->hw.tx_packet_delta = adapter->stats.tpt - adapter->tpt_old;
+	adapter->tpt_old = adapter->stats.tpt;
+	adapter->hw.collision_delta = adapter->stats.colc - adapter->colc_old;
+	adapter->colc_old = adapter->stats.colc;
+	
+	adapter->gorcl = adapter->stats.gorcl - adapter->gorcl_old;
+	adapter->gorcl_old = adapter->stats.gorcl;
+	adapter->gotcl = adapter->stats.gotcl - adapter->gotcl_old;
+	adapter->gotcl_old = adapter->stats.gotcl;
+
 	e1000_update_adaptive(&adapter->hw);
 
 	if(!netif_carrier_ok(netdev)) {
@@ -1860,6 +1871,7 @@
 {
 	struct e1000_adapter *adapter = netdev->priv;
 
+	e1000_update_stats(adapter);
 	return &adapter->net_stats;
 }
 
@@ -1918,7 +1930,7 @@
  * @adapter: board private structure
  **/
 
-static void
+void
 e1000_update_stats(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
@@ -1936,8 +1948,7 @@
 
 	adapter->stats.crcerrs += E1000_READ_REG(hw, CRCERRS);
 	adapter->stats.gprc += E1000_READ_REG(hw, GPRC);
-	adapter->gorcl = E1000_READ_REG(hw, GORCL);
-	adapter->stats.gorcl += adapter->gorcl;
+	adapter->stats.gorcl += E1000_READ_REG(hw, GORCL);
 	adapter->stats.gorch += E1000_READ_REG(hw, GORCH);
 	adapter->stats.bprc += E1000_READ_REG(hw, BPRC);
 	adapter->stats.mprc += E1000_READ_REG(hw, MPRC);
@@ -1949,8 +1960,6 @@
 	adapter->stats.prc1023 += E1000_READ_REG(hw, PRC1023);
 	adapter->stats.prc1522 += E1000_READ_REG(hw, PRC1522);
 
-	spin_unlock_irqrestore(&adapter->stats_lock, flags);
-
 	/* the rest of the counters are only modified here */
 
 	adapter->stats.symerrs += E1000_READ_REG(hw, SYMERRS);
@@ -1968,8 +1977,7 @@
 	adapter->stats.xofftxc += E1000_READ_REG(hw, XOFFTXC);
 	adapter->stats.fcruc += E1000_READ_REG(hw, FCRUC);
 	adapter->stats.gptc += E1000_READ_REG(hw, GPTC);
-	adapter->gotcl = E1000_READ_REG(hw, GOTCL);
-	adapter->stats.gotcl += adapter->gotcl;
+	adapter->stats.gotcl += E1000_READ_REG(hw, GOTCL);
 	adapter->stats.gotch += E1000_READ_REG(hw, GOTCH);
 	adapter->stats.rnbc += E1000_READ_REG(hw, RNBC);
 	adapter->stats.ruc += E1000_READ_REG(hw, RUC);
@@ -2051,6 +2059,8 @@
 		   !e1000_read_phy_reg(hw, M88E1000_RX_ERR_CNTR, &phy_tmp))
 			adapter->phy_stats.receive_errors += phy_tmp;
 	}
+
+	spin_unlock_irqrestore(&adapter->stats_lock, flags);
 }
 
 /**
--- linux-2.6.0/drivers/net/e1000/e1000_ethtool.c.orig	2003-12-23 15:27:54.000000000 -0800
+++ linux-2.6.0/drivers/net/e1000/e1000_ethtool.c	2003-12-23 15:31:10.000000000 -0800
@@ -39,6 +39,7 @@
 extern void e1000_down(struct e1000_adapter *adapter);
 extern void e1000_reset(struct e1000_adapter *adapter);
 extern int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
+extern void e1000_update_stats(struct e1000_adapter *adapter);
 
 struct e1000_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -1522,6 +1523,7 @@
 		} stats = { {ETHTOOL_GSTATS, E1000_STATS_LEN} };
 		int i;
 
+		e1000_update_stats(adapter);
 		for(i = 0; i < E1000_STATS_LEN; i++)
 			stats.data[i] = (e1000_gstrings_stats[i].sizeof_stat ==
 					sizeof(uint64_t)) ?
--- linux-2.6.0/drivers/net/e1000/e1000.h.orig	2003-12-23 16:09:14.000000000 -0800
+++ linux-2.6.0/drivers/net/e1000/e1000.h	2003-12-23 16:11:30.000000000 -0800
@@ -196,6 +196,9 @@
 	uint32_t tx_int_delay;
 	uint32_t tx_abs_int_delay;
 	uint32_t gotcl;
+	uint64_t gotcl_old;
+	uint64_t tpt_old;
+	uint64_t colc_old;
 	uint32_t tx_fifo_head;
 	uint32_t tx_head_addr;
 	uint32_t tx_fifo_size;
@@ -210,6 +213,7 @@
 	uint32_t rx_abs_int_delay;
 	boolean_t rx_csum;
 	uint32_t gorcl;
+	uint64_t gorcl_old;
 
 	/* Interrupt Throttle Rate */
 	uint32_t itr;

