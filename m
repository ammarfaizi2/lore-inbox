Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVAZAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVAZAua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVAZAra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:47:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5882 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262052AbVAZAhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:37:21 -0500
Message-ID: <41F6E625.4090608@mvista.com>
Date: Tue, 25 Jan 2005 17:36:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: Russell King <rmk@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][SERIAL] mpsc updates
Content-Type: multipart/mixed;
 boundary="------------070304090609050709030404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------070304090609050709030404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi again, Andrew.

This patch:
- replaces several macros with the actual code
- change the type of pointer variables from u32 to void *
- removes unecessary casts
- puts the contents of mpsc_defs.h into mpsc.h and removes the mpsc_defs.h
- reflects the new names of some structs
- cleans up some whitespace

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------070304090609050709030404
Content-Type: text/plain;
 name="mpsc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpsc.patch"

diff -Nru a/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
--- a/drivers/serial/mpsc.c	2005-01-25 17:28:43 -07:00
+++ b/drivers/serial/mpsc.c	2005-01-25 17:28:43 -07:00
@@ -36,16 +36,14 @@
  *
  * 1) Some chips have an erratum where several regs cannot be
  * read.  To work around that, we keep a local copy of those regs in
- * 'mpsc_port_info' and use the *_M or *_S macros when accessing those regs.
+ * 'mpsc_port_info'.
  *
  * 2) Some chips have an erratum where the ctlr will hang when the SDMA ctlr
- * accesses system mem in a cache coherent region.  This *should* be a
- * show-stopper when coherency is turned on but it seems to work okay as
- * long as there are no snoop hits.  Therefore, the ring buffer entries and
- * the buffers themselves are allocated via 'dma_alloc_noncoherent()' and
- * 'dma_cache_sync()' is used.  Also, since most PPC platforms are coherent
- * which makes 'dma_cache_sync()' a no-op, explicit cache management macros
- * have been added ensuring there are no snoop hits when coherency is on.
+ * accesses system mem with coherency enabled.  For that reason, the driver
+ * assumes that coherency for that ctlr has been disabled.  This means
+ * that when in a cache coherent system, the driver has to manually manage
+ * the data cache on the areas that it touches because the dma_* macro are
+ * basically no-ops.
  *
  * 3) There is an erratum (on PPC) where you can't use the instruction to do
  * a DMA_TO_DEVICE/cache clean so DMA_BIDIRECTIONAL/flushes are used in places
@@ -54,7 +52,6 @@
  * 4) AFAICT, hardware flow control isn't supported by the controller --MAG.
  */
 
-#include <linux/mv643xx.h>
 #include "mpsc.h"
 
 /*
@@ -81,25 +78,48 @@
 static void
 mpsc_brg_init(struct mpsc_port_info *pi, u32 clk_src)
 {
+	u32	v;
+
+	v = (pi->mirror_regs) ? pi->BRG_BCR_m : readl(pi->brg_base + BRG_BCR);
+	v = (v & ~(0xf << 18)) | ((clk_src & 0xf) << 18);
+
 	if (pi->brg_can_tune)
-		MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 25, 0);
+		v &= ~(1 << 25);
+
+	if (pi->mirror_regs)
+		pi->BRG_BCR_m = v;
+	writel(v, pi->brg_base + BRG_BCR);
 
-	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 4, 18, clk_src);
-	MPSC_MOD_FIELD(pi, brg, BRG_BTR, 16, 0, 0);
+	writel(readl(pi->brg_base + BRG_BTR) & 0xffff0000,
+		pi->brg_base + BRG_BTR);
 	return;
 }
 
 static void
 mpsc_brg_enable(struct mpsc_port_info *pi)
 {
-	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 16, 1);
+	u32	v;
+
+	v = (pi->mirror_regs) ? pi->BRG_BCR_m : readl(pi->brg_base + BRG_BCR);
+	v |= (1 << 16);
+
+	if (pi->mirror_regs)
+		pi->BRG_BCR_m = v;
+	writel(v, pi->brg_base + BRG_BCR);
 	return;
 }
 
 static void
 mpsc_brg_disable(struct mpsc_port_info *pi)
 {
-	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 16, 0);
+	u32	v;
+
+	v = (pi->mirror_regs) ? pi->BRG_BCR_m : readl(pi->brg_base + BRG_BCR);
+	v &= ~(1 << 16);
+
+	if (pi->mirror_regs)
+		pi->BRG_BCR_m = v;
+	writel(v, pi->brg_base + BRG_BCR);
 	return;
 }
 
@@ -115,10 +135,16 @@
 	 * that accounts for the way the mpsc is set up is:
 	 * CDV = (clk / (baud*2*16)) - 1 ==> CDV = (clk / (baud << 5)) - 1.
 	 */
-	u32 cdv = (pi->port.uartclk / (baud << 5)) - 1;
+	u32	cdv = (pi->port.uartclk / (baud << 5)) - 1;
+	u32	v;
 
 	mpsc_brg_disable(pi);
-	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 16, 0, cdv);
+	v = (pi->mirror_regs) ? pi->BRG_BCR_m : readl(pi->brg_base + BRG_BCR);
+	v = (v & 0xffff0000) | (cdv & 0xffff);
+
+	if (pi->mirror_regs)
+		pi->BRG_BCR_m = v;
+	writel(v, pi->brg_base + BRG_BCR);
 	mpsc_brg_enable(pi);
 
 	return;
@@ -135,7 +161,7 @@
 static void
 mpsc_sdma_burstsize(struct mpsc_port_info *pi, u32 burst_size)
 {
-	u32 v;
+	u32	v;
 
 	pr_debug("mpsc_sdma_burstsize[%d]: burst_size: %d\n",
 	    pi->port.line, burst_size);
@@ -151,7 +177,8 @@
 	else
 		v = 0x3;	/* 8 64-bit words */
 
-	MPSC_MOD_FIELD(pi, sdma, SDMA_SDC, 2, 12, v);
+	writel((readl(pi->sdma_base + SDMA_SDC) & (0x3 << 12)) | (v << 12),
+		pi->sdma_base + SDMA_SDC);
 	return;
 }
 
@@ -161,7 +188,8 @@
 	pr_debug("mpsc_sdma_init[%d]: burst_size: %d\n", pi->port.line,
 		burst_size);
 
-	MPSC_MOD_FIELD(pi, sdma, SDMA_SDC, 10, 0, 0x03f);
+	writel((readl(pi->sdma_base + SDMA_SDC) & 0x3ff) | 0x03f,
+		pi->sdma_base + SDMA_SDC);
 	mpsc_sdma_burstsize(pi, burst_size);
 	return;
 }
