Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWEIV2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWEIV2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWEIV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:28:45 -0400
Received: from mail.hypersurf.com ([209.237.0.6]:3591 "EHLO mail.hypersurf.com")
	by vger.kernel.org with ESMTP id S1751062AbWEIV2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:28:42 -0400
Message-Id: <200605092128.k49LSQ6R024308@mail.hypersurf.com>
Reply-To: <amah@highpoint-tech.com>
From: "Allen" <amah@highpoint-tech.com>
To: <linux-scsi@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Date: Tue, 9 May 2006 14:28:31 -0700
Organization: HighPoint Technologies, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZzUcWE419Jx/ePRWaamWkCJnlD8AAXZbBg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first time driver submission of HighPoint RocketRAID 3xxx
controllers.

Signed-off-by: HighPoint Linux Team <linux@highpoint-tech.com>
---
 Documentation/scsi/hptiop.txt |   92 +++
 MAINTAINERS                   |    6 
 drivers/scsi/Kconfig          |    9 
 drivers/scsi/Makefile         |    1 
 drivers/scsi/hptiop.c         | 1475
+++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/hptiop.h         |  524 +++++++++++++++
 6 files changed, 2107 insertions(+), 0 deletions(-)

diff --git a/Documentation/scsi/hptiop.txt b/Documentation/scsi/hptiop.txt
new file mode 100644
index 0000000..7347a41
--- /dev/null
+++ b/Documentation/scsi/hptiop.txt
@@ -0,0 +1,92 @@
+HIGHPOINT ROCKETRAID 3xxx RAID DRIVER (hptiop)
+
+Controller Register Map
+-------------------------
+
+The controller IOP is accessed via PCI BAR0.
+
+     BAR0 offset    Register
+            0x10    Inbound Message Register 0
+            0x14    Inbound Message Register 1
+            0x18    Outbound Message Register 0
+            0x1C    Outbound Message Register 1
+            0x20    Inbound Doorbell Register
+            0x24    Inbound Interrupt Status Register
+            0x28    Inbound Interrupt Mask Register
+            0x30    Outbound Interrupt Status Register
+            0x34    Outbound Interrupt Mask Register
+            0x40    Inbound Queue Port
+            0x44    Outbound Queue Port
+
+
+I/O Request Workflow
+----------------------
+
+All queued requests are handled via inbound/outbound queue port.
+A request packet can be allocated in either IOP or host memory.
+
+To send a request to the controller:
+
+    - Get a free request packet by reading the inbound queue port or
+      allocate a free request in host DMA coherent memory.
+
+      The value returned from the inbound queue port is an offset
+      relative to the IOP BAR0.
+
+      Requests allocated in host memory must be aligned on 32-bytes
boundary.
+
+    - Fill the packet.
+
+    - Post the packet to IOP by writing it to inbound queue. For requests
+      allocated in IOP memory, write the offset to inbound queue port. For
+      requests allocated in host memory, write (0x80000000|(bus_addr>>5))
+      to the inbound queue port.
+
+    - The IOP process the request. When the request is completed, it
+      will be put into outbound queue. An outbound interrupt will be
+      generated.
+
+      For requests allocated in IOP memory, the request offset is posted to
+      outbound queue.
+
+      For requests allocated in host memory, (0x80000000|(bus_addr>>5))
+      is posted to the outbound queue. If IOP_REQUEST_FLAG_OUTPUT_CONTEXT
+      flag is set in the request, the low 32-bit context value will be
+      posted instead.
+
+    - The host read the outbound queue and complete the request.
+
+      For requests allocated in IOP memory, the host driver free the
request
+      by writing it to the outbound queue.
+
+Non-queued requests (reset/flush etc) can be sent via inbound message
+register 0. An outbound message with the same value indicates the
completion
+of an inbouind message.
+
+
+User-level Interface
+---------------------
+
+The driver expose following sysfs attributes:
+
+     NAME                 R/W    Description
+     driver-version        R     driver version string
+     firmware-version      R     firmware version string
+     device-list           R     list all devices
+     ioctl                 W     driver interface for management software
+
+The 'ioctl' node acts as a general binary interface between the IOP
firmware
+and HighPoint RAID management software. New management functions can be
+implemented in application/firmware without modification in driver code.
+
+
+---------------------------------------------------------------------------
--
+Copyright (C) 2006 HighPoint Technologies, Inc. All Rights Reserved.
+
+  This file is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  linux@highpoint-tech.com
+  http://www.highpoint-tech.com
diff --git a/MAINTAINERS b/MAINTAINERS
index d6a8e5b..720b2a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1126,6 +1126,12 @@ L: linux-hams@vger.kernel.org
 W: http://www.nt.tuwien.ac.at/~kkudielk/Linux/
 S: Maintained
 
+HIGHPOINT ROCKETRAID 3xxx RAID DRIVER
+P: HighPoint Linux Team
+M: linux@highpoint-tech.com
+W: http://www.highpoint-tech.com
+S: Supported
+
 HIPPI
 P: Jes Sorensen
 M: jes@trained-monkey.org
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a480a37..11b6b9e 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -532,6 +532,15 @@ config SCSI_PDC_ADMA
 
    If unsure, say N.
 
+config SCSI_HPTIOP
+ tristate "HighPoint RocketRAID 3xxx Controller support"
+ depends on SCSI && PCI
+ help
+   This option enables support for HighPoint RocketRAID 3xxx
+   controllers.
+
+   If unsure, say N.
+
 config SCSI_SATA_QSTOR
  tristate "Pacific Digital SATA QStor support"
  depends on SCSI_SATA && PCI
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 81803a1..e7de6a0 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_SCSI_SATA_NV) += libata.o s
 obj-$(CONFIG_SCSI_SATA_ULI) += libata.o sata_uli.o
 obj-$(CONFIG_SCSI_SATA_MV) += libata.o sata_mv.o
 obj-$(CONFIG_SCSI_PDC_ADMA) += libata.o pdc_adma.o
+obj-$(CONFIG_SCSI_HPTIOP) += hptiop.o
 
 obj-$(CONFIG_ARM)  += arm/
 
diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
new file mode 100644
index 0000000..437154c
--- /dev/null
+++ b/drivers/scsi/hptiop.c
@@ -0,0 +1,1475 @@
+/*
+ * HighPoint RR3xxx controller driver for Linux
+ * Copyright (C) 2006 HighPoint Technologies, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Please report bugs/comments/suggestions to linux@highpoint-tech.com
+ *
+ * For more information, visit http://www.highpoint-tech.com
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+#include <linux/hdreg.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_tcq.h>
+#include <scsi/scsi_host.h>
+
+#include "hptiop.h"
+
+MODULE_AUTHOR("HighPoint Technologies, Inc.");
+MODULE_DESCRIPTION("HighPoint RocketRAID 3xxx SATA Controller Driver");
+
+static char driver_name[] = "hptiop";
+static const char driver_name_long[] = "RocketRAID 3xxx SATA Controller
driver";
+static const char driver_ver[] = "v1.0 (060426)";
+
+static void hptiop_host_request_callback(struct hptiop_hba * hba, u32 tag);
+static void hptiop_iop_request_callback(struct hptiop_hba * hba, u32 tag);
+static void hptiop_message_callback(struct hptiop_hba * hba, u32 msg);
+
+static int iop_wait_ready(struct hpt_iopmu __iomem * iop, u32 millisec)
+{
+ u32 req = 0;
+ int i;
+
+ for (i = 0; i < millisec; i++) {
+  req = readl(&iop->inbound_queue);
+   if (req != IOPMU_QUEUE_EMPTY)
+   break;
+  mdelay(1);
+ }
+
+ if (req != IOPMU_QUEUE_EMPTY) {
+  writel(req, &iop->outbound_queue);
+  return 0;
+ }
+
+ return -1;
+}
+
+static void inline hptiop_request_callback(struct hptiop_hba * hba, u32
tag)
+{
+ if ((tag & IOPMU_QUEUE_MASK_HOST_BITS) == IOPMU_QUEUE_ADDR_HOST_BIT)
+  return hptiop_host_request_callback(hba,
+    tag & ~IOPMU_QUEUE_ADDR_HOST_BIT);
+ else
+  return hptiop_iop_request_callback(hba, tag);
+}
+
+static inline void hptiop_drain_outbound_queue(struct hptiop_hba * hba)
+{
+ u32 req;
+
+ while ((req = readl(&hba->iop->outbound_queue)) != IOPMU_QUEUE_EMPTY) {
+
+  if (req & IOPMU_QUEUE_MASK_HOST_BITS)
+   hptiop_request_callback(hba, req);
+  else {
+   struct hpt_iop_request_header __iomem * p;
+
+   p = (struct hpt_iop_request_header __iomem *)
+    ((char __iomem *)hba->iop + req);
+
+   if (readl(&p->flags) & IOP_REQUEST_FLAG_SYNC_REQUEST) {
+    if (readl(&p->context))
+     hptiop_request_callback(hba, req);
+    else
+     writel(1, &p->context);
+   }
+   else
+    hptiop_request_callback(hba, req);
+  }
+ }
+}
+
+static int __iop_intr(struct hptiop_hba * hba)
+{
+ struct hpt_iopmu __iomem * iop = hba->iop;
+ u32 status;
+ int ret = 0;
+
+ status = readl(&iop->outbound_intstatus);
+
+ if (status & IOPMU_OUTBOUND_INT_MSG0) {
+  u32 msg = readl(&iop->outbound_msgaddr0);
+  dprintk("received outbound msg %x\n", msg);
+  writel(IOPMU_OUTBOUND_INT_MSG0, &iop->outbound_intstatus);
+  hptiop_message_callback(hba, msg);
+  ret = 1;
+ }
+
+ if (status & IOPMU_OUTBOUND_INT_POSTQUEUE) {
+  hptiop_drain_outbound_queue(hba);
+  ret = 1;
+ }
+
+ return ret;
+}
+
+static int iop_send_sync_request(struct hptiop_hba * hba,
+     void __iomem * _req, u32 millisec)
+{
+ struct hpt_iop_request_header __iomem * req = _req;
+ u32 i;
+
+ writel(readl(&req->flags) | IOP_REQUEST_FLAG_SYNC_REQUEST,
+   &req->flags);
+
+ writel(0, &req->context);
+
+ writel((unsigned long)req - (unsigned long)hba->iop,
+   &hba->iop->inbound_queue);
+
+ for (i = 0; i < millisec; i++) {
+  __iop_intr(hba);
+  if (readl(&req->context))
+   return 0;
+  mdelay(1);
+ }
+
+ return -1;
+}
+
+static int iop_send_sync_msg(struct hptiop_hba * hba, u32 msg, u32
millisec)
+{
+ u32 i;
+
+ hba->msg_done = 0;
+
+ writel(msg, &hba->iop->inbound_msgaddr0);
+
+ for (i = 0; i < millisec; i++) {
+  __iop_intr(hba);
+  if (hba->msg_done)
+   break;
+  mdelay(1);
+ }
+
+ return hba->msg_done? 0 : -1;
+}
+
+static int iop_get_config(struct hptiop_hba * hba,
+    struct hpt_iop_request_get_config * config)
+{
+ u32 req32;
+ struct hpt_iop_request_get_config __iomem * req;
+
+ req32 = readl(&hba->iop->inbound_queue);
+ if (req32 == IOPMU_QUEUE_EMPTY)
+  return -1;
+
+ req = (struct hpt_iop_request_get_config __iomem *)
+   ((unsigned long)hba->iop + req32);
+
+ writel(0, &req->header.flags);
+ writel(IOP_REQUEST_TYPE_GET_CONFIG, &req->header.type);
+ writel(sizeof(struct hpt_iop_request_get_config), &req->header.size);
+ writel(IOP_RESULT_PENDING, &req->header.result);
+
+ if (iop_send_sync_request(hba, req, 20000)) {
+  dprintk("Get config send cmd failed\n");
+  return -1;
+ }
+
+ memcpy_fromio(config, req, sizeof(*config));
+ writel(req32, &hba->iop->outbound_queue);
+ return 0;
+}
+
+static int iop_set_config(struct hptiop_hba * hba,
+    struct hpt_iop_request_set_config * config)
+{
+ u32 req32;
+ struct hpt_iop_request_set_config __iomem * req;
+
+ req32 = readl(&hba->iop->inbound_queue);
+ if (req32 == IOPMU_QUEUE_EMPTY)
+  return -1;
+
+ req = (struct hpt_iop_request_set_config __iomem *)
+   ((unsigned long)hba->iop + req32);
+
+ memcpy_toio((u8 __iomem *)req + sizeof(struct hpt_iop_request_header),
+  (u8 *)config + sizeof(struct hpt_iop_request_header),
+  sizeof(struct hpt_iop_request_set_config) -
+   sizeof(struct hpt_iop_request_header));
+
+ writel(0, &req->header.flags);
+ writel(IOP_REQUEST_TYPE_SET_CONFIG, &req->header.type);
+ writel(sizeof(struct hpt_iop_request_set_config), &req->header.size);
+ writel(IOP_RESULT_PENDING, &req->header.result);
+
+ if (iop_send_sync_request(hba, req, 20000)) {
+  dprintk("Set config send cmd failed\n");
+  return -1;
+ }
+
+ writel(req32, &hba->iop->outbound_queue);
+ return 0;
+}
+
+static int hptiop_initialize_iop(struct hptiop_hba * hba)
+{
+ struct hpt_iopmu __iomem *  iop = hba->iop;
+
+ /* enable interrupts */
+ writel(~(IOPMU_OUTBOUND_INT_POSTQUEUE|IOPMU_OUTBOUND_INT_MSG0),
+   &iop->outbound_intmask);
+
+ hba->initialized = 1;
+
+ /* start background tasks */
+ if (iop_send_sync_msg(hba,
+   IOPMU_INBOUND_MSG0_START_BACKGROUND_TASK, 5000)) {
+  printk(KERN_ERR "scsi%d: fail to start background task\n",
+   hba->host->host_no);
+  return -1;
+ }
+ return 0;
+}
+
+static int hptiop_map_pci_bar(struct hptiop_hba * hba)
+{
+ u8 cmd;
+ u32 mem_base_phy, length;
+ void __iomem * mem_base_virt;
+ struct pci_dev *pcidev = hba->pcidev;
+
+ pci_read_config_byte(pcidev, PCI_COMMAND, &cmd);
+ pci_write_config_byte(pcidev, PCI_COMMAND,
+   cmd | PCI_COMMAND_MASTER |
+   PCI_COMMAND_MEMORY | PCI_COMMAND_INVALIDATE);
+
+ if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_MEM)) {
+  printk(KERN_ERR "scsi%d: pci resource invalid\n",
+    hba->host->host_no);
+  return -1;
+ }
+
+ mem_base_phy = pci_resource_start(pcidev, 0);
+ length = pci_resource_len(pcidev, 0);
+ mem_base_virt = ioremap(mem_base_phy, length);
+
+ if (!mem_base_virt) {
+  printk(KERN_ERR "scsi%d: Fail to ioremap memory space\n",
+    hba->host->host_no);
+  return -1;
+ }
+
+ hba->iop = mem_base_virt;
+ dprintk("hptiop_map_pci_bar: iop=%p\n", hba->iop);
+ return 0;
+}
+
+static void hptiop_message_callback(struct hptiop_hba * hba, u32 msg)
+{
+ dprintk("iop message 0x%x\n", msg);
+
+ if (!hba->initialized)
+  return;
+
+ if (msg == IOPMU_INBOUND_MSG0_RESET) {
+  atomic_set(&hba->resetting, 0);
+  wake_up(&hba->reset_wq);
+ }
+ else if (msg <= IOPMU_INBOUND_MSG0_MAX)
+  hba->msg_done = 1;
+}
+
+static inline struct hptiop_request * get_req(struct hptiop_hba * hba)
+{
+ struct hptiop_request * ret;
+
+ dprintk("get_req : req=%p\n", hba->req_list);
+
+ ret = hba->req_list;
+ if (ret)
+  hba->req_list = ret->next;
+
+ return ret;
+}
+
+static inline void free_req(struct hptiop_hba *hba, struct hptiop_request
*req)
+{
+ dprintk("free_req(%d, %p)\n", req->index, req);
+ req->next = hba->req_list;
+ hba->req_list = req;
+}
+
+static void hptiop_host_request_callback(struct hptiop_hba * hba, u32 tag)
+{
+ struct hpt_iop_request_scsi_command * req;
+ struct scsi_cmnd *scp;
+
+ req = (struct hpt_iop_request_scsi_command *)hba->reqs[tag].req_virt;
+ dprintk("hptiop_request_callback: req=%p, type=%d, "
+   "result=%d, context=0x%x tag=%d\n",
+   req, req->header.type, req->header.result,
+   req->header.context, tag);
+
+ BUG_ON(!req->header.result);
+ BUG_ON(req->header.type != IOP_REQUEST_TYPE_SCSI_COMMAND);
+
+ scp = hba->reqs[tag].scp;
+
+ if (HPT_SCP(scp)->mapped) {
+  if (scp->use_sg)
+   pci_unmap_sg(hba->pcidev,
+    (struct scatterlist *)scp->request_buffer,
+    scp->use_sg,
+    scp->sc_data_direction
+   );
+  else
+   pci_unmap_single(hba->pcidev,
+    HPT_SCP(scp)->dma_handle,
+    scp->request_bufflen,
+    scp->sc_data_direction
+   );
+ }
+
+ switch(req->header.result) {
+ case IOP_RESULT_SUCCESS:
+  scp->result = (DID_OK<<16);
+  break;
+ case IOP_RESULT_BAD_TARGET:
+  scp->result = (DID_BAD_TARGET<<16);
+  break;
+ case IOP_RESULT_BUSY:
+  scp->result = (DID_BUS_BUSY<<16);
+  break;
+ case IOP_RESULT_RESET:
+  scp->result = (DID_RESET<<16);
+  break;
+ case IOP_RESULT_FAIL:
+  scp->result = (DID_ERROR<<16);
+  break;
+ case IOP_RESULT_INVALID_REQUEST:
+  scp->result = (DID_ABORT<<16);
+  break;
+ case IOP_RESULT_MODE_SENSE_CHECK_CONDITION:
+  scp->result = SAM_STAT_CHECK_CONDITION;
+  memset(&scp->sense_buffer,
+    0, sizeof(scp->sense_buffer));
+  memcpy(&scp->sense_buffer,
+   &req->sg_list, req->dataxfer_length);
+  break;
+
+ default:
+  scp->result = ((DRIVER_INVALID|SUGGEST_ABORT)<<24) |
+     (DID_ABORT<<16);
+  break;
+ }
+
+ dprintk("scsi_done(%p)\n", scp);
+ scp->scsi_done(scp);
+ free_req(hba, &hba->reqs[tag]);
+ atomic_dec(&hba->outstandingcommands);
+}
+
+void hptiop_iop_request_callback(struct hptiop_hba * hba, u32 tag)
+{
+ struct hpt_iop_request_header __iomem * req;
+ struct hpt_iop_request_ioctl_command __iomem * p;
+ struct hpt_ioctl_k *arg;
+
+ req = (struct hpt_iop_request_header __iomem *)
+   ((unsigned long)hba->iop + tag);
+ dprintk("hptiop_request_callback: req=%p, type=%d, "
+   "result=%d, context=0x%x tag=%d\n",
+   req, readl(&req->type), readl(&req->result),
+   readl(&req->context), tag);
+
+ BUG_ON(!readl(&req->result));
+ BUG_ON(readl(&req->type) != IOP_REQUEST_TYPE_IOCTL_COMMAND);
+
+ p = (struct hpt_iop_request_ioctl_command __iomem *)req;
+ arg = (struct hpt_ioctl_k *)(unsigned long)
+  (readl(&req->context) |
+   ((u64)readl(&req->context_hi32)<<32));
+
+ if (readl(&req->result) == IOP_RESULT_SUCCESS) {
+  arg->result = HPT_IOCTL_RESULT_OK;
+
+  if (arg->outbuf_size)
+   memcpy_fromio(arg->outbuf,
+    &p->buf[(readl(&p->inbuf_size) + 3)& ~3],
+    arg->outbuf_size);
+
+  if (arg->bytes_returned)
+   *arg->bytes_returned = arg->outbuf_size;
+ }
+ else
+  arg->result = HPT_IOCTL_RESULT_FAILED;
+
+ arg->done(arg);
+ writel(tag, &hba->iop->outbound_queue);
+}
+
+static irqreturn_t hptiop_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+ struct hptiop_hba * hba = (struct hptiop_hba *)dev_id;
+ int  handled = 0;
+ unsigned long flags;
+
+ spin_lock_irqsave(hba->host->host_lock, flags);
+ handled = __iop_intr(hba);
+ spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+ return handled;
+}
+
+static int hptiop_buildsgl(struct scsi_cmnd *scp, struct hpt_iopsg *psg)
+{
+ int sg_count = 0;
+ struct hpt_iopsg *psg_start = psg;
+ struct Scsi_Host *host = scp->device->host;
+ struct hptiop_hba *hba = (struct hptiop_hba *)host->hostdata;
+ struct scatterlist *sglist = (struct scatterlist *)scp->request_buffer;
+
+ if (scp->use_sg) {
+  u64 addr, last = 0;
+  unsigned int length;
+  int idx;
+
+  HPT_SCP(scp)->sgcnt = pci_map_sg(hba->pcidev,
+    sglist, scp->use_sg,
+    scp->sc_data_direction);
+  HPT_SCP(scp)->mapped = 1;
+  BUG_ON(HPT_SCP(scp)->sgcnt > hba->max_sg_descriptors);
+
+  psg--;
+  for (idx = 0; idx < HPT_SCP(scp)->sgcnt; idx++) {
+   addr = sg_dma_address(&sglist[idx]);
+   length = sg_dma_len(&sglist[idx]);
+   /* merge the sg elements if possible */
+   if (idx && last==addr && psg->size &&
+    psg->size + length <= 0x10000 &&
+    (addr & 0xffffffff) != 0) {
+    psg->size += length;
+    last += length;
+   }
+   else {
+    psg++;
+    psg->pci_address = addr;
+    psg->size = length;
+    last = addr + length;
+   }
+   psg->eot = (idx == HPT_SCP(scp)->sgcnt - 1)? 1 : 0;
+  }
+
+  sg_count = psg - psg_start + 1;
+  BUG_ON(sg_count > hba->max_sg_descriptors);
+ } else {
+  HPT_SCP(scp)->dma_handle = pci_map_single(
+    hba->pcidev,
+    scp->request_buffer,
+    scp->request_bufflen,
+    scp->sc_data_direction
+   );
+  HPT_SCP(scp)->mapped = 1;
+  psg->pci_address = HPT_SCP(scp)->dma_handle;
+  psg->size = (u32)scp->request_bufflen;
+  psg->eot = 1;
+  sg_count = 1;
+ }
+ return sg_count;
+}
+
+static int hptiop_queuecommand(struct scsi_cmnd * scp,
+    void (*done) (struct scsi_cmnd *))
+{
+ struct Scsi_Host *host = scp->device->host;
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+ struct hpt_iop_request_scsi_command * req;
+ int sg_count = 0;
+ struct hptiop_request * _req;
+
+ BUG_ON(!done);
+ scp->scsi_done = done;
+
+ /*
+  * hptiop_shutdown will flash controller cache.
+  */
+ if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
+  scp->result = DID_OK<<16;
+  goto cmd_done;
+ }
+
+ _req = get_req(hba);
+ if (_req == NULL) {
+  dprintk("hptiop_queuecmd : no free req\n");
+  scp->result = DID_BUS_BUSY << 16;
+  goto cmd_done;
+ }
+
+ _req->scp = scp;
+
+ dprintk("hptiop_queuecmd(scp=%p) %d/%d/%d/%d cdb=(%x-%x-%x) "
+   "req_index=%d, req=%p\n",
+   scp,
+   host->host_no, scp->device->channel,
+   scp->device->id, scp->device->lun,
+   *((u32 *)&scp->cmnd),
+   *((u32 *)&scp->cmnd + 1),
+   *((u32 *)&scp->cmnd + 2),
+   _req->index, _req->req_virt);
+
+ scp->result = 0;
+
+ if (scp->device->channel || scp->device->lun ||
+   scp->device->id > hba->max_devices) {
+  scp->result = DID_BAD_TARGET << 16;
+  free_req(hba, _req);
+  goto cmd_done;
+ }
+
+ req = (struct hpt_iop_request_scsi_command *)_req->req_virt;
+
+ atomic_inc(&hba->outstandingcommands);
+
+ /* build S/G table */
+ if (scp->request_bufflen)
+  sg_count = hptiop_buildsgl(scp, req->sg_list);
+ else
+  HPT_SCP(scp)->mapped = 0;
+
+ req->header.flags = IOP_REQUEST_FLAG_OUTPUT_CONTEXT;
+ req->header.type = IOP_REQUEST_TYPE_SCSI_COMMAND;
+ req->header.result = IOP_RESULT_PENDING;
+ req->header.context = (u64)(IOPMU_QUEUE_ADDR_HOST_BIT |
+       (u32)_req->index);
+ req->dataxfer_length = scp->bufflen;
+ req->channel = scp->device->channel;
+ req->target = scp->device->id;
+ req->lun = scp->device->lun;
+ req->header.size = sizeof(struct hpt_iop_request_scsi_command)
+     - sizeof(struct hpt_iopsg)
+     + sg_count * sizeof(struct hpt_iopsg);
+
+ memcpy(req->cdb, scp->cmnd, sizeof(req->cdb));
+
+ writel(IOPMU_QUEUE_ADDR_HOST_BIT | _req->req_shifted_phy,
+   &hba->iop->inbound_queue);
+
+ return 0;
+
+cmd_done:
+ dprintk("scsi_done(scp=%p)\n", scp);
+ scp->scsi_done(scp);
+ return 0;
+}
+
+static const char *hptiop_info(struct Scsi_Host *host)
+{
+ return driver_name_long;
+}
+
+static int hptiop_abort(struct scsi_cmnd *scp)
+{
+ dprintk("hptiop_abort(%d/%d/%d) scp=%p\n",
+   scp->device->host->host_no, scp->device->channel,
+   scp->device->id, scp);
+ return FAILED;
+}
+
+static int hptiop_reset_hba(struct hptiop_hba * hba)
+{
+ if (atomic_xchg(&hba->resetting, 1) == 0) {
+  atomic_inc(&hba->reset_count);
+  writel(IOPMU_INBOUND_MSG0_RESET,
+    &hba->iop->outbound_msgaddr0);
+ }
+
+ wait_event_timeout(hba->reset_wq,
+   atomic_read(&hba->resetting) == 0, 60 * HZ);
+
+ if (atomic_read(&hba->resetting)) {
+  /* IOP is in unkown state, abort reset */
+  printk(KERN_ERR "scsi%d: reset failed\n", hba->host->host_no);
+  return -1;
+ }
+
+ /* all scp should be finished */
+ BUG_ON(atomic_read(&hba->outstandingcommands) != 0);
+
+ spin_lock_irq(hba->host->host_lock);
+
+ if (iop_send_sync_msg(hba,
+  IOPMU_INBOUND_MSG0_START_BACKGROUND_TASK, 5000)) {
+  dprintk("scsi%d: fail to start background task\n",
+    hba->host->host_no);
+ }
+
+ spin_unlock_irq(hba->host->host_lock);
+
+ return 0;
+}
+
+static int hptiop_reset(struct scsi_cmnd *scp)
+{
+ struct Scsi_Host * host = scp->device->host;
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+
+ printk(KERN_WARNING "hptiop_reset(%d/%d/%d) scp=%p\n",
+   scp->device->host->host_no, scp->device->channel,
+   scp->device->id, scp);
+
+ return hptiop_reset_hba(hba)? FAILED : SUCCESS;
+}
+
+static int hptiop_adjust_disk_queue_depth(struct scsi_device *sdev,
+      int queue_depth)
+{
+ if(queue_depth > 256)
+  queue_depth = 256;
+ scsi_adjust_queue_depth(sdev, MSG_ORDERED_TAG, queue_depth);
+ return queue_depth;
+}
+
+struct hptiop_getinfo {
+ char *buffer;
+ int buflength;
+ int bufoffset;
+ int buffillen;
+ int filpos;
+};
+
+static void hptiop_copy_mem_info(struct hptiop_getinfo *pinfo,
+     char *data, int datalen)
+{
+ if (pinfo->filpos < pinfo->bufoffset) {
+  if (pinfo->filpos + datalen <= pinfo->bufoffset) {
+   pinfo->filpos += datalen;
+   return;
+  } else {
+   data += (pinfo->bufoffset - pinfo->filpos);
+   datalen  -= (pinfo->bufoffset - pinfo->filpos);
+   pinfo->filpos = pinfo->bufoffset;
+  }
+ }
+
+ pinfo->filpos += datalen;
+ if (pinfo->buffillen == pinfo->buflength)
+  return;
+
+ if (pinfo->buflength - pinfo->buffillen < datalen)
+  datalen = pinfo->buflength - pinfo->buffillen;
+
+ memcpy(pinfo->buffer + pinfo->buffillen, data, datalen);
+ pinfo->buffillen += datalen;
+}
+
+static int hptiop_copy_info(struct hptiop_getinfo *pinfo, char *fmt, ...)
+{
+ va_list args;
+ char buf[128];
+ int len;
+
+ va_start(args, fmt);
+ len = vsprintf(buf, fmt, args);
+ va_end(args);
+ hptiop_copy_mem_info(pinfo, buf, len);
+ return len;
+}
+
+static void hptiop_ioctl_done(struct hpt_ioctl_k *arg)
+{
+ arg->done = NULL;
+ wake_up(&arg->hba->ioctl_wq);
+}
+
+static void hptiop_do_ioctl(struct hpt_ioctl_k *arg)
+{
+ struct hptiop_hba * hba = arg->hba;
+ u32 val;
+ struct hpt_iop_request_ioctl_command __iomem * req;
+ int ioctl_retry = 0;
+
+ dprintk("scsi%d: hptiop_do_ioctl\n", hba->host->host_no);
+
+ /*
+  * check (in + out) buff size from application.
+  * outbuf must be dword aligned.
+  */
+ if (((arg->inbuf_size + 3) & ~3) + arg->outbuf_size >
+   hba->max_request_size
+    - sizeof(struct hpt_iop_request_header)
+    - 4 * sizeof(u32)) {
+  dprintk("scsi%d: ioctl buf size (%d/%d) is too large\n",
+    hba->host->host_no,
+    arg->inbuf_size, arg->outbuf_size);
+  arg->result = HPT_IOCTL_RESULT_FAILED;
+  return;
+ }
+
+retry:
+ spin_lock_irq(hba->host->host_lock);
+
+ val = readl(&hba->iop->inbound_queue);
+ if (val == IOPMU_QUEUE_EMPTY) {
+  dprintk("scsi%d: no free req for ioctl\n", hba->host->host_no);
+  arg->result = -1;
+  return ;
+ }
+
+ req = (struct hpt_iop_request_ioctl_command __iomem *)
+   ((unsigned long)hba->iop + val);
+
+ writel(HPT_CTL_CODE_LINUX_TO_IOP(arg->ioctl_code),
+   &req->ioctl_code);
+ writel(arg->inbuf_size, &req->inbuf_size);
+ writel(arg->outbuf_size, &req->outbuf_size);
+
+ /*
+  * use the buffer on the IOP local memory first, then copy it
+  * back to host
+  */
+ if (arg->inbuf_size)
+  memcpy_toio(req->buf, arg->inbuf, arg->inbuf_size);
+
+ /* correct the controller ID for IOP */
+ if ((arg->ioctl_code == HPT_IOCTL_GET_CHANNEL_INFO ||
+  arg->ioctl_code == HPT_IOCTL_GET_CONTROLLER_INFO_V2 ||
+  arg->ioctl_code == HPT_IOCTL_GET_CONTROLLER_INFO)
+  && arg->inbuf_size >= sizeof(u32))
+  writel(0, req->buf);
+
+ writel(IOP_REQUEST_TYPE_IOCTL_COMMAND, &req->header.type);
+ writel(0, &req->header.flags);
+ writel(offsetof(struct hpt_iop_request_ioctl_command, buf)
+   + arg->inbuf_size, &req->header.size);
+ writel((u32)(unsigned long)arg, &req->header.context);
+ writel(BITS_PER_LONG > 32 ? (u32)((unsigned long)arg>>32) : 0,
+   &req->header.context_hi32);
+ writel(IOP_RESULT_PENDING, &req->header.result);
+
+ arg->result = HPT_IOCTL_RESULT_FAILED;
+ arg->done = hptiop_ioctl_done;
+
+ writel(val, &hba->iop->inbound_queue);
+
+ spin_unlock_irq(hba->host->host_lock);
+
+ wait_event_timeout(hba->ioctl_wq, arg->done == NULL, 60 * HZ);
+
+ if (arg->done != NULL) {
+  hptiop_reset_hba(hba);
+  if (ioctl_retry++ < 3)
+   goto retry;
+ }
+
+ dprintk("hpt_iop_ioctl %x result %d\n",
+   arg->ioctl_code, arg->result);
+}
+
+static inline int __hpt_do_ioctl(struct hptiop_hba *hba,
+   u32 code, void *inbuf, u32 insize,
+   void *outbuf, u32 outsize)
+{
+ struct hpt_ioctl_k arg;
+ arg.hba = hba;
+ arg.ioctl_code = code;
+ arg.inbuf = inbuf;
+ arg.outbuf = outbuf;
+ arg.inbuf_size = insize;
+ arg.outbuf_size = outsize;
+ arg.bytes_returned = NULL;
+ hptiop_do_ioctl(&arg);
+ return arg.result;
+}
+
+#define hpt_id_valid(id) ((id) && ((u32)(id) != 0xffffffff))
+
+static int hptiop_get_controller_info(struct hptiop_hba * hba,
+     struct hpt_controller_info * pinfo)
+{
+ int id = 0;
+ return __hpt_do_ioctl(hba, HPT_IOCTL_GET_CONTROLLER_INFO,
+  &id, sizeof(int), pinfo, sizeof(*pinfo));
+}
+
+
+static int hptiop_get_channel_info(struct hptiop_hba * hba, int bus,
+     struct hpt_channel_info * pinfo)
+{
+ u32 ids[2];
+ ids[0] = 0;
+ ids[1] = bus;
+ return __hpt_do_ioctl(hba, HPT_IOCTL_GET_CHANNEL_INFO,
+    ids, sizeof(ids), pinfo, sizeof(*pinfo));
+
+}
+
+static int hptiop_get_logical_devices(struct hptiop_hba * hba,
+     hpt_id_t * pids, int maxcount)
+{
+ int i;
+ u32 count = maxcount-1;
+
+ if (__hpt_do_ioctl(hba, HPT_IOCTL_GET_LOGICAL_DEVICES,
+   &count, sizeof(u32),
+   pids, sizeof(hpt_id_t) * maxcount))
+  return -1;
+
+ maxcount = (int)pids[0];
+ for (i = 0; i < maxcount; i++) pids[i] = pids[i+1];
+ return maxcount;
+}
+
+static int hptiop_get_device_info_v3(struct hptiop_hba * hba,
+   hpt_id_t id, struct hpt_logical_device_info_v3 * pinfo)
+{
+ return __hpt_do_ioctl(hba, HPT_IOCTL_GET_DEVICE_INFO_V3,
+    &id, sizeof(hpt_id_t),
+    pinfo, sizeof(*pinfo));
+}
+
+static const char *get_array_status(struct hpt_logical_device_info_v3 *
devinfo)
+{
+ static char s[64];
+ u32 flags = devinfo->u.array.flags;
+
+ if (flags & ARRAY_FLAG_DISABLED)
+  return "Disabled";
+ else if (flags & ARRAY_FLAG_TRANSFORMING)
+  sprintf(s, "Expanding/Migrating %d.%d%%%s%s",
+   devinfo->u.array.transforming_progress / 100,
+   devinfo->u.array.transforming_progress % 100,
+   (flags & (ARRAY_FLAG_NEEDBUILDING|ARRAY_FLAG_BROKEN))?
+     ", Critical" : "",
+   ((flags & ARRAY_FLAG_NEEDINITIALIZING) &&
+    !(flags & ARRAY_FLAG_REBUILDING) &&
+    !(flags & ARRAY_FLAG_INITIALIZING))?
+     ", Unintialized" : "");
+ else if ((flags & ARRAY_FLAG_BROKEN) &&
+    devinfo->u.array.array_type != AT_RAID6)
+  return "Critical";
+ else if (flags & ARRAY_FLAG_REBUILDING)
+  sprintf(s,
+   (flags & ARRAY_FLAG_NEEDINITIALIZING)?
+    "%sBackground initializing %d.%d%%" :
+     "%sRebuilding %d.%d%%",
+   (flags & ARRAY_FLAG_BROKEN)? "Critical, " : "",
+   devinfo->u.array.rebuilding_progress / 100,
+   devinfo->u.array.rebuilding_progress % 100);
+ else if (flags & ARRAY_FLAG_VERIFYING)
+  sprintf(s, "%sVerifying %d.%d%%",
+   (flags & ARRAY_FLAG_BROKEN)? "Critical, " : "",
+   devinfo->u.array.rebuilding_progress / 100,
+   devinfo->u.array.rebuilding_progress % 100);
+ else if (flags & ARRAY_FLAG_INITIALIZING)
+  sprintf(s, "%sForground initializing %d.%d%%",
+   (flags & ARRAY_FLAG_BROKEN)? "Critical, " : "",
+   devinfo->u.array.rebuilding_progress / 100,
+   devinfo->u.array.rebuilding_progress % 100);
+ else if (flags & ARRAY_FLAG_NEEDTRANSFORM)
+  sprintf(s,"%s%s%s", "Need Expanding/Migrating",
+   (flags & ARRAY_FLAG_BROKEN)? "Critical, " : "",
+   ((flags & ARRAY_FLAG_NEEDINITIALIZING) &&
+    !(flags & ARRAY_FLAG_REBUILDING) &&
+    !(flags & ARRAY_FLAG_INITIALIZING))?
+    ", Unintialized" : "");
+ else if (flags & ARRAY_FLAG_NEEDINITIALIZING &&
+  !(flags & ARRAY_FLAG_REBUILDING) &&
+  !(flags & ARRAY_FLAG_INITIALIZING))
+  sprintf(s,"%sUninitialized",
+   (flags & ARRAY_FLAG_BROKEN)? "Critical, " : "");
+ else if ((flags & ARRAY_FLAG_NEEDBUILDING) ||
+   (flags & ARRAY_FLAG_BROKEN))
+  return "Critical";
+ else
+  return "Normal";
+ return s;
+}
+
+static void hptiop_dump_devinfo(struct hptiop_hba * hba,
+   struct hptiop_getinfo *pinfo, hpt_id_t id, int indent)
+{
+ struct hpt_logical_device_info_v3 devinfo;
+ int i;
+ u64 capacity;
+
+ for (i = 0; i < indent; i++)
+  hptiop_copy_info(pinfo, "\t");
+
+ if (hptiop_get_device_info_v3(hba, id, &devinfo)) {
+  hptiop_copy_info(pinfo, "unknown\n");
+  return;
+ }
+
+ switch (devinfo.type) {
+
+ case LDT_DEVICE: {
+  struct hd_driveid *driveid;
+
+  driveid = (struct hd_driveid *)devinfo.u.device.ident;
+  driveid->model[20] = 0;
+  if (indent)
+   if (devinfo.u.device.flags & DEVICE_FLAG_DISABLED)
+    hptiop_copy_info(pinfo,"Missing\n");
+   else
+    hptiop_copy_info(pinfo, "CH%d %s\n",
+     devinfo.u.device.path_id + 1,
+     driveid->model
+    );
+  else {
+   capacity = devinfo.capacity*512;
+   do_div(capacity, 1000000);
+   hptiop_copy_info(pinfo,
+    "CH%d %s, %dMB, %s %s%s%s%s\n",
+    devinfo.u.device.path_id + 1,
+    driveid->model,
+    (int)capacity,
+    (devinfo.u.device.flags & DEVICE_FLAG_DISABLED)?
+     "Disabled" : "Normal",
+    devinfo.u.device.read_ahead_enabled?
+      "[RA]" : "",
+    devinfo.u.device.write_cache_enabled?
+      "[WC]" : "",
+    devinfo.u.device.TCQ_enabled?
+      "[TCQ]" : "",
+    devinfo.u.device.NCQ_enabled?
+      "[NCQ]" : ""
+   );
+  }
+  break;
+ }
+
+ case LDT_ARRAY:
+  if (devinfo.target_id != INVALID_TARGET_ID)
+   hptiop_copy_info(pinfo, "[DISK %d_%d] ",
+     devinfo.vbus_id, devinfo.target_id);
+
+  capacity = devinfo.capacity * 512;
+  do_div(capacity, 1000000);
+  hptiop_copy_info(pinfo, "%s (%s), %dMB, %s\n",
+   devinfo.u.array.name,
+   devinfo.u.array.array_type==AT_RAID0? "RAID0" :
+    devinfo.u.array.array_type==AT_RAID1? "RAID1" :
+    devinfo.u.array.array_type==AT_RAID5? "RAID5" :
+    devinfo.u.array.array_type==AT_RAID6? "RAID6" :
+    devinfo.u.array.array_type==AT_JBOD? "JBOD" :
+     "unknown",
+   (int)capacity,
+   get_array_status(&devinfo)
+  );
+  for (i = 0; i < devinfo.u.array.ndisk; i++) {
+   if (hpt_id_valid(devinfo.u.array.members[i])) {
+    if ((1<<i) & devinfo.u.array.critical_members)
+     hptiop_copy_info(pinfo, "\t*");
+    hptiop_dump_devinfo(hba, pinfo,
+     devinfo.u.array.members[i], indent+1);
+   }
+   else
+    hptiop_copy_info(pinfo, "\tMissing\n");
+  }
+  if (id == devinfo.u.array.transform_source) {
+   hptiop_copy_info(pinfo, "\tExpanding/Migrating to:\n");
+   hptiop_dump_devinfo(hba, pinfo,
+    devinfo.u.array.transform_target, indent+1);
+  }
+  break;
+ }
+}
+
+static ssize_t hptiop_show_version(struct class_device *class_dev, char
*buf)
+{
+ return snprintf(buf, PAGE_SIZE, "%s\n", driver_ver);
+}
+
+static ssize_t hptiop_show_devicelist(struct class_device *class_dev, char
*buf)
+{
+ struct Scsi_Host *host = class_to_shost(class_dev);
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+ struct hptiop_getinfo info;
+ int i, j, count;
+ struct hpt_controller_info con_info;
+ struct hpt_channel_info chan_info;
+ hpt_id_t ids[32];
+
+ info.buffer     = buf;
+ info.buflength  = PAGE_SIZE;
+ info.bufoffset  = 0;
+ info.filpos     = 0;
+ info.buffillen  = 0;
+
+ if (hptiop_get_controller_info(hba, &con_info))
+  return -EIO;
+
+ for (i = 0; i < con_info.num_buses; i++) {
+  if (hptiop_get_channel_info(hba, i, &chan_info) == 0) {
+   if (hpt_id_valid(chan_info.devices[0]))
+    hptiop_dump_devinfo(hba, &info,
+      chan_info.devices[0], 0);
+   if (hpt_id_valid(chan_info.devices[1]))
+    hptiop_dump_devinfo(hba, &info,
+      chan_info.devices[1], 0);
+  }
+ }
+
+ count = hptiop_get_logical_devices(hba, (hpt_id_t *)&ids,
+     sizeof(ids) / sizeof(ids[0]));
+
+ for (j = 0; j < count; j++)
+  hptiop_dump_devinfo(hba, &info, ids[j], 0);
+
+ return info.buffillen;
+}
+
+static ssize_t hptiop_store_ioctl(struct class_device *class_dev,
+     const char *buffer, size_t length)
+{
+ struct Scsi_Host * host = class_to_shost(class_dev);
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+ struct hpt_ioctl_u *ioctl_u = (struct hpt_ioctl_u *)buffer;
+ struct hpt_ioctl_k ioctl_k;
+ u32 bytes_returned;
+ int err = -EINVAL;
+
+ if (length < sizeof(struct hpt_ioctl_u))
+  return -EINVAL;
+
+ if (ioctl_u->magic != HPT_IOCTL_MAGIC)
+  return -EINVAL;
+
+ ioctl_k.ioctl_code = ioctl_u->ioctl_code;
+ ioctl_k.inbuf = NULL;
+ ioctl_k.inbuf_size = ioctl_u->inbuf_size;
+ ioctl_k.outbuf = NULL;
+ ioctl_k.outbuf_size = ioctl_u->outbuf_size;
+ ioctl_k.hba = hba;
+ ioctl_k.bytes_returned = &bytes_returned;
+
+ /* verify user buffer */
+ if ((ioctl_k.inbuf_size && !access_ok(VERIFY_READ,
+   ioctl_u->inbuf, ioctl_k.inbuf_size)) ||
+  (ioctl_k.outbuf_size && !access_ok(VERIFY_WRITE,
+   ioctl_u->outbuf, ioctl_k.outbuf_size)) ||
+  (ioctl_u->bytes_returned && !access_ok(VERIFY_WRITE,
+   ioctl_u->bytes_returned, sizeof(u32))) ||
+  ioctl_k.inbuf_size + ioctl_k.outbuf_size > 0x10000) {
+
+  dprintk("scsi%d: got bad user address\n", hba->host->host_no);
+  return -EINVAL;
+ }
+
+ /* map buffer to kernel. */
+ if (ioctl_k.inbuf_size) {
+  ioctl_k.inbuf = kmalloc(ioctl_k.inbuf_size, GFP_KERNEL);
+  if (!ioctl_k.inbuf) {
+   dprintk("scsi%d: fail to alloc inbuf\n",
+     hba->host->host_no);
+   err = -ENOMEM;
+   goto err_exit;
+  }
+
+  if (copy_from_user(ioctl_k.inbuf,
+    ioctl_u->inbuf, ioctl_k.inbuf_size)) {
+   goto err_exit;
+  }
+ }
+
+ if (ioctl_k.outbuf_size) {
+  ioctl_k.outbuf = kmalloc(ioctl_k.outbuf_size, GFP_KERNEL);
+  if (!ioctl_k.outbuf) {
+   dprintk("scsi%d: fail to alloc outbuf\n",
+     hba->host->host_no);
+   err = -ENOMEM;
+   goto err_exit;
+  }
+ }
+
+ hptiop_do_ioctl(&ioctl_k);
+
+ if (ioctl_k.result == HPT_IOCTL_RESULT_OK) {
+  if (ioctl_k.outbuf_size &&
+   copy_to_user(ioctl_u->outbuf,
+    ioctl_k.outbuf, ioctl_k.outbuf_size))
+   goto err_exit;
+
+  if (ioctl_u->bytes_returned &&
+   copy_to_user(ioctl_u->bytes_returned,
+    &bytes_returned, sizeof(u32)))
+   goto err_exit;
+
+  err = length;
+ }
+
+err_exit:
+ if (ioctl_k.inbuf)
+  kfree(ioctl_k.inbuf);
+ if (ioctl_k.outbuf)
+  kfree(ioctl_k.outbuf);
+
+ return err;
+}
+
+static ssize_t hptiop_show_fw_version(struct class_device *class_dev, char
*buf)
+{
+ struct Scsi_Host * host = class_to_shost(class_dev);
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+
+ return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+    hba->firmware_version >> 24,
+    (hba->firmware_version >> 16) & 0xff,
+    (hba->firmware_version >> 8) & 0xff,
+    hba->firmware_version & 0xff);
+}
+
+static struct class_device_attribute hptiop_attr_version = {
+ .attr = {
+  .name = "driver-version",
+  .mode = S_IRUGO,
+ },
+ .show = hptiop_show_version,
+};
+
+static struct class_device_attribute hptiop_attr_fw_version = {
+ .attr = {
+  .name = "firmware-version",
+  .mode = S_IRUGO,
+ },
+ .show = hptiop_show_fw_version,
+};
+
+static struct class_device_attribute hptiop_attr_devicelist = {
+ .attr = {
+  .name = "device-list",
+  .mode = S_IRUGO,
+ },
+ .show = hptiop_show_devicelist,
+};
+
+static struct class_device_attribute hptiop_attr_ioctl = {
+ .attr = {
+  .name = "ioctl",
+  .mode = S_IWUSR,
+ },
+ .store = hptiop_store_ioctl
+};
+
+static struct class_device_attribute *hptiop_attrs[] = {
+ &hptiop_attr_version,
+ &hptiop_attr_fw_version,
+ &hptiop_attr_devicelist,
+ &hptiop_attr_ioctl,
+ NULL
+};
+
+static struct scsi_host_template driver_template = {
+ .module                     = THIS_MODULE,
+ .name                       = driver_name,
+ .queuecommand               = hptiop_queuecommand,
+ .eh_abort_handler           = hptiop_abort,
+ .eh_device_reset_handler    = hptiop_reset,
+ .eh_bus_reset_handler       = hptiop_reset,
+ .info                       = hptiop_info,
+ .unchecked_isa_dma          = 0,
+ .emulated                   = 0,
+ .use_clustering             = ENABLE_CLUSTERING,
+ .proc_name                  = driver_name,
+ .shost_attrs                = hptiop_attrs,
+ .this_id                    = -1,
+ .change_queue_depth         = hptiop_adjust_disk_queue_depth,
+};
+
+static int __devinit hptiop_probe(struct pci_dev *pcidev,
+     const struct pci_device_id *id)
+{
+ struct Scsi_Host * host = NULL;
+ struct hptiop_hba * hba;
+ struct hpt_iop_request_get_config  iop_config;
+ struct hpt_iop_request_set_config  set_config;
+ dma_addr_t start_phy;
+ void * start_virt;
+ u32 offset, i, req_size;
+
+ dprintk("hptiop_probe(%p)\n", pcidev);
+
+ if (pci_enable_device(pcidev)) {
+  printk(KERN_ERR "hptiop: fail to enable pci device\n");
+  return -ENODEV;
+ }
+
+ printk(KERN_INFO "adapter at PCI %d:%d:%d, IRQ %d\n",
+  pcidev->bus->number, pcidev->devfn >> 3, pcidev->devfn & 7,
+  pcidev->irq);
+
+ pci_set_master(pcidev);
+
+ /* Enable 64bit DMA if possible */
+ if (pci_set_dma_mask(pcidev, 0xFFFFFFFFFFFFFFFFULL)) {
+  if (pci_set_dma_mask(pcidev, 0xFFFFFFFFUL)) {
+   printk(KERN_ERR "hptiop: fail to set dma_mask\n");
+   goto disable_pci_device;
+  }
+ }
+
+ if (pci_request_regions(pcidev, driver_name)) {
+  printk(KERN_ERR "hptiop: pci_request_regions failed\n");
+  goto disable_pci_device;
+ }
+
+ host = scsi_host_alloc(&driver_template, sizeof(struct hptiop_hba));
+ if (!host) {
+  printk(KERN_ERR "hptiop: fail to alloc scsi host\n");
+  goto free_pci_regions;
+ }
+
+ hba = (struct hptiop_hba *)host->hostdata;
+
+ hba->pcidev = pcidev;
+ hba->host = host;
+ hba->initialized = 0;
+
+ atomic_set(&hba->outstandingcommands, 0);
+ atomic_set(&hba->resetting, 0);
+ atomic_set(&hba->reset_count, 0);
+
+ init_waitqueue_head(&hba->reset_wq);
+ init_waitqueue_head(&hba->ioctl_wq);
+
+ host->max_lun = 1;
+ host->max_channel = 0;
+ host->io_port = 0;
+ host->n_io_port = 0;
+ host->irq = pcidev->irq;
+
+ if (hptiop_map_pci_bar(hba))
+  goto free_scsi_host;
+
+ if (iop_wait_ready(hba->iop, 20000)) {
+  printk(KERN_ERR "scsi%d: firmware not ready\n",
+    hba->host->host_no);
+  goto unmap_pci_bar;
+ }
+
+ if (iop_get_config(hba, &iop_config)) {
+  printk(KERN_ERR "scsi%d: get config failed\n",
+    hba->host->host_no);
+  goto unmap_pci_bar;
+ }
+
+ hba->max_requests = min(iop_config.max_requests, HPTIOP_MAX_REQUESTS);
+ hba->max_devices = iop_config.max_devices;
+ hba->max_request_size = iop_config.request_size;
+ hba->max_sg_descriptors = iop_config.max_sg_count;
+ hba->firmware_version = iop_config.firmware_version;
+ hba->sdram_size = iop_config.sdram_size;
+
+ host->max_sectors = iop_config.data_transfer_length >> 9;
+ host->max_id = iop_config.max_devices;
+ host->sg_tablesize = iop_config.max_sg_count;
+ host->can_queue = iop_config.max_requests;
+ host->cmd_per_lun = iop_config.max_requests;
+ host->max_cmd_len = 16;
+
+ set_config.vbus_id = host->host_no;
+ set_config.iop_id = host->host_no;
+
+ if (iop_set_config(hba, &set_config)) {
+  printk(KERN_ERR "scsi%d: set config failed\n",
+    hba->host->host_no);
+  goto unmap_pci_bar;
+ }
+
+ if (scsi_add_host(host, &pcidev->dev)) {
+  printk(KERN_ERR "scsi%d: scsi_add_host failed\n",
+     hba->host->host_no);
+  goto unmap_pci_bar;
+ }
+
+ pci_set_drvdata(pcidev, host);
+
+ if (request_irq(pcidev->irq, hptiop_intr, SA_SHIRQ,
+     driver_name, hba)) {
+  printk(KERN_ERR "scsi%d: request irq %d failed\n",
+     hba->host->host_no, pcidev->irq);
+  goto remove_scsi_host;
+ }
+
+ /* Allocate request mem */
+ req_size = sizeof(struct hpt_iop_request_scsi_command)
+  + sizeof(struct hpt_iopsg) * (hba->max_sg_descriptors - 1);
+ if ((req_size& 0x1f) != 0)
+  req_size = (req_size + 0x1f) & ~0x1f;
+
+ dprintk("req_size=%d, max_requests=%d\n", req_size, hba->max_requests);
+
+ hba->req_size = req_size;
+ start_virt = dma_alloc_coherent(&pcidev->dev,
+    hba->req_size*hba->max_requests + 0x20,
+    &start_phy, GFP_KERNEL);
+
+ if (!start_virt) {
+  printk(KERN_ERR "scsi%d: fail to alloc request mem\n",
+     hba->host->host_no);
+  goto free_request_irq;
+ }
+
+ hba->dma_coherent = start_virt;
+ hba->dma_coherent_handle = start_phy;
+
+ if ((start_phy & 0x1f) != 0)
+ {
+  offset = ((start_phy + 0x1f) & ~0x1f) - start_phy;
+  start_phy += offset;
+  start_virt += offset;
+ }
+
+ hba->req_list = start_virt;
+ for (i = 0; i < hba->max_requests; i++) {
+  hba->reqs[i].next = NULL;
+  hba->reqs[i].req_virt = start_virt;
+  hba->reqs[i].req_shifted_phy = start_phy >> 5;
+  hba->reqs[i].index = i;
+  free_req(hba, &hba->reqs[i]);
+  start_virt = (char *)start_virt + hba->req_size;
+  start_phy = start_phy + hba->req_size;
+ }
+
+ /* Enable Interrupt and start background task */
+ if (hptiop_initialize_iop(hba))
+  goto free_request_mem;
+
+ scsi_scan_host(host);
+
+ dprintk("scsi%d: hptiop_probe successfully\n", hba->host->host_no);
+ return 0;
+
+free_request_mem:
+ dma_free_coherent(&hba->pcidev->dev,
+   hba->req_size*hba->max_requests + 0x20,
+   hba->dma_coherent, hba->dma_coherent_handle);
+
+free_request_irq:
+ free_irq(hba->pcidev->irq, hba);
+
+remove_scsi_host:
+ scsi_remove_host(host);
+
+unmap_pci_bar:
+ iounmap(hba->iop);
+
+free_pci_regions:
+ pci_release_regions(pcidev) ;
+
+free_scsi_host:
+ scsi_host_put(host);
+
+disable_pci_device:
+ pci_disable_device(pcidev);
+
+ dprintk("scsi%d: hptiop_probe fail\n", host->host_no);
+ return -ENODEV;
+}
+
+static void hptiop_shutdown(struct pci_dev *pcidev)
+{
+ struct Scsi_Host * host = pci_get_drvdata(pcidev);
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+ struct hpt_iopmu __iomem * iop = hba->iop;
+ u32    int_mask;
+
+ dprintk("hptiop_shutdown(%p)\n", hba);
+
+ /* all outstandingcommands should be finished */
+ BUG_ON(atomic_read(&hba->outstandingcommands) != 0);
+
+ /* stop the iop */
+ spin_lock_irq(hba->host->host_lock);
+ if (iop_send_sync_msg(hba, IOPMU_INBOUND_MSG0_SHUTDOWN, 60000))
+  printk(KERN_ERR "scsi%d: shutdown the iop timeout\n",
+     hba->host->host_no);
+ spin_unlock_irq(hba->host->host_lock);
+
+ /* disable all outbound interrupts */
+ int_mask = readl(&iop->outbound_intmask);
+ writel(int_mask|IOPMU_OUTBOUND_INT_MSG0|IOPMU_OUTBOUND_INT_POSTQUEUE,
+   &iop->outbound_intmask);
+}
+
+static void hptiop_remove(struct pci_dev *pcidev)
+{
+ struct Scsi_Host * host = pci_get_drvdata(pcidev);
+ struct hptiop_hba * hba = (struct hptiop_hba *)host->hostdata;
+
+ dprintk("scsi%d: hptiop_remove\n", hba->host->host_no);
+
+ hptiop_shutdown(pcidev);
+
+ free_irq(hba->pcidev->irq, hba);
+
+ dma_free_coherent(&hba->pcidev->dev,
+   hba->req_size * hba->max_requests + 0x20,
+   hba->dma_coherent,
+   hba->dma_coherent_handle);
+
+ iounmap(hba->iop);
+
+ pci_release_regions(hba->pcidev);
+ pci_set_drvdata(hba->pcidev, NULL);
+ pci_disable_device(hba->pcidev);
+
+ scsi_remove_host(host);
+ scsi_host_put(host);
+}
+
+static struct pci_device_id hptiop_id_table[] = {
+ { PCI_DEVICE(0x1103, 0x3220) },
+ { PCI_DEVICE(0x1103, 0x3320) },
+ {},
+};
+
+MODULE_DEVICE_TABLE(pci, hptiop_id_table);
+
+static struct pci_driver hptiop_pci_driver = {
+ .name       = driver_name,
+ .id_table   = hptiop_id_table,
+ .probe      = hptiop_probe,
+ .remove     = hptiop_remove,
+ .shutdown   = hptiop_shutdown,
+};
+
+static int hptiop_module_init(void)
+{
+ printk(KERN_INFO "%s %s\n", driver_name_long, driver_ver);
+
+ return pci_module_init(&hptiop_pci_driver);
+}
+
+static void hptiop_module_exit(void)
+{
+ dprintk("hptiop_module_exit\n");
+ pci_unregister_driver(&hptiop_pci_driver);
+}
+
+
+module_init(hptiop_module_init);
+module_exit(hptiop_module_exit);
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
diff --git a/drivers/scsi/hptiop.h b/drivers/scsi/hptiop.h
new file mode 100644
index 0000000..7e38927
--- /dev/null
+++ b/drivers/scsi/hptiop.h
@@ -0,0 +1,524 @@
+/*
+ * HighPoint RR3xxx controller driver for Linux
+ * Copyright (C) 2006 HighPoint Technologies, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Please report bugs/comments/suggestions to linux@highpoint-tech.com
+ *
+ * For more information, visit http://www.highpoint-tech.com
+ */
+#ifndef _HPTIOP_H_
+#define _HPTIOP_H_
+
+typedef u32 hpt_id_t;
+
+/*
+ * logical device type.
+ * Identify array (logical device) and physical device.
+ */
+#define LDT_ARRAY   1
+#define LDT_DEVICE  2
+
+/*
+ * Array types
+ */
+#define AT_UNKNOWN  0
+#define AT_RAID0    1
+#define AT_RAID1    2
+#define AT_RAID5    3
+#define AT_RAID6    4
+#define AT_JBOD     7
+
+#define MAX_NAME_LENGTH     36
+#define MAX_ARRAYNAME_LEN   16
+
+#define MAX_ARRAY_MEMBERS_V1 8
+#define MAX_ARRAY_MEMBERS_V2 16
+
+/* keep definition for source code compatiblity */
+#define MAX_ARRAY_MEMBERS MAX_ARRAY_MEMBERS_V1
+
+/*
+ * array flags
+ */
+#define ARRAY_FLAG_DISABLED         0x00000001 /* The array is disabled */
+#define ARRAY_FLAG_NEEDBUILDING     0x00000002 /* need to be rebuilt */
+#define ARRAY_FLAG_REBUILDING       0x00000004 /* in rebuilding process */
+#define ARRAY_FLAG_BROKEN           0x00000008 /* broken but still working
*/
+#define ARRAY_FLAG_BOOTDISK         0x00000010 /* has a active partition */
+
+#define ARRAY_FLAG_BOOTMARK         0x00000040 /* array has boot mark set
*/
+#define ARRAY_FLAG_NEED_AUTOREBUILD 0x00000080 /* auto-rebuild should start
*/
+#define ARRAY_FLAG_VERIFYING        0x00000100 /* is being verified */
+#define ARRAY_FLAG_INITIALIZING     0x00000200 /* is being initialized */
+#define ARRAY_FLAG_TRANSFORMING     0x00000400 /* tranform in progress */
+#define ARRAY_FLAG_NEEDTRANSFORM    0x00000800 /* array need tranform */
+#define ARRAY_FLAG_NEEDINITIALIZING 0x00001000 /* initialization not done
*/
+#define ARRAY_FLAG_BROKEN_REDUNDANT 0x00002000 /* broken but redundant */
+
+/*
+ * device flags
+ */
+#define DEVICE_FLAG_DISABLED        0x00000001 /* device is disabled */
+#define DEVICE_FLAG_BOOTDISK        0x00000002 /* disk has a active
partition */
+#define DEVICE_FLAG_BOOTMARK        0x00000004 /* disk has boot mark set */
+#define DEVICE_FLAG_WITH_601        0x00000008 /* has HPT601 connected */
+#define DEVICE_FLAG_SATA            0x00000010 /* S-ATA device */
+
+#define DEVICE_FLAG_UNINITIALIZED   0x00010000 /* device is not initialized
*/
+#define DEVICE_FLAG_LEGACY          0x00020000 /* lagacy drive */
+
+#define DEVICE_FLAG_IS_SPARE        0x80000000 /* is a spare disk */
+
+/*
+ * ioctl codes
+ */
+#define HPT_CTL_CODE(x) (x+0xFF00)
+#define HPT_CTL_CODE_LINUX_TO_IOP(x) ((x)-0xff00)
+
+#define HPT_IOCTL_GET_VERSION               HPT_CTL_CODE(0)
+#define HPT_IOCTL_GET_CONTROLLER_COUNT      HPT_CTL_CODE(1)
+#define HPT_IOCTL_GET_CONTROLLER_INFO       HPT_CTL_CODE(2)
+#define HPT_IOCTL_GET_CHANNEL_INFO          HPT_CTL_CODE(3)
+#define HPT_IOCTL_GET_LOGICAL_DEVICES       HPT_CTL_CODE(4)
+#define HPT_IOCTL_GET_DEVICE_INFO           HPT_CTL_CODE(5)
+#define HPT_IOCTL_CREATE_ARRAY              HPT_CTL_CODE(6)
+#define HPT_IOCTL_DELETE_ARRAY              HPT_CTL_CODE(7)
+#define HPT_IOCTL_ARRAY_IO                  HPT_CTL_CODE(8)
+#define HPT_IOCTL_DEVICE_IO                 HPT_CTL_CODE(9)
+#define HPT_IOCTL_GET_EVENT                 HPT_CTL_CODE(10)
+#define HPT_IOCTL_REBUILD_DATA_BLOCK        HPT_CTL_CODE(11)
+#define HPT_IOCTL_ADD_SPARE_DISK            HPT_CTL_CODE(12)
+#define HPT_IOCTL_REMOVE_SPARE_DISK         HPT_CTL_CODE(13)
+#define HPT_IOCTL_ADD_DISK_TO_ARRAY         HPT_CTL_CODE(14)
+#define HPT_IOCTL_SET_ARRAY_STATE           HPT_CTL_CODE(15)
+#define HPT_IOCTL_SET_ARRAY_INFO            HPT_CTL_CODE(16)
+#define HPT_IOCTL_SET_DEVICE_INFO           HPT_CTL_CODE(17)
+#define HPT_IOCTL_RESCAN_DEVICES            HPT_CTL_CODE(18)
+#define HPT_IOCTL_GET_DRIVER_CAPABILITIES   HPT_CTL_CODE(19)
+#define HPT_IOCTL_GET_601_INFO              HPT_CTL_CODE(20)
+#define HPT_IOCTL_SET_601_INFO              HPT_CTL_CODE(21)
+#define HPT_IOCTL_LOCK_DEVICE               HPT_CTL_CODE(22)
+#define HPT_IOCTL_UNLOCK_DEVICE             HPT_CTL_CODE(23)
+#define HPT_IOCTL_IDE_PASS_THROUGH          HPT_CTL_CODE(24)
+#define HPT_IOCTL_VERIFY_DATA_BLOCK         HPT_CTL_CODE(25)
+#define HPT_IOCTL_INITIALIZE_DATA_BLOCK     HPT_CTL_CODE(26)
+#define HPT_IOCTL_ADD_DEDICATED_SPARE       HPT_CTL_CODE(27)
+#define HPT_IOCTL_DEVICE_IO_EX              HPT_CTL_CODE(28)
+#define HPT_IOCTL_SET_BOOT_MARK             HPT_CTL_CODE(29)
+#define HPT_IOCTL_QUERY_REMOVE              HPT_CTL_CODE(30)
+#define HPT_IOCTL_REMOVE_DEVICES            HPT_CTL_CODE(31)
+#define HPT_IOCTL_CREATE_ARRAY_V2           HPT_CTL_CODE(32)
+#define HPT_IOCTL_GET_DEVICE_INFO_V2        HPT_CTL_CODE(33)
+#define HPT_IOCTL_SET_DEVICE_INFO_V2        HPT_CTL_CODE(34)
+#define HPT_IOCTL_REBUILD_DATA_BLOCK_V2     HPT_CTL_CODE(35)
+#define HPT_IOCTL_VERIFY_DATA_BLOCK_V2      HPT_CTL_CODE(36)
+#define HPT_IOCTL_INITIALIZE_DATA_BLOCK_V2  HPT_CTL_CODE(37)
+#define HPT_IOCTL_LOCK_DEVICE_V2            HPT_CTL_CODE(38)
+#define HPT_IOCTL_DEVICE_IO_V2              HPT_CTL_CODE(39)
+#define HPT_IOCTL_DEVICE_IO_EX_V2           HPT_CTL_CODE(40)
+#define HPT_IOCTL_CREATE_TRANSFORM          HPT_CTL_CODE(41)
+#define HPT_IOCTL_STEP_TRANSFORM            HPT_CTL_CODE(42)
+#define HPT_IOCTL_SET_VDEV_INFO             HPT_CTL_CODE(43)
+#define HPT_IOCTL_CALC_MAX_CAPACITY         HPT_CTL_CODE(44)
+#define HPT_IOCTL_INIT_DISKS                HPT_CTL_CODE(45)
+#define HPT_IOCTL_GET_DEVICE_INFO_V3        HPT_CTL_CODE(46)
+#define HPT_IOCTL_GET_CONTROLLER_INFO_V2    HPT_CTL_CODE(47)
+#define HPT_IOCTL_I2C_TRANSACTION           HPT_CTL_CODE(48)
+#define HPT_IOCTL_GET_PARAMETER_LIST        HPT_CTL_CODE(49)
+#define HPT_IOCTL_GET_PARAMETER             HPT_CTL_CODE(50)
+#define HPT_IOCTL_SET_PARAMETER             HPT_CTL_CODE(51)
+#define HPT_IOCTL_GET_CONTROLLER_IDS        HPT_CTL_CODE(100)
+#define HPT_IOCTL_GET_DCB                   HPT_CTL_CODE(101)
+#define HPT_IOCTL_EPROM_IO                  HPT_CTL_CODE(102)
+#define HPT_IOCTL_GET_CONTROLLER_VENID      HPT_CTL_CODE(103)
+
+/*
+ * Controller information.
+ */
+struct hpt_controller_info {
+ u8 chip_type;                    /* chip type */
+ u8 interrupt_level;              /* IRQ level */
+ u8 num_buses;                    /* bus count */
+ u8 chip_flags;
+
+ u8 product_id[MAX_NAME_LENGTH];/* product name */
+ u8 vendor_id[MAX_NAME_LENGTH]; /* vender name */
+}
+__attribute__((packed));
+
+/*
+ * Channel information.
+ */
+struct hpt_channel_info {
+ u32         io_port;         /* IDE Base Port Address */
+ u32         control_port;    /* IDE Control Port Address */
+
+ hpt_id_t    devices[2];     /* device connected to this channel */
+}
+__attribute__((packed));
+
+/*
+ * Array information.
+ */
+struct hpt_array_info_v3 {
+ u8      name[MAX_ARRAYNAME_LEN]; /* array name */
+ u8      description[64];         /* array description */
+ u8      create_manager[16];      /* who created it */
+ u32     create_time;             /* when created it */
+
+ u8      array_type;              /* array type */
+ u8      block_size_shift;        /* stripe size */
+ u8      ndisk;                   /* Number of ID in Members[] */
+ u8      reserved;
+
+ u32     flags;                   /* working flags, see ARRAY_FLAG_XXX */
+ u32     members[MAX_ARRAY_MEMBERS_V2];  /* member array/disks */
+
+ u32     rebuilding_progress;
+ u64     rebuilt_sectors; /* rebuilding point (LBA) for single member */
+
+ hpt_id_t    transform_source;
+ hpt_id_t    transform_target;    /* destination device ID */
+ u32     transforming_progress;
+ u32     signature;              /* persistent identification*/
+ u16     critical_members;       /* bit mask of critical members */
+ u16     reserve2;
+ u32     reserve;
+}
+__attribute__((packed));
+
+/*
+ * physical device information.
+ */
+#define MAX_PARENTS_PER_DISK    8
+
+struct hpt_device_info_v2 {
+ u8   ctlr_id;             /* controller id */
+ u8   path_id;             /* bus */
+ u8   target_id;           /* id */
+ u8   device_mode_setting; /* Current Data Transfer mode: 0-4 PIO0-4 */
+      /* 5-7 MW DMA0-2, 8-13 UDMA0-5 */
+ u8   device_type;         /* device type */
+ u8   usable_mode;         /* highest usable mode */
+
+#ifdef __BIG_ENDIAN_BITFIELD
+ u8   NCQ_enabled: 1;
+ u8   NCQ_supported: 1;
+ u8   TCQ_enabled: 1;
+ u8   TCQ_supported: 1;
+ u8   write_cache_enabled: 1;
+ u8   write_cache_supported: 1;
+ u8   read_ahead_enabled: 1;
+ u8   read_ahead_supported: 1;
+ u8   reserved6: 6;
+ u8   spin_up_mode: 2;
+#else
+ u8   read_ahead_supported: 1;
+ u8   read_ahead_enabled: 1;
+ u8   write_cache_supported: 1;
+ u8   write_cache_enabled: 1;
+ u8   TCQ_supported: 1;
+ u8   TCQ_enabled: 1;
+ u8   NCQ_supported: 1;
+ u8   NCQ_enabled: 1;
+ u8   spin_up_mode: 2;
+ u8   reserved6: 6;
+#endif
+
+ u32  flags;         /* working flags, see DEVICE_FLAG_XXX */
+ u8   ident[150];    /* (partitial) Identify Data of this device */
+
+ u64  total_free;
+ u64  max_free;
+ u64  bad_sectors;
+ hpt_id_t parent_arrays[MAX_PARENTS_PER_DISK];
+}
+__attribute__((packed));
+
+/*
+ * Logical device information.
+ */
+#define INVALID_TARGET_ID   0xFF
+#define INVALID_BUS_ID      0xFF
+
+struct hpt_logical_device_info_v3 {
+ u8       type;                   /* LDT_ARRAY or LDT_DEVICE */
+ u8       cache_policy;           /* refer to CACHE_POLICY_xxx */
+ u8       vbus_id;                /* vbus sequence in vbus_list */
+ u8       target_id;              /* OS target id. 0xFF is invalid */
+      /* OS name: DISK $VBusId_$TargetId */
+ u64      capacity;               /* array capacity */
+ hpt_id_t parent_array;           /* don't use this field for physical
+         device. use ParentArrays field in
+         hpt_device_info_v2 */
+ /* reserved statistic fields */
+ u32      stat1;
+ u32      stat2;
+ u32      stat3;
+ u32      stat4;
+
+ union {
+  struct hpt_array_info_v3 array;
+  struct hpt_device_info_v2 device;
+ } __attribute__((packed)) u;
+
+}
+__attribute__((packed));
+
+/*
+ * ioctl structure
+ */
+#define HPT_IOCTL_MAGIC   0xA1B2C3D4
+
+struct hpt_ioctl_u {
+ u32   magic;            /* used to check if it's a valid ioctl packet */
+ u32   ioctl_code;       /* operation control code */
+ void __user *inbuf;     /* input data buffer */
+ u32   inbuf_size;       /* size of input data buffer */
+ void __user *outbuf;    /* output data buffer */
+ u32   outbuf_size;      /* size of output data buffer */
+ void __user *bytes_returned;   /* count of bytes returned */
+}
+__attribute__((packed));
+
+
+struct hpt_iopmu
+{
+ u32 resrved0[4];
+ u32 inbound_msgaddr0;
+ u32 inbound_msgaddr1;
+ u32 outbound_msgaddr0;
+ u32 outbound_msgaddr1;
+ u32 inbound_doorbell;
+ u32 inbound_intstatus;
+ u32 inbound_intmask;
+ u32 outbound_doorbell;
+ u32 outbound_intstatus;
+ u32 outbound_intmask;
+ u32 reserved1[2];
+ u32 inbound_queue;
+ u32 outbound_queue;
+};
+
+#define IOPMU_QUEUE_EMPTY            0xffffffff
+#define IOPMU_QUEUE_MASK_HOST_BITS   0xf0000000
+#define IOPMU_QUEUE_ADDR_HOST_BIT    0x80000000
+
+#define IOPMU_OUTBOUND_INT_MSG0      1
+#define IOPMU_OUTBOUND_INT_MSG1      2
+#define IOPMU_OUTBOUND_INT_DOORBELL  4
+#define IOPMU_OUTBOUND_INT_POSTQUEUE 8
+#define IOPMU_OUTBOUND_INT_PCI       0x10
+
+#define IOPMU_INBOUND_INT_MSG0       1
+#define IOPMU_INBOUND_INT_MSG1       2
+#define IOPMU_INBOUND_INT_DOORBELL   4
+#define IOPMU_INBOUND_INT_ERROR      8
+#define IOPMU_INBOUND_INT_POSTQUEUE  0x10
+
+enum hpt_iopmu_message {
+ /* host-to-iop messages */
+ IOPMU_INBOUND_MSG0_NOP = 0,
+ IOPMU_INBOUND_MSG0_RESET,
+ IOPMU_INBOUND_MSG0_FLUSH,
+ IOPMU_INBOUND_MSG0_SHUTDOWN,
+ IOPMU_INBOUND_MSG0_STOP_BACKGROUND_TASK,
+ IOPMU_INBOUND_MSG0_START_BACKGROUND_TASK,
+ IOPMU_INBOUND_MSG0_MAX = 0xff,
+ /* iop-to-host messages */
+ IOPMU_OUTBOUND_MSG0_REGISTER_DEVICE_0 = 0x100,
+ IOPMU_OUTBOUND_MSG0_REGISTER_DEVICE_MAX = 0x1ff,
+ IOPMU_OUTBOUND_MSG0_UNREGISTER_DEVICE_0 = 0x200,
+ IOPMU_OUTBOUND_MSG0_UNREGISTER_DEVICE_MAX = 0x2ff,
+ IOPMU_OUTBOUND_MSG0_REVALIDATE_DEVICE_0 = 0x300,
+ IOPMU_OUTBOUND_MSG0_REVALIDATE_DEVICE_MAX = 0x3ff,
+};
+
+struct hpt_iop_request_header
+{
+    u32 size;
+    u32 type;
+    u32 flags;
+    u32 result;
+    u32 context; /* host context */
+    u32 context_hi32;
+};
+
+#define IOP_REQUEST_FLAG_SYNC_REQUEST 1
+#define IOP_REQUEST_FLAG_BIST_REQUEST 2
+#define IOP_REQUEST_FLAG_REMAPPED     4
+#define IOP_REQUEST_FLAG_OUTPUT_CONTEXT 8
+
+enum hpt_iop_request_type {
+ IOP_REQUEST_TYPE_GET_CONFIG = 0,
+ IOP_REQUEST_TYPE_SET_CONFIG,
+ IOP_REQUEST_TYPE_BLOCK_COMMAND,
+ IOP_REQUEST_TYPE_SCSI_COMMAND,
+ IOP_REQUEST_TYPE_IOCTL_COMMAND,
+ IOP_REQUEST_TYPE_MAX
+};
+
+enum hpt_iop_result_type {
+ IOP_RESULT_PENDING = 0,
+ IOP_RESULT_SUCCESS,
+ IOP_RESULT_FAIL,
+ IOP_RESULT_BUSY,
+ IOP_RESULT_RESET,
+ IOP_RESULT_INVALID_REQUEST,
+ IOP_RESULT_BAD_TARGET,
+ IOP_RESULT_MODE_SENSE_CHECK_CONDITION,
+};
+
+struct hpt_iop_request_get_config
+{
+ struct hpt_iop_request_header header;
+ u32 interface_version;
+ u32 firmware_version;
+ u32 max_requests;
+ u32 request_size;
+ u32 max_sg_count;
+ u32 data_transfer_length;
+ u32 alignment_mask;
+ u32 max_devices;
+ u32 sdram_size;
+};
+
+struct hpt_iop_request_set_config
+{
+ struct hpt_iop_request_header header;
+ u32 iop_id;
+ u32 vbus_id;
+ u32 reserve[6];
+};
+
+struct hpt_iopsg
+{
+    u32 size;
+    u32 eot; /* non-zero: end of table */
+    u64 pci_address;
+};
+
+struct hpt_iop_request_block_command
+{
+ struct hpt_iop_request_header header;
+ u8     channel;
+ u8     target;
+ u8     lun;
+ u8     pad1;
+ u16    command; /* IOP_BLOCK_COMMAND_{READ,WRITE} */
+ u16    sectors;
+ u64    lba;
+ struct hpt_iopsg sg_list[1];
+};
+
+#define IOP_BLOCK_COMMAND_READ     1
+#define IOP_BLOCK_COMMAND_WRITE    2
+#define IOP_BLOCK_COMMAND_VERIFY   3
+#define IOP_BLOCK_COMMAND_FLUSH    4
+#define IOP_BLOCK_COMMAND_SHUTDOWN 5
+
+struct hpt_iop_request_scsi_command
+{
+ struct hpt_iop_request_header header;
+ u8     channel;
+ u8     target;
+ u8     lun;
+ u8     pad1;
+ u8     cdb[16];
+ u32    dataxfer_length;
+ struct hpt_iopsg sg_list[1];
+};
+
+struct hpt_iop_request_ioctl_command
+{
+ struct hpt_iop_request_header header;
+ u32    ioctl_code;
+ u32    inbuf_size;
+ u32    outbuf_size;
+ u32    bytes_returned;
+ u8     buf[1];
+ /* out data should be put at buf[(inbuf_size+3)&~3] */
+};
+
+#define HPTIOP_MAX_REQUESTS  256u
+
+struct hptiop_request {
+ struct hptiop_request * next;
+ void *                  req_virt;
+ u32                     req_shifted_phy;
+ struct scsi_cmnd *      scp;
+ int                     index;
+};
+
+struct hpt_scsi_pointer {
+ int mapped;
+ int sgcnt;
+ dma_addr_t dma_handle;
+};
+
+#define HPT_SCP(scp) ((struct hpt_scsi_pointer *)&(scp)->SCp)
+
+struct hptiop_hba {
+ struct hpt_iopmu __iomem * iop;
+ struct Scsi_Host * host;
+ struct pci_dev * pcidev;
+
+ /* IOP config info */
+ u32     firmware_version;
+ u32     sdram_size;
+ u32     max_devices;
+ u32     max_requests;
+ u32     max_request_size;
+ u32     max_sg_descriptors;
+
+ u32     req_size; /* host-allocated request buffer size */
+ int     initialized;
+ int     msg_done;
+
+ struct hptiop_request * req_list;
+ struct hptiop_request reqs[HPTIOP_MAX_REQUESTS];
+
+ /* used to free allocated dma area */
+ void *      dma_coherent;
+ dma_addr_t  dma_coherent_handle;
+
+ atomic_t    outstandingcommands;
+ atomic_t    reset_count;
+ atomic_t    resetting;
+
+ wait_queue_head_t reset_wq;
+ wait_queue_head_t ioctl_wq;
+};
+
+struct hpt_ioctl_k
+{
+ struct hptiop_hba * hba;
+ u32    ioctl_code;
+ u32    inbuf_size;
+ u32    outbuf_size;
+ void * inbuf;
+ void * outbuf;
+ u32  * bytes_returned;
+ void (*done)(struct hpt_ioctl_k *);
+ int    result; /* HPT_IOCTL_RESULT_ */
+};
+
+#define HPT_IOCTL_RESULT_OK         0
+#define HPT_IOCTL_RESULT_FAILED     (-1)
+
+#if 0
+#define dprintk(fmt, args...) do { printk(fmt, ##args); } while(0)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+#endif

