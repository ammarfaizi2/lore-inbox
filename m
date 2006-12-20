Return-Path: <linux-kernel-owner+w=401wt.eu-S932774AbWLTA7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWLTA7L (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWLTA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:59:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774AbWLTA6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:58:44 -0500
Date: Tue, 19 Dec 2006 19:58:31 -0500
From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 2/4] Add device probing and sysfs integration.
Message-ID: <20061220005831.GD11746@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kristian Hoegsberg <krh@redhat.com>
---
 drivers/firewire/Makefile         |    3 
 drivers/firewire/fw-card.c        |   56 +++
 drivers/firewire/fw-device-cdev.c |  617 +++++++++++++++++++++++++++++++++++++
 drivers/firewire/fw-device-cdev.h |  146 +++++++++
 drivers/firewire/fw-device.c      |  613 +++++++++++++++++++++++++++++++++++++
 drivers/firewire/fw-device.h      |  127 ++++++++
 drivers/firewire/fw-iso.c         |    1 
 drivers/firewire/fw-topology.c    |   10 -
 drivers/firewire/fw-transaction.c |    5 
 drivers/firewire/fw-transaction.h |    4 
 10 files changed, 1573 insertions(+), 9 deletions(-)

diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index db7020d..da77bc0 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -2,6 +2,7 @@ #
 # Makefile for the Linux IEEE 1394 implementation
 #
 
-fw-core-objs := fw-card.o fw-topology.o fw-transaction.o fw-iso.o
+fw-core-objs := fw-card.o fw-topology.o fw-transaction.o fw-iso.o \
+	fw-device.o fw-device-cdev.o
 
 obj-$(CONFIG_FW) += fw-core.o
diff --git a/drivers/firewire/fw-card.c b/drivers/firewire/fw-card.c
index d8abd70..7977390 100644
--- a/drivers/firewire/fw-card.c
+++ b/drivers/firewire/fw-card.c
@@ -24,6 +24,7 @@ #include <linux/errno.h>
 #include <linux/device.h>
 #include "fw-transaction.h"
 #include "fw-topology.h"
