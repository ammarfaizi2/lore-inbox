Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVJDW2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVJDW2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVJDW2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:28:34 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:64172 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S965018AbVJDW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:28:33 -0400
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 1/2] simple SPI controller implementation on PXA2xx SSP port
Date: Tue, 4 Oct 2005 15:28:27 -0700
User-Agent: KMail/1.7.1
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041528.27423.stephen@streetfiresound.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a prototype interrupt driven SPI "controller" for Intel's PXA2xx 
series SOC. The driver plugs into the lightweight SPI framework developed by
David Brownell. Hardwired configuration information is provided via
spi_board_info structures initialized in arch/arm/mach_pxa board
initialization code (see include/linux/spi.h for details). 

The driver is built around a spi_message fifo serviced by two tasklets. The
first tasklet (pump_messages) is responsible for queuing SPI transactions 
and scheduling SPI transfers.  The second tasklet (pump_transfers) is 
responsible to setting up and launching the interrupt driven transfers.
Per transfer chip select and delay control is available.

This is a prototype driver, so you mileage will vary. It has only been
tested on the NSSP port.

Known Limitations:
 Does not handle invert chip select polarity.
 Heavy loaded systems may see transaction failures.
 Wordsize support is untested.
 Internal NSSP chip select is not support (i.e. NSSPSRFM)

---- snip ----
 drivers/spi/Kconfig                       |   12 
 drivers/spi/Makefile                      |    2 
 drivers/spi/pxa2xx_spi_ssp.c              |  741 ++++++++++++++++++++++++++++++
 include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h |   36 +
 4 files changed, 791 insertions(+)

--- linux-2.6.12-spi/drivers/spi/Kconfig 2005-10-04 14:07:18.000000000 -0700
+++ linux-2.6.12-spi-pxa/drivers/spi/Kconfig 2005-10-04 14:00:12.279449000 -0700
@@ -65,6 +65,12 @@
 comment "SPI Master Controller Drivers"
 
 
+config SPI_PXA_SSP
+       tristate "PXA SSP controller as SPI master"
+       depends on ARCH_PXA
+       help
+         This implements SPI master mode using an SSP controller.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
@@ -77,6 +83,12 @@
 comment "SPI Protocol Masters"
 
 
+config SPI_CS8415A
+       tristate "CS8415A SPD/IF decoder"
+       help
+         This chip provides an 8 channel SPD/IF switcher with complete
+         SPD/IF decoding.
+
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
--- linux-2.6.12-spi/drivers/spi/Makefile 2005-10-04 14:07:18.000000000 -0700
+++ linux-2.6.12-spi-pxa/drivers/spi/Makefile 2005-10-04 14:00:12.279449000 -0700
@@ -11,9 +11,11 @@
 obj-$(CONFIG_SPI_MASTER)               += spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_PXA_SSP)              += pxa2xx_spi_ssp.o
 #      ... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
+obj-$(CONFIG_SPI_CS8415A)              += cs8415a.o
 #      ... add above this line ...
 
 # SPI slave controller drivers (upstream link)
