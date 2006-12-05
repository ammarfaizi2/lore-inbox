Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937358AbWLEGko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937358AbWLEGko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966991AbWLEGko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:40:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58941 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937358AbWLEGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:40:34 -0500
From: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/2] Import fw-core driver.
Date: Tue, 05 Dec 2006 01:36:49 -0500
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-Id: <20061205063648.9320.84534.stgit@dinky.boston.redhat.com>
In-Reply-To: <20061205063641.9320.44707.stgit@dinky.boston.redhat.com>
References: <20061205063641.9320.44707.stgit@dinky.boston.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pull in the core stack and build system changes.

Signed-off-by: Kristian Høgsberg <krh@redhat.com>
---

 drivers/Kconfig             |    2 
 drivers/Makefile            |    1 
 drivers/fw/Kconfig          |   23 +
 drivers/fw/Makefile         |    7 
 drivers/fw/fw-card.c        |  410 +++++++++++++++++++++
 drivers/fw/fw-iso.c         |  136 +++++++
 drivers/fw/fw-topology.c    |  444 ++++++++++++++++++++++
 drivers/fw/fw-topology.h    |  131 +++++++
 drivers/fw/fw-transaction.c |  856 +++++++++++++++++++++++++++++++++++++++++++
 drivers/fw/fw-transaction.h |  415 +++++++++++++++++++++
 10 files changed, 2425 insertions(+), 0 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index f394634..cf39e45 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -30,6 +30,8 @@ source "drivers/md/Kconfig"
 
 source "drivers/message/fusion/Kconfig"
 
+source "drivers/fw/Kconfig"
+
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 4ac14da..43335ef 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
 obj-$(CONFIG_ATA)		+= ata/
 obj-$(CONFIG_FUSION)		+= message/
+obj-$(CONFIG_FW_CORE)		+= fw/
 obj-$(CONFIG_IEEE1394)		+= ieee1394/
 obj-y				+= cdrom/
 obj-$(CONFIG_MTD)		+= mtd/
