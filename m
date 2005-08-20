Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVHTWfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVHTWfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVHTWfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 18:35:41 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:25499 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1750708AbVHTWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 18:35:40 -0400
X-IronPort-AV: i="3.96,128,1122872400"; 
   d="scan'208"; a="301374684:sNHT34194216"
Date: Sat, 20 Aug 2005 17:50:52 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: greg@kroah.com, michael_e_brown@dell.com, matt_domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base Driver with sysfs support
Message-ID: <20050820225052.GA5042@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Dell Systems Management Base Driver with sysfs support.

This patch incorporates changes based on comments from the previous posting.

Summary of changes:

* Changed permissions on sysfs files so that only owner can read.
* Changed to use __uNN/__sNN types in structs.
* smi_data_write will grow smi_data_buf if needed.
* Renamed struct callintf_cmd to struct smi_cmd.
* Renamed callintf_smi to smi_request.
* Added 2 more supported values that were requested in smi_request_store.
* Hold rtc_lock across SMI in host_control_smi.

Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
---

diff -uprN linux-2.6.13-rc6.orig/Documentation/dcdbas.txt linux-2.6.13-rc6/Documentation/dcdbas.txt
--- linux-2.6.13-rc6.orig/Documentation/dcdbas.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc6/Documentation/dcdbas.txt	2005-08-19 18:45:37.000000000 -0500
@@ -0,0 +1,87 @@
+Overview
+
+The Dell Systems Management Base Driver provides a sysfs interface for
+systems management software such as Dell OpenManage to perform system
+management interrupts and host control actions (system power cycle or
+power off after OS shutdown) on certain Dell systems.
+
+Dell OpenManage requires this driver on the following Dell PowerEdge systems:
+300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC, 650, 1655MC,
+700, and 750.  Other Dell software such as the open source Libsmbios library
+is expected to make use of this driver, and it may include the use of this
+driver on other Dell systems.
+
+
+System Management Interrupt
+
+On some Dell systems, systems management software must access certain
+management information via a system management interrupt (SMI).  The SMI data
+buffer must reside in 32-bit address space, and the physical address of the
+buffer is required for the SMI.  The driver maintains the memory required for
+the SMI and provides a way for the application to generate the SMI.
+The driver creates the following sysfs entries for systems management
+software to perform these system management interrupts:
+
+/sys/devices/platform/dcdbas/smi_data
+/sys/devices/platform/dcdbas/smi_data_buf_phys_addr
+/sys/devices/platform/dcdbas/smi_data_buf_size
+/sys/devices/platform/dcdbas/smi_request
+
+Systems management software must perform the following steps to execute
+a SMI using this driver:
+
+1) Lock smi_data.
+2) Write system management command to smi_data.
+3) Write "1" to smi_request to generate a calling interface SMI or
+   "2" to generate a raw SMI.
+4) Read system management command response from smi_data.
+5) Unlock smi_data.
+
+
+Host Control Action
+
+Dell OpenManage supports a host control feature that allows the administrator
+to perform a power cycle or power off of the system after the OS has finished
+shutting down.  On some Dell systems, this host control feature requires that
+a driver perform a SMI after the OS has finished shutting down.
+
+The driver creates the following sysfs entries for systems management software
+to schedule the driver to perform a power cycle or power off host control
+action after the system has finished shutting down:
+
+/sys/devices/platform/dcdbas/host_control_action
+/sys/devices/platform/dcdbas/host_control_smi_type
+/sys/devices/platform/dcdbas/host_control_on_shutdown
+
+Dell OpenManage performs the following steps to execute a power cycle or
+power off host control action using this driver:
+
+1) Write host control action to be performed to host_control_action.
+2) Write type of SMI that driver needs to perform to host_control_smi_type.
+3) Write "1" to host_control_on_shutdown to enable host control action.
+4) Initiate OS shutdown.
+   (Driver will perform host control SMI when it is notified that the OS
+   has finished shutting down.)
+
+
+Host Control SMI Type
+
+The following table shows the value to write to host_control_smi_type to
+perform a power cycle or power off host control action:
+
+PowerEdge System    Host Control SMI Type
+----------------    ---------------------
+      300             HC_SMITYPE_TYPE1
+     1300             HC_SMITYPE_TYPE1
+     1400             HC_SMITYPE_TYPE2
+      500SC           HC_SMITYPE_TYPE2
+     1500SC           HC_SMITYPE_TYPE2
+     1550             HC_SMITYPE_TYPE2
+      600SC           HC_SMITYPE_TYPE2
+     1600SC           HC_SMITYPE_TYPE2
+      650             HC_SMITYPE_TYPE2
+     1655MC           HC_SMITYPE_TYPE2
+      700             HC_SMITYPE_TYPE3
+      750             HC_SMITYPE_TYPE3
+
+
diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c linux-2.6.13-rc6/drivers/firmware/dcdbas.c
--- linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc6/drivers/firmware/dcdbas.c	2005-08-19 19:07:50.823719952 -0500
@@ -0,0 +1,593 @@
+/*
+ *  dcdbas.c: Dell Systems Management Base Driver
+ *
+ *  The Dell Systems Management Base Driver provides a sysfs interface for
+ *  systems management software to perform System Management Interrupts (SMIs)
+ *  and Host Control Actions (power cycle or power off after OS shutdown) on
+ *  Dell systems.
+ *
+ *  See Documentation/dcdbas.txt for more information.
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
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mc146818rtc.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+
+#include "dcdbas.h"
+
+#define DRIVER_NAME		"dcdbas"
+#define DRIVER_VERSION		"5.6.0-1"
+#define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
+
+static struct platform_device *dcdbas_pdev;
+
+static u8 *smi_data_buf;
+static dma_addr_t smi_data_buf_handle;
+static unsigned long smi_data_buf_size;
+static u32 smi_data_buf_phys_addr;
+static DECLARE_MUTEX(smi_data_lock);
+
+static unsigned int host_control_action;
+static unsigned int host_control_smi_type;
+static unsigned int host_control_on_shutdown;
+
+/**
+ * smi_data_buf_free: free SMI data buffer
+ */
+static void smi_data_buf_free(void)
+{
+	if (!smi_data_buf)
+		return;
+
+	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
+		__FUNCTION__, smi_data_buf_phys_addr, smi_data_buf_size);
+
+	dma_free_coherent(&dcdbas_pdev->dev, smi_data_buf_size, smi_data_buf,
+			  smi_data_buf_handle);
+	smi_data_buf = NULL;
+	smi_data_buf_handle = 0;
+	smi_data_buf_phys_addr = 0;
+	smi_data_buf_size = 0;
+}
+
+/**
+ * smi_data_buf_realloc: grow SMI data buffer if needed
+ */
+static int smi_data_buf_realloc(unsigned long size)
+{
+	void *buf;
+	dma_addr_t handle;
+
+	if (smi_data_buf_size >= size)
+		return 0;
+
+	if (size > MAX_SMI_DATA_BUF_SIZE)
+		return -EINVAL;
+
+	/* new buffer is needed */
+	buf = dma_alloc_coherent(&dcdbas_pdev->dev, size, &handle, GFP_KERNEL);
+	if (!buf) {
+		dev_dbg(&dcdbas_pdev->dev,
+			"%s: failed to allocate memory size %lu\n",
+			__FUNCTION__, size);
+		return -ENOMEM;
+	}
+	/* memory zeroed by dma_alloc_coherent */
+
+	if (smi_data_buf)
+		memcpy(buf, smi_data_buf, smi_data_buf_size);
+
+	/* free any existing buffer */
+	smi_data_buf_free();
+
+	/* set up new buffer for use */
+	smi_data_buf = buf;
+	smi_data_buf_handle = handle;
+	smi_data_buf_phys_addr = (u32) virt_to_phys(buf);
+	smi_data_buf_size = size;
+
+	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
+		__FUNCTION__, smi_data_buf_phys_addr, smi_data_buf_size);
+
+	return 0;
+}
+
+static ssize_t smi_data_buf_phys_addr_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "%x\n", smi_data_buf_phys_addr);
+}
+
+static ssize_t smi_data_buf_size_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return sprintf(buf, "%lu\n", smi_data_buf_size);
+}
+
+static ssize_t smi_data_buf_size_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	unsigned long buf_size;
+	ssize_t ret;
+
+	buf_size = simple_strtoul(buf, NULL, 10);
+
+	/* make sure SMI data buffer is at least buf_size */
+	down(&smi_data_lock);
+	ret = smi_data_buf_realloc(buf_size);
+	up(&smi_data_lock);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t smi_data_read(struct kobject *kobj, char *buf, loff_t pos,
+			     size_t count)
+{
+	size_t max_read;
+	ssize_t ret;
+
+	down(&smi_data_lock);
+
+	if (pos >= smi_data_buf_size) {
+		ret = 0;
+		goto out;
+	}
+
+	max_read = smi_data_buf_size - pos;
+	ret = min(max_read, count);
+	memcpy(buf, smi_data_buf + pos, ret);
+out:
+	up(&smi_data_lock);
+	return ret;
+}
+
+static ssize_t smi_data_write(struct kobject *kobj, char *buf, loff_t pos,
+			      size_t count)
+{
+	ssize_t ret;
+
+	down(&smi_data_lock);
+
+	ret = smi_data_buf_realloc(pos + count);
+	if (ret)
+		goto out;
+
+	memcpy(smi_data_buf + pos, buf, count);
+	ret = count;
+out:
+	up(&smi_data_lock);
+	return ret;
+}
+
+static ssize_t host_control_action_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "%u\n", host_control_action);
+}
+
+static ssize_t host_control_action_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	/* make sure buffer is available for host control command */
+	down(&smi_data_lock);
+	ret = smi_data_buf_realloc(sizeof(struct apm_cmd));
+	up(&smi_data_lock);
+	if (ret)
+		return ret;
+
+	host_control_action = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+
+static ssize_t host_control_smi_type_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%u\n", host_control_smi_type);
+}
+
+static ssize_t host_control_smi_type_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	host_control_smi_type = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+
+static ssize_t host_control_on_shutdown_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	return sprintf(buf, "%u\n", host_control_on_shutdown);
+}
+
+static ssize_t host_control_on_shutdown_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	host_control_on_shutdown = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+
+/**
+ * smi_request: generate SMI request
+ * 
+ * Called with smi_data_lock.
+ */
+static int smi_request(struct smi_cmd *smi_cmd)
+{
+	cpumask_t old_mask;
+	int ret = 0;
+
+	if (smi_cmd->magic != SMI_CMD_MAGIC)
+		return -EBADR;
+
+	/* SMI requires CPU 0 */
+	old_mask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	if (smp_processor_id() != 0) {
+		dev_dbg(&dcdbas_pdev->dev, "%s: failed to get CPU 0\n",
+			__FUNCTION__);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* generate SMI */
+	asm volatile (
+		"outb %b0,%w1"
+		: /* no output args */
+		: "a" (smi_cmd->command_code), 
+		  "d" (smi_cmd->command_address), 
+		  "b" (smi_cmd->ebx), 
+		  "c" (smi_cmd->ecx)  
+		: "memory"
+	);
+
+out:
+	set_cpus_allowed(current, old_mask);
+	return ret;
+}
+
+/**
+ * smi_request_store:
+ * 
+ * The valid values are:
+ * 0: zero SMI data buffer
+ * 1: generate calling interface SMI
+ * 2: generate raw SMI
+ * 
+ * User application writes smi_cmd to smi_data before telling driver
+ * to generate SMI.
+ */
+static ssize_t smi_request_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct smi_cmd *smi_cmd;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	ssize_t ret;
+
+	down(&smi_data_lock);
+
+	if (smi_data_buf_size < sizeof(struct smi_cmd)) {
+		ret = -ENODEV;
+		goto out;
+	}
+	smi_cmd = (struct smi_cmd *)smi_data_buf;
+
+	switch (val) {
+	case 2:
+		/* Raw SMI */
+		ret = smi_request(smi_cmd);
+		if (!ret)
+			ret = count;
+		break;
+	case 1:
+		/* Calling Interface SMI */
+		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
+		ret = smi_request(smi_cmd);
+		if (!ret)
+			ret = count;
+		break;
+	case 0:
+		memset(smi_data_buf, 0, smi_data_buf_size);
+		ret = count;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out:
+	up(&smi_data_lock);
+	return ret;
+}
+
+/**
+ * host_control_smi: generate host control SMI
+ *
+ * Caller must set up the host control command in smi_data_buf.
+ */
+static int host_control_smi(void)
+{
+	struct apm_cmd *apm_cmd;
+	u8 *data;
+	unsigned long flags;
+	u32 num_ticks;
+	s8 cmd_status;
+	u8 index;
+
+	apm_cmd = (struct apm_cmd *)smi_data_buf;
+	apm_cmd->status = ESM_STATUS_CMD_UNSUCCESSFUL;
+
+	switch (host_control_smi_type) {
+	case HC_SMITYPE_TYPE1:
+		spin_lock_irqsave(&rtc_lock, flags);
+		/* write SMI data buffer physical address */
+		data = (u8 *)&smi_data_buf_phys_addr;
+		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
+		     index++, data++) {
+			outb(index,
+			     (CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
+			outb(*data,
+			     (CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
+		}
+
+		/* first set status to -1 as called by spec */
+		cmd_status = ESM_STATUS_CMD_UNSUCCESSFUL;
+		outb((u8) cmd_status, PCAT_APM_STATUS_PORT);
+
+		/* generate SMM call */
+		outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+		spin_unlock_irqrestore(&rtc_lock, flags);
+
+		/* wait a few to see if it executed */
+		num_ticks = TIMEOUT_USEC_SHORT_SEMA_BLOCKING;
+		while ((cmd_status = inb(PCAT_APM_STATUS_PORT))
+		       == ESM_STATUS_CMD_UNSUCCESSFUL) {
+			num_ticks--;
+			if (num_ticks == EXPIRED_TIMER)
+				return -ETIME;
+		}
+		break;
+
+	case HC_SMITYPE_TYPE2:
+	case HC_SMITYPE_TYPE3:
+		spin_lock_irqsave(&rtc_lock, flags);
+		/* write SMI data buffer physical address */
+		data = (u8 *)&smi_data_buf_phys_addr;
+		for (index = PE1400_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1400_CMOS_CMD_STRUCT_PTR + 4);
+		     index++, data++) {
+			outb(index, (CMOS_BASE_PORT + CMOS_PAGE1_INDEX_PORT));
+			outb(*data, (CMOS_BASE_PORT + CMOS_PAGE1_DATA_PORT));
+		}
+
+		/* generate SMM call */
+		if (host_control_smi_type == HC_SMITYPE_TYPE3)
+			outb(ESM_APM_CMD, PCAT_APM_CONTROL_PORT);
+		else
+			outb(ESM_APM_CMD, PE1400_APM_CONTROL_PORT);
+
+		/* restore RTC index pointer since it was written to above */
+		CMOS_READ(RTC_REG_C);
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
+				return -ETIME;
+		}
+		break;
+
+	default:
+		dev_dbg(&dcdbas_pdev->dev, "%s: invalid SMI type %u\n",
+			__FUNCTION__, host_control_smi_type);
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+/**
+ * dcdbas_host_control: initiate host control
+ * 
+ * This function is called by the driver after the system has
+ * finished shutting down if the user application specified a
+ * host control action to perform on shutdown.  It is safe to
+ * use smi_data_buf at this point because the system has finished
+ * shutting down and no userspace apps are running.
+ */
+static void dcdbas_host_control(void)
+{
+	struct apm_cmd *apm_cmd;
+	u8 action;
+
+	if (host_control_action == HC_ACTION_NONE)
+		return;
+
+	action = host_control_action;
+	host_control_action = HC_ACTION_NONE;
+
+	if (!smi_data_buf) {
+		dev_dbg(&dcdbas_pdev->dev, "%s: no SMI buffer\n", __FUNCTION__);
+		return;
+	}
+
+	if (smi_data_buf_size < sizeof(struct apm_cmd)) {
+		dev_dbg(&dcdbas_pdev->dev, "%s: SMI buffer too small\n",
+			__FUNCTION__);
+		return;
+	}
+
+	apm_cmd = (struct apm_cmd *)smi_data_buf;
+
+	/* power off takes precedence */
+	if (action & HC_ACTION_HOST_CONTROL_POWEROFF) {
+		apm_cmd->command = ESM_APM_POWER_CYCLE;
+		apm_cmd->reserved = 0;
+		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16) 0;
+		host_control_smi();
+	} else if (action & HC_ACTION_HOST_CONTROL_POWERCYCLE) {
+		apm_cmd->command = ESM_APM_POWER_CYCLE;
+		apm_cmd->reserved = 0;
+		*((s16 *)&apm_cmd->parameters.shortreq.parm[0]) = (s16) 20;
+		host_control_smi();
+	}
+}
+
+/**
+ * dcdbas_reboot_notify: handle reboot notification for host control
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
+		if (host_control_on_shutdown) {
+			/* firmware is going to perform host control action */
+			if (++notify_cnt == 2) {
+				printk(KERN_WARNING
+				       "Please wait for shutdown "
+				       "action to complete...\n");
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
+static struct notifier_block dcdbas_reboot_nb = {
+	.notifier_call = dcdbas_reboot_notify,
+	.next = NULL,
+	.priority = 0
+};
+
+static DCDBAS_BIN_ATTR_RW(smi_data);
+
+static struct bin_attribute *dcdbas_bin_attrs[] = {
+	&bin_attr_smi_data,
+	NULL
+};
+
+static DCDBAS_DEV_ATTR_RW(smi_data_buf_size);
+static DCDBAS_DEV_ATTR_RO(smi_data_buf_phys_addr);
+static DCDBAS_DEV_ATTR_WO(smi_request);
+static DCDBAS_DEV_ATTR_RW(host_control_action);
+static DCDBAS_DEV_ATTR_RW(host_control_smi_type);
+static DCDBAS_DEV_ATTR_RW(host_control_on_shutdown);
+
+static struct device_attribute *dcdbas_dev_attrs[] = {
+	&dev_attr_smi_data_buf_size,
+	&dev_attr_smi_data_buf_phys_addr,
+	&dev_attr_smi_request,
+	&dev_attr_host_control_action,
+	&dev_attr_host_control_smi_type,
+	&dev_attr_host_control_on_shutdown,
+	NULL
+};
+
+/**
+ * dcdbas_init: initialize driver
+ */
+static int __init dcdbas_init(void)
+{
+	int i;
+
+	host_control_action = HC_ACTION_NONE;
+	host_control_smi_type = HC_SMITYPE_NONE;
+
+	dcdbas_pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(dcdbas_pdev))
+		return PTR_ERR(dcdbas_pdev);
+
+	/*
+	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
+	 * This is done by setting the DMA mask below.
+	 */
+	dcdbas_pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
+	dcdbas_pdev->dev.dma_mask = &dcdbas_pdev->dev.coherent_dma_mask;
+
+	register_reboot_notifier(&dcdbas_reboot_nb);
+
+	for (i = 0; dcdbas_bin_attrs[i]; i++)
+		sysfs_create_bin_file(&dcdbas_pdev->dev.kobj,
+				      dcdbas_bin_attrs[i]);
+
+	for (i = 0; dcdbas_dev_attrs[i]; i++)
+		device_create_file(&dcdbas_pdev->dev, dcdbas_dev_attrs[i]);
+
+	dev_info(&dcdbas_pdev->dev, "%s (version %s)\n",
+		 DRIVER_DESCRIPTION, DRIVER_VERSION);
+
+	return 0;
+}
+
+/**
+ * dcdbas_exit: perform driver cleanup
+ */
+static void __exit dcdbas_exit(void)
+{
+	platform_device_unregister(dcdbas_pdev);
+	unregister_reboot_notifier(&dcdbas_reboot_nb);
+	smi_data_buf_free();
+}
+
+module_init(dcdbas_init);
+module_exit(dcdbas_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION " (version " DRIVER_VERSION ")");
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_AUTHOR("Dell Inc.");
+MODULE_LICENSE("GPL");
+
diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.h linux-2.6.13-rc6/drivers/firmware/dcdbas.h
--- linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc6/drivers/firmware/dcdbas.h	2005-08-19 18:45:52.000000000 -0500
@@ -0,0 +1,107 @@
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
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define MAX_SMI_DATA_BUF_SIZE			(256 * 1024)
+
+#define HC_ACTION_NONE				(0)
+#define HC_ACTION_HOST_CONTROL_POWEROFF		BIT(1)
+#define HC_ACTION_HOST_CONTROL_POWERCYCLE	BIT(2)
+
+#define HC_SMITYPE_NONE				(0)
+#define HC_SMITYPE_TYPE1			(1)
+#define HC_SMITYPE_TYPE2			(2)
+#define HC_SMITYPE_TYPE3			(3)
+
+#define ESM_APM_CMD				(0x0A0)
+#define ESM_APM_POWER_CYCLE			(0x10)
+#define ESM_STATUS_CMD_UNSUCCESSFUL		(-1)
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
+#define SMI_CMD_MAGIC				(0x534D4931)
+
+#define DCDBAS_DEV_ATTR_RW(_name) \
+	DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
+
+#define DCDBAS_DEV_ATTR_RO(_name) \
+	DEVICE_ATTR(_name,0400,_name##_show,NULL);
+
+#define DCDBAS_DEV_ATTR_WO(_name) \
+	DEVICE_ATTR(_name,0200,NULL,_name##_store);
+
+#define DCDBAS_BIN_ATTR_RW(_name) \
+struct bin_attribute bin_attr_##_name = { \
+	.attr =  { .name = __stringify(_name), \
+		   .mode = 0600, \
+		   .owner = THIS_MODULE }, \
+	.read =  _name##_read, \
+	.write = _name##_write, \
+}
+
+struct smi_cmd {
+	__u32 magic;
+	__u32 ebx;
+	__u32 ecx;
+	__u16 command_address;
+	__u8 command_code;
+	__u8 reserved;
+	__u8 command_buffer[1];
+} __attribute__ ((packed));
+
+struct apm_cmd {
+	__u8 command;
+	__s8 status;
+	__u16 reserved;
+	union {
+		struct {
+			__u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
+		} __attribute__ ((packed)) shortreq;
+
+		struct {
+			__u16 num_sg_entries;
+			struct {
+				__u32 size;
+				__u64 addr;
+			} __attribute__ ((packed))
+			    sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
+		} __attribute__ ((packed)) longreq;
+	} __attribute__ ((packed)) parameters;
+} __attribute__ ((packed));
+
+#endif /* _DCDBAS_H_ */
+
diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/Kconfig linux-2.6.13-rc6/drivers/firmware/Kconfig
--- linux-2.6.13-rc6.orig/drivers/firmware/Kconfig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.13-rc6/drivers/firmware/Kconfig	2005-08-19 18:45:56.000000000 -0500
@@ -58,4 +58,21 @@ config EFI_PCDP
 
 	  See <http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf>
 
+config DCDBAS
+	tristate "Dell Systems Management Base Driver"
+	depends on X86 || X86_64
+	default m
+	help
+	  The Dell Systems Management Base Driver provides a sysfs interface
+	  for systems management software to perform System Management
+	  Interrupts (SMIs) and Host Control Actions (system power cycle or
+	  power off after OS shutdown) on certain Dell systems.
+
+	  See <file:Documentation/dcdbas.txt> for more details on the driver
+	  and the Dell systems on which Dell systems management software makes
+	  use of this driver.
+
+	  Say Y or M here to enable the driver for use by Dell systems
+	  management software such as Dell OpenManage.
+
 endmenu
diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/Makefile linux-2.6.13-rc6/drivers/firmware/Makefile
--- linux-2.6.13-rc6.orig/drivers/firmware/Makefile	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.13-rc6/drivers/firmware/Makefile	2005-08-19 18:46:00.000000000 -0500
@@ -4,3 +4,4 @@
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
+obj-$(CONFIG_DCDBAS)		+= dcdbas.o
diff -uprN linux-2.6.13-rc6.orig/MAINTAINERS linux-2.6.13-rc6/MAINTAINERS
--- linux-2.6.13-rc6.orig/MAINTAINERS	2005-08-15 11:19:05.000000000 -0500
+++ linux-2.6.13-rc6/MAINTAINERS	2005-08-19 18:45:29.975559856 -0500
@@ -696,6 +696,11 @@ M:	dz@debian.org
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
