Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266365AbRGFKpX>; Fri, 6 Jul 2001 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266366AbRGFKpN>; Fri, 6 Jul 2001 06:45:13 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:56840 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S266365AbRGFKpE>; Fri, 6 Jul 2001 06:45:04 -0400
From: Henry <henry@borg.metroweb.co.za>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Fri, 6 Jul 2001 12:31:22 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01070516412506.06182@borg> <3B457835.F06E49CF@uow.edu.au>
In-Reply-To: <3B457835.F06E49CF@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01070612450702.13482@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> There does appear to be an SMP race in brw_page() which can cause
> this - end_buffer_io_async() unlocks the page, try_to_free_buffers()
> zaps the buffer_head ring and brw_page() gets a null pointer.  But
> gee, it's unlikely unless you have super-fast disks and/or something
> which has a super-slow interrupt routine.
> 
> Could you please provide a description of your hardware lineup?
> 
> And could you please test 2.4.6 with this patch?
> 
> --- linux-2.4.6/fs/buffer.c	Wed Jul  4 18:21:31 2001
> +++ lk-ext3/fs/buffer.c	Fri Jul  6 18:25:00 2001
> @@ -2181,8 +2181,9 @@ int brw_page(int rw, struct page *page, 
>  
>  	/* Stage 2: start the IO */
>  	do {
> +		struct buffer_head *next = bh->b_this_page;
>  		submit_bh(rw, bh);
> -		bh = bh->b_this_page;
> +		bh = next;
>  	} while (bh != head);
>  	return 0;
>  }

Howzit Andrew,

OK, I'll give the patch a try.  I'll only be able to provide feedback
after about 12-24 hours though, depending on when I can reboot.

Hardware is pretty standard stuff:

Dual CPU Pentium II 233Mhz.  128MB RAM, Gigabyte motherboard (circa
1998), 20Gb IDE disks, realtek 8139 100Mb card.  Pretty std stuff. 
What's weird though is that this oops doesn't occur on our several
*very* busy clustered cache servers (running squid) - only one task
though (ie, squid/diskd/dnsserver), whereas the problem machines run
various apps.

Cheers
Henry