+#include "fw-device.h"
 
 /* The lib/crc16.c implementation uses the standard (0x8005)
  * polynomial, but we need the ITU-T (or CCITT) polynomial (0x1021).
@@ -186,6 +187,59 @@ fw_core_remove_descriptor (struct fw_des
 EXPORT_SYMBOL(fw_core_remove_descriptor);
 
 static void
+fw_card_irm_work(struct work_struct *work)
+{
+	struct fw_card *card =
+		container_of(work, struct fw_card, work.work);
+	struct fw_device *root;
+	unsigned long flags;
+	int new_irm_id, generation;
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
+	generation = card->generation;
+	root = card->root_node->data;
+
+	if (root == NULL)
+		/* Either link_on is false, or we failed to read the
+		 * config rom.  In either case, pick another root. */
+		new_irm_id = card->local_node->node_id;
+	else if (root->state != FW_DEVICE_RUNNING)
+		/* If we haven't probed this device yet, bail out now
+		 * and let's try again once that's done. */
+		new_irm_id = -1;
+	else if (root->config_rom[2] & bib_cmc)
+		/* FIXME: I suppose we should set the cmstr bit in the
+		 * STATE_CLEAR register of this node, as described in
+		 * 1394-1995, 8.4.2.6.  Also, send out a force root
+		 * packet for this node. */
+		new_irm_id = -1;
+	else
+		/* Current root has an active link layer and we
+		 * successfully read the config rom, but it's not
+		 * cycle master capable. */
+		new_irm_id = card->local_node->node_id;
+
+	if (card->irm_retries++ > 5)
+		new_irm_id = -1;
+
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	if (new_irm_id > 0) {
+		fw_notify("Trying to become root (card %d)\n", card->index);
+		fw_send_force_root(card, new_irm_id, generation);
+		fw_core_initiate_bus_reset(card, 1);
+	}
+}
+
+static void
 release_card(struct device *device)
 {
 	struct fw_card *card =
@@ -222,6 +276,8 @@ fw_card_initialize(struct fw_card *card,
 
 	card->local_node = NULL;
 
+	INIT_DELAYED_WORK(&card->work, fw_card_irm_work);
+
 	card->card_device.bus     = &fw_bus_type;
 	card->card_device.release = release_card;
 	card->card_device.parent  = card->device;
diff --git a/drivers/firewire/fw-device-cdev.c b/drivers/firewire/fw-device-cdev.c
new file mode 100644
index 0000000..c10e332
--- /dev/null
+++ b/drivers/firewire/fw-device-cdev.c
@@ -0,0 +1,617 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-device-cdev.c - Char device for device raw access
+ *
+ * Copyright (C) 2005-2006  Kristian Hoegsberg <krh@bitplanet.net>
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
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/vmalloc.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/compat.h>
+#include <asm/uaccess.h>
+#include "fw-transaction.h"
+#include "fw-topology.h"
+#include "fw-device.h"
+#include "fw-device-cdev.h"
+
+/*
+ * todo
+ *
+ * - bus resets sends a new packet with new generation and node id
+ *
+ */
+
+/* dequeue_event() just kfree()'s the event, so the event has to be
+ * the first field in the struct. */
+
+struct event {
+	struct { void *data; size_t size; } v[2];
+	struct list_head link;
+};
+
+struct response {
+	struct event event;
+	struct fw_transaction transaction;
+	struct client *client;
+	struct fw_cdev_event_response response;
+};
+
+struct iso_interrupt {
+	struct event event;
+	struct fw_cdev_event_iso_interrupt interrupt;
+};
+
+struct client {
+	struct fw_device *device;
+	spinlock_t lock;
+	struct list_head handler_list;
+	struct list_head request_list;
+	u32 request_serial;
+	struct list_head event_list;
+	struct semaphore event_list_sem;
+	wait_queue_head_t wait;
+	unsigned long vm_start;
+	struct fw_iso_context *iso_context;
+};
+
+static inline void __user *
+u64_to_uptr(__u64 value)
+{
+	return (void __user *)(unsigned long)value;
+}
+
+static inline __u64
+uptr_to_u64(void __user *ptr)
+{
+	return (__u64)(unsigned long)ptr;
+}
+
+static int fw_device_op_open(struct inode *inode, struct file *file)
+{
+	struct fw_device *device;
+	struct client *client;
+
+	device = container_of(inode->i_cdev, struct fw_device, cdev);
+
+	client = kzalloc(sizeof *client, GFP_KERNEL);
+	if (client == NULL)
+		return -ENOMEM;
+
+	client->device = fw_device_get(device);
+	INIT_LIST_HEAD(&client->event_list);
+	sema_init(&client->event_list_sem, 0);
+	INIT_LIST_HEAD(&client->handler_list);
+	INIT_LIST_HEAD(&client->request_list);
+	spin_lock_init(&client->lock);
+	init_waitqueue_head(&client->wait);
+
+	file->private_data = client;
+
+	return 0;
+}
+
+static void queue_event(struct client *client, struct event *event,
+			void *data0, size_t size0, void *data1, size_t size1)
+{
+	unsigned long flags;
+
+	event->v[0].data = data0;
+	event->v[0].size = size0;
+	event->v[1].data = data1;
+	event->v[1].size = size1;
+
+	spin_lock_irqsave(&client->lock, flags);
+
+	list_add_tail(&event->link, &client->event_list);
+
+	up(&client->event_list_sem);
+	wake_up_interruptible(&client->wait);
+
+	spin_unlock_irqrestore(&client->lock, flags);
+}
+
+static int dequeue_event(struct client *client, char __user *buffer, size_t count)
+{
+	unsigned long flags;
+	struct event *event;
+	size_t size, total;
+	int i, retval = -EFAULT;
+
+	if (down_interruptible(&client->event_list_sem) < 0)
+		return -EINTR;
+
+	spin_lock_irqsave(&client->lock, flags);
+
+	event = container_of(client->event_list.next, struct event, link);
+	list_del(&event->link);
+
+	spin_unlock_irqrestore(&client->lock, flags);
+
+	if (buffer == NULL)
+		goto out;
+
+	total = 0;
+	for (i = 0; i < ARRAY_SIZE(event->v) && total < count; i++) {
+		size = min(event->v[i].size, count - total);
+		if (copy_to_user(buffer + total, event->v[i].data, size))
+			goto out;
+		total += size;
+	}
+	retval = total;
+
+ out:
+	kfree(event);
+
+	return retval;
+}
+
+static ssize_t
+fw_device_op_read(struct file *file,
+		  char __user *buffer, size_t count, loff_t *offset)
+{
+	struct client *client = file->private_data;
+
+	return dequeue_event(client, buffer, count);
+}
+
+static int ioctl_config_rom(struct client *client, void __user *arg)
+{
+	struct fw_cdev_get_config_rom rom;
+
+	rom.length = client->device->config_rom_length;
+	memcpy(rom.data, client->device->config_rom, rom.length * 4);
+	if (copy_to_user(arg, &rom,
+			 (char *)&rom.data[rom.length] - (char *)&rom))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void
+complete_transaction(struct fw_card *card, int rcode,
+		     void *payload, size_t length, void *data)
+{
+	struct response *response = data;
+	struct client *client = response->client;
+
+	if (length < response->response.length)
+		response->response.length = length;
+	if (rcode == RCODE_COMPLETE)
+		memcpy(response->response.data, payload,
+		       response->response.length);
+
+	response->response.type   = FW_CDEV_EVENT_RESPONSE;
+	response->response.rcode  = rcode;
+	queue_event(client, &response->event,
+		    &response->response, sizeof response->response,
+		    response->response.data, response->response.length);
+}
+
+static ssize_t ioctl_send_request(struct client *client, void __user *arg)
+{
+	struct fw_device *device = client->device;
+	struct fw_cdev_send_request request;
+	struct response *response;
+
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	/* What is the biggest size we'll accept, really? */
+	if (request.length > 4096)
+		return -EINVAL;
+
+	response = kmalloc(sizeof *response + request.length, GFP_KERNEL);
+	if (response == NULL)
+		return -ENOMEM;
+
+	response->client = client;
+	response->response.length = request.length;
+	response->response.closure = request.closure;
+
+	if (request.data &&
+	    copy_from_user(response->response.data,
+			   u64_to_uptr(request.data), request.length)) {
+		kfree(response);
+		return -EFAULT;
+	}
+
+	fw_send_request(device->card, &response->transaction,
+			request.tcode,
+			device->node->node_id | LOCAL_BUS,
+			device->card->generation,
+			device->node->max_speed,
+			request.offset,
+			response->response.data, request.length,
+			complete_transaction, response);
+
+	if (request.data)
+		return sizeof request + request.length;
+	else
+		return sizeof request;
+}
+
+struct address_handler {
+	struct fw_address_handler handler;
+	__u64 closure;
+	struct client *client;
+	struct list_head link;
+};
+
+struct request {
+	struct fw_request *request;
+	void *data;
+	size_t length;
+	u32 serial;
+	struct list_head link;
+};
+
+struct request_event {
+	struct event event;
+	struct fw_cdev_event_request request;
+};
+
+static void
+handle_request(struct fw_card *card, struct fw_request *r,
+	       int tcode, int destination, int source,
+	       int generation, int speed,
+	       unsigned long long offset,
+	       void *payload, size_t length, void *callback_data)
+{
+	struct address_handler *handler = callback_data;
+	struct request *request;
+	struct request_event *e;
+	unsigned long flags;
+	struct client *client = handler->client;
+
+	request = kmalloc(sizeof *request, GFP_ATOMIC);
+	e = kmalloc(sizeof *e, GFP_ATOMIC);
+	if (request == NULL || e == NULL) {
+		kfree(request);
+		kfree(e);
+		fw_send_response(card, r, RCODE_CONFLICT_ERROR);
+		return;
+	}
+
+	request->request = r;
+	request->data    = payload;
+	request->length  = length;
+
+	spin_lock_irqsave(&client->lock, flags);
+	request->serial = client->request_serial++;
+	list_add_tail(&request->link, &client->request_list);
+	spin_unlock_irqrestore(&client->lock, flags);
+
+	e->request.type    = FW_CDEV_EVENT_REQUEST;
+	e->request.tcode   = tcode;
+	e->request.offset  = offset;
+	e->request.length  = length;
+	e->request.serial  = request->serial;
+	e->request.closure = handler->closure;
+
+	queue_event(client, &e->event,
+		    &e->request, sizeof e->request, payload, length);
+}
+
+static int ioctl_allocate(struct client *client, void __user *arg)
+{
+	struct fw_cdev_allocate request;
+	struct address_handler *handler;
+	unsigned long flags;
+	struct fw_address_region region;
+
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	handler = kmalloc(sizeof *handler, GFP_KERNEL);
+	if (handler == NULL)
+		return -ENOMEM;
+
+	region.start = request.offset;
+	region.end = request.offset + request.length;
+	handler->handler.length = request.length;
+	handler->handler.address_callback = handle_request;
+	handler->handler.callback_data = handler;
+	handler->closure = request.closure;
+	handler->client = client;
+
+	if (fw_core_add_address_handler(&handler->handler, &region) < 0) {
+		kfree(handler);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&client->lock, flags);
+	list_add_tail(&handler->link, &client->handler_list);
+	spin_unlock_irqrestore(&client->lock, flags);
+
+	return 0;
+}
+
+static int ioctl_send_response(struct client *client, void __user *arg)
+{
+	struct fw_cdev_send_response request;
+	struct request *r;
+	unsigned long flags;
+
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	spin_lock_irqsave(&client->lock, flags);
+	list_for_each_entry(r, &client->request_list, link) {
+		if (r->serial == request.serial) {
+			list_del(&r->link);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&client->lock, flags);
+
+	if (&r->link == &client->request_list)
+		return -EINVAL;
+
+	if (request.length < r->length)
+		r->length = request.length;
+	if (copy_from_user(r->data, u64_to_uptr(request.data), r->length))
+		return -EFAULT;
+
+	fw_send_response(client->device->card, r->request, request.rcode);
+
+	kfree(r);
+
+	return 0;
+}
+
+static void
+iso_callback(struct fw_iso_context *context, int status, u32 cycle, void *data)
+{
+	struct client *client = data;
+	struct iso_interrupt *interrupt;
+
+	interrupt = kzalloc(sizeof *interrupt, GFP_ATOMIC);
+	if (interrupt == NULL)
+		return;
+
+	interrupt->interrupt.type      = FW_CDEV_EVENT_ISO_INTERRUPT;
+	interrupt->interrupt.closure   = 0;
+	interrupt->interrupt.cycle     = cycle;
+	queue_event(client, &interrupt->event,
+		    &interrupt->interrupt, sizeof interrupt->interrupt, NULL, 0);
+}
+
+static int ioctl_create_iso_context(struct client *client, void __user *arg)
+{
+	struct fw_cdev_create_iso_context request;
+
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	client->iso_context = fw_iso_context_create(client->device->card,
+						    FW_ISO_CONTEXT_TRANSMIT,
+						    request.buffer_size,
+						    iso_callback, client);
+	if (IS_ERR(client->iso_context))
+		return PTR_ERR(client->iso_context);
+
+	return 0;
+}
+
+static int ioctl_queue_iso(struct client *client, void __user *arg)
+{
+	struct fw_cdev_queue_iso request;
+	struct fw_cdev_iso_packet __user *p, *end, *next;
+	void *payload, *payload_end;
+	unsigned long index;
+	int count;
+	struct {
+		struct fw_iso_packet packet;
+		u8 header[256];
+	} u;
+
+	if (client->iso_context == NULL)
+		return -EINVAL;
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	/* If the user passes a non-NULL data pointer, has mmap()'ed
+	 * the iso buffer, and the pointer points inside the buffer,
+	 * we setup the payload pointers accordingly.  Otherwise we
+	 * set them both to NULL, which will still let packets with
+	 * payload_length == 0 through.  In other words, if no packets
+	 * use the indirect payload, the iso buffer need not be mapped
+	 * and the request.data pointer is ignored.*/
+
+	index = (unsigned long)request.data - client->vm_start;
+	if (request.data != 0 && client->vm_start != 0 &&
+	    index <= client->iso_context->buffer_size) {
+		payload = client->iso_context->buffer + index;
+		payload_end = client->iso_context->buffer +
+			client->iso_context->buffer_size;
+	} else {
+		payload = NULL;
+		payload_end = NULL;
+	}
+
+	if (!access_ok(VERIFY_READ, request.packets, request.size))
+		return -EFAULT;
+
+	p = (struct fw_cdev_iso_packet __user *)u64_to_uptr(request.packets);
+	end = (void __user *)p + request.size;
+	count = 0;
+	while (p < end) {
+		if (__copy_from_user(&u.packet, p, sizeof *p))
+			return -EFAULT;
+		next = (struct fw_cdev_iso_packet __user *)
+			&p->header[u.packet.header_length / 4];
+		if (next > end)
+			return -EINVAL;
+		if (__copy_from_user
+		    (u.packet.header, p->header, u.packet.header_length))
+			return -EFAULT;
+		if (u.packet.skip &&
+		    u.packet.header_length + u.packet.payload_length > 0)
+			return -EINVAL;
+		if (payload + u.packet.payload_length > payload_end)
+			return -EINVAL;
+
+		if (fw_iso_context_queue(client->iso_context,
+					 &u.packet, payload))
+			break;
+
+		p = next;
+		payload += u.packet.payload_length;
+		count++;
+	}
+
+	request.size    -= uptr_to_u64(p) - request.packets;
+	request.packets  = uptr_to_u64(p);
+	request.data     =
+		client->vm_start + (payload - client->iso_context->buffer);
+
+	if (copy_to_user(arg, &request, sizeof request))
+		return -EFAULT;
+
+	return count;
+}
+
+static int ioctl_send_iso(struct client *client, void __user *arg)
+{
+	struct fw_cdev_send_iso request;
+
+	if (copy_from_user(&request, arg, sizeof request))
+		return -EFAULT;
+
+	return fw_iso_context_send(client->iso_context, request.channel,
+				   request.speed, request.cycle);
+}
+
+static int
+dispatch_ioctl(struct client *client, unsigned int cmd, void __user *arg)
+{
+	switch (cmd) {
+	case FW_CDEV_IOC_GET_CONFIG_ROM:
+		return ioctl_config_rom(client, arg);
+	case FW_CDEV_IOC_SEND_REQUEST:
+		return ioctl_send_request(client, arg);
+	case FW_CDEV_IOC_ALLOCATE:
+		return ioctl_allocate(client, arg);
+	case FW_CDEV_IOC_SEND_RESPONSE:
+		return ioctl_send_response(client, arg);
+	case FW_CDEV_IOC_CREATE_ISO_CONTEXT:
+		return ioctl_create_iso_context(client, arg);
+	case FW_CDEV_IOC_QUEUE_ISO:
+		return ioctl_queue_iso(client, arg);
+	case FW_CDEV_IOC_SEND_ISO:
+		return ioctl_send_iso(client, arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static long
+fw_device_op_ioctl(struct file *file,
+		   unsigned int cmd, unsigned long arg)
+{
+	struct client *client = file->private_data;
+
+	return dispatch_ioctl(client, cmd, (void __user *) arg);
+}
+
+#ifdef CONFIG_COMPAT
+static long
+fw_device_op_compat_ioctl(struct file *file,
+			  unsigned int cmd, unsigned long arg)
+{
+	struct client *client = file->private_data;
+
+	return dispatch_ioctl(client, cmd, compat_ptr(arg));
+}
+#endif
+
+static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct client *client = file->private_data;
+
+	if (client->iso_context->buffer == NULL)
+		return -EINVAL;
+
+	client->vm_start = vma->vm_start;
+
+	return remap_vmalloc_range(vma, client->iso_context->buffer, 0);
+}
+
+static int fw_device_op_release(struct inode *inode, struct file *file)
+{
+	struct client *client = file->private_data;
+	struct address_handler *h, *next;
+	struct request *r, *next_r;
+
+	if (client->iso_context)
+		fw_iso_context_destroy(client->iso_context);
+
+	list_for_each_entry_safe(h, next, &client->handler_list, link) {
+		fw_core_remove_address_handler(&h->handler);
+		kfree(h);
+	}
+
+	list_for_each_entry_safe(r, next_r, &client->request_list, link) {
+		fw_send_response(client->device->card, r->request,
+				 RCODE_CONFLICT_ERROR);
+		kfree(r);
+	}
+
+	/* TODO: wait for all transactions to finish so
+	 * complete_transaction doesn't try to queue up responses
+	 * after we free client. */
+	while (!list_empty(&client->event_list))
+		dequeue_event(client, NULL, 0);
+
+	fw_device_put(client->device);
+	kfree(client);
+
+	return 0;
+}
+
+static unsigned int fw_device_op_poll(struct file *file, poll_table * pt)
+{
+	struct client *client = file->private_data;
+
+	poll_wait(file, &client->wait, pt);
+
+	if (!list_empty(&client->event_list))
+		return POLLIN | POLLRDNORM;
+	else
+		return 0;
+}
+
+struct file_operations fw_device_ops = {
+	.owner		= THIS_MODULE,
+	.open		= fw_device_op_open,
+	.read		= fw_device_op_read,
+	.unlocked_ioctl	= fw_device_op_ioctl,
+	.poll		= fw_device_op_poll,
+	.release	= fw_device_op_release,
+	.mmap		= fw_device_op_mmap,
+
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= fw_device_op_compat_ioctl
+#endif
+};
diff --git a/drivers/firewire/fw-device-cdev.h b/drivers/firewire/fw-device-cdev.h
new file mode 100644
index 0000000..18b20c2
--- /dev/null
+++ b/drivers/firewire/fw-device-cdev.h
@@ -0,0 +1,146 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-device-cdev.h -- Char device interface.
+ *
+ * Copyright (C) 2005-2006  Kristian Hoegsberg <krh@bitplanet.net>
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
+#ifndef __fw_cdev_h
+#define __fw_cdev_h
+
+#include <asm/ioctl.h>
+#include <asm/types.h>
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
+#define RCODE_COMPLETE			0x0
+#define RCODE_CONFLICT_ERROR     	0x4
+#define RCODE_DATA_ERROR         	0x5
+#define RCODE_TYPE_ERROR         	0x6
+#define RCODE_ADDRESS_ERROR      	0x7
+
+#define SCODE_100			0x0
+#define SCODE_200			0x1
+#define SCODE_400			0x2
+#define SCODE_800			0x3
+#define SCODE_1600			0x4
+#define SCODE_3200			0x5
+
+#define FW_CDEV_EVENT_RESPONSE		0x00
+#define FW_CDEV_EVENT_REQUEST		0x01
+#define FW_CDEV_EVENT_ISO_INTERRUPT	0x02
+
+/* The 'closure' fields are for user space to use.  Data passed in the
+ * 'closure' field for a request will be returned in the corresponding
+ * event.  It's a 64-bit type so that it's a fixed size type big
+ * enough to hold a pointer on all platforms. */
+
+struct fw_cdev_event_response {
+	__u32 type;
+	__u32 rcode;
+	__u64 closure;
+	__u32 length;
+	__u32 data[0];
+};
+
+struct fw_cdev_event_request {
+	__u32 type;
+	__u32 tcode;
+	__u64 offset;
+	__u64 closure;
+	__u32 serial;
+	__u32 length;
+	__u32 data[0];
+};
+
+struct fw_cdev_event_iso_interrupt {
+	__u32 type;
+	__u32 cycle;
+	__u64 closure;
+};
+
+#define FW_CDEV_IOC_GET_CONFIG_ROM	_IOR('#', 0x00, struct fw_cdev_get_config_rom)
+#define FW_CDEV_IOC_SEND_REQUEST	_IO('#', 0x01)
+#define FW_CDEV_IOC_ALLOCATE		_IO('#', 0x02)
+#define FW_CDEV_IOC_SEND_RESPONSE	_IO('#', 0x03)
+#define FW_CDEV_IOC_CREATE_ISO_CONTEXT	_IO('#', 0x04)
+#define FW_CDEV_IOC_QUEUE_ISO		_IO('#', 0x05)
+#define FW_CDEV_IOC_SEND_ISO		_IO('#', 0x06)
+
+struct fw_cdev_get_config_rom {
+	__u32 length;
+	__u32 data[256];
+};
+
+struct fw_cdev_send_request {
+	__u32 tcode;
+	__u32 length;
+	__u64 offset;
+	__u64 closure;
+	__u64 data;
+};
+
+struct fw_cdev_send_response {
+	__u32 rcode;
+	__u32 length;
+	__u64 data;
+	__u32 serial;
+};
+
+struct fw_cdev_allocate {
+	__u64 offset;
+	__u64 closure;
+	__u32 length;
+};
+
+struct fw_cdev_create_iso_context {
+	__u32 buffer_size;
+};
+
+struct fw_cdev_iso_packet {
+        __u16 payload_length;	/* Length of indirect payload. */
+	__u32 interrupt : 1;	/* Generate interrupt on this packet */
+	__u32 skip : 1;		/* Set to not send packet at all. */
+	__u32 tag : 2;
+	__u32 sy : 4;
+	__u32 header_length : 8;	/* Length of immediate header. */
+        __u32 header[0];
+};
+
+struct fw_cdev_queue_iso {
+	__u32 size;
+	__u64 packets;
+	__u64 data;
+};
+
+struct fw_cdev_send_iso {
+	__u32 channel;
+	__u32 speed;
+	__s32 cycle;
+};
+
+#endif
diff --git a/drivers/firewire/fw-device.c b/drivers/firewire/fw-device.c
new file mode 100644
index 0000000..ec1cb7f
--- /dev/null
+++ b/drivers/firewire/fw-device.c
@@ -0,0 +1,613 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-device.c - Device probing and sysfs code.
+ *
+ * Copyright (C) 2005-2006  Kristian Hoegsberg <krh@bitplanet.net>
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
+#include <linux/kthread.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include "fw-transaction.h"
+#include "fw-topology.h"
+#include "fw-device.h"
+
+void fw_csr_iterator_init(struct fw_csr_iterator *ci, u32 * p)
+{
+	ci->p = p + 1;
+	ci->end = ci->p + (p[0] >> 16);
+}
+
+EXPORT_SYMBOL(fw_csr_iterator_init);
+
+int fw_csr_iterator_next(struct fw_csr_iterator *ci, int *key, int *value)
+{
+	*key = *ci->p >> 24;
+	*value = *ci->p & 0xffffff;
+
+	return ci->p++ < ci->end;
+}
+
+EXPORT_SYMBOL(fw_csr_iterator_next);
+
+static int is_fw_unit(struct device *dev);
+
+static int match_unit_directory(u32 * directory, struct fw_device_id *id)
+{
+	struct fw_csr_iterator ci;
+	int key, value, match;
+
+	match = 0;
+	fw_csr_iterator_init(&ci, directory);
+	while (fw_csr_iterator_next(&ci, &key, &value)) {
+		if (key == CSR_VENDOR && value == id->vendor)
+			match |= FW_MATCH_VENDOR;
+		if (key == CSR_MODEL && value == id->model)
+			match |= FW_MATCH_MODEL;
+		if (key == CSR_SPECIFIER_ID && value == id->specifier_id)
+			match |= FW_MATCH_SPECIFIER_ID;
+		if (key == CSR_VERSION && value == id->version)
+			match |= FW_MATCH_VERSION;
+	}
+
+	return (match & id->match_flags) == id->match_flags;
+}
+
+static int fw_unit_match(struct device *dev, struct device_driver *drv)
+{
+	struct fw_unit *unit = fw_unit(dev);
+	struct fw_driver *driver = fw_driver(drv);
+	int i;
+
+	/* We only allow binding to fw_units. */
+	if (!is_fw_unit(dev))
+		return 0;
+
+	for (i = 0; driver->id_table[i].match_flags != 0; i++) {
+		if (match_unit_directory(unit->directory, &driver->id_table[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int get_modalias(struct fw_unit *unit, char *buffer, size_t buffer_size)
+{
+	struct fw_device *device = fw_device(unit->device.parent);
+	struct fw_csr_iterator ci;
+
+	int key, value;
+	int vendor = 0;
+	int model = 0;
+	int specifier_id = 0;
+	int version = 0;
+
+	fw_csr_iterator_init(&ci, &device->config_rom[5]);
+	while (fw_csr_iterator_next(&ci, &key, &value)) {
+		switch (key) {
+		case CSR_VENDOR:
+			vendor = value;
+			break;
+		case CSR_MODEL:
+			model = value;
+			break;
+		}
+	}
+
+	fw_csr_iterator_init(&ci, unit->directory);
+	while (fw_csr_iterator_next(&ci, &key, &value)) {
+		switch (key) {
+		case CSR_SPECIFIER_ID:
+			specifier_id = value;
+			break;
+		case CSR_VERSION:
+			version = value;
+			break;
+		}
+	}
+
+	return snprintf(buffer, buffer_size,
+			"ieee1394:ven%08Xmo%08Xsp%08Xver%08X",
+			vendor, model, specifier_id, version);
+}
+
+static int
+fw_unit_uevent(struct device *dev, char **envp, int num_envp,
+	       char *buffer, int buffer_size)
+{
+	struct fw_unit *unit = fw_unit(dev);
+	char modalias[64];
+	int length = 0;
+	int i = 0;
+
+	if (!is_fw_unit(dev))
+		goto out;
+
+	get_modalias(unit, modalias, sizeof modalias);
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=%s", modalias))
+		return -ENOMEM;
+
+      out:
+	envp[i] = NULL;
+
+	return 0;
+}
+
+struct bus_type fw_bus_type = {
+	.name = "fw",
+	.match = fw_unit_match,
+	.uevent = fw_unit_uevent
+};
+
+EXPORT_SYMBOL(fw_bus_type);
+
+extern struct fw_device *fw_device_get(struct fw_device *device)
+{
+	get_device(&device->device);
+
+	return device;
+}
+
+extern void fw_device_put(struct fw_device *device)
+{
+	put_device(&device->device);
+}
+
+static void fw_device_release(struct device *dev)
+{
+	struct fw_device *device = fw_device(dev);
+	unsigned long flags;
+
+	/* Take the card lock so we don't set this to NULL while a
+	 * FW_NODE_UPDATED callback is being handled. */
+	spin_lock_irqsave(&device->card->lock, flags);
+	device->node->data = NULL;
+	spin_unlock_irqrestore(&device->card->lock, flags);
+
+	fw_node_put(device->node);
+	fw_card_put(device->card);
+	kfree(device->config_rom);
+	kfree(device);
+}
+
+int fw_device_enable_phys_dma(struct fw_device *device)
+{
+	return device->card->driver->enable_phys_dma(device->card,
+						     device->node_id,
+						     device->generation);
+}
+
+EXPORT_SYMBOL(fw_device_enable_phys_dma);
+
+static ssize_t
+show_modalias_attribute(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct fw_unit *unit = fw_unit(dev);
+	int length;
+
+	length = get_modalias(unit, buf, PAGE_SIZE);
+	strcpy(buf + length, "\n");
+
+	return length + 1;
+}
+
+static struct device_attribute modalias_attribute = {
+	.attr = {.name = "modalias",.mode = S_IRUGO},
+	.show = show_modalias_attribute
+};
+
+static ssize_t
+show_config_rom_attribute(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct fw_device *device = fw_device(dev);
+
+	memcpy(buf, device->config_rom, device->config_rom_length * 4);
+
+	return device->config_rom_length * 4;
+}
+
+static struct device_attribute config_rom_attribute = {
+	.attr = {.name = "config_rom",.mode = S_IRUGO},
+	.show = show_config_rom_attribute,
+};
+
+struct read_quadlet_callback_data {
+	struct completion done;
+	int rcode;
+	u32 data;
+};
+
+static void
+complete_transaction(struct fw_card *card, int rcode,
+		     void *payload, size_t length, void *data)
+{
+	struct read_quadlet_callback_data *callback_data = data;
+
+	if (rcode == RCODE_COMPLETE)
+		callback_data->data = be32_to_cpu(*(__be32 *)payload);
+	callback_data->rcode = rcode;
+	complete(&callback_data->done);
+}
+
+static int read_rom(struct fw_device *device, int index, u32 * data)
+{
+	struct read_quadlet_callback_data callback_data;
+	struct fw_transaction t;
+	u64 offset;
+
+	init_completion(&callback_data.done);
+
+	offset = 0xfffff0000400ULL + index * 4;
+	fw_send_request(device->card, &t, TCODE_READ_QUADLET_REQUEST,
+			device->node_id | LOCAL_BUS,
+			device->generation, SCODE_100,
+			offset, NULL, 4, complete_transaction, &callback_data);
+
+	wait_for_completion(&callback_data.done);
+
+	*data = callback_data.data;
+
+	return callback_data.rcode;
+}
+
+static int read_bus_info_block(struct fw_device *device)
+{
+	static u32 rom[256];
+	u32 stack[16], sp, key;
+	int i, end, length;
+
+	/* First read the bus info block. */
+	for (i = 0; i < 5; i++) {
+		if (read_rom(device, i, &rom[i]) != RCODE_COMPLETE)
+			return -1;
+		/* As per IEEE1212 7.2, during power-up, devices can
+		 * reply with a 0 for the first quadlet of the config
+		 * rom to indicate that they are booting (for example,
+		 * if the firmware is on the disk of a external
+		 * harddisk).  In that case we just fail, and the
+		 * retry mechanism will try again later. */
+		if (i == 0 && rom[i] == 0)
+			return -1;
+	}
+
+	/* Now parse the config rom.  The config rom is a recursive
+	 * directory structure so we parse it using a stack of
+	 * references to the blocks that make up the structure.  We
+	 * push a reference to the root directory on the stack to
+	 * start things off. */
+	length = i;
+	sp = 0;
+	stack[sp++] = 0xc0000005;
+	while (sp > 0) {
+		/* Pop the next block reference of the stack.  The
+		 * lower 24 bits is the offset into the config rom,
+		 * the upper 8 bits are the type of the reference the
+		 * block. */
+		key = stack[--sp];
+		i = key & 0xffffff;
+		if (i >= ARRAY_SIZE(rom))
+			/* The reference points outside the standard
+			 * config rom area, something's fishy. */
+			return -1;
+
+		/* Read header quadlet for the block to get the length. */
+		if (read_rom(device, i, &rom[i]) != RCODE_COMPLETE)
+			return -1;
+		end = i + (rom[i] >> 16) + 1;
+		i++;
+		if (end > ARRAY_SIZE(rom))
+			/* This block extends outside standard config
+			 * area (and the array we're reading it
+			 * into).  That's broken, so ignore this
+			 * device. */
+			return -1;
+
+		/* Now read in the block.  If this is a directory
+		 * block, check the entries as we read them to see if
+		 * it references another block, and push it in that case. */
+		while (i < end) {
+			if (read_rom(device, i, &rom[i]) != RCODE_COMPLETE)
+				return -1;
+			if ((key >> 30) == 3 && (rom[i] >> 30) > 1 &&
+			    sp < ARRAY_SIZE(stack))
+				stack[sp++] = i + rom[i];
+			i++;
+		}
+		if (length < i)
+			length = i;
+	}
+
+	device->config_rom = kmalloc(length * 4, GFP_KERNEL);
+	if (device->config_rom == NULL)
+		return -1;
+	memcpy(device->config_rom, rom, length * 4);
+	device->config_rom_length = length;
+
+	return 0;
+}
+
+static void fw_unit_release(struct device *dev)
+{
+	struct fw_unit *unit = fw_unit(dev);
+
+	kfree(unit);
+}
+
+static int is_fw_unit(struct device *dev)
+{
+	return dev->release == fw_unit_release;
+}
+
+static void create_units(struct fw_device *device)
+{
+	struct fw_csr_iterator ci;
+	struct fw_unit *unit;
+	int key, value, i;
+
+	i = 0;
+	fw_csr_iterator_init(&ci, &device->config_rom[5]);
+	while (fw_csr_iterator_next(&ci, &key, &value)) {
+		if (key != (CSR_UNIT | CSR_DIRECTORY))
+			continue;
+
+		/* Get the address of the unit directory and try to
+		 * match the drivers id_tables against it. */
+		unit = kzalloc(sizeof *unit, GFP_KERNEL);
+		if (unit == NULL) {
+			fw_error("failed to allocate memory for unit\n");
+			continue;
+		}
+
+		unit->directory = ci.p + value - 1;
+		unit->device.bus = &fw_bus_type;
+		unit->device.release = fw_unit_release;
+		unit->device.parent = &device->device;
+		snprintf(unit->device.bus_id, sizeof unit->device.bus_id,
+			 "%s.%d", device->device.bus_id, i++);
+
+		if (device_register(&unit->device) < 0) {
+			kfree(unit);
+			continue;
+		}
+
+		if (device_create_file(&unit->device, &modalias_attribute) < 0) {
+			device_unregister(&unit->device);
+			kfree(unit);
+		}
+	}
+}
+
+static int shutdown_unit(struct device *device, void *data)
+{
+	struct fw_unit *unit = fw_unit(device);
+
+	if (is_fw_unit(device)) {
+		device_remove_file(&unit->device, &modalias_attribute);
+		device_unregister(&unit->device);
+	}
+
+	return 0;
+}
+
+static void fw_device_shutdown(struct work_struct *work)
+{
+	struct fw_device *device =
+		container_of(work, struct fw_device, work.work);
+
+	device_remove_file(&device->device, &config_rom_attribute);
+	cdev_del(&device->cdev);
+	unregister_chrdev_region(device->device.devt, 1);
+	device_for_each_child(&device->device, NULL, shutdown_unit);
+	device_unregister(&device->device);
+}
+
+/* These defines control the retry behavior for reading the config
+ * rom.  It shouldn't be necessary to tweak these; if the device
+ * doesn't respond to a config rom read within 10 seconds, it's not
+ * going to respond at all.  As for the initial delay, a lot of
+ * devices will be able to respond within half a second after bus
+ * reset.  On the other hand, it's not really worth being more
+ * aggressive than that, since it scales pretty well; if 10 devices
+ * are plugged in, they're all getting read within one second. */
+
+#define MAX_RETRIES	5
+#define RETRY_DELAY	(2 * HZ)
+#define INITIAL_DELAY	(HZ / 2)
+
+static void fw_device_init(struct work_struct *work)
+{
+	static int serial;
+	struct fw_device *device =
+		container_of(work, struct fw_device, work.work);
+
+	/* All failure paths here set node->data to NULL, so that we
+	 * don't try to do device_for_each_child() on a kfree()'d
+	 * device. */
+
+	if (read_bus_info_block(device) < 0) {
+		if (device->config_rom_retries < MAX_RETRIES) {
+			device->config_rom_retries++;
+			schedule_delayed_work(&device->work, RETRY_DELAY);
+		} else {
+			fw_notify("giving up on config rom for node id %d\n",
+				  device->node_id);
+			fw_device_release(&device->device);
+		}
+		return;
+	}
+
+	device->device.bus = &fw_bus_type;
+	device->device.release = fw_device_release;
+	device->device.parent = device->card->device;
+	snprintf(device->device.bus_id, sizeof device->device.bus_id,
+		 "fw%d", serial++);
+
+	if (alloc_chrdev_region(&device->device.devt, 0, 1, "fw")) {
+		fw_error("Failed to register char device region.\n");
+		goto error;
+	}
+
+	cdev_init(&device->cdev, &fw_device_ops);
+	device->cdev.owner = THIS_MODULE;
+	kobject_set_name(&device->cdev.kobj, device->device.bus_id);
+	if (cdev_add(&device->cdev, device->device.devt, 1)) {
+		fw_error("Failed to register char device.\n");
+		goto error;
+	}
+
+	if (device_add(&device->device)) {
+		fw_error("Failed to add device.\n");
+		goto error;
+	}
+
+	if (device_create_file(&device->device, &config_rom_attribute) < 0) {
+		fw_error("Failed to create config rom file.\n");
+		goto error_with_device;
+	}
+
+	create_units(device);
+
+	/* Transition the device to running state.  If it got pulled
+	 * out from under us while we did the intialization work, we
+	 * have to shut down the device again here.  Normally, though,
+	 * fw_node_event will be responsible for shutting it down when
+	 * necessary.  We have to use the atomic cmpxchg here to avoid
+	 * racing with the FW_NODE_DESTROYED case in
+	 * fw_node_event(). */
+	if (cmpxchg(&device->state,
+		    FW_DEVICE_INITIALIZING,
+		    FW_DEVICE_RUNNING) == FW_DEVICE_SHUTDOWN)
+		fw_device_shutdown(&device->work.work);
+	else
+		fw_notify("created new fw device %s (%d config rom retries)\n",
+			  device->device.bus_id, device->config_rom_retries);
+
+	/* Reschedule the IRM work if we just finished reading the
+	 * root node config rom.  If this races with a bus reset we
+	 * just end up running the IRM work a couple of extra times -
+	 * pretty harmless. */
+	if (device->node == device->card->root_node)
+		schedule_delayed_work(&device->card->work, 0);
+
+	return;
+
+      error_with_device:
+	device_del(&device->device);
+      error:
+	cdev_del(&device->cdev);
+	unregister_chrdev_region(device->device.devt, 1);
+	put_device(&device->device);
+}
+
+static int update_unit(struct device *dev, void *data)
+{
+	struct fw_unit *unit = fw_unit(dev);
+	struct fw_driver *driver = (struct fw_driver *)dev->driver;
+
+	if (is_fw_unit(dev) && driver != NULL && driver->update != NULL)
+		driver->update(unit);
+
+	return 0;
+}
+
+void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
+{
+	struct fw_device *device;
+
+	/* Ignore events for the local node (i.e. the node that
+	 * corresponds to the ieee1394 controller in this linux box). */
+	if (node == card->local_node)
+		return;
+
+	switch (event) {
+	case FW_NODE_CREATED:
+	case FW_NODE_LINK_ON:
+		if (!node->link_on)
+			break;
+
+		device = kzalloc(sizeof(*device), GFP_ATOMIC);
+		if (device == NULL)
+			break;
+
+		/* Do minimal intialization of the device here, the
+		 * rest will happen in fw_device_init().  We need the
+		 * card and node so we can read the config rom and we
+		 * need to do device_initialize() now so
+		 * device_for_each_child() in FW_NODE_UPDATED is
+		 * doesn't freak out. */
+		device_initialize(&device->device);
+		device->state = FW_DEVICE_INITIALIZING;
+		device->card = fw_card_get(card);
+		device->node = fw_node_get(node);
+		device->node_id = node->node_id;
+		device->generation = card->generation;
+
+		/* Set the node data to point back to this device so
+		 * FW_NODE_UPDATED callbacks can update the node_id
+		 * and generation for the device. */
+		node->data = device;
+
+		/* Many devices are slow to respond after bus resets,
+		 * especially if they are bus powered and go through
+		 * power-up after getting plugged in.  We schedule the
+		 * first config rom scan half a second after bus reset. */
+		INIT_DELAYED_WORK(&device->work, fw_device_init);
+		schedule_delayed_work(&device->work, INITIAL_DELAY);
+		break;
+
+	case FW_NODE_UPDATED:
+		if (!node->link_on || node->data == NULL)
+			break;
+
+		device = node->data;
+		device->node_id = node->node_id;
+		device->generation = card->generation;
+		device_for_each_child(&device->device, NULL, update_unit);
+		break;
+
+	case FW_NODE_DESTROYED:
+	case FW_NODE_LINK_OFF:
+		if (!node->data)
+			break;
+
+		/* Destroy the device associated with the node.  There
+		 * are two cases here: either the device is fully
+		 * initialized (FW_DEVICE_RUNNING) or we're in the
+		 * process of reading its config rom
+		 * (FW_DEVICE_INITIALIZING).  If it is fully
+		 * initialized we can reuse device->work to schedule a
+		 * full fw_device_shutdown().  If not, there's work
+		 * scheduled to read it's config rom, and we just put
+		 * the device in shutdown state to have that code fail
+		 * to create the device. */
+		device = node->data;
+		if (xchg(&device->state,
+			 FW_DEVICE_SHUTDOWN) == FW_DEVICE_RUNNING) {
+			INIT_DELAYED_WORK(&device->work, fw_device_shutdown);
+			schedule_delayed_work(&device->work, 0);
+		}
+		break;
+	}
+}
diff --git a/drivers/firewire/fw-device.h b/drivers/firewire/fw-device.h
new file mode 100644
index 0000000..84cd5e7
--- /dev/null
+++ b/drivers/firewire/fw-device.h
@@ -0,0 +1,127 @@
+/*						-*- c-basic-offset: 8 -*-
+ *
+ * fw-device.h - Device probing and sysfs code.
+ *
+ * Copyright (C) 2005-2006  Kristian Hoegsberg <krh@bitplanet.net>
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
+#ifndef __fw_device_h
+#define __fw_device_h
+
+#include <linux/fs.h>
+#include <linux/cdev.h>
+
+enum fw_device_state {
+	FW_DEVICE_INITIALIZING,
+	FW_DEVICE_RUNNING,
+	FW_DEVICE_SHUTDOWN
+};
+
+struct fw_device {
+	int state;
+	struct fw_node *node;
+	int node_id;
+	int generation;
+	struct fw_card *card;
+	struct device device;
+	struct cdev cdev;
+	__be32 *config_rom;
+	size_t config_rom_length;
+	int config_rom_retries;
+	struct delayed_work work;
+};
+
+static inline struct fw_device *
+fw_device(struct device *dev)
+{
+        return container_of(dev, struct fw_device, device);
+}
+
+struct fw_device *fw_device_get(struct fw_device *device);
+void fw_device_put(struct fw_device *device);
+int fw_device_enable_phys_dma(struct fw_device *device);
+
+struct fw_unit {
+	struct device device;
+	u32 *directory;
+};
+
+static inline struct fw_unit *
+fw_unit(struct device *dev)
+{
+        return container_of(dev, struct fw_unit, device);
+}
+
+#define CSR_OFFSET	0x40
+#define CSR_LEAF	0x80
+#define CSR_DIRECTORY	0xc0
+
+#define CSR_DESCRIPTOR		0x01
+#define CSR_VENDOR		0x03
+#define CSR_HARDWARE_VERSION	0x04
+#define CSR_NODE_CAPABILITIES	0x0c
+#define CSR_UNIT		0x11
+#define CSR_SPECIFIER_ID	0x12
+#define CSR_VERSION		0x13
+#define CSR_DEPENDENT_INFO	0x14
+#define CSR_MODEL		0x17
+#define CSR_INSTANCE		0x18
+
+#define SBP2_COMMAND_SET_SPECIFIER	0x38
+#define SBP2_COMMAND_SET		0x39
+#define SBP2_COMMAND_SET_REVISION	0x3b
+#define SBP2_FIRMWARE_REVISION		0x3c
+
+struct fw_csr_iterator {
+	u32 *p;
+	u32 *end;
+};
+
+void fw_csr_iterator_init(struct fw_csr_iterator *ci, u32 *p);
+int fw_csr_iterator_next(struct fw_csr_iterator *ci,
+			 int *key, int *value);
+
+#define FW_MATCH_VENDOR		0x0001
+#define FW_MATCH_MODEL		0x0002
+#define FW_MATCH_SPECIFIER_ID	0x0004
+#define FW_MATCH_VERSION	0x0008
+
+struct fw_device_id {
+	u32 match_flags;
+	u32 vendor;
+	u32 model;
+	u32 specifier_id;
+	u32 version;
+	void *driver_data;
+};
+
+struct fw_driver {
+	struct device_driver driver;
+	/* Called when the parent device sits through a bus reset. */
+	void (*update) (struct fw_unit *unit);
+	struct fw_device_id *id_table;
+};
+
+static inline struct fw_driver *
+fw_driver(struct device_driver *drv)
+{
+        return container_of(drv, struct fw_driver, driver);
+}
+
+extern struct file_operations fw_device_ops;
+
+#endif
diff --git a/drivers/firewire/fw-iso.c b/drivers/firewire/fw-iso.c
index 61548c4..6b63856 100644
--- a/drivers/firewire/fw-iso.c
+++ b/drivers/firewire/fw-iso.c
@@ -26,6 +26,7 @@ #include <linux/mm.h>
 
 #include "fw-transaction.h"
 #include "fw-topology.h"
+#include "fw-device.h"
 
 static int
 setup_iso_buffer(struct fw_iso_context *ctx, size_t size,
diff --git a/drivers/firewire/fw-topology.c b/drivers/firewire/fw-topology.c
index 2778aa3..e475025 100644
--- a/drivers/firewire/fw-topology.c
+++ b/drivers/firewire/fw-topology.c
@@ -434,13 +434,15 @@ fw_core_handle_bus_reset(struct fw_card 
 		for_each_fw_node(card, local_node, report_found_node);
 	} else {
 		update_tree(card, local_node, &changed);
+		if (changed)
+			card->irm_retries = 0;
 	}
 
+	/* If we're not the root node, we may have to do some IRM work. */
+	if (card->local_node != card->root_node)
+		schedule_delayed_work(&card->work, 0);
+
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 EXPORT_SYMBOL(fw_core_handle_bus_reset);
-
-void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
-{
-}
diff --git a/drivers/firewire/fw-transaction.c b/drivers/firewire/fw-transaction.c
index c3acf74..affd420 100644
--- a/drivers/firewire/fw-transaction.c
+++ b/drivers/firewire/fw-transaction.c
@@ -33,6 +33,7 @@ #include <asm/semaphore.h>
 
 #include "fw-transaction.h"
 #include "fw-topology.h"
+#include "fw-device.h"
 
 #define header_pri(pri)			((pri) << 0)
 #define header_tcode(tcode)		((tcode) << 4)
@@ -702,10 +703,6 @@ static struct fw_descriptor vendor_textu
 	.data = vendor_textual_descriptor_data
 };
 
-struct bus_type fw_bus_type = {
-	.name = "fw",
-};
-
 static int __init fw_core_init(void)
 {
 	int retval;
diff --git a/drivers/firewire/fw-transaction.h b/drivers/firewire/fw-transaction.h
index 149ef16..7f618f2 100644
--- a/drivers/firewire/fw-transaction.h
+++ b/drivers/firewire/fw-transaction.h
@@ -265,6 +265,10 @@ struct fw_card {
 	struct device card_device;
 
 	struct list_head link;
+
+	/* Work struct for IRM duties. */
+	struct delayed_work work;
+	int irm_retries;
 };
 
 struct fw_card *fw_card_get(struct fw_card *card);
-- 
1.4.2.4

