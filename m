Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWATM1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWATM1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWATM1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:27:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750920AbWATM1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:27:04 -0500
Date: Fri, 20 Jan 2006 13:28:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, AChittenden@bluearc.com, linux-kernel@vger.kernel.org,
       lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060120122859.GH13429@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com> <20060119194836.GM21663@redhat.com> <20060119141515.5f779b8d.akpm@osdl.org> <20060120081231.GE4213@suse.de> <20060120002307.76bcbc27.akpm@osdl.org> <20060120120844.GG13429@suse.de> <20060120041727.5329f299.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120041727.5329f299.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Fri, Jan 20 2006, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > On Thu, Jan 19 2006, Andrew Morton wrote:
> > > > > Dave Jones <davej@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 19, 2006 at 03:11:45PM -0000, Andy Chittenden wrote:
> > > > > >  > DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
> > > > > >  > present:12740kB pages_scanned:4 all_unreclaimable? yes
> > > > > > 
> > > > > > Note we only scanned 4 pages before we gave up.
> > > > > > Larry Woodman came up with this patch below that clears all_unreclaimable
> > > > > > when in two places where we've made progress at freeing up some pages
> > > > > > which has helped oom situations for some of our users.
> > > > > 
> > > > > That won't help - there are exactly zero pages on ZONE_DMA's LRU.
> > > > > 
> > > > > The problem appears to be that all of the DMA zone has been gobbled up by
> > > > > the BIO layer.  It seems quite inappropriate that a modern 64-bit machine
> > > > > is allocating tons of disk I/O pages from the teeny ZONE_DMA.  I'm
> > > > > suspecting that someone has gone and set a queue's ->bounce_gfp to the wrong
> > > > > thing.
> > > > > 
> > > > > Jens, would you have time to investigate please?
> > > > 
> > > > Certainly, I'll get this tested and fixed this afternoon.
> > > 
> > > Wow ;)
> > >
> > > You may find it's an x86_64 glitch - setting max_[low_]pfn wrong down in
> > > the bowels of the arch mm init code, something like that.
> > > 
> > > I thought it might have been a regression which came in when we added
> > > ZONE_DMA32 but the RH reporter is based on 2.6.14-<redhat stuff>, and he
> > > didn't have ZONE_DMA32.
> > 
> > Sorry, spoke too soon, I thought this was the 'bio/scsi leaks' which
> > most likely is a scsi leak that also results in the bios not getting
> > freed.
> > 
> > This DMA32 zone shortage looks like a vm short coming, you're likely the
> > better candidate to fix that :-)
> 
> It's not ZONE_DMA32.  It's the 12MB ZONE_DMA which is being exhausted on
> this 4GB 64-bit machine.
> 
> Andy put a dump_stack() into the oom code and it pointed at 
> 
> 
>  Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
>  <ffffffff8014f4b0>{__alloc_pages+536}
>         <ffffffff80169788>{bio_alloc_bioset+232}
>  <ffffffff80169d03>{bio_copy_user+218}
>         <ffffffff801bd657>{blk_rq_map_user+136}
>  <ffffffff801c0008>{sg_io+328}
>         <ffffffff801c047c>{scsi_cmd_ioctl+491}
>  <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
>         <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
>  <ffffffff802a6db6>{schedule_timeout+158}
>         <ffffffff801bf165>{blkdev_ioctl+1365}
>  <ffffffff80243cb2>{sys_sendto+251}
>         <ffffffff801751e5>{__pollwait+0}
>  <ffffffff8016b16a>{block_ioctl+25}
>         <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
>         <ffffffff80174cb4>{sys_ioctl+89}

Hmm strange, what kind of device is this? I'm guessing it's not ISA.
Andy, can you try and boot with this applied?

Did the blk_max_low_pfn stuff get a different meaning with the addition
of the DMA32 zone?

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8e27d0a..ab897de 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -636,6 +636,8 @@ void blk_queue_bounce_limit(request_queu
 {
 	unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
 
+	printk("bounce: queue %p, setting pfn %lu, max_low %lu\n", q, bounce_pfn, blk_max_low_pfn);
+
 	/*
 	 * set appropriate bounce gfp mask -- unfortunately we don't have a
 	 * full 4GB zone, so we have to resort to low memory for any bounces.

-- 
Jens Axboe

