Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbUCNFwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUCNFwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:52:14 -0500
Received: from memebeam.org ([212.13.199.71]:39177 "EHLO jvb.vm.bytemark.co.uk")
	by vger.kernel.org with ESMTP id S263293AbUCNFwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:52:11 -0500
Message-ID: <4053F304.5040903@neggie.net>
Date: Sun, 14 Mar 2004 00:52:04 -0500
From: John Belmonte <john@neggie.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [PATCH] (2.6.x) toshiba_acpi needs copy_from_user (fixes oops)
References: <20040314052510.GA2587@ip68-4-255-84.oc.oc.cox.net>
In-Reply-To: <20040314052510.GA2587@ip68-4-255-84.oc.oc.cox.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for tracking this down.

Please don't apply this patch to the kernel tree.  I will submit a 
variation via Len Brown.  In any case, it appears at least one other 
ACPI driver has a similar bug, so best to go through Len.

-John


Barry K. Nathan wrote:
> On kernels with the 4G/4G patch (like some of the recent kernels in
> Fedora Core 2 development), writing stuff to the /proc/acpi/toshiba/*
> files causes an oops. As it turns out, this is because the driver is
> accessing userspace data without first doing copy_from_user(). IOW, this
> is a bug in toshiba_acpi, not a bug in the 4G/4G patch.
> 
> Here's a patch to fix this bug. I've tested it on 2.6.4 + some patches
> from the FC kernels (including the 4G/4G patch) and it fixes my oopses.
> I have also tested it against vanilla 2.6.4 and I haven't encountered
> any regressions.
> 
> If there are any problems with this patch, let me know.
> 
> -Barry K. Nathan <barryn@pobox.com>
> 
> 
> diff -ruN linux-2.6.4/drivers/acpi/toshiba_acpi.c linux-2.6.4-bkn1/drivers/acpi/toshiba_acpi.c
> --- linux-2.6.4/drivers/acpi/toshiba_acpi.c	2004-03-12 21:31:59.000000000 -0800
> +++ linux-2.6.4-bkn1/drivers/acpi/toshiba_acpi.c	2004-03-12 22:27:07.000000000 -0800
> @@ -41,6 +41,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
> +#include <asm/uaccess.h>
>  
>  #include <acpi/acpi_drivers.h>
>  
> @@ -269,10 +270,18 @@
>  }
>  
>  static int
> -dispatch_write(struct file* file, const char* buffer, unsigned long count,
> -	ProcItem* item)
> +dispatch_write(struct file* file, const char __user *buffer,
> +	unsigned long count, ProcItem* item)
>  {
> -	return item->write_func(buffer, count);
> +	char str[48] = {'\0'};
> +
> +	if (count > sizeof(str) - 1)
> +		return count;
> +	
> +	if (copy_from_user(str, buffer, count))
> +		return -EFAULT;
> +
> +	return item->write_func(str, count);
>  }
>  
>  static char*
> 
> 


-- 
http:// if  ile.org/
