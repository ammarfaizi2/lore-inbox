Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRGGGIz>; Sat, 7 Jul 2001 02:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbRGGGIq>; Sat, 7 Jul 2001 02:08:46 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:61701 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S266040AbRGGGIf>; Sat, 7 Jul 2001 02:08:35 -0400
From: Henry <henry@borg.metroweb.co.za>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Sat, 7 Jul 2001 08:03:21 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01070516412506.06182@borg> <3B457835.F06E49CF@uow.edu.au>
In-Reply-To: <3B457835.F06E49CF@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01070708085101.00793@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2001, Andrew Morton wrote:
> Henry wrote:
> > 
> > ...
> > Dual-cpu pentium 233 (intel) with 128MB RAM and more than double that swap.
> > 
> > ...
> > Unable to handle kernel NULL pointer dereference at virtual address 00000008
> > c01b4227
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01b4227>]
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010207
> > eax: 00000001   ebx: 00000000   ecx: 000000c0   edx: c12c49c0
> > esi: c12d3f4c   edi: 00000001   ebp: c0d0f2a0   esp: c12d3ee0
> > ds: 0018   es: 0018   ss: 0018
> > Process kswapd (pid: 3, stackpage=c12d3000)
> > Stack: 00000000 c12d3f4c c12d3f4c c01330cb 00000001 00000000 001c4300 c1203048
> >        00000000 00000028 c0129752 00000001 c1203048 00000305 c12d3f48 00001000
> >        001c4300 c1203048 00000000 00000028 c12d3f48 00000000 00001000 00001c43
> > Call Trace: [<c01330cb>] [<c0129752>] [<c0106cec>] [<c012981f>] [<c012a4e8>] [<c
> > 0128b1d>] [<c01293f5>]
> >        [<c0129486>] [<c01054cc>]
> > Code: 0f b7 43 08 66 c1 e8 09 0f b7 f0 8b 43 18 a8 04 75 19 68 a7
> > 
> > >>EIP; c01b4227 <submit_bh+b/74>   <=====
> > Trace; c01330cb <brw_page+8f/a0>
> > Trace; c0129752 <rw_swap_page_base+152/1b0>
> > Trace; c0106cec <ret_from_intr+0/7>
> > Trace; c012981f <rw_swap_page+6f/b8>
> > Trace; c012a4e8 <swap_writepage+78/80>
> > Trace; c0128b1d <page_launder+285/874>
> > Trace; c01293f5 <do_try_to_free_pages+1d/58>
> > Trace; c0129486 <kswapd+56/e8>
> > Trace; c01054cc <kernel_thread+28/38>
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


Howzit Andrew

So far, so good.  There has not been a single oops on the two principle
servers I patched.  

uptime1:		8:04am  up 18:22,  1 user,  load average: 0.09, 0.15, 0.11
uptime2:		8:04am  up 18:25,  1 user,  load average: 0.15, 0.20, 0.15

Andrew my china, you are the _MAN_!  We should know by monday afternoon
(the monday morning/midday crunch should provide some valuable
feedback).

Cheers
Henry
