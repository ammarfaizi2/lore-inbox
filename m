Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWBZOkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWBZOkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBZOkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:40:24 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:31890 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751141AbWBZOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:40:24 -0500
Date: Sun, 26 Feb 2006 09:35:39 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: OOM-killer too aggressive?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Largret <largret@gmail.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Largret is getting repeated OOM kills because of DMA memory
exhaustion:

oom-killer: gfp_mask=0xd1, order=3

Call Trace: <ffffffff8104ed46>{out_of_memory+58} <ffffffff8104ff30>{__alloc_pages+534}
       <ffffffff8104ffee>{__get_free_pages+48} <ffffffff8117d8e9>{dma_mem_alloc+31}
       <ffffffff81183e70>{floppy_open+348} <ffffffff81072125>{do_open+172}
       <ffffffff810724b4>{blkdev_open+0} <ffffffff810724dc>{blkdev_open+40}
       <ffffffff81069fea>{__dentry_open+230} <ffffffff8106a10e>{nameidata_to_filp+40}
       <ffffffff8106a153>{do_filp_open+51} <ffffffff8106a2cb>{get_unused_fd+116}
       <ffffffff8106a477>{do_sys_open+73} <ffffffff8106a4d3>{sys_open+27}
       <ffffffff8100aa3a>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:184
cpu 0 cold: high 62, batch 15 used:4
cpu 1 hot: high 186, batch 31 used:160
cpu 1 cold: high 62, batch 15 used:4
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:     2843384kB (0kB HighMem)
Active:10367 inactive:38871 dirty:42 writeback:0 unstable:0 free:710846
slab:4726 mapped:2155 pagetables:147
DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
present:15728kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 3014 3014 3014
DMA32 free:2843340kB min:7008kB low:8760kB high:10512kB active:41468kB
inactive:155484kB present:3086500kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 44kB
DMA32: 933*4kB 573*8kB 229*16kB 74*32kB 21*64kB 5*128kB 1*256kB 1*512kB
0*1024kB 0*2048kB 690*4096kB = 2843340kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 1477960kB
Total swap = 1477960kB
Free swap:       1477960kB
786416 pages of RAM
17590 reserved pages
10033 pages shared
0 pages swap cached
Out of Memory: Killed process 4886 (dbus-daemon).


Looking at floppy_open, we have:

        if (!floppy_track_buffer) {
                /* if opening an ED drive, reserve a big buffer,
                 * else reserve a small one */
                if ((UDP->cmos == 6) || (UDP->cmos == 5))
                        try = 64;       /* Only 48 actually useful */
                else
                        try = 32;       /* Only 24 actually useful */

                tmp = (char *)fd_dma_mem_alloc(1024 * try);
                if (!tmp && !floppy_track_buffer) {
                        try >>= 1;      /* buffer only one side */
                        INFBOUND(try, 16);
                        tmp = (char *)fd_dma_mem_alloc(1024 * try);
                }
                if (!tmp && !floppy_track_buffer) {
                        fallback_on_nodma_alloc(&tmp, 2048 * try);
                }

So it will try to allocate half its first request if that fails, then
fall back to non-DMA memory as a last resort, but doesn't get a chance
because the OOM killer gets invoked.  Maybe we need a new flag that says
"fail me immediately if no memory available"?

Or should floppy.c be fixed so it doesn't ask for so much?


I found a diagnostic patch but only this part applies to 2.6.16-rc4:

> From: Jens Axboe <axboe@suse.de>

--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -637,6 +637,8 @@ void blk_queue_bounce_limit(request_queu
 {
 	unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
 
+	printk("q=%p, dma_addr=%llx, bounce pfn %lu\n", q, dma_addr, bounce_pfn);
+
 	/*
 	 * set appropriate bounce gfp mask -- unfortunately we don't have a
 	 * full 4GB zone, so we have to resort to low memory for any bounces.
 
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
