Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWANWwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWANWwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWANWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:52:09 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:45269 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751352AbWANWwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:52:06 -0500
Date: Sun, 15 Jan 2006 00:51:57 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] sh: DMA updates
Message-ID: <20060114225157.GD4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the current SH DMA API somewhat to support a proper virtual
channel abstraction, and also works to represent this through the driver
model by giving each DMAC its own platform device.

There's also a few other minor changes to support a few new CPU subtypes,
and make TEI generation for the SH DMAC configurable.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/drivers/dma/dma-api.c   |   51 +++++++++++----
 arch/sh/drivers/dma/dma-g2.c    |    3 
 arch/sh/drivers/dma/dma-isa.c   |   20 ++---
 arch/sh/drivers/dma/dma-pvr2.c  |    3 
 arch/sh/drivers/dma/dma-sh.c    |  134 ++++++++++++++++++++++++----------------
 arch/sh/drivers/dma/dma-sh.h    |   44 +++++++++----
 arch/sh/drivers/dma/dma-sysfs.c |   31 +++++++--
 arch/sh/kernel/cpu/bus.c        |    2 
 include/asm-sh/bus-sh.h         |    1 
 include/asm-sh/cpu-sh3/dma.h    |   31 ++++++++-
 include/asm-sh/cpu-sh4/dma.h    |   52 ++++++++++++---
 include/asm-sh/dma-mapping.h    |   25 +++----
 include/asm-sh/dma.h            |   14 +++-
 13 files changed, 291 insertions(+), 120 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-api.c sh-2.6.15/arch/sh/drivers/dma/dma-api.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-api.c	2005-06-20 22:36:13.000000000 +0300
+++ sh-2.6.15/arch/sh/drivers/dma/dma-api.c	2006-01-04 16:58:04.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * SuperH-specific DMA management API
  *
- * Copyright (C) 2003, 2004  Paul Mundt
+ * Copyright (C) 2003, 2004, 2005  Paul Mundt
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <linux/platform_device.h>
 #include <asm/dma.h>
 
 DEFINE_SPINLOCK(dma_spin_lock);
