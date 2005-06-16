Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVFPR2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVFPR2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVFPR2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:28:05 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:54419 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261776AbVFPRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:25:47 -0400
X-IronPort-AV: i="3.93,204,1115010000"; 
   d="scan'208"; a="255127839:sNHT22681732"
Date: Thu, 16 Jun 2005 12:30:24 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: douglas_warzecha@dell.com, abhay_salunke@dell.com, matt_domsch@dell.com
Subject: [PATCH 2.6.12-rc6] char: Add Dell Systems Management Base driver
Message-ID: <20050616173024.GA2596@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Dell Systems Management Base driver.

The Dell Systems Management Base driver is a character driver that
provides support needed by Dell systems management software to manage
certain Dell systems.  The driver implements ioctls for Dell systems
management software to use to communicate with the driver.

This driver has been tested with Dell systems management software
on a variety of Dell systems.

By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and
I have the right to submit it under the open source license
indicated in the file.

Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
---

diff -uprN linux-2.6.12-rc6.orig/drivers/char/dcdbas.c linux-2.6.12-rc6/drivers/char/dcdbas.c
--- linux-2.6.12-rc6.orig/drivers/char/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.12-rc6/drivers/char/dcdbas.c	2005-06-16 11:14:24.937360712 -0500
@@ -0,0 +1,666 @@
+/*
+ *  Dell Systems Management Base driver for Linux kernels 2.4 and 2.6
+ *
+ *  Copyright (C) 1995-2005 Dell Inc.
+ *
+ *  The Dell Systems Management Base driver provides support needed by
+ *  Dell systems management software to manage Dell systems.
+ *  The systems management software uses ioctls to communicate
+ *  with the driver.
+ *
+ *  The DRIVER_VERSION and MODULE_DESCRIPTION macros must specify
+ *  the driver version as defined below to provide proper driver
+ *  versioning for systems management scripts.
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
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ioctl.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "dcdbas.h"
+
+#define DRIVER_NAME		"dcdbas"
+#define DRIVER_VERSION		"5.6.0-1"
+#define DRIVER_DESCRIPTION	"Systems Management Base driver"
+
+static int driver_major;
+static atomic_t hold_on_shutdown;
+static struct semaphore tvm_lock;
+static u8 *tvm_dma_buf;
+static u32 tvm_dma_buf_phys_addr;
+static unsigned long tvm_dma_buf_size;
+static u8 tvm_hc_action;
+static u8 tvm_smi_type;
+
+/**
+ * tvm_alloc_suitable - allocate memory suitable for TVM system management
+ * @size: size of memory to allocate
+ * @phys_max: maximum physical memory address
+ */
+static void *tvm_alloc_suitable(unsigned long size, unsigned long phys_max)
+{
+	void *ptr;
+	unsigned int flags = GFP_KERNEL;
+
+	while ((ptr = kmalloc(size, flags)) != NULL) {
+		if ((virt_to_phys(ptr) + size - 1) <= phys_max)
+			break;
+
+		kfree(ptr);
+		ptr = NULL;
+
+		if (flags & GFP_DMA)
+			break;
+
+		flags |= GFP_DMA;
+	}
+	return ptr;
+}
+
+/**
+ * tvm_free_suitable - free memory suitable for TVM system management
+ * @ptr: virtual address of memory to free
+ */
+static void tvm_free_suitable(void *ptr)
+{
+	kfree(ptr);
+}
+
+/**
+ * tvm_free_dma_buf - free buffer allocated for TVM system support
+ */
+static void tvm_free_dma_buf(void)
+{
+	if (tvm_dma_buf == NULL)
+		return;
+
+	pr_debug("%s: phys: %x size: %lu\n",
+		__FUNCTION__, tvm_dma_buf_phys_addr, tvm_dma_buf_size);
+
+	tvm_free_suitable(tvm_dma_buf);
+	tvm_dma_buf = NULL;
+	tvm_dma_buf_phys_addr = 0;
+	tvm_dma_buf_size = 0;
+}
+
+/**
+ * tvm_realloc_dma_buf - reallocate buffer for TVM system support if needed
+ * @size: size of memory needed
+ */
+static s32 tvm_realloc_dma_buf(unsigned long size)
+{
+	u8 *buf;
+
+	if (tvm_dma_buf_size >= size) {
+		if ((size != 0) && (tvm_dma_buf == NULL)) {
+			pr_debug("%s: corruption detected\n", __FUNCTION__);
+			return ESM_STATUS_CMD_DEVICE_BAD;
+		}
+
+		/* current buffer is big enough */
+		return ESM_STATUS_CMD_SUCCESS;
+	}
+
+	/* new buffer is needed */
+	buf = tvm_alloc_suitable(size, TVM_PHYS_MAX);
+	if (buf == NULL) {
+		printk(KERN_INFO
+			"%s failed to allocate memory of size %lu for TVM\n",
+			DRIVER_NAME, size);
+		return ESM_STATUS_CMD_UNSUCCESSFUL;
+	}
+
+	/* free any existing buffer */
+	tvm_free_dma_buf();
+
+	/* set up new buffer for use */
+	tvm_dma_buf = buf;
+	tvm_dma_buf_phys_addr = (u32)virt_to_phys(buf);
+	tvm_dma_buf_size = size;
+
+	pr_debug("%s: phys: %x size: %lu\n",
+		__FUNCTION__, tvm_dma_buf_phys_addr, tvm_dma_buf_size);
+
+	return ESM_STATUS_CMD_SUCCESS;
+}
+
+/**
+ * tvm_read_dma_buf - read data from TVM buffer
+ * @tmr: IOCTL data
+ */
+static s32 tvm_read_dma_buf(struct dcdbas_tvm_mem_read *tmr)
+{
+	struct apm_cmd_t *apm_cmd;
+	unsigned long size_needed;
+
+	pr_debug("%s: size: %u\n", __FUNCTION__, tmr->size);
+
+	if (tvm_dma_buf == NULL) {
+		pr_debug("%s: TVM buffer not allocated\n", __FUNCTION__);
+		return ESM_STATUS_CMD_DEVICE_BAD;
+	}
+
+	apm_cmd = (struct apm_cmd_t *)tvm_dma_buf;
+
+	size_needed = tmr->size;
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT)
+		size_needed +=
+			(sizeof(struct apm_cmd_t) - ESM_APM_CMD_HEADER_SIZE);
+
+	if (size_needed > tvm_dma_buf_size) {
+		pr_debug("%s: TVM buffer too small\n", __FUNCTION__);
+		return ESM_STATUS_CMD_DEVICE_BAD;
+	}
+
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT) {
+		/* long command */
+		memcpy(tmr->buffer, tvm_dma_buf, ESM_APM_CMD_HEADER_SIZE);
+		if (tmr->size > ESM_APM_CMD_HEADER_SIZE) {
+			memcpy(tmr->buffer + ESM_APM_CMD_HEADER_SIZE,
+				tvm_dma_buf + sizeof(struct apm_cmd_t),
+				tmr->size - ESM_APM_CMD_HEADER_SIZE);
+		}
+	} else {
+		/* short command */
+		memcpy(tmr->buffer, tvm_dma_buf, tmr->size);
+	}
+
+	return ESM_STATUS_CMD_SUCCESS;
+}
+
+/**
+ * tvm_write_dma_buf - write data to TVM buffer
+ * @tmw: IOCTL data
+ */
+static s32 tvm_write_dma_buf(struct dcdbas_tvm_mem_write *tmw)
+{
+	struct apm_cmd_t *apm_cmd = (struct apm_cmd_t *)tmw->buffer;
+	u32 size_needed = tmw->size;
+	s32 status;
+
+	pr_debug("%s: size: %u\n", __FUNCTION__, tmw->size);
+
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT)
+		size_needed +=
+			(sizeof(struct apm_cmd_t) - ESM_APM_CMD_HEADER_SIZE);
+
+	status = tvm_realloc_dma_buf(size_needed);
+	if (status != ESM_STATUS_CMD_SUCCESS)
+		return status;
+
+	if (apm_cmd->command & ESM_APM_LONG_CMD_FORMAT) {
+		/* long command */
+		memcpy(tvm_dma_buf, tmw->buffer, ESM_APM_CMD_HEADER_SIZE);
+		if (tmw->size > ESM_APM_CMD_HEADER_SIZE) {
+			memcpy(tvm_dma_buf + sizeof(struct apm_cmd_t),
+				tmw->buffer + ESM_APM_CMD_HEADER_SIZE,
+				tmw->size - ESM_APM_CMD_HEADER_SIZE);
+		}
+
+		/* create scatter/gather list */
+		apm_cmd = (struct apm_cmd_t *)tvm_dma_buf;
+		apm_cmd->parameters.longreq.num_sg_entries = 1;
+		apm_cmd->parameters.longreq.sglist[0].size =
+			(tmw->size - ESM_APM_CMD_HEADER_SIZE);
+		apm_cmd->parameters.longreq.sglist[0].addr =
+			(tvm_dma_buf_phys_addr + sizeof(struct apm_cmd_t));
+	} else {
+		/* short command */
+		memcpy(tvm_dma_buf, tmw->buffer, tmw->size);
+	}
+
+	tmw->phys_address = tvm_dma_buf_phys_addr;
+
+	return ESM_STATUS_CMD_SUCCESS;
+}
+
+/**
+ * tvm_alloc_dma_buf - allocate buffer for TVM system support
+ * @tma: IOCTL data
+ */
+static s32 tvm_alloc_dma_buf(struct dcdbas_tvm_mem_alloc *tma)
+{
+	s32 status;
+
+	pr_debug("%s: size: %u\n", __FUNCTION__, tma->size);
+
+	status = tvm_realloc_dma_buf(tma->size);
+	if (status == ESM_STATUS_CMD_SUCCESS)
+		tma->phys_address = tvm_dma_buf_phys_addr;
+	else
+		tma->phys_address = 0;
+
+	return status;
+}
+
+/**
+ * tvm_set_hc_action - set TVM host control action
+ * @thca: IOCTL data
+ */
+static s32 tvm_set_hc_action(struct dcdbas_tvm_hc_action *thca)
+{
+	pr_debug("%s: action_bitmap: %x smi_type: %u\n",
+		__FUNCTION__, thca->action_bitmap, thca->smi_type);
+
+	if (tvm_dma_buf == NULL) {
+		pr_debug("%s: TVM buffer not allocated\n", __FUNCTION__);
+		return ESM_STATUS_CMD_UNSUCCESSFUL;
+	}
+
+	tvm_hc_action = thca->action_bitmap;
+	tvm_smi_type = thca->smi_type;
+
+	return ESM_STATUS_CMD_SUCCESS;
+}
+
+/**
+ * tvm_perform_cmd - perform command for TVM system support
+ *
+ * The caller must set up the command in tvm_dma_buf.
+ */
+static s32 tvm_perform_cmd(void)
+{
+	struct apm_cmd_t *apm_cmd;
+	u8 *data;
+	u32 num_ticks;
+	s8 cmd_status;
+	u8 index;
+
+	apm_cmd = (struct apm_cmd_t *)tvm_dma_buf;
+	apm_cmd->status = ESM_STATUS_CMD_UNSUCCESSFUL;
+
+	switch (tvm_smi_type) {
+	case TVM_SMITYPE_TYPE1:
+	{
+		/* write physical address one byte at a time */
+		data = (u8 *)&tvm_dma_buf_phys_addr;
+		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
+		     index++) {
+			outb(index,
+				(CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
+			outb(*data++,
+				(CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
+		}
+
+		cmd_status = ESM_STATUS_CMD_UNSUCCESSFUL;
+
+		/* first set status to -1 as called by spec */
+		outb((u8)cmd_status, PCAT_APM_STATUS_PORT);
+
+		/* generate SMM call */
+		outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+
+		/* restore RTC index pointer */
+		outb(0x0C, 0x70);
+		inb(0x70);
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
+		/* write physical address one byte at a time */
+		data = (u8 *)&tvm_dma_buf_phys_addr;
+		for (index = PE1400_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1400_CMOS_CMD_STRUCT_PTR + 4);
+		     index++) {
+			outb(index, (CMOS_BASE_PORT + CMOS_PAGE1_INDEX_PORT));
+			outb(*data++, (CMOS_BASE_PORT + CMOS_PAGE1_DATA_PORT));
+		}
+
+		/* generate SMM call */
+		if (tvm_smi_type == TVM_SMITYPE_TYPE3)
+			outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+		else
+			outb(ESM_APM_CMD, PE1400_APM_CONTROL_PORT);
+
+		/* restore RTC index pointer */
+		outb(0x0C, 0x70);
+		inb(0x70);
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
+	struct apm_cmd_t *apm_cmd;
+
+	if (tvm_dma_buf == NULL) {
+		pr_debug("%s: TVM memory not allocated\n", __FUNCTION__);
+		return ESM_STATUS_CMD_UNSUCCESSFUL;
+	}
+
+	apm_cmd = (struct apm_cmd_t *)tvm_dma_buf;
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
+	struct dcdbas_callintf_cmd *ci_cmd = &ireq->data.callintf_cmd;
+	u32 command_buffer_phys_addr = virt_to_phys(ci_cmd->command_buffer);
+	cpumask_t old_mask;
+
+	pr_debug("%s: cmdaddr: %x cmdcode: %x phys: %x\n",
+		__FUNCTION__, ci_cmd->command_address, ci_cmd->command_code,
+		command_buffer_phys_addr);
+
+	/* SMI requires CPU 0 */
+	old_mask = current->cpus_allowed;
+	set_cpus_allowed(current, CPUMASK_OF_CPU(0));
+	if (smp_processor_id() != 0) {
+		pr_debug("%s: failed to get CPU 0\n", __FUNCTION__);
+		return -EBUSY;
+	}
+
+	/* generate SMI */
+	asm("pushl %ebx");
+	asm("pushl %ecx");
+	asm("rep" : : "b" (command_buffer_phys_addr));
+	asm("rep" : : "c" (ci_cmd->signature));
+	outb(ci_cmd->command_code, ci_cmd->command_address);
+	asm("popl %ecx");
+	asm("popl %ebx");
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
+	pr_debug("%s: req_type: %u\n", __FUNCTION__, ireq->hdr.req_type);
+
+	switch (ireq->hdr.req_type) {
+	case ESM_TVM_READ_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		ireq->hdr.status = tvm_read_dma_buf(&ireq->data.tvm_mem_read);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_WRITE_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		ireq->hdr.status = tvm_write_dma_buf(&ireq->data.tvm_mem_write);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_ALLOC_MEM:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		ireq->hdr.status = tvm_alloc_dma_buf(&ireq->data.tvm_mem_alloc);
+		up(&tvm_lock);
+		break;
+
+	case ESM_TVM_HC_ACTION:
+		if (down_interruptible(&tvm_lock))
+			return -ERESTARTSYS;
+		ireq->hdr.status = tvm_set_hc_action(&ireq->data.tvm_hc_action);
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
+		pr_debug("%s: unsupported req_type\n", __FUNCTION__);
+		ireq->hdr.status = ESM_STATUS_CMD_NOT_IMPLEMENTED;
+		break;
+	}
+
+	return retval;
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
+	struct dcdbas_ioctl_req *ubuf = (struct dcdbas_ioctl_req *)arg;
+	struct dcdbas_ioctl_req *kbuf = NULL;
+	struct dcdbas_ioctl_hdr hdr;
+	unsigned long size;
+	int retval;
+
+	if (cmd != IOCTL_DCDBAS_CMD)
+		return -EINVAL;
+
+	if (copy_from_user(&hdr, ubuf, sizeof(struct dcdbas_ioctl_hdr)))
+		return -EFAULT;
+
+	size = sizeof(struct dcdbas_ioctl_hdr) + hdr.data_size;
+	if (size > MAX_DCDBAS_IOCTL_REQ_SIZE)
+		return -EINVAL;
+
+	if ((kbuf = kmalloc(size, GFP_KERNEL)) == NULL) {
+		printk(KERN_INFO
+			"%s failed to allocate ioctl memory size %lu\n",
+			DRIVER_NAME, size);
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(kbuf, ubuf, size)) {
+		kfree(kbuf);
+		return -EFAULT;
+	}
+
+	if ((retval = dcdbas_dispatch_ioctl(kbuf)) != 0) {
+		kfree(kbuf);
+		return retval;
+	}
+
+	if (copy_to_user(ubuf, kbuf, size)) {
+		kfree(kbuf);
+		return -EFAULT;
+	}
+
+	kfree(kbuf);
+
+	return 0;
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
+	static int msg_done = 0;
+
+	switch (code) {
+	case SYS_DOWN:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		if (atomic_read(&hold_on_shutdown)) {
+			/* firmware is going to perform host control action */
+			if (!msg_done) {
+				printk(KERN_WARNING
+					"Please wait for shutdown "
+					"action to complete...\n");
+				msg_done = 1;
+			}
+			register_reboot_notifier(nb);
+			dcdbas_host_control();
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct file_operations dcdbas_fops = {
+	owner:	THIS_MODULE,
+	ioctl:	dcdbas_ioctl,
+};
+
+static struct notifier_block dcdbas_reboot_nb = {
+	dcdbas_reboot_notify,
+	NULL,
+	0
+};
+
+/**
+ * dcdbas_init - initialize module
+ */
+static int __init dcdbas_init(void)
+{
+	int retval;
+
+	tvm_hc_action = HC_ACTION_NONE;
+	tvm_smi_type = TVM_SMITYPE_NONE;
+	sema_init(&tvm_lock, 1);
+
+	retval = register_chrdev(0, DRIVER_NAME, &dcdbas_fops);
+	if (retval < 0) {
+		printk(KERN_WARNING
+			"%s: register_chrdev failed with error %d\n",
+			DRIVER_NAME, retval);
+		return retval;
+	}
+	driver_major = retval;
+
+	register_reboot_notifier(&dcdbas_reboot_nb);
+	dcdbas_register_ioctl32(IOCTL_DCDBAS_CMD);
+
+	printk(KERN_INFO"%s version %s\n", DRIVER_NAME, DRIVER_VERSION);
+
+	return 0;
+}
+
+/**
+ * dcdbas_exit - perform module cleanup
+ */
+static void __exit dcdbas_exit(void)
+{
+	dcdbas_unregister_ioctl32(IOCTL_DCDBAS_CMD);
+	unregister_reboot_notifier(&dcdbas_reboot_nb);
+	unregister_chrdev(driver_major, DRIVER_NAME);
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
diff -uprN linux-2.6.12-rc6.orig/drivers/char/dcdbas.h linux-2.6.12-rc6/drivers/char/dcdbas.h
--- linux-2.6.12-rc6.orig/drivers/char/dcdbas.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.12-rc6/drivers/char/dcdbas.h	2005-06-16 11:14:24.937360712 -0500
@@ -0,0 +1,196 @@
+/*
+ *  Dell Systems Management Base driver for Linux kernels 2.4 and 2.6
+ *
+ *  Copyright (C) 1995-2005 Dell Inc.
+ *
+ *  The Dell Systems Management Base driver provides support needed by
+ *  Dell systems management software to manage Dell systems.
+ *  The systems management software uses ioctls to communicate
+ *  with the driver.
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
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/ioctl.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_X86_64
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#include <linux/ioctl32.h>
+#else
+#include <asm/ioctl32.h>
+#endif
+#endif
+
+#ifdef CONFIG_X86_64
+/* use 64bit ioctl handler for 32bit ioctls */
+#define dcdbas_register_ioctl32(cmd)	register_ioctl32_conversion(cmd, NULL)
+#define dcdbas_unregister_ioctl32(cmd)	unregister_ioctl32_conversion(cmd)
+#else
+#define dcdbas_register_ioctl32(cmd)	{}
+#define dcdbas_unregister_ioctl32(cmd)	{}
+#endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#define CPUMASK_OF_CPU(cpu)		cpumask_of_cpu(cpu)
+#else
+#define CPUMASK_OF_CPU(cpu)		(1 << cpu_logical_map(cpu))
+typedef unsigned long cpumask_t;
+#define MODULE_VERSION(VERSION)
+#endif
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
+#define MAX_DCDBAS_IOCTL_REQ_SIZE		(128 * 1024)
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
+#define TVM_PHYS_MAX				(0xffffffffUL)
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
+	union __attribute__ ((packed)) {
+		struct dcdbas_tvm_mem_alloc	tvm_mem_alloc;
+		struct dcdbas_tvm_mem_read	tvm_mem_read;
+		struct dcdbas_tvm_mem_write	tvm_mem_write;
+		struct dcdbas_tvm_hc_action	tvm_hc_action;
+		struct dcdbas_callintf_cmd	callintf_cmd;
+	} data;
+} __attribute__ ((packed));
+
+struct apm_cmd_t {
+	u8 command;
+	s8 status;
+	u16 reserved;
+	union __attribute__ ((packed)) {
+		struct __attribute__ ((packed)) {
+			u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
+		} shortreq;
+
+		struct __attribute__ ((packed)) {
+			u16 num_sg_entries;
+			struct __attribute__ ((packed)) {
+				u32 size;
+				u64 addr;
+			} sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
+		} longreq;
+	} parameters;
+} __attribute__ ((packed));
+
+#endif /* _DCDBAS_H_ */
+
diff -uprN linux-2.6.12-rc6.orig/drivers/char/Kconfig linux-2.6.12-rc6/drivers/char/Kconfig
--- linux-2.6.12-rc6.orig/drivers/char/Kconfig	2005-06-15 19:09:47.000000000 -0500
+++ linux-2.6.12-rc6/drivers/char/Kconfig	2005-06-16 11:18:03.664109192 -0500
@@ -998,5 +998,21 @@ config MMTIMER
 
 source "drivers/char/tpm/Kconfig"
 
+menu "Dell Systems Management"
+
+config DCDBAS
+	tristate "Dell Systems Management Base driver"
+	default m
+	help
+	  The Dell Systems Management Base driver provides support
+	  needed by Dell systems management software to manage
+	  certain Dell systems.
+
+	  Say Y or M here if you plan to use Dell systems management
+	  software to manage your system.  If you say M here, the
+	  driver will be compiled as a module called dcdbas.
+
+endmenu
+
 endmenu
 
diff -uprN linux-2.6.12-rc6.orig/drivers/char/Makefile linux-2.6.12-rc6/drivers/char/Makefile
--- linux-2.6.12-rc6.orig/drivers/char/Makefile	2005-06-15 19:09:47.000000000 -0500
+++ linux-2.6.12-rc6/drivers/char/Makefile	2005-06-16 11:18:07.973454072 -0500
@@ -91,6 +91,8 @@ obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/
+obj-$(CONFIG_DCDBAS) += dcdbas.o
+
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff -uprN linux-2.6.12-rc6.orig/MAINTAINERS linux-2.6.12-rc6/MAINTAINERS
--- linux-2.6.12-rc6.orig/MAINTAINERS	2005-06-15 19:09:46.000000000 -0500
+++ linux-2.6.12-rc6/MAINTAINERS	2005-06-16 11:14:14.194993800 -0500
@@ -681,6 +681,11 @@ M:	dz@debian.org
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
