Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWGGJFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWGGJFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWGGJFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:05:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932072AbWGGJFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:05:36 -0400
Date: Fri, 7 Jul 2006 02:04:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "erich" <erich@areca.com.tw>
Cc: James.Bottomley@SteelEye.com, rdunlap@xenotime.net, hch@infradead.org,
       brong@fastmail.fm, dax@gurulabs.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, robm@fastmail.fm
Subject: Re: Areca driver recap + status
Message-Id: <20060707020437.0f3532e4.akpm@osdl.org>
In-Reply-To: <001601c6a1a1$34a17180$0132a8c0@erich2003>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	<20060621222826.ff080422.akpm@osdl.org>
	<1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	<20060626080122.894de905.akpm@osdl.org>
	<001601c6a1a1$34a17180$0132a8c0@erich2003>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 16:41:53 +0800
"erich" <erich@areca.com.tw> wrote:

> From: Erich Chen <erich@areca.com.tw>
> 
>   1- fix sysfs has more than one value per file
>   2- PAE issues (cast of dma_addr_t to unsigned long)
>   3- unblock SYNCHRONIZE_CACHE
> 
> Signed-off-by: Erich Chen <erich@areca.com.tw>
> 
> Areca had tested its arcmsr linux raid driver on ppc machines G5 and it 
> worked fine.

Thanks.

> +static ssize_t
> +arcmsr_sysfs_iop_message_clear(struct kobject *kobj, char *buf, loff_t off,
> +    size_t count)
> +{
> +	struct class_device *cdev = container_of(kobj,struct class_device,kobj);
> +	struct Scsi_Host *host = class_to_shost(cdev);
> +	struct AdapterControlBlock *acb = (struct AdapterControlBlock *) host->hostdata;
> +	struct MessageUnit __iomem *reg = acb->pmu;
> +	uint8_t *pQbuffer;
> +
> +	if (!capable(CAP_SYS_ADMIN) || (count && off) == 0)
> +		return 0;

That (count && off) == 0 looks odd.  Are you sure that's what you meant to
do?

Also, a write() handler shouldn't return zero if it didn't write anything. 
Some applications will see that the write() returned less than expected and
didn't return an error so they'll just loop around and try to write more
data.  They'll hang up when writing to your sysfs file.

http://www.opengroup.org/onlinepubs/009695399/functions/write.html says

RETURN VALUE

    Upon successful completion, write() and pwrite() shall return the
    number of bytes actually written to the file associated with fildes. 
    This number shall never be greater than nbyte.  Otherwise, -1 shall be
    returned and errno set to indicate the error.

So you should return -EINVAL here, and perhaps -EACCES or -EPERM.  Because
nothing was written.