@@ -55,16 +56,14 @@
 
 struct dma_info *get_dma_info(unsigned int chan)
 {
-	struct list_head *pos, *tmp;
+	struct dma_info *info;
 	unsigned int total = 0;
 
 	/*
 	 * Look for each DMAC's range to determine who the owner of
 	 * the channel is.
 	 */
-	list_for_each_safe(pos, tmp, &registered_dmac_list) {
-		struct dma_info *info = list_entry(pos, struct dma_info, list);
-
+	list_for_each_entry(info, &registered_dmac_list, list) {
 		total += info->nr_channels;
 		if (chan > total)
 			continue;
@@ -75,6 +74,20 @@
 	return NULL;
 }
 
+static unsigned int get_nr_channels(void)
+{
+	struct dma_info *info;
+	unsigned int nr = 0;
+
+	if (unlikely(list_empty(&registered_dmac_list)))
+		return nr;
+
+	list_for_each_entry(info, &registered_dmac_list, list)
+		nr += info->nr_channels;
+
+	return nr;
+}
+
 struct dma_channel *get_dma_channel(unsigned int chan)
 {
 	struct dma_info *info = get_dma_info(chan);
@@ -173,7 +186,7 @@
 static int dma_read_proc(char *buf, char **start, off_t off,
 			 int len, int *eof, void *data)
 {
-	struct list_head *pos, *tmp;
+	struct dma_info *info;
 	char *p = buf;
 
 	if (list_empty(&registered_dmac_list))
@@ -182,8 +195,7 @@
 	/*
 	 * Iterate over each registered DMAC
 	 */
-	list_for_each_safe(pos, tmp, &registered_dmac_list) {
-		struct dma_info *info = list_entry(pos, struct dma_info, list);
+	list_for_each_entry(info, &registered_dmac_list, list) {
 		int i;
 
 		/*
@@ -205,9 +217,9 @@
 #endif
 
 
-int __init register_dmac(struct dma_info *info)
+int register_dmac(struct dma_info *info)
 {
-	int i;
+	unsigned int total_channels, i;
 
 	INIT_LIST_HEAD(&info->list);
 
@@ -217,6 +229,11 @@
 
 	BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);
 
+	info->pdev = platform_device_register_simple((char *)info->name, -1,
+						     NULL, 0);
+	if (IS_ERR(info->pdev))
+		return PTR_ERR(info->pdev);
+
 	/*
 	 * Don't touch pre-configured channels
 	 */
@@ -232,10 +249,12 @@
 		memset(info->channels, 0, size);
 	}
 
+	total_channels = get_nr_channels();
 	for (i = 0; i < info->nr_channels; i++) {
 		struct dma_channel *chan = info->channels + i;
 
 		chan->chan = i;
+		chan->vchan = i + total_channels;
 
 		memcpy(chan->dev_id, "Unused", 7);
 
@@ -245,9 +264,7 @@
 		init_MUTEX(&chan->sem);
 		init_waitqueue_head(&chan->wait_queue);
 
-#ifdef CONFIG_SYSFS
-		dma_create_sysfs_files(chan);
-#endif
+		dma_create_sysfs_files(chan, info);
 	}
 
 	list_add(&info->list, &registered_dmac_list);
@@ -255,12 +272,18 @@
 	return 0;
 }
 
-void __exit unregister_dmac(struct dma_info *info)
+void unregister_dmac(struct dma_info *info)
 {
+	unsigned int i;
+
+	for (i = 0; i < info->nr_channels; i++)
+		dma_remove_sysfs_files(info->channels + i, info);
+
 	if (!(info->flags & DMAC_CHANNELS_CONFIGURED))
 		kfree(info->channels);
 
 	list_del(&info->list);
+	platform_device_unregister(info->pdev);
 }
 
 static int __init dma_api_init(void)
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-g2.c sh-2.6.15/arch/sh/drivers/dma/dma-g2.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-g2.c	2004-12-26 05:37:10.000000000 +0200
+++ sh-2.6.15/arch/sh/drivers/dma/dma-g2.c	2006-01-04 00:15:27.000000000 +0200
@@ -140,7 +140,7 @@
 };
 
 static struct dma_info g2_dma_info = {
-	.name		= "G2 DMA",
+	.name		= "g2_dmac",
 	.nr_channels	= 4,
 	.ops		= &g2_dma_ops,
 	.flags		= DMAC_CHANNELS_TEI_CAPABLE,
@@ -160,6 +160,7 @@
 static void __exit g2_dma_exit(void)
 {
 	free_irq(HW_EVENT_G2_DMA, 0);
+	unregister_dmac(&g2_dma_info);
 }
 
 subsys_initcall(g2_dma_init);
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-isa.c sh-2.6.15/arch/sh/drivers/dma/dma-isa.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-isa.c	2004-08-14 20:27:37.000000000 +0300
+++ sh-2.6.15/arch/sh/drivers/dma/dma-isa.c	2006-01-04 00:15:27.000000000 +0200
@@ -25,14 +25,14 @@
  * such, this code is meant for only the simplest of tasks (and shouldn't be
  * used in any new drivers at all).
  *
- * It should also be noted that various functions here are labelled as
- * being deprecated. This is due to the fact that the ops->xfer() method is
- * the preferred way of doing things (as well as just grabbing the spinlock
- * directly). As such, any users of this interface will be warned rather
- * loudly.
+ * NOTE: ops->xfer() is the preferred way of doing things. However, there
+ * are some users of the ISA DMA API that exist in common code that we
+ * don't necessarily want to go out of our way to break, so we still
+ * allow for some compatability at that level. Any new code is strongly
+ * advised to run far away from the ISA DMA API and use the SH DMA API
+ * directly.
  */
-
-unsigned long __deprecated claim_dma_lock(void)
+unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
 
@@ -42,19 +42,19 @@
 }
 EXPORT_SYMBOL(claim_dma_lock);
 
-void __deprecated release_dma_lock(unsigned long flags)
+void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 EXPORT_SYMBOL(release_dma_lock);
 
-void __deprecated disable_dma(unsigned int chan)
+void disable_dma(unsigned int chan)
 {
 	/* Nothing */
 }
 EXPORT_SYMBOL(disable_dma);
 
-void __deprecated enable_dma(unsigned int chan)
+void enable_dma(unsigned int chan)
 {
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = &info->channels[chan];
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-pvr2.c sh-2.6.15/arch/sh/drivers/dma/dma-pvr2.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-pvr2.c	2004-12-26 05:37:10.000000000 +0200
+++ sh-2.6.15/arch/sh/drivers/dma/dma-pvr2.c	2006-01-04 00:15:27.000000000 +0200
@@ -80,7 +80,7 @@
 };
 
 static struct dma_info pvr2_dma_info = {
-	.name		= "PowerVR 2 DMA",
+	.name		= "pvr2_dmac",
 	.nr_channels	= 1,
 	.ops		= &pvr2_dma_ops,
 	.flags		= DMAC_CHANNELS_TEI_CAPABLE,
@@ -98,6 +98,7 @@
 {
 	free_dma(PVR2_CASCADE_CHAN);
 	free_irq(HW_EVENT_PVR2_DMA, 0);
+	unregister_dmac(&pvr2_dma_info);
 }
 
 subsys_initcall(pvr2_dma_init);
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-sh.c sh-2.6.15/arch/sh/drivers/dma/dma-sh.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-sh.c	2004-08-14 20:27:37.000000000 +0300
+++ sh-2.6.15/arch/sh/drivers/dma/dma-sh.c	2006-01-07 21:46:31.691900491 +0200
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2000 Takashi YOSHII
  * Copyright (C) 2003, 2004 Paul Mundt
+ * Copyright (C) 2005 Andriy Skulysh
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -16,51 +17,28 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <asm/dreamcast/dma.h>
 #include <asm/signal.h>
 #include <asm/irq.h>
 #include <asm/dma.h>
 #include <asm/io.h>
 #include "dma-sh.h"
 
-/*
- * The SuperH DMAC supports a number of transmit sizes, we list them here,
- * with their respective values as they appear in the CHCR registers.
- *
- * Defaults to a 64-bit transfer size.
- */
-enum {
-	XMIT_SZ_64BIT,
-	XMIT_SZ_8BIT,
-	XMIT_SZ_16BIT,
-	XMIT_SZ_32BIT,
-	XMIT_SZ_256BIT,
-};
-
-/*
- * The DMA count is defined as the number of bytes to transfer.
- */
-static unsigned int ts_shift[] = {
-	[XMIT_SZ_64BIT]		= 3,
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_256BIT]	= 5,
-};
-
 static inline unsigned int get_dmte_irq(unsigned int chan)
 {
-	unsigned int irq;
+	unsigned int irq = 0;
 
 	/*
 	 * Normally we could just do DMTE0_IRQ + chan outright, though in the
 	 * case of the 7751R, the DMTE IRQs for channels > 4 start right above
 	 * the SCIF
 	 */
-
 	if (chan < 4) {
 		irq = DMTE0_IRQ + chan;
 	} else {
+#ifdef DMTE4_IRQ
 		irq = DMTE4_IRQ + chan - 4;
+#endif
 	}
 
 	return irq;
@@ -78,9 +56,7 @@
 {
 	u32 chcr = ctrl_inl(CHCR[chan->chan]);
 
-	chcr >>= 4;
-
-	return ts_shift[chcr & 0x0007];
+	return ts_shift[(chcr & CHCR_TS_MASK)>>CHCR_TS_SHIFT];
 }
 
 /*
@@ -109,8 +85,13 @@
 
 static int sh_dmac_request_dma(struct dma_channel *chan)
 {
+	char name[32];
+
+	snprintf(name, sizeof(name), "DMAC Transfer End (Channel %d)",
+		 chan->chan);
+
 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
-			   SA_INTERRUPT, "DMAC Transfer End", chan);
+			   SA_INTERRUPT, name, chan);
 }
 
 static void sh_dmac_free_dma(struct dma_channel *chan)
@@ -118,10 +99,18 @@
 	free_irq(get_dmte_irq(chan->chan), chan);
 }
 
-static void sh_dmac_configure_channel(struct dma_channel *chan, unsigned long chcr)
+static void
+sh_dmac_configure_channel(struct dma_channel *chan, unsigned long chcr)
 {
 	if (!chcr)
-		chcr = RS_DUAL;
+		chcr = RS_DUAL | CHCR_IE;
+
+	if (chcr & CHCR_IE) {
+		chcr &= ~CHCR_IE;
+		chan->flags |= DMA_TEI_CAPABLE;
+	} else {
+		chan->flags &= ~DMA_TEI_CAPABLE;
+	}
 
 	ctrl_outl(chcr, CHCR[chan->chan]);
 
@@ -130,22 +119,32 @@
 
 static void sh_dmac_enable_dma(struct dma_channel *chan)
 {
-	int irq = get_dmte_irq(chan->chan);
+	int irq;
 	u32 chcr;
 
 	chcr = ctrl_inl(CHCR[chan->chan]);
-	chcr |= CHCR_DE | CHCR_IE;
+	chcr |= CHCR_DE;
+
+	if (chan->flags & DMA_TEI_CAPABLE)
+		chcr |= CHCR_IE;
+
 	ctrl_outl(chcr, CHCR[chan->chan]);
 
-	enable_irq(irq);
+	if (chan->flags & DMA_TEI_CAPABLE) {
+		irq = get_dmte_irq(chan->chan);
+		enable_irq(irq);
+	}
 }
 
 static void sh_dmac_disable_dma(struct dma_channel *chan)
 {
-	int irq = get_dmte_irq(chan->chan);
+	int irq;
 	u32 chcr;
 
-	disable_irq(irq);
+	if (chan->flags & DMA_TEI_CAPABLE) {
+		irq = get_dmte_irq(chan->chan);
+		disable_irq(irq);
+	}
 
 	chcr = ctrl_inl(CHCR[chan->chan]);
 	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
@@ -158,7 +157,7 @@
 	 * If we haven't pre-configured the channel with special flags, use
 	 * the defaults.
 	 */
-	if (!(chan->flags & DMA_CONFIGURED))
+	if (unlikely(!(chan->flags & DMA_CONFIGURED)))
 		sh_dmac_configure_channel(chan, 0);
 
 	sh_dmac_disable_dma(chan);
@@ -178,9 +177,11 @@
 	 * cascading to the PVR2 DMAC. In this case, we still need to write
 	 * SAR and DAR, regardless of value, in order for cascading to work.
 	 */
-	if (chan->sar || (mach_is_dreamcast() && chan->chan == 2))
+	if (chan->sar || (mach_is_dreamcast() &&
+			  chan->chan == PVR2_CASCADE_CHAN))
 		ctrl_outl(chan->sar, SAR[chan->chan]);
-	if (chan->dar || (mach_is_dreamcast() && chan->chan == 2))
+	if (chan->dar || (mach_is_dreamcast() &&
+			  chan->chan == PVR2_CASCADE_CHAN))
 		ctrl_outl(chan->dar, DAR[chan->chan]);
 
 	ctrl_outl(chan->count >> calc_xmit_shift(chan), DMATCR[chan->chan]);
@@ -198,17 +199,38 @@
 	return ctrl_inl(DMATCR[chan->chan]) << calc_xmit_shift(chan);
 }
 
-#if defined(CONFIG_CPU_SH4)
-static irqreturn_t dma_err(int irq, void *dev_id, struct pt_regs *regs)
+#ifdef CONFIG_CPU_SUBTYPE_SH7780
+#define dmaor_read_reg()	ctrl_inw(DMAOR)
+#define dmaor_write_reg(data)	ctrl_outw(data, DMAOR)
+#else
+#define dmaor_read_reg()	ctrl_inl(DMAOR)
+#define dmaor_write_reg(data)	ctrl_outl(data, DMAOR)
+#endif
+
+static inline int dmaor_reset(void)
 {
-	unsigned long dmaor = ctrl_inl(DMAOR);
+	unsigned long dmaor = dmaor_read_reg();
+
+	/* Try to clear the error flags first, incase they are set */
+	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
+	dmaor_write_reg(dmaor);
 
-	printk("DMAE: DMAOR=%lx\n", dmaor);
+	dmaor |= DMAOR_INIT;
+	dmaor_write_reg(dmaor);
 
-	ctrl_outl(ctrl_inl(DMAOR)&~DMAOR_NMIF, DMAOR);
-	ctrl_outl(ctrl_inl(DMAOR)&~DMAOR_AE, DMAOR);
-	ctrl_outl(ctrl_inl(DMAOR)|DMAOR_DME, DMAOR);
+	/* See if we got an error again */
+	if ((dmaor_read_reg() & (DMAOR_AE | DMAOR_NMIF))) {
+		printk(KERN_ERR "dma-sh: Can't initialize DMAOR.\n");
+		return -EINVAL;
+	}
 
+	return 0;
+}
+
+#if defined(CONFIG_CPU_SH4)
+static irqreturn_t dma_err(int irq, void *dev_id, struct pt_regs *regs)
+{
+	dmaor_reset();
 	disable_irq(irq);
 
 	return IRQ_HANDLED;
@@ -224,8 +246,8 @@
 };
 
 static struct dma_info sh_dmac_info = {
-	.name		= "SuperH DMAC",
-	.nr_channels	= 4,
+	.name		= "sh_dmac",
+	.nr_channels	= CONFIG_NR_ONCHIP_DMA_CHANNELS,
 	.ops		= &sh_dmac_ops,
 	.flags		= DMAC_CHANNELS_TEI_CAPABLE,
 };
@@ -248,7 +270,13 @@
 		make_ipr_irq(irq, DMA_IPR_ADDR, DMA_IPR_POS, DMA_PRIORITY);
 	}
 
-	ctrl_outl(0x8000 | DMAOR_DME, DMAOR);
+	/*
+	 * Initialize DMAOR, and clean up any error flags that may have
+	 * been set.
+	 */
+	i = dmaor_reset();
+	if (i < 0)
+		return i;
 
 	return register_dmac(info);
 }
@@ -258,10 +286,12 @@
 #ifdef CONFIG_CPU_SH4
 	free_irq(DMAE_IRQ, 0);
 #endif
+	unregister_dmac(&sh_dmac_info);
 }
 
 subsys_initcall(sh_dmac_init);
 module_exit(sh_dmac_exit);
 
