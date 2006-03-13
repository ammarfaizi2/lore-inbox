Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWCMWlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWCMWlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWCMWlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:41:16 -0500
Received: from havoc.gtf.org ([69.61.125.42]:32139 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964805AbWCMWlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:41:14 -0500
Date: Mon, 13 Mar 2006 17:41:12 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: promise_linux@promise.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2.6.16-rc6] Promise SuperTrak driver
Message-ID: <20060313224112.GA19513@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Here follows the 'shasta' driver, contributed by Promise, for review.
They've asked me to make the "open source introduction" for them.
The SuperTrak hardware is a controller where you talk to a firmware
via SCSI CDBs.

It's been through a couple rounds of review by me, so its pretty clean
already.  I already spotted another couple niggles though: my mispelling
of 'SuperTrek', and the deprecated use of pci_module_init().

Anyway, comment away...  The driver maintainer is CC'd.

The 'shasta' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

contains the following updates:

 drivers/scsi/Kconfig  |    7 
 drivers/scsi/Makefile |    1 
 drivers/scsi/shasta.c | 1210 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1218 insertions(+)

Jeff Garzik:
      [SCSI] Add Promise SuperTrak 'shasta' driver.

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 3c606cf..de75299 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1033,6 +1033,13 @@ config 53C700_LE_ON_BE
 	depends on SCSI_LASI700
 	default y
 
+config SCSI_SHASTA
+	tristate "Promise SuperTrek EX8350/8300/16350/16300 support"
+	depends on PCI && SCSI
+	---help---
+	  This driver supports Promise SuperTrak EX8350/8300/16350/16300
+	  Storage controllers.
+
 config SCSI_SYM53C8XX_2
 	tristate "SYM53C8XX Version 2 SCSI support"
 	depends on PCI && SCSI
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 320e765..0c5cee0 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_SCSI_LASI700)	+= 53c700.o l
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
 obj-$(CONFIG_SCSI_IPR)		+= ipr.o
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
+obj-$(CONFIG_SCSI_SHASTA)	+= shasta.o
 obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
