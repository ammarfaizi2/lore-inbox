Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUHFXdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUHFXdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUHFXdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:33:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60924 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S266149AbUHFX0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:26:36 -0400
Date: Fri, 6 Aug 2004 16:26:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][PPC32] Add PPC4xx DMA engine library
Message-ID: <20040806162630.A1597@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a cleaned up version of the PPC4xx DMA engine library. Converted
to new DCR access method and DMA API.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig	Fri Aug  6 16:24:56 2004
+++ b/arch/ppc/platforms/4xx/Kconfig	Fri Aug  6 16:24:56 2004
@@ -175,6 +175,15 @@
 	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
+config PPC4xx_DMA
+	bool "PPC4xx DMA controller support"
+	depends on 4xx
+
+config PPC4xx_EDMA
+	bool
+	depends on !STB03xxx && PPC4xx_DMA
+	default y
+
 config PM
 	bool "Power Management support (EXPERIMENTAL)"
 	depends on 4xx && EXPERIMENTAL
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	Fri Aug  6 16:24:56 2004
+++ b/arch/ppc/syslib/Makefile	Fri Aug  6 16:24:56 2004
@@ -25,7 +25,8 @@
 obj-$(CONFIG_4xx)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
 obj-$(CONFIG_GEN_RTC)		+= todc_time.o
-obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
+obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
+obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 ifeq ($(CONFIG_40x),y)
 obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
diff -Nru a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
--- a/arch/ppc/syslib/ppc4xx_dma.c	Fri Aug  6 16:24:56 2004
+++ b/arch/ppc/syslib/ppc4xx_dma.c	Fri Aug  6 16:24:56 2004
@@ -1,42 +1,427 @@
 /*
- * Author: Pete Popov <ppopov@mvista.com> or source@mvista.com
+ * arch/ppc/kernel/ppc4xx_dma.c
  *
- * arch/ppc/kernel/ppc405_dma.c
+ * IBM PPC4xx DMA engine core library
  *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * Copyright 2000-2004 MontaVista Software Inc.
  *
- * IBM 405 DMA Controller Functions
+ * Cleaned up and converted to new DCR access
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Original code by Armin Kuster <akuster@mvista.com>
+ * and Pete Popov <ppopov@mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <asm/system.h>
-#include <asm/io.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
-#include <asm/ppc405_dma.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/ppc4xx_dma.h>
+
+ppc_dma_ch_t dma_channels[MAX_PPC4xx_DMA_CHANNELS];
+
+int
+ppc4xx_get_dma_status(void)
+{
+	return (mfdcr(DCRN_DMASR));
+}
+
+void
+ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr)
+{
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("set_src_addr: bad channel: %d\n", dmanr);
+		return;
+	}
+
+#ifdef PPC4xx_DMA64BIT
+	mtdcr(DCRN_DMASAH0 + dmanr*2, (u32)(src_addr >> 32));
+#else
+	mtdcr(DCRN_DMASA0 + dmanr*2, (u32)src_addr);
+#endif
+}
+
+void
+ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr)
+{
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("set_dst_addr: bad channel: %d\n", dmanr);
+		return;
+	}
+
+#ifdef PPC4xx_DMA64BIT
+	mtdcr(DCRN_DMADAH0 + dmanr*2, (u32)(dst_addr >> 32));
+#else
+	mtdcr(DCRN_DMADA0 + dmanr*2, (u32)dst_addr);
+#endif
+}
+
+void
+ppc4xx_enable_dma(unsigned int dmanr)
+{
+	unsigned int control;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+	unsigned int status_bits[] = { DMA_CS0 | DMA_TS0 | DMA_CH0_ERR,
+				       DMA_CS1 | DMA_TS1 | DMA_CH1_ERR,
+				       DMA_CS2 | DMA_TS2 | DMA_CH2_ERR,
+				       DMA_CS3 | DMA_TS3 | DMA_CH3_ERR};
+
+	if (p_dma_ch->in_use) {
+		printk("enable_dma: channel %d in use\n", dmanr);
+		return;
+	}
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("enable_dma: bad channel: %d\n", dmanr);
+		return;
+	}
+
+	if (p_dma_ch->mode == DMA_MODE_READ) {
+		/* peripheral to memory */
+		ppc4xx_set_src_addr(dmanr, 0);
+		ppc4xx_set_dst_addr(dmanr, p_dma_ch->addr);
+	} else if (p_dma_ch->mode == DMA_MODE_WRITE) {
+		/* memory to peripheral */
+		ppc4xx_set_src_addr(dmanr, p_dma_ch->addr);
+		ppc4xx_set_dst_addr(dmanr, 0);
+	}
+
+	/* for other xfer modes, the addresses are already set */
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+
+	control &= ~(DMA_TM_MASK | DMA_TD);	/* clear all mode bits */
+	if (p_dma_ch->mode == DMA_MODE_MM) {
+		/* software initiated memory to memory */
+		control |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
+	}
+
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
+
+	/*
+	 * Clear the CS, TS, RI bits for the channel from DMASR.  This
+	 * has been observed to happen correctly only after the mode and
+	 * ETD/DCE bits in DMACRx are set above.  Must do this before
+	 * enabling the channel.
+	 */
+
+	mtdcr(DCRN_DMASR, status_bits[dmanr]);
+
+	/*
+	 * For device-paced transfers, Terminal Count Enable apparently
+	 * must be on, and this must be turned on after the mode, etc.
+	 * bits are cleared above (at least on Redwood-6).
+	 */
+
+	if ((p_dma_ch->mode == DMA_MODE_MM_DEVATDST) ||
+	    (p_dma_ch->mode == DMA_MODE_MM_DEVATSRC))
+		control |= DMA_TCE_ENABLE;
+
+	/*
+	 * Now enable the channel.
+	 */
+
+	control |= (p_dma_ch->mode | DMA_CE_ENABLE);
+
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
+
+	p_dma_ch->in_use = 1;
+}
+
+void
+ppc4xx_disable_dma(unsigned int dmanr)
+{
+	unsigned int control;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (!p_dma_ch->in_use) {
+		printk("disable_dma: channel %d not in use\n", dmanr);
+		return;
+	}
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("disable_dma: bad channel: %d\n", dmanr);
+		return;
+	}
+
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+	control &= ~DMA_CE_ENABLE;
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
+
+	p_dma_ch->in_use = 0;
+}
+
+/*
+ * Sets the dma mode for single DMA transfers only.
+ * For scatter/gather transfers, the mode is passed to the
+ * alloc_dma_handle() function as one of the parameters.
+ *
+ * The mode is simply saved and used later.  This allows
+ * the driver to call set_dma_mode() and set_dma_addr() in
+ * any order.
+ *
+ * Valid mode values are:
+ *
+ * DMA_MODE_READ          peripheral to memory
+ * DMA_MODE_WRITE         memory to peripheral
+ * DMA_MODE_MM            memory to memory
+ * DMA_MODE_MM_DEVATSRC   device-paced memory to memory, device at src
+ * DMA_MODE_MM_DEVATDST   device-paced memory to memory, device at dst
+ */
+int
+ppc4xx_set_dma_mode(unsigned int dmanr, unsigned int mode)
+{
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("set_dma_mode: bad channel 0x%x\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	p_dma_ch->mode = mode;
+
+	return DMA_STATUS_GOOD;
+}
 
+/*
+ * Sets the DMA Count register. Note that 'count' is in bytes.
+ * However, the DMA Count register counts the number of "transfers",
+ * where each transfer is equal to the bus width.  Thus, count
+ * MUST be a multiple of the bus width.
+ */
+void
+ppc4xx_set_dma_count(unsigned int dmanr, unsigned int count)
+{
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+#ifdef DEBUG_4xxDMA
+	{
+		int error = 0;
+		switch (p_dma_ch->pwidth) {
+		case PW_8:
+			break;
+		case PW_16:
+			if (count & 0x1)
+				error = 1;
+			break;
+		case PW_32:
+			if (count & 0x3)
+				error = 1;
+			break;
+		case PW_64:
+			if (count & 0x7)
+				error = 1;
+			break;
+		default:
+			printk("set_dma_count: invalid bus width: 0x%x\n",
+			       p_dma_ch->pwidth);
+			return;
+		}
+		if (error)
+			printk
+			    ("Warning: set_dma_count count 0x%x bus width %d\n",
+			     count, p_dma_ch->pwidth);
+	}
+#endif
+
+	count = count >> p_dma_ch->shift;
+
+	mtdcr(DCRN_DMACT0 + (dmanr * 0x8), count);
+}
 
 /*
- * Function prototypes
+ *   Returns the number of bytes left to be transfered.
+ *   After a DMA transfer, this should return zero.
+ *   Reading this while a DMA transfer is still in progress will return
+ *   unpredictable results.
  */
+int
+ppc4xx_get_dma_residue(unsigned int dmanr)
+{
+	unsigned int count;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
 
-int hw_init_dma_channel(unsigned int,  ppc_dma_ch_t *);
-int init_dma_channel(unsigned int);
-int get_channel_config(unsigned int, ppc_dma_ch_t *);
-int set_channel_priority(unsigned int, unsigned int);
-unsigned int get_peripheral_width(unsigned int);
-int alloc_dma_handle(sgl_handle_t *, unsigned int, unsigned int);
-void free_dma_handle(sgl_handle_t);
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_get_dma_residue: bad channel 0x%x\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
 
+	count = mfdcr(DCRN_DMACT0 + (dmanr * 0x8));
 
-ppc_dma_ch_t dma_channels[MAX_405GP_DMA_CHANNELS];
+	return (count << p_dma_ch->shift);
+}
+
+/*
+ * Sets the DMA address for a memory to peripheral or peripheral
+ * to memory transfer.  The address is just saved in the channel
+ * structure for now and used later in enable_dma().
+ */
+void
+ppc4xx_set_dma_addr(unsigned int dmanr, phys_addr_t addr)
+{
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_set_dma_addr: bad channel: %d\n", dmanr);
+		return;
+	}
+
+#ifdef DEBUG_4xxDMA
+	{
+		int error = 0;
+		switch (p_dma_ch->pwidth) {
+		case PW_8:
+			break;
+		case PW_16:
+			if ((unsigned) addr & 0x1)
+				error = 1;
+			break;
+		case PW_32:
+			if ((unsigned) addr & 0x3)
+				error = 1;
+			break;
+		case PW_64:
+			if ((unsigned) addr & 0x7)
+				error = 1;
+			break;
+		default:
+			printk("ppc4xx_set_dma_addr: invalid bus width: 0x%x\n",
+			       p_dma_ch->pwidth);
+			return;
+		}
+		if (error)
+			printk("Warning: ppc4xx_set_dma_addr addr 0x%x bus width %d\n",
+			       addr, p_dma_ch->pwidth);
+	}
+#endif
+
+	/* save dma address and program it later after we know the xfer mode */
+	p_dma_ch->addr = addr;
+}
+
+/*
+ * Sets both DMA addresses for a memory to memory transfer.
+ * For memory to peripheral or peripheral to memory transfers
+ * the function set_dma_addr() should be used instead.
+ */
+void
+ppc4xx_set_dma_addr2(unsigned int dmanr, phys_addr_t src_dma_addr,
+		     phys_addr_t dst_dma_addr)
+{
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_set_dma_addr2: bad channel: %d\n", dmanr);
+		return;
+	}
+
+#ifdef DEBUG_4xxDMA
+	{
+		ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+		int error = 0;
+		switch (p_dma_ch->pwidth) {
+			case PW_8:
+				break;
+			case PW_16:
+				if (((unsigned) src_dma_addr & 0x1) ||
+						((unsigned) dst_dma_addr & 0x1)
+				   )
+					error = 1;
+				break;
+			case PW_32:
+				if (((unsigned) src_dma_addr & 0x3) ||
+						((unsigned) dst_dma_addr & 0x3)
+				   )
+					error = 1;
+				break;
+			case PW_64:
+				if (((unsigned) src_dma_addr & 0x7) ||
+						((unsigned) dst_dma_addr & 0x7)
+				   )
+					error = 1;
+				break;
+			default:
+				printk("ppc4xx_set_dma_addr2: invalid bus width: 0x%x\n",
+						p_dma_ch->pwidth);
+				return;
+		}
+		if (error)
+			printk
+				("Warning: ppc4xx_set_dma_addr2 src 0x%x dst 0x%x bus width %d\n",
+				 src_dma_addr, dst_dma_addr, p_dma_ch->pwidth);
+	}
+#endif
+
+	ppc4xx_set_src_addr(dmanr, src_dma_addr);
+	ppc4xx_set_dst_addr(dmanr, dst_dma_addr);
+}
+
+/*
+ * Enables the channel interrupt.
+ *
+ * If performing a scatter/gatter transfer, this function
+ * MUST be called before calling alloc_dma_handle() and building
+ * the sgl list.  Otherwise, interrupts will not be enabled, if
+ * they were previously disabled.
+ */
+int
+ppc4xx_enable_dma_interrupt(unsigned int dmanr)
+{
+	unsigned int control;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_enable_dma_interrupt: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	p_dma_ch->int_enable = 1;
+
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+	control |= DMA_CIE_ENABLE;	/* Channel Interrupt Enable */
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
+
+	return DMA_STATUS_GOOD;
+}
+
+/*
+ * Disables the channel interrupt.
+ *
+ * If performing a scatter/gatter transfer, this function
+ * MUST be called before calling alloc_dma_handle() and building
+ * the sgl list.  Otherwise, interrupts will not be disabled, if
+ * they were previously enabled.
+ */
+int
+ppc4xx_disable_dma_interrupt(unsigned int dmanr)
+{
+	unsigned int control;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_disable_dma_interrupt: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	p_dma_ch->int_enable = 0;
+
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+	control &= ~DMA_CIE_ENABLE;	/* Channel Interrupt Enable */
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
+
+	return DMA_STATUS_GOOD;
+}
 
 /*
  * Configures a DMA channel, including the peripheral bus width, if a
@@ -47,166 +432,112 @@
  * called from platform specific init code.  The driver should not need to
  * call this function.
  */