diff --git a/drivers/fw/Kconfig b/drivers/fw/Kconfig
new file mode 100644
index 0000000..f09ed59
--- /dev/null
+++ b/drivers/fw/Kconfig
@@ -0,0 +1,23 @@
+# -*- shell-script -*-
+
+menu "IEEE 1394 (FireWire) support (JUJU alternative stack)"
+
+config FW_CORE
+	tristate "IEEE 1394 (FireWire) support (JUJU alternative stack)"
+	help
+	  IEEE 1394 describes a high performance serial bus, which is also
+	  known as FireWire(tm) or i.Link(tm) and is used for connecting all
+	  sorts of devices (most notably digital video cameras) to your
+	  computer.
+
+	  If you have FireWire hardware and want to use it, say Y here.  This
+	  is the core support only, you will also need to select a driver for
+	  your IEEE 1394 adapter.
+
+	  This is the "JUJU" firewire stack, an alternative
+	  implementation designed for roboustness and simplicity.
+
+	  To compile this driver as a module, say M here: the
+	  module will be called fw-core.
+
+endmenu
diff --git a/drivers/fw/Makefile b/drivers/fw/Makefile
new file mode 100644
index 0000000..1b2a3ad
--- /dev/null
+++ b/drivers/fw/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux IEEE 1394 implementation
+#
+
+fw-core-objs := fw-card.o fw-topology.o fw-transaction.o fw-iso.o
+
+obj-$(CONFIG_FW_CORE) += fw-core.o
diff --git a/drivers/fw/fw-card.c b/drivers/fw/fw-card.c
new file mode 100644
index 0000000..6840441
--- /dev/null
+++ b/drivers/fw/fw-card.c
@@ -0,0 +1,410 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-card.c - card level functions
+ *
+ * Copyright © 2005  Kristian Høgsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include "fw-transaction.h"
+#include "fw-topology.h"
+#include "fw-device.h"
+
+/* The lib/crc16.c implementation uses the standard (0x8005)
+ * polynomial, but we need the ITU-T (or CCITT) polynomial (0x1021).
+ * The implementation below works on an array of host-endian u32
+ * words, assuming they'll be transmited msb first. */
+static u16
+crc16_itu_t(const u32 *buffer, size_t length)
+{
+	int shift, i;
+	u32 data;
+	u16 sum, crc = 0;
+
+	for (i = 0; i < length; i++) {
+		data = *buffer++;
+		for (shift = 28; shift >= 0; shift -= 4 ) {
+			sum = ((crc >> 12) ^ (data >> shift)) & 0xf;
+			crc = (crc << 4) ^ (sum << 12) ^ (sum << 5) ^ (sum);
+		}
+		crc &= 0xffff;
+	}
+
+	return crc;
+}
+
+static LIST_HEAD(card_list);
+
+static LIST_HEAD(descriptor_list);
+static int descriptor_count;
+
+static u32 *
+generate_config_rom (struct fw_card *card, size_t *config_rom_length)
+{
+	struct fw_descriptor *desc;
+        struct fw_config_rom *crh;
+	static u32 config_rom[256];
+	int i, j, length;
+
+        /* Initialize contents of config rom buffer.  On the OHCI
+         * controller, block reads to the config rom accesses the host
+         * memory, but quadlet read access the hardware bus info block
+         * registers.  That's just crack, but it means we should make
+         * sure the contents of bus info block in host memory mathces
+         * the version stored in the OHCI registers. */
+
+	memset(config_rom, 0, sizeof config_rom);
+        crh = (struct fw_config_rom *) config_rom;
+	crh->crc_length = 4;
+	crh->info_length = 4;
+	crh->crc = 0;
+	crh->magic = 0x31333934;
+
+        crh->link_speed = card->link_speed;
+	/* 1394a 10.25 specifies that the config rom generation field
+	 * must be updated every time a node updates its config rom
+	 * and that it should be a number between 0x2 and 0xf; thus the
+	 * generation++ % 14 + 2. */
+        crh->generation = card->config_rom_generation++ % 14 + 2;
+        crh->max_rom = 2;
+        crh->max_receive = card->max_receive;
+        crh->isc = 1;
+        crh->cmc = 1;
+        crh->imc = 1;
+        crh->guid_high = card->guid >> 32;
+        crh->guid_low = card->guid;
+
+	/* Generate root directory. */
+	i = 0;
+	crh->data[i++] = 0;
+	crh->data[i++] = 0x0c0083c0; /* node capabilities */
+	crh->data[i++] = 0x03d00d1e; /* vendor id */
+	j = i + descriptor_count;
+
+	/* Generate root directory entries for descriptors. */
+	list_for_each_entry (desc, &descriptor_list, link) {
+		crh->data[i] = desc->key | (j - i);
+		i++;
+		j += desc->length;
+	}
+
+	/* Update root directory length. */
+	crh->data[0] = (i - 1) << 16;
+
+	/* End of root directory, now copy in descriptors. */
+	list_for_each_entry (desc, &descriptor_list, link) {
+		memcpy(&crh->data[i], desc->data, desc->length * 4);
+		i += desc->length;
+	}
+
+	/* Byteswap and calculate CRCs for all blocks in the config
+	 * rom.  This assumes that CRC length and info length are
+	 * identical for the bus info block, which is always the case
+	 * for this implementation. */
+	for (i = 0; i < 5 + j; i += length + 1) {
+		length = (config_rom[i] >> 16) & 0xff;
+		config_rom[i] |= crc16_itu_t(&config_rom[i + 1], length);
+	}
+
+	*config_rom_length = 5 + j;
+
+	return config_rom;
+}
+
+static void
+update_config_roms (void)
+{
+	struct fw_card *card;
+	u32 *config_rom;
+	int length;
+
+	list_for_each_entry (card, &card_list, link) {
+		config_rom = generate_config_rom(card, &length);
+		card->driver->set_config_rom(card, config_rom, length);
+	}
+}
+
+int
+fw_core_add_descriptor (struct fw_descriptor *desc)
+{
+	size_t i;
+
+	/* Check descriptor is valid; the length of all blocks in the
+	 * descriptor has to add up to exactly the length of the
+	 * block. */
+	i = 0;
+	while (i < desc->length)
+		i += (desc->data[i] >> 16) + 1;
+
+	if (i != desc->length)
+		return -1;
+
+	down_write(&fw_bus_type.subsys.rwsem);
+
+	list_add_tail (&desc->link, &descriptor_list);
+	descriptor_count++;
+	update_config_roms();
+
+	up_write(&fw_bus_type.subsys.rwsem);
+
+	return 0;
+}
+EXPORT_SYMBOL(fw_core_add_descriptor);
+
+void
+fw_core_remove_descriptor (struct fw_descriptor *desc)
+{
+	down_write(&fw_bus_type.subsys.rwsem);
+
+	list_del(&desc->link);
+	descriptor_count--;
+	update_config_roms();
+
+	up_write(&fw_bus_type.subsys.rwsem);
+}
+EXPORT_SYMBOL(fw_core_remove_descriptor);
+
+static void
+fw_card_irm_work(void *data)
+{
+	struct fw_card *card = data;
+	struct fw_device *root;
+	unsigned long flags;
+
+	/* FIXME: This simple bus management unconditionally picks a
+	 * cycle master if the current root can't do it.  We need to
+	 * not do this if there is a bus manager already.  Also, some
+	 * hubs set the contender bit, which is bogus, so we should
+	 * probably do a little sanity check on the IRM (like, read
+	 * the bandwidth register) if it's not us. */
+
+	spin_lock_irqsave(&card->lock, flags);
+
+	root = card->root_node->data;
+
+	/* Either link_on is false, or we failed to read the config
+	 * rom.  In either case, pick another root. */
+	if (root == NULL)
+		goto reset;
+
+	/* If we haven't probed this device yet, bail out now and
+	 * let's try again once that's done. */
+	if (root->state != FW_DEVICE_RUNNING)
+		goto out;
+
+	if (root->config_rom->cmc)
+		/* FIXME: I suppose we should set the cmstr bit in the
+		 * STATE_CLEAR register of this node, as described in
+		 * 1394-1995, 8.4.2.6.  Also, send out a force root
+		 * packet for this node. */
+		goto out;
+
+ reset:
+	if (card->irm_retries++ > 5)
+		goto out;
+
+	fw_notify("Trying to become root (card %p)\n", card);
+	fw_send_force_root(card, card->local_node->node_id,
+			   card->generation);
+	fw_core_initiate_bus_reset(card, 1);
+
+ out:
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
+static void
+release_card(struct device *device)
+{
+	struct fw_card *card =
+		container_of(device, struct fw_card, card_device);
+
+	kfree(card);
+}
+
+int
+fw_core_add_card (struct fw_card *card, struct fw_card_driver *driver,
+		  struct device *device,
+                  u32 max_receive, u32 link_speed, u64 guid)
+{
+	static int index;
+	u32 *config_rom;
+	int length, retval;
+
+	card->index = index++;
+        card->driver = driver;
+	card->device = device;
+	card->max_receive = max_receive;
+	card->link_speed = link_speed;
+        card->guid = guid;
+        card->current_tlabel = 0;
+        card->tlabel_mask = 0;
+	card->color = 0;
+
+        INIT_LIST_HEAD(&card->transaction_list);
+	spin_lock_init(&card->lock);
+
+	card->local_node = NULL;
+
+        /* FIXME: add #define's for phy registers. */
+	/* Activate link_on bit and contender bit in our self ID packets.*/
+        if (driver->update_phy_reg(card, 4, 0, 0x80 | 0x40) < 0)
+                return -EIO;
+
+	down_write(&fw_bus_type.subsys.rwsem);
+
+	config_rom = generate_config_rom (card, &length);
+
+	list_add_tail(&card->link, &card_list);
+
+	up_write(&fw_bus_type.subsys.rwsem);
+
+	INIT_WORK(&card->work, fw_card_irm_work, card);
+
+	card->card_device.bus     = &fw_bus_type;
+	card->card_device.release = release_card;
+	card->card_device.parent  = card->device;
+	snprintf(card->card_device.bus_id, sizeof card->card_device.bus_id,
+		 "fwcard%d", card->index);
+
+	retval = device_register(&card->card_device);
+	if (retval < 0) {
+                fw_error("Failed to register card device.");
+		return retval;
+	}
+
+	/* The subsystem grabs a reference when the card is added and
+	 * drops it when the driver calls fw_core_remove_card. */
+	fw_card_get(card);
+
+        return driver->enable(card, config_rom, length);
+}
+EXPORT_SYMBOL(fw_core_add_card);
+
+/* The next few functions implements a dummy driver that use once a
+ * card driver shuts down an fw_card.  This allows the driver to
+ * cleanly unload, as all IO to the card will be handled by the dummy
+ * driver instead of calling into the (possibly) unloaded module.  The
+ * dummy driver just fails all IO. */
+
+static int
+dummy_enable(struct fw_card *card, u32 *config_rom, size_t length)
+{
+	BUG();
+	return -1;
+}
+
+static int
+dummy_update_phy_reg(struct fw_card *card, int address,
+		     int clear_bits, int set_bits)
+{
+	return -ENODEV;
+}
+
+static int
+dummy_set_config_rom(struct fw_card *card,
+		     u32 *config_rom, size_t length)
+{
+	/* We take the card out of card_list before setting the dummy
+	 * driver, so this should never get called. */
+	BUG();
+	return -1;
+}
+
+static void
+dummy_send_request(struct fw_card *card, struct fw_packet *packet)
+{
+        packet->callback(packet, card, -ENODEV);
+}
+
+static void
+dummy_send_response(struct fw_card *card, struct fw_packet *packet)
+{
+        packet->callback(packet, card, -ENODEV);
+}
+
+static int
+dummy_enable_phys_dma(struct fw_card *card,
+		      int node_id, int generation)
+{
+	return -ENODEV;
+}
+
+static struct fw_card_driver dummy_driver = {
+        .name            = "dummy",
+	.enable          = dummy_enable,
+	.update_phy_reg  = dummy_update_phy_reg,
+	.set_config_rom  = dummy_set_config_rom,
+        .send_request    = dummy_send_request,
+        .send_response   = dummy_send_response,
+	.enable_phys_dma = dummy_enable_phys_dma
+};
+
+void flush_transactions(struct fw_card *card, u32 timestamp);
+
+void
+fw_core_remove_card(struct fw_card *card)
+{
+	down_write(&fw_bus_type.subsys.rwsem);
+	list_del(&card->link);
+	up_write(&fw_bus_type.subsys.rwsem);
+
+	/* Set up the dummy driver. */
+	card->driver = &dummy_driver;
+
+	flush_transactions(card, 0x20000);
+
+	fw_destroy_nodes(card);
+
+	/* This also drops the subsystem reference. */
+	device_unregister(&card->card_device);
+}
+EXPORT_SYMBOL(fw_core_remove_card);
+
+struct fw_card *
+fw_card_get(struct fw_card *card)
+{
+	get_device(&card->card_device);
+
+	return card;
+}
+EXPORT_SYMBOL(fw_card_get);
+
+/* An assumption for fw_card_put() is that the card driver allocates
+ * the fw_card struct with kalloc and that it has been shut down
+ * before the last ref is dropped. */
+void
+fw_card_put(struct fw_card *card)
+{
+	put_device(&card->card_device);
+}
+EXPORT_SYMBOL(fw_card_put);
+
+int
+fw_core_initiate_bus_reset(struct fw_card *card, int short_reset)
+{
+        u32 address;
+
+        if (short_reset)
+                address = 5;
+        else
+                address = 1;
+
+        return card->driver->update_phy_reg(card, address, 0, 0x40);
+}
+EXPORT_SYMBOL(fw_core_initiate_bus_reset);
diff --git a/drivers/fw/fw-iso.c b/drivers/fw/fw-iso.c
new file mode 100644
index 0000000..8cfaa5a
--- /dev/null
+++ b/drivers/fw/fw-iso.c
@@ -0,0 +1,136 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-iso.c - Isochronous IO
+ * Copyright (C) 2006 Kristian Høgsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+
+#include "fw-transaction.h"
+#include "fw-topology.h"
+#include "fw-device.h"
+
+static int
+setup_iso_buffer(struct fw_iso_context *ctx, size_t size,
+		 enum dma_data_direction direction)
+{
+	struct page *page;
+	int i;
+	void *p;
+
+	ctx->buffer_size = PAGE_ALIGN(size);
+	if (size == 0)
+		return 0;
+
+	ctx->buffer = vmalloc_32_user(ctx->buffer_size);
+	if (ctx->buffer == NULL)
+		return -ENOMEM;
+
+	ctx->page_count = ctx->buffer_size >> PAGE_SHIFT;
+	ctx->pages =
+	    kzalloc(ctx->page_count * sizeof(ctx->pages[0]), GFP_KERNEL);
+	if (ctx->pages == NULL) {
+		vfree(ctx->buffer);
+		return -ENOMEM;
+	}
+
+	p = ctx->buffer;
+	for (i = 0; i < ctx->page_count; i++, p += PAGE_SIZE) {
+		page = vmalloc_to_page(p);
+		ctx->pages[i] = dma_map_page(ctx->card->device,
+					     page, 0, PAGE_SIZE, direction);
+	}
+
+	return 0;
+}
+
+static void destroy_iso_buffer(struct fw_iso_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->page_count; i++)
+		dma_unmap_page(ctx->card->device, ctx->pages[i],
+			       PAGE_SIZE, DMA_TO_DEVICE);
+
+	kfree(ctx->pages);
+	vfree(ctx->buffer);
+}
+
+struct fw_iso_context *fw_iso_context_create(struct fw_card *card, int type,
+					     size_t buffer_size,
+					     fw_iso_callback_t callback,
+					     void *callback_data)
+{
+	struct fw_iso_context *ctx;
+	int retval;
+
+	ctx = card->driver->allocate_iso_context(card, type);
+	if (IS_ERR(ctx))
+		return ctx;
+
+	ctx->card = card;
+	ctx->type = type;
+	ctx->callback = callback;
+	ctx->callback_data = callback_data;
+
+	retval = setup_iso_buffer(ctx, buffer_size, DMA_TO_DEVICE);
+	if (retval < 0) {
+		card->driver->free_iso_context(ctx);
+		return ERR_PTR(retval);
+	}
+
+	return ctx;
+}
+
+EXPORT_SYMBOL(fw_iso_context_create);
+
+void fw_iso_context_destroy(struct fw_iso_context *ctx)
+{
+	struct fw_card *card = ctx->card;
+
+	destroy_iso_buffer(ctx);
+
+	card->driver->free_iso_context(ctx);
+}
+
+EXPORT_SYMBOL(fw_iso_context_destroy);
+
+int
+fw_iso_context_send(struct fw_iso_context *ctx,
+		    int channel, int speed, int cycle)
+{
+	ctx->channel = channel;
+	ctx->speed = speed;
+
+	return ctx->card->driver->send_iso(ctx, cycle);
+}
+
+EXPORT_SYMBOL(fw_iso_context_send);
+
+int
+fw_iso_context_queue(struct fw_iso_context *ctx,
+		     struct fw_iso_packet *packet, void *payload)
+{
+	struct fw_card *card = ctx->card;
+
+	return card->driver->queue_iso(ctx, packet, payload);
+}
+
+EXPORT_SYMBOL(fw_iso_context_queue);
diff --git a/drivers/fw/fw-topology.c b/drivers/fw/fw-topology.c
new file mode 100644
index 0000000..9fe1ab8
--- /dev/null
+++ b/drivers/fw/fw-topology.c
@@ -0,0 +1,444 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-topology.c - Incremental bus scan, based on bus topology
+ *
+ * Copyright (C) 2004 Kristian Høgsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/wait.h>
+#include <linux/errno.h>
+#include "fw-transaction.h"
+#include "fw-topology.h"
+
+static struct fw_phy_packet *count_ports(struct fw_phy_packet *sid,
+					 int *total_port_count,
+					 int *child_port_count)
+{
+	struct fw_phy_packet q;
+	int port_type, shift, seq;
+
+	*total_port_count = 0;
+	*child_port_count = 0;
+
+	shift = 6;
+	q = *sid;
+	seq = 0;
+
+	while (1) {
+		port_type = (q.quadlet >> shift) & 0x03;
+		switch (port_type) {
+		case SELFID_PORT_CHILD:
+			(*child_port_count)++;
+		case SELFID_PORT_PARENT:
+		case SELFID_PORT_NCONN:
+			(*total_port_count)++;
+		case SELFID_PORT_NONE:
+			break;
+		}
+
+		shift -= 2;
+		if (shift == 0) {
+			if (!q.self_id.more_packets)
+				return sid + 1;
+
+			shift = 16;
+			sid++;
+			q = *sid;
+
+			/* Check that the extra packets actually are
+			 * extended self ID packets and that the
+			 * sequence numbers in the extended self ID
+			 * packets increase as expected. */
+
+			if (!q.extended_self_id.extended ||
+			    seq != q.extended_self_id.sequence)
+				return NULL;
+
+			seq++;
+		}
+	}
+}
+
+static int get_port_type(struct fw_phy_packet *sid, int port_index)
+{
+	int index, shift;
+
+	index = (port_index + 5) / 8;
+	shift = 16 - ((port_index + 5) & 7) * 2;
+	return (sid[index].quadlet >> shift) & 0x03;
+}
+
+/* Nodes are created with a ref count of one, belonging to the tree
+ * they are part of. */
+struct fw_node *fw_node_create(struct fw_phy_packet sid, int port_count,
+			       int color)
+{
+	struct fw_node *node;
+
+	node = kzalloc(sizeof *node + port_count * sizeof node->ports[0],
+		       GFP_ATOMIC);
+	if (node == NULL)
+		return NULL;
+
+	node->color = color;
+	node->node_id = sid.self_id.phy_id;
+	node->link_on = sid.self_id.link_on;
+	node->phy_speed = sid.self_id.phy_speed;
+	node->port_count = port_count;
+
+	atomic_set(&node->ref_count, 1);
+	INIT_LIST_HEAD(&node->link);
+
+	return node;
+}
+
+/**
+ * build_tree - Build the tree representation of the topology
+ * @self_ids: array of self IDs to create the tree from
+ * @self_id_count: the length of the self_ids array
+ * @local_id: the node ID of the local node
+ *
+ * This function builds the tree representation of the topology given
+ * by the self IDs from the latest bus reset.  During the construction
+ * of the tree, the function checks that the self IDs are valid and
+ * internally consistent.  On succcess this funtions returns the
+ * fw_node corresponding to the local card otherwise NULL.
+ */
+static struct fw_node *build_tree(struct fw_card *card)
+{
+	struct fw_node *node, *child, *local_node;
+	struct list_head stack, *h;
+	struct fw_phy_packet *sid, *next_sid, *end, q;
+	int i, port_count, child_port_count, phy_id, parent_count, stack_depth;
+
+	local_node = NULL;
+	node = NULL;
+	INIT_LIST_HEAD(&stack);
+	stack_depth = 0;
+	sid = (struct fw_phy_packet *)card->self_ids;
+	end = sid + card->self_id_count;
+	phy_id = 0;
+	card->irm_node = NULL;
+
+	while (sid < end) {
+		next_sid = count_ports(sid, &port_count, &child_port_count);
+
+		if (next_sid == NULL) {
+			fw_error("Inconsistent extended self IDs.\n");
+			return NULL;
+		}
+
+		q = *sid;
+		if (phy_id != q.self_id.phy_id) {
+			fw_error("PHY ID mismatch in self ID: %d != %d.\n",
+				 phy_id, q.self_id.phy_id);
+			return NULL;
+		}
+
+		if (child_port_count > stack_depth) {
+			fw_error("Topology stack underflow\n");
+			return NULL;
+		}
+
+		/* Seek back from the top of our stack to find the
+		 * start of the child nodes for this node. */
+		for (i = 0, h = &stack; i < child_port_count; i++)
+			h = h->prev;
+		child = fw_node(h);
+
+		node = fw_node_create(q, port_count, card->color);
+		if (node == NULL) {
+			fw_error("Out of memory while building topology.");
+			return NULL;
+		}
+
+		if (phy_id == (card->node_id & 0x3f))
+			local_node = node;
+
+		if (q.self_id.contender)
+			card->irm_node = node;
+
+		parent_count = 0;
+
+		for (i = 0; i < port_count; i++) {
+			switch (get_port_type(sid, i)) {
+			case SELFID_PORT_PARENT:
+				/* Who's your daddy?  We dont know the
+				 * parent node at this time, so we
+				 * temporarily abuse node->color for
+				 * remembering the entry in the
+				 * node->ports array where the parent
+				 * node should be.  Later, when we
+				 * handle the parent node, we fix up
+				 * the reference.
+				 */
+				parent_count++;
+				node->color = i;
+				break;
+
+			case SELFID_PORT_CHILD:
+				node->ports[i].node = child;
+				/* Fix up parent reference for this
+				 * child node. */
+				child->ports[child->color].node = node;
+				child->color = card->color;
+				child = fw_node(child->link.next);
+				break;
+			}
+		}
+
+		/* Check that the node reports exactly one parent
+		 * port, except for the root, which of course should
+		 * have no parents. */
+		if ((next_sid == end && parent_count != 0) ||
+		    (next_sid < end && parent_count != 1)) {
+			fw_error("Parent port inconsistency for node %d: "
+				 "parent_count=%d\n", phy_id, parent_count);
+			return NULL;
+		}
+
+		/* Pop the child nodes off the stack and push the new node. */
+		__list_del(h->prev, &stack);
+		list_add_tail(&node->link, &stack);
+		stack_depth += 1 - child_port_count;
+
+		sid = next_sid;
+		phy_id++;
+	}
+
+	card->root_node = node;
+
+	return local_node;
+}
+
+typedef void (*fw_node_callback_t) (struct fw_card * card,
+				    struct fw_node * node,
+				    struct fw_node * parent);
+
+static void
+for_each_fw_node(struct fw_card *card, struct fw_node *root,
+		 fw_node_callback_t callback)
+{
+	struct list_head list;
+	struct fw_node *node, *child, *parent;
+	int i;
+
+	INIT_LIST_HEAD(&list);
+
+	list_add_tail(&root->link, &list);
+	parent = NULL;
+	while (!list_empty(&list)) {
+		node = fw_node(list.next);
+		list_del(&node->link);
+		node->color = card->color;
+
+		for (i = 0; i < node->port_count; i++) {
+			child = node->ports[i].node;
+			if (!child)
+				continue;
+			if (child->color == card->color)
+				parent = child;
+			else
+				list_add_tail(&child->link, &list);
+		}
+
+		callback(card, node, parent);
+	}
+}
+
+static void
+report_lost_node(struct fw_card *card,
+		 struct fw_node *node, struct fw_node *parent)
+{
+	fw_node_event(card, node, FW_NODE_DESTROYED);
+	fw_node_put(node);
+}
+
+static void
+report_found_node(struct fw_card *card,
+		  struct fw_node *node, struct fw_node *parent)
+{
+	int b_path = (node->phy_speed == SCODE_BETA);
+
+	if (parent != NULL) {
+		node->max_speed = min(parent->max_speed, node->phy_speed);
+		node->b_path = parent->b_path && b_path;
+	} else {
+		node->max_speed = node->phy_speed;
+		node->b_path = b_path;
+	}
+
+	fw_node_event(card, node, FW_NODE_CREATED);
+}
+
+void fw_destroy_nodes(struct fw_card *card)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	card->color++;
+	if (card->local_node != NULL)
+		for_each_fw_node(card, card->local_node, report_lost_node);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
+static void move_tree(struct fw_node *node0, struct fw_node *node1, int port)
+{
+	struct fw_node *tree;
+	int i;
+
+	tree = node1->ports[port].node;
+	node0->ports[port].node = tree;
+	for (i = 0; i < tree->port_count; i++) {
+		if (tree->ports[i].node == node1) {
+			tree->ports[i].node = node0;
+			break;
+		}
+	}
+}
+
+/**
+ * update_tree - compare the old topology tree for card with the new
+ * one specified by root.  Queue the nodes and mark them as either
+ * found, lost or updated.  Update the nodes in the card topology tree
+ * as we go.
+ */
+static void
+update_tree(struct fw_card *card, struct fw_node *root, int *changed)
+{
+	struct list_head list0, list1;
+	struct fw_node *node0, *node1;
+	int i, event;
+
+	INIT_LIST_HEAD(&list0);
+	list_add_tail(&card->local_node->link, &list0);
+	INIT_LIST_HEAD(&list1);
+	list_add_tail(&root->link, &list1);
+
+	node0 = fw_node(list0.next);
+	node1 = fw_node(list1.next);
+	*changed = 0;
+
+	while (&node0->link != &list0) {
+
+		/* assert(node0->port_count == node1->port_count); */
+		if (node0->link_on && !node1->link_on)
+			event = FW_NODE_LINK_OFF;
+		else if (!node0->link_on && node1->link_on)
+			event = FW_NODE_LINK_ON;
+		else
+			event = FW_NODE_UPDATED;
+
+		node0->node_id = node1->node_id;
+		node0->color = card->color;
+		node0->link_on = node1->link_on;
+		node0->initiated_reset = node1->initiated_reset;
+		node1->color = card->color;
+		fw_node_event(card, node0, event);
+
+		if (card->root_node == node1)
+			card->root_node = node0;
+		if (card->irm_node == node1)
+			card->irm_node = node0;
+
+		for (i = 0; i < node0->port_count; i++) {
+			if (node0->ports[i].node && node1->ports[i].node) {
+				/* This port didn't change, queue the
+				 * connected node for further
+				 * investigation. */
+				if (node0->ports[i].node->color == card->color)
+					continue;
+				list_add_tail(&node0->ports[i].node->link,
+					      &list0);
+				list_add_tail(&node1->ports[i].node->link,
+					      &list1);
+			} else if (node0->ports[i].node) {
+				/* The nodes connected here were
+				 * unplugged; unref the lost nodes and
+				 * queue FW_NODE_LOST callbacks for
+				 * them. */
+
+				for_each_fw_node(card, node0->ports[i].node,
+						 report_lost_node);
+				node0->ports[i].node = NULL;
+				*changed = 1;
+			} else if (node1->ports[i].node) {
+				/* One or more node were connected to
+				 * this port. Move the new nodes into
+				 * the tree and queue FW_NODE_CREATED
+				 * callbacks for them. */
+				move_tree(node0, node1, i);
+				for_each_fw_node(card, node0->ports[i].node,
+						 report_found_node);
+				*changed = 1;
+			}
+		}
+
+		node0 = fw_node(node0->link.next);
+		node1 = fw_node(node1->link.next);
+	}
+}
+
+void flush_transactions(struct fw_card *card, u32 timestamp);
+
+void
+fw_core_handle_bus_reset(struct fw_card *card,
+			 int node_id, int generation,
+			 int self_id_count, u32 * self_ids)
+{
+	struct fw_node *local_node;
+	unsigned long flags;
+	int changed;
+
+	flush_transactions(card, 0x20000);
+
+	spin_lock_irqsave(&card->lock, flags);
+
+	card->node_id = node_id;
+	card->self_id_count = self_id_count;
+	card->generation = generation;
+	memcpy(card->self_ids, self_ids, self_id_count * 4);
+
+	local_node = build_tree(card);
+
+	card->color++;
+
+	if (local_node == NULL) {
+		fw_error("topology build failed\n");
+		/* FIXME: We need to issue a bus reset in this case. */
+	} else if (card->local_node == NULL) {
+		card->local_node = local_node;
+		for_each_fw_node(card, local_node, report_found_node);
+	} else {
+		update_tree(card, local_node, &changed);
+		if (changed)
+			card->irm_retries = 0;
+	}
+
+	/* If we're not the root node, we may have to do some IRM work. */
+	if (card->local_node != card->root_node)
+		schedule_work(&card->work);
+
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
+EXPORT_SYMBOL(fw_core_handle_bus_reset);
+
+void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
+{
+}
diff --git a/drivers/fw/fw-topology.h b/drivers/fw/fw-topology.h
new file mode 100644
index 0000000..219f50e
--- /dev/null
+++ b/drivers/fw/fw-topology.h
@@ -0,0 +1,131 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-topology.h -- Incremental bus scan, based on bus topology
+ *
+ * Copyright (C) 2003 Kristian Hoegsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __fw_topology_h
+#define __fw_topology_h
+
+struct fw_phy_packet {
+	union {
+		struct {
+			u32 reserved : 24;
+			u32 phy_id : 6;
+			u32 identifier : 2;
+		} link_on;
+
+		struct {
+			u32 reserved : 16;
+			u32 gap_count : 6;
+			u32 t : 1;
+			u32 r : 1;
+			u32 root_id : 6;
+			u32 identifier : 2;
+		} phy_config;
+
+		struct {
+			u32 more_packets : 1;
+			u32 initiated_reset : 1;
+			u32 ports : 6;
+			u32 power : 3;
+			u32 contender : 1;
+			u32 delay : 2;
+			u32 phy_speed : 2;
+			u32 gap_count : 6;
+			u32 link_on : 1;
+			u32 extended : 1;
+			u32 phy_id : 6;
+			u32 packet_type : 2;
+		} self_id;
+
+		struct {
+			u32 more_packets : 1;
+			u32 reserved0 : 1;
+			u32 ports : 16;
+			u32 reserved1 : 2;
+			u32 sequence : 3;
+			u32 extended : 1;
+			u32 phy_id : 6;
+			u32 packet_type : 2;
+		} extended_self_id;
+
+		u32 quadlet;
+	};
+};
+
+enum {
+	FW_NODE_CREATED =   0x00,
+	FW_NODE_UPDATED =   0x01,
+	FW_NODE_DESTROYED = 0x02,
+	FW_NODE_LINK_ON =   0x03,
+	FW_NODE_LINK_OFF =  0x04
+};
+
+struct fw_port {
+	struct fw_node *node;
+	unsigned speed : 3; /* S100, S200, ... S3200 */
+};
+
+struct fw_node {
+	u16 node_id;
+        u8 color;
+	u8 port_count;
+	unsigned link_on : 1;
+	unsigned initiated_reset : 1;
+	unsigned b_path : 1;
+	u8 phy_speed; /* As in the self ID packet. */
+	u8 max_speed; /* Minimum of all phy-speeds and port speeds on
+		       * the path from the local node to this node. */
+
+	atomic_t ref_count;
+
+        /* For serializing node topology into a list. */
+	struct list_head link;
+
+	/* Upper layer specific data. */
+	void *data;
+
+        struct fw_port ports[0];
+};
+
+extern inline struct fw_node *
+fw_node(struct list_head *l)
+{
+        return list_entry (l, struct fw_node, link);
+}
+
+extern inline struct fw_node *
+fw_node_get(struct fw_node *node)
+{
+	atomic_inc(&node->ref_count);
+
+	return node;
+}
+
+extern inline void
+fw_node_put(struct fw_node *node)
+{
+	if (atomic_dec_and_test(&node->ref_count))
+		kfree(node);
+}
+
+void
+fw_destroy_nodes(struct fw_card *card);
+
+#endif
diff --git a/drivers/fw/fw-transaction.c b/drivers/fw/fw-transaction.c
new file mode 100644
index 0000000..a42e985
--- /dev/null
+++ b/drivers/fw/fw-transaction.c
@@ -0,0 +1,856 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-transaction.c - core IEEE1394 transaction logic
+ *
+ * Copyright (C) 2004 Kristian Høgsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/poll.h>
+#include <linux/list.h>
+#include <linux/kthread.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+
+#include "fw-transaction.h"
+#include "fw-topology.h"
+#include "fw-device.h"
+
+struct fw_packet_header {
+	union {
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int offset_high:16;
+			unsigned int source:16;
+			unsigned long offset_low;
+		} request;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int reserved0:12;
+			unsigned int rcode:4;
+			unsigned int source:16;
+			unsigned long reserved1;
+		} response;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int offset_high:16;
+			unsigned int source:16;
+			unsigned long offset_low;
+		} read_quadlet_request;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int reserved0:12;
+			unsigned int rcode:4;
+			unsigned int source:16;
+			unsigned long reserved1;
+			unsigned long data;
+		} read_quadlet_response;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int offset_high:16;
+			unsigned int source:16;
+			unsigned long offset_low;
+			unsigned int extended_tcode:16;
+			unsigned int data_length:16;
+		} read_block_request;
+
+		/* This response packet format is the same for block
+		 * read responses and lock responses.  Furthermore, we
+		 * define a field called block_response, for the
+		 * situations where we want to treat responses with
+		 * block payload generically. */
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int reserved0:12;
+			unsigned int rcode:4;
+			unsigned int source:16;
+			unsigned long reserved1;
+			unsigned int extended_tcode:16;
+			unsigned int data_length:16;
+			u32 data[0];
+		} read_block_response, lock_response, block_response;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int offset_high:16;
+			unsigned int source:16;
+			u32 offset_low;
+			u32 data;
+		} write_quadlet_request;
+
+		/* This response packet format is the same for block
+		 * write requests and lock requests.  Furthermore, we
+		 * define a field called block_request, for the
+		 * situations where we want to treat requests with
+		 * block payload generically. */
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int offset_high:16;
+			unsigned int source:16;
+			unsigned int offset_low:32;
+			unsigned int extended_tcode:16;
+			unsigned int data_length:16;
+			u32 data[0];
+		} write_block_request, lock_request, block_request;
+
+		struct {
+			unsigned int priority:4;
+			unsigned int tcode:4;
+			unsigned int rt:2;
+			unsigned int tlabel:6;
+			unsigned int destination:16;
+			unsigned int reserved0:12;
+			unsigned int rcode:4;
+			unsigned int source:16;
+			unsigned long reserved1;
+		} write_response;
+	};
+};
+
+static void
+close_transaction(struct fw_transaction *t, struct fw_card *card, int rcode,
+		  u32 * payload, size_t length)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	card->tlabel_mask &= ~(1 << t->tlabel);
+	list_del(&t->link);
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	t->callback(card, rcode, payload, length, t->callback_data);
+}
+
+static struct fw_transaction *lookup_transaction(struct fw_card *card,
+						 int source, int tlabel)
+{
+	struct fw_transaction *t, *result;
+	unsigned long flags;
+
+	result = NULL;
+	spin_lock_irqsave(&card->lock, flags);
+	list_for_each_entry(t, &card->transaction_list, link) {
+		if (t->node_id == source && t->tlabel == tlabel) {
+			result = t;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	return result;
+}
+
+static void
+transmit_complete_callback(struct fw_packet *packet,
+			   struct fw_card *card, int status)
+{
+	struct fw_transaction *t =
+	    container_of(packet, struct fw_transaction, packet);
+
+	switch (status) {
+	case ACK_COMPLETE:
+		close_transaction(t, card, RCODE_COMPLETE, NULL, 0);
+		break;
+	case ACK_PENDING:
+		t->timestamp = packet->timestamp;
+		break;
+	case ACK_BUSY_X:
+	case ACK_BUSY_A:
+	case ACK_BUSY_B:
+		close_transaction(t, card, RCODE_BUSY, NULL, 0);
+		break;
+	case ACK_DATA_ERROR:
+	case ACK_TYPE_ERROR:
+		close_transaction(t, card, RCODE_SEND_ERROR, NULL, 0);
+		break;
+	default:
+		/* FIXME: In this case, status is a negative errno,
+		 * corresponding to an OHCI specific transmit error
+		 * code.  We should map that to an RCODE instead of
+		 * just the generic RCODE_SEND_ERROR. */
+		close_transaction(t, card, RCODE_SEND_ERROR, NULL, 0);
+		break;
+	}
+}
+
+void
+fw_fill_packet(struct fw_packet *packet, int tcode, int tlabel,
+	       int node_id, int generation, int speed,
+	       unsigned long long offset, u32 * payload, size_t length)
+{
+	int ext_tcode;
+	struct fw_packet_header *header;
+
+	if (tcode > 0x10) {
+		ext_tcode = tcode - 0x10;
+		tcode = TCODE_LOCK_REQUEST;
+	} else
+		ext_tcode = 0;
+
+	header = (struct fw_packet_header *)packet->header;
+	header->request.priority = 0;
+	header->request.rt = RETRY_X;
+	header->request.tlabel = tlabel;
+	header->request.tcode = tcode;
+	header->request.destination = node_id | LOCAL_BUS;
+	header->request.offset_high = offset >> 32;
+	header->request.source = 0;	/* Inserted by OHCI controller */
+	header->request.offset_low = offset;
+
+	switch (tcode) {
+	case TCODE_WRITE_QUADLET_REQUEST:
+		header->write_quadlet_request.data = payload[0];
+		packet->header_length = sizeof header->write_quadlet_request;
+		packet->payload_length = 0;
+		break;
+
+	case TCODE_LOCK_REQUEST:
+	case TCODE_WRITE_BLOCK_REQUEST:
+		header->block_request.data_length = length;
+		header->block_request.extended_tcode = ext_tcode;
+		packet->header_length = sizeof header->block_request;
+		packet->payload = payload;
+		packet->payload_length = length;
+		break;
+
+	case TCODE_READ_QUADLET_REQUEST:
+		packet->header_length = sizeof header->read_quadlet_request;
+		packet->payload_length = 0;
+		break;
+
+	case TCODE_READ_BLOCK_REQUEST:
+		header->read_block_request.data_length = length;
+		header->read_block_request.extended_tcode = 0;
+		packet->header_length = sizeof header->read_block_request;
+		packet->payload_length = 0;
+		break;
+	}
+
+	packet->speed = speed;
+	packet->generation = generation;
+}
+
+/**
+ * This function provides low-level access to the IEEE1394 transaction
+ * logic.  Most C programs would use either fw_read(), fw_write() or
+ * fw_lock() instead - those function are convenience wrappers for
+ * this function.  The fw_send_request() function is primarily
+ * provided as a flexible, one-stop entry point for languages bindings
+ * and protocol bindings.
+ *
+ * FIXME: Document this function further, in particular the possible
+ * values for rcode in the callback.  In short, we map ACK_COMPLETE to
+ * RCODE_COMPLETE, internal errors set errno and set rcode to
+ * RCODE_SEND_ERROR (which is out of range for standard ieee1394
+ * rcodes).  All other rcodes are forwarded unchanged.  For all
+ * errors, payload is NULL, length is 0.
+ *
+ * Can not expect the callback to be called before the function
+ * returns, though this does happen in some cases (ACK_COMPLETE and
+ * errors).
+ *
+ * The payload is only used for write requests and must not be freed
+ * until the callback has been called.
+ *
+ * @param card the card from which to send the request
+ * @param tcode the tcode for this transaction.  Do not use
+ *   TCODE_LOCK_REQUEST directly, insted use TCODE_LOCK_MASK_SWAP
+ *   etc. to specify tcode and ext_tcode.
+ * @param node_id the node_id of the destination node
+ * @param generation the generation for which node_id is valid
+ * @param speed the speed to use for sending the request
+ * @param offset the 48 bit offset on the destination node
+ * @param payload the data payload for the request subaction
+ * @param length the length in bytes of the data to read
+ * @param callback function to be called when the transaction is completed
+ * @param callback_data pointer to arbitrary data, which will be
+ *   passed to the callback
+ */
+void
+fw_send_request(struct fw_card *card, struct fw_transaction *t,
+		int tcode, int node_id, int generation, int speed,
+		unsigned long long offset,
+		u32 * payload, size_t length,
+		fw_transaction_callback_t callback, void *callback_data)
+{
+	unsigned long flags;
+	int tlabel;
+
+	/* Allocate tlabel from the bitmap and put the transaction on
+	 * the list while holding the card spinlock. */
+
+	spin_lock_irqsave(&card->lock, flags);
+
+	tlabel = card->current_tlabel;
+	if (card->tlabel_mask & (1 << tlabel)) {
+		spin_unlock_irqrestore(&card->lock, flags);
+		callback(card, RCODE_SEND_ERROR, NULL, 0, callback_data);
+		return;
+	}
+
+	card->current_tlabel = (card->current_tlabel + 1) & 0x1f;
+	card->tlabel_mask |= (1 << tlabel);
+
+	list_add_tail(&t->link, &card->transaction_list);
+
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	/* Initialize rest of transaction, fill out packet and send it. */
+	t->node_id = node_id;
+	t->tlabel = tlabel;
+	t->callback = callback;
+	t->callback_data = callback_data;
+
+	fw_fill_packet(&t->packet, tcode, t->tlabel,
+		       node_id, generation, speed, offset, payload, length);
+	t->packet.callback = transmit_complete_callback;
+
+	card->driver->send_request(card, &t->packet);
+}
+
+EXPORT_SYMBOL(fw_send_request);
+
+static void
+transmit_phy_packet_callback(struct fw_packet *packet,
+			     struct fw_card *card, int status)
+{
+	kfree(packet);
+}
+
+static void send_phy_packet(struct fw_card *card, u32 data, int generation)
+{
+	struct fw_packet *packet;
+
+	packet = kzalloc(sizeof *packet, GFP_ATOMIC);
+	if (packet == NULL)
+		return;
+
+	packet->header[0] = data;
+	packet->header[1] = ~data;
+	packet->header_length = 8;
+	packet->payload_length = 0;
+	packet->speed = SCODE_100;
+	packet->generation = generation;
+	packet->callback = transmit_phy_packet_callback;
+
+	card->driver->send_request(card, packet);
+}
+
+void fw_send_force_root(struct fw_card *card, int node_id, int generation)
+{
+	struct fw_phy_packet p;
+
+	p.quadlet = 0;
+	p.phy_config.identifier = PHY_PACKET_CONFIG;
+	p.phy_config.root_id = node_id;
+	p.phy_config.r = 1;
+	send_phy_packet(card, p.quadlet, generation);
+}
+
+void flush_transactions(struct fw_card *card, u32 timestamp)
+{
+	struct fw_transaction *t, *next;
+	LIST_HEAD(list);
+	unsigned long flags;
+
+	/* To avoid serving the transaction complete callback under
+	 * the card lock, we first grab the card lock and filter out
+	 * expired transactions into a local list.  Then we just
+	 * iterate through the local list and close those
+	 * transactions. */
+	spin_lock_irqsave(&card->lock, flags);
+	list_for_each_entry_safe(t, next, &card->transaction_list, link) {
+		if (t->timestamp + 800 < timestamp ||
+		    (timestamp < t->timestamp &&
+		     t->timestamp + 800 < timestamp + 0x10000)) {
+			list_move_tail(&t->link, &list);
+		}
+	}
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	list_for_each_entry_safe(t, next, &list, link)
+	    close_transaction(t, card, RCODE_CANCELLED, NULL, 0);
+}
+
+static struct fw_address_handler *lookup_overlapping_address_handler(struct
+								     list_head
+								     *list,
+								     unsigned
+								     long long
+								     offset,
+								     size_t
+								     length)
+{
+	struct fw_address_handler *handler;
+
+	list_for_each_entry(handler, list, link) {
+		if (handler->offset < offset + length &&
+		    offset < handler->offset + handler->length)
+			return handler;
+	}
+
+	return NULL;
+}
+
+static struct fw_address_handler *lookup_enclosing_address_handler(struct
+								   list_head
+								   *list,
+								   unsigned long
+								   long offset,
+								   size_t
+								   length)
+{
+	struct fw_address_handler *handler;
+
+	list_for_each_entry(handler, list, link) {
+		if (handler->offset <= offset &&
+		    offset + length <= handler->offset + handler->length)
+			return handler;
+	}
+
+	return NULL;
+}
+
+static DEFINE_SPINLOCK(address_handler_lock);
+static LIST_HEAD(address_handler_list);
+
+struct fw_address_region fw_low_memory_region =
+    { 0x000000000000ull, 0x000100000000ull };
+struct fw_address_region fw_high_memory_region =
+    { 0x000100000000ull, 0xffffe0000000ull };
+struct fw_address_region fw_private_region =
+    { 0xffffe0000000ull, 0xfffff0000000ull };
+struct fw_address_region fw_csr_region =
+    { 0xfffff0000000ULL, 0xfffff0000800ull };
+struct fw_address_region fw_unit_space_region =
+    { 0xfffff0000900ull, 0x1000000000000ull };
+
+EXPORT_SYMBOL(fw_low_memory_region);
+EXPORT_SYMBOL(fw_high_memory_region);
+EXPORT_SYMBOL(fw_private_region);
+EXPORT_SYMBOL(fw_csr_region);
+EXPORT_SYMBOL(fw_unit_space_region);
+
+/**
+ * Allocate a range of addresses in the node space of the OHCI
+ * controller.  When a request is received that falls within the
+ * specified address range, the specified callback is invoked.  The
+ * parameters passed to the callback give the details of the
+ * particular request
+ */
+
+int
+fw_core_add_address_handler(struct fw_address_handler *handler,
+			    struct fw_address_region *region)
+{
+	struct fw_address_handler *other;
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	spin_lock_irqsave(&address_handler_lock, flags);
+
+	handler->offset = region->start;
+	while (handler->offset + handler->length <= region->end) {
+		other =
+		    lookup_overlapping_address_handler(&address_handler_list,
+						       handler->offset,
+						       handler->length);
+		if (other != NULL) {
+			handler->offset += other->length;
+		} else {
+			list_add_tail(&handler->link, &address_handler_list);
+			ret = 0;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&address_handler_lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(fw_core_add_address_handler);
+
+/**
+ * Deallocate a range of addresses allocated with fw_allocate.  This
+ * will call the associated callback one last time with a the special
+ * tcode TCODE_DEALLOCATE, to let the client destroy the registered
+ * callback data.  For convenience, the callback parameters offset and
+ * length are set to the start and the length respectively for the
+ * deallocated region, payload is set to NULL.
+ */
+
+void fw_core_remove_address_handler(struct fw_address_handler *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&address_handler_lock, flags);
+	list_del(&handler->link);
+	spin_unlock_irqrestore(&address_handler_lock, flags);
+}
+
+EXPORT_SYMBOL(fw_core_remove_address_handler);
+
+struct fw_request {
+	struct fw_packet response;
+	int ack;
+	u32 length;
+	u32 data[0];
+};
+
+static void
+free_response_callback(struct fw_packet *packet,
+		       struct fw_card *card, int status)
+{
+	struct fw_request *request;
+
+	request = container_of(packet, struct fw_request, response);
+	kfree(request);
+}
+
+static void
+fw_fill_response(struct fw_packet *response,
+		 struct fw_packet_header *request, u32 * data, size_t length)
+{
+	struct fw_packet_header *header;
+
+	header = (struct fw_packet_header *)response->header;
+	header->response.priority = 0;
+	header->response.rt = RETRY_1;
+	header->response.tlabel = request->request.tlabel;
+	header->response.destination = request->request.source;
+	header->response.source = request->request.destination;
+	header->response.reserved0 = 0;
+	header->response.reserved1 = 0;
+
+	switch (request->request.tcode) {
+	case TCODE_WRITE_QUADLET_REQUEST:
+	case TCODE_WRITE_BLOCK_REQUEST:
+		header->write_response.tcode = TCODE_WRITE_RESPONSE;
+		response->header_length = sizeof header->write_response;
+		response->payload_length = 0;
+		break;
+
+	case TCODE_READ_QUADLET_REQUEST:
+		header->read_quadlet_response.tcode =
+		    TCODE_READ_QUADLET_RESPONSE;
+		header->read_quadlet_response.data = 0;
+		response->header_length = sizeof header->read_quadlet_response;
+		response->payload_length = 0;
+		break;
+
+	case TCODE_READ_BLOCK_REQUEST:
+	case TCODE_LOCK_REQUEST:
+		header->block_response.tcode = request->request.tcode + 2;
+		header->block_response.data_length = length;
+		header->block_response.extended_tcode =
+		    request->block_request.extended_tcode;
+		response->header_length = sizeof header->block_response;
+		response->payload = data;
+		response->payload_length = length;
+		break;
+
+	default:
+		BUG();
+		return;
+	}
+}
+
+static struct fw_request *allocate_request(struct fw_packet_header *header,
+					   int ack, int speed, int timestamp,
+					   int generation)
+{
+	struct fw_request *request;
+	u32 *data, length;
+
+	switch (header->request.tcode) {
+	case TCODE_WRITE_QUADLET_REQUEST:
+		data = &header->write_quadlet_request.data;
+		length = 4;
+		break;
+
+	case TCODE_WRITE_BLOCK_REQUEST:
+		data = header->write_block_request.data;
+		length = header->write_block_request.data_length;
+		break;
+
+	case TCODE_READ_QUADLET_REQUEST:
+		data = NULL;
+		length = 4;
+		break;
+
+	case TCODE_READ_BLOCK_REQUEST:
+		data = NULL;
+		length = header->read_block_request.data_length;
+		break;
+
+	case TCODE_LOCK_REQUEST:
+		data = header->lock_response.data;
+		length = header->lock_request.data_length;
+		break;
+
+	default:
+		BUG();
+		return NULL;
+	}
+
+	request = kmalloc(sizeof *request + length, GFP_ATOMIC);
+	if (request == NULL)
+		return NULL;
+
+	request->response.speed = speed;
+	request->response.timestamp = timestamp;
+	request->response.generation = generation;
+	request->response.callback = free_response_callback;
+	request->ack = ack;
+	request->length = length;
+	if (data)
+		memcpy(request->data, data, length);
+
+	fw_fill_response(&request->response, header, request->data, length);
+
+	return request;
+}
+
+void
+fw_send_response(struct fw_card *card, struct fw_request *request, int rcode)
+{
+	struct fw_packet_header *header;
+
+	/* Broadcast packets are reported as ACK_COMPLETE, so this
+	 * check is sufficient to ensure we don't send response to
+	 * broadcast packets or posted writes. */
+	if (request->ack != ACK_PENDING)
+		return;
+
+	header = (struct fw_packet_header *)request->response.header;
+
+	header->response.rcode = rcode;
+	if (rcode != RCODE_COMPLETE)
+		request->response.payload_length = 0;
+	else if (header->response.tcode == TCODE_READ_QUADLET_RESPONSE)
+		header->read_quadlet_response.data = request->data[0];
+
+	card->driver->send_response(card, &request->response);
+}
+
+EXPORT_SYMBOL(fw_send_response);
+
+void
+fw_core_handle_request(struct fw_card *card,
+		       int speed, int ack, int timestamp,
+		       int generation, u32 length, u32 * payload)
+{
+	struct fw_address_handler *handler;
+	struct fw_packet_header *header;
+	struct fw_request *request;
+	unsigned long long offset;
+	unsigned long flags;
+	int t;
+
+	if (length > 2048) {
+		/* FIXME: send error response. */
+		return;
+	}
+
+	header = (struct fw_packet_header *)payload;
+
+	if (ack != ACK_PENDING && ack != ACK_COMPLETE)
+		return;
+
+	t = (timestamp & 0x1fff) + 4000;
+	if (t >= 8000)
+		t = (timestamp & ~0x1fff) + 0x2000 + t - 8000;
+	else
+		t = (timestamp & ~0x1fff) + t;
+
+	request = allocate_request(header, ack, speed, t, generation);
+	if (request == NULL) {
+		/* FIXME: send statically allocated busy packet. */
+		return;
+	}
+
+	offset = ((unsigned long long)header->request.offset_high << 32) |
+	    header->request.offset_low;
+
+	spin_lock_irqsave(&address_handler_lock, flags);
+	handler = lookup_enclosing_address_handler(&address_handler_list,
+						   offset, request->length);
+	spin_unlock_irqrestore(&address_handler_lock, flags);
+
+	/* FIXME: lookup the fw_node corresponding to the sender of
+	 * this request and pass that to the address handler instead
+	 * of the node ID.  We may also want to move the address
+	 * allocations to fw_node so we only do this callback if the
+	 * upper layers registered it for this node. */
+
+	if (handler == NULL)
+		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
+	else
+		handler->address_callback(card, request,
+					  header->request.tcode,
+					  header->request.destination,
+					  header->request.source,
+					  generation, speed, offset,
+					  request->data, request->length,
+					  handler->callback_data);
+}
+
+EXPORT_SYMBOL(fw_core_handle_request);
+
+void
+fw_core_handle_response(struct fw_card *card,
+			int speed, int ack, int timestamp,
+			u32 length, u32 * response)
+{
+	struct fw_transaction *t;
+	struct fw_packet_header *packet;
+	u32 *data;
+	size_t data_length;
+
+	packet = (struct fw_packet_header *)response;
+	t = lookup_transaction(card,
+			       packet->response.source,
+			       packet->response.tlabel);
+	if (t == NULL) {
+		fw_notify("Unsolicited response\n");
+		return;
+	}
+
+	/* FIXME: sanity check packet, is length correct, does tcodes
+	 * and addresses match. */
+
+	switch (packet->response.tcode) {
+	case TCODE_READ_QUADLET_RESPONSE:
+		data = (u32 *) & packet->read_quadlet_response.data;
+		data_length = 4;
+		break;
+
+	case TCODE_WRITE_RESPONSE:
+		data = NULL;
+		data_length = 0;
+		break;
+
+	case TCODE_READ_BLOCK_RESPONSE:
+	case TCODE_LOCK_RESPONSE:
+		data = packet->block_response.data;
+		data_length = packet->block_response.data_length;
+		break;
+
+	default:
+		/* Should never happen, this is just to shut up gcc. */
+		data = NULL;
+		data_length = 0;
+		break;
+	}
+
+	close_transaction(t, card, packet->response.rcode, data, data_length);
+}
+
+EXPORT_SYMBOL(fw_core_handle_response);
+
+MODULE_AUTHOR("Kristian Høgsberg <krh@bitplanet.net>");
+MODULE_DESCRIPTION("Core IEEE1394 transaction logic");
+MODULE_LICENSE("GPL");
+
+static u32 vendor_textual_descriptor_data[] = {
+	/* textual descriptor leaf () */
+	0x00080000,
+	0x00000000,
+	0x00000000,
+	0x4c696e75,		/* L i n u */
+	0x78204669,		/* x   F i */
+	0x72657769,		/* r e w i */
+	0x72652028,		/* r e   ( */
+	0x4a554a55,		/* J U J U */
+	0x29000000,		/* )       */
+};
+
+static struct fw_descriptor vendor_textual_descriptor = {
+	.length = ARRAY_SIZE(vendor_textual_descriptor_data),
+	.key = 0x81000000,
+	.data = vendor_textual_descriptor_data
+};
+
+static int __init fw_core_init(void)
+{
+	int retval;
+
+	retval = bus_register(&fw_bus_type);
+	if (retval < 0) {
+		fw_error("failed to register fw bus");
+		return retval;
+	}
+
+	/* Add the vendor textual descriptor. */
+	fw_core_add_descriptor(&vendor_textual_descriptor);
+
+	fw_notify("Loaded fw-core driver.\n");
+
+	return 0;
+}
+
+static void __exit fw_core_cleanup(void)
+{
+	bus_unregister(&fw_bus_type);
+
+	fw_notify("Unloaded fw-core driver.\n");
+}
+
+module_init(fw_core_init);
+module_exit(fw_core_cleanup);
diff --git a/drivers/fw/fw-transaction.h b/drivers/fw/fw-transaction.h
new file mode 100644
index 0000000..17404e7
--- /dev/null
+++ b/drivers/fw/fw-transaction.h
@@ -0,0 +1,415 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-transaction.h - Header for IEEE1394 transaction logic
+ *
+ * Copyright (C) 2003 Kristian Høgsberg <krh@bitplanet.net>
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
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __fw_core_h
+#define __fw_core_h
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/fs.h>
+
+#define TCODE_WRITE_QUADLET_REQUEST	0
+#define TCODE_WRITE_BLOCK_REQUEST	1
+#define TCODE_WRITE_RESPONSE		2
+#define TCODE_READ_QUADLET_REQUEST	4
+#define TCODE_READ_BLOCK_REQUEST	5
+#define TCODE_READ_QUADLET_RESPONSE	6
+#define TCODE_READ_BLOCK_RESPONSE	7
+#define TCODE_CYCLE_START		8
+#define TCODE_LOCK_REQUEST       	9
+#define TCODE_STREAM_DATA        	10
+#define TCODE_LOCK_RESPONSE      	11
+
+/* Juju specific tcodes */
+#define TCODE_DEALLOCATE		0x10
+#define TCODE_LOCK_MASK_SWAP		0x11
+#define TCODE_LOCK_COMPARE_SWAP		0x12
+#define TCODE_LOCK_FETCH_ADD		0x13
+#define TCODE_LOCK_LITTLE_ADD		0x14
+#define TCODE_LOCK_BOUNDED_ADD		0x15
+#define TCODE_LOCK_WRAP_ADD		0x16
+#define TCODE_LOCK_VENDOR_SPECIFIC	0x17
+
+#define TCODE_IS_WRITE_REQUEST(tcode)	( ((tcode) & ~1) == 0 )
+#define TCODE_IS_READ_REQUEST(tcode)	( ((tcode) & ~1) == 4 )
+
+#define SCODE_100			0x0
+#define SCODE_200			0x1
+#define SCODE_400			0x2
+#define SCODE_BETA			0x3
+
+#define EXTCODE_MASK_SWAP        0x1
+#define EXTCODE_COMPARE_SWAP     0x2
+#define EXTCODE_FETCH_ADD        0x3
+#define EXTCODE_LITTLE_ADD       0x4
+#define EXTCODE_BOUNDED_ADD      0x5
+#define EXTCODE_WRAP_ADD         0x6
+
+#define ACK_COMPLETE             0x1
+#define ACK_PENDING              0x2
+#define ACK_BUSY_X               0x4
+#define ACK_BUSY_A               0x5
+#define ACK_BUSY_B               0x6
+#define ACK_DATA_ERROR           0xd
+#define ACK_TYPE_ERROR           0xe
+
+#define RCODE_COMPLETE           0x0
+#define RCODE_CONFLICT_ERROR     0x4
+#define RCODE_DATA_ERROR         0x5
+#define RCODE_TYPE_ERROR         0x6
+#define RCODE_ADDRESS_ERROR      0x7
+
+/* Juju specific rcodes */
+#define RCODE_SEND_ERROR	0x10
+#define RCODE_CANCELLED		0x11
+#define RCODE_BUSY		0x12
+
+#define RETRY_1	0x00
+#define RETRY_X	0x01
+#define RETRY_A	0x02
+#define RETRY_B	0x03
+
+#define LOCAL_BUS 0xffc0
+
+#define SELFID_PORT_CHILD        0x3
+#define SELFID_PORT_PARENT       0x2
+#define SELFID_PORT_NCONN        0x1
+#define SELFID_PORT_NONE         0x0
+
+#define PHY_PACKET_CONFIG	0x0
+#define PHY_PACKET_LINK_ON	0x1
+#define PHY_PACKET_SELF_ID	0x2
+
+#define fw_notify(s, args...) printk(KERN_NOTICE KBUILD_MODNAME ": " s, ## args)
+#define fw_error(s, args...) printk(KERN_ERR KBUILD_MODNAME ": " s, ## args)
+#define fw_debug(s, args...) printk(KERN_DEBUG KBUILD_MODNAME ": " s, ## args)
+
+static inline void
+fw_memcpy_from_be32(void *_dst, void *_src, size_t size)
+{
+	u32 *dst = _dst;
+	u32 *src = _src;
+	int i;
+
+	for (i = 0; i < size / 4; i++)
+		dst[i] = cpu_to_be32(src[i]);
+}
+
+static inline void
+fw_memcpy_to_be32(void *_dst, void *_src, size_t size)
+{
+	fw_memcpy_from_be32(_dst, _src, size);
+}
+
+struct fw_card;
+struct fw_packet;
+struct fw_node;
+struct fw_request;
+
+struct fw_descriptor {
+	struct list_head link;
+	size_t length;
+	u32 key;
+	u32 *data;
+};
+
+int fw_core_add_descriptor (struct fw_descriptor *desc);
+void fw_core_remove_descriptor (struct fw_descriptor *desc);
+
+typedef void (*fw_packet_callback_t) (struct fw_packet *packet,
+				      struct fw_card *card, int status);
+
+typedef void (*fw_transaction_callback_t)(struct fw_card *card, int rcode,
+					  u32 *payload,
+					  size_t length,
+					  void *callback_data);
+
+typedef void (*fw_address_callback_t)(struct fw_card *card,
+				      struct fw_request *request,
+				      int tcode, int destination, int source,
+				      int generation, int speed,
+				      unsigned long long offset,
+				      u32 *payload, size_t length,
+				      void *callback_data);
+
+typedef void (*fw_bus_reset_callback_t)(struct fw_card *handle,
+					int node_id, int generation,
+					u32 *self_ids,
+					int self_id_count,
+					void *callback_data);
+
+struct fw_packet {
+        int speed;
+        int generation;
+        u32 header[4];
+        size_t header_length;
+        u32 *payload;
+        size_t payload_length;
+        u32 timestamp;
+
+        dma_addr_t payload_bus;
+
+        /* This callback is called when the packet transmission has
+         * completed; for successful transmission, the status code is
+         * the ack received from the destination, otherwise it's a
+         * negative errno: ENOMEM, ESTALE, ETIMEDOUT, ENODEV, EIO.
+         * The callback can be called from tasklet context and thus
+         * must never block.
+         */
+        fw_packet_callback_t callback;
+        struct list_head link;
+};
+
+struct fw_transaction {
+        int node_id; /* The generation is implied; it is always the current. */
+        int tlabel;
+        int timestamp;
+        struct list_head link;
+
+        struct fw_packet packet;
+
+	/* The data passed to the callback is valid only during the
+	 * callback.  */
+        fw_transaction_callback_t callback;
+        void *callback_data;
+};
+
+extern inline struct fw_packet *
+fw_packet(struct list_head *l)
+{
+        return list_entry (l, struct fw_packet, link);
+}
+
+struct fw_address_handler {
+        u64 offset;
+        size_t length;
+        fw_address_callback_t address_callback;
+        void *callback_data;
+        struct list_head link;
+};
+
+
+struct fw_address_region {
+	u64 start;
+	u64 end;
+};
+
+extern struct fw_address_region fw_low_memory_region;
+extern struct fw_address_region fw_high_memory_region;
+extern struct fw_address_region fw_private_region;
+extern struct fw_address_region fw_csr_region;
+extern struct fw_address_region fw_unit_space_region;
+
+int fw_core_add_address_handler(struct fw_address_handler *handler,
+				struct fw_address_region *region);
+void fw_core_remove_address_handler(struct fw_address_handler *handler);
+void fw_send_response(struct fw_card *card,
+		      struct fw_request *request, int rcode);
+
+extern struct bus_type fw_bus_type;
+
+struct fw_card {
+        struct fw_card_driver *driver;
+	struct device *device;
+
+        int node_id;
+        int generation;
+        /* This is the generation used for timestamping incoming requests. */
+        int request_generation;
+        int current_tlabel, tlabel_mask;
+        struct list_head transaction_list;
+        unsigned long long guid;
+	int max_receive;
+	int link_speed;
+	int config_rom_generation;
+
+        /* We need to store up to 4 self ID for a maximum of 63 devices. */
+        int self_id_count;
+        u32 self_ids[252];
+
+	spinlock_t lock; /* Take this lock when handling the lists in
+			  * this struct. */
+	struct fw_node *local_node;
+	struct fw_node *root_node;
+	struct fw_node *irm_node;
+	int color;
+
+	int index;
+
+	struct device card_device;
+
+	struct list_head link;
+
+	/* Work struct for IRM duties. */
+	struct work_struct work;
+	int irm_retries;
+};
+
+struct fw_card *fw_card_get(struct fw_card *card);
+void fw_card_put(struct fw_card *card);
+
+/* The iso packet format allows for an immediate header/payload part
+ * stored in 'header' immediately after the packet info plus an
+ * indirect payload part that is pointer to by the 'payload' field.
+ * Applications can use one or the other or both to implement simple
+ * low-bandwidth streaming (e.g. audio) or more advanced
+ * scatter-gather streaming (e.g. assembling video frame automatically). */
+
+struct fw_iso_packet {
+        u16 payload_length;	/* Length of indirect payload. */
+	u32 interrupt : 1;	/* Generate interrupt on this packet */
+	u32 skip : 1;		/* Set to not send packet at all. */
+	u32 tag : 2;
+	u32 sy : 4;
+	u32 header_length : 8;	/* Length of immediate header. */
+        u32 header[0];
+};
+
+#define FW_ISO_CONTEXT_TRANSMIT	0
+#define FW_ISO_CONTEXT_RECEIVE	1
+
+struct fw_iso_context;
+
+typedef void (*fw_iso_callback_t) (struct fw_iso_context *context,
+				   int status, u32 cycle, void *data);
+
+struct fw_iso_context {
+	struct fw_card *card;
+	int type;
+	int channel;
+	int speed;
+	fw_iso_callback_t callback;
+	void *callback_data;
+
+	void *buffer;
+	size_t buffer_size;
+	dma_addr_t *pages;
+	int page_count;
+};
+
+struct fw_iso_context *
+fw_iso_context_create(struct fw_card *card, int type,
+		      size_t buffer_size,
+		      fw_iso_callback_t callback,
+		      void *callback_data);
+
+void
+fw_iso_context_destroy(struct fw_iso_context *ctx);
+
+void
+fw_iso_context_start(struct fw_iso_context *ctx,
+		     int channel, int speed, int cycle);
+
+int
+fw_iso_context_queue(struct fw_iso_context *ctx,
+		     struct fw_iso_packet *packet, void *payload);
+
+int
+fw_iso_context_send(struct fw_iso_context *ctx,
+		    int channel, int speed, int cycle);
+
+struct fw_card_driver {
+        const char *name;
+
+        /* Enable the given card with the given initial config rom.
+         * This function is expected to activate the card, and either
+         * enable the PHY or set the link_on bit and initiate a bus
+         * reset. */
+        int (*enable) (struct fw_card *card, u32 *config_rom, size_t length);
+
+        int (*update_phy_reg) (struct fw_card *card, int address,
+                               int clear_bits, int set_bits);
+
+        /* Update the config rom for an enabled card.  This function
+         * should change the config rom that is presented on the bus
+         * an initiate a bus reset. */
+        int (*set_config_rom) (struct fw_card *card,
+			       u32 *config_rom, size_t length);
+
+        void (*send_request) (struct fw_card *card, struct fw_packet *packet);
+        void (*send_response) (struct fw_card *card, struct fw_packet *packet);
+
+	/* Allow the specified node ID to do direct DMA out and in of
+	 * host memory.  The card will disable this for all node when
+	 * a bus reset happens, so driver need to reenable this after
+	 * bus reset.  Returns 0 on success, -ENODEV if the card
+	 * doesn't support this, -ESTALE if the generation doesn't
+	 * match. */
+	int (*enable_phys_dma) (struct fw_card *card,
+				int node_id, int generation);
+
+	struct fw_iso_context *
+	(*allocate_iso_context)(struct fw_card *card, int type);
+	void (*free_iso_context)(struct fw_iso_context *ctx);
+
+	int (*send_iso)(struct fw_iso_context *ctx, s32 cycle);
+
+	int (*queue_iso)(struct fw_iso_context *ctx,
+			 struct fw_iso_packet *packet, void *payload);
+};
+
+int
+fw_core_initiate_bus_reset(struct fw_card *card, int short_reset);
+
+void
+fw_send_request(struct fw_card *card, struct fw_transaction *t,
+		int tcode, int node_id, int generation, int speed,
+		unsigned long long offset,
+		u32 *payload, size_t length,
+		fw_transaction_callback_t callback, void *callback_data);
+
+void
+fw_send_force_root(struct fw_card *card, int node_id, int generation);
+
+/* Called by the topology code to inform the device code of node
+ * activity; found, lost, or updated nodes */
+void
+fw_node_event(struct fw_card *card, struct fw_node *node, int event);
+
+/* API used by card level drivers */
+
+/* Do we need phy speed here also?  If we add more args, maybe we
+   should go back to struct fw_card_info. */
+int
+fw_core_add_card (struct fw_card *card, struct fw_card_driver *driver,
+		  struct device *device,
+		  u32 max_receive, u32 link_speed, u64 guid);
+
+void
+fw_core_remove_card(struct fw_card *card);
+
+void
+fw_core_handle_bus_reset(struct fw_card *card,
+			 int node_id, int generation,
+			 int self_id_count, u32 *self_ids);
+void
+fw_core_handle_request(struct fw_card *card,
+		       int speed, int ack, int timestamp,
+		       int generation,
+		       u32 length, u32 *payload);
+void
+fw_core_handle_response(struct fw_card *card,
+                        int speed, int ack, int timestamp,
+                        u32 length, u32 *payload);
+
+
+#endif /* __fw_core_h */