+MODULE_AUTHOR("Takashi YOSHII, Paul Mundt, Andriy Skulysh");
+MODULE_DESCRIPTION("SuperH On-Chip DMAC Support");
 MODULE_LICENSE("GPL");
-
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-sh.h sh-2.6.15/arch/sh/drivers/dma/dma-sh.h
--- linux-2.6.15/arch/sh/drivers/dma/dma-sh.h	2004-07-15 22:21:14.000000000 +0300
+++ sh-2.6.15/arch/sh/drivers/dma/dma-sh.h	2006-01-04 00:15:27.000000000 +0200
@@ -11,6 +11,8 @@
 #ifndef __DMA_SH_H
 #define __DMA_SH_H
 
+#include <asm/cpu/dma.h>
+
 /* Definitions for the SuperH DMAC */
 #define REQ_L	0x00000000
 #define REQ_E	0x00080000
@@ -26,27 +28,47 @@
 #define SM_DEC	0x00002000
 #define RS_IN	0x00000200
 #define RS_OUT	0x00000300
-#define TM_BURST 0x0000080
-#define TS_8	0x00000010
-#define TS_16	0x00000020
-#define TS_32	0x00000030
-#define TS_64	0x00000000
 #define TS_BLK	0x00000040
 #define CHCR_DE 0x00000001
 #define CHCR_TE 0x00000002
 #define CHCR_IE 0x00000004
 