--- linux-2.6.12-spi/drivers/spi/pxa2xx_spi_ssp.c 1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-spi-pxa/drivers/spi/pxa2xx_spi_ssp.c 2005-10-04 12:50:10.699272000 -0700
@@ -0,0 +1,741 @@
+/*
+ * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* 
+ * This is a prototype interrupt driven SPI "controller" for Intel's PXA2xx 
+ * series SOC. The driver plugs into the lightweight SPI framework developed by
+ * David Brownell. Hardwired configuration information is provided via
+ * spi_board_info structures initialized in arch/arm/mach_pxa board
+ * initialization code (see include/linux/spi.h for details). NEED TO ADD
+ * PXA SPECIFIED INITIALIZATION INFORMATION.
+ * 
+ * This follow code snippet demostrates a sample board configuration using
+ * the PXA255 NSSP port connect to a CS8415A chip via GPIO chip select 2.
+ * 
+ * static struct cs8415a_platform_data cs8415a_platform_info = {
+ * .enabled = 1,
+ * .muted = 1,
+ * .channel = 0,
+ * .mask_interrupt = cs8415a_mask_interrupt,
+ * .unmask_interrupt = cs8415a_unmask_interrupt,
+ * .service_requested = cs8415a_service_requested,
+ * };
+ *
+ * static struct pxa2xx_spi_chip cs8415a_chip_info = {
+ * .mode = SPI_MODE_3,
+ * .tx_threshold = 12,
+ * .rx_threshold = 4,
+ * .bits_per_word = 8,
+ * .chip_select_gpio = 2,
+ * .timeout_microsecs = 64,
+ * };
+ *
+ * static struct spi_board_info streetracer_spi_board_info[] __initdata = {
+ * {
+ *  .modalias = "cs8415a",
+ *  .max_speed_hz = 3686400,
+ *  .bus_num = 2,
+ *  .chip_select = 0,
+ *  .platform_data = &cs8415a_platform_info,
+ *  .controller_data = &cs8415a_chip_info,
+ *  .irq = STREETRACER_APCI_IRQ,
+ * },
+ * };
+ *
+ * static struct resource pxa_spi_resources[] = {
+ * [0] = {
+ *  .start = __PREG(SSCR0_P(2)),
+ *  .end = __PREG(SSCR0_P(2)) + 0x2c,
+ *  .flags = IORESOURCE_MEM,
+ * },
+ * [1] = {
+ *  .start = IRQ_NSSP,
+ *  .end = IRQ_NSSP,
+ *  .flags = IORESOURCE_IRQ,
+ * },
+ * };
+ *
+ * static struct pxa2xx_spi_master pxa_nssp_master_info = {
+ * .bus_num = 2,
+ * .clock_enable = CKEN9_NSSP,
+ * .num_chipselect = 3,
+ * };
+ *
+ * static struct platform_device pxa_spi_ssp = {
+ * .name = "pxa2xx-spi-ssp",
+ * .id = -1,
+ * .resource = pxa_spi_resources,
+ * .num_resources = ARRAY_SIZE(pxa_spi_resources),
+ * .dev = {
+ *  .platform_data = &pxa_nssp_master_info,
+ * },
+ * }; 
+ *
+ * static void __init streetracer_init(void)
+ * {
+ * platform_device_register(&pxa_spi_ssp);
+ * spi_register_board_info(streetracer_spi_board_info, 
+ *     ARRAY_SIZE(streetracer_spi_board_info));
+ * } 
+ *
+ * The driver is built around a spi_message fifo serviced by two tasklets. The
+ * first tasklet (pump_messages) is responsible for queuing SPI transactions 
+ * and scheduling SPI transfers.  The second tasklet (pump_transfers) is 
+ * responsible to setting up and launching the interrupt driven transfers.
+ * Per transfer chip select and delay control is available.
+ * 
+ * This is a prototype driver, so you mileage will vary. It has only been
+ * tested on the NSSP port.
+ * 
+ * Known Limitations:
+ *  Does not handle invert chip select polarity.
+ *  Heavy loaded systems may see transaction failures.
+ *  Wordsize support is untested.
+ *  Internal NSSP chip select is not support (i.e. NSSPSRFM)
+ *  Module hangs during unload.
+ * 
+ */
+ 
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/delay.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/pxa2xx_spi_ssp.h>
+
+MODULE_AUTHOR("Stephen Street");
+MODULE_DESCRIPTION("PXA2xx SSP SPI Contoller");
+MODULE_LICENSE("GPL");
+
+#define MAX_SPEED_HZ 3686400
+#define MAX_BUSES 3
+
+#define GET_IRQ_STATUS(x) (__REG(sssr)&(SSSR_TINT|SSSR_RFS|SSSR_TFS|SSSR_ROR))
+
+struct transfer_state {
+ int index;
+ int len;
+ u32 gpio;
+ void *tx;
+ void *tx_end;
+ void *rx;
+ void *rx_end;
+ void (*write)(u32 sssr, u32 ssdr, struct transfer_state *state);
+ void (*read)(u32 sssr, u32 ssdr, struct transfer_state *state);
+};
+
+struct master_data {
+ spinlock_t lock;
+ struct spi_master *master;
+ struct list_head queue;
+ struct tasklet_struct pump_messages;
+ struct tasklet_struct pump_transfers;
+ struct spi_message* cur_msg;
+ struct transfer_state cur_state;
+ u32 sscr0;
+ u32 sscr1;
+ u32 sssr;
+ u32 ssitr;
+ u32 ssdr;
+ u32 ssto;
+ u32 sspsp;
+};
+
+struct chip_data {
+ u32 cr0;
+ u32 cr1;
+ u32 to;
+ u32 psp;
+ u16 cs_gpio;
+ u32 timeout;
+ u8 n_bytes;
+ void (*write)(u32 sssr, u32 ssdr, struct transfer_state *state);
+ void (*read)(u32 sssr, u32 ssdr, struct transfer_state *state);
+};
+
+static inline void flush(struct master_data *drv_data)
+{
+ u32 sssr = drv_data->sssr;
+ u32 ssdr = drv_data->ssdr;
+ 
+ do {
+  while (__REG(sssr) & SSSR_RNE) {
+   (void)__REG(ssdr);
+  }
+ } while (__REG(sssr) & SSSR_BSY);
+ __REG(sssr) = SSSR_ROR ;
+}
+
+static inline void save_state(struct master_data *drv_data, 
+    struct chip_data *chip)
+{
+ /* Save critical register */
+ chip->cr0 = __REG(drv_data->sscr0);
+ chip->cr1 = __REG(drv_data->sscr1);
+ chip->to = __REG(drv_data->ssto);
+ chip->psp = __REG(drv_data->sspsp);
+ 
+ /* Disable clock */
+ __REG(drv_data->sscr0) &= ~SSCR0_SSE;
+}
+
+static inline void restore_state(struct master_data *drv_data, 
+     struct chip_data *chip)
+{
+ /* Clear status and disable clock*/
+ __REG(drv_data->sssr) = SSSR_ROR | SSSR_TUR | SSSR_BCE;
+ __REG(drv_data->sscr0) = chip->cr0 & ~SSCR0_SSE;
+ 
+ /* Load the registers */
+ __REG(drv_data->sscr1) = chip->cr1;
+ __REG(drv_data->ssto) = chip->to;
+ __REG(drv_data->sspsp) = chip->psp;
+ __REG(drv_data->sscr0) = chip->cr0;
+}
+
+static inline void dump_state(struct master_data* drv_data)
+{
+ u32 sscr0 = drv_data->sscr0;
+ u32 sscr1 = drv_data->sscr1;
+ u32 sssr = drv_data->sssr;
+ u32 ssto = drv_data->ssto;
+ u32 sspsp = drv_data->sspsp;
+ 
+ pr_debug("SSP dump: sscr0=0x%08x, sscr1=0x%08x, "
+   "ssto=0x%08x, sspsp=0x%08x, sssr=0x%08x\n",
+   __REG(sscr0), __REG(sscr1), __REG(ssto), 
+   __REG(sspsp), __REG(sssr));
+}
+
+static void null_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
+  __REG(ssdr) = 0;
+  ++state->tx;
+ }
+}
+
+static void null_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
+  (void)(__REG(ssdr));
+  ++state->rx;
+ }
+}
+
+static void u8_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
+  __REG(ssdr) = *(u8 *)(state->tx);
+  ++state->tx;
+ }
+}
+
+static void u8_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
+  *(u8 *)(state->rx) = __REG(ssdr);
+  ++state->rx;
+ }
+}
+
+static void u16_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
+  __REG(ssdr) = *(u16 *)(state->tx);
+  state->tx += 2;
+ }
+}
+
+static void u16_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
+  *(u16 *)(state->rx) = __REG(ssdr);
+  state->rx += 2;
+ }
+}
+static void u32_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
+  __REG(ssdr) = *(u32 *)(state->tx);
+  state->tx += 4;
+ }
+}
+
+static void u32_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
+{
+ while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
+  *(u32 *)(state->rx) = __REG(ssdr);
+  state->rx += 4;
+ }
+}
+
+static irqreturn_t ssp_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+ struct master_data *drv_data = (struct master_data *)dev_id;
+ struct transfer_state *state;
+ u32 sssr = drv_data->sssr;
+ u32 ssdr = drv_data->ssdr;
+ u32 sscr1 = drv_data->sscr1;
+ u32 ssto = drv_data->ssto;
+ u32 irq_status;
+ struct spi_message *msg;
+ 
+ if (!drv_data->cur_msg || !drv_data->cur_msg->state) {
+  printk(KERN_ERR "pxs2xx_spi_ssp: bad message or message "
+    "state in interrupt handler\n");
+ }
+ state = (struct transfer_state *)drv_data->cur_msg->state;
+ msg = drv_data->cur_msg;
+
+ while ((irq_status = GET_IRQ_STATUS(sssr))) {
+
+  if (irq_status & SSSR_ROR) {
+
+   /* Clear and disable interrupts */
+   __REG(ssto) = 0;
+   __REG(sssr) = SSSR_TINT | SSSR_ROR;
+   __REG(sscr1) &= ~(SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
+   
+   flush(drv_data);
+   
+   printk(KERN_WARNING "fifo overun: "
+     "index=%d tx_len=%d rx_len%d\n", 
+     state->index, 
+     (state->tx_end - state->tx), 
+     (state->rx_end - state->rx)); 
+
+   state->index = -2;
+   tasklet_schedule(&drv_data->pump_transfers);
+
+   return IRQ_HANDLED;
+  }
+
+  
+  /* Pump data */
+  state->read(sssr, ssdr, state);
+  state->write(sssr, ssdr, state);
+  
+  if ((irq_status & SSSR_TINT) || (state->rx <= state->rx_end)) {
+   
+   /* Look for false positive timeout */
+   if (state->rx < state->rx_end) {
+    __REG(sssr) = SSSR_TINT;
+    break;
+   }
+   
+   /* Clear timeout */
+   __REG(ssto) = 0;
+   __REG(sssr) = SSSR_TINT | SSSR_ROR ;
+   __REG(sscr1) &= ~(SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
+   
+   msg->actual_length += msg->transfers[state->index].len;
+ 
+   if (msg->transfers[state->index].cs_change) 
+    /* Fix me, need to handle cs polarity */
+    GPSR(state->gpio) = GPIO_bit(state->gpio);
+
+   /* Schedule transfer tasklet */
+   ++state->index;
+   tasklet_schedule(&drv_data->pump_transfers);
+   
+   return IRQ_HANDLED;
+  }
+ }
+ 
+ return IRQ_HANDLED;
+} 
+
+static void pump_transfers(unsigned long data)
+{
+ struct master_data *drv_data = (struct master_data *)data;
+ struct spi_message *message = drv_data->cur_msg;
+ struct chip_data *chip;
+ struct transfer_state * state;
+ struct spi_transfer *transfer;
+ u32 sscr1 = drv_data->sscr1;
+ u32 ssto = drv_data->ssto;
+ 
+ if (!message) {
+  printk(KERN_ERR "pxs2xx_spi_ssp: bad pump_transfers "
+    "schedule\n");
+  tasklet_schedule(&drv_data->pump_messages);
+  return;
+ }
+ 
+ state = (struct transfer_state *)message->state;
+ if (!state) {
+  printk(KERN_ERR "pxs2xx_spi_ssp: bad message state\n");
+  drv_data->cur_msg = NULL;
+  tasklet_schedule(&drv_data->pump_messages);
+  return;
+ }
+ 
+ chip = spi_get_ctldata(message->dev);
+ if (!chip) {
+  printk(KERN_ERR "pxs2xx_spi_ssp: bad chip data\n");
+  drv_data->cur_msg = NULL;
+  tasklet_schedule(&drv_data->pump_messages);
+  return;
+ }
+ 
+ /* Handle for abort */
+ if (state->index == -2) {
+  
+  message->status = -EIO;
+  if (message->complete)
+   message->complete(message->context);
+
+  drv_data->cur_msg = NULL;
+  save_state(drv_data, chip);
+
+  tasklet_schedule(&drv_data->pump_messages);  
+  
+  return;
+ }
+
+ /* Handle end of message */
+ if (state->index == message->n_transfer) {
+  
+  if (!message->transfers[state->index].cs_change) 
+   /* Fix me, need to handle cs polarity */
+   GPSR(state->gpio) = GPIO_bit(state->gpio);
+   
+  message->status = 0;
+  if (message->complete)
+   message->complete(message->context);
+
+  drv_data->cur_msg = NULL;
+  save_state(drv_data, chip);
+
+  tasklet_schedule(&drv_data->pump_messages);  
+  
+  return;
+ }
+ 
+ /* Handle start of message */
+ if (state->index == -1) {
+  
+  restore_state(drv_data, chip);
+
+  flush(drv_data);
+
+  ++state->index;
+ }
+ 
+ /* Delay if requested at end of transfer*/
+ if (state->index > 1) {
+  transfer = message->transfers + (state->index - 1);
+  if (transfer->delay_usecs)
+   udelay(transfer->delay_usecs);
+ }
+
+ /* Setup the transfer state */ 
+ transfer = message->transfers + state->index;
+ state->gpio = chip->cs_gpio;  
+ state->tx = (void *)transfer->tx_buf;
+ state->tx_end = state->tx + (transfer->len * chip->n_bytes);
+ state->rx = transfer->rx_buf;
+ state->rx_end = state->rx + (transfer->len * chip->n_bytes);
+ state->write = state->tx ? chip->write : null_writer;
+ state->read = state->rx ? chip->read : null_reader;
+ 
+ /* Fix me, need to handle cs polarity */
+ GPCR(chip->cs_gpio) = GPIO_bit(chip->cs_gpio);
+ 
+ /* Go baby, go */
+ __REG(ssto) = chip->timeout;
+ __REG(sscr1) |= (SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
+}
+
+
+static void pump_messages(unsigned long data)
+{
+ struct master_data *drv_data = (struct master_data *)data;
+
+ spin_lock(&drv_data->lock);
+
+ /* Check for list empty */ 
+ if (list_empty(&drv_data->queue)) {
+  spin_unlock(&drv_data->lock);
+  return;
+ }
+ 
+ /* Check to see if we are already running */
+ if (drv_data->cur_msg) {
+  spin_unlock(&drv_data->lock);
+  return;
+ }  
+
+ /* Extract head of queue and check for tasklet reschedule */
+ drv_data->cur_msg = list_entry(drv_data->queue.next, 
+     struct spi_message, queue);
+ list_del_init(&drv_data->cur_msg->queue);
+ 
+ /* Setup message transfer and schedule transfer pump */
+ drv_data->cur_msg->state = &drv_data->cur_state;
+ drv_data->cur_state.index = -1;
+ drv_data->cur_state.len = 0;
+ tasklet_schedule(&drv_data->pump_transfers);
+   
+ spin_unlock(&drv_data->lock);
+}
+
+static int transfer(struct spi_device *spi, struct spi_message *msg)
+{
+ struct master_data *drv_data = class_get_devdata(&spi->master->cdev);
+
+ msg->actual_length = 0;
+ msg->status = 0;
+  
+ spin_lock_bh(&drv_data->lock);
+ list_add_tail(&msg->queue, &drv_data->queue);
+ spin_unlock_bh(&drv_data->lock);
+ 
+ tasklet_schedule(&drv_data->pump_messages);
+ 
+ return 0;
+}
+
+static int setup(struct spi_device *spi)
+{
+ struct pxa2xx_spi_chip *chip_info;
+ struct chip_data *chip;
+ 
+ chip_info = (struct pxa2xx_spi_chip *)spi->platform_data;
+ 
+ /* Only alloc on first setup */
+ chip = spi_get_ctldata(spi);
+ if (chip == NULL) {
+  chip = kcalloc(1, sizeof(struct chip_data), GFP_KERNEL);
+  if (!chip)
+   return -ENOMEM;
+
+  spi->mode = chip_info->mode;
+  spi->bits_per_word = chip_info->bits_per_word;
+ }
+ 
+ chip->cs_gpio = chip_info->chip_select_gpio;
+ chip->cr0 = SSCR0_SerClkDiv((MAX_SPEED_HZ / spi->max_speed_hz) + 2) 
+   | SSCR0_Motorola 
+   | SSCR0_DataSize(spi->bits_per_word) 
+   | SSCR0_SSE
+   | (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
+ chip->cr1 = SSCR1_RxTresh(chip_info->rx_threshold) 
+   | SSCR1_TxTresh(chip_info->tx_threshold) 
+   | (((spi->mode & SPI_CPHA) != 0) << 4) 
+   | (((spi->mode & SPI_CPOL) != 0) << 3);
+ chip->to = 0;
+ chip->psp = 0;
+ chip->timeout = (chip_info->timeout_microsecs * 10000) / 2712;
+ 
+ if (spi->bits_per_word <= 8) {
+  chip->n_bytes = 1;
+  chip->read = u8_reader;
+  chip->write = u8_writer;
+ }
+ else if (spi->bits_per_word <= 16) {
+  chip->n_bytes = 2;
+  chip->read = u16_reader;
+  chip->write = u16_writer;
+ }
+ else if (spi->bits_per_word <= 32) {
+  chip->n_bytes = 4;
+  chip->read = u32_reader;
+  chip->write = u32_writer;
+ }
+ else {
+  printk(KERN_ERR "pxa2xx_spi_ssp: invalid wordsize\n");
+  kfree(chip);
+  return -ENODEV;
+ }
+  
+ spi_set_ctldata(spi, chip);
+ 
+ dev_dbg(&spi->dev, "gpio=%u sscr0=0x%08x sscr1=0x%08x "
+    "ssto=0x%08x sspsp=0x%08x\n", 
+    chip->cs_gpio, chip->cr0, 
+    chip->cr1, chip->to, chip->psp);
+   
+ return 0;
+}
+
+static void cleanup(const struct spi_device *spi)
+{
+ struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
+ 
+ if (chip)
+  kfree(chip);
+ 
+ dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n", 
+    spi->master->bus_num, spi->chip_select);
+}
+
+static int probe(struct device *dev)
+{
+ struct platform_device *pdev = to_platform_device(dev);
+ struct pxa2xx_spi_master *platform_info;
+ struct spi_master *master;
+ struct master_data *drv_data = 0;
+ struct resource *memory_resource;
+ int irq;
+ int status = 0;
+
+ platform_info = (struct pxa2xx_spi_master *)pdev->dev.platform_data;
+ 
+ master = spi_alloc_master(dev, sizeof(struct master_data));
+ if (!master)
+  return -ENOMEM;
+ drv_data = class_get_devdata(&master->cdev);
+ drv_data->master = master; 
+  
+ INIT_LIST_HEAD(&drv_data->queue);
+ spin_lock_init(&drv_data->lock);
+
+ tasklet_init(&drv_data->pump_messages, 
+   pump_messages, 
+   (unsigned long)drv_data);
+
+ tasklet_init(&drv_data->pump_transfers, 
+   pump_transfers, 
+   (unsigned long)drv_data);
+ 
+ master->bus_num = platform_info->bus_num;
+ master->num_chipselect = platform_info->num_chipselect;
+ master->cleanup = cleanup;
+ master->setup = setup;
+ master->transfer = transfer;
+ 
+ /* Setup register addresses */
+ memory_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ if (!memory_resource) {
+  dev_dbg(dev, "can not find platform io memory\n");
+  status = -ENODEV;
+  goto out_error_memory;
+ }
+ 
+ drv_data->sscr0 = memory_resource->start + 0x00000000;
+ drv_data->sscr1 = memory_resource->start + 0x00000004;
+ drv_data->sssr = memory_resource->start + 0x00000008;
+ drv_data->ssitr = memory_resource->start + 0x0000000c;
+ drv_data->ssdr = memory_resource->start + 0x00000010;
+ drv_data->ssto = memory_resource->start + 0x00000028;
+ drv_data->sspsp = memory_resource->start + 0x0000002c;
+ 
+ /* Attach to IRQ */
+ irq = platform_get_irq(pdev, 0);
+ if (irq == 0) {
+  dev_dbg(dev, "problem getting IORESOURCE_IRQ[0]\n");
+  status = -ENODEV;
+  goto out_error_memory;
+ }
+ 
+ status = request_irq(irq, ssp_int, SA_INTERRUPT, dev->bus_id, drv_data);
+ if (status < 0) {
+  dev_dbg(dev, "problem requesting IORESOURCE_IRQ %u\n", irq);
+  goto out_error_memory;
+ }
+ 
+ /* Enable SOC clock */
+ pxa_set_cken(platform_info->clock_enable, 1);
+  
+ /* Load default SSP configuration */
+ __REG(drv_data->sscr0) = 0;
+ __REG(drv_data->sscr1) = SSCR1_RxTresh(4) | SSCR1_TxTresh(12);
+ __REG(drv_data->sscr0) = SSCR0_SerClkDiv(2) 
+     | SSCR0_Motorola 
+     | SSCR0_DataSize(8);
+ __REG(drv_data->ssto) = 0;
+ __REG(drv_data->sspsp) = 0;
+ 
+ dev_set_drvdata(dev, master);
+ status = spi_register_master(master);
+ if (status != 0) {
+  goto out_error_irq;
+ }
+  
+ return status;
+
+out_error_irq:
+ free_irq(irq, drv_data);
+ 
+out_error_memory:
+ class_device_put(&master->cdev);
+
+ return status;
+}
+
+static int remove(struct device *dev)
+{
+ struct platform_device *pdev = to_platform_device(dev);
+ struct spi_master *master = dev_get_drvdata(dev);
+ struct master_data *drv_data = class_get_devdata(&master->cdev);
+ struct pxa2xx_spi_master *platform_info;
+ 
+ int irq;
+ unsigned long flags;
+ 
+ platform_info = (struct pxa2xx_spi_master *)pdev->dev.platform_data;
+
+ spin_lock_irqsave(&drv_data->lock, flags);
+
+ __REG(drv_data->sscr0) = 0;
+ pxa_set_cken(platform_info->clock_enable, 0);
+
+ irq = platform_get_irq(pdev, 0);
+ if (irq != 0)
+  free_irq(irq, drv_data);
+ 
+ spin_unlock_irqrestore(&drv_data->lock, flags);
+
+ spi_unregister_master(master);
+ 
+ return 0;
+}
+
+static struct device_driver driver = {
+ .name = "pxa2xx-spi-ssp",
+ .bus = &platform_bus_type,
+ .owner = THIS_MODULE,
+ .probe = probe,
+ .remove = remove,
+};
+
+static int pxa2xx_spi_ssp_init(void)
+{
+ driver_register(&driver);
+ 
+ return 0;
+}
+module_init(pxa2xx_spi_ssp_init);
+
+static void pxa2xx_spi_ssp_exit(void)
+{
+ driver_unregister(&driver);
+}
+module_exit(pxa2xx_spi_ssp_exit);
--- linux-2.6.12-spi/include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h 1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-spi-pxa/include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h 2005-10-04 12:50:22.922007000 -0700
@@ -0,0 +1,36 @@
+/* Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef PXA2XX_SPI_SSP_H_
+#define PXA2XX_SPI_SSP_H_
+
+struct pxa2xx_spi_master {
+ u16 bus_num;
+ u32 clock_enable;
+ u16 num_chipselect;
+};
+
+struct pxa2xx_spi_chip {
+ u8 mode;
+ u8 tx_threshold;
+ u8 rx_threshold;
+ u8 bits_per_word;
+ u16 chip_select_gpio;
+ u32 timeout_microsecs;
+};
+
+#endif /*PXA2XX_SPI_SSP_H_*/
