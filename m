Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUCaVcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCaVcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:32:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2209 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262509AbUCaV04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:26:56 -0500
Date: Wed, 31 Mar 2004 15:26:48 -0600
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH] ibmvscsi driver - sixth version
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave>
Cc: linux-kernel@vger.kernel.org
From: Dave Boutcher <sleddog@us.ibm.com>
Organization: IBM
Content-Type: multipart/mixed; boundary=----------fjD33O9GjmkoJ05x3BjcJG
MIME-Version: 1.0
Message-ID: <opr5qwiyw4l6e53g@us.ibm.com>
In-Reply-To: <1079027038.2820.57.camel@mulgrave>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------fjD33O9GjmkoJ05x3BjcJG
Content-Type: text/plain; format=flowed; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

James,

Here is the next version of the ibmvscsi lldd.  I know you were waiting 
for the fix that correctly checks for errors on the dma_map_foo calls, 
which is included.  The other functional changes are to implement 
device_reset, and to surface a bunch of adapter attributes through 
shost_attrs.

This driver has been under test for the last couple of months, and is 
scheduled to ship in a couple of distributions shortly.  There are a few 
bug fixes included in this patch as well, mostly in the area of abort 
processing and correctly handling edge conditions (freeing buffers in 
error paths etc.)

Comments always welcomed.  I would like to get this upstream if I can, 
since the linux distributors are complaining slightly that it is not.

Thanks,

Dave B
------------fjD33O9GjmkoJ05x3BjcJG
Content-Disposition: attachment; filename=patch-ibmvscsi-2.6-mar31.diff
Content-Type: application/octet-stream; name=patch-ibmvscsi-2.6-mar31.diff
Content-Transfer-Encoding: 8bit

diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/Makefile ppc64-2.5new/drivers/scsi/ibmvscsi/Makefile
--- linux-2.5/drivers/scsi/ibmvscsi/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/Makefile	2004-03-31 13:42:37.000000000 -0600
@@ -0,0 +1,5 @@
+obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsic.o
+
+ibmvscsic-y			+= ibmvscsi.o
+ibmvscsic-$(CONFIG_PPC_ISERIES)	+= iseries_vscsi.o 
+ibmvscsic-$(CONFIG_PPC_PSERIES)	+= rpa_vscsi.o 
diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/ibmvscsi.c ppc64-2.5new/drivers/scsi/ibmvscsi/ibmvscsi.c
--- linux-2.5/drivers/scsi/ibmvscsi/ibmvscsi.c	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/ibmvscsi.c	2004-03-31 10:36:36.000000000 -0600
@@ -0,0 +1,1348 @@
+/* ------------------------------------------------------------
+ * ibmvscsi.c
+ * (C) Copyright IBM Corporation 1994, 2004
+ * Authors: Colin DeVilbiss (devilbis@us.ibm.com)
+ *          Santiago Leon (santil@us.ibm.com)
+ *          Dave Boutcher (sleddog@us.ibm.com)
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * ------------------------------------------------------------
+ * Emulation of a SCSI host adapter for Virtual I/O devices
+ *
+ * This driver supports the SCSI adapter implemented by the IBM
+ * Power5 firmware.  That SCSI adapter is not a physical adapter,
+ * but allows Linux SCSI peripheral drivers to directly
+ * access devices in another logical partition on the physical system.
+ *
+ * The virtual adapter(s) are present in the open firmware device
+ * tree just like real adapters.
+ *
+ * One of the capabilities provided on these systems is the ability
+ * to DMA between partitions.  The architecture states that for VSCSI,
+ * the server side is allowed to DMA to and from the client.  The client
+ * is never trusted to DMA to or from the server directly.
+ *
+ * Messages are sent between partitions on a "Command/Response Queue" 
+ * (CRQ), which is just a buffer of 16 byte entries in the receiver's 
+ * Senders cannot access the buffer directly, but send messages by
+ * making a hypervisor call and passing in the 16 bytes.  The hypervisor
+ * puts the message in the next 16 byte space in round-robbin fashion,
+ * turns on the high order bit of the message (the valid bit), and 
+ * generates an interrupt to the receiver (if interrupts are turned on.) 
+ * The receiver just turns off the valid bit when they have copied out
+ * the message.
+ *
+ * The VSCSI client builds a SCSI Remote Protocol (SRP) Information Unit
+ * (IU) (as defined in the T10 standard available at www.t10.org), gets 
+ * a DMA address for the message, and sends it to the server as the
+ * payload of a CRQ message.  The server DMAs the SRP IU and processes it,
+ * including doing any additional data transfers.  When it is done, it
+ * DMAs the SRP response back to the same address as the request came from,
+ * and sends a CRQ message back to inform the client that the request has
+ * completed.
+ *
+ * Note that some of the underlying infrastructure is different between
+ * machines conforming to the "RS/6000 Platform Architecture" (RPA) and
+ * the older iSeries hypervisor models.  To support both, some low level
+ * routines have been broken out into rpa_vscsi.c and iseries_vscsi.c.
+ * The Makefile should pick one, not two, not zero, of these.
+ *
+ * TODO: This is currently pretty tied to the IBM i/pSeries hypervisor
+ * interfaces.  It would be really nice to abstract this above an RDMA
+ * layer.
+ */
+
+#include <linux/pci.h>		/* needed only for pci_dma_mapping_error */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
+#include "ibmvscsi.h"
+
+/* The values below are somewhat arbitrary default values, but 
+ * OS/400 will use 3 busses (disks, CDs, tapes, I think.)
+ * Note that there are 3 bits of channel value, 6 bits of id, and
+ * 5 bits of LUN.
+ */
+static int max_id = 64;
+static int max_channel = 3;
+static int init_timeout = 5;
+static int cmd_per_lun = 8;
+static int max_requests = 50;
+
+MODULE_DESCRIPTION("IBM Virtual SCSI");
+MODULE_AUTHOR("Dave Boutcher");
+MODULE_LICENSE("GPL");
+
+module_param_named(max_id, max_id, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(max_id, "Largest ID value for each channel");
+module_param_named(max_channel, max_channel, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(max_channel, "Largest channel value");
+module_param_named(init_timeout, init_timeout, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(init_timeout, "Initialization timeout in seconds");
+module_param_named(cmd_per_lun, cmd_per_lun, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(cd_per_lun, "Commands per lun");
+module_param_named(max_requests, max_requests, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(max_requests, "Maximum requests for this adapter");
+
+/* ------------------------------------------------------------
+ * Routines for the event pool and event structs
+ */
+/**
+ * initialize_event_pool: - Allocates and initializes the event pool for a host
+ * @pool:	event_pool to be initialized
+ * @size:	Number of events in pool
+ * @hostdata:	ibmvscsi_host_data who owns the event pool
+ *
+ * Returns zero on success.
+*/
+static int initialize_event_pool(struct event_pool *pool,
+				 int size, struct ibmvscsi_host_data *hostdata)
+{
+	int i;
+
+	pool->size = size;
+	pool->events = kmalloc(pool->size * sizeof(*pool->events), GFP_KERNEL);
+	if (!pool->events)
+		return -ENOMEM;
+	memset(pool->events, 0x00, pool->size * sizeof(*pool->events));
+
+	pool->iu_storage =
+	    dma_alloc_coherent(hostdata->dev,
+			       pool->size * sizeof(*pool->iu_storage),
+			       &pool->iu_token, 0);
+	if (!pool->iu_storage) {
+		kfree(pool->events);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < pool->size; ++i) {
+		struct srp_event_struct *evt = &pool->events[i];
+		memset(&evt->crq, 0x00, sizeof(evt->crq));
+		evt->crq.valid = 0x80;
+		evt->crq.IU_length = sizeof(*evt->evt);
+		evt->crq.IU_data_ptr = pool->iu_token + sizeof(*evt->evt) * i;
+		evt->evt = pool->iu_storage + i;
+		evt->hostdata = hostdata;
+	}
+
+	return 0;
+}
+
+/**
+ * release_event_pool: - Frees memory of an event pool of a host
+ * @pool:	event_pool to be released
+ * @hostdata:	ibmvscsi_host_data who owns the even pool
+ *
+ * Returns zero on success.
+*/
+static void release_event_pool(struct event_pool *pool,
+			       struct ibmvscsi_host_data *hostdata)
+{
+	int i, in_use = 0;
+	for (i = 0; i < pool->size; ++i)
+		if (pool->events[i].in_use)
+			++in_use;
+	if (in_use)
+		printk(KERN_WARNING
+		       "ibmvscsi: releasing event pool with %d "
+		       "events still in use?\n", in_use);
+	kfree(pool->events);
+	dma_free_coherent(hostdata->dev,
+			  pool->size * sizeof(*pool->iu_storage),
+			  pool->iu_storage, pool->iu_token);
+}
+
+/**
+ * ibmvscsi_valid_event_struct: - Determines if event is valid.
+ * @pool:	event_pool that contains the event
+ * @evt:	srp_event_struct to be checked for validity
+ *
+ * Returns zero if event is invalid, one otherwise.
+*/
+int ibmvscsi_valid_event_struct(struct event_pool *pool,
+				struct srp_event_struct *evt)
+{
+	int index = evt - pool->events;
+	if (index < 0 || index >= pool->size)	/* outside of bounds */
+		return 0;
+	if (evt != pool->events + index)	/* unaligned */
+		return 0;
+	return 1;
+}
+
+/**
+ * ibmvscsi_free-event_struct: - Changes status of event to "free"
+ * @pool:	event_pool that contains the event
+ * @evt:	srp_event_struct to be modified
+ *
+*/
+static void ibmvscsi_free_event_struct(struct event_pool *pool,
+				       struct srp_event_struct *evt)
+{
+	if (!ibmvscsi_valid_event_struct(pool, evt)) {
+		printk(KERN_ERR
+		       "ibmvscsi: Freeing invalid event_struct %p "
+		       "(not in pool %p)\n", evt, pool->events);
+		return;
+	}
+	if (!evt->in_use) {
+		printk(KERN_ERR
+		       "ibmvscsi: Freeing event_struct %p "
+		       "which is not in use!\n", evt);
+		return;
+	}
+	evt->in_use = 0;
+}
+
+/**
+ * ibmvscsi_get_event_struct: - Gets the next free event in pool
+ * @pool:	event_pool that contains the events to be searched
+ *
+ * Returns the next event in "free" state, and NULL if none are free.
+ * Note that no synchronization is done here, we assume the host_lock
+ * will syncrhonze things.
+*/
+static
+struct srp_event_struct *ibmvscsi_get_event_struct(struct event_pool *pool)
+{
+	struct srp_event_struct *cur, *last = pool->events + pool->size;
+
+	for (cur = pool->events; cur < last; ++cur)
+		if (!cur->in_use) {
+			cur->in_use = 1;
+			break;
+		}
+
+	if (cur >= last) {
+		printk(KERN_ERR "ibmvscsi: found no event struct in pool!\n");
+		return NULL;
+	}
+
+	return cur;
+}
+
+/**
+ * evt_struct_for: - Initializes the next free event
+ * @pool:	event_pool that contains events to be searched
+ * @evt:	VIOSRP_IU that the event will point to
+ * @cmnd:	The scsi cmnd object for this event.  Can be NULL
+ * @done:	Callback function when event is processed
+ *
+ * Returns the initialized event, and NULL if there are no free events
+ */
+static
+struct srp_event_struct *evt_struct_for(struct event_pool *pool,
+					union VIOSRP_IU *evt,
+					struct scsi_cmnd *cmnd,
+					void (*done) (struct srp_event_struct
+						      *))
+{
+	struct srp_event_struct *evt_struct = ibmvscsi_get_event_struct(pool);
+	if (!evt_struct)
+		return NULL;
+
+	*evt_struct->evt = *evt;
+	evt_struct->evt->srp.generic.tag = (u64) (unsigned long)evt_struct;
+
+	evt_struct->cmnd = cmnd;
+	evt_struct->done = done;
+	return evt_struct;
+}
+
+/* ------------------------------------------------------------
+ * Routines for receiving SCSI responses from the hosting partition
+ */
+/**
+ * unmap_direct_data: - Unmap address pointed by SRP_CMD
+ * @cmd:	SRP_CMD whose additional_data member will be unmapped
+ * @dev:	device for which the memory is mapped
+ *
+*/
+static void unmap_direct_data(struct SRP_CMD *cmd, struct device *dev)
+{
+	struct memory_descriptor *data =
+	    (struct memory_descriptor *)cmd->additional_data;
+	dma_unmap_single(dev, data->virtual_address, data->length,
+			 DMA_BIDIRECTIONAL);
+}
+
+/**
+ * unmap_direct_data: - Unmap array of address pointed by SRP_CMD
+ * @cmd:	SRP_CMD whose additional_data member will be unmapped
+ * @dev:	device for which the memory is mapped
+ *
+*/
+static void unmap_indirect_data(struct SRP_CMD *cmd, struct device *dev)
+{
+	struct indirect_descriptor *indirect =
+	    (struct indirect_descriptor *)cmd->additional_data;
+	int i, num_mapped = indirect->head.length / sizeof(indirect->list[0]);
+	for (i = 0; i < num_mapped; ++i) {
+		struct memory_descriptor *data = &indirect->list[i];
+		dma_unmap_single(dev,
+				 data->virtual_address,
+				 data->length, DMA_BIDIRECTIONAL);
+	}
+}
+
+/**
+ * unmap_direct_data: - Unmap data pointed in SRP_CMD based on the format
+ * @cmd:	SRP_CMD whose additional_data member will be unmapped
+ * @dev:	device for which the memory is mapped
+ *
+*/
+static void unmap_cmd_data(struct SRP_CMD *cmd, struct device *dev)
+{
+	if ((cmd->data_out_format == SRP_NO_BUFFER) &&
+	    (cmd->data_in_format == SRP_NO_BUFFER))
+		return;
+	else if ((cmd->data_out_format == SRP_DIRECT_BUFFER) ||
+		 (cmd->data_in_format == SRP_DIRECT_BUFFER))
+		unmap_direct_data(cmd, dev);
+	else
+		unmap_indirect_data(cmd, dev);
+}
+
+/**
+ * map_sg_data: - Maps dma for a scatterlist and initializes decriptor fields
+ * @cmd:	Scsi_Cmnd with the scatterlist
+ * @srp_cmd:	SRP_CMD that contains the memory descriptor
+ * @dev:	device for which to map dma memory
+ *
+ * Called by map_data_for_srp_cmd() when building srp cmd from scsi cmd.
+ * Returns 1 on success.
+*/
+static int map_sg_data(struct scsi_cmnd *cmd,
+		       struct SRP_CMD *srp_cmd, struct device *dev)
+{
+
+	int i, sg_mapped;
+	u64 total_length = 0;
+	struct scatterlist *sg = cmd->request_buffer;
+	struct memory_descriptor *data =
+	    (struct memory_descriptor *)srp_cmd->additional_data;
+	struct indirect_descriptor *indirect =
+	    (struct indirect_descriptor *)data;
+	sg_mapped = dma_map_sg(dev, sg, cmd->use_sg, DMA_BIDIRECTIONAL);
+
+	if (pci_dma_mapping_error(sg_dma_address(&sg[0])))
+		return 0;
+
+	/* special case; we can use a single direct descriptor */
+	if (sg_mapped == 1) {
+		if (cmd->sc_data_direction == DMA_TO_DEVICE)
+			srp_cmd->data_out_format = SRP_DIRECT_BUFFER;
+		else
+			srp_cmd->data_in_format = SRP_DIRECT_BUFFER;
+		data->virtual_address = sg_dma_address(&sg[0]);
+		data->length = sg_dma_len(&sg[0]);
+		data->memory_handle = 0;
+		return 1;
+	}
+
+	if (sg_mapped > MAX_INDIRECT_BUFS) {
+		printk(KERN_ERR
+		       "ibmvscsi: More than %d mapped sg entries, got %d\n",
+		       MAX_INDIRECT_BUFS, sg_mapped);
+		return 0;
+	}
+
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		srp_cmd->data_out_format = SRP_INDIRECT_BUFFER;
+		srp_cmd->data_out_count = sg_mapped;
+	} else {
+		srp_cmd->data_in_format = SRP_INDIRECT_BUFFER;
+		srp_cmd->data_in_count = sg_mapped;
+	}
+	indirect->head.virtual_address = 0;
+	indirect->head.length = sg_mapped * sizeof(indirect->list[0]);
+	indirect->head.memory_handle = 0;
+	for (i = 0; i < sg_mapped; ++i) {
+		struct memory_descriptor *descr = &indirect->list[i];
+		struct scatterlist *sg_entry = &sg[i];
+		descr->virtual_address = sg_dma_address(sg_entry);
+		descr->length = sg_dma_len(sg_entry);
+		descr->memory_handle = 0;
+		total_length += sg_dma_len(sg_entry);
+	}
+	indirect->total_length = total_length;
+
+	return 1;
+}
+
+/**
+ * map_sg_data: - Maps memory and initializes memory decriptor fields
+ * @cmd:	struct scsi_cmnd with the memory to be mapped
+ * @srp_cmd:	SRP_CMD that contains the memory descriptor
+ * @dev:	device for which to map dma memory
+ *
+ * Called by map_data_for_srp_cmd() when building srp cmd from scsi cmd.
+ * Returns 1 on success.
+*/
+static int map_single_data(struct scsi_cmnd *cmd,
+			   struct SRP_CMD *srp_cmd, struct device *dev)
+{
+	struct memory_descriptor *data =
+	    (struct memory_descriptor *)srp_cmd->additional_data;
+
+	data->virtual_address =
+	    (u64) (unsigned long)dma_map_single(dev, cmd->request_buffer,
+						cmd->request_bufflen,
+						DMA_BIDIRECTIONAL);
+	if (pci_dma_mapping_error(data->virtual_address)) {
+		printk(KERN_ERR
+		       "ibmvscsi: Unable to map request_buffer for command!\n");
+		return 0;
+	}
+	data->length = cmd->request_bufflen;
+	data->memory_handle = 0;
+
+	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+		srp_cmd->data_out_format = SRP_DIRECT_BUFFER;
+	else
+		srp_cmd->data_in_format = SRP_DIRECT_BUFFER;
+
+	return 1;
+}
+
+/**
+ * map_data_for_srp_cmd: - Calls functions to map data for srp cmds
+ * @cmd:	struct scsi_cmnd with the memory to be mapped
+ * @srp_cmd:	SRP_CMD that contains the memory descriptor
+ * @dev:	dma device for which to map dma memory
+ *
+ * Called by scsi_cmd_to_srp_cmd() when converting scsi cmds to srp cmds 
+ * Returns 1 on success.
+*/
+static int map_data_for_srp_cmd(struct scsi_cmnd *cmd,
+				struct SRP_CMD *srp_cmd, struct device *dev)
+{
+	switch (cmd->sc_data_direction) {
+	case DMA_FROM_DEVICE:
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_NONE:
+		return 1;
+	case DMA_BIDIRECTIONAL:
+		printk(KERN_ERR
+		       "ibmvscsi: Can't map DMA_BIDIRECTIONAL to read/write\n");
+		return 0;
+	default:
+		printk(KERN_ERR
+		       "ibmvscsi: Unknown data direction 0x%02x; can't map!\n",
+		       cmd->sc_data_direction);
+		return 0;
+	}
+
+	if (!cmd->request_buffer)
+		return 1;
+	if (cmd->use_sg)
+		return map_sg_data(cmd, srp_cmd, dev);
+	return map_single_data(cmd, srp_cmd, dev);
+}
+
+/* ------------------------------------------------------------
+ * Routines for sending and receiving SRPs
+ */
+/**
+ * ibmvscsi_send_srp_event: - Transforms event to u64 array and calls send_crq()
+ * @evt_struct:	evt_struct to be sent
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+ * Returns the value returned from ibmvscsi_send_crq(). (Zero for success)
+ * Note that this routine assumes that host_lock is held for synchronization
+*/
+static int ibmvscsi_send_srp_event(struct srp_event_struct *evt_struct,
+				   struct ibmvscsi_host_data *hostdata)
+{
+	struct scsi_cmnd *cmnd;
+	u64 *crq_as_u64 = (u64 *) & evt_struct->crq;
+
+	/* If we have exhausted our request limit, just queue this request.
+	 * Note that there are rare cases involving driver generated requests 
+	 * (such as task management requests) that the mid layer may think we
+	 * can handle more requests (can_queue) when we actually can't
+	 */
+	if ((evt_struct->crq.format == VIOSRP_SRP_FORMAT) &&
+	    (atomic_dec_if_positive(&hostdata->request_limit) < 0)) {
+		printk("ibmvscsi: Warning, request_limit exceeded\n");
+		unmap_cmd_data(&evt_struct->evt->srp.cmd, hostdata->dev);
+		ibmvscsi_free_event_struct(&hostdata->pool, evt_struct);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	/* Add this to the sent list.  We need to do this 
+	 * before we actually send 
+	 * in case it comes back REALLY fast
+	 */
+	list_add_tail(&evt_struct->list, &hostdata->sent);
+
+	if (ibmvscsi_send_crq(hostdata, crq_as_u64[0], crq_as_u64[1]) != 0) {
+		list_del(&evt_struct->list);
+
+		cmnd = evt_struct->cmnd;
+		printk(KERN_ERR "ibmvscsi: failed to send event struct\n");
+		unmap_cmd_data(&evt_struct->evt->srp.cmd, hostdata->dev);
+		ibmvscsi_free_event_struct(&hostdata->pool, evt_struct);
+		cmnd->result = DID_ERROR << 16;
+		evt_struct->cmnd_done(cmnd);
+	}
+
+	return 0;
+}
+
+/**
+ * handle_cmd_rsp: -  Handle responses from commands
+ * @evt_struct:	srp_event_struct to be handled
+ *
+ * Used as a callback by when sending scsi cmds (by scsi_cmd_to_event_struct). 
+ * Gets called by ibmvscsi_handle_crq()
+*/
+static void handle_cmd_rsp(struct srp_event_struct *evt_struct)
+{
+	struct SRP_RSP *rsp = &evt_struct->evt->srp.rsp;
+	struct scsi_cmnd *cmnd = (struct scsi_cmnd *)evt_struct->cmnd;
+
+	if (cmnd) {
+		cmnd->result = rsp->status;
+		if (((cmnd->result >> 1) & 0x1f) == CHECK_CONDITION)
+			memcpy(cmnd->sense_buffer,
+			       rsp->sense_and_response_data,
+			       rsp->sense_data_list_length);
+		unmap_cmd_data(&evt_struct->cmd, evt_struct->hostdata->dev);
+
+		if (rsp->dounder)
+			cmnd->resid = rsp->data_out_residual_count;
+		else if (rsp->diunder)
+			cmnd->resid = rsp->data_in_residual_count;
+	}
+
+	if (evt_struct->cmnd_done) {
+		evt_struct->cmnd_done(cmnd);
+	}
+}
+
+/* ------------------------------------------------------------
+ * Routines for queuing individual SCSI commands to the hosting partition
+ */
+
+/**
+ * lun_from_dev: - Returns the lun of the scsi device
+ * @dev:	struct scsi_device
+ *
+*/
+static inline u16 lun_from_dev(struct scsi_device *dev)
+{
+	return (0x2 << 14) | (dev->id << 8) | (dev->channel << 5) | dev->lun;
+}
+
+/**
+ * scsi_cmd_to_srp_cmd: - Initializes srp cmd with data from scsi cmd
+ * @cmd:	source struct scsi_cmnd
+ * @srp_cmd:	target SRP_CMD
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+ * Returns 1 on success.
+*/
+static int scsi_cmd_to_srp_cmd(struct scsi_cmnd *cmd,
+			       struct SRP_CMD *srp_cmd,
+			       struct ibmvscsi_host_data *hostdata)
+{
+	u16 lun = lun_from_dev(cmd->device);
+	memset(srp_cmd, 0x00, sizeof(*srp_cmd));
+
+	srp_cmd->type = SRP_CMD_TYPE;
+	memcpy(srp_cmd->cdb, cmd->cmnd, sizeof(cmd->cmnd));
+	srp_cmd->lun = ((u64) lun) << 48;
+
+	return map_data_for_srp_cmd(cmd, srp_cmd, hostdata->dev);
+}
+
+/**
+ * scsi_cmd_to_event_struct: - Initializes a srp_event_struct 
+ *                             with data from scsi cmd
+ * @cmd:	Source struct scsi_cmnd
+ * @done:	Callback function to be called when cmd is completed
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+ * Returns the srp_event_struct to be used or NULL if not successful.
+*/
+static struct srp_event_struct *scsi_cmd_to_event_struct(struct scsi_cmnd *cmd,
+							 void (*done) (struct
+								       scsi_cmnd
+								       *),
+							 struct
+							 ibmvscsi_host_data
+							 *hostdata)
+{
+	struct SRP_CMD srp_cmd;
+	struct srp_event_struct *evt_struct;
+
+	if (!scsi_cmd_to_srp_cmd(cmd, &srp_cmd, hostdata)) {
+		printk(KERN_ERR "ibmvscsi: couldn't convert cmd to SRP_CMD\n");
+		return NULL;
+	}
+
+	evt_struct = evt_struct_for(&hostdata->pool,
+				    (union VIOSRP_IU *)&srp_cmd,
+				    (void *)cmd, handle_cmd_rsp);
+	if (!evt_struct) {
+		return NULL;
+	}
+
+	evt_struct->cmd = srp_cmd;
+	evt_struct->cmnd_done = done;
+	evt_struct->crq.timeout = cmd->timeout;
+	return evt_struct;
+}
+
+/**
+ * ibmvscsi_queue: - The queuecommand function of the scsi template 
+ * @cmd:	struct scsi_cmnd to be executed
+ * @done:	Callback function to be called when cmd is completed
+*/
+static
+int ibmvscsi_queuecommand(struct scsi_cmnd *cmd,
+			  void (*done) (struct scsi_cmnd *))
+{
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)&cmd->device->host->hostdata;
+	struct srp_event_struct *evt_struct =
+	    scsi_cmd_to_event_struct(cmd, done, hostdata);
+
+	if (!evt_struct) {
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	evt_struct->crq.format = VIOSRP_SRP_FORMAT;
+
+	return ibmvscsi_send_srp_event(evt_struct, hostdata);
+}
+
+/* ------------------------------------------------------------
+ * Routines for driver initialization
+ */
+/**
+ * adapter_info_rsp: - Handle response to MAD adapter info request
+ * @evt_struct:	srp_event_struct with the response
+ *
+ * Used as a "done" callback by when sending adapter_info. Gets called
+ * by ibmvscsi_handle_crq()
+*/
+static void adapter_info_rsp(struct srp_event_struct *evt_struct)
+{
+	struct ibmvscsi_host_data *hostdata = evt_struct->hostdata;
+	dma_unmap_single(hostdata->dev,
+			 evt_struct->evt->mad.adapter_info.buffer,
+			 evt_struct->evt->mad.adapter_info.common.length,
+			 DMA_BIDIRECTIONAL);
+
+	if (evt_struct->evt->mad.adapter_info.common.status) {
+		printk("ibmvscsi: error %d getting adapter info\n",
+		       evt_struct->evt->mad.adapter_info.common.status);
+	} else {
+		printk("ibmvscsi: host srp version: %s, "
+		       "host partition %s (%d), OS %d\n",
+		       hostdata->madapter_info.srp_version,
+		       hostdata->madapter_info.partition_name,
+		       hostdata->madapter_info.partition_number,
+		       hostdata->madapter_info.os_type);
+	}
+}
+
+/**
+ * send_mad_adapter_info: - Sends the mad adapter info request
+ *      and stores the result so it can be retrieved with
+ *      sysfs.  We COULD consider causing a failure if the
+ *      returned SRP version doesn't match ours.
+ * @hostdata:	ibmvscsi_host_data of host
+ * 
+ * Returns zero if successful.
+*/
+static void send_mad_adapter_info(struct ibmvscsi_host_data *hostdata)
+{
+	struct VIOSRP_ADAPTER_INFO req;
+	struct srp_event_struct *evt_struct;
+
+	memset(&hostdata->madapter_info, 0x00, sizeof(hostdata->madapter_info));
+	memset(&req, 0x00, sizeof(req));
+	req.common.type = VIOSRP_ADAPTER_INFO_TYPE;
+	req.common.length = sizeof(hostdata->madapter_info);
+	req.buffer = dma_map_single(hostdata->dev,
+				    &hostdata->madapter_info,
+				    sizeof(hostdata->madapter_info),
+				    DMA_BIDIRECTIONAL);
+	if (pci_dma_mapping_error(req.buffer)) {
+		printk(KERN_ERR
+		       "ibmvscsi: Unable to map request_buffer "
+		       "for adapter_info!\n");
+		return;
+	}
+
+	evt_struct = evt_struct_for(&hostdata->pool,
+				    (union VIOSRP_IU *)&req, NULL,
+				    adapter_info_rsp);
+	evt_struct->crq.format = VIOSRP_MAD_FORMAT;
+
+	if (!evt_struct) {
+		printk(KERN_ERR "ibmvscsi: couldn't allocate an event "
+		       "for ADAPTER_INFO_REQ!\n");
+		dma_unmap_single(hostdata->dev, req.buffer,
+				 req.common.length, DMA_BIDIRECTIONAL);
+		return;
+	}
+
+	if (ibmvscsi_send_srp_event(evt_struct, hostdata)) {
+		printk(KERN_ERR "ibmvscsi: couldn't send ADAPTER_INFO_REQ!\n");
+	}
+};
+
+/**
+ * login_rsp: - Handle response to SRP login request
+ * @evt_struct:	srp_event_struct with the response
+ *
+ * Used as a "done" callback by when sending srp_login. Gets called
+ * by ibmvscsi_handle_crq()
+*/
+static void login_rsp(struct srp_event_struct *evt_struct)
+{
+	struct ibmvscsi_host_data *hostdata = evt_struct->hostdata;
+	switch (evt_struct->evt->srp.generic.type) {
+	case SRP_LOGIN_RSP_TYPE:	/* it worked! */
+		break;
+	case SRP_LOGIN_REJ_TYPE:	/* refused! */
+		printk(KERN_INFO "ibmvscsi: SRP_LOGIN_REQ rejected\n");
+		/* Login failed.  */
+		atomic_set(&hostdata->request_limit, -1);
+		return;
+	default:
+		printk(KERN_ERR
+		       "ibmvscsi: Invalid login response typecode 0x%02x!\n",
+		       evt_struct->evt->srp.generic.type);
+		/* Login failed.  */
+		atomic_set(&hostdata->request_limit, -1);
+		return;
+	}
+
+	printk(KERN_INFO "ibmvscsi: SRP_LOGIN succeeded\n");
+
+	if (evt_struct->evt->srp.login_rsp.request_limit_delta > (max_requests-2))
+	    evt_struct->evt->srp.login_rsp.request_limit_delta = max_requests-2;
+
+	/* Now we know what the real request-limit is */
+	atomic_set(&hostdata->request_limit,
+		   evt_struct->evt->srp.login_rsp.request_limit_delta);
+
+	hostdata->host->can_queue =
+	    evt_struct->evt->srp.login_rsp.request_limit_delta;
+
+	send_mad_adapter_info(hostdata);
+	return;
+}
+
+/**
+ * send_srp_login: - Sends the srp login
+ * @hostdata:	ibmvscsi_host_data of host
+ * 
+ * Returns zero if successful.
+*/
+static int send_srp_login(struct ibmvscsi_host_data *hostdata)
+{
+	int rc;
+	unsigned long flags;
+
+	struct SRP_LOGIN_REQ req = {
+		.type = SRP_LOGIN_REQ_TYPE,
+		.max_requested_initiator_to_target_iulen = sizeof(union SRP_IU),
+		.required_buffer_formats = 0x0002	/* direct and indirect */
+	};
+	struct srp_event_struct *evt_struct = evt_struct_for(&hostdata->pool,
+							     (union VIOSRP_IU *)
+							     &req,
+							     NULL,
+							     login_rsp);
+
+	if (!evt_struct) {
+		printk(KERN_ERR
+		       "ibmvscsi: couldn't allocate an event for login req!\n");
+		return FAILED;
+	}
+
+	/* Start out with a request limit of 1, since this is negotiated in
+	 * the login request we are just sending
+	 */
+	atomic_set(&hostdata->request_limit, 1);
+	evt_struct->crq.format = VIOSRP_SRP_FORMAT;
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
+	rc = ibmvscsi_send_srp_event(evt_struct, hostdata);
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+	return rc;
+};
+
+/**
+ * sync_completion: Signal that a synchronous command has completed
+ * Note that after returning from this call, the evt_struct is freed.
+ * the caller waiting on this completion shouldn't touch the evt_struct
+ * again.
+ */
+static void sync_completion(struct srp_event_struct *evt_struct)
+{
+	complete(&evt_struct->comp);
+}
+
+/**
+ * ibmvscsi_abort: Abort a command...from scsi host template
+ * send this over to the server and wait synchronously for the response
+ */
+static int ibmvscsi_eh_abort_handler(struct scsi_cmnd *cmd)
+{
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)cmd->device->host->hostdata;
+	union VIOSRP_IU iu;
+	struct SRP_TSK_MGMT *tsk_mgmt = &iu.srp.tsk_mgmt;
+	struct srp_event_struct *evt;
+	struct srp_event_struct *tmp_evt, *found_evt;
+	u16 lun = lun_from_dev(cmd->device);
+
+	/* First, find this command in our sent list so we can figure
+	 * out the correct tag
+	 */
+	found_evt = NULL;
+	list_for_each_entry(tmp_evt, &hostdata->sent, list) {
+		if (tmp_evt->cmnd == cmd) {
+			found_evt = tmp_evt;
+			break;
+		}
+	}
+
+	/* Set up an abort SRP command */
+	memset(&iu, 0x00, sizeof(iu));
+	tsk_mgmt->type = SRP_TSK_MGMT_TYPE;
+	tsk_mgmt->lun = ((u64) lun) << 48;
+	tsk_mgmt->task_mgmt_flags = 0x01;	/* ABORT TASK */
+	tsk_mgmt->managed_task_tag = (u64) (unsigned long)found_evt;
+
+	printk(KERN_INFO "ibmvscsi: aborting command. lun 0x%lx, tag 0x%lx\n",
+	       tsk_mgmt->lun, tsk_mgmt->managed_task_tag);
+
+	evt = evt_struct_for(&hostdata->pool, &iu, NULL, sync_completion);
+	if (!evt) {
+		printk(KERN_ERR "ibmvscsi: failed to allocate abort() event\n");
+		return FAILED;
+	}
+	evt->crq.format = VIOSRP_SRP_FORMAT;
+
+	init_completion(&evt->comp);
+	if (ibmvscsi_send_srp_event(evt, hostdata) != 0) {
+		printk(KERN_ERR "ibmvscsi: failed to send abort() event\n");
+		return FAILED;
+	}
+
+	spin_unlock_irq(hostdata->host->host_lock);
+	wait_for_completion(&evt->comp);
+	spin_lock_irq(hostdata->host->host_lock);
+
+	/* Because we dropped the spinlock above, it's possible
+	 * The event is no longer in our list.  Make sure it didn't
+	 * complete while we were aborting
+	 */
+	list_for_each_entry(tmp_evt, &hostdata->sent, list) {
+		if (tmp_evt->cmnd == cmd) {
+			found_evt = tmp_evt;
+			break;
+		}
+	}
+	if (found_evt == NULL)
+		return SUCCESS;
+
+	cmd->result = (DID_ABORT << 16);
+	list_del(&found_evt->list);
+	unmap_cmd_data(&found_evt->cmd, found_evt->hostdata->dev);
+	ibmvscsi_free_event_struct(&found_evt->hostdata->pool, found_evt);
+	atomic_inc(&hostdata->request_limit);
+	printk(KERN_INFO
+	       "ibmvscsi: successfully aborted task tag 0x%lx\n",
+	       tsk_mgmt->managed_task_tag);
+	return SUCCESS;
+}
+
+/**
+ * ibmvscsi_eh_device_reset_handler: Reset a single LUN...from scsi host 
+ * template send this over to the server and wait synchronously for the 
+ * response
+ */
+static int ibmvscsi_eh_device_reset_handler(struct scsi_cmnd *cmd)
+{
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)cmd->device->host->hostdata;
+
+	union VIOSRP_IU iu;
+	struct SRP_TSK_MGMT *tsk_mgmt = &iu.srp.tsk_mgmt;
+	struct srp_event_struct *evt;
+	struct srp_event_struct *tmp_evt, *pos;
+	u16 lun = lun_from_dev(cmd->device);
+
+	/* Set up a lun reset SRP command */
+	memset(&iu, 0x00, sizeof(iu));
+	tsk_mgmt->type = SRP_TSK_MGMT_TYPE;
+	tsk_mgmt->lun = ((u64) lun) << 48;
+	tsk_mgmt->task_mgmt_flags = 0x08;	/* LUN RESET */
+
+	printk(KERN_INFO "ibmvscsi: resetting device. lun 0x%lx\n",
+	       tsk_mgmt->lun);
+
+	evt = evt_struct_for(&hostdata->pool, &iu, NULL, sync_completion);
+	if (!evt) {
+		printk(KERN_ERR "ibmvscsi: failed to allocate reset event\n");
+		return FAILED;
+	}
+	evt->crq.format = VIOSRP_SRP_FORMAT;
+
+	init_completion(&evt->comp);
+	if (ibmvscsi_send_srp_event(evt, hostdata) != 0) {
+		printk(KERN_ERR "ibmvscsi: failed to send reset event\n");
+		return FAILED;
+	}
+
+	spin_unlock_irq(hostdata->host->host_lock);
+	wait_for_completion(&evt->comp);
+	spin_lock_irq(hostdata->host->host_lock);
+
+	/* We need to find all commands for this LUN that have not yet been
+	 * responded to, and fail them with DID_RESET
+	 */
+	list_for_each_entry_safe(tmp_evt, pos, &hostdata->sent, list) {
+		if (tmp_evt->cmnd->device == cmd->device) {
+			tmp_evt->cmnd->result = (DID_RESET << 16);
+			list_del(&tmp_evt->list);
+			unmap_cmd_data(&tmp_evt->cmd, tmp_evt->hostdata->dev);
+			ibmvscsi_free_event_struct(&tmp_evt->hostdata->pool,
+						   tmp_evt);
+			if (tmp_evt->cmnd_done) {
+				spin_unlock_irq(hostdata->host->host_lock);
+				tmp_evt->cmnd_done(tmp_evt->cmnd);
+				spin_lock_irq(hostdata->host->host_lock);
+			}
+
+		}
+	}
+	return SUCCESS;
+}
+
+/**
+ * purge_requests: Our virtual adapter just shut down.  purge any sent requests
+ * @hostdata:    the adapter
+ */
+static void purge_requests(struct ibmvscsi_host_data *hostdata)
+{
+	struct srp_event_struct *tmp_evt, *pos;
+	unsigned long flags;
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
+	list_for_each_entry_safe(tmp_evt, pos, &hostdata->sent, list) {
+		tmp_evt->cmnd->result = (DID_ERROR << 16);
+		list_del(&tmp_evt->list);
+		unmap_cmd_data(&tmp_evt->cmd, tmp_evt->hostdata->dev);
+		ibmvscsi_free_event_struct(&tmp_evt->hostdata->pool, tmp_evt);
+		if (tmp_evt->cmnd_done) {
+			spin_unlock_irqrestore(hostdata->host->host_lock,
+					       flags);
+			tmp_evt->cmnd_done(tmp_evt->cmnd);
+			spin_lock_irqsave(hostdata->host->host_lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+}
+
+/**
+ * ibmvscsi_handle_crq: - Handles and frees received events in the CRQ
+ * @crq:	Command/Response queue
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+*/
+void ibmvscsi_handle_crq(struct VIOSRP_CRQ *crq,
+			 struct ibmvscsi_host_data *hostdata)
+{
+	unsigned long flags;
+	struct srp_event_struct *evt_struct =
+	    (struct srp_event_struct *)crq->IU_data_ptr;
+	switch (crq->valid) {
+	case 0xC0:		/* initialization */
+		switch (crq->format) {
+		case 0x01:	/* Initialization message */
+			printk(KERN_INFO "ibmvscsi: partner initialized\n");
+			/* Send back a response */
+			if (ibmvscsi_send_crq(hostdata,
+					      0xC002000000000000, 0) == 0) {
+				/* Now login */
+				send_srp_login(hostdata);
+			} else {
+				printk(KERN_ERR
+				       "ibmvscsi: Unable to send init rsp\n");
+			}
+
+			break;
+		case 0x02:	/* Initialization response */
+			printk(KERN_INFO
+			       "ibmvscsi: partner initialization complete\n");
+
+			/* Now login */
+			send_srp_login(hostdata);
+			break;
+		default:
+			printk(KERN_ERR "ibmvscsi: unknown crq message type\n");
+		}
+		return;
+	case 0xFF:		/* Hypervisor telling us the connection is closed */
+		printk(KERN_INFO "ibmvscsi: Virtual adapter failed!\n");
+
+		atomic_set(&hostdata->request_limit, -1);
+		purge_requests(hostdata);
+		return;
+	case 0x80:		/* real payload */
+		break;
+	default:
+		printk(KERN_ERR
+		       "ibmvscsi: got an invalid message type 0x%02x\n",
+		       crq->valid);
+		return;
+	}
+
+	/* The only kind of payload CRQs we should get are responses to
+	 * things we send. Make sure this response is to something we
+	 * actually sent
+	 */
+	if (!ibmvscsi_valid_event_struct(&hostdata->pool, evt_struct)) {
+		printk(KERN_ERR
+		       "ibmvscsi: returned correlation_token 0x%p is invalid!\n",
+		       (void *)crq->IU_data_ptr);
+		return;
+	}
+
+	if (crq->format == VIOSRP_SRP_FORMAT)
+		atomic_add(evt_struct->evt->srp.rsp.request_limit_delta,
+			   &hostdata->request_limit);
+
+	if (evt_struct->done)
+		evt_struct->done(evt_struct);
+	else
+		printk(KERN_ERR
+		       "ibmvscsi: returned done() is NULL; not running it!\n");
+
+	/*
+	 * Lock the host_lock before messing with these structures, since we
+	 * are running in a task context
+	 */
+	spin_lock_irqsave(evt_struct->hostdata->host->host_lock, flags);
+	list_del(&evt_struct->list);
+	ibmvscsi_free_event_struct(&evt_struct->hostdata->pool, evt_struct);
+	spin_unlock_irqrestore(evt_struct->hostdata->host->host_lock, flags);
+}
+
+/**
+ * ibmvscsi_get_host_config: Send the command to the server to get host
+ * configuration data.  The data is opaque to us.
+ */
+static int ibmvscsi_do_host_config(struct ibmvscsi_host_data *hostdata,
+				   unsigned char *buffer, int length)
+{
+	struct VIOSRP_HOST_CONFIG host_config;
+	struct srp_event_struct *evt_struct;
+	int rc;
+
+	memset(&host_config, 0x00, sizeof(host_config));
+	host_config.common.type = VIOSRP_HOST_CONFIG_TYPE;
+	host_config.common.length = length;
+	host_config.buffer = dma_map_single(hostdata->dev, buffer, length,
+					    DMA_BIDIRECTIONAL);
+
+	if (pci_dma_mapping_error(host_config.buffer)) {
+		printk(KERN_ERR
+		       "ibmvscsi: dma_mapping error " "getting host config\n");
+		rc = -1;
+	}
+
+	evt_struct = evt_struct_for(&hostdata->pool,
+				    (union VIOSRP_IU *)&host_config,
+				    NULL, sync_completion);
+
+	if (!evt_struct) {
+		printk(KERN_ERR
+		       "ibmvscsi: could't allocate event for HOST_CONFIG!\n");
+		dma_unmap_single(hostdata->dev, host_config.buffer, length,
+				 DMA_BIDIRECTIONAL);
+		rc = -1;
+	} else {
+		evt_struct->crq.format = VIOSRP_MAD_FORMAT;
+		init_completion(&evt_struct->comp);
+		rc = ibmvscsi_send_srp_event(evt_struct, hostdata);
+		if (rc == 0) {
+			wait_for_completion(&evt_struct->comp);
+			dma_unmap_single(hostdata->dev, host_config.buffer, 
+					 length,
+					 DMA_BIDIRECTIONAL);
+		}
+	}
+
+
+	return rc ? rc : host_config.common.status;
+}
+
+/* ------------------------------------------------------------
+ * sysfs attributes
+ */
+static ssize_t show_host_srp_version(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%s\n",
+		       hostdata->madapter_info.srp_version);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_srp_version = {
+	.attr = {
+		 .name = "srp_version",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_srp_version,
+};
+
+static ssize_t show_host_partition_name(struct class_device *class_dev,
+					char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%s\n",
+		       hostdata->madapter_info.partition_name);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_partition_name = {
+	.attr = {
+		 .name = "partition_name",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_partition_name,
+};
+
+static ssize_t show_host_partition_number(struct class_device *class_dev,
+					  char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%d\n",
+		       hostdata->madapter_info.partition_number);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_partition_number = {
+	.attr = {
+		 .name = "partition_number",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_partition_number,
+};
+
+static ssize_t show_host_mad_version(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%d\n",
+		       hostdata->madapter_info.mad_version);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_mad_version = {
+	.attr = {
+		 .name = "mad_version",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_mad_version,
+};
+
+static ssize_t show_host_os_type(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%d\n", hostdata->madapter_info.os_type);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_os_type = {
+	.attr = {
+		 .name = "os_type",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_os_type,
+};
+
+static ssize_t show_host_config(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+
+	/* returns null-terminated host config data */
+	if (ibmvscsi_do_host_config(hostdata, buf, PAGE_SIZE) == 0)
+		return strlen(buf);
+	else
+		return 0;
+}
+
+static struct class_device_attribute ibmvscsi_host_config = {
+	.attr = {
+		 .name = "config",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_config,
+};
+
+static struct class_device_attribute *ibmvscsi_attrs[] = {
+	&ibmvscsi_host_srp_version,
+	&ibmvscsi_host_partition_name,
+	&ibmvscsi_host_partition_number,
+	&ibmvscsi_host_mad_version,
+	&ibmvscsi_host_os_type,
+	&ibmvscsi_host_config,
+	NULL
+};
+
+/* ------------------------------------------------------------
+ * SCSI driver registration
+ */
+static struct scsi_host_template driver_template = {
+	.module = THIS_MODULE,
+	.name = "SCSI host adapter emulator for RPA/iSeries Virtual I/O",
+	.proc_name = "ibmvscsi",
+	.queuecommand = ibmvscsi_queuecommand,
+	.eh_abort_handler = ibmvscsi_eh_abort_handler,
+	.eh_device_reset_handler = ibmvscsi_eh_device_reset_handler,
+	.can_queue = 1,		/* Updated after SRP_LOGIN */
+	.this_id = -1,
+	.sg_tablesize = MAX_INDIRECT_BUFS,
+	.use_clustering = ENABLE_CLUSTERING,
+	.emulated = 1,
+	.shost_attrs = ibmvscsi_attrs,
+};
+
+/**
+ * Called by bus code for each adapter
+ */
+struct ibmvscsi_host_data *ibmvscsi_probe(struct device *dev)
+{
+	struct ibmvscsi_host_data *hostdata;
+	struct Scsi_Host *host;
+	unsigned long wait_switch = 0;
+
+	driver_template.cmd_per_lun = cmd_per_lun,
+	    host = scsi_host_alloc(&driver_template, sizeof(*hostdata));
+	if (!host) {
+		printk(KERN_ERR "ibmvscsi: couldn't allocate host data\n");
+		goto scsi_host_alloc_failed;
+	}
+
+	hostdata = (struct ibmvscsi_host_data *)host->hostdata;
+	memset(hostdata, 0x00, sizeof(*hostdata));
+	INIT_LIST_HEAD(&hostdata->sent);
+	hostdata->host = host;
+	hostdata->dev = dev;
+	atomic_set(&hostdata->request_limit, -1);
+
+	if (ibmvscsi_init_crq_queue(&hostdata->queue, hostdata,
+				    max_requests) != 0) {
+		printk(KERN_ERR "ibmvscsi: couldn't initialize crq\n");
+		goto init_crq_failed;
+	}
+	if (initialize_event_pool(&hostdata->pool,
+				  max_requests, hostdata) != 0) {
+		printk(KERN_ERR "ibmvscsi: couldn't initialize event pool\n");
+		goto init_pool_failed;
+	}
+
+	host->max_lun = 8;
+	host->max_id = max_id;
+	host->max_channel = max_channel;
+
+	if (scsi_add_host(hostdata->host, hostdata->dev))
+		goto add_host_failed;
+
+	/* Try to send an initialization message.  Note that this is allowed
+	 * to fail if the other end is not acive.  In that case we don't
+	 * want to scan
+	 */
+	if (ibmvscsi_send_crq(hostdata, 0xC001000000000000, 0) == 0) {
+		/*
+		 * Wait around max init_timeout secs for the adapter to finish
+		 * initializing. When we are done initializing, we will have a
+		 * valid request_limit.  We don't want Linux scanning before
+		 * we are ready.
+		 */
+		for (wait_switch = jiffies + (init_timeout * HZ);
+		     time_before(jiffies, wait_switch) &&
+		     atomic_read(&hostdata->request_limit) < 0;) {
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(5);
+		}
+
+		/* if we now have a valid request_limit, initiate a scan */
+		if (atomic_read(&hostdata->request_limit) > 0)
+			scsi_scan_host(host);
+	}
+
+	return hostdata;
+
+      add_host_failed:
+	release_event_pool(&hostdata->pool, hostdata);
+      init_pool_failed:
+	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata, max_requests);
+      init_crq_failed:
+	scsi_host_put(host);
+      scsi_host_alloc_failed:
+	return NULL;
+}
+
+void ibmvscsi_remove(struct ibmvscsi_host_data *hostdata)
+{
+	release_event_pool(&hostdata->pool, hostdata);
+	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata, max_requests);
+
+	scsi_remove_host(hostdata->host);
+	scsi_host_put(hostdata->host);
+	return;
+}
diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/ibmvscsi.h ppc64-2.5new/drivers/scsi/ibmvscsi/ibmvscsi.h
--- linux-2.5/drivers/scsi/ibmvscsi/ibmvscsi.h	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/ibmvscsi.h	2004-03-30 18:42:05.000000000 -0600
@@ -0,0 +1,111 @@
+/* ------------------------------------------------------------
+ * ibmvscsi.h
+ * (C) Copyright IBM Corporation 1994, 2003
+ * Authors: Colin DeVilbiss (devilbis@us.ibm.com)
+ *          Santiago Leon (santil@us.ibm.com)
+ *          Dave Boutcher (sleddog@us.ibm.com)
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * ------------------------------------------------------------
+ * Emulation of a SCSI host adapter for Virtual I/O devices
+ *
+ * This driver allows the Linux SCSI peripheral drivers to directly
+ * access devices in the hosting partition, either on an iSeries
+ * hypervisor system or a converged hypervisor system.
+ */
+#ifndef IBMVSCSI_H
+#define IBMVSCSI_H
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include "viosrp.h"
+
+struct scsi_cmnd;
+struct Scsi_Host;
+/**
+ * Work out the number of scatter/gather buffers we support
+ */
+static const struct SRP_CMD *fake_srp_cmd = NULL;
+enum {
+	MAX_INDIRECT_BUFS = (sizeof(fake_srp_cmd->additional_data) -
+			     sizeof(struct indirect_descriptor)) /
+	    sizeof(struct memory_descriptor)
+};
+
+/* ------------------------------------------------------------
+ * Data Structures
+ */
+/* an RPA command/response transport queue */
+struct crq_queue {
+	struct VIOSRP_CRQ *msgs;
+	int size, cur;
+	dma_addr_t msg_token;
+	spinlock_t lock;
+};
+
+/* a unit of work for the hosting partition */
+struct srp_event_struct {
+	union VIOSRP_IU *evt;
+	struct scsi_cmnd *cmnd;
+	struct list_head list;
+	void (*done) (struct srp_event_struct *);
+	struct VIOSRP_CRQ crq;
+	struct ibmvscsi_host_data *hostdata;
+	char in_use;
+	struct SRP_CMD cmd;
+	void (*cmnd_done) (struct scsi_cmnd *);
+	struct completion comp;
+};
+
+/* a pool of event structs for use */
+struct event_pool {
+	struct srp_event_struct *events;
+	u32 size;
+	union VIOSRP_IU *iu_storage;
+	dma_addr_t iu_token;
+};
+
+/* all driver data associated with a host adapter */
+struct ibmvscsi_host_data {
+	atomic_t request_limit;
+	struct device *dev;
+	struct event_pool pool;
+	struct crq_queue queue;
+	struct work_struct srp_task;
+	struct list_head sent;
+	struct Scsi_Host *host;
+	struct MAD_ADAPTER_INFO_DATA madapter_info;
+};
+
+/* routines for managing a command/response queue */
+int ibmvscsi_init_crq_queue(struct crq_queue *queue,
+			    struct ibmvscsi_host_data *hostdata,
+			    int max_requests);
+void ibmvscsi_release_crq_queue(struct crq_queue *queue,
+				struct ibmvscsi_host_data *hostdata,
+				int max_requests);
+void ibmvscsi_handle_crq(struct VIOSRP_CRQ *crq,
+			 struct ibmvscsi_host_data *hostdata);
+int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
+		      u64 word1, u64 word2);
+
+/* Probe/remove routines */
+struct ibmvscsi_host_data *ibmvscsi_probe(struct device *dev);
+void ibmvscsi_remove(struct ibmvscsi_host_data *hostdata);
+
+#endif				/* IBMVSCSI_H */
diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/iseries_vscsi.c ppc64-2.5new/drivers/scsi/ibmvscsi/iseries_vscsi.c
--- linux-2.5/drivers/scsi/ibmvscsi/iseries_vscsi.c	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/iseries_vscsi.c	2004-03-30 17:29:50.000000000 -0600
@@ -0,0 +1,161 @@
+/* ------------------------------------------------------------
+ * iSeries_vscsi.c
+ * (C) Copyright IBM Corporation 1994, 2003
+ * Authors: Colin DeVilbiss (devilbis@us.ibm.com)
+ *          Santiago Leon (santil@us.ibm.com)
+ *          Dave Boutcher (sleddog@us.ibm.com)
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * ------------------------------------------------------------
+ * iSeries-specific functions of the SCSI host adapter for Virtual I/O devices
+ *
+ * This driver allows the Linux SCSI peripheral drivers to directly
+ * access devices in the hosting partition, either on an iSeries
+ * hypervisor system or a converged hypervisor system.
+ */
+
+#include <asm/iSeries/vio.h>
+#include <asm/iSeries/HvLpEvent.h>
+#include <asm/iSeries/HvTypes.h>
+#include <asm/iSeries/HvLpConfig.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include "ibmvscsi.h"
+
+static void noop_release(struct device *dev) {};
+
+/* global variables */
+extern struct device *iSeries_vio_dev;
+static struct ibmvscsi_host_data *single_host_data;
+static struct pci_dev iseries_vscsi_dev = {
+	.dev.bus = &pci_bus_type,
+	.dev.bus_id = "vscsi",
+	.dev.release = noop_release
+};
+
+/* ------------------------------------------------------------
+ * Routines for direct interpartition interaction
+ */
+struct VIOSRPLpEvent {
+	struct HvLpEvent lpevt;	/* 0x00-0x17          */
+	u32 reserved1;		/* 0x18-0x1B; unused  */
+	u16 version;		/* 0x1C-0x1D; unused  */
+	u16 subtype_rc;		/* 0x1E-0x1F; unused  */
+	struct VIOSRP_CRQ crq;	/* 0x20-0x3F          */
+};
+
+/** 
+ * standard interface for handling logical partition events.
+ */
+static void ibmvscsi_handle_event(struct HvLpEvent *lpevt)
+{
+	struct VIOSRPLpEvent *evt = (struct VIOSRPLpEvent *)lpevt;
+
+	if (!evt) {
+		printk(KERN_ERR "ibmvscsi: received null event\n");
+		return;
+	}
+
+	if (single_host_data == NULL) {
+		printk(KERN_ERR
+		       "ibmvscsi: received event, no adapter present\n");
+		return;
+	}
+
+	ibmvscsi_handle_crq(&evt->crq, single_host_data);
+}
+
+/* ------------------------------------------------------------
+ * Routines for driver initialization
+ */
+int ibmvscsi_init_crq_queue(struct crq_queue *queue,
+			    struct ibmvscsi_host_data *hostdata,
+			    int max_requests)
+{
+	int rc;
+
+	rc = viopath_open(viopath_hostLp, viomajorsubtype_scsi, 0);
+	if (rc < 0) {
+		printk("viopath_open failed with rc %d in open_event_path\n",
+		       rc);
+		goto viopath_open_failed;
+	}
+
+	rc = vio_setHandler(viomajorsubtype_scsi, ibmvscsi_handle_event);
+	if (rc < 0) {
+		printk("vio_setHandler failed with rc %d in open_event_path\n",
+		       rc);
+		goto vio_setHandler_failed;
+	}
+	return 0;
+
+      vio_setHandler_failed:
+	viopath_close(viopath_hostLp, viomajorsubtype_scsi,
+		      max_requests);
+      viopath_open_failed:
+	return -1;
+}
+
+void ibmvscsi_release_crq_queue(struct crq_queue *queue,
+				struct ibmvscsi_host_data *hostdata,
+				int max_requests)
+{
+	vio_clearHandler(viomajorsubtype_scsi);
+	viopath_close(viopath_hostLp, viomajorsubtype_scsi,
+		      max_requests);
+}
+
+/**
+ * ibmvscsi_send_crq: - Send a CRQ
+ * @hostdata:	the adapter
+ * @word1:	the first 64 bits of the data
+ * @word2:	the second 64 bits of the data
+ */
+int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
+{
+	single_host_data = hostdata;
+	return HvCallEvent_signalLpEventFast(viopath_hostLp,
+					     HvLpEvent_Type_VirtualIo,
+					     viomajorsubtype_scsi,
+					     HvLpEvent_AckInd_NoAck,
+					     HvLpEvent_AckType_ImmediateAck,
+					     viopath_sourceinst(viopath_hostLp),
+					     viopath_targetinst(viopath_hostLp),
+					     0,
+					     VIOVERSION << 16, word1, word2, 0,
+					     0);
+}
+
+int __init ibmvscsi_module_init(void)
+{
+	iseries_vscsi_dev.sysdata = to_pci_dev(iSeries_vio_dev)->sysdata;
+	if (device_register(&iseries_vscsi_dev.dev)) {
+		printk(KERN_ERR "ibmvscsi: failed to register device\n");
+		return 1;
+	}
+	single_host_data = ibmvscsi_probe(&iseries_vscsi_dev.dev);
+	return (single_host_data == NULL);
+}
+
+void __exit ibmvscsi_module_exit(void)
+{
+	ibmvscsi_remove(single_host_data);
+	device_unregister(&iseries_vscsi_dev.dev);
+}
+
+module_init(ibmvscsi_module_init);
+module_exit(ibmvscsi_module_exit);
--- linux-2.5/drivers/scsi/ibmvscsi/rpa_vscsi.c	2004-03-31 14:02:13.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/rpa_vscsi.c	2004-03-31 14:06:58.000000000 -0600
@@ -0,0 +1,285 @@
+/* ------------------------------------------------------------
+ * rpa_vscsi.c
+ * (C) Copyright IBM Corporation 1994, 2003
+ * Authors: Colin DeVilbiss (devilbis@us.ibm.com)
+ *          Santiago Leon (santil@us.ibm.com)
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * ------------------------------------------------------------
+ * RPA-specific functions of the SCSI host adapter for Virtual I/O devices
+ *
+ * This driver allows the Linux SCSI peripheral drivers to directly
+ * access devices in the hosting partition, either on an iSeries
+ * hypervisor system or a converged hypervisor system.
+ */
+
+#include <asm/vio.h>
+#include <asm/iommu.h>
+#include <asm/hvcall.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include "ibmvscsi.h"
+
+/* ------------------------------------------------------------
+ * Routines for managing the command/response queue
+ */
+/**
+ * ibmvscsi_handle_event: - Interrupt handler for crq events
+ * @irq:	number of irq to handle, not used
+ * @dev_instance: ibmvscsi_host_data of host that received interrupt
+ * @regs:	pt_regs with registers
+ *
+ * Disables interrupts and schedules srp_task
+ * Always returns IRQ_HANDLED
+ */
+static irqreturn_t ibmvscsi_handle_event(int irq,
+					 void *dev_instance,
+					 struct pt_regs *regs)
+{
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)dev_instance;
+	vio_disable_interrupts(to_vio_dev(hostdata->dev));
+	schedule_work(&hostdata->srp_task);
+	return IRQ_HANDLED;
+}
+
+/**
+ * release_crq_queue: - Deallocates data and unregisters CRQ
+ * @queue:	crq_queue to initialize and register
+ * @host_data:	ibmvscsi_host_data of host
+ *
+ * Frees irq, deallocates a page for messages, unmaps dma, and unregisters
+ * the crq with the hypervisor.
+ */
+void ibmvscsi_release_crq_queue(struct crq_queue *queue,
+				struct ibmvscsi_host_data *hostdata,
+				int max_requests)
+{
+	long rc;
+	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+	free_irq(vdev->irq, (void *)hostdata);
+	do {
+		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
+	} while (H_isLongBusy(rc));
+	dma_unmap_single(hostdata->dev,
+			 queue->msg_token,
+			 queue->size * sizeof(*queue->msgs),
+			 PCI_DMA_BIDIRECTIONAL);
+	free_page((unsigned long)queue->msgs);
+}
+
+/**
+ * crq_queue_next_crq: - Returns the next entry in message queue
+ * @queue:	crq_queue to use
+ *
+ * Returns pointer to next entry in queue, or NULL if there are no new 
+ * entried in the CRQ.
+ */
+static struct VIOSRP_CRQ *crq_queue_next_crq(struct crq_queue *queue)
+{
+	struct VIOSRP_CRQ *crq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	crq = &queue->msgs[queue->cur];
+	if (crq->valid & 0x80) {
+		if (++queue->cur == queue->size)
+			queue->cur = 0;
+	} else
+		crq = NULL;
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	return crq;
+}
+
+/**
+ * ibmvscsi_send_crq: - Send a CRQ
+ * @hostdata:	the adapter
+ * @word1:	the first 64 bits of the data
+ * @word2:	the second 64 bits of the data
+ */
+int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
+{
+	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+
+	return plpar_hcall_norets(H_SEND_CRQ, vdev->unit_address, word1, word2);
+}
+
+/**
+ * ibmvscsi_task: - Process srps asynchronously
+ * @data:	ibmvscsi_host_data of host
+ */
+static void ibmvscsi_task(void *data)
+{
+	struct ibmvscsi_host_data *hostdata = (struct ibmvscsi_host_data *)data;
+	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+	struct VIOSRP_CRQ *crq;
+	int done = 0;
+
+	while (!done) {
+		/* Pull all the valid messages off the CRQ */
+		while ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
+			ibmvscsi_handle_crq(crq, hostdata);
+			crq->valid = 0x00;
+		}
+
+		vio_enable_interrupts(vdev);
+		if ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
+			vio_disable_interrupts(vdev);
+			ibmvscsi_handle_crq(crq, hostdata);
+			crq->valid = 0x00;
+		} else {
+			done = 1;
+		}
+	}
+}
+
+/**
+ * initialize_crq_queue: - Initializes and registers CRQ with hypervisor
+ * @queue:	crq_queue to initialize and register
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+ * Allocates a page for messages, maps it for dma, and registers
+ * the crq with the hypervisor.
+ * Returns zero on success.
+ */
+int ibmvscsi_init_crq_queue(struct crq_queue *queue,
+			    struct ibmvscsi_host_data *hostdata,
+			    int max_requests)
+{
+	int rc;
+	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+
+	queue->msgs = (struct VIOSRP_CRQ *)get_zeroed_page(GFP_KERNEL);
+
+	if (!queue->msgs)
+		goto malloc_failed;
+	queue->size = PAGE_SIZE / sizeof(*queue->msgs);
+
+	queue->msg_token = dma_map_single(hostdata->dev, queue->msgs,
+					  queue->size * sizeof(*queue->msgs),
+					  PCI_DMA_BIDIRECTIONAL);
+
+	if (pci_dma_mapping_error(queue->msg_token))
+		goto map_failed;
+
+	rc = plpar_hcall_norets(H_REG_CRQ,
+				vdev->unit_address,
+				queue->msg_token, PAGE_SIZE);
+	if (rc == 2) {
+		/* Adapter is good, but other end is not ready */
+		printk(KERN_WARNING "ibmvscsi: Partner adapter not ready\n");
+	} else if (rc != 0) {
+		printk(KERN_WARNING
+		       "ibmvscsi: couldn't register crq--rc 0x%x\n", rc);
+		goto reg_crq_failed;
+	}
+
+	if (request_irq(vdev->irq,
+			ibmvscsi_handle_event,
+			0, "ibmvscsi", (void *)hostdata) != 0) {
+		printk(KERN_ERR "ibmvscsi: couldn't register irq 0x%x\n",
+		       vdev->irq);
+		goto req_irq_failed;
+	}
+
+	rc = vio_enable_interrupts(vdev);
+	if (rc != 0) {
+		printk(KERN_ERR "ibmvscsi:  Error %d enabling interrupts!!!\n",
+		       rc);
+		goto req_irq_failed;
+	}
+
+	queue->cur = 0;
+	queue->lock = SPIN_LOCK_UNLOCKED;
+
+	INIT_WORK(&hostdata->srp_task, (void *)ibmvscsi_task, hostdata);
+
+	return 0;
+
+      req_irq_failed:
+	plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
+      reg_crq_failed:
+	dma_unmap_single(hostdata->dev,
+			 queue->msg_token,
+			 queue->size * sizeof(*queue->msgs),
+			 PCI_DMA_BIDIRECTIONAL);
+      map_failed:
+	free_page((unsigned long)queue->msgs);
+      malloc_failed:
+	return -1;
+}
+
+/**
+ * rpa_device_table: Used by vio.c to match devices in the device tree we 
+ * support.
+ */
+static struct vio_device_id rpa_device_table[] __devinitdata = {
+	{"scsi-3", "IBM,v-scsi"},	/* Note: This entry can go away when 
+					   all the firmware is up to date */
+	{"vscsi", "IBM,v-scsi"},
+	{0,}
+};
+
+/**
+ * rpa_probe: The callback from the virtual I/O bus code.
+ * @vdev     : The vio specific device structure
+ * @id       : the device id..we don't currently use it
+ */
+static int rpa_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	struct ibmvscsi_host_data *hostdata = ibmvscsi_probe(&vdev->dev);
+	if (hostdata) {
+		vdev->driver_data = hostdata;
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+/**
+ * rpa_remove: The callback from the virtual I/O bus code to remove a device
+ * @vdev     : The vio specific device structure
+ */
+static int rpa_remove(struct vio_dev *vdev)
+{
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)vdev->driver_data;
+	ibmvscsi_remove(hostdata);
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(vio, rpa_device_table);
+static struct vio_driver ibmvscsi_driver = {
+	.name = "ibmvscsi",
+	.id_table = rpa_device_table,
+	.probe = rpa_probe,
+	.remove = rpa_remove
+};
+
+int __init ibmvscsi_module_init(void)
+{
+	return vio_register_driver(&ibmvscsi_driver);
+}
+
+void __exit ibmvscsi_module_exit(void)
+{
+	vio_unregister_driver(&ibmvscsi_driver);
+}
+
+module_init(ibmvscsi_module_init);
+module_exit(ibmvscsi_module_exit);
diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/srp.h ppc64-2.5new/drivers/scsi/ibmvscsi/srp.h
--- linux-2.5/drivers/scsi/ibmvscsi/srp.h	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/srp.h	2004-03-27 16:35:20.000000000 -0600
@@ -0,0 +1,225 @@
+/*****************************************************************************/
+/* srp.h -- SCSI RDMA Protocol definitions                                   */
+/*                                                                           */
+/* Written By: Colin Devilbis, IBM Corporation                               */
+/*                                                                           */
+/* Copyright (C) 2003 IBM Corporation                                        */
+/*                                                                           */
+/* This program is free software; you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by      */
+/* the Free Software Foundation; either version 2 of the License, or         */
+/* (at your option) any later version.                                       */
+/*                                                                           */
+/* This program is distributed in the hope that it will be useful,           */
+/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             */
+/* GNU General Public License for more details.                              */
+/*                                                                           */
+/* You should have received a copy of the GNU General Public License         */
+/* along with this program; if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */
+/*                                                                           */
+/*                                                                           */
+/* This file contains structures and definitions for the SCSI RDMA Protocol  */
+/* (SRP) as defined in the T10 standard available at www.t10.org.  This      */
+/* file was based on the 16a version of the standard                         */
+/*                                                                           */
+/*****************************************************************************/
+#ifndef SRP_H
+#define SRP_H
+
+#define PACKED __attribute__((packed))
+
+enum SRP_TYPES {
+	SRP_LOGIN_REQ_TYPE = 0x00,
+	SRP_LOGIN_RSP_TYPE = 0xC0,
+	SRP_LOGIN_REJ_TYPE = 0x80,
+	SRP_I_LOGOUT_TYPE = 0x03,
+	SRP_T_LOGOUT_TYPE = 0x80,
+	SRP_TSK_MGMT_TYPE = 0x01,
+	SRP_CMD_TYPE = 0x02,
+	SRP_RSP_TYPE = 0xC1,
+	SRP_CRED_REQ_TYPE = 0x81,
+	SRP_CRED_RSP_TYPE = 0x41,
+	SRP_AER_REQ_TYPE = 0x82,
+	SRP_AER_RSP_TYPE = 0x42
+};
+
+enum SRP_DESCRIPTOR_FORMATS {
+	SRP_NO_BUFFER = 0x00,
+	SRP_DIRECT_BUFFER = 0x01,
+	SRP_INDIRECT_BUFFER = 0x02
+};
+
+struct memory_descriptor {
+	u64 virtual_address;
+	u32 memory_handle;
+	u32 length;
+};
+
+struct indirect_descriptor {
+	struct memory_descriptor head;
+	u64 total_length;
+	struct memory_descriptor list[1];
+};
+
+struct SRP_GENERIC {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+};
+
+struct SRP_LOGIN_REQ {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+	u32 max_requested_initiator_to_target_iulen;
+	u32 reserved2;
+	u16 required_buffer_formats;
+	u8 reserved3:6;
+	u8 multi_channel_action:2;
+	u8 reserved4;
+	u32 reserved5;
+	u8 initiator_port_identifier[16];
+	u8 target_port_identifier[16];
+};
+
+struct SRP_LOGIN_RSP {
+	u8 type;
+	u8 reserved1[3];
+	u32 request_limit_delta;
+	u64 tag;
+	u32 max_initiator_to_target_iulen;
+	u32 max_target_to_initiator_iulen;
+	u16 supported_buffer_formats;
+	u8 reserved2:6;
+	u8 multi_channel_result:2;
+	u8 reserved3;
+	u8 reserved4[24];
+};
+
+struct SRP_LOGIN_REJ {
+	u8 type;
+	u8 reserved1[3];
+	u32 reason;
+	u64 tag;
+	u64 reserved2;
+	u16 supported_buffer_formats;
+	u8 reserved3[6];
+};
+
+struct SRP_I_LOGOUT {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+};
+
+struct SRP_T_LOGOUT {
+	u8 type;
+	u8 reserved1[3];
+	u32 reason;
+	u64 tag;
+};
+
+struct SRP_TSK_MGMT {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+	u32 reserved2;
+	u64 lun PACKED;
+	u8 reserved3;
+	u8 reserved4;
+	u8 task_mgmt_flags;
+	u8 reserved5;
+	u64 managed_task_tag;
+	u64 reserved6;
+};
+
+struct SRP_CMD {
+	u8 type;
+	u32 reserved1 PACKED;
+	u8 data_out_format:4;
+	u8 data_in_format:4;
+	u8 data_out_count;
+	u8 data_in_count;
+	u64 tag;
+	u32 reserved2;
+	u64 lun PACKED;
+	u8 reserved3;
+	u8 reserved4:5;
+	u8 task_attribute:3;
+	u8 reserved5;
+	u8 additional_cdb_len;
+	u8 cdb[16];
+	u8 additional_data[0x100 - 0x30];
+};
+
+struct SRP_RSP {
+	u8 type;
+	u8 reserved1[3];
+	u32 request_limit_delta;
+	u64 tag;
+	u16 reserved2;
+	u8 reserved3:2;
+	u8 diunder:1;
+	u8 diover:1;
+	u8 dounder:1;
+	u8 doover:1;
+	u8 snsvalid:1;
+	u8 rspvalid:1;
+	u8 status;
+	u32 data_in_residual_count;
+	u32 data_out_residual_count;
+	u32 sense_data_list_length;
+	u32 response_data_list_length;
+	u8 sense_and_response_data[18];
+};
+
+struct SRP_CRED_REQ {
+	u8 type;
+	u8 reserved1[3];
+	u32 request_limit_delta;
+	u64 tag;
+};
+
+struct SRP_CRED_RSP {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+};
+
+struct SRP_AER_REQ {
+	u8 type;
+	u8 reserved1[3];
+	u32 request_limit_delta;
+	u64 tag;
+	u32 reserved2;
+	u64 lun;
+	u32 sense_data_list_length;
+	u32 reserved3;
+	u8 sense_data[20];
+};
+
+struct SRP_AER_RSP {
+	u8 type;
+	u8 reserved1[7];
+	u64 tag;
+};
+
+union SRP_IU {
+	struct SRP_GENERIC generic;
+	struct SRP_LOGIN_REQ login_req;
+	struct SRP_LOGIN_RSP login_rsp;
+	struct SRP_LOGIN_REJ login_rej;
+	struct SRP_I_LOGOUT i_logout;
+	struct SRP_T_LOGOUT t_logout;
+	struct SRP_TSK_MGMT tsk_mgmt;
+	struct SRP_CMD cmd;
+	struct SRP_RSP rsp;
+	struct SRP_CRED_REQ cred_req;
+	struct SRP_CRED_RSP cred_rsp;
+	struct SRP_AER_REQ aer_req;
+	struct SRP_AER_RSP aer_rsp;
+};
+
+#endif
diff -uNr --exclude=SCCS linux-2.5/drivers/scsi/ibmvscsi/viosrp.h ppc64-2.5new/drivers/scsi/ibmvscsi/viosrp.h
--- linux-2.5/drivers/scsi/ibmvscsi/viosrp.h	1969-12-31 18:00:00.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/ibmvscsi/viosrp.h	2004-03-27 16:37:18.000000000 -0600
@@ -0,0 +1,126 @@
+/*****************************************************************************/
+/* srp.h -- SCSI RDMA Protocol definitions                                   */
+/*                                                                           */
+/* Written By: Colin Devilbis, IBM Corporation                               */
+/*                                                                           */
+/* Copyright (C) 2003 IBM Corporation                                        */
+/*                                                                           */
+/* This program is free software; you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by      */
+/* the Free Software Foundation; either version 2 of the License, or         */
+/* (at your option) any later version.                                       */
+/*                                                                           */
+/* This program is distributed in the hope that it will be useful,           */
+/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             */
+/* GNU General Public License for more details.                              */
+/*                                                                           */
+/* You should have received a copy of the GNU General Public License         */
+/* along with this program; if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */
+/*                                                                           */
+/*                                                                           */
+/* This file contains structures and definitions for IBM RPA (RS/6000        */
+/* platform architecture) implementation of the SRP (SCSI RDMA Protocol)     */
+/* standard.  SRP is used on IBM iSeries and pSeries platforms to send SCSI  */
+/* commands between logical partitions.                                      */
+/*                                                                           */
+/* SRP Information Units (IUs) are sent on a "Command/Response Queue" (CRQ)  */
+/* between partitions.  The definitions in this file are architected,        */
+/* and cannot be changed without breaking compatibility with other versions  */
+/* of Linux and other operating systems (AIX, OS/400) that talk this protocol*/
+/* between logical partitions                                                */
+/*****************************************************************************/
+#ifndef VIOSRP_H
+#define VIOSRP_H
+#include "srp.h"
+
+enum VIOSRP_CRQ_FORMATS {
+	VIOSRP_SRP_FORMAT = 0x01,
+	VIOSRP_MAD_FORMAT = 0x02,
+	VIOSRP_OS400_FORMAT = 0x03,
+	VIOSRP_AIX_FORMAT = 0x04,
+	VIOSRP_LINUX_FORMAT = 0x06,
+	VIOSRP_INLINE_FORMAT = 0x07
+};
+
+struct VIOSRP_CRQ {
+	u8 valid;		/* used by RPA */
+	u8 format;		/* SCSI vs out-of-band */
+	u8 reserved;
+	u8 status;		/* non-scsi failure? (e.g. DMA failure) */
+	u16 timeout;		/* in seconds */
+	u16 IU_length;		/* in bytes */
+	u64 IU_data_ptr;	/* the TCE for transferring data */
+};
+
+/* MADs are Management requests above and beyond the IUs defined in the SRP
+ * standard.  
+ */
+enum VIOSRP_MAD_TYPES {
+	VIOSRP_EMPTY_IU_TYPE = 0x01,
+	VIOSRP_ERROR_LOG_TYPE = 0x02,
+	VIOSRP_ADAPTER_INFO_TYPE = 0x03,
+	VIOSRP_HOST_CONFIG_TYPE = 0x04
+};
+
+/* 
+ * Common MAD header
+ */
+struct MAD_COMMON {
+	u32 type;
+	u16 status;
+	u16 length;
+	u64 tag;
+};
+
+/*
+ * All SRP (and MAD) requests normally flow from the
+ * client to the server.  There is no way for the server to send
+ * an asynchronous message back to the client.  The Empty IU is used
+ * to hang out a meaningless request to the server so that it can respond
+ * asynchrouously with something like a SCSI AER 
+ */
+struct VIOSRP_EMPTY_IU {
+	struct MAD_COMMON common;
+	u64 buffer;
+	u32 port;
+};
+
+struct VIOSRP_ERROR_LOG {
+	struct MAD_COMMON common;
+	u64 buffer;
+};
+
+struct VIOSRP_ADAPTER_INFO {
+	struct MAD_COMMON common;
+	u64 buffer;
+};
+
+struct VIOSRP_HOST_CONFIG {
+	struct MAD_COMMON common;
+	u64 buffer;
+};
+
+union MAD_IU {
+	struct VIOSRP_EMPTY_IU empty_iu;
+	struct VIOSRP_ERROR_LOG error_log;
+	struct VIOSRP_ADAPTER_INFO adapter_info;
+	struct VIOSRP_HOST_CONFIG host_config;
+};
+
+union VIOSRP_IU {
+	union SRP_IU srp;
+	union MAD_IU mad;
+};
+
+struct MAD_ADAPTER_INFO_DATA {
+	char srp_version[8];
+	char partition_name[96];
+	u32 partition_number;
+	u32 mad_version;
+	u32 os_type;
+	u32 port_max_txu[8];	/* per-port maximum transfer */
+};
+
+#endif
--- linux-2.5/drivers/scsi/Kconfig	2004-03-31 13:59:50.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/Kconfig	2004-03-31 14:13:10.000000000 -0600
@@ -752,6 +752,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called ips.
 
+config SCSI_IBMVSCSI
+	tristate "IBM Virtual SCSI support"
+	depends on PPC_PSERIES || PPC_ISERIES
+	help
+	  This is the IBM Virtual SCSI Client
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ibmvscsic.
+
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
 	depends on PCI && SCSI && BROKEN
--- linux-2.5/drivers/scsi/Makefile	2004-03-31 13:59:33.000000000 -0600
+++ ppc64-2.5new/drivers/scsi/Makefile	2004-03-31 14:14:20.000000000 -0600
@@ -123,6 +123,7 @@
 obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
+obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
 
 obj-$(CONFIG_ARM)		+= arm/
 

------------fjD33O9GjmkoJ05x3BjcJG--