-/* Define the default configuration for dual address memory-memory transfer.
- * The 0x400 value represents auto-request, external->external.
- */
-#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
-
-#define DMAOR_COD	0x00000008
+/* DMAOR definitions */
 #define DMAOR_AE	0x00000004
 #define DMAOR_NMIF	0x00000002
 #define DMAOR_DME	0x00000001
 
+/*
+ * Define the default configuration for dual address memory-memory transfer.
+ * The 0x400 value represents auto-request, external->external.
+ */
+#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
+
 #define MAX_DMAC_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)
 
+/*
+ * Subtypes that have fewer channels than this simply need to change
+ * CONFIG_NR_ONCHIP_DMA_CHANNELS. Likewise, subtypes with a larger number
+ * of channels should expand on this.
+ *
+ * For most subtypes we can easily figure these values out with some
+ * basic calculation, unfortunately on other subtypes these are more
+ * scattered, so we just leave it unrolled for simplicity.
+ */
+#define SAR	((unsigned long[]){SH_DMAC_BASE + 0x00, SH_DMAC_BASE + 0x10, \
+				   SH_DMAC_BASE + 0x20, SH_DMAC_BASE + 0x30, \
+				   SH_DMAC_BASE + 0x50, SH_DMAC_BASE + 0x60})
+#define DAR	((unsigned long[]){SH_DMAC_BASE + 0x04, SH_DMAC_BASE + 0x14, \
+				   SH_DMAC_BASE + 0x24, SH_DMAC_BASE + 0x34, \
+				   SH_DMAC_BASE + 0x54, SH_DMAC_BASE + 0x64})
+#define DMATCR	((unsigned long[]){SH_DMAC_BASE + 0x08, SH_DMAC_BASE + 0x18, \
+				   SH_DMAC_BASE + 0x28, SH_DMAC_BASE + 0x38, \
+				   SH_DMAC_BASE + 0x58, SH_DMAC_BASE + 0x68})
+#define CHCR	((unsigned long[]){SH_DMAC_BASE + 0x0c, SH_DMAC_BASE + 0x1c, \
+				   SH_DMAC_BASE + 0x2c, SH_DMAC_BASE + 0x3c, \
+				   SH_DMAC_BASE + 0x5c, SH_DMAC_BASE + 0x6c})
+
+#define DMAOR	(SH_DMAC_BASE + 0x40)
+
 #endif /* __DMA_SH_H */
 
