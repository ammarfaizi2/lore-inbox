Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUH0Xib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUH0Xib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUH0Xib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:38:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45303 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267170AbUH0X2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:28:20 -0400
Message-ID: <412FC375.8010601@mvista.com>
Date: Fri, 27 Aug 2004 16:27:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmk@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH,SERIAL] MPSC driver patch
Content-Type: multipart/mixed;
 boundary="------------040602030604000806050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040602030604000806050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell,

Please review and consider for inclusion, the following patch for the 
Marvell MultiProtocol Serial Controller (MPSC).  This ctlr is on a 
series of host bridges (and other things) for PPC and MIPS processors.

I tried to design the driver to keep the processor/platform-specific 
code out of the main driver code.  I made an additional file for ppc32 
specific code.  If/when someone with a mips platform wants to use it, 
they can create a mpsc_mips file.

The ctlr operates similar to a typical network controller with send and 
receive rings.  Unfortunately there are many errata so you will see some 
"unusual" things in the code.  For example:
a) An erratum prevents the reading of several registers on the ctlr 
(writing is okay).  To work around that, a local copy of what the 
registers are is kept and special macros are used to access those 
mirrored values.
b) Another erratum says that the MPSC cannot be used to access cache 
coherent memory (and all of the systems I use are coherent).  However, 
it seems to work okay as long as there are no snoop hits so there are 
macros in the code to manually manage the caches to prevent snoop hits.  
Each macro checks a flag to see if the manual cache mgmt is necessary as 
not all versions have the erratum.

The driver seems to work well but more testing is needed and it is 
lacking KGDB support.  I will get to both of those in time.

One final thing, I need a minor number assignment for the 204 major 
(Low-density serial ports).  How do I do that?  (I'm using 5 as a place 
holder.)

Thank you,

Mark
--


--------------040602030604000806050809
Content-Type: text/plain;
 name="mpsc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpsc.patch"

diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	2004-08-27 11:21:34 -07:00
+++ b/drivers/serial/Kconfig	2004-08-27 11:21:34 -07:00
@@ -726,4 +726,18 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called icom.
 
