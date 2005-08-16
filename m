Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVHPGXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVHPGXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHPGXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:23:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:33482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932602AbVHPGXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:23:46 -0400
Date: Mon, 15 Aug 2005 22:52:48 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816055247.GA20697@kroah.com>
References: <20050815200522.GA3667@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815200522.GA3667@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 03:05:22PM -0500, Doug Warzecha wrote:
> This patch adds the Dell Systems Management Base Driver with sysfs support.
> 
> This driver has been tested with Dell OpenManage.

Much better, but I still have a few questions:

> +System Management Interrupt
> +
> +On some Dell systems, systems management software must access certain
> +management information via a system management interrupt (SMI).  The SMI data
> +buffer must reside in 32-bit address space, and the physical address of the
> +buffer is required for the SMI.  The driver maintains the memory required for
> +the SMI and provides a way for the application to generate the SMI.
> +The driver creates the following sysfs entries for systems management
> +software to perform these system management interrupts:
> +
> +/sys/devices/platform/dcdbas/smi_data
> +/sys/devices/platform/dcdbas/smi_data_buf_phys_addr
> +/sys/devices/platform/dcdbas/smi_data_buf_size
> +/sys/devices/platform/dcdbas/callintf_smi
> +
> +Systems management software must perform the following steps to execute
> +a SMI using this driver:
> +
> +1) Lock smi_data.
> +2) Determine buffer size needed for system management command.
> +3) Write buffer size needed to smi_data_buf_size.
> +   (Driver will ensure that its SMI data buffer is at least that size.)

Why have this step?  Why is it needed?  Just go off of the size of the
buffer that is written to smi_data.  Or am I missing something?

> +4) If physical address of SMI data buffer is needed to set up system
> +   management command, read physical address from smi_data_buf_phys_addr
> +   and add to command data.

How do you know this?