diff -urN -X exclude linux-2.6.15/arch/sh/drivers/dma/dma-sysfs.c sh-2.6.15/arch/sh/drivers/dma/dma-sysfs.c
--- linux-2.6.15/arch/sh/drivers/dma/dma-sysfs.c	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/drivers/dma/dma-sysfs.c	2006-01-04 16:58:04.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * sysfs interface for SH DMA API
  *
- * Copyright (C) 2004  Paul Mundt
+ * Copyright (C) 2004, 2005  Paul Mundt
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -12,7 +12,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sysdev.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <asm/dma.h>
 
@@ -77,7 +79,7 @@
 	unsigned long config;
 
 	config = simple_strtoul(buf, NULL, 0);
-	dma_configure_channel(channel->chan, config);
+	dma_configure_channel(channel->vchan, config);
 
 	return count;
 }
@@ -111,12 +113,13 @@
 dma_ro_attr(count, "0x%08x\n");
 dma_ro_attr(flags, "0x%08lx\n");
 
-int __init dma_create_sysfs_files(struct dma_channel *chan)
+int dma_create_sysfs_files(struct dma_channel *chan, struct dma_info *info)
 {
 	struct sys_device *dev = &chan->dev;
+	char name[16];
 	int ret;
 
-	dev->id  = chan->chan;
+	dev->id  = chan->vchan;
 	dev->cls = &dma_sysclass;
 
 	ret = sysdev_register(dev);
@@ -129,6 +132,24 @@
 	sysdev_create_file(dev, &attr_flags);
 	sysdev_create_file(dev, &attr_config);
 
-	return 0;
+	snprintf(name, sizeof(name), "dma%d", chan->chan);
+	return sysfs_create_link(&info->pdev->dev.kobj, &dev->kobj, name);
+}
+
+void dma_remove_sysfs_files(struct dma_channel *chan, struct dma_info *info)
+{
+	struct sys_device *dev = &chan->dev;
+	char name[16];
+
+	sysdev_remove_file(dev, &attr_dev_id);
+	sysdev_remove_file(dev, &attr_count);
+	sysdev_remove_file(dev, &attr_mode);
+	sysdev_remove_file(dev, &attr_flags);
+	sysdev_remove_file(dev, &attr_config);
+
+	snprintf(name, sizeof(name), "dma%d", chan->chan);
+	sysfs_remove_link(&info->pdev->dev.kobj, name);
+
+	sysdev_unregister(dev);
 }
 
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/bus.c sh-2.6.15/arch/sh/kernel/cpu/bus.c
--- linux-2.6.15/arch/sh/kernel/cpu/bus.c	2005-06-20 22:45:19.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/cpu/bus.c	2006-01-04 00:15:27.000000000 +0200
@@ -107,6 +107,8 @@
 	/* This is needed for USB OHCI to work */
 	if (dev->dma_mask)
 		dev->dev.dma_mask = dev->dma_mask;
