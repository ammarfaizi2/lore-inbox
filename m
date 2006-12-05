Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967527AbWLEF6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967527AbWLEF6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967567AbWLEF6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:58:42 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:42739 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967527AbWLEF6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:58:40 -0500
Message-ID: <45750A89.7000802@garzik.org>
Date: Tue, 05 Dec 2006 00:58:33 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052245.7213.39098.stgit@dinky.boston.redhat.com>
In-Reply-To: <20061205052245.7213.39098.stgit@dinky.boston.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Add the OHCI driver to the stack and build system.
> 
> Signed-off-by: Kristian Høgsberg <krh@redhat.com>
> ---
> 
>  drivers/fw/fw-ohci.c | 1334 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fw/fw-ohci.h |  152 ++++++
>  2 files changed, 1486 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/fw/fw-ohci.c b/drivers/fw/fw-ohci.c
> new file mode 100644
> index 0000000..78e0324
> --- /dev/null
> +++ b/drivers/fw/fw-ohci.c
> @@ -0,0 +1,1334 @@
> +/*						-*- c-basic-offset: 8 -*-
> + *
> + * fw-ohci.c - Driver for OHCI 1394 boards
> + * Copyright (C) 2003 Kristian Høgsberg <krh@bitplanet.net>
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
> + * along with this program; if not, write to the Free Software Foundation,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/poll.h>
> +#include <asm/uaccess.h>
> +#include <asm/semaphore.h>
> +
> +#include "fw-transaction.h"
> +#include "fw-ohci.h"
> +
> +struct descriptor {
> +	u32 req_count:16;
> +
> +	u32 wait:2;
> +	u32 branch:2;
> +	u32 irq:2;
> +	u32 yy:1;
> +	u32 ping:1;
> +
> +	u32 key:3;
> +	u32 status:1;
> +	u32 command:4;
> +
> +	u32 data_address;
> +	u32 branch_address;
> +
> +	u32 res_count:16;
> +	u32 transfer_status:16;
> +} __attribute__ ((aligned(16)));

you probably want __le32 annotations for sparse, right?


> +#define DESCRIPTOR_OUTPUT_MORE		0
> +#define DESCRIPTOR_OUTPUT_LAST		1
> +#define DESCRIPTOR_INPUT_MORE		2
> +#define DESCRIPTOR_INPUT_LAST		3
> +#define DESCRIPTOR_NO_IRQ		0
> +#define DESCRIPTOR_IRQ_ERROR		1
> +#define DESCRIPTOR_IRQ_ALWAYS		3
> +#define DESCRIPTOR_KEY_IMMEDIATE	2
> +#define DESCRIPTOR_BRANCH_ALWAYS	3
> +
> +struct ar_context {
> +	struct fw_ohci *ohci;
> +	struct descriptor descriptor;
> +	u32 buffer[512];
> +	dma_addr_t descriptor_bus;
> +	dma_addr_t buffer_bus;
> +
> +	u32 command_ptr;
> +	u32 control_set;
> +	u32 control_clear;
> +
> +	struct tasklet_struct tasklet;
> +};
> +
> +struct at_context {
> +	struct fw_ohci *ohci;
> +	dma_addr_t descriptor_bus;
> +	dma_addr_t buffer_bus;
> +
> +	struct list_head list;
> +
> +	struct {
> +		struct descriptor more;
> +		u32 header[4];
> +		struct descriptor last;
> +	} descriptor;
> +
> +	u32 command_ptr;
> +	u32 control_set;
> +	u32 control_clear;
> +
> +	struct tasklet_struct tasklet;
> +};
> +
> +struct it_header {
> +	u32 sy:4;
> +	u32 tcode:4;
> +	u32 channel:6;
> +	u32 tag:2;
> +	u32 speed:3;
> +	u32 reserved0:13;
> +	u32 reserved1:16;
> +	u32 data_length:16;
> +};

ditto.

And for the last two fields, I bet that using the normal 'u16' type 
(__le16?) would generate much better code than a bitfield:16 ever would.


> +struct iso_context {
> +	struct fw_iso_context base;
> +	struct tasklet_struct tasklet;
> +	u32 control_set;
> +	u32 control_clear;
> +	u32 command_ptr;
> +	u32 context_match;
> +
> +	struct descriptor *buffer;
> +	dma_addr_t buffer_bus;
> +	struct descriptor *head_descriptor;
> +	struct descriptor *tail_descriptor;
> +	struct descriptor *tail_descriptor_last;
> +	struct descriptor *prev_descriptor;
> +};
> +
> +#define CONFIG_ROM_SIZE 1024
> +
> +struct fw_ohci {
> +	struct fw_card card;
> +
> +	struct pci_dev *dev;

struct device* instead?  grep for to_pci_dev() to see how to get pci-dev 
from device.


> +	char *registers;

should be 'void __iomem *'

See Documentation/sparse.txt for more info on checking your code with 
sparse.


> +	dma_addr_t self_id_bus;
> +	u32 *self_id_cpu;
> +	struct tasklet_struct bus_reset_tasklet;
> +	int generation;
> +	int request_generation;
> +
> +	spinlock_t lock;
> +	u32 self_id_buffer[512];
> +
> +	/* Config rom buffers */
> +	u32 *config_rom;
> +	dma_addr_t config_rom_bus;
> +	u32 *next_config_rom;
> +	dma_addr_t next_config_rom_bus;
> +
> +	struct ar_context ar_request_ctx;
> +	struct ar_context ar_response_ctx;
> +	struct at_context at_request_ctx;
> +	struct at_context at_response_ctx;
> +
> +	u32 it_context_mask;
> +	struct iso_context *it_context_list;
> +	u32 ir_context_mask;
> +	struct iso_context *ir_context_list;
> +};
> +
> +extern inline struct fw_ohci *fw_ohci(struct fw_card *card)
> +{
> +	return container_of(card, struct fw_ohci, card);
> +}
> +
> +#define CONTEXT_CYCLE_MATCH_ENABLE	0x80000000
> +
> +#define CONTEXT_RUN	0x8000
> +#define CONTEXT_WAKE	0x1000
> +#define CONTEXT_DEAD	0x0800
> +#define CONTEXT_ACTIVE	0x0400
> +
> +#define OHCI1394_MAX_AT_REQ_RETRIES	0x2
> +#define OHCI1394_MAX_AT_RESP_RETRIES	0x2
> +#define OHCI1394_MAX_PHYS_RESP_RETRIES	0x8
> +
> +#define FW_OHCI_MAJOR			240
> +#define OHCI1394_REGISTER_SIZE		0x800
> +#define OHCI_LOOP_COUNT			500
> +#define OHCI1394_PCI_HCI_Control	0x40
> +#define SELF_ID_BUF_SIZE		0x800