> +5) Write system management command to smi_data.
> +6) Write "1" to callintf_smi to generate a calling interface SMI.
> +7) Read system management command response from smi_data.
> +8) Unlock smi_data.
> +
> +
> +Host Control Action
> +
> +Dell OpenManage supports a host control feature that allows the administrator
> +to perform a power cycle or power off of the system after the OS has finished
> +shutting down.  On some Dell systems, this host control feature requires that
> +a driver perform a SMI after the OS has finished shutting down.
> +
> +The driver creates the following sysfs entries for systems management software
> +to schedule the driver to perform a power cycle or power off host control
> +action after the system has finished shutting down:
> +
> +/sys/devices/platform/dcdbas/host_control_action
> +/sys/devices/platform/dcdbas/host_control_smi_type
> +/sys/devices/platform/dcdbas/host_control_on_shutdown
> +
> +Dell OpenManage performs the following steps to execute a power cycle or
> +power off host control action using this driver:
> +
> +1) Write host control action to be performed to host_control_action.
> +2) Write type of SMI that driver needs to perform to host_control_smi_type.
> +3) Write "1" to host_control_on_shutdown to enable host control action.
> +4) Initiate OS shutdown.
> +   (Driver will perform host control SMI when it is notified that the OS
> +   has finished shutting down.)
> +
> +
> diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c linux-2.6.13-rc6/drivers/firmware/dcdbas.c
> --- linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.13-rc6/drivers/firmware/dcdbas.c	2005-08-15 14:07:32.000000000 -0500
> @@ -0,0 +1,601 @@
> +/*
> + *  dcdbas.c: Dell Systems Management Base Driver
> + *
> + *  The Dell Systems Management Base Driver provides a sysfs interface for
> + *  systems management software to perform System Management Interrupts (SMIs)
> + *  and Host Control Actions (power cycle or power off after OS shutdown) on
> + *  Dell systems.
> + *
> + *  See Documentation/dcdbas.txt for more information.
> + *
> + *  Copyright (C) 1995-2005 Dell Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License v2.0 as published by
> + *  the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/io.h>
> +#include <asm/semaphore.h>
> +
> +#include "dcdbas.h"
> +
> +#define DRIVER_NAME		"dcdbas"
> +#define DRIVER_VERSION		"5.6.0-1"
> +#define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
> +
> +static struct platform_device *dcdbas_pdev;
> +
> +static u8 *smi_data_buf;
> +static dma_addr_t smi_data_buf_handle;
> +static unsigned long smi_data_buf_size;
> +static u32 smi_data_buf_phys_addr;
> +static DECLARE_MUTEX(smi_data_lock);
> +
> +static unsigned int host_control_action;
> +static unsigned int host_control_smi_type;
> +static unsigned int host_control_on_shutdown;
> +
> +/**
> + * smi_data_buf_free: free SMI data buffer
> + */
> +static void smi_data_buf_free(void)
> +{
> +	if (!smi_data_buf)
> +		return;
> +
> +	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
> +		__FUNCTION__, smi_data_buf_phys_addr, smi_data_buf_size);
> +
> +	dma_free_coherent(&dcdbas_pdev->dev, smi_data_buf_size, smi_data_buf,
> +			  smi_data_buf_handle);
> +	smi_data_buf = NULL;
> +	smi_data_buf_handle = 0;
> +	smi_data_buf_phys_addr = 0;
> +	smi_data_buf_size = 0;
> +}
> +
> +/**
> + * smi_data_buf_realloc: grow SMI data buffer if needed
> + */
> +static int smi_data_buf_realloc(unsigned long size)
> +{
> +	void *buf;
> +	dma_addr_t handle;
> +	int ret = 0;
> +
> +	if (size > MAX_SMI_DATA_BUF_SIZE)
> +		return -EINVAL;
> +
> +	down(&smi_data_lock);
> +
> +	/* check if current buffer is big enough */
> +	if (smi_data_buf_size >= size) {
> +		if (size && !smi_data_buf) {
> +			dev_dbg(&dcdbas_pdev->dev,
> +				"%s: corruption detected\n", __FUNCTION__);
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		/* current buffer is big enough */
> +		goto out;
> +	}
> +
> +	/* new buffer is needed */
> +	buf = dma_alloc_coherent(&dcdbas_pdev->dev, size, &handle, GFP_KERNEL);
> +	if (!buf) {
> +		dev_dbg(&dcdbas_pdev->dev,
> +			"%s: failed to allocate memory size %lu\n",
> +			__FUNCTION__, size);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	/* memory zeroed by dma_alloc_coherent */
> +
> +	/* free any existing buffer */
> +	smi_data_buf_free();
> +
> +	/* set up new buffer for use */
> +	smi_data_buf = buf;
> +	smi_data_buf_handle = handle;
> +	smi_data_buf_phys_addr = (u32) virt_to_phys(buf);
> +	smi_data_buf_size = size;
> +
> +	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
> +		__FUNCTION__, smi_data_buf_phys_addr, smi_data_buf_size);
> +out:
> +	up(&smi_data_lock);
> +	return ret;
> +}
> +
> +static ssize_t smi_data_buf_phys_addr_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%x\n", smi_data_buf_phys_addr);
> +}
> +
> +static ssize_t smi_data_buf_size_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return sprintf(buf, "%lu\n", smi_data_buf_size);
> +}
> +
> +static ssize_t smi_data_buf_size_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	unsigned long buf_size;
> +	ssize_t ret;
> +
> +	buf_size = simple_strtoul(buf, NULL, 10);
> +
> +	/* make sure SMI data buffer is at least buf_size */
> +	ret = smi_data_buf_realloc(buf_size);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t smi_data_read(struct kobject *kobj, char *buf, loff_t pos,
> +			     size_t count)
> +{
> +	size_t max_read;
> +	ssize_t ret;
> +
> +	down(&smi_data_lock);
> +
> +	if (pos >= smi_data_buf_size) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	max_read = smi_data_buf_size - pos;
> +	ret = min(max_read, count);
> +	memcpy(buf, smi_data_buf + pos, ret);
> +out:
> +	up(&smi_data_lock);
> +	return ret;
> +}
> +
> +static ssize_t smi_data_write(struct kobject *kobj, char *buf, loff_t pos,
> +			      size_t count)
> +{
> +	size_t max_write;
> +	ssize_t ret;
> +
> +	down(&smi_data_lock);
> +
> +	if (pos >= smi_data_buf_size) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	max_write = smi_data_buf_size - pos;
> +	ret = min(max_write, count);
> +	memcpy(smi_data_buf + pos, buf, ret);
> +out:
> +	up(&smi_data_lock);
> +	return ret;
> +}
> +
> +static ssize_t host_control_action_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return sprintf(buf, "%u\n", host_control_action);
> +}
> +
> +static ssize_t host_control_action_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	ssize_t ret;
> +
> +	/* make sure buffer is available for host control command */
> +	ret = smi_data_buf_realloc(sizeof(struct apm_cmd));
> +	if (ret)
> +		return ret;
> +
> +	host_control_action = simple_strtoul(buf, NULL, 10);
> +	return count;
> +}
> +
> +static ssize_t host_control_smi_type_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sprintf(buf, "%u\n", host_control_smi_type);
> +}
> +
> +static ssize_t host_control_smi_type_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	host_control_smi_type = simple_strtoul(buf, NULL, 10);
> +	return count;
> +}
> +
> +static ssize_t host_control_on_shutdown_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	return sprintf(buf, "%u\n", host_control_on_shutdown);
> +}
> +
> +static ssize_t host_control_on_shutdown_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	host_control_on_shutdown = simple_strtoul(buf, NULL, 10);
> +	return count;
> +}
> +
> +/**
> + * callintf_smi: generate calling interface SMI
> + */
> +static int callintf_smi(void)
> +{
> +	struct callintf_cmd *ci_cmd;
> +	cpumask_t old_mask;
> +	u32 command_buffer_phys_addr;
> +	int ret = 0;
> +
> +	/* SMI requires CPU 0 */
> +	old_mask = current->cpus_allowed;
> +	set_cpus_allowed(current, cpumask_of_cpu(0));
> +	if (smp_processor_id() != 0) {
> +		dev_dbg(&dcdbas_pdev->dev, "%s: failed to get CPU 0\n",
> +			__FUNCTION__);
> +		ret = -EBUSY;
> +		goto out1;
> +	}
> +
> +	down(&smi_data_lock);
> +
> +	if (smi_data_buf_size < sizeof(struct callintf_cmd)) {
> +		ret = -ENODEV;
> +		goto out2;
> +	}
> +
> +	ci_cmd = (struct callintf_cmd *)smi_data_buf;
> +	if (ci_cmd->magic != CALLINTF_CMD_MAGIC) {
> +		ret = -EBADR;
> +		goto out2;
> +	}
> +
> +	/*
> +	 * SMI requires command buffer physical address in ebx and
> +	 * command signature in ecx.
> +	 */
> +	command_buffer_phys_addr = (u32) virt_to_phys(ci_cmd->command_buffer);
> +
> +	/* generate SMI */
> +	__asm__ __volatile__(
> +		"outb %b0,%w1"
> +		: /* no output args */
> +		: "a" (ci_cmd->command_code), 
> +		  "d" (ci_cmd->command_address), 
> +		  "b" (command_buffer_phys_addr), 
> +		  "c" (ci_cmd->command_signature)  
> +		: "memory"
> +	);
> +
> +out2:
> +	up(&smi_data_lock);
> +out1:
> +	set_cpus_allowed(current, old_mask);
> +	return ret;
> +}
> +
> +/**
> + * callintf_smi_store:
> + * 
> + * The valid values are:
> + * 1: generate calling interface SMI
> + * 
> + * User application writes calling interface command to smi_data
> + * before telling driver to generate SMI.
> + */
> +static ssize_t callintf_smi_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	if (simple_strtoul(buf, NULL, 10) != 1)
> +		return -EINVAL;
> +
> +	ret = callintf_smi();
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * host_control_smi: generate host control SMI
> + *
> + * Caller must set up the host control command in smi_data_buf.
> + */
> +static int host_control_smi(void)
> +{
> +	struct apm_cmd *apm_cmd;
> +	u8 *data;
> +	unsigned long flags;
> +	u32 num_ticks;
> +	s8 cmd_status;
> +	u8 index;
> +
> +	apm_cmd = (struct apm_cmd *)smi_data_buf;
> +	apm_cmd->status = ESM_STATUS_CMD_UNSUCCESSFUL;
> +
> +	switch (host_control_smi_type) {
> +	case HC_SMITYPE_TYPE1:
> +		/* write SMI data buffer physical address */
> +		data = (u8 *)&smi_data_buf_phys_addr;
> +		spin_lock_irqsave(&rtc_lock, flags);
> +		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
> +		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
> +		     index++) {
> +			outb(index,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
> +			outb(*data++,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
> +		}
> +		spin_unlock_irqrestore(&rtc_lock, flags);
> +
> +		/* first set status to -1 as called by spec */
> +		cmd_status = ESM_STATUS_CMD_UNSUCCESSFUL;
> +		outb((u8) cmd_status, PCAT_APM_STATUS_PORT);
> +
> +		/* generate SMM call */
> +		outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
> +
> +		/* restore RTC index pointer */
> +		spin_lock_irqsave(&rtc_lock, flags);
> +		outb(0x0C, 0x70);
> +		inb(0x70);
> +		spin_unlock_irqrestore(&rtc_lock, flags);
> +
> +		/* wait a few to see if it executed */
> +		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
> +		while ((cmd_status = inb(PCAT_APM_STATUS_PORT))
> +		       == ESM_STATUS_CMD_UNSUCCESSFUL) {
> +			num_ticks--;
> +			if (num_ticks == EXPIRED_TIMER)
> +				return -ETIME;
> +		}
> +		break;
> +
> +	case HC_SMITYPE_TYPE2:
> +	case HC_SMITYPE_TYPE3:
> +		/* write SMI data buffer physical address */
> +		data = (u8 *)&smi_data_buf_phys_addr;
> +		spin_lock_irqsave(&rtc_lock, flags);
> +		for (index = PE1400_CMOS_CMD_STRUCT_PTR;
> +		     index < (PE1400_CMOS_CMD_STRUCT_PTR + 4);
> +		     index++) {
> +			outb(index, (CMOS_BASE_PORT + CMOS_PAGE1_INDEX_PORT));
> +			outb(*data++, (CMOS_BASE_PORT + CMOS_PAGE1_DATA_PORT));
> +		}
> +		spin_unlock_irqrestore(&rtc_lock, flags);
> +
> +		/* generate SMM call */
> +		if (host_control_smi_type == HC_SMITYPE_TYPE3)
> +			outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
> +		else
> +			outb(ESM_APM_CMD, PE1400_APM_CONTROL_PORT);
> +
> +		/* restore RTC index pointer */
> +		spin_lock_irqsave(&rtc_lock, flags);
> +		outb(0x0C, 0x70);
> +		inb(0x70);
> +		spin_unlock_irqrestore(&rtc_lock, flags);
> +
> +		/* read control port back to serialize write */
> +		cmd_status = inb(PE1400_APM_CONTROL_PORT);
> +
> +		/* wait a few to see if it executed */
> +		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
> +		while (apm_cmd->status == ESM_STATUS_CMD_UNSUCCESSFUL) {
> +			num_ticks--;
> +			if (num_ticks == EXPIRED_TIMER)
> +				return -ETIME;
> +		}
> +		break;
> +
> +	default:
> +		dev_dbg(&dcdbas_pdev->dev, "%s: invalid SMI type %u\n",
> +			__FUNCTION__, host_control_smi_type);
> +		return -ENOSYS;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * dcdbas_host_control: initiate host control
> + * 
> + * This function is called by the driver after the system has
> + * finished shutting down if the user application specified a
> + * host control action to perform on shutdown.  It is safe to
> + * use smi_data_buf at this point because the system has finished
> + * shutting down and no userspace apps are running.
> + */
> +static void dcdbas_host_control(void)
> +{
> +	struct apm_cmd *apm_cmd;
> +	u8 action;
> +
> +	if (host_control_action == HC_ACTION_NONE)
> +		return;
> +
> +	action = host_control_action;
> +	host_control_action = HC_ACTION_NONE;
> +
> +	if (!smi_data_buf) {
> +		dev_dbg(&dcdbas_pdev->dev, "%s: no SMI buffer\n", __FUNCTION__);
> +		return;
> +	}
> +
> +	if (smi_data_buf_size < sizeof(struct apm_cmd)) {
> +		dev_dbg(&dcdbas_pdev->dev, "%s: SMI buffer too small\n",
> +			__FUNCTION__);
> +		return;
> +	}
> +
> +	apm_cmd = (struct apm_cmd *)smi_data_buf;
> +
> +	/* power off takes precedence */
> +	if (action & HC_ACTION_HOST_CONTROL_POWEROFF) {
> +		apm_cmd->command = ESM_APM_POWER_CYCLE;
> +		apm_cmd->reserved = 0;
> +		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16) 0;
> +		host_control_smi();
> +	} else if (action & HC_ACTION_HOST_CONTROL_POWERCYCLE) {
> +		apm_cmd->command = ESM_APM_POWER_CYCLE;
> +		apm_cmd->reserved = 0;
> +		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16) 20;
> +		host_control_smi();
> +	}
> +}
> +
> +/**
> + * dcdbas_reboot_notify: handle reboot notification for host control
> + */
> +static int dcdbas_reboot_notify(struct notifier_block *nb, unsigned long code,
> +				void *unused)
> +{
> +	static unsigned int notify_cnt = 0;
> +
> +	switch (code) {
> +	case SYS_DOWN:
> +	case SYS_HALT:
> +	case SYS_POWER_OFF:
> +		if (host_control_on_shutdown) {
> +			/* firmware is going to perform host control action */
> +			if (++notify_cnt == 2) {
> +				printk(KERN_WARNING
> +				       "Please wait for shutdown "
> +				       "action to complete...\n");
> +				dcdbas_host_control();
> +			}
> +			/*
> +			 * register again and initiate the host control
> +			 * action on the second notification to allow
> +			 * everyone that registered to be notified
> +			 */
> +			register_reboot_notifier(nb);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block dcdbas_reboot_nb = {
> +	.notifier_call = dcdbas_reboot_notify,
> +	.next = NULL,
> +	.priority = 0
> +};
> +
> +static DCDBAS_BIN_ATTR_RW(smi_data);
> +
> +static struct bin_attribute *dcdbas_bin_attrs[] = {
> +	&bin_attr_smi_data,
> +	NULL
> +};
> +
> +static DCDBAS_DEV_ATTR_RW(smi_data_buf_size);
> +static DCDBAS_DEV_ATTR_RO(smi_data_buf_phys_addr);
> +static DCDBAS_DEV_ATTR_WO(callintf_smi);
> +static DCDBAS_DEV_ATTR_RW(host_control_action);
> +static DCDBAS_DEV_ATTR_RW(host_control_smi_type);
> +static DCDBAS_DEV_ATTR_RW(host_control_on_shutdown);
> +
> +static struct device_attribute *dcdbas_dev_attrs[] = {
> +	&dev_attr_smi_data_buf_size,
> +	&dev_attr_smi_data_buf_phys_addr,
> +	&dev_attr_callintf_smi,
> +	&dev_attr_host_control_action,
> +	&dev_attr_host_control_smi_type,
> +	&dev_attr_host_control_on_shutdown,
> +	NULL
> +};
> +
> +/**
> + * dcdbas_init: initialize driver
> + */
> +static int __init dcdbas_init(void)
> +{
> +	int i;
> +
> +	host_control_action = HC_ACTION_NONE;
> +	host_control_smi_type = HC_SMITYPE_NONE;
> +
> +	dcdbas_pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> +	if (IS_ERR(dcdbas_pdev))
> +		return PTR_ERR(dcdbas_pdev);
> +
> +	/*
> +	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
> +	 * This is done by setting the DMA mask below.
> +	 */
> +	dcdbas_pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
> +	dcdbas_pdev->dev.dma_mask = &dcdbas_pdev->dev.coherent_dma_mask;
> +
> +	register_reboot_notifier(&dcdbas_reboot_nb);
> +
> +	for (i = 0; dcdbas_bin_attrs[i]; i++)
> +		sysfs_create_bin_file(&dcdbas_pdev->dev.kobj,
> +				      dcdbas_bin_attrs[i]);
> +
> +	for (i = 0; dcdbas_dev_attrs[i]; i++)
> +		device_create_file(&dcdbas_pdev->dev, dcdbas_dev_attrs[i]);
> +
> +	dev_info(&dcdbas_pdev->dev, "%s (version %s)\n",
> +		 DRIVER_DESCRIPTION, DRIVER_VERSION);
> +
> +	return 0;
> +}
> +
> +/**
> + * dcdbas_exit: perform driver cleanup
> + */
> +static void __exit dcdbas_exit(void)
> +{
> +	platform_device_unregister(dcdbas_pdev);
> +	unregister_reboot_notifier(&dcdbas_reboot_nb);
> +	smi_data_buf_free();
> +}
> +
> +module_init(dcdbas_init);
> +module_exit(dcdbas_exit);
> +
> +MODULE_DESCRIPTION(DRIVER_DESCRIPTION " (version " DRIVER_VERSION ")");
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_AUTHOR("Dell Inc.");
> +MODULE_LICENSE("GPL");
> +
> diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.h linux-2.6.13-rc6/drivers/firmware/dcdbas.h
> --- linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.13-rc6/drivers/firmware/dcdbas.h	2005-08-15 14:07:35.000000000 -0500
> @@ -0,0 +1,106 @@
> +/*
> + *  dcdbas.h: Definitions for Dell Systems Management Base driver
> + *
> + *  Copyright (C) 1995-2005 Dell Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License v2.0 as published by
> + *  the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + */
> +
> +#ifndef _DCDBAS_H_
> +#define _DCDBAS_H_
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#define MAX_SMI_DATA_BUF_SIZE			(256 * 1024)
> +
> +#define HC_ACTION_NONE				(0)
> +#define HC_ACTION_HOST_CONTROL_POWEROFF		BIT(1)
> +#define HC_ACTION_HOST_CONTROL_POWERCYCLE	BIT(2)
> +
> +#define HC_SMITYPE_NONE				(0)
> +#define HC_SMITYPE_TYPE1			(1)
> +#define HC_SMITYPE_TYPE2			(2)
> +#define HC_SMITYPE_TYPE3			(3)
> +
> +#define ESM_APM_CMD				(0x0A0)
> +#define ESM_APM_POWER_CYCLE			(0x10)
> +#define ESM_STATUS_CMD_UNSUCCESSFUL		(-1)
> +
> +#define CMOS_BASE_PORT				(0x070)
> +#define CMOS_PAGE1_INDEX_PORT			(0)
> +#define CMOS_PAGE1_DATA_PORT			(1)
> +#define CMOS_PAGE2_INDEX_PORT_PIIX4		(2)
> +#define CMOS_PAGE2_DATA_PORT_PIIX4		(3)
> +#define PE1400_APM_CONTROL_PORT			(0x0B0)
> +#define PCAT_APM_CONTROL_PORT			(0x0B2)
> +#define PCAT_APM_STATUS_PORT			(0x0B3)
> +#define PE1300_CMOS_CMD_STRUCT_PTR		(0x38)
> +#define PE1400_CMOS_CMD_STRUCT_PTR		(0x70)
> +
> +#define MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN	(14)
> +#define MAX_SYSMGMT_LONGCMD_SGENTRY_NUM		(16)
> +
> +#define TIMEOUT_USEC_SHORT_SEMA_BLOCKING	(10000)
> +#define EXPIRED_TIMER				(0)
> +
> +#define CALLINTF_CMD_MAGIC			(0x43414C4C)
> +
> +#define DCDBAS_DEV_ATTR_RW(_name) \
> +	DEVICE_ATTR(_name,0644,_name##_show,_name##_store);
> +
> +#define DCDBAS_DEV_ATTR_RO(_name) \
> +	DEVICE_ATTR(_name,0444,_name##_show,NULL);

Why let all users read this data?

> +
> +#define DCDBAS_DEV_ATTR_WO(_name) \
> +	DEVICE_ATTR(_name,0200,NULL,_name##_store);
> +
> +#define DCDBAS_BIN_ATTR_RW(_name) \
> +struct bin_attribute bin_attr_##_name = { \
> +	.attr =  { .name = __stringify(_name), \
> +		   .mode = 0644, \

Why let everyone read this data?

> +		   .owner = THIS_MODULE }, \
> +	.read =  _name##_read, \
> +	.write = _name##_write, \
> +}
> +
> +struct callintf_cmd {
> +	u32 magic;

Why even have this?  Does it really stop anything except random
scribblings?

> +	u16 command_address;
> +	u8 command_code;
> +	u8 reserved;
> +	u32 command_signature;
> +	u8 command_buffer[1];
> +} __attribute__ ((packed));

As these cross the userspace/kernelspace boundry, please use the __u32,
__u16, and __u8 variable types.

> +struct apm_cmd {
> +	u8 command;
> +	s8 status;
> +	u16 reserved;
> +	union {
> +		struct {
> +			u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
> +		} __attribute__ ((packed)) shortreq;
> +
> +		struct {
> +			u16 num_sg_entries;
> +			struct {
> +				u32 size;
> +				u64 addr;
> +			} __attribute__ ((packed))
> +			    sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
> +		} __attribute__ ((packed)) longreq;
> +	} __attribute__ ((packed)) parameters;
> +} __attribute__ ((packed));

Same here (I think...)

thanks,

greg k-h
