Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWJESYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWJESYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWJESXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:38 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751008AbWJESW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:22:56 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 4/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:01:33 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051101.33443.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:42.0703 (UTC) FILETIME=[3F6149F0:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. VIOC hardware APIs.

Signed-off-by: Misha Tomushev  <misha@fabric7.com

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_api.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_api.c
--- linux-2.6.17/drivers/net/vioc/vioc_api.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_api.c	2006-10-04 
10:21:45.000000000 -0700
@@ -0,0 +1,384 @@
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
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+
+int vioc_set_rx_intr_param(int viocdev_idx, int rx_intr_id, u32 timeout, u32 
cntout)
+{
+	int ret = 0;
+	struct vioc_device *viocdev;
+	u64 regaddr;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(VIOC_IHCU, 0, (VREG_IHCU_RXCINTTIMER + 
+							(rx_intr_id << 2)));
+	vioc_reg_wr(timeout, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_IHCU, 0, (VREG_IHCU_RXCINTPKTCNT + 
+							(rx_intr_id << 2)));
+	vioc_reg_wr(cntout, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+
+int vioc_get_vnic_mac(int viocdev_idx, u32 vnic_id, u8 * p)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+	u64 regaddr;
+	u32 value;
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_MACADDRLO);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+	*((u32 *) & p[2]) = htonl(value);
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_MACADDRHI);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+	*((u16 *) & p[0]) = htons(value);
+
+	return 0;
+}
+
+int vioc_set_vnic_mac(int viocdev_idx, u32 vnic_id, u8 * p)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+	u64 regaddr;
+	u32 value;
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_MACADDRLO);
+	value = ntohl(*((u32 *) & p[2]));
+
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_MACADDRHI);
+	value = (ntohl(*((u32 *) & p[0])) >> 16) & 0xffff;
+
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return 0;
+}
+
+int vioc_set_txq(int viocdev_idx, u32 vnic_id, u32 txq_id, dma_addr_t base,
+		 u32 num_elements)
+{
+	int ret = 0;
+	u32 value;
+	struct vioc_device *viocdev;
+	u64 regaddr;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+	if (vnic_id >= VIOC_MAX_VNICS)
+		goto parm_err_ret;
+
+	if (txq_id >= VIOC_MAX_TXQ)
+		goto parm_err_ret;
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, (VREG_VENG_TXD_W0 + (txq_id << 
5)));
+
+	value = base;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, (VREG_VENG_TXD_W1 + (txq_id << 
5)));
+	value = (((base >> 16) >> 16) & 0x000000ff) |
+	    ((num_elements << 8) & 0x00ffff00);
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	/*
+	 * Enable Interrupt-on-Empty
+	 */
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_TXINTCTL);
+	vioc_reg_wr(VREG_VENG_TXINTCTL_INTONEMPTY_MASK, viocdev->ba.virt,
+		    regaddr);
+
+	return ret;
+
+      parm_err_ret:
+	return -EINVAL;
+}
+
+int vioc_set_rxc(int viocdev_idx, struct rxc *rxc)
+{
+	u32 value;
+	struct vioc_device *viocdev;
+	u64 regaddr;
+	int ret = 0;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(VIOC_IHCU, 0, (VREG_IHCU_RXC_LO + (rxc->rxc_id << 4)));
+	value = rxc->dma;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_IHCU, 0, (VREG_IHCU_RXC_HI + (rxc->rxc_id << 4)));
+	value = (((rxc->dma >> 16) >> 16) & 0x000000ff) |
+	    ((rxc->count << 8) & 0x00ffff00);
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	/*
+	 * Set-up mapping between this RxC queue and Rx interrupt
+	 */
+	regaddr = GETRELADDR(VIOC_IHCU, 0, (VREG_IHCU_RXC_INT + (rxc->rxc_id << 
4)));
+	vioc_reg_wr((rxc->interrupt_id & 0xF), viocdev->ba.virt, regaddr);
+
+	ret = vioc_set_rx_intr_param(viocdev_idx,
+				     rxc->interrupt_id,
+				     viocdev->prov.run_param.rx_intr_timeout,
+				     viocdev->prov.run_param.rx_intr_cntout);
+	return ret;
+}
+
+int vioc_set_rxs(int viocdev_idx, dma_addr_t base)
+{
+	int ret = 0;
+	u32 value;
+	u64 regaddr;
+	struct vioc_device *viocdev;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+	regaddr = GETRELADDR(VIOC_IHCU, 0, VREG_IHCU_INTRSTATADDRLO);
+	value = base;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+	regaddr = GETRELADDR(VIOC_IHCU, 0, VREG_IHCU_INTRSTATADDRHI);
+	value = ((base >> 16) >> 16) & 0x000000ff;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+int vioc_set_rxdq(int viocdev_idx, u32 vnic_id, u32 rxdq_id, u32 rx_bufsize,
+		  dma_addr_t base, u32 num_elements)
+{
+	int ret = 0;
+	u32 value;
+	struct vioc_device *viocdev;
+	u64 regaddr;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(VIOC_IHCU, vnic_id, (VREG_IHCU_RXD_W0_R0 + 
+							(rxdq_id << 4)));
+	value = base;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_IHCU, vnic_id, (VREG_IHCU_RXD_W1_R0 + 
+							(rxdq_id << 4)));
+	value = (((base >> 16) >> 16) & 0x000000ff) |
+	    ((num_elements << 8) & 0x00ffff00);
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_IHCU, vnic_id, (VREG_IHCU_RXD_W2_R0 + 
+							(rxdq_id << 4)));
+	value = rx_bufsize;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+u32 vioc_rrd(int viocdev_idx, int module_id, int vnic_id, int reg_addr)
+{
+	u32 value;
+	u64 regaddr;
+	struct vioc_device *viocdev;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(module_id, vnic_id, reg_addr);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+
+	return value;
+}
+
+int vioc_rwr(int viocdev_idx, int module_id, int vnic_id, int reg_addr,
+	     u32 value)
+{
+	int ret = 0;
+	struct vioc_device *viocdev;
+	u64 regaddr;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(module_id, vnic_id, reg_addr);
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+int vioc_ena_dis_tx_on_empty(int viocdev_idx, u32 vnic_id, u32 txq_id,
+			     int ena_dis)
+{
+	u32 value = 0;
+	u64 regaddr;
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+
+	if (ena_dis)
+		value |= VREG_VENG_TXINTCTL_INTONEMPTY_MASK;
+	else
+		value &= ~VREG_VENG_TXINTCTL_INTONEMPTY_MASK;
+
+	regaddr = GETRELADDR(VIOC_VENG, vnic_id, VREG_VENG_TXINTCTL);
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return 0;
+}
+
+int vioc_set_vnic_cfg(int viocdev_idx, u32 vnic_id, u32 cfg)
+{
+	int ret = 0;
+	u64 regaddr;
+	struct vioc_device *viocdev;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+	regaddr = GETRELADDR(VIOC_BMC, vnic_id, VREG_BMC_VNIC_CFG);
+
+	vioc_reg_wr(cfg, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+int vioc_ena_dis_rxd_q(int viocdev_idx, u32 q_id, int ena_dis)
+{
+	int ret = 0;
+	u32 value;
+	u64 regaddr;
+	struct vioc_device *viocdev;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+	regaddr = GETRELADDR(VIOC_IHCU, 0, VREG_IHCU_RXDQEN);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+
+	if (ena_dis)
+		value |= 1 << q_id;
+	else
+		value &= ~(1 << q_id);
+
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	return ret;
+}
+
+void vioc_sw_reset(int viocdev_idx)
+{
+	u32 value;
+	u64 regaddr;
+	struct vioc_device *viocdev;
+
+	viocdev = vioc_viocdev(viocdev_idx);
+
+	regaddr = GETRELADDR(VIOC_BMC, 0, VREG_BMC_GLOBAL);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+	value |= VREG_BMC_GLOBAL_SOFTRESET_MASK;
+	vioc_reg_wr(value, viocdev->ba.virt, regaddr);
+
+	do {
+		vioc_reg_rd(viocdev->ba.virt, regaddr, &value);
+		mdelay(1);
+	} while (value & VREG_BMC_GLOBAL_SOFTRESET_MASK);
+
+	/*
+	 * Clear BMC INTERRUPT register
+	 */
+	regaddr = GETRELADDR(VIOC_BMC, 0, VREG_BMC_INTRSTATUS);
+	vioc_reg_wr(0xffff, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VING, 0, VREG_VING_BUFTH1);
+	vioc_reg_wr(128, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VING, 0, VREG_VING_BUFTH2);
+	vioc_reg_wr(150, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VING, 0, VREG_VING_BUFTH3);
+	vioc_reg_wr(200, viocdev->ba.virt, regaddr);
+
+	regaddr = GETRELADDR(VIOC_VING, 0, VREG_VING_BUFTH4);
+	vioc_reg_wr(256, viocdev->ba.virt, regaddr);
+
+	/*
+	 * Initialize Context Scrub Control Register
+	 */
+	regaddr = GETRELADDR(VIOC_VING, 0, VREG_VING_CONTEXTSCRUB);
+	/* Enable Context Scrub, Timeout ~ 5 sec */
+	vioc_reg_wr(0x8000000f, viocdev->ba.virt, regaddr);	
+	/*
+	 * Initialize Sleep Time Register
+	 */
+	regaddr = GETRELADDR(VIOC_IHCU, 0, VREG_IHCU_SLEEPTIME);
+	/* at 50ns ticks, 20 = 20x50 = 1usec */
+	vioc_reg_wr(20, viocdev->ba.virt, regaddr);	
+	/*
+	 * VIOC bits version
+	 */
+	regaddr = GETRELADDR(VIOC_HT, 0, VREG_HT_CLASSREV);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &viocdev->vioc_bits_version);
+	/*
+	 * VIOC bits sub-version
+	 */
+	regaddr = GETRELADDR(VIOC_HT, 0, VREG_HT_EXPREV);
+	vioc_reg_rd(viocdev->ba.virt, regaddr, &viocdev->vioc_bits_subversion);
+
+}
+
+int vioc_vnic_resources_set(int viocdev_idx, u32 vnic_id)
+{
+	struct vioc_device *viocdev = vioc_viocdev(viocdev_idx);
+	struct vnic_device *vnicdev = viocdev->vnic_netdev[vnic_id]->priv;
+	u64 regaddr;
+
+	/* Map VNIC-2-RXD */
+	regaddr = GETRELADDR(VIOC_IHCU, vnic_id, VREG_IHCU_VNICRXDMAP);
+	vioc_reg_wr(vnicdev->qmap, viocdev->ba.virt, regaddr);
+
+	/* Map VNIC-2-RXC */
+	regaddr = GETRELADDR(VIOC_IHCU, vnic_id, VREG_IHCU_VNICRXCMAP);
+	vioc_reg_wr(vnicdev->rxc_id, viocdev->ba.virt, regaddr);
+
+	/* Map Interrupt-2-RXC */
+	regaddr =  GETRELADDR(VIOC_IHCU, vnic_id, (VREG_IHCU_RXC_INT +
+					       (vnicdev->rxc_id << 4)));
+	vioc_reg_wr(vnicdev->rxc_intr_id, viocdev->ba.virt, regaddr);
+
+	return 0;
+}
diff -uprN linux-2.6.17/drivers/net/vioc/vioc_api.h 
linux-2.6.17.vioc/drivers/net/vioc/vioc_api.h
--- linux-2.6.17/drivers/net/vioc/vioc_api.h	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_api.h	2006-09-06 
16:23:00.000000000 -0700
@@ -0,0 +1,64 @@
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
+#ifndef _VIOC_API_H_
+#define _VIOC_API_H_
+
+#include <asm/io.h>
+#include "vioc_vnic.h"
+
+extern int vioc_vnic_resources_set(int vioc_id, u32 vnic_id);
+extern void vioc_sw_reset(int vioc_id);
+extern u32 vioc_rrd(int vioc_id, int module_id, int vnic_id, int reg_addr);
+extern int vioc_rwr(int vioc_id, int module_id, int vnic_id, int reg_addr, 
u32 value);
+extern int vioc_set_vnic_mac(int vioc_id, u32 vnic_id, u8 * p);
+extern int vioc_get_vnic_mac(int vioc_id, u32 vnic_id, u8 * p);
+extern int vioc_set_txq(int vioc_id, u32 vnic_id, u32 txq_id, dma_addr_t 
base,
+                u32 num_elements);
+
+extern int vioc_set_rxc(int viocdev_idx, struct rxc *rxc);
+
+
+extern int vioc_set_rxdq(int vioc_id, u32 vnic_id, u32 rxq_id, u32 
rx_bufsize,
+                 dma_addr_t base, u32 num_elements);
+extern int vioc_set_rxs(int vioc_id, dma_addr_t base);
+extern int vioc_set_vnic_cfg(int viocdev_idx, u32 vnic_id, u32 vnic_q_map);
+extern int vioc_ena_dis_rxd_q(int vioc_id, u32 q_id, int ena_dis);
+extern int vioc_ena_dis_tx_on_empty(int viocdev_idx, u32 vnic_id, u32 txq_id,
+                            int ena_dis);
+static inline void
+vioc_reg_wr(u32 value, void __iomem *vaddr, u32 offset)
+{
+       writel(value, vaddr + offset);
+}
+
+static inline void
+vioc_reg_rd(void __iomem *vaddr, u32 offset, u32 * value_p)
+{
+       *value_p = readl(vaddr + offset);
+}
+
+#endif                         /* _VIOC_API_H_ */


-- 
Misha Tomushev
misha@fabric7.com