consider using

	enum {
		constant1	= 1234,
		constant2	= 5678,
	};

for constants.  These actually have some type information attached by 
the compiler, and they show up as symbols in the debugger since they are 
not stripped out by the C pre-processor.


> +#define PCI_CLASS_FIREWIRE_OHCI ((PCI_CLASS_SERIAL_FIREWIRE << 8) | 0x10)
> +
> +static char ohci_driver_name[] = KBUILD_MODNAME;
> +
> +extern inline void reg_write(const struct fw_ohci *ohci, int offset, u32 data)
> +{
> +	writel(data, ohci->registers + offset);
> +}
> +
> +extern inline u32 reg_read(const struct fw_ohci *ohci, int offset)
> +{
> +	return readl(ohci->registers + offset);
> +}
> +
> +static int read_phy_reg(struct fw_ohci *ohci, u8 addr)
> +{
> +	u32 val;
> +
> +	reg_write(ohci, OHCI1394_PhyControl, OHCI1394_PhyControl_Read(addr));
> +	msleep(2);
> +	val = reg_read(ohci, OHCI1394_PhyControl);
> +	if ((val & OHCI1394_PhyControl_ReadDone) == 0)
> +		return -EBUSY;
> +
> +	return OHCI1394_PhyControl_ReadData(val);
> +}
> +
> +static void write_phy_reg(struct fw_ohci *ohci, u8 addr, u8 data)
> +{
> +	reg_write(ohci, OHCI1394_PhyControl,
> +		  OHCI1394_PhyControl_Write(addr, data));
> +}
> +
> +static int
> +ohci_update_phy_reg(struct fw_card *card, int addr,
> +		    int clear_bits, int set_bits)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	int old;
> +
> +	old = read_phy_reg(ohci, addr);
> +	if (old < 0) {
> +		fw_error("failed to set phy reg bits.\n");
> +		return old;
> +	}
> +	old = (old & ~clear_bits) | set_bits;
> +	write_phy_reg(ohci, addr, old);
> +
> +	return 0;
> +}
> +
> +static void ar_context_run(struct ar_context *ctx)
> +{
> +	reg_write(ctx->ohci, ctx->command_ptr, ctx->descriptor_bus | 1);
> +	reg_write(ctx->ohci, ctx->control_set, CONTEXT_RUN);

PCI posting?


> +static void ar_context_tasklet(unsigned long data)
> +{
> +	struct ar_context *ctx = (struct ar_context *)data;
> +	struct fw_ohci *ohci = ctx->ohci;
> +	u32 status;
> +	int length, speed, ack, timestamp;
> +
> +	/* FIXME: What to do about evt_* errors? */
> +	length    = ctx->descriptor.req_count - ctx->descriptor.res_count - 4;
> +	status    = ctx->buffer[length / 4];
> +	ack       = ((status >> 16) & 0x1f) - 16;
> +	speed     = (status >> 21) & 0x7;
> +	timestamp = status & 0xffff;
> +
> +	/* The OHCI bus reset handler synthesizes a phy packet with
> +	 * the new generation number when a bus reset happens (see
> +	 * section 8.4.2.3).  This helps us determine when a request
> +	 * was received and make sure we send the response in the same
> +	 * generation.  We only need this for requests; for responses
> +	 * we use the unique tlabel for finding the matching
> +	 * request. */
> +	if (ack + 16 == 0x09)
> +		ohci->request_generation = (ctx->buffer[2] >> 16) & 0xff;
> +	else if (ctx == &ohci->ar_request_ctx)
> +		fw_core_handle_request(&ohci->card, speed, ack, timestamp,
> +				       ohci->request_generation,
> +				       length, ctx->buffer);
> +	else
> +		fw_core_handle_response(&ohci->card, speed, ack, timestamp,
> +					length, ctx->buffer);
> +
> +	ctx->descriptor.data_address = ctx->buffer_bus;
> +	ctx->descriptor.req_count = sizeof ctx->buffer;
> +	ctx->descriptor.res_count = ctx->descriptor.req_count;
> +
> +	dma_sync_single_for_device(&ohci->dev->dev, ctx->descriptor_bus,
> +				   sizeof ctx->descriptor_bus, DMA_TO_DEVICE);
> +
> +	/* FIXME: We stop and restart the ar context here, what if we
> +	 * stop while a receive is in progress? Maybe we could just
> +	 * loop the context back to itself and use it in buffer fill
> +	 * mode as intended... */
> +
> +	reg_write(ctx->ohci, ctx->control_clear, CONTEXT_RUN);
> +	ar_context_run(ctx);
> +}
> +
> +static int
> +ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci, u32 control_set)
> +{
> +	/* FIXME: cpu_to_le32. */
> +
> +	ctx->descriptor_bus =
> +		dma_map_single(&ohci->dev->dev, &ctx->descriptor,
> +			       sizeof ctx->descriptor, PCI_DMA_TODEVICE);
> +	if (ctx->descriptor_bus == 0)
> +		return -ENOMEM;
> +
> +	if (ctx->descriptor_bus & 0xf)
> +		fw_notify("descriptor not 16-byte aligned: 0x%08x\n",
> +			  ctx->descriptor_bus);
> +
> +	ctx->buffer_bus =
> +		dma_map_single(&ohci->dev->dev, ctx->buffer,
> +			       sizeof ctx->buffer, PCI_DMA_FROMDEVICE);
> +
> +	if (ctx->buffer_bus == 0)
> +		return -ENOMEM;

leak on error


> +	memset(&ctx->descriptor, 0, sizeof ctx->descriptor);
> +	ctx->descriptor.command      = DESCRIPTOR_INPUT_MORE;
> +	ctx->descriptor.status       = 1;
> +	ctx->descriptor.irq          = DESCRIPTOR_NO_IRQ;
> +	ctx->descriptor.branch       = DESCRIPTOR_BRANCH_ALWAYS;
> +	ctx->descriptor.req_count    = sizeof ctx->buffer;
> +	ctx->descriptor.data_address = ctx->buffer_bus;
> +	ctx->descriptor.res_count    = ctx->descriptor.req_count;
> +
> +	ctx->control_set   = control_set;
> +	ctx->control_clear = control_set + 4;
> +	ctx->command_ptr   = control_set + 12;
> +	ctx->ohci          = ohci;
> +
> +	tasklet_init(&ctx->tasklet, ar_context_tasklet, (unsigned long)ctx);
> +
> +	ar_context_run(ctx);
> +
> +	return 0;
> +}
> +
> +		ohci->next_config_rom = NULL;
> +	}
> +
> +	spin_unlock_irqrestore(&ohci->lock, flags);
> +
> +	fw_core_handle_bus_reset(&ohci->card, node_id, generation,
> +				 self_id_count, ohci->self_id_buffer);
> +}
> +
> +static irqreturn_t irq_handler(int irq, void *data, struct pt_regs *unused)
> +{
> +	struct fw_ohci *ohci = data;
> +	u32 event, iso_event;
> +	int i;
> +
> +	event = reg_read(ohci, OHCI1394_IntEventClear);
> +
> +	if (!event)
> +		return IRQ_NONE;

check for 0xffffffff also


> +	reg_write(ohci, OHCI1394_IntEventClear, event);
> +
> +	if (event & OHCI1394_selfIDComplete)
> +		tasklet_schedule(&ohci->bus_reset_tasklet);
> +
> +	if (event & OHCI1394_RQPkt)
> +		tasklet_schedule(&ohci->ar_request_ctx.tasklet);
> +
> +	if (event & OHCI1394_RSPkt)
> +		tasklet_schedule(&ohci->ar_response_ctx.tasklet);
> +
> +	if (event & OHCI1394_reqTxComplete)
> +		tasklet_schedule(&ohci->at_request_ctx.tasklet);
> +
> +	if (event & OHCI1394_respTxComplete)
> +		tasklet_schedule(&ohci->at_response_ctx.tasklet);
> +
> +	iso_event = reg_read(ohci, OHCI1394_IsoRecvIntEventSet);
> +	reg_write(ohci, OHCI1394_IsoRecvIntEventClear, iso_event);
> +
> +	while (iso_event) {
> +		i = ffs(iso_event) - 1;
> +		tasklet_schedule(&ohci->ir_context_list[i].tasklet);
> +		iso_event &= ~(1 << i);
> +	}
> +
> +	iso_event = reg_read(ohci, OHCI1394_IsoXmitIntEventSet);
> +	reg_write(ohci, OHCI1394_IsoXmitIntEventClear, iso_event);
> +
> +	while (iso_event) {
> +		i = ffs(iso_event) - 1;
> +		tasklet_schedule(&ohci->it_context_list[i].tasklet);
> +		iso_event &= ~(1 << i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ohci_enable(struct fw_card *card, u32 * config_rom, size_t length)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +
> +	/* When the link is not yet enabled, the atomic config rom
> +	 * described above is not active.  We have to update
> +	 * ConfigRomHeader and BusOptions manually, and the write to
> +	 * ConfigROMmap takes effect immediately.  We tie this to the
> +	 * enabling of the link, so we ensure that we have a valid
> +	 * config rom before enabling - the OHCI requires that
> +	 * ConfigROMhdr and BusOptions have valid values before
> +	 * enabling.
> +	 */
> +
> +	ohci->config_rom = pci_alloc_consistent(ohci->dev, CONFIG_ROM_SIZE,
> +						&ohci->config_rom_bus);
> +	if (ohci->config_rom == NULL)
> +		return -ENOMEM;
> +
> +	memset(ohci->config_rom, 0, CONFIG_ROM_SIZE);
> +	fw_memcpy_to_be32(ohci->config_rom, config_rom, length * 4);
> +
> +	reg_write(ohci, OHCI1394_ConfigROMmap, ohci->config_rom_bus);
> +	reg_write(ohci, OHCI1394_ConfigROMhdr, config_rom[0]);
> +	reg_write(ohci, OHCI1394_BusOptions, config_rom[2]);
> +
> +	reg_write(ohci, OHCI1394_AsReqFilterHiSet, 0x80000000);
> +
> +	if (request_irq(ohci->dev->irq, irq_handler,
> +			SA_SHIRQ, ohci_driver_name, ohci)) {
> +		fw_error("Failed to allocate shared interrupt %d.\n",
> +			 ohci->dev->irq);
> +		return -EIO;

leak on error


> +	reg_write(ohci, OHCI1394_HCControlSet,
> +		  OHCI1394_HCControl_linkEnable |
> +		  OHCI1394_HCControl_BIBimageValid);

PCI posting


> +	/* We are ready to go, initiate bus reset to finish the
> +	 * initialization. */
> +
> +	fw_core_initiate_bus_reset(&ohci->card, 1);
> +
> +	return 0;
> +}
> +
> +static int
> +ohci_set_config_rom(struct fw_card *card, u32 * config_rom, size_t length)
> +{
> +	struct fw_ohci *ohci;
> +	unsigned long flags;
> +	int retval = 0;
> +
> +	ohci = fw_ohci(card);
> +
> +	/* When the OHCI controller is enabled, the config rom update
> +	 * mechanism is a bit tricky, but easy enough to use.  See
> +	 * section 5.5.6 in the OHCI specification.
> +	 *
> +	 * The OHCI controller caches the new config rom address in a
> +	 * shadow register (ConfigROMmapNext) and needs a bus reset
> +	 * for the changes to take place.  When the bus reset is
> +	 * detected, the controller loads the new values for the
> +	 * ConfigRomHeader and BusOptions registers from the specified
> +	 * config rom and loads ConfigROMmap from the ConfigROMmapNext
> +	 * shadow register. All automatically and atomically.
> +	 *
> +	 * We use ohci->lock to avoid racing with the code that sets
> +	 * ohci->next_config_rom to NULL (see bus_reset_tasklet).
> +	 */
> +
> +	spin_lock_irqsave(&ohci->lock, flags);
> +
> +	if (ohci->next_config_rom == NULL) {
> +		ohci->next_config_rom =
> +			pci_alloc_consistent(ohci->dev, CONFIG_ROM_SIZE,
> +					     &ohci->next_config_rom_bus);
> +
> +		memset(ohci->next_config_rom, 0, CONFIG_ROM_SIZE);

next_config_rom could be NULL.  you have got to check allocations inside 
spinlocks (GFP_ATOMIC), they are more likely to fail than GFP_KERNEL.


> +		fw_memcpy_to_be32(ohci->next_config_rom, config_rom,
> +				  length * 4);
> +		reg_write(ohci, OHCI1394_ConfigROMmap,
> +			  ohci->next_config_rom_bus);
> +
> +		/* Now initiate a bus reset to have the changes take
> +		 * effect. We clean up the old config rom memory and
> +		 * DMA mappings in the bus reset tasklet, since the
> +		 * OHCI controller could need to access it before the
> +		 * bus reset takes effect.
> +		 */
> +
> +		fw_core_initiate_bus_reset(&ohci->card, 1);
> +	} else
> +		retval = -EBUSY;
> +
> +	spin_unlock_irqrestore(&ohci->lock, flags);
> +
> +	return retval;
> +}
> +
> +static void ohci_send_request(struct fw_card *card, struct fw_packet *packet)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +
> +	at_context_transmit(&ohci->at_request_ctx, packet);
> +}
> +
> +static void ohci_send_response(struct fw_card *card, struct fw_packet *packet)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +
> +	at_context_transmit(&ohci->at_response_ctx, packet);
> +}
> +
> +static int
> +ohci_enable_phys_dma(struct fw_card *card, int node_id, int generation)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	unsigned long flags;
> +	int retval = 0;
> +
> +	/* FIXME: make sure this bitmask is cleared when we clear the
> +	 * busReset interrupt bit. */
> +
> +	spin_lock_irqsave(&ohci->lock, flags);
> +
> +	if (ohci->generation != generation) {
> +		retval = -ESTALE;
> +		goto out;
> +	}
> +
> +	if (node_id < 32) {
> +		reg_write(ohci, OHCI1394_PhyReqFilterLoSet, 1 << node_id);
> +	} else {
> +		reg_write(ohci, OHCI1394_PhyReqFilterHiSet,
> +			  1 << (node_id - 32));
> +	}

PCI posting


> +	spin_unlock_irqrestore(&ohci->lock, flags);
> +
> + out:
> +	return retval;
> +}
> +
> +static void ir_context_tasklet(unsigned long data)
> +{
> +	struct iso_context *ctx = (struct iso_context *)data;
> +
> +	(void)ctx;
> +}
> +
> +#define ISO_BUFFER_SIZE (64 * 1024)
> +
> +static void flush_iso_context(struct iso_context *ctx)
> +{
> +	struct fw_ohci *ohci = fw_ohci(ctx->base.card);
> +	struct descriptor *d, *last;
> +	int z;
> +
> +	dma_sync_single_for_cpu(ohci->card.device, ctx->buffer_bus,
> +				ISO_BUFFER_SIZE, DMA_TO_DEVICE);
> +
> +	d    = ctx->tail_descriptor;
> +	last = ctx->tail_descriptor_last;
> +
> +	while (last->branch_address != 0 && last->transfer_status != 0) {
> +		z = last->branch_address & 0xf;
> +		d = ctx->buffer + (last->branch_address -
> +				   ctx->buffer_bus) / sizeof *d;
> +
> +		if (z == 2)
> +			last = d;
> +		else
> +			last = d + z - 1;
> +
> +		if (last->irq)
> +			ctx->base.callback(&ctx->base,
> +					   0, last->res_count,
> +					   ctx->base.callback_data);
> +	}
> +
> +	ctx->tail_descriptor      = d;
> +	ctx->tail_descriptor_last = last;
> +}
> +
> +static void it_context_tasklet(unsigned long data)
> +{
> +	struct iso_context *ctx = (struct iso_context *)data;
> +
> +	flush_iso_context(ctx);
> +}
> +
> +static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
> +							int type)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	struct iso_context *ctx, *list;
> +	void (*tasklet) (unsigned long data);
> +	u32 *mask;
> +	unsigned long flags;
> +	int index;
> +
> +	if (type == FW_ISO_CONTEXT_TRANSMIT) {
> +		mask = &ohci->it_context_mask;
> +		list = ohci->it_context_list;
> +		tasklet = it_context_tasklet;
> +	} else {
> +		mask = &ohci->ir_context_mask;
> +		list = ohci->ir_context_list;
> +		tasklet = ir_context_tasklet;
> +	}
> +
> +	spin_lock_irqsave(&ohci->lock, flags);
> +	index = ffs(*mask) - 1;
> +	if (index >= 0)
> +		*mask &= ~(1 << index);
> +	spin_unlock_irqrestore(&ohci->lock, flags);
> +
> +	if (index < 0)
> +		return ERR_PTR(-EBUSY);
> +
> +	ctx = &list[index];
> +	memset(ctx, 0, sizeof *ctx);
> +	tasklet_init(&ctx->tasklet, tasklet, (unsigned long)ctx);
> +
> +	ctx->buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);
> +	if (ctx->buffer == NULL) {
> +		spin_lock_irqsave(&ohci->lock, flags);
> +		*mask |= 1 << index;
> +		spin_unlock_irqrestore(&ohci->lock, flags);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ctx->buffer_bus =
> +	    dma_map_single(card->device, ctx->buffer,
> +			   ISO_BUFFER_SIZE, PCI_DMA_TODEVICE);
> +
> +	ctx->head_descriptor      = ctx->buffer;
> +	ctx->prev_descriptor      = ctx->buffer;
> +	ctx->tail_descriptor      = ctx->buffer;
> +	ctx->tail_descriptor_last = ctx->buffer;
> +
> +	/* We put a dummy descriptor in the buffer that has a NULL
> +	 * branch address and looks like it's been sent.  That way we
> +	 * have a descriptor to append DMA programs to.  Also, the
> +	 * ring buffer invariant is that it always has at least one
> +	 * element so that head == tail means buffer full. */
> +
> +	memset(ctx->head_descriptor, 0, sizeof *ctx->head_descriptor);
> +	ctx->head_descriptor->command         = DESCRIPTOR_OUTPUT_LAST;
> +	ctx->head_descriptor->transfer_status = 0x8011;
> +	ctx->head_descriptor++;
> +
> +	return &ctx->base;
> +}
> +
> +static int ohci_send_iso(struct fw_iso_context *base, s32 cycle)
> +{
> +	struct iso_context *ctx = (struct iso_context *)base;
> +	struct fw_ohci *ohci = fw_ohci(ctx->base.card);
> +	u32 cycle_match = 0;
> +	int index;
> +
> +	index = ctx - ohci->it_context_list;
> +	if (cycle > 0)
> +		cycle_match = CONTEXT_CYCLE_MATCH_ENABLE |
> +			(cycle & 0x7fff) << 16;
> +
> +	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, 1 << index);
> +	reg_write(ohci, OHCI1394_IsoXmitCommandPtr(index),
> +		  ctx->tail_descriptor_last->branch_address);
> +	reg_write(ohci, OHCI1394_IsoXmitContextControlClear(index), ~0);
> +	reg_write(ohci, OHCI1394_IsoXmitContextControlSet(index),
> +		  CONTEXT_RUN | cycle_match);

