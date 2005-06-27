Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVF0DLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVF0DLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVF0DLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:11:34 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:38356 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261753AbVF0DLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:11:01 -0400
Date: Sun, 26 Jun 2005 20:10:55 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: linux-kernel@vger.kernel.org, douglas_warzecha@dell.com,
       abhay_salunke@dell.com, matt_domsch@dell.com
Subject: Re: [PATCH][RFC 2] char: Add Dell Systems Management Base driver
Message-Id: <20050626201055.092c9f5d.rdunlap@xenotime.net>
In-Reply-To: <20050626230544.GA6121@sysman-doug.us.dell.com>
References: <20050626230544.GA6121@sysman-doug.us.dell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 18:05:44 -0500 Doug Warzecha wrote:

| diff -uprN linux-2.6.12-rc6.orig/drivers/char/dcdbas.c linux-2.6.12-rc6/drivers/char/dcdbas.c
| --- linux-2.6.12-rc6.orig/drivers/char/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
| +++ linux-2.6.12-rc6/drivers/char/dcdbas.c	2005-06-26 17:48:57.239013248 -0500
| @@ -0,0 +1,686 @@
| +
| +#define DRIVER_NAME		"dcdbas"
| +#define DRIVER_VERSION		"5.6.0-1"
| +#define DRIVER_DESCRIPTION	"Systems Management Base Driver"
| +
| +static int driver_major;
| +static atomic_t hold_on_shutdown;

Why does hold_on_shutdown need to be atomic_t?

| +/**
| + * dcdbas_dispatch_ioctl - dispatch IOCTL request
| + * @ireq: IOCTL request
| + */
| +static int dcdbas_dispatch_ioctl(struct dcdbas_ioctl_req *ireq)
| +{
| +	int retval = 0;

Is it OK that lots of these don't alter retval for their return
status?

| +	pr_debug("%s: req_type: %u\n", __FUNCTION__, ireq->hdr.req_type);
| +
| +	switch (ireq->hdr.req_type) {
| +	case ESM_TVM_READ_MEM:
| +		if (down_interruptible(&tvm_lock))
| +			return -ERESTARTSYS;
| +		ireq->hdr.status = tvm_read_dma_buf(&ireq->data.tvm_mem_read);
| +		up(&tvm_lock);
| +		break;
| +
| +	case ESM_TVM_WRITE_MEM:
| +		if (down_interruptible(&tvm_lock))
| +			return -ERESTARTSYS;
| +		ireq->hdr.status = tvm_write_dma_buf(&ireq->data.tvm_mem_write);
| +		up(&tvm_lock);
| +		break;
| +
| +	case ESM_TVM_ALLOC_MEM:
| +		if (down_interruptible(&tvm_lock))
| +			return -ERESTARTSYS;
| +		ireq->hdr.status = tvm_alloc_dma_buf(&ireq->data.tvm_mem_alloc);
| +		up(&tvm_lock);
| +		break;
| +
| +	case ESM_TVM_HC_ACTION:
| +		if (down_interruptible(&tvm_lock))
| +			return -ERESTARTSYS;
| +		ireq->hdr.status = tvm_set_hc_action(&ireq->data.tvm_hc_action);
| +		up(&tvm_lock);
| +		break;
| +
| +	case ESM_CALLINTF_REQ:
| +		retval = callintf_generate_smi(ireq);
| +		break;
| +
| +	case ESM_HOLD_OS_ON_SHUTDOWN:
| +		/* firmware is going to perform host control action */
| +		atomic_set(&hold_on_shutdown, 1);
| +		ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
| +		break;
| +
| +	case ESM_CANCEL_HOLD_OS_ON_SHUTDOWN:
| +		atomic_set(&hold_on_shutdown, 0);
| +		ireq->hdr.status = ESM_STATUS_CMD_SUCCESS;
| +		break;
| +
| +	default:
| +		pr_debug("%s: unsupported req_type\n", __FUNCTION__);
| +		ireq->hdr.status = ESM_STATUS_CMD_NOT_IMPLEMENTED;
| +		break;
| +	}
| +
| +	return retval;
| +}
| +
| +/**
| + * dcdbas_do_ioctl - process ioctl request
| + * @filp: file object for device
| + * @cmd: IOCTL command
| + * @arg: IOCTL request data
| + */
| +static int dcdbas_do_ioctl(struct file *filp, unsigned int cmd,
| +			   unsigned long arg)
| +{
| +	struct dcdbas_ioctl_req *ubuf = (struct dcdbas_ioctl_req *)arg;

Add __user annotations?
and check them with sparse.

| +	struct dcdbas_ioctl_req *kbuf = NULL;
| +	struct dcdbas_ioctl_hdr hdr;
| +	unsigned long size;
| +	int ret;
| +}

| +/**
| + * dcdbas_reboot_notify - handle reboot notification
| + * @nb: info about registered reboot notifier
| + * @code: notification code
| + * @unused: unused argument
| + */
| +static int dcdbas_reboot_notify(struct notifier_block *nb, unsigned long code,
| +				void *unused)
| +{
| +	static unsigned int notify_cnt = 0;
| +
| +	switch (code) {
| +	case SYS_DOWN:
| +	case SYS_HALT:
| +	case SYS_POWER_OFF:
| +		if (atomic_read(&hold_on_shutdown)) {
| +			/* firmware is going to perform host control action */
| +			if (++notify_cnt == 2) {
| +				printk(KERN_WARNING
| +					"Please wait for shutdown "
| +					"action to complete...\n");
| +				dcdbas_host_control();
| +			}
| +			register_reboot_notifier(nb);

Why call register_reboot_notifier() again?

| +		}
| +		break;
| +	}
| +
| +	return NOTIFY_DONE;
| +}

| diff -uprN linux-2.6.12-rc6.orig/drivers/char/dcdbas.h linux-2.6.12-rc6/drivers/char/dcdbas.h
| --- linux-2.6.12-rc6.orig/drivers/char/dcdbas.h	1969-12-31 18:00:00.000000000 -0600
| +++ linux-2.6.12-rc6/drivers/char/dcdbas.h	2005-06-26 15:06:08.000000000 -0500
| @@ -0,0 +1,161 @@
| +/*
| + * IOCTL status values
| + */
| +#define ESM_STATUS_CMD_UNSUCCESSFUL		(-1)
| +#define ESM_STATUS_CMD_SUCCESS			(0)
| +#define ESM_STATUS_CMD_NOT_IMPLEMENTED		(1)
| +#define ESM_STATUS_CMD_BAD			(2)
| +#define ESM_STATUS_CMD_TIMEOUT			(3)
| +#define ESM_STATUS_CMD_NO_SUCH_DEVICE		(7)
| +#define ESM_STATUS_CMD_DEVICE_BAD		(9)

Why is CMD_UNSUCCESSFUL the only IOCTL status value that is negative?
IOW, could all of them except for CMD_SUCCESS be negative?

---
~Randy