+	if (dev->coherent_dma_mask)
+		dev->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
 	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%s%u",
 		 dev->name, dev->dev_id);

diff -urN -X exclude linux-2.6.15/include/asm-sh/bus-sh.h sh-2.6.15/include/asm-sh/bus-sh.h
--- linux-2.6.15/include/asm-sh/bus-sh.h	2005-06-20 22:46:02.000000000 +0300
+++ sh-2.6.15/include/asm-sh/bus-sh.h	2006-01-04 00:15:29.000000000 +0200
@@ -21,6 +21,7 @@
 	void		*mapbase;
 	unsigned int	irq[6];
 	u64		*dma_mask;
+	u64		coherent_dma_mask;
 };
 
 #define to_sh_dev(d)	container_of((d), struct sh_dev, dev)

diff -urN -X exclude linux-2.6.15/include/asm-sh/cpu-sh3/dma.h sh-2.6.15/include/asm-sh/cpu-sh3/dma.h
--- linux-2.6.15/include/asm-sh/cpu-sh3/dma.h	2004-07-15 22:22:27.000000000 +0300
+++ sh-2.6.15/include/asm-sh/cpu-sh3/dma.h	2006-01-04 16:58:04.000000000 +0200
@@ -3,5 +3,34 @@
 
 #define SH_DMAC_BASE	0xa4000020
 
