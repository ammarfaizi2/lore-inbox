Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWI1Ucv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWI1Ucv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWI1Ucv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:32:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWI1Uct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:32:49 -0400
Date: Thu, 28 Sep 2006 13:32:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 12
Message-Id: <20060928133246.14e79ace.akpm@osdl.org>
In-Reply-To: <20060928182438.GC5017@parisc-linux.org>
References: <20060928182438.GC5017@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 12:24:38 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> Add ability to scan scsi busses asynchronously
> 
> ...

> --- a/drivers/scsi/Makefile
> +++ b/drivers/scsi/Makefile
> @@ -140,6 +140,8 @@ obj-$(CONFIG_CHR_DEV_SCH)	+= ch.o
>  # This goes last, so that "real" scsi devices probe earlier
>  obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
>  
> +obj-$(CONFIG_SCSI)		+= scsi_wait_scan.o
> +
>  scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
>  				   scsicam.o scsi_error.o scsi_lib.o \
>  				   scsi_scan.o scsi_sysfs.o \
>
> ...

I think that's supposed to go into scsi_mod-y, at line 146.

>
> +static char scsi_scan_type[6] = "sync";

That wasted a byte.

> +
> +module_param_string(scan, scsi_scan_type, sizeof(scsi_scan_type), S_IRUGO);
> +MODULE_PARM_DESC(scan, "sync, async or none");
> +
>  /*
>   * max_scsi_report_luns: the maximum number of LUNS that will be
>   * returned from the REPORT LUNS command. 8 times this value must
> @@ -108,6 +115,53 @@ MODULE_PARM_DESC(inq_timeout, 
>  		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
>  		 " Default is 5. Some non-compliant devices need more.");
>  
> +static spinlock_t async_scan_lock = SPIN_LOCK_UNLOCKED;

DEFINE_SPINLOCK()

> +static LIST_HEAD(scanning_hosts);
> +
> +struct async_scan_data {
> +	struct list_head list;
> +	struct Scsi_Host *shost;
> +	struct completion prev_finished;
> +};
> +
> +int scsi_complete_async_scans(void)
> +{
> +	struct async_scan_data *data;
> +
> +	do {
> +		if (list_empty(&scanning_hosts))
> +			return 0;
> +		data = kmalloc(sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			msleep(1);
> +	} while (!data);

ick.  Immortal allocation loops are poor form.  If there's really no
alternative, please use __GFP_NOFAIL, so people can easily grep for your
sins.

> +	data->shost = NULL;
> +	init_completion(&data->prev_finished);
> +
> +	spin_lock(&async_scan_lock);
> +	if (list_empty(&scanning_hosts))
> +		goto done;
> +	list_add_tail(&data->list, &scanning_hosts);
> +	spin_unlock(&async_scan_lock);

"If the list is not empty, stick something on it".

What an unusual thing to do.  I'm sure it makes sense, but some comments
explaining what's going on would be nice.

> +	printk(KERN_INFO "scsi: waiting for bus probes to complete ...\n");
> +	wait_for_completion(&data->prev_finished);
> +
> +	spin_lock(&async_scan_lock);
> +	list_del(&data->list);
> + done:
> +	spin_unlock(&async_scan_lock);
> +
> +	kfree(data);
> +	return 0;
> +}
> +
> +#ifdef MODULE
> +/* Only exported for the benefit of scsi_wait_scan */
> +EXPORT_SYMBOL_GPL(scsi_complete_async_scans);
> +#endif

Is that actually needed?  AFACIT this .o file will just get linked against
the one which contains scsi_wait_scan() anyway.


