Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTLDMoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 07:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTLDMoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 07:44:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1179 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261774AbTLDMoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 07:44:20 -0500
Date: Thu, 4 Dec 2003 13:43:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031204124342.GD1086@suse.de>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <200312031747.16927.ender@debian.org> <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03 2003, Linus Torvalds wrote:
> 
> 
> On Wed, 3 Dec 2003, David Martínez Moreno wrote:
> >
> > 	I've just rebooted about six hours ago, and it's giving panics elsewhere:
> >
> > [...]
> > Ending XFS recovery on filesystem: md0 (dev: md0)
> > b44: eth0: Link is down.
> > b44: eth0: Link is up at 100 Mbps, full duplex.
> > b44: eth0: Flow control is on for TX and on for RX.
> > eth0: no IPv6 routers present
> > Unable to handle kernel paging request at virtual address 00100104
> 
> That's the LIST_POISON stuff: 00100100 is the "bad list pointer". Somebody
> tried to remove a page twice.
> 
> Doesn't mean a lot - if your "struct page" got corrupted, anything can
> happen. Quite possibly it's a double free.
> 
> > 	I can rebuild the Debian mirror for not using the RAID and using the SATA
> > disks separately, but will be tomorrow, it's a lot of space to move, and I
> > need remote intervention.
> >
> > 	Anyway I'd love to know before doing if it will be useful, looking at what
> > Jens has said just ten minutes ago about RAIDs 0/5. Will it help to you? Say
> > so and I'll go for it.
> 
> It might be more useful to leave it as RAID0, if you're willing to try out
> patches to try to debug this. The slab-debugging thing I sent out earlier
> is one such patch (but may well cause out-of-memory problems under load),
> and possibly the atomic-decrement checker patch (appended). And maybe Jens
> and Neil can come up with something..

I can reproduce on raid5 with linear dm on top (using XFS). I need to
kill the slab and memory debugging, I've put some bio debugging in there
instead (the memory debugging interferes with it). It's definitely a bio
use after free case, clone_endio() ends up with a freed bio.

Program received signal SIGEMT, Emulation trap.
0xc02dd454 in handle_stripe (sh=0xc17cf630) at drivers/md/raid5.c:1009
1009                                        wbi = wbi2;
(gdb) bt
#0  0xc02dd454 in handle_stripe (sh=0xc17cf630) at drivers/md/raid5.c:1009
#1  0xc02de31f in raid5d (mddev=0xdfd2d200) at drivers/md/raid5.c:1436
#2  0xc02e675a in md_thread (arg=0xdffdc1a0) at drivers/md/md.c:2692
#3  0xc010752d in kernel_thread_helper () at arch/i386/kernel/process.c:226

wbi (dev->written) has already been freed by someone else.

My puny 512MB test box cannot use your slab-debug patch :). The
atomic-checker didn't catch anything.

-- 
Jens Axboe

