Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFDGai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFDGai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFDGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:30:37 -0400
Received: from mail0.lsil.com ([147.145.40.20]:46550 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261256AbVFDGNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:13:45 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCEFA@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Ju, Seokmann" <sju@lsil.com>
Subject: [PATCH scsi-misc 2/2][RESEND] megaraid_sas: LSI Logic MegaRAID SA
	S RAID Driver
Date: Sat, 4 Jun 2005 02:13:17 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>

diff -Naur scsi-misc.b/drivers/scsi/megaraid/megaraid_sas.c
scsi-misc.c/drivers/scsi/megaraid/megaraid_sas.c
--- scsi-misc.b/drivers/scsi/megaraid/megaraid_sas.c	1969-12-31
19:00:00.000000000 -0500
+++ scsi-misc.c/drivers/scsi/megaraid/megaraid_sas.c	2005-06-03
20:36:06.657461568 -0400
@@ -0,0 +1,3437 @@
+/*
+ *
+ *		Linux MegaRAID driver for SAS based RAID controllers
+ *
+ * Copyright (c) 2003-2005  LSI Logic Corporation.
+ *
+ *	   This program is free software; you can redistribute it and/or
+ *	   modify it under the terms of the GNU General Public License
+ *	   as published by the Free Software Foundation; either version
+ *	   2 of the License, or (at your option) any later version.
+ *
+ * FILE		: megaraid_sas.c
+ * Version	: v00.00.01.03-rc1
+ *
+ * Authors:
+ * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
+ *
+ * List of supported controllers
+ *
+ * OEM	Product Name			VID	DID	SSVID	SSID
+ * ---	------------			---	---	----	----
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/list.h>
+#include <linux/version.h>
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+#include "megaraid_sas.h"
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION(MEGASAS_VERSION);
+MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
+MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");
+
+/*
+ * PCI ID table for all supported controllers
+ */
+static struct pci_device_id megasas_pci_table[] = {
+
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS1064R,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+	},
+	{
+		PCI_VENDOR_ID_DELL,
+		PCI_DEVICE_ID_DELL_PERC5,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+	},
+	{ 0 }	/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(pci, megasas_pci_table);
+
+static int megasas_mgmt_majorno;
+static struct megasas_mgmt_info	megasas_mgmt_info;
+static struct fasync_struct *megasas_async_queue;
+static DECLARE_MUTEX(megasas_async_queue_mutex);
+
+/**
+ * megasas_get_cmd -	Get a command from the free pool
+ * @instance:		Adapter soft state
+ *
+ * Returns a free command from the pool
+ */
+static inline struct megasas_cmd*
+megasas_get_cmd(struct megasas_instance *instance)
+{
+	unsigned long		flags;
+	struct megasas_cmd	*cmd = NULL;
+
+	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
+
+	if (!list_empty(&instance->cmd_pool)) {
+		cmd = list_entry((&instance->cmd_pool)->next, 
+					struct megasas_cmd, list);
+		list_del_init( &cmd->list );
+	}
+
+	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
+	return cmd;
+}
+
+/**
+ * megasas_return_cmd -	Return a cmd to free command pool
+ * @instance:		Adapter soft state
+ * @cmd:		Command packet to be returned to free command pool
+ */
+static inline void
+megasas_return_cmd(struct megasas_instance *instance, struct megasas_cmd
*cmd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
+
+	list_add(&cmd->list, &instance->cmd_pool);
+
+	spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
+}
+
+/**
+ * megasas_enable_intr -	Enables interrupts
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_enable_intr(struct megasas_register_set *regs)
+{
+	writel(1, &(regs)->outbound_intr_mask);
+
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+
+/**
+ * megasas_disable_intr -	Disables interrupts
+ * @regs:			MFI register set
+ */
+static inline void
+megasas_disable_intr(struct megasas_register_set *regs)
+{
+	u32 mask = readl(&regs->outbound_intr_mask) & (~0x00000001);
+	writel(mask, &regs->outbound_intr_mask);
+
+	/* Dummy readl to force pci flush */
+	readl(&regs->outbound_intr_mask);
+}
+	
+
+/**
+ * megasas_issue_polled -	Issues a polling command
+ * @instance:			Adapter soft state
+ * @cmd:			Command packet to be issued 
+ *
+ * For polling, MFI requires the cmd_status to be set to 0xFF before
posting.
+ */
+static int
+megasas_issue_polled(struct megasas_instance *instance, struct megasas_cmd
*cmd)
+{
+	int	i;
+	u32	msecs = MFI_POLL_TIMEOUT_SECS * 1000;
+
+	struct megasas_header *frame_hdr = &cmd->frame->hdr;
+
+	frame_hdr->cmd_status	= 0xFF;
+	frame_hdr->flags 	|= MFI_FRAME_DONT_POST_IN_REPLY_QUEUE;
+
+	/*
+	 * Issue the frame using inbound queue port
+	 */
+	writel(cmd->frame_phys_addr >> 3, 
+			&instance->reg_set->inbound_queue_port);
+
+	/*
+	 * Wait for cmd_status to change
+	 */
+	for(i=0; (i < msecs) && (frame_hdr->cmd_status == 0xff); i++) {
+		rmb();
+		msleep(1);
+	}
+
+	if (frame_hdr->cmd_status == 0xff)
+		return -ETIME;
+
+	return 0;
+}
+
+/**
+ * megasas_issue_blocked_cmd -	Synchronous wrapper around regular FW cmds
+ * @instance:			Adapter soft state
+ * @cmd:			Command to be issued
+ *
+ * This function waits on an event for the command to be returned from ISR.
+ * Used to issue ioctl commands.
+ */
+static int
+megasas_issue_blocked_cmd(struct megasas_instance *instance,
+					struct megasas_cmd *cmd)
+{
+	cmd->cmd_status	= ENODATA;
+
+	writel(cmd->frame_phys_addr >> 3, 
+		&instance->reg_set->inbound_queue_port);
+
+	wait_event( instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
+
+	return 0;
+}
+
+/**
+ * megasas_issue_blocked_abort_cmd -	Aborts previously issued cmd
+ * @instance:				Adapter soft state
+ * @cmd_to_abort:			Previously issued cmd to be aborted
+ *
+ * MFI firmware can abort previously issued AEN comamnd (automatic event
+ * notification). The megasas_issue_blocked_abort_cmd() issues such abort
+ * cmd and blocks till it is completed.
+ */
+static int
+megasas_issue_blocked_abort_cmd(struct megasas_instance *instance,
+				struct megasas_cmd *cmd_to_abort)
+{
+	struct megasas_cmd		*cmd;
+	struct megasas_abort_frame	*abort_fr;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd)
+		return -1;
+
+	abort_fr = &cmd->frame->abort;
+
+	/*
+	 * Prepare and issue the abort frame
+	 */
+	abort_fr->cmd				= MFI_CMD_ABORT;
+	abort_fr->cmd_status			= 0xFF;
+	abort_fr->flags				= 0;
+	abort_fr->abort_context			= cmd_to_abort->index;
+	abort_fr->abort_mfi_phys_addr_lo	=
cmd_to_abort->frame_phys_addr;
+	abort_fr->abort_mfi_phys_addr_hi	= 0;
+
+	writel(cmd->frame_phys_addr >> 3, 
+		&instance->reg_set->inbound_queue_port);
+
+	/*
+	 * Wait for this cmd to complete
+	 */
+	cmd->sync_cmd = 1;
+	wait_event(instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF));
+
+	megasas_return_cmd(instance, cmd);
+
+	return 0;
+}
+
+/**
+ * megasas_make_sgl32 -	Prepares 32-bit SGL
+ * @instance:		Adapter soft state
+ * @scp:		SCSI command from the mid-layer
+ * @mfi_sgl:		SGL to be filled in
+ *
+ * If successful, this function returns the number of SG elements.
Otherwise,
+ * it returnes -1.
+ */
+static inline int
+megasas_make_sgl32(struct megasas_instance *instance, struct scsi_cmnd
*scp,
+						union megasas_sgl *mfi_sgl)
+{
+	int			i;
+	int			sge_count;
+	struct scatterlist	*os_sgl;
+
+	/*
+	 * Return 0 if there is no data transfer
+	 */
+	if (!scp->request_buffer || !scp->request_bufflen)
+		return 0;
+
+	if (!scp->use_sg) {
+		mfi_sgl->sge32[0].phys_addr	=
pci_map_single(instance->pdev,
+							scp->request_buffer,
+
scp->request_bufflen,
+
scp->sc_data_direction);
+		mfi_sgl->sge32[0].length	= scp->request_bufflen;
+
+		return 1;
+	}
+
+	os_sgl		= (struct scatterlist*) scp->request_buffer;
+	sge_count	= pci_map_sg(instance->pdev, os_sgl, scp->use_sg,
+					scp->sc_data_direction );
+
+	for( i = 0; i < sge_count; i++, os_sgl++ ) {
+		mfi_sgl->sge32[i].length	= sg_dma_len(os_sgl);
+		mfi_sgl->sge32[i].phys_addr	= sg_dma_address(os_sgl);
+	}
+
+	return sge_count;
+}
+
+/**
+ * megasas_make_sgl64 -	Prepares 64-bit SGL
+ * @instance:		Adapter soft state
+ * @scp:		SCSI command from the mid-layer
+ * @mfi_sgl:		SGL to be filled in
+ *
+ * If successful, this function returns the number of SG elements.
Otherwise,
+ * it returnes -1.
+ */
+static inline int
+megasas_make_sgl64(struct megasas_instance *instance, struct scsi_cmnd
*scp,
+						union megasas_sgl *mfi_sgl)
+{
+	int			i;
+	int			sge_count;
+	struct scatterlist	*os_sgl;
+
+	/*
+	 * Return 0 if there is no data transfer
+	 */
+	if (!scp->request_buffer || !scp->request_bufflen)
+		return 0;
+
+	if (!scp->use_sg) {
+		mfi_sgl->sge64[0].phys_addr	=
pci_map_single(instance->pdev,
+							scp->request_buffer,
+
scp->request_bufflen,
+
scp->sc_data_direction);
+
+		mfi_sgl->sge64[0].length	= scp->request_bufflen;
+
+		return 1;
+	}
+
+	os_sgl		= (struct scatterlist*) scp->request_buffer;
+	sge_count	= pci_map_sg(instance->pdev, os_sgl, scp->use_sg,
+					scp->sc_data_direction);
+
+	for(i = 0; i < sge_count; i++, os_sgl++) {
+		mfi_sgl->sge64[i].length	= sg_dma_len(os_sgl);
+		mfi_sgl->sge64[i].phys_addr	= sg_dma_address(os_sgl);
+	}
+
+	return sge_count;
+}
+
+/**
+ * megasas_build_dcdb -	Prepares a direct cdb (DCDB) command
+ * @instance:		Adapter soft state
+ * @scp:		SCSI command
+ * @cmd:		Command to be prepared in
+ *
+ * This function prepares CDB commands. These are typcially pass-through
+ * commands to the devices.
+ */
+static inline int
+megasas_build_dcdb(struct megasas_instance *instance, struct scsi_cmnd
*scp,
+						struct megasas_cmd *cmd)
+{
+	u32				sge_sz;
+	int				sge_bytes;
+	u32				is_logical;
+	u32				device_id;
+	u16				flags = 0;
+	struct megasas_pthru_frame*	pthru;
+
+	is_logical		= MEGASAS_IS_LOGICAL(scp);
+	device_id		= MEGASAS_DEV_INDEX(instance, scp);
+	pthru			= (struct megasas_pthru_frame*) cmd->frame;
+
+	if (scp->sc_data_direction == PCI_DMA_TODEVICE )
+		flags = MFI_FRAME_DIR_WRITE;
+	else if( scp->sc_data_direction == PCI_DMA_FROMDEVICE )
+		flags = MFI_FRAME_DIR_READ;
+	else if( scp->sc_data_direction == PCI_DMA_NONE )
+		flags = MFI_FRAME_DIR_NONE;
+
+	/*
+	 * Prepare the DCDB frame
+	 */
+	pthru->cmd		= (is_logical) ? MFI_CMD_LD_SCSI_IO :
+							MFI_CMD_PD_SCSI_IO;
+	pthru->cmd_status	= 0x0;
+	pthru->scsi_status	= 0x0;
+	pthru->target_id	= device_id;
+	pthru->lun		= scp->device->lun;
+	pthru->cdb_len		= scp->cmd_len;
+	pthru->timeout		= 0;
+	pthru->flags		= flags;
+	pthru->data_xfer_len	= scp->request_bufflen;
+
+	memcpy(pthru->cdb, scp->cmnd, scp->cmd_len);
+
+	/*
+	 * Construct SGL
+	 */
+	sge_sz 	= (IS_DMA64) ? sizeof(struct megasas_sge64) :
+				sizeof(struct megasas_sge32);
+
+	if (IS_DMA64) {
+		pthru->flags	|= MFI_FRAME_SGL64;
+		pthru->sge_count = megasas_make_sgl64(instance, scp,
+
&pthru->sgl);
+	}
+	else
+		pthru->sge_count = megasas_make_sgl32(instance, scp,
+
&pthru->sgl);
+
+	/*
+	 * Sense info specific
+	 */
+	pthru->sense_len		= SCSI_SENSE_BUFFERSIZE;
+	pthru->sense_buf_phys_addr_hi	= 0;
+	pthru->sense_buf_phys_addr_lo	= cmd->sense_phys_addr;
+
+	sge_bytes = sge_sz * pthru->sge_count;
+
+	/*
+	 * Compute the total number of frames this command consumes. FW uses
+	 * this number to pull sufficient number of frames from host memory.
+	 */
+	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+				((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) +
1;
+
+	if (cmd->frame_count > 7)
+		cmd->frame_count = 8;
+
+	return cmd->frame_count;
+}
+
+/**
+ * megasas_build_ldio -	Prepares IOs to logical devices
+ * @instance:		Adapter soft state
+ * @scp:		SCSI command
+ * @cmd:		Command to to be prepared
+ *
+ * Frames (and accompanying SGLs) for regular SCSI IOs use this function.
+ */
+static inline int
+megasas_build_ldio(struct megasas_instance *instance, struct scsi_cmnd
*scp,
+						struct megasas_cmd *cmd)
+{
+	u32				sge_sz;
+	int				sge_bytes;
+	u32				device_id;
+	u8				sc = scp->cmnd[0];
+	u16				flags = 0;
+	struct megasas_io_frame		*ldio;
+
+	device_id	= MEGASAS_DEV_INDEX(instance, scp);
+	ldio		= (struct megasas_io_frame*) cmd->frame;
+
+	if (scp->sc_data_direction == PCI_DMA_TODEVICE )
+		flags = MFI_FRAME_DIR_WRITE;
+	else if( scp->sc_data_direction == PCI_DMA_FROMDEVICE )
+		flags = MFI_FRAME_DIR_READ;
+
+	/*
+	 * Preare the Logical IO frame: 2nd bit is zero for all read cmds
+	 */
+	ldio->cmd		= (sc &
0x02)?MFI_CMD_LD_WRITE:MFI_CMD_LD_READ;
+	ldio->cmd_status	= 0x0;
+	ldio->scsi_status	= 0x0;
+	ldio->target_id		= device_id;
+	ldio->timeout		= 0;
+	ldio->reserved_0	= 0;
+	ldio->pad_0		= 0;
+	ldio->flags		= flags;
+	ldio->start_lba_hi	= 0;
+	ldio->access_byte	= (scp->cmd_len != 6) ? scp->cmnd[1] : 0;
+
+	/*
+	 * 6-byte READ(0x08) or WRITE(0x0A) cdb
+	 */
+	if (scp->cmd_len == 6) {
+		ldio->lba_count		=	(u32)scp->cmnd[4];
+		ldio->start_lba_lo	= 	((u32)scp->cmnd[1] << 16)|
+						((u32)scp->cmnd[2] << 8) |
+						(u32)scp->cmnd[3];
+
+		ldio->start_lba_lo 	&=	0x1FFFFF;
+	}
+
+	/*
+	 * 10-byte READ(0x28) or WRITE(0x2A) cdb
+	 */
+	else if (scp->cmd_len == 10) {
+		ldio->lba_count		=	(u32)scp->cmnd[8] |
+						((u32)scp->cmnd[7] << 8);
+		ldio->start_lba_lo	=	((u32)scp->cmnd[2] << 24)|
+						((u32)scp->cmnd[3] << 16)|
+						((u32)scp->cmnd[4] << 8)|
+						(u32)scp->cmnd[5];
+	}
+
+	/*
+	 * 12-byte READ(0xA8) or WRITE(0xAA) cdb
+	 */
+	else if (scp->cmd_len == 12) {
+		ldio->lba_count		=	((u32)scp->cmnd[6] << 24)|
+						((u32)scp->cmnd[7] << 16)|
+						((u32)scp->cmnd[8] << 8) |
+						(u32)scp->cmnd[9];
+
+		ldio->start_lba_lo	=	((u32)scp->cmnd[2] << 24)|
+						((u32)scp->cmnd[3] << 16)|
+						((u32)scp->cmnd[4] << 8) |
+						(u32)scp->cmnd[5];
+	}
+
+	/*
+	 * 16-byte READ(0x88) or WRITE(0x8A) cdb
+	 */
+	else if (scp->cmd_len == 16) {
+		ldio->lba_count		=	((u32)scp->cmnd[10] << 24)|
+						((u32)scp->cmnd[11] << 16)|
+						((u32)scp->cmnd[12] << 8) |
+						(u32)scp->cmnd[13];
+
+		ldio->start_lba_lo	=	((u32)scp->cmnd[6] << 24)|
+						((u32)scp->cmnd[7] << 16)|
+						((u32)scp->cmnd[8] << 8) |
+						(u32)scp->cmnd[9];
+
+		ldio->start_lba_hi	=	((u32)scp->cmnd[2] << 24)|
+						((u32)scp->cmnd[3] << 16)|
+						((u32)scp->cmnd[4] << 8) |
+						(u32)scp->cmnd[5];
+
+	}
+
+	/*
+	 * Construct SGL
+	 */
+	sge_sz 	= (IS_DMA64) ? sizeof(struct megasas_sge64) :
+					sizeof(struct megasas_sge32);
+
+	if (IS_DMA64) {
+		ldio->flags	|= MFI_FRAME_SGL64;
+		ldio->sge_count = megasas_make_sgl64(instance, scp,
+								&ldio->sgl);
+	}
+	else
+		ldio->sge_count = megasas_make_sgl32(instance, scp,
+								&ldio->sgl);
+
+	/*
+	 * Sense info specific
+	 */
+	ldio->sense_len			= SCSI_SENSE_BUFFERSIZE;
+	ldio->sense_buf_phys_addr_hi	= 0;
+	ldio->sense_buf_phys_addr_lo	= cmd->sense_phys_addr;
+
+	sge_bytes = sge_sz * ldio->sge_count;
+
+	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+				((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) +
1;
+
+	if (cmd->frame_count > 7)
+		cmd->frame_count = 8;
+
+	return cmd->frame_count;
+}
+
+/**
+ * megasas_build_cmd -	Prepares a command packet
+ * @instance:		Adapter soft state
+ * @scp:		SCSI command
+ * @frame_count:	[OUT] Number of frames used to prepare this command
+ */
+static inline struct megasas_cmd*
+megasas_build_cmd(struct megasas_instance *instance, struct scsi_cmnd *scp,
+							int *frame_count )
+{
+	u32			logical_cmd;
+	struct megasas_cmd	*cmd;
+
+	/*
+	 * Find out if this is logical or physical drive command.
+	 */
+	logical_cmd	= MEGASAS_IS_LOGICAL(scp);
+
+	/*
+	 * Logical drive command
+	 */
+	if (logical_cmd) {
+
+		if (scp->device->id >= MEGASAS_MAX_LD) {
+			scp->result = DID_BAD_TARGET << 16;
+			return NULL;
+		}
+
+		switch(scp->cmnd[0]) {
+
+		case READ_10:
+		case WRITE_10:
+		case READ_12:
+		case WRITE_12:
+		case READ_6:
+		case WRITE_6:
+		case READ_16:
+		case WRITE_16:
+			/*
+			 * Fail for LUN > 0
+			 */
+			if (scp->device->lun) {
+				scp->result = DID_BAD_TARGET << 16;
+				return NULL;
+			}
+
+			cmd = megasas_get_cmd(instance);
+
+			if (!cmd) {
+				scp->result = DID_IMM_RETRY << 16;
+				return NULL;
+			}
+
+			*frame_count = megasas_build_ldio(instance, scp,
cmd);
+
+			if (! (*frame_count) ) {
+				megasas_return_cmd( instance, cmd );
+				return NULL;
+			}
+
+			return cmd;
+
+		default:
+			/*
+			 * Fail for LUN > 0
+			 */
+			if (scp->device->lun) {
+				scp->result = DID_BAD_TARGET << 16;
+				return NULL;
+			}
+
+			cmd = megasas_get_cmd(instance);
+
+			if (!cmd) {
+				scp->result = DID_IMM_RETRY << 16;
+				return NULL;
+			}
+
+			*frame_count = megasas_build_dcdb(instance, scp,
cmd);
+
+			if (! (*frame_count) ) {
+				megasas_return_cmd(instance, cmd);
+				return NULL;
+			}
+
+			return cmd;
+		}
+	}
+	else {
+		cmd = megasas_get_cmd(instance);
+
+		if (!cmd) {
+			scp->result = DID_IMM_RETRY << 16;
+			return NULL;
+		}
+
+		*frame_count = megasas_build_dcdb(instance, scp, cmd);
+
+		if (!(*frame_count)) {
+			megasas_return_cmd(instance, cmd);
+			return NULL;
+		}
+
+		return cmd;
+	}
+
+	return NULL;
+}
+
+/**
+ * megasas_queue_command -	Queue entry point
+ * @scmd:			SCSI command to be queued
+ * @done:			Callback entry point
+ */
+static int
+megasas_queue_command(struct scsi_cmnd *scmd, void (*done)(struct
scsi_cmnd*))
+{
+	u32				frame_count;
+	unsigned long			flags;
+	struct megasas_cmd		*cmd;
+	struct megasas_instance		*instance;
+
+	instance	= (struct megasas_instance*)
+				scmd->device->host->hostdata;
+	scmd->scsi_done	= done;
+	scmd->result	= 0;
+
+	cmd = megasas_build_cmd( instance, scmd, &frame_count );
+
+	if (!cmd) {
+		done(scmd);
+		return 0;
+	}
+
+	cmd->scmd = scmd;
+
+	/*
+	 * Issue the command to the FW
+	 */
+	spin_lock_irqsave(&instance->instance_lock, flags);
+	instance->fw_outstanding++;
+	spin_unlock_irqrestore(&instance->instance_lock, flags);
+
+	writel(((cmd->frame_phys_addr >> 3) | (cmd->frame_count - 1)),
+				&instance->reg_set->inbound_queue_port );
+
+	return 0;
+}
+
+/**
+ * megasas_wait_for_outstanding -	Wait for all outstanding cmds
+ * @instance:				Adapter soft state
+ *
+ * This function waits for upto MEGASAS_RESET_WAIT_TIME seconds for FW to
+ * complete all its outstanding commands. Returns error if one or more IOs
+ * are pending after this time period. It also marks the controller dead.
+ */
+static int
+megasas_wait_for_outstanding(struct megasas_instance *instance)
+{
+	int	i;
+	u32	wait_time = MEGASAS_RESET_WAIT_TIME;
+
+	for(i = 0; i < wait_time; i++) {
+
+		if (!instance->fw_outstanding)
+			break;
+
+		if (!(i % MEGASAS_RESET_NOTICE_INTERVAL)) {
+			printk( KERN_NOTICE "megasas: [%2d]waiting for %d "
+			"commands to complete\n", i,
instance->fw_outstanding );
+		}
+
+		msleep(1000);
+	}
+
+
+	if (instance->fw_outstanding) {
+		instance->hw_crit_error = 1;
+		return FAILED;
+	}
+
+	return SUCCESS;
+}
+
+/**
+ * megasas_generic_reset -	Generic reset routine
+ * @scmd:			Mid-layer SCSI command
+ *
+ * This routine implements a generic reset handler for device, bus and host
+ * reset requests. Device, bus and host specific reset handlers can use
this
+ * function after they do their specific tasks.
+ */
+static int
+megasas_generic_reset(struct scsi_cmnd *scmd)
+{
+	int				ret_val;
+	struct	megasas_instance	*instance;
+       
+	instance = (struct megasas_instance*)scmd->device->host->hostdata;
+
+	printk(KERN_NOTICE "megasas: RESET -%ld cmd=%x <c=%d t=%d l=%d>\n",
+		scmd->serial_number, scmd->cmnd[0], scmd->device->channel,
+		scmd->device->id, scmd->device->lun);
+
+	if (instance->hw_crit_error) {
+		printk(KERN_ERR "megasas: cannot recover from previous reset
"
+
"failures\n");
+		return FAILED;
+	}
+
+	spin_unlock(scmd->device->host->host_lock);
+
+	ret_val = megasas_wait_for_outstanding(instance);
+
+	if (ret_val == SUCCESS)
+		printk(KERN_NOTICE "megasas: reset successful \n");
+	else
+		printk(KERN_ERR "megasas: failed to do reset\n");
+
+	spin_lock(scmd->device->host->host_lock);
+
+	return ret_val;
+}
+
+/**
+ * megasas_reset_device -	Device reset handler entry point
+ *
+ * Issues CLUSTER_RESET_LD (FW direct cmd) before calling generic reset fn.
+ */
+static int
+megasas_reset_device(struct scsi_cmnd *scmd)
+{
+	int				ret;
+	struct megasas_cmd		*cmd;
+	struct megasas_dcmd_frame	*dcmd;
+	struct megasas_instance		*instance;
+        
+	/*
+	 * First wait for all commands to complete
+	 */
+	ret = megasas_generic_reset(scmd);
+
+	if (ret == FAILED)
+		return ret;
+
+	/*
+	 * Reset reservations on LD
+	 */
+	instance = (struct megasas_instance*)scmd->device->host->hostdata;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (cmd) {
+
+		dcmd = &cmd->frame->dcmd;
+
+		memset( dcmd->mbox, 0, MFI_MBOX_SIZE );
+
+		dcmd->cmd		= MFI_CMD_DCMD;
+		dcmd->cmd_status	= 0x0;
+		dcmd->sge_count		= 0;
+		dcmd->flags		= MFI_FRAME_DIR_NONE;
+		dcmd->timeout		= 0;
+		dcmd->data_xfer_len	= 0;
+		dcmd->opcode		= MR_DCMD_CLUSTER_RESET_LD;
+		dcmd->mbox[0]		= MEGASAS_DEV_INDEX(instance, scmd);
+
+		megasas_issue_blocked_cmd(instance, cmd);
+
+		megasas_return_cmd(instance, cmd);
+	}
+
+	return ret;
+}
+
+/**
+ * megasas_reset_bus_host -	Bus & host reset handler entry point
+ *
+ * Issues CLUSTER_RESET_ALL (FW direct cmd) before calling generic reset
fn.
+ */
+static int
+megasas_reset_bus_host(struct scsi_cmnd *scmd)
+{
+	int				ret;
+	struct megasas_cmd		*cmd;
+	struct megasas_dcmd_frame	*dcmd;
+	struct megasas_instance		*instance;
+
+	/*
+	 * Frist wait for all commands to complete
+	 */
+	ret = megasas_generic_reset(scmd);
+
+	if (ret == FAILED)
+		return ret;
+	
+	/*
+	 * Reset all reservations
+	 */
+	instance = (struct megasas_instance*)scmd->device->host->hostdata;
+
+	cmd = megasas_get_cmd( instance );
+
+	if (cmd) {
+
+		dcmd = &cmd->frame->dcmd;
+
+		memset( dcmd->mbox, 0, MFI_MBOX_SIZE );
+
+		dcmd->cmd		= MFI_CMD_DCMD;
+		dcmd->cmd_status	= 0x0;
+		dcmd->sge_count		= 0;
+		dcmd->flags		= MFI_FRAME_DIR_NONE;
+		dcmd->timeout		= 0;
+		dcmd->data_xfer_len	= 0;
+		dcmd->opcode		= MR_DCMD_CLUSTER_RESET_ALL;
+
+		megasas_issue_blocked_cmd(instance, cmd);
+
+		megasas_return_cmd(instance, cmd);
+	}
+
+	return ret;
+}
+
+/**
+ * megasas_service_aen -	Processes an event notification
+ * @instance:			Adapter soft state
+ * @cmd:			AEN command completed by the ISR
+ *
+ * For AEN, driver sends a command down to FW that is held by the FW till
an
+ * event occurs. When an event of interest occurs, FW completes the command
+ * that it was previously holding.
+ *
+ * This routines sends SIGIO signal to processes that have registered with
the
+ * driver for AEN.
+ */
+static void
+megasas_service_aen(struct megasas_instance *instance, struct megasas_cmd
*cmd)
+{
+	/*
+	 * Don't signal app if it is just an aborted previously registered
aen
+	 */
+	if (!cmd->abort_aen)
+		kill_fasync( &megasas_async_queue, SIGIO, POLL_IN );
+	else
+		cmd->abort_aen = 0;
+
+	instance->aen_cmd = NULL;
+	megasas_return_cmd(instance, cmd);
+}
+
+/**
+ * megasas_sysfs_show_app_hndl - Exports adapter handle via sysfs
+ *
+ * User space applications _don't_ address the controllers using zero based
+ * indices. Instead driver exports a unique 16-bit handle for each
controller
+ * (refer to comments under MR_LINUX_GET_ADAPTER_MAP ioctl).
+ *
+ * Applications use this handle to delete or add logical drives (via FW
+ * commands). To make these logical driver appear or disappear to SCSI
layer,
+ * applications have to do a delete or scan on a SCSI host in sysfs tree.
+ * The applications have to have a way to find out the SCSI host number
+ * corresponding to the unique 16-bit handle.
+ *
+ * This function exports the unique 16-bit handle in sysfs under the SCSI
+ * host. Applications can traverse the list of hosts till they find a host
+ * that has the required handle.
+ */
+static ssize_t
+megasas_sysfs_show_app_hndl(struct class_device *cdev, char *buf)
+{
+	int				i;
+	u32				hndl = 0;
+	struct Scsi_Host		*shost;
+	struct megasas_instance		*instance;
+
+	shost		= class_to_shost( cdev );
+	instance	= (struct megasas_instance*)shost->hostdata;
+
+	for (i = 0; i < megasas_mgmt_info.max_index; i++ ) {
+
+		if (instance == megasas_mgmt_info.instance[i])
+			hndl = ((i + 1) << 4) | 0xF;
+	}
+
+	return snprintf(buf, 8, "%u\n", hndl);
+}
+
+/*
+ * Sysfs attribute definition: Exports driver specific controller handle
+ */
+CLASS_DEVICE_ATTR(megaraid_sas_app_hndl, S_IRUSR,
megasas_sysfs_show_app_hndl,
+
NULL);
+/*
+ * Host template initializer for sysfs attributes
+ */
+static struct class_device_attribute* megasas_shost_attrs[] = {
+	&class_device_attr_megaraid_sas_app_hndl,
+	NULL,
+};
+
+/*
+ * Scsi host template for megaraid_sas driver
+ */
+static struct scsi_host_template megasas_template = {
+
+	.module				= THIS_MODULE,
+	.name				= "LSI Logic SAS based MegaRAID
driver",
+	.queuecommand			= megasas_queue_command,
+	.eh_device_reset_handler	= megasas_reset_device,
+	.eh_bus_reset_handler		= megasas_reset_bus_host,
+	.eh_host_reset_handler		= megasas_reset_bus_host,
+	.use_clustering			= ENABLE_CLUSTERING,
+	.shost_attrs			= megasas_shost_attrs,
+};
+
+/**
+ * megasas_complete_int_cmd -	Completes an internal command
+ * @instance:			Adapter soft state
+ * @cmd:			Command to be completed
+ *
+ * The megasas_issue_blocked_cmd() function waits for a command to complete
+ * after it issues a command. This function wakes up that waiting routine
by
+ * calling wake_up() on the wait queue.
+ */
+static void
+megasas_complete_int_cmd(struct megasas_instance *instance,
+					struct megasas_cmd* cmd)
+{
+	cmd->cmd_status = cmd->frame->io.cmd_status;
+
+	if (cmd->cmd_status == ENODATA) {
+		cmd->cmd_status = 0;
+	}
+	wake_up(&instance->int_cmd_wait_q);
+}
+
+/**
+ * megasas_complete_abort -	Completes aborting a command
+ * @instance:			Adapter soft state
+ * @cmd:			Cmd that was issued to abort another cmd
+ *
+ * The megasas_issue_blocked_abort_cmd() function waits on abort_cmd_wait_q

+ * after it issues an abort on a previously issued command. This function 
+ * wakes up all functions waiting on the same wait queue.
+ */
+static void
+megasas_complete_abort(struct megasas_instance *instance,
+				struct megasas_cmd *cmd)
+{
+	if (cmd->sync_cmd) {
+		cmd->sync_cmd = 0;
+		wake_up(&instance->abort_cmd_wait_q);
+	}
+
+	return;
+}
+
+/**
+ * megasas_unmap_sgbuf -	Unmap SG buffers
+ * @instance:			Adapter soft state
+ * @cmd:			Completed command
+ */
+static inline void
+megasas_unmap_sgbuf(struct megasas_instance *instance, struct megasas_cmd
*cmd)
+{
+	dma_addr_t	buf_h;
+	u8		opcode;
+
+	if (cmd->scmd->use_sg) {
+		pci_unmap_sg(instance->pdev, cmd->scmd->request_buffer,
+			cmd->scmd->use_sg, cmd->scmd->sc_data_direction);
+		return;
+	}
+
+	if (!cmd->scmd->request_bufflen)
+		return;
+
+	opcode = cmd->frame->hdr.cmd;
+
+	if ((opcode == MFI_CMD_LD_READ) || (opcode == MFI_CMD_LD_WRITE)) {
+		if (IS_DMA64)
+			buf_h = cmd->frame->io.sgl.sge64[0].phys_addr;
+		else
+			buf_h = cmd->frame->io.sgl.sge32[0].phys_addr;
+	}
+	else {
+		if (IS_DMA64)
+			buf_h = cmd->frame->pthru.sgl.sge64[0].phys_addr;
+		else
+			buf_h = cmd->frame->pthru.sgl.sge32[0].phys_addr;
+	}
+
+	pci_unmap_single(instance->pdev, buf_h, cmd->scmd->request_bufflen,
+
cmd->scmd->sc_data_direction);
+	return;
+}
+
+/**
+ * megasas_complete_cmd -	Completes a command
+ * @instance:			Adapter soft state
+ * @cmd:			Command to be completed
+ * @alt_status:			If non-zero, use this value as
status to 
+ * 				SCSI mid-layer instead of the value returned
+ * 				by the FW. This should be used if caller
wants
+ * 				an alternate status (as in the case of
aborted
+ * 				commands)
+ */
+static inline void
+megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd
*cmd,
+								u8
alt_status)
+{
+	int			exception = 0;
+	struct	megasas_header	*hdr = &cmd->frame->hdr;
+	unsigned long		flags;
+
+	switch( hdr->cmd ) {
+
+	case MFI_CMD_PD_SCSI_IO:
+	case MFI_CMD_LD_SCSI_IO:
+
+		/*
+		 * MFI_CMD_PD_SCSI_IO and MFI_CMD_LD_SCSI_IO could have been
+		 * issued either through an IO path or an IOCTL path. If it
+		 * was via IOCTL, we will send it to internal completion.
+		 */
+		if (cmd->sync_cmd) {
+			cmd->sync_cmd = 0;
+			megasas_complete_int_cmd(instance, cmd);
+			break;
+		}
+
+		/*
+		 * Don't export physical disk devices to mid-layer.
+		 */
+		if (!MEGASAS_IS_LOGICAL(cmd->scmd) && 
+			(hdr->cmd_status == MFI_STAT_OK) &&
+			(cmd->scmd->cmnd[0] == INQUIRY)) {
+
+			if (((*(u8*) cmd->scmd->request_buffer) & 0x1F) ==
+								TYPE_DISK) {
+				cmd->scmd->result = DID_BAD_TARGET << 16;
+				exception = 1;
+			}
+		}
+
+	case MFI_CMD_LD_READ:
+	case MFI_CMD_LD_WRITE:
+
+		if (alt_status) {
+			cmd->scmd->result = alt_status << 16;
+			exception = 1;
+		}
+
+
+		if (exception) {
+	
+			spin_lock_irqsave(&instance->instance_lock, flags);
+			instance->fw_outstanding--;
+			spin_unlock_irqrestore(&instance->instance_lock,
flags);
+
+			megasas_unmap_sgbuf(instance, cmd);
+			cmd->scmd->scsi_done(cmd->scmd);
+			megasas_return_cmd(instance, cmd);
+
+			break;
+		}
+
+
+		switch (hdr->cmd_status) {
+
+		case MFI_STAT_OK:
+		case MFI_STAT_LD_CC_IN_PROGRESS:
+		case MFI_STAT_LD_INIT_IN_PROGRESS:
+		case MFI_STAT_LD_RECON_IN_PROGRESS:
+			cmd->scmd->result = DID_OK << 16;
+			break;
+
+		case MFI_STAT_SCSI_IO_FAILED:
+			cmd->scmd->result = (DID_ERROR << 16)
|hdr->scsi_status;
+			break;
+
+		case MFI_STAT_SCSI_DONE_WITH_ERROR:
+
+			cmd->scmd->result = (DID_OK << 16) |
hdr->scsi_status;
+
+			if (hdr->scsi_status == SAM_STAT_CHECK_CONDITION) {
+				memset(cmd->scmd->sense_buffer, 0,
+
SCSI_SENSE_BUFFERSIZE);
+				memcpy(cmd->scmd->sense_buffer, cmd->sense,
+							hdr->sense_len);
+
+				cmd->scmd->result |= DRIVER_SENSE << 24;
+			}
+
+			break;
+
+		case MFI_STAT_DEVICE_NOT_FOUND:
+			cmd->scmd->result = DID_BAD_TARGET << 16;
+			break;
+
+		default:
+			printk(KERN_DEBUG "megasas: unhandled status %#x\n",
+							hdr->cmd_status);
+			cmd->scmd->result = DID_ERROR << 16;
+		}
+
+		spin_lock_irqsave(&instance->instance_lock, flags);
+		instance->fw_outstanding--;
+		spin_unlock_irqrestore(&instance->instance_lock, flags);
+
+		megasas_unmap_sgbuf(instance, cmd);
+		cmd->scmd->scsi_done(cmd->scmd);
+		megasas_return_cmd(instance, cmd);
+
+		break;
+
+	case MFI_CMD_SMP:
+	case MFI_CMD_STP:
+	case MFI_CMD_DCMD:
+
+		/*
+		 * See if got an event notification
+		 */
+		if (cmd->frame->dcmd.opcode == MR_DCMD_CTRL_EVENT_WAIT)
+			megasas_service_aen(instance, cmd);
+		else
+			megasas_complete_int_cmd(instance, cmd);
+
+		break;
+
+	case MFI_CMD_ABORT:
+		/*
+		 * Cmd issued to abort another cmd returned
+		 */
+		megasas_complete_abort(instance, cmd);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/**
+ * megasas_deplete_reply_queue -	Processes all completed commands
+ * @instance:				Adapter soft state
+ * @alt_status:				Alternate status to be
returned to
+ * 					SCSI mid-layer instead of the status
+ * 					returned by the FW
+ */
+static inline int
+megasas_deplete_reply_queue(struct megasas_instance *instance, u8
alt_status)
+{
+	u32			status;
+	u32			producer;
+	u32			consumer;
+	u32			context;
+	struct megasas_cmd	*cmd;
+
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = readl(&instance->reg_set->outbound_intr_status);
+
+	if (!(status & MFI_OB_INTR_STATUS_MASK)) {
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	writel(status, &instance->reg_set->outbound_intr_status);
+
+	producer = *instance->producer;
+	consumer = *instance->consumer;
+
+	while(consumer != producer) {
+		context = instance->reply_queue[consumer];
+
+		cmd = instance->cmd_list[context];
+
+		megasas_complete_cmd( instance, cmd, alt_status );
+
+		consumer++;
+		if (consumer == (instance->max_fw_cmds + 1)) {
+			consumer = 0;
+		}
+	}
+
+	*instance->consumer = producer;
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * megasas_isr - isr entry point
+ */
+static irqreturn_t
+megasas_isr(int irq, void *devp, struct pt_regs *regs)
+{
+	return megasas_deplete_reply_queue((struct megasas_instance*)devp,
+			       					DID_OK );
+}
+
+/**
+ * megasas_transition_to_ready -	Move the FW to READY state
+ * @reg_set:				MFI register set
+ *
+ * During the initialization, FW passes can potentially be in any one of
+ * several possible states. If the FW in operational, waiting-for-handshake
+ * states, driver must take steps to bring it to ready state. Otherwise, it
+ * has to wait for the ready state.
+ */
+static int
+megasas_transition_to_ready(struct megasas_register_set *reg_set)
+{
+	int	i;
+	u8	max_wait;
+	u32	fw_state;
+	u32	cur_state;
+
+	fw_state = readl(&reg_set->outbound_msg_0) & MFI_STATE_MASK;
+
+	while(fw_state != MFI_STATE_READY) {
+
+		printk(KERN_INFO "megasas: Waiting for FW to come to ready" 
+								" state\n");
+		switch(fw_state) {
+
+		case MFI_STATE_FAULT:
+
+			printk(KERN_DEBUG "megasas: FW in FAULT state!!\n");
+			return -ENODEV;
+
+		case MFI_STATE_WAIT_HANDSHAKE:
+			/*
+			 * Set the CLR bit in inbound doorbell
+			 */
+			writel(MFI_INIT_CLEAR_HANDSHAKE, 
+				&reg_set->inbound_doorbell);
+
+			max_wait	= 2;
+			cur_state	= MFI_STATE_WAIT_HANDSHAKE;
+			break;
+
+		case MFI_STATE_OPERATIONAL:
+			/*
+			 * Bring it to READY state; assuming max wait 2 secs
+			 */
+			megasas_disable_intr(reg_set);
+			writel(MFI_INIT_READY, &reg_set->inbound_doorbell);
+
+			max_wait	= 10;
+			cur_state	= MFI_STATE_OPERATIONAL;
+			break;
+
+		case MFI_STATE_UNDEFINED:
+			/*
+			 * This state should not last for more than 2
seconds
+			 */
+			max_wait	= 2;
+			cur_state	= MFI_STATE_UNDEFINED;
+			break;
+
+		case MFI_STATE_BB_INIT:
+			max_wait	= 2;
+			cur_state	= MFI_STATE_BB_INIT;
+			break;
+
+		case MFI_STATE_FW_INIT:
+			max_wait	= 20;
+			cur_state	= MFI_STATE_FW_INIT;
+			break;
+
+		case MFI_STATE_FW_INIT_2:
+			max_wait	= 20;
+			cur_state	= MFI_STATE_FW_INIT_2;
+			break;
+
+		case MFI_STATE_DEVICE_SCAN:
+			max_wait	= 20;
+			cur_state	= MFI_STATE_DEVICE_SCAN;
+			break;
+
+		case MFI_STATE_FLUSH_CACHE:
+			max_wait	= 20;
+			cur_state	= MFI_STATE_FLUSH_CACHE;
+			break;
+
+		default:
+			printk(KERN_DEBUG "megasas: Unknown state 0x%x\n",
+								fw_state);
+			return -ENODEV;
+		}
+
+		/*
+		 * The cur_state should not last for more than max_wait secs
+		 */
+		for(i = 0; i < (max_wait * 1000); i++) {
+			fw_state = MFI_STATE_MASK & 
+					readl(&reg_set->outbound_msg_0);
+
+			if (fw_state == cur_state) {
+				msleep(1);
+			}
+			else
+				break;
+		}
+
+		/*
+		 * Return error if fw_state hasn't changed after max_wait
+		 */
+		if (fw_state == cur_state) {
+			printk(KERN_DEBUG "FW state [%d] hasn't changed "
+				"in %d secs\n", fw_state, max_wait);
+			return -ENODEV;
+		}
+	};
+
+	return 0;
+}
+
+/**
+ * megasas_teardown_frame_pool -	Destroy the cmd frame DMA pool
+ * @instance:				Adapter soft state
+ */
+static void
+megasas_teardown_frame_pool(struct megasas_instance *instance)
+{
+	int			i;
+	u32			max_cmd = instance->max_fw_cmds;
+	struct megasas_cmd	*cmd;
+
+	if (!instance->frame_dma_pool)
+		return;
+
+	/*
+	 * Return all frames to pool
+	 */
+	for(i = 0; i < max_cmd; i++) {
+
+		cmd = instance->cmd_list[i];
+
+		if( cmd->frame)
+			pci_pool_free(instance->frame_dma_pool, cmd->frame,
+					cmd->frame_phys_addr);
+
+		if (cmd->sense)
+			pci_pool_free(instance->sense_dma_pool, cmd->frame,
+					cmd->sense_phys_addr);
+	}
+
+	/*
+	 * Now destroy the pool itself
+	 */
+	pci_pool_destroy(instance->frame_dma_pool);
+	pci_pool_destroy(instance->sense_dma_pool);
+
+	instance->frame_dma_pool = NULL;
+	instance->sense_dma_pool = NULL;
+}
+
+/**
+ * megasas_create_frame_pool -	Creates DMA pool for cmd frames
+ * @instance:			Adapter soft state
+ *
+ * Each command packet has an embedded DMA memory buffer that is used for
+ * filling MFI frame and the SG list that immediately follows the frame.
This
+ * function creates those DMA memory buffers for each command packet by
using
+ * PCI pool facility.
+ */
+static int
+megasas_create_frame_pool(struct megasas_instance *instance)
+{
+	int			i;
+	u32			max_cmd;
+	u32			sge_sz;
+	u32			sgl_sz;
+	u32			total_sz ;
+	u32			frame_count;
+	struct megasas_cmd	*cmd;
+
+	max_cmd = instance->max_fw_cmds;
+
+	/*
+	 * Size of our frame is 64 bytes for MFI frame, followed by max SG
+	 * elements and finally SCSI_SENSE_BUFFERSIZE bytes for sense buffer
+	 */
+	sge_sz	= (IS_DMA64) ? sizeof(struct megasas_sge64) :
+				sizeof(struct megasas_sge32);
+
+	/*
+	 * Calculated the number of 64byte frames required for SGL
+	 */
+	sgl_sz		= sge_sz * instance->max_num_sge;
+	frame_count	= (sgl_sz + MEGAMFI_FRAME_SIZE -
1)/MEGAMFI_FRAME_SIZE;
+
+	/*
+	 * We need one extra frame for the MFI command
+	 */
+	frame_count++;
+
+	total_sz = MEGAMFI_FRAME_SIZE * frame_count;
+	/*
+	 * Use DMA pool facility provided by PCI layer
+	 */
+	instance->frame_dma_pool = pci_pool_create("megasas frame pool",
+					instance->pdev, total_sz, 64, 0);
+
+	if (!instance->frame_dma_pool) {
+		printk(KERN_DEBUG "megasas: failed to setup frame pool\n");
+		return -ENOMEM;
+	}
+
+	instance->sense_dma_pool = pci_pool_create("megasas sense pool",
+					instance->pdev, 128, 4, 0);
+
+	if (!instance->sense_dma_pool) {
+		printk(KERN_DEBUG "megasas: failed to setup sense pool\n");
+		
+		pci_pool_destroy(instance->frame_dma_pool);
+		instance->frame_dma_pool = NULL;
+
+		return -ENOMEM;
+	}
+
+	/*
+	 * Allocate and attach a frame to each of the commands in cmd_list.
+	 * By making cmd->index as the context instead of the &cmd, we can
+	 * always use 32bit context regardless of the architecture
+	 */
+	for( i = 0; i < max_cmd; i++ ) {
+
+		cmd		= instance->cmd_list[i];
+
+		cmd->frame	= pci_pool_alloc(instance->frame_dma_pool,
+					GFP_KERNEL, &cmd->frame_phys_addr);
+
+		cmd->sense	= pci_pool_alloc(instance->sense_dma_pool,
+					GFP_KERNEL, &cmd->sense_phys_addr);
+
+		/*
+		 * megasas_teardown_frame_pool() takes care of freeing
+		 * whatever has been allocated
+		 */
+		if (!cmd->frame || !cmd->sense) {
+			printk(KERN_DEBUG "megasas: pci_pool_alloc failed
\n");
+			megasas_teardown_frame_pool(instance);
+			return -ENOMEM;
+		}
+
+		cmd->frame->io.context	= cmd->index;
+	}
+
+	return 0;
+}
+
+/**
+ * megasas_free_cmds -	Free all the cmds in the free cmd pool
+ * @instance:		Adapter soft state
+ */
+static void
+megasas_free_cmds(struct megasas_instance *instance)
+{
+	int i;
+	/* First free the MFI frame pool */
+	megasas_teardown_frame_pool( instance );
+
+	/* Free all the commands in the cmd_list */
+	for (i = 0; i < instance->max_fw_cmds; i++)
+		kfree(instance->cmd_list[i]);
+	
+	/* Free the cmd_list buffer itself */
+	kfree(instance->cmd_list);
+	instance->cmd_list = NULL;
+
+	INIT_LIST_HEAD( &instance->cmd_pool );
+}
+
+/**
+ * megasas_alloc_cmds -	Allocates the command packets
+ * @instance:		Adapter soft state
+ *
+ * Each command that is issued to the FW, whether IO commands from the OS
or
+ * internal commands like IOCTLs, are wrapped in local data structure
called
+ * megasas_cmd. The frame embedded in this megasas_cmd is actually issued
to
+ * the FW.
+ *
+ * Each frame has a 32-bit field called context (tag). This context is used
+ * to get back the megasas_cmd from the frame when a frame gets completed
in
+ * the ISR. Typically the address of the megasas_cmd itself would be used
as
+ * the context. But we wanted to keep the differences between 32 and 64 bit
+ * systems to the mininum. We always use 32 bit integers for the context.
In
+ * this driver, the 32 bit values are the indices into an array cmd_list.
+ * This array is used only to look up the megasas_cmd given the context.
The
+ * free commands themselves are maintained in a linked list called
cmd_pool.
+ */
+static int
+megasas_alloc_cmds(struct megasas_instance *instance)
+{
+	int			i;
+	int			j;
+	u32			max_cmd;
+	struct megasas_cmd	*cmd;
+
+	max_cmd = instance->max_fw_cmds;
+
+	/*
+	 * instance->cmd_list is an array of struct megasas_cmd pointers.
+	 * Allocate the dynamic array first and then allocate individual
+	 * commands.
+	 */
+	instance->cmd_list = kmalloc(sizeof(struct megasas_cmd*) * max_cmd,
+								GFP_KERNEL);
+
+	if (!instance->cmd_list) {
+		printk(KERN_DEBUG "megasas: out of memory\n");
+		return -ENOMEM;
+	}
+
+	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd*) *
max_cmd);
+
+	for(i = 0; i < max_cmd; i++) {
+		instance->cmd_list[i] = kmalloc(sizeof(struct megasas_cmd),
+								GFP_KERNEL);
+
+		if (!instance->cmd_list[i]) {
+
+			for (j = 0; j < i; j++)
+				kfree(instance->cmd_list[j]);
+
+			kfree(instance->cmd_list);
+			instance->cmd_list = NULL;
+
+			return -ENOMEM;
+		}
+	}
+
+	/*
+	 * Add all the commands to command pool (instance->cmd_pool)
+	 */
+	for( i = 0; i < max_cmd; i++ ) {
+		cmd = instance->cmd_list[i];
+		memset(cmd, 0, sizeof(struct megasas_cmd));
+		cmd->index	= i;
+
+		list_add_tail(&cmd->list, &instance->cmd_pool);
+	}
+
+	/*
+	 * Create a frame pool and assign one frame to each cmd
+	 */
+	if (megasas_create_frame_pool(instance)) {
+		printk(KERN_DEBUG "megasas: Error creating frame DMA
pool\n");
+		megasas_free_cmds(instance);
+	}
+
+	return 0;
+}
+
+/**
+ * megasas_get_controller_info -	Returns FW's controller structure
+ * @instance:				Adapter soft state
+ * @ctrl_info:				Controller information structure
+ *
+ * Issues an internal command (DCMD) to get the FW's controller structure.
+ * This information is mainly used to find out the maximum IO transfer per
+ * command supported by the FW.
+ */
+static int
+megasas_get_ctrl_info(struct megasas_instance *instance,
+				struct megasas_ctrl_info *ctrl_info)
+{
+	int				ret = 0;
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+	struct megasas_ctrl_info*	ci;
+	dma_addr_t			ci_h;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd) {
+		printk(KERN_DEBUG "megasas: Failed to get a free cmd\n");
+		return -ENOMEM;
+	}
+
+	dcmd = &cmd->frame->dcmd;
+
+	ci = pci_alloc_consistent(instance->pdev,
+				sizeof(struct megasas_ctrl_info), &ci_h);
+
+	if (!ci) {
+		printk(KERN_DEBUG "Failed to alloc mem for ctrl info\n");
+		megasas_return_cmd(instance, cmd);
+		return -ENOMEM;
+	}
+
+	memset(ci, 0, sizeof(*ci));
+	memset(dcmd->mbox, 0, MFI_MBOX_SIZE);
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0xFF;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct megasas_ctrl_info);
+	dcmd->opcode			= MR_DCMD_CTRL_GET_INFO;
+	dcmd->sgl.sge32[0].phys_addr	= ci_h;
+	dcmd->sgl.sge32[0].length	= sizeof(struct megasas_ctrl_info);
+
+	if (!megasas_issue_polled(instance, cmd)) {
+		ret = 0;
+		memcpy(ctrl_info, ci, sizeof(struct megasas_ctrl_info));
+	}
+	else {
+		ret = -1;
+	}
+
+	pci_free_consistent(instance->pdev, sizeof(struct
megasas_ctrl_info),
+								ci, ci_h);
+
+	megasas_return_cmd(instance, cmd);
+	return ret;
+}
+
+/**
+ * megasas_init_mfi -	Initializes the FW
+ * @instance:		Adapter soft state
+ *
+ * This is the main function for initializing MFI firmware.
+ */
+static int
+megasas_init_mfi(struct megasas_instance *instance)
+{
+	u32				context_sz;
+	u32				reply_q_sz;
+	u32				max_sectors_1;
+	u32				max_sectors_2;
+	struct megasas_register_set	*reg_set;
+
+	struct megasas_cmd		*cmd;
+	struct megasas_ctrl_info	*ctrl_info;
+
+	struct megasas_init_frame	*init_frame;
+	struct megasas_init_queue_info	*initq_info;
+	dma_addr_t			init_frame_h;
+	dma_addr_t			initq_info_h;
+
+	/*
+	 * Map the message registers
+	 */
+	instance->base_addr = pci_resource_start(instance->pdev, 0);
+
+	if (pci_request_regions(instance->pdev, "megasas: LSI Logic")) {
+		printk( KERN_DEBUG "megasas: IO memory region busy!\n");
+		return -EBUSY;
+	}
+
+	instance->reg_set = (struct megasas_register_set*) ioremap_nocache(
+						instance->base_addr, 8192);
+
+	if (!instance->reg_set) {
+		printk( KERN_DEBUG "megasas: Failed to map IO mem\n" );
+		goto fail_ioremap;
+	}
+
+	reg_set = instance->reg_set;
+
+	/*
+	 * We expect the FW state to be READY
+	 */
+	if (megasas_transition_to_ready(instance->reg_set))
+		goto fail_ready_state;
+
+	/*
+	 * Get various operational parameters from status register
+	 */
+	instance->max_fw_cmds = readl(&reg_set->outbound_msg_0) & 0x00FFFF;
+	instance->max_num_sge =(readl(&reg_set->outbound_msg_0) & 0xFF0000)
>>
+
0x10;
+	/*
+	 * Create a pool of commands
+	 */
+	if (megasas_alloc_cmds(instance))
+		goto fail_alloc_cmds;
+
+	/*
+	 * Allocate memory for reply queue. Length of reply queue should
+	 * be _one_ more than the maximum commands handled by the firmware.
+	 *
+	 * Note: When FW completes commands, it places corresponding contex
+	 * values in this circular reply queue. This circular queue is a
fairly
+	 * typical producer-consumer queue. FW is the producer (of completed
+	 * commands) and the driver is the consumer.
+	 */
+	context_sz = sizeof(u32);
+	reply_q_sz = context_sz * (instance->max_fw_cmds + 1);
+
+	instance->reply_queue = pci_alloc_consistent(instance->pdev,
+				reply_q_sz, &instance->reply_queue_h);
+
+	if (!instance->reply_queue) {
+		printk( KERN_DEBUG "megasas: Out of DMA mem for reply
queue\n");
+		goto fail_reply_queue;
+	}
+
+	/*
+	 * Prepare a init frame. Note the init frame points to queue info
+	 * structure. Each frame has SGL allocated after first 64 bytes. For
+	 * this frame - since we don't need any SGL - we use SGL's space as
+	 * queue info structure
+	 *
+	 * We will not get a NULL command below. We just created the pool.
+	 */
+	cmd = megasas_get_cmd(instance);
+
+	init_frame	= (struct megasas_init_frame*) cmd->frame;
+	initq_info	= (struct megasas_init_queue_info*)
+				((unsigned long)init_frame + 64);
+
+	init_frame_h	= cmd->frame_phys_addr;
+	initq_info_h	= init_frame_h + 64;
+
+	memset(init_frame, 0, MEGAMFI_FRAME_SIZE);
+	memset(initq_info, 0, sizeof(struct megasas_init_queue_info));
+
+	initq_info->reply_queue_entries	= instance->max_fw_cmds + 1;
+	initq_info->reply_queue_start_phys_addr_lo =
+						instance->reply_queue_h;
+
+	initq_info->producer_index_phys_addr_lo = instance->producer_h;
+	initq_info->consumer_index_phys_addr_lo = instance->consumer_h;
+
+	init_frame->cmd				= MFI_CMD_INIT;
+	init_frame->cmd_status			= 0xFF;
+	init_frame->queue_info_new_phys_addr_lo	= initq_info_h;
+
+	init_frame->data_xfer_len = sizeof(struct megasas_init_queue_info);
+
+	/*
+	 * Issue the init frame in polled mode
+	 */
+	if (megasas_issue_polled(instance, cmd)) {
+		printk(KERN_DEBUG "megasas: Failed to init firmware\n");
+		goto fail_fw_init;
+	}
+
+	megasas_return_cmd(instance, cmd);
+
+	ctrl_info = kmalloc(sizeof(struct megasas_ctrl_info), GFP_KERNEL);
+
+	/*
+	 * Compute the max allowed sectors per IO: The controller info has
two
+	 * limits on max sectors. Driver should use the minimum of these
two.
+	 *
+	 * 1 << stripe_sz_ops.min = max sectors per strip
+	 *
+	 * Note that older firmwares ( < FW ver 30) didn't report
information
+	 * to calculate max_sectors_1. So the number ended up as zero
always.
+	 */
+	if (ctrl_info && !megasas_get_ctrl_info(instance, ctrl_info)) {
+
+		max_sectors_1 =	(1 << ctrl_info->stripe_sz_ops.min) *
+					ctrl_info->max_strips_per_io;
+		max_sectors_2 =	ctrl_info->max_request_size;
+
+		instance->max_sectors_per_req = (max_sectors_1 <
max_sectors_2) 
+					?  max_sectors_1 : max_sectors_2;
+	}
+	else
+		instance->max_sectors_per_req = instance->max_num_sge *
+						PAGE_SIZE / 512;
+
+	kfree(ctrl_info);
+
+	return 0;
+
+fail_fw_init:
+	megasas_return_cmd(instance, cmd);
+
+	pci_free_consistent(instance->pdev, reply_q_sz,
+				instance->reply_queue,
+				instance->reply_queue_h);
+fail_reply_queue:
+	megasas_free_cmds(instance);
+
+fail_alloc_cmds:
+fail_ready_state:
+	iounmap(instance->reg_set);
+
+fail_ioremap:
+	pci_release_regions(instance->pdev);
+
+	return -EINVAL;
+}
+
+/**
+ * megasas_release_mfi -	Reverses the FW initialization
+ * @intance:			Adapter soft state
+ */
+static void
+megasas_release_mfi(struct megasas_instance *instance)
+{
+	u32 reply_q_sz = sizeof(u32) * (instance->max_fw_cmds + 1);
+
+	pci_free_consistent(instance->pdev, reply_q_sz,
+				instance->reply_queue,
+				instance->reply_queue_h);
+
+	megasas_free_cmds(instance);
+
+	iounmap(instance->reg_set);
+
+	pci_release_regions(instance->pdev);
+}
+
+/**
+ * megasas_get_seq_num -	Gets latest event sequence numbers
+ * @instance:			Adapter soft state
+ * @eli:			FW event log sequence numbers information
+ *
+ * FW maintains a log of all events in a non-volatile area. Upper layers
would
+ * usually find out the latest sequence number of the events, the seq
number at
+ * the boot etc. They would "read" all the events below the latest seq
number
+ * by issuing a direct fw cmd (DCMD). For the future events (beyond latest
seq
+ * number), they would subsribe to AEN (asynchronous event notification)
and
+ * wait for the events to happen.
+ */
+static int
+megasas_get_seq_num( struct megasas_instance *instance,
+			struct megasas_evt_log_info *eli)
+{
+	struct megasas_cmd		*cmd;
+	struct megasas_dcmd_frame	*dcmd;
+	struct megasas_evt_log_info	*el_info;
+	dma_addr_t			el_info_h;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd) {
+		return -ENOMEM;
+	}
+
+	dcmd	= &cmd->frame->dcmd;
+	el_info	= pci_alloc_consistent(instance->pdev,
+				sizeof(struct megasas_evt_log_info),
+							&el_info_h);
+
+	if (!el_info) {
+		megasas_return_cmd(instance, cmd);
+		return -ENOMEM;
+	}
+
+	memset(el_info, 0, sizeof(*el_info));
+	memset(dcmd->mbox, 0, MFI_MBOX_SIZE);
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct
megasas_evt_log_info);
+	dcmd->opcode			= MR_DCMD_CTRL_EVENT_GET_INFO;
+	dcmd->sgl.sge32[0].phys_addr	= el_info_h;
+	dcmd->sgl.sge32[0].length	= sizeof(struct
megasas_evt_log_info);
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	/*
+	 * Copy the data back into callers buffer
+	 */
+	memcpy(eli, el_info, sizeof(struct megasas_evt_log_info));
+
+	pci_free_consistent(instance->pdev, sizeof(struct
megasas_evt_log_info),
+							el_info, el_info_h);
+
+	megasas_return_cmd(instance, cmd);
+
+	return 0;
+}
+
+/**
+ * megasas_register_aen -	Registers for asynchronous event
notification
+ * @instance:			Adapter soft state
+ * @seq_num:			The starting sequence number
+ * @class_locale:		Class of the event
+ *
+ * This function subscribes for AEN for events beyond the @seq_num. It
requests
+ * to be notified if and only if the event is of type @class_locale
+ */
+static int
+megasas_register_aen(struct megasas_instance *instance, u32 seq_num,
+							u32
class_locale_word)
+{
+	int					ret_val;
+	struct megasas_cmd			*cmd;
+	struct megasas_dcmd_frame		*dcmd;
+	u32					*mbox_word;
+	union megasas_evt_class_locale		curr_aen;
+	union megasas_evt_class_locale		prev_aen;
+
+	/*
+	 * If there an AEN pending already (aen_cmd), check if the
+	 * class_locale of that pending AEN is inclusive of the new
+	 * AEN request we currently have. If it is, then we don't have
+	 * to do anything. In other words, whichever events the current
+	 * AEN request is subscribing to, have already been subscribed
+	 * to.
+	 *
+	 * If the old_cmd is _not_ inclusive, then we have to abort
+	 * that command, form a class_locale that is superset of both
+	 * old and current and re-issue to the FW
+	 */
+
+	curr_aen.word = class_locale_word;
+
+	if (instance->aen_cmd) {
+
+		mbox_word	= (u32*)instance->aen_cmd->frame->dcmd.mbox;
+		prev_aen.word	= mbox_word[1];
+
+		if (prev_aen.word == curr_aen.word) {
+			/*
+			 * Required events have already been subscribed for
+			 */
+			return 0;
+		}
+		else{
+			curr_aen.members.locale |= prev_aen.members.locale;
+
+			if(prev_aen.members.class < curr_aen.members.class)
+				curr_aen.members.class =
prev_aen.members.class;
+
+			instance->aen_cmd->abort_aen = 1;
+			ret_val = megasas_issue_blocked_abort_cmd(instance, 
+						instance->aen_cmd);
+
+			if (ret_val) {
+				printk(KERN_DEBUG "megasas: Failed to abort
"
+						"previous AEN command\n");
+				return ret_val;
+			}
+		}
+	}
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd) 
+		return -ENOMEM;
+
+	dcmd		= &cmd->frame->dcmd;
+	mbox_word	= (u32*) dcmd->mbox;
+
+	memset(instance->evt_detail, 0, sizeof(struct megasas_evt_detail));
+
+	/*
+	 * Prepare DCMD for aen registration
+	 */
+	memset(dcmd->mbox, 0, MFI_MBOX_SIZE);
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct megasas_evt_detail);
+	dcmd->opcode			= MR_DCMD_CTRL_EVENT_WAIT;
+	mbox_word[0]			= seq_num;
+	mbox_word[1]			= curr_aen.word;
+	dcmd->sgl.sge32[0].phys_addr	= (u32)(instance->evt_detail_h & 
+								0xFFFF);
+	dcmd->sgl.sge32[0].length	= sizeof(struct megasas_evt_detail);
+
+	/*
+	 * Store reference to the cmd used to register for AEN. When an
+	 * application wants us to register for AEN, we have to abort this
+	 * cmd and re-register with a new EVENT LOCALE supplied by that app
+	 */
+	instance->aen_cmd = cmd;
+
+	/*
+	 * Issue the aen registration frame
+	 */
+	writel(cmd->frame_phys_addr >> 3, 
+		&instance->reg_set->inbound_queue_port);
+
+	return 0;
+}
+
+/**
+ * megasas_start_aen -	Subscribes to AEN during driver load time
+ * @instance:		Adapter soft state
+ */
+static int
+megasas_start_aen(struct megasas_instance *instance)
+{
+	struct megasas_evt_log_info	eli;
+	union megasas_evt_class_locale	class_locale;
+
+	/*
+	 * Get the latest sequence number from FW
+	 */
+	memset( &eli, 0, sizeof(eli) );
+
+	if (megasas_get_seq_num( instance, &eli )) 
+		return -1;
+
+	/*
+	 * Register AEN with FW for latest sequence number plus 1
+	 */
+	class_locale.members.reserved	= 0;
+	class_locale.members.locale	= MR_EVT_LOCALE_ALL;
+	class_locale.members.class	= MR_EVT_CLASS_DEBUG;
+
+	return megasas_register_aen( instance, eli.newest_seq_num + 1,
+						class_locale.word );
+}
+
+/**
+ * megasas_io_attach -	Attaches this driver to SCSI mid-layer
+ * @instance:		Adapter soft state
+ */
+static int
+megasas_io_attach(struct megasas_instance *instance)
+{
+	struct Scsi_Host *host = instance->host;
+
+	/*
+	 * Export parameters required by SCSI mid-layer
+	 */
+	scsi_set_device( host, &instance->pdev->dev );
+
+	host->irq		= instance->pdev->irq;
+	host->unique_id		= instance->unique_id;
+	host->can_queue		= instance->max_fw_cmds - MEGASAS_INT_CMDS;
+	host->this_id		= instance->init_id;
+	host->sg_tablesize	= instance->max_num_sge;
+	host->max_sectors	= instance->max_sectors_per_req;
+	host->cmd_per_lun	= instance->max_fw_cmds - MEGASAS_INT_CMDS;
+	host->max_channel	= MEGASAS_MAX_CHANNELS - 1;
+	host->max_id		= MEGASAS_MAX_DEV_PER_CHANNEL;
+	host->max_lun		= MEGASAS_MAX_LUN;
+
+	/*
+	 * Notify the mid-layer about the new controller
+	 */
+	if (scsi_add_host(host, &instance->pdev->dev)) {
+		printk( KERN_DEBUG "megasas: scsi_add_host failed\n" );
+		return -ENODEV;
+	}
+
+	/*
+	 * Trigger SCSI to scan our drives
+	 */
+	scsi_scan_host(host);
+	return 0;
+}
+
+/**
+ * megasas_probe_one -	PCI hotplug entry point
+ * @pdev:		PCI device structure
+ * @id:			PCI ids of supported hotplugged adapter	
+ */
+static int __devinit
+megasas_probe_one(struct pci_dev *pdev, const struct pci_device_id *id )
+{
+	int				rval;
+	struct Scsi_Host		*host;
+	struct megasas_instance		*instance;
+
+	/*
+	 * Announce PCI information
+	 */
+	printk(KERN_INFO "megasas: %#4.04x:%#4.04x:%#4.04x:%#4.04x: ",
+		pdev->vendor, pdev->device, pdev->subsystem_vendor,
+						pdev->subsystem_device);
+
+	printk(KERN_INFO "megasas: bus %d:slot %d:func %d\n",
+		pdev->bus->number,
PCI_SLOT(pdev->devfn),PCI_FUNC(pdev->devfn));
+
+	/*
+	 * PCI prepping: enable device set bus mastering and dma mask
+	 */
+	rval = pci_enable_device(pdev);
+
+	if (rval) {
+		return rval;
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * All our contollers are capable of performing 64-bit DMA
+	 */
+	if (IS_DMA64) {
+		if (pci_set_dma_mask( pdev, DMA_64BIT_MASK) != 0) {
+
+			if (pci_set_dma_mask( pdev, DMA_32BIT_MASK ) != 0) 
+				goto fail_set_dma_mask;
+		}
+	}
+	else {
+		if (pci_set_dma_mask( pdev, DMA_32BIT_MASK ) != 0) 
+			goto fail_set_dma_mask;
+	}
+
+	host = scsi_host_alloc(&megasas_template, 
+				sizeof(struct megasas_instance));
+
+	if (!host) {
+		printk(KERN_DEBUG "megasas: scsi_host_alloc failed\n");
+		goto fail_alloc_instance;
+	}
+
+	instance = (struct megasas_instance*)host->hostdata;
+	memset(instance, 0, sizeof(*instance));
+
+	instance->producer = pci_alloc_consistent(pdev, sizeof(u32),
+
&instance->producer_h);
+	instance->consumer = pci_alloc_consistent(pdev, sizeof(u32),
+
&instance->consumer_h);
+
+	if (!instance->producer || !instance->consumer) {
+		printk( KERN_DEBUG "megasas: Failed to allocate memory for "
+						"producer, consumer\n" );
+		goto fail_alloc_dma_buf;
+	}
+
+	*instance->producer = 0;
+	*instance->consumer = 0;
+
+	instance->evt_detail = pci_alloc_consistent(pdev,
+				sizeof(struct megasas_evt_detail),
+				&instance->evt_detail_h);
+
+	if (!instance->evt_detail) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory for "
+						"event detail structure\n");
+		goto fail_alloc_dma_buf;
+	}
+
+	/*
+	 * Initialize locks and queues
+	 */
+	INIT_LIST_HEAD(&instance->cmd_pool);
+
+	init_waitqueue_head(&instance->int_cmd_wait_q);
+	init_waitqueue_head(&instance->abort_cmd_wait_q);
+
+	spin_lock_init(&instance->aen_lock);
+	spin_lock_init(&instance->cmd_pool_lock);
+	spin_lock_init(&instance->instance_lock);
+
+	/*
+	 * Initialize PCI related and misc parameters
+	 */
+	instance->pdev		= pdev;
+	instance->host		= host;	
+	instance->unique_id	= pdev->bus->number << 8 | pdev->devfn;
+	instance->init_id	= MEGASAS_DEFAULT_INIT_ID;
+
+	/*
+	 * Initialize MFI Firmware
+	 */
+	if (megasas_init_mfi(instance))
+		goto fail_init_mfi;
+
+	/*
+	 * Register IRQ
+	 */
+	if (request_irq(pdev->irq, megasas_isr, SA_SHIRQ, "megasas",
+							instance)) {
+		printk(KERN_DEBUG "megasas: Failed to register IRQ\n");
+		goto fail_irq;
+	}
+
+	megasas_enable_intr(instance->reg_set);
+
+	/*
+	 * Store instance in PCI softstate
+	 */
+	pci_set_drvdata(pdev, instance);
+
+	/*
+	 * Add this controller to megasas_mgmt_info structure so that it
+	 * can be exported to management applications
+	 */
+	megasas_mgmt_info.count++;
+	megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = instance;
+	megasas_mgmt_info.max_index++;
+
+	/*
+	 * Initiate AEN (Asynchronous Event Notification)
+	 */
+	megasas_start_aen(instance);
+
+	/*
+	 * Register with SCSI mid-layer
+	 */
+	if (megasas_io_attach(instance))
+		goto fail_io_attach;
+
+	return 0;
+
+fail_io_attach:
+	megasas_mgmt_info.count--;
+	megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = NULL;
+	megasas_mgmt_info.max_index--;
+
+	pci_set_drvdata(pdev, NULL);
+	megasas_disable_intr(instance->reg_set);
+	free_irq(instance->pdev->irq, instance);
+
+	megasas_release_mfi(instance);
+
+fail_irq:
+fail_init_mfi:
+fail_alloc_dma_buf:
+	if (instance->evt_detail)
+		pci_free_consistent(pdev, sizeof(struct megasas_evt_detail),
+				instance->evt_detail,
instance->evt_detail_h);
+
+	if (instance->producer)
+		pci_free_consistent(pdev, sizeof(u32), instance->producer,
+
instance->producer_h);
+	if (instance->consumer)
+		pci_free_consistent(pdev, sizeof(u32), instance->consumer,
+
instance->consumer_h);
+	scsi_host_put(host);
+
+fail_alloc_instance:
+fail_set_dma_mask:
+	pci_disable_device(pdev);
+
+	return -ENODEV;
+}
+
+/**
+ * megasas_flush_cache -	Requests FW to flush all its caches
+ * @instance:			Adapter soft state
+ */
+static void
+megasas_flush_cache(struct megasas_instance *instance)
+{
+	struct megasas_cmd		*cmd;
+	struct megasas_dcmd_frame	*dcmd;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd)
+		return;
+
+	dcmd = &cmd->frame->dcmd;
+
+	memset(dcmd->mbox, 0, MFI_MBOX_SIZE);
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 0;
+	dcmd->flags			= MFI_FRAME_DIR_NONE;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= 0;
+	dcmd->opcode			= MR_DCMD_CTRL_CACHE_FLUSH;
+	dcmd->mbox[0]			= MR_FLUSH_CTRL_CACHE |
+						MR_FLUSH_DISK_CACHE;
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	megasas_return_cmd(instance, cmd);
+
+	return;
+}
+
+/**
+ * megasas_shutdown_controller -	Instructs FW to shutdown the
controller
+ * @instance:				Adapter soft state
+ */
+static void
+megasas_shutdown_controller(struct megasas_instance *instance)
+{
+	struct megasas_cmd		*cmd;
+	struct megasas_dcmd_frame	*dcmd;
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd);
+		return;
+
+	if (instance->aen_cmd)
+		megasas_issue_blocked_abort_cmd(instance,
instance->aen_cmd);
+
+	dcmd = &cmd->frame->dcmd;
+
+	memset( dcmd->mbox, 0, MFI_MBOX_SIZE );
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 0;
+	dcmd->flags			= MFI_FRAME_DIR_NONE;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= 0;
+	dcmd->opcode			= MR_DCMD_CTRL_SHUTDOWN;
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	megasas_return_cmd(instance, cmd);
+
+	return;
+}
+
+/**
+ * megasas_detach_one -	PCI hot"un"plug entry point
+ * @pdev:		PCI device structure
+ */
+static void
+megasas_detach_one(struct pci_dev *pdev)
+{
+	int				i;
+	struct Scsi_Host		*host;
+	struct megasas_instance		*instance;
+
+	instance 	= pci_get_drvdata(pdev);
+	host		= instance->host;
+
+	scsi_remove_host(instance->host);
+	megasas_flush_cache(instance);
+	megasas_shutdown_controller(instance);
+
+	/*
+	 * Take the instance off the instance array. Note that we will not
+	 * decrement the max_index. We let this array be sparse array
+	 */
+	for (i = 0; i < megasas_mgmt_info.max_index; i++) {
+		if (megasas_mgmt_info.instance[i] == instance) {
+			megasas_mgmt_info.count--;
+			megasas_mgmt_info.instance[i] = NULL;
+
+			break;
+		}
+	}
+
+	pci_set_drvdata(instance->pdev, NULL);
+
+	megasas_disable_intr(instance->reg_set);
+
+	free_irq(instance->pdev->irq, instance);
+
+	megasas_release_mfi(instance);
+
+	pci_free_consistent(pdev, sizeof(struct megasas_evt_detail),
+			instance->evt_detail, instance->evt_detail_h);
+
+	pci_free_consistent(pdev, sizeof(u32), instance->producer,
+						instance->producer_h);
+
+	pci_free_consistent(pdev, sizeof(u32), instance->consumer,
+						instance->consumer_h);
+
+	scsi_host_put(host);
+
+	pci_set_drvdata(pdev, NULL);
+
+	pci_disable_device(pdev);
+
+	return;
+}
+
+/**
+ * megasas_shutdown -	Shutdown entry point
+ * @device:		Generic device structure
+ */
+static void
+megasas_shutdown(struct device *device)
+{
+	struct megasas_instance	*instance = (struct megasas_instance*)
+						dev_get_drvdata(device);
+	megasas_flush_cache(instance);
+}
+
+/**
+ * megasas_mgmt_open -	char node "open" entry point
+ */
+static int
+megasas_mgmt_open(struct inode *inode, struct file *filep)
+{
+	/*
+	 * Allow only those users with admin rights
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return 0;
+}
+
+/**
+ * megasas_mgmt_release - char node "release" entry point
+ */
+static int
+megasas_mgmt_release(struct inode *inode, struct file *filep)
+{
+	return 0;
+}
+
+/**
+ * megasas_mgmt_fasync -	Async notifier registration from
applications
+ *
+ * This function adds the calling process to a driver global queue. When an
+ * event occurs, SIGIO will be sent to all processes in this queue.
+ */
+static int
+megasas_mgmt_fasync(int fd, struct file *filep, int mode)
+{
+	int rc;
+
+	down( &megasas_async_queue_mutex );
+
+	rc = fasync_helper(fd, filep, mode, &megasas_async_queue);
+
+	up(&megasas_async_queue_mutex);
+
+	if (rc >0)
+		return 0;
+
+	printk(KERN_DEBUG "megasas: fasync_helper failed [%d]\n", rc);
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_dcmd -	Issues DCMD to the FW
+ * @instance:			Adapter soft state
+ * @uioc:			User's ioctl packet copied into kernel addr
+ * @argp:			User's ioctl packet in user address
+ * @cmd:			Command to be prepared and issued
+ *
+ * This function prepares direct command (DCMD) to FW from user's ioctl
packet.
+ * The driver allocates temporary buffer (if needed) for data transfer
+ *
+ * Note: The suffixes 'k' & 'u' mean 'kerne' and 'user' respectively
+ */
+static int
+megasas_mgmt_fw_dcmd(struct megasas_instance *instance, struct iocpacket
*uioc,
+				void __user *argp, struct megasas_cmd *cmd)
+{
+	int					rc = 0;
+	void __user				*ubuff;
+	struct megasas_dcmd_frame		*kdcmd;
+	struct megasas_dcmd_frame __user	*udcmd;
+	struct megasas_dcmd_frame		*cmd_dcmd;
+	caddr_t					kbuff;
+	dma_addr_t				kbuff_h;
+	u32					xferlen;
+	u8					user_64bit_sgl = 0;
+
+	cmd_dcmd	= &cmd->frame->dcmd;
+	kdcmd 		= (struct megasas_dcmd_frame*) &uioc->frame;
+	udcmd		= (struct megasas_dcmd_frame*)
+				(((struct iocpacket*)argp)->frame);
+
+	if (kdcmd->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+		xferlen	= kdcmd->sgl.sge32[0].length;
+		ubuff	= (void __user*) (ulong)
udcmd->sgl.sge32[0].phys_addr;
+	}
+	else {
+		xferlen	= kdcmd->sgl.sge64[0].length;
+		ubuff	= (void __user*) (ulong)
udcmd->sgl.sge64[0].phys_addr;
+	}
+
+	/*
+	 * Allocate internal buffer for data transfer
+	 */
+	if (xferlen)
+		kbuff = pci_alloc_consistent(instance->pdev, xferlen,
&kbuff_h);
+	else
+		kbuff = NULL;
+
+	if (xferlen && !kbuff) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory for "
+						"DCMD internal buffer \n");
+		return -ENOMEM;
+	}
+
+	if (xferlen && (kdcmd->flags & MFI_FRAME_DIR_WRITE)) {
+
+		if (copy_from_user(kbuff, ubuff, xferlen)) {
+			printk( KERN_DEBUG "megasas: Failed to copy from "
+							"application
buffer\n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+
+	/*
+	 * Copy the frame sent by user into driver's frame
+	 */
+	cmd_dcmd->cmd				= kdcmd->cmd;
+	cmd_dcmd->cmd_status			= kdcmd->cmd_status;
+	cmd_dcmd->sge_count			= kdcmd->sge_count;
+	cmd_dcmd->timeout			= kdcmd->timeout;
+	cmd_dcmd->data_xfer_len			= kdcmd->data_xfer_len;
+	cmd_dcmd->opcode			= kdcmd->opcode;
+
+	memcpy( cmd_dcmd->mbox, kdcmd->mbox, MFI_MBOX_SIZE );
+
+	if (!user_64bit_sgl) {
+		cmd_dcmd->flags			= kdcmd->flags;
+		cmd_dcmd->sgl.sge32[0].length	=
kdcmd->sgl.sge32[0].length;
+		cmd_dcmd->sgl.sge32[0].phys_addr= kbuff_h;
+	}
+	else {
+		cmd_dcmd->flags			= kdcmd->flags
|MFI_FRAME_SGL64;
+		cmd_dcmd->sgl.sge64[0].length	=
kdcmd->sgl.sge64[0].length;
+		cmd_dcmd->sgl.sge64[0].phys_addr= kbuff_h;
+	}
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+		if (copy_to_user(ubuff, kbuff, xferlen)) {
+
+			printk( KERN_DEBUG "megasas: Failed to copy "
+					"to application buffer\n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+
+	if (copy_to_user(&udcmd->cmd_status, &cmd_dcmd->cmd_status,
+						sizeof(u8))) {
+		printk(KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer\n");
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+exit_label:
+	pci_free_consistent(instance->pdev, xferlen, kbuff, kbuff_h);
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_dcdb -	Prepares and issues DCDB
+ * @instance:			Adapter soft state
+ * @uioc:			User's ioctl packet copied into kernel addr
+ * @argp:			User's ioctl packet in user addr
+ * @cmd:			Free command from the command pool
+ *
+ * Note that the suffixes 'k' and 'u' mean 'kernel' and 'user'
respectively.
+ */
+static int
+megasas_mgmt_fw_dcdb(struct megasas_instance *instance, struct iocpacket
*uioc,
+				void __user *argp, struct megasas_cmd *cmd)
+{
+	int					rc = 0;
+	void __user				*ubuff;
+	void __user				*usense;
+	struct megasas_pthru_frame		*kdcdb;
+	struct megasas_pthru_frame __user	*udcdb;
+	struct megasas_pthru_frame		*cmd_dcdb;
+	caddr_t					kbuff;
+	dma_addr_t				kbuff_h;
+	caddr_t					ksense;
+	dma_addr_t				ksense_h;
+	u32					xferlen;
+	u8					user_64bit_sgl = 0;
+	u64					temp;
+
+	ksense		= NULL;
+	usense		= NULL;
+	cmd_dcdb	= &cmd->frame->pthru;
+	kdcdb 		= (struct megasas_pthru_frame*) &uioc->frame;
+	udcdb		= (struct megasas_pthru_frame*)
+				(((struct iocpacket*)argp)->frame);
+
+	if (kdcdb->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+		xferlen	= kdcdb->sgl.sge32[0].length;
+		ubuff	= (void __user*)(ulong)
(udcdb->sgl.sge32[0].phys_addr);
+	}
+	else {
+		xferlen	= kdcdb->sgl.sge64[0].length;
+		ubuff	= (void __user*) (ulong)
udcdb->sgl.sge64[0].phys_addr;
+	}
+
+	/*
+	 * Allocate internal buffer for data transfer
+	 */
+	if (xferlen)
+		kbuff = pci_alloc_consistent(instance->pdev, xferlen,
&kbuff_h);
+	else
+		kbuff = NULL;
+
+	if (xferlen && !kbuff) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+						"for DCDB internal
buffer\n");
+		return -ENOMEM;
+	}
+
+	memset(kbuff, 0, xferlen);
+
+	/*
+	 * Allocate internal buffer for request sense
+	 */
+	if (kdcdb->sense_len) {
+		ksense = pci_alloc_consistent(instance->pdev,
kdcdb->sense_len,
+								&ksense_h);
+		if (!ksense) {
+			rc = -ENOMEM;
+			goto exit_label;
+		}
+
+		temp = kdcdb->sense_buf_phys_addr_hi; 
+		temp = temp << 32 | kdcdb->sense_buf_phys_addr_lo;
+
+		usense = (void __user*)(ulong) temp;
+
+	}
+
+	if (xferlen && (kdcdb->flags & MFI_FRAME_DIR_WRITE)) {
+
+		if (copy_from_user(kbuff, ubuff, xferlen)) {
+			printk(KERN_DEBUG "megasas: Failed to copy from "
+						"application buffer \n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+
+	memcpy(cmd_dcdb, kdcdb, MEGAMFI_FRAME_SIZE);
+	cmd_dcdb->context = cmd->index;
+	cmd_dcdb->sge_count = 1;
+
+	if (!user_64bit_sgl) {
+		cmd_dcdb->flags			= kdcdb->flags;
+		cmd_dcdb->sgl.sge32[0].length	=
kdcdb->sgl.sge32[0].length;
+		cmd_dcdb->sgl.sge32[0].phys_addr= kbuff_h;
+	}
+	else {
+		cmd_dcdb->flags			= kdcdb->flags
|MFI_FRAME_SGL64;
+		cmd_dcdb->sgl.sge64[0].length	=
kdcdb->sgl.sge64[0].length;
+		cmd_dcdb->sgl.sge64[0].phys_addr= kbuff_h;
+	}
+
+	cmd_dcdb->sense_buf_phys_addr_hi = 0;
+	cmd_dcdb->sense_buf_phys_addr_lo = ksense_h ;
+
+	cmd->sync_cmd = 1;
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	if (xferlen && (kdcdb->flags & MFI_FRAME_DIR_READ)) {
+
+		if (copy_to_user( ubuff, kbuff, xferlen)) {
+
+			printk(KERN_DEBUG "megasas: Failed to copy "
+					"to application buffer \n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+
+	if (copy_to_user(&udcdb->cmd_status, &cmd_dcdb->cmd_status,
+						sizeof(u8))) {
+		printk(KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer\n" );
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	if (kdcdb->sense_len) {
+		if (copy_to_user(usense, ksense, kdcdb->sense_len)) {
+			printk(KERN_DEBUG "megasas: Failed to copy "
+					"to application buffer \n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+
+exit_label:
+	if (ksense)
+		pci_free_consistent(instance->pdev, kdcdb->sense_len,
ksense,
+								ksense_h);
+	if (kbuff)
+		pci_free_consistent(instance->pdev, xferlen, kbuff,
kbuff_h);
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_smp -	Issues passthrough cmds to SAS devices
+ * @instance:			Adapter soft state
+ * @uioc:			User's ioctl packet in kernel address
+ * @argp:			User's ioctl packet in user address
+ * @cmd:			Command from free pool
+ *
+ * SMP frames have two SG elements at the end - response and request ( in
that
+ * order). This function allocates temporary DMA buffers for these SG
elements.
+ *
+ * Note that the suffixes 'k' and 'u' mean 'kernel' and 'user'
respectively.
+ */
+static int
+megasas_mgmt_fw_smp(struct megasas_instance *instance, struct iocpacket
*uioc,
+				void __user *argp, struct megasas_cmd *cmd)
+{
+	int					rc = 0;
+	struct megasas_smp_frame		*ksmp;
+	struct megasas_smp_frame __user		*usmp;
+	struct megasas_smp_frame		*cmd_smp;
+
+	caddr_t					kreq;
+	caddr_t					kresp;
+	dma_addr_t				kreq_h;
+	dma_addr_t				kresp_h;
+	void __user				*ureq;
+	void __user				*uresp;
+	u32					req_len;
+	u32					resp_len;
+
+	u8					user_64bit_sgl = 0;
+
+	cmd_smp		= &cmd->frame->smp;
+	ksmp 		= (struct megasas_smp_frame*) &uioc->frame;
+	usmp		= (struct megasas_smp_frame*)
+				(((struct iocpacket*)argp)->frame);
+
+	if (ksmp->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+		resp_len	= ksmp->sgl.sge32[0].length;
+		req_len		= ksmp->sgl.sge32[1].length;
+
+		uresp	= (void __user*) ((ulong)
usmp->sgl.sge32[0].phys_addr);
+		ureq	= (void __user*) ((ulong)
usmp->sgl.sge32[1].phys_addr);
+	}
+	else {
+		resp_len	= ksmp->sgl.sge64[0].length;
+		req_len		= ksmp->sgl.sge64[1].length;
+
+		uresp	= (void __user*) ((ulong)
usmp->sgl.sge64[0].phys_addr);
+		ureq	= (void __user*) ((ulong)
usmp->sgl.sge64[1].phys_addr);
+	}
+
+	if (!req_len || !resp_len) {
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate kernel buffers for SMP request and response
+	 */
+	kreq	= NULL;
+	kresp	= NULL;
+
+	kreq = pci_alloc_consistent(instance->pdev, req_len, &kreq_h);
+
+	if (!kreq) {
+
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+							"for SMP request
\n");
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	kresp = pci_alloc_consistent(instance->pdev, resp_len, &kresp_h);
+
+	if(!kresp) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+							"for SMP response
\n");
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	if (copy_from_user(kreq, ureq, req_len)) {
+		printk(KERN_DEBUG "megasas: Failed to copy from "
+					"application buffer \n");
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	memcpy (cmd_smp, ksmp, MEGAMFI_FRAME_SIZE);
+	cmd_smp->context = cmd->index;
+
+	if (!user_64bit_sgl) {
+		cmd_smp->flags				= ksmp->flags;
+		cmd_smp->sgl.sge32[0].length		= resp_len;
+		cmd_smp->sgl.sge32[0].phys_addr		= kresp_h;
+		cmd_smp->sgl.sge32[1].length		= req_len;
+		cmd_smp->sgl.sge32[1].phys_addr		= kreq_h;
+	}
+	else {
+		cmd_smp->flags				= ksmp->flags |
+							MFI_FRAME_SGL64;
+		cmd_smp->sgl.sge64[0].length		= resp_len;
+		cmd_smp->sgl.sge64[0].phys_addr		= kresp_h;
+		cmd_smp->sgl.sge64[1].length		= req_len;
+		cmd_smp->sgl.sge64[1].phys_addr		= kreq_h;
+	}
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	if (copy_to_user(uresp, kresp, resp_len)) {
+		printk(KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer \n");
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	if (copy_to_user(&usmp->cmd_status, &cmd_smp->cmd_status,
+						sizeof(u8))) {
+		printk(KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer \n");
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+exit_label:
+
+	if (kreq)
+		pci_free_consistent(instance->pdev, req_len, kreq, kreq_h);
+	if (kresp)
+		pci_free_consistent(instance->pdev, resp_len, kresp,
kresp_h);
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_stp -	Issues passthrough cmds to SATA drives
+ * @instance:			Adapter soft state
+ * @uioc:			User ioctl packet in kernel address
+ * @argp:			User ioctl packet in user address
+ * @cmd:			Command from free pool
+ *
+ * Note that the suffixes 'k' and 'u' mean 'kernel' and 'user'
respectively.
+ */
+static int
+megasas_mgmt_fw_stp(struct megasas_instance *instance, struct iocpacket
*uioc,
+				void __user *argp, struct megasas_cmd *cmd)
+{
+	int					rc = 0;
+	struct megasas_stp_frame		*kstp;
+	struct megasas_stp_frame __user		*ustp;
+	struct megasas_stp_frame		*cmd_stp;
+
+	caddr_t					kdata;
+	caddr_t					kresp;
+	dma_addr_t				kdata_h;
+	dma_addr_t				kresp_h;
+	void __user				*udata;
+	void __user				*uresp;
+	u32					data_len;
+	u32					resp_len;
+
+	u8					user_64bit_sgl = 0;
+
+	cmd_stp		= &cmd->frame->stp;
+	kstp 		= (struct megasas_stp_frame *) &uioc->frame;
+	ustp		= (struct megasas_stp_frame *)
+				(((struct iocpacket *)argp)->frame);
+
+	if (kstp->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+
+		resp_len	= ustp->sgl.sge32[0].length;
+		data_len	= ustp->sgl.sge32[1].length;
+
+		uresp	= (void __user*) ((ulong)
ustp->sgl.sge32[0].phys_addr);
+		udata	= (void __user*) ((ulong)
ustp->sgl.sge32[1].phys_addr);
+	}
+	else {
+		resp_len	= ustp->sgl.sge64[0].length;
+		data_len	= ustp->sgl.sge64[1].length;
+
+		uresp	= (void __user*) ((ulong)
ustp->sgl.sge64[0].phys_addr);
+		udata	= (void __user*) ((ulong)
ustp->sgl.sge64[1].phys_addr);
+	}
+
+	if (!data_len || !resp_len) {
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate kernel buffers for SMP request and response
+	 */
+
+	kdata	= NULL;
+	kresp	= NULL;
+
+	kdata = pci_alloc_consistent(instance->pdev, data_len, &kdata_h);
+
+	if(!kdata) {
+
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+							"for STP request
\n");
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	kresp = pci_alloc_consistent(instance->pdev, resp_len, &kresp_h);
+
+	if(!kresp) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+							"for STP response
\n");
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	memcpy (cmd_stp, kstp, MEGAMFI_FRAME_SIZE);
+	cmd_stp->context = cmd->index;
+
+	if (!user_64bit_sgl) {
+		cmd_stp->flags				= kstp->flags;
+		cmd_stp->sgl.sge32[0].length		= resp_len;
+		cmd_stp->sgl.sge32[0].phys_addr		= kresp_h;
+		cmd_stp->sgl.sge32[1].length		= data_len;
+		cmd_stp->sgl.sge32[1].phys_addr		= kdata_h;
+	}
+	else {
+		cmd_stp->flags				= kstp->flags |
+							MFI_FRAME_SGL64;
+		cmd_stp->sgl.sge64[0].length		= resp_len;
+		cmd_stp->sgl.sge64[0].phys_addr		= kresp_h;
+		cmd_stp->sgl.sge64[1].length		= data_len;
+		cmd_stp->sgl.sge64[1].phys_addr		= kdata_h;
+	}
+
+	megasas_issue_blocked_cmd(instance, cmd);
+
+	if (copy_to_user(uresp, kresp, resp_len)) {
+		printk( KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer \n" );
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	if (copy_to_user(udata, kdata, data_len)) {
+		printk( KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer \n" );
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	if (copy_to_user(&ustp->cmd_status, &cmd_stp->cmd_status,
+						sizeof(u8))) {
+		printk( KERN_DEBUG "megasas: Failed to copy to "
+					"application buffer \n" );
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+exit_label:
+
+	if (kdata)
+		pci_free_consistent(instance->pdev, data_len, kdata,
kdata_h);
+	if (kresp)
+		pci_free_consistent(instance->pdev, resp_len, kresp,
kresp_h);
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_ioctl -	Issues management ioctls to FW
+ * @instance:			Adapter soft state
+ * @argp:			User's ioctl packet
+ */
+static int
+megasas_mgmt_fw_ioctl(struct megasas_instance *instance, void __user *argp)
+{
+	int				ret;
+	struct iocpacket		*uioc;
+	struct megasas_header		*hdr;
+	struct megasas_cmd		*cmd;
+
+	uioc = kmalloc(sizeof(struct iocpacket), GFP_KERNEL);
+
+	if (!uioc) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+					"for application IOCTL packet\n");
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(uioc, argp, sizeof(struct iocpacket))) {
+		printk( KERN_DEBUG "megasas: Failed to copy from "
+						"application buffer \n" );
+		return -EFAULT;
+	}
+
+	cmd = megasas_get_cmd(instance);
+
+	if (!cmd) {
+		printk(KERN_DEBUG "megasas: Failed to get a cmd packet\n");
+		return -ENOMEM;
+	}
+
+	hdr = (struct megasas_header*) uioc->frame;
+
+	switch( hdr->cmd ) {
+
+		case MFI_CMD_DCMD:
+			ret = megasas_mgmt_fw_dcmd(instance, uioc, argp,
cmd);
+			break;
+
+		case MFI_CMD_PD_SCSI_IO:
+		case MFI_CMD_LD_SCSI_IO:
+			ret = megasas_mgmt_fw_dcdb(instance, uioc, argp,
cmd);
+			break;
+
+		case MFI_CMD_SMP:
+			ret = megasas_mgmt_fw_smp(instance, uioc, argp,
cmd);
+			break;
+
+		case MFI_CMD_STP:
+			ret = megasas_mgmt_fw_stp(instance, uioc, argp,
cmd);
+			break;
+
+		default:
+			ret = -EINVAL;
+			break;
+	}
+
+	megasas_return_cmd( instance, cmd );
+	return ret;
+}
+
+/**
+ * megasas_fill_drv_ver -	Fills the driver version info for
application
+ * @dv:				Driver version information
+ */
+static void
+megasas_fill_drv_ver(struct megasas_drv_ver *dv)
+{
+	memset( dv, 0, sizeof(*dv) );
+
+	memcpy(dv->signature,	"$LSI LOGIC$",	strlen("$LSI LOGIC$")	);
+	memcpy(dv->os_name,	"Linux",	strlen("Linux")		);
+	memcpy(dv->os_ver,	"Ver Indpndt",	strlen("ver indpndt")	);
+	memcpy(dv->drv_name,	"megaraid_sas",	strlen("megaraid_sas")	);
+	memcpy(dv->drv_ver,	MEGASAS_VERSION,strlen(MEGASAS_VERSION)	);
+	memcpy(dv->drv_rel_date,MEGASAS_RELDATE,strlen(MEGASAS_RELDATE)	);
+}
+
+/**
+ * megasas_mgmt_ioctl -	char node ioctl entry point
+ *
+ * Few ioctl commands should be handled by driver itself (driver ioctls)
and
+ * the rest should be converted into appropriate commands for FW and
issued.
+ */
+static int
+megasas_mgmt_ioctl(struct inode *inode, struct file* filep,
+			unsigned int cmd, unsigned long arg )
+{
+	int					i;
+	int					j;
+	int					rc;
+	u8					fw_status;
+	struct iocpacket			*uioc;
+	void __user				*argp;
+	void __user				*udata_addr;
+	u8					user_64bit_sgl = 0;
+	u32					opcode;
+
+	u32					seq_num;
+	u32					class_locale_word;
+	u32					*mbox_word;
+
+	struct megasas_instance			*instance;
+	struct megasas_dcmd_frame		*kdcmd;
+	struct megasas_dcmd_frame __user	*udcmd;
+	struct megasas_drv_ver			*dv;
+	struct pci_dev				*pdev;
+
+	argp	= (void __user*) arg;
+	uioc	= kmalloc(sizeof(struct iocpacket), GFP_KERNEL);
+
+	if (!uioc) {
+		printk(KERN_DEBUG "megasas: Failed to allocate memory "
+					"for application IOCTL packet\n");
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(uioc, argp, sizeof(struct iocpacket))) {
+		printk( KERN_DEBUG "megasas: Failed to copy from "
+						"application buffer \n" );
+		return -EINVAL;
+	}
+
+	if (strncmp(uioc->signature, IOC_SIGNATURE, strlen(IOC_SIGNATURE))
!=0){
+		printk( KERN_DEBUG "megasas: Invalid ioctl signature\n" );
+		return -EINVAL;
+	}
+
+	if (uioc->version != 0) {
+		printk( KERN_DEBUG "megasas: Invalid ioctl version %d\n",
+
uioc->version );
+		return -EINVAL;
+	}
+
+	instance	= NULL;
+	kdcmd		= (struct megasas_dcmd_frame*) uioc->frame;
+	udcmd		= (struct megasas_dcmd_frame*)
+				(((struct iocpacket*)argp)->frame);
+
+	/*
+	 * Find out if user has used 32 or 64 bit SGL
+	 */
+	if (kdcmd->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl)
+		udata_addr = (void __user*) 
+
((ulong)kdcmd->sgl.sge32[0].phys_addr);
+	else
+		udata_addr = (void __user*) 
+					((ulong)
kdcmd->sgl.sge64[0].phys_addr);
+
+	i = ((uioc->controller_id & 0xF0) >> 4) - 1;
+
+	if (i < megasas_mgmt_info.max_index)
+		instance = megasas_mgmt_info.instance[i];
+	else
+		instance = NULL;
+
+	if ((uioc->control_code == MR_DRIVER_IOCTL_LINUX) ||
+		(uioc->control_code == MR_DRIVER_IOCTL_COMMON)) {
+		/*
+		 * If MR_DRIVER_IOCTL_LINUX or MR_DRIVER_IOCTL_COMMON
+		 * look at dcmd->opcode for the actual operation
+		 */
+		opcode = kdcmd->opcode;
+	}
+	else {
+		/* FW Command */
+		opcode = uioc->control_code;
+	}
+
+	switch (opcode) {
+
+	case MR_DRIVER_IOCTL_DRIVER_VERSION:
+
+		dv = kmalloc(sizeof(struct megasas_drv_ver), GFP_KERNEL);
+
+		if (!dv) {
+			printk(KERN_DEBUG "megasas: Failed to allocate "
+						"memory for driver
version\n");
+			return -ENOMEM;
+		}
+
+		megasas_fill_drv_ver(dv);
+
+		if (copy_to_user(udata_addr, dv, 
+					sizeof(struct megasas_drv_ver))) {
+			printk( KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+			return -EFAULT;
+		}
+
+		rc		= 0;
+		fw_status	= MFI_STAT_OK;
+
+		if (copy_to_user( &udcmd->cmd_status, &fw_status,
+						sizeof(u8))) {
+			rc = -EFAULT;
+			printk( KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_ADAPTER_COUNT:
+
+		if (copy_to_user(udata_addr, &megasas_mgmt_info.count,
+							sizeof(u16))) {
+			return -EFAULT;
+			printk( KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+		}
+
+		rc		= 0;
+		fw_status	= MFI_STAT_OK;
+
+		if (copy_to_user(&udcmd->cmd_status, &fw_status,
+						sizeof(u8))) {
+			rc = -EFAULT;
+			printk( KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_ADAPTER_MAP:
+		/*
+		 * The applications _don't_ address our controllers using
zero
+		 * based index. We give them an array of 16-bit unique
handles.
+		 * These unique handles are simple encryptions of the
indices
+		 *
+		 * Encrypting logic - which converts a controller index into
a
+		 * 16-bit value - is simply (index + 1) << 4 | 0x0F.
+		 *
+		 * Note also when controllers are hot plugged, our
controller
+		 * array (megasas_mgmt_info) becomes sparse. We don't reuse
the
+		 * vacated slots.
+		 */
+		memset(megasas_mgmt_info.map, 0,
+			sizeof(u16) * MAX_MGMT_ADAPTERS);
+
+		j = 0;
+		for (i = 0; i < megasas_mgmt_info.max_index; i++) {
+			if (megasas_mgmt_info.instance[i]) {
+				megasas_mgmt_info.map[j].unique_hndl =
+					((i + 1) << 4) | 0xF;
+				
+				pdev = megasas_mgmt_info.instance[i]->pdev;
+
+				megasas_mgmt_info.map[j].bus_devfn =
+					((pdev->bus->number)	<< 16 |
+				 	(PCI_SLOT(pdev->devfn))	<< 8 |
+				 	(PCI_FUNC(pdev->devfn))) & 0xFFFFFF;
+
+				j++;
+			}
+		}
+
+		if ((j) && (copy_to_user(udata_addr, megasas_mgmt_info.map,
+				sizeof(struct megasas_adp_map) * j))) {
+
+			printk(KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+			return -EFAULT;
+		}
+
+		fw_status	= MFI_STAT_OK;
+		rc		= 0;
+
+		if (copy_to_user( &udcmd->cmd_status, &fw_status,
+						sizeof(u8))) {
+			rc = -EFAULT;
+			printk(KERN_DEBUG "megasas: Failed to copy to "
+						"application buffer \n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_AEN:
+
+		if (!instance) {
+			printk( KERN_DEBUG "megasas: Invalid instance \n" );
+			return -ENODEV;
+		}
+
+
+		spin_lock(&instance->aen_lock);
+
+		mbox_word		= (u32*) kdcmd->mbox;
+		seq_num			= mbox_word[0];
+		class_locale_word	= mbox_word[1];
+
+		rc = megasas_register_aen(instance, seq_num,
class_locale_word);
+
+		spin_unlock(&instance->aen_lock);
+
+		break;
+
+	case IOC_CMD_FIRMWARE:
+
+		if (!instance) {
+			printk(KERN_DEBUG "megasas: Invalid instance \n");
+			return -ENODEV;
+		}
+
+		rc = megasas_mgmt_fw_ioctl(instance, argp);
+
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return rc;
+}
+
+#ifdef CONFIG_COMPAT
+/**
+ * megasas_compat_ioctl -	Handles conversions from 32-bit apps
+ */
+static int
+megasas_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long
arg)
+{
+	return megasas_mgmt_ioctl(NULL, filep, cmd, arg);
+}
+#endif
+
+/*
+ * File operations structure for management interface
+ */
+static struct file_operations megasas_mgmt_fops = {
+	.owner		= THIS_MODULE,
+	.open		= megasas_mgmt_open,
+	.release	= megasas_mgmt_release,
+	.fasync		= megasas_mgmt_fasync,
+	.ioctl		= megasas_mgmt_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= megasas_compat_ioctl,
+#endif
+};
+
+/*
+ * PCI hotplug support registration structure
+ */
+static struct pci_driver megasas_pci_driver = {
+
+	.name		= "megaraid_sas",
+	.id_table	= megasas_pci_table,
+	.probe		= megasas_probe_one,
+	.remove		= __devexit_p(megasas_detach_one),
+	.driver		= {
+				.shutdown = megasas_shutdown,
+			  }
+};
+
+/**
+ * megasas_init - Driver load entry point
+ */
+static int __init
+megasas_init(void)
+{
+	int rval;
+
+	/*
+	 * Announce driver version and other information
+	 */
+	printk( KERN_INFO "megasas: %s %s\n", MEGASAS_VERSION,
+					MEGASAS_EXT_VERSION);
+
+	/*
+	 * Register character device node
+	 */
+	rval =  register_chrdev(0, "megaraid_sas_ioctl",
&megasas_mgmt_fops);
+
+	if (rval < 0) {
+		printk(KERN_DEBUG "megasas: failed to open device node\n");
+		return rval;
+	}
+
+	megasas_mgmt_majorno = rval;
+
+	/*
+	 * Register ourselves as PCI hotplug module
+	 */
+	rval = pci_module_init(&megasas_pci_driver);
+
+	if(rval) {
+		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed
\n");
+		unregister_chrdev(megasas_mgmt_majorno,
"megaraid_sas_ioctl");
+	}
+
+	return rval;
+}
+
+/**
+ * megasas_exit - Driver unload entry point
+ */
+static void __exit
+megasas_exit(void)
+{
+	pci_unregister_driver(&megasas_pci_driver);
+	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
+
+	return;
+}
+
+module_init(megasas_init);
+module_exit(megasas_exit);
+
