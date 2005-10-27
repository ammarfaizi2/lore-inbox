Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVJ0LdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVJ0LdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 07:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVJ0LdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 07:33:10 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:58319 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbVJ0LdI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 07:33:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t2xlckanCdY1ciC46QO/e20HHTZ9Hc7HLD5IgjyjCy/kOWYOcRatrHuWyaU7wroOgA34CJOlBshAqpGej1lnRffTyXbu2/UfJnqdW3VqpwTTz0mgE6ckJ/Xc2WAMK2XoWYk1E+6ugYhcx2HxpPEainYRCWaIZg09/ddtsg1Y2Ic=
Message-ID: <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
Date: Thu, 27 Oct 2005 19:33:07 +0800
From: Mike Lee <eemike@gmail.com>
To: "stephen@streetfiresound.com" <stephen@streetfiresound.com>
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
In-Reply-To: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stepen
   I am now writing another controller driver by david's framework.
But leak of debuging layer, could your loopback driver serve for this
purpose and how could i use it?

Mike,Lee

On 10/26/05, stephen@streetfiresound.com <stephen@streetfiresound.com> wrote:
> This is a refresh of my initial "SPI controller" implementation running on
> David Brownell's "simple SPI framework". The controller should run on any
> PXA2xx SSP port and has been tested on the PXA255 NSSP port.  Complete
> board setup and description facilities per the SPI framework are
> supported.
>
> Summary of changes:
>    - Added non-descriptor DMA support for aligned buffers.
>    - Modifications to support transfers from interrupt context.
>    - Addition of "loopback" demo "SPI protocol" driver.
>
> David's SPI patch can be found at
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112844925715957&w=2
>
> Your comments and suggestions encouraged!  You can e-mail me directly if you
> have any question regarding running SPI controller on your board.
>
> Stephen Street
>
> ---snip---
>
> This is a prototype dma/interrupt driven SPI "controller" for Intel's PXA2xx
> series SOC. The driver plugs into the lightweight SPI framework developed by
> David Brownell. Hardwired configuration information is provided via
> spi_board_info structures initialized in arch/arm/mach_pxa board
> initialization code (see include/linux/spi.h for details).
>
> The driver is built around a spi_message fifo serviced by two tasklets. The
> first tasklet (pump_messages) is responsible for queuing SPI transactions
> and scheduling SPI transfers.  The second tasklet (pump_transfers) is
> responsible to setting up and launching the dma/interrupt driven transfers.
> DMA transfers maybe enabled by setting the "enable_dma" flag in the
> "pxa2xx_spi_master" structure.  The driver will select DMA transfers if the
> "spi_message" transfer buffers are aligned on a 8-byte boundary.  Unaligned
> buffers will be sent using interrupt driven PIO. The driver user "Streaming
> DMA mappings" to program two PXA2xx dma channels aquired during the device
> probing. Per transfer chip select and delay control is available.
>
> This is a prototype driver, so you mileage will vary. It has only been
> tested on the NSSP port.
>
> Known Limitations:
>   Does not handle invert chip select polarity.
>   Heavy loaded systems may see transaction failures.
>   Wordsize support is untested.
>   Module hangs during unload.
>
>  drivers/spi/Kconfig                       |   11
>  drivers/spi/Makefile                      |    3
>  drivers/spi/pxa2xx_loopback.c             |  403 +++++++++
>  drivers/spi/pxa2xx_spi_ssp.c              | 1286 ++++++++++++++++++++++++++++++
>  include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h |   42
>  5 files changed, 1745 insertions(+)
>
> --- linux-2.6.12-spi/drivers/spi/Kconfig        2005-10-25 16:17:54.101062361 -0700
> +++ linux-2.6.12-spi-pxa/drivers/spi/Kconfig    2005-10-25 16:13:14.434103295 -0700
> @@ -65,6 +65,12 @@
>  comment "SPI Master Controller Drivers"
>
>
> +config SPI_PXA_SSP
> +       tristate "PXA SSP controller as SPI master"
> +       depends on ARCH_PXA
> +       help
> +         This implements SPI master mode using an SSP controller.
> +
>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #
> @@ -77,6 +83,11 @@
>  comment "SPI Protocol Masters"
>
>
> +config SPI_PXA_LOOPBACK
> +       tristate "PXA2xx Loopback device"
> +       help
> +         This is a test and development loopback driver.
> +
>  #
>  # Add new SPI protocol masters in alphabetical order above this line
>  #
> --- linux-2.6.12-spi/drivers/spi/Makefile       2005-10-25 16:17:54.123061965 -0700
> +++ linux-2.6.12-spi-pxa/drivers/spi/Makefile   2005-10-25 16:13:44.128574038 -0700
> @@ -11,9 +11,12 @@
>  obj-$(CONFIG_SPI_MASTER)               += spi.o
>
>  # SPI master controller drivers (bus)
> +obj-$(CONFIG_SPI_PXA_SSP)              += pxa2xx_spi_ssp.o
>  #      ... add above this line ...
>
>  # SPI protocol drivers (device/link on bus)
> +obj-$(CONFIG_SPI_PXA_LOOPBACK)         += pxa2xx_loopback.o
> +
>  #      ... add above this line ...
>
>  # SPI slave controller drivers (upstream link)
> --- linux-2.6.12-spi/drivers/spi/pxa2xx_spi_ssp.c       1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.12-spi-pxa/drivers/spi/pxa2xx_spi_ssp.c   2005-10-25 15:58:06.325046000 -0700
> @@ -0,0 +1,1286 @@
> +/*
> + * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/*
> + * This is a prototype dma/interrupt driven SPI "controller" for Intel's PXA2xx
> + * series SOC. The driver plugs into the lightweight SPI framework developed by
> + * David Brownell. Hardwired configuration information is provided via
> + * spi_board_info structures initialized in arch/arm/mach_pxa board
> + * initialization code (see include/linux/spi.h for details).
> + *
> + * This follow code snippet demostrates a sample board configuration using
> + * the PXA255 NSSP port connect to a "loopback" pseudo-chip.
> + *
> + *
> + * static struct pxa2xx_spi_chip loopback_chip_info = {
> + *     .mode = SPI_MODE_3,
> + *     .tx_threshold = 12,
> + *     .rx_threshold = 4,
> + *     .dma_burst_size = 8,
> + *     .bits_per_word = 8,
> + *     .timeout_microsecs = 64,
> + *     .enable_loopback = 1,
> + * };
> + *
> + * static struct spi_board_info board_info[] __initdata = {
> + *     {
> + *             .modalias = "loopback",
> + *             .max_speed_hz = 3686400,
> + *             .bus_num = 2,
> + *             .chip_select = 0,
> + *             .controller_data = &loopback_chip_info,
> + *     },
> + * };
> + *
> + * static struct resource pxa_spi_resources[] = {
> + *     [0] = {
> + *             .start  = __PREG(SSCR0_P(2)),
> + *             .end    = __PREG(SSCR0_P(2)) + 0x2c,
> + *             .flags  = IORESOURCE_MEM,
> + *     },
> + *     [1] = {
> + *             .start  = IRQ_NSSP,
> + *             .end    = IRQ_NSSP,
> + *             .flags  = IORESOURCE_IRQ,
> + *     },
> + * };
> + *
> + * static struct pxa2xx_spi_master pxa_nssp_master_info = {
> + *     .bus_num = 2,
> + *     .clock_enable = CKEN9_NSSP,
> + *     .num_chipselect = 3,
> + *     .enable_dma = 1,
> + * };
> + *
> + * static struct platform_device pxa_spi_ssp = {
> + *     .name = "pxa2xx-spi-ssp",
> + *     .id = -1,
> + *     .resource = pxa_spi_resources,
> + *     .num_resources = ARRAY_SIZE(pxa_spi_resources),
> + *     .dev = {
> + *             .platform_data = &pxa_nssp_master_info,
> + *     },
> + * };
> + *
> + * static void __init streetracer_init(void)
> + * {
> + *     platform_device_register(&pxa_spi_ssp);
> + *     spi_register_board_info(board_info, ARRAY_SIZE(board_info));
> + * }
> + *
> + * The driver is built around a spi_message fifo serviced by two tasklets. The
> + * first tasklet (pump_messages) is responsible for queuing SPI transactions
> + * and scheduling SPI transfers.  The second tasklet (pump_transfers) is
> + * responsible to setting up and launching the dma/interrupt driven transfers.
> + * DMA transfers maybe enabled by setting the "enable_dma" flag in the
> + * "pxa2xx_spi_master" structure.  The driver will select DMA transfers if the
> + * "spi_message" transfer buffers are aligned on a 8-byte boundary.  Unaligned
> + * buffers will be sent using interrupt driven PIO. The driver user "Streaming
> + * DMA mappings" to program two PXA2xx dma channels aquired during the device
> + * probing. Per transfer chip select and delay control is available.
> + *
> + * This is a prototype driver, so you mileage will vary. It has only been
> + * tested on the NSSP port.
> + *
> + * Known Limitations:
> + *     Does not handle invert chip select polarity.
> + *     Heavy loaded systems may see transaction failures.
> + *     Wordsize support is untested.
> + *     Module hangs during unload.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/spi.h>
> +#include <linux/ioport.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/hardware.h>
> +#include <asm/delay.h>
> +#include <asm/dma.h>
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/arch/pxa-regs.h>
> +#include <asm/arch/pxa2xx_spi_ssp.h>
> +
> +MODULE_AUTHOR("Stephen Street");
> +MODULE_DESCRIPTION("PXA2xx SSP SPI Contoller");
> +MODULE_LICENSE("GPL");
> +
> +#define MAX_SPEED_HZ 3686400
> +#define MAX_BUSES 3
> +
> +#define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
> +#define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
> +
> +#define IS_DMA_ALIGNED(x,y) ((((u32)(x)& 0x07)==0) && (((u32)(y)& 0x07)==0))
> +#define GET_IRQ_STATUS(x) (__REG(x)&(SSSR_TINT|SSSR_RFS|SSSR_TFS|SSSR_ROR))
> +
> +struct master_data;
> +
> +struct transfer_state {
> +       int index;
> +       int len;
> +       void *tx;
> +       void *tx_end;
> +       void *rx;
> +       void *rx_end;
> +       void (*write)(u32 sssr, u32 ssdr, struct transfer_state *state);
> +       void (*read)(u32 sssr, u32 ssdr, struct transfer_state *state);
> +       irqreturn_t (*transfer_handler)(struct master_data *drv_data,
> +                                       struct spi_message *msg,
> +                                       struct transfer_state *state);
> +       void (*cs_control)(u32 command);
> +};
> +
> +struct master_data {
> +       spinlock_t lock;
> +       struct spi_master *master;
> +       int rx_channel;
> +       int tx_channel;
> +       struct list_head queue;
> +       struct tasklet_struct pump_messages;
> +       struct tasklet_struct pump_transfers;
> +       struct spi_message* cur_msg;
> +       struct transfer_state cur_state;
> +       void *null_dma_buf;
> +       u32 trans_cnt;
> +       u32 dma_trans_cnt;
> +       u32 int_trans_cnt;
> +       u32 bigunalign_cnt;
> +       u32 buserr_cnt;
> +       u32 ror_cnt;
> +       u32 sscr0;
> +       u32 sscr1;
> +       u32 sssr;
> +       u32 ssitr;
> +       u32 ssdr;
> +       u32 ssto;
> +       u32 sspsp;
> +};
> +
> +struct chip_data {
> +       u32 cr0;
> +       u32 cr1;
> +       u32 to;
> +       u32 psp;
> +       u32 timeout;
> +       u8 n_bytes;
> +       u32 dma_width;
> +       u32 dma_burst_size;
> +       u32 threshold;
> +       u32 dma_threshold;
> +       u8 enable_dma;
> +       void (*write)(u32 sssr, u32 ssdr, struct transfer_state *state);
> +       void (*read)(u32 sssr, u32 ssdr, struct transfer_state *state);
> +       void (*cs_control)(u32 command);
> +};
> +
> +static inline void flush(struct master_data *drv_data)
> +{
> +       u32 sssr = drv_data->sssr;
> +       u32 ssdr = drv_data->ssdr;
> +
> +       do {
> +               while (__REG(sssr) & SSSR_RNE) {
> +                       (void)__REG(ssdr);
> +               }
> +       } while (__REG(sssr) & SSSR_BSY);
> +       __REG(sssr) = SSSR_ROR ;
> +}
> +
> +static inline void save_state(struct master_data *drv_data,
> +                               struct chip_data *chip)
> +{
> +       /* Save critical register */
> +       chip->cr0 = __REG(drv_data->sscr0);
> +       chip->cr1 = __REG(drv_data->sscr1);
> +       chip->to = __REG(drv_data->ssto);
> +       chip->psp = __REG(drv_data->sspsp);
> +
> +       /* Disable clock */
> +       __REG(drv_data->sscr0) &= ~SSCR0_SSE;
> +}
> +
> +static inline void restore_state(struct master_data *drv_data,
> +                                       struct chip_data *chip)
> +{
> +       /* Clear status and disable clock*/
> +       __REG(drv_data->sssr) = SSSR_ROR | SSSR_TUR | SSSR_BCE;
> +       __REG(drv_data->sscr0) = chip->cr0 & ~SSCR0_SSE;
> +
> +       /* Load the registers */
> +       __REG(drv_data->sscr1) = chip->cr1;
> +       __REG(drv_data->ssto) = chip->to;
> +       __REG(drv_data->sspsp) = chip->psp;
> +       __REG(drv_data->sscr0) = chip->cr0;
> +}
> +
> +static inline void dump_state(struct master_data* drv_data)
> +{
> +       u32 sscr0 = drv_data->sscr0;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 sssr = drv_data->sssr;
> +       u32 ssto = drv_data->ssto;
> +       u32 sspsp = drv_data->sspsp;
> +
> +       printk("SSP dump: sscr0=0x%08x, sscr1=0x%08x, "
> +                       "ssto=0x%08x, sspsp=0x%08x, sssr=0x%08x\n",
> +                       __REG(sscr0), __REG(sscr1), __REG(ssto),
> +                       __REG(sspsp), __REG(sssr));
> +}
> +
> +static inline void dump_message(struct spi_message *msg)
> +{
> +       int i;
> +       struct device *dev = &msg->dev->dev;
> +
> +       dev_dbg(dev, "message = %p\n", msg);
> +       dev_dbg(dev, "    complete = %p\n", msg->complete);
> +       dev_dbg(dev, "    context = %p\n", msg->context);
> +       dev_dbg(dev, "    actual_length = %u\n", msg->actual_length);
> +       dev_dbg(dev, "    status = %d\n", msg->status);
> +       dev_dbg(dev, "    state = %p\n", msg->state);
> +       dev_dbg(dev, "    n_transfers = %u\n", msg->n_transfer);
> +
> +       for (i = 0; i < msg->n_transfer; i++) {
> +               dev_dbg(dev, "        %d, tx_buf = %p\n",
> +                               i, msg->transfers[i].tx_buf);
> +               dev_dbg(dev, "        %d, rx_buf = %p\n",
> +                               i, msg->transfers[i].rx_buf);
> +               dev_dbg(dev, "        %d, tx_dma = %p\n",
> +                               i, (void *)msg->transfers[i].tx_dma);
> +               dev_dbg(dev, "        %d, rx_dma = %p\n",
> +                               i, (void *)msg->transfers[i].rx_dma);
> +               dev_dbg(dev, "        %d, len = %u\n",
> +                               i, msg->transfers[i].len);
> +               dev_dbg(dev, "        %d, cs_change = %u\n",
> +                               i, msg->transfers[i].cs_change);
> +               dev_dbg(dev, "        %d, delay_usecs = %u\n",
> +                               i, msg->transfers[i].delay_usecs);
> +       }
> +}
> +
> +static void null_cs_control(u32 command)
> +{
> +}
> +
> +static void null_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
> +               __REG(ssdr) = 0;
> +               ++state->tx;
> +       }
> +}
> +
> +static void null_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
> +               (void)(__REG(ssdr));
> +               ++state->rx;
> +       }
> +}
> +
> +static void u8_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
> +               __REG(ssdr) = *(u8 *)(state->tx);
> +               ++state->tx;
> +       }
> +}
> +
> +static void u8_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
> +               *(u8 *)(state->rx) = __REG(ssdr);
> +               ++state->rx;
> +       }
> +}
> +
> +static void u16_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
> +               __REG(ssdr) = *(u16 *)(state->tx);
> +               state->tx += 2;
> +       }
> +}
> +
> +static void u16_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
> +               *(u16 *)(state->rx) = __REG(ssdr);
> +               state->rx += 2;
> +       }
> +}
> +static void u32_writer(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_TNF) && (state->tx < state->tx_end)) {
> +               __REG(ssdr) = *(u32 *)(state->tx);
> +               state->tx += 4;
> +       }
> +}
> +
> +static void u32_reader(u32 sssr, u32 ssdr, struct transfer_state *state)
> +{
> +       while ((__REG(sssr) & SSSR_RNE) && (state->rx < state->rx_end)) {
> +               *(u32 *)(state->rx) = __REG(ssdr);
> +               state->rx += 4;
> +       }
> +}
> +
> +static void dma_handler(int channel, void *data, struct pt_regs *regs)
> +{
> +       struct master_data *drv_data = (struct master_data *)data;
> +       u32 sssr = drv_data->sssr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->sscr1;
> +       u32 irq_status = DCSR(drv_data->tx_channel) & DMA_INT_MASK;
> +       struct spi_message *msg = drv_data->cur_msg;
> +       struct transfer_state *state = (struct transfer_state *)msg->context;
> +
> +       if (irq_status & DCSR_BUSERR) {
> +
> +               __REG(ssto) = 0;
> +               __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +               __REG(sscr1) &= ~(SSCR1_TSRE | SSCR1_RSRE | SSCR1_TINTE);
> +               DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +               DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +
> +               flush(drv_data);
> +
> +               printk(KERN_ERR "dma_handler: bad bus address on channel %d\n",
> +                                       channel);
> +
> +               drv_data->buserr_cnt++;
> +               drv_data->cur_state.index = -2;
> +               tasklet_schedule(&drv_data->pump_transfers);
> +       }
> +
> +       if (channel == drv_data->rx_channel && irq_status & DCSR_ENDINTR) {
> +               /* Forward to transfer handler */
> +               state->rx = state->rx_end;
> +               state->transfer_handler(drv_data, msg, state);
> +       }
> +
> +
> +}
> +
> +static irqreturn_t dma_transfer(struct master_data *drv_data,
> +                               struct spi_message *msg,
> +                               struct transfer_state *state)
> +{
> +       u32 sssr = drv_data->sssr;
> +       u32 ssdr = drv_data->ssdr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->ssto;
> +       u32 irq_status = GET_IRQ_STATUS(sssr);
> +       u32 trailing_sssr = 0;
> +
> +       if (irq_status & SSSR_ROR) {
> +               /* Clear and disable interrupts on SSP and DMA channels*/
> +               __REG(ssto) = 0;
> +               __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +               __REG(sscr1) &= ~(SSCR1_TSRE | SSCR1_RSRE | SSCR1_TINTE);
> +               DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +               DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +
> +               flush(drv_data);
> +
> +               printk(KERN_WARNING "dma_transfer: fifo overun"
> +                                       "tx dcmd = 0x%08x rx dcmd = 0x%08x\n",
> +                                       DCMD(drv_data->tx_channel),
> +                                       DCMD(drv_data->rx_channel));
> +
> +               drv_data->ror_cnt++;
> +
> +               state->index = -2;
> +               tasklet_schedule(&drv_data->pump_transfers);
> +
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (irq_status & SSSR_TINT || state->rx == state->rx_end) {
> +
> +               /* Check for false positive */
> +               if (DCSR(drv_data->tx_channel) & DCSR_RUN) {
> +                       __REG(sssr) = SSSR_TINT;
> +                       return IRQ_HANDLED;
> +               }
> +
> +               /* Clear and disable interrupts on SSP and DMA channels*/
> +               __REG(ssto) = 0;
> +               __REG(sssr) = SSSR_TINT | SSSR_ROR ;
> +               __REG(sscr1) &= ~(SSCR1_TSRE | SSCR1_RSRE | SSCR1_TINTE);
> +               DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +               DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +               while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE)
> +                               || (__REG(sssr) & SSSR_BSY));
> +
> +               /* Handle trailing byte, must unmap the dma buffers */
> +               dma_unmap_single(&msg->dev->dev,
> +                                       msg->transfers[state->index].tx_dma,
> +                                       msg->transfers[state->index].len,
> +                                       DMA_TO_DEVICE);
> +               dma_unmap_single(&msg->dev->dev,
> +                                       msg->transfers[state->index].rx_dma,
> +                                       msg->transfers[state->index].len,
> +                                       DMA_FROM_DEVICE);
> +
> +               /* Calculate number of trailing bytes */
> +               trailing_sssr = __REG(sssr);
> +               if ((trailing_sssr & 0xf008) != 0xf000) {
> +                       state->rx = state->rx_end -
> +                                       (((trailing_sssr >> 12) & 0x0f) + 1);
> +                       state->read(sssr, ssdr, state);
> +               }
> +
> +               if (msg->transfers[state->index].cs_change)
> +                       state->cs_control(PXA2XX_CS_DEASSERT);
> +
> +               /* Schedule transfer tasklet */
> +               msg->actual_length += msg->transfers[state->index].len;
> +               ++state->index;
> +               tasklet_schedule(&drv_data->pump_transfers);
> +
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}
> +
> +static irqreturn_t interrupt_transfer(struct master_data *drv_data,
> +                                       struct spi_message *msg,
> +                                       struct transfer_state *state)
> +{
> +       u32 sssr = drv_data->sssr;
> +       u32 ssdr = drv_data->ssdr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->ssto;
> +       u32 irq_status;
> +
> +       while ((irq_status = GET_IRQ_STATUS(sssr))) {
> +
> +               if (irq_status & SSSR_ROR) {
> +
> +                       /* Clear and disable interrupts */
> +                       __REG(ssto) = 0;
> +                       __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +                       __REG(sscr1) &= ~(SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
> +
> +                       flush(drv_data);
> +
> +                       printk(KERN_WARNING "interrupt_transfer: fifo overun, "
> +                                       "index=%d tx_len=%d rx_len=%d\n",
> +                                       state->index,
> +                                       (state->tx_end - state->tx),
> +                                       (state->rx_end - state->rx));
> +
> +                       drv_data->ror_cnt++;
> +                       state->index = -2;
> +                       tasklet_schedule(&drv_data->pump_transfers);
> +
> +                       return IRQ_HANDLED;
> +               }
> +
> +               /* Look for false positive timeout */
> +               if ((irq_status & SSSR_TINT) && (state->rx < state->rx_end))
> +                       __REG(sssr) = SSSR_TINT;
> +
> +               /* Pump data */
> +               state->read(sssr, ssdr, state);
> +               state->write(sssr, ssdr, state);
> +
> +               /* Disable tx interrupt enable rx timeout */
> +               if (state->tx == state->tx_end) {
> +                       __REG(sscr1) &= ~SSCR1_TIE;
> +               }
> +
> +               if ((irq_status & SSSR_TINT) || (state->rx == state->rx_end)) {
> +
> +                       /* Clear timeout */
> +                       __REG(ssto) = 0;
> +                       __REG(sssr) = SSSR_TINT | SSSR_ROR ;
> +                       __REG(sscr1) &= ~(SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
> +
> +                       msg->actual_length += msg->transfers[state->index].len;
> +
> +                       if (msg->transfers[state->index].cs_change)
> +                               state->cs_control(PXA2XX_CS_DEASSERT);
> +
> +                       /* Schedule transfer tasklet */
> +                       ++state->index;
> +                       tasklet_schedule(&drv_data->pump_transfers);
> +
> +                       return IRQ_HANDLED;
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ssp_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +       struct master_data *drv_data = (struct master_data *)dev_id;
> +       struct transfer_state *state;
> +       struct spi_message *msg;
> +
> +       if (!drv_data->cur_msg || !drv_data->cur_msg->state) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad message or transfer "
> +                               "state in interrupt handler\n");
> +               return IRQ_NONE;
> +       }
> +       state = (struct transfer_state *)drv_data->cur_msg->state;
> +       msg = drv_data->cur_msg;
> +
> +       return state->transfer_handler(drv_data, msg, state);
> +}
> +
> +static void pump_dma_transfers(unsigned long data)
> +{
> +       struct master_data *drv_data = (struct master_data *)data;
> +       struct spi_message *message = drv_data->cur_msg;
> +       struct chip_data *chip;
> +       struct transfer_state * state;
> +       struct spi_transfer *transfer;
> +       u32 sssr = drv_data->sssr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->ssto;
> +       u32 tx_dcd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> +       u32 rx_dcd = DCMD_INCTRGADDR | DCMD_FLOWSRC | DCMD_ENDIRQEN;
> +       u32 tx_map_len;
> +       u32 rx_map_len;
> +       unsigned long flags;
> +
> +       if (!message) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad pump_transfers "
> +                               "schedule\n");
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       state = (struct transfer_state *)message->state;
> +       if (!state) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad message state\n");
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       chip = spi_get_ctldata(message->dev);
> +       if (!chip) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad chip data\n");
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle for abort */
> +       if (state->index == -2) {
> +               message->status = -EIO;
> +               if (message->complete) {
> +                       message->complete(message->context);
> +               }
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle end of message */
> +       if (state->index == message->n_transfer) {
> +               if (!message->transfers[state->index].cs_change)
> +                       state->cs_control(PXA2XX_CS_DEASSERT);
> +
> +               message->status = 0;
> +               if (message->complete)
> +                       message->complete(message->context);
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle start of message */
> +       if (state->index == -1) {
> +               restore_state(drv_data, chip);
> +               flush(drv_data);
> +               ++state->index;
> +       }
> +
> +       /* Delay if requested at end of transfer*/
> +       if (state->index > 1) {
> +               transfer = message->transfers + (state->index - 1);
> +               if (transfer->delay_usecs)
> +                       udelay(transfer->delay_usecs);
> +       }
> +
> +       /* Setup the transfer state based on the type of transfer */
> +       flush(drv_data);
> +       drv_data->trans_cnt++;
> +       transfer = message->transfers + state->index;
> +       state->cs_control = !chip->cs_control ?
> +                               null_cs_control : chip->cs_control;
> +       state->tx = (void *)transfer->tx_buf;
> +       state->tx_end = state->tx + (transfer->len * chip->n_bytes);
> +       state->rx = transfer->rx_buf;
> +       state->rx_end = state->rx + (transfer->len * chip->n_bytes);
> +       state->write = state->tx ? chip->write : null_writer;
> +       state->read = state->rx ? chip->read : null_reader;
> +
> +       /* Make sure DMA is enable and buffer are aligned on 8-byte boundary */
> +       if (chip->enable_dma && IS_DMA_ALIGNED(state->tx, state->rx)) {
> +
> +               /* Ensure we have the correct interrupt handler */
> +               state->transfer_handler = dma_transfer;
> +               drv_data->dma_trans_cnt++;
> +
> +               /* Use local DMA if no rx buf specified */
> +               if (state->rx == NULL) {
> +                       *(u32 *)(drv_data->null_dma_buf) = 0;
> +                       state->rx = drv_data->null_dma_buf;
> +                       rx_map_len = 4;
> +                       rx_dcd &= ~DCMD_INCTRGADDR;
> +               }
> +               else
> +                       rx_map_len = transfer->len & DCMD_LENGTH;
> +
> +
> +               /* Disable cache on rx buffer */
> +               transfer->rx_dma =
> +                       dma_map_single(&message->dev->dev,
> +                                       state->rx,
> +                                       rx_map_len,
> +                                       DMA_FROM_DEVICE);
> +
> +               if (dma_mapping_error(transfer->rx_dma))
> +                       goto out_mapping_error;
> +
> +               /* Setup rx DMA Channel */
> +               DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
> +               DSADR(drv_data->rx_channel) = drv_data->ssdr;
> +               DTADR(drv_data->rx_channel) = transfer->rx_dma;
> +               DCMD(drv_data->rx_channel) = rx_dcd
> +                                               | chip->dma_width
> +                                               | chip->dma_burst_size
> +                                               | transfer->len;
> +
> +               /* Use local DMA if no tx buf specified */
> +               if (transfer->tx_buf == NULL) {
> +                       *(u32 *)(drv_data->null_dma_buf) = 0;
> +                       state->tx = drv_data->null_dma_buf;
> +                       tx_map_len = 4;
> +                       tx_dcd &= ~DCMD_INCSRCADDR;
> +               }
> +               else
> +                       tx_map_len = transfer->len & DCMD_LENGTH;
> +
> +               /* Disable cache on tx buffer */
> +               transfer->tx_dma =
> +                       dma_map_single(&message->dev->dev,
> +                                       state->tx,
> +                                       tx_map_len,
> +                                       DMA_TO_DEVICE);
> +
> +               if (dma_mapping_error(transfer->tx_dma))
> +                       goto out_mapping_error;
> +
> +               /* Setup tx DMA Channel */
> +               DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
> +               DSADR(drv_data->tx_channel) = transfer->tx_dma;
> +               DTADR(drv_data->tx_channel) = drv_data->ssdr;
> +               DCMD(drv_data->tx_channel) = tx_dcd
> +                                               | chip->dma_width
> +                                               | chip->dma_burst_size
> +                                               | transfer->len;
> +
> +               /* Fix me, need to handle cs polarity */
> +               state->cs_control(PXA2XX_CS_ASSERT);
> +
> +               /* Go baby, go */
> +               local_irq_save(flags);
> +               __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +               DCSR(drv_data->rx_channel) |= DCSR_RUN;
> +               DCSR(drv_data->tx_channel) |= DCSR_RUN;
> +               __REG(ssto) = chip->timeout;
> +               __REG(sscr1) = chip->cr1
> +                               | chip->dma_threshold
> +                               | SSCR1_TSRE
> +                               | SSCR1_RSRE
> +                               | SSCR1_TINTE;
> +               local_irq_restore(flags);
> +       }
> +       else {
> +               if (transfer->len > 16)
> +                       drv_data->bigunalign_cnt++;
> +
> +               /* Ensure we have the correct interrupt handler */
> +               state->transfer_handler = interrupt_transfer;
> +               drv_data->int_trans_cnt++;
> +
> +               /* Fix me, need to handle cs polarity */
> +               state->cs_control(PXA2XX_CS_ASSERT);
> +
> +               /* Go baby, go */
> +               local_irq_save(flags);
> +               __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +               __REG(ssto) = chip->timeout;
> +               __REG(sscr1) = chip->cr1
> +                               | chip->threshold
> +                               | SSCR1_TIE
> +                               | SSCR1_RIE
> +                               | SSCR1_TINTE;
> +               local_irq_restore(flags);
> +       }
> +
> +       return;
> +
> +out_mapping_error:
> +       printk(KERN_ERR "problem mapping dma buf\n");
> +       message->status = -EIO;
> +       if (message->complete) {
> +               message->complete(message->context);
> +       }
> +       drv_data->cur_msg = NULL;
> +       tasklet_schedule(&drv_data->pump_messages);
> +       return;
> +}
> +
> +static void pump_int_transfers(unsigned long data)
> +{
> +       struct master_data *drv_data = (struct master_data *)data;
> +       struct spi_message *message = drv_data->cur_msg;
> +       struct chip_data *chip;
> +       struct transfer_state * state;
> +       struct spi_transfer *transfer;
> +       u32 sssr = drv_data->sssr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->ssto;
> +       unsigned long flags;
> +
> +       if (!message) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad pump_transfers "
> +                               "schedule\n");
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       state = (struct transfer_state *)message->state;
> +       if (!state) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad message state\n");
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       chip = spi_get_ctldata(message->dev);
> +       if (!chip) {
> +               printk(KERN_ERR "pxs2xx_spi_ssp: bad chip data\n");
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle for abort */
> +       if (state->index == -2) {
> +               message->status = -EIO;
> +               if (message->complete) {
> +                       message->complete(message->context);
> +               }
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle end of message */
> +       if (state->index == message->n_transfer) {
> +               if (!message->transfers[state->index].cs_change)
> +               state->cs_control(PXA2XX_CS_DEASSERT);
> +
> +               message->status = 0;
> +               if (message->complete)
> +                       message->complete(message->context);
> +               drv_data->cur_msg = NULL;
> +               tasklet_schedule(&drv_data->pump_messages);
> +               return;
> +       }
> +
> +       /* Handle start of message */
> +       if (state->index == -1) {
> +               restore_state(drv_data, chip);
> +               flush(drv_data);
> +               ++state->index;
> +       }
> +
> +       /* Delay if requested at end of transfer*/
> +       if (state->index > 1) {
> +               transfer = message->transfers + (state->index - 1);
> +               if (transfer->delay_usecs)
> +                       udelay(transfer->delay_usecs);
> +       }
> +
> +       /* Setup the transfer state based on the type of transfer */
> +       flush(drv_data);
> +       drv_data->trans_cnt++;
> +       transfer = message->transfers + state->index;
> +       state->cs_control = chip->cs_control;
> +       state->tx = (void *)transfer->tx_buf;
> +       state->tx_end = state->tx + (transfer->len * chip->n_bytes);
> +       state->rx = transfer->rx_buf;
> +       state->rx_end = state->rx + (transfer->len * chip->n_bytes);
> +       state->write = state->tx ? chip->write : null_writer;
> +       state->read = state->rx ? chip->read : null_reader;
> +       state->transfer_handler = interrupt_transfer;
> +       drv_data->int_trans_cnt++;
> +
> +       /* Fix me, need to handle cs polarity */
> +       state->cs_control(PXA2XX_CS_ASSERT);
> +
> +       /* Go baby, go */
> +       local_irq_save(flags);
> +       __REG(sssr) = SSSR_TINT | SSSR_ROR;
> +       __REG(ssto) = chip->timeout;
> +       __REG(sscr1) = chip->cr1
> +                       | chip->threshold
> +                       | SSCR1_TIE
> +                       | SSCR1_RIE
> +                       | SSCR1_TINTE;
> +       local_irq_restore(flags);
> +}
> +
> +static void pump_messages(unsigned long data)
> +{
> +       struct master_data *drv_data = (struct master_data *)data;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&drv_data->lock, flags);
> +
> +       /* Check for list empty */
> +       if (list_empty(&drv_data->queue)) {
> +               spin_unlock(&drv_data->lock);
> +               return;
> +       }
> +
> +       /* Check to see if we are already running */
> +       if (drv_data->cur_msg) {
> +               spin_unlock(&drv_data->lock);
> +               return;
> +       }
> +
> +       /* Extract head of queue and check for tasklet reschedule */
> +       drv_data->cur_msg = list_entry(drv_data->queue.next,
> +                                       struct spi_message, queue);
> +       list_del_init(&drv_data->cur_msg->queue);
> +
> +       /* Setup message transfer and schedule transfer pump */
> +       drv_data->cur_msg->state = &drv_data->cur_state;
> +       drv_data->cur_state.index = -1;
> +       drv_data->cur_state.len = 0;
> +       tasklet_schedule(&drv_data->pump_transfers);
> +
> +       spin_unlock_irqrestore(&drv_data->lock, flags);
> +}
> +
> +static int transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> +       struct master_data *drv_data = class_get_devdata(&spi->master->cdev);
> +       unsigned long flags;
> +
> +       msg->actual_length = 0;
> +       msg->status = 0;
> +
> +       spin_lock_irqsave(&drv_data->lock, flags);
> +       list_add_tail(&msg->queue, &drv_data->queue);
> +       spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +       tasklet_schedule(&drv_data->pump_messages);
> +
> +       return 0;
> +}
> +
> +static int setup(struct spi_device *spi)
> +{
> +       struct pxa2xx_spi_chip *chip_info;
> +       struct chip_data *chip;
> +
> +       chip_info = (struct pxa2xx_spi_chip *)spi->platform_data;
> +
> +       /* Only alloc on first setup */
> +       chip = spi_get_ctldata(spi);
> +       if (chip == NULL) {
> +               chip = kcalloc(1, sizeof(struct chip_data), GFP_KERNEL);
> +               if (!chip)
> +                       return -ENOMEM;
> +
> +               spi->mode = chip_info->mode;
> +               spi->bits_per_word = chip_info->bits_per_word;
> +       }
> +
> +       chip->cs_control = chip_info->cs_control;
> +       chip->cr0 = SSCR0_SerClkDiv((MAX_SPEED_HZ / spi->max_speed_hz) + 2)
> +                       | SSCR0_Motorola
> +                       | SSCR0_DataSize(spi->bits_per_word)
> +                       | SSCR0_SSE
> +                       | (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
> +       chip->cr1 = (((spi->mode & SPI_CPHA) != 0) << 4)
> +                       | (((spi->mode & SPI_CPOL) != 0) << 3)
> +                       | (chip_info->enable_loopback ? SSCR1_LBM : 0);
> +       chip->to = 0;
> +       chip->psp = 0;
> +       chip->timeout = (chip_info->timeout_microsecs * 10000) / 2712;
> +       chip->threshold = SSCR1_RxTresh(chip_info->rx_threshold)
> +                               | SSCR1_TxTresh(chip_info->tx_threshold);
> +
> +       chip->enable_dma = chip_info->dma_burst_size != 0;
> +       if (chip_info->dma_burst_size <= 8) {
> +               chip->dma_threshold = SSCR1_RxTresh(8) | SSCR1_TxTresh(8);
> +               chip->dma_burst_size = DCMD_BURST8;
> +       }
> +       else if (chip_info->dma_burst_size <= 16) {
> +               chip->dma_threshold = SSCR1_RxTresh(16) | SSCR1_TxTresh(16);
> +               chip->dma_burst_size = DCMD_BURST16;
> +       }
> +       else {
> +               chip->dma_threshold = SSCR1_RxTresh(32) | SSCR1_TxTresh(32);
> +               chip->dma_burst_size = DCMD_BURST32;
> +       }
> +
> +       if (spi->bits_per_word <= 8) {
> +               chip->n_bytes = 1;
> +               chip->dma_width = DCMD_WIDTH1;
> +               chip->read = u8_reader;
> +               chip->write = u8_writer;
> +       }
> +       else if (spi->bits_per_word <= 16) {
> +               chip->n_bytes = 2;
> +               chip->dma_width = DCMD_WIDTH2;
> +               chip->read = u16_reader;
> +               chip->write = u16_writer;
> +       }
> +       else if (spi->bits_per_word <= 32) {
> +               chip->n_bytes = 4;
> +               chip->dma_width = DCMD_WIDTH4;
> +               chip->read = u32_reader;
> +               chip->write = u32_writer;
> +       }
> +       else {
> +               printk(KERN_ERR "pxa2xx_spi_ssp: invalid wordsize\n");
> +               kfree(chip);
> +               return -ENODEV;
> +       }
> +
> +       spi_set_ctldata(spi, chip);
> +
> +       return 0;
> +}
> +
> +static void cleanup(const struct spi_device *spi)
> +{
> +       struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
> +
> +       if (chip)
> +               kfree(chip);
> +
> +       dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
> +                               spi->master->bus_num, spi->chip_select);
> +}
> +
> +static ssize_t trans_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->trans_cnt);
> +}
> +DEVICE_ATTR(transfer_count, 0444, trans_cnt_show, NULL);
> +
> +static ssize_t dma_trans_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->dma_trans_cnt);
> +}
> +DEVICE_ATTR(dma_transfer_count, 0444, dma_trans_cnt_show, NULL);
> +
> +static ssize_t int_trans_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->int_trans_cnt);
> +}
> +DEVICE_ATTR(interrupt_transfer_count, 0444, int_trans_cnt_show, NULL);
> +
> +static ssize_t bigunalign_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->bigunalign_cnt);
> +}
> +DEVICE_ATTR(big_unaligned_count, 0444, bigunalign_cnt_show, NULL);
> +
> +static ssize_t buserr_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->buserr_cnt);
> +}
> +DEVICE_ATTR(bus_error_count, 0444, buserr_cnt_show, NULL);
> +
> +static ssize_t ror_cnt_show(struct device *dev, char *buf)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +
> +       return snprintf(buf, PAGE_SIZE, "%u\n", drv_data->ror_cnt);
> +}
> +DEVICE_ATTR(overrun_count, 0444, ror_cnt_show, NULL);
> +
> +static int probe(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct pxa2xx_spi_master *platform_info;
> +       struct spi_master *master;
> +       struct master_data *drv_data = 0;
> +       struct resource *memory_resource;
> +       int irq;
> +       int status = 0;
> +
> +       platform_info = (struct pxa2xx_spi_master *)pdev->dev.platform_data;
> +
> +       master = spi_alloc_master(dev, sizeof(struct master_data) + 16);
> +       if (!master)
> +               return -ENOMEM;
> +       drv_data = class_get_devdata(&master->cdev);
> +       drv_data->master = master;
> +
> +       INIT_LIST_HEAD(&drv_data->queue);
> +       spin_lock_init(&drv_data->lock);
> +
> +       tasklet_init(&drv_data->pump_messages,
> +                       pump_messages,
> +                       (unsigned long)drv_data);
> +
> +       master->bus_num = platform_info->bus_num;
> +       master->num_chipselect = platform_info->num_chipselect;
> +       master->cleanup = cleanup;
> +       master->setup = setup;
> +       master->transfer = transfer;
> +       drv_data->null_dma_buf = drv_data + sizeof(struct master_data);
> +       drv_data->null_dma_buf = (void *)(((u32)(drv_data->null_dma_buf)
> +                                        & 0xfffffff8) | 8 );
> +       drv_data->trans_cnt = 0;
> +       drv_data->dma_trans_cnt = 0;
> +       drv_data->int_trans_cnt = 0;
> +       drv_data->bigunalign_cnt = 0;
> +       drv_data->buserr_cnt = 0;
> +       drv_data->ror_cnt = 0;
> +
> +       /* Setup register addresses */
> +       memory_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!memory_resource) {
> +               dev_dbg(dev, "can not find platform io memory\n");
> +               status = -ENODEV;
> +               goto out_error_memory;
> +       }
> +
> +       drv_data->sscr0 = memory_resource->start + 0x00000000;
> +       drv_data->sscr1 = memory_resource->start + 0x00000004;
> +       drv_data->sssr = memory_resource->start + 0x00000008;
> +       drv_data->ssitr = memory_resource->start + 0x0000000c;
> +       drv_data->ssdr = memory_resource->start + 0x00000010;
> +       drv_data->ssto = memory_resource->start + 0x00000028;
> +       drv_data->sspsp = memory_resource->start + 0x0000002c;
> +
> +       /* Attach to IRQ */
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq == 0) {
> +               dev_dbg(dev, "problem getting IORESOURCE_IRQ[0]\n");
> +               status = -ENODEV;
> +               goto out_error_memory;
> +       }
> +
> +       status = request_irq(irq, ssp_int, SA_INTERRUPT, dev->bus_id, drv_data);
> +       if (status < 0) {
> +               dev_dbg(dev, "problem requesting IORESOURCE_IRQ %u\n", irq);
> +               goto out_error_memory;
> +       }
> +
> +       /* Setup DMA is requested */
> +       if (platform_info->enable_dma) {
> +
> +               tasklet_init(&drv_data->pump_transfers,
> +                               pump_dma_transfers,
> +                               (unsigned long)drv_data);
> +
> +               /* Get two DMA channels (rx and tx) */
> +               drv_data->rx_channel = pxa_request_dma("pxa2xx_spi_ssp_rx",
> +                                                               DMA_PRIO_HIGH,
> +                                                               dma_handler,
> +                                                               drv_data);
> +               if (drv_data->rx_channel < 0) {
> +                       dev_err(dev, "problem (%d) requesting rx channel\n",
> +                                       drv_data->rx_channel);
> +                       status = -ENODEV;
> +                       goto out_error_irq;
> +               }
> +               DRCMRRXSS2DR = DRCMR_MAPVLD
> +                               | (drv_data->rx_channel &  DRCMR_CHLNUM);
> +
> +               drv_data->tx_channel = pxa_request_dma("pxa2xx_spi_ssp_tx",
> +                                                               DMA_PRIO_MEDIUM,
> +                                                               dma_handler,
> +                                                               drv_data);
> +               if (drv_data->tx_channel < 0) {
> +                       dev_err(dev, "problem (%d) requesting tx channel\n",
> +                                       drv_data->tx_channel);
> +                       status = -ENODEV;
> +                       goto out_error_rx_dma;
> +               }
> +               DRCMRTXSS2DR = DRCMR_MAPVLD
> +                               | (drv_data->tx_channel &  DRCMR_CHLNUM);
> +       }
> +       else
> +               /* No DMA use interrupt transfers */
> +               tasklet_init(&drv_data->pump_transfers,
> +                               pump_int_transfers,
> +                               (unsigned long)drv_data);
> +
> +       /* Enable SOC clock */
> +       pxa_set_cken(platform_info->clock_enable, 1);
> +
> +       /* Load default SSP configuration */
> +       __REG(drv_data->sscr0) = 0;
> +       __REG(drv_data->sscr1) = SSCR1_RxTresh(4) | SSCR1_TxTresh(12);
> +       __REG(drv_data->sscr0) = SSCR0_SerClkDiv(2)
> +                                       | SSCR0_Motorola
> +                                       | SSCR0_DataSize(8);
> +       __REG(drv_data->ssto) = 0;
> +       __REG(drv_data->sspsp) = 0;
> +
> +       status = device_create_file(dev, &dev_attr_transfer_count);
> +       status += device_create_file(dev, &dev_attr_dma_transfer_count);
> +       status += device_create_file(dev, &dev_attr_interrupt_transfer_count);
> +       status += device_create_file(dev, &dev_attr_big_unaligned_count);
> +       status += device_create_file(dev, &dev_attr_bus_error_count);
> +       status += device_create_file(dev, &dev_attr_overrun_count);
> +       if (status != 0) {
> +               dev_err(dev, "problem creating attribute\n");
> +               status = -EIO;
> +               goto out_error_attr;
> +       }
> +
> +
> +       /* Register with the SPI framework */
> +       dev_set_drvdata(dev, master);
> +       status = spi_register_master(master);
> +       if (status != 0) {
> +               goto out_error_attr;
> +       }
> +
> +       return status;
> +
> +out_error_attr:
> +
> +       device_remove_file(dev, &dev_attr_transfer_count);
> +       device_remove_file(dev, &dev_attr_dma_transfer_count);
> +       device_remove_file(dev, &dev_attr_interrupt_transfer_count);
> +       device_remove_file(dev, &dev_attr_big_unaligned_count);
> +       device_remove_file(dev, &dev_attr_bus_error_count);
> +       device_remove_file(dev, &dev_attr_overrun_count);
> +
> +       pxa_free_dma(drv_data->tx_channel);
> +
> +out_error_rx_dma:
> +       pxa_free_dma(drv_data->rx_channel);
> +
> +out_error_irq:
> +       free_irq(irq, drv_data);
> +
> +out_error_memory:
> +
> +       return status;
> +}
> +
> +static int remove(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct master_data *drv_data = class_get_devdata(&master->cdev);
> +       struct pxa2xx_spi_master *platform_info;
> +
> +       int irq;
> +       unsigned long flags;
> +
> +       device_remove_file(dev, &dev_attr_transfer_count);
> +       device_remove_file(dev, &dev_attr_dma_transfer_count);
> +       device_remove_file(dev, &dev_attr_interrupt_transfer_count);
> +       device_remove_file(dev, &dev_attr_big_unaligned_count);
> +       device_remove_file(dev, &dev_attr_bus_error_count);
> +       device_remove_file(dev, &dev_attr_overrun_count);
> +
> +       platform_info = (struct pxa2xx_spi_master *)pdev->dev.platform_data;
> +
> +       spin_lock_irqsave(&drv_data->lock, flags);
> +
> +       __REG(drv_data->sscr0) = 0;
> +       pxa_set_cken(platform_info->clock_enable, 0);
> +
> +       DRCMRRXSS2DR = 0;
> +       DRCMRTXSS2DR = 0;
> +       pxa_free_dma(drv_data->tx_channel);
> +       pxa_free_dma(drv_data->rx_channel);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq != 0)
> +               free_irq(irq, drv_data);
> +
> +       spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +       spi_unregister_master(master);
> +
> +       return 0;
> +}
> +
> +static struct device_driver driver = {
> +       .name = "pxa2xx-spi-ssp",
> +       .bus = &platform_bus_type,
> +       .owner = THIS_MODULE,
> +       .probe = probe,
> +       .remove = remove,
> +};
> +
> +static int pxa2xx_spi_ssp_init(void)
> +{
> +       driver_register(&driver);
> +
> +       return 0;
> +}
> +module_init(pxa2xx_spi_ssp_init);
> +
> +static void pxa2xx_spi_ssp_exit(void)
> +{
> +       driver_unregister(&driver);
> +}
> +module_exit(pxa2xx_spi_ssp_exit);
> --- linux-2.6.12-spi/drivers/spi/pxa2xx_loopback.c      1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.12-spi-pxa/drivers/spi/pxa2xx_loopback.c  2005-10-25 15:58:06.325046000 -0700
> @@ -0,0 +1,403 @@
> +/*
> + * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/spi.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/miscdevice.h>
> +#include <linux/kfifo.h>
> +
> +#include <asm/semaphore.h>
> +#include <asm/atomic.h>
> +#include <asm/uaccess.h>
> +
> +MODULE_AUTHOR("Stephen Street");
> +MODULE_DESCRIPTION("PXA Loopback SPI Protocol Driver");
> +MODULE_LICENSE("GPL");
> +
> +#define BUF_SIZE (1024)
> +
> +struct device_data {
> +       char name[BUS_ID_SIZE];
> +       struct miscdevice misc_device;
> +       struct semaphore driver_lock;
> +       struct list_head device_entry;
> +       atomic_t busy;
> +       spinlock_t read_lock;
> +       spinlock_t write_lock;
> +       struct kfifo *read_fifo;
> +       struct kfifo *write_fifo;
> +       wait_queue_head_t read_available;
> +       wait_queue_head_t write_available;
> +       struct spi_message msg;
> +       struct spi_transfer transfer;
> +       void *dma_buf;
> +};
> +
> +static void post(void *context);
> +
> +static LIST_HEAD(device_list);
> +static DECLARE_MUTEX(device_list_lock);
> +
> +static inline struct device_data *find_dev_data(int minor)
> +{
> +       struct list_head *ptr;
> +       struct device_data *entry;
> +
> +       down(&device_list_lock);
> +
> +       list_for_each(ptr, &device_list) {
> +               entry = list_entry(ptr, struct device_data, device_entry);
> +               if (minor == entry->misc_device.minor) {
> +                       up(&device_list_lock);
> +                       return entry;
> +               }
> +       }
> +
> +       up(&device_list_lock);
> +       return NULL;
> +}
> +
> +static inline void add_device_data(struct device_data *dev_data)
> +{
> +       down(&device_list_lock);
> +
> +       list_add(&dev_data->device_entry, &device_list);
> +
> +       up(&device_list_lock);
> +}
> +
> +static inline void remove_device_data(struct device_data *dev_data)
> +{
> +       down(&device_list_lock);
> +
> +       list_del(&dev_data->device_entry);
> +
> +       up(&device_list_lock);
> +}
> +
> +static void kick(struct device_data *dev_data)
> +{
> +       unsigned int size;
> +       int status = 0;
> +
> +       /* Make sure we are not busy */
> +       if (!atomic_inc_and_test(&dev_data->busy)) {
> +               atomic_dec(&dev_data->busy);
> +               return;
> +       }
> +
> +       /* Check for available data */
> +       size = kfifo_len(dev_data->write_fifo);
> +       if (!size) {
> +               atomic_dec(&dev_data->busy);
> +               return;
> +       }
> +
> +       /* Read the data to send */
> +       if (kfifo_get(dev_data->write_fifo, dev_data->dma_buf, size) != size) {
> +               dev_err(dev_data->misc_device.dev, "write fifo failure\n");
> +               atomic_dec(&dev_data->busy);
> +               return;
> +       }
> +
> +       /* Send async spi message */
> +       memset(&dev_data->msg, 0, sizeof(struct spi_message));
> +       memset(&dev_data->transfer, 0, sizeof(struct spi_transfer));
> +       dev_data->transfer.tx_buf = dev_data->dma_buf;
> +       dev_data->transfer.rx_buf = dev_data->dma_buf;
> +       dev_data->transfer.len = size;
> +       dev_data->msg.transfers = &dev_data->transfer;
> +       dev_data->msg.n_transfer = 1;
> +       dev_data->msg.complete = post;
> +       dev_data->msg.context = dev_data;
> +       status = spi_async(to_spi_device(dev_data->misc_device.dev),
> +                               &dev_data->msg);
> +       if (status < 0) {
> +               dev_err(dev_data->misc_device.dev,
> +                               "spi failure (%d)\n",
> +                               status);
> +               atomic_dec(&dev_data->busy);
> +       }
> +
> +       wake_up_interruptible(&dev_data->write_available);
> +}
> +
> +static void post(void *context)
> +{
> +       struct device_data *dev_data = (struct device_data *)context;
> +       unsigned int space;
> +       unsigned length;
> +       unsigned char local_buf[BUF_SIZE];
> +
> +       /* Check spi status */
> +       if (dev_data->msg.status == 0) {
> +
> +               /* Make room for new data */
> +               length = dev_data->msg.actual_length;
> +               space = BUF_SIZE - kfifo_len(dev_data->read_fifo);
> +               if (space < length)
> +                       kfifo_get(dev_data->read_fifo,
> +                                       local_buf,
> +                                       length - space);
> +
> +               /* Add the new data */
> +               if (kfifo_put(dev_data->read_fifo, dev_data->dma_buf, length)
> +                               != length) {
> +                       dev_err(dev_data->misc_device.dev,
> +                                       "read fifo post failure\n");
> +               }
> +
> +               /* Let readers know */
> +               wake_up_interruptible(&dev_data->read_available);
> +       }
> +       else
> +               dev_err(dev_data->misc_device.dev,
> +                               "spi failure (%d)\n",
> +                               dev_data->msg.status);
> +
> +       atomic_dec(&dev_data->busy);
> +       kick(dev_data);
> +}
> +
> +static ssize_t read(struct file *filp,
> +                       char __user *buf,
> +                       size_t count,
> +                       loff_t *f_pos)
> +{
> +       struct device_data *dev_data = (struct device_data *)filp->private_data;
> +       char local_buf[BUF_SIZE];
> +       size_t read_size;
> +
> +       if (down_interruptible(&dev_data->driver_lock))
> +               return -ERESTARTSYS;
> +
> +       while (kfifo_len(dev_data->read_fifo) == 0) {
> +               up(&dev_data->driver_lock);
> +               if (filp->f_flags & O_NONBLOCK)
> +                       return -EAGAIN;
> +               if (wait_event_interruptible(dev_data->read_available,
> +                               (kfifo_len(dev_data->read_fifo) != 0)))
> +                       return -ERESTARTSYS;
> +               if (down_interruptible(&dev_data->driver_lock))
> +                       return -ERESTARTSYS;
> +       }
> +
> +       read_size = min(count, (size_t)BUF_SIZE);
> +       read_size = min(read_size, kfifo_len(dev_data->read_fifo));
> +
> +       if (kfifo_get(dev_data->read_fifo, local_buf, read_size) != read_size) {
> +               dev_err(dev_data->misc_device.dev, "read fifo failure");
> +               up(&dev_data->driver_lock);
> +               return -EIO;
> +       }
> +
> +       if (copy_to_user(buf, local_buf, read_size)) {
> +               dev_err(dev_data->misc_device.dev, "user space failure");
> +               up(&dev_data->driver_lock);
> +               return -EFAULT;
> +       }
> +
> +       up(&dev_data->driver_lock);
> +
> +       return read_size;
> +}
> +
> +static ssize_t write(struct file *filp,
> +                       const char __user *buf,
> +                       size_t count,
> +                       loff_t *f_pos)
> +{
> +       struct device_data *dev_data = (struct device_data *)filp->private_data;
> +       char local_buf[BUF_SIZE];
> +       size_t write_size;
> +
> +       if (down_interruptible(&dev_data->driver_lock))
> +               return -ERESTARTSYS;
> +
> +       while (kfifo_len(dev_data->write_fifo) == BUF_SIZE) {
> +               up(&dev_data->driver_lock);
> +               if (filp->f_flags & O_NONBLOCK)
> +                       return -EAGAIN;
> +               if (wait_event_interruptible(dev_data->read_available,
> +                               (kfifo_len(dev_data->write_fifo) < BUF_SIZE)))
> +                       return -ERESTARTSYS;
> +               if (down_interruptible(&dev_data->driver_lock))
> +                       return -ERESTARTSYS;
> +       }
> +
> +       write_size = min(count, (size_t)BUF_SIZE);
> +       write_size = min(write_size,
> +                               BUF_SIZE - kfifo_len(dev_data->write_fifo));
> +
> +       if (copy_from_user(local_buf, buf, write_size)) {
> +               dev_err(dev_data->misc_device.dev, "user space failure");
> +               up(&dev_data->driver_lock);
> +               return -EFAULT;
> +       }
> +
> +       if (kfifo_put(dev_data->write_fifo, local_buf, write_size)
> +                       != write_size) {
> +               dev_err(dev_data->misc_device.dev, "write fifo failure");
> +               up(&dev_data->driver_lock);
> +               return -EIO;
> +       }
> +
> +       kick(dev_data);
> +
> +       up(&dev_data->driver_lock);
> +
> +       return write_size;
> +}
> +
> +static int open(struct inode *inode, struct file *filp)
> +{
> +       struct device_data *dev_data;
> +
> +       dev_data = find_dev_data(iminor(inode));
> +       if (dev_data == NULL) {
> +               printk(KERN_ERR "no device data for minor %d\n",
> +                               iminor(inode));
> +               return ENODEV;
> +       }
> +       filp->private_data = dev_data;
> +
> +       return 0;
> +}
> +
> +static struct file_operations loopback_fops = {
> +       .owner = THIS_MODULE,
> +       .llseek = no_llseek,
> +       .write = write,
> +       .read = read,
> +       .open = open,
> +};
> +
> +static int probe(struct device *dev)
> +{
> +       struct device_data *dev_data;
> +       struct spi_device *sdev;
> +       int status;
> +
> +       /* Allocate driver data */
> +       dev_data = kcalloc(1, sizeof(struct device_data) + BUF_SIZE + 16,
> +                               GFP_KERNEL);
> +       if (!dev_data) {
> +               dev_err(dev, "problem allocating driver memory\n");
> +               status = -ENOMEM;
> +               goto out_error;
> +       }
> +
> +       /* Allocated input/output fifos */
> +       dev_data->read_fifo = kfifo_alloc(BUF_SIZE,
> +                                       GFP_KERNEL,
> +                                       &dev_data->read_lock);
> +       if (IS_ERR(dev_data->read_fifo)) {
> +               status = -ENOMEM;
> +               goto out_memalloc;
> +       }
> +
> +       dev_data->write_fifo = kfifo_alloc(BUF_SIZE,
> +                                       GFP_KERNEL,
> +                                       &dev_data->write_lock);
> +       if (IS_ERR(dev_data->write_fifo)) {
> +               status = -ENOMEM;
> +               goto out_readalloc;
> +       }
> +
> +       /* Initialize the driver data */
> +       init_MUTEX(&dev_data->driver_lock);
> +       spin_lock_init(&dev_data->read_lock);
> +       spin_lock_init(&dev_data->write_lock);
> +       atomic_set(&dev_data->busy, -1);
> +       init_waitqueue_head(&dev_data->read_available);
> +       init_waitqueue_head(&dev_data->write_available);
> +       dev_data->dma_buf = dev_data + sizeof(struct device_data);
> +       dev_data->dma_buf = (void *)(((u32)(dev_data->dma_buf)&0xfffffff8)|8);
> +       INIT_LIST_HEAD(&dev_data->device_entry);
> +       dev_set_drvdata(dev, dev_data);
> +
> +       /* Build misc device name from bus number and chip select */
> +       sdev = to_spi_device(dev);
> +       snprintf(dev_data->name, BUS_ID_SIZE, "slp%u%u",
> +                       sdev->master->bus_num,
> +                       sdev->chip_select);
> +
> +       /* Register as a misc device with dynamic minor number */
> +       dev_data->misc_device.name = dev_data->name;
> +       dev_data->misc_device.dev = dev;
> +       dev_data->misc_device.fops = &loopback_fops;
> +       dev_data->misc_device.minor = MISC_DYNAMIC_MINOR;
> +       status = misc_register(&dev_data->misc_device);
> +       if (status != 0) {
> +               dev_err(dev, "problem (%d) registering misc device\n", status);
> +               goto out_writealloc;
> +       }
> +
> +       /* Add device data to internal device list */
> +       add_device_data(dev_data);
> +
> +       return 0;
> +
> +out_writealloc:
> +       kfifo_free(dev_data->write_fifo);
> +
> +out_readalloc:
> +       kfifo_free(dev_data->read_fifo);
> +
> +out_memalloc:
> +       kfree(dev_data);
> +
> +out_error:
> +       return status;
> +}
> +
> +static int remove(struct device *dev)
> +{
> +       struct device_data *dev_data = dev_get_drvdata(dev);
> +
> +       misc_deregister(&dev_data->misc_device);
> +       remove_device_data(dev_data);
> +       kfree(dev_data);
> +
> +       return 0;
> +}
> +
> +struct device_driver loopback_spi = {
> +       .name = "loopback",
> +       .bus = &spi_bus_type,
> +       .owner = THIS_MODULE,
> +       .probe = probe,
> +       .remove = remove,
> +};
> +
> +static int __init loopback_init(void)
> +{
> +       return driver_register(&loopback_spi);
> +}
> +module_init(loopback_init);
> +
> +static void __exit loopback_exit(void)
> +{
> +       driver_unregister(&loopback_spi);
> +}
> +module_exit(loopback_exit);
> --- linux-2.6.12-spi/include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h  1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.12-spi-pxa/include/asm-arm/arch-pxa/pxa2xx_spi_ssp.h      2005-10-25 15:58:06.000000000 -0700
> @@ -0,0 +1,42 @@
> +/* Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef PXA2XX_SPI_SSP_H_
> +#define PXA2XX_SPI_SSP_H_
> +
> +#define PXA2XX_CS_ASSERT (0x01)
> +#define PXA2XX_CS_DEASSERT (0x02)
> +
> +struct pxa2xx_spi_master {
> +       u16 bus_num;
> +       u32 clock_enable;
> +       u16 num_chipselect;
> +       u8 enable_dma;
> +};
> +
> +struct pxa2xx_spi_chip {
> +       u8 mode;
> +       u8 tx_threshold;
> +       u8 rx_threshold;
> +       u8 bits_per_word;
> +       u8 dma_burst_size;
> +       u32 timeout_microsecs;
> +       u8 enable_loopback;
> +       void (*cs_control)(u32 command);
> +};
> +
> +#endif /*PXA2XX_SPI_SSP_H_*/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
-----------------------------------------------
Mike Lee