@@ -169,16 +197,21 @@
 static inline u32
 mpsc_sdma_intr_mask(struct mpsc_port_info *pi, u32 mask)
 {
-	u32 old, v;
+	u32	old, v;
 
 	pr_debug("mpsc_sdma_intr_mask[%d]: mask: 0x%x\n", pi->port.line, mask);
 
-	old = v = MPSC_READ_S(pi, sdma_intr, SDMA_INTR_MASK);
+	old = v = (pi->mirror_regs) ? pi->shared_regs->SDMA_INTR_MASK_m :
+		readl(pi->shared_regs->sdma_intr_base + SDMA_INTR_MASK);
+
 	mask &= 0xf;
 	if (pi->port.line)
 		mask <<= 8;
 	v &= ~mask;
-	MPSC_WRITE_S(pi, sdma_intr, SDMA_INTR_MASK, v);
+
+	if (pi->mirror_regs)
+		pi->shared_regs->SDMA_INTR_MASK_m = v;
+	writel(v, pi->shared_regs->sdma_intr_base + SDMA_INTR_MASK);
 
 	if (pi->port.line)
 		old >>= 8;
@@ -188,16 +221,21 @@
 static inline void
 mpsc_sdma_intr_unmask(struct mpsc_port_info *pi, u32 mask)
 {
-	u32 v;
+	u32	v;
 
 	pr_debug("mpsc_sdma_intr_unmask[%d]: mask: 0x%x\n", pi->port.line,mask);
 
-	v = MPSC_READ_S(pi, sdma_intr, SDMA_INTR_MASK);
+	v = (pi->mirror_regs) ? pi->shared_regs->SDMA_INTR_MASK_m :
+		readl(pi->shared_regs->sdma_intr_base + SDMA_INTR_MASK);
+
 	mask &= 0xf;
 	if (pi->port.line)
 		mask <<= 8;
 	v |= mask;
-	MPSC_WRITE_S(pi, sdma_intr, SDMA_INTR_MASK, v);
+
+	if (pi->mirror_regs)
+		pi->shared_regs->SDMA_INTR_MASK_m = v;
+	writel(v, pi->shared_regs->sdma_intr_base + SDMA_INTR_MASK);
 	return;
 }
 
@@ -205,7 +243,10 @@
 mpsc_sdma_intr_ack(struct mpsc_port_info *pi)
 {
 	pr_debug("mpsc_sdma_intr_ack[%d]: Acknowledging IRQ\n", pi->port.line);
-	MPSC_WRITE_S(pi, sdma_intr, SDMA_INTR_CAUSE, 0);
+
+	if (pi->mirror_regs)
+		pi->shared_regs->SDMA_INTR_CAUSE_m = 0;
+	writel(0, pi->shared_regs->sdma_intr_base + SDMA_INTR_CAUSE);
 	return;
 }
 
@@ -215,30 +256,30 @@
 	pr_debug("mpsc_sdma_set_rx_ring[%d]: rxre_p: 0x%x\n",
 		pi->port.line, (u32) rxre_p);
 
-	MPSC_WRITE(pi, sdma, SDMA_SCRDP, (u32) rxre_p);
+	writel((u32)rxre_p, pi->sdma_base + SDMA_SCRDP);
 	return;
 }
 
 static inline void
 mpsc_sdma_set_tx_ring(struct mpsc_port_info *pi, struct mpsc_tx_desc *txre_p)
 {
-	MPSC_WRITE(pi, sdma, SDMA_SFTDP, (u32) txre_p);
-	MPSC_WRITE(pi, sdma, SDMA_SCTDP, (u32) txre_p);
+	writel((u32)txre_p, pi->sdma_base + SDMA_SFTDP);
+	writel((u32)txre_p, pi->sdma_base + SDMA_SCTDP);
 	return;
 }
 
 static inline void
 mpsc_sdma_cmd(struct mpsc_port_info *pi, u32 val)
 {
-	u32 v;
+	u32	v;
 
-	v = MPSC_READ(pi, sdma, SDMA_SDCM);
+	v = readl(pi->sdma_base + SDMA_SDCM);
 	if (val)
 		v |= val;
 	else
 		v = 0;
 	wmb();
-	MPSC_WRITE(pi, sdma, SDMA_SDCM, v);
+	writel(v, pi->sdma_base + SDMA_SDCM);
 	wmb();
 	return;
 }
@@ -246,7 +287,7 @@
 static inline uint
 mpsc_sdma_tx_active(struct mpsc_port_info *pi)
 {
-	return MPSC_READ(pi, sdma, SDMA_SDCM) & SDMA_SDCM_TXD;
+	return readl(pi->sdma_base + SDMA_SDCM) & SDMA_SDCM_TXD;
 }
 
 static inline void
@@ -259,7 +300,11 @@
 		txre = (struct mpsc_tx_desc *)(pi->txr +
 			(pi->txr_tail * MPSC_TXRE_SIZE));
 		dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
-		MPSC_CACHE_INVALIDATE(pi, (u32)txre, (u32)txre+MPSC_TXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			invalidate_dcache_range((ulong)txre,
+				(ulong)txre + MPSC_TXRE_SIZE);
+#endif
 
 		if (be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O) {
 			txre_p = (struct mpsc_tx_desc *)(pi->txr_p +
@@ -305,32 +350,61 @@
 static void
 mpsc_hw_init(struct mpsc_port_info *pi)
 {
+	u32	v;
+
 	pr_debug("mpsc_hw_init[%d]: Initializing hardware\n", pi->port.line);
 
 	/* Set up clock routing */
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_MRR, 3, 0, 0);
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_MRR, 3, 6, 0);
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_RCRR, 4, 0, 0);
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_RCRR, 4, 8, 1);
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_TCRR, 4, 0, 0);
-	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_TCRR, 4, 8, 1);
+	if (pi->mirror_regs) {
+		v = pi->shared_regs->MPSC_MRR_m;
+		v &= ~0x1c7;
+		pi->shared_regs->MPSC_MRR_m = v;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_MRR);
+
+		v = pi->shared_regs->MPSC_RCRR_m;
+		v = (v & ~0xf0f) | 0x100;
+		pi->shared_regs->MPSC_RCRR_m = v;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_RCRR);
+
+		v = pi->shared_regs->MPSC_TCRR_m;
+		v = (v & ~0xf0f) | 0x100;
+		pi->shared_regs->MPSC_TCRR_m = v;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_TCRR);
+	}
+	else {
+		v = readl(pi->shared_regs->mpsc_routing_base + MPSC_MRR);
+		v &= ~0x1c7;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_MRR);
+
+		v = readl(pi->shared_regs->mpsc_routing_base + MPSC_RCRR);
+		v = (v & ~0xf0f) | 0x100;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_RCRR);
+
+		v = readl(pi->shared_regs->mpsc_routing_base + MPSC_TCRR);
+		v = (v & ~0xf0f) | 0x100;
+		writel(v, pi->shared_regs->mpsc_routing_base + MPSC_TCRR);
+	}
 
 	/* Put MPSC in UART mode & enabel Tx/Rx egines */
-	MPSC_WRITE(pi, mpsc, MPSC_MMCRL, 0x000004c4);
+	writel(0x000004c4, pi->mpsc_base + MPSC_MMCRL);
 
 	/* No preamble, 16x divider, low-latency,  */
-	MPSC_WRITE(pi, mpsc, MPSC_MMCRH, 0x04400400);
+	writel(0x04400400, pi->mpsc_base + MPSC_MMCRH);
 
