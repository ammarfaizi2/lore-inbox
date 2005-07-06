Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVGFAMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVGFAMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVGFAMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:12:49 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:8241 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262020AbVGFAGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:06:16 -0400
X-IronPort-AV: i="3.94,171,1118034000"; 
   d="scan'208"; a="281695293:sNHT21247226"
Date: Tue, 5 Jul 2005 19:13:34 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, douglas_warzecha@dell.com
Subject: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706001333.GA3569@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Dell Systems Management Base driver.

The Dell Systems Management Base driver is a character driver that
implements ioctls for Dell systems management software to use to
communicate with the driver.  The driver provides support for Dell
systems management software to manage the following Dell PowerEdge
systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC,
650, 1655MC, 700, and 750.

By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and
I have the right to submit it under the open source license
indicated in the file.

Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
---

diff -uprN linux-2.6.13-rc1.orig/drivers/char/dcdbas.c linux-2.6.13-rc1/drivers/char/dcdbas.c
--- linux-2.6.13-rc1.orig/drivers/char/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc1/drivers/char/dcdbas.c	2005-07-05 10:26:22.355056432 -0500
@@ -0,0 +1,777 @@
+/*
+ *  dcdbas.c: Dell Systems Management Base Driver
+ *
+ *  Copyright (C) 1995-2005 Dell Inc.
+ *
+ *  The Dell Systems Management Base driver is a character driver that
+ *  implements ioctls for Dell systems management software to use to
+ *  communicate with the driver.  The driver provides support for Dell
+ *  systems management software to manage the following Dell PowerEdge
+ *  systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC,
+ *  650, 1655MC, 700, and 750.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License v2.0 as published by
+ *  the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ioctl.h>
+#include <linux/kernel.h>
+#include <linux/mc146818rtc.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "dcdbas.h"
+
+#define DRIVER_NAME		"dcdbas"
+#define DRIVER_VERSION		"5.6.0-1"
+#define DRIVER_DESCRIPTION	"Systems Management Base Driver"
+
+static int driver_major;
+static atomic_t hold_on_shutdown;
+static struct semaphore tvm_lock;
+static u8 *tvm_dma_buf;
+static dma_addr_t tvm_dma_buf_handle;
+static u32 tvm_dma_buf_phys_addr;
+static unsigned int tvm_dma_buf_size;
+static u8 tvm_hc_action;
+static u8 tvm_smi_type;
+
+/**
+ * dcdbas_device_release - device release method
+ * @dev: device
+ */
+static void dcdbas_device_release(struct device *dev)
+{
+	/* nothing to release */
+}
+
+static struct platform_device dcdbas_pdev = {
+	.name = DRIVER_NAME,
+	.id   = -1,
+	.dev  = {
+		.coherent_dma_mask = DMA_32BIT_MASK,
+		.dma_mask          = &dcdbas_pdev.dev.coherent_dma_mask,
+		.release           = dcdbas_device_release,
+	},
+};
+
+/**
+ * tvm_free_dma_buf - free buffer allocated for TVM systems management
+ */
+static void tvm_free_dma_buf(void)
+{
+	if (tvm_dma_buf == NULL)
+		return;
+
+	dev_dbg(&dcdbas_pdev.dev, "%s: phys: %x size: %u\n",
+		__FUNCTION__, tvm_dma_buf_phys_addr, tvm_dma_buf_size);
+
+	dma_free_coherent(&dcdbas_pdev.dev, tvm_dma_buf_size, tvm_dma_buf,
+		tvm_dma_buf_handle);
+	tvm_dma_buf = NULL;
+	tvm_dma_buf_handle = 0;
+	tvm_dma_buf_phys_addr = 0;
+	tvm_dma_buf_size = 0;
+}
+
+/**
+ * tvm_realloc_dma_buf - reallocate buffer for TVM systems management if needed
+ * @size: size of memory needed
+ */
+static int tvm_realloc_dma_buf(unsigned int size)
+{
+	u8 *buf;
+	dma_addr_t handle;
+
+	if (size > MAX_TVM_DMA_BUF_SIZE)
+		return -EINVAL;
+
+	if (tvm_dma_buf_size >= size) {
+		if ((size != 0) && (tvm_dma_buf == NULL)) {
+			dev_dbg(&dcdbas_pdev.dev,
+				"%s: corruption detected\n", __FUNCTION__);
+			return -EFAULT;
+		}
+
+		/* current buffer is big enough */
+		return 0;
+	}
+
+	/* new buffer is needed */
+	buf = dma_alloc_coherent(&dcdbas_pdev.dev, size, &handle, GFP_KERNEL);
+	if (buf == NULL) {
+		dev_info(&dcdbas_pdev.dev,
+			"failed to allocate memory of size %u for TVM\n",
+			size);
+		return -ENOMEM;
+	}
+
+	/* free any existing buffer */
+	tvm_free_dma_buf();
+
+	/* set up new buffer for use */
+	tvm_dma_buf = buf;
+	tvm_dma_buf_handle = handle;
+	tvm_dma_buf_phys_addr = (u32)virt_to_phys(buf);
+	tvm_dma_buf_size = size;
+
+	dev_dbg(&dcdbas_pdev.dev, "%s: phys: %x size: %u\n",
+		__FUNCTION__, tvm_dma_buf_phys_addr, tvm_dma_buf_size);
+
+	return 0;
+}
+
+/**
+ * tvm_read_dma_buf - read systems management command response from TVM buffer
+ * @ireq: IOCTL data
+ */
+static int tvm_read_dma_buf(struct dcdbas_ioctl_req *ireq)
+{
+	struct dcdbas_tvm_mem_read *tmr;
+	struct apm_cmd *apm_cmd;
+	unsigned int data_size_needed, buf_size_needed;
+
+	data_size_needed = sizeof(struct dcdbas_tvm_mem_read);
+	if (ireq->hdr.data_size < data_size_needed)
+		return -EINVAL;
+
+	tmr = &ireq->data.tvm_mem_read;
+	dev_dbg(&dcdbas_pdev.dev, "%s: size: %u\n", __FUNCTION__, tmr->size);
+	if (tmr->size < ESM_APM_CMD_HEADER_SIZE ||
+	    tmr->size > MAX_DCDBAS_IOCTL_DATA_SIZE)
+		return -EINVAL;
+
+	data_size_needed = sizeof(struct dcdbas_tvm_mem_read) -
+			   sizeof(tmr->buffer) +
+			   tmr->size;
+	if (ireq->hdr.data_size < data_size_needed)
+		return -EINVAL;
+
+	if (tvm_dma_buf == NULL ||
+	    tvm_dma_buf_size < ESM_APM_CMD_HEADER_SIZE) {
+		ireq->hdr.status = ESM_STATUS_CMD_DEVICE_BAD;
+		return 0;
+	}
+
+	apm_cmd = (struct apm_cmd *)tvm_dma_buf;
+
+	buf_size_needed = tmr->size;
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT)
+		buf_size_needed +=
+			(sizeof(struct apm_cmd) - ESM_APM_CMD_HEADER_SIZE);
+
+	if (tvm_dma_buf_size < buf_size_needed) {
+		ireq->hdr.status = ESM_STATUS_CMD_DEVICE_BAD;
+		return 0;
+	}
+
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT) {
+		/* long command */
+		memcpy(tmr->buffer, tvm_dma_buf, ESM_APM_CMD_HEADER_SIZE);
+		if (tmr->size > ESM_APM_CMD_HEADER_SIZE) {
+			memcpy(tmr->buffer + ESM_APM_CMD_HEADER_SIZE,
+				tvm_dma_buf + sizeof(struct apm_cmd),
+				tmr->size - ESM_APM_CMD_HEADER_SIZE);
+		}
+	} else {
+		/* short command */
+		memcpy(tmr->buffer, tvm_dma_buf, tmr->size);
+	}
+
+	ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+	return 0;
+}
+
+/**
+ * tvm_write_dma_buf - write systems management command request to TVM buffer
+ * @ireq: IOCTL data
+ */
+static int tvm_write_dma_buf(struct dcdbas_ioctl_req *ireq)
+{
+	struct dcdbas_tvm_mem_write *tmw;
+	struct apm_cmd *apm_cmd;
+	unsigned int data_size_needed, buf_size_needed;
+	int ret;
+
+	data_size_needed = sizeof(struct dcdbas_tvm_mem_write);
+	if (ireq->hdr.data_size < data_size_needed)
+		return -EINVAL;
+
+	tmw = &ireq->data.tvm_mem_write;
+	dev_dbg(&dcdbas_pdev.dev, "%s: size: %u\n", __FUNCTION__, tmw->size);
+	if (tmw->size < ESM_APM_CMD_HEADER_SIZE ||
+	    tmw->size > MAX_DCDBAS_IOCTL_DATA_SIZE)
+		return -EINVAL;
+
+	data_size_needed = sizeof(struct dcdbas_tvm_mem_write) -
+			   sizeof(tmw->buffer) +
+			   tmw->size;
+	if (ireq->hdr.data_size < data_size_needed)
+		return -EINVAL;
+
+	apm_cmd = (struct apm_cmd *)tmw->buffer;
+	buf_size_needed = tmw->size;
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT)
+		buf_size_needed +=
+			(sizeof(struct apm_cmd) - ESM_APM_CMD_HEADER_SIZE);
+
+	/* make sure buffer is big enough for command */
+	ret = tvm_realloc_dma_buf(buf_size_needed);
+	if (ret)
+		return ret;
+
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT) {
+		/* long command */
+		memcpy(tvm_dma_buf, tmw->buffer, ESM_APM_CMD_HEADER_SIZE);
+		if (tmw->size > ESM_APM_CMD_HEADER_SIZE) {
+			memcpy(tvm_dma_buf + sizeof(struct apm_cmd),
+				tmw->buffer + ESM_APM_CMD_HEADER_SIZE,
+				tmw->size - ESM_APM_CMD_HEADER_SIZE);
+		}
+
+		/* create scatter/gather list */
+		apm_cmd = (struct apm_cmd *)tvm_dma_buf;
+		apm_cmd->parameters.longreq.num_sg_entries = 1;
+		apm_cmd->parameters.longreq.sglist[0].size =
+			(tmw->size - ESM_APM_CMD_HEADER_SIZE);
+		apm_cmd->parameters.longreq.sglist[0].addr =
+			(tvm_dma_buf_phys_addr + sizeof(struct apm_cmd));
+	} else {
+		/* short command */
+		memcpy(tvm_dma_buf, tmw->buffer, tmw->size);
+	}
+
+	tmw->phys_address = tvm_dma_buf_phys_addr;
+
+	ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+	return 0;
+}
+
+/**
+ * tvm_alloc_dma_buf - allocate buffer for TVM systems management
+ * @ireq: IOCTL data
+ */
+static int tvm_alloc_dma_buf(struct dcdbas_ioctl_req *ireq)
+{
+	struct dcdbas_tvm_mem_alloc *tma;
+	int ret;
+
+	if (ireq->hdr.data_size < sizeof(struct dcdbas_tvm_mem_alloc))
+		return -EINVAL;
+
+	tma = &ireq->data.tvm_mem_alloc;
+	dev_dbg(&dcdbas_pdev.dev, "%s: size: %u\n", __FUNCTION__, tma->size);
+
+	ret = tvm_realloc_dma_buf(tma->size);
+	if (ret)
+		return ret;
+
+	tma->phys_address = tvm_dma_buf_phys_addr;
+
+	ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+	return 0;
+}
+
+/**
+ * tvm_set_hc_action - set TVM system host control action
+ * @ireq: IOCTL data
+ */
+static int tvm_set_hc_action(struct dcdbas_ioctl_req *ireq)
+{
+	struct dcdbas_tvm_hc_action *thca;
+	int ret;
+
+	if (ireq->hdr.data_size < sizeof(struct dcdbas_tvm_hc_action))
+		return -EINVAL;
+
+	/* make sure buffer is available for host control command */
+	ret = tvm_realloc_dma_buf(sizeof(struct apm_cmd));
+	if (ret)
+		return ret;
+
+	thca = &ireq->data.tvm_hc_action;
+	dev_dbg(&dcdbas_pdev.dev, "%s: action_bitmap: %x smi_type: %u\n",
+		__FUNCTION__, thca->action_bitmap, thca->smi_type);
+
+	tvm_hc_action = thca->action_bitmap;
+	tvm_smi_type = thca->smi_type;
+
+	ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+	return 0;
+}
+
+/**
+ * tvm_perform_cmd - perform command for TVM systems management
+ *
+ * The caller must set up the command in tvm_dma_buf.
+ */
+static s32 tvm_perform_cmd(void)
+{
+	struct apm_cmd *apm_cmd;
+	u8 *data;
+	unsigned long flags;
+	u32 num_ticks;
+	s8 cmd_status;
+	u8 index;
+
+	apm_cmd = (struct apm_cmd *)tvm_dma_buf;
+	apm_cmd->status = ESM_STATUS_CMD_UNSUCCESSFUL;
+
+	switch (tvm_smi_type) {
+	case TVM_SMITYPE_TYPE1:
+	{
+		cmd_status = ESM_STATUS_CMD_UNSUCCESSFUL;
+		data = (u8 *)&tvm_dma_buf_phys_addr;
+
+		/* write physical address one byte at a time */
+		spin_lock_irqsave(&rtc_lock, flags);
+		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
+		     index++) {
+			outb(index,
+				(CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
+			outb(*data++,
+				(CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
+		}
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		/* first set status to -1 as called by spec */
+		outb((u8)cmd_status, PCAT_APM_STATUS_PORT);
+
+		/* generate SMM call */
+		outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+
+		/* restore RTC index pointer */
+		spin_lock_irqsave(&rtc_lock, flags);
+		outb(0x0C, 0x70);
+		inb(0x70);
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		/* wait a few to see if it executed */
+		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
+		while ((cmd_status = inb(PCAT_APM_STATUS_PORT))
+		       == ESM_STATUS_CMD_UNSUCCESSFUL) {
+			num_ticks--;
+			if (num_ticks == EXPIRED_TIMER)
+				return ESM_STATUS_CMD_TIMEOUT;
+		}
+	}
+	break;
+
+	case TVM_SMITYPE_TYPE2:
+	case TVM_SMITYPE_TYPE3:
+	{
+		data = (u8 *)&tvm_dma_buf_phys_addr;
+
+		/* write physical address one byte at a time */
+		spin_lock_irqsave(&rtc_lock, flags);
+		for (index = PE1400_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1400_CMOS_CMD_STRUCT_PTR + 4);
+		     index++) {
+			outb(index, (CMOS_BASE_PORT + CMOS_PAGE1_INDEX_PORT));
+			outb(*data++, (CMOS_BASE_PORT + CMOS_PAGE1_DATA_PORT));
+		}
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		/* generate SMM call */
+		if (tvm_smi_type == TVM_SMITYPE_TYPE3)
+			outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+		else
+			outb(ESM_APM_CMD, PE1400_APM_CONTROL_PORT);
+
+		/* restore RTC index pointer */
+		spin_lock_irqsave(&rtc_lock, flags);
+		outb(0x0C, 0x70);
+		inb(0x70);
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		/* read control port back to serialize write */
+		cmd_status = inb(PE1400_APM_CONTROL_PORT);
+
+		/* wait a few to see if it executed */
+		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
+		while (apm_cmd->status == ESM_STATUS_CMD_UNSUCCESSFUL) {
+			num_ticks--;
+			if (num_ticks == EXPIRED_TIMER)
+				return ESM_STATUS_CMD_TIMEOUT;
+		}
+	}
+	break;
+
+	default:
+		return ESM_STATUS_CMD_NOT_IMPLEMENTED;
+	}
+
+	return ESM_STATUS_CMD_SUCCESS;
+}
+
+/**
+ * tvm_host_control - initiate host control action on TVM system
+ */
+static s32 tvm_host_control(void)
+{
+	struct apm_cmd *apm_cmd;
+
+	if (tvm_dma_buf == NULL ||
+	    tvm_dma_buf_size < sizeof(struct apm_cmd)) {
+		dev_dbg(&dcdbas_pdev.dev, "%s: TVM buffer error\n",
+			__FUNCTION__);
+		return ESM_STATUS_CMD_DEVICE_BAD;
+	}
+
+	apm_cmd = (struct apm_cmd *)tvm_dma_buf;
+
+	/* power off takes precedence */
+	if (tvm_hc_action & HC_ACTION_HOST_CONTROL_POWEROFF) {
+		tvm_hc_action = HC_ACTION_NONE;
+
+		apm_cmd->command = ESM_APM_POWER_CYCLE;
+		apm_cmd->reserved = 0;
+		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16)0;
+
+		return tvm_perform_cmd();
+	}
+	if (tvm_hc_action & HC_ACTION_HOST_CONTROL_POWERCYCLE) {
+		tvm_hc_action = HC_ACTION_NONE;
+
+		apm_cmd->command = ESM_APM_POWER_CYCLE;
+		apm_cmd->reserved = 0;
+		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16)20;
+
+		return tvm_perform_cmd();
+	}
+
+	tvm_hc_action = HC_ACTION_NONE;
+
+	return ESM_STATUS_CMD_UNSUCCESSFUL;
+}
+
+/**
+ * callintf_generate_smi - generate SMI for calling interface request
+ * @ireq: IOCTL data
+ */
+static int callintf_generate_smi(struct dcdbas_ioctl_req *ireq)
+{
+#if defined(__i386__)
+	struct dcdbas_callintf_cmd *ci_cmd;
+	u32 command_buffer_phys_addr;
+	cpumask_t old_mask;
+
+	if (ireq->hdr.data_size < sizeof(struct dcdbas_callintf_cmd))
+		return -EINVAL;
+
+	ci_cmd = &ireq->data.callintf_cmd;
+	command_buffer_phys_addr = virt_to_phys(ci_cmd->command_buffer);
+
+	dev_dbg(&dcdbas_pdev.dev, "%s: cmdaddr: %x cmdcode: %x phys: %x\n",
+		__FUNCTION__, ci_cmd->command_address, ci_cmd->command_code,
+		command_buffer_phys_addr);
+
+	/* SMI requires CPU 0 */
+	old_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	if (smp_processor_id() != 0) {
+		dev_dbg(&dcdbas_pdev.dev, "%s: failed to get CPU 0\n",
+			__FUNCTION__);
+		return -EBUSY;
+	}
+
+	/*
+	 * SMI requires command buffer physical address in ebx and
+	 * signature in ecx.
+	 */
+
+	/* generate SMI */
+	asm("outb %b0,%w1" : :
+	      "a" (ci_cmd->command_code),
+	      "d" (ci_cmd->command_address),
+	      "b" (command_buffer_phys_addr),
+	      "c" (ci_cmd->signature));
+
+	set_cpus_allowed(current, old_mask);
+	ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+	return 0;
+#else
+	return -ENOSYS;
+#endif
+}
+
+/**
+ * dcdbas_host_control - initiate host control action
+ */
+static void dcdbas_host_control(void)
+{
+	if (tvm_hc_action != HC_ACTION_NONE)
+		tvm_host_control();
+}
+
+/**
+ * dcdbas_dispatch_ioctl - dispatch IOCTL request
+ * @ireq: IOCTL request
+ */
+static int dcdbas_dispatch_ioctl(struct dcdbas_ioctl_req *ireq)
+{
+	int retval = 0;
+
+	dev_dbg(&dcdbas_pdev.dev, "%s: req_type: %u\n",
+		__FUNCTION__, ireq->hdr.req_type);
+
+	switch (ireq->hdr.req_type) {
+	case ESM_TVM_READ_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		retval = tvm_read_dma_buf(ireq);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_WRITE_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		retval = tvm_write_dma_buf(ireq);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_ALLOC_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		retval = tvm_alloc_dma_buf(ireq);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_HC_ACTION:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		retval = tvm_set_hc_action(ireq);
+		up(&tvm_lock);
+		break;
+
+	case ESM_CALLINTF_REQ:
+		retval = callintf_generate_smi(ireq);
+		break;
+
+	case ESM_HOLD_OS_ON_SHUTDOWN:
+		/* firmware is going to perform host control action */
+		atomic_set(&hold_on_shutdown, 1);
+		ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+		break;
+
+	case ESM_CANCEL_HOLD_OS_ON_SHUTDOWN:
+		atomic_set(&hold_on_shutdown, 0);
+		ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
+		break;
+
+	default:
+		dev_dbg(&dcdbas_pdev.dev, "%s: unsupported req_type\n",
+			__FUNCTION__);
+		ireq->hdr.status = ESM_STATUS_CMD_NOT_IMPLEMENTED;
+		break;
+	}
+
+	return retval;
+}
+
+/**
+ * dcdbas_do_ioctl - process ioctl request
+ * @filp: file object for device
+ * @cmd: IOCTL command
+ * @arg: IOCTL request data
+ */
+static int dcdbas_do_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct dcdbas_ioctl_req __user *ubuf;
+	struct dcdbas_ioctl_req *kbuf;
+	struct dcdbas_ioctl_hdr hdr;
+	unsigned long size;
+	int ret;
+
+	if (cmd != IOCTL_DCDBAS_CMD) {
+		ret = -EINVAL;
+		goto out1;
+	}
+
+	ubuf = (struct dcdbas_ioctl_req __user *)arg;
+	if (copy_from_user(&hdr, ubuf, sizeof(struct dcdbas_ioctl_hdr))) {
+		ret = -EFAULT;
+		goto out1;
+	}
+
+	if (hdr.data_size > MAX_DCDBAS_IOCTL_DATA_SIZE) {
+		ret = -EINVAL;
+		goto out1;
+	}
+
+	size = sizeof(struct dcdbas_ioctl_hdr) + hdr.data_size;
+	if ((kbuf = kmalloc(size, GFP_KERNEL)) == NULL) {
+		dev_info(&dcdbas_pdev.dev,
+			"failed to allocate ioctl memory size %lu\n",
+			size);
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	if (copy_from_user(kbuf, ubuf, size)) {
+		ret = -EFAULT;
+		goto out2;
+	}
+
+	if ((ret = dcdbas_dispatch_ioctl(kbuf)) != 0)
+		goto out2;
+
+	if (copy_to_user(ubuf, kbuf, size))
+		ret = -EFAULT;
+
+out2:
+	kfree(kbuf);
+out1:
+	return ret;
+}
+
+/**
+ * dcdbas_ioctl - ioctl handler
+ * @inode: inode for device
+ * @filp: file object for device
+ * @cmd: IOCTL command
+ * @arg: IOCTL request data
+ */
+static int dcdbas_ioctl(struct inode *inode, struct file *filp,
+			unsigned int cmd, unsigned long arg)
+{
+	return dcdbas_do_ioctl(filp, cmd, arg);
+}
+
+/**
+ * dcdbas_compat_ioctl - compat ioctl handler
+ * @filp: file object for device
+ * @cmd: IOCTL command
+ * @arg: IOCTL request data
+ */
+static long dcdbas_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	return dcdbas_do_ioctl(filp, cmd, arg);
+}
+
+/**
+ * dcdbas_reboot_notify - handle reboot notification
+ * @nb: info about registered reboot notifier
+ * @code: notification code
+ * @unused: unused argument
+ */
+static int dcdbas_reboot_notify(struct notifier_block *nb, unsigned long code,
+				void *unused)
+{
+	static unsigned int notify_cnt = 0;
+
+	switch (code) {
+	case SYS_DOWN:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		if (atomic_read(&hold_on_shutdown)) {
+			/* firmware is going to perform host control action */
+			if (++notify_cnt == 2) {
+				printk(KERN_WARNING
+					"Please wait for shutdown "
+					"action to complete...\n");
+				dcdbas_host_control();
+			}
+			/*
+			 * register again and initiate the host control
+			 * action on the second notification to allow
+			 * everyone that registered to be notified
+			 */
+			register_reboot_notifier(nb);
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct file_operations dcdbas_fops = {
+	.owner =	THIS_MODULE,
+	.ioctl =	dcdbas_ioctl,
+	.compat_ioctl =	dcdbas_compat_ioctl,
+};
+
+static struct notifier_block dcdbas_reboot_nb = {
+	.notifier_call = dcdbas_reboot_notify,
+	.next =		 NULL,
+	.priority =	 0
+};
+
+/**
+ * dcdbas_init - initialize driver
+ */
+static int __init dcdbas_init(void)
+{
+	int ret;
+
+	tvm_hc_action = HC_ACTION_NONE;
+	tvm_smi_type = TVM_SMITYPE_NONE;
+	sema_init(&tvm_lock, 1);
+
+	ret = platform_device_register(&dcdbas_pdev);
+	if (ret)
+		goto error1;
+
+	ret = register_chrdev(0, DRIVER_NAME, &dcdbas_fops);
+	if (ret < 0) {
+		dev_warn(&dcdbas_pdev.dev,
+			"register_chrdev failed with error %d\n",
+			ret);
+		goto error2;
+	}
+	driver_major = ret;
+
+	register_reboot_notifier(&dcdbas_reboot_nb);
+
+	dev_info(&dcdbas_pdev.dev, "%s (version %s)\n",
+		DRIVER_DESCRIPTION, DRIVER_VERSION);
+
+	return 0;
+
+error2:
+	platform_device_unregister(&dcdbas_pdev);
+error1:
+	return ret;
+}
+
+/**
+ * dcdbas_exit - perform driver cleanup
+ */
+static void __exit dcdbas_exit(void)
+{
+	unregister_reboot_notifier(&dcdbas_reboot_nb);
+	unregister_chrdev(driver_major, DRIVER_NAME);
+	platform_device_unregister(&dcdbas_pdev);
+	tvm_free_dma_buf();
+}
+
+module_init(dcdbas_init);
+module_exit(dcdbas_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION" (version "DRIVER_VERSION")");
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_AUTHOR("Dell Inc.");
+MODULE_LICENSE("GPL");
+
diff -uprN linux-2.6.13-rc1.orig/drivers/char/dcdbas.h linux-2.6.13-rc1/drivers/char/dcdbas.h
--- linux-2.6.13-rc1.orig/drivers/char/dcdbas.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc1/drivers/char/dcdbas.h	2005-07-05 10:26:24.635709720 -0500
@@ -0,0 +1,163 @@
+/*
+ *  dcdbas.h: Definitions for Dell Systems Management Base driver
+ *
+ *  Copyright (C) 1995-2005 Dell Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License v2.0 as published by
+ *  the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#ifndef _DCDBAS_H_
+#define _DCDBAS_H_
+
+#include <linux/input.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * IOCTL command values
+ */
+#define DCDBAS_IOC_TYPE				'U'
+#define IOCTL_DCDBAS_CMD			_IO(DCDBAS_IOC_TYPE, 1)
+
+/*
+ * IOCTL request type values
+ */
+#define ESM_HOLD_OS_ON_SHUTDOWN			(41)
+#define ESM_CANCEL_HOLD_OS_ON_SHUTDOWN		(42)
+#define ESM_TVM_HC_ACTION			(43)
+#define ESM_TVM_ALLOC_MEM			(44)
+#define ESM_CALLINTF_REQ			(47)
+#define ESM_TVM_READ_MEM			(48)
+#define ESM_TVM_WRITE_MEM			(49)
+
+#define MAX_DCDBAS_IOCTL_DATA_SIZE		(127 * 1024)
+#define MAX_TVM_DMA_BUF_SIZE			(128 * 1024)
+
+/*
+ * IOCTL status values
+ */
+#define ESM_STATUS_CMD_UNSUCCESSFUL		(-1)
+#define ESM_STATUS_CMD_SUCCESS			(0)
+#define ESM_STATUS_CMD_NOT_IMPLEMENTED		(1)
+#define ESM_STATUS_CMD_BAD			(2)
+#define ESM_STATUS_CMD_TIMEOUT			(3)
+#define ESM_STATUS_CMD_NO_SUCH_DEVICE		(7)
+#define ESM_STATUS_CMD_DEVICE_BAD		(9)
+
+/*
+ * Host control action values
+ */
+#define HC_ACTION_NONE				(0)
+#define HC_ACTION_HOST_CONTROL_POWEROFF		BIT(1)
+#define HC_ACTION_HOST_CONTROL_POWERCYCLE	BIT(2)
+
+/*
+ * TVM SMI type values
+ */
+#define TVM_SMITYPE_NONE			(0)
+#define TVM_SMITYPE_TYPE1			(1)
+#define TVM_SMITYPE_TYPE2			(2)
+#define TVM_SMITYPE_TYPE3			(3)
+
+/*
+ * APM command values
+ */
+#define ESM_APM_CMD				(0x0A0)
+#define ESM_APM_CMD_HEADER_SIZE			(4)
+#define ESM_APM_POWER_CYCLE			(0x10)
+#define ESM_APM_LONG_CMD_FORMAT			BIT(7)
+
+#define CMOS_BASE_PORT				(0x070)
+#define CMOS_PAGE1_INDEX_PORT			(0)
+#define CMOS_PAGE1_DATA_PORT			(1)
+#define CMOS_PAGE2_INDEX_PORT_PIIX4		(2)
+#define CMOS_PAGE2_DATA_PORT_PIIX4		(3)
+#define PE1400_APM_CONTROL_PORT			(0x0B0)
+#define PCAT_APM_CONTROL_PORT			(0x0B2)
+#define PCAT_APM_STATUS_PORT			(0x0B3)
+#define PE1300_CMOS_CMD_STRUCT_PTR		(0x38)
+#define PE1400_CMOS_CMD_STRUCT_PTR		(0x70)
+
+#define MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN	(14)
+#define MAX_SYSMGMT_LONGCMD_SGENTRY_NUM		(16)
+
+#define TIMEOUT_USEC_SHORT_SEMA_BLOCKING	(10000)
+#define EXPIRED_TIMER				(0)
+
+struct dcdbas_ioctl_hdr {
+	u64 reserved;
+	s32 status;
+	u32 req_type;
+	u32 data_size;
+} __attribute__ ((packed));
+
+struct dcdbas_tvm_mem_alloc {
+	u32 phys_address;
+	u32 size;
+} __attribute__ ((packed));
+
+struct dcdbas_tvm_mem_read {
+	u32 size;
+	u8 buffer[1];
+} __attribute__ ((packed));
+
+struct dcdbas_tvm_mem_write {
+	u32 phys_address;
+	u32 size;
+	u8 buffer[1];
+} __attribute__ ((packed));
+
+struct dcdbas_tvm_hc_action {
+	u8 action_bitmap;
+	u8 smi_type;
+} __attribute__ ((packed));
+
+struct dcdbas_callintf_cmd {
+	u16 command_address;
+	u8 command_code;
+	u8 reserved[1];
+	u32 signature;
+	u32 command_buffer_size;
+	u8 command_buffer[1];
+} __attribute__ ((packed));
+
+struct dcdbas_ioctl_req {
+	struct dcdbas_ioctl_hdr hdr;
+	union {
+		struct dcdbas_tvm_mem_alloc tvm_mem_alloc;
+		struct dcdbas_tvm_mem_read  tvm_mem_read;
+		struct dcdbas_tvm_mem_write tvm_mem_write;
+		struct dcdbas_tvm_hc_action tvm_hc_action;
+		struct dcdbas_callintf_cmd  callintf_cmd;
+	} __attribute__ ((packed)) data;
+} __attribute__ ((packed));
+
+struct apm_cmd {
+	u8 command;
+	s8 status;
+	u16 reserved;
+	union {
+		struct {
+			u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
+		} __attribute__ ((packed)) shortreq;
+
+		struct {
+			u16 num_sg_entries;
+			struct {
+				u32 size;
+				u64 addr;
+			} __attribute__ ((packed))
+			sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
+		} __attribute__ ((packed)) longreq;
+	} __attribute__ ((packed)) parameters;
+} __attribute__ ((packed));
+
+#endif /* _DCDBAS_H_ */
+
diff -uprN linux-2.6.13-rc1.orig/drivers/char/Kconfig linux-2.6.13-rc1/drivers/char/Kconfig
--- linux-2.6.13-rc1.orig/drivers/char/Kconfig	2005-07-05 10:19:56.000000000 -0500
+++ linux-2.6.13-rc1/drivers/char/Kconfig	2005-07-05 10:26:32.026586136 -0500
@@ -1002,5 +1002,22 @@ config MMTIMER
 
 source "drivers/char/tpm/Kconfig"
 
+menu "Dell Systems Management"
+
+config DCDBAS
+	tristate "Dell Systems Management Base driver"
+	default m
+	help
+	  The Dell Systems Management Base driver provides support for
+	  Dell systems management software to manage the following Dell
+	  PowerEdge systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550,
+	  600SC, 1600SC, 650, 1655MC, 700, and 750.
+
+	  Say Y or M here if you plan to use Dell systems management
+	  software to manage one of the systems listed above.  If you
+	  say M here, the driver will be compiled as a module called dcdbas.
+
+endmenu
+
 endmenu
 
diff -uprN linux-2.6.13-rc1.orig/drivers/char/Makefile linux-2.6.13-rc1/drivers/char/Makefile
--- linux-2.6.13-rc1.orig/drivers/char/Makefile	2005-07-05 10:19:56.000000000 -0500
+++ linux-2.6.13-rc1/drivers/char/Makefile	2005-07-05 10:26:37.284786768 -0500
@@ -92,6 +92,8 @@ obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/
+obj-$(CONFIG_DCDBAS) += dcdbas.o
+
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff -uprN linux-2.6.13-rc1.orig/MAINTAINERS linux-2.6.13-rc1/MAINTAINERS
--- linux-2.6.13-rc1.orig/MAINTAINERS	2005-07-05 10:19:55.580855000 -0500
+++ linux-2.6.13-rc1/MAINTAINERS	2005-07-05 10:26:45.762497960 -0500
@@ -692,6 +692,11 @@ M:	dz@debian.org
 W:	http://www.debian.org/~dz/i8k/
 S:	Maintained
 
+DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
+P:	Doug Warzecha
+M:	Douglas_Warzecha@dell.com
+S:	Maintained
+
 DEVICE-MAPPER
 P:	Alasdair Kergon
 L:	dm-devel@redhat.com
