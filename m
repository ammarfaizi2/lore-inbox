Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWIFBAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWIFBAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWIFBAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:00:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24896 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965098AbWIFBAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:00:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IBX4hhgNl8UXxBmnhZUUzzs27W8ESACAohWkldygdQSha2BH6xJKxDGV7/CfkP4/LiIFzHWCkqwniWjtluam09f9BlfSn1x7Ro6z2r1U62vVSCM7GdjMW+CPz9Q6F6IvecpbNkuQ8HlW1RRYs2nBy+3Ein/jG87iZfENVziDLUI=
Message-ID: <625fc13d0609051800w5d4b114cp5e2517ca683708ee@mail.gmail.com>
Date: Tue, 5 Sep 2006 20:00:06 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH] Make MTD chardev mmap available under some circumstances
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <24712.1157483886@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <24712.1157483886@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/06, David Howells <dhowells@redhat.com> wrote:
>
> Make it possible to mmap MTD chardevs directly or by copy on a NOMMU system.

Why would you want to do this?  I'm just curious.


> +/*
> + * Allow NOMMU mmap() to directly map the device (if not NULL)
> + * - return the address to which the offset maps
> + * - return -ENOSYS to indicate refusal to do the mapping

Where do you actually do the -ENOSYS part?  I think that comment
belongs to the actual mtd_get_unmapped_area call in mtdchar.c, no?

> +/*
> + * try to determine where a shared mapping can be made
> + * - only supported for NOMMU at the moment (MMU can't doesn't copy private
> + *   mappings)
> + */
> +#ifndef CONFIG_MMU
> +static unsigned long mtd_get_unmapped_area(struct file *file,
> +                                          unsigned long addr,
> +                                          unsigned long len,
> +                                          unsigned long pgoff,
> +                                          unsigned long flags)
> +{
> +       struct mtd_file_info *mfi = file->private_data;
> +       struct mtd_info *mtd = mfi->mtd;
> +
> +       if (mtd->get_unmapped_area) {
> +               unsigned long offset;
> +
> +               if (addr != 0)
> +                       return (unsigned long) -EINVAL;
> +
> +               if (len > mtd->size || pgoff >= (mtd->size >> PAGE_SHIFT))
> +                       return (unsigned long) -EINVAL;
> +
> +               offset = pgoff << PAGE_SHIFT;
> +               if (offset > mtd->size - len)
> +                       return (unsigned long) -EINVAL;
> +
> +               return mtd->get_unmapped_area(mtd, len, offset, flags);
> +       }
> +
> +       /* can't map directly */
> +       return (unsigned long) -ENOSYS;
> +}
> +#endif

Could we do something like:

#else
#define mtd_get_unmapped_area (NULL);

which would prevent the ugly ifdef in the mtd_fops structure?

>  static struct file_operations mtd_fops = {
>         .owner          = THIS_MODULE,
>         .llseek         = mtd_lseek,
> @@ -771,6 +864,10 @@ static struct file_operations mtd_fops =
>         .ioctl          = mtd_ioctl,
>         .open           = mtd_open,
>         .release        = mtd_close,
> +       .mmap           = mtd_mmap,
> +#ifndef CONFIG_MMU
> +       .get_unmapped_area = mtd_get_unmapped_area,
> +#endif

See above.


josh