-	MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0);
-	MPSC_WRITE_M(pi, mpsc, MPSC_CHR_2, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_3, pi->mpsc_max_idle);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_4, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_5, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_6, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_7, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_8, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_9, 0);
-	MPSC_WRITE(pi, mpsc, MPSC_CHR_10, 0);
+	if (pi->mirror_regs) {
+		pi->MPSC_CHR_1_m = 0;
+		pi->MPSC_CHR_2_m = 0;
+	}
+	writel(0, pi->mpsc_base + MPSC_CHR_1);
+	writel(0, pi->mpsc_base + MPSC_CHR_2);
+	writel(pi->mpsc_max_idle, pi->mpsc_base + MPSC_CHR_3);
+	writel(0, pi->mpsc_base + MPSC_CHR_4);
+	writel(0, pi->mpsc_base + MPSC_CHR_5);
+	writel(0, pi->mpsc_base + MPSC_CHR_6);
+	writel(0, pi->mpsc_base + MPSC_CHR_7);
+	writel(0, pi->mpsc_base + MPSC_CHR_8);
+	writel(0, pi->mpsc_base + MPSC_CHR_9);
+	writel(0, pi->mpsc_base + MPSC_CHR_10);
 
 	return;
 }
@@ -338,19 +412,21 @@
 static inline void
 mpsc_enter_hunt(struct mpsc_port_info *pi)
 {
-	u32 v;
-
 	pr_debug("mpsc_enter_hunt[%d]: Hunting...\n", pi->port.line);
 
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 1, 31, 1);
-
-	/* If erratum prevents reading CHR_2, just delay for a while */
-	if (pi->mirror_regs)
+	if (pi->mirror_regs) {
+		writel(pi->MPSC_CHR_2_m | MPSC_CHR_2_EH,
+			pi->mpsc_base + MPSC_CHR_2);
+		/* Erratum prevents reading CHR_2 so just delay for a while */
 		udelay(100);
-	else
-		do {
-			v = MPSC_READ_M(pi, mpsc, MPSC_CHR_2);
-		} while (v & MPSC_CHR_2_EH);
+	}
+	else {
+		writel(readl(pi->mpsc_base + MPSC_CHR_2) | MPSC_CHR_2_EH,
+			pi->mpsc_base + MPSC_CHR_2);
+
+		while (readl(pi->mpsc_base + MPSC_CHR_2) & MPSC_CHR_2_EH)
+			udelay(10);
+	}
 
 	return;
 }
@@ -358,16 +434,32 @@
 static inline void
 mpsc_freeze(struct mpsc_port_info *pi)
 {
+	u32	v;
+
 	pr_debug("mpsc_freeze[%d]: Freezing\n", pi->port.line);
 
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 9, 1);
+	v = (pi->mirror_regs) ? pi->MPSC_MPCR_m :
+		readl(pi->mpsc_base + MPSC_MPCR);
+	v |= MPSC_MPCR_FRZ;
+
+	if (pi->mirror_regs)
+		pi->MPSC_MPCR_m = v;
+	writel(v, pi->mpsc_base + MPSC_MPCR);
 	return;
 }
 
 static inline void
 mpsc_unfreeze(struct mpsc_port_info *pi)
 {
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 9, 0);
+	u32	v;
+
+	v = (pi->mirror_regs) ? pi->MPSC_MPCR_m :
+		readl(pi->mpsc_base + MPSC_MPCR);
+	v &= ~MPSC_MPCR_FRZ;
+
+	if (pi->mirror_regs)
+		pi->MPSC_MPCR_m = v;
+	writel(v, pi->mpsc_base + MPSC_MPCR);
 
 	pr_debug("mpsc_unfreeze[%d]: Unfrozen\n", pi->port.line);
 	return;
@@ -376,29 +468,55 @@
 static inline void
 mpsc_set_char_length(struct mpsc_port_info *pi, u32 len)
 {
+	u32	v;
+
 	pr_debug("mpsc_set_char_length[%d]: char len: %d\n", pi->port.line,len);
 
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 2, 12, len);
+	v = (pi->mirror_regs) ? pi->MPSC_MPCR_m :
+		readl(pi->mpsc_base + MPSC_MPCR);
+	v = (v & ~(0x3 << 12)) | ((len & 0x3) << 12);
+
+	if (pi->mirror_regs)
+		pi->MPSC_MPCR_m = v;
+	writel(v, pi->mpsc_base + MPSC_MPCR);
 	return;
 }
 
 static inline void
 mpsc_set_stop_bit_length(struct mpsc_port_info *pi, u32 len)
 {
+	u32	v;
+
 	pr_debug("mpsc_set_stop_bit_length[%d]: stop bits: %d\n",
 		pi->port.line, len);
 
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 14, len);
+	v = (pi->mirror_regs) ? pi->MPSC_MPCR_m :
+		readl(pi->mpsc_base + MPSC_MPCR);
+
+	v = (v & ~(1 << 14)) | ((len & 0x1) << 14);
+
+	if (pi->mirror_regs)
+		pi->MPSC_MPCR_m = v;
+	writel(v, pi->mpsc_base + MPSC_MPCR);
 	return;
 }
 
 static inline void
 mpsc_set_parity(struct mpsc_port_info *pi, u32 p)
 {
+	u32	v;
+
 	pr_debug("mpsc_set_parity[%d]: parity bits: 0x%x\n", pi->port.line, p);
 
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 2, 2, p);	/* TPM */
-	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 2, 18, p);	/* RPM */
+	v = (pi->mirror_regs) ? pi->MPSC_CHR_2_m :
+		readl(pi->mpsc_base + MPSC_CHR_2);
+
+	p &= 0x3;
+	v = (v & ~0xc000c) | (p << 18) | (p << 2);
+
+	if (pi->mirror_regs)
+		pi->MPSC_CHR_2_m = v;
+	writel(v, pi->mpsc_base + MPSC_CHR_2);
 	return;
 }
 
@@ -560,8 +678,11 @@
 
 	dma_cache_sync((void *) pi->dma_region, MPSC_DMA_ALLOC_SIZE,
 		DMA_BIDIRECTIONAL);
-	MPSC_CACHE_FLUSH(pi, pi->dma_region,
-		pi->dma_region + MPSC_DMA_ALLOC_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			flush_dcache_range((ulong)pi->dma_region,
+				(ulong)pi->dma_region + MPSC_DMA_ALLOC_SIZE);
+#endif
 
 	return;
 }
@@ -631,7 +752,11 @@
 	rxre = (struct mpsc_rx_desc *)(pi->rxr + (pi->rxr_posn*MPSC_RXRE_SIZE));
 
 	dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
