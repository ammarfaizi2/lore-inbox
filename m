Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWHTHcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWHTHcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 03:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHTHcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 03:32:20 -0400
Received: from 1wt.eu ([62.212.114.60]:41744 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751642AbWHTHcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 03:32:19 -0400
Date: Sun, 20 Aug 2006 09:21:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060820072148.GB306@1wt.eu>
References: <20060819234629.GA16814@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819234629.GA16814@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Sun, Aug 20, 2006 at 03:46:29AM +0400, Solar Designer wrote:
> Willy,
> 
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.  (Last time I checked, 2.6 needed an equivalent fix,
> but I haven't produced one yet.)
> 
> Basically, the code in drivers/block/loop.c did not check the return
> value from kernel_thread().  If kernel_thread() would fail, the code
> would misbehave (IIRC, the invoking process would become unkillable).
> 
> An easy way to trigger the bug was to run losetup under strace (as
> root), and this is also how I tested the error path added with this
> patch.

That's amazing it never got fixed before !
I still remembered this problem being discussed, and finally found
the thread :

  http://lkml.org/lkml/2003/11/14/55

In fact, no code was proposed and 2.6 got fixed later, then stopped
using kernel_thread() so nearly nobody might have noticed it :

  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=3e88c17d404c5787afd5bd1763380317f5ccbf84;hp=22e6c1b39c648850438decd491f62d311800c7db

> This change has been a part of publicly released -ow patches for 8+
> months.
> 
> There are more instances of kernel_thread() calls that do not check the
> return value; some of the remaining ones might need to be fixed, too.

I've read somewhere that the module loading code might be affected too.

> Thanks,
> 
> Alexander

Thanks for this patch, I know this problem caught me at least one !

Cheers,
Willy


> diff -urpPX nopatch linux-2.4.33/drivers/block/loop.c linux/drivers/block/loop.c
> --- linux-2.4.33/drivers/block/loop.c	Fri Jun  3 04:26:42 2005
> +++ linux/drivers/block/loop.c	Sat Aug 12 08:51:47 2006
> @@ -693,12 +693,23 @@ static int loop_set_fd(struct loop_devic
>  	set_blocksize(dev, bs);
>  
>  	lo->lo_bh = lo->lo_bhtail = NULL;
> -	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
> -	down(&lo->lo_sem);
> +	error = kernel_thread(loop_thread, lo,
> +	    CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
> +	if (error < 0)
> +		goto out_clr;
> +	down(&lo->lo_sem); /* wait for the thread to start */
>  
>  	fput(file);
>  	return 0;
>  
> + out_clr:
> +	lo->lo_backing_file = NULL;
> +	lo->lo_device = 0;
> +	lo->lo_flags = 0;
> +	loop_sizes[lo->lo_number] = 0;
> +	inode->i_mapping->gfp_mask = lo->old_gfp_mask;
> +	lo->lo_state = Lo_unbound;
> +	fput(file); /* yes, have to do it twice */
>   out_putf:
>  	fput(file);
>   out:

