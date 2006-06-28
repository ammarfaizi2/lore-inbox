Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWF1OYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWF1OYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161300AbWF1OXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:23:44 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:62099 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1161259AbWF1OXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:23:38 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FD5@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Gridish Shlomi-RM96313 <gridish@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
Subject: [PATCH 4/7] powerpc: Add QE library qe_lib--ucc support
Date: Wed, 28 Jun 2006 22:23:31 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc.c      |  350 ++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |  413 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  411 +++++++++++++++++++++++++++++++++
 3 files changed, 1174 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
new file mode 100644
index 0000000..8475d7f
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -0,0 +1,350 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE UCC API Set - UCC specific routines implementations.
+ *
+ * Changelog: 
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include <asm/ucc.h>
+
+int ucc_set_qe_mux_mii_mng(int ucc_num)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	out_be32(&qe_immr->qmx.cmxgcr,
+		 ((in_be32(&qe_immr->qmx.cmxgcr) &
+		   ~QE_CMXGCR_MII_ENET_MNG) |
+		  (ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT)));
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+int ucc_set_type(int ucc_num, struct ucc_common *regs,
+		 enum ucc_speed_type speed)
+{
+	u8 guemr = 0;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	guemr = regs->guemr;
+	guemr &= ~(UCC_GUEMR_MODE_MASK_RX | UCC_GUEMR_MODE_MASK_TX);
+	switch (speed) {
+	case UCC_SPEED_TYPE_SLOW:
+		guemr |= (UCC_GUEMR_MODE_SLOW_RX | UCC_GUEMR_MODE_SLOW_TX);
+		break;
+	case UCC_SPEED_TYPE_FAST:
+		guemr |= (UCC_GUEMR_MODE_FAST_RX | UCC_GUEMR_MODE_FAST_TX);
+		break;
+	default:
+		return -EINVAL;
+	}
+	regs->guemr = guemr;
+
+	return 0;
+}
+
+int ucc_init_guemr(struct ucc_common *regs)
+{
+	u8 guemr = 0;
+
+	if (!regs)
+		return -EINVAL;
+
+	/* Set bit 3 (which is reserved in the GUEMR register) to 1 */
+	guemr = UCC_GUEMR_SET_RESERVED3;
+
+	regs->guemr = guemr;
+
+	return 0;
+}
+
+static void get_cmxucr_reg(int ucc_num, volatile u32 ** p_cmxucr, u8 * reg_num,
+			   u8 * shift)
+{
+	switch (ucc_num) {
+	case (0):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 16;
+		break;
+	case (2):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 0;
+		break;
+	case (4):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 16;
+		break;
+	case (6):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 0;
+		break;
+	case (1):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 16;
+		break;
+	case (3):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 0;
+		break;
+	case (5):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr4);
+		*reg_num = 4;
+		*shift = 16;
+		break;
+	case (7):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr4);
+		*reg_num = 4;
+		*shift = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask)
+{
+	volatile u32 *p_cmxucr;
+	u8 reg_num;
+	u8 shift;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	get_cmxucr_reg(ucc_num, &p_cmxucr, &reg_num, &shift);
+
+	if (set)
+		out_be32(p_cmxucr, in_be32(p_cmxucr) | (mask << shift));
+	else
+		out_be32(p_cmxucr, in_be32(p_cmxucr) & ~(mask << shift));
+
+	return 0;
+}
+
+int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode)
+{
+	volatile u32 *p_cmxucr;
+	u8 reg_num;
+	u8 shift;
+	u32 clockBits;
+	u32 clockMask;
+	int source = -1;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	if (!((mode == COMM_DIR_RX) || (mode == COMM_DIR_TX))) {
+		printk(KERN_ERR
+		       "ucc_set_qe_mux_rxtx: bad comm mode type passed.");
+		return -EINVAL;
+	}
+
+	get_cmxucr_reg(ucc_num, &p_cmxucr, &reg_num, &shift);
+
+	switch (reg_num) {
+	case (1):
+		switch (clock) {
+		case (QE_BRG1):
+			source = 1;
+			break;
+		case (QE_BRG2):
+			source = 2;
+			break;
+		case (QE_BRG7):
+			source = 3;
+			break;
+		case (QE_BRG8):
+			source = 4;
+			break;
+		case (QE_CLK9):
+			source = 5;
+			break;
+		case (QE_CLK10):
+			source = 6;
+			break;
+		case (QE_CLK11):
+			source = 7;
+			break;
+		case (QE_CLK12):
+			source = 8;
+			break;
+		case (QE_CLK15):
+			source = 9;
+			break;
+		case (QE_CLK16):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (2):
+		switch (clock) {
+		case (QE_BRG5):
+			source = 1;
+			break;
+		case (QE_BRG6):
+			source = 2;
+			break;
+		case (QE_BRG7):
+			source = 3;
+			break;
+		case (QE_BRG8):
+			source = 4;
+			break;
+		case (QE_CLK13):
+			source = 5;
+			break;
+		case (QE_CLK14):
+			source = 6;
+			break;
+		case (QE_CLK19):
+			source = 7;
+			break;
+		case (QE_CLK20):
+			source = 8;
+			break;
+		case (QE_CLK15):
+			source = 9;
+			break;
+		case (QE_CLK16):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (3):
+		switch (clock) {
+		case (QE_BRG9):
+			source = 1;
+			break;
+		case (QE_BRG10):
+			source = 2;
+			break;
+		case (QE_BRG15):
+			source = 3;
+			break;
+		case (QE_BRG16):
+			source = 4;
+			break;
+		case (QE_CLK3):
+			source = 5;
+			break;
+		case (QE_CLK4):
+			source = 6;
+			break;
+		case (QE_CLK17):
+			source = 7;
+			break;
+		case (QE_CLK18):
+			source = 8;
+			break;
+		case (QE_CLK7):
+			source = 9;
+			break;
+		case (QE_CLK8):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (4):
+		switch (clock) {
+		case (QE_BRG13):
+			source = 1;
+			break;
+		case (QE_BRG14):
+			source = 2;
+			break;
+		case (QE_BRG15):
+			source = 3;
+			break;
+		case (QE_BRG16):
+			source = 4;
+			break;
+		case (QE_CLK5):
+			source = 5;
+			break;
+		case (QE_CLK6):
+			source = 6;
+			break;
+		case (QE_CLK21):
+			source = 7;
+			break;
+		case (QE_CLK22):
+			source = 8;
+			break;
+		case (QE_CLK7):
+			source = 9;
+			break;
+		case (QE_CLK8):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	default:
+		source = -1;
+		break;
+	}
+
+	if (source == -1) {
+		printk(KERN_ERR
+		     "ucc_set_qe_mux_rxtx: Bad combination of clock and UCC.");
+		return -ENOENT;
+	}
+
+	clockBits = (u32) source;
+	clockMask = QE_CMXUCR_TX_CLK_SRC_MASK;
+	if (mode == COMM_DIR_RX) {
+		clockBits <<= 4;  /* Rx field is 4 bits to left of Tx field */
+		clockMask <<= 4;  /* Rx field is 4 bits to left of Tx field */
+	}
+	clockBits <<= shift;
+	clockMask <<= shift;
+
+	out_be32(p_cmxucr, (in_be32(p_cmxucr) & ~clockMask) | clockBits);
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
new file mode 100644
index 0000000..4c94259
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -0,0 +1,413 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE UCC Fast API Set - UCC Fast specific routines implementations.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include <asm/ucc.h>
+#include <asm/ucc_fast.h>
+
+#define uccf_printk(level, format, arg...)  \
+        printk(level format "\n", ## arg)
+
+#define uccf_dbg(format, arg...)            \
+        uccf_printk(KERN_DEBUG , format , ## arg)
+#define uccf_err(format, arg...)            \
+        uccf_printk(KERN_ERR , format , ## arg)
+#define uccf_info(format, arg...)           \
+        uccf_printk(KERN_INFO , format , ## arg)
+#define uccf_warn(format, arg...)           \
+        uccf_printk(KERN_WARNING , format , ## arg)
+
+#ifdef UCCF_VERBOSE_DEBUG
+#define uccf_vdbg uccf_dbg
+#else
+#define uccf_vdbg(fmt, args...) do { } while (0)
+#endif				/* UCCF_VERBOSE_DEBUG */
+
+void ucc_fast_dump_regs(ucc_fast_private_t * uccf)
+{
+	uccf_info("UCC%d Fast registers:", uccf->uf_info->ucc_num);
+	uccf_info("Base address: 0x%08x", (u32) uccf->uf_regs);
+
+	uccf_info("gumr  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->gumr, in_be32(&uccf->uf_regs->gumr));
+	uccf_info("upsmr : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->upsmr, in_be32(&uccf->uf_regs->upsmr));
+	uccf_info("utodr : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utodr, in_be16(&uccf->uf_regs->utodr));
+	uccf_info("udsr  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->udsr, in_be16(&uccf->uf_regs->udsr));
+	uccf_info("ucce  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->ucce, in_be32(&uccf->uf_regs->ucce));
+	uccf_info("uccm  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
+	uccf_info("uccs  : addr - 0x%08x, val - 0x%02x",
+		  (u32) & uccf->uf_regs->uccs, uccf->uf_regs->uccs);
+	uccf_info("urfb  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
+	uccf_info("urfs  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfs, in_be16(&uccf->uf_regs->urfs));
+	uccf_info("urfet : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfet, in_be16(&uccf->uf_regs->urfet));
+	uccf_info("urfset: addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfset,
+		  in_be16(&uccf->uf_regs->urfset));
+	uccf_info("utfb  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->utfb, in_be32(&uccf->uf_regs->utfb));
+	uccf_info("utfs  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utfs, in_be16(&uccf->uf_regs->utfs));
+	uccf_info("utfet : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utfet, in_be16(&uccf->uf_regs->utfet));
+	uccf_info("utftt : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utftt, in_be16(&uccf->uf_regs->utftt));
+	uccf_info("utpt  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utpt, in_be16(&uccf->uf_regs->utpt));
+	uccf_info("urtry : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
+	uccf_info("guemr : addr - 0x%08x, val - 0x%02x",
+		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
+}
+
+u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
+{
+	switch (uccf_num) {
+	case (0):
+		return (QE_CR_SUBBLOCK_UCCFAST1);
+	case (1):
+		return (QE_CR_SUBBLOCK_UCCFAST2);
+	case (2):
+		return (QE_CR_SUBBLOCK_UCCFAST3);
+	case (3):
+		return (QE_CR_SUBBLOCK_UCCFAST4);
+	case (4):
+		return (QE_CR_SUBBLOCK_UCCFAST5);
+	case (5):
+		return (QE_CR_SUBBLOCK_UCCFAST6);
+	case (6):
+		return (QE_CR_SUBBLOCK_UCCFAST7);
+	case (7):
+		return (QE_CR_SUBBLOCK_UCCFAST8);
+	default:
+		return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf)
+{
+	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
+}
+
+void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode)
+{
+	ucc_fast_t *uf_regs;
+	u32 gumr;
+
+	uf_regs = uccf->uf_regs;
+
+	/* Enable reception and/or transmission on this UCC. */
+	gumr = in_be32(&uf_regs->gumr);
+	if (mode & COMM_DIR_TX) {
+		gumr |= UCC_FAST_GUMR_ENT;
+		uccf->enabled_tx = 1;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr |= UCC_FAST_GUMR_ENR;
+		uccf->enabled_rx = 1;
+	}
+	out_be32(&uf_regs->gumr, gumr);
+}
+
+void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode)
+{
+	ucc_fast_t *uf_regs;
+	u32 gumr;
+
+	uf_regs = uccf->uf_regs;
+
+	/* Disable reception and/or transmission on this UCC. */
+	gumr = in_be32(&uf_regs->gumr);
+	if (mode & COMM_DIR_TX) {
+		gumr &= ~UCC_FAST_GUMR_ENT;
+		uccf->enabled_tx = 0;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr &= ~UCC_FAST_GUMR_ENR;
+		uccf->enabled_rx = 0;
+	}
+	out_be32(&uf_regs->gumr, gumr);
+}
+
+int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret)
+{
+	ucc_fast_private_t *uccf;
+	ucc_fast_t *uf_regs;
+	u32 gumr = 0;
+	int ret;
+
+	uccf_vdbg("%s: IN", __FUNCTION__);
+
+	if (!uf_info)
+		return -EINVAL;
+
+	/* check if the UCC port number is in range. */
+	if ((uf_info->ucc_num < 0) || (uf_info->ucc_num > UCC_MAX_NUM - 1)) {
+		uccf_err("ucc_fast_init: Illagal UCC number!");
+		return -EINVAL;
+	}
+
+	/* Check that 'max_rx_buf_length' is properly aligned (4). */
+	if (uf_info->max_rx_buf_length & (UCC_FAST_MRBLR_ALIGNMENT - 1)) {
+		uccf_err("ucc_fast_init: max_rx_buf_length not aligned.");
+		return -EINVAL;
+	}
+
+	/* Validate Virtual Fifo register values */
+	if (uf_info->urfs < UCC_FAST_URFS_MIN_VAL) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfs too small.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfs not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfet not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfset & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		   ("ucc_fast_init: Virtual Fifo register urfset not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utfs not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utfet not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utftt & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utftt not aligned.");
+		return -EINVAL;
+	}
+
+	uccf =
+	    (ucc_fast_private_t *) kmalloc(sizeof(ucc_fast_private_t),
+					   GFP_KERNEL);
+	if (!uccf) {
+		uccf_err
+		    ("ucc_fast_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccf, 0, sizeof(ucc_fast_private_t));
+
+	/* Fill fast UCC structure */
+	uccf->uf_info = uf_info;
+	/* Set the PHY base address */
+	uccf->uf_regs =
+	    (ucc_fast_t *) ioremap(uf_info->regs, sizeof(ucc_fast_t));
+	if (uccf->uf_regs == NULL) {
+		uccf_err
+		    ("ucc_fast_init: No memory map for UCC slow controller!");
+		return -ENOMEM;
+	}
+
+	uccf->enabled_tx = 0;
+	uccf->enabled_rx = 0;
+	uccf->stopped_tx = 0;
+	uccf->stopped_rx = 0;
+	uf_regs = uccf->uf_regs;
+	uccf->p_ucce = (u32 *) & (uf_regs->ucce);
+	uccf->p_uccm = (u32 *) & (uf_regs->uccm);
+#ifdef STATISTICS
+	uccf->tx_frames = 0;
+	uccf->rx_frames = 0;
+	uccf->rx_discarded = 0;
+#endif				/* STATISTICS */
+
+	/* Init Guemr register */
+	if ((ret = ucc_init_guemr((ucc_common_t *) (uf_regs)))) {
+		uccf_err("ucc_fast_init: Could not init the guemr register.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	/* Set UCC to fast type */
+	if ((ret = ucc_set_type(uf_info->ucc_num,
+				(ucc_common_t *) (uf_regs),
+				UCC_SPEED_TYPE_FAST))) {
+		uccf_err("ucc_fast_init: Could not set type to fast.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	uccf->mrblr = uf_info->max_rx_buf_length;
+
+	/* Set GUMR.                               */
+	/* For more details see the hardware spec. */
+	/* gumr starts as zero.                    */
+	if (uf_info->tci)
+		gumr |= UCC_FAST_GUMR_TCI;
+	gumr |= uf_info->ttx_trx;
+	if (uf_info->cdp)
+		gumr |= UCC_FAST_GUMR_CDP;
+	if (uf_info->ctsp)
+		gumr |= UCC_FAST_GUMR_CTSP;
+	if (uf_info->cds)
+		gumr |= UCC_FAST_GUMR_CDS;
+	if (uf_info->ctss)
+		gumr |= UCC_FAST_GUMR_CTSS;
+	if (uf_info->txsy)
+		gumr |= UCC_FAST_GUMR_TXSY;
+	if (uf_info->rsyn)
+		gumr |= UCC_FAST_GUMR_RSYN;
+	gumr |= uf_info->synl;
+	if (uf_info->rtsm)
+		gumr |= UCC_FAST_GUMR_RTSM;
+	gumr |= uf_info->renc;
+	if (uf_info->revd)
+		gumr |= UCC_FAST_GUMR_REVD;
+	gumr |= uf_info->tenc;
+	gumr |= uf_info->tcrc;
+	gumr |= uf_info->mode;
+	out_be32(&uf_regs->gumr, gumr);
+
+	/* Allocate memory for Tx Virtual Fifo */
+	uccf->ucc_fast_tx_virtual_fifo_base_offset =
+	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+		uccf_err
+		    ("ucc_fast_init: Can not allocate MURAM memory for "
+			"ucc_fast_tx_virtual_fifo_base_offset.");
+		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
+		ucc_fast_free(uccf);
+		return -ENOMEM;
+	}
+
+	/* Allocate memory for Rx Virtual Fifo */
+	uccf->ucc_fast_rx_virtual_fifo_base_offset =
+	    qe_muram_alloc(uf_info->urfs +
+			   (u32)
+			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
+			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (IS_MURAM_ERR(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+		uccf_err
+		    ("ucc_fast_init: Can not allocate MURAM memory for " 
+			"ucc_fast_rx_virtual_fifo_base_offset.");
+		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
+		ucc_fast_free(uccf);
+		return -ENOMEM;
+	}
+
+	/* Set Virtual Fifo registers */
+	out_be16(&uf_regs->urfs, uf_info->urfs);
+	out_be16(&uf_regs->urfet, uf_info->urfet);
+	out_be16(&uf_regs->urfset, uf_info->urfset);
+	out_be16(&uf_regs->utfs, uf_info->utfs);
+	out_be16(&uf_regs->utfet, uf_info->utfet);
+	out_be16(&uf_regs->utftt, uf_info->utftt);
+	/* utfb, urfb are offsets from MURAM base */
+	out_be32(&uf_regs->utfb, uccf->ucc_fast_tx_virtual_fifo_base_offset);
+	out_be32(&uf_regs->urfb, uccf->ucc_fast_rx_virtual_fifo_base_offset);
+
+	/* Mux clocking */
+	/* Grant Support */
+	ucc_set_qe_mux_grant(uf_info->ucc_num, uf_info->grant_support);
+	/* Breakpoint Support */
+	ucc_set_qe_mux_bkpt(uf_info->ucc_num, uf_info->brkpt_support);
+	/* Set Tsa or NMSI mode. */
+	ucc_set_qe_mux_tsa(uf_info->ucc_num, uf_info->tsa);
+	/* If NMSI (not Tsa), set Tx and Rx clock. */
+	if (!uf_info->tsa) {
+		/* Rx clock routing */
+		if (uf_info->rx_clock != QE_CLK_NONE) {
+			if (ucc_set_qe_mux_rxtx
+			    (uf_info->ucc_num, uf_info->rx_clock,
+			     COMM_DIR_RX)) {
+				uccf_err
+		("ucc_fast_init: Illegal value for parameter 'RxClock'.");
+				ucc_fast_free(uccf);
+				return -EINVAL;
+			}
+		}
+		/* Tx clock routing */
+		if (uf_info->tx_clock != QE_CLK_NONE) {
+			if (ucc_set_qe_mux_rxtx
+			    (uf_info->ucc_num, uf_info->tx_clock,
+			     COMM_DIR_TX)) {
+				uccf_err
+		("ucc_fast_init: Illegal value for parameter 'TxClock'.");
+				ucc_fast_free(uccf);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * INTERRUPTS
+	 */
+	/* Set interrupt mask register at UCC level. */
+	out_be32(&uf_regs->uccm, uf_info->uccm_mask);
+
+	/* First, clear anything pending at UCC level, */
+	/* otherwise, old garbage may come through     */
+	/* as soon as the dam is opened.               */
+
+	/* Writing '1' clears */
+	out_be32(&uf_regs->ucce, 0xffffffff);
+
+	*uccf_ret = uccf;
+	return 0;
+}
+
+void ucc_fast_free(ucc_fast_private_t * uccf)
+{
+	if (!uccf)
+		return;
+
+	if (uccf->ucc_fast_tx_virtual_fifo_base_offset)
+		qe_muram_free(uccf->ucc_fast_tx_virtual_fifo_base_offset);
+
+	if (uccf->ucc_fast_rx_virtual_fifo_base_offset)
+		qe_muram_free(uccf->ucc_fast_rx_virtual_fifo_base_offset);
+
+	kfree(uccf);
+}
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
new file mode 100644
index 0000000..9ded1b5
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -0,0 +1,411 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE UCC Slow API Set - UCC Slow specific routines implementations.
+ *
+ * Changelog:
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include <asm/ucc.h>
+#include <asm/ucc_slow.h>
+
+#define uccs_printk(level, format, arg...)  \
+        printk(level format "\n", ## arg)
+
+#define uccs_dbg(format, arg...)            \
+        uccs_printk(KERN_DEBUG , format , ## arg)
+#define uccs_err(format, arg...)            \
+        uccs_printk(KERN_ERR , format , ## arg)
+#define uccs_info(format, arg...)           \
+        uccs_printk(KERN_INFO , format , ## arg)
+#define uccs_warn(format, arg...)           \
+        uccs_printk(KERN_WARNING , format , ## arg)
+
+#ifdef UCCS_VERBOSE_DEBUG
+#define uccs_vdbg uccs_dbg
+#else
+#define uccs_vdbg(fmt, args...) do { } while (0)
+#endif				/* UCCS_VERBOSE_DEBUG */
+
+u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
+{
+	switch (uccs_num) {
+	case (0):
+		return (QE_CR_SUBBLOCK_UCCSLOW1);
+	case (1):
+		return (QE_CR_SUBBLOCK_UCCSLOW2);
+	case (2):
+		return (QE_CR_SUBBLOCK_UCCSLOW3);
+	case (3):
+		return (QE_CR_SUBBLOCK_UCCSLOW4);
+	case (4):
+		return (QE_CR_SUBBLOCK_UCCSLOW5);
+	case (5):
+		return (QE_CR_SUBBLOCK_UCCSLOW6);
+	case (6):
+		return (QE_CR_SUBBLOCK_UCCSLOW7);
+	case (7):
+		return (QE_CR_SUBBLOCK_UCCSLOW8);
+	default:
+		return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs)
+{
+	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
+}
+
+void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_GRACEFUL_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED,
+		     0);
+}
+
+void ucc_slow_stop_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_restart_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_RESTART_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode)
+{
+	ucc_slow_t *us_regs;
+	u32 gumr_l;
+
+	us_regs = uccs->us_regs;
+
+	/* Enable reception and/or transmission on this UCC. */
+	gumr_l = in_be32(&us_regs->gumr_l);
+	if (mode & COMM_DIR_TX) {
+		gumr_l |= UCC_SLOW_GUMR_L_ENT;
+		uccs->enabled_tx = 1;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr_l |= UCC_SLOW_GUMR_L_ENR;
+		uccs->enabled_rx = 1;
+	}
+	out_be32(&us_regs->gumr_l, gumr_l);
+}
+
+void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode)
+{
+	ucc_slow_t *us_regs;
+	u32 gumr_l;
+
+	us_regs = uccs->us_regs;
+
+	/* Disable reception and/or transmission on this UCC. */
+	gumr_l = in_be32(&us_regs->gumr_l);
+	if (mode & COMM_DIR_TX) {
+		gumr_l &= ~UCC_SLOW_GUMR_L_ENT;
+		uccs->enabled_tx = 0;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr_l &= ~UCC_SLOW_GUMR_L_ENR;
+		uccs->enabled_rx = 0;
+	}
+	out_be32(&us_regs->gumr_l, gumr_l);
+}
+
+int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret)
+{
+	u32 i;
+	ucc_slow_t *us_regs;
+	u32 gumr;
+	u8 function_code = 0;
+	u8 *bd;
+	ucc_slow_private_t *uccs;
+	u32 id;
+	u32 command;
+	int ret;
+
+	uccs_vdbg("%s: IN", __FUNCTION__);
+
+	if (!us_info)
+		return -EINVAL;
+
+	/* check if the UCC port number is in range. */
+	if ((us_info->ucc_num < 0) || (us_info->ucc_num > UCC_MAX_NUM - 1)) {
+		uccs_err("ucc_slow_init: Illagal UCC number!");
+		return -EINVAL;
+	}
+
+	/* Set mrblr */
+	/* Check that 'max_rx_buf_length' is properly aligned (4), unless 
+	rfw is 1, meaning that QE accepts one byte at a time, unlike normal 
+	case when QE accepts 32 bits at a time. */
+	if ((!us_info->rfw)
+	    && (us_info->max_rx_buf_length & (UCC_SLOW_MRBLR_ALIGNMENT - 1))) {
+		uccs_err("max_rx_buf_length not aligned.");
+		return -EINVAL;
+	}
+
+	uccs =
+	    (ucc_slow_private_t *) kmalloc(sizeof(ucc_slow_private_t),
+					   GFP_KERNEL);
+	if (!uccs) {
+		uccs_err
+		    ("ucc_slow_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccs, 0, sizeof(ucc_slow_private_t));
+
+	/* Fill slow UCC structure */
+	uccs->us_info = us_info;
+	uccs->saved_uccm = 0;
+	uccs->p_rx_frame = 0;
+	uccs->us_regs = us_info->us_regs;
+	us_regs = uccs->us_regs;
+	uccs->p_ucce = (u16 *) & (us_regs->ucce);
+	uccs->p_uccm = (u16 *) & (us_regs->uccm);
+#ifdef STATISTICS
+	uccs->rx_frames = 0;
+	uccs->tx_frames = 0;
+	uccs->rx_discarded = 0;
+#endif				/* STATISTICS */
+
+	/* Get PRAM base */
+	uccs->us_pram_offset =
+	    qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
+	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
+		uccs_err
+		    ("ucc_slow_init: Can not allocate MURAM memory " \
+			"for Slow UCC.");
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, id, QE_CR_PROTOCOL_UNSPECIFIED,
+		     (u32) uccs->us_pram_offset);
+
+	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
+
+	/* Init Guemr register */
+	if ((ret = ucc_init_guemr((ucc_common_t *) (us_info->us_regs)))) {
+		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		ucc_slow_free(uccs);
+		return ret;
+	}
+
+	/* Set UCC to slow type */
+	if ((ret = ucc_set_type(us_info->ucc_num,
+				(ucc_common_t *) (us_info->us_regs),
+				UCC_SPEED_TYPE_SLOW))) {
+		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		ucc_slow_free(uccs);
+		return ret;
+	}
+
+	out_be16(&uccs->us_pram->mrblr, us_info->max_rx_buf_length);
+
+	INIT_LIST_HEAD(&uccs->confQ);
+
+	/* Allocate BDs. */
+	uccs->rx_base_offset =
+	    qe_muram_alloc(us_info->rx_bd_ring_len * UCC_SLOW_SIZE_OF_BD,
+			   QE_ALIGNMENT_OF_BD);
+	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
+		uccs_err("ucc_slow_init: No memory for Rx BD's.");
+		uccs->rx_base_offset = 0;
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+
+	uccs->tx_base_offset =
+	    qe_muram_alloc(us_info->tx_bd_ring_len * UCC_SLOW_SIZE_OF_BD,
+			   QE_ALIGNMENT_OF_BD);
+	if (IS_MURAM_ERR(uccs->tx_base_offset)) {
+		uccs_err("ucc_slow_init: No memory for Tx BD's.");
+		uccs->tx_base_offset = 0;
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+
+	/* Init Tx bds */
+	bd = uccs->confBd = uccs->tx_bd = qe_muram_addr(uccs->tx_base_offset);
+	for (i = 0; i < us_info->tx_bd_ring_len; i++) {
+		BD_BUFFER_CLEAR(bd);
+		BD_STATUS_AND_LENGTH_SET(bd, 0);
+		bd += QE_SIZEOF_BD;
+	}
+	bd -= QE_SIZEOF_BD;
+	BD_STATUS_AND_LENGTH_SET(bd, T_W);	/* for last BD set Wrap bit */
+
+	/* Init Rx bds */
+	bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
+	for (i = 0; i < us_info->rx_bd_ring_len; i++) {
+		BD_STATUS_AND_LENGTH_SET(bd, 0);
+		BD_BUFFER_CLEAR(bd);
+		bd += QE_SIZEOF_BD;
+	}
+	bd -= QE_SIZEOF_BD;
+	BD_STATUS_AND_LENGTH_SET(bd, R_W);	/* for last BD set Wrap bit */
+
+	/* Set GUMR (For more details see the hardware spec.). */
+	/* gumr_h */
+	gumr = 0;
+	gumr |= us_info->tcrc;
+	if (us_info->cdp)
+		gumr |= UCC_SLOW_GUMR_H_CDP;
+	if (us_info->ctsp)
+		gumr |= UCC_SLOW_GUMR_H_CTSP;
+	if (us_info->cds)
+		gumr |= UCC_SLOW_GUMR_H_CDS;
+	if (us_info->ctss)
+		gumr |= UCC_SLOW_GUMR_H_CTSS;
+	if (us_info->tfl)
+		gumr |= UCC_SLOW_GUMR_H_TFL;
+	if (us_info->rfw)
+		gumr |= UCC_SLOW_GUMR_H_RFW;
+	if (us_info->txsy)
+		gumr |= UCC_SLOW_GUMR_H_TXSY;
+	if (us_info->rtsm)
+		gumr |= UCC_SLOW_GUMR_H_RTSM;
+	out_be32(&us_regs->gumr_h, gumr);
+
+	/* gumr_l */
+	gumr = 0;
+	if (us_info->tci)
+		gumr |= UCC_SLOW_GUMR_L_TCI;
+	if (us_info->rinv)
+		gumr |= UCC_SLOW_GUMR_L_RINV;
+	if (us_info->tinv)
+		gumr |= UCC_SLOW_GUMR_L_TINV;
+	if (us_info->tend)
+		gumr |= UCC_SLOW_GUMR_L_TEND;
+	gumr |= us_info->tdcr;
+	gumr |= us_info->rdcr;
+	gumr |= us_info->tenc;
+	gumr |= us_info->renc;
+	gumr |= us_info->diag;
+	gumr |= us_info->mode;
+	out_be32(&us_regs->gumr_l, gumr);
+
+	/* Function code registers */
+	/* function_code has initial value 0 */
+
+	/* if the data is in cachable memory, the 'global' */
+	/* in the function code should be set.             */
+	function_code |= us_info->data_mem_part;
+	function_code |= QE_BMR_BYTE_ORDER_BO_MOT;	/* Required for QE */
+	uccs->us_pram->tfcr = function_code;
+	uccs->us_pram->rfcr = function_code;
+
+	/* rbase, tbase are offsets from MURAM base */
+	out_be16(&uccs->us_pram->rbase, uccs->us_pram_offset);
+	out_be16(&uccs->us_pram->tbase, uccs->us_pram_offset);
+
+	/* Mux clocking */
+	/* Grant Support */
+	ucc_set_qe_mux_grant(us_info->ucc_num, us_info->grant_support);
+	/* Breakpoint Support */
+	ucc_set_qe_mux_bkpt(us_info->ucc_num, us_info->brkpt_support);
+	/* Set Tsa or NMSI mode. */
+	ucc_set_qe_mux_tsa(us_info->ucc_num, us_info->tsa);
+	/* If NMSI (not Tsa), set Tx and Rx clock. */
+	if (!us_info->tsa) {
+		/* Rx clock routing */
+		if (ucc_set_qe_mux_rxtx
+		    (us_info->ucc_num, us_info->rx_clock, COMM_DIR_RX)) {
+			uccs_err
+			    ("ucc_slow_init: Illegal value for parameter" \
+				" 'RxClock'.");
+			ucc_slow_free(uccs);
+			return -EINVAL;
+		}
+		/* Tx clock routing */
+		if (ucc_set_qe_mux_rxtx
+		    (us_info->ucc_num, us_info->tx_clock, COMM_DIR_TX)) {
+			uccs_err
+			    ("ucc_slow_init: Illegal value for parameter " \
+				"'TxClock'.");
+			ucc_slow_free(uccs);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * INTERRUPTS
+	 */
+	/* Set interrupt mask register at UCC level. */
+	out_be16(&us_regs->uccm, us_info->uccm_mask);
+
+	/* First, clear anything pending at UCC level, */
+	/* otherwise, old garbage may come through     */
+	/* as soon as the dam is opened.               */
+
+	/* Writing '1' clears */
+	out_be16(&us_regs->ucce, 0xffff);
+
+	/* Issue QE Init command */
+	if (us_info->init_tx && us_info->init_rx)
+		command = QE_INIT_TX_RX;
+	else if (us_info->init_tx)
+		command = QE_INIT_TX;
+	else
+		command = QE_INIT_RX;	/* We know at least one is TRUE */
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(command, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+
+	*uccs_ret = uccs;
+	return 0;
+}
+
+void ucc_slow_free(ucc_slow_private_t * uccs)
+{
+	if (!uccs)
+		return;
+
+	if (uccs->rx_base_offset)
+		qe_muram_free(uccs->rx_base_offset);
+
+	if (uccs->tx_base_offset)
+		qe_muram_free(uccs->tx_base_offset);
+
+	if (uccs->us_pram) {
+		qe_muram_free(uccs->us_pram_offset);
+		uccs->us_pram = NULL;
+	}
+
+	kfree(uccs);
+}