-	MPSC_CACHE_INVALIDATE(pi, (u32) rxre, (u32) rxre + MPSC_RXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+		invalidate_dcache_range((ulong)rxre,
+			(ulong)rxre + MPSC_RXRE_SIZE);
+#endif
 
 	/*
 	 * Loop through Rx descriptors handling ones that have been completed.
@@ -651,7 +776,11 @@
 
 		bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE);
 		dma_cache_sync((void *) bp, MPSC_RXBE_SIZE, DMA_FROM_DEVICE);
-		MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_RXBE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			invalidate_dcache_range((ulong)bp,
+				(ulong)bp + MPSC_RXBE_SIZE);
+#endif
 
 		/*
 		 * Other than for parity error, the manual provides little
@@ -716,20 +845,28 @@
 					    SDMA_DESC_CMDSTAT_L);
 		wmb();
 		dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_BIDIRECTIONAL);
-		MPSC_CACHE_FLUSH(pi, (u32) rxre, (u32) rxre + MPSC_RXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			flush_dcache_range((ulong)rxre,
+				(ulong)rxre + MPSC_RXRE_SIZE);
+#endif
 
 		/* Advance to next descriptor */
 		pi->rxr_posn = (pi->rxr_posn + 1) & (MPSC_RXR_ENTRIES - 1);
 		rxre = (struct mpsc_rx_desc *)(pi->rxr +
 			(pi->rxr_posn * MPSC_RXRE_SIZE));
 		dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
-		MPSC_CACHE_INVALIDATE(pi, (u32)rxre, (u32)rxre+MPSC_RXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			invalidate_dcache_range((ulong)rxre,
+				(ulong)rxre + MPSC_RXRE_SIZE);
+#endif
 
 		rc = 1;
 	}
 
 	/* Restart rx engine, if its stopped */
-	if ((MPSC_READ(pi, sdma, SDMA_SDCM) & SDMA_SDCM_ERD) == 0)
+	if ((readl(pi->sdma_base + SDMA_SDCM) & SDMA_SDCM_ERD) == 0)
 		mpsc_start_rx(pi);
 
 	tty_flip_buffer_push(tty);
@@ -753,7 +890,11 @@
 							   : 0));
 	wmb();
 	dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_BIDIRECTIONAL);
-	MPSC_CACHE_FLUSH(pi, (u32) txre, (u32) txre + MPSC_TXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+		flush_dcache_range((ulong)txre,
+			(ulong)txre + MPSC_TXRE_SIZE);
+#endif
 
 	return;
 }
