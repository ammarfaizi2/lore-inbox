Return-Path: <linux-kernel-owner+w=401wt.eu-S1751980AbWLNGPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWLNGPf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWLNGPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:15:12 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:8716 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbWLNGO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:14:59 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:14:57 EST
From: Divy Le Ray <None@chelsio.com>
Subject: [PATCH 6/10] cxgb3 - on board memory, MAC and PHY
Date: Wed, 13 Dec 2006 21:43:19 -0800
To: jeff@garzik.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20061214054319.5858.73231.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divy Le Ray <divy@chelsio.com>

This patch implements on board memory, MAC and PHY management
for the Chelsio T3 network adapter's driver.

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---

 drivers/net/cxgb3/ael1002.c |  231 ++++++++++++++++++++++
 drivers/net/cxgb3/mc5.c     |  453 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/cxgb3/vsc8211.c |  208 ++++++++++++++++++++
 drivers/net/cxgb3/xgmac.c   |  389 +++++++++++++++++++++++++++++++++++++
 4 files changed, 1281 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cxgb3/ael1002.c b/drivers/net/cxgb3/ael1002.c
new file mode 100755
index 0000000..93a90d8
--- /dev/null
+++ b/drivers/net/cxgb3/ael1002.c
@@ -0,0 +1,231 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver.
+ *
+ * Copyright (C) 2005-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#include "common.h"
+#include "regs.h"
+
+enum {
+	AEL100X_TX_DISABLE = 9,
+	AEL100X_TX_CONFIG1 = 0xc002,
+	AEL1002_PWR_DOWN_HI = 0xc011,
+	AEL1002_PWR_DOWN_LO = 0xc012,
+	AEL1002_XFI_EQL = 0xc015,
+	AEL1002_LB_EN = 0xc017,
+
+	LASI_CTRL = 0x9002,
+	LASI_STAT = 0x9005
+};
+
+static void ael100x_txon(struct cphy *phy)
+{
+	int tx_on_gpio = phy->addr == 0 ? F_GPIO7_OUT_VAL : F_GPIO2_OUT_VAL;
+
+	msleep(100);
+	t3_set_reg_field(phy->adapter, A_T3DBG_GPIO_EN, 0, tx_on_gpio);
+	msleep(30);
+}
+
+static int ael1002_power_down(struct cphy *phy, int enable)
+{
+	int err;
+
+	err = mdio_write(phy, MDIO_DEV_PMA_PMD, AEL100X_TX_DISABLE, !!enable);
+	if (!err)
+		err = t3_mdio_change_bits(phy, MDIO_DEV_PMA_PMD, MII_BMCR,
+					  BMCR_PDOWN, enable ? BMCR_PDOWN : 0);
+	return err;
+}
+
+static int ael1002_reset(struct cphy *phy, int wait)
+{
+	int err;
+
+	if ((err = ael1002_power_down(phy, 0)) ||
+	    (err = mdio_write(phy, MDIO_DEV_PMA_PMD, AEL100X_TX_CONFIG1, 1)) ||
+	    (err = mdio_write(phy, MDIO_DEV_PMA_PMD, AEL1002_PWR_DOWN_HI, 0)) ||
+	    (err = mdio_write(phy, MDIO_DEV_PMA_PMD, AEL1002_PWR_DOWN_LO, 0)) ||
+	    (err = mdio_write(phy, MDIO_DEV_PMA_PMD, AEL1002_XFI_EQL, 0x18)) ||
+	    (err = t3_mdio_change_bits(phy, MDIO_DEV_PMA_PMD, AEL1002_LB_EN,
+				       0, 1 << 5)))
+		return err;
+	return 0;
+}
+
+static int ael1002_intr_noop(struct cphy *phy)
+{
+	return 0;
+}
+
+static int ael100x_get_link_status(struct cphy *phy, int *link_ok,
+				   int *speed, int *duplex, int *fc)
+{
+	if (link_ok) {
+		unsigned int status;
+		int err = mdio_read(phy, MDIO_DEV_PMA_PMD, MII_BMSR, &status);
+
+		/*
+		 * BMSR_LSTATUS is latch-low, so if it is 0 we need to read it
+		 * once more to get the current link state.
+		 */
+		if (!err && !(status & BMSR_LSTATUS))
+			err = mdio_read(phy, MDIO_DEV_PMA_PMD, MII_BMSR,
+					&status);
+		if (err)
+			return err;
+		*link_ok = !!(status & BMSR_LSTATUS);
+	}
+	if (speed)
+		*speed = SPEED_10000;
+	if (duplex)
+		*duplex = DUPLEX_FULL;
+	return 0;
+}
+
+static struct cphy_ops ael1002_ops = {
+	.reset = ael1002_reset,
+	.intr_enable = ael1002_intr_noop,
+	.intr_disable = ael1002_intr_noop,
+	.intr_clear = ael1002_intr_noop,
+	.intr_handler = ael1002_intr_noop,
+	.get_link_status = ael100x_get_link_status,
+	.power_down = ael1002_power_down,
+};
+
+void t3_ael1002_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops)
+{
+	cphy_init(phy, adapter, phy_addr, &ael1002_ops, mdio_ops);
+	ael100x_txon(phy);
+}
+
+static int ael1006_reset(struct cphy *phy, int wait)
+{
+	return t3_phy_reset(phy, MDIO_DEV_PMA_PMD, wait);
+}
+
+static int ael1006_intr_enable(struct cphy *phy)
+{
+	return mdio_write(phy, MDIO_DEV_PMA_PMD, LASI_CTRL, 1);
+}
+
+static int ael1006_intr_disable(struct cphy *phy)
+{
+	return mdio_write(phy, MDIO_DEV_PMA_PMD, LASI_CTRL, 0);
+}
+
+static int ael1006_intr_clear(struct cphy *phy)
+{
+	u32 val;
+
+	return mdio_read(phy, MDIO_DEV_PMA_PMD, LASI_STAT, &val);
+}
+
+static int ael1006_intr_handler(struct cphy *phy)
+{
+	unsigned int status;
+	int err = mdio_read(phy, MDIO_DEV_PMA_PMD, LASI_STAT, &status);
+
+	if (err)
+		return err;
+	return (status & 1) ? cphy_cause_link_change : 0;
+}
+
+static int ael1006_power_down(struct cphy *phy, int enable)
+{
+	return t3_mdio_change_bits(phy, MDIO_DEV_PMA_PMD, MII_BMCR,
+				   BMCR_PDOWN, enable ? BMCR_PDOWN : 0);
+}
+
+static struct cphy_ops ael1006_ops = {
+	.reset = ael1006_reset,
+	.intr_enable = ael1006_intr_enable,
+	.intr_disable = ael1006_intr_disable,
+	.intr_clear = ael1006_intr_clear,
+	.intr_handler = ael1006_intr_handler,
+	.get_link_status = ael100x_get_link_status,
+	.power_down = ael1006_power_down,
+};
+
+void t3_ael1006_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops)
+{
+	cphy_init(phy, adapter, phy_addr, &ael1006_ops, mdio_ops);
+	ael100x_txon(phy);
+}
+
+static struct cphy_ops qt2045_ops = {
+	.reset = ael1006_reset,
+	.intr_enable = ael1006_intr_enable,
+	.intr_disable = ael1006_intr_disable,
+	.intr_clear = ael1006_intr_clear,
+	.intr_handler = ael1006_intr_handler,
+	.get_link_status = ael100x_get_link_status,
+	.power_down = ael1006_power_down,
+};
+
+void t3_qt2045_phy_prep(struct cphy *phy, struct adapter *adapter,
+			int phy_addr, const struct mdio_ops *mdio_ops)
+{
+	unsigned int stat;
+
+	cphy_init(phy, adapter, phy_addr, &qt2045_ops, mdio_ops);
+
+	/*
+	 * Some cards where the PHY is supposed to be at address 0 actually
+	 * have it at 1.
+	 */
+	if (!phy_addr && !mdio_read(phy, MDIO_DEV_PMA_PMD, MII_BMSR, &stat) &&
+	    stat == 0xffff)
+		phy->addr = 1;
+}
+
+static int xaui_direct_reset(struct cphy *phy, int wait)
+{
+	return 0;
+}
+
+static int xaui_direct_get_link_status(struct cphy *phy, int *link_ok,
+				       int *speed, int *duplex, int *fc)
+{
+	if (link_ok) {
+		unsigned int status;
+
+		status = t3_read_reg(phy->adapter,
+				     XGM_REG(A_XGM_SERDES_STAT0, phy->addr));
+		*link_ok = !(status & F_LOWSIG0);
+	}
+	if (speed)
+		*speed = SPEED_10000;
+	if (duplex)
+		*duplex = DUPLEX_FULL;
+	return 0;
+}
+
+static int xaui_direct_power_down(struct cphy *phy, int enable)
+{
+	return 0;
+}
+
+static struct cphy_ops xaui_direct_ops = {
+	.reset = xaui_direct_reset,
+	.intr_enable = ael1002_intr_noop,
+	.intr_disable = ael1002_intr_noop,
+	.intr_clear = ael1002_intr_noop,
+	.intr_handler = ael1002_intr_noop,
+	.get_link_status = xaui_direct_get_link_status,
+	.power_down = xaui_direct_power_down,
+};
+
+void t3_xaui_direct_phy_prep(struct cphy *phy, struct adapter *adapter,
+			     int phy_addr, const struct mdio_ops *mdio_ops)
+{
+	cphy_init(phy, adapter, 1, &xaui_direct_ops, mdio_ops);
+}
diff --git a/drivers/net/cxgb3/mc5.c b/drivers/net/cxgb3/mc5.c
new file mode 100755
index 0000000..44fa9ea
--- /dev/null
+++ b/drivers/net/cxgb3/mc5.c
@@ -0,0 +1,453 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver.
+ *
+ * Copyright (C) 2003-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#include "common.h"
+#include "regs.h"
+
+enum {
+	IDT75P52100 = 4,
+	IDT75N43102 = 5
+};
+
+/* DBGI command mode */
+enum {
+	DBGI_MODE_MBUS = 0,
+	DBGI_MODE_IDT52100 = 5
+};
+
+/* IDT 75P52100 commands */
+#define IDT_CMD_READ   0
+#define IDT_CMD_WRITE  1
+#define IDT_CMD_SEARCH 2
+#define IDT_CMD_LEARN  3
+
+/* IDT LAR register address and value for 144-bit mode (low 32 bits) */
+#define IDT_LAR_ADR0   	0x180006
+#define IDT_LAR_MODE144	0xffff0000
+
+/* IDT SCR and SSR addresses (low 32 bits) */
+#define IDT_SCR_ADR0  0x180000
+#define IDT_SSR0_ADR0 0x180002
+#define IDT_SSR1_ADR0 0x180004
+
+/* IDT GMR base address (low 32 bits) */
+#define IDT_GMR_BASE_ADR0 0x180020
+
+/* IDT data and mask array base addresses (low 32 bits) */
+#define IDT_DATARY_BASE_ADR0 0
+#define IDT_MSKARY_BASE_ADR0 0x80000
+
+/* IDT 75N43102 commands */
+#define IDT4_CMD_SEARCH144 3
+#define IDT4_CMD_WRITE     4
+#define IDT4_CMD_READ      5
+
+/* IDT 75N43102 SCR address (low 32 bits) */
+#define IDT4_SCR_ADR0  0x3
+
+/* IDT 75N43102 GMR base addresses (low 32 bits) */
+#define IDT4_GMR_BASE0 0x10
+#define IDT4_GMR_BASE1 0x20
+#define IDT4_GMR_BASE2 0x30
+
+/* IDT 75N43102 data and mask array base addresses (low 32 bits) */
+#define IDT4_DATARY_BASE_ADR0 0x1000000
+#define IDT4_MSKARY_BASE_ADR0 0x2000000
+
+#define MAX_WRITE_ATTEMPTS 5
+
+#define MAX_ROUTES 2048
+
+/*
+ * Issue a command to the TCAM and wait for its completion.  The address and
+ * any data required by the command must have been setup by the caller.
+ */
+static int mc5_cmd_write(struct adapter *adapter, u32 cmd)
+{
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_CMD, cmd);
+	return t3_wait_op_done(adapter, A_MC5_DB_DBGI_RSP_STATUS,
+			       F_DBGIRSPVALID, 1, MAX_WRITE_ATTEMPTS, 1);
+}
+
+static inline void dbgi_wr_addr3(struct adapter *adapter, u32 v1, u32 v2,
+				 u32 v3)
+{
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_ADDR0, v1);
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_ADDR1, v2);
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_ADDR2, v3);
+}
+
+static inline void dbgi_wr_data3(struct adapter *adapter, u32 v1, u32 v2,
+				 u32 v3)
+{
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_DATA0, v1);
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_DATA1, v2);
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_DATA2, v3);
+}
+
+static inline void dbgi_rd_rsp3(struct adapter *adapter, u32 *v1, u32 *v2,
+				u32 *v3)
+{
+	*v1 = t3_read_reg(adapter, A_MC5_DB_DBGI_RSP_DATA0);
+	*v2 = t3_read_reg(adapter, A_MC5_DB_DBGI_RSP_DATA1);
+	*v3 = t3_read_reg(adapter, A_MC5_DB_DBGI_RSP_DATA2);
+}
+
+/*
+ * Write data to the TCAM register at address (0, 0, addr_lo) using the TCAM
+ * command cmd.  The data to be written must have been set up by the caller.
+ * Returns -1 on failure, 0 on success.
+ */
+static int mc5_write(struct adapter *adapter, u32 addr_lo, u32 cmd)
+{
+	t3_write_reg(adapter, A_MC5_DB_DBGI_REQ_ADDR0, addr_lo);
+	if (mc5_cmd_write(adapter, cmd) == 0)
+		return 0;
+	CH_ERR(adapter, "MC5 timeout writing to TCAM address 0x%x\n",
+	       addr_lo);
+	return -1;
+}
+
+static int init_mask_data_array(struct mc5 *mc5, u32 mask_array_base,
+				u32 data_array_base, u32 write_cmd,
+				int addr_shift)
+{
+	unsigned int i;
+	struct adapter *adap = mc5->adapter;
+
+	/*
+	 * We need the size of the TCAM data and mask arrays in terms of
+	 * 72-bit entries.
+	 */
+	unsigned int size72 = mc5->tcam_size;
+	unsigned int server_base = t3_read_reg(adap, A_MC5_DB_SERVER_INDEX);
+
+	if (mc5->mode == MC5_MODE_144_BIT) {
+		size72 *= 2;	/* 1 144-bit entry is 2 72-bit entries */
+		server_base *= 2;
+	}
+
+	/* Clear the data array */
+	dbgi_wr_data3(adap, 0, 0, 0);
+	for (i = 0; i < size72; i++)
+		if (mc5_write(adap, data_array_base + (i << addr_shift),
+			      write_cmd))
+			return -1;
+
+	/* Initialize the mask array. */
+	dbgi_wr_data3(adap, 0xffffffff, 0xffffffff, 0xff);
+	for (i = 0; i < size72; i++) {
+		if (i == server_base)	/* entering server or routing region */
+			t3_write_reg(adap, A_MC5_DB_DBGI_REQ_DATA0,
+				     mc5->mode == MC5_MODE_144_BIT ?
+				     0xfffffff9 : 0xfffffffd);
+		if (mc5_write(adap, mask_array_base + (i << addr_shift),
+			      write_cmd))
+			return -1;
+	}
+	return 0;
+}
+
+static int init_idt52100(struct mc5 *mc5)
+{
+	int i;
+	struct adapter *adap = mc5->adapter;
+
+	t3_write_reg(adap, A_MC5_DB_RSP_LATENCY,
+		     V_RDLAT(0x15) | V_LRNLAT(0x15) | V_SRCHLAT(0x15));
+	t3_write_reg(adap, A_MC5_DB_PART_ID_INDEX, 2);
+
+	/*
+	 * Use GMRs 14-15 for ELOOKUP, GMRs 12-13 for SYN lookups, and
+	 * GMRs 8-9 for ACK- and AOPEN searches.
+	 */
+	t3_write_reg(adap, A_MC5_DB_POPEN_DATA_WR_CMD, IDT_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_POPEN_MASK_WR_CMD, IDT_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_AOPEN_SRCH_CMD, IDT_CMD_SEARCH);
+	t3_write_reg(adap, A_MC5_DB_AOPEN_LRN_CMD, IDT_CMD_LEARN);
+	t3_write_reg(adap, A_MC5_DB_SYN_SRCH_CMD, IDT_CMD_SEARCH | 0x6000);
+	t3_write_reg(adap, A_MC5_DB_SYN_LRN_CMD, IDT_CMD_LEARN);
+	t3_write_reg(adap, A_MC5_DB_ACK_SRCH_CMD, IDT_CMD_SEARCH);
+	t3_write_reg(adap, A_MC5_DB_ACK_LRN_CMD, IDT_CMD_LEARN);
+	t3_write_reg(adap, A_MC5_DB_ILOOKUP_CMD, IDT_CMD_SEARCH);
+	t3_write_reg(adap, A_MC5_DB_ELOOKUP_CMD, IDT_CMD_SEARCH | 0x7000);
+	t3_write_reg(adap, A_MC5_DB_DATA_WRITE_CMD, IDT_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_DATA_READ_CMD, IDT_CMD_READ);
+
+	/* Set DBGI command mode for IDT TCAM. */
+	t3_write_reg(adap, A_MC5_DB_DBGI_CONFIG, DBGI_MODE_IDT52100);
+
+	/* Set up LAR */
+	dbgi_wr_data3(adap, IDT_LAR_MODE144, 0, 0);
+	if (mc5_write(adap, IDT_LAR_ADR0, IDT_CMD_WRITE))
+		goto err;
+
+	/* Set up SSRs */
+	dbgi_wr_data3(adap, 0xffffffff, 0xffffffff, 0);
+	if (mc5_write(adap, IDT_SSR0_ADR0, IDT_CMD_WRITE) ||
+	    mc5_write(adap, IDT_SSR1_ADR0, IDT_CMD_WRITE))
+		goto err;
+
+	/* Set up GMRs */
+	for (i = 0; i < 32; ++i) {
+		if (i >= 12 && i < 15)
+			dbgi_wr_data3(adap, 0xfffffff9, 0xffffffff, 0xff);
+		else if (i == 15)
+			dbgi_wr_data3(adap, 0xfffffff9, 0xffff8007, 0xff);
+		else
+			dbgi_wr_data3(adap, 0xffffffff, 0xffffffff, 0xff);
+
+		if (mc5_write(adap, IDT_GMR_BASE_ADR0 + i, IDT_CMD_WRITE))
+			goto err;
+	}
+
+	/* Set up SCR */
+	dbgi_wr_data3(adap, 1, 0, 0);
+	if (mc5_write(adap, IDT_SCR_ADR0, IDT_CMD_WRITE))
+		goto err;
+
+	return init_mask_data_array(mc5, IDT_MSKARY_BASE_ADR0,
+				    IDT_DATARY_BASE_ADR0, IDT_CMD_WRITE, 0);
+err:
+	return -EIO;
+}
+
+static int init_idt43102(struct mc5 *mc5)
+{
+	int i;
+	struct adapter *adap = mc5->adapter;
+
+	t3_write_reg(adap, A_MC5_DB_RSP_LATENCY,
+		     adap->params.rev == 0 ? V_RDLAT(0xd) | V_SRCHLAT(0x11) :
+		     V_RDLAT(0xd) | V_SRCHLAT(0x12));
+
+	/*
+	 * Use GMRs 24-25 for ELOOKUP, GMRs 20-21 for SYN lookups, and no mask
+	 * for ACK- and AOPEN searches.
+	 */
+	t3_write_reg(adap, A_MC5_DB_POPEN_DATA_WR_CMD, IDT4_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_POPEN_MASK_WR_CMD, IDT4_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_AOPEN_SRCH_CMD,
+		     IDT4_CMD_SEARCH144 | 0x3800);
+	t3_write_reg(adap, A_MC5_DB_SYN_SRCH_CMD, IDT4_CMD_SEARCH144);
+	t3_write_reg(adap, A_MC5_DB_ACK_SRCH_CMD, IDT4_CMD_SEARCH144 | 0x3800);
+	t3_write_reg(adap, A_MC5_DB_ILOOKUP_CMD, IDT4_CMD_SEARCH144 | 0x3800);
+	t3_write_reg(adap, A_MC5_DB_ELOOKUP_CMD, IDT4_CMD_SEARCH144 | 0x800);
+	t3_write_reg(adap, A_MC5_DB_DATA_WRITE_CMD, IDT4_CMD_WRITE);
+	t3_write_reg(adap, A_MC5_DB_DATA_READ_CMD, IDT4_CMD_READ);
+
+	t3_write_reg(adap, A_MC5_DB_PART_ID_INDEX, 3);
+
+	/* Set DBGI command mode for IDT TCAM. */
+	t3_write_reg(adap, A_MC5_DB_DBGI_CONFIG, DBGI_MODE_IDT52100);
+
+	/* Set up GMRs */
+	dbgi_wr_data3(adap, 0xffffffff, 0xffffffff, 0xff);
+	for (i = 0; i < 7; ++i)
+		if (mc5_write(adap, IDT4_GMR_BASE0 + i, IDT4_CMD_WRITE))
+			goto err;
+
+	for (i = 0; i < 4; ++i)
+		if (mc5_write(adap, IDT4_GMR_BASE2 + i, IDT4_CMD_WRITE))
+			goto err;
+
+	dbgi_wr_data3(adap, 0xfffffff9, 0xffffffff, 0xff);
+	if (mc5_write(adap, IDT4_GMR_BASE1, IDT4_CMD_WRITE) ||
+	    mc5_write(adap, IDT4_GMR_BASE1 + 1, IDT4_CMD_WRITE) ||
+	    mc5_write(adap, IDT4_GMR_BASE1 + 4, IDT4_CMD_WRITE))
+		goto err;
+
+	dbgi_wr_data3(adap, 0xfffffff9, 0xffff8007, 0xff);
+	if (mc5_write(adap, IDT4_GMR_BASE1 + 5, IDT4_CMD_WRITE))
+		goto err;
+
+	/* Set up SCR */
+	dbgi_wr_data3(adap, 0xf0000000, 0, 0);
+	if (mc5_write(adap, IDT4_SCR_ADR0, IDT4_CMD_WRITE))
+		goto err;
+
+	return init_mask_data_array(mc5, IDT4_MSKARY_BASE_ADR0,
+				    IDT4_DATARY_BASE_ADR0, IDT4_CMD_WRITE, 1);
+err:
+	return -EIO;
+}
+
+/* Put MC5 in DBGI mode. */
+static inline void mc5_dbgi_mode_enable(const struct mc5 *mc5)
+{
+	t3_write_reg(mc5->adapter, A_MC5_DB_CONFIG,
+		     V_TMMODE(mc5->mode == MC5_MODE_72_BIT) | F_DBGIEN);
+}
+
+/* Put MC5 in M-Bus mode. */
+static void mc5_dbgi_mode_disable(const struct mc5 *mc5)
+{
+	t3_write_reg(mc5->adapter, A_MC5_DB_CONFIG,
+		     V_TMMODE(mc5->mode == MC5_MODE_72_BIT) |
+		     V_COMPEN(mc5->mode == MC5_MODE_72_BIT) |
+		     V_PRTYEN(mc5->parity_enabled) | F_MBUSEN);
+}
+
+/*
+ * Initialization that requires the OS and protocol layers to already
+ * be intialized goes here.
+ */
+int t3_mc5_init(struct mc5 *mc5, unsigned int nservers, unsigned int nfilters,
+		unsigned int nroutes)
+{
+	u32 cfg;
+	int err;
+	unsigned int tcam_size = mc5->tcam_size;
+	struct adapter *adap = mc5->adapter;
+
+	if (nroutes > MAX_ROUTES || nroutes + nservers + nfilters > tcam_size)
+		return -EINVAL;
+
+	/* Reset the TCAM */
+	cfg = t3_read_reg(adap, A_MC5_DB_CONFIG) & ~F_TMMODE;
+	cfg |= V_TMMODE(mc5->mode == MC5_MODE_72_BIT) | F_TMRST;
+	t3_write_reg(adap, A_MC5_DB_CONFIG, cfg);
+	if (t3_wait_op_done(adap, A_MC5_DB_CONFIG, F_TMRDY, 1, 500, 0)) {
+		CH_ERR(adap, "TCAM reset timed out\n");
+		return -1;
+	}
+
+	t3_write_reg(adap, A_MC5_DB_ROUTING_TABLE_INDEX, tcam_size - nroutes);
+	t3_write_reg(adap, A_MC5_DB_FILTER_TABLE,
+		     tcam_size - nroutes - nfilters);
+	t3_write_reg(adap, A_MC5_DB_SERVER_INDEX,
+		     tcam_size - nroutes - nfilters - nservers);
+
+	mc5->parity_enabled = 1;
+
+	/* All the TCAM addresses we access have only the low 32 bits non 0 */
+	t3_write_reg(adap, A_MC5_DB_DBGI_REQ_ADDR1, 0);
+	t3_write_reg(adap, A_MC5_DB_DBGI_REQ_ADDR2, 0);
+
+	mc5_dbgi_mode_enable(mc5);
+
+	switch (mc5->part_type) {
+	case IDT75P52100:
+		err = init_idt52100(mc5);
+		break;
+	case IDT75N43102:
+		err = init_idt43102(mc5);
+		break;
+	default:
+		CH_ERR(adap, "Unsupported TCAM type %d\n", mc5->part_type);
+		err = -EINVAL;
+		break;
+	}
+
+	mc5_dbgi_mode_disable(mc5);
+	return err;
+}
+
+/*
+ *	read_mc5_range - dump a part of the memory managed by MC5
+ *	@mc5: the MC5 handle
+ *	@start: the start address for the dump
+ *	@n: number of 72-bit words to read
+ *	@buf: result buffer
+ *
+ *	Read n 72-bit words from MC5 memory from the given start location.
+ */
+int t3_read_mc5_range(const struct mc5 *mc5, unsigned int start,
+		      unsigned int n, u32 *buf)
+{
+	u32 read_cmd;
+	int err = 0;
+	struct adapter *adap = mc5->adapter;
+
+	if (mc5->part_type == IDT75P52100)
+		read_cmd = IDT_CMD_READ;
+	else if (mc5->part_type == IDT75N43102)
+		read_cmd = IDT4_CMD_READ;
+	else
+		return -EINVAL;
+
+	mc5_dbgi_mode_enable(mc5);
+
+	while (n--) {
+		t3_write_reg(adap, A_MC5_DB_DBGI_REQ_ADDR0, start++);
+		if (mc5_cmd_write(adap, read_cmd)) {
+			err = -EIO;
+			break;
+		}
+		dbgi_rd_rsp3(adap, buf + 2, buf + 1, buf);
+		buf += 3;
+	}
+
+	mc5_dbgi_mode_disable(mc5);
+	return 0;
+}
+
+#define MC5_INT_FATAL (F_PARITYERR | F_REQQPARERR | F_DISPQPARERR)
+
+/*
+ * MC5 interrupt handler
+ */
+void t3_mc5_intr_handler(struct mc5 *mc5)
+{
+	struct adapter *adap = mc5->adapter;
+	u32 cause = t3_read_reg(adap, A_MC5_DB_INT_CAUSE);
+
+	if ((cause & F_PARITYERR) && mc5->parity_enabled) {
+		CH_ALERT(adap, "MC5 parity error\n");
+		mc5->stats.parity_err++;
+	}
+
+	if (cause & F_REQQPARERR) {
+		CH_ALERT(adap, "MC5 request queue parity error\n");
+		mc5->stats.reqq_parity_err++;
+	}
+
+	if (cause & F_DISPQPARERR) {
+		CH_ALERT(adap, "MC5 dispatch queue parity error\n");
+		mc5->stats.dispq_parity_err++;
+	}
+
+	if (cause & F_ACTRGNFULL)
+		mc5->stats.active_rgn_full++;
+	if (cause & F_NFASRCHFAIL)
+		mc5->stats.nfa_srch_err++;
+	if (cause & F_UNKNOWNCMD)
+		mc5->stats.unknown_cmd++;
+	if (cause & F_DELACTEMPTY)
+		mc5->stats.del_act_empty++;
+	if (cause & MC5_INT_FATAL)
+		t3_fatal_err(adap);
+
+	t3_write_reg(adap, A_MC5_DB_INT_CAUSE, cause);
+}
+
+void __devinit t3_mc5_prep(struct adapter *adapter, struct mc5 *mc5, int mode)
+{
+#define K * 1024
+
+	static unsigned int tcam_part_size[] = {	/* in K 72-bit entries */
+		64 K, 128 K, 256 K, 32 K
+	};
+
+#undef K
+
+	u32 cfg = t3_read_reg(adapter, A_MC5_DB_CONFIG);
+
+	mc5->adapter = adapter;
+	mc5->mode = (unsigned char)mode;
+	mc5->part_type = (unsigned char)G_TMTYPE(cfg);
+	if (cfg & F_TMTYPEHI)
+		mc5->part_type |= 4;
+
+	mc5->tcam_size = tcam_part_size[G_TMPARTSIZE(cfg)];
+	if (mode == MC5_MODE_144_BIT)
+		mc5->tcam_size /= 2;
+}
diff --git a/drivers/net/cxgb3/vsc8211.c b/drivers/net/cxgb3/vsc8211.c
new file mode 100755
index 0000000..6a0a815
--- /dev/null
+++ b/drivers/net/cxgb3/vsc8211.c
@@ -0,0 +1,208 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver.
+ *
+ * Copyright (C) 2005-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#include "common.h"
+
+/* VSC8211 PHY specific registers. */
+enum {
+	VSC8211_INTR_ENABLE = 25,
+	VSC8211_INTR_STATUS = 26,
+	VSC8211_AUX_CTRL_STAT = 28,
+};
+
+enum {
+	VSC_INTR_RX_ERR = 1 << 0,
+	VSC_INTR_MS_ERR = 1 << 1,	/* master/slave resolution error */
+	VSC_INTR_CABLE = 1 << 2,	/* cable impairment */
+	VSC_INTR_FALSE_CARR = 1 << 3,	/* false carrier */
+	VSC_INTR_MEDIA_CHG = 1 << 4,	/* AMS media change */
+	VSC_INTR_RX_FIFO = 1 << 5,	/* Rx FIFO over/underflow */
+	VSC_INTR_TX_FIFO = 1 << 6,	/* Tx FIFO over/underflow */
+	VSC_INTR_DESCRAMBL = 1 << 7,	/* descrambler lock-lost */
+	VSC_INTR_SYMBOL_ERR = 1 << 8,	/* symbol error */
+	VSC_INTR_NEG_DONE = 1 << 10,	/* autoneg done */
+	VSC_INTR_NEG_ERR = 1 << 11,	/* autoneg error */
+	VSC_INTR_LINK_CHG = 1 << 13,	/* link change */
+	VSC_INTR_ENABLE = 1 << 15,	/* interrupt enable */
+};
+
+#define CFG_CHG_INTR_MASK (VSC_INTR_LINK_CHG | VSC_INTR_NEG_ERR | \
+	 		   VSC_INTR_NEG_DONE)
+#define INTR_MASK (CFG_CHG_INTR_MASK | VSC_INTR_TX_FIFO | VSC_INTR_RX_FIFO | \
+		   VSC_INTR_ENABLE)
+
+/* PHY specific auxiliary control & status register fields */
+#define S_ACSR_ACTIPHY_TMR    0
+#define M_ACSR_ACTIPHY_TMR    0x3
+#define V_ACSR_ACTIPHY_TMR(x) ((x) << S_ACSR_ACTIPHY_TMR)
+
+#define S_ACSR_SPEED    3
+#define M_ACSR_SPEED    0x3
+#define G_ACSR_SPEED(x) (((x) >> S_ACSR_SPEED) & M_ACSR_SPEED)
+
+#define S_ACSR_DUPLEX 5
+#define F_ACSR_DUPLEX (1 << S_ACSR_DUPLEX)
+
+#define S_ACSR_ACTIPHY 6
+#define F_ACSR_ACTIPHY (1 << S_ACSR_ACTIPHY)
+
+/*
+ * Reset the PHY.  This PHY completes reset immediately so we never wait.
+ */
+static int vsc8211_reset(struct cphy *cphy, int wait)
+{
+	return t3_phy_reset(cphy, 0, 0);
+}
+
+static int vsc8211_intr_enable(struct cphy *cphy)
+{
+	return mdio_write(cphy, 0, VSC8211_INTR_ENABLE, INTR_MASK);
+}
+
+static int vsc8211_intr_disable(struct cphy *cphy)
+{
+	return mdio_write(cphy, 0, VSC8211_INTR_ENABLE, 0);
+}
+
+static int vsc8211_intr_clear(struct cphy *cphy)
+{
+	u32 val;
+
+	/* Clear PHY interrupts by reading the register. */
+	return mdio_read(cphy, 0, VSC8211_INTR_STATUS, &val);
+}
+
+static int vsc8211_autoneg_enable(struct cphy *cphy)
+{
+	return t3_mdio_change_bits(cphy, 0, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE,
+				   BMCR_ANENABLE | BMCR_ANRESTART);
+}
+
+static int vsc8211_autoneg_restart(struct cphy *cphy)
+{
+	return t3_mdio_change_bits(cphy, 0, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE,
+				   BMCR_ANRESTART);
+}
+
+static int vsc8211_get_link_status(struct cphy *cphy, int *link_ok,
+				   int *speed, int *duplex, int *fc)
+{
+	unsigned int bmcr, status, lpa, adv;
+	int err, sp = -1, dplx = -1, pause = 0;
+
+	err = mdio_read(cphy, 0, MII_BMCR, &bmcr);
+	if (!err)
+		err = mdio_read(cphy, 0, MII_BMSR, &status);
+	if (err)
+		return err;
+
+	if (link_ok) {
+		/*
+		 * BMSR_LSTATUS is latch-low, so if it is 0 we need to read it
+		 * once more to get the current link state.
+		 */
+		if (!(status & BMSR_LSTATUS))
+			err = mdio_read(cphy, 0, MII_BMSR, &status);
+		if (err)
+			return err;
+		*link_ok = (status & BMSR_LSTATUS) != 0;
+	}
+	if (!(bmcr & BMCR_ANENABLE)) {
+		dplx = (bmcr & BMCR_FULLDPLX) ? DUPLEX_FULL : DUPLEX_HALF;
+		if (bmcr & BMCR_SPEED1000)
+			sp = SPEED_1000;
+		else if (bmcr & BMCR_SPEED100)
+			sp = SPEED_100;
+		else
+			sp = SPEED_10;
+	} else if (status & BMSR_ANEGCOMPLETE) {
+		err = mdio_read(cphy, 0, VSC8211_AUX_CTRL_STAT, &status);
+		if (err)
+			return err;
+
+		dplx = (status & F_ACSR_DUPLEX) ? DUPLEX_FULL : DUPLEX_HALF;
+		sp = G_ACSR_SPEED(status);
+		if (sp == 0)
+			sp = SPEED_10;
+		else if (sp == 1)
+			sp = SPEED_100;
+		else
+			sp = SPEED_1000;
+
+		if (fc && dplx == DUPLEX_FULL) {
+			err = mdio_read(cphy, 0, MII_LPA, &lpa);
+			if (!err)
+				err = mdio_read(cphy, 0, MII_ADVERTISE, &adv);
+			if (err)
+				return err;
+
+			if (lpa & adv & ADVERTISE_PAUSE_CAP)
+				pause = PAUSE_RX | PAUSE_TX;
+			else if ((lpa & ADVERTISE_PAUSE_CAP) &&
+				 (lpa & ADVERTISE_PAUSE_ASYM) &&
+				 (adv & ADVERTISE_PAUSE_ASYM))
+				pause = PAUSE_TX;
+			else if ((lpa & ADVERTISE_PAUSE_ASYM) &&
+				 (adv & ADVERTISE_PAUSE_CAP))
+				pause = PAUSE_RX;
+		}
+	}
+	if (speed)
+		*speed = sp;
+	if (duplex)
+		*duplex = dplx;
+	if (fc)
+		*fc = pause;
+	return 0;
+}
+
+static int vsc8211_power_down(struct cphy *cphy, int enable)
+{
+	return t3_mdio_change_bits(cphy, 0, MII_BMCR, BMCR_PDOWN,
+				   enable ? BMCR_PDOWN : 0);
+}
+
+static int vsc8211_intr_handler(struct cphy *cphy)
+{
+	unsigned int cause;
+	int err, cphy_cause = 0;
+
+	err = mdio_read(cphy, 0, VSC8211_INTR_STATUS, &cause);
+	if (err)
+		return err;
+
+	cause &= INTR_MASK;
+	if (cause & CFG_CHG_INTR_MASK)
+		cphy_cause |= cphy_cause_link_change;
+	if (cause & (VSC_INTR_RX_FIFO | VSC_INTR_TX_FIFO))
+		cphy_cause |= cphy_cause_fifo_error;
+	return cphy_cause;
+}
+
+static struct cphy_ops vsc8211_ops = {
+	.reset = vsc8211_reset,
+	.intr_enable = vsc8211_intr_enable,
+	.intr_disable = vsc8211_intr_disable,
+	.intr_clear = vsc8211_intr_clear,
+	.intr_handler = vsc8211_intr_handler,
+	.autoneg_enable = vsc8211_autoneg_enable,
+	.autoneg_restart = vsc8211_autoneg_restart,
+	.advertise = t3_phy_advertise,
+	.set_speed_duplex = t3_set_phy_speed_duplex,
+	.get_link_status = vsc8211_get_link_status,
+	.power_down = vsc8211_power_down,
+};
+
+void t3_vsc8211_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops)
+{
+	cphy_init(phy, adapter, phy_addr, &vsc8211_ops, mdio_ops);
+}
diff --git a/drivers/net/cxgb3/xgmac.c b/drivers/net/cxgb3/xgmac.c
new file mode 100755
index 0000000..4e1cda8
--- /dev/null
+++ b/drivers/net/cxgb3/xgmac.c
@@ -0,0 +1,389 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver.
+ *
+ * Copyright (C) 2005-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#include "common.h"
+#include "regs.h"
+
+/*
+ * # of exact address filters.  The first one is used for the station address,
+ * the rest are available for multicast addresses.
+ */
+#define EXACT_ADDR_FILTERS 8
+
+static inline int macidx(const struct cmac *mac)
+{
+	return mac->offset / (XGMAC0_1_BASE_ADDR - XGMAC0_0_BASE_ADDR);
+}
+
+static void xaui_serdes_reset(struct cmac *mac)
+{
+	static unsigned int clear[] = {
+		F_PWRDN0 | F_PWRDN1, F_RESETPLL01, F_RESET0 | F_RESET1,
+		F_PWRDN2 | F_PWRDN3, F_RESETPLL23, F_RESET2 | F_RESET3
+	};
+
+	int i;
+	struct adapter *adap = mac->adapter;
+	u32 ctrl = A_XGM_SERDES_CTRL0 + mac->offset;
+
+	t3_write_reg(adap, ctrl, adap->params.vpd.xauicfg[macidx(mac)] |
+		     F_RESET3 | F_RESET2 | F_RESET1 | F_RESET0 |
+		     F_PWRDN3 | F_PWRDN2 | F_PWRDN1 | F_PWRDN0 |
+		     F_RESETPLL23 | F_RESETPLL01);
+	(void)t3_read_reg(adap, ctrl);
+	udelay(15);
+
+	for (i = 0; i < ARRAY_SIZE(clear); i++) {
+		t3_set_reg_field(adap, ctrl, clear[i], 0);
+		udelay(15);
+	}
+}
+
+void t3b_pcs_reset(struct cmac *mac)
+{
+	t3_set_reg_field(mac->adapter, A_XGM_RESET_CTRL + mac->offset,
+			 F_PCS_RESET_, 0);
+	udelay(20);
+	t3_set_reg_field(mac->adapter, A_XGM_RESET_CTRL + mac->offset, 0,
+			 F_PCS_RESET_);
+}
+
+int t3_mac_reset(struct cmac *mac)
+{
+	static const struct addr_val_pair mac_reset_avp[] = {
+		{A_XGM_TX_CTRL, 0},
+		{A_XGM_RX_CTRL, 0},
+		{A_XGM_RX_CFG, F_DISPAUSEFRAMES | F_EN1536BFRAMES |
+		 F_RMFCS | F_ENJUMBO | F_ENHASHMCAST},
+		{A_XGM_RX_HASH_LOW, 0},
+		{A_XGM_RX_HASH_HIGH, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_1, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_2, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_3, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_4, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_5, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_6, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_7, 0},
+		{A_XGM_RX_EXACT_MATCH_LOW_8, 0},
+		{A_XGM_STAT_CTRL, F_CLRSTATS}
+	};
+	u32 val;
+	struct adapter *adap = mac->adapter;
+	unsigned int oft = mac->offset;
+
+	t3_write_reg(adap, A_XGM_RESET_CTRL + oft, F_MAC_RESET_);
+	(void)t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
+
+	t3_write_regs(adap, mac_reset_avp, ARRAY_SIZE(mac_reset_avp), oft);
+	t3_set_reg_field(adap, A_XGM_RXFIFO_CFG + oft,
+			 F_RXSTRFRWRD | F_DISERRFRAMES,
+			 uses_xaui(adap) ? 0 : F_RXSTRFRWRD);
+
+	if (uses_xaui(adap)) {
+		if (adap->params.rev == 0) {
+			t3_set_reg_field(adap, A_XGM_SERDES_CTRL + oft, 0,
+					 F_RXENABLE | F_TXENABLE);
+			if (t3_wait_op_done(adap, A_XGM_SERDES_STATUS1 + oft,
+					    F_CMULOCK, 1, 5, 2)) {
+				CH_ERR(adap,
+				       "MAC %d XAUI SERDES CMU lock failed\n",
+				       macidx(mac));
+				return -1;
+			}
+			t3_set_reg_field(adap, A_XGM_SERDES_CTRL + oft, 0,
+					 F_SERDESRESET_);
+		} else
+			xaui_serdes_reset(mac);
+	}
+
+	if (adap->params.rev > 0)
+		t3_write_reg(adap, A_XGM_PAUSE_TIMER + oft, 0xf000);
+
+	val = F_MAC_RESET_;
+	if (is_10G(adap))
+		val |= F_PCS_RESET_;
+	else if (uses_xaui(adap))
+		val |= F_PCS_RESET_ | F_XG2G_RESET_;
+	else
+		val |= F_RGMII_RESET_ | F_XG2G_RESET_;
+	t3_write_reg(adap, A_XGM_RESET_CTRL + oft, val);
+	(void)t3_read_reg(adap, A_XGM_RESET_CTRL + oft);	/* flush */
+	if ((val & F_PCS_RESET_) && adap->params.rev) {
+		msleep(1);
+		t3b_pcs_reset(mac);
+	}
+
+	memset(&mac->stats, 0, sizeof(mac->stats));
+	return 0;
+}
+
+/*
+ * Set the exact match register 'idx' to recognize the given Ethernet address.
+ */
+static void set_addr_filter(struct cmac *mac, int idx, const u8 * addr)
+{
+	u32 addr_lo, addr_hi;
+	unsigned int oft = mac->offset + idx * 8;
+
+	addr_lo = (addr[3] << 24) | (addr[2] << 16) | (addr[1] << 8) | addr[0];
+	addr_hi = (addr[5] << 8) | addr[4];
+
+	t3_write_reg(mac->adapter, A_XGM_RX_EXACT_MATCH_LOW_1 + oft, addr_lo);
+	t3_write_reg(mac->adapter, A_XGM_RX_EXACT_MATCH_HIGH_1 + oft, addr_hi);
+}
+
+/* Set one of the station's unicast MAC addresses. */
+int t3_mac_set_address(struct cmac *mac, unsigned int idx, u8 addr[6])
+{
+	if (idx >= mac->nucast)
+		return -EINVAL;
+	set_addr_filter(mac, idx, addr);
+	return 0;
+}
+
+/*
+ * Specify the number of exact address filters that should be reserved for
+ * unicast addresses.  Caller should reload the unicast and multicast addresses
+ * after calling this.
+ */
+int t3_mac_set_num_ucast(struct cmac *mac, int n)
+{
+	if (n > EXACT_ADDR_FILTERS)
+		return -EINVAL;
+	mac->nucast = n;
+	return 0;
+}
+
+/* Calculate the RX hash filter index of an Ethernet address */
+static int hash_hw_addr(const u8 * addr)
+{
+	int hash = 0, octet, bit, i = 0, c;
+
+	for (octet = 0; octet < 6; ++octet)
+		for (c = addr[octet], bit = 0; bit < 8; c >>= 1, ++bit) {
+			hash ^= (c & 1) << i;
+			if (++i == 6)
+				i = 0;
+		}
+	return hash;
+}
+
+int t3_mac_set_rx_mode(struct cmac *mac, struct t3_rx_mode *rm)
+{
+	u32 val, hash_lo, hash_hi;
+	struct adapter *adap = mac->adapter;
+	unsigned int oft = mac->offset;
+
+	val = t3_read_reg(adap, A_XGM_RX_CFG + oft) & ~F_COPYALLFRAMES;
+	if (rm->dev->flags & IFF_PROMISC)
+		val |= F_COPYALLFRAMES;
+	t3_write_reg(adap, A_XGM_RX_CFG + oft, val);
+
+	if (rm->dev->flags & IFF_ALLMULTI)
+		hash_lo = hash_hi = 0xffffffff;
+	else {
+		u8 *addr;
+		int exact_addr_idx = mac->nucast;
+
+		hash_lo = hash_hi = 0;
+		while ((addr = t3_get_next_mcaddr(rm)))
+			if (exact_addr_idx < EXACT_ADDR_FILTERS)
+				set_addr_filter(mac, exact_addr_idx++, addr);
+			else {
+				int hash = hash_hw_addr(addr);
+
+				if (hash < 32)
+					hash_lo |= (1 << hash);
+				else
+					hash_hi |= (1 << (hash - 32));
+			}
+	}
+
+	t3_write_reg(adap, A_XGM_RX_HASH_LOW + oft, hash_lo);
+	t3_write_reg(adap, A_XGM_RX_HASH_HIGH + oft, hash_hi);
+	return 0;
+}
+
+int t3_mac_set_mtu(struct cmac *mac, unsigned int mtu)
+{
+	int hwm, lwm;
+	unsigned int thres, v;
+	struct adapter *adap = mac->adapter;
+
+	/*
+	 * MAX_FRAME_SIZE inludes header + FCS, mtu doesn't.  The HW max
+	 * packet size register includes header, but not FCS.
+	 */
+	mtu += 14;
+	if (mtu > MAX_FRAME_SIZE - 4)
+		return -EINVAL;
+	t3_write_reg(adap, A_XGM_RX_MAX_PKT_SIZE + mac->offset, mtu);
+
+	/*
+	 * Adjust the PAUSE frame watermarks.  We always set the LWM, and the
+	 * HWM only if flow-control is enabled.
+	 */
+	hwm = max(MAC_RXFIFO_SIZE - 3 * mtu, MAC_RXFIFO_SIZE / 2U);
+	hwm = min(hwm, 3 * MAC_RXFIFO_SIZE / 4 + 1024);
+	lwm = hwm - 1024;
+	v = t3_read_reg(adap, A_XGM_RXFIFO_CFG + mac->offset);
+	v &= ~V_RXFIFOPAUSELWM(M_RXFIFOPAUSELWM);
+	v |= V_RXFIFOPAUSELWM(lwm / 8);
+	if (G_RXFIFOPAUSEHWM(v))
+		v = (v & ~V_RXFIFOPAUSEHWM(M_RXFIFOPAUSEHWM)) |
+		    V_RXFIFOPAUSEHWM(hwm / 8);
+	t3_write_reg(adap, A_XGM_RXFIFO_CFG + mac->offset, v);
+
+	/* Adjust the TX FIFO threshold based on the MTU */
+	thres = (adap->params.vpd.cclk * 1000) / 15625;
+	thres = (thres * mtu) / 1000;
+	if (is_10G(adap))
+		thres /= 10;
+	thres = mtu > thres ? (mtu - thres + 7) / 8 : 0;
+	thres = max(thres, 8U);	/* need at least 8 */
+	t3_set_reg_field(adap, A_XGM_TXFIFO_CFG + mac->offset,
+			 V_TXFIFOTHRESH(M_TXFIFOTHRESH), V_TXFIFOTHRESH(thres));
+	return 0;
+}
+
+int t3_mac_set_speed_duplex_fc(struct cmac *mac, int speed, int duplex, int fc)
+{
+	u32 val;
+	struct adapter *adap = mac->adapter;
+	unsigned int oft = mac->offset;
+
+	if (duplex >= 0 && duplex != DUPLEX_FULL)
+		return -EINVAL;
+	if (speed >= 0) {
+		if (speed == SPEED_10)
+			val = V_PORTSPEED(0);
+		else if (speed == SPEED_100)
+			val = V_PORTSPEED(1);
+		else if (speed == SPEED_1000)
+			val = V_PORTSPEED(2);
+		else if (speed == SPEED_10000)
+			val = V_PORTSPEED(3);
+		else
+			return -EINVAL;
+
+		t3_set_reg_field(adap, A_XGM_PORT_CFG + oft,
+				 V_PORTSPEED(M_PORTSPEED), val);
+	}
+
+	val = t3_read_reg(adap, A_XGM_RXFIFO_CFG + oft);
+	val &= ~V_RXFIFOPAUSEHWM(M_RXFIFOPAUSEHWM);
+	if (fc & PAUSE_TX)
+		val |= V_RXFIFOPAUSEHWM(G_RXFIFOPAUSELWM(val) + 128);	/* +1KB */
+	t3_write_reg(adap, A_XGM_RXFIFO_CFG + oft, val);
+
+	t3_set_reg_field(adap, A_XGM_TX_CFG + oft, F_TXPAUSEEN,
+			 (fc & PAUSE_RX) ? F_TXPAUSEEN : 0);
+	return 0;
+}
+
+int t3_mac_enable(struct cmac *mac, int which)
+{
+	int idx = macidx(mac);
+	struct adapter *adap = mac->adapter;
+	unsigned int oft = mac->offset;
+
+	if (which & MAC_DIRECTION_TX) {
+		t3_write_reg(adap, A_XGM_TX_CTRL + oft, F_TXEN);
+		t3_write_reg(adap, A_TP_PIO_ADDR, A_TP_TX_DROP_CFG_CH0 + idx);
+		t3_write_reg(adap, A_TP_PIO_DATA, 0xbf000001);
+		t3_write_reg(adap, A_TP_PIO_ADDR, A_TP_TX_DROP_MODE);
+		t3_set_reg_field(adap, A_TP_PIO_DATA, 1 << idx, 1 << idx);
+	}
+	if (which & MAC_DIRECTION_RX)
+		t3_write_reg(adap, A_XGM_RX_CTRL + oft, F_RXEN);
+	return 0;
+}
+
+int t3_mac_disable(struct cmac *mac, int which)
+{
+	int idx = macidx(mac);
+	struct adapter *adap = mac->adapter;
+
+	if (which & MAC_DIRECTION_TX) {
+		t3_write_reg(adap, A_XGM_TX_CTRL + mac->offset, 0);
+		t3_write_reg(adap, A_TP_PIO_ADDR, A_TP_TX_DROP_CFG_CH0 + idx);
+		t3_write_reg(adap, A_TP_PIO_DATA, 0xc000001f);
+		t3_write_reg(adap, A_TP_PIO_ADDR, A_TP_TX_DROP_MODE);
+		t3_set_reg_field(adap, A_TP_PIO_DATA, 1 << idx, 0);
+	}
+	if (which & MAC_DIRECTION_RX)
+		t3_write_reg(adap, A_XGM_RX_CTRL + mac->offset, 0);
+	return 0;
+}
+
+/*
+ * This function is called periodically to accumulate the current values of the
+ * RMON counters into the port statistics.  Since the packet counters are only
+ * 32 bits they can overflow in ~286 secs at 10G, so the function should be
+ * called more frequently than that.  The byte counters are 45-bit wide, they
+ * would overflow in ~7.8 hours.
+ */
+const struct mac_stats *t3_mac_update_stats(struct cmac *mac)
+{
+#define RMON_READ(mac, addr) t3_read_reg(mac->adapter, addr + mac->offset)
+#define RMON_UPDATE(mac, name, reg) \
+	(mac)->stats.name += (u64)RMON_READ(mac, A_XGM_STAT_##reg)
+#define RMON_UPDATE64(mac, name, reg_lo, reg_hi) \
+	(mac)->stats.name += RMON_READ(mac, A_XGM_STAT_##reg_lo) + \
+			     ((u64)RMON_READ(mac, A_XGM_STAT_##reg_hi) << 32)
+
+	u32 v, lo;
+
+	RMON_UPDATE64(mac, rx_octets, RX_BYTES_LOW, RX_BYTES_HIGH);
+	RMON_UPDATE64(mac, rx_frames, RX_FRAMES_LOW, RX_FRAMES_HIGH);
+	RMON_UPDATE(mac, rx_mcast_frames, RX_MCAST_FRAMES);
+	RMON_UPDATE(mac, rx_bcast_frames, RX_BCAST_FRAMES);
+	RMON_UPDATE(mac, rx_fcs_errs, RX_CRC_ERR_FRAMES);
+	RMON_UPDATE(mac, rx_pause, RX_PAUSE_FRAMES);
+	RMON_UPDATE(mac, rx_jabber, RX_JABBER_FRAMES);
+	RMON_UPDATE(mac, rx_short, RX_SHORT_FRAMES);
+	RMON_UPDATE(mac, rx_symbol_errs, RX_SYM_CODE_ERR_FRAMES);
+
+	RMON_UPDATE(mac, rx_too_long, RX_OVERSIZE_FRAMES);
+	mac->stats.rx_too_long += RMON_READ(mac, A_XGM_RX_MAX_PKT_SIZE_ERR_CNT);
+
+	RMON_UPDATE(mac, rx_frames_64, RX_64B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_65_127, RX_65_127B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_128_255, RX_128_255B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_256_511, RX_256_511B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_512_1023, RX_512_1023B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_1024_1518, RX_1024_1518B_FRAMES);
+	RMON_UPDATE(mac, rx_frames_1519_max, RX_1519_MAXB_FRAMES);
+
+	RMON_UPDATE64(mac, tx_octets, TX_BYTE_LOW, TX_BYTE_HIGH);
+	RMON_UPDATE64(mac, tx_frames, TX_FRAME_LOW, TX_FRAME_HIGH);
+	RMON_UPDATE(mac, tx_mcast_frames, TX_MCAST);
+	RMON_UPDATE(mac, tx_bcast_frames, TX_BCAST);
+	RMON_UPDATE(mac, tx_pause, TX_PAUSE);
+	/* This counts error frames in general (bad FCS, underrun, etc). */
+	RMON_UPDATE(mac, tx_underrun, TX_ERR_FRAMES);
+
+	RMON_UPDATE(mac, tx_frames_64, TX_64B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_65_127, TX_65_127B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_128_255, TX_128_255B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_256_511, TX_256_511B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_512_1023, TX_512_1023B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_1024_1518, TX_1024_1518B_FRAMES);
+	RMON_UPDATE(mac, tx_frames_1519_max, TX_1519_MAXB_FRAMES);
+
+	/* The next stat isn't clear-on-read. */
+	t3_write_reg(mac->adapter, A_TP_MIB_INDEX, mac->offset ? 51 : 50);
+	v = t3_read_reg(mac->adapter, A_TP_MIB_RDATA);
+	lo = (u32) mac->stats.rx_cong_drops;
+	mac->stats.rx_cong_drops += (u64) (v - lo);
+
+	return &mac->stats;
+}
