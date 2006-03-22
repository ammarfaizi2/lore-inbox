Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWCVTKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWCVTKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWCVTKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:10:53 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31231 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932354AbWCVTKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:10:52 -0500
Date: Wed, 22 Mar 2006 12:11:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rmk+serial@arm.linux.org.uk
Subject: [PATCH 2.6.16-rc6-mm2] serial: merge mpsc.h into mpsc.c
Message-ID: <20060322191124.GB22208@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges mpsc.h into mpsc.c because its the only file that
#include's mpsc.h.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 mpsc.c |  258 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mpsc.h |  290 -----------------------------------------------------------------
 2 files changed, 255 insertions(+), 293 deletions(-)
---

diff -Nurp linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.c linux-2.6.16-rc6-mm2-mpsc_merge/drivers/serial/mpsc.c
--- linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.c	2006-03-22 11:49:14.000000000 -0700
+++ linux-2.6.16-rc6-mm2-mpsc_merge/drivers/serial/mpsc.c	2006-03-22 10:26:36.000000000 -0700
@@ -1,6 +1,4 @@
 /*
- * drivers/serial/mpsc.c
- *
  * Generic driver for the MPSC (UART mode) on Marvell parts (e.g., GT64240,
  * GT64260, MV64340, MV64360, GT96100, ... ).
  *
@@ -52,9 +50,263 @@
  * 4) AFAICT, hardware flow control isn't supported by the controller --MAG.
  */
 
+#include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/mv643xx.h>
 #include <linux/platform_device.h>
 
