Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbWH2SXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWH2SXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWH2SXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:23:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbWH2SXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:23:52 -0400
Date: Tue, 29 Aug 2006 11:20:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and
 /dev/kmem
Message-Id: <20060829112030.a2a8c763.akpm@osdl.org>
In-Reply-To: <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
References: <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 18:59:49 +0100
David Howells <dhowells@redhat.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Set the backing device info capabilities for /dev/mem and /dev/kmem to permit
> direct sharing under no-MMU conditions.
> 
> Also comment the capabilities for /dev/zero.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/char/mem.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 917b204..4c29619 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -238,6 +238,19 @@ #endif
>  }
>  #endif
>  
> +#ifndef CONFIG_MMU
> +static unsigned long get_unmapped_area_mem(struct file *file,
> +					   unsigned long addr,
> +					   unsigned long len,
> +					   unsigned long pgoff,
> +					   unsigned long flags)
> +{
> +	if (!valid_mmap_phys_addr_range(pgoff, len))
> +		return (unsigned long) -EINVAL;
> +	return pgoff;
> +}

#else
#define get_unmapped_area_mem NULL
#endif

> @@ -782,6 +801,9 @@ static const struct file_operations mem_
>  	.write		= write_mem,
>  	.mmap		= mmap_mem,
>  	.open		= open_mem,
> +#ifndef CONFIG_MMU
> +	.get_unmapped_area = get_unmapped_area_mem,
> +#endif
>  };

zap ifdefs.

>  static const struct file_operations kmem_fops = {
> @@ -790,6 +812,9 @@ static const struct file_operations kmem
>  	.write		= write_kmem,
>  	.mmap		= mmap_kmem,
>  	.open		= open_kmem,
> +#ifndef CONFIG_MMU
> +	.get_unmapped_area = get_unmapped_area_mem,
> +#endif
>  };

Ditto.

> +/*
> + * capabilities for /dev/zero
> + * - permits private mappings, "copies" are taken of the source of zeros
> + */
>  static struct backing_dev_info zero_bdi = {
>  	.capabilities	= BDI_CAP_MAP_COPY,
>  };
>  
> +/*
> + * capabilities for /dev/mem and /dev/kmem
> + * - permits shared mmap for read, write and/or exec
> + * - does not permit private mmap (add BDI_CAP_MAP_COPY to permit this)
> + */
> +static struct backing_dev_info mem_bdi = {
> +	.capabilities	= (BDI_CAP_MAP_DIRECT |
> +			   BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP |
> +			   BDI_CAP_EXEC_MAP),
> +};

This changes behaviour, doesn't it?  But only for !CONFIG_MMU kernels?

Perhaps some additional commentary around this is needed.


>  static const struct file_operations full_fops = {
>  	.llseek		= full_lseek,
>  	.read		= read_full,
> @@ -861,9 +901,11 @@ static int memory_open(struct inode * in
>  {
>  	switch (iminor(inode)) {
>  		case 1:
> +			filp->f_mapping->backing_dev_info = &mem_bdi;
>  			filp->f_op = &mem_fops;
>  			break;
>  		case 2:
> +			filp->f_mapping->backing_dev_info = &mem_bdi;
>  			filp->f_op = &kmem_fops;
>  			break;
>  		case 3:

Perhaps one could make mem_bdi==NULL if !CONFIG_MMU, for a minor space
saving.

