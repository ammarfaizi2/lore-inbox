Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWJRXid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWJRXid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbWJRXiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:38:08 -0400
Received: from [63.64.152.142] ([63.64.152.142]:50702 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423162AbWJRXiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:38:04 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 3/7] I/OAT: Remove the wrappers around read(bwl)/write(bwl) in ioatdma
Date: Wed, 18 Oct 2006 16:46:53 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234653.26671.21444.stgit@gitlost.site>
In-Reply-To: <20061018234417.26671.56773.stgit@gitlost.site>
References: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/ioatdma.c    |   60 +++++++++++------------
 drivers/dma/ioatdma_io.h |  118 ----------------------------------------------
 2 files changed, 28 insertions(+), 150 deletions(-)

diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index f3b34b5..ceb03ee 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -32,7 +32,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include "ioatdma.h"
-#include "ioatdma_io.h"
 #include "ioatdma_registers.h"
 #include "ioatdma_hw.h"
 
@@ -51,8 +50,8 @@ static int enumerate_dma_channels(struct
 	int i;
 	struct ioat_dma_chan *ioat_chan;
 
-	device->common.chancnt = ioatdma_read8(device, IOAT_CHANCNT_OFFSET);
-	xfercap_scale = ioatdma_read8(device, IOAT_XFERCAP_OFFSET);
+	device->common.chancnt = readb(device->reg_base + IOAT_CHANCNT_OFFSET);
+	xfercap_scale = readb(device->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
 
 	for (i = 0; i < device->common.chancnt; i++) {
@@ -123,7 +122,7 @@ static int ioat_dma_alloc_chan_resources
 	 * In-use bit automatically set by reading chanctrl
 	 * If 0, we got it, if 1, someone else did
 	 */
-	chanctrl = ioatdma_chan_read16(ioat_chan, IOAT_CHANCTRL_OFFSET);
+	chanctrl = readw(ioat_chan->reg_base + IOAT_CHANCTRL_OFFSET);
 	if (chanctrl & IOAT_CHANCTRL_CHANNEL_IN_USE)
 		return -EBUSY;
 
@@ -132,12 +131,12 @@ static int ioat_dma_alloc_chan_resources
 		IOAT_CHANCTRL_ERR_INT_EN |
 		IOAT_CHANCTRL_ANY_ERR_ABORT_EN |
 		IOAT_CHANCTRL_ERR_COMPLETION_EN;
-        ioatdma_chan_write16(ioat_chan, IOAT_CHANCTRL_OFFSET, chanctrl);
+        writew(chanctrl, ioat_chan->reg_base + IOAT_CHANCTRL_OFFSET);
 
-	chanerr = ioatdma_chan_read32(ioat_chan, IOAT_CHANERR_OFFSET);
+	chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 	if (chanerr) {
 		printk("IOAT: CHANERR = %x, clearing\n", chanerr);
-		ioatdma_chan_write32(ioat_chan, IOAT_CHANERR_OFFSET, chanerr);
+		writel(chanerr, ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 	}
 
 	/* Allocate descriptors */
@@ -161,10 +160,10 @@ static int ioat_dma_alloc_chan_resources
 		               &ioat_chan->completion_addr);
 	memset(ioat_chan->completion_virt, 0,
 	       sizeof(*ioat_chan->completion_virt));
-	ioatdma_chan_write32(ioat_chan, IOAT_CHANCMP_OFFSET_LOW,
-	               ((u64) ioat_chan->completion_addr) & 0x00000000FFFFFFFF);
-	ioatdma_chan_write32(ioat_chan, IOAT_CHANCMP_OFFSET_HIGH,
-	               ((u64) ioat_chan->completion_addr) >> 32);
+	writel(((u64) ioat_chan->completion_addr) & 0x00000000FFFFFFFF,
+	       ioat_chan->reg_base + IOAT_CHANCMP_OFFSET_LOW);
+	writel(((u64) ioat_chan->completion_addr) >> 32,
+	       ioat_chan->reg_base + IOAT_CHANCMP_OFFSET_HIGH);
 
 	ioat_start_null_desc(ioat_chan);
 	return i;
@@ -182,7 +181,7 @@ static void ioat_dma_free_chan_resources
 
 	ioat_dma_memcpy_cleanup(ioat_chan);
 
-	ioatdma_chan_write8(ioat_chan, IOAT_CHANCMD_OFFSET, IOAT_CHANCMD_RESET);
+	writeb(IOAT_CHANCMD_RESET, ioat_chan->reg_base + IOAT_CHANCMD_OFFSET);
 
 	spin_lock_bh(&ioat_chan->desc_lock);
 	list_for_each_entry_safe(desc, _desc, &ioat_chan->used_desc, node) {
@@ -210,9 +209,9 @@ static void ioat_dma_free_chan_resources
 	ioat_chan->last_completion = ioat_chan->completion_addr = 0;
 
 	/* Tell hw the chan is free */
-	chanctrl = ioatdma_chan_read16(ioat_chan, IOAT_CHANCTRL_OFFSET);
+	chanctrl = readw(ioat_chan->reg_base + IOAT_CHANCTRL_OFFSET);
 	chanctrl &= ~IOAT_CHANCTRL_CHANNEL_IN_USE;
-	ioatdma_chan_write16(ioat_chan, IOAT_CHANCTRL_OFFSET, chanctrl);
+	writew(chanctrl, ioat_chan->reg_base + IOAT_CHANCTRL_OFFSET);
 }
 
 /**
@@ -318,9 +317,8 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 	spin_unlock_bh(&ioat_chan->desc_lock);
 
 	if (append)
-		ioatdma_chan_write8(ioat_chan,
-		                    IOAT_CHANCMD_OFFSET,
-		                    IOAT_CHANCMD_APPEND);
+		writeb(IOAT_CHANCMD_APPEND,
+		       ioat_chan->reg_base + IOAT_CHANCMD_OFFSET);
 	return cookie;
 }
 
@@ -417,9 +415,8 @@ static void ioat_dma_memcpy_issue_pendin
 
 	if (ioat_chan->pending != 0) {
 		ioat_chan->pending = 0;
-		ioatdma_chan_write8(ioat_chan,
-		                    IOAT_CHANCMD_OFFSET,
-		                    IOAT_CHANCMD_APPEND);
+		writeb(IOAT_CHANCMD_APPEND,
+		       ioat_chan->reg_base + IOAT_CHANCMD_OFFSET);
 	}
 }
 
@@ -449,7 +446,7 @@ static void ioat_dma_memcpy_cleanup(stru
 	if ((chan->completion_virt->full & IOAT_CHANSTS_DMA_TRANSFER_STATUS) ==
 		IOAT_CHANSTS_DMA_TRANSFER_STATUS_HALTED) {
 		printk("IOAT: Channel halted, chanerr = %x\n",
-			ioatdma_chan_read32(chan, IOAT_CHANERR_OFFSET));
+			readl(chan->reg_base + IOAT_CHANERR_OFFSET));
 
 		/* TODO do something to salvage the situation */
 	}
@@ -569,21 +566,21 @@ static irqreturn_t ioat_do_interrupt(int
 	unsigned long attnstatus;
 	u8 intrctrl;
 
-	intrctrl = ioatdma_read8(instance, IOAT_INTRCTRL_OFFSET);
+	intrctrl = readb(instance->reg_base + IOAT_INTRCTRL_OFFSET);
 
 	if (!(intrctrl & IOAT_INTRCTRL_MASTER_INT_EN))
 		return IRQ_NONE;
 
 	if (!(intrctrl & IOAT_INTRCTRL_INT_STATUS)) {
-		ioatdma_write8(instance, IOAT_INTRCTRL_OFFSET, intrctrl);
+		writeb(intrctrl, instance->reg_base + IOAT_INTRCTRL_OFFSET);
 		return IRQ_NONE;
 	}
 
-	attnstatus = ioatdma_read32(instance, IOAT_ATTNSTATUS_OFFSET);
+	attnstatus = readl(instance->reg_base + IOAT_ATTNSTATUS_OFFSET);
 
 	printk(KERN_ERR "ioatdma error: interrupt! status %lx\n", attnstatus);
 
-	ioatdma_write8(instance, IOAT_INTRCTRL_OFFSET, intrctrl);
+	writeb(intrctrl, instance->reg_base + IOAT_INTRCTRL_OFFSET);
 	return IRQ_HANDLED;
 }
 
@@ -612,14 +609,13 @@ static void ioat_start_null_desc(struct 
 	spin_unlock_bh(&ioat_chan->desc_lock);
 
 #if (BITS_PER_LONG == 64)
-	ioatdma_chan_write64(ioat_chan, IOAT_CHAINADDR_OFFSET, desc->phys);
+	writeq(desc->phys, ioat_chan->reg_base + IOAT_CHAINADDR_OFFSET);
 #else
-	ioatdma_chan_write32(ioat_chan,
-	                     IOAT_CHAINADDR_OFFSET_LOW,
-	                     (u32) desc->phys);
-	ioatdma_chan_write32(ioat_chan, IOAT_CHAINADDR_OFFSET_HIGH, 0);
+	writel((u32) desc->phys,
+	       ioat_chan->reg_base + IOAT_CHAINADDR_OFFSET_LOW);
+	writel(0, ioat_chan->reg_base + IOAT_CHAINADDR_OFFSET_HIGH);
 #endif
-	ioatdma_chan_write8(ioat_chan, IOAT_CHANCMD_OFFSET, IOAT_CHANCMD_START);
+	writeb(IOAT_CHANCMD_START, ioat_chan->reg_base + IOAT_CHANCMD_OFFSET);
 }
 
 /*
@@ -748,7 +744,7 @@ static int __devinit ioat_probe(struct p
 
 	device->reg_base = reg_base;
 
-	ioatdma_write8(device, IOAT_INTRCTRL_OFFSET, IOAT_INTRCTRL_MASTER_INT_EN);
+	writeb(IOAT_INTRCTRL_MASTER_INT_EN, device->reg_base + IOAT_INTRCTRL_OFFSET);
 	pci_set_master(pdev);
 
 	INIT_LIST_HEAD(&device->common.channels);
diff --git a/drivers/dma/ioatdma_io.h b/drivers/dma/ioatdma_io.h
deleted file mode 100644
index c0b4bf6..0000000
--- a/drivers/dma/ioatdma_io.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called COPYING.
- */
-#ifndef IOATDMA_IO_H
-#define IOATDMA_IO_H
-
-#include <asm/io.h>
-
-/*
- * device and per-channel MMIO register read and write functions
- * this is a lot of anoying inline functions, but it's typesafe
- */
-
-static inline u8 ioatdma_read8(struct ioat_device *device,
-                               unsigned int offset)
-{
-	return readb(device->reg_base + offset);
-}
-
-static inline u16 ioatdma_read16(struct ioat_device *device,
-                                 unsigned int offset)
-{
-	return readw(device->reg_base + offset);
-}
-
-static inline u32 ioatdma_read32(struct ioat_device *device,
-                                 unsigned int offset)
-{
-	return readl(device->reg_base + offset);
-}
-
-static inline void ioatdma_write8(struct ioat_device *device,
-                                  unsigned int offset, u8 value)
-{
-	writeb(value, device->reg_base + offset);
-}
-
-static inline void ioatdma_write16(struct ioat_device *device,
-                                   unsigned int offset, u16 value)
-{
-	writew(value, device->reg_base + offset);
-}
-
-static inline void ioatdma_write32(struct ioat_device *device,
-                                   unsigned int offset, u32 value)
-{
-	writel(value, device->reg_base + offset);
-}
-
-static inline u8 ioatdma_chan_read8(struct ioat_dma_chan *chan,
-                                    unsigned int offset)
-{
-	return readb(chan->reg_base + offset);
-}
-
-static inline u16 ioatdma_chan_read16(struct ioat_dma_chan *chan,
-                                      unsigned int offset)
-{
-	return readw(chan->reg_base + offset);
-}
-
-static inline u32 ioatdma_chan_read32(struct ioat_dma_chan *chan,
-                                      unsigned int offset)
-{
-	return readl(chan->reg_base + offset);
-}
-
-static inline void ioatdma_chan_write8(struct ioat_dma_chan *chan,
-                                       unsigned int offset, u8 value)
-{
-	writeb(value, chan->reg_base + offset);
-}
-
-static inline void ioatdma_chan_write16(struct ioat_dma_chan *chan,
-                                        unsigned int offset, u16 value)
-{
-	writew(value, chan->reg_base + offset);
-}
-
-static inline void ioatdma_chan_write32(struct ioat_dma_chan *chan,
-                                        unsigned int offset, u32 value)
-{
-	writel(value, chan->reg_base + offset);
-}
-
-#if (BITS_PER_LONG == 64)
-static inline u64 ioatdma_chan_read64(struct ioat_dma_chan *chan,
-                                      unsigned int offset)
-{
-	return readq(chan->reg_base + offset);
-}
-
-static inline void ioatdma_chan_write64(struct ioat_dma_chan *chan,
-                                        unsigned int offset, u64 value)
-{
-	writeq(value, chan->reg_base + offset);
-}
-#endif
-
-#endif /* IOATDMA_IO_H */
-

