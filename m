Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319000AbSH1Vi1>; Wed, 28 Aug 2002 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319001AbSH1Vi1>; Wed, 28 Aug 2002 17:38:27 -0400
Received: from holomorphy.com ([66.224.33.161]:33664 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319000AbSH1ViZ>;
	Wed, 28 Aug 2002 17:38:25 -0400
Date: Wed, 28 Aug 2002 14:42:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
Message-ID: <20020828214243.GC888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D6C53ED.32044CAD@zip.com.au> <20020828200857.GB888@holomorphy.com> <3D6D3216.D472CBC3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6D3216.D472CBC3@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This is disturbing. I suspect this is only going to raise poor memory
>> utilization issues on highmem boxen.

On Wed, Aug 28, 2002 at 01:27:02PM -0700, Andrew Morton wrote:
> The intent is to fix them.  Allowing more than 2G of dirty data to
> float about seems unreasonable, and it pins buffer_heads.
> But hey.  The patch merely sets the initial value of /proc/sys/vm/dirty*,
> and those things are writeable.

Hmm. Then I've actually tested this... I can at least say it's stable,
even if I'm not wild about the approach.


William Lee Irwin III wrote:
>> AFAICT the OOM issues are largely a by-product of mempool allocations
>> entering out_of_memory() when they have the perfectly reasonable
>> alternative strategy of simply waiting for the mempool to refill.

On Wed, Aug 28, 2002 at 01:27:02PM -0700, Andrew Morton wrote:
> I don't have enough RAM to reproduce this.  Please send
> call traces up from out_of_memory().

I've already written the patch to address it, though of course, I can
post those traces along with the patch once it's rediffed. (It's trivial
though -- just a fresh GFP flag and a check for it before calling
out_of_memory(), setting it in mempool_alloc(), and ignoring it in
slab.c.) It requires several rounds of "un-throttling" to reproduce
the OOM's, the nature of which I've outlined elsewhere.

One such trace is below, some of the others might require repeating the
runs. It's actually a relatively deep call chain, I'd be worried about
blowing the stack at this point as well.


Cheers,
Bill

2.5.31-akpm + request queue size of 16384 + inode table size of 1024       
+ zone->wait_table max size of 65536 + MIN_PDFLUSH_THREADS == NR_CPUS
+ MAX_PDFLUSH_THREADS == 16*NR_CPUS on 16x/16GB x86 running 4
simultaneous tiobench --size $((4*1024)) --threads 256 on 4 disks.

They also pile up on ->i_sem of the dir they create files in, not sure
what to do about that aside from working around it in userspace. It
basically takes this kind of stuff so the things don't all fall asleep
on some resource or other, though the box is still pretty much idle.


#1  0xc013ba01 in oom_kill () at oom_kill.c:181
#2  0xc013ba7c in out_of_memory () at oom_kill.c:248
#3  0xc0137628 in try_to_free_pages (classzone=0xc039f300, gfp_mask=80,
    order=0) at vmscan.c:585
#4  0xc013831b in balance_classzone (classzone=0xc039f300, gfp_mask=80,
    order=0, freed=0xf7b0dc5c) at page_alloc.c:278
#5  0xc01385f7 in __alloc_pages (gfp_mask=80, order=0, zonelist=0xc02b4064)
    at page_alloc.c:401
#6  0xc013b777 in alloc_pages_pgdat (pgdat=0xc039f000, gfp_mask=80, order=0)
    at numa.c:77
#7  0xc013b7c3 in _alloc_pages (gfp_mask=80, order=0) at numa.c:105
#8  0xc013e440 in page_pool_alloc (gfp_mask=80, data=0x0) at highmem.c:33
#9  0xc013f395 in mempool_alloc (pool=0xf7b78d20, gfp_mask=80) at mempool.c:203
#10 0xc013ed85 in blk_queue_bounce (q=0xf76a941c, bio_orig=0xf7b0dd60)
    at highmem.c:397
#11 0xc01da088 in __make_request (q=0xf76a941c, bio=0xec0324a0)
    at ll_rw_blk.c:1481
#12 0xc01da5bf in generic_make_request (bio=0xec0324a0) at ll_rw_blk.c:1714
#13 0xc01da63c in submit_bio (rw=1, bio=0xec0324a0) at ll_rw_blk.c:1760
#14 0xc0161701 in mpage_bio_submit (rw=1, bio=0xec0324a0) at mpage.c:93
#15 0xc0162094 in mpage_writepages (mapping=0xed953d7c,
#16 0xc01722e0 in ext2_writepages (mapping=0xed953d7c, nr_to_write=0xf7b0df8c)
    at inode.c:636
#17 0xc0140a1a in do_writepages (mapping=0xed953d7c, nr_to_write=0xf7b0df8c)
    at page-writeback.c:372
#18 0xc0160b74 in __sync_single_inode (inode=0xed953cf4, wait=0,
    nr_to_write=0xf7b0df8c) at fs-writeback.c:147
#19 0xc0160d50 in __writeback_single_inode (inode=0xed953cf4, sync=0,
    nr_to_write=0xf7b0df8c) at fs-writeback.c:196
#20 0xc0160ec1 in sync_sb_inodes (single_bdi=0x0, sb=0xf6049c00, sync_mode=0,
    nr_to_write=0xf7b0df8c, older_than_this=0x0) at fs-writeback.c:270
#21 0xc016104d in __writeback_unlocked_inodes (bdi=0x0,
    nr_to_write=0xf7b0df8c, sync_mode=WB_SYNC_NONE, older_than_this=0x0)
    at fs-writeback.c:310
#22 0xc01610f6 in writeback_unlocked_inodes (nr_to_write=0xf7b0df8c,
    sync_mode=WB_SYNC_NONE, older_than_this=0x0) at fs-writeback.c:340
#23 0xc01407e9 in background_writeout (_min_pages=0) at page-writeback.c:188
#24 0xc0140408 in __pdflush (my_work=0xf7b0dfd4) at pdflush.c:120
#25 0xc01404f7 in pdflush (dummy=0x0) at pdflush.c:168
