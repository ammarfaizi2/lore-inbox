Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLDOII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTLDOII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:08:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35511 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261956AbTLDOIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:08:02 -0500
Date: Thu, 4 Dec 2003 15:07:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031204140738.GE1086@suse.de>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <200312031747.16927.ender@debian.org> <Pine.LNX.4.58.0312030916080.6950@home.osdl.org> <20031204124342.GD1086@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031204124342.GD1086@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04 2003, Jens Axboe wrote:
> On Wed, Dec 03 2003, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 3 Dec 2003, David Martínez Moreno wrote:
> > >
> > > 	I've just rebooted about six hours ago, and it's giving panics elsewhere:
> > >
> > > [...]
> > > Ending XFS recovery on filesystem: md0 (dev: md0)
> > > b44: eth0: Link is down.
> > > b44: eth0: Link is up at 100 Mbps, full duplex.
> > > b44: eth0: Flow control is on for TX and on for RX.
> > > eth0: no IPv6 routers present
> > > Unable to handle kernel paging request at virtual address 00100104
> > 
> > That's the LIST_POISON stuff: 00100100 is the "bad list pointer". Somebody
> > tried to remove a page twice.
> > 
> > Doesn't mean a lot - if your "struct page" got corrupted, anything can
> > happen. Quite possibly it's a double free.
> > 
> > > 	I can rebuild the Debian mirror for not using the RAID and using the SATA
> > > disks separately, but will be tomorrow, it's a lot of space to move, and I
> > > need remote intervention.
> > >
> > > 	Anyway I'd love to know before doing if it will be useful, looking at what
> > > Jens has said just ten minutes ago about RAIDs 0/5. Will it help to you? Say
> > > so and I'll go for it.
> > 
> > It might be more useful to leave it as RAID0, if you're willing to try out
> > patches to try to debug this. The slab-debugging thing I sent out earlier
> > is one such patch (but may well cause out-of-memory problems under load),
> > and possibly the atomic-decrement checker patch (appended). And maybe Jens
> > and Neil can come up with something..
> 
> I can reproduce on raid5 with linear dm on top (using XFS). I need to
> kill the slab and memory debugging, I've put some bio debugging in there
> instead (the memory debugging interferes with it). It's definitely a bio
> use after free case, clone_endio() ends up with a freed bio.
> 
> Program received signal SIGEMT, Emulation trap.
> 0xc02dd454 in handle_stripe (sh=0xc17cf630) at drivers/md/raid5.c:1009
> 1009                                        wbi = wbi2;
> (gdb) bt
> #0  0xc02dd454 in handle_stripe (sh=0xc17cf630) at drivers/md/raid5.c:1009
> #1  0xc02de31f in raid5d (mddev=0xdfd2d200) at drivers/md/raid5.c:1436
> #2  0xc02e675a in md_thread (arg=0xdffdc1a0) at drivers/md/md.c:2692
> #3  0xc010752d in kernel_thread_helper () at arch/i386/kernel/process.c:226
> 
> wbi (dev->written) has already been freed by someone else.
> 
> My puny 512MB test box cannot use your slab-debug patch :). The
> atomic-checker didn't catch anything.

I can just as easily reproduce with ext2, so I don't think XFS has
anything to do with it. This is still raid5 with dm linear on top.

(gdb) bt
#0  0x0b10dead in ?? ()
#1  0xc0170e25 in bio_endio (bio=0xda37fae0, bytes_done=0, error=0)
    at fs/bio.c:689
#2  0xc02e8a0d in clone_endio (bio=0xda38c120, done=7168, error=0)
    at drivers/md/dm.c:266
#3  0xc02dd78c in handle_stripe (sh=0xdfc18de0) at drivers/md/raid5.c:1209
#4  0xc02de38f in raid5d (mddev=0xdfd62200) at drivers/md/raid5.c:1437
#5  0xc02e67da in md_thread (arg=0xdfd58260) at drivers/md/md.c:2692
#6  0xc010752d in kernel_thread_helper () at arch/i386/kernel/process.c:226
(gdb) p *(struct bio *) 0xda37fae0
$1 = {bi_sector = 42974, bi_next = 0x0, bi_bdev = 0xb10dead, bi_flags =
1041, 
  bi_rw = 1, bi_vcnt = 3, bi_idx = 0, bi_phys_segments = 0, 
  bi_hw_segments = 0, bi_size = 0, bi_max_vecs = 0, bi_io_vec =
0xda357ce0, 
  bi_end_io = 0xb10dead, bi_cnt = {counter = 0}, bi_private = 0xb10dead, 
  bi_destructor = 0xc0170050 <bio_destructor>, free_eip = 0xc02e8a26}

EIP is bad, bio debug magic 0x0b10dead. bi_flags has the uptodate bit
set, the clone bit, and the 10th bit (debug dead bit). The bio itself
was freed by 0xc02e8a26, dm.c:clone_endio().

-- 
Jens Axboe

