Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRIAS3t>; Sat, 1 Sep 2001 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271106AbRIAS3c>; Sat, 1 Sep 2001 14:29:32 -0400
Received: from ns.ithnet.com ([217.64.64.10]:61454 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271105AbRIAS3Y>;
	Sat, 1 Sep 2001 14:29:24 -0400
Date: Sat, 1 Sep 2001 20:28:23 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010901202823.303eb0eb.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001 21:03:22 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> > >  		/* XXX: is pages_min/4 a good amount to reserve for this? */
> > > +		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
> > > +				!(current->flags & PF_MEMALLOC))
> > > +			continue;
> > Hello Daniel,
> > 
> > I tried this patch and it makes _no_ difference. Failures show up in same 
> > situation and amount. Do you need traces? They look the same
> 
> OK, first would you confirm that the frequency of 0 order failures has
> stayed the same?

Hello Daniel (and the rest),

I redid the test and have the following results, based on a 2.4.10-pre2 with
above patch:

meminfo before:

Sep  1 15:09:40 admin kernel: SysRq: Show Memory
Sep  1 15:09:40 admin kernel: Mem-info:
Sep  1 15:09:40 admin kernel: Free pages:      811288kB (     0kB HighMem)
Sep  1 15:09:40 admin kernel: ( Active: 927, inactive_dirty: 9604,
inactive_clea
n: 0, free: 202822 (383 766 1149) )
Sep  1 15:09:40 admin kernel: 1*4kB 1*8kB 5*16kB 4*32kB 5*64kB 1*128kB 1*256kB
0
*512kB 1*1024kB 6*2048kB = 14236kB)
Sep  1 15:09:40 admin kernel: 1*4kB 1*8kB 1*16kB 141*32kB 57*64kB 31*128kB
10*25
6kB 4*512kB 0*1024kB 381*2048kB = 797052kB)
Sep  1 15:09:40 admin kernel: = 0kB)
Sep  1 15:09:40 admin kernel: Swap cache: add 0, delete 0, find 0/0
Sep  1 15:09:40 admin kernel: Free swap:       265032kB
Sep  1 15:09:40 admin kernel: 229376 pages of RAM
Sep  1 15:09:40 admin kernel: 0 pages of HIGHMEM
Sep  1 15:09:40 admin kernel: 4378 reserved pages
Sep  1 15:09:40 admin kernel: 22056 pages shared
Sep  1 15:09:40 admin kernel: 0 pages swap cached
Sep  1 15:09:40 admin kernel: 0 pages in page table cachSep  1 15:09:40 admin
kernel: Buffer memory:     6576kB
Sep  1 15:09:40 admin kernel:     CLEAN: 1489 buffers, 5935 kbyte, 513 used
(las
t=1489), 0 locked, 0 protected, 0 dirty

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 105066496 816660480        0  6733824 36917248
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:        797520 kB
MemShared:           0 kB
Buffers:          6576 kB
Cached:          36052 kB
SwapCached:          0 kB
Active:           4076 kB
Inact_dirty:     38552 kB
Inact_clean:         0 kB
Inact_target:      296 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:        797520 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

(meminfo may slightly differ from SYSREQ, an application (seti) started in
between)

The usual test was going on, in the end I had:

meminfo:

Sep  1 15:18:27 admin kernel: SysRq: Show Memory
Sep  1 15:18:27 admin kernel: Mem-info:
Sep  1 15:18:27 admin kernel: Free pages:        3056kB (     0kB HighMem)
Sep  1 15:18:27 admin kernel: ( Active: 13965, inactive_dirty: 185778,
inactive_clean: 178, free: 764 (383 766 1149) )
Sep  1 15:18:27 admin kernel: 1*4kB 1*8kB 1*16kB 9*32kB 5*64kB 1*128kB 1*256kB
0*512kB 0*1024kB 0*2048kB = 1020kB)
Sep  1 15:18:27 admin kernel: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 5*128kB 3*256kB
1*512kB 0*1024kB 0*2048kB = 2036kB)
Sep  1 15:18:27 admin kernel: = 0kB)
Sep  1 15:18:27 admin kernel: Swap cache: add 0, delete 0, find 0/0
Sep  1 15:18:27 admin kernel: Free swap:       265032kB
Sep  1 15:18:27 admin kernel: 229376 pages of RAM
Sep  1 15:18:27 admin kernel: 0 pages of HIGHMEM
Sep  1 15:18:27 admin kernel: 4378 reserved pages
Sep  1 15:18:27 admin kernel: 215286 pages shared
Sep  1 15:18:27 admin kernel: 0 pages swap cached
Sep  1 15:18:27 admin kernel: 0 pages in page table cache
Sep  1 15:18:27 admin kernel: Buffer memory:    15576kB
Sep  1 15:18:27 admin kernel:     CLEAN: 178719 buffers, 714855 kbyte, 536 used
(last=178719), 0 locked, 0 protected, 0 dirty
Sep  1 15:18:27 admin kernel:     DIRTY: 10060 buffers, 40240 kbyte, 0 used
(last=0), 0 locked, 0 protected, 10060 dirty
S
        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918597632  3129344        0 15958016 802725888
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          3056 kB
MemShared:           0 kB
Buffers:         15584 kB
Cached:         783912 kB
SwapCached:          0 kB
Active:          55864 kB
Inact_dirty:    742948 kB
Inact_clean:       684 kB
Inact_target:     8188 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          3056 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

And the traces:
83 mostly identical errors showed up, all looking like

Sep  1 15:17:53 admin kernel: cdda2wav: __alloc_pages: 3-order allocation
failed (gfp=0x20/0).
Sep  1 15:17:53 admin kernel: Call Trace: [_alloc_pages+22/24]
[__get_free_pages+10/28] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>]     
Sep  1 15:17:53 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24]
[__get_free_pages+10/28] [<fdcf8826>] [<fdcf88f5>] 
Sep  1 15:17:53 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008]
[do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>]
[do_page_fault+0/1164]
Sep  1 15:17:53 admin kernel:    [dentry_open+189/316] [filp_open+82/92]
[do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]

Trace; fdcf80f5 <[sg]sg_build_reserve+25/48>
Trace; fdcf6589 <[sg]sg_ioctl+6c5/ae4>
Trace; fdcf76bd <[sg]sg_build_indi+55/1a8>

So, there are no 0-order allocs failing in this setup.

Are you content with having no 0-order failures?

I will try to simplify the test to a case that anybody can check out more
easily.
Stay tuned.

Regards,
Stephan