-int hw_init_dma_channel(unsigned int dmanr,  ppc_dma_ch_t *p_init)
+int
+ppc4xx_init_dma_channel(unsigned int dmanr, ppc_dma_ch_t * p_init)
 {
-    unsigned int polarity;
-    uint32_t control = 0;
-    ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-#ifdef DEBUG_405DMA
-    if (!p_init) {
-        printk("hw_init_dma_channel: NULL p_init\n");
-        return DMA_STATUS_NULL_POINTER;
-    }
-    if (dmanr >= MAX_405GP_DMA_CHANNELS) {
-        printk("hw_init_dma_channel: bad channel %d\n", dmanr);
-        return DMA_STATUS_BAD_CHANNEL;
-    }
-#endif
+	unsigned int polarity;
+	uint32_t control = 0;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	DMA_MODE_READ = (unsigned long) DMA_TD;	/* Peripheral to Memory */
+	DMA_MODE_WRITE = 0;	/* Memory to Peripheral */
+
+	if (!p_init) {
+		printk("ppc4xx_init_dma_channel: NULL p_init\n");
+		return DMA_STATUS_NULL_POINTER;
+	}
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_init_dma_channel: bad channel %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
 
 #if DCRN_POL > 0
-    polarity = mfdcr(DCRN_POL);
+	polarity = mfdcr(DCRN_POL);
 #else
-    polarity = 0;
+	polarity = 0;
 #endif
 
-    /* Setup the control register based on the values passed to
-     * us in p_init.  Then, over-write the control register with this
-     * new value.
-     */
-
-    control |= (
-                SET_DMA_CIE_ENABLE(p_init->int_enable) | /* interrupt enable         */
-                SET_DMA_BEN(p_init->buffer_enable)     | /* buffer enable            */
-                SET_DMA_ETD(p_init->etd_output)        | /* end of transfer pin      */
-                SET_DMA_TCE(p_init->tce_enable)        | /* terminal count enable    */
-                SET_DMA_PL(p_init->pl)                 | /* peripheral location      */
-                SET_DMA_DAI(p_init->dai)               | /* dest addr increment      */
-                SET_DMA_SAI(p_init->sai)               | /* src addr increment       */
-                SET_DMA_PRIORITY(p_init->cp)           |  /* channel priority        */
-                SET_DMA_PW(p_init->pwidth)             |  /* peripheral/bus width    */
-                SET_DMA_PSC(p_init->psc)               |  /* peripheral setup cycles */
-                SET_DMA_PWC(p_init->pwc)               |  /* peripheral wait cycles  */
-                SET_DMA_PHC(p_init->phc)               |  /* peripheral hold cycles  */
-                SET_DMA_PREFETCH(p_init->pf)              /* read prefetch           */
-                );
-
-    switch (dmanr) {
-        case 0:
-            /* clear all polarity signals and then "or" in new signal levels */
-            polarity &= ~(DMAReq0_ActiveLow | DMAAck0_ActiveLow | EOT0_ActiveLow);
-            polarity |= p_dma_ch->polarity;
-#if DCRN_POL > 0
-            mtdcr(DCRN_POL, polarity);
-#endif
-            mtdcr(DCRN_DMACR0, control);
-            break;
-        case 1:
-            polarity &= ~(DMAReq1_ActiveLow | DMAAck1_ActiveLow | EOT1_ActiveLow);
-            polarity |= p_dma_ch->polarity;
+	/* Setup the control register based on the values passed to
+	 * us in p_init.  Then, over-write the control register with this
+	 * new value.
+	 */
+	control |= SET_DMA_CONTROL;
+
+	/* clear all polarity signals and then "or" in new signal levels */
+	polarity &= ~GET_DMA_POLARITY(dmanr);
+	polarity |= p_dma_ch->polarity;
 #if DCRN_POL > 0
-            mtdcr(DCRN_POL, polarity);
+	mtdcr(DCRN_POL, polarity);
 #endif
-            mtdcr(DCRN_DMACR1, control);
-            break;
-        case 2:
-            polarity &= ~(DMAReq2_ActiveLow | DMAAck2_ActiveLow | EOT2_ActiveLow);
-            polarity |= p_dma_ch->polarity;
-#if DCRN_POL > 0
-            mtdcr(DCRN_POL, polarity);
-#endif
-            mtdcr(DCRN_DMACR2, control);
-            break;
-        case 3:
-            polarity &= ~(DMAReq3_ActiveLow | DMAAck3_ActiveLow | EOT3_ActiveLow);
-            polarity |= p_dma_ch->polarity;
-#if DCRN_POL > 0
-            mtdcr(DCRN_POL, polarity);
-#endif
-            mtdcr(DCRN_DMACR3, control);
-            break;
-        default:
-            return DMA_STATUS_BAD_CHANNEL;
-    }
-
-    /* save these values in our dma channel structure */
-    memcpy(p_dma_ch, p_init, sizeof(ppc_dma_ch_t));
-
-    /*
-     * The peripheral width values written in the control register are:
-     *   PW_8                 0
-     *   PW_16                1
-     *   PW_32                2
-     *   PW_64                3
-     *
-     *   Since the DMA count register takes the number of "transfers",
-     *   we need to divide the count sent to us in certain
-     *   functions by the appropriate number.  It so happens that our
-     *   right shift value is equal to the peripheral width value.
-     */
-    p_dma_ch->shift = p_init->pwidth;
-
-    /*
-     * Save the control word for easy access.
-     */
-    p_dma_ch->control = control;
-
-    mtdcr(DCRN_DMASR, 0xffffffff); /* clear status register */
-    return DMA_STATUS_GOOD;
-}
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
 
+	/* save these values in our dma channel structure */
+	memcpy(p_dma_ch, p_init, sizeof (ppc_dma_ch_t));
 
+	/*
+	 * The peripheral width values written in the control register are:
+	 *   PW_8                 0
+	 *   PW_16                1
+	 *   PW_32                2
+	 *   PW_64                3
+	 *
+	 *   Since the DMA count register takes the number of "transfers",
+	 *   we need to divide the count sent to us in certain
+	 *   functions by the appropriate number.  It so happens that our
+	 *   right shift value is equal to the peripheral width value.
+	 */
+	p_dma_ch->shift = p_init->pwidth;
+
+	/*
+	 * Save the control word for easy access.
+	 */
+	p_dma_ch->control = control;
 
+	mtdcr(DCRN_DMASR, 0xffffffff);	/* clear status register */
+	return DMA_STATUS_GOOD;
+}
 
 /*
  * This function returns the channel configuration.
  */
-int get_channel_config(unsigned int dmanr, ppc_dma_ch_t *p_dma_ch)
+int
+ppc4xx_get_channel_config(unsigned int dmanr, ppc_dma_ch_t * p_dma_ch)
 {
-    unsigned int polarity;
-    unsigned int control;
+	unsigned int polarity;
+	unsigned int control;
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_get_channel_config: bad channel %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
 
 #if DCRN_POL > 0
-    polarity = mfdcr(DCRN_POL);
+	polarity = mfdcr(DCRN_POL);
 #else
-    polarity = 0;
+	polarity = 0;
 #endif
 
-    switch (dmanr) {
-        case 0:
-            p_dma_ch->polarity =
-                polarity & (DMAReq0_ActiveLow | DMAAck0_ActiveLow | EOT0_ActiveLow);
-            control = mfdcr(DCRN_DMACR0);
-            break;
-        case 1:
-            p_dma_ch->polarity =
-                polarity & (DMAReq1_ActiveLow | DMAAck1_ActiveLow | EOT1_ActiveLow);
-            control = mfdcr(DCRN_DMACR1);
-            break;
-        case 2:
-            p_dma_ch->polarity =
-                polarity & (DMAReq2_ActiveLow | DMAAck2_ActiveLow | EOT2_ActiveLow);
-            control = mfdcr(DCRN_DMACR2);
-            break;
-        case 3:
-            p_dma_ch->polarity =
-                polarity & (DMAReq3_ActiveLow | DMAAck3_ActiveLow | EOT3_ActiveLow);
-            control = mfdcr(DCRN_DMACR3);
-            break;
-        default:
-            return DMA_STATUS_BAD_CHANNEL;
-    }
-
-    p_dma_ch->cp = GET_DMA_PRIORITY(control);
-    p_dma_ch->pwidth = GET_DMA_PW(control);
-    p_dma_ch->psc = GET_DMA_PSC(control);
-    p_dma_ch->pwc = GET_DMA_PWC(control);
-    p_dma_ch->phc = GET_DMA_PHC(control);
-    p_dma_ch->pf = GET_DMA_PREFETCH(control);
-    p_dma_ch->int_enable = GET_DMA_CIE_ENABLE(control);
-    p_dma_ch->shift = GET_DMA_PW(control);
+	p_dma_ch->polarity = polarity & GET_DMA_POLARITY(dmanr);
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+
+	p_dma_ch->cp = GET_DMA_PRIORITY(control);
+	p_dma_ch->pwidth = GET_DMA_PW(control);
+	p_dma_ch->psc = GET_DMA_PSC(control);
+	p_dma_ch->pwc = GET_DMA_PWC(control);
+	p_dma_ch->phc = GET_DMA_PHC(control);
+	p_dma_ch->ce = GET_DMA_CE_ENABLE(control);
+	p_dma_ch->int_enable = GET_DMA_CIE_ENABLE(control);
+	p_dma_ch->shift = GET_DMA_PW(control);
 
-    return DMA_STATUS_GOOD;
+#ifdef CONFIG_PPC4xx_EDMA
+	p_dma_ch->pf = GET_DMA_PREFETCH(control);
+#else
+	p_dma_ch->ch_enable = GET_DMA_CH(control);
+	p_dma_ch->ece_enable = GET_DMA_ECE(control);
+	p_dma_ch->tcd_disable = GET_DMA_TCD(control);
+#endif
+	return DMA_STATUS_GOOD;
 }
 
 /*
@@ -222,50 +553,28 @@
  * PRIORITY_HIGH
  *
  */
-int set_channel_priority(unsigned int dmanr, unsigned int priority)
+int
+ppc4xx_set_channel_priority(unsigned int dmanr, unsigned int priority)
 {
-    unsigned int control;
+	unsigned int control;
 
-#ifdef DEBUG_405DMA
-    if ( (priority != PRIORITY_LOW) &&
-            (priority != PRIORITY_MID_LOW) &&
-            (priority != PRIORITY_MID_HIGH) &&
-            (priority != PRIORITY_HIGH)) {
-        printk("set_channel_priority: bad priority: 0x%x\n", priority);
-    }
-#endif
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_set_channel_priority: bad channel %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
 
-    switch (dmanr) {
-        case 0:
-            control = mfdcr(DCRN_DMACR0);
-            control|= SET_DMA_PRIORITY(priority);
-            mtdcr(DCRN_DMACR0, control);
-            break;
-        case 1:
-            control = mfdcr(DCRN_DMACR1);
-            control|= SET_DMA_PRIORITY(priority);
-            mtdcr(DCRN_DMACR1, control);
-            break;
-        case 2:
-            control = mfdcr(DCRN_DMACR2);
-            control|= SET_DMA_PRIORITY(priority);
-            mtdcr(DCRN_DMACR2, control);
-            break;
-        case 3:
-            control = mfdcr(DCRN_DMACR3);
-            control|= SET_DMA_PRIORITY(priority);
-            mtdcr(DCRN_DMACR3, control);
-            break;
-        default:
-#ifdef DEBUG_405DMA
-            printk("set_channel_priority: bad channel: %d\n", dmanr);
-#endif
-            return DMA_STATUS_BAD_CHANNEL;
-    }
-    return DMA_STATUS_GOOD;
-}
+	if ((priority != PRIORITY_LOW) &&
+	    (priority != PRIORITY_MID_LOW) &&
+	    (priority != PRIORITY_MID_HIGH) && (priority != PRIORITY_HIGH)) {
+		printk("ppc4xx_set_channel_priority: bad priority: 0x%x\n", priority);
+	}
 
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
+	control |= SET_DMA_PRIORITY(priority);
+	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
 
+	return DMA_STATUS_GOOD;
+}
 
 /*
  * Returns the width of the peripheral attached to this channel. This assumes
@@ -280,213 +589,36 @@
  *
  *   The function returns 0 on error.
  */
-unsigned int get_peripheral_width(unsigned int dmanr)
+unsigned int
+ppc4xx_get_peripheral_width(unsigned int dmanr)
 {
-    unsigned int control;
-
-    switch (dmanr) {
-        case 0:
-            control = mfdcr(DCRN_DMACR0);
-            break;
-        case 1:
-            control = mfdcr(DCRN_DMACR1);
-            break;
-        case 2:
-            control = mfdcr(DCRN_DMACR2);
-            break;
-        case 3:
-            control = mfdcr(DCRN_DMACR3);
-            break;
-        default:
-#ifdef DEBUG_405DMA
-            printk("get_peripheral_width: bad channel: %d\n", dmanr);
-#endif
-            return 0;
-    }
-    return(GET_DMA_PW(control));
-}
-
-
-
-
-/*
- *   Create a scatter/gather list handle.  This is simply a structure which
- *   describes a scatter/gather list.
- *
- *   A handle is returned in "handle" which the driver should save in order to
- *   be able to access this list later.  A chunk of memory will be allocated
- *   to be used by the API for internal management purposes, including managing
- *   the sg list and allocating memory for the sgl descriptors.  One page should
- *   be more than enough for that purpose.  Perhaps it's a bit wasteful to use
- *   a whole page for a single sg list, but most likely there will be only one
- *   sg list per channel.
- *
- *   Interrupt notes:
- *   Each sgl descriptor has a copy of the DMA control word which the DMA engine
- *   loads in the control register.  The control word has a "global" interrupt
- *   enable bit for that channel. Interrupts are further qualified by a few bits
- *   in the sgl descriptor count register.  In order to setup an sgl, we have to
- *   know ahead of time whether or not interrupts will be enabled at the completion
- *   of the transfers.  Thus, enable_dma_interrupt()/disable_dma_interrupt() MUST
- *   be called before calling alloc_dma_handle().  If the interrupt mode will never
- *   change after powerup, then enable_dma_interrupt()/disable_dma_interrupt()
- *   do not have to be called -- interrupts will be enabled or disabled based
- *   on how the channel was configured after powerup by the hw_init_dma_channel()
- *   function.  Each sgl descriptor will be setup to interrupt if an error occurs;
- *   however, only the last descriptor will be setup to interrupt. Thus, an
- *   interrupt will occur (if interrupts are enabled) only after the complete
- *   sgl transfer is done.
- */
-int alloc_dma_handle(sgl_handle_t *phandle, unsigned int mode, unsigned int dmanr)
-{
-    sgl_list_info_t *psgl;
-    dma_addr_t dma_addr;
-    ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-    uint32_t sg_command;
-    void *ret;
-
-#ifdef DEBUG_405DMA
-    if (!phandle) {
-            printk("alloc_dma_handle: null handle pointer\n");
-            return DMA_STATUS_NULL_POINTER;
-    }
-    switch (mode) {
-        case DMA_MODE_READ:
-        case DMA_MODE_WRITE:
-        case DMA_MODE_MM:
-        case DMA_MODE_MM_DEVATSRC:
-        case DMA_MODE_MM_DEVATDST:
-            break;
-        default:
-            printk("alloc_dma_handle: bad mode 0x%x\n", mode);
-            return DMA_STATUS_BAD_MODE;
-    }
-    if (dmanr >= MAX_405GP_DMA_CHANNELS) {
-        printk("alloc_dma_handle: invalid channel 0x%x\n", dmanr);
-        return DMA_STATUS_BAD_CHANNEL;
-    }
-#endif
+	unsigned int control;
 
-    /* Get a page of memory, which is zeroed out by pci_alloc_consistent() */
-
-/* wrong not a pci device - armin */
-    /* psgl = (sgl_list_info_t *) pci_alloc_consistent(NULL, SGL_LIST_SIZE, &dma_addr);
-*/
-
-	ret = consistent_alloc(GFP_ATOMIC |GFP_DMA, SGL_LIST_SIZE, &dma_addr);
-	if (ret != NULL) {
-		memset(ret, 0,SGL_LIST_SIZE );
-		psgl = (sgl_list_info_t *) ret;
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_get_peripheral_width: bad channel %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
 	}
 
+	control = mfdcr(DCRN_DMACR0 + (dmanr * 0x8));
 
-    if (psgl == NULL) {
-        *phandle = (sgl_handle_t)NULL;
-        return DMA_STATUS_OUT_OF_MEMORY;
-    }
-
-    psgl->dma_addr = dma_addr;
-    psgl->dmanr = dmanr;
-
-    /*
-     * Modify and save the control word. These word will get written to each sgl
-     * descriptor.  The DMA engine then loads this control word into the control
-     * register every time it reads a new descriptor.
-     */
-    psgl->control = p_dma_ch->control;
-    psgl->control &= ~(DMA_TM_MASK | DMA_TD);  /* clear all "mode" bits first               */
-    psgl->control |= (mode | DMA_CH_ENABLE);   /* save the control word along with the mode */
-
-    if (p_dma_ch->int_enable) {
-        psgl->control |= DMA_CIE_ENABLE;       /* channel interrupt enabled                 */
-    }
-    else {
-        psgl->control &= ~DMA_CIE_ENABLE;
-    }
-
-#if DCRN_ASGC > 0
-    sg_command = mfdcr(DCRN_ASGC);
-    switch (dmanr) {
-        case 0:
-            sg_command |= SSG0_MASK_ENABLE;
-            break;
-        case 1:
-            sg_command |= SSG1_MASK_ENABLE;
-            break;
-        case 2:
-            sg_command |= SSG2_MASK_ENABLE;
-            break;
-        case 3:
-            sg_command |= SSG3_MASK_ENABLE;
-            break;
-        default:
-#ifdef DEBUG_405DMA
-            printk("alloc_dma_handle: bad channel: %d\n", dmanr);
-#endif
-            free_dma_handle((sgl_handle_t)psgl);
-            *phandle = (sgl_handle_t)NULL;
-            return DMA_STATUS_BAD_CHANNEL;
-    }
-
-    mtdcr(DCRN_ASGC, sg_command);  /* enable writing to this channel's sgl control bits */
-#else
-   (void)sg_command;
-#endif
-    psgl->sgl_control = SG_ERI_ENABLE | SG_LINK;   /* sgl descriptor control bits */
-
-    if (p_dma_ch->int_enable) {
-        if (p_dma_ch->tce_enable)
-            psgl->sgl_control |= SG_TCI_ENABLE;
-        else
-            psgl->sgl_control |= SG_ETI_ENABLE;
-    }
-
-    *phandle = (sgl_handle_t)psgl;
-    return DMA_STATUS_GOOD;
-}
-
-
-
-/*
- * Destroy a scatter/gather list handle that was created by alloc_dma_handle().
- * The list must be empty (contain no elements).
- */
-void free_dma_handle(sgl_handle_t handle)
-{
-    sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-
-    if (!handle) {
-#ifdef DEBUG_405DMA
-        printk("free_dma_handle: got NULL\n");
-#endif
-        return;
-    }
-    else if (psgl->phead) {
-#ifdef DEBUG_405DMA
-        printk("free_dma_handle: list not empty\n");
-#endif
-        return;
-    }
-    else if (!psgl->dma_addr) { /* should never happen */
-#ifdef DEBUG_405DMA
-        printk("free_dma_handle: no dma address\n");
-#endif
-        return;
-    }
-
-  /* wrong not a PCI device -armin */
-  /*  pci_free_consistent(NULL, SGL_LIST_SIZE, (void *)psgl, psgl->dma_addr); */
-	//	free_pages((unsigned long)psgl, get_order(SGL_LIST_SIZE));
-    	consistent_free((void *)psgl);
-
-
+	return (GET_DMA_PW(control));
 }
 
 