diff --git a/drivers/scsi/shasta.c b/drivers/scsi/shasta.c
new file mode 100644
index 0000000..21fcdfd
--- /dev/null
+++ b/drivers/scsi/shasta.c
@@ -0,0 +1,1210 @@
+/*
+ * SuperTrak EX8350/8300/16350/16300 Storage Controller driver for Linux
+ *
+ *	Copyright (C) 2005, 2006 Promise Technology Inc.
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Written By: 
+ *		Ed Lin <edl@promisechina.com>
+ *
+ *	Version: 2.9.0.13
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/blkdev.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/byteorder.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_host.h>
+
+#define SHASTA_NAME "shasta"
+#define ST_DRIVER_DATE "(Mar 6, 2006)"
+#define ST_DRIVER_VERSION "2.9.0.13"
+#define VER_MAJOR 		2	
+#define VER_MINOR 		9
+#define OEM 			0
+#define BUILD_VER 		13
+
+enum{
+	/* MU status code */
+	MU_STATE_STARTING			= 1,
+	MU_STATE_FMU_READY_FOR_HANDSHAKE	= 2,
+	MU_STATE_SEND_HANDSHAKE_FRAME		= 3,
+	MU_STATE_STARTED			= 4,
+	MU_STATE_RESETTING			= 5,
+
+	MU_MAX_DELAY_TIME			= 50000,
+	MU_HANDSHAKE_SIGNATURE			= 0x55aaaa55,
+	HMU_PARTNER_TYPE			= 2,
+
+	/* MU register offset */
+	IMR0	= 0x10,	/* MU_INBOUND_MESSAGE_REG0 */
+	IMR1	= 0x14,	/* MU_INBOUND_MESSAGE_REG1 */
+	OMR0	= 0x18,	/* MU_OUTBOUND_MESSAGE_REG0 */
+	OMR1	= 0x1c,	/* MU_OUTBOUND_MESSAGE_REG1 */
+	IDBL	= 0x20,	/* MU_INBOUND_DOORBELL */
+	IIS	= 0x24,	/* MU_INBOUND_INTERRUPT_STATUS */
+	IIM	= 0x28,	/* MU_INBOUND_INTERRUPT_MASK */
+	ODBL	= 0x2c,	/* MU_OUTBOUND_DOORBELL */
+	OIS	= 0x30,	/* MU_OUTBOUND_INTERRUPT_STATUS */
+	OIM	= 0x3c,	/* MU_OUTBOUND_INTERRUPT_MASK */
+
+	/* MU register value */
+	MU_INBOUND_DOORBELL_HANDSHAKE		= 1,
+	MU_INBOUND_DOORBELL_REQHEADCHANGED	= 2,
+	MU_INBOUND_DOORBELL_STATUSTAILCHANGED	= 4,
+	MU_INBOUND_DOORBELL_HMUSTOPPED		= 8,
+	MU_INBOUND_DOORBELL_RESET		= 16,
+
+	MU_OUTBOUND_DOORBELL_HANDSHAKE		= 1,
+	MU_OUTBOUND_DOORBELL_REQUESTTAILCHANGED	= 2,
+	MU_OUTBOUND_DOORBELL_STATUSHEADCHANGED	= 4,
+	MU_OUTBOUND_DOORBELL_BUSCHANGE		= 8,
+	MU_OUTBOUND_DOORBELL_HASEVENT		= 16,
+
+	/* firmware returned values */
+	SRB_STATUS_SUCCESS			= 0x01,
+	SRB_STATUS_ERROR			= 0x04,
+	SRB_STATUS_BUSY				= 0x05,
+	SRB_STATUS_INVALID_REQUEST		= 0x06,
+	SRB_STATUS_SELECTION_TIMEOUT		= 0x0A,
+	SRB_SEE_SENSE 				= 0x80,
+
+	/* task attribute */
+	TASK_ATTRIBUTE_SIMPLE			= 0x0,
+	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
+	TASK_ATTRIBUTE_ORDERED			= 0x2,
+	TASK_ATTRIBUTE_ACA			= 0x4,
+
+	/* request count, etc. */
+	MU_MAX_REQUEST		= 32,
+	TAG_BITMAP_LENGTH	= MU_MAX_REQUEST,
+
+	/* one message wasted, use MU_MAX_REQUEST+1
+		to handle MU_MAX_REQUEST messages */
+	MU_REQ_COUNT		= (MU_MAX_REQUEST + 1),
+	MU_STATUS_COUNT		= (MU_MAX_REQUEST + 1),
+
+	SHASTA_CDB_LENGTH	= MAX_COMMAND_SIZE,
+	REQ_VARIABLE_LEN	= 1024,
+	STATUS_VAR_LEN		= 128,
+	ST_CAN_QUEUE		= MU_MAX_REQUEST,
+	ST_CMD_PER_LUN		= MU_MAX_REQUEST,
+	ST_MAX_SG		= 32,
+
+	/* sg flags */
+	SG_CF_EOT		= 0x80,	/* end of table */
+	SG_CF_64B		= 0x40,	/* 64 bit format item */
+	SG_CF_HOST		= 0x20,	/* sg is in host address space */
+	SG_CF_RAW		= 0x10,	
+	SG_CF_DMA		= 0x08,
+
+	ST_MAX_ARRAY_SUPPORTED	= 16,
+	ST_MAX_TARGET_NUM	= (ST_MAX_ARRAY_SUPPORTED+1),
+	ST_MAX_LUN_PER_TARGET	= 16,
+
+	PASSTHRU_REQ_TYPE	= 0x00000001,
+	PASSTHRU_REQ_NO_WAKEUP	= 0x00000100,
+	ST_INTERNAL_TIMEOUT	= 30,
+
+	/* vendor specific commands of Promise */
+	ARRAY_CMD		= 0xe0,
+	CONTROLLER_CMD		= 0xe1,
+	DEBUGGING_CMD		= 0xe2,
+	PASSTHRU_CMD		= 0xe3,
+
+	PASSTHRU_GET_ADAPTER	= 0x05,
+	PASSTHRU_GET_DRVVER	= 0x10,
+	CTLR_POWER_STATE_CHANGE	= 0x0e,
+	CTLR_POWER_SAVING	= 0x01,
+
+	PASSTHRU_SIGNATURE	= 0x4e415041,
+
+	INQUIRY_EVPD		= 0x01,
+};
+
+struct st_sgitem {
+	u8 ctrl;	/* SG_CF_xxx */
+	u8 reserved[3];
+	__le32 count;
+	__le32 addr;
+	__le32 addr_hi;
+};
+
+struct st_sgtable {
+	__le16 sg_count;
+	__le16 max_sg_count; 
+	__le32 sz_in_byte;
+	struct st_sgitem table[ST_MAX_SG];
+};
+
+struct handshake_frame {
+	__le32 rb_phy;		/* request payload queue physical address */
+	__le32 rb_phy_hi;
+	__le16 req_sz;		/* size of each request payload */
+	__le16 req_cnt;		/* count of reqs the buffer can hold */
+	__le16 status_sz;	/* size of each status payload */
+	__le16 status_cnt;	/* count of status the buffer can hold */
+	__le32 hosttime;	/* seconds from Jan 1, 1970 (GMT) */
+	__le32 hosttime_hi;
+	u8 partner_type;	/* who sends this frame */
+	u8 reserved0[7];
+	__le32 partner_ver_major;		/* partner version */
+	__le32 partner_ver_minor;
+	__le32 partner_ver_oem;
+	__le32 partner_ver_build;
+	u32 reserved1[4];
+};
+
+struct req_msg {
+	__le16 tag;
+	u8 lun;
+	u8 target;
+	u8 task_attr;
+	u8 task_manage;
+	u8 prd_entry;
+	u8 payload_sz;	/* payload size in 4-byte */
+	u8 cdb[SHASTA_CDB_LENGTH];
+	u8 variable[REQ_VARIABLE_LEN];
+};
+
+struct status_msg {
+	__le16 tag;
+	u8 lun;
+	u8 target;
+	u8 srb_status;
+	u8 scsi_status;
+	u8 reserved;
+	u8 payload_sz;	/* payload size in 4-byte */
+	u8 variable[STATUS_VAR_LEN];
+};
+
+#define MU_REQ_BUFFER_SIZE	(MU_REQ_COUNT * sizeof(struct req_msg))
+#define MU_STATUS_BUFFER_SIZE	(MU_STATUS_COUNT * sizeof(struct status_msg))
+#define MU_BUFFER_SIZE		(MU_REQ_BUFFER_SIZE + MU_STATUS_BUFFER_SIZE)
+
+struct ver_info {
+	u32 major;
+	u32 minor;
+	u32 oem;
+	u32 build;
+	u32 reserved[2];
+};
+
+struct st_frame {
+	u32 base[6];
+	u32 rom_addr;
+
+	struct ver_info drv_ver;
+	struct ver_info bios_ver;
+
+	u32 bus;
+	u32 slot;
+	u32 irq_level;
+	u32 irq_vec;
+	u32 id;	
+	u32 subid;
+
+	u32 dimm_size;
+	u8 dimm_type;	
+	u8 reserved[3];
+	
+	u32 channel;
+	u32 reserved1;
+};
+
+struct st_drvver {
+	u32 major;
+	u32 minor;
+	u32 oem;
+	u32 build;
+	u32 signature[2];
+	u8 console_id;
+	u8 host_no;
+	u8 reserved0[2];
+	u32 reserved[3];
+};
+
+struct st_ccb {
+	struct req_msg *req;
+	struct scsi_cmnd *cmd;
+
+	void *sense_buffer;
+	struct page *page;
+	unsigned int sense_bufflen;
+	unsigned int page_offset;
+
+	u32 req_type;
+	u8 srb_status;
+	u8 scsi_status;
+};
+
+struct st_hba {
+	void __iomem *mmio_base;	/* iomapped PCI memory space */
+	void *dma_mem;
+	dma_addr_t dma_handle;
+
+	struct Scsi_Host *host;
+	struct pci_dev *pdev;
+
+	u32 tag;
+	u32 req_head;
+	u32 req_tail;
+	u32 status_head;
+	u32 status_tail;
+
+	struct status_msg *status_buffer;
+	struct st_ccb ccb[MU_MAX_REQUEST];
+	struct st_ccb *wait_ccb;
+	wait_queue_head_t waitq;
+
+	unsigned int mu_status;
+	int out_req_cnt;
+};
+
+static char console_inq_page[] =
+{
+	0x03,0x00,0x03,0x03,0xFA,0x00,0x00,0x30,
+	0x50,0x72,0x6F,0x6D,0x69,0x73,0x65,0x20,	/* "Promise " */
+	0x52,0x41,0x49,0x44,0x20,0x43,0x6F,0x6E,	/* "RAID Con" */
+	0x73,0x6F,0x6C,0x65,0x20,0x20,0x20,0x20,	/* "sole    " */
+	0x31,0x2E,0x30,0x30,0x20,0x20,0x20,0x20,	/* "1.00    " */
+	0x53,0x58,0x2F,0x52,0x53,0x41,0x46,0x2D,	/* "SX/RSAF-" */
+	0x54,0x45,0x31,0x2E,0x30,0x30,0x20,0x20,	/* "TE1.00  " */
+	0x0C,0x20,0x20,0x20,0x20,0x20,0x20,0x20
+};
+
+MODULE_AUTHOR("Ed Lin");
+MODULE_DESCRIPTION("Promise Technology SuperTrak EX Controllers");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(ST_DRIVER_VERSION);
+
+static inline void shasta_gettime(u32 *time)
+{
+	struct timeval tv;
+	do_gettimeofday(&tv);
+
+	*time = cpu_to_le32(tv.tv_sec & 0xffffffff);
+	*(time + 1) = cpu_to_le32((tv.tv_sec >> 16) >> 16); 
+}
+
+static inline u16 shasta_alloc_tag(u32 *bitmap)
+{
+	u16 i;
+	for (i = 0; i < TAG_BITMAP_LENGTH; i++) 
+		if (!((*bitmap) & (1 << i))) {
+			*bitmap |= (1 << i);
+			return i;
+		}
+
+	return TAG_BITMAP_LENGTH;
+}
+
+static inline void shasta_free_tag(u32 *bitmap, u16 tag)
+{
+	*bitmap &= ~(1 << tag);
+}
+
+static inline struct status_msg *shasta_get_status(struct st_hba *hba)
+{
+	struct status_msg *status = 
+		hba->status_buffer + hba->status_tail;
+
+	++hba->status_tail;
+	hba->status_tail %= MU_STATUS_COUNT;
+
+	return status;
+}
+
+static inline struct req_msg *shasta_alloc_req(struct st_hba *hba)
+{
+	struct req_msg *req = ((struct req_msg *)hba->dma_mem) +
+		hba->req_head;
+
+	++hba->req_head;
+	hba->req_head %= MU_REQ_COUNT;
+
+	return req;
+}
+
+static inline void shasta_map_sg(struct st_hba *hba,
+	struct req_msg *req, struct scsi_cmnd *cmd)
+{
+	struct pci_dev *pdev = hba->pdev;
+	dma_addr_t dma_handle;
+	struct scatterlist *src;
+	struct st_sgtable *dst;
+	int i;
+
+	dst = (struct st_sgtable *)req->variable;
+	dst->max_sg_count = cpu_to_le16(ST_MAX_SG);
+	dst->sz_in_byte = cpu_to_le32(cmd->request_bufflen);
+
+	if (cmd->use_sg) {
+		src = (struct scatterlist *) cmd->request_buffer;
+		dst->sg_count = cpu_to_le16((u16)pci_map_sg(pdev, src,
+			cmd->use_sg, cmd->sc_data_direction));
+
+		for (i = 0; i < dst->sg_count; i++, src++) {
+			dst->table[i].count = cpu_to_le32((u32)sg_dma_len(src));
+			dst->table[i].addr = 
+				cpu_to_le32(sg_dma_address(src) & 0xffffffff);
+			dst->table[i].addr_hi = 
+				cpu_to_le32((sg_dma_address(src) >> 16) >> 16);
+			dst->table[i].ctrl = SG_CF_64B | SG_CF_HOST;
+    		}
+		dst->table[--i].ctrl |= SG_CF_EOT;
+		return;
+	}
+
+	dma_handle = pci_map_single(pdev, cmd->request_buffer,
+		cmd->request_bufflen, cmd->sc_data_direction);
+	cmd->SCp.dma_handle = dma_handle;
+
+	dst->sg_count = cpu_to_le16(1);
+	dst->table[0].addr = cpu_to_le32(dma_handle & 0xffffffff);
+	dst->table[0].addr_hi = cpu_to_le32((dma_handle >> 16) >> 16);
+	dst->table[0].count = cpu_to_le32((u32)cmd->request_bufflen);
+	dst->table[0].ctrl = SG_CF_EOT | SG_CF_64B | SG_CF_HOST;
+}
+
+static int shasta_direct_cp(struct scsi_cmnd *cmd, void *src, unsigned int len)
+{
+	void *dest;
+	unsigned int cp_len;
+	struct scatterlist *sg = cmd->request_buffer;
+
+	if (cmd->use_sg) {
+		dest = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+		cp_len = min(sg->length, len);
+	} else {
+		dest = cmd->request_buffer;
+		cp_len = min(cmd->request_bufflen, len);
+	}
+
+	memcpy(dest, src, cp_len);
+
+	if (cmd->use_sg) 
+		kunmap_atomic(dest - sg->offset, KM_IRQ0);
+	return cp_len == len;
+}
+
+static void shasta_controller_info(struct st_hba *hba, struct st_ccb *ccb)
+{
+	struct st_frame *p;
+	struct scsi_cmnd *cmd = ccb->cmd;
+
+	if (cmd->use_sg)
+		p = kmap_atomic(ccb->page, KM_IRQ0) + ccb->page_offset;
+	else
+		p = cmd->request_buffer;
+
+	memset(p->base, 0, sizeof(u32)*6);
+	*(unsigned long *)(p->base) = pci_resource_start(hba->pdev, 0);
+	p->rom_addr = 0;
+
+	p->drv_ver.major = VER_MAJOR;
+	p->drv_ver.minor = VER_MINOR;
+	p->drv_ver.oem = OEM;
+	p->drv_ver.build = BUILD_VER;
+
+	p->bus = hba->pdev->bus->number;
+	p->slot = hba->pdev->devfn;
+	p->irq_level = 0;
+	p->irq_vec = hba->pdev->irq;
+	p->id = hba->pdev->vendor << 16 | hba->pdev->device;
+	p->subid =
+		hba->pdev->subsystem_vendor << 16 | hba->pdev->subsystem_device;
+	if (cmd->use_sg) 
+		kunmap_atomic((void *)p - ccb->page_offset, KM_IRQ0);
+}
+
+static inline void
+shasta_send_cmd(struct st_hba *hba, struct req_msg *req, u16 tag)
+{
+	req->tag = cpu_to_le16(tag);
+	req->task_attr = TASK_ATTRIBUTE_SIMPLE;
+	req->task_manage = 0; /* not supported yet */
+	req->payload_sz = (u8)((sizeof(struct req_msg))/sizeof(u32));
+
+	hba->ccb[tag].req = req;
+	hba->out_req_cnt++;
+	wmb();
+
+	writel(hba->req_head, hba->mmio_base + IMR0);
+	writel(MU_INBOUND_DOORBELL_REQHEADCHANGED, hba->mmio_base + IDBL);
+	readl(hba->mmio_base + IDBL); /* flush */
+}
+
+static int
+shasta_queuecommand(struct scsi_cmnd *cmd, void (* fn)(struct scsi_cmnd *))
+{
+	struct st_hba *hba;
+ 	struct Scsi_Host *host;
+	unsigned int id,lun;
+	struct req_msg *req;
+	u16 tag;
+	host = cmd->device->host;
+	id = cmd->device->id;
+	lun = cmd->device->channel; /* firmware lun issue work around */
+	hba = (struct st_hba *)host->hostdata;
+
+	switch (cmd->cmnd[0]) {
+	case READ_6:
+	case WRITE_6:
+		cmd->cmnd[9] = 0;
+		cmd->cmnd[8] = cmd->cmnd[4];
+		cmd->cmnd[7] = 0;
+		cmd->cmnd[6] = 0;
+		cmd->cmnd[5] = cmd->cmnd[3];
+		cmd->cmnd[4] = cmd->cmnd[2];
+		cmd->cmnd[3] = cmd->cmnd[1] & 0x1f;
+		cmd->cmnd[2] = 0;
+		cmd->cmnd[1] &= 0xe0;
+		cmd->cmnd[0] += READ_10 - READ_6;
+		break;
+	case MODE_SENSE:
+	{
+		char mode_sense[4] = { 3, 0, 0, 0 };
+
+		shasta_direct_cp(cmd, mode_sense, sizeof(mode_sense));
+		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+		fn(cmd);
+		return 0;
+	}
+	case MODE_SENSE_10:
+	{
+		char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
+
+		shasta_direct_cp(cmd, mode_sense10, sizeof(mode_sense10));
+		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+		fn(cmd);
+		return 0;
+	}
+	case INQUIRY:
+		if (id != ST_MAX_ARRAY_SUPPORTED || lun != 0) 
+			break;
+		if((cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
+			shasta_direct_cp(cmd, console_inq_page,
+				sizeof(console_inq_page));
+			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+		} else
+			cmd->result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+		fn(cmd);
+		return 0;
+	case PASSTHRU_CMD:
+		if (cmd->cmnd[1] == PASSTHRU_GET_DRVVER) {
+			struct st_drvver ver;
+			ver.major = VER_MAJOR;
+			ver.minor = VER_MINOR;
+			ver.oem = OEM;
+			ver.build = BUILD_VER;
+			ver.signature[0] = PASSTHRU_SIGNATURE;
+			ver.console_id = ST_MAX_ARRAY_SUPPORTED;
+			ver.host_no = hba->host->host_no;
+			cmd->result = shasta_direct_cp(cmd, &ver, sizeof(ver)) ?
+				DID_OK << 16 | COMMAND_COMPLETE << 8 :
+				DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+			fn(cmd);
+			return 0;
+		}
+	default:
+		break;
+	}
+
+	cmd->scsi_done = fn;
+
+	if (unlikely((tag = shasta_alloc_tag(&hba->tag)) == TAG_BITMAP_LENGTH))
+		return SCSI_MLQUEUE_HOST_BUSY;
+
+	req = shasta_alloc_req(hba);
+	req->lun = lun;
+	req->target = id;
+
+	/* cdb */
+	memcpy(req->cdb, cmd->cmnd, SHASTA_CDB_LENGTH);
+
+	if (cmd->sc_data_direction != DMA_NONE)
+		shasta_map_sg(hba, req, cmd);
+
+	hba->ccb[tag].cmd = cmd;
+	hba->ccb[tag].sense_bufflen = SCSI_SENSE_BUFFERSIZE;
+	hba->ccb[tag].sense_buffer = cmd->sense_buffer;
+	if (cmd->use_sg) {
+		hba->ccb[tag].page_offset =
+			((struct scatterlist *)cmd->request_buffer)->offset;
+		hba->ccb[tag].page =
+			((struct scatterlist *)cmd->request_buffer)->page;
+	}
+	hba->ccb[tag].req_type = 0;
+
+	shasta_send_cmd(hba, req, tag);
+    	return 0;
+}
+
+static inline void shasta_unmap_sg(struct st_hba *hba, struct scsi_cmnd *cmd)
+{
+	dma_addr_t dma_handle;
+	if (cmd->sc_data_direction != DMA_NONE) {
+ 		if (cmd->use_sg) {
+			pci_unmap_sg(hba->pdev, cmd->request_buffer,
+				cmd->use_sg, cmd->sc_data_direction);
+		} else {
+ 			dma_handle = cmd->SCp.dma_handle;
+			pci_unmap_single(hba->pdev, dma_handle,
+				cmd->request_bufflen, cmd->sc_data_direction);
+ 		}
+	}
+}
+
+static inline void shasta_scsi_fin(struct st_ccb *ccb)
+{
+	struct scsi_cmnd *cmd = ccb->cmd;
+	int result;
+
+	if (ccb->srb_status & SRB_SEE_SENSE)
+		result = DRIVER_SENSE << 24 | SAM_STAT_CHECK_CONDITION;
+	else switch (ccb->srb_status) {
+		case SRB_STATUS_SUCCESS:
+			result = DID_OK << 16 | COMMAND_COMPLETE << 8 |
+				SAM_STAT_GOOD;
+			break;
+		case SRB_STATUS_SELECTION_TIMEOUT:
+			result = DID_NO_CONNECT << 16 | COMMAND_COMPLETE << 8;
+			break;
+		case SRB_STATUS_BUSY:
+			result = DID_BUS_BUSY << 16 | COMMAND_COMPLETE << 8;
+			break;
+		case SRB_STATUS_INVALID_REQUEST:
+		case SRB_STATUS_ERROR:
+		default:
+			result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+			break;
+  	}
+
+   	cmd->result = result;
+   	cmd->scsi_done(cmd);
+}
+
+static inline void shasta_copy_data(struct st_ccb *ccb,
+	struct status_msg *resp, unsigned int variable)
+{
+	if (resp->scsi_status == SAM_STAT_GOOD) {
+		if (ccb->cmd != NULL) {
+			void *p;
+			if (ccb->cmd->use_sg)
+				p = kmap_atomic(ccb->page, KM_IRQ0)
+					+ ccb->page_offset;
+			else
+				p = ccb->cmd->request_buffer;
+			memcpy(p, resp->variable,
+				min(variable, ccb->cmd->request_bufflen));
+			if (ccb->cmd->use_sg) 
+				kunmap_atomic(p - ccb->page_offset,
+					KM_IRQ0);
+		}
+	} else {
+		if (ccb->sense_buffer != NULL)
+			memcpy(ccb->sense_buffer, resp->variable,
+				min(variable, ccb->sense_bufflen));
+	}
+}
+
+static inline void shasta_mu_intr(struct st_hba *hba, u32 doorbell)
+{
+	void __iomem *base = hba->mmio_base;
+	struct status_msg *resp;
+	struct st_ccb *ccb;
+	unsigned int size;
+	u16 tag;
+
+	if (!(doorbell & MU_OUTBOUND_DOORBELL_STATUSHEADCHANGED))
+		return;
+
+	/* status payloads */
+	hba->status_head = readl(base + OMR1);
+	if (unlikely(hba->status_head >= MU_STATUS_COUNT)) {
+		printk(KERN_WARNING SHASTA_NAME "(%s): invalid status head\n",
+			pci_name(hba->pdev));
+		return;
+	}
+
+	if (unlikely(hba->mu_status != MU_STATE_STARTED ||
+		hba->out_req_cnt <= 0)) {
+		hba->status_tail = hba->status_head;
+		goto update_status;
+	}
+
+	while (hba->status_tail != hba->status_head) {
+		resp = shasta_get_status(hba);
+		tag = le16_to_cpu(resp->tag);
+		if (unlikely(tag >= TAG_BITMAP_LENGTH)) {
+			printk(KERN_WARNING SHASTA_NAME
+				"(%s): invalid tag\n", pci_name(hba->pdev));
+			continue;
+		}
+		if (unlikely((hba->tag & (1 << tag)) == 0)) {
+			printk(KERN_WARNING SHASTA_NAME
+				"(%s): null tag\n", pci_name(hba->pdev));
+			continue;
+		}
+
+		hba->out_req_cnt--;
+		ccb = &hba->ccb[tag];
+		if (hba->wait_ccb == ccb)
+			hba->wait_ccb = NULL;
+		if (unlikely(ccb->req == NULL)) {
+			printk(KERN_WARNING SHASTA_NAME
+				"(%s): lagging req\n", pci_name(hba->pdev));
+			shasta_free_tag(&hba->tag, tag);
+  			shasta_unmap_sg(hba, ccb->cmd); /* ??? */
+			continue;
+		}
+
+		size = resp->payload_sz * sizeof(u32); /* payload size */
+		if (unlikely(size < sizeof(*resp) - STATUS_VAR_LEN ||
+			size > sizeof(*resp))) {
+			printk(KERN_WARNING SHASTA_NAME
+				"(%s): invalid status size\n", pci_name(hba->pdev));
+		} else {
+			size -= sizeof(*resp) - STATUS_VAR_LEN; /* copy size */
+			if (size)
+				shasta_copy_data(ccb, resp, size);
+		}
+
+		ccb->srb_status = resp->srb_status;
+		ccb->scsi_status = resp->scsi_status;
+
+		if (ccb->req_type & PASSTHRU_REQ_TYPE) {
+			if (ccb->req_type & PASSTHRU_REQ_NO_WAKEUP) {
+				ccb->req_type = 0;
+				continue;
+			}
+			ccb->req_type = 0;
+			if (waitqueue_active(&hba->waitq))
+				wake_up(&hba->waitq);
+			continue;
+		}
+		if (ccb->cmd->cmnd[0] == PASSTHRU_CMD &&
+			ccb->cmd->cmnd[1] == PASSTHRU_GET_ADAPTER)
+			shasta_controller_info(hba, ccb);
+		shasta_free_tag(&hba->tag, tag);
+  		shasta_unmap_sg(hba, ccb->cmd);
+		shasta_scsi_fin(ccb);
+	}
+
+update_status:
+	writel(hba->status_head, base + IMR1);
+	readl(base + IMR1); /* flush */
+}
+
+static irqreturn_t shasta_intr(int irq, void *__hba, struct pt_regs *regs)
+{
+	struct st_hba *hba = __hba;
+	void __iomem *base = hba->mmio_base;
+	u32 data;
+	unsigned long flags;
+	int handled = 0;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+
+	data = readl(base + ODBL);
+
+	if (data && data != 0xffffffff) {
+		/* clear the interrupt */
+		writel(data, base + ODBL);
+		readl(base + ODBL); /* flush */
+		shasta_mu_intr(hba, data);
+		handled = 1;
+	}
+
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int shasta_handshake(struct st_hba *hba)
+{
+	void __iomem *base = hba->mmio_base;
+	struct handshake_frame *h;
+	int i;
+
+	if (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
+		writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
+		readl(base + IDBL);
+		for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
+			&& i < MU_MAX_DELAY_TIME; i++) {
+			rmb();
+			msleep(1);
+		}
+
+		if (i == MU_MAX_DELAY_TIME) {
+			printk(KERN_ERR SHASTA_NAME
+				"(%s): no handshake signature\n",
+				pci_name(hba->pdev));
+			return -1;
+		}
+	}
+
+	udelay(10);
+
+	h = (struct handshake_frame *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
+	h->rb_phy = cpu_to_le32(hba->dma_handle);
+	h->rb_phy_hi = cpu_to_le32((hba->dma_handle >> 16) >> 16);
+	h->req_sz = cpu_to_le16(sizeof(struct req_msg));
+	h->req_cnt = cpu_to_le16(MU_REQ_COUNT);
+	h->status_sz = cpu_to_le16(sizeof(struct status_msg));
+	h->status_cnt = cpu_to_le16(MU_STATUS_COUNT);
+	shasta_gettime(&h->hosttime);
+	h->partner_type = HMU_PARTNER_TYPE;
+	wmb();
+
+	writel(hba->dma_handle + MU_REQ_BUFFER_SIZE, base + IMR0);
+	readl(base + IMR0);
+	writel((hba->dma_handle >> 16) >> 16, base + OMR0); /* 4G border safe */
+	readl(base + OMR0);
+	writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
+	readl(base + IDBL); /* flush */
+
+	udelay(10);
+	for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
+		&& i < MU_MAX_DELAY_TIME; i++) {
+		rmb();
+		msleep(1);
+	}
+
+	if (i == MU_MAX_DELAY_TIME) {
+		printk(KERN_ERR SHASTA_NAME
+			"(%s): no signature after handshake frame\n",
+			pci_name(hba->pdev));
+		return -1;
+	}
+
+	writel(0, base + IMR0);
+	readl(base + IMR0);
+	writel(0, base + OMR0);
+	readl(base + OMR0);
+	writel(0, base + IMR1);
+	readl(base + IMR1);
+	writel(0, base + OMR1);
+	readl(base + OMR1); /* flush */
+	hba->mu_status = MU_STATE_STARTED;
+	return 0;
+}
+
+static int shasta_abort(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *host = cmd->device->host;
+	struct st_hba *hba = (struct st_hba *)host->hostdata;
+	u16 tag;
+	void __iomem *base;
+	u32 data;
+	int fail = 0;
+	unsigned long flags;
+	base = hba->mmio_base;
+	spin_lock_irqsave(host->host_lock, flags);
+
+	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
+		if (hba->ccb[tag].cmd == cmd && (hba->tag & (1 << tag))) {
+			hba->wait_ccb = &(hba->ccb[tag]);
+			break;
+		}
+	if (tag >= MU_MAX_REQUEST) goto out;
+
+	data = readl(base + ODBL);
+	if (data == 0 || data == 0xffffffff) goto fail_out;
+
+	writel(data, base + ODBL);
+	readl(base + ODBL); /* flush */
+
+	shasta_mu_intr(hba, data);
+
+ 	if (hba->wait_ccb == NULL) {
+ 		printk(KERN_WARNING SHASTA_NAME
+			"(%s): lost interrupt\n", pci_name(hba->pdev));
+		goto out;
+	}
+
+fail_out:
+	hba->wait_ccb->req = NULL; /* nullify the req's future return */
+	hba->wait_ccb = NULL;
+	fail = 1;
+out:
+	spin_unlock_irqrestore(host->host_lock, flags);
+	return fail ? FAILED : SUCCESS;
+}
+
+static int shasta_reset(struct scsi_cmnd *cmd)
+{
+	struct st_hba *hba;
+	int tag;
+	int i = 0;
+	unsigned long flags;
+	hba = (struct st_hba *)cmd->device->host->hostdata;
+
+wait_cmds:
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
+		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL) 
+			break;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	if (tag < MU_MAX_REQUEST) {
+		msleep(1000);
+		if (++i < 10) goto wait_cmds;
+	}
+
+	hba->mu_status = MU_STATE_RESETTING;
+	writel(MU_INBOUND_DOORBELL_HANDSHAKE, hba->mmio_base + IDBL);
+	readl(hba->mmio_base + IDBL);
+	msleep(3000);
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+
+	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
+		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL) {
+			shasta_free_tag(&hba->tag, tag);
+			shasta_unmap_sg(hba, hba->ccb[tag].cmd);
+			hba->ccb[tag].cmd->result = DID_RESET << 16;
+			hba->ccb[tag].cmd->scsi_done(hba->ccb[tag].cmd);
+		}
+
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	if (shasta_handshake(hba)) {
+		printk(KERN_WARNING SHASTA_NAME
+			"(%s): resetting: handshake failed\n",
+			pci_name(hba->pdev));
+		return FAILED;
+	}
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	hba->tag = 0;
+	hba->req_head = 0;
+	hba->req_tail = 0;
+	hba->status_head = 0;
+	hba->status_tail = 0;
+	hba->out_req_cnt = 0;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	return SUCCESS;
+}
+
+static void shasta_init_hba(struct st_hba *hba,
+	struct Scsi_Host * host, struct pci_dev *pdev)
+{
+	host->max_channel = ST_MAX_LUN_PER_TARGET; /* fw lun work around */
+    	host->max_id = ST_MAX_TARGET_NUM;
+    	host->max_lun = 1; /* fw lun work around */
+	host->unique_id = host->host_no;
+	host->max_cmd_len = SHASTA_CDB_LENGTH;
+
+	hba->host = host;
+	hba->pdev = pdev;
+	init_waitqueue_head(&hba->waitq);
+}
+
+static int shasta_init_shm(struct st_hba *hba, struct pci_dev *pdev)
+{
+	hba->dma_mem = pci_alloc_consistent(pdev,
+		MU_BUFFER_SIZE, &hba->dma_handle);
+	if (!hba->dma_mem)
+		return -ENOMEM;
+
+	hba->status_buffer =
+		(struct status_msg *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
+	hba->mu_status = MU_STATE_STARTING;
+	return 0;
+}
+
+static void shasta_internal_flush(struct st_hba *hba, int id, u16 tag)
+{
+	struct req_msg *req;
+
+	req = shasta_alloc_req(hba);
+	memset(req->cdb, 0, SHASTA_CDB_LENGTH);
+
+	if (id < ST_MAX_ARRAY_SUPPORTED*ST_MAX_LUN_PER_TARGET) {
+		req->target = id/ST_MAX_LUN_PER_TARGET;
+		req->lun = id%ST_MAX_LUN_PER_TARGET;
+		req->cdb[0] = CONTROLLER_CMD;
+		req->cdb[1] = CTLR_POWER_STATE_CHANGE;
+		req->cdb[2] = CTLR_POWER_SAVING;
+	} else {
+		req->target = id/ST_MAX_LUN_PER_TARGET - ST_MAX_ARRAY_SUPPORTED;
+		req->lun = id%ST_MAX_LUN_PER_TARGET;
+   		req->cdb[0] = SYNCHRONIZE_CACHE;
+	}
+
+	hba->ccb[tag].cmd = NULL;
+	hba->ccb[tag].page_offset = 0;
+ 	hba->ccb[tag].page = NULL;
+	hba->ccb[tag].sense_bufflen = 0;
+	hba->ccb[tag].sense_buffer = NULL;
+	hba->ccb[tag].req_type |= PASSTHRU_REQ_TYPE;
+
+	shasta_send_cmd(hba, req, tag);
+}
+
+static int shasta_biosparam(struct scsi_device *sdev,
+	struct block_device *bdev, sector_t capacity, int geom[])
+{
+	int heads = 255, sectors = 63, cylinders;
+
+	if (capacity < 0x200000) {
+		heads = 64;
+		sectors = 32;
+	}
+
+	cylinders = sector_div(capacity, heads * sectors);
+
+	geom[0] = heads;
+	geom[1] = sectors;
+	geom[2] = cylinders;
+
+	return 0;
+}
+
+static struct scsi_host_template driver_template = {
+	.module				= THIS_MODULE,
+	.name				= SHASTA_NAME,
+	.proc_name			= SHASTA_NAME,
+	.bios_param			= shasta_biosparam,
+	.queuecommand			= shasta_queuecommand,
+	.eh_abort_handler		= shasta_abort,
+	.eh_host_reset_handler		= shasta_reset,
+	.can_queue			= ST_CAN_QUEUE,
+	.this_id			= -1,
+	.sg_tablesize			= ST_MAX_SG,
+	.cmd_per_lun			= ST_CMD_PER_LUN,
+};
+
+static int shasta_set_dma_mask(struct pci_dev * pdev)
+{
+	int ret;
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)
+	    && !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
+	    return 0;
+	ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+	if (!ret)
+		ret = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+	return ret;
+}
+
+static int __devinit
+shasta_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct st_hba *hba;
+	struct Scsi_Host *host;
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	pci_set_master(pdev);
+
+	host = scsi_host_alloc(&driver_template, sizeof(struct st_hba));
+
+	if (!host) {
+		printk(KERN_ERR SHASTA_NAME "(%s): scsi_host_alloc failed\n",
+			pci_name(pdev));
+		err = -ENOMEM;
+		goto out_disable;
+	}
+
+	hba = (struct st_hba *)host->hostdata;
+	memset(hba, 0, sizeof(struct st_hba));
+
+	err = pci_request_regions(pdev, SHASTA_NAME);
+	if (err < 0) {
+		printk(KERN_ERR SHASTA_NAME "(%s): request regions failed\n",
+			pci_name(pdev));
+		goto out_scsi_host_put;
+	}
+
+	hba->mmio_base = ioremap(pci_resource_start(pdev, 0),
+		pci_resource_len(pdev, 0));
+	if ( !hba->mmio_base) {
+		printk(KERN_ERR SHASTA_NAME "(%s): memory map failed\n",
+			pci_name(pdev));
+		err = -ENOMEM;
+		goto out_release_regions;
+	}
+
+	err = shasta_set_dma_mask(pdev);
+	if (err) {
+		printk(KERN_ERR SHASTA_NAME "(%s): set dma mask failed\n",
+			pci_name(pdev));
+		goto out_iounmap;
+	}
+
+	err = shasta_init_shm(hba, pdev);
+	if (err) {
+		printk(KERN_ERR SHASTA_NAME "(%s): dma mem alloc failed\n",
+		       pci_name(pdev));
+		goto out_iounmap;
+	}
+
+	shasta_init_hba(hba, host, pdev);
+
+	err = request_irq(pdev->irq, shasta_intr, SA_SHIRQ, SHASTA_NAME, hba);
+	if (err) {
+		printk(KERN_ERR SHASTA_NAME "(%s): request irq failed\n",
+		       pci_name(pdev));
+		goto out_pci_free;
+	}
+
+	err = shasta_handshake(hba);
+	if (err)
+		goto out_free_irq;
+
+	pci_set_drvdata(pdev, hba);
+
+	err = scsi_add_host(host, &pdev->dev);
+	if (err) {
+		printk(KERN_ERR SHASTA_NAME "(%s): scsi_add_host failed\n",
+			pci_name(pdev));
+		goto out_free_irq;
+	}
+
+	scsi_scan_host(host);
+
+	return 0;
+
+out_free_irq:
+	free_irq(pdev->irq, hba);
+out_pci_free:
+	pci_free_consistent(pdev, MU_BUFFER_SIZE,
+		hba->dma_mem, hba->dma_handle);
+out_iounmap:
+	iounmap(hba->mmio_base);	
+out_release_regions:
+	pci_release_regions(pdev);
+out_scsi_host_put:
+	scsi_host_put(host);
+out_disable:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void shasta_hba_stop(struct st_hba *hba)
+{
+	unsigned long flags;
+	int i;
+	u16 tag;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	if ((tag = shasta_alloc_tag(&hba->tag)) == TAG_BITMAP_LENGTH) {
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		printk(KERN_ERR SHASTA_NAME "(%s): unable to alloc tag\n",
+			pci_name(hba->pdev));
+		return;
+	}
+	for (i=0; i<(ST_MAX_ARRAY_SUPPORTED*ST_MAX_LUN_PER_TARGET*2); i++) {
+		shasta_internal_flush(hba, i, tag);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+		wait_event_timeout(hba->waitq,
+			!(hba->ccb[tag].req_type), ST_INTERNAL_TIMEOUT*HZ);
+		if (hba->ccb[tag].req_type & PASSTHRU_REQ_TYPE)
+			return;
+		spin_lock_irqsave(hba->host->host_lock, flags);
+	}
+
+	shasta_free_tag(&hba->tag, tag);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+
+static void shasta_hba_free(struct st_hba *hba)
+{
+	free_irq(hba->pdev->irq, hba);
+
+	iounmap(hba->mmio_base);
+
+	pci_release_regions(hba->pdev);
+
+	if (hba->dma_mem)
+		pci_free_consistent(hba->pdev, MU_BUFFER_SIZE,
+			hba->dma_mem, hba->dma_handle);
+}
+
+static void shasta_remove(struct pci_dev *pdev)
+{
+	struct st_hba *hba = pci_get_drvdata(pdev);
+
+	scsi_remove_host(hba->host);
+
+	pci_set_drvdata(pdev, NULL);
+
+	shasta_hba_stop(hba);
+
+	shasta_hba_free(hba);
+
+	scsi_host_put(hba->host);
+
+	pci_disable_device(pdev);
+}
+
+static void shasta_shutdown(struct pci_dev *pdev)
+{
+	struct st_hba *hba = pci_get_drvdata(pdev);
+
+	shasta_hba_stop(hba);
+}
+
+static struct pci_device_id shasta_pci_tbl[] = {
+	{ PCI_VENDOR_ID_INTEL, 0x0334, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, 0x0374, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_PROMISE, 0x8350, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_PROMISE, 0xf350, PCI_ANY_ID, PCI_ANY_ID, },
+	{ }	/* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, shasta_pci_tbl);
+
+static struct pci_driver shasta_pci_driver = {
+	.name		= SHASTA_NAME,
+	.id_table	= shasta_pci_tbl,
+	.probe		= shasta_probe,
+	.remove		= __devexit_p(shasta_remove),
+	.shutdown	= shasta_shutdown,
+};
+
+static int __init shasta_init(void)
+{
+	printk(KERN_INFO SHASTA_NAME
+		": Promise SuperTrak EX Driver version: %s %s\n",
+		 ST_DRIVER_VERSION, ST_DRIVER_DATE);
+
+	return pci_module_init(&shasta_pci_driver);
+}
+
+static void __exit shasta_exit(void)
+{
+	pci_unregister_driver(&shasta_pci_driver);
+}
+
+module_init(shasta_init);
+module_exit(shasta_exit);
