Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSKJOZ5>; Sun, 10 Nov 2002 09:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSKJOZ5>; Sun, 10 Nov 2002 09:25:57 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:18654 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S264883AbSKJOZz>; Sun, 10 Nov 2002 09:25:55 -0500
Date: Sun, 10 Nov 2002 15:32:36 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: kernel BUG at kernel/timer.c:333!
Message-ID: <20021110153236.A18563@cistron.nl>
References: <aqj8bf$ff2$1@ncc1701.cistron.net> <3DCD5917.FEEA7C5D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DCD5917.FEEA7C5D@digeo.com>; from akpm@digeo.com on Sat, Nov 09, 2002 at 10:51:03AM -0800
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> Miquel van Smoorenburg wrote:
> > I can reliably crash 2.5.X on one of our newsservers (dual PIII/450, GigE,
> > lots of disk- and network I/O).
> > 
> > kernel BUG at kernel/timer.c:333!
> 
> There are timer fixes in Linus's current tree.  The problem which
> they address could cause this BUG.

I've booted 2.5.46bk5 on the machine, and it has been running for over
2 hours with extra heavy diskio. That reliably crashed the machine
in about 45 minutes with 2.4.45 and 2.5.46, machine is still up now.

> > Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> > Call Trace:
> >  [<c0117be8>] __might_sleep+0x54/0x58
> >  [<c013578c>] set_shrinker+0x3c/0x7c
> >  [<c01686b4>] mb_cache_create+0x1c4/0x244
> >  [<c0168380>] mb_cache_shrink_fn+0x0/0x170
> >  [<c01050ab>] init+0x47/0x1ac
> >  [<c0105064>] init+0x0/0x1ac
> >  [<c0106e8d>] kernel_thread_helper+0x5/0xc
> 
> That's different.  A fix for this is in Linus's tree.

Indeed, I don't see that one anymore in -bk5

I'm still seeing the buffer layer error at fs/buffer.c:1623,
though. Happens when a blockdev is close()d. Is a fix for
this in -mm2? Does -mm2 include -bk5 ?  If so I'll put that
on it and keep an eye on it tomorrow, see what happens.

Debug messages I'm still seeing:
(note that I compiled IPv6 into the kernel since we're slowly moving
our network to IPv6 but that it is otherwise unused right now, and
that the previous kernels that crashed on me didn't have IPv6 in it)

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc0285748, data=0xf78a6680
Call Trace:
 [<c0122610>] check_timer_failed+0x40/0x54
 [<c0285748>] igmp6_timer_handler+0x0/0x58
 [<c0122b12>] del_timer+0x16/0x84
 [<c02855d8>] igmp6_join_group+0x94/0x124
 [<c028464c>] igmp6_group_added+0xcc/0xd8
 [<c02885ab>] tcp_v6_err+0x3a7/0x63c
 [<c0284a46>] ipv6_dev_mc_inc+0x31e/0x330
 [<c027443e>] addrconf_join_solict+0x3a/0x44
 [<c0275a3f>] addrconf_dad_start+0x13/0x15c
 [<c0275354>] addrconf_add_linklocal+0x28/0x44
 [<c0275407>] addrconf_dev_config+0x97/0xa4
 [<c02754ee>] addrconf_notify+0x52/0xc0
 [<c0126037>] notifier_call_chain+0x1f/0x38
 [<c02259f6>] dev_open+0xa6/0xb0
 [<c0226ca1>] dev_change_flags+0x51/0x104
 [<c025bad0>] devinet_ioctl+0x2bc/0x598
 [<c025e2e7>] inet_ioctl+0x77/0xb4
 [<c021f41b>] sock_ioctl+0x267/0x298
 [<c0153c09>] sys_ioctl+0x22d/0x27c
 [<c01095b1>] error_code+0x2d/0x38
 [<c0108b6f>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:1623
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0145753>] __buffer_error+0x33/0x38
 [<c0146e6f>] __block_write_full_page+0x7f/0x3bc
 [<c0147ef9>] block_write_full_page+0x2d/0x9c
 [<c014a414>] blkdev_get_block+0x0/0x48
 [<c014a513>] blkdev_writepage+0xf/0x14
 [<c014a414>] blkdev_get_block+0x0/0x48
 [<c0161857>] mpage_writepages+0x21b/0x398
 [<c014a504>] blkdev_writepage+0x0/0x14
 [<c0137cfb>] __pagevec_free+0x1f/0x28
 [<c0135895>] release_pages+0x171/0x17c
 [<c014b5ad>] generic_writepages+0x11/0x15
 [<c013e068>] do_writepages+0x18/0x30
 [<c012f035>] filemap_fdatawrite+0x51/0x68
 [<c014596f>] sync_blockdev+0x1b/0x3c
 [<c014b3bf>] blkdev_put+0x7b/0x19c
 [<c014b4f2>] blkdev_close+0x12/0x18
 [<c0145410>] __fput+0x30/0xf8
 [<c01453dc>] fput+0x14/0x18
 [<c01437cc>] filp_close+0xb0/0xbc
 [<c014384e>] sys_close+0x76/0xa4
 [<c0108b6f>] syscall_call+0x7/0xb

Thanks,

Mike.
