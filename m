Return-Path: <linux-kernel-owner+w=401wt.eu-S1161436AbWLPTsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWLPTsj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbWLPTsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:48:39 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33300 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161424AbWLPTsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:48:37 -0500
X-Greylist: delayed 1855 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 14:48:36 EST
Date: Sat, 16 Dec 2006 20:46:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Divy Le Ray <divy@chelsio.com>
cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/10] cxgb3, p1
In-Reply-To: <4580E3D7.3050708@chelsio.com>
Message-ID: <Pine.LNX.4.61.0612162045010.5411@yvahk01.tjqt.qr>
References: <4580E3D7.3050708@chelsio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I resubmit the patch supporting the latest Chelsio T3 adapter.
> It incorporates the last feedbacks for code cleanup.
> It is built gainst Linus'tree.
>
> We think the driver is now ready to be merged.
> Can you please advise on the next steps for inclusion in 2.6.20 ?
>
> A corresponding monolithic patch is posted at the following URL:
> http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
>
> This driver is required by the Chelsio T3 RDMA driver
> which was updated on 12/10/2006.

Here are some extras that you could source (but don't require a 
resubmit)



---

Cleanup.
Not all unnecessary casts are gone

  - (void)cmpxchg stayed to silence a warning

  - some (u32) in t3_hw.c remain because it's not just an ugly cast,
    but also a truncation. Taking away (u32) without verifying that
    it is invariant with an implicit truncation is not good (and
    I was lazy at verifying it)

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc1/drivers/net/cxgb3/xgmac.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/xgmac.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/xgmac.c
@@ -25,7 +25,7 @@ static inline int macidx(const struct cm
 
 static void xaui_serdes_reset(struct cmac *mac)
 {
-	static unsigned int clear[] = {
+	static const unsigned int clear[] = {
 		F_PWRDN0 | F_PWRDN1, F_RESETPLL01, F_RESET0 | F_RESET1,
 		F_PWRDN2 | F_PWRDN3, F_RESETPLL23, F_RESET2 | F_RESET3
 	};
@@ -38,7 +38,7 @@ static void xaui_serdes_reset(struct cma
 		     F_RESET3 | F_RESET2 | F_RESET1 | F_RESET0 |
 		     F_PWRDN3 | F_PWRDN2 | F_PWRDN1 | F_PWRDN0 |
 		     F_RESETPLL23 | F_RESETPLL01);
-	(void)t3_read_reg(adap, ctrl);
+	t3_read_reg(adap, ctrl);
 	udelay(15);
 
 	for (i = 0; i < ARRAY_SIZE(clear); i++) {
@@ -80,7 +80,7 @@ int t3_mac_reset(struct cmac *mac)
 	unsigned int oft = mac->offset;
 
 	t3_write_reg(adap, A_XGM_RESET_CTRL + oft, F_MAC_RESET_);
-	(void)t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
+	t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
 
 	t3_write_regs(adap, mac_reset_avp, ARRAY_SIZE(mac_reset_avp), oft);
 	t3_set_reg_field(adap, A_XGM_RXFIFO_CFG + oft,
@@ -115,7 +115,7 @@ int t3_mac_reset(struct cmac *mac)
 	else
 		val |= F_RGMII_RESET_ | F_XG2G_RESET_;
 	t3_write_reg(adap, A_XGM_RESET_CTRL + oft, val);
-	(void)t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
+	t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
 	if ((val & F_PCS_RESET_) && adap->params.rev) {
 		msleep(1);
 		t3b_pcs_reset(mac);
Index: linux-2.6.20-rc1/drivers/net/cxgb3/sge.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/sge.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/sge.c
@@ -2160,7 +2160,7 @@ static irqreturn_t t3_intr(int irq, void
 
 	if (likely(w0 | w1)) {
 		t3_write_reg(adap, A_PL_CLI, 0);
-		(void)t3_read_reg(adap, A_PL_CLI);	/* flush */
+		t3_read_reg(adap, A_PL_CLI);	/* flush */
 
 		if (likely(w0))
 			process_responses_gts(adap, q0);
Index: linux-2.6.20-rc1/drivers/net/cxgb3/t3_hw.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/t3_hw.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/t3_hw.c
@@ -15,7 +15,7 @@
 #include "firmware_exports.h"
 
  /**
- *	t3_wait_op_done_val - wait until an operation is completed
+  *	t3_wait_op_done_val - wait until an operation is completed
   *	@adapter: the adapter performing the operation
   *	@reg: the register to check for completion
   *	@mask: a single-bit field within @reg that indicates completion
@@ -84,7 +84,7 @@ void t3_set_reg_field(struct adapter *ad
 	u32 v = t3_read_reg(adapter, addr) & ~mask;
 
 	t3_write_reg(adapter, addr, v | val);
-	(void)t3_read_reg(adapter, addr);	/* flush */
+	t3_read_reg(adapter, addr);	/* flush */
 }
 
 /**
@@ -526,7 +526,7 @@ int t3_seeprom_read(struct adapter *adap
 	if ((addr >= EEPROMSIZE && addr != EEPROM_STAT_ADDR) || (addr & 3))
 		return -EINVAL;
 
-	pci_write_config_word(adapter->pdev, base + PCI_VPD_ADDR, (u16) addr);
+	pci_write_config_word(adapter->pdev, base + PCI_VPD_ADDR, addr);
 	do {
 		udelay(10);
 		pci_read_config_word(adapter->pdev, base + PCI_VPD_ADDR, &val);
@@ -562,7 +562,7 @@ int t3_seeprom_write(struct adapter *ada
 	pci_write_config_dword(adapter->pdev, base + PCI_VPD_DATA,
 			       cpu_to_le32(data));
 	pci_write_config_word(adapter->pdev,base + PCI_VPD_ADDR,
-			      (u16)addr | PCI_VPD_ADDR_F);
+			      addr | PCI_VPD_ADDR_F);
 	do {
 		msleep(1);
 		pci_read_config_word(adapter->pdev, base + PCI_VPD_ADDR, &val);
@@ -634,8 +634,8 @@ static int get_vpd_params(struct adapter
 		p->port_type[0] = uses_xaui(adapter) ? 1 : 2;
 		p->port_type[1] = uses_xaui(adapter) ? 6 : 2;
 	} else {
-		p->port_type[0] = (u8) hex2int(vpd.port0_data[0]);
-		p->port_type[1] = (u8) hex2int(vpd.port1_data[0]);
+		p->port_type[0] = hex2int(vpd.port0_data[0]);
+		p->port_type[1] = hex2int(vpd.port1_data[0]);
 		p->xauicfg[0] = simple_strtoul(vpd.xaui0cfg_data, NULL, 16);
 		p->xauicfg[1] = simple_strtoul(vpd.xaui1cfg_data, NULL, 16);
 	}
@@ -1000,7 +1000,7 @@ void t3_link_changed(struct adapter *ada
 		t3_write_reg(adapter, A_XGM_XAUI_ACT_CTRL + mac->offset,
 			     link_ok ? F_TXACTENABLE | F_RXEN : 0);
 	}
-	lc->link_ok = (unsigned char)link_ok;
+	lc->link_ok = link_ok;
 	lc->speed = speed < 0 ? SPEED_INVALID : speed;
 	lc->duplex = duplex < 0 ? DUPLEX_INVALID : duplex;
 	if (lc->requested_fc & PAUSE_AUTONEG)
@@ -1011,7 +1011,7 @@ void t3_link_changed(struct adapter *ada
 	if (link_ok && speed >= 0 && lc->autoneg == AUTONEG_ENABLE) {
 		/* Set MAC speed, duplex, and flow control to match PHY. */
 		t3_mac_set_speed_duplex_fc(mac, speed, duplex, fc);
-		lc->fc = (unsigned char)fc;
+		lc->fc = fc;
 	}
 
 	t3_os_link_changed(adapter, port_id, link_ok, speed, duplex, fc);
@@ -1047,7 +1047,7 @@ int t3_link_start(struct cphy *phy, stru
 		if (lc->autoneg == AUTONEG_DISABLE) {
 			lc->speed = lc->requested_speed;
 			lc->duplex = lc->requested_duplex;
-			lc->fc = (unsigned char)fc;
+			lc->fc = fc;
 			t3_mac_set_speed_duplex_fc(mac, lc->speed, lc->duplex,
 						   fc);
 			/* Also disables autoneg */
@@ -1057,7 +1057,7 @@ int t3_link_start(struct cphy *phy, stru
 			phy->ops->autoneg_enable(phy);
 	} else {
 		t3_mac_set_speed_duplex_fc(mac, -1, -1, fc);
-		lc->fc = (unsigned char)fc;
+		lc->fc = fc;
 		phy->ops->reset(phy, 0);
 	}
 	return 0;
@@ -1493,7 +1493,7 @@ static int mac_intr_handler(struct adapt
  */
 int t3_phy_intr_handler(struct adapter *adapter)
 {
-	static int intr_gpio_bits[] = { 8, 0x20 };
+	static const int intr_gpio_bits[] = { 8, 0x20 };
 
 	u32 i, cause = t3_read_reg(adapter, A_T3DBG_INT_CAUSE);
 
@@ -1564,7 +1564,7 @@ int t3_slow_intr_handler(struct adapter 
 
 	/* Clear the interrupts just processed. */
 	t3_write_reg(adapter, A_PL_INT_CAUSE0, cause);
-	(void)t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
+	t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
 	return 1;
 }
 
@@ -1618,7 +1618,7 @@ void t3_intr_enable(struct adapter *adap
 	else
 		t3_write_reg(adapter, A_PCIX_INT_ENABLE, PCIX_INTR_MASK);
 	t3_write_reg(adapter, A_PL_INT_ENABLE0, adapter->slow_intr_mask);
-	(void)t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
+	t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
 }
 
 /**
@@ -1631,7 +1631,7 @@ void t3_intr_enable(struct adapter *adap
 void t3_intr_disable(struct adapter *adapter)
 {
 	t3_write_reg(adapter, A_PL_INT_ENABLE0, 0);
-	(void)t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
+	t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
 	adapter->slow_intr_mask = 0;
 }
 
@@ -1643,7 +1643,7 @@ void t3_intr_disable(struct adapter *ada
  */
 void t3_intr_clear(struct adapter *adapter)
 {
-	static unsigned int cause_reg_addr[] = {
+	static const unsigned int cause_reg_addr[] = {
 		A_SG_INT_CAUSE,
 		A_SG_RSPQ_FL_STATUS,
 		A_PCIX_INT_CAUSE,
@@ -1671,7 +1671,7 @@ void t3_intr_clear(struct adapter *adapt
 		t3_write_reg(adapter, cause_reg_addr[i], 0xffffffff);
 
 	t3_write_reg(adapter, A_PL_INT_CAUSE0, 0xffffffff);
-	(void)t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
+	t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
 }
 
 /**
@@ -1777,12 +1777,12 @@ int t3_sge_init_ecntxt(struct adapter *a
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_EC_INDEX(cidx) |
 		     V_EC_CREDITS(credits) | V_EC_GTS(gts_enable));
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, V_EC_SIZE(size) |
-		     V_EC_BASE_LO((u32) base_addr & 0xffff));
+		     V_EC_BASE_LO(base_addr & 0xffff));
 	base_addr >>= 16;
-	t3_write_reg(adapter, A_SG_CONTEXT_DATA2, (u32) base_addr);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA2, base_addr);
 	base_addr >>= 32;
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA3,
-		     V_EC_BASE_HI((u32) base_addr & 0xf) | V_EC_RESPQ(respq) |
+		     V_EC_BASE_HI(base_addr & 0xf) | V_EC_RESPQ(respq) |
 		     V_EC_TYPE(type) | V_EC_GEN(gen) | V_EC_UP_TOKEN(token) |
 		     F_EC_VALID);
 	return t3_sge_write_context(adapter, id, F_EGRESS);
@@ -1815,7 +1815,7 @@ int t3_sge_init_flcntxt(struct adapter *
 		return -EBUSY;
 
 	base_addr >>= 12;
-	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, (u32) base_addr);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, base_addr);
 	base_addr >>= 32;
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA1,
 		     V_FL_BASE_HI((u32) base_addr) |
@@ -1858,7 +1858,7 @@ int t3_sge_init_rspcntxt(struct adapter 
 	base_addr >>= 12;
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_CQ_SIZE(size) |
 		     V_CQ_INDEX(cidx));
-	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, (u32) base_addr);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, base_addr);
 	base_addr >>= 32;
 	if (irq_vec_idx >= 0)
 		intr = V_RQ_MSI_VEC(irq_vec_idx) | F_RQ_INTR_EN;
@@ -1894,7 +1894,7 @@ int t3_sge_init_cqcntxt(struct adapter *
 
 	base_addr >>= 12;
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA0, V_CQ_SIZE(size));
-	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, (u32) base_addr);
+	t3_write_reg(adapter, A_SG_CONTEXT_DATA1, base_addr);
 	base_addr >>= 32;
 	t3_write_reg(adapter, A_SG_CONTEXT_DATA2,
 		     V_CQ_BASE_HI((u32) base_addr) | V_CQ_RSPQ(rspq) |
@@ -2192,8 +2192,8 @@ int t3_read_rss(struct adapter *adapter,
 			val = t3_read_reg(adapter, A_TP_RSS_LKP_TABLE);
 			if (!(val & 0x80000000))
 				return -EAGAIN;
-			*lkup++ = (u8) val;
-			*lkup++ = (u8) (val >> 8);
+			*lkup++ = val;
+			*lkup++ = val >> 8;
 		}
 
 	if (map)
@@ -2203,7 +2203,7 @@ int t3_read_rss(struct adapter *adapter,
 			val = t3_read_reg(adapter, A_TP_RSS_MAP_TABLE);
 			if (!(val & 0x80000000))
 				return -EAGAIN;
-			*map++ = (u16) val;
+			*map++ = val;
 		}
 	return 0;
 }
@@ -2540,7 +2540,7 @@ void t3_load_mtus(struct adapter *adap, 
 		  unsigned short alpha[NCCTRL_WIN],
 		  unsigned short beta[NCCTRL_WIN], unsigned short mtu_cap)
 {
-	static unsigned int avg_pkts[NCCTRL_WIN] = {
+	static const unsigned int avg_pkts[NCCTRL_WIN] = {
 		2, 6, 10, 14, 20, 28, 40, 56, 80, 112, 160, 224, 320, 448, 640,
 		896, 1281, 1792, 2560, 3584, 5120, 7168, 10240, 14336, 20480,
 		28672, 40960, 57344, 81920, 114688, 163840, 229376
@@ -2606,8 +2606,7 @@ void t3_get_cong_cntl_tab(struct adapter
 		for (w = 0; w < NCCTRL_WIN; ++w) {
 			t3_write_reg(adap, A_TP_CCTRL_TABLE,
 				     0xffff0000 | (mtu << 5) | w);
-			incr[mtu][w] = (unsigned short)t3_read_reg(adap,
-								   A_TP_CCTRL_TABLE)
+			incr[mtu][w] = t3_read_reg(adap, A_TP_CCTRL_TABLE)
 			    & 0x1fff;
 		}
 }
@@ -2680,7 +2679,7 @@ void t3_config_trace_filter(struct adapt
 	tp_wr_indirect(adapter, addr++, mask[2]);
 	tp_wr_indirect(adapter, addr++, key[3]);
 	tp_wr_indirect(adapter, addr, mask[3]);
-	(void)t3_read_reg(adapter, A_TP_PIO_DATA);
+	t3_read_reg(adapter, A_TP_PIO_DATA);
 }
 
 /**
@@ -2796,7 +2795,7 @@ static int calibrate_xgm(struct adapter 
 
 		for (i = 0; i < 5; ++i) {
 			t3_write_reg(adapter, A_XGM_XAUI_IMP, 0);
-			(void)t3_read_reg(adapter, A_XGM_XAUI_IMP);
+			t3_read_reg(adapter, A_XGM_XAUI_IMP);
 			msleep(1);
 			v = t3_read_reg(adapter, A_XGM_XAUI_IMP);
 			if (!(v & (F_XGM_CALFAULT | F_CALBUSY))) {
@@ -2849,7 +2848,7 @@ struct mc7_timing_params {
 static int wrreg_wait(struct adapter *adapter, unsigned int addr, u32 val)
 {
 	t3_write_reg(adapter, addr, val);
-	(void)t3_read_reg(adapter, addr);	/* flush */
+	t3_read_reg(adapter, addr);	/* flush */
 	if (!(t3_read_reg(adapter, addr) & F_BUSY))
 		return 0;
 	CH_ERR(adapter, "write to MC7 register 0x%x timed out\n", addr);
@@ -2858,7 +2857,9 @@ static int wrreg_wait(struct adapter *ad
 
 static int mc7_init(struct mc7 *mc7, unsigned int mc7_clock, int mem_type)
 {
-	static unsigned int mc7_mode[] = { 0x632, 0x642, 0x652, 0x432, 0x442 };
+	static const unsigned int mc7_mode[] = {
+		0x632, 0x642, 0x652, 0x432, 0x442,
+	};
 	static const struct mc7_timing_params mc7_timings[] = {
 		{12, 3, 4, {20, 28, 34, 52, 0}, 15, 6, 4},
 		{12, 4, 5, {20, 28, 34, 52, 0}, 16, 7, 4},
@@ -2883,7 +2884,7 @@ static int mc7_init(struct mc7 *mc7, uns
 
 	if (!slow) {
 		t3_write_reg(adapter, mc7->offset + A_MC7_CAL, F_SGL_CAL_EN);
-		(void)t3_read_reg(adapter, mc7->offset + A_MC7_CAL);
+		t3_read_reg(adapter, mc7->offset + A_MC7_CAL);
 		msleep(1);
 		if (t3_read_reg(adapter, mc7->offset + A_MC7_CAL) &
 		    (F_BUSY | F_SGL_CAL_EN | F_CAL_FAULT)) {
@@ -2901,7 +2902,7 @@ static int mc7_init(struct mc7 *mc7, uns
 
 	t3_write_reg(adapter, mc7->offset + A_MC7_CFG,
 		     val | F_CLKEN | F_TERM150);
-	(void)t3_read_reg(adapter, mc7->offset + A_MC7_CFG);	/* flush */
+	t3_read_reg(adapter, mc7->offset + A_MC7_CFG);	/* flush */
 
 	if (!slow)
 		t3_set_reg_field(adapter, mc7->offset + A_MC7_DLL, F_DLLENB,
@@ -2936,7 +2937,7 @@ static int mc7_init(struct mc7 *mc7, uns
 
 	t3_write_reg(adapter, mc7->offset + A_MC7_REF,
 		     F_PERREFEN | V_PREREFDIV(mc7_clock));
-	(void)t3_read_reg(adapter, mc7->offset + A_MC7_REF);	/* flush */
+	t3_read_reg(adapter, mc7->offset + A_MC7_REF);	/* flush */
 
 	t3_write_reg(adapter, mc7->offset + A_MC7_ECC, F_ECCGENEN | F_ECCCHKEN);
 	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_DATA, 0);
@@ -2944,7 +2945,7 @@ static int mc7_init(struct mc7 *mc7, uns
 	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_ADDR_END,
 		     (mc7->size << width) - 1);
 	t3_write_reg(adapter, mc7->offset + A_MC7_BIST_OP, V_OP(1));
-	(void)t3_read_reg(adapter, mc7->offset + A_MC7_BIST_OP);	/* flush */
+	t3_read_reg(adapter, mc7->offset + A_MC7_BIST_OP);	/* flush */
 
 	attempts = 50;
 	do {
@@ -2966,13 +2967,13 @@ out_fail:
 
 static void config_pcie(struct adapter *adap)
 {
-	static u16 ack_lat[4][6] = {
+	static const u16 ack_lat[][6] = {
 		{237, 416, 559, 1071, 2095, 4143},
 		{128, 217, 289, 545, 1057, 2081},
 		{73, 118, 154, 282, 538, 1050},
 		{67, 107, 86, 150, 278, 534}
 	};
-	static u16 rpl_tmr[4][6] = {
+	static const u16 rpl_tmr[][6] = {
 		{711, 1248, 1677, 3213, 6285, 12429},
 		{384, 651, 867, 1635, 3171, 6243},
 		{219, 354, 462, 846, 1614, 3150},
@@ -3067,7 +3068,7 @@ int t3_init_hw(struct adapter *adapter, 
 	t3_write_reg(adapter, A_CIM_HOST_ACC_DATA, vpd->uclk | fw_params);
 	t3_write_reg(adapter, A_CIM_BOOT_CFG,
 		     V_BOOTADDR(FW_FLASH_BOOT_ADDR >> 2));
-	(void)t3_read_reg(adapter, A_CIM_BOOT_CFG);	/* flush */
+	t3_read_reg(adapter, A_CIM_BOOT_CFG);	/* flush */
 
 	do {			/* wait for uP to initialize */
 		msleep(20);
@@ -3206,13 +3207,13 @@ void early_hw_init(struct adapter *adapt
 
 	/* Enable MAC clocks so we can access the registers */
 	t3_write_reg(adapter, A_XGM_PORT_CFG, val);
-	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+	t3_read_reg(adapter, A_XGM_PORT_CFG);
 
 	val |= F_CLKDIVRESET_;
 	t3_write_reg(adapter, A_XGM_PORT_CFG, val);
-	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+	t3_read_reg(adapter, A_XGM_PORT_CFG);
 	t3_write_reg(adapter, XGM_REG(A_XGM_PORT_CFG, 1), val);
-	(void)t3_read_reg(adapter, A_XGM_PORT_CFG);
+	t3_read_reg(adapter, A_XGM_PORT_CFG);
 }
 
 /*
#<EOF>

	-`J'
-- 