+config SERIAL_MPSC
+	bool "Marvell MPSC serial port support"
+	depends on PPC32 && MV64X60
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the Marvell MPSC serial controller.
+
+config SERIAL_MPSC_CONSOLE
+	bool "Support for console on Marvell MPSC serial port"
+	depends on SERIAL_MPSC
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you want to support a serial console on a Marvell MPSC.
+
 endmenu
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	2004-08-27 11:21:34 -07:00
+++ b/drivers/serial/Makefile	2004-08-27 11:21:34 -07:00
@@ -41,3 +41,4 @@
 obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += sn_console.o
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
+obj-$(CONFIG_SERIAL_MPSC) += mpsc/
diff -Nru a/drivers/serial/mpsc/Makefile b/drivers/serial/mpsc/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/mpsc/Makefile	2004-08-27 11:21:34 -07:00
@@ -0,0 +1,6 @@
+#
+# Make file for the Marvell MPSC driver.
+#
+
+obj-$(CONFIG_SERIAL_MPSC)	+= mpsc.o
+obj-$(CONFIG_PPC32)		+= mpsc_ppc32.o
diff -Nru a/drivers/serial/mpsc/mpsc.c b/drivers/serial/mpsc/mpsc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/mpsc/mpsc.c	2004-08-27 11:21:34 -07:00
@@ -0,0 +1,1472 @@
+/*
+ * drivers/serial/mpsc/mpsc.c
+ *
+ * Generic driver for the MPSC (UART mode) on Marvell parts (e.g., GT64240,
+ * GT64260, MV64340, MV64360, GT96100, ... ).
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * Based on an old MPSC driver that was in the linuxppc tree.  It appears to
+ * have been created by Chris Zankel (formerly of MontaVista) but there
+ * is no proper Copyright so I'm not sure.  Apparently, parts were also
+ * taken from PPCBoot (now U-Boot).  Also based on drivers/serial/8250.c
+ * by Russell King.
+ *
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+/*
+ * The MPSC interface is much like a typical network controller's interface.
+ * That is, you set up separate rings of descriptors for transmitting and
+ * receiving data.  There is also a pool of buffers with (one buffer per
+ * descriptor) that incoming data are dma'd into or outgoing data are dma'd
+ * out of.
+ *
+ * The MPSC requires two other controllers to be able to work.  The Baud Rate
+ * Generator (BRG) provides a clock at programmable frequencies which determines
+ * the baud rate.  The Serial DMA Controller (SDMA) takes incoming data from the
+ * MPSC and DMA's it into memory or DMA's outgoing data and passes it to the
+ * MPSC.  It is actually the SDMA interrupt that the driver uses to keep the
+ * transmit and receive "engines" going (i.e., indicate data has been
+ * transmitted or received).
+ *
+ * NOTES:
+ *
+ * 1) Some chips have an erratum where several regs cannot be
+ * read.  To work around that, we keep a local copy of those regs in
+ * 'mpsc_port_info' and use the *_M or *_S macros when accessing those regs.
+ *
+ * 2) Some chips have an erratum where the chip will hang when the SDMA ctlr
+ * accesses system mem in a cache coherent region.  This *should* be a
+ * show-stopper when coherency is turned on but it seems to work okay as
+ * long as there are no snoop hits.  Therefore, there are explicit cache
+ * management macros to manage the cache ensuring there are no snoop hits.
+ *
+ * 3) AFAICT, hardware flow control isn't supported by the controller --MAG.
+ */
+
+#include "mpsc.h"
+
+/*
+ * Define how this driver is known to the outside (we've been assigned a
+ * range on the "Low-density serial ports" major).
+ */
+#define MPSC_MAJOR		204
+#define MPSC_MINOR_START	5	/* XXXX */
+#define	MPSC_DRIVER_NAME	"MPSC"
+#define	MPSC_DEVFS_NAME		"ttym/"
+#define	MPSC_DEV_NAME		"ttyM"
+#define	MPSC_VERSION		"1.00"
+
+static struct mpsc_port_info mpsc_ports[MPSC_NUM_CTLRS];
+static struct mpsc_shared_regs mpsc_shared_regs;
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+/*
+ ******************************************************************************
+ *
+ * Baud Rate Generator Routines (BRG)
+ *
+ ******************************************************************************
+ */
+static void mpsc_brg_init(struct mpsc_port_info *pi, u32 clk_src)
+{
+	if (pi->brg_can_tune) {
+		MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 25, 0);
+	}
+
+	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 4, 18, clk_src);
+	MPSC_MOD_FIELD(pi, brg, BRG_BTR, 16, 0, 0);
+	return;
+}
+
+static void mpsc_brg_enable(struct mpsc_port_info *pi)
+{
+	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 16, 1);
+	return;
+}
+
+static void mpsc_brg_disable(struct mpsc_port_info *pi)
+{
+	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 1, 16, 0);
+	return;
+}
+
+static inline void mpsc_set_baudrate(struct mpsc_port_info *pi, u32 baud)
+{
+	/*
+	 * To set the baud, we adjust the CDV field in the BRG_BCR reg.
+	 * From manual: Baud = clk / ((CDV+1)*2) ==> CDV = (clk / (baud*2)) - 1.
+	 * However, the input clock is divided by 16 in the MPSC b/c of how
+	 * 'MPSC_MMCRH' was set up so we have to divide the 'clk' used in our
+	 * calculation by 16 to account for that.  So the real calculation
+	 * that accounts for the way the mpsc is set up is:
+	 * CDV = (clk / (baud*2*16)) - 1 ==> CDV = (clk / (baud << 5)) - 1.
+	 */
+	u32 cdv = (pi->port.uartclk / (baud << 5)) - 1;
+
+	mpsc_brg_disable(pi);
+	MPSC_MOD_FIELD_M(pi, brg, BRG_BCR, 16, 0, cdv);
+	mpsc_brg_enable(pi);
+
+	return;
+}
+
+/*
+ ******************************************************************************
+ *
+ * Serial DMA Routines (SDMA)
+ *
+ ******************************************************************************
+ */
+
+static void mpsc_sdma_burstsize(struct mpsc_port_info *pi, u32 burst_size)
+{
+	u32 v;
+
+	DBG("mpsc_sdma_burstsize[%d]: burst_size: %d\n",
+	    pi->port.line, burst_size);
+
+	burst_size >>= 3; /* Divide by 8 b/c reg values are 8-byte chunks */
+
+	if (burst_size < 2)
+		v = 0x0;	/* 1 64-bit word */
+	else if (burst_size < 4)
+		v = 0x1;	/* 2 64-bit words */
+	else if (burst_size < 8)
+		v = 0x2;	/* 4 64-bit words */
+	else
+		v = 0x3;	/* 8 64-bit words */
+
+	MPSC_MOD_FIELD(pi, sdma, SDMA_SDC, 2, 12, v);
+	return;
+}
+
+static void mpsc_sdma_init(struct mpsc_port_info *pi, u32 burst_size)
+{
+	DBG("mpsc_sdma_init[%d]: burst_size: %d\n", pi->port.line, burst_size);
+
+	MPSC_MOD_FIELD(pi, sdma, SDMA_SDC, 10, 0, 0x03f);
+	mpsc_sdma_burstsize(pi, burst_size);
+	return;
+}
+
+static inline u32 mpsc_sdma_intr_mask(struct mpsc_port_info *pi, u32 mask)
+{
+	u32 old, v;
+
+	DBG("mpsc_sdma_intr_mask[%d]: mask: 0x%x\n", pi->port.line, mask);
+
+	old = v = MPSC_READ_S(pi, sdma_intr, SDMA_INTR_MASK);
+	mask &= 0xf;
+	if (pi->port.line)
+		mask <<= 8;
+	v &= ~mask;
+	MPSC_WRITE_S(pi, sdma_intr, SDMA_INTR_MASK, v);
+
+	if (pi->port.line)
+		old >>= 8;
+	return old & 0xf;
+}
+
+static inline void mpsc_sdma_intr_unmask(struct mpsc_port_info *pi, u32 mask)
+{
+	u32 v;
+
+	DBG("mpsc_sdma_intr_unmask[%d]: mask: 0x%x\n", pi->port.line, mask);
+
+	v = MPSC_READ_S(pi, sdma_intr, SDMA_INTR_MASK);
+	mask &= 0xf;
+	if (pi->port.line)
+		mask <<= 8;
+	v |= mask;
+	MPSC_WRITE_S(pi, sdma_intr, SDMA_INTR_MASK, v);
+	return;
+}
+
+static inline void mpsc_sdma_intr_ack(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_sdma_intr_ack[%d]: Acknowledging IRQ\n", pi->port.line);
+	MPSC_WRITE(pi, sdma_intr, SDMA_INTR_CAUSE, 0);
+	return;
+}
+
+static inline void
+mpsc_sdma_set_rx_ring(struct mpsc_port_info *pi, struct mpsc_rx_desc *rxre_p)
+{
+	DBG("mpsc_sdma_set_rx_ring[%d]: rxre_p: 0x%x\n",
+	    pi->port.line, (u32) rxre_p);
+
+	MPSC_WRITE(pi, sdma, SDMA_SCRDP, (u32) rxre_p);
+	return;
+}
+
+static inline void
+mpsc_sdma_set_tx_ring(struct mpsc_port_info *pi,
+		      volatile struct mpsc_tx_desc *txre_p)
+{
+	MPSC_WRITE(pi, sdma, SDMA_SFTDP, (u32) txre_p);
+	MPSC_WRITE(pi, sdma, SDMA_SCTDP, (u32) txre_p);
+	return;
+}
+
+static inline void mpsc_sdma_cmd(struct mpsc_port_info *pi, u32 val)
+{
+	u32 v;
+
+	v = MPSC_READ(pi, sdma, SDMA_SDCM);
+	if (val)
+		v |= val;
+	else
+		v = 0;
+	MPSC_WRITE(pi, sdma, SDMA_SDCM, v);
+	return;
+}
+
+static inline void mpsc_sdma_start_tx(struct mpsc_port_info *pi)
+{
+	volatile struct mpsc_tx_desc *txre, *txre_p;
+
+	/* If tx isn't running & there's a desc ready to go, start it */
+	if (!pi->txr_running) {
+		txre = (volatile struct mpsc_tx_desc *)(pi->txr +
+							(pi->txr_tail *
+							 MPSC_TXRE_SIZE));
+		MPSC_CACHE_INVALIDATE(pi, (u32) txre,
+				      (u32) txre + MPSC_TXRE_SIZE);
+
+		if (be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O) {
+			txre_p = (struct mpsc_tx_desc *)(pi->txr_p +
+							 (pi->txr_tail *
+							  MPSC_TXRE_SIZE));
+
+			mpsc_sdma_set_tx_ring(pi, txre_p);
+			mpsc_sdma_cmd(pi, SDMA_SDCM_STD | SDMA_SDCM_TXD);
+
+			pi->txr_running = 1;
+		}
+	}
+
+	return;
+}
+
+static inline void mpsc_sdma_stop(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_sdma_stop[%d]: Stopping SDMA\n", pi->port.line);
+
+	/* Abort any SDMA transfers */
+	mpsc_sdma_cmd(pi, 0);
+	mpsc_sdma_cmd(pi, SDMA_SDCM_AR | SDMA_SDCM_AT);
+
+	/* Clear the SDMA current and first TX and RX pointers */
+	mpsc_sdma_set_tx_ring(pi, 0);
+	mpsc_sdma_set_rx_ring(pi, 0);
+
+	/* Disable interrupts */
+	mpsc_sdma_intr_mask(pi, 0xf);
+	mpsc_sdma_intr_ack(pi);
+	udelay(1000);
+
+	return;
+}
+
+static inline uint mpsc_sdma_tx_active(struct mpsc_port_info *pi)
+{
+	return MPSC_READ(pi, sdma, SDMA_SDCM) & SDMA_SDCM_TXD;
+}
+
+/*
+ ******************************************************************************
+ *
+ * Multi-Protocol Serial Controller Routines (MPSC)
+ *
+ ******************************************************************************
+ */
+
+static void mpsc_hw_init(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_hw_init[%d]: Initializing hardware\n", pi->port.line);
+
+	/* Set up clock routing */
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_MRR, 3, 0, 0);
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_MRR, 3, 6, 0);
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_RCRR, 4, 0, 0);
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_RCRR, 4, 8, 1);
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_TCRR, 4, 0, 0);
+	MPSC_MOD_FIELD_S(pi, mpsc_routing, MPSC_TCRR, 4, 8, 1);
+
+	/* Put MPSC in UART mode & enabel Tx/Rx egines */
+	MPSC_WRITE(pi, mpsc, MPSC_MMCRL, 0x000004c4);
+
+	/* No preamble, 16x divider, low-latency,  */
+	MPSC_WRITE(pi, mpsc, MPSC_MMCRH, 0x04400400);
+
+	MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0);
+	MPSC_WRITE_M(pi, mpsc, MPSC_CHR_2, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_3, pi->mpsc_max_idle);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_4, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_5, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_6, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_7, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_8, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_9, 0);
+	MPSC_WRITE(pi, mpsc, MPSC_CHR_10, 0);
+
+	return;
+}
+
+static inline void mpsc_enter_hunt(struct mpsc_port_info *pi)
+{
+	u32 v;
+
+	DBG("mpsc_enter_hunt[%d]: Hunting...\n", pi->port.line);
+
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 1, 31, 1);
+
+	/* If erratum prevents reading CHR_2, just delay for a while */
+	if (pi->mirror_regs) {
+		udelay(100);
+	} else
+		do {
+			v = MPSC_READ_M(pi, mpsc, MPSC_CHR_2);
+		} while (v & MPSC_CHR_2_EH);
+
+	return;
+}
+
+static inline void mpsc_freeze(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_freeze[%d]: Freezing\n", pi->port.line);
+
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 9, 1);
+	return;
+}
+
+static inline void mpsc_unfreeze(struct mpsc_port_info *pi)
+{
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 9, 0);
+
+	DBG("mpsc_unfreeze[%d]: Unfrozen\n", pi->port.line);
+	return;
+}
+
+static inline void mpsc_set_char_length(struct mpsc_port_info *pi, u32 len)
+{
+	DBG("mpsc_set_char_length[%d]: char len: %d\n", pi->port.line, len);
+
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 2, 12, len);
+	return;
+}
+
+static inline void mpsc_set_stop_bit_length(struct mpsc_port_info *pi, u32 len)
+{
+	DBG("mpsc_set_stop_bit_length[%d]: stop bits: %d\n", pi->port.line,
+	    len);
+
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_MPCR, 1, 14, len);
+	return;
+}
+
+static inline void mpsc_set_parity(struct mpsc_port_info *pi, u32 p)
+{
+	DBG("mpsc_set_parity[%d]: parity bits: 0x%x\n", pi->port.line, p);
+
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 2, 2, p);	/* TPM */
+	MPSC_MOD_FIELD_M(pi, mpsc, MPSC_CHR_2, 2, 18, p);	/* RPM */
+	return;
+}
+
+/*
+ ******************************************************************************
+ *
+ * Driver Init Routines
+ *
+ ******************************************************************************
+ */
+
+static void mpsc_init_hw(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_init_hw[%d]: Initializing\n", pi->port.line);
+
+	mpsc_brg_init(pi, pi->brg_clk_src);
+	mpsc_brg_enable(pi);
+	mpsc_sdma_init(pi, dma_get_cache_alignment());	/* burst a cacheline */
+	mpsc_sdma_stop(pi);
+	mpsc_hw_init(pi);
+
+	return;
+}
+
+static int mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
+{
+	int rc = 0;
+	static void mpsc_free_ring_mem(struct mpsc_port_info *pi);
+
+	DBG("mpsc_alloc_ring_mem[%d]: Allocating ring mem\n", pi->port.line);
+
+	if (!pi->dma_region) {
+		if (!dma_supported(pi->port.dev, 0xffffffff)) {
+			printk(KERN_ERR "MPSC: inadequate DMA support\n");
+			rc = -ENXIO;
+		} else if ((pi->dma_region = dma_alloc_coherent(pi->port.dev,
+			MPSC_DMA_ALLOC_SIZE, &pi->dma_region_p, GFP_KERNEL))
+			== NULL) {
+
+			printk(KERN_ERR "MPSC: can't alloc Desc region\n");
+			rc = -ENOMEM;
+		} else
+			MPSC_CACHE_INVALIDATE(pi, pi->dma_region,
+					      pi->dma_region +
+					      MPSC_DMA_ALLOC_SIZE);
+	}
+
+	return rc;
+}
+
+static void mpsc_free_ring_mem(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_free_ring_mem[%d]: Freeing ring mem\n", pi->port.line);
+
+	if (pi->dma_region) {
+		MPSC_CACHE_INVALIDATE(pi, pi->dma_region,
+				      pi->dma_region + MPSC_DMA_ALLOC_SIZE);
+		dma_free_coherent(pi->port.dev, MPSC_DMA_ALLOC_SIZE,
+				  pi->dma_region, pi->dma_region_p);
+
+		pi->dma_region = NULL;
+		pi->dma_region_p = (dma_addr_t) NULL;
+	}
+
+	return;
+}
+
+static void mpsc_init_rings(struct mpsc_port_info *pi)
+{
+	struct mpsc_rx_desc *rxre;
+	struct mpsc_tx_desc *txre;
+	dma_addr_t dp, dp_p;
+	u8 *bp, *bp_p;
+	int i;
+
+	DBG("mpsc_init_rings[%d]: Initializing rings\n", pi->port.line);
+
+	BUG_ON(pi->dma_region == NULL);
+
+	memset(pi->dma_region, 0, MPSC_DMA_ALLOC_SIZE);
+
+	/*
+	 * Descriptors & buffers are multiples of cacheline size and must be
+	 * cacheline aligned.
+	 */
+	dp = ALIGN((u32) pi->dma_region, dma_get_cache_alignment());
+	dp_p = ALIGN((u32) pi->dma_region_p, dma_get_cache_alignment());
+
+	/*
+	 * Partition dma region into rx ring descriptor, rx buffers,
+	 * tx ring descriptors, and tx buffers.
+	 */
+	pi->rxr = dp;
+	pi->rxr_p = dp_p;
+	dp += MPSC_RXR_SIZE;
+	dp_p += MPSC_RXR_SIZE;
+
+	pi->rxb = (u8 *) dp;
+	pi->rxb_p = (u8 *) dp_p;
+	dp += MPSC_RXB_SIZE;
+	dp_p += MPSC_RXB_SIZE;
+
+	pi->rxr_posn = 0;
+
+	pi->txr = dp;
+	pi->txr_p = dp_p;
+	dp += MPSC_TXR_SIZE;
+	dp_p += MPSC_TXR_SIZE;
+
+	pi->txb = (u8 *) dp;
+	pi->txb_p = (u8 *) dp_p;
+
+	pi->txr_running = 0;
+	pi->txr_head = 0;
+	pi->txr_tail = 0;
+
+	/* Init rx ring descriptors */
+	dp = pi->rxr;
+	dp_p = pi->rxr_p;
+	bp = pi->rxb;
+	bp_p = pi->rxb_p;
+
+	for (i = 0; i < MPSC_RXR_ENTRIES; i++) {
+		rxre = (struct mpsc_rx_desc *)dp;
+
+		rxre->bufsize = cpu_to_be16(MPSC_RXBE_SIZE);
+		rxre->bytecnt = cpu_to_be16(0);
+		rxre->cmdstat = cpu_to_be32(SDMA_DESC_CMDSTAT_O |
+					    SDMA_DESC_CMDSTAT_EI |
+					    SDMA_DESC_CMDSTAT_F |
+					    SDMA_DESC_CMDSTAT_L);
+		rxre->link = cpu_to_be32(dp_p + MPSC_RXRE_SIZE);
+		rxre->buf_ptr = cpu_to_be32(bp_p);
+		MPSC_CACHE_FLUSH(pi, dp, dp + MPSC_RXRE_SIZE);
+		MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_RXBE_SIZE);
+
+		dp += MPSC_RXRE_SIZE;
+		dp_p += MPSC_RXRE_SIZE;
+		bp += MPSC_RXBE_SIZE;
+		bp_p += MPSC_RXBE_SIZE;
+	}
+	rxre->link = cpu_to_be32(pi->rxr_p);	/* Wrap last back to first */
+	MPSC_CACHE_FLUSH(pi, dp, dp + MPSC_RXRE_SIZE);
+
+	/* Init tx ring descriptors */
+	dp = pi->txr;
+	dp_p = pi->txr_p;
+	bp = pi->txb;
+	bp_p = pi->txb_p;
+
+	for (i = 0; i < MPSC_TXR_ENTRIES; i++) {
+		txre = (struct mpsc_tx_desc *)dp;
+
+		txre->link = cpu_to_be32(dp_p + MPSC_TXRE_SIZE);
+		txre->buf_ptr = cpu_to_be32(bp_p);
+		MPSC_CACHE_FLUSH(pi, dp, dp + MPSC_TXRE_SIZE);
+
+		dp += MPSC_TXRE_SIZE;
+		dp_p += MPSC_TXRE_SIZE;
+		bp += MPSC_TXBE_SIZE;
+		bp_p += MPSC_TXBE_SIZE;
+	}
+	txre->link = cpu_to_be32(pi->txr_p);	/* Wrap last back to first */
+	MPSC_CACHE_FLUSH(pi, dp, dp + MPSC_TXRE_SIZE);
+
+	return;
+}
+
+static void mpsc_uninit_rings(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_uninit_rings[%d]: Uninitializing rings\n", pi->port.line);
+
+	BUG_ON(pi->dma_region == NULL);
+
+	pi->rxr = 0;
+	pi->rxr_p = 0;
+	pi->rxb = NULL;
+	pi->rxb_p = NULL;
+	pi->rxr_posn = 0;
+
+	pi->txr = 0;
+	pi->txr_p = 0;
+	pi->txb = NULL;
+	pi->txb_p = NULL;
+	pi->txr_running = 0;
+	pi->txr_head = 0;
+	pi->txr_tail = 0;
+
+	return;
+}
+
+static int mpsc_make_ready(struct mpsc_port_info *pi)
+{
+	int rc;
+
+	DBG("mpsc_make_ready[%d]: Making cltr ready\n", pi->port.line);
+
+	if (!pi->ready) {
+		mpsc_init_hw(pi);
+		if ((rc = mpsc_alloc_ring_mem(pi)))
+			return rc;
+		mpsc_init_rings(pi);
+		pi->ready = 1;
+	}
+
+	return 0;
+}
+
+/*
+ ******************************************************************************
+ *
+ * Interrupt Handling Routines
+ *
+ ******************************************************************************
+ */
+
+static inline int mpsc_rx_intr(struct mpsc_port_info *pi, struct pt_regs *regs)
+{
+	volatile struct mpsc_rx_desc *rxre;
+	struct tty_struct *tty = pi->port.info->tty;
+	u32 cmdstat, bytes_in;
+	u8 *bp;
+	int rc = 0;
+	static void mpsc_start_rx(struct mpsc_port_info *pi);
+
+	DBG("mpsc_rx_intr[%d]: Handling Rx intr\n", pi->port.line);
+
+	rxre = (volatile struct mpsc_rx_desc *)(pi->rxr +
+						(pi->rxr_posn *
+						 MPSC_RXRE_SIZE));
+	MPSC_CACHE_INVALIDATE(pi, (u32) rxre, (u32) rxre + MPSC_RXRE_SIZE);
+
+	/*
+	 * Loop through Rx descriptors handling ones that have been completed.
+	 */
+	while (!((cmdstat = be32_to_cpu(rxre->cmdstat)) & SDMA_DESC_CMDSTAT_O)){
+		bytes_in = be16_to_cpu(rxre->bytecnt);
+
+		if (unlikely((tty->flip.count + bytes_in) >= TTY_FLIPBUF_SIZE)){
+			tty->flip.work.func((void *)tty);
+
+			if ((tty->flip.count + bytes_in) >= TTY_FLIPBUF_SIZE) {
+				/* Take what we can, throw away the rest */
+				bytes_in = TTY_FLIPBUF_SIZE - tty->flip.count;
+				cmdstat &= ~SDMA_DESC_CMDSTAT_PE;
+			}
+		}
+
+		bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE);
+		MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_RXBE_SIZE);
+
+		/*
+		 * Other than for parity error, the manual provides little
+		 * info on what data will be in a frame flagged by any of
+		 * these errors.  For parity error, it is the last byte in
+		 * the buffer that had the error.  As for the rest, I guess
+		 * we'll assume there is no data in the buffer.
+		 * If there is...it gets lost.
+		 */
+		if (cmdstat & (SDMA_DESC_CMDSTAT_BR | SDMA_DESC_CMDSTAT_FR |
+			       SDMA_DESC_CMDSTAT_OR)) {
+
+			pi->port.icount.rx++;
+
+			if (cmdstat & SDMA_DESC_CMDSTAT_BR) {	/* Break */
+				pi->port.icount.brk++;
+
+				if (uart_handle_break(&pi->port))
+					goto next_frame;
+			} else if (cmdstat & SDMA_DESC_CMDSTAT_FR)/* Framing */
+				pi->port.icount.frame++;
+			else if (cmdstat & SDMA_DESC_CMDSTAT_OR) /* Overrun */
+				pi->port.icount.overrun++;
+
+			cmdstat &= pi->port.read_status_mask;
+
+			if (!(cmdstat & pi->port.ignore_status_mask)) {
+				if (cmdstat & SDMA_DESC_CMDSTAT_BR)
+					*tty->flip.flag_buf_ptr = TTY_BREAK;
+				else if (cmdstat & SDMA_DESC_CMDSTAT_FR)
+					*tty->flip.flag_buf_ptr = TTY_FRAME;
+				else if (cmdstat & SDMA_DESC_CMDSTAT_OR)
+					*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+
+				tty->flip.flag_buf_ptr++;
+				*tty->flip.char_buf_ptr = '\0';
+				tty->flip.char_buf_ptr++;
+				tty->flip.count++;
+			}
+		} else {
+			if (uart_handle_sysrq_char(&pi->port, *bp, regs)) {
+				bp++;
+				bytes_in--;
+			}
+
+			memcpy(tty->flip.char_buf_ptr, bp, bytes_in);
+			memset(tty->flip.flag_buf_ptr, TTY_NORMAL, bytes_in);
+
+			tty->flip.char_buf_ptr += bytes_in;
+			tty->flip.flag_buf_ptr += bytes_in;
+			tty->flip.count += bytes_in;
+			pi->port.icount.rx += bytes_in;
+
+			cmdstat &= SDMA_DESC_CMDSTAT_PE;
+
+			if (cmdstat) {	/* Parity */
+				pi->port.icount.parity++;
+
+				if (!(cmdstat & pi->port.read_status_mask))
+					*(tty->flip.flag_buf_ptr - 1) =
+					    TTY_FRAME;
+			}
+		}
+
+	      next_frame:
+		rxre->bytecnt = cpu_to_be16(0);
+		wmb();
+		rxre->cmdstat = cpu_to_be32(SDMA_DESC_CMDSTAT_O |
+					    SDMA_DESC_CMDSTAT_EI |
+					    SDMA_DESC_CMDSTAT_F |
+					    SDMA_DESC_CMDSTAT_L);
+		MPSC_CACHE_FLUSH(pi, (u32) rxre, (u32) rxre + MPSC_RXRE_SIZE);
+
+		/* Advance to next descriptor */
+		pi->rxr_posn = (pi->rxr_posn + 1) & (MPSC_RXR_ENTRIES - 1);
+		rxre = (volatile struct mpsc_rx_desc *)(pi->rxr +
+							(pi->rxr_posn *
+							 MPSC_RXRE_SIZE));
+		MPSC_CACHE_INVALIDATE(pi, (u32) rxre,
+				      (u32) rxre + MPSC_RXRE_SIZE);
+
+		rc = 1;
+	}
+
+	/* Restart rx engine, if its stopped */
+	if ((MPSC_READ(pi, sdma, SDMA_SDCM) & SDMA_SDCM_ERD) == 0) {
+		mpsc_start_rx(pi);
+	}
+
+	tty_flip_buffer_push(tty);
+	return rc;
+}
+
+static inline void
+mpsc_setup_tx_desc(struct mpsc_port_info *pi, u32 count, u32 intr)
+{
+	volatile struct mpsc_tx_desc *txre;
+
+	txre = (volatile struct mpsc_tx_desc *)(pi->txr +
+						(pi->txr_head *
+						 MPSC_TXRE_SIZE));
+	MPSC_CACHE_INVALIDATE(pi, (u32) txre, (u32) txre + MPSC_TXRE_SIZE);
+
+	txre->bytecnt = cpu_to_be16(count);
+	txre->shadow = txre->bytecnt;
+	wmb();			/* ensure cmdstat is last field updated */
+	txre->cmdstat = cpu_to_be32(SDMA_DESC_CMDSTAT_O | SDMA_DESC_CMDSTAT_F |
+				    SDMA_DESC_CMDSTAT_L | ((intr) ?
+							   SDMA_DESC_CMDSTAT_EI
+							   : 0));
+	MPSC_CACHE_FLUSH(pi, (u32) txre, (u32) txre + MPSC_TXRE_SIZE);
+
+	return;
+}
+
+static inline void mpsc_copy_tx_data(struct mpsc_port_info *pi)
+{
+	struct circ_buf *xmit = &pi->port.info->xmit;
+	u8 *bp;
+	u32 i;
+
+	/* Make sure the desc ring isn't full */
+	while (CIRC_CNT(pi->txr_head, pi->txr_tail, MPSC_TXR_ENTRIES) <
+	       (MPSC_TXR_ENTRIES - 1)) {
+		if (pi->port.x_char) {
+			/*
+			 * Ideally, we should use the TCS field in
+			 * CHR_1 to put the x_char out immediately but
+			 * errata prevents us from being able to read
+			 * CHR_2 to know that its safe to write to
+			 * CHR_1.  Instead, just put it in-band with
+			 * all the other Tx data.
+			 */
+			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
+			MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_TXBE_SIZE);
+			*bp = pi->port.x_char;
+			pi->port.x_char = 0;
+			i = 1;
+		} else if (!uart_circ_empty(xmit)
+			   && !uart_tx_stopped(&pi->port)) {
+			i = MIN(MPSC_TXBE_SIZE, uart_circ_chars_pending(xmit));
+			i = MIN(i, CIRC_CNT_TO_END(xmit->head, xmit->tail,
+						   UART_XMIT_SIZE));
+			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
+			MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_TXBE_SIZE);
+			memcpy(bp, &xmit->buf[xmit->tail], i);
+			xmit->tail = (xmit->tail + i) & (UART_XMIT_SIZE - 1);
+
+			if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+				uart_write_wakeup(&pi->port);
+		} else {	/* All tx data copied into ring bufs */
+			return;
+		}
+
+		MPSC_CACHE_FLUSH(pi, bp, bp + MPSC_TXBE_SIZE);
+		mpsc_setup_tx_desc(pi, i, 1);
+
+		/* Advance to next descriptor */
+		pi->txr_head = (pi->txr_head + 1) & (MPSC_TXR_ENTRIES - 1);
+	}
+
+	return;
+}
+
+static inline int mpsc_tx_intr(struct mpsc_port_info *pi)
+{
+	volatile struct mpsc_tx_desc *txre;
+	int rc = 0;
+
+	if (pi->txr_running) {
+		txre = (volatile struct mpsc_tx_desc *)(pi->txr +
+							(pi->txr_tail *
+							 MPSC_TXRE_SIZE));
+		MPSC_CACHE_INVALIDATE(pi, (u32) txre,
+				      (u32) txre + MPSC_TXRE_SIZE);
+
+		while (!(be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O)) {
+			pi->txr_running = 0;
+			rc = 1;
+			pi->port.icount.tx += be16_to_cpu(txre->bytecnt);
+			pi->txr_tail = (pi->txr_tail + 1) &
+			    (MPSC_TXR_ENTRIES - 1);
+
+			/* If no more data to tx, fall out of loop */
+			if (pi->txr_head == pi->txr_tail)
+				break;
+
+			txre = (volatile struct mpsc_tx_desc *)(pi->txr +
+					(pi->txr_tail * MPSC_TXRE_SIZE));
+			MPSC_CACHE_INVALIDATE(pi, (u32) txre,
+					      (u32) txre + MPSC_TXRE_SIZE);
+		}
+
+		mpsc_sdma_start_tx(pi);	/* start next desc if ready */
+
+		/* 
+		 * It is possible to have more tx data waiting in the serial
+		 * core's tx buffer so we need to check here so it doesn't
+		 * get missed.
+		 */
+		if (!pi->txr_running) {
+			mpsc_copy_tx_data(pi);
+			mpsc_sdma_start_tx(pi);
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * This is the driver's interrupt handler.  To avoid a race, we first clear
+ * the interrupt, then handle any completed Rx/Tx descriptors.  When done
+ * handling those descriptors, we restart the Rx/Tx engines if they're stopped.
+ */
+static irqreturn_t mpsc_sdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mpsc_port_info *pi = dev_id;
+	ulong iflags;
+	int rc = IRQ_NONE;
+
+	DBG("mpsc_sdma_intr[%d]: SDMA Interrupt Received\n", pi->port.line);
+
+	spin_lock_irqsave(&pi->port.lock, iflags);
+	mpsc_sdma_intr_ack(pi);
+	if (mpsc_rx_intr(pi, regs) || mpsc_tx_intr(pi))
+		rc = IRQ_HANDLED;
+	spin_unlock_irqrestore(&pi->port.lock, iflags);
+
+	DBG("mpsc_sdma_intr[%d]: SDMA Interrupt Handled\n", pi->port.line);
+	return rc;
+}
+
+/*
+ ******************************************************************************
+ *
+ * serial_core.c Interface routines
+ *
+ ******************************************************************************
+ */
+static uint mpsc_tx_empty(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	ulong iflags;
+	uint rc;
+
+	spin_lock_irqsave(&pi->port.lock, iflags);
+	rc = mpsc_sdma_tx_active(pi) ? 0 : TIOCSER_TEMT;
+	spin_unlock_irqrestore(&pi->port.lock, iflags);
+
+	return rc;
+}
+
+static void mpsc_set_mctrl(struct uart_port *port, uint mctrl)
+{
+	/* Have no way to set modem control lines AFAICT */
+	return;
+}
+
+static uint mpsc_get_mctrl(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	u32 mflags, status;
+	ulong iflags;
+
+	spin_lock_irqsave(&pi->port.lock, iflags);
+	status = MPSC_READ_M(pi, mpsc, MPSC_CHR_10);
+	spin_unlock_irqrestore(&pi->port.lock, iflags);
+
+	mflags = 0;
+	if (status & 0x1)
+		mflags |= TIOCM_CTS;
+	if (status & 0x2)
+		mflags |= TIOCM_CAR;
+
+	return mflags | TIOCM_DSR;	/* No way to tell if DSR asserted */
+}
+
+static void mpsc_stop_tx(struct uart_port *port, uint tty_start)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+
+	DBG("mpsc_stop_tx[%d]: tty_start: %d\n", port->line, tty_start);
+
+	mpsc_freeze(pi);
+	return;
+}
+
+static void mpsc_start_tx(struct uart_port *port, uint tty_start)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+
+	mpsc_unfreeze(pi);
+	mpsc_copy_tx_data(pi);
+	mpsc_sdma_start_tx(pi);
+
+	DBG("mpsc_start_tx[%d]: tty_start: %d\n", port->line, tty_start);
+	return;
+}
+
+static void mpsc_start_rx(struct mpsc_port_info *pi)
+{
+	DBG("mpsc_start_rx[%d]: Starting...\n", pi->port.line);
+
+	if (pi->rcv_data) {
+		mb();
+		mpsc_enter_hunt(pi);
+		mpsc_sdma_cmd(pi, SDMA_SDCM_ERD);
+	}
+	return;
+}
+
+static void mpsc_stop_rx(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+
+	DBG("mpsc_stop_rx[%d]: Stopping...\n", port->line);
+
+	mpsc_sdma_cmd(pi, SDMA_SDCM_AR);
+	return;
+}
+
+static void mpsc_enable_ms(struct uart_port *port)
+{
+	return;			/* Not supported */
+}
+
+static void mpsc_break_ctl(struct uart_port *port, int ctl)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	ulong flags;
+
+	spin_lock_irqsave(&pi->port.lock, flags);
+	if (ctl) {
+		/* Send as many BRK chars as we can */
+		MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0x00ff0000);
+	} else {
+		/* Stop sending BRK chars */
+		MPSC_WRITE_M(pi, mpsc, MPSC_CHR_1, 0);
+	}
+	spin_unlock_irqrestore(&pi->port.lock, flags);
+
+	return;
+}
+
+static int mpsc_startup(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	u32 flag = 0;
+	int rc;
+
+	DBG("mpsc_startup[%d]: Starting up MPSC, irq: %d\n",
+	    port->line, pi->port.irq);
+
+	if ((rc = mpsc_make_ready(pi)) == 0) {
+		/* Setup IRQ handler */
+		mpsc_sdma_intr_ack(pi);
+
+		/* If irq's are shared, need to set flag */
+		if (mpsc_ports[0].port.irq == mpsc_ports[1].port.irq)
+			flag = SA_SHIRQ;
+
+		if (request_irq(pi->port.irq, mpsc_sdma_intr, flag,
+				"MPSC/SDMA", pi)) {
+			printk(KERN_ERR "MPSC: Can't get SDMA IRQ %d\n",
+			       pi->port.irq);
+		}
+
+		mpsc_sdma_intr_unmask(pi, 0xf);
+		mpsc_sdma_set_rx_ring(pi, (struct mpsc_rx_desc *)(pi->rxr_p +
+					  (pi->rxr_posn * MPSC_RXRE_SIZE)));
+	}
+
+	return rc;
+}
+
+static void mpsc_shutdown(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	static void mpsc_release_port(struct uart_port *port);
+
+	DBG("mpsc_shutdown[%d]: Shutting down MPSC\n", port->line);
+
+	while (mpsc_sdma_tx_active(pi))
+		udelay(100);	/* Let Tx ring drain */
+
+	mpsc_sdma_stop(pi);
+	free_irq(pi->port.irq, pi);
+	return;
+}
+
+static void
+mpsc_set_termios(struct uart_port *port, struct termios *termios,
+		 struct termios *old)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	u32 baud, quot;
+	ulong flags;
+	u32 chr_bits, stop_bits, par;
+
+	pi->c_iflag = termios->c_iflag;
+	pi->c_cflag = termios->c_cflag;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		chr_bits = MPSC_MPCR_CL_5;
+		break;
+	case CS6:
+		chr_bits = MPSC_MPCR_CL_6;
+		break;
+	case CS7:
+		chr_bits = MPSC_MPCR_CL_7;
+		break;
+	default:
+	case CS8:
+		chr_bits = MPSC_MPCR_CL_8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		stop_bits = MPSC_MPCR_SBL_2;
+	else
+		stop_bits = MPSC_MPCR_SBL_1;
+
+	par = MPSC_CHR_2_PAR_EVEN;
+	if (termios->c_cflag & PARENB) {
+		if (termios->c_cflag & PARODD)
+			par = MPSC_CHR_2_PAR_ODD;
+#ifdef	CMSPAR
+		if (termios->c_cflag & CMSPAR) {
+			if (termios->c_cflag & PARODD)
+				par = MPSC_CHR_2_PAR_MARK;
+			else
+				par = MPSC_CHR_2_PAR_SPACE;
+		}
+#endif
+	}
+
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk);
+	quot = uart_get_divisor(port, baud);
+
+	spin_lock_irqsave(&pi->port.lock, flags);
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	mpsc_set_char_length(pi, chr_bits);
+	mpsc_set_stop_bit_length(pi, stop_bits);
+	mpsc_set_parity(pi, par);
+	mpsc_set_baudrate(pi, baud);
+
+	/* Characters/events to read */
+	pi->rcv_data = 1;
+	pi->port.read_status_mask = SDMA_DESC_CMDSTAT_OR;
+
+	if (termios->c_iflag & INPCK)
+		pi->port.read_status_mask |= SDMA_DESC_CMDSTAT_PE |
+		    SDMA_DESC_CMDSTAT_FR;
+
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		pi->port.read_status_mask |= SDMA_DESC_CMDSTAT_BR;
+
+	/* Characters/events to ignore */
+	pi->port.ignore_status_mask = 0;
+
+	if (termios->c_iflag & IGNPAR)
+		pi->port.ignore_status_mask |= SDMA_DESC_CMDSTAT_PE |
+		    SDMA_DESC_CMDSTAT_FR;
+
+	if (termios->c_iflag & IGNBRK) {
+		pi->port.ignore_status_mask |= SDMA_DESC_CMDSTAT_BR;
+
+		if (termios->c_iflag & IGNPAR)
+			pi->port.ignore_status_mask |= SDMA_DESC_CMDSTAT_OR;
+	}
+
+	/* Ignore all chars if CREAD not set */
+	if (!(termios->c_cflag & CREAD)) {
+		pi->rcv_data = 0;
+	} else {
+		mpsc_start_rx(pi);
+	}
+
+	spin_unlock_irqrestore(&pi->port.lock, flags);
+	return;
+}
+
+static const char *mpsc_type(struct uart_port *port)
+{
+	DBG("mpsc_type[%d]: port type: %s\n", port->line, MPSC_DRIVER_NAME);
+	return MPSC_DRIVER_NAME;
+}
+
+static int mpsc_request_port(struct uart_port *port)
+{
+	/* Should make chip/platform specific call */
+	return 0;
+}
+
+static void mpsc_release_port(struct uart_port *port)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+
+	mpsc_uninit_rings(pi);
+	mpsc_free_ring_mem(pi);
+	pi->ready = 0;
+
+	return;
+}
+
+static void mpsc_config_port(struct uart_port *port, int flags)
+{
+	return;
+}
+
+static int mpsc_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
+	int rc = 0;
+
+	DBG("mpsc_verify_port[%d]: Verifying port data\n", pi->port.line);
+
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_MPSC)
+		rc = -EINVAL;
+	if (pi->port.irq != ser->irq)
+		rc = -EINVAL;
+	if (ser->io_type != SERIAL_IO_MEM)
+		rc = -EINVAL;
+	if (pi->port.uartclk / 16 != ser->baud_base)	/* Not sure */
+		rc = -EINVAL;
+	if ((void *)pi->port.mapbase != ser->iomem_base)
+		rc = -EINVAL;
+	if (pi->port.iobase != ser->port)
+		rc = -EINVAL;
+	if (ser->hub6 != 0)
+		rc = -EINVAL;
+
+	return rc;
+}
+
+static struct uart_ops mpsc_pops = {
+	.tx_empty     = mpsc_tx_empty,
+	.set_mctrl    = mpsc_set_mctrl,
+	.get_mctrl    = mpsc_get_mctrl,
+	.stop_tx      = mpsc_stop_tx,
+	.start_tx     = mpsc_start_tx,
+	.stop_rx      = mpsc_stop_rx,
+	.enable_ms    = mpsc_enable_ms,
+	.break_ctl    = mpsc_break_ctl,
+	.startup      = mpsc_startup,
+	.shutdown     = mpsc_shutdown,
+	.set_termios  = mpsc_set_termios,
+	.type         = mpsc_type,
+	.release_port = mpsc_release_port,
+	.request_port = mpsc_request_port,
+	.config_port  = mpsc_config_port,
+	.verify_port  = mpsc_verify_port,
+};
+
+/*
+ ******************************************************************************
+ *
+ * Console Interface Routines
+ *
+ ******************************************************************************
+ */
+
+#ifdef CONFIG_SERIAL_MPSC_CONSOLE
+static void mpsc_console_write(struct console *co, const char *s, uint count)
+{
+	struct mpsc_port_info *pi = &mpsc_ports[co->index];
+	u8 *bp, *dp, add_cr = 0;
+	int i;
+
+	while (mpsc_sdma_tx_active(pi))
+		udelay(100);
+
+	pi->txr_running = 0;
+	pi->txr_tail = pi->txr_head;
+
+	while (count > 0) {
+		bp = dp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
+		MPSC_CACHE_INVALIDATE(pi, bp, bp + MPSC_TXBE_SIZE);
+
+		for (i = 0; i < MPSC_TXBE_SIZE; i++) {
+			if (count == 0)
+				break;
+
+			if (add_cr) {
+				*(dp++) = '\r';
+				add_cr = 0;
+			} else {
+				*(dp++) = *s;
+
+				if (*(s++) == '\n') { /* add '\r' after '\n' */
+					add_cr = 1;
+					count++;
+				}
+			}
+
+			count--;
+		}
+
+		MPSC_CACHE_FLUSH(pi, bp, bp + MPSC_TXBE_SIZE);
+		mpsc_setup_tx_desc(pi, i, 1);
+		mpsc_sdma_start_tx(pi);
+		pi->txr_head = (pi->txr_head + 1) & (MPSC_TXR_ENTRIES - 1);
+
+		while (mpsc_sdma_tx_active(pi))
+			udelay(100);
+
+		pi->txr_running = 0;
+		pi->txr_tail = (pi->txr_tail + 1) & (MPSC_TXR_ENTRIES - 1);
+	}
+
+	return;
+}
+
+static int __init mpsc_console_setup(struct console *co, char *options)
+{
+	struct mpsc_port_info *pi;
+	int baud, bits, parity, flow;
+
+	DBG("mpsc_console_setup[%d]: options: %s\n", co->index, options);
+
+	if (co->index >= MPSC_NUM_CTLRS)
+		co->index = 0;
+
+	pi = &mpsc_ports[co->index];
+
+	baud = pi->default_baud;
+	bits = pi->default_bits;
+	parity = pi->default_parity;
+	flow = pi->default_flow;
+
+	if (!pi->port.ops)
+		return -ENODEV;
+
+	spin_lock_init(&pi->port.lock);	/* Temporary fix--copied from 8250.c */
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&pi->port, co, baud, parity, bits, flow);
+}
+
+extern struct uart_driver mpsc_reg;
+static struct console mpsc_console = {
+	.name   = MPSC_DEV_NAME,
+	.write  = mpsc_console_write,
+	.device = uart_console_device,
+	.setup  = mpsc_console_setup,
+	.flags  = CON_PRINTBUFFER,
+	.index  = -1,
+	.data   = &mpsc_reg,
+};
+
+static int __init mpsc_console_init(void)
+{
+	DBG("mpsc_console_init: Enter\n");
+	register_console(&mpsc_console);
+	return 0;
+}
+
+console_initcall(mpsc_console_init);
+
+static int __init mpsc_late_console_init(void)
+{
+	DBG("mpsc_late_console_init: Enter\n");
+
+	if (!(mpsc_console.flags & CON_ENABLED))
+		register_console(&mpsc_console);
+	return 0;
+}
+
+late_initcall(mpsc_late_console_init);
+
+#define MPSC_CONSOLE	&mpsc_console
+#else
+#define MPSC_CONSOLE	NULL
+#endif
+
+/*
+ ******************************************************************************
+ *
+ * Driver Interface Routines
+ *
+ ******************************************************************************
+ */
+
+static void mpsc_map_regs(struct mpsc_port_info *pi)
+{
+	pi->mpsc_base = (u32) ioremap(pi->mpsc_base_p, MPSC_REG_BLOCK_SIZE);
+	pi->mpsc_routing_base = (u32) ioremap(pi->mpsc_routing_base_p,
+					      MPSC_ROUTING_REG_BLOCK_SIZE);
+	pi->sdma_base = (u32) ioremap(pi->sdma_base_p, SDMA_REG_BLOCK_SIZE);
+	pi->sdma_intr_base = (u32) ioremap(pi->sdma_intr_base_p,
+					   SDMA_INTR_REG_BLOCK_SIZE);
+	pi->brg_base = (u32) ioremap(pi->brg_base_p, BRG_REG_BLOCK_SIZE);
+
+	return;
+}
+
+static void mpsc_unmap_regs(struct mpsc_port_info *pi)
+{
+	iounmap((void *)pi->mpsc_base);
+	iounmap((void *)pi->mpsc_routing_base);
+	iounmap((void *)pi->sdma_base);
+	iounmap((void *)pi->sdma_intr_base);
+	iounmap((void *)pi->brg_base);
+
+	pi->mpsc_base = 0;
+	pi->mpsc_routing_base = 0;
+	pi->sdma_base = 0;
+	pi->sdma_intr_base = 0;
+	pi->brg_base = 0;
+
+	return;
+}
+
+/* Called from platform specific device probe routine */
+struct mpsc_port_info *mpsc_device_probe(int index)
+{
+	struct mpsc_port_info *pi = NULL;
+
+	if ((index >= 0) && (index < MPSC_NUM_CTLRS))
+		pi = &mpsc_ports[index];
+
+	return pi;
+}
+
+/* Called from platform specific device remove routine */
+struct mpsc_port_info *mpsc_device_remove(int index)
+{
+	struct mpsc_port_info *pi = NULL;
+
+	if ((index >= 0) && (index < MPSC_NUM_CTLRS))
+		pi = &mpsc_ports[index];
+
+	return pi;
+}
+
+static struct uart_driver mpsc_reg = {
+	.owner       = THIS_MODULE,
+	.driver_name = MPSC_DRIVER_NAME,
+	.devfs_name  = MPSC_DEVFS_NAME,
+	.dev_name    = MPSC_DEV_NAME,
+	.major       = MPSC_MAJOR,
+	.minor       = MPSC_MINOR_START,
+	.nr          = MPSC_NUM_CTLRS,
+	.cons        = MPSC_CONSOLE,
+};
+
+static int __init mpsc_init(void)
+{
+	struct mpsc_port_info *pi;
+	int i, j, rc;
+
+	printk(KERN_INFO "Serial: MPSC driver $Revision: 1.00 $\n");
+
+	mpsc_ports[0].shared_regs = &mpsc_shared_regs;
+	mpsc_ports[1].shared_regs = &mpsc_shared_regs;
+
+	if ((rc = mpsc_platform_register_driver()) >= 0) {
+		if ((rc = uart_register_driver(&mpsc_reg)) < 0) {
+			mpsc_platform_unregister_driver();
+		} else {
+			for (i = 0; i < MPSC_NUM_CTLRS; i++) {
+				pi = &mpsc_ports[i];
+
+				pi->port.line = i;
+				pi->port.type = PORT_MPSC;
+				pi->port.fifosize = MPSC_TXBE_SIZE;
+				pi->port.membase = (char *)pi->mpsc_base;
+				pi->port.mapbase = (ulong) pi->mpsc_base;
+				pi->port.ops = &mpsc_pops;
+				pi->shared_regs = &mpsc_shared_regs;
+
+				mpsc_map_regs(pi);
+
+				if ((rc = mpsc_make_ready(pi)) >= 0) {
+					uart_add_one_port(&mpsc_reg, &pi->port);
+				} else { /* on failure, undo everything */
+					for (j = 0; j < i; j++) {
+						mpsc_unmap_regs(&mpsc_ports[j]);
+						uart_remove_one_port(&mpsc_reg,
+								     &mpsc_ports
+								     [j].port);
+					}
+
+					uart_unregister_driver(&mpsc_reg);
+					mpsc_platform_unregister_driver();
+					break;
+				}
+			}
+		}
+	}
+
+	return rc;
+}
+
+static void __exit mpsc_exit(void)
+{
+	int i;
+
+	DBG("mpsc_exit: Exiting\n");
+
+	for (i = 0; i < MPSC_NUM_CTLRS; i++) {
+		mpsc_unmap_regs(&mpsc_ports[i]);
+		uart_remove_one_port(&mpsc_reg, &mpsc_ports[i].port);
+	}
+
+	uart_unregister_driver(&mpsc_reg);
+	mpsc_platform_unregister_driver();
+
+	return;
+}
+
+int register_serial(struct serial_struct *req)
+{
+	return uart_register_port(&mpsc_reg, &mpsc_ports[req->line].port);
+}
+
+void unregister_serial(int line)
+{
+	uart_unregister_port(&mpsc_reg, line);
+	return;
+}
+
+module_init(mpsc_init);
+module_exit(mpsc_exit);
+
+EXPORT_SYMBOL(register_serial);
+EXPORT_SYMBOL(unregister_serial);
+
+MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
+MODULE_DESCRIPTION("Generic Marvell MPSC serial/UART driver $Revision: 1.00 $");
+MODULE_VERSION(MPSC_VERSION);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(MPSC_MAJOR);
diff -Nru a/drivers/serial/mpsc/mpsc.h b/drivers/serial/mpsc/mpsc.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/mpsc/mpsc.h	2004-08-27 11:21:34 -07:00
@@ -0,0 +1,284 @@
+/*
+ * drivers/serial/mpsc/mpsc.h
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef	__MPSC_H__
+#define	__MPSC_H__
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/tty.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/serial.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/serial_core.h>
+#include "mpsc_defs.h"
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
+	/* SDMA_INTR_CAUSE_m should be added too but never read so not needed */
+	u32 MPSC_MRR_m;
+	u32 MPSC_RCRR_m;
+	u32 MPSC_TCRR_m;
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
+	u32 mpsc_base_p;
+	u32 mpsc_routing_base_p;
+	u32 sdma_base_p;
+	u32 sdma_intr_base_p;
+	u32 brg_base_p;
+
+	/* Virtual addresses of various blocks of registers (from platform) */
+	u32 mpsc_base;
+	u32 mpsc_routing_base;
+	u32 sdma_base;
+	u32 sdma_intr_base;
+	u32 brg_base;
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
+	u8 txr_running;		/* Tx engine running? */
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
+#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
+#define	MPSC_CACHE_FLUSH(pi, s, e) {			\
+	if (pi->cache_mgmt) {				\
+		/* 64x60 erratum: can't use dcbst/clean_dcache_range() */ \
+		flush_dcache_range((ulong)s, (ulong)e);	\
+		mb();					\
+	}						\
+}
+
+#define	MPSC_CACHE_INVALIDATE(pi, s, e) {			\
+	if (pi->cache_mgmt) {					\
+		invalidate_dcache_range((ulong)s, (ulong)e);	\
+		mb();						\
+	}							\
+}
+
+#define	MPSC_CACHE_FLUSH_INVALIDATE(pi, s, e) {		\
+	if (pi->cache_mgmt) {				\
+		flush_dcache_range((ulong)s, (ulong)e);	\
+		mb();					\
+	}						\
+}
+#else
+/* Other architectures need to fill this in */
+#define	MPSC_CACHE_FLUSH(pi, s, e)		BUG()
+#define	MPSC_CACHE_INVALIDATE(pi, s, e)		BUG()
+#define	MPSC_CACHE_FLUSH_INVALIDATE(pi, s, e)	BUG()
+#endif
+
+/*
+ * 'MASK_INSERT' takes the low-order 'n' bits of 'i', shifts it 'b' bits to
+ * the left, and inserts it into the target 't'.  The corresponding bits in
+ * 't' will have been cleared before the bits in 'i' are inserted.
+ */
+#ifdef CONFIG_PPC32
+#define MASK_INSERT(t, i, n, b) ({				\
+	u32	rval = (t);					\
+        __asm__ __volatile__(					\
+		"rlwimi %0,%2,%4,32-(%3+%4),31-%4\n"		\
+		: "=r" (rval)					\
+		: "0" (rval), "r" (i), "i" (n), "i" (b));	\
+	rval;							\
+})
+#else
+/* These macros are really just examples.  Feel free to change them --MAG */
+#define GEN_MASK(n, b)			\
+({					\
+	u32	m, sl, sr;		\
+	sl = 32 - (n);			\
+	sr = sl - (b);			\
+	m = (0xffffffff << sl) >> sr;	\
+})
+
+#define MASK_INSERT(t, i, n, b)		\
+({					\
+	u32	m, rval = (t);		\
+	m = GEN_MASK((n), (b));		\
+	rval &= ~m;			\
+	rval |= (((i) << (b)) & m);	\
+})
+#endif
+
+/* I/O macros for regs that you can read */
+#define	MPSC_READ(pi, unit, offset)	readl((pi)->unit##_base + (offset))
+#define	MPSC_WRITE(pi, unit, offset, v)	writel(v, (pi)->unit##_base + (offset))
+#define	MPSC_MOD_FIELD(pi, unit, offset, num_bits, shift, val)	\
+{								\
+	u32	v;						\
+	v = readl((pi)->unit##_base + (offset));		\
+	writel(MASK_INSERT(v,val,num_bits,shift), (pi)->unit##_base+(offset));\
+}
+
+/* Macros for regs with erratum that are not shared between MPSC ctlrs */
+#define	MPSC_READ_M(pi, unit, offset)			\
+({							\
+	u32	v;					\
+	if ((pi)->mirror_regs) v = (pi)->offset##_m;	\
+	else v = readl((pi)->unit##_base + (offset));	\
+	v;						\
+})
+
+#define	MPSC_WRITE_M(pi, unit, offset, v)		\
+({							\
+	if ((pi)->mirror_regs) (pi)->offset##_m = v;	\
+	writel(v, (pi)->unit##_base + (offset));	\
+})
+
+#define	MPSC_MOD_FIELD_M(pi, unit, offset, num_bits, shift, val)	\
+({									\
+	u32	v;							\
+	if ((pi)->mirror_regs) v = (pi)->offset##_m;			\
+	else v = readl((pi)->unit##_base + (offset));			\
+	v = MASK_INSERT(v, val, num_bits, shift);			\
+	if ((pi)->mirror_regs) (pi)->offset##_m = v;			\
+	writel(v, (pi)->unit##_base + (offset));			\
+})
+
+/* Macros for regs with erratum that are shared between MPSC ctlrs */
+#define	MPSC_READ_S(pi, unit, offset)					\
+({									\
+	u32	v;							\
+	if ((pi)->mirror_regs) v = (pi)->shared_regs->offset##_m;	\
+	else v = readl((pi)->unit##_base + (offset));			\
+	v;								\
+})
+
+#define	MPSC_WRITE_S(pi, unit, offset, v)				\
+({									\
+	if ((pi)->mirror_regs) (pi)->shared_regs->offset##_m = v;	\
+	writel(v, (pi)->unit##_base + (offset));			\
+})
+
+#define	MPSC_MOD_FIELD_S(pi, unit, offset, num_bits, shift, val)	\
+({									\
+	u32	v;							\
+	if ((pi)->mirror_regs) v = (pi)->shared_regs->offset##_m;	\
+	else v = readl((pi)->unit##_base + (offset));			\
+	v = MASK_INSERT(v, val, num_bits, shift);			\
+	if ((pi)->mirror_regs) (pi)->shared_regs->offset##_m = v;	\
+	writel(v, (pi)->unit##_base + (offset));			\
+})
+
+#if !defined(MIN)
+#define	MIN(a, b)	(((a) < (b)) ? (a) : (b))
+#endif
+
+/* Hooks to platform-specific code */
+int mpsc_platform_register_driver(void);
+void mpsc_platform_unregister_driver(void);
+
+/* Hooks back in to mpsc common to be called by platform-specific code */
+struct mpsc_port_info *mpsc_device_probe(int index);
+struct mpsc_port_info *mpsc_device_remove(int index);
+
+#endif				/* __MPSC_H__ */
diff -Nru a/drivers/serial/mpsc/mpsc_defs.h b/drivers/serial/mpsc/mpsc_defs.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/mpsc/mpsc_defs.h	2004-08-27 11:21:34 -07:00
@@ -0,0 +1,151 @@
+/*
+ * drivers/serial/mpsc/mpsc_defs.h
+ * 
+ * Register definitions for the Marvell Multi-Protocol Serial Controller (MPSC),
+ * Serial DMA Controller (SDMA), and Baud Rate Generator (BRG).
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef	__MPSC_DEFS_H__
+#define	__MPSC_DEFS_H__
+
+#define	MPSC_NUM_CTLRS		2
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
+#define	MPSC_REG_BLOCK_SIZE		0x0038
+
+#define	MPSC_MPCR_CL_5			0
+#define	MPSC_MPCR_CL_6			1
+#define	MPSC_MPCR_CL_7			2
+#define	MPSC_MPCR_CL_8			3
+#define	MPSC_MPCR_SBL_1			0
+#define	MPSC_MPCR_SBL_2			3
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
+#define	MPSC_ROUTING_REG_BLOCK_SIZE	0x000c
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
+#define	SDMA_REG_BLOCK_SIZE		0x0c18
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
+#define	SDMA_INTR_REG_BLOCK_SIZE	0x0084
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
+#define	BRG_REG_BLOCK_SIZE		0x0008
+
+#endif /*__MPSC_DEFS_H__ */
diff -Nru a/drivers/serial/mpsc/mpsc_ppc32.c b/drivers/serial/mpsc/mpsc_ppc32.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/serial/mpsc/mpsc_ppc32.c	2004-08-27 11:21:34 -07:00
@@ -0,0 +1,109 @@
+/*
+ * drivers/serial/mpsc/mpsc_ppc32.c
+ *
+ * Middle layer that sucks data from the ppc32 OCP--that is, chip &
+ * platform-specific data--and puts it into the mpsc_port_info structure
+ * for the mpsc driver to use.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include "mpsc.h"
+#include <asm/ocp.h>
+#include <asm/mv64x60.h>
+
+static void mpsc_ocp_remove(struct ocp_device *ocpdev);
+
+static int mpsc_ocp_probe(struct ocp_device *ocpdev)
+{
+	struct mpsc_port_info *pi;
+	struct mv64x60_ocp_mpsc_data *dp;
+	u32 base;
+	int rc = -ENODEV;
+
+	if ((pi = mpsc_device_probe(ocpdev->def->index)) != NULL) {
+		dp = (struct mv64x60_ocp_mpsc_data *)ocpdev->def->additions;
+
+		pi->mpsc_base_p = ocpdev->def->paddr;
+
+		if (ocpdev->def->index == 0) {
+			base = pi->mpsc_base_p - MV64x60_MPSC_0_OFFSET;
+			pi->sdma_base_p = base + MV64x60_SDMA_0_OFFSET;
+			pi->brg_base_p = base + MV64x60_BRG_0_OFFSET;
+		} else {	/* Must be 1 */
+			base = pi->mpsc_base_p - MV64x60_MPSC_1_OFFSET;
+			pi->sdma_base_p = base + MV64x60_SDMA_1_OFFSET;
+			pi->brg_base_p = base + MV64x60_BRG_1_OFFSET;
+		}
+
+		pi->mpsc_routing_base_p = base + MV64x60_MPSC_ROUTING_OFFSET;
+		pi->sdma_intr_base_p = base + MV64x60_SDMA_INTR_OFFSET;
+
+		pi->port.irq = ocpdev->def->irq;
+		pi->port.uartclk = dp->brg_clk_freq;
+
+		pi->mirror_regs = dp->mirror_regs;
+		pi->cache_mgmt = dp->cache_mgmt;
+		pi->brg_can_tune = dp->brg_can_tune;
+		pi->brg_clk_src = dp->brg_clk_src;
+		pi->mpsc_max_idle = dp->max_idle;
+		pi->default_baud = dp->default_baud;
+		pi->default_bits = dp->default_bits;
+		pi->default_parity = dp->default_parity;
+		pi->default_flow = dp->default_flow;
+
+		/* Initial values of mirrored regs */
+		pi->MPSC_CHR_1_m = dp->chr_1_val;
+		pi->MPSC_CHR_2_m = dp->chr_2_val;
+		pi->MPSC_CHR_10_m = dp->chr_10_val;
+		pi->MPSC_MPCR_m = dp->mpcr_val;
+		pi->BRG_BCR_m = dp->bcr_val;
+
+		/* Seed only with the first ctlr's values */
+		if (ocpdev->def->index == 0) {
+			pi->shared_regs->MPSC_MRR_m = dp->mrr_val;
+			pi->shared_regs->MPSC_RCRR_m = dp->rcrr_val;
+			pi->shared_regs->MPSC_TCRR_m = dp->tcrr_val;
+			pi->shared_regs->SDMA_INTR_MASK_m = dp->intr_mask_val;
+		}
+
+		pi->port.iotype = UPIO_MEM;
+
+		rc = 0;
+	}
+
+	return rc;
+}
+
+static void mpsc_ocp_remove(struct ocp_device *ocpdev)
+{
+	(void)mpsc_device_remove(ocpdev->def->index);
+	return;
+}
+
+static struct ocp_device_id mpsc_ocp_ids[] = {
+	{.vendor = OCP_VENDOR_MARVELL,.function = OCP_FUNC_MPSC},
+	{.vendor = OCP_VENDOR_INVALID}
+};
+
+static struct ocp_driver mpsc_ocp_driver = {
+	.name     = "mpsc",
+	.id_table = mpsc_ocp_ids,
+	.probe    = mpsc_ocp_probe,
+	.remove   = mpsc_ocp_remove,
+};
+
+int mpsc_platform_register_driver(void)
+{
+	return ocp_register_driver(&mpsc_ocp_driver);
+}
+
+void mpsc_platform_unregister_driver(void)
+{
+	ocp_unregister_driver(&mpsc_ocp_driver);
+	return;
+}

--------------040602030604000806050809--

