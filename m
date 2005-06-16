Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVFPVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVFPVOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:14:42 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:54696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261845AbVFPVOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:14:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pNKOx8NwUpiYKTsDzh/g0mj36u8AuRVs/+aBtUZq0KHE3s8+VOVCKdtMhq8dNtvdSQGDzJ2RlV0bZCZD1hpTHtexsCH5MSS9zKOxLinAR8rBPr5EEDxTe97RjHtL5yqqxNQoFEdBqyWgWGwtNAhhtuhn4DCTZAAF3fzwf9WwHTI=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Subject: Re: [PATCH 2.6.12-rc6] char: Add Dell Systems Management Base driver
Date: Fri, 17 Jun 2005 01:20:06 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, abhay_salunke@dell.com,
       matt_domsch@dell.com
References: <20050616173024.GA2596@sysman-doug.us.dell.com>
In-Reply-To: <20050616173024.GA2596@sysman-doug.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506170120.06818.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 21:30, Doug Warzecha wrote:

> The Dell Systems Management Base driver is a character driver that
> provides support needed by Dell systems management software to manage
> certain Dell systems.  The driver implements ioctls for Dell systems
> management software to use to communicate with the driver.

> --- linux-2.6.12-rc6.orig/drivers/char/dcdbas.c
> +++ linux-2.6.12-rc6/drivers/char/dcdbas.c

> +static void tvm_free_suitable(void *ptr)
> +{
> +	kfree(ptr);
> +}

Just call kfree directly.

> +static struct file_operations dcdbas_fops = {
> +	owner:	THIS_MODULE,
> +	ioctl:	dcdbas_ioctl,
> +};

Use C99 initializers.

	.owner = ...
	.ioctl = ...

> +static struct notifier_block dcdbas_reboot_nb = {
> +	dcdbas_reboot_notify,
> +	NULL,
> +	0
> +};

Here too.

> --- linux-2.6.12-rc6.orig/drivers/char/dcdbas.h
> +++ linux-2.6.12-rc6/drivers/char/dcdbas.h

> +#define ESM_HOLD_OS_ON_SHUTDOWN			(41)
> +#define ESM_CANCEL_HOLD_OS_ON_SHUTDOWN		(42)
> +#define ESM_TVM_HC_ACTION			(43)
> +#define ESM_TVM_ALLOC_MEM			(44)
> +#define ESM_CALLINTF_REQ			(47)
> +#define ESM_TVM_READ_MEM			(48)
> +#define ESM_TVM_WRITE_MEM			(49)

> +#define ESM_STATUS_CMD_SUCCESS			(0)
> +#define ESM_STATUS_CMD_NOT_IMPLEMENTED		(1)
> +#define ESM_STATUS_CMD_BAD			(2)
> +#define ESM_STATUS_CMD_TIMEOUT			(3)
> +#define ESM_STATUS_CMD_NO_SUCH_DEVICE		(7)
> +#define ESM_STATUS_CMD_DEVICE_BAD		(9)

> +#define HC_ACTION_NONE				(0)

> +#define TVM_SMITYPE_NONE			(0)
> +#define TVM_SMITYPE_TYPE1			(1)
> +#define TVM_SMITYPE_TYPE2			(2)
> +#define TVM_SMITYPE_TYPE3			(3)

> +#define ESM_APM_CMD				(0x0A0)
> +#define ESM_APM_CMD_HEADER_SIZE			(4)
> +#define ESM_APM_POWER_CYCLE			(0x10)

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

> +#define MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN	(14)
> +#define MAX_SYSMGMT_LONGCMD_SGENTRY_NUM		(16)

> +#define TIMEOUT_USEC_SHORT_SEMA_BLOCKING	(10000)
> +#define EXPIRED_TIMER				(0)

> +#define TVM_PHYS_MAX				(0xffffffffUL)

Useless brackets.

> +struct apm_cmd_t {

Please, drop this "_t". You're not typedefing.

> +	u8 command;
> +	s8 status;
> +	u16 reserved;
> +	union __attribute__ ((packed)) {
> +		struct __attribute__ ((packed)) {
> +			u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
> +		} shortreq;
> +
> +		struct __attribute__ ((packed)) {
> +			u16 num_sg_entries;
> +			struct __attribute__ ((packed)) {
> +				u32 size;
> +				u64 addr;
> +			} sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
> +		} longreq;
> +	} parameters;
> +} __attribute__ ((packed));

> --- linux-2.6.12-rc6.orig/drivers/char/Kconfig
> +++ linux-2.6.12-rc6/drivers/char/Kconfig

> +config DCDBAS
> +	tristate "Dell Systems Management Base driver"
> +	default m
> +	help
> +	  The Dell Systems Management Base driver provides support
> +	  needed by Dell systems management software to manage
> +	  certain Dell systems.
> +
> +	  Say Y or M here if you plan to use Dell systems management
> +	  software to manage your system.  If you say M here, the
> +	  driver will be compiled as a module called dcdbas.

Uhh... 5 deriatives from "manage" and you still haven't described what the
driver is actually needed for. What "certain" systems?
