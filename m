Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWH1D7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWH1D7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWH1D7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 23:59:51 -0400
Received: from mother.openwall.net ([195.42.179.200]:52877 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S932395AbWH1D7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 23:59:50 -0400
Date: Mon, 28 Aug 2006 07:55:56 +0400
From: Solar Designer <solar@openwall.com>
To: Julio Auto <mindvortex@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Message-ID: <20060828035556.GA27902@openwall.com>
References: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 03:41:00AM -0300, Julio Auto wrote:
> this is my porting (to 2.6.x) of the loop.c issue reported and patched
> by Solar Designer, to whom all credits of the original idea to the
> patch go (more info in the original "[PATCH] loop.c: kernel_thread()
> retval check" e-mail thread).

The patch looks good to me, although I did not test it.

> Honestly, I couldn't test it on other computers, but mine. But the
> tests were made against a stock (unmodified) 2.6.17.9 kernel and the
> patch works like it should. Nevertheless, a second thought/review is
> always appreciated.

I think that testing this on a single machine is fine, but it is
preferable that you also check for any resource leaks.  That is, replace
the kernel_thread() call with -EAGAIN, then run losetup in a loop and
see whether the system possibly leaks a resource.  I did apply this sort
of testing to my original 2.4 patch.

> Signed-off-by: Julio Auto <mindvortex@gmail.com>

Acked-by: Solar Designer <solar@openwall.com>

> --- drivers/block/loop.c.orig	2006-08-23 11:44:51.000000000 -0700
> +++ drivers/block/loop.c	2006-08-24 00:33:54.000000000 -0700
> @@ -841,10 +841,20 @@ static int loop_set_fd(struct loop_devic
> 
> 	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
> 	if (error < 0)
> -		goto out_putf;
> +		goto out_clr;
> 	wait_for_completion(&lo->lo_done);
> 	return 0;
> 
> + out_clr:
> +	lo->lo_device = NULL;
> +	lo->lo_flags = 0;
> +	lo->lo_backing_file = NULL;
> +	set_capacity(disks[lo->lo_number], 0);
> +	invalidate_bdev(bdev, 0);
> +	bd_set_size(bdev, 0);
> +	mapping_set_gfp_mask(mapping, lo->old_gfp_mask);
> +	lo->lo_state = Lo_unbound;
> +
>  out_putf:
> 	fput(file);
>  out:

Thanks,

Alexander
