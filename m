Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTKGWWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTKGWWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:22:21 -0500
Received: from ns.suse.de ([195.135.220.2]:32941 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264086AbTKGL06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:26:58 -0500
Date: Fri, 7 Nov 2003 12:25:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031107112555.GC591@suse.de>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au> <20031107112346.GA5153@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107112346.GA5153@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Herbert Xu wrote:
> On Fri, Nov 07, 2003 at 08:09:00AM +1100, herbert wrote:
> > On Wed, Nov 05, 2003 at 10:48:55AM +0100, Jens Axboe wrote:
> > > 
> > > I don't see any problems with this approach, I'll commit the code.
> > 
> > Actually, please hold onto that patch if possible, I've just received
> > a report that it maybe causing worse problems than the one it solves.
> > 
> > I'll get back to you.

Well too late, it's in the kernel tree. I've been running it here for
some days as well, haven't seen any problems. It also looks fine to me,
so...

> OK, looks like the crash is unrelated to this change.  Here is
> the dump:
> 
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:329!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c012d4e7>]    Not tainted
> EFLAGS: 00010246
> EIP is at unlock_page+0x17/0x40
> eax: 00000000   ebx: c100e448   ecx: 0000001c   edx: c100e448
> esi: c105a058   edi: c1304f20   ebp: c0257ebc   esp: c0257e58
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0256000 task=c0224c80)
> Stack: c10e3114 00000001 c015f09e c1304f20 00000000 00011000 c01496ed c1304f20 
>        00011000 00000000 00011000 c1304f20 c01a252f c1304f20 00011000 00000000 
>        00011000 c1304f20 00000000 00000000 00000000 00000000 c12f8b30 c029ace0 
> Call Trace:
>  [<c015f09e>] mpage_end_io_read+0x4e/0x70
>  [<c01496ed>] bio_endio+0x3d/0x60
>  [<c01a252f>] __end_that_request_first+0x1ef/0x210
>  [<c01a2567>] end_that_request_first+0x17/0x20
>  [<c30c9768>] scsi_end_request+0x28/0xb0 [scsi_mod]
>  [<c30c9b5a>] scsi_io_completion+0x1da/0x470 [scsi_mod]
>  [<c30428bc>] sd_rw_intr+0x7c/0x240 [sd_mod]
>  [<c30c5a01>] scsi_finish_command+0x81/0xe0 [scsi_mod]
>  [<c30c5826>] scsi_softirq+0xd6/0x200 [scsi_mod]
>  [<c011c453>] do_softirq+0x93/0xa0
>  [<c010cea6>] do_IRQ+0xd6/0x110
>  [<c0105000>] _stext+0x0/0x20
>  [<c010b6c8>] common_interrupt+0x18/0x20
>  [<c01088a0>] default_idle+0x0/0x30
>  [<c0105000>] _stext+0x0/0x20
>  [<c01088c4>] default_idle+0x24/0x30
>  [<c0108935>] cpu_idle+0x25/0x40
>  [<c02586a9>] start_kernel+0x159/0x190

Could be related, someone is doing an unlock on an already unlocked
page. Is this the same system that saw the bounce problem initially?

-- 
Jens Axboe

