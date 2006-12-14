Return-Path: <linux-kernel-owner+w=401wt.eu-S1752001AbWLNGSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWLNGSf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWLNGSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:18:32 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:8716 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbWLNGPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:15:07 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:14:57 EST
Date: Wed, 13 Dec 2006 21:42:08 -0800
From: divy@chelsio.com
Message-Id: <200612140542.kBE5g81H005820@localhost.localdomain>
To: jeff@garzik.org
Subject: [PATCH 3/10] cxgb3 - [PATCH 3/10] cxgb3 - HW access routines - part 1
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divy Le Ray <divy@chelsio.com>
[PATCH 3/10] cxgb3 - HW access routines - part 1


This patch implements the HW access routines for the
Chelsio T3 network adapter's driver.
This patch is split. This is the first part.

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---
 drivers/net/cxgb3/t3_hw.c | 3352 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 3352 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cxgb3/t3_hw.c b/drivers/net/cxgb3/t3_hw.c
new file mode 100755
index 0000000..3a1802d
--- /dev/null
+++ b/drivers/net/cxgb3/t3_hw.c
@@ -0,0 +1,3352 @@
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
+#include "sge_defs.h"
+#include "firmware_exports.h"
+
+ /**
+  *	t3_wait_op_done_val - wait until an operation is completed
+  *	@adapter: the adapter performing the operation
+  *	@reg: the register to check for completion
+  *	@mask: a single-bit field within @reg that indicates completion
+  *	@polarity: the value of the field when the operation is completed
+  *	@attempts: number of check iterations
+  *	@delay: delay in usecs between iterations
+  *	@valp: where to store the value of the register at completion time
+  *
+  *	Wait until an operation is completed by checking a bit in a register
+  *	up to @attempts times.  If @valp is not NULL the value of the register
+  *	at the time it indicated completion is stored there.  Returns 0 if the
+  *	operation completes and -EAGAIN otherwise.
+  */
+
+int t3_wait_op_done_val(struct adapter *adapter, int reg, u32 mask,
+			int polarity, int attempts, int delay, u32 *valp)
+{
+	while (1) {
+		u32 val = t3_read_reg(adapter, reg);
+
+		if (!!(val & mask) == polarity) {
+			if (valp)
+				*valp = val;
+			return 0;
+		}
+		if (--attempts == 0)
+ 			return -EAGAIN;
+		if (delay)
+			udelay(delay);
+	}
+}
+
+/**
+ *	t3_write_regs - write a bunch of registers
+ *	@adapter: the adapter to program
+ *	@p: an array of register address/register value pairs
+ *	@n: the number of address/value pairs
+ *	@offset: register address offset
+ *
+ *	Takes an array of register address/register value pairs and writes each
+ *	value to the corresponding register.  Register addresses are adjusted
+ *	by the supplied offset.
+ */
+void t3_write_regs(struct adapter *adapter, const struct addr_val_pair *p,
+		   int n, unsigned int offset)
+{
+	while (n--) {
+		t3_write_reg(adapter, p->reg_addr + offset, p->val);
+		p++;
+	}
+}
+
+/**
+ *	t3_set_reg_field - set a register field to a value
+ *	@adapter: the adapter to program
+ *	@addr: the register address
+ *	@mask: specifies the portion of the register to modify
+ *	@val: the new value for the register field
+ *
+ *	Sets a register field specified by the supplied mask to the
+ *	given value.
+ */
+void t3_set_reg_field(struct adapter *adapter, unsigned int addr, u32 mask,
+		      u32 val)
+{
+	u32 v = t3_read_reg(adapter, addr) & ~mask;
+
+	t3_write_reg(adapter, addr, v | val);
+	(void)t3_read_reg(adapter, addr);	/* flush */
+}
+
+/**
+ *	t3_read_indirect - read indirectly addressed registers
+ *	@adap: the adapter
+ *	@addr_reg: register holding the indirect address
+ *	@data_reg: register holding the value of the indirect register
+ *	@vals: where the read register values are stored
+ *	@start_idx: index of first indirect register to read
+ *	@nregs: how many indirect registers to read
+ *
+ *	Reads registers that are accessed indirectly through an address/data
+ *	register pair.
+ */
+void t3_read_indirect(struct adapter *adap, unsigned int addr_reg,
+		      unsigned int data_reg, u32 *vals, unsigned int nregs,
+		      unsigned int start_idx)
+{
+	while (nregs--) {
+		t3_write_reg(adap, addr_reg, start_idx);
+		*vals++ = t3_read_reg(adap, data_reg);
+		start_idx++;
+	}
+}
+
+/**
+ *	t3_mc7_bd_read - read from MC7 through backdoor accesses
+ *	@mc7: identifies MC7 to read from
+ *	@start: index of first 64-bit word to read
+ *	@n: number of 64-bit words to read
+ *	@buf: where to store the read result
+ *
+ *	Read n 64-bit words from MC7 starting at word start, using backdoor
+ *	accesses.
+ */
+int t3_mc7_bd_read(struct mc7 *mc7, unsigned int start, unsigned int n,
+		   u64 *buf)
+{
+	static const int shift[] = { 0, 0, 16, 24 };
+	static const int step[] = { 0, 32, 16, 8 };
+
+	unsigned int size64 = mc7->size / 8;	/* # of 64-bit words */
+	struct adapter *adap = mc7->adapter;
+
+	if (start >= size64 || start + n > size64)
+		return -EINVAL;
+
+	start *= (8 << mc7->width);
+	while (n--) {
+		int i;
+		u64 val64 = 0;
+
+		for (i = (1 << mc7->width) - 1; i >= 0; --i) {
+			int attempts = 10;
+			u32 val;
+
+			t3_write_reg(adap, mc7->offset + A_MC7_BD_ADDR, start);
+			t3_write_reg(adap, mc7->offset + A_MC7_BD_OP, 0);
+			val = t3_read_reg(adap, mc7->offset + A_MC7_BD_OP);
+			while ((val & F_BUSY) && attempts--)
+				val = t3_read_reg(adap,
+						  mc7->offset + A_MC7_BD_OP);
+			if (val & F_BUSY)
+				return -EIO;
+
+			val = t3_read_reg(adap, mc7->offset + A_MC7_BD_DATA1);
+			if (mc7->width == 0) {
+				val64 = t3_read_reg(adap,
+						    mc7->offset +
+						    A_MC7_BD_DATA0);
+				val64 |= (u64) val << 32;
+			} else {
+				if (mc7->width > 1)
+					val >>= shift[mc7->width];
+				val64 |= (u64) val << (step[mc7->width] * i);
+			}
+			start += 8;
+		}
+		*buf++ = val64;
+	}
+	return 0;
+}
+
+/*
+ * Initialize MI1.
+ */
+static void mi1_init(struct adapter *adap, const struct adapter_info *ai)
+{
+	u32 clkdiv = adap->params.vpd.cclk / (2 * adap->params.vpd.mdc) - 1;
+	u32 val = F_PREEN | V_MDIINV(ai->mdiinv) | V_MDIEN(ai->mdien) |
+	    V_CLKDIV(clkdiv);
+
+	if (!(ai->caps & SUPPORTED_10000baseT_Full))
+		val |= V_ST(1);
+	t3_write_reg(adap, A_MI1_CFG, val);
+}
+
+#define MDIO_ATTEMPTS 10
+
+/*
+ * MI1 read/write operations for direct-addressed PHYs.
+ */
+static int mi1_read(struct adapter *adapter, int phy_addr, int mmd_addr,
+		    int reg_addr, unsigned int *valp)
+{
+	int ret;
+	u32 addr = V_REGADDR(reg_addr) | V_PHYADDR(phy_addr);
+
+	if (mmd_addr)
+		return -EINVAL;
+
+	mutex_lock(&adapter->mdio_lock);
+	t3_write_reg(adapter, A_MI1_ADDR, addr);
+	t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(2));
+	ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0, MDIO_ATTEMPTS, 20);
+	if (!ret)
+		*valp = t3_read_reg(adapter, A_MI1_DATA);
+	mutex_unlock(&adapter->mdio_lock);
+	return ret;
+}
+
+static int mi1_write(struct adapter *adapter, int phy_addr, int mmd_addr,
+		     int reg_addr, unsigned int val)
+{
+	int ret;
+	u32 addr = V_REGADDR(reg_addr) | V_PHYADDR(phy_addr);
+
+	if (mmd_addr)
+		return -EINVAL;
+
+	mutex_lock(&adapter->mdio_lock);
+	t3_write_reg(adapter, A_MI1_ADDR, addr);
+	t3_write_reg(adapter, A_MI1_DATA, val);
+	t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(1));
+	ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0, MDIO_ATTEMPTS, 20);
+	mutex_unlock(&adapter->mdio_lock);
+	return ret;
+}
+
+static const struct mdio_ops mi1_mdio_ops = {
+	mi1_read,
+	mi1_write
+};
+
+/*
+ * MI1 read/write operations for indirect-addressed PHYs.
+ */
+static int mi1_ext_read(struct adapter *adapter, int phy_addr, int mmd_addr,
+			int reg_addr, unsigned int *valp)
+{
+	int ret;
+	u32 addr = V_REGADDR(mmd_addr) | V_PHYADDR(phy_addr);
+
+	mutex_lock(&adapter->mdio_lock);
+	t3_write_reg(adapter, A_MI1_ADDR, addr);
+	t3_write_reg(adapter, A_MI1_DATA, reg_addr);
+	t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(0));
+	ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0, MDIO_ATTEMPTS, 20);
+	if (!ret) {
+		t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(3));
+		ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0,
+				      MDIO_ATTEMPTS, 20);
+		if (!ret)
+			*valp = t3_read_reg(adapter, A_MI1_DATA);
+	}
+	mutex_unlock(&adapter->mdio_lock);
+	return ret;
+}
+
+static int mi1_ext_write(struct adapter *adapter, int phy_addr, int mmd_addr,
+			 int reg_addr, unsigned int val)
+{
+	int ret;
+	u32 addr = V_REGADDR(mmd_addr) | V_PHYADDR(phy_addr);
+
+	mutex_lock(&adapter->mdio_lock);
+	t3_write_reg(adapter, A_MI1_ADDR, addr);
+	t3_write_reg(adapter, A_MI1_DATA, reg_addr);
+	t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(0));
+	ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0, MDIO_ATTEMPTS, 20);
+	if (!ret) {
+		t3_write_reg(adapter, A_MI1_DATA, val);
+		t3_write_reg(adapter, A_MI1_OP, V_MDI_OP(1));
+		ret = t3_wait_op_done(adapter, A_MI1_OP, F_BUSY, 0,
+				      MDIO_ATTEMPTS, 20);
+	}
+	mutex_unlock(&adapter->mdio_lock);
+	return ret;
+}
+
+static const struct mdio_ops mi1_mdio_ext_ops = {
+	mi1_ext_read,
+	mi1_ext_write
+};
+
+/**
+ *	t3_mdio_change_bits - modify the value of a PHY register
+ *	@phy: the PHY to operate on
+ *	@mmd: the device address
+ *	@reg: the register address
+ *	@clear: what part of the register value to mask off
+ *	@set: what part of the register value to set
+ *
+ *	Changes the value of a PHY register by applying a mask to its current
+ *	value and ORing the result with a new value.
+ */
+int t3_mdio_change_bits(struct cphy *phy, int mmd, int reg, unsigned int clear,
+			unsigned int set)
+{
+	int ret;
+	unsigned int val;
+
+	ret = mdio_read(phy, mmd, reg, &val);
+	if (!ret) {
+		val &= ~clear;
+		ret = mdio_write(phy, mmd, reg, val | set);
+	}
+	return ret;
+}
+
+/**
+ *	t3_phy_reset - reset a PHY block
+ *	@phy: the PHY to operate on
+ *	@mmd: the device address of the PHY block to reset
+ *	@wait: how long to wait for the reset to complete in 1ms increments
+ *
+ *	Resets a PHY block and optionally waits for the reset to complete.
+ *	@mmd should be 0 for 10/100/1000 PHYs and the device address to reset
+ *	for 10G PHYs.
+ */
+int t3_phy_reset(struct cphy *phy, int mmd, int wait)
+{
+	int err;
+	unsigned int ctl;
+
+	err = t3_mdio_change_bits(phy, mmd, MII_BMCR, BMCR_PDOWN, BMCR_RESET);
+	if (err || !wait)
+		return err;
+
+	do {
+		err = mdio_read(phy, mmd, MII_BMCR, &ctl);
+		if (err)
+			return err;
+		ctl &= BMCR_RESET;
+		if (ctl)
+			msleep(1);
+	} while (ctl && --wait);
+
+	return ctl ? -1 : 0;
+}
+
+/**
+ *	t3_phy_advertise - set the PHY advertisement registers for autoneg
+ *	@phy: the PHY to operate on
+ *	@advert: bitmap of capabilities the PHY should advertise
+ *
+ *	Sets a 10/100/1000 PHY's advertisement registers to advertise the
+ *	requested capabilities.
+ */
+int t3_phy_advertise(struct cphy *phy, unsigned int advert)
+{
+	int err;
+	unsigned int val = 0;
+
+	err = mdio_read(phy, 0, MII_CTRL1000, &val);
+	if (err)
+		return err;
+
+	val &= ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
+	if (advert & ADVERTISED_1000baseT_Half)
+		val |= ADVERTISE_1000HALF;
+	if (advert & ADVERTISED_1000baseT_Full)
+		val |= ADVERTISE_1000FULL;
+
+	err = mdio_write(phy, 0, MII_CTRL1000, val);
+	if (err)
+		return err;
+
+	val = 1;
+	if (advert & ADVERTISED_10baseT_Half)
+		val |= ADVERTISE_10HALF;
+	if (advert & ADVERTISED_10baseT_Full)
+		val |= ADVERTISE_10FULL;
+	if (advert & ADVERTISED_100baseT_Half)
+		val |= ADVERTISE_100HALF;
+	if (advert & ADVERTISED_100baseT_Full)
+		val |= ADVERTISE_100FULL;
+	if (advert & ADVERTISED_Pause)
+		val |= ADVERTISE_PAUSE_CAP;
+	if (advert & ADVERTISED_Asym_Pause)
+		val |= ADVERTISE_PAUSE_ASYM;
+	return mdio_write(phy, 0, MII_ADVERTISE, val);
+}
+
+/**
+ *	t3_set_phy_speed_duplex - force PHY speed and duplex
+ *	@phy: the PHY to operate on
+ *	@speed: requested PHY speed
+ *	@duplex: requested PHY duplex
+ *
+ *	Force a 10/100/1000 PHY's speed and duplex.  This also disables
+ *	auto-negotiation except for GigE, where auto-negotiation is mandatory.
+ */
+int t3_set_phy_speed_duplex(struct cphy *phy, int speed, int duplex)
+{
+	int err;
+	unsigned int ctl;
+
+	err = mdio_read(phy, 0, MII_BMCR, &ctl);
+	if (err)
+		return err;
+
+	if (speed >= 0) {
+		ctl &= ~(BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);
+		if (speed == SPEED_100)
+			ctl |= BMCR_SPEED100;
+		else if (speed == SPEED_1000)
+			ctl |= BMCR_SPEED1000;
+	}
+	if (duplex >= 0) {
+		ctl &= ~(BMCR_FULLDPLX | BMCR_ANENABLE);
+		if (duplex == DUPLEX_FULL)
+			ctl |= BMCR_FULLDPLX;
+	}
+	if (ctl & BMCR_SPEED1000) /* auto-negotiation required for GigE */
+		ctl |= BMCR_ANENABLE;
+	return mdio_write(phy, 0, MII_BMCR, ctl);
+}
+
+static const struct adapter_info t3_adap_info[] = {
+	{2, 0, 0, 0,
+	 F_GPIO2_OEN | F_GPIO4_OEN |
+	 F_GPIO2_OUT_VAL | F_GPIO4_OUT_VAL, F_GPIO3 | F_GPIO5,
+	 SUPPORTED_OFFLOAD,
+	 &mi1_mdio_ops, "Chelsio PE9000"},
+	{2, 0, 0, 0,
+	 F_GPIO2_OEN | F_GPIO4_OEN |
+	 F_GPIO2_OUT_VAL | F_GPIO4_OUT_VAL, F_GPIO3 | F_GPIO5,
+	 SUPPORTED_OFFLOAD,
+	 &mi1_mdio_ops, "Chelsio T302"},
+	{1, 0, 0, 0,
+	 F_GPIO1_OEN | F_GPIO6_OEN | F_GPIO7_OEN | F_GPIO10_OEN |
+	 F_GPIO1_OUT_VAL | F_GPIO6_OUT_VAL | F_GPIO10_OUT_VAL, 0,
+	 SUPPORTED_10000baseT_Full | SUPPORTED_AUI | SUPPORTED_OFFLOAD,
+	 &mi1_mdio_ext_ops, "Chelsio T310"},
+	{2, 0, 0, 0,
+	 F_GPIO1_OEN | F_GPIO2_OEN | F_GPIO4_OEN | F_GPIO5_OEN | F_GPIO6_OEN |
+	 F_GPIO7_OEN | F_GPIO10_OEN | F_GPIO11_OEN | F_GPIO1_OUT_VAL |
+	 F_GPIO5_OUT_VAL | F_GPIO6_OUT_VAL | F_GPIO10_OUT_VAL, 0,
+	 SUPPORTED_10000baseT_Full | SUPPORTED_AUI | SUPPORTED_OFFLOAD,
+	 &mi1_mdio_ext_ops, "Chelsio T320"},
+};
+
+/*
+ * Return the adapter_info structure with a given index.  Out-of-range indices
+ * return NULL.
+ */
+const struct adapter_info *t3_get_adapter_info(unsigned int id)
+{
+	return id < ARRAY_SIZE(t3_adap_info) ? &t3_adap_info[id] : NULL;
+}
+
+#define CAPS_1G (SUPPORTED_10baseT_Full | SUPPORTED_100baseT_Full | \
+		 SUPPORTED_1000baseT_Full | SUPPORTED_Autoneg | SUPPORTED_MII)
+#define CAPS_10G (SUPPORTED_10000baseT_Full | SUPPORTED_AUI)
+
+static const struct port_type_info port_types[] = {
+	{NULL},
+	{t3_ael1002_phy_prep, CAPS_10G | SUPPORTED_FIBRE,
+	 "10GBASE-XR"},
+	{t3_vsc8211_phy_prep, CAPS_1G | SUPPORTED_TP | SUPPORTED_IRQ,
+	 "10/100/1000BASE-T"},
+	{NULL, CAPS_1G | SUPPORTED_TP | SUPPORTED_IRQ,
+	 "10/100/1000BASE-T"},
+	{t3_xaui_direct_phy_prep, CAPS_10G | SUPPORTED_TP, "10GBASE-CX4"},
+	{NULL, CAPS_10G, "10GBASE-KX4"},
+	{t3_qt2045_phy_prep, CAPS_10G | SUPPORTED_TP, "10GBASE-CX4"},
+	{t3_ael1006_phy_prep, CAPS_10G | SUPPORTED_FIBRE,
+	 "10GBASE-SR"},
+	{NULL, CAPS_10G | SUPPORTED_TP, "10GBASE-CX4"},
+};
+
+#undef CAPS_1G
+#undef CAPS_10G
+
+#define VPD_ENTRY(name, len) \
+	u8 name##_kword[2]; u8 name##_len; u8 name##_data[len]
+
+/*
+ * Partial EEPROM Vital Product Data structure.  Includes only the ID and
+ * VPD-R sections.
+ */
+struct t3_vpd {
+	u8 id_tag;
+	u8 id_len[2];
+	u8 id_data[16];
+	u8 vpdr_tag;
+	u8 vpdr_len[2];
+	 VPD_ENTRY(pn, 16);	/* part number */
+	 VPD_ENTRY(ec, 16);	/* EC level */
+	 VPD_ENTRY(sn, 16);	/* serial number */
+	 VPD_ENTRY(na, 12);	/* MAC address base */
+	 VPD_ENTRY(cclk, 6);	/* core clock */
+	 VPD_ENTRY(mclk, 6);	/* mem clock */
+	 VPD_ENTRY(uclk, 6);	/* uP clk */
+	 VPD_ENTRY(mdc, 6);	/* MDIO clk */
+	 VPD_ENTRY(mt, 2);	/* mem timing */
+	 VPD_ENTRY(xaui0cfg, 6);	/* XAUI0 config */
+	 VPD_ENTRY(xaui1cfg, 6);	/* XAUI1 config */
+	 VPD_ENTRY(port0, 2);	/* PHY0 complex */
+	 VPD_ENTRY(port1, 2);	/* PHY1 complex */
+	 VPD_ENTRY(port2, 2);	/* PHY2 complex */
+	 VPD_ENTRY(port3, 2);	/* PHY3 complex */
+	 VPD_ENTRY(rv, 1);	/* csum */
+	u32 pad;		/* for multiple-of-4 sizing and alignment */
+};
+
+#define EEPROM_MAX_POLL   4
+#define EEPROM_STAT_ADDR  0x4000
+#define VPD_BASE          0xc00
+
+/**
+ *	t3_seeprom_read - read a VPD EEPROM location
+ *	@adapter: adapter to read
+ *	@addr: EEPROM address
+ *	@data: where to store the read data
+ *
+ *	Read a 32-bit word from a location in VPD EEPROM using the card's PCI
+ *	VPD ROM capability.  A zero is written to the flag bit when the
+ *	addres is written to the control register.  The hardware device will
+ *	set the flag to 1 when 4 bytes have been read into the data register.
+ */
+int t3_seeprom_read(struct adapter *adapter, u32 addr, u32 *data)
+{
+	u16 val;
+	int attempts = EEPROM_MAX_POLL;
+	unsigned int base = adapter->params.pci.vpd_cap_addr;
+
+	if ((addr >= EEPROMSIZE && addr != EEPROM_STAT_ADDR) || (addr & 3))
+		return -EINVAL;
+
+	pci_write_config_word(adapter->pdev, base + PCI_VPD_ADDR, (u16) addr);
+	do {
+		udelay(10);
+		pci_read_config_word(adapter->pdev, base + PCI_VPD_ADDR, &val);
+	} while (!(val & PCI_VPD_ADDR_F) && --attempts);
+
+	if (!(val & PCI_VPD_ADDR_F)) {
+		CH_ERR(adapter, "reading EEPROM address 0x%x failed\n", addr);
+		return -EIO;
+	}
+	pci_read_config_dword(adapter->pdev, base + PCI_VPD_DATA, data);
+	*data = le32_to_cpu(*data);
+	return 0;
+}
+
+/**
+ *	t3_seeprom_write - write a VPD EEPROM location
+ *	@adapter: adapter to write
+ *	@addr: EEPROM address
+ *	@data: value to write
+ *
+ *	Write a 32-bit word to a location in VPD EEPROM using the card's PCI
+ *	VPD ROM capability.
+ */
+int t3_seeprom_write(struct adapter *adapter, u32 addr, u32 data)
+{
+	u16 val;
+	int attempts = EEPROM_MAX_POLL;
+	unsigned int base = adapter->params.pci.vpd_cap_addr;
+
+	if ((addr >= EEPROMSIZE && addr != EEPROM_STAT_ADDR) || (addr & 3))
+		return -EINVAL;
+
+	pci_write_config_dword(adapter->pdev, base + PCI_VPD_DATA,
+			       cpu_to_le32(data));
+	pci_write_config_word(adapter->pdev,base + PCI_VPD_ADDR,
+			      (u16)addr | PCI_VPD_ADDR_F);
+	do {
+		msleep(1);
+		pci_read_config_word(adapter->pdev, base + PCI_VPD_ADDR, &val);
+	} while ((val & PCI_VPD_ADDR_F) && --attempts);
+
+	if (val & PCI_VPD_ADDR_F) {
+		CH_ERR(adapter, "write to EEPROM address 0x%x failed\n", addr);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ *	t3_seeprom_wp - enable/disable EEPROM write protection
+ *	@adapter: the adapter
+ *	@enable: 1 to enable write protection, 0 to disable it
+ *
+ *	Enables or disables write protection on the serial EEPROM.
+ */
+int t3_seeprom_wp(struct adapter *adapter, int enable)
+{
+	return t3_seeprom_write(adapter, EEPROM_STAT_ADDR, enable ? 0xc : 0);
+}
+
+/*
+ * Convert a character holding a hex digit to a number.
+ */
+static unsigned int hex2int(unsigned char c)
+{
+	return isdigit(c) ? c - '0' : toupper(c) - 'A' + 10;
+}
+
+/**
+ *	get_vpd_params - read VPD parameters from VPD EEPROM
+ *	@adapter: adapter to read
+ *	@p: where to store the parameters
+ *
+ *	Reads card parameters stored in VPD EEPROM.
+ */
+static int get_vpd_params(struct adapter *adapter, struct vpd_params *p)
+{
+	int i, addr, ret;
+	struct t3_vpd vpd;
+
+	/*
+	 * Card information is normally at VPD_BASE but some early cards had
+	 * it at 0.
+	 */
+	ret = t3_seeprom_read(adapter, VPD_BASE, (u32 *) & vpd);
+	if (ret)
+		return ret;
+	addr = vpd.id_tag == 0x82 ? VPD_BASE : 0;
+
+	for (i = 0; i < sizeof(vpd); i += 4) {
+		ret = t3_seeprom_read(adapter, addr + i,
+				      (u32 *)((u8 *)&vpd + i));
+		if (ret)
+			return ret;
+	}
+
+	p->cclk = simple_strtoul(vpd.cclk_data, NULL, 10);
+	p->mclk = simple_strtoul(vpd.mclk_data, NULL, 10);
+	p->uclk = simple_strtoul(vpd.uclk_data, NULL, 10);
+	p->mdc = simple_strtoul(vpd.mdc_data, NULL, 10);
+	p->mem_timing = simple_strtoul(vpd.mt_data, NULL, 10);
+
+	/* Old eeproms didn't have port information */
+	if (adapter->params.rev == 0 && !vpd.port0_data[0]) {
+		p->port_type[0] = uses_xaui(adapter) ? 1 : 2;
+		p->port_type[1] = uses_xaui(adapter) ? 6 : 2;
+	} else {
+		p->port_type[0] = (u8) hex2int(vpd.port0_data[0]);
+		p->port_type[1] = (u8) hex2int(vpd.port1_data[0]);
+		p->xauicfg[0] = simple_strtoul(vpd.xaui0cfg_data, NULL, 16);
+		p->xauicfg[1] = simple_strtoul(vpd.xaui1cfg_data, NULL, 16);
+	}
+
+	for (i = 0; i < 6; i++)
+		p->eth_base[i] = hex2int(vpd.na_data[2 * i]) * 16 +
+				 hex2int(vpd.na_data[2 * i + 1]);
+	return 0;
+}
+
+/* serial flash and firmware constants */
+enum {
+	SF_ATTEMPTS = 5,	/* max retries for SF1 operations */
+	SF_SEC_SIZE = 64 * 1024,	/* serial flash sector size */
+	SF_SIZE = SF_SEC_SIZE * 8,	/* serial flash size */
+
+	/* flash command opcodes */
+	SF_PROG_PAGE = 2,	/* program page */
+	SF_WR_DISABLE = 4,	/* disable writes */
+	SF_RD_STATUS = 5,	/* read status register */
+	SF_WR_ENABLE = 6,	/* enable writes */
+	SF_RD_DATA_FAST = 0xb,	/* read flash */
+	SF_ERASE_SECTOR = 0xd8,	/* erase sector */
+
+	FW_FLASH_BOOT_ADDR = 0x70000,	/* start address of FW in flash */
+	FW_VERS_ADDR = 0x77ffc	/* flash address holding FW version */
+};
+
+/**
+ *	sf1_read - read data from the serial flash
+ *	@adapter: the adapter
+ *	@byte_cnt: number of bytes to read
+ *	@cont: whether another operation will be chained
+ *	@valp: where to store the read data
+ *
+ *	Reads up to 4 bytes of data from the serial flash.  The location of
+ *	the read needs to be specified prior to calling this by issuing the
+ *	appropriate commands to the serial flash.
+ */
+static int sf1_read(struct adapter *adapter, unsigned int byte_cnt, int cont,
+		    u32 *valp)
+{
+	int ret;
+
+	if (!byte_cnt || byte_cnt > 4)
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SF_OP) & F_BUSY)
+		return -EBUSY;
+	t3_write_reg(adapter, A_SF_OP, V_CONT(cont) | V_BYTECNT(byte_cnt - 1));
+	ret = t3_wait_op_done(adapter, A_SF_OP, F_BUSY, 0, SF_ATTEMPTS, 10);
+	if (!ret)
+		*valp = t3_read_reg(adapter, A_SF_DATA);
+	return ret;
+}
+
+/**
+ *	sf1_write - write data to the serial flash
+ *	@adapter: the adapter
+ *	@byte_cnt: number of bytes to write
+ *	@cont: whether another operation will be chained
+ *	@val: value to write
+ *
+ *	Writes up to 4 bytes of data to the serial flash.  The location of
+ *	the write needs to be specified prior to calling this by issuing the
+ *	appropriate commands to the serial flash.
+ */
+static int sf1_write(struct adapter *adapter, unsigned int byte_cnt, int cont,
+		     u32 val)
+{
+	if (!byte_cnt || byte_cnt > 4)
+		return -EINVAL;
+	if (t3_read_reg(adapter, A_SF_OP) & F_BUSY)
+		return -EBUSY;
+	t3_write_reg(adapter, A_SF_DATA, val);
+	t3_write_reg(adapter, A_SF_OP,
+		     V_CONT(cont) | V_BYTECNT(byte_cnt - 1) | V_OP(1));
+	return t3_wait_op_done(adapter, A_SF_OP, F_BUSY, 0, SF_ATTEMPTS, 10);
+}
+
+/**
+ *	flash_wait_op - wait for a flash operation to complete
+ *	@adapter: the adapter
+ *	@attempts: max number of polls of the status register
+ *	@delay: delay between polls in ms
+ *
+ *	Wait for a flash operation to complete by polling the status register.
+ */
+static int flash_wait_op(struct adapter *adapter, int attempts, int delay)
+{
+	int ret;
+	u32 status;
+
+	while (1) {
+		if ((ret = sf1_write(adapter, 1, 1, SF_RD_STATUS)) != 0 ||
+		    (ret = sf1_read(adapter, 1, 0, &status)) != 0)
+			return ret;
+		if (!(status & 1))
+			return 0;
+		if (--attempts == 0)
+			return -EAGAIN;
+		if (delay)
+			msleep(delay);
+	}
+}
+
+/**
+ *	t3_read_flash - read words from serial flash
+ *	@adapter: the adapter
+ *	@addr: the start address for the read
+ *	@nwords: how many 32-bit words to read
+ *	@data: where to store the read data
+ *	@byte_oriented: whether to store data as bytes or as words
+ *
+ *	Read the specified number of 32-bit words from the serial flash.
+ *	If @byte_oriented is set the read data is stored as a byte array
+ *	(i.e., big-endian), otherwise as 32-bit words in the platform's
+ *	natural endianess.
+ */
+int t3_read_flash(struct adapter *adapter, unsigned int addr,
+		  unsigned int nwords, u32 *data, int byte_oriented)
+{
+	int ret;
+
+	if (addr + nwords * sizeof(u32) > SF_SIZE || (addr & 3))
+		return -EINVAL;
+
+	addr = swab32(addr) | SF_RD_DATA_FAST;
+
+	if ((ret = sf1_write(adapter, 4, 1, addr)) != 0 ||
+	    (ret = sf1_read(adapter, 1, 1, data)) != 0)
+		return ret;
+
+	for (; nwords; nwords--, data++) {
+		ret = sf1_read(adapter, 4, nwords > 1, data);
+		if (ret)
+			return ret;
+		if (byte_oriented)
+			*data = htonl(*data);
+	}
+	return 0;
+}
+
+/**
+ *	t3_write_flash - write up to a page of data to the serial flash
+ *	@adapter: the adapter
+ *	@addr: the start address to write
+ *	@n: length of data to write
+ *	@data: the data to write
+ *
+ *	Writes up to a page of data (256 bytes) to the serial flash starting
+ *	at the given address.
+ */
+static int t3_write_flash(struct adapter *adapter, unsigned int addr,
+			  unsigned int n, const u8 * data)
+{
+	int ret;
+	u32 buf[64];
+	unsigned int i, c, left, val, offset = addr & 0xff;
+
+	if (addr + n > SF_SIZE || offset + n > 256)
+		return -EINVAL;
+
+	val = swab32(addr) | SF_PROG_PAGE;
+
+	if ((ret = sf1_write(adapter, 1, 0, SF_WR_ENABLE)) != 0 ||
+	    (ret = sf1_write(adapter, 4, 1, val)) != 0)
+		return ret;
+
+	for (left = n; left; left -= c) {
+		c = min(left, 4U);
+		for (val = 0, i = 0; i < c; ++i)
+			val = (val << 8) + *data++;
+
+		ret = sf1_write(adapter, c, c != left, val);
+		if (ret)
+			return ret;
+	}
+	if ((ret = flash_wait_op(adapter, 5, 1)) != 0)
+		return ret;
+
+	/* Read the page to verify the write succeeded */
+	ret = t3_read_flash(adapter, addr & ~0xff, ARRAY_SIZE(buf), buf, 1);
+	if (ret)
+		return ret;
+
+	if (memcmp(data - n, (u8 *) buf + offset, n))
+		return -EIO;
+	return 0;
+}
+
+/**
+ *	t3_get_fw_version - read the firmware version
+ *	@adapter: the adapter
+ *	@vers: where to place the version
+ *
+ *	Reads the FW version from flash.
+ */
+int t3_get_fw_version(struct adapter *adapter, u32 *vers)
+{
+	return t3_read_flash(adapter, FW_VERS_ADDR, 1, vers, 0);
+}
+
+/**
+ *	t3_check_fw_version - check if the FW is compatible with this driver
+ *	@adapter: the adapter
+ *
+ *	Checks if an adapter's FW is compatible with the driver.  Returns 0
+ *	if the versions are compatible, a negative error otherwise.
+ */
+int t3_check_fw_version(struct adapter *adapter)
+{
+	int ret;
+	u32 vers;
+
+	ret = t3_get_fw_version(adapter, &vers);
+	if (ret)
+		return ret;
+
+	/* Minor 0xfff means the FW is an internal development-only version. */
+	if ((vers & 0xfff) == 0xfff)
+		return 0;
+
+	if (vers == 0x1002009)
+		return 0;
+
+	CH_ERR(adapter, "found wrong FW version, driver needs version 2.9\n");
+	return -EINVAL;
+}
+
+/**
+ *	t3_flash_erase_sectors - erase a range of flash sectors
+ *	@adapter: the adapter
+ *	@start: the first sector to erase
+ *	@end: the last sector to erase
+ *
+ *	Erases the sectors in the given range.
+ */
+static int t3_flash_erase_sectors(struct adapter *adapter, int start, int end)
+{
+	while (start <= end) {
+		int ret;
+
+		if ((ret = sf1_write(adapter, 1, 0, SF_WR_ENABLE)) != 0 ||
+		    (ret = sf1_write(adapter, 4, 0,
+				     SF_ERASE_SECTOR | (start << 8))) != 0 ||
+		    (ret = flash_wait_op(adapter, 5, 500)) != 0)
+			return ret;
+		start++;
+	}
+	return 0;
+}
+
+/*
+ *	t3_load_fw - download firmware
+ *	@adapter: the adapter
+ *	@fw_data: the firrware image to write
+ *	@size: image size
+ *
+ *	Write the supplied firmware image to the card's serial flash.
+ *	The FW image has the following sections: @size - 8 bytes of code and
+ *	data, followed by 4 bytes of FW version, followed by the 32-bit
+ *	1's complement checksum of the whole image.
+ */
+int t3_load_fw(struct adapter *adapter, const u8 * fw_data, unsigned int size)
+{
+	u32 csum;
+	unsigned int i;
+	const u32 *p = (const u32 *)fw_data;
+	int ret, addr, fw_sector = FW_FLASH_BOOT_ADDR >> 16;
+
+	if (size & 3)
+		return -EINVAL;
+	if (size > FW_VERS_ADDR + 8 - FW_FLASH_BOOT_ADDR)
+		return -EFBIG;
+
+	for (csum = 0, i = 0; i < size / sizeof(csum); i++)
+		csum += ntohl(p[i]);
+	if (csum != 0xffffffff) {
+		CH_ERR(adapter, "corrupted firmware image, checksum %u\n",
+		       csum);
+		return -EINVAL;
+	}
+
+	ret = t3_flash_erase_sectors(adapter, fw_sector, fw_sector);
+	if (ret)
+		goto out;
+
+	size -= 8;		/* trim off version and checksum */
+	for (addr = FW_FLASH_BOOT_ADDR; size;) {
+		unsigned int chunk_size = min(size, 256U);
+
+		ret = t3_write_flash(adapter, addr, chunk_size, fw_data);
+		if (ret)
+			goto out;
+
+		addr += chunk_size;
+		fw_data += chunk_size;
+		size -= chunk_size;
+	}
+
+	ret = t3_write_flash(adapter, FW_VERS_ADDR, 4, fw_data);
+out:
+	if (ret)
+		CH_ERR(adapter, "firmware download failed, error %d\n", ret);
+	return ret;
+}
+
+#define CIM_CTL_BASE 0x2000
+
+/**
+ *      t3_cim_ctl_blk_read - read a block from CIM control region
+ *
+ *      @adap: the adapter
+ *      @addr: the start address within the CIM control region
+ *      @n: number of words to read
+ *      @valp: where to store the result
+ *
+ *      Reads a block of 4-byte words from the CIM control region.
+ */
+int t3_cim_ctl_blk_read(struct adapter *adap, unsigned int addr,
+			unsigned int n, unsigned int *valp)
+{
+	int ret = 0;
+
+	if (t3_read_reg(adap, A_CIM_HOST_ACC_CTRL) & F_HOSTBUSY)
+		return -EBUSY;
+
+	for ( ; !ret && n--; addr += 4) {
+		t3_write_reg(adap, A_CIM_HOST_ACC_CTRL, CIM_CTL_BASE + addr);
+		ret = t3_wait_op_done(adap, A_CIM_HOST_ACC_CTRL, F_HOSTBUSY,
+				      0, 5, 2);
+		if (!ret)
+			*valp++ = t3_read_reg(adap, A_CIM_HOST_ACC_DATA);
+	}
+	return ret;
+}
+
+
+/**
+ *	t3_link_changed - handle interface link changes
+ *	@adapter: the adapter
+ *	@port_id: the port index that changed link state
+ *
+ *	Called when a port's link settings change to propagate the new values
+ *	to the associated PHY and MAC.  After performing the common tasks it
+ *	invokes an OS-specific handler.
+ */
+void t3_link_changed(struct adapter *adapter, int port_id)
+{
+	int link_ok, speed, duplex, fc;
+	struct port_info *pi = adap2pinfo(adapter, port_id);
+	struct cphy *phy = &pi->phy;
+	struct cmac *mac = &pi->mac;
+	struct link_config *lc = &pi->link_config;
+
+	phy->ops->get_link_status(phy, &link_ok, &speed, &duplex, &fc);
+
+	if (link_ok != lc->link_ok && adapter->params.rev > 0 &&
+	    uses_xaui(adapter)) {
+		if (link_ok)
+			t3b_pcs_reset(mac);
+		t3_write_reg(adapter, A_XGM_XAUI_ACT_CTRL + mac->offset,
+			     link_ok ? F_TXACTENABLE | F_RXEN : 0);
+	}
+	lc->link_ok = (unsigned char)link_ok;
+	lc->speed = speed < 0 ? SPEED_INVALID : speed;
+	lc->duplex = duplex < 0 ? DUPLEX_INVALID : duplex;
+	if (lc->requested_fc & PAUSE_AUTONEG)
+		fc &= lc->requested_fc;
+	else
+		fc = lc->requested_fc & (PAUSE_RX | PAUSE_TX);
+
+	if (link_ok && speed >= 0 && lc->autoneg == AUTONEG_ENABLE) {
+		/* Set MAC speed, duplex, and flow control to match PHY. */
+		t3_mac_set_speed_duplex_fc(mac, speed, duplex, fc);
+		lc->fc = (unsigned char)fc;
+	}
+
+	t3_os_link_changed(adapter, port_id, link_ok, speed, duplex, fc);
+}
+
+/**
+ *	t3_link_start - apply link configuration to MAC/PHY
+ *	@phy: the PHY to setup
+ *	@mac: the MAC to setup
+ *	@lc: the requested link configuration
+ *
+ *	Set up a port's MAC and PHY according to a desired link configuration.
+ *	- If the PHY can auto-negotiate first decide what to advertise, then
+ *	  enable/disable auto-negotiation as desired, and reset.
+ *	- If the PHY does not auto-negotiate just reset it.
+ *	- If auto-negotiation is off set the MAC to the proper speed/duplex/FC,
+ *	  otherwise do it later based on the outcome of auto-negotiation.
+ */
+int t3_link_start(struct cphy *phy, struct cmac *mac, struct link_config *lc)
+{
+	unsigned int fc = lc->requested_fc & (PAUSE_RX | PAUSE_TX);
+
+	lc->link_ok = 0;
+	if (lc->supported & SUPPORTED_Autoneg) {
+		lc->advertising &= ~(ADVERTISED_Asym_Pause | ADVERTISED_Pause);
+		if (fc) {
+			lc->advertising |= ADVERTISED_Asym_Pause;
+			if (fc & PAUSE_RX)
+				lc->advertising |= ADVERTISED_Pause;
+		}
+		phy->ops->advertise(phy, lc->advertising);
+
+		if (lc->autoneg == AUTONEG_DISABLE) {
+			lc->speed = lc->requested_speed;
+			lc->duplex = lc->requested_duplex;
+			lc->fc = (unsigned char)fc;
+			t3_mac_set_speed_duplex_fc(mac, lc->speed, lc->duplex,
+						   fc);
+			/* Also disables autoneg */
+			phy->ops->set_speed_duplex(phy, lc->speed, lc->duplex);
+			phy->ops->reset(phy, 0);
+		} else
+			phy->ops->autoneg_enable(phy);
+	} else {
+		t3_mac_set_speed_duplex_fc(mac, -1, -1, fc);
+		lc->fc = (unsigned char)fc;
+		phy->ops->reset(phy, 0);
+	}
+	return 0;
+}
+
+/**
+ *	t3_set_vlan_accel - control HW VLAN extraction
+ *	@adapter: the adapter
+ *	@ports: bitmap of adapter ports to operate on
+ *	@on: enable (1) or disable (0) HW VLAN extraction
+ *
+ *	Enables or disables HW extraction of VLAN tags for the given port.
+ */
+void t3_set_vlan_accel(struct adapter *adapter, unsigned int ports, int on)
+{
+	t3_set_reg_field(adapter, A_TP_OUT_CONFIG,
+			 ports << S_VLANEXTRACTIONENABLE,
+			 on ? (ports << S_VLANEXTRACTIONENABLE) : 0);
+}
+
+struct intr_info {
+	unsigned int mask;	/* bits to check in interrupt status */
+	const char *msg;	/* message to print or NULL */
+	short stat_idx;		/* stat counter to increment or -1 */
+	unsigned short fatal:1;	/* whether the condition reported is fatal */
+};
+
+/**
+ *	t3_handle_intr_status - table driven interrupt handler
+ *	@adapter: the adapter that generated the interrupt
+ *	@reg: the interrupt status register to process
+ *	@mask: a mask to apply to the interrupt status
+ *	@acts: table of interrupt actions
+ *	@stats: statistics counters tracking interrupt occurences
+ *
+ *	A table driven interrupt handler that applies a set of masks to an
+ *	interrupt status word and performs the corresponding actions if the
+ *	interrupts described by the mask have occured.  The actions include
+ *	optionally printing a warning or alert message, and optionally
+ *	incrementing a stat counter.  The table is terminated by an entry
+ *	specifying mask 0.  Returns the number of fatal interrupt conditions.
+ */
+static int t3_handle_intr_status(struct adapter *adapter, unsigned int reg,
+				 unsigned int mask,
+				 const struct intr_info *acts,
+				 unsigned long *stats)
+{
+	int fatal = 0;
+	unsigned int status = t3_read_reg(adapter, reg) & mask;
+
+	for (; acts->mask; ++acts) {
+		if (!(status & acts->mask))
+			continue;
+		if (acts->fatal) {
+			fatal++;
+			CH_ALERT(adapter, "%s (0x%x)\n",
+				 acts->msg, status & acts->mask);
+		} else if (acts->msg)
+			CH_WARN(adapter, "%s (0x%x)\n",
+				acts->msg, status & acts->mask);
+		if (acts->stat_idx >= 0)
+			stats[acts->stat_idx]++;
+	}
+	if (status)		/* clear processed interrupts */
+		t3_write_reg(adapter, reg, status);
+	return fatal;
+}
+
+#define SGE_INTR_MASK (F_RSPQDISABLED)
+#define MC5_INTR_MASK (F_PARITYERR | F_ACTRGNFULL | F_UNKNOWNCMD | \
+		       F_REQQPARERR | F_DISPQPARERR | F_DELACTEMPTY | \
+		       F_NFASRCHFAIL)
+#define MC7_INTR_MASK (F_AE | F_UE | F_CE | V_PE(M_PE))
+#define XGM_INTR_MASK (V_TXFIFO_PRTY_ERR(M_TXFIFO_PRTY_ERR) | \
+		       V_RXFIFO_PRTY_ERR(M_RXFIFO_PRTY_ERR) | \
+		       F_TXFIFO_UNDERRUN | F_RXFIFO_OVERFLOW)
+#define PCIX_INTR_MASK (F_MSTDETPARERR | F_SIGTARABT | F_RCVTARABT | \
+			F_RCVMSTABT | F_SIGSYSERR | F_DETPARERR | \
+			F_SPLCMPDIS | F_UNXSPLCMP | F_RCVSPLCMPERR | \
+			F_DETCORECCERR | F_DETUNCECCERR | F_PIOPARERR | \
+			V_WFPARERR(M_WFPARERR) | V_RFPARERR(M_RFPARERR) | \
+			V_CFPARERR(M_CFPARERR) /* | V_MSIXPARERR(M_MSIXPARERR) */)
+#define PCIE_INTR_MASK (F_UNXSPLCPLERRR | F_UNXSPLCPLERRC | F_PCIE_PIOPARERR |\
+			F_PCIE_WFPARERR | F_PCIE_RFPARERR | F_PCIE_CFPARERR | \
+			/* V_PCIE_MSIXPARERR(M_PCIE_MSIXPARERR) | */ \
+			V_BISTERR(M_BISTERR) | F_PEXERR)
+#define ULPRX_INTR_MASK F_PARERR
+#define ULPTX_INTR_MASK 0
+#define CPLSW_INTR_MASK (F_TP_FRAMING_ERROR | \
+			 F_SGE_FRAMING_ERROR | F_CIM_FRAMING_ERROR | \
+			 F_ZERO_SWITCH_ERROR)
+#define CIM_INTR_MASK (F_BLKWRPLINT | F_BLKRDPLINT | F_BLKWRCTLINT | \
+		       F_BLKRDCTLINT | F_BLKWRFLASHINT | F_BLKRDFLASHINT | \
+		       F_SGLWRFLASHINT | F_WRBLKFLASHINT | F_BLKWRBOOTINT | \
+	 	       F_FLASHRANGEINT | F_SDRAMRANGEINT | F_RSVDSPACEINT)
+#define PMTX_INTR_MASK (F_ZERO_C_CMD_ERROR | ICSPI_FRM_ERR | OESPI_FRM_ERR | \
+			V_ICSPI_PAR_ERROR(M_ICSPI_PAR_ERROR) | \
+			V_OESPI_PAR_ERROR(M_OESPI_PAR_ERROR))
+#define PMRX_INTR_MASK (F_ZERO_E_CMD_ERROR | IESPI_FRM_ERR | OCSPI_FRM_ERR | \
+			V_IESPI_PAR_ERROR(M_IESPI_PAR_ERROR) | \
+			V_OCSPI_PAR_ERROR(M_OCSPI_PAR_ERROR))
+#define MPS_INTR_MASK (V_TX0TPPARERRENB(M_TX0TPPARERRENB) | \
+		       V_TX1TPPARERRENB(M_TX1TPPARERRENB) | \
+		       V_RXTPPARERRENB(M_RXTPPARERRENB) | \
+		       V_MCAPARERRENB(M_MCAPARERRENB))
+#define PL_INTR_MASK (F_T3DBG | F_XGMAC0_0 | F_XGMAC0_1 | F_MC5A | F_PM1_TX | \
+		      F_PM1_RX | F_ULP2_TX | F_ULP2_RX | F_TP1 | F_CIM | \
+		      F_MC7_CM | F_MC7_PMTX | F_MC7_PMRX | F_SGE3 | F_PCIM0 | \
+		      F_MPS0 | F_CPL_SWITCH)
+
+/*
+ * Interrupt handler for the PCIX1 module.
+ */
+static void pci_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info pcix1_intr_info[] = {
+		{ F_PEXERR, "PCI PEX error", -1, 1 },
+		{F_MSTDETPARERR, "PCI master detected parity error", -1, 1},
+		{F_SIGTARABT, "PCI signaled target abort", -1, 1},
+		{F_RCVTARABT, "PCI received target abort", -1, 1},
+		{F_RCVMSTABT, "PCI received master abort", -1, 1},
+		{F_SIGSYSERR, "PCI signaled system error", -1, 1},
+		{F_DETPARERR, "PCI detected parity error", -1, 1},
+		{F_SPLCMPDIS, "PCI split completion discarded", -1, 1},
+		{F_UNXSPLCMP, "PCI unexpected split completion error", -1, 1},
+		{F_RCVSPLCMPERR, "PCI received split completion error", -1,
+		 1},
+		{F_DETCORECCERR, "PCI correctable ECC error",
+		 STAT_PCI_CORR_ECC, 0},
+		{F_DETUNCECCERR, "PCI uncorrectable ECC error", -1, 1},
+		{F_PIOPARERR, "PCI PIO FIFO parity error", -1, 1},
+		{V_WFPARERR(M_WFPARERR), "PCI write FIFO parity error", -1,
+		 1},
+		{V_RFPARERR(M_RFPARERR), "PCI read FIFO parity error", -1,
+		 1},
+		{V_CFPARERR(M_CFPARERR), "PCI command FIFO parity error", -1,
+		 1},
+		{V_MSIXPARERR(M_MSIXPARERR), "PCI MSI-X table/PBA parity "
+		 "error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_PCIX_INT_CAUSE, PCIX_INTR_MASK,
+				  pcix1_intr_info, adapter->irq_stats))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * Interrupt handler for the PCIE module.
+ */
+static void pcie_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info pcie_intr_info[] = {
+		{F_UNXSPLCPLERRR,
+		 "PCI unexpected split completion DMA read error", -1, 1},
+		{F_UNXSPLCPLERRC,
+		 "PCI unexpected split completion DMA command error", -1, 1},
+		{F_PCIE_PIOPARERR, "PCI PIO FIFO parity error", -1, 1},
+		{F_PCIE_WFPARERR, "PCI write FIFO parity error", -1, 1},
+		{F_PCIE_RFPARERR, "PCI read FIFO parity error", -1, 1},
+		{F_PCIE_CFPARERR, "PCI command FIFO parity error", -1, 1},
+		{V_PCIE_MSIXPARERR(M_PCIE_MSIXPARERR),
+		 "PCI MSI-X table/PBA parity error", -1, 1},
+		{V_BISTERR(M_BISTERR), "PCI BIST error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_PCIE_INT_CAUSE, PCIE_INTR_MASK,
+				  pcie_intr_info, adapter->irq_stats))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * TP interrupt handler.
+ */
+static void tp_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info tp_intr_info[] = {
+		{0xffffff, "TP parity error", -1, 1},
+		{0x1000000, "TP out of Rx pages", -1, 1},
+		{0x2000000, "TP out of Tx pages", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_TP_INT_CAUSE, 0xffffffff,
+				  tp_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * CIM interrupt handler.
+ */
+static void cim_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info cim_intr_info[] = {
+		{F_RSVDSPACEINT, "CIM reserved space write", -1, 1},
+		{F_SDRAMRANGEINT, "CIM SDRAM address out of range", -1, 1},
+		{F_FLASHRANGEINT, "CIM flash address out of range", -1, 1},
+		{F_BLKWRBOOTINT, "CIM block write to boot space", -1, 1},
+		{F_WRBLKFLASHINT, "CIM write to cached flash space", -1, 1},
+		{F_SGLWRFLASHINT, "CIM single write to flash space", -1, 1},
+		{F_BLKRDFLASHINT, "CIM block read from flash space", -1, 1},
+		{F_BLKWRFLASHINT, "CIM block write to flash space", -1, 1},
+		{F_BLKRDCTLINT, "CIM block read from CTL space", -1, 1},
+		{F_BLKWRCTLINT, "CIM block write to CTL space", -1, 1},
+		{F_BLKRDPLINT, "CIM block read from PL space", -1, 1},
+		{F_BLKWRPLINT, "CIM block write to PL space", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_CIM_HOST_INT_CAUSE, 0xffffffff,
+				  cim_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * ULP RX interrupt handler.
+ */
+static void ulprx_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info ulprx_intr_info[] = {
+		{F_PARERR, "ULP RX parity error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_ULPRX_INT_CAUSE, 0xffffffff,
+				  ulprx_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * ULP TX interrupt handler.
+ */
+static void ulptx_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info ulptx_intr_info[] = {
+		{F_PBL_BOUND_ERR_CH0, "ULP TX channel 0 PBL out of bounds",
+		 STAT_ULP_CH0_PBL_OOB, 0},
+		{F_PBL_BOUND_ERR_CH1, "ULP TX channel 1 PBL out of bounds",
+		 STAT_ULP_CH1_PBL_OOB, 0},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_ULPTX_INT_CAUSE, 0xffffffff,
+				  ulptx_intr_info, adapter->irq_stats))
+		t3_fatal_err(adapter);
+}
+
+#define ICSPI_FRM_ERR (F_ICSPI0_FIFO2X_RX_FRAMING_ERROR | \
+	F_ICSPI1_FIFO2X_RX_FRAMING_ERROR | F_ICSPI0_RX_FRAMING_ERROR | \
+	F_ICSPI1_RX_FRAMING_ERROR | F_ICSPI0_TX_FRAMING_ERROR | \
+	F_ICSPI1_TX_FRAMING_ERROR)
+#define OESPI_FRM_ERR (F_OESPI0_RX_FRAMING_ERROR | \
+	F_OESPI1_RX_FRAMING_ERROR | F_OESPI0_TX_FRAMING_ERROR | \
+	F_OESPI1_TX_FRAMING_ERROR | F_OESPI0_OFIFO2X_TX_FRAMING_ERROR | \
+	F_OESPI1_OFIFO2X_TX_FRAMING_ERROR)
+
+/*
+ * PM TX interrupt handler.
+ */
+static void pmtx_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info pmtx_intr_info[] = {
+		{F_ZERO_C_CMD_ERROR, "PMTX 0-length pcmd", -1, 1},
+		{ICSPI_FRM_ERR, "PMTX ispi framing error", -1, 1},
+		{OESPI_FRM_ERR, "PMTX ospi framing error", -1, 1},
+		{V_ICSPI_PAR_ERROR(M_ICSPI_PAR_ERROR),
+		 "PMTX ispi parity error", -1, 1},
+		{V_OESPI_PAR_ERROR(M_OESPI_PAR_ERROR),
+		 "PMTX ospi parity error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_PM1_TX_INT_CAUSE, 0xffffffff,
+				  pmtx_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+#define IESPI_FRM_ERR (F_IESPI0_FIFO2X_RX_FRAMING_ERROR | \
+	F_IESPI1_FIFO2X_RX_FRAMING_ERROR | F_IESPI0_RX_FRAMING_ERROR | \
+	F_IESPI1_RX_FRAMING_ERROR | F_IESPI0_TX_FRAMING_ERROR | \
+	F_IESPI1_TX_FRAMING_ERROR)
+#define OCSPI_FRM_ERR (F_OCSPI0_RX_FRAMING_ERROR | \
+	F_OCSPI1_RX_FRAMING_ERROR | F_OCSPI0_TX_FRAMING_ERROR | \
+	F_OCSPI1_TX_FRAMING_ERROR | F_OCSPI0_OFIFO2X_TX_FRAMING_ERROR | \
+	F_OCSPI1_OFIFO2X_TX_FRAMING_ERROR)
+
+/*
+ * PM RX interrupt handler.
+ */
+static void pmrx_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info pmrx_intr_info[] = {
+		{F_ZERO_E_CMD_ERROR, "PMRX 0-length pcmd", -1, 1},
+		{IESPI_FRM_ERR, "PMRX ispi framing error", -1, 1},
+		{OCSPI_FRM_ERR, "PMRX ospi framing error", -1, 1},
+		{V_IESPI_PAR_ERROR(M_IESPI_PAR_ERROR),
+		 "PMRX ispi parity error", -1, 1},
+		{V_OCSPI_PAR_ERROR(M_OCSPI_PAR_ERROR),
+		 "PMRX ospi parity error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_PM1_RX_INT_CAUSE, 0xffffffff,
+				  pmrx_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * CPL switch interrupt handler.
+ */
+static void cplsw_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info cplsw_intr_info[] = {
+/*		{ F_CIM_OVFL_ERROR, "CPL switch CIM overflow", -1, 1 }, */
+		{F_TP_FRAMING_ERROR, "CPL switch TP framing error", -1, 1},
+		{F_SGE_FRAMING_ERROR, "CPL switch SGE framing error", -1, 1},
+		{F_CIM_FRAMING_ERROR, "CPL switch CIM framing error", -1, 1},
+		{F_ZERO_SWITCH_ERROR, "CPL switch no-switch error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_CPL_INTR_CAUSE, 0xffffffff,
+				  cplsw_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+/*
+ * MPS interrupt handler.
+ */
+static void mps_intr_handler(struct adapter *adapter)
+{
+	static const struct intr_info mps_intr_info[] = {
+		{0x1ff, "MPS parity error", -1, 1},
+		{0}
+	};
+
+	if (t3_handle_intr_status(adapter, A_MPS_INT_CAUSE, 0xffffffff,
+				  mps_intr_info, NULL))
+		t3_fatal_err(adapter);
+}
+
+#define MC7_INTR_FATAL (F_UE | V_PE(M_PE) | F_AE)
+
+/*
+ * MC7 interrupt handler.
+ */
+static void mc7_intr_handler(struct mc7 *mc7)
+{
+	struct adapter *adapter = mc7->adapter;
+	u32 cause = t3_read_reg(adapter, mc7->offset + A_MC7_INT_CAUSE);
+
+	if (cause & F_CE) {
+		mc7->stats.corr_err++;
+		CH_WARN(adapter, "%s MC7 correctable error at addr 0x%x, "
+			"data 0x%x 0x%x 0x%x\n", mc7->name,
+			t3_read_reg(adapter, mc7->offset + A_MC7_CE_ADDR),
+			t3_read_reg(adapter, mc7->offset + A_MC7_CE_DATA0),
+			t3_read_reg(adapter, mc7->offset + A_MC7_CE_DATA1),
+			t3_read_reg(adapter, mc7->offset + A_MC7_CE_DATA2));
+	}
+
+	if (cause & F_UE) {
+		mc7->stats.uncorr_err++;
+		CH_ALERT(adapter, "%s MC7 uncorrectable error at addr 0x%x, "
+			 "data 0x%x 0x%x 0x%x\n", mc7->name,
+			 t3_read_reg(adapter, mc7->offset + A_MC7_UE_ADDR),
+			 t3_read_reg(adapter, mc7->offset + A_MC7_UE_DATA0),
+			 t3_read_reg(adapter, mc7->offset + A_MC7_UE_DATA1),
+			 t3_read_reg(adapter, mc7->offset + A_MC7_UE_DATA2));
+	}
+
+	if (G_PE(cause)) {
+		mc7->stats.parity_err++;
+		CH_ALERT(adapter, "%s MC7 parity error 0x%x\n",
+			 mc7->name, G_PE(cause));
+	}
+
+	if (cause & F_AE) {
+		u32 addr = 0;
+
+		if (adapter->params.rev > 0)
+			addr = t3_read_reg(adapter,
+					   mc7->offset + A_MC7_ERR_ADDR);
+		mc7->stats.addr_err++;
+		CH_ALERT(adapter, "%s MC7 address error: 0x%x\n",
+			 mc7->name, addr);
+	}
+
+	if (cause & MC7_INTR_FATAL)
+		t3_fatal_err(adapter);
+
+	t3_write_reg(adapter, mc7->offset + A_MC7_INT_CAUSE, cause);
+}
+
+#define XGM_INTR_FATAL (V_TXFIFO_PRTY_ERR(M_TXFIFO_PRTY_ERR) | \
+			V_RXFIFO_PRTY_ERR(M_RXFIFO_PRTY_ERR))
+/*
+ * XGMAC interrupt handler.
+ */
+static int mac_intr_handler(struct adapter *adap, unsigned int idx)
+{
+	struct cmac *mac = &adap2pinfo(adap, idx)->mac;
+	u32 cause = t3_read_reg(adap, A_XGM_INT_CAUSE + mac->offset);
+
+	if (cause & V_TXFIFO_PRTY_ERR(M_TXFIFO_PRTY_ERR)) {
+		mac->stats.tx_fifo_parity_err++;
+		CH_ALERT(adap, "port%d: MAC TX FIFO parity error\n", idx);
+	}
+	if (cause & V_RXFIFO_PRTY_ERR(M_RXFIFO_PRTY_ERR)) {
+		mac->stats.rx_fifo_parity_err++;
+		CH_ALERT(adap, "port%d: MAC RX FIFO parity error\n", idx);
+	}
+	if (cause & F_TXFIFO_UNDERRUN)
+		mac->stats.tx_fifo_urun++;
+	if (cause & F_RXFIFO_OVERFLOW)
+		mac->stats.rx_fifo_ovfl++;
+	if (cause & V_SERDES_LOS(M_SERDES_LOS))
+		mac->stats.serdes_signal_loss++;
+	if (cause & F_XAUIPCSCTCERR)
+		mac->stats.xaui_pcs_ctc_err++;
+	if (cause & F_XAUIPCSALIGNCHANGE)
+		mac->stats.xaui_pcs_align_change++;
+
+	t3_write_reg(adap, A_XGM_INT_CAUSE + mac->offset, cause);
+	if (cause & XGM_INTR_FATAL)
+		t3_fatal_err(adap);
+	return cause != 0;
+}
+
+/*
+ * Interrupt handler for PHY events.
+ */
+int t3_phy_intr_handler(struct adapter *adapter)
+{
+	static int intr_gpio_bits[] = { 8, 0x20 };
+
+	u32 i, cause = t3_read_reg(adapter, A_T3DBG_INT_CAUSE);
+
+	for_each_port(adapter, i) {
+		if (cause & intr_gpio_bits[i]) {
+			struct cphy *phy = &adap2pinfo(adapter, i)->phy;
+			int phy_cause = phy->ops->intr_handler(phy);
+
+			if (phy_cause & cphy_cause_link_change)
+				t3_link_changed(adapter, i);
+			if (phy_cause & cphy_cause_fifo_error)
+				phy->fifo_errors++;
+		}
+	}
+
+	t3_write_reg(adapter, A_T3DBG_INT_CAUSE, cause);
+	return 0;
+}
+
+/*
+ * T3 slow path (non-data) interrupt handler.
+ */
+int t3_slow_intr_handler(struct adapter *adapter)
+{
+	u32 cause = t3_read_reg(adapter, A_PL_INT_CAUSE0);
+
+	cause &= adapter->slow_intr_mask;
+	if (!cause)
+		return 0;
+	if (cause & F_PCIM0) {
+		if (is_pcie(adapter))
+			pcie_intr_handler(adapter);
+		else
+			pci_intr_handler(adapter);
+	}
+	if (cause & F_SGE3)
+		t3_sge_err_intr_handler(adapter);
+	if (cause & F_MC7_PMRX)
+		mc7_intr_handler(&adapter->pmrx);
+	if (cause & F_MC7_PMTX)
+		mc7_intr_handler(&adapter->pmtx);
+	if (cause & F_MC7_CM)
+		mc7_intr_handler(&adapter->cm);
+	if (cause & F_CIM)
+		cim_intr_handler(adapter);
+	if (cause & F_TP1)
+		tp_intr_handler(adapter);
+	if (cause & F_ULP2_RX)
+		ulprx_intr_handler(adapter);
+	if (cause & F_ULP2_TX)
+		ulptx_intr_handler(adapter);
+	if (cause & F_PM1_RX)
+		pmrx_intr_handler(adapter);
+	if (cause & F_PM1_TX)
+		pmtx_intr_handler(adapter);
+	if (cause & F_CPL_SWITCH)
+		cplsw_intr_handler(adapter);
+	if (cause & F_MPS0)
+		mps_intr_handler(adapter);
+	if (cause & F_MC5A)
+		t3_mc5_intr_handler(&adapter->mc5);
+	if (cause & F_XGMAC0_0)
+		mac_intr_handler(adapter, 0);
+	if (cause & F_XGMAC0_1)
+		mac_intr_handler(adapter, 1);
+	if (cause & F_T3DBG)
+		t3_os_ext_intr_handler(adapter);
+
+	/* Clear the interrupts just processed. */
+	t3_write_reg(adapter, A_PL_INT_CAUSE0, cause);
+	(void)t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
+	return 1;
+}
+
+/**
+ *	t3_intr_enable - enable interrupts
+ *	@adapter: the adapter whose interrupts should be enabled
+ *
+ *	Enable interrupts by setting the interrupt enable registers of the
+ *	various HW modules and then enabling the top-level interrupt
+ *	concentrator.
+ */
+void t3_intr_enable(struct adapter *adapter)
+{
+	static const struct addr_val_pair intr_en_avp[] = {
+		{A_SG_INT_ENABLE, SGE_INTR_MASK},
+		{A_MC7_INT_ENABLE, MC7_INTR_MASK},
+		{A_MC7_INT_ENABLE - MC7_PMRX_BASE_ADDR + MC7_PMTX_BASE_ADDR,
+		 MC7_INTR_MASK},
+		{A_MC7_INT_ENABLE - MC7_PMRX_BASE_ADDR + MC7_CM_BASE_ADDR,
+		 MC7_INTR_MASK},
+		{A_MC5_DB_INT_ENABLE, MC5_INTR_MASK},
+		{A_ULPRX_INT_ENABLE, ULPRX_INTR_MASK},
+		{A_TP_INT_ENABLE, 0x3bfffff},
+		{A_PM1_TX_INT_ENABLE, PMTX_INTR_MASK},
+		{A_PM1_RX_INT_ENABLE, PMRX_INTR_MASK},
+		{A_CIM_HOST_INT_ENABLE, CIM_INTR_MASK},
+		{A_MPS_INT_ENABLE, MPS_INTR_MASK},
+	};
+
+	adapter->slow_intr_mask = PL_INTR_MASK;
+
+	t3_write_regs(adapter, intr_en_avp, ARRAY_SIZE(intr_en_avp), 0);
+
+	if (adapter->params.rev > 0) {
+		t3_write_reg(adapter, A_CPL_INTR_ENABLE,
+			     CPLSW_INTR_MASK | F_CIM_OVFL_ERROR);
+		t3_write_reg(adapter, A_ULPTX_INT_ENABLE,
+			     ULPTX_INTR_MASK | F_PBL_BOUND_ERR_CH0 |
+			     F_PBL_BOUND_ERR_CH1);
+	} else {
+		t3_write_reg(adapter, A_CPL_INTR_ENABLE, CPLSW_INTR_MASK);
+		t3_write_reg(adapter, A_ULPTX_INT_ENABLE, ULPTX_INTR_MASK);
+	}
+
+	t3_write_reg(adapter, A_T3DBG_GPIO_ACT_LOW,
+		     adapter_info(adapter)->gpio_intr);
+	t3_write_reg(adapter, A_T3DBG_INT_ENABLE,
+		     adapter_info(adapter)->gpio_intr);
+	if (is_pcie(adapter))
+		t3_write_reg(adapter, A_PCIE_INT_ENABLE, PCIE_INTR_MASK);
+	else
+		t3_write_reg(adapter, A_PCIX_INT_ENABLE, PCIX_INTR_MASK);
+	t3_write_reg(adapter, A_PL_INT_ENABLE0, adapter->slow_intr_mask);
+	(void)t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
+}
+
+/**
+ *	t3_intr_disable - disable a card's interrupts
+ *	@adapter: the adapter whose interrupts should be disabled
+ *
+ *	Disable interrupts.  We only disable the top-level interrupt
+ *	concentrator and the SGE data interrupts.
+ */
+void t3_intr_disable(struct adapter *adapter)
+{
+	t3_write_reg(adapter, A_PL_INT_ENABLE0, 0);
+	(void)t3_read_reg(adapter, A_PL_INT_ENABLE0);	/* flush */
+	adapter->slow_intr_mask = 0;
+}
+
+/**
+ *	t3_intr_clear - clear all interrupts
+ *	@adapter: the adapter whose interrupts should be cleared
+ *
+ *	Clears all interrupts.
+ */
+void t3_intr_clear(struct adapter *adapter)
+{
+	static unsigned int cause_reg_addr[] = {
+		A_SG_INT_CAUSE,
+		A_SG_RSPQ_FL_STATUS,
+		A_PCIX_INT_CAUSE,
+		A_MC7_INT_CAUSE,
+		A_MC7_INT_CAUSE - MC7_PMRX_BASE_ADDR + MC7_PMTX_BASE_ADDR,
+		A_MC7_INT_CAUSE - MC7_PMRX_BASE_ADDR + MC7_CM_BASE_ADDR,
+		A_CIM_HOST_INT_CAUSE,
+		A_TP_INT_CAUSE,
+		A_MC5_DB_INT_CAUSE,
+		A_ULPRX_INT_CAUSE,
+		A_ULPTX_INT_CAUSE,
+		A_CPL_INTR_CAUSE,
+		A_PM1_TX_INT_CAUSE,
+		A_PM1_RX_INT_CAUSE,
+		A_MPS_INT_CAUSE,
+		A_T3DBG_INT_CAUSE,
+	};
+	unsigned int i;
+
+	/* Clear PHY and MAC interrupts for each port. */
+	for_each_port(adapter, i)
+	    t3_port_intr_clear(adapter, i);
+
+	for (i = 0; i < ARRAY_SIZE(cause_reg_addr); ++i)
+		t3_write_reg(adapter, cause_reg_addr[i], 0xffffffff);
+
+	t3_write_reg(adapter, A_PL_INT_CAUSE0, 0xffffffff);
+	(void)t3_read_reg(adapter, A_PL_INT_CAUSE0);	/* flush */
+}
+