-EXPORT_SYMBOL(hw_init_dma_channel);
-EXPORT_SYMBOL(get_channel_config);
-EXPORT_SYMBOL(set_channel_priority);
-EXPORT_SYMBOL(get_peripheral_width);
-EXPORT_SYMBOL(alloc_dma_handle);
-EXPORT_SYMBOL(free_dma_handle);
+EXPORT_SYMBOL(ppc4xx_init_dma_channel);
+EXPORT_SYMBOL(ppc4xx_get_channel_config);
+EXPORT_SYMBOL(ppc4xx_set_channel_priority);
+EXPORT_SYMBOL(ppc4xx_get_peripheral_width);
 EXPORT_SYMBOL(dma_channels);
+EXPORT_SYMBOL(ppc4xx_set_src_addr);
+EXPORT_SYMBOL(ppc4xx_set_dst_addr);
+EXPORT_SYMBOL(ppc4xx_set_dma_addr);
+EXPORT_SYMBOL(ppc4xx_set_dma_addr2);
+EXPORT_SYMBOL(ppc4xx_enable_dma);
+EXPORT_SYMBOL(ppc4xx_disable_dma);
+EXPORT_SYMBOL(ppc4xx_set_dma_mode);
+EXPORT_SYMBOL(ppc4xx_set_dma_count);
+EXPORT_SYMBOL(ppc4xx_get_dma_residue);
+EXPORT_SYMBOL(ppc4xx_enable_dma_interrupt);
+EXPORT_SYMBOL(ppc4xx_disable_dma_interrupt);
+EXPORT_SYMBOL(ppc4xx_get_dma_status);
diff -Nru a/arch/ppc/syslib/ppc4xx_sgdma.c b/arch/ppc/syslib/ppc4xx_sgdma.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/syslib/ppc4xx_sgdma.c	Fri Aug  6 16:24:56 2004
@@ -0,0 +1,455 @@
+/*
+ * arch/ppc/kernel/ppc4xx_sgdma.c
+ *
+ * IBM PPC4xx DMA engine scatter/gather library 
+ *
+ * Copyright 2002-2003 MontaVista Software Inc.
+ *
+ * Cleaned up and converted to new DCR access
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Original code by Armin Kuster <akuster@mvista.com>
+ * and Pete Popov <ppopov@mvista.com>
+ *   
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/ppc4xx_dma.h>
+
+void
+ppc4xx_set_sg_addr(int dmanr, phys_addr_t sg_addr)
+{
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_set_sg_addr: bad channel: %d\n", dmanr);
+		return;
+	}
+
+#ifdef PPC4xx_DMA_64BIT
+	mtdcr(DCRN_ASGH0 + (dmanr * 0x8), (u32)(sg_addr >> 32));
+#endif			
+	mtdcr(DCRN_ASG0 + (dmanr * 0x8), (u32)sg_addr);
+}
+
+/*
+ *   Add a new sgl descriptor to the end of a scatter/gather list 
+ *   which was created by alloc_dma_handle(). 
+ *
+ *   For a memory to memory transfer, both dma addresses must be
+ *   valid. For a peripheral to memory transfer, one of the addresses
+ *   must be set to NULL, depending on the direction of the transfer:
+ *   memory to peripheral: set dst_addr to NULL,
+ *   peripheral to memory: set src_addr to NULL.
+ */
+int
+ppc4xx_add_dma_sgl(sgl_handle_t handle, phys_addr_t src_addr, phys_addr_t dst_addr,
+		   unsigned int count)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+	ppc_dma_ch_t *p_dma_ch;
+
+	if (!handle) {
+		printk("ppc4xx_add_dma_sgl: null handle\n");
+		return DMA_STATUS_BAD_HANDLE;
+	}
+
+	if (psgl->dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_add_dma_sgl: bad channel: %d\n", psgl->dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	p_dma_ch = &dma_channels[psgl->dmanr];
+
+#ifdef DEBUG_4xxDMA
+	{
+		int error = 0;
+		unsigned int aligned =
+		    (unsigned) src_addr | (unsigned) dst_addr | count;
+		switch (p_dma_ch->pwidth) {
+		case PW_8:
+			break;
+		case PW_16:
+			if (aligned & 0x1)
+				error = 1;
+			break;
+		case PW_32:
+			if (aligned & 0x3)
+				error = 1;
+			break;
+		case PW_64:
+			if (aligned & 0x7)
+				error = 1;
+			break;
+		default:
+			printk("ppc4xx_add_dma_sgl: invalid bus width: 0x%x\n",
+			       p_dma_ch->pwidth);
+			return DMA_STATUS_GENERAL_ERROR;
+		}
+		if (error)
+			printk
+			    ("Alignment warning: ppc4xx_add_dma_sgl src 0x%x dst 0x%x count 0x%x bus width var %d\n",
+			     src_addr, dst_addr, count, p_dma_ch->pwidth);
+
+	}
+#endif
+
+	if ((unsigned) (psgl->ptail + 1) >= ((unsigned) psgl + SGL_LIST_SIZE)) {
+		printk("sgl handle out of memory \n");
+		return DMA_STATUS_OUT_OF_MEMORY;
+	}
+
+	if (!psgl->ptail) {
+		psgl->phead = (ppc_sgl_t *)
+		    ((unsigned) psgl + sizeof (sgl_list_info_t));
+		psgl->phead_dma = psgl->dma_addr + sizeof(sgl_list_info_t);
+		psgl->ptail = psgl->phead;
+		psgl->ptail_dma = psgl->phead_dma;
+	} else {
+		psgl->ptail->next = psgl->ptail_dma + sizeof(ppc_sgl_t);
+		psgl->ptail++;
+		psgl->ptail_dma += sizeof(ppc_sgl_t);
+	}
+
+	psgl->ptail->control = psgl->control;
+	psgl->ptail->src_addr = src_addr;
+	psgl->ptail->dst_addr = dst_addr;
+	psgl->ptail->control_count = (count >> p_dma_ch->shift) |
+	    psgl->sgl_control;
+	psgl->ptail->next = (uint32_t) NULL;
+
+	return DMA_STATUS_GOOD;
+}
+
+/*
+ * Enable (start) the DMA described by the sgl handle.
+ */
+void
+ppc4xx_enable_dma_sgl(sgl_handle_t handle)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+	ppc_dma_ch_t *p_dma_ch;
+	uint32_t sg_command;
+
+	if (!handle) {
+		printk("ppc4xx_enable_dma_sgl: null handle\n");
+		return;
+	} else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
+		printk("ppc4xx_enable_dma_sgl: bad channel in handle %d\n",
+		       psgl->dmanr);
+		return;
+	} else if (!psgl->phead) {
+		printk("ppc4xx_enable_dma_sgl: sg list empty\n");
+		return;
+	}
+
+	p_dma_ch = &dma_channels[psgl->dmanr];
+	psgl->ptail->control_count &= ~SG_LINK;	/* make this the last dscrptr */
+	sg_command = mfdcr(DCRN_ASGC);
+
+	ppc4xx_set_sg_addr(psgl->dmanr, psgl->phead_dma);
+
+	sg_command |= SSG_ENABLE(psgl->dmanr);
+
+	mtdcr(DCRN_ASGC, sg_command);	/* start transfer */
+}
+
+/*
+ * Halt an active scatter/gather DMA operation.
+ */
+void
+ppc4xx_disable_dma_sgl(sgl_handle_t handle)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+	uint32_t sg_command;
+
+	if (!handle) {
+		printk("ppc4xx_enable_dma_sgl: null handle\n");
+		return;
+	} else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
+		printk("ppc4xx_enable_dma_sgl: bad channel in handle %d\n",
+		       psgl->dmanr);
+		return;
+	}
+
+	sg_command = mfdcr(DCRN_ASGC);
+	sg_command &= ~SSG_ENABLE(psgl->dmanr);
+	mtdcr(DCRN_ASGC, sg_command);	/* stop transfer */
+}
+
+/*
+ *  Returns number of bytes left to be transferred from the entire sgl list.
+ *  *src_addr and *dst_addr get set to the source/destination address of
+ *  the sgl descriptor where the DMA stopped.
+ *
+ *  An sgl transfer must NOT be active when this function is called.
+ */
+int
+ppc4xx_get_dma_sgl_residue(sgl_handle_t handle, phys_addr_t * src_addr,
+			   phys_addr_t * dst_addr)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+	ppc_dma_ch_t *p_dma_ch;
+	ppc_sgl_t *pnext, *sgl_addr;
+	uint32_t count_left;
+
+	if (!handle) {
+		printk("ppc4xx_get_dma_sgl_residue: null handle\n");
+		return DMA_STATUS_BAD_HANDLE;
+	} else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
+		printk("ppc4xx_get_dma_sgl_residue: bad channel in handle %d\n",
+		       psgl->dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	sgl_addr = (ppc_sgl_t *) __va(mfdcr(DCRN_ASG0 + (psgl->dmanr * 0x8)));
+	count_left = mfdcr(DCRN_DMACT0 + (psgl->dmanr * 0x8));
+
+	if (!sgl_addr) {
+		printk("ppc4xx_get_dma_sgl_residue: sgl addr register is null\n");
+		goto error;
+	}
+
+	pnext = psgl->phead;
+	while (pnext &&
+	       ((unsigned) pnext < ((unsigned) psgl + SGL_LIST_SIZE) &&
+		(pnext != sgl_addr))
+	    ) {
+		pnext++;
+	}
+
+	if (pnext == sgl_addr) {	/* found the sgl descriptor */
+
+		*src_addr = pnext->src_addr;
+		*dst_addr = pnext->dst_addr;
+
+		/*
+		 * Now search the remaining descriptors and add their count.
+		 * We already have the remaining count from this descriptor in
+		 * count_left.
+		 */
+		pnext++;
+
+		while ((pnext != psgl->ptail) &&
+		       ((unsigned) pnext < ((unsigned) psgl + SGL_LIST_SIZE))
+		    ) {
+			count_left += pnext->control_count & SG_COUNT_MASK;
+		}
+
+		if (pnext != psgl->ptail) {	/* should never happen */
+			printk
+			    ("ppc4xx_get_dma_sgl_residue error (1) psgl->ptail 0x%x handle 0x%x\n",
+			     (unsigned int) psgl->ptail, (unsigned int) handle);
+			goto error;
+		}
+
+		/* success */
+		p_dma_ch = &dma_channels[psgl->dmanr];
+		return (count_left << p_dma_ch->shift);	/* count in bytes */
+
+	} else {
+		/* this shouldn't happen */
+		printk
+		    ("get_dma_sgl_residue, unable to match current address 0x%x, handle 0x%x\n",
+		     (unsigned int) sgl_addr, (unsigned int) handle);
+
+	}
+
+      error:
+	*src_addr = (phys_addr_t) NULL;
+	*dst_addr = (phys_addr_t) NULL;
+	return 0;
+}
+
+/*
+ * Returns the address(es) of the buffer(s) contained in the head element of
+ * the scatter/gather list.  The element is removed from the scatter/gather
+ * list and the next element becomes the head.
+ *
+ * This function should only be called when the DMA is not active.
+ */
+int
+ppc4xx_delete_dma_sgl_element(sgl_handle_t handle, phys_addr_t * src_dma_addr,
+			      phys_addr_t * dst_dma_addr)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+
+	if (!handle) {
+		printk("ppc4xx_delete_sgl_element: null handle\n");
+		return DMA_STATUS_BAD_HANDLE;
+	} else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
+		printk("ppc4xx_delete_sgl_element: bad channel in handle %d\n",
+		       psgl->dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	if (!psgl->phead) {
+		printk("ppc4xx_delete_sgl_element: sgl list empty\n");
+		*src_dma_addr = (phys_addr_t) NULL;
+		*dst_dma_addr = (phys_addr_t) NULL;
+		return DMA_STATUS_SGL_LIST_EMPTY;
+	}
+
+	*src_dma_addr = (phys_addr_t) psgl->phead->src_addr;
+	*dst_dma_addr = (phys_addr_t) psgl->phead->dst_addr;
+
+	if (psgl->phead == psgl->ptail) {
+		/* last descriptor on the list */
+		psgl->phead = NULL;
+		psgl->ptail = NULL;
+	} else {
+		psgl->phead++;
+		psgl->phead_dma += sizeof(ppc_sgl_t);
+	}
+
+	return DMA_STATUS_GOOD;
+}
+
+
+/*
+ *   Create a scatter/gather list handle.  This is simply a structure which
+ *   describes a scatter/gather list.
+ *
+ *   A handle is returned in "handle" which the driver should save in order to 
+ *   be able to access this list later.  A chunk of memory will be allocated 
+ *   to be used by the API for internal management purposes, including managing 
+ *   the sg list and allocating memory for the sgl descriptors.  One page should 
+ *   be more than enough for that purpose.  Perhaps it's a bit wasteful to use 
+ *   a whole page for a single sg list, but most likely there will be only one 
+ *   sg list per channel.
+ *
+ *   Interrupt notes:
+ *   Each sgl descriptor has a copy of the DMA control word which the DMA engine
+ *   loads in the control register.  The control word has a "global" interrupt 
+ *   enable bit for that channel. Interrupts are further qualified by a few bits
+ *   in the sgl descriptor count register.  In order to setup an sgl, we have to
+ *   know ahead of time whether or not interrupts will be enabled at the completion
+ *   of the transfers.  Thus, enable_dma_interrupt()/disable_dma_interrupt() MUST
+ *   be called before calling alloc_dma_handle().  If the interrupt mode will never
+ *   change after powerup, then enable_dma_interrupt()/disable_dma_interrupt() 
+ *   do not have to be called -- interrupts will be enabled or disabled based
+ *   on how the channel was configured after powerup by the hw_init_dma_channel()
+ *   function.  Each sgl descriptor will be setup to interrupt if an error occurs;
+ *   however, only the last descriptor will be setup to interrupt. Thus, an 
+ *   interrupt will occur (if interrupts are enabled) only after the complete
+ *   sgl transfer is done.
+ */
+int
+ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned int mode, unsigned int dmanr)
+{
+	sgl_list_info_t *psgl;
+	dma_addr_t dma_addr;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+	uint32_t sg_command;
+	void *ret;
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("ppc4xx_alloc_dma_handle: invalid channel 0x%x\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
+	if (!phandle) {
+		printk("ppc4xx_alloc_dma_handle: null handle pointer\n");
+		return DMA_STATUS_NULL_POINTER;
+	}
+
+	/* Get a page of memory, which is zeroed out by consistent_alloc() */
+	ret = dma_alloc_coherent(NULL, DMA_PPC4xx_SIZE, &dma_addr, GFP_KERNEL);
+	if (ret != NULL) {
+		memset(ret, 0, DMA_PPC4xx_SIZE);
+		psgl = (sgl_list_info_t *) ret;
+	}
+
+	if (psgl == NULL) {
+		*phandle = (sgl_handle_t) NULL;
+		return DMA_STATUS_OUT_OF_MEMORY;
+	}
+
+	psgl->dma_addr = dma_addr;
+	psgl->dmanr = dmanr;
+
+	/*
+	 * Modify and save the control word. These words will be
+	 * written to each sgl descriptor.  The DMA engine then
+	 * loads this control word into the control register
+	 * every time it reads a new descriptor.
+	 */
+	psgl->control = p_dma_ch->control;
+	/* Clear all mode bits */
+	psgl->control &= ~(DMA_TM_MASK | DMA_TD);
+	/* Save control word and mode */
+	psgl->control |= (mode | DMA_CE_ENABLE);
+
+	/* In MM mode, we must set ETD/TCE */
+	if (mode == DMA_MODE_MM)
+		psgl->control |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
+
+	if (p_dma_ch->int_enable) {
+		/* Enable channel interrupt */
+		psgl->control |= DMA_CIE_ENABLE;
+	} else {
+		psgl->control &= ~DMA_CIE_ENABLE;
+	}
+
+	sg_command = mfdcr(DCRN_ASGC);
+	sg_command |= SSG_MASK_ENABLE(dmanr);
+
+	/* Enable SGL control access */
+	mtdcr(DCRN_ASGC, sg_command);
+	psgl->sgl_control = SG_ERI_ENABLE | SG_LINK;
+
+	if (p_dma_ch->int_enable) {
+		if (p_dma_ch->tce_enable)
+			psgl->sgl_control |= SG_TCI_ENABLE;
+		else
+			psgl->sgl_control |= SG_ETI_ENABLE;
+	}
+
+	*phandle = (sgl_handle_t) psgl;
+	return DMA_STATUS_GOOD;
+}
+
+/*
+ * Destroy a scatter/gather list handle that was created by alloc_dma_handle().
+ * The list must be empty (contain no elements).
+ */
+void
+ppc4xx_free_dma_handle(sgl_handle_t handle)
+{
+	sgl_list_info_t *psgl = (sgl_list_info_t *) handle;
+
+	if (!handle) {
+		printk("ppc4xx_free_dma_handle: got NULL\n");
+		return;
+	} else if (psgl->phead) {
+		printk("ppc4xx_free_dma_handle: list not empty\n");
+		return;
+	} else if (!psgl->dma_addr) {	/* should never happen */
+		printk("ppc4xx_free_dma_handle: no dma address\n");
+		return;
+	}
+
+	dma_free_coherent(NULL, DMA_PPC4xx_SIZE, (void *) psgl, 0);
+}
+
+EXPORT_SYMBOL(ppc4xx_alloc_dma_handle);
+EXPORT_SYMBOL(ppc4xx_free_dma_handle);
+EXPORT_SYMBOL(ppc4xx_add_dma_sgl);
+EXPORT_SYMBOL(ppc4xx_delete_dma_sgl_element);
+EXPORT_SYMBOL(ppc4xx_enable_dma_sgl);
+EXPORT_SYMBOL(ppc4xx_disable_dma_sgl);
+EXPORT_SYMBOL(ppc4xx_get_dma_sgl_residue);
diff -Nru a/include/asm-ppc/ppc405_dma.h b/include/asm-ppc/ppc405_dma.h
--- a/include/asm-ppc/ppc405_dma.h	Fri Aug  6 16:24:56 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,1271 +0,0 @@
-/*
- * Author: Pete Popov <ppopov@mvista.com>
- *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Data structures specific to the IBM PowerPC 405 on-chip DMA controller
- * and API.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASMPPC_405_DMA_H
-#define __ASMPPC_405_DMA_H
-
-#include <linux/types.h>
-
-/* #define DEBUG_405DMA */
-
-#define TRUE  1
-#define FALSE 0
-
-#define SGL_LIST_SIZE 4096
-/* #define PCI_ALLOC_IS_NONCONSISTENT */
-
-#define MAX_405GP_DMA_CHANNELS	4
-
-/* The maximum address that we can perform a DMA transfer to on this platform */
-/* Doesn't really apply... */
-#define MAX_DMA_ADDRESS		0xFFFFFFFF
-
-extern unsigned long ISA_DMA_THRESHOLD;
-
-#define dma_outb	outb
-#define dma_inb		inb
-
-
-/*
- * Function return status codes
- * These values are used to indicate whether or not the function
- * call was successful, or a bad/invalid parameter was passed.
- */
-#define DMA_STATUS_GOOD			0
-#define DMA_STATUS_BAD_CHANNEL		1
-#define DMA_STATUS_BAD_HANDLE		2
-#define DMA_STATUS_BAD_MODE		3
-#define DMA_STATUS_NULL_POINTER		4
-#define DMA_STATUS_OUT_OF_MEMORY	5
-#define DMA_STATUS_SGL_LIST_EMPTY	6
-#define DMA_STATUS_GENERAL_ERROR	7
-
-
-/*
- * These indicate status as returned from the DMA Status Register.
- */
-#define DMA_STATUS_NO_ERROR	0
-#define DMA_STATUS_CS		1	/* Count Status        */
-#define DMA_STATUS_TS		2	/* Transfer Status     */
-#define DMA_STATUS_DMA_ERROR	3	/* DMA Error Occurred  */
-#define DMA_STATUS_DMA_BUSY	4	/* The channel is busy */
-
-
-/*
- * Transfer Modes
- * These modes are defined in a way that makes it possible to
- * simply "or" in the value in the control register.
- */
-#define DMA_MODE_READ		DMA_TD                /* Peripheral to Memory */
-#define DMA_MODE_WRITE		0                     /* Memory to Peripheral */
-#define DMA_MODE_MM		(SET_DMA_TM(TM_S_MM)) /* memory to memory */
-
-				/* Device-paced memory to memory, */
-				/* device is at source address    */
-#define DMA_MODE_MM_DEVATSRC	(DMA_TD | SET_DMA_TM(TM_D_MM))
-
-				/* Device-paced memory to memory,      */
-				/* device is at destination address    */
-#define DMA_MODE_MM_DEVATDST	(SET_DMA_TM(TM_D_MM))
-
-
-/*
- * DMA Polarity Configuration Register
- */
-#define DMAReq0_ActiveLow (1<<31)
-#define DMAAck0_ActiveLow (1<<30)
-#define EOT0_ActiveLow    (1<<29)           /* End of Transfer      */
-
-#define DMAReq1_ActiveLow (1<<28)
-#define DMAAck1_ActiveLow (1<<27)
-#define EOT1_ActiveLow    (1<<26)
-
-#define DMAReq2_ActiveLow (1<<25)
-#define DMAAck2_ActiveLow (1<<24)
-#define EOT2_ActiveLow    (1<<23)
-
-#define DMAReq3_ActiveLow (1<<22)
-#define DMAAck3_ActiveLow (1<<21)
-#define EOT3_ActiveLow    (1<<20)
-
-/*
- * DMA Sleep Mode Register
- */
-#define SLEEP_MODE_ENABLE (1<<21)
-
-
-/*
- * DMA Status Register
- */
-#define DMA_CS0           (1<<31) /* Terminal Count has been reached */
-#define DMA_CS1           (1<<30)
-#define DMA_CS2           (1<<29)
-#define DMA_CS3           (1<<28)
-
-#define DMA_TS0           (1<<27) /* End of Transfer has been requested */
-#define DMA_TS1           (1<<26)
-#define DMA_TS2           (1<<25)
-#define DMA_TS3           (1<<24)
-
-#define DMA_CH0_ERR       (1<<23) /* DMA Chanel 0 Error */
-#define DMA_CH1_ERR       (1<<22)
-#define DMA_CH2_ERR       (1<<21)
-#define DMA_CH3_ERR       (1<<20)
-
-#define DMA_IN_DMA_REQ0   (1<<19) /* Internal DMA Request is pending */
-#define DMA_IN_DMA_REQ1   (1<<18)
-#define DMA_IN_DMA_REQ2   (1<<17)
-#define DMA_IN_DMA_REQ3   (1<<16)
-
-#define DMA_EXT_DMA_REQ0  (1<<15) /* External DMA Request is pending */
-#define DMA_EXT_DMA_REQ1  (1<<14)
-#define DMA_EXT_DMA_REQ2  (1<<13)
-#define DMA_EXT_DMA_REQ3  (1<<12)
-
-#define DMA_CH0_BUSY      (1<<11) /* DMA Channel 0 Busy */
-#define DMA_CH1_BUSY      (1<<10)
-#define DMA_CH2_BUSY       (1<<9)
-#define DMA_CH3_BUSY       (1<<8)
-
-#define DMA_SG0            (1<<7) /* DMA Channel 0 Scatter/Gather in progress */
-#define DMA_SG1            (1<<6)
-#define DMA_SG2            (1<<5)
-#define DMA_SG3            (1<<4)
-
-
-
-/*
- * DMA Channel Control Registers
- */
-#define DMA_CH_ENABLE         (1<<31)     /* DMA Channel Enable */
-#define SET_DMA_CH_ENABLE(x)  (((x)&0x1)<<31)
-#define GET_DMA_CH_ENABLE(x)  (((x)&DMA_CH_ENABLE)>>31)
-
-#define DMA_CIE_ENABLE        (1<<30)     /* DMA Channel Interrupt Enable */
-#define SET_DMA_CIE_ENABLE(x) (((x)&0x1)<<30)
-#define GET_DMA_CIE_ENABLE(x) (((x)&DMA_CIE_ENABLE)>>30)
-
-#define DMA_TD                (1<<29)
-#define SET_DMA_TD(x)         (((x)&0x1)<<29)
-#define GET_DMA_TD(x)         (((x)&DMA_TD)>>29)
-
-#define DMA_PL                (1<<28)     /* Peripheral Location */
-#define SET_DMA_PL(x)         (((x)&0x1)<<28)
-#define GET_DMA_PL(x)         (((x)&DMA_PL)>>28)
-
-#define EXTERNAL_PERIPHERAL    0
-#define INTERNAL_PERIPHERAL    1
-
-
-#define SET_DMA_PW(x)     (((x)&0x3)<<26) /* Peripheral Width */
-#define DMA_PW_MASK       SET_DMA_PW(3)
-#define   PW_8                 0
-#define   PW_16                1
-#define   PW_32                2
-#define   PW_64                3
-#define GET_DMA_PW(x)     (((x)&DMA_PW_MASK)>>26)
-
-#define DMA_DAI           (1<<25)         /* Destination Address Increment */
-#define SET_DMA_DAI(x)    (((x)&0x1)<<25)
-
-#define DMA_SAI           (1<<24)         /* Source Address Increment */
-#define SET_DMA_SAI(x)    (((x)&0x1)<<24)
-
-#define DMA_BEN           (1<<23)         /* Buffer Enable */
-#define SET_DMA_BEN(x)    (((x)&0x1)<<23)
-
-#define SET_DMA_TM(x)     (((x)&0x3)<<21) /* Transfer Mode */
-#define DMA_TM_MASK       SET_DMA_TM(3)
-#define   TM_PERIPHERAL        0          /* Peripheral */
-#define   TM_RESERVED          1          /* Reserved */
-#define   TM_S_MM              2          /* Memory to Memory */
-#define   TM_D_MM              3          /* Device Paced Memory to Memory */
-#define GET_DMA_TM(x)     (((x)&DMA_TM_MASK)>>21)
-
-#define SET_DMA_PSC(x)    (((x)&0x3)<<19) /* Peripheral Setup Cycles */
-#define DMA_PSC_MASK      SET_DMA_PSC(3)
-#define GET_DMA_PSC(x)    (((x)&DMA_PSC_MASK)>>19)
-
-#define SET_DMA_PWC(x)    (((x)&0x3F)<<13) /* Peripheral Wait Cycles */
-#define DMA_PWC_MASK      SET_DMA_PWC(0x3F)
-#define GET_DMA_PWC(x)    (((x)&DMA_PWC_MASK)>>13)
-
-#define SET_DMA_PHC(x)    (((x)&0x7)<<10) /* Peripheral Hold Cycles */
-#define DMA_PHC_MASK      SET_DMA_PHC(0x7)
-#define GET_DMA_PHC(x)    (((x)&DMA_PHC_MASK)>>10)
-
-#define DMA_ETD_OUTPUT     (1<<9)         /* EOT pin is a TC output */
-#define SET_DMA_ETD(x)     (((x)&0x1)<<9)
-
-#define DMA_TCE_ENABLE     (1<<8)
-#define SET_DMA_TCE(x)     (((x)&0x1)<<8)
-
-#define SET_DMA_PRIORITY(x)   (((x)&0x3)<<6)   /* DMA Channel Priority */
-#define DMA_PRIORITY_MASK SET_DMA_PRIORITY(3)
-#define   PRIORITY_LOW         0
-#define   PRIORITY_MID_LOW     1
-#define   PRIORITY_MID_HIGH    2
-#define   PRIORITY_HIGH        3
-#define GET_DMA_PRIORITY(x) (((x)&DMA_PRIORITY_MASK)>>6)
-
-#define SET_DMA_PREFETCH(x)   (((x)&0x3)<<4)  /* Memory Read Prefetch */
-#define DMA_PREFETCH_MASK      SET_DMA_PREFETCH(3)
-#define   PREFETCH_1           0              /* Prefetch 1 Double Word */
-#define   PREFETCH_2           1
-#define   PREFETCH_4           2
-#define GET_DMA_PREFETCH(x) (((x)&DMA_PREFETCH_MASK)>>4)
-
-#define DMA_PCE            (1<<3)         /* Parity Check Enable */
-#define SET_DMA_PCE(x)     (((x)&0x1)<<3)
-#define GET_DMA_PCE(x)     (((x)&DMA_PCE)>>3)
-
-#define DMA_DEC            (1<<2)         /* Address Decrement */
-#define SET_DMA_DEC(x)     (((x)&0x1)<<2)
-#define GET_DMA_DEC(x)     (((x)&DMA_DEC)>>2)
-
-/*
- * DMA SG Command Register
- */
-#define SSG0_ENABLE        (1<<31)        /* Start Scatter Gather */
-#define SSG1_ENABLE        (1<<30)
-#define SSG2_ENABLE        (1<<29)
-#define SSG3_ENABLE        (1<<28)
-#define SSG0_MASK_ENABLE   (1<<15)        /* Enable writing to SSG0 bit */
-#define SSG1_MASK_ENABLE   (1<<14)
-#define SSG2_MASK_ENABLE   (1<<13)
-#define SSG3_MASK_ENABLE   (1<<12)
-
-
-/*
- * DMA Scatter/Gather Descriptor Bit fields
- */
-#define SG_LINK            (1<<31)        /* Link */
-#define SG_TCI_ENABLE      (1<<29)        /* Enable Terminal Count Interrupt */
-#define SG_ETI_ENABLE      (1<<28)        /* Enable End of Transfer Interrupt */
-#define SG_ERI_ENABLE      (1<<27)        /* Enable Error Interrupt */
-#define SG_COUNT_MASK       0xFFFF        /* Count Field */
-
-
-
-
-typedef uint32_t sgl_handle_t;
-
-typedef struct {
-
-	/*
-	 * Valid polarity settings:
-	 *   DMAReq0_ActiveLow
-	 *   DMAAck0_ActiveLow
-	 *   EOT0_ActiveLow
-	 *
-	 *   DMAReq1_ActiveLow
-	 *   DMAAck1_ActiveLow
-	 *   EOT1_ActiveLow
-	 *
-	 *   DMAReq2_ActiveLow
-	 *   DMAAck2_ActiveLow
-	 *   EOT2_ActiveLow
-	 *
-	 *   DMAReq3_ActiveLow
-	 *   DMAAck3_ActiveLow
-	 *   EOT3_ActiveLow
-	 */
-	unsigned int polarity;
-
-	char buffer_enable;      /* Boolean: buffer enable            */
-	char tce_enable;         /* Boolean: terminal count enable    */
-	char etd_output;         /* Boolean: eot pin is a tc output   */
-	char pce;                /* Boolean: parity check enable      */
-
-	/*
-	 * Peripheral location:
-	 * INTERNAL_PERIPHERAL (UART0 on the 405GP)
-	 * EXTERNAL_PERIPHERAL
-	 */
-	char pl;                 /* internal/external peripheral      */
-
-	/*
-	 * Valid pwidth settings:
-	 *   PW_8
-	 *   PW_16
-	 *   PW_32
-	 *   PW_64
-	 */
-	unsigned int pwidth;
-
-	char dai;                /* Boolean: dst address increment   */
-	char sai;                /* Boolean: src address increment   */
-
-	/*
-	 * Valid psc settings: 0-3
-	 */
-	unsigned int psc;        /* Peripheral Setup Cycles         */
-
-	/*
-	 * Valid pwc settings:
-	 * 0-63
-	 */
-	unsigned int pwc;        /* Peripheral Wait Cycles          */
-
-	/*
-	 * Valid phc settings:
-	 * 0-7
-	 */
-	unsigned int phc;        /* Peripheral Hold Cycles          */
-
-	/*
-	 * Valid cp (channel priority) settings:
-	 *   PRIORITY_LOW
-	 *   PRIORITY_MID_LOW
-	 *   PRIORITY_MID_HIGH
-	 *   PRIORITY_HIGH
-	 */
-	unsigned int cp;         /* channel priority                */
-
-	/*
-	 * Valid pf (memory read prefetch) settings:
-	 *
-	 *   PREFETCH_1
-	 *   PREFETCH_2
-	 *   PREFETCH_4
-	 */
-	unsigned int pf;         /* memory read prefetch            */
-
-	/*
-	 * Boolean: channel interrupt enable
-	 * NOTE: for sgl transfers, only the last descriptor will be setup to
-	 * interrupt.
-	 */
-	char int_enable;
-
-	char shift;              /* easy access to byte_count shift, based on */
-	                         /* the width of the channel                  */
-
-	uint32_t control;        /* channel control word                      */
-
-
-	/* These variabled are used ONLY in single dma transfers              */
-	unsigned int mode;       /* transfer mode                     */
-	dma_addr_t addr;
-
-} ppc_dma_ch_t;
-
-
-typedef struct {
-	uint32_t control;
-	uint32_t src_addr;
-	uint32_t dst_addr;
-	uint32_t control_count;
-	uint32_t next;
-} ppc_sgl_t;
-
-
-
-typedef struct {
-	unsigned int dmanr;
-	uint32_t control;     /* channel ctrl word; loaded from each descrptr */
-	uint32_t sgl_control; /* LK, TCI, ETI, and ERI bits in sgl descriptor */
-	dma_addr_t dma_addr;  /* dma (physical) address of this list          */
-	ppc_sgl_t *phead;
-	ppc_sgl_t *ptail;
-
-} sgl_list_info_t;
-
-
-typedef struct {
-	unsigned int *src_addr;
-	unsigned int *dst_addr;
-	dma_addr_t dma_src_addr;
-	dma_addr_t dma_dst_addr;
-} pci_alloc_desc_t;
-
-
-extern ppc_dma_ch_t dma_channels[];
-
-/*
- *
- * DMA API inline functions
- * These functions are implemented here as inline functions for
- * performance reasons.
- *
- */
-
-static __inline__ int get_405gp_dma_status(void)
-{
-	return (mfdcr(DCRN_DMASR));
-}
-
-
-static __inline__ int enable_405gp_dma(unsigned int dmanr)
-{
-	unsigned int control;
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-#ifdef DEBUG_405DMA
-	if (dmanr >= MAX_405GP_DMA_CHANNELS) {
-		printk("enable_dma: bad channel: %d\n", dmanr);
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-#endif
-
-
-	switch (dmanr) {
-	case 0:
-		if (p_dma_ch->mode == DMA_MODE_READ) {
-			/* peripheral to memory */
-			mtdcr(DCRN_DMASA0, NULL);
-			mtdcr(DCRN_DMADA0, p_dma_ch->addr);
-			}
-		else if (p_dma_ch->mode == DMA_MODE_WRITE) {
-			/* memory to peripheral */
-			mtdcr(DCRN_DMASA0, p_dma_ch->addr);
-			mtdcr(DCRN_DMADA0, NULL);
-		}
-		/* for other xfer modes, the addresses are already set */
-		control = mfdcr(DCRN_DMACR0);
-		control &= ~(DMA_TM_MASK | DMA_TD);   /* clear all mode bits */
-		control |= (p_dma_ch->mode | DMA_CH_ENABLE);
-		mtdcr(DCRN_DMACR0, control);
-		break;
-	case 1:
-		if (p_dma_ch->mode == DMA_MODE_READ) {
-			mtdcr(DCRN_DMASA1, NULL);
-			mtdcr(DCRN_DMADA1, p_dma_ch->addr);
-		} else if (p_dma_ch->mode == DMA_MODE_WRITE) {
-			mtdcr(DCRN_DMASA1, p_dma_ch->addr);
-			mtdcr(DCRN_DMADA1, NULL);
-		}
-		control = mfdcr(DCRN_DMACR1);
-		control &= ~(DMA_TM_MASK | DMA_TD);
-		control |= (p_dma_ch->mode | DMA_CH_ENABLE);
-		mtdcr(DCRN_DMACR1, control);
-		break;
-	case 2:
-		if (p_dma_ch->mode == DMA_MODE_READ) {
-			mtdcr(DCRN_DMASA2, NULL);
-			mtdcr(DCRN_DMADA2, p_dma_ch->addr);
-		} else if (p_dma_ch->mode == DMA_MODE_WRITE) {
-			mtdcr(DCRN_DMASA2, p_dma_ch->addr);
-			mtdcr(DCRN_DMADA2, NULL);
-		}
-		control = mfdcr(DCRN_DMACR2);
-		control &= ~(DMA_TM_MASK | DMA_TD);
-		control |= (p_dma_ch->mode | DMA_CH_ENABLE);
-		mtdcr(DCRN_DMACR2, control);
-		break;
-	case 3:
-		if (p_dma_ch->mode == DMA_MODE_READ) {
-			mtdcr(DCRN_DMASA3, NULL);
-			mtdcr(DCRN_DMADA3, p_dma_ch->addr);
-		} else if (p_dma_ch->mode == DMA_MODE_WRITE) {
-			mtdcr(DCRN_DMASA3, p_dma_ch->addr);
-			mtdcr(DCRN_DMADA3, NULL);
-		}
-		control = mfdcr(DCRN_DMACR3);
-		control &= ~(DMA_TM_MASK | DMA_TD);
-		control |= (p_dma_ch->mode | DMA_CH_ENABLE);
-		mtdcr(DCRN_DMACR3, control);
-		break;
-	default:
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-	return DMA_STATUS_GOOD;
-}
-
-
-
-static __inline__ void disable_405gp_dma(unsigned int dmanr)
-{
-	unsigned int control;
-
-	switch (dmanr) {
-	case 0:
-		control = mfdcr(DCRN_DMACR0);
-		control &= ~DMA_CH_ENABLE;
-		mtdcr(DCRN_DMACR0, control);
-		break;
-	case 1:
-		control = mfdcr(DCRN_DMACR1);
-		control &= ~DMA_CH_ENABLE;
-		mtdcr(DCRN_DMACR1, control);
-		break;
-	case 2:
-		control = mfdcr(DCRN_DMACR2);
-		control &= ~DMA_CH_ENABLE;
-		mtdcr(DCRN_DMACR2, control);
-		break;
-	case 3:
-		control = mfdcr(DCRN_DMACR3);
-		control &= ~DMA_CH_ENABLE;
-		mtdcr(DCRN_DMACR3, control);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("disable_dma: bad channel: %d\n", dmanr);
-#endif
-	}
-}
-
-
-
-/*
- * Sets the dma mode for single DMA transfers only.
- * For scatter/gather transfers, the mode is passed to the
- * alloc_dma_handle() function as one of the parameters.
- *
- * The mode is simply saved and used later.  This allows
- * the driver to call set_dma_mode() and set_dma_addr() in
- * any order.
- *
- * Valid mode values are:
- *
- * DMA_MODE_READ          peripheral to memory
- * DMA_MODE_WRITE         memory to peripheral
- * DMA_MODE_MM            memory to memory
- * DMA_MODE_MM_DEVATSRC   device-paced memory to memory, device at src
- * DMA_MODE_MM_DEVATDST   device-paced memory to memory, device at dst
- */
-static __inline__ int set_405gp_dma_mode(unsigned int dmanr, unsigned int mode)
-{
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-#ifdef DEBUG_405DMA
-	switch (mode) {
-	case DMA_MODE_READ:
-	case DMA_MODE_WRITE:
-	case DMA_MODE_MM:
-	case DMA_MODE_MM_DEVATSRC:
-	case DMA_MODE_MM_DEVATDST:
-		break;
-	default:
-		printk("set_dma_mode: bad mode 0x%x\n", mode);
-		return DMA_STATUS_BAD_MODE;
-	}
-	if (dmanr >= MAX_405GP_DMA_CHANNELS) {
-		printk("set_dma_mode: bad channel 0x%x\n", dmanr);
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-#endif
-
-	p_dma_ch->mode = mode;
-	return DMA_STATUS_GOOD;
-}
-
-
-
-/*
- * Sets the DMA Count register. Note that 'count' is in bytes.
- * However, the DMA Count register counts the number of "transfers",
- * where each transfer is equal to the bus width.  Thus, count
- * MUST be a multiple of the bus width.
- */
-static __inline__ void
-set_405gp_dma_count(unsigned int dmanr, unsigned int count)
-{
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-#ifdef DEBUG_405DMA
-	{
-	int error = 0;
-	switch(p_dma_ch->pwidth) {
-	case PW_8:
-		break;
-	case PW_16:
-		if (count & 0x1)
-		error = 1;
-		break;
-	case PW_32:
-		if (count & 0x3)
-		error = 1;
-		break;
-	case PW_64:
-		if (count & 0x7)
-		error = 1;
-		break;
-	default:
-		printk("set_dma_count: invalid bus width: 0x%x\n",
-			p_dma_ch->pwidth);
-		return;
-	}
-	if (error)
-		printk("Warning: set_dma_count count 0x%x bus width %d\n",
-			count, p_dma_ch->pwidth);
-	}
-#endif
-
-	count = count >> p_dma_ch->shift;
-	switch (dmanr) {
-	case 0:
-		mtdcr(DCRN_DMACT0, count);
-		break;
-	case 1:
-		mtdcr(DCRN_DMACT1, count);
-		break;
-	case 2:
-		mtdcr(DCRN_DMACT2, count);
-		break;
-	case 3:
-		mtdcr(DCRN_DMACT3, count);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("set_dma_count: bad channel: %d\n", dmanr);
-#endif
-	}
-}
-
-
-
-/*
- *   Returns the number of bytes left to be transfered.
- *   After a DMA transfer, this should return zero.
- *   Reading this while a DMA transfer is still in progress will return
- *   unpredictable results.
- */
-static __inline__ int get_405gp_dma_residue(unsigned int dmanr)
-{
-	unsigned int count;
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-	switch (dmanr) {
-	case 0:
-		count = mfdcr(DCRN_DMACT0);
-		break;
-	case 1:
-		count = mfdcr(DCRN_DMACT1);
-		break;
-	case 2:
-		count = mfdcr(DCRN_DMACT2);
-		break;
-	case 3:
-		count = mfdcr(DCRN_DMACT3);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("get_dma_residue: bad channel: %d\n", dmanr);
-#endif
-	    return 0;
-	}
-
-	return (count << p_dma_ch->shift);
-}
-
-
-
-/*
- * Sets the DMA address for a memory to peripheral or peripheral
- * to memory transfer.  The address is just saved in the channel
- * structure for now and used later in enable_dma().
- */
-static __inline__ void set_405gp_dma_addr(unsigned int dmanr, dma_addr_t addr)
-{
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-#ifdef DEBUG_405DMA
-	{
-	int error = 0;
-	switch(p_dma_ch->pwidth) {
-	case PW_8:
-		break;
-	case PW_16:
-		if ((unsigned)addr & 0x1)
-		error = 1;
-		break;
-	case PW_32:
-		if ((unsigned)addr & 0x3)
-		error = 1;
-		break;
-	case PW_64:
-		if ((unsigned)addr & 0x7)
-		error = 1;
-		break;
-	default:
-		printk("set_dma_addr: invalid bus width: 0x%x\n",
-			p_dma_ch->pwidth);
-		return;
-	}
-	if (error)
-		printk("Warning: set_dma_addr addr 0x%x bus width %d\n",
-			addr, p_dma_ch->pwidth);
-	}
-#endif
-
-	/* save dma address and program it later after we know the xfer mode */
-	p_dma_ch->addr = addr;
-}
-
-
-
-
-/*
- * Sets both DMA addresses for a memory to memory transfer.
- * For memory to peripheral or peripheral to memory transfers
- * the function set_dma_addr() should be used instead.
- */
-static __inline__ void
-set_405gp_dma_addr2(unsigned int dmanr, dma_addr_t src_dma_addr,
-	dma_addr_t dst_dma_addr)
-{
-#ifdef DEBUG_405DMA
-	{
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-	int error = 0;
-	switch(p_dma_ch->pwidth) {
-	case PW_8:
-		break;
-	case PW_16:
-		if (((unsigned)src_dma_addr & 0x1) ||
-		    ((unsigned)dst_dma_addr & 0x1)
-		   )
-			error = 1;
-		break;
-	case PW_32:
-		if (((unsigned)src_dma_addr & 0x3) ||
-		    ((unsigned)dst_dma_addr & 0x3)
-		   )
-			error = 1;
-		break;
-	case PW_64:
-		if (((unsigned)src_dma_addr & 0x7) ||
-		    ((unsigned)dst_dma_addr & 0x7)
-		   )
-			error = 1;
-		break;
-	default:
-		printk("set_dma_addr2: invalid bus width: 0x%x\n",
-			p_dma_ch->pwidth);
-		return;
-	}
-	if (error)
-		printk("Warning: set_dma_addr2 src 0x%x dst 0x%x bus width %d\n",
-			src_dma_addr, dst_dma_addr, p_dma_ch->pwidth);
-	}
-#endif
-
-	switch (dmanr) {
-	case 0:
-		mtdcr(DCRN_DMASA0, src_dma_addr);
-		mtdcr(DCRN_DMADA0, dst_dma_addr);
-		break;
-	case 1:
-		mtdcr(DCRN_DMASA1, src_dma_addr);
-		mtdcr(DCRN_DMADA1, dst_dma_addr);
-		break;
-	case 2:
-		mtdcr(DCRN_DMASA2, src_dma_addr);
-		mtdcr(DCRN_DMADA2, dst_dma_addr);
-		break;
-	case 3:
-		mtdcr(DCRN_DMASA3, src_dma_addr);
-		mtdcr(DCRN_DMADA3, dst_dma_addr);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("set_dma_addr2: bad channel: %d\n", dmanr);
-#endif
-	}
-}
-
-
-
-/*
- * Enables the channel interrupt.
- *
- * If performing a scatter/gatter transfer, this function
- * MUST be called before calling alloc_dma_handle() and building
- * the sgl list.  Otherwise, interrupts will not be enabled, if
- * they were previously disabled.
- */
-static __inline__ int
-enable_405gp_dma_interrupt(unsigned int dmanr)
-{
-	unsigned int control;
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-	p_dma_ch->int_enable = TRUE;
-	switch (dmanr) {
-	case 0:
-		control = mfdcr(DCRN_DMACR0);
-		control|= DMA_CIE_ENABLE;        /* Channel Interrupt Enable */
-		mtdcr(DCRN_DMACR0, control);
-		break;
-	case 1:
-		control = mfdcr(DCRN_DMACR1);
-		control|= DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR1, control);
-		break;
-	case 2:
-		control = mfdcr(DCRN_DMACR2);
-		control|= DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR2, control);
-		break;
-	case 3:
-		control = mfdcr(DCRN_DMACR3);
-		control|= DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR3, control);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("enable_dma_interrupt: bad channel: %d\n", dmanr);
-#endif
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-	return DMA_STATUS_GOOD;
-}
-
-
-
-/*
- * Disables the channel interrupt.
- *
- * If performing a scatter/gatter transfer, this function
- * MUST be called before calling alloc_dma_handle() and building
- * the sgl list.  Otherwise, interrupts will not be disabled, if
- * they were previously enabled.
- */
-static __inline__ int
-disable_405gp_dma_interrupt(unsigned int dmanr)
-{
-	unsigned int control;
-	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
-
-	p_dma_ch->int_enable = TRUE;
-	switch (dmanr) {
-	case 0:
-		control = mfdcr(DCRN_DMACR0);
-		control &= ~DMA_CIE_ENABLE;       /* Channel Interrupt Enable */
-		mtdcr(DCRN_DMACR0, control);
-		break;
-	case 1:
-		control = mfdcr(DCRN_DMACR1);
-		control &= ~DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR1, control);
-		break;
-	case 2:
-		control = mfdcr(DCRN_DMACR2);
-		control &= ~DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR2, control);
-		break;
-	case 3:
-		control = mfdcr(DCRN_DMACR3);
-		control &= ~DMA_CIE_ENABLE;
-		mtdcr(DCRN_DMACR3, control);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("enable_dma_interrupt: bad channel: %d\n", dmanr);
-#endif
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-	return DMA_STATUS_GOOD;
-}
-
-
-#ifdef DCRNCAP_DMA_SG
-
-/*
- *   Add a new sgl descriptor to the end of a scatter/gather list
- *   which was created by alloc_dma_handle().
- *
- *   For a memory to memory transfer, both dma addresses must be
- *   valid. For a peripheral to memory transfer, one of the addresses
- *   must be set to NULL, depending on the direction of the transfer:
- *   memory to peripheral: set dst_addr to NULL,
- *   peripheral to memory: set src_addr to NULL.
- */
-static __inline__ int
-add_405gp_dma_sgl(sgl_handle_t handle, dma_addr_t src_addr, dma_addr_t dst_addr,
-	unsigned int count)
-{
-	sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-	ppc_dma_ch_t *p_dma_ch;
-
-	if (!handle) {
-#ifdef DEBUG_405DMA
-		printk("add_dma_sgl: null handle\n");
-#endif
-		return DMA_STATUS_BAD_HANDLE;
-	}
-
-#ifdef DEBUG_405DMA
-	if (psgl->dmanr >= MAX_405GP_DMA_CHANNELS) {
-		printk("add_dma_sgl error: psgl->dmanr == %d\n", psgl->dmanr);
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-#endif
-
-	p_dma_ch = &dma_channels[psgl->dmanr];
-
-#ifdef DEBUG_405DMA
-	{
-	int error = 0;
-	unsigned int aligned = (unsigned)src_addr | (unsigned)dst_addr | count;
-	switch(p_dma_ch->pwidth) {
-	case PW_8:
-		break;
-	case PW_16:
-		if (aligned & 0x1)
-		error = 1;
-		break;
-	case PW_32:
-		if (aligned & 0x3)
-			error = 1;
-		break;
-	case PW_64:
-		if (aligned & 0x7)
-			error = 1;
-		break;
-	default:
-		printk("add_dma_sgl: invalid bus width: 0x%x\n",
-			p_dma_ch->pwidth);
-		return DMA_STATUS_GENERAL_ERROR;
-	}
-	if (error)
-		printk("Alignment warning: add_dma_sgl src 0x%x dst 0x%x count 0x%x bus width var %d\n",
-			src_addr, dst_addr, count, p_dma_ch->pwidth);
-
-	}
-#endif
-
-	if ((unsigned)(psgl->ptail + 1) >= ((unsigned)psgl + SGL_LIST_SIZE)) {
-#ifdef DEBUG_405DMA
-		printk("sgl handle out of memory \n");
-#endif
-		return DMA_STATUS_OUT_OF_MEMORY;
-	}
-
-
-	if (!psgl->ptail) {
-		psgl->phead = (ppc_sgl_t *)
-			      ((unsigned)psgl + sizeof(sgl_list_info_t));
-		psgl->ptail = psgl->phead;
-	} else {
-		psgl->ptail->next = virt_to_bus(psgl->ptail + 1);
-		psgl->ptail++;
-	}
-
-	psgl->ptail->control       = psgl->control;
-	psgl->ptail->src_addr      = src_addr;
-	psgl->ptail->dst_addr      = dst_addr;
-	psgl->ptail->control_count = (count >> p_dma_ch->shift) |
-				     psgl->sgl_control;
-	psgl->ptail->next          = (uint32_t)NULL;
-
-	return DMA_STATUS_GOOD;
-}
-
-
-
-/*
- * Enable (start) the DMA described by the sgl handle.
- */
-static __inline__ void enable_405gp_dma_sgl(sgl_handle_t handle)
-{
-	sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-	ppc_dma_ch_t *p_dma_ch;
-	uint32_t sg_command;
-
-#ifdef DEBUG_405DMA
-	if (!handle) {
-		printk("enable_dma_sgl: null handle\n");
-		return;
-	} else if (psgl->dmanr > (MAX_405GP_DMA_CHANNELS - 1)) {
-		printk("enable_dma_sgl: bad channel in handle %d\n",
-			psgl->dmanr);
-		return;
-	} else if (!psgl->phead) {
-		printk("enable_dma_sgl: sg list empty\n");
-		return;
-	}
-#endif
-
-	p_dma_ch = &dma_channels[psgl->dmanr];
-	psgl->ptail->control_count &= ~SG_LINK; /* make this the last dscrptr */
-	sg_command = mfdcr(DCRN_ASGC);
-
-	switch(psgl->dmanr) {
-	case 0:
-		mtdcr(DCRN_ASG0, virt_to_bus(psgl->phead));
-		sg_command |= SSG0_ENABLE;
-		break;
-	case 1:
-		mtdcr(DCRN_ASG1, virt_to_bus(psgl->phead));
-		sg_command |= SSG1_ENABLE;
-		break;
-	case 2:
-		mtdcr(DCRN_ASG2, virt_to_bus(psgl->phead));
-		sg_command |= SSG2_ENABLE;
-		break;
-	case 3:
-		mtdcr(DCRN_ASG3, virt_to_bus(psgl->phead));
-		sg_command |= SSG3_ENABLE;
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("enable_dma_sgl: bad channel: %d\n", psgl->dmanr);
-#endif
-	}
-
-#if 0 /* debug */
-	printk("\n\nenable_dma_sgl at dma_addr 0x%x\n",
-		virt_to_bus(psgl->phead));
-	{
-	ppc_sgl_t *pnext, *sgl_addr;
-
-	pnext = psgl->phead;
-	while (pnext) {
-		printk("dma descriptor at 0x%x, dma addr 0x%x\n",
-			(unsigned)pnext, (unsigned)virt_to_bus(pnext));
-		printk("control 0x%x src 0x%x dst 0x%x c_count 0x%x, next 0x%x\n",
-			(unsigned)pnext->control, (unsigned)pnext->src_addr,
-			(unsigned)pnext->dst_addr,
-			(unsigned)pnext->control_count, (unsigned)pnext->next);
-
-		(unsigned)pnext = bus_to_virt(pnext->next);
-	}
-	printk("sg_command 0x%x\n", sg_command);
-	}
-#endif
-
-#ifdef PCI_ALLOC_IS_NONCONSISTENT
-	/*
-	* This is temporary only, until pci_alloc_consistent() really does
-	* return "consistent" memory.
-	*/
-	flush_dcache_range((unsigned)handle, (unsigned)handle + SGL_LIST_SIZE);
-#endif
-
-	mtdcr(DCRN_ASGC, sg_command);             /* start transfer */
-}
-
-
-
-/*
- * Halt an active scatter/gather DMA operation.
- */
-static __inline__ void disable_405gp_dma_sgl(sgl_handle_t handle)
-{
-	sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-	uint32_t sg_command;
-
-#ifdef DEBUG_405DMA
-	if (!handle) {
-		printk("enable_dma_sgl: null handle\n");
-		return;
-	} else if (psgl->dmanr > (MAX_405GP_DMA_CHANNELS - 1)) {
-		printk("enable_dma_sgl: bad channel in handle %d\n",
-			psgl->dmanr);
-		return;
-	}
-#endif
-	sg_command = mfdcr(DCRN_ASGC);
-	switch(psgl->dmanr) {
-	case 0:
-		sg_command &= ~SSG0_ENABLE;
-		break;
-	case 1:
-		sg_command &= ~SSG1_ENABLE;
-		break;
-	case 2:
-		sg_command &= ~SSG2_ENABLE;
-		break;
-	case 3:
-		sg_command &= ~SSG3_ENABLE;
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("enable_dma_sgl: bad channel: %d\n", psgl->dmanr);
-#endif
-	}
-
-	mtdcr(DCRN_ASGC, sg_command);             /* stop transfer */
-}
-
-
-
-/*
- *  Returns number of bytes left to be transferred from the entire sgl list.
- *  *src_addr and *dst_addr get set to the source/destination address of
- *  the sgl descriptor where the DMA stopped.
- *
- *  An sgl transfer must NOT be active when this function is called.
- */
-static __inline__ int
-get_405gp_dma_sgl_residue(sgl_handle_t handle, dma_addr_t *src_addr,
-	dma_addr_t *dst_addr)
-{
-	sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-	ppc_dma_ch_t *p_dma_ch;
-	ppc_sgl_t *pnext, *sgl_addr;
-	uint32_t count_left;
-
-#ifdef DEBUG_405DMA
-	if (!handle) {
-		printk("get_dma_sgl_residue: null handle\n");
-		return DMA_STATUS_BAD_HANDLE;
-	} else if (psgl->dmanr > (MAX_405GP_DMA_CHANNELS - 1)) {
-		printk("get_dma_sgl_residue: bad channel in handle %d\n",
-			psgl->dmanr);
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-#endif
-
-	switch(psgl->dmanr) {
-	case 0:
-		sgl_addr = (ppc_sgl_t *)bus_to_virt(mfdcr(DCRN_ASG0));
-		count_left = mfdcr(DCRN_DMACT0);
-		break;
-	case 1:
-		sgl_addr = (ppc_sgl_t *)bus_to_virt(mfdcr(DCRN_ASG1));
-		count_left = mfdcr(DCRN_DMACT1);
-		break;
-	case 2:
-		sgl_addr = (ppc_sgl_t *)bus_to_virt(mfdcr(DCRN_ASG2));
-		count_left = mfdcr(DCRN_DMACT2);
-		break;
-	case 3:
-		sgl_addr = (ppc_sgl_t *)bus_to_virt(mfdcr(DCRN_ASG3));
-		count_left = mfdcr(DCRN_DMACT3);
-		break;
-	default:
-#ifdef DEBUG_405DMA
-		printk("get_dma_sgl_residue: bad channel: %d\n", psgl->dmanr);
-#endif
-		goto error;
-	}
-
-	if (!sgl_addr) {
-#ifdef DEBUG_405DMA
-		printk("get_dma_sgl_residue: sgl addr register is null\n");
-#endif
-		goto error;
-	}
-
-	pnext = psgl->phead;
-	while (pnext &&
-		((unsigned)pnext < ((unsigned)psgl + SGL_LIST_SIZE) &&
-		(pnext != sgl_addr))
-	      ) {
-		pnext = pnext++;
-	}
-
-	if (pnext == sgl_addr) {           /* found the sgl descriptor */
-
-		*src_addr = pnext->src_addr;
-		*dst_addr = pnext->dst_addr;
-
-		/*
-		 * Now search the remaining descriptors and add their count.
-		 * We already have the remaining count from this descriptor in
-		 * count_left.
-		 */
-		pnext++;
-
-		while ((pnext != psgl->ptail) &&
-			((unsigned)pnext < ((unsigned)psgl + SGL_LIST_SIZE))
-		      ) {
-			count_left += pnext->control_count & SG_COUNT_MASK;
-		}
-
-		if (pnext != psgl->ptail) { /* should never happen */
-#ifdef DEBUG_405DMA
-			printk("get_dma_sgl_residue error (1) psgl->ptail 0x%x handle 0x%x\n",
-				(unsigned int)psgl->ptail,
-				(unsigned int)handle);
-#endif
-			goto error;
-		}
-
-		/* success */
-		p_dma_ch = &dma_channels[psgl->dmanr];
-		return (count_left << p_dma_ch->shift);  /* count in bytes */
-
-	} else {
-	/* this shouldn't happen */
-#ifdef DEBUG_405DMA
-		printk("get_dma_sgl_residue, unable to match current address 0x%x, handle 0x%x\n",
-			(unsigned int)sgl_addr, (unsigned int)handle);
-
-#endif
-	}
-
-
-error:
-	*src_addr = (dma_addr_t)NULL;
-	*dst_addr = (dma_addr_t)NULL;
-	return 0;
-}
-
-
-
-
-/*
- * Returns the address(es) of the buffer(s) contained in the head element of
- * the scatter/gather list.  The element is removed from the scatter/gather
- * list and the next element becomes the head.
- *
- * This function should only be called when the DMA is not active.
- */
-static __inline__ int
-delete_405gp_dma_sgl_element(sgl_handle_t handle, dma_addr_t *src_dma_addr,
-	dma_addr_t *dst_dma_addr)
-{
-	sgl_list_info_t *psgl = (sgl_list_info_t *)handle;
-
-#ifdef DEBUG_405DMA
-	if (!handle) {
-		printk("delete_sgl_element: null handle\n");
-		return DMA_STATUS_BAD_HANDLE;
-	} else if (psgl->dmanr > (MAX_405GP_DMA_CHANNELS - 1)) {
-		printk("delete_sgl_element: bad channel in handle %d\n",
-			psgl->dmanr);
-		return DMA_STATUS_BAD_CHANNEL;
-	}
-#endif
-
-	if (!psgl->phead) {
-#ifdef DEBUG_405DMA
-		printk("delete_sgl_element: sgl list empty\n");
-#endif
-		*src_dma_addr = (dma_addr_t)NULL;
-		*dst_dma_addr = (dma_addr_t)NULL;
-		return DMA_STATUS_SGL_LIST_EMPTY;
-	}
-
-	*src_dma_addr = (dma_addr_t)psgl->phead->src_addr;
-	*dst_dma_addr = (dma_addr_t)psgl->phead->dst_addr;
-
-	if (psgl->phead == psgl->ptail) {
-		/* last descriptor on the list */
-		psgl->phead = NULL;
-		psgl->ptail = NULL;
-	} else {
-		psgl->phead++;
-	}
-
-	return DMA_STATUS_GOOD;
-}
-
-#endif /* DCRNCAP_DMA_SG */
-
-/*
- * The rest of the DMA API, in ppc405_dma.c
- */
-extern int hw_init_dma_channel(unsigned int,  ppc_dma_ch_t *);
-extern int get_channel_config(unsigned int, ppc_dma_ch_t *);
-extern int set_channel_priority(unsigned int, unsigned int);
-extern unsigned int get_peripheral_width(unsigned int);
-extern int alloc_dma_handle(sgl_handle_t *, unsigned int, unsigned int);
-extern void free_dma_handle(sgl_handle_t);
-
-#endif
-#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/ppc4xx_dma.h b/include/asm-ppc/ppc4xx_dma.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/ppc4xx_dma.h	Fri Aug  6 16:24:56 2004
@@ -0,0 +1,570 @@
+/*
+ * include/asm-ppc/ppc4xx_dma.h
+ *
+ * IBM PPC4xx DMA engine library
+ *
+ * Copyright 2000-2004 MontaVista Software Inc.
+ *
+ * Cleaned up a bit more, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Original code by Armin Kuster <akuster@mvista.com>
+ * and Pete Popov <ppopov@mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASMPPC_PPC4xx_DMA_H
+#define __ASMPPC_PPC4xx_DMA_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/mmu.h>
+#include <asm/ibm4xx.h>
+
+#undef DEBUG_4xxDMA
+
+#define MAX_PPC4xx_DMA_CHANNELS		4
+
+/* in arch/ppc/kernel/setup.c -- Cort */
+extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;
+
+/* 
+ * Function return status codes
+ * These values are used to indicate whether or not the function
+ * call was successful, or a bad/invalid parameter was passed.
+ */
+#define DMA_STATUS_GOOD			0
+#define DMA_STATUS_BAD_CHANNEL		1
+#define DMA_STATUS_BAD_HANDLE		2
+#define DMA_STATUS_BAD_MODE		3
+#define DMA_STATUS_NULL_POINTER		4
+#define DMA_STATUS_OUT_OF_MEMORY	5
+#define DMA_STATUS_SGL_LIST_EMPTY	6
+#define DMA_STATUS_GENERAL_ERROR	7
+#define DMA_STATUS_CHANNEL_NOTFREE	8
+
+#define DMA_CHANNEL_BUSY		0x80000000
+
+/*
+ * These indicate status as returned from the DMA Status Register.
+ */
+#define DMA_STATUS_NO_ERROR	0
+#define DMA_STATUS_CS		1	/* Count Status        */
+#define DMA_STATUS_TS		2	/* Transfer Status     */
+#define DMA_STATUS_DMA_ERROR	3	/* DMA Error Occurred  */
+#define DMA_STATUS_DMA_BUSY	4	/* The channel is busy */
+
+
+/*
+ * DMA Channel Control Registers
+ */
+
+#ifdef CONFIG_44x
+#define	PPC4xx_DMA_64BIT
+#define DMA_CR_OFFSET 1
+#else
+#define DMA_CR_OFFSET 0
+#endif
+
+#define DMA_CE_ENABLE        (1<<31)	/* DMA Channel Enable */
+#define SET_DMA_CE_ENABLE(x) (((x)&0x1)<<31)
+#define GET_DMA_CE_ENABLE(x) (((x)&DMA_CE_ENABLE)>>31)
+
+#define DMA_CIE_ENABLE        (1<<30)	/* DMA Channel Interrupt Enable */
+#define SET_DMA_CIE_ENABLE(x) (((x)&0x1)<<30)
+#define GET_DMA_CIE_ENABLE(x) (((x)&DMA_CIE_ENABLE)>>30)
+
+#define DMA_TD                (1<<29)
+#define SET_DMA_TD(x)         (((x)&0x1)<<29)
+#define GET_DMA_TD(x)         (((x)&DMA_TD)>>29)
+
+#define DMA_PL                (1<<28)	/* Peripheral Location */
+#define SET_DMA_PL(x)         (((x)&0x1)<<28)
+#define GET_DMA_PL(x)         (((x)&DMA_PL)>>28)
+
+#define EXTERNAL_PERIPHERAL    0
+#define INTERNAL_PERIPHERAL    1
+
+#define SET_DMA_PW(x)     (((x)&0x3)<<(26-DMA_CR_OFFSET))	/* Peripheral Width */
+#define DMA_PW_MASK       SET_DMA_PW(3)
+#define   PW_8                 0
+#define   PW_16                1
+#define   PW_32                2
+#define   PW_64                3
+/* FIXME: Add PW_128 support for 440GP DMA block */
+#define GET_DMA_PW(x)     (((x)&DMA_PW_MASK)>>(26-DMA_CR_OFFSET))
+
+#define DMA_DAI           (1<<(25-DMA_CR_OFFSET))	/* Destination Address Increment */
+#define SET_DMA_DAI(x)    (((x)&0x1)<<(25-DMA_CR_OFFSET))
+
+#define DMA_SAI           (1<<(24-DMA_CR_OFFSET))	/* Source Address Increment */
+#define SET_DMA_SAI(x)    (((x)&0x1)<<(24-DMA_CR_OFFSET))
+
+#define DMA_BEN           (1<<(23-DMA_CR_OFFSET))	/* Buffer Enable */
+#define SET_DMA_BEN(x)    (((x)&0x1)<<(23-DMA_CR_OFFSET))
+
+#define SET_DMA_TM(x)     (((x)&0x3)<<(21-DMA_CR_OFFSET))	/* Transfer Mode */
+#define DMA_TM_MASK       SET_DMA_TM(3)
+#define   TM_PERIPHERAL        0	/* Peripheral */
+#define   TM_RESERVED          1	/* Reserved */
+#define   TM_S_MM              2	/* Memory to Memory */
+#define   TM_D_MM              3	/* Device Paced Memory to Memory */
+#define GET_DMA_TM(x)     (((x)&DMA_TM_MASK)>>(21-DMA_CR_OFFSET))
+
+#define SET_DMA_PSC(x)    (((x)&0x3)<<(19-DMA_CR_OFFSET))	/* Peripheral Setup Cycles */
+#define DMA_PSC_MASK      SET_DMA_PSC(3)
+#define GET_DMA_PSC(x)    (((x)&DMA_PSC_MASK)>>(19-DMA_CR_OFFSET))
+
+#define SET_DMA_PWC(x)    (((x)&0x3F)<<(13-DMA_CR_OFFSET))	/* Peripheral Wait Cycles */
+#define DMA_PWC_MASK      SET_DMA_PWC(0x3F)
+#define GET_DMA_PWC(x)    (((x)&DMA_PWC_MASK)>>(13-DMA_CR_OFFSET))
+
+#define SET_DMA_PHC(x)    (((x)&0x7)<<(10-DMA_CR_OFFSET))	/* Peripheral Hold Cycles */
+#define DMA_PHC_MASK      SET_DMA_PHC(0x7)
+#define GET_DMA_PHC(x)    (((x)&DMA_PHC_MASK)>>(10-DMA_CR_OFFSET))
+
+#define DMA_ETD_OUTPUT     (1<<(9-DMA_CR_OFFSET))	/* EOT pin is a TC output */
+#define SET_DMA_ETD(x)     (((x)&0x1)<<(9-DMA_CR_OFFSET))
+
+#define DMA_TCE_ENABLE     (1<<(8-DMA_CR_OFFSET))
+#define SET_DMA_TCE(x)     (((x)&0x1)<<(8-DMA_CR_OFFSET))
+
+#define DMA_DEC            (1<<(2)	/* Address Decrement */
+#define SET_DMA_DEC(x)     (((x)&0x1)<<2)
+#define GET_DMA_DEC(x)     (((x)&DMA_DEC)>>2)
+
+/*
+ * Transfer Modes
+ * These modes are defined in a way that makes it possible to
+ * simply "or" in the value in the control register.
+ */
+
+#define DMA_MODE_MM		(SET_DMA_TM(TM_S_MM))	/* memory to memory */
+
+				/* Device-paced memory to memory, */
+				/* device is at source address    */
+#define DMA_MODE_MM_DEVATSRC	(DMA_TD | SET_DMA_TM(TM_D_MM))
+
+				/* Device-paced memory to memory,      */
+				/* device is at destination address    */
+#define DMA_MODE_MM_DEVATDST	(SET_DMA_TM(TM_D_MM))
+
+/* 405gp/440gp */
+#define SET_DMA_PREFETCH(x)   (((x)&0x3)<<(4-DMA_CR_OFFSET))	/* Memory Read Prefetch */
+#define DMA_PREFETCH_MASK      SET_DMA_PREFETCH(3)
+#define   PREFETCH_1           0	/* Prefetch 1 Double Word */
+#define   PREFETCH_2           1
+#define   PREFETCH_4           2
+#define GET_DMA_PREFETCH(x) (((x)&DMA_PREFETCH_MASK)>>(4-DMA_CR_OFFSET))
+
+#define DMA_PCE            (1<<(3-DMA_CR_OFFSET))	/* Parity Check Enable */
+#define SET_DMA_PCE(x)     (((x)&0x1)<<(3-DMA_CR_OFFSET))
+#define GET_DMA_PCE(x)     (((x)&DMA_PCE)>>(3-DMA_CR_OFFSET))
+
+/* stb3x */
+
+#define DMA_ECE_ENABLE (1<<5)
+#define SET_DMA_ECE(x) (((x)&0x1)<<5)
+#define GET_DMA_ECE(x) (((x)&DMA_ECE_ENABLE)>>5)
+
+#define DMA_TCD_DISABLE	(1<<4)
+#define SET_DMA_TCD(x) (((x)&0x1)<<4)
+#define GET_DMA_TCD(x) (((x)&DMA_TCD_DISABLE)>>4)
+
+typedef uint32_t sgl_handle_t;
+
+#ifdef CONFIG_PPC4xx_EDMA
+
+#define SGL_LIST_SIZE 4096
+#define DMA_PPC4xx_SIZE SGL_LIST_SIZE
+
+#define SET_DMA_PRIORITY(x)   (((x)&0x3)<<(6-DMA_CR_OFFSET))	/* DMA Channel Priority */
+#define DMA_PRIORITY_MASK SET_DMA_PRIORITY(3)
+#define PRIORITY_LOW           0
+#define PRIORITY_MID_LOW       1
+#define PRIORITY_MID_HIGH      2
+#define PRIORITY_HIGH          3
+#define GET_DMA_PRIORITY(x) (((x)&DMA_PRIORITY_MASK)>>(6-DMA_CR_OFFSET))
+
+/* 
+ * DMA Polarity Configuration Register
+ */
+#define DMAReq_ActiveLow(chan) (1<<(31-(chan*3)))
+#define DMAAck_ActiveLow(chan) (1<<(30-(chan*3)))
+#define EOT_ActiveLow(chan)    (1<<(29-(chan*3)))	/* End of Transfer */
+
+/*
+ * DMA Sleep Mode Register
+ */
+#define SLEEP_MODE_ENABLE (1<<21)
+
+/*
+ * DMA Status Register
+ */
+#define DMA_CS0           (1<<31)	/* Terminal Count has been reached */
+#define DMA_CS1           (1<<30)
+#define DMA_CS2           (1<<29)
+#define DMA_CS3           (1<<28)
+
+#define DMA_TS0           (1<<27)	/* End of Transfer has been requested */
+#define DMA_TS1           (1<<26)
+#define DMA_TS2           (1<<25)
+#define DMA_TS3           (1<<24)
+
+#define DMA_CH0_ERR       (1<<23)	/* DMA Chanel 0 Error */
+#define DMA_CH1_ERR       (1<<22)
+#define DMA_CH2_ERR       (1<<21)
+#define DMA_CH3_ERR       (1<<20)
+
+#define DMA_IN_DMA_REQ0   (1<<19)	/* Internal DMA Request is pending */
+#define DMA_IN_DMA_REQ1   (1<<18)
+#define DMA_IN_DMA_REQ2   (1<<17)
+#define DMA_IN_DMA_REQ3   (1<<16)
+
+#define DMA_EXT_DMA_REQ0  (1<<15)	/* External DMA Request is pending */
+#define DMA_EXT_DMA_REQ1  (1<<14)
+#define DMA_EXT_DMA_REQ2  (1<<13)
+#define DMA_EXT_DMA_REQ3  (1<<12)
+
+#define DMA_CH0_BUSY      (1<<11)	/* DMA Channel 0 Busy */
+#define DMA_CH1_BUSY      (1<<10)
+#define DMA_CH2_BUSY       (1<<9)
+#define DMA_CH3_BUSY       (1<<8)
+
+#define DMA_SG0            (1<<7)	/* DMA Channel 0 Scatter/Gather in progress */
+#define DMA_SG1            (1<<6)
+#define DMA_SG2            (1<<5)
+#define DMA_SG3            (1<<4)
+
+/*
+ * DMA SG Command Register
+ */
+#define SSG_ENABLE(chan)   	(1<<(31-chan))	/* Start Scatter Gather */
+#define SSG_MASK_ENABLE(chan)	(1<<(15-chan))	/* Enable writing to SSG0 bit */
+
+/*
+ * DMA Scatter/Gather Descriptor Bit fields 
+ */
+#define SG_LINK            (1<<31)	/* Link */
+#define SG_TCI_ENABLE      (1<<29)	/* Enable Terminal Count Interrupt */
+#define SG_ETI_ENABLE      (1<<28)	/* Enable End of Transfer Interrupt */
+#define SG_ERI_ENABLE      (1<<27)	/* Enable Error Interrupt */
+#define SG_COUNT_MASK       0xFFFF	/* Count Field */
+
+#define SET_DMA_CONTROL \
+ 		(SET_DMA_CIE_ENABLE(p_init->int_enable) | /* interrupt enable         */ \
+ 		SET_DMA_BEN(p_init->buffer_enable)     | /* buffer enable            */\
+		SET_DMA_ETD(p_init->etd_output)        | /* end of transfer pin      */ \
+	       	SET_DMA_TCE(p_init->tce_enable)        | /* terminal count enable    */ \
+                SET_DMA_PL(p_init->pl)                 | /* peripheral location      */ \
+                SET_DMA_DAI(p_init->dai)               | /* dest addr increment      */ \
+                SET_DMA_SAI(p_init->sai)               | /* src addr increment       */ \
+                SET_DMA_PRIORITY(p_init->cp)           |  /* channel priority        */ \
+                SET_DMA_PW(p_init->pwidth)             |  /* peripheral/bus width    */ \
+                SET_DMA_PSC(p_init->psc)               |  /* peripheral setup cycles */ \
+                SET_DMA_PWC(p_init->pwc)               |  /* peripheral wait cycles  */ \
+                SET_DMA_PHC(p_init->phc)               |  /* peripheral hold cycles  */ \
+                SET_DMA_PREFETCH(p_init->pf)              /* read prefetch           */)
+
+#define GET_DMA_POLARITY(chan) (DMAReq_ActiveLow(chan) | DMAAck_ActiveLow(chan) | EOT_ActiveLow(chan))
+
+#elif defined(CONFIG_STBXXX_DMA)		/* stb03xxx */
+
+#define DMA_PPC4xx_SIZE	4096
+
+/*
+ * DMA Status Register
+ */
+
+#define SET_DMA_PRIORITY(x)   (((x)&0x00800001))	/* DMA Channel Priority */
+#define DMA_PRIORITY_MASK	0x00800001
+#define   PRIORITY_LOW         	0x00000000
+#define   PRIORITY_MID_LOW     	0x00000001
+#define   PRIORITY_MID_HIGH    	0x00800000
+#define   PRIORITY_HIGH        	0x00800001
+#define GET_DMA_PRIORITY(x) (((((x)&DMA_PRIORITY_MASK) &0x00800000) >> 22 ) | (((x)&DMA_PRIORITY_MASK) &0x00000001))
+
+#define DMA_CS0           (1<<31)	/* Terminal Count has been reached */
+#define DMA_CS1           (1<<30)
+#define DMA_CS2           (1<<29)
+#define DMA_CS3           (1<<28)
+
+#define DMA_TS0           (1<<27)	/* End of Transfer has been requested */
+#define DMA_TS1           (1<<26)
+#define DMA_TS2           (1<<25)
+#define DMA_TS3           (1<<24)
+
+#define DMA_CH0_ERR       (1<<23)	/* DMA Chanel 0 Error */
+#define DMA_CH1_ERR       (1<<22)
+#define DMA_CH2_ERR       (1<<21)
+#define DMA_CH3_ERR       (1<<20)
+
+#define DMA_CT0		  (1<<19)	/* Chained transfere */
+
+#define DMA_IN_DMA_REQ0   (1<<18)	/* Internal DMA Request is pending */
+#define DMA_IN_DMA_REQ1   (1<<17)
+#define DMA_IN_DMA_REQ2   (1<<16)
+#define DMA_IN_DMA_REQ3   (1<<15)
+
+#define DMA_EXT_DMA_REQ0  (1<<14)	/* External DMA Request is pending */
+#define DMA_EXT_DMA_REQ1  (1<<13)
+#define DMA_EXT_DMA_REQ2  (1<<12)
+#define DMA_EXT_DMA_REQ3  (1<<11)
+
+#define DMA_CH0_BUSY      (1<<10)	/* DMA Channel 0 Busy */
+#define DMA_CH1_BUSY      (1<<9)
+#define DMA_CH2_BUSY       (1<<8)
+#define DMA_CH3_BUSY       (1<<7)
+
+#define DMA_CT1            (1<<6)	/* Chained transfere */
+#define DMA_CT2            (1<<5)
+#define DMA_CT3            (1<<4)
+
+#define DMA_CH_ENABLE (1<<7)
+#define SET_DMA_CH(x) (((x)&0x1)<<7)
+#define GET_DMA_CH(x) (((x)&DMA_CH_ENABLE)>>7)
+
+/* STBx25xxx dma unique */
+/* enable device port on a dma channel 
+ * example ext 0 on dma 1
+ */
+
+#define	SSP0_RECV	15
+#define	SSP0_XMIT	14
+#define EXT_DMA_0	12
+#define	SC1_XMIT	11
+#define SC1_RECV	10
+#define EXT_DMA_2	9 
+#define	EXT_DMA_3	8 
+#define SERIAL2_XMIT	7
+#define SERIAL2_RECV	6
+#define SC0_XMIT 	5
+#define	SC0_RECV	4
+#define	SERIAL1_XMIT	3 
+#define SERIAL1_RECV	2
+#define	SERIAL0_XMIT	1
+#define SERIAL0_RECV	0
+
+#define DMA_CHAN_0	1
+#define DMA_CHAN_1	2
+#define DMA_CHAN_2	3
+#define DMA_CHAN_3	4
+
+/* end STBx25xx */
+
+/*
+ * Bit 30 must be one for Redwoods, otherwise transfers may receive errors.
+ */
+#define DMA_CR_MB0 0x2
+
+#define SET_DMA_CONTROL \
+       		(SET_DMA_CIE_ENABLE(p_init->int_enable) |  /* interrupt enable         */ \
+		SET_DMA_ETD(p_init->etd_output)        |  /* end of transfer pin      */ \
+		SET_DMA_TCE(p_init->tce_enable)        |  /* terminal count enable    */ \
+		SET_DMA_PL(p_init->pl)                 |  /* peripheral location      */ \
+		SET_DMA_DAI(p_init->dai)               |  /* dest addr increment      */ \
+		SET_DMA_SAI(p_init->sai)               |  /* src addr increment       */ \
+		SET_DMA_PRIORITY(p_init->cp)           |  /* channel priority        */  \
+		SET_DMA_PW(p_init->pwidth)             |  /* peripheral/bus width    */ \
+		SET_DMA_PSC(p_init->psc)               |  /* peripheral setup cycles */ \
+		SET_DMA_PWC(p_init->pwc)               |  /* peripheral wait cycles  */ \
+		SET_DMA_PHC(p_init->phc)               |  /* peripheral hold cycles  */ \
+		SET_DMA_TCD(p_init->tcd_disable)	  |  /* TC chain mode disable   */ \
+		SET_DMA_ECE(p_init->ece_enable)	  |  /* ECE chanin mode enable  */ \
+		SET_DMA_CH(p_init->ch_enable)	|    /* Chain enable 	        */ \
+		DMA_CR_MB0				/* must be one */)
+
+#define GET_DMA_POLARITY(chan) chan
+
+#endif
+
+typedef struct {
+	unsigned short in_use;	/* set when channel is being used, clr when
+				 * available.
+				 */
+	/* 
+	 * Valid polarity settings:
+	 *   DMAReq_ActiveLow(n)
+	 *   DMAAck_ActiveLow(n)
+	 *   EOT_ActiveLow(n)
+	 *
+	 *   n is 0 to max dma chans
+	 */
+	unsigned int polarity;
+
+	char buffer_enable;	/* Boolean: buffer enable            */
+	char tce_enable;	/* Boolean: terminal count enable    */
+	char etd_output;	/* Boolean: eot pin is a tc output   */
+	char pce;		/* Boolean: parity check enable      */
+
+	/*
+	 * Peripheral location:
+	 * INTERNAL_PERIPHERAL (UART0 on the 405GP)
+	 * EXTERNAL_PERIPHERAL
+	 */
+	char pl;		/* internal/external peripheral      */
+
+	/*
+	 * Valid pwidth settings:
+	 *   PW_8
+	 *   PW_16
+	 *   PW_32
+	 *   PW_64
+	 */
+	unsigned int pwidth;
+
+	char dai;		/* Boolean: dst address increment   */
+	char sai;		/* Boolean: src address increment   */
+
+	/*
+	 * Valid psc settings: 0-3
+	 */
+	unsigned int psc;	/* Peripheral Setup Cycles         */
+
+	/*
+	 * Valid pwc settings:
+	 * 0-63
+	 */
+	unsigned int pwc;	/* Peripheral Wait Cycles          */
+
+	/*
+	 * Valid phc settings:
+	 * 0-7
+	 */
+	unsigned int phc;	/* Peripheral Hold Cycles          */
+
+	/*
+	 * Valid cp (channel priority) settings:
+	 *   PRIORITY_LOW
+	 *   PRIORITY_MID_LOW
+	 *   PRIORITY_MID_HIGH
+	 *   PRIORITY_HIGH
+	 */
+	unsigned int cp;	/* channel priority                */
+
+	/*
+	 * Valid pf (memory read prefetch) settings:
+	 *
+	 *   PREFETCH_1
+	 *   PREFETCH_2
+	 *   PREFETCH_4
+	 */
+	unsigned int pf;	/* memory read prefetch            */
+
+	/*
+	 * Boolean: channel interrupt enable
+	 * NOTE: for sgl transfers, only the last descriptor will be setup to
+	 * interrupt.
+	 */
+	char int_enable;
+
+	char shift;		/* easy access to byte_count shift, based on */
+	/* the width of the channel                  */
+
+	uint32_t control;	/* channel control word                      */
+
+	/* These variabled are used ONLY in single dma transfers              */
+	unsigned int mode;	/* transfer mode                     */
+	phys_addr_t addr;
+	char ce;		/* channel enable */
+#ifdef CONFIG_STB03xxx
+	char ch_enable;
+	char tcd_disable;
+	char ece_enable;
+	char td;		/* transfer direction */
+#endif
+
+} ppc_dma_ch_t;
+
+/*
+ * PPC44x DMA implementations have a slightly different
+ * descriptor layout.  Probably moved about due to the
+ * change to 64-bit addresses and link pointer. I don't
+ * know why they didn't just leave control_count after
+ * the dst_addr.
+ */
+#ifdef PPC4xx_DMA_64BIT
+typedef struct {
+	uint32_t control;
+	uint32_t control_count;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	phys_addr_t next;
+} ppc_sgl_t;
+#else
+typedef struct {
+	uint32_t control;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	uint32_t control_count;
+	uint32_t next;
+} ppc_sgl_t;
+#endif
+
+typedef struct {
+	unsigned int dmanr;
+	uint32_t control;	/* channel ctrl word; loaded from each descrptr */
+	uint32_t sgl_control;	/* LK, TCI, ETI, and ERI bits in sgl descriptor */
+	dma_addr_t dma_addr;	/* dma (physical) address of this list          */
+	ppc_sgl_t *phead;
+	dma_addr_t phead_dma;
+	ppc_sgl_t *ptail;
+	dma_addr_t ptail_dma;
+} sgl_list_info_t;
+
+typedef struct {
+	phys_addr_t *src_addr;
+	phys_addr_t *dst_addr;
+	phys_addr_t dma_src_addr;
+	phys_addr_t dma_dst_addr;
+} pci_alloc_desc_t;
+
+extern ppc_dma_ch_t dma_channels[];
+
+/*
+ * The DMA API are in ppc4xx_dma.c and ppc4xx_sgdma.c
+ */
+extern int ppc4xx_init_dma_channel(unsigned int, ppc_dma_ch_t *);
+extern int ppc4xx_get_channel_config(unsigned int, ppc_dma_ch_t *);
+extern int ppc4xx_set_channel_priority(unsigned int, unsigned int);
+extern unsigned int ppc4xx_get_peripheral_width(unsigned int);
+extern void ppc4xx_set_sg_addr(int, phys_addr_t);
+extern int ppc4xx_add_dma_sgl(sgl_handle_t, phys_addr_t, phys_addr_t, unsigned int);
+extern void ppc4xx_enable_dma_sgl(sgl_handle_t);
+extern void ppc4xx_disable_dma_sgl(sgl_handle_t);
+extern int ppc4xx_get_dma_sgl_residue(sgl_handle_t, phys_addr_t *, phys_addr_t *);
+extern int ppc4xx_delete_dma_sgl_element(sgl_handle_t, phys_addr_t *, phys_addr_t *);
+extern int ppc4xx_alloc_dma_handle(sgl_handle_t *, unsigned int, unsigned int);
+extern void ppc4xx_free_dma_handle(sgl_handle_t);
+extern int ppc4xx_get_dma_status(void);
+extern void ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr);
+extern void ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr);
+extern void ppc4xx_enable_dma(unsigned int dmanr);
+extern void ppc4xx_disable_dma(unsigned int dmanr);
+extern void ppc4xx_set_dma_count(unsigned int dmanr, unsigned int count);
+extern int ppc4xx_get_dma_residue(unsigned int dmanr);
+extern void ppc4xx_set_dma_addr2(unsigned int dmanr, phys_addr_t src_dma_addr,
+				 phys_addr_t dst_dma_addr);
+extern int ppc4xx_enable_dma_interrupt(unsigned int dmanr);
+extern int ppc4xx_disable_dma_interrupt(unsigned int dmanr);
+extern int ppc4xx_clr_dma_status(unsigned int dmanr);
+extern int ppc4xx_map_dma_port(unsigned int dmanr, unsigned int ocp_dma,short dma_chan);
+extern int ppc4xx_disable_dma_port(unsigned int dmanr, unsigned int ocp_dma,short dma_chan);
+extern int ppc4xx_set_dma_mode(unsigned int dmanr, unsigned int mode);
+
+/* These are in kernel/dma.c: */
+
+/* reserve a DMA channel */
+extern int request_dma(unsigned int dmanr, const char *device_id);
+/* release it again */
+extern void free_dma(unsigned int dmanr);
+#endif
+#endif				/* __KERNEL__ */
