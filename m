Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUCIVpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUCIVpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:45:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:62608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbUCIVpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:45:05 -0500
Date: Tue, 9 Mar 2004 13:46:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing return value check on do_write_mem
Message-Id: <20040309134648.61e3cb9f.akpm@osdl.org>
In-Reply-To: <200403081246.33897.blaisorblade_spam@yahoo.it>
References: <200403081246.33897.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> In drivers/char/mem.c do_write_mem can return -EFAULT but write_kmem forgets 
> this and goes blindly.
> 
> Note: /dev/kmem can be written to only by root, so this *cannot* have security 
> implications.
> 
> Also, do_write_mem takes two unused params and is static - so I've removed 
> those. I actually double-checked this - however please test compilation on 
> Sparc/m68k, since there are some #ifdef.
> 

It's a small thing, but:

> --- ./drivers/char/mem.c.fix	2004-02-20 16:27:21.000000000 +0100
> +++ ./drivers/char/mem.c	2004-03-08 12:17:23.000000000 +0100
> @@ -96,13 +96,14 @@
>  }
>  #endif
>  
> -static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
> -			    const char * buf, size_t count, loff_t *ppos)
> +static ssize_t do_write_mem(void *p, const char * buf, size_t count,
> +			    loff_t *ppos)
>  {
> -	ssize_t written;
> +	ssize_t written = 0;
>  
> -	written = 0;
>  #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
> +	unsigned long realp = *ppos;
> +

A thread which shares this fd can alter the value at *ppos at any time via
lseek() .

>  	/* we don't have page 0 mapped on sparc and m68k.. */
>  	if (realp < PAGE_SIZE) {
>  		unsigned long sz = PAGE_SIZE-realp;
> @@ -165,7 +166,7 @@
>  
>  	if (!valid_phys_addr_range(p, &count))
>  		return -EFAULT;
> -	return do_write_mem(file, __va(p), p, buf, count, ppos);
> +	return do_write_mem(__va(p), buf, count, ppos);
>  }
>  
>  static int mmap_mem(struct file * file, struct vm_area_struct * vma)
> @@ -276,7 +277,9 @@
>  		if (count > (unsigned long) high_memory - p)
>  			wrote = (unsigned long) high_memory - p;

Here we have applied a range check.

> -		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
> +		wrote = do_write_mem((void*)p, buf, wrote, ppos);

But here we go off and use *ppos, which may now have a different value from
that which we just range-checked.