-#endif /* __ASM_CPU_SH3_DMA_H */
+/* Definitions for the SuperH DMAC */
+#define TM_BURST	0x00000020
+#define TS_8		0x00000000
+#define TS_16		0x00000008
+#define TS_32		0x00000010
+#define TS_128		0x00000018
+
+#define CHCR_TS_MASK	0x18
+#define CHCR_TS_SHIFT	3
+
+#define DMAOR_INIT	DMAOR_DME
 
+/*
+ * The SuperH DMAC supports a number of transmit sizes, we list them here,
+ * with their respective values as they appear in the CHCR registers.
+ */
+enum {
+	XMIT_SZ_8BIT,
+	XMIT_SZ_16BIT,
+	XMIT_SZ_32BIT,
+	XMIT_SZ_128BIT,
+};
+
+static unsigned int ts_shift[] __attribute__ ((used)) = {
+	[XMIT_SZ_8BIT]		= 0,
+	[XMIT_SZ_16BIT]		= 1,
+	[XMIT_SZ_32BIT]		= 2,
+	[XMIT_SZ_128BIT]	= 4,
+};
+
+#endif /* __ASM_CPU_SH3_DMA_H */


diff -urN -X exclude linux-2.6.15/include/asm-sh/cpu-sh4/dma.h sh-2.6.15/include/asm-sh/cpu-sh4/dma.h
--- linux-2.6.15/include/asm-sh/cpu-sh4/dma.h	2004-08-14 20:28:00.000000000 +0300
+++ sh-2.6.15/include/asm-sh/cpu-sh4/dma.h	2006-01-04 00:15:29.000000000 +0200
@@ -1,17 +1,49 @@
 #ifndef __ASM_CPU_SH4_DMA_H
 #define __ASM_CPU_SH4_DMA_H
 
+#ifdef CONFIG_CPU_SH4A
+#define SH_DMAC_BASE	0xfc808020
+#else
 #define SH_DMAC_BASE	0xffa00000
+#endif
 
-#define SAR	((unsigned long[]){SH_DMAC_BASE + 0x00, SH_DMAC_BASE + 0x10, \
-				   SH_DMAC_BASE + 0x20, SH_DMAC_BASE + 0x30})
-#define DAR	((unsigned long[]){SH_DMAC_BASE + 0x04, SH_DMAC_BASE + 0x14, \
-				   SH_DMAC_BASE + 0x24, SH_DMAC_BASE + 0x34})
-#define DMATCR	((unsigned long[]){SH_DMAC_BASE + 0x08, SH_DMAC_BASE + 0x18, \
-				   SH_DMAC_BASE + 0x28, SH_DMAC_BASE + 0x38})
-#define CHCR	((unsigned long[]){SH_DMAC_BASE + 0x0c, SH_DMAC_BASE + 0x1c, \
-				   SH_DMAC_BASE + 0x2c, SH_DMAC_BASE + 0x3c})
-#define DMAOR	(SH_DMAC_BASE + 0x40)
+/* Definitions for the SuperH DMAC */
+#define TM_BURST	0x0000080
+#define TS_8		0x00000010
+#define TS_16		0x00000020
+#define TS_32		0x00000030
+#define TS_64		0x00000000
 
-#endif /* __ASM_CPU_SH4_DMA_H */
+#define CHCR_TS_MASK	0x30
+#define CHCR_TS_SHIFT	4
+
+#define DMAOR_COD	0x00000008
+
+#define DMAOR_INIT	( 0x8000 | DMAOR_DME )
 
+/*
+ * The SuperH DMAC supports a number of transmit sizes, we list them here,
+ * with their respective values as they appear in the CHCR registers.
+ *
+ * Defaults to a 64-bit transfer size.
+ */
+enum {
+	XMIT_SZ_64BIT,
+	XMIT_SZ_8BIT,
+	XMIT_SZ_16BIT,
+	XMIT_SZ_32BIT,
+	XMIT_SZ_256BIT,
+};
+
+/*
+ * The DMA count is defined as the number of bytes to transfer.
+ */
+static unsigned int ts_shift[] __attribute__ ((used)) = {
+	[XMIT_SZ_64BIT]		= 3,
+	[XMIT_SZ_8BIT]		= 0,
+	[XMIT_SZ_16BIT]		= 1,
+	[XMIT_SZ_32BIT]		= 2,
+	[XMIT_SZ_256BIT]	= 5,
+};
+
+#endif /* __ASM_CPU_SH4_DMA_H */

