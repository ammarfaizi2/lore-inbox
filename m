Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGBNc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGBNc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUGBNc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:32:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12485 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264519AbUGBNcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:32:52 -0400
Date: Fri, 2 Jul 2004 10:18:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/2.4.26] Avoid kernel data corruption through /dev/kmem
Message-ID: <20040702131844.GC7679@logos.cnet>
References: <200407011605.29386.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407011605.29386.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 04:05:29PM +0200, BlaisorBlade wrote:
> I'm sending this fix for /dev/kmem; I already sent a cleanup about this, but 
> since you said "cleanups go in 2.6", then I'm sending only the bugfix.

Hi Paolo, 

This looks much better for inclusion. But do you actually have a problem with
write to /dev/kmem not returning correct error code?

If you convince me there are good enough reasons we can try this on 2.4.28-pre.

Thanks

> We need to check if do_write_mem == -EFAULT.
> In fact, without that check, we could execute this:
> 
> do_write_mem returns -EFAULT;
> wrote = -EFAULT;
> 
> buf += wrote; //i.e. buf -= EFAULT (14);
> 
> ... read other data from buf, and write it to kernel memory
> (actually on special circumstances, i.e. p < high_memory && 
>  p + count > high_memory).
> 
> Luckily not at all exploitable (not even in the OpenBSD idea) since
> to write on /dev/kmem you must already be root.
> 
> ---
> 
>  linux-2.4.26-paolo/drivers/char/mem.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/char/mem.c~fix-mem-return drivers/char/mem.c
> --- linux-2.4.26/drivers/char/mem.c~fix-mem-return	2004-07-01 15:14:00.275806312 +0200
> +++ linux-2.4.26-paolo/drivers/char/mem.c	2004-07-01 15:28:24.604408392 +0200
> @@ -287,11 +287,13 @@ static ssize_t write_kmem(struct file * 
>  	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
>  
>  	if (p < (unsigned long) high_memory) {
> -		wrote = count;
> +		ssize_t towrite = count;
>  		if (count > (unsigned long) high_memory - p)
> -			wrote = (unsigned long) high_memory - p;
> +			towrite = (unsigned long) high_memory - p;
>  
> -		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
> +		wrote = do_write_mem(file, (void*)p, p, buf, towrite, ppos);
> +		if (wrote != towrite)
> +			return wrote;
>  
>  		p += wrote;
>  		buf += wrote;
> _