@@ -798,7 +939,11 @@
 			return;
 
 		dma_cache_sync((void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
-		MPSC_CACHE_FLUSH(pi, bp, bp + MPSC_TXBE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			flush_dcache_range((ulong)bp,
+				(ulong)bp + MPSC_TXBE_SIZE);
+#endif
 		mpsc_setup_tx_desc(pi, i, 1);
 
 		/* Advance to next descriptor */
@@ -819,7 +964,11 @@
 			(pi->txr_tail * MPSC_TXRE_SIZE));
 
 		dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
-		MPSC_CACHE_INVALIDATE(pi, (u32) txre, (u32)txre+MPSC_TXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			invalidate_dcache_range((ulong)txre,
+				(ulong)txre + MPSC_TXRE_SIZE);
+#endif
 
 		while (!(be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O)) {
 			rc = 1;
@@ -834,8 +983,11 @@
 				(pi->txr_tail * MPSC_TXRE_SIZE));
 			dma_cache_sync((void *) txre, MPSC_TXRE_SIZE,
 				DMA_FROM_DEVICE);
-			MPSC_CACHE_INVALIDATE(pi, (u32) txre,
-			      (u32) txre + MPSC_TXRE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+				invalidate_dcache_range((ulong)txre,
+					(ulong)txre + MPSC_TXRE_SIZE);
+#endif
 		}
 
 		mpsc_copy_tx_data(pi);
@@ -907,7 +1059,8 @@
 	ulong iflags;
 
 	spin_lock_irqsave(&pi->port.lock, iflags);
-	status = MPSC_READ_M(pi, mpsc, MPSC_CHR_10);
+	status = (pi->mirror_regs) ? pi->MPSC_CHR_10_m :
+		readl(pi->mpsc_base + MPSC_CHR_10);
 	spin_unlock_irqrestore(&pi->port.lock, iflags);
 
 	mflags = 0;
@@ -976,13 +1129,15 @@
 mpsc_break_ctl(struct uart_port *port, int ctl)
 {
 	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
-	ulong flags;
+	ulong	flags;
+	u32	v;
+
+	v = ctl ? 0x00ff0000 : 0;
 
 	spin_lock_irqsave(&pi->port.lock, flags);
-	if (ctl) /* Send as many BRK chars as we can */
-		MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0x00ff0000);
-	else /* Stop sending BRK chars */
-		MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0);
+	if (pi->mirror_regs)
+		pi->MPSC_CHR_1_m = v;
+	writel(v, pi->mpsc_base + MPSC_CHR_1);
 	spin_unlock_irqrestore(&pi->port.lock, flags);
 
 	return;
@@ -1246,7 +1401,11 @@
 		}
 
 		dma_cache_sync((void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
-		MPSC_CACHE_FLUSH(pi, bp, bp + MPSC_TXBE_SIZE);
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
+			flush_dcache_range((ulong)bp,
+				(ulong)bp + MPSC_TXBE_SIZE);
+#endif
 		mpsc_setup_tx_desc(pi, i, 0);
 		pi->txr_head = (pi->txr_head + 1) & (MPSC_TXR_ENTRIES - 1);
 		mpsc_sdma_start_tx(pi);
@@ -1339,7 +1498,7 @@
 		MPSC_ROUTING_BASE_ORDER)) && request_mem_region(r->start,
 		MPSC_ROUTING_REG_BLOCK_SIZE, "mpsc_routing_regs")) {
 
-		mpsc_shared_regs.mpsc_routing_base = (u32) ioremap(r->start,
+		mpsc_shared_regs.mpsc_routing_base = ioremap(r->start,
 			MPSC_ROUTING_REG_BLOCK_SIZE);
 		mpsc_shared_regs.mpsc_routing_base_p = r->start;
 	}
@@ -1352,12 +1511,12 @@
 		MPSC_SDMA_INTR_BASE_ORDER)) && request_mem_region(r->start,
 		MPSC_SDMA_INTR_REG_BLOCK_SIZE, "sdma_intr_regs")) {
 
-		mpsc_shared_regs.sdma_intr_base = (u32) ioremap(r->start,
+		mpsc_shared_regs.sdma_intr_base = ioremap(r->start,
 			MPSC_SDMA_INTR_REG_BLOCK_SIZE);
 		mpsc_shared_regs.sdma_intr_base_p = r->start;
 	}
 	else {
-		iounmap((void *)mpsc_shared_regs.mpsc_routing_base);
+		iounmap(mpsc_shared_regs.mpsc_routing_base);
 		release_mem_region(mpsc_shared_regs.mpsc_routing_base_p,
 			MPSC_ROUTING_REG_BLOCK_SIZE);
 		mpsc_resource_err("SDMA intr base");
@@ -1371,12 +1530,12 @@
 mpsc_shared_unmap_regs(void)
 {
 	if (!mpsc_shared_regs.mpsc_routing_base) {
-		iounmap((void *)mpsc_shared_regs.mpsc_routing_base);
+		iounmap(mpsc_shared_regs.mpsc_routing_base);
 		release_mem_region(mpsc_shared_regs.mpsc_routing_base_p,
 			MPSC_ROUTING_REG_BLOCK_SIZE);
 	}
 	if (!mpsc_shared_regs.sdma_intr_base) {
-		iounmap((void *)mpsc_shared_regs.sdma_intr_base);
+		iounmap(mpsc_shared_regs.sdma_intr_base);
 		release_mem_region(mpsc_shared_regs.sdma_intr_base_p,
 			MPSC_SDMA_INTR_REG_BLOCK_SIZE);
 	}
@@ -1394,21 +1553,20 @@
 mpsc_shared_drv_probe(struct device *dev)
 {
 	struct platform_device		*pd = to_platform_device(dev);
-	struct mpsc_shared_pd_dd	*dd;
+	struct mpsc_shared_pdata	*pdata;
 	int				 rc = -ENODEV;
 
 	if (pd->id == 0) {
 		if (!(rc = mpsc_shared_map_regs(pd)))  {
-			dd = (struct mpsc_shared_pd_dd *)
-				dev_get_drvdata(dev);
+			pdata = (struct mpsc_shared_pdata *)dev->platform_data;
 
-			mpsc_shared_regs.MPSC_MRR_m = dd->mrr_val;
-			mpsc_shared_regs.MPSC_RCRR_m= dd->rcrr_val;
-			mpsc_shared_regs.MPSC_TCRR_m= dd->tcrr_val;
+			mpsc_shared_regs.MPSC_MRR_m = pdata->mrr_val;
+			mpsc_shared_regs.MPSC_RCRR_m= pdata->rcrr_val;
+			mpsc_shared_regs.MPSC_TCRR_m= pdata->tcrr_val;
 			mpsc_shared_regs.SDMA_INTR_CAUSE_m =
-				dd->intr_cause_val;
+				pdata->intr_cause_val;
 			mpsc_shared_regs.SDMA_INTR_MASK_m =
-				dd->intr_mask_val;
+				pdata->intr_mask_val;
 
 			rc = 0;
 		}
@@ -1469,7 +1627,7 @@
 	if ((r = platform_get_resource(pd, IORESOURCE_MEM, MPSC_BASE_ORDER)) &&
 		request_mem_region(r->start, MPSC_REG_BLOCK_SIZE, "mpsc_regs")){
 
-		pi->mpsc_base = (u32) ioremap(r->start, MPSC_REG_BLOCK_SIZE);
+		pi->mpsc_base = ioremap(r->start, MPSC_REG_BLOCK_SIZE);
 		pi->mpsc_base_p = r->start;
 	}
 	else {
@@ -1481,7 +1639,7 @@
 		MPSC_SDMA_BASE_ORDER)) && request_mem_region(r->start,
 		MPSC_SDMA_REG_BLOCK_SIZE, "sdma_regs")) {
 
-		pi->sdma_base = (u32)ioremap(r->start,MPSC_SDMA_REG_BLOCK_SIZE);
+		pi->sdma_base = ioremap(r->start,MPSC_SDMA_REG_BLOCK_SIZE);
 		pi->sdma_base_p = r->start;
 	}
 	else {
@@ -1493,7 +1651,7 @@
 		&& request_mem_region(r->start, MPSC_BRG_REG_BLOCK_SIZE,
 		"brg_regs")) {
 
-		pi->brg_base = (u32) ioremap(r->start, MPSC_BRG_REG_BLOCK_SIZE);
+		pi->brg_base = ioremap(r->start, MPSC_BRG_REG_BLOCK_SIZE);
 		pi->brg_base_p = r->start;
 	}
 	else {
@@ -1508,15 +1666,15 @@
 mpsc_drv_unmap_regs(struct mpsc_port_info *pi)
 {
 	if (!pi->mpsc_base) {
-		iounmap((void *)pi->mpsc_base);
+		iounmap(pi->mpsc_base);
 		release_mem_region(pi->mpsc_base_p, MPSC_REG_BLOCK_SIZE);
 	}
 	if (!pi->sdma_base) {
-		iounmap((void *)pi->sdma_base);
+		iounmap(pi->sdma_base);
 		release_mem_region(pi->sdma_base_p, MPSC_SDMA_REG_BLOCK_SIZE);
 	}
 	if (!pi->brg_base) {
-		iounmap((void *)pi->brg_base);
+		iounmap(pi->brg_base);
 		release_mem_region(pi->brg_base_p, MPSC_BRG_REG_BLOCK_SIZE);
 	}
 
@@ -1535,35 +1693,35 @@
 mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
 	struct platform_device *pd, int num)
 {
-	struct mpsc_pd_dd	*dd;
+	struct mpsc_pdata	*pdata;
 
-	dd = (struct mpsc_pd_dd *)dev_get_drvdata(&pd->dev);
+	pdata = (struct mpsc_pdata *)pd->dev.platform_data;
 
-	pi->port.uartclk = dd->brg_clk_freq;
+	pi->port.uartclk = pdata->brg_clk_freq;
 	pi->port.iotype = UPIO_MEM;
 	pi->port.line = num;
 	pi->port.type = PORT_MPSC;
 	pi->port.fifosize = MPSC_TXBE_SIZE;
-	pi->port.membase = (char *)pi->mpsc_base;
-	pi->port.mapbase = (ulong) pi->mpsc_base;
+	pi->port.membase = pi->mpsc_base;
+	pi->port.mapbase = (ulong)pi->mpsc_base;
 	pi->port.ops = &mpsc_pops;
 
-	pi->mirror_regs = dd->mirror_regs;
-	pi->cache_mgmt = dd->cache_mgmt;
-	pi->brg_can_tune = dd->brg_can_tune;
-	pi->brg_clk_src = dd->brg_clk_src;
-	pi->mpsc_max_idle = dd->max_idle;
-	pi->default_baud = dd->default_baud;
-	pi->default_bits = dd->default_bits;
-	pi->default_parity = dd->default_parity;
-	pi->default_flow = dd->default_flow;
+	pi->mirror_regs = pdata->mirror_regs;
+	pi->cache_mgmt = pdata->cache_mgmt;
+	pi->brg_can_tune = pdata->brg_can_tune;
+	pi->brg_clk_src = pdata->brg_clk_src;
+	pi->mpsc_max_idle = pdata->max_idle;
+	pi->default_baud = pdata->default_baud;
+	pi->default_bits = pdata->default_bits;
+	pi->default_parity = pdata->default_parity;
+	pi->default_flow = pdata->default_flow;
 
 	/* Initial values of mirrored regs */
-	pi->MPSC_CHR_1_m = dd->chr_1_val;
-	pi->MPSC_CHR_2_m = dd->chr_2_val;
-	pi->MPSC_CHR_10_m = dd->chr_10_val;
-	pi->MPSC_MPCR_m = dd->mpcr_val;
-	pi->BRG_BCR_m = dd->bcr_val;
+	pi->MPSC_CHR_1_m = pdata->chr_1_val;
+	pi->MPSC_CHR_2_m = pdata->chr_2_val;
+	pi->MPSC_CHR_10_m = pdata->chr_10_val;
+	pi->MPSC_MPCR_m = pdata->mpcr_val;
+	pi->BRG_BCR_m = pdata->bcr_val;
 
 	pi->shared_regs = &mpsc_shared_regs;
 
diff -Nru a/drivers/serial/mpsc.h b/drivers/serial/mpsc.h
--- a/drivers/serial/mpsc.h	2005-01-25 17:28:43 -07:00
+++ b/drivers/serial/mpsc.h	2005-01-25 17:28:43 -07:00
@@ -22,9 +22,11 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/mv643xx.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -33,8 +35,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/serial_core.h>
-#include "mpsc_defs.h"
+#define	MPSC_NUM_CTLRS		2
 
 /*
  * Descriptors and buffers must be cache line aligned.
@@ -79,11 +80,11 @@
  * between the two MPSC controllers.  This struct contains those shared regs.
  */
 struct mpsc_shared_regs {
-	u32 mpsc_routing_base_p;
-	u32 sdma_intr_base_p;
+	phys_addr_t mpsc_routing_base_p;
+	phys_addr_t sdma_intr_base_p;
 
-	u32 mpsc_routing_base;
-	u32 sdma_intr_base;
+	void *mpsc_routing_base;
+	void *sdma_intr_base;
 
 	u32 MPSC_MRR_m;
 	u32 MPSC_RCRR_m;
@@ -114,14 +115,14 @@
 	int default_flow;
 
 	/* Physical addresses of various blocks of registers (from platform) */
-	u32 mpsc_base_p;
-	u32 sdma_base_p;
-	u32 brg_base_p;
+	phys_addr_t mpsc_base_p;
+	phys_addr_t sdma_base_p;
+	phys_addr_t brg_base_p;
 
 	/* Virtual addresses of various blocks of registers (from platform) */
-	u32 mpsc_base;
-	u32 sdma_base;
-	u32 brg_base;
+	void *mpsc_base;
+	void *sdma_base;
+	void *brg_base;
 
 	/* Descriptor ring and buffer allocations */
 	void *dma_region;
@@ -149,135 +150,6 @@
 	struct mpsc_shared_regs *shared_regs;
 };
 
-#if defined(CONFIG_PPC32)
-
-#if defined(CONFIG_NOT_COHERENT_CACHE)
-/* No-ops when coherency is off b/c dma_cache_sync() does that work */
-#define	MPSC_CACHE_INVALIDATE(pi, s, e)
-#define	MPSC_CACHE_FLUSH(pi, s, e)
-#else /* defined(CONFIG_NOT_COHERENT_CACHE) */
-/* Coherency is on so dma_cache_sync() is no-op so must do manually */
-#define	MPSC_CACHE_INVALIDATE(pi, s, e) {			\
-	if (pi->cache_mgmt) {					\
-		invalidate_dcache_range((ulong)s, (ulong)e);	\
-	}							\
-}
-
-#define	MPSC_CACHE_FLUSH(pi, s, e) {			\
-	if (pi->cache_mgmt) {				\
-		flush_dcache_range((ulong)s, (ulong)e);	\
-	}						\
-}
-#endif /* defined(CONFIG_NOT_COHERENT_CACHE) */
-
-#else /* defined(CONFIG_PPC32) */
-/* Other architectures need to fill this in */
-#define	MPSC_CACHE_INVALIDATE(pi, s, e)	BUG()
-#define	MPSC_CACHE_FLUSH(pi, s, e)	BUG()
-#endif /* defined(CONFIG_PPC32) */
-
-/*
- * 'MASK_INSERT' takes the low-order 'n' bits of 'i', shifts it 'b' bits to
- * the left, and inserts it into the target 't'.  The corresponding bits in
- * 't' will have been cleared before the bits in 'i' are inserted.
- */
-#ifdef CONFIG_PPC32
-#define MASK_INSERT(t, i, n, b) ({				\
-	u32	rval = (t);					\
-        __asm__ __volatile__(					\
-		"rlwimi %0,%2,%4,32-(%3+%4),31-%4\n"		\
-		: "=r" (rval)					\
-		: "0" (rval), "r" (i), "i" (n), "i" (b));	\
-	rval;							\
-})
-#else
-/* These macros are really just examples.  Feel free to change them --MAG */
-#define GEN_MASK(n, b)			\
-({					\
-	u32	m, sl, sr;		\
-	sl = 32 - (n);			\
-	sr = sl - (b);			\
-	m = (0xffffffff << sl) >> sr;	\
-})
-
-#define MASK_INSERT(t, i, n, b)		\
-({					\
-	u32	m, rval = (t);		\
-	m = GEN_MASK((n), (b));		\
-	rval &= ~m;			\
-	rval |= (((i) << (b)) & m);	\
-})
-#endif
-
-/* I/O macros for regs that you can read */
-#define	MPSC_READ(pi, unit, offset)					\
-	readl((volatile void *)((pi)->unit##_base + (offset)))
-
-#define	MPSC_WRITE(pi, unit, offset, v)					\
-	writel(v, (volatile void *)((pi)->unit##_base + (offset)))
-
-#define	MPSC_MOD_FIELD(pi, unit, offset, num_bits, shift, val)		\
-{									\
-	u32	v;							\
-	v = readl((volatile void *)((pi)->unit##_base + (offset)));	\
-	writel(MASK_INSERT(v,val,num_bits,shift),			\
-		(volatile void *)((pi)->unit##_base+(offset)));		\
-}
-
-/* Macros for regs with erratum that are not shared between MPSC ctlrs */
-#define	MPSC_READ_M(pi, unit, offset)					\
-({									\
-	u32	v;							\
-	if ((pi)->mirror_regs) v = (pi)->offset##_m;			\
-	else v = readl((volatile void *)((pi)->unit##_base + (offset)));\
-	v;								\
-})
-
-#define	MPSC_WRITE_M(pi, unit, offset, v)				\
-({									\
-	if ((pi)->mirror_regs) (pi)->offset##_m = v;			\
-	writel(v, (volatile void *)((pi)->unit##_base + (offset)));	\
-})
-
-#define	MPSC_MOD_FIELD_M(pi, unit, offset, num_bits, shift, val)	\
-({									\
-	u32	v;							\
-	if ((pi)->mirror_regs) v = (pi)->offset##_m;			\
-	else v = readl((volatile void *)((pi)->unit##_base + (offset)));\
-	v = MASK_INSERT(v, val, num_bits, shift);			\
-	if ((pi)->mirror_regs) (pi)->offset##_m = v;			\
-	writel(v, (volatile void *)((pi)->unit##_base + (offset)));	\
-})
-
-/* Macros for regs with erratum that are shared between MPSC ctlrs */
-#define	MPSC_READ_S(pi, unit, offset)					\
-({									\
-	u32	v;							\
-	if ((pi)->mirror_regs) v = (pi)->shared_regs->offset##_m;	\
-	else v = readl((volatile void *)((pi)->shared_regs->unit##_base + \
-		(offset)));						\
-	v;								\
-})
-
-#define	MPSC_WRITE_S(pi, unit, offset, v)				\
-({									\
-	if ((pi)->mirror_regs) (pi)->shared_regs->offset##_m = v;	\
-	writel(v, (volatile void *)((pi)->shared_regs->unit##_base +	\
-		(offset)));						\
-})
-
-#define	MPSC_MOD_FIELD_S(pi, unit, offset, num_bits, shift, val)	\
-({									\
-	u32	v;							\
-	if ((pi)->mirror_regs) v = (pi)->shared_regs->offset##_m;	\
-	else v = readl((volatile void *)((pi)->shared_regs->unit##_base + \
-		(offset)));						\
-	v = MASK_INSERT(v, val, num_bits, shift);			\
-	if ((pi)->mirror_regs) (pi)->shared_regs->offset##_m = v;	\
-	writel(v, (volatile void *)((pi)->shared_regs->unit##_base +	\
-		(offset)));						\
-})
-
 /* Hooks to platform-specific code */
 int mpsc_platform_register_driver(void);
 void mpsc_platform_unregister_driver(void);
@@ -285,5 +157,133 @@
 /* Hooks back in to mpsc common to be called by platform-specific code */
 struct mpsc_port_info *mpsc_device_probe(int index);
 struct mpsc_port_info *mpsc_device_remove(int index);
+
+/*
+ *****************************************************************************
+ *
+ *	Multi-Protocol Serial Controller Interface Registers
+ *
+ *****************************************************************************
+ */
+
+/* Main Configuratino Register Offsets */
+#define	MPSC_MMCRL			0x0000
+#define	MPSC_MMCRH			0x0004
+#define	MPSC_MPCR			0x0008
+#define	MPSC_CHR_1			0x000c
+#define	MPSC_CHR_2			0x0010
+#define	MPSC_CHR_3			0x0014
+#define	MPSC_CHR_4			0x0018
+#define	MPSC_CHR_5			0x001c
+#define	MPSC_CHR_6			0x0020
+#define	MPSC_CHR_7			0x0024
+#define	MPSC_CHR_8			0x0028
+#define	MPSC_CHR_9			0x002c
+#define	MPSC_CHR_10			0x0030
+#define	MPSC_CHR_11			0x0034
+
+#define	MPSC_MPCR_FRZ			(1 << 9)
+#define	MPSC_MPCR_CL_5			0
+#define	MPSC_MPCR_CL_6			1
+#define	MPSC_MPCR_CL_7			2
+#define	MPSC_MPCR_CL_8			3
+#define	MPSC_MPCR_SBL_1			0
+#define	MPSC_MPCR_SBL_2			1
+
+#define	MPSC_CHR_2_TEV			(1<<1)
+#define	MPSC_CHR_2_TA			(1<<7)
+#define	MPSC_CHR_2_TTCS			(1<<9)
+#define	MPSC_CHR_2_REV			(1<<17)
+#define	MPSC_CHR_2_RA			(1<<23)
+#define	MPSC_CHR_2_CRD			(1<<25)
+#define	MPSC_CHR_2_EH			(1<<31)
+#define	MPSC_CHR_2_PAR_ODD		0
+#define	MPSC_CHR_2_PAR_SPACE		1
+#define	MPSC_CHR_2_PAR_EVEN		2
+#define	MPSC_CHR_2_PAR_MARK		3
+
+/* MPSC Signal Routing */
+#define	MPSC_MRR			0x0000
+#define	MPSC_RCRR			0x0004
+#define	MPSC_TCRR			0x0008
+
+/*
+ *****************************************************************************
+ *
+ *	Serial DMA Controller Interface Registers
+ *
+ *****************************************************************************
+ */
+
+#define	SDMA_SDC			0x0000
+#define	SDMA_SDCM			0x0008
+#define	SDMA_RX_DESC			0x0800
+#define	SDMA_RX_BUF_PTR			0x0808
+#define	SDMA_SCRDP			0x0810
+#define	SDMA_TX_DESC			0x0c00
+#define	SDMA_SCTDP			0x0c10
+#define	SDMA_SFTDP			0x0c14
+
+#define	SDMA_DESC_CMDSTAT_PE		(1<<0)
+#define	SDMA_DESC_CMDSTAT_CDL		(1<<1)
+#define	SDMA_DESC_CMDSTAT_FR		(1<<3)
+#define	SDMA_DESC_CMDSTAT_OR		(1<<6)
+#define	SDMA_DESC_CMDSTAT_BR		(1<<9)
+#define	SDMA_DESC_CMDSTAT_MI		(1<<10)
+#define	SDMA_DESC_CMDSTAT_A		(1<<11)
+#define	SDMA_DESC_CMDSTAT_AM		(1<<12)
+#define	SDMA_DESC_CMDSTAT_CT		(1<<13)
+#define	SDMA_DESC_CMDSTAT_C		(1<<14)
+#define	SDMA_DESC_CMDSTAT_ES		(1<<15)
+#define	SDMA_DESC_CMDSTAT_L		(1<<16)
+#define	SDMA_DESC_CMDSTAT_F		(1<<17)
+#define	SDMA_DESC_CMDSTAT_P		(1<<18)
+#define	SDMA_DESC_CMDSTAT_EI		(1<<23)
+#define	SDMA_DESC_CMDSTAT_O		(1<<31)
+
+#define SDMA_DESC_DFLT			(SDMA_DESC_CMDSTAT_O |	\
+					SDMA_DESC_CMDSTAT_EI)
+
+#define	SDMA_SDC_RFT			(1<<0)
+#define	SDMA_SDC_SFM			(1<<1)
+#define	SDMA_SDC_BLMR			(1<<6)
+#define	SDMA_SDC_BLMT			(1<<7)
+#define	SDMA_SDC_POVR			(1<<8)
+#define	SDMA_SDC_RIFB			(1<<9)
+
+#define	SDMA_SDCM_ERD			(1<<7)
+#define	SDMA_SDCM_AR			(1<<15)
+#define	SDMA_SDCM_STD			(1<<16)
+#define	SDMA_SDCM_TXD			(1<<23)
+#define	SDMA_SDCM_AT			(1<<31)
+
+#define	SDMA_0_CAUSE_RXBUF		(1<<0)
+#define	SDMA_0_CAUSE_RXERR		(1<<1)
+#define	SDMA_0_CAUSE_TXBUF		(1<<2)
+#define	SDMA_0_CAUSE_TXEND		(1<<3)
+#define	SDMA_1_CAUSE_RXBUF		(1<<8)
+#define	SDMA_1_CAUSE_RXERR		(1<<9)
+#define	SDMA_1_CAUSE_TXBUF		(1<<10)
+#define	SDMA_1_CAUSE_TXEND		(1<<11)
+
+#define	SDMA_CAUSE_RX_MASK	(SDMA_0_CAUSE_RXBUF | SDMA_0_CAUSE_RXERR | \
+	SDMA_1_CAUSE_RXBUF | SDMA_1_CAUSE_RXERR)
+#define	SDMA_CAUSE_TX_MASK	(SDMA_0_CAUSE_TXBUF | SDMA_0_CAUSE_TXEND | \
+	SDMA_1_CAUSE_TXBUF | SDMA_1_CAUSE_TXEND)
+
+/* SDMA Interrupt registers */
+#define	SDMA_INTR_CAUSE			0x0000
+#define	SDMA_INTR_MASK			0x0080
+
+/*
+ *****************************************************************************
+ *
+ *	Baud Rate Generator Interface Registers
+ *
+ *****************************************************************************
+ */
+
+#define	BRG_BCR				0x0000
+#define	BRG_BTR				0x0004
 
 #endif				/* __MPSC_H__ */
diff -Nru a/drivers/serial/mpsc_defs.h b/drivers/serial/mpsc_defs.h
--- a/drivers/serial/mpsc_defs.h	2005-01-25 17:28:43 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,146 +0,0 @@
-/*
- * drivers/serial/mpsc_defs.h
- *
- * Register definitions for the Marvell Multi-Protocol Serial Controller (MPSC),
- * Serial DMA Controller (SDMA), and Baud Rate Generator (BRG).
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef	__MPSC_DEFS_H__
-#define	__MPSC_DEFS_H__
-
-#define	MPSC_NUM_CTLRS		2
-
-/*
- *****************************************************************************
- *
- *	Multi-Protocol Serial Controller Interface Registers
- *
- *****************************************************************************
- */
-
-/* Main Configuratino Register Offsets */
-#define	MPSC_MMCRL			0x0000
-#define	MPSC_MMCRH			0x0004
-#define	MPSC_MPCR			0x0008
-#define	MPSC_CHR_1			0x000c
-#define	MPSC_CHR_2			0x0010
-#define	MPSC_CHR_3			0x0014
-#define	MPSC_CHR_4			0x0018
-#define	MPSC_CHR_5			0x001c
-#define	MPSC_CHR_6			0x0020
-#define	MPSC_CHR_7			0x0024
-#define	MPSC_CHR_8			0x0028
-#define	MPSC_CHR_9			0x002c
-#define	MPSC_CHR_10			0x0030
-#define	MPSC_CHR_11			0x0034
-
-#define	MPSC_MPCR_CL_5			0
-#define	MPSC_MPCR_CL_6			1
-#define	MPSC_MPCR_CL_7			2
-#define	MPSC_MPCR_CL_8			3
-#define	MPSC_MPCR_SBL_1			0
-#define	MPSC_MPCR_SBL_2			3
-
-#define	MPSC_CHR_2_TEV			(1<<1)
-#define	MPSC_CHR_2_TA			(1<<7)
-#define	MPSC_CHR_2_TTCS			(1<<9)
-#define	MPSC_CHR_2_REV			(1<<17)
-#define	MPSC_CHR_2_RA			(1<<23)
-#define	MPSC_CHR_2_CRD			(1<<25)
-#define	MPSC_CHR_2_EH			(1<<31)
-#define	MPSC_CHR_2_PAR_ODD		0
-#define	MPSC_CHR_2_PAR_SPACE		1
-#define	MPSC_CHR_2_PAR_EVEN		2
-#define	MPSC_CHR_2_PAR_MARK		3
-
-/* MPSC Signal Routing */
-#define	MPSC_MRR			0x0000
-#define	MPSC_RCRR			0x0004
-#define	MPSC_TCRR			0x0008
-
-/*
- *****************************************************************************
- *
- *	Serial DMA Controller Interface Registers
- *
- *****************************************************************************
- */
-
-#define	SDMA_SDC			0x0000
-#define	SDMA_SDCM			0x0008
-#define	SDMA_RX_DESC			0x0800
-#define	SDMA_RX_BUF_PTR			0x0808
-#define	SDMA_SCRDP			0x0810
-#define	SDMA_TX_DESC			0x0c00
-#define	SDMA_SCTDP			0x0c10
-#define	SDMA_SFTDP			0x0c14
-
-#define	SDMA_DESC_CMDSTAT_PE		(1<<0)
-#define	SDMA_DESC_CMDSTAT_CDL		(1<<1)
-#define	SDMA_DESC_CMDSTAT_FR		(1<<3)
-#define	SDMA_DESC_CMDSTAT_OR		(1<<6)
-#define	SDMA_DESC_CMDSTAT_BR		(1<<9)
-#define	SDMA_DESC_CMDSTAT_MI		(1<<10)
-#define	SDMA_DESC_CMDSTAT_A		(1<<11)
-#define	SDMA_DESC_CMDSTAT_AM		(1<<12)
-#define	SDMA_DESC_CMDSTAT_CT		(1<<13)
-#define	SDMA_DESC_CMDSTAT_C		(1<<14)
-#define	SDMA_DESC_CMDSTAT_ES		(1<<15)
-#define	SDMA_DESC_CMDSTAT_L		(1<<16)
-#define	SDMA_DESC_CMDSTAT_F		(1<<17)
-#define	SDMA_DESC_CMDSTAT_P		(1<<18)
-#define	SDMA_DESC_CMDSTAT_EI		(1<<23)
-#define	SDMA_DESC_CMDSTAT_O		(1<<31)
-
-#define SDMA_DESC_DFLT			(SDMA_DESC_CMDSTAT_O |	\
-					SDMA_DESC_CMDSTAT_EI)
-
-#define	SDMA_SDC_RFT			(1<<0)
-#define	SDMA_SDC_SFM			(1<<1)
-#define	SDMA_SDC_BLMR			(1<<6)
-#define	SDMA_SDC_BLMT			(1<<7)
-#define	SDMA_SDC_POVR			(1<<8)
-#define	SDMA_SDC_RIFB			(1<<9)
-
-#define	SDMA_SDCM_ERD			(1<<7)
-#define	SDMA_SDCM_AR			(1<<15)
-#define	SDMA_SDCM_STD			(1<<16)
-#define	SDMA_SDCM_TXD			(1<<23)
-#define	SDMA_SDCM_AT			(1<<31)
-
-#define	SDMA_0_CAUSE_RXBUF		(1<<0)
-#define	SDMA_0_CAUSE_RXERR		(1<<1)
-#define	SDMA_0_CAUSE_TXBUF		(1<<2)
-#define	SDMA_0_CAUSE_TXEND		(1<<3)
-#define	SDMA_1_CAUSE_RXBUF		(1<<8)
-#define	SDMA_1_CAUSE_RXERR		(1<<9)
-#define	SDMA_1_CAUSE_TXBUF		(1<<10)
-#define	SDMA_1_CAUSE_TXEND		(1<<11)
-
-#define	SDMA_CAUSE_RX_MASK	(SDMA_0_CAUSE_RXBUF | SDMA_0_CAUSE_RXERR | \
-	SDMA_1_CAUSE_RXBUF | SDMA_1_CAUSE_RXERR)
-#define	SDMA_CAUSE_TX_MASK	(SDMA_0_CAUSE_TXBUF | SDMA_0_CAUSE_TXEND | \
-	SDMA_1_CAUSE_TXBUF | SDMA_1_CAUSE_TXEND)
-
-/* SDMA Interrupt registers */
-#define	SDMA_INTR_CAUSE			0x0000
-#define	SDMA_INTR_MASK			0x0080
-
-/*
- *****************************************************************************
- *
- *	Baud Rate Generator Interface Registers
- *
- *****************************************************************************
- */
-
-#define	BRG_BCR				0x0000
-#define	BRG_BTR				0x0004
-
-#endif /*__MPSC_DEFS_H__ */

--------------070304090609050709030404--