diff -urN -X exclude linux-2.6.15/include/asm-sh/dma-mapping.h sh-2.6.15/include/asm-sh/dma-mapping.h
--- linux-2.6.15/include/asm-sh/dma-mapping.h	2006-01-04 14:20:02.000000000 +0200
+++ sh-2.6.15/include/asm-sh/dma-mapping.h	2006-01-04 14:29:32.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
+#include <asm/cacheflush.h>
 #include <asm/io.h>
 
 extern struct bus_type pci_bus_type;
@@ -141,24 +142,24 @@
 	}
 }
 
-static inline void dma_sync_single_for_cpu(struct device *dev,
-					   dma_addr_t dma_handle, size_t size,
-					   enum dma_data_direction dir)
+static void dma_sync_single_for_cpu(struct device *dev,
+				    dma_addr_t dma_handle, size_t size,
+				    enum dma_data_direction dir)
 	__attribute__ ((alias("dma_sync_single")));
 
-static inline void dma_sync_single_for_device(struct device *dev,
-					   dma_addr_t dma_handle, size_t size,
-					   enum dma_data_direction dir)
+static void dma_sync_single_for_device(struct device *dev,
+				       dma_addr_t dma_handle, size_t size,
+				       enum dma_data_direction dir)
 	__attribute__ ((alias("dma_sync_single")));
 
-static inline void dma_sync_sg_for_cpu(struct device *dev,
-				       struct scatterlist *sg, int nelems,
-				       enum dma_data_direction dir)
+static void dma_sync_sg_for_cpu(struct device *dev,
+				struct scatterlist *sg, int nelems,
+				enum dma_data_direction dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
-static inline void dma_sync_sg_for_device(struct device *dev,
-				       struct scatterlist *sg, int nelems,
-				       enum dma_data_direction dir)
+static void dma_sync_sg_for_device(struct device *dev,
+				   struct scatterlist *sg, int nelems,
+				   enum dma_data_direction dir)
 	__attribute__ ((alias("dma_sync_sg")));
 
 static inline int dma_get_cache_alignment(void)
diff -urN -X exclude linux-2.6.15/include/asm-sh/dma.h sh-2.6.15/include/asm-sh/dma.h
--- linux-2.6.15/include/asm-sh/dma.h	2004-12-26 05:37:56.000000000 +0200
+++ sh-2.6.15/include/asm-sh/dma.h	2006-01-04 00:15:30.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/sysdev.h>
+#include <linux/device.h>
 #include <asm/cpu/dma.h>
 #include <asm/semaphore.h>
 
@@ -54,8 +55,8 @@
  * DMA channel capabilities / flags
  */
 enum {
-	DMA_CONFIGURED			= 0x00,
 	DMA_TEI_CAPABLE			= 0x01,
+	DMA_CONFIGURED			= 0x02,
 };
 
 extern spinlock_t dma_spin_lock;
@@ -74,7 +75,8 @@
 struct dma_channel {
 	char dev_id[16];
 
-	unsigned int chan;
+	unsigned int chan;		/* Physical channel number */
+	unsigned int vchan;		/* Virtual channel number */
 	unsigned int mode;
 	unsigned int count;
 
@@ -91,6 +93,8 @@
 };
 
 struct dma_info {
+	struct platform_device *pdev;
+
 	const char *name;
 	unsigned int nr_channels;
 	unsigned long flags;
@@ -130,7 +134,11 @@
 
 #ifdef CONFIG_SYSFS
 /* arch/sh/drivers/dma/dma-sysfs.c */
-extern int dma_create_sysfs_files(struct dma_channel *);
+extern int dma_create_sysfs_files(struct dma_channel *, struct dma_info *);
+extern void dma_remove_sysfs_files(struct dma_channel *, struct dma_info *);
+#else
+#define dma_create_sysfs_file(channel, info)		do { } while (0)
+#define dma_remove_sysfs_file(channel, info)		do { } while (0)
 #endif
 
 #ifdef CONFIG_PCI