PCI posting?


> +static void ohci_free_iso_context(struct fw_iso_context *base)
> +{
> +	struct fw_ohci *ohci = fw_ohci(base->card);
> +	struct iso_context *ctx = (struct iso_context *)base;
> +	unsigned long flags;
> +	int index;
> +
> +	flush_iso_context(ctx);
> +
> +	spin_lock_irqsave(&ohci->lock, flags);
> +
> +	if (ctx->base.type == FW_ISO_CONTEXT_TRANSMIT) {
> +		index = ctx - ohci->it_context_list;
> +		reg_write(ohci, OHCI1394_IsoXmitContextControlClear(index), ~0);
> +		reg_write(ohci, OHCI1394_IsoXmitIntMaskClear, 1 << index);
> +		ohci->it_context_mask |= 1 << index;
> +	} else {
> +		index = ctx - ohci->ir_context_list;
> +		reg_write(ohci, OHCI1394_IsoRcvContextControlClear(index), ~0);
> +		reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, 1 << index);
> +		ohci->ir_context_mask |= 1 << index;
> +	}
> +
> +	dma_unmap_single(ohci->card.device, ctx->buffer_bus,
> +			 ISO_BUFFER_SIZE, DMA_TO_DEVICE);

PCI posting?


> +	spin_unlock_irqrestore(&ohci->lock, flags);
> +}
> +
> +static int
> +ohci_queue_iso(struct fw_iso_context *base,
> +	       struct fw_iso_packet *packet, void *payload)
> +{
> +	struct iso_context *ctx = (struct iso_context *)base;
> +	struct fw_ohci *ohci = fw_ohci(ctx->base.card);
> +	struct descriptor *d, *end, *last, *tail, *pd;
> +	struct fw_iso_packet *p;
> +	struct it_header *header;
> +	dma_addr_t d_bus;
> +	u32 z, header_z, payload_z;
> +	u32 payload_index, payload_end_index, next_page_index;
> +	int index, page, end_page, i, length, offset;
> +
> +	/* FIXME: Cycle lost behavior should be configurable: lose
> +	 * packet, retransmit or terminate.. */
> +
> +	p = packet;
> +	payload_index = payload - ctx->base.buffer;
> +	d = ctx->head_descriptor;
> +	tail = ctx->tail_descriptor;
> +	end = ctx->buffer + ISO_BUFFER_SIZE / sizeof(struct descriptor);
> +
> +	if (p->skip)
> +		z = 1;
> +	else
> +		z = 2;
> +	if (p->header_length > 0)
> +		z++;
> +
> +	/* Determine the first page the payload isn't contained in. */
> +	end_page = PAGE_ALIGN(payload_index + p->payload_length) >> PAGE_SHIFT;
> +	if (p->payload_length > 0)
> +		payload_z = end_page - (payload_index >> PAGE_SHIFT);
> +	else
> +		payload_z = 0;
> +
> +	z += payload_z;
> +
> +	/* Get header size in number of descriptors. */
> +	header_z = DIV_ROUND_UP(p->header_length, sizeof *d);
> +
> +	if (d + z + header_z <= tail) {
> +		goto has_space;
> +	} else if (d > tail && d + z + header_z <= end) {
> +		goto has_space;
> +	} else if (d > tail && ctx->buffer + z + header_z <= tail) {
> +		d = ctx->buffer;
> +		goto has_space;
> +	}
> +
> +	/* No space in buffer */
> +	return -1;
> +
> + has_space:
> +	memset(d, 0, (z + header_z) * sizeof *d);
> +	d_bus = ctx->buffer_bus + (d - ctx->buffer) * sizeof *d;
> +
> +	if (p->skip) {
> +		d[0].key = 0;
> +		d[0].req_count = 0;
> +	} else {
> +		d[0].key = DESCRIPTOR_KEY_IMMEDIATE;
> +		d[0].req_count = 8;
> +
> +		header = (struct it_header *)&d[1];
> +		header->sy          = p->sy;
> +		header->tag         = p->tag;
> +		header->tcode       = TCODE_STREAM_DATA;
> +		header->channel     = ctx->base.channel;
> +		header->speed       = ctx->base.speed;
> +		header->data_length = p->header_length + p->payload_length;
> +	}
> +
> +	if (p->header_length > 0) {
> +		d[2].req_count    = p->header_length;
> +		d[2].data_address = d_bus + z * sizeof *d;
> +		memcpy(&d[z], p->header, p->header_length);
> +	}
> +
> +	pd = d + z - payload_z;
> +	payload_end_index = payload_index + p->payload_length;
> +	for (i = 0; i < payload_z; i++) {
> +		page               = payload_index >> PAGE_SHIFT;
> +		offset             = payload_index & ~PAGE_MASK;
> +		next_page_index    = (page + 1) << PAGE_SHIFT;
> +		length             =
> +			min(next_page_index, payload_end_index) - payload_index;
> +		pd[i].req_count    = length;
> +		pd[i].data_address = ctx->base.pages[page] + offset;
> +
> +		payload_index += length;
> +	}
> +
> +	if (z == 2)
> +		last = d;
> +	else
> +		last = d + z - 1;
> +
> +	last->command = DESCRIPTOR_OUTPUT_LAST;
> +	last->status  = 1;
> +	last->branch  = DESCRIPTOR_BRANCH_ALWAYS;
> +	if (p->interrupt)
> +		last->irq = DESCRIPTOR_IRQ_ALWAYS;
> +	else
> +		last->irq = DESCRIPTOR_NO_IRQ;
> +
> +	dma_sync_single_for_device(ohci->card.device, ctx->buffer_bus,
> +				   ISO_BUFFER_SIZE, DMA_TO_DEVICE);
> +
> +	ctx->head_descriptor = d + z + header_z;
> +	ctx->prev_descriptor->branch_address = d_bus | z;
> +	ctx->prev_descriptor = last;
> +
> +	index = ctx - ohci->it_context_list;
> +	reg_write(ohci, OHCI1394_IsoXmitContextControlSet(index), CONTEXT_WAKE);

PCI posting?


> +static struct fw_card_driver ohci_driver = {
> +	.name			= ohci_driver_name,
> +	.enable			= ohci_enable,
> +	.update_phy_reg		= ohci_update_phy_reg,
> +	.set_config_rom		= ohci_set_config_rom,
> +	.send_request		= ohci_send_request,
> +	.send_response		= ohci_send_response,
> +	.enable_phys_dma	= ohci_enable_phys_dma,
> +
> +	.allocate_iso_context	= ohci_allocate_iso_context,
> +	.free_iso_context	= ohci_free_iso_context,
> +	.queue_iso		= ohci_queue_iso,
> +	.send_iso		= ohci_send_iso
> +};
> +
> +static int software_reset(struct fw_ohci *ohci)
> +{
> +	int i;
> +
> +	reg_write(ohci, OHCI1394_HCControlSet, OHCI1394_HCControl_softReset);
> +
> +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
> +		if ((reg_read(ohci, OHCI1394_HCControlSet) &
> +		     OHCI1394_HCControl_softReset) == 0)
> +			return 0;
> +		msleep(1);
> +	}
> +
> +	return -EBUSY;
> +}
> +
> +/* ---------- pci subsystem interface ---------- */
> +
> +enum {
> +	CLEANUP_IRQ,
> +	CLEANUP_SELF_ID,
> +	CLEANUP_REGISTERS,
> +	CLEANUP_IOMEM,
> +	CLEANUP_OHCI
> +};
> +
> +static int cleanup(struct fw_ohci *ohci, int stage, int code)
> +{
> +	switch (stage) {
> +	case CLEANUP_SELF_ID:
> +		pci_free_consistent(ohci->dev, SELF_ID_BUF_SIZE,
> +				    ohci->self_id_cpu, ohci->self_id_bus);
> +	case CLEANUP_REGISTERS:
> +		kfree(ohci->it_context_list);
> +		kfree(ohci->ir_context_list);
> +		iounmap(ohci->registers);
> +	case CLEANUP_IOMEM:
> +		release_mem_region(pci_resource_start(ohci->dev, 0),
> +				   OHCI1394_REGISTER_SIZE);
> +	case CLEANUP_OHCI:
> +		fw_card_put(&ohci->card);
> +	}
> +
> +	return code;
> +}
> +
> +static int __devinit
> +pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
> +{
> +	struct fw_ohci *ohci;
> +	u32 base, bus_options, max_receive, link_speed;
> +	u64 guid;
> +	int error_code;
> +	size_t size;
> +
> +	if (pci_enable_device(dev)) {
> +		fw_error("Failed to enable OHCI hardware.\n");
> +		return -ENXIO;
> +	}
> +
> +	ohci = kzalloc(sizeof *ohci, SLAB_KERNEL);

GFP_KERNEL


> +	if (ohci == NULL) {
> +		fw_error("Could not malloc fw_ohci data.\n");
> +		return -ENOMEM;
> +	}
> +
> +	pci_set_master(dev);
> +	pci_write_config_dword(dev, OHCI1394_PCI_HCI_Control, 0);
> +	pci_set_drvdata(dev, ohci);
> +
> +	ohci->dev = dev;
> +	spin_lock_init(&ohci->lock);
> +
> +	tasklet_init(&ohci->bus_reset_tasklet,
> +		     bus_reset_tasklet, (unsigned long)ohci);
> +
> +	/* We hardcode the register set size, since some cards get
> +	 * this wrong and others have some extra registers after the
> +	 * OHCI range.  We only use the OHCI registers, so there's no
> +	 * need to be clever.  */
> +	base = pci_resource_start(dev, 0);
> +	if (!request_mem_region(base, OHCI1394_REGISTER_SIZE, ohci_driver_name)) {

ugh!  use pci_request_regions(), not request_mem_region()


> +		fw_error("MMIO resource (0x%x - 0x%x) unavailable\n",
> +			 base, base + OHCI1394_REGISTER_SIZE);
> +		return cleanup(ohci, CLEANUP_OHCI, -EBUSY);
> +	}
> +
> +	ohci->registers = ioremap(base, OHCI1394_REGISTER_SIZE);
> +	if (ohci->registers == NULL) {
> +		fw_error("Failed to remap registers\n");
> +		return cleanup(ohci, CLEANUP_IOMEM, -ENXIO);
> +	}

pci_iomap() does a lot of this


> +	if (software_reset(ohci)) {
> +		fw_error("Failed to reset ohci card.\n");
> +		return cleanup(ohci, CLEANUP_REGISTERS, -EBUSY);
> +	}
> +
> +	/* Now enable LPS, which we need in order to start accessing
> +	 * most of the registers.  In fact, on some cards (ALI M5251),
> +	 * accessing registers in the SClk domain without LPS enabled
> +	 * will lock up the machine.  Wait 50msec to make sure we have
> +	 * full link enabled.  */
> +	reg_write(ohci, OHCI1394_HCControlSet,
> +		  OHCI1394_HCControl_LPS |
> +		  OHCI1394_HCControl_postedWriteEnable);
> +	msleep(50);

PCI posting


> +	/* self-id dma buffer allocation */
> +	ohci->self_id_cpu = pci_alloc_consistent(ohci->dev, SELF_ID_BUF_SIZE,
> +						 &ohci->self_id_bus);
> +	if (ohci->self_id_cpu == NULL) {
> +		fw_error("Out of memory for self ID buffer.\n");
> +		return cleanup(ohci, CLEANUP_REGISTERS, -ENOMEM);
> +	}
> +	reg_write(ohci, OHCI1394_SelfIDBuffer, ohci->self_id_bus);
> +	reg_write(ohci, OHCI1394_LinkControlSet,
> +		  OHCI1394_LinkControl_rcvSelfID |
> +		  OHCI1394_LinkControl_cycleTimerEnable |
> +		  OHCI1394_LinkControl_cycleMaster);
> +
> +	ar_context_init(&ohci->ar_request_ctx, ohci,
> +			OHCI1394_AsReqRcvContextControlSet);
> +
> +	ar_context_init(&ohci->ar_response_ctx, ohci,
> +			OHCI1394_AsRspRcvContextControlSet);
> +
> +	at_context_init(&ohci->at_request_ctx, ohci,
> +			OHCI1394_AsReqTrContextControlSet);
> +
> +	at_context_init(&ohci->at_response_ctx, ohci,
> +			OHCI1394_AsRspTrContextControlSet);
> +
> +	reg_write(ohci, OHCI1394_ATRetries,
> +		  OHCI1394_MAX_AT_REQ_RETRIES |
> +		  (OHCI1394_MAX_AT_RESP_RETRIES << 4) |
> +		  (OHCI1394_MAX_PHYS_RESP_RETRIES << 8));
> +
> +	reg_write(ohci, OHCI1394_IsoRecvIntMaskSet, ~0);
> +	ohci->it_context_mask = reg_read(ohci, OHCI1394_IsoRecvIntMaskSet);
> +	reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, ~0);
> +	size = sizeof(struct iso_context) * hweight32(ohci->it_context_mask);
> +	ohci->it_context_list = kzalloc(size, GFP_KERNEL);
> +
> +	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, ~0);
> +	ohci->ir_context_mask = reg_read(ohci, OHCI1394_IsoXmitIntMaskSet);
> +	reg_write(ohci, OHCI1394_IsoXmitIntMaskClear, ~0);
> +	size = sizeof(struct iso_context) * hweight32(ohci->ir_context_mask);
> +	ohci->ir_context_list = kzalloc(size, GFP_KERNEL);
> +
> +	if (ohci->it_context_list == NULL || ohci->ir_context_list == NULL) {
> +		fw_error("Out of memory for it/ir contexts.\n");
> +		return cleanup(ohci, CLEANUP_REGISTERS, -ENOMEM);
> +	}
> +
> +	reg_write(ohci, OHCI1394_PhyUpperBound, 0x00010000);
> +	reg_write(ohci, OHCI1394_IntEventClear, ~0);
> +	reg_write(ohci, OHCI1394_IntMaskClear, ~0);
> +	reg_write(ohci, OHCI1394_IntMaskSet,
> +		  OHCI1394_selfIDComplete |
> +		  OHCI1394_RQPkt | OHCI1394_RSPkt |
> +		  OHCI1394_reqTxComplete | OHCI1394_respTxComplete |
> +		  OHCI1394_isochRx | OHCI1394_isochTx |
> +		  OHCI1394_masterIntEnable);
> +
> +	bus_options = reg_read(ohci, OHCI1394_BusOptions);
> +	max_receive = (bus_options >> 12) & 0xf;
> +	link_speed = bus_options & 0x7;
> +	guid = (__u64) reg_read(ohci, OHCI1394_GUIDHi) << 32 |
> +		reg_read(ohci, OHCI1394_GUIDLo);
> +
> +	error_code = fw_core_add_card(&ohci->card, &ohci_driver, &dev->dev,
> +				      max_receive, link_speed, guid);
> +	if (error_code < 0)
> +		return cleanup(ohci, CLEANUP_SELF_ID, error_code);
> +
> +	fw_notify("Added fw-ohci device %s.\n", dev->dev.bus_id);
> +
> +	return 0;
> +}
> +
> +static void pci_remove(struct pci_dev *dev)
> +{
> +	struct fw_ohci *ohci;
> +
> +	ohci = pci_get_drvdata(dev);
> +	if (ohci == NULL)
> +		return;

test for event that will never occur


> +	free_irq(ohci->dev->irq, ohci);
> +	fw_core_remove_card(&ohci->card);
> +
> +	/* FIXME: Fail all pending packets here, now that the upper
> +	 * layers can't queue any more. */
> +
> +	software_reset(ohci);
> +	cleanup(ohci, CLEANUP_SELF_ID, 0);
> +
> +	fw_notify("Removed fw-ohci device.\n");

need to call pci_disable_device(), pci_release_regions()



> +static struct pci_device_id pci_table[] = {
> +	{
> +		.class		= PCI_CLASS_FIREWIRE_OHCI,
> +		.class_mask	= PCI_ANY_ID,

I'm not sure this is a proper class_mask?


> +		.vendor		= PCI_ANY_ID,
> +		.device		= PCI_ANY_ID,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, pci_table);
> +
> +static struct pci_driver fw_ohci_pci_driver = {
> +	.name		= ohci_driver_name,
> +	.id_table	= pci_table,
> +	.probe		= pci_probe,
> +	.remove		= pci_remove,
> +};
> +
> +MODULE_AUTHOR("Kristian Høgsberg <krh@bitplanet.net>");
> +MODULE_DESCRIPTION("Driver for PCI OHCI IEEE1394 controllers");
> +MODULE_LICENSE("GPL");
> +
> +static int __init fw_ohci_init(void)
> +{
> +	if (pci_register_driver(&fw_ohci_pci_driver)) {
> +		fw_error("Failed to register PCI driver.\n");
> +		return -EBUSY;
> +	}
> +
> +	fw_notify("Loaded fw-ohci driver.\n");
> +
> +	return 0;

just return pci_register_driver() return value directly, don't invent 
your own error when pci_register_driver() already returned a 
more-correct error code



> +static void __exit fw_ohci_cleanup(void)
> +{
> +	pci_unregister_driver(&fw_ohci_pci_driver);
> +	fw_notify("Unloaded fw-ohci driver.\n");
> +}
> +
> +module_init(fw_ohci_init);
> +module_exit(fw_ohci_cleanup);
> diff --git a/drivers/fw/fw-ohci.h b/drivers/fw/fw-ohci.h
> new file mode 100644
> index 0000000..e200b1b
> --- /dev/null
> +++ b/drivers/fw/fw-ohci.h
> @@ -0,0 +1,152 @@
> +#ifndef __fw_ohci_h
> +#define __fw_ohci_h
> +
> +/* OHCI register map */
> +
> +#define OHCI1394_Version                      0x000
> +#define OHCI1394_GUID_ROM                     0x004
> +#define OHCI1394_ATRetries                    0x008
> +#define OHCI1394_CSRData                      0x00C
> +#define OHCI1394_CSRCompareData               0x010
> +#define OHCI1394_CSRControl                   0x014
> +#define OHCI1394_ConfigROMhdr                 0x018
> +#define OHCI1394_BusID                        0x01C
> +#define OHCI1394_BusOptions                   0x020
> +#define OHCI1394_GUIDHi                       0x024
> +#define OHCI1394_GUIDLo                       0x028
> +#define OHCI1394_ConfigROMmap                 0x034
> +#define OHCI1394_PostedWriteAddressLo         0x038
> +#define OHCI1394_PostedWriteAddressHi         0x03C
> +#define OHCI1394_VendorID                     0x040
> +#define OHCI1394_HCControlSet                 0x050
> +#define OHCI1394_HCControlClear               0x054
> +#define  OHCI1394_HCControl_BIBimageValid	0x80000000
> +#define  OHCI1394_HCControl_noByteSwap		0x40000000
> +#define  OHCI1394_HCControl_programPhyEnable	0x00800000
> +#define  OHCI1394_HCControl_aPhyEnhanceEnable	0x00400000
> +#define  OHCI1394_HCControl_LPS			0x00080000
> +#define  OHCI1394_HCControl_postedWriteEnable	0x00040000
> +#define  OHCI1394_HCControl_linkEnable		0x00020000
> +#define  OHCI1394_HCControl_softReset		0x00010000
> +#define OHCI1394_SelfIDBuffer                 0x064
> +#define OHCI1394_SelfIDCount                  0x068
> +#define OHCI1394_IRMultiChanMaskHiSet         0x070
> +#define OHCI1394_IRMultiChanMaskHiClear       0x074
> +#define OHCI1394_IRMultiChanMaskLoSet         0x078
> +#define OHCI1394_IRMultiChanMaskLoClear       0x07C
> +#define OHCI1394_IntEventSet                  0x080
> +#define OHCI1394_IntEventClear                0x084
> +#define OHCI1394_IntMaskSet                   0x088
> +#define OHCI1394_IntMaskClear                 0x08C
> +#define OHCI1394_IsoXmitIntEventSet           0x090
> +#define OHCI1394_IsoXmitIntEventClear         0x094
> +#define OHCI1394_IsoXmitIntMaskSet            0x098
> +#define OHCI1394_IsoXmitIntMaskClear          0x09C
> +#define OHCI1394_IsoRecvIntEventSet           0x0A0
> +#define OHCI1394_IsoRecvIntEventClear         0x0A4
> +#define OHCI1394_IsoRecvIntMaskSet            0x0A8
> +#define OHCI1394_IsoRecvIntMaskClear          0x0AC
> +#define OHCI1394_InitialBandwidthAvailable    0x0B0
> +#define OHCI1394_InitialChannelsAvailableHi   0x0B4
> +#define OHCI1394_InitialChannelsAvailableLo   0x0B8
> +#define OHCI1394_FairnessControl              0x0DC
> +#define OHCI1394_LinkControlSet               0x0E0
> +#define OHCI1394_LinkControlClear             0x0E4
> +#define   OHCI1394_LinkControl_rcvSelfID	(1 << 9)
> +#define   OHCI1394_LinkControl_rcvPhyPkt	(1 << 10)
> +#define   OHCI1394_LinkControl_cycleTimerEnable	(1 << 20)
> +#define   OHCI1394_LinkControl_cycleMaster	(1 << 21)
> +#define   OHCI1394_LinkControl_cycleSource	(1 << 22)
> +#define OHCI1394_NodeID                       0x0E8
> +#define   OHCI1394_NodeID_idValid             0x80000000
> +#define OHCI1394_PhyControl                   0x0EC
> +#define   OHCI1394_PhyControl_Read(addr)	(((addr) << 8) | 0x00008000)
> +#define   OHCI1394_PhyControl_ReadDone		0x80000000
> +#define   OHCI1394_PhyControl_ReadData(r)	(((r) & 0x00ff0000) >> 16)
> +#define   OHCI1394_PhyControl_Write(addr, data) (((addr) << 8) | (data) | 0x00004000)
> +#define   OHCI1394_PhyControl_WriteDone		0x00004000
> +#define OHCI1394_IsochronousCycleTimer        0x0F0
> +#define OHCI1394_AsReqFilterHiSet             0x100
> +#define OHCI1394_AsReqFilterHiClear           0x104
> +#define OHCI1394_AsReqFilterLoSet             0x108
> +#define OHCI1394_AsReqFilterLoClear           0x10C
> +#define OHCI1394_PhyReqFilterHiSet            0x110
> +#define OHCI1394_PhyReqFilterHiClear          0x114
> +#define OHCI1394_PhyReqFilterLoSet            0x118
> +#define OHCI1394_PhyReqFilterLoClear          0x11C
> +#define OHCI1394_PhyUpperBound                0x120
> +
> +#define OHCI1394_AsReqTrContextBase           0x180
> +#define OHCI1394_AsReqTrContextControlSet     0x180
> +#define OHCI1394_AsReqTrContextControlClear   0x184
> +#define OHCI1394_AsReqTrCommandPtr            0x18C
> +
> +#define OHCI1394_AsRspTrContextBase           0x1A0
> +#define OHCI1394_AsRspTrContextControlSet     0x1A0
> +#define OHCI1394_AsRspTrContextControlClear   0x1A4
> +#define OHCI1394_AsRspTrCommandPtr            0x1AC
> +
> +#define OHCI1394_AsReqRcvContextBase          0x1C0
> +#define OHCI1394_AsReqRcvContextControlSet    0x1C0
> +#define OHCI1394_AsReqRcvContextControlClear  0x1C4
> +#define OHCI1394_AsReqRcvCommandPtr           0x1CC
> +
> +#define OHCI1394_AsRspRcvContextBase          0x1E0
> +#define OHCI1394_AsRspRcvContextControlSet    0x1E0
> +#define OHCI1394_AsRspRcvContextControlClear  0x1E4
> +#define OHCI1394_AsRspRcvCommandPtr           0x1EC
> +
> +/* Isochronous transmit registers */
> +#define OHCI1394_IsoXmitContextBase(n)           (0x200 + 16 * (n))
> +#define OHCI1394_IsoXmitContextControlSet(n)     (0x200 + 16 * (n))
> +#define OHCI1394_IsoXmitContextControlClear(n)   (0x204 + 16 * (n))
> +#define OHCI1394_IsoXmitCommandPtr(n)            (0x20C + 16 * (n))
> +
> +/* Isochronous receive registers */
> +#define OHCI1394_IsoRcvContextControlSet(n)   (0x400 + 32 * (n))
> +#define OHCI1394_IsoRcvContextControlClear(n) (0x404 + 32 * (n))
> +#define OHCI1394_IsoRcvCommandPtr(n)          (0x40C + 32 * (n))
> +#define OHCI1394_IsoRcvContextMatch(n)        (0x410 + 32 * (n))
> +
> +/* Interrupts Mask/Events */
> +#define OHCI1394_reqTxComplete           0x00000001
> +#define OHCI1394_respTxComplete          0x00000002
> +#define OHCI1394_ARRQ                    0x00000004
> +#define OHCI1394_ARRS                    0x00000008
> +#define OHCI1394_RQPkt                   0x00000010
> +#define OHCI1394_RSPkt                   0x00000020
> +#define OHCI1394_isochTx                 0x00000040
> +#define OHCI1394_isochRx                 0x00000080
> +#define OHCI1394_postedWriteErr          0x00000100
> +#define OHCI1394_lockRespErr             0x00000200
> +#define OHCI1394_selfIDComplete          0x00010000
> +#define OHCI1394_busReset                0x00020000
> +#define OHCI1394_phy                     0x00080000
> +#define OHCI1394_cycleSynch              0x00100000
> +#define OHCI1394_cycle64Seconds          0x00200000
> +#define OHCI1394_cycleLost               0x00400000
> +#define OHCI1394_cycleInconsistent       0x00800000
> +#define OHCI1394_unrecoverableError      0x01000000
> +#define OHCI1394_cycleTooLong            0x02000000
> +#define OHCI1394_phyRegRcvd              0x04000000
> +#define OHCI1394_masterIntEnable         0x80000000
> +
> +#define OHCI1394_evt_no_status		0x0
> +#define OHCI1394_evt_long_packet	0x2
> +#define OHCI1394_evt_missing_ack	0x3
> +#define OHCI1394_evt_underrun		0x4
> +#define OHCI1394_evt_overrun		0x5
> +#define OHCI1394_evt_descriptor_read	0x6
> +#define OHCI1394_evt_data_read		0x7
> +#define OHCI1394_evt_data_write		0x8
> +#define OHCI1394_evt_bus_reset		0x9
> +#define OHCI1394_evt_timeout		0xa
> +#define OHCI1394_evt_tcode_err		0xb
> +#define OHCI1394_evt_reserved_b		0xc
> +#define OHCI1394_evt_reserved_c		0xd
> +#define OHCI1394_evt_unknown		0xe
> +#define OHCI1394_evt_flushed		0xf
> +
> +#define OHCI1394_phy_tcode		0xe

consider enum{} for reasons mentioned above