-#include "mpsc.h"
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#define	MPSC_NUM_CTLRS		2
+
+/*
+ * Descriptors and buffers must be cache line aligned.
+ * Buffers lengths must be multiple of cache line size.
+ * Number of Tx & Rx descriptors must be powers of 2.
+ */
+#define	MPSC_RXR_ENTRIES	32
+#define	MPSC_RXRE_SIZE		dma_get_cache_alignment()
+#define	MPSC_RXR_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXRE_SIZE)
+#define	MPSC_RXBE_SIZE		dma_get_cache_alignment()
+#define	MPSC_RXB_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXBE_SIZE)
+
+#define	MPSC_TXR_ENTRIES	32
+#define	MPSC_TXRE_SIZE		dma_get_cache_alignment()
+#define	MPSC_TXR_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXRE_SIZE)
+#define	MPSC_TXBE_SIZE		dma_get_cache_alignment()
+#define	MPSC_TXB_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXBE_SIZE)
+
+#define	MPSC_DMA_ALLOC_SIZE	(MPSC_RXR_SIZE + MPSC_RXB_SIZE +	\
+				MPSC_TXR_SIZE + MPSC_TXB_SIZE +		\
+				dma_get_cache_alignment() /* for alignment */)
+
+/* Rx and Tx Ring entry descriptors -- assume entry size is <= cacheline size */
+struct mpsc_rx_desc {
+	u16 bufsize;
+	u16 bytecnt;
+	u32 cmdstat;
+	u32 link;
+	u32 buf_ptr;
+} __attribute((packed));
+
+struct mpsc_tx_desc {
+	u16 bytecnt;
+	u16 shadow;
+	u32 cmdstat;
+	u32 link;
+	u32 buf_ptr;
+} __attribute((packed));
+
+/*
+ * Some regs that have the erratum that you can't read them are are shared
+ * between the two MPSC controllers.  This struct contains those shared regs.
+ */
+struct mpsc_shared_regs {
+	phys_addr_t mpsc_routing_base_p;
+	phys_addr_t sdma_intr_base_p;
+
+	void __iomem *mpsc_routing_base;
+	void __iomem *sdma_intr_base;
+
+	u32 MPSC_MRR_m;
+	u32 MPSC_RCRR_m;
+	u32 MPSC_TCRR_m;
+	u32 SDMA_INTR_CAUSE_m;
+	u32 SDMA_INTR_MASK_m;
+};
+
+/* The main driver data structure */
+struct mpsc_port_info {
+	struct uart_port port;	/* Overlay uart_port structure */
+
+	/* Internal driver state for this ctlr */
+	u8 ready;
+	u8 rcv_data;
+	tcflag_t c_iflag;	/* save termios->c_iflag */
+	tcflag_t c_cflag;	/* save termios->c_cflag */
+
+	/* Info passed in from platform */
+	u8 mirror_regs;		/* Need to mirror regs? */
+	u8 cache_mgmt;		/* Need manual cache mgmt? */
+	u8 brg_can_tune;	/* BRG has baud tuning? */
+	u32 brg_clk_src;
+	u16 mpsc_max_idle;
+	int default_baud;
+	int default_bits;
+	int default_parity;
+	int default_flow;
+
+	/* Physical addresses of various blocks of registers (from platform) */
+	phys_addr_t mpsc_base_p;
+	phys_addr_t sdma_base_p;
+	phys_addr_t brg_base_p;
+
+	/* Virtual addresses of various blocks of registers (from platform) */
+	void __iomem *mpsc_base;
+	void __iomem *sdma_base;
+	void __iomem *brg_base;
+
+	/* Descriptor ring and buffer allocations */
+	void *dma_region;
+	dma_addr_t dma_region_p;
+
+	dma_addr_t rxr;		/* Rx descriptor ring */
+	dma_addr_t rxr_p;	/* Phys addr of rxr */
+	u8 *rxb;		/* Rx Ring I/O buf */
+	u8 *rxb_p;		/* Phys addr of rxb */
+	u32 rxr_posn;		/* First desc w/ Rx data */
+
+	dma_addr_t txr;		/* Tx descriptor ring */
+	dma_addr_t txr_p;	/* Phys addr of txr */
+	u8 *txb;		/* Tx Ring I/O buf */
+	u8 *txb_p;		/* Phys addr of txb */
+	int txr_head;		/* Where new data goes */
+	int txr_tail;		/* Where sent data comes off */
+
+	/* Mirrored values of regs we can't read (if 'mirror_regs' set) */
+	u32 MPSC_MPCR_m;
+	u32 MPSC_CHR_1_m;
+	u32 MPSC_CHR_2_m;
+	u32 MPSC_CHR_10_m;
+	u32 BRG_BCR_m;
+	struct mpsc_shared_regs *shared_regs;
+};
+
+/* Hooks to platform-specific code */
+int mpsc_platform_register_driver(void);
+void mpsc_platform_unregister_driver(void);
+
+/* Hooks back in to mpsc common to be called by platform-specific code */
+struct mpsc_port_info *mpsc_device_probe(int index);
+struct mpsc_port_info *mpsc_device_remove(int index);
+
+/* Main MPSC Configuration Register Offsets */
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
+/* Serial DMA Controller Interface Registers */
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
+/* Baud Rate Generator Interface Registers */
+#define	BRG_BCR				0x0000
+#define	BRG_BTR				0x0004
 
 /*
  * Define how this driver is known to the outside (we've been assigned a
diff -Nurp linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.h linux-2.6.16-rc6-mm2-mpsc_merge/drivers/serial/mpsc.h
--- linux-2.6.16-rc6-mm2-mpsc_sysrq/drivers/serial/mpsc.h	2006-03-22 11:50:28.000000000 -0700
+++ linux-2.6.16-rc6-mm2-mpsc_merge/drivers/serial/mpsc.h	1969-12-31 17:00:00.000000000 -0700
@@ -1,290 +0,0 @@
-/*
- * drivers/serial/mpsc.h
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef	__MPSC_H__
-#define	__MPSC_H__
-
-#include <linux/config.h>
-
-#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/sysrq.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/mv643xx.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#define	MPSC_NUM_CTLRS		2
-
-/*
- * Descriptors and buffers must be cache line aligned.
- * Buffers lengths must be multiple of cache line size.
- * Number of Tx & Rx descriptors must be powers of 2.
- */
-#define	MPSC_RXR_ENTRIES	32
-#define	MPSC_RXRE_SIZE		dma_get_cache_alignment()
-#define	MPSC_RXR_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXRE_SIZE)
-#define	MPSC_RXBE_SIZE		dma_get_cache_alignment()
-#define	MPSC_RXB_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXBE_SIZE)
-
-#define	MPSC_TXR_ENTRIES	32
-#define	MPSC_TXRE_SIZE		dma_get_cache_alignment()
-#define	MPSC_TXR_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXRE_SIZE)
-#define	MPSC_TXBE_SIZE		dma_get_cache_alignment()
-#define	MPSC_TXB_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXBE_SIZE)
-
-#define	MPSC_DMA_ALLOC_SIZE	(MPSC_RXR_SIZE + MPSC_RXB_SIZE +	\
-				MPSC_TXR_SIZE + MPSC_TXB_SIZE +		\
-				dma_get_cache_alignment() /* for alignment */)
-
-/* Rx and Tx Ring entry descriptors -- assume entry size is <= cacheline size */
-struct mpsc_rx_desc {
-	u16 bufsize;
-	u16 bytecnt;
-	u32 cmdstat;
-	u32 link;
-	u32 buf_ptr;
-} __attribute((packed));
-
-struct mpsc_tx_desc {
-	u16 bytecnt;
-	u16 shadow;
-	u32 cmdstat;
-	u32 link;
-	u32 buf_ptr;
-} __attribute((packed));
-
-/*
- * Some regs that have the erratum that you can't read them are are shared
- * between the two MPSC controllers.  This struct contains those shared regs.
- */
-struct mpsc_shared_regs {
-	phys_addr_t mpsc_routing_base_p;
-	phys_addr_t sdma_intr_base_p;
-
-	void __iomem *mpsc_routing_base;
-	void __iomem *sdma_intr_base;
-
-	u32 MPSC_MRR_m;
-	u32 MPSC_RCRR_m;
-	u32 MPSC_TCRR_m;
-	u32 SDMA_INTR_CAUSE_m;
-	u32 SDMA_INTR_MASK_m;
-};
-
-/* The main driver data structure */
-struct mpsc_port_info {
-	struct uart_port port;	/* Overlay uart_port structure */
-
-	/* Internal driver state for this ctlr */
-	u8 ready;
-	u8 rcv_data;
-	tcflag_t c_iflag;	/* save termios->c_iflag */
-	tcflag_t c_cflag;	/* save termios->c_cflag */
-
-	/* Info passed in from platform */
-	u8 mirror_regs;		/* Need to mirror regs? */
-	u8 cache_mgmt;		/* Need manual cache mgmt? */
-	u8 brg_can_tune;	/* BRG has baud tuning? */
-	u32 brg_clk_src;
-	u16 mpsc_max_idle;
-	int default_baud;
-	int default_bits;
-	int default_parity;
-	int default_flow;
-
-	/* Physical addresses of various blocks of registers (from platform) */
-	phys_addr_t mpsc_base_p;
-	phys_addr_t sdma_base_p;
-	phys_addr_t brg_base_p;
-
-	/* Virtual addresses of various blocks of registers (from platform) */
-	void __iomem *mpsc_base;
-	void __iomem *sdma_base;
-	void __iomem *brg_base;
-
-	/* Descriptor ring and buffer allocations */
-	void *dma_region;
-	dma_addr_t dma_region_p;
-
-	dma_addr_t rxr;		/* Rx descriptor ring */
-	dma_addr_t rxr_p;	/* Phys addr of rxr */
-	u8 *rxb;		/* Rx Ring I/O buf */
-	u8 *rxb_p;		/* Phys addr of rxb */
-	u32 rxr_posn;		/* First desc w/ Rx data */
-
-	dma_addr_t txr;		/* Tx descriptor ring */
-	dma_addr_t txr_p;	/* Phys addr of txr */
-	u8 *txb;		/* Tx Ring I/O buf */
-	u8 *txb_p;		/* Phys addr of txb */
-	int txr_head;		/* Where new data goes */
-	int txr_tail;		/* Where sent data comes off */
-
-	/* Mirrored values of regs we can't read (if 'mirror_regs' set) */
-	u32 MPSC_MPCR_m;
-	u32 MPSC_CHR_1_m;
-	u32 MPSC_CHR_2_m;
-	u32 MPSC_CHR_10_m;
-	u32 BRG_BCR_m;
-	struct mpsc_shared_regs *shared_regs;
-};
-
-/* Hooks to platform-specific code */
-int mpsc_platform_register_driver(void);
-void mpsc_platform_unregister_driver(void);
-
-/* Hooks back in to mpsc common to be called by platform-specific code */
-struct mpsc_port_info *mpsc_device_probe(int index);
-struct mpsc_port_info *mpsc_device_remove(int index);
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
-#define	MPSC_MPCR_FRZ			(1 << 9)
-#define	MPSC_MPCR_CL_5			0
-#define	MPSC_MPCR_CL_6			1
-#define	MPSC_MPCR_CL_7			2
-#define	MPSC_MPCR_CL_8			3
-#define	MPSC_MPCR_SBL_1			0
-#define	MPSC_MPCR_SBL_2			1
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
-#endif				/* __MPSC_H__ */
