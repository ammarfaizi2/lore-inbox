Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270758AbRH1LYM>; Tue, 28 Aug 2001 07:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270772AbRH1LYD>; Tue, 28 Aug 2001 07:24:03 -0400
Received: from ns.ithnet.com ([217.64.64.10]:43526 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S270758AbRH1LXs>;
	Tue, 28 Aug 2001 07:23:48 -0400
Date: Tue, 28 Aug 2001 13:22:59 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
Message-Id: <20010828132259.1a2405c9.skraw@ithnet.com>
In-Reply-To: <200108251929.f7PJT5Q06766@mailf.telia.com>
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com>
	<200108250055.f7P0tGh28170@mailg.telia.com>
	<20010825135508.5afe1988.skraw@ithnet.com>
	<200108251929.f7PJT5Q06766@mailf.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001 21:24:40 +0200
Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:

> I would like to see from were these higher order allocs comes from.
> Please insert something like this:
> 
>                 printk("pid=%d; __alloc_pages(gfp=0x%x, order=%ld, ...)\n", 
> current->pid, gfp_mask, order);
>                 show_trace(NULL);

Ok, Roger (and all the others involved).
I am back with new tests for memory problems.
Current test setup is:

software: 2.4.10-pre1 with Marco Tosatti's latest mem patch.
hardware: P3 1GHz 1 GB RAM, Adaptec SCSI, IBM 36GB HD 100MBit Tulip (roughly :-)

I copy files from via NFS to the machine on a reiserfs partition and read a CD (with xcdroast) to the same partition (reading an image). A note on that: NFS is exported with option no_subtree_check, because otherwise it fails on low mem condition and truncates files. This effect _only_ shows when exporting a reiserfs filesystem, on ext2 works well. Thanks to Neil Brown for helping me find this out.

meminfo before test:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 92602368 829124608        0  6684672 37040128
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:        809692 kB
MemShared:           0 kB
Buffers:          6528 kB
Cached:          36172 kB
SwapCached:          0 kB
Active:           3672 kB
Inact_dirty:     39028 kB
Inact_clean:         0 kB
Inact_target:      704 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:        809692 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

First experience during test: CPU load is pretty high (varying around 6 - 8), sometimes results from "cat /proc/meminfo" take half a minute to show up.
Anyway, everything runs ok (besides the fact that it looks slow) until reading the CD is done. Then this shows up:

Aug 28 13:08:20 admin kernel: __alloc_pages: 3-order allocation failed. 
Aug 28 13:08:20 admin kernel: pid=1139; __alloc_pages(gfp=0x20, order=3, ...)
Aug 28 13:08:20 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>]
Aug 28 13:08:20 admin kernel:    [<fdcec0f5>] [<fdcea589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>]
Aug 28 13:08:20 admin kernel:    [<fdceb6bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdce94aa>] [do_page_fault+0/1164]
Aug 28 13:08:20 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]
Aug 28 13:08:20 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 28 13:08:20 admin kernel: pid=1139; __alloc_pages(gfp=0x20, order=3, ...)
Aug 28 13:08:20 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>]
Aug 28 13:08:20 admin kernel:    [<fdcec0f5>] [<fdcea589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>]
Aug 28 13:08:20 admin kernel:    [<fdceb6bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdce94aa>] [do_page_fault+0/1164]
Aug 28 13:08:20 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]
Aug 28 13:08:20 admin kernel: __alloc_pages: 3-order allocation failed. 
Aug 28 13:08:20 admin kernel: pid=1139; __alloc_pages(gfp=0x20, order=3, ...)
Aug 28 13:08:20 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>]
Aug 28 13:08:20 admin kernel:    [<fdcec0f5>] [<fdcea589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>]
Aug 28 13:08:20 admin kernel:    [<fdceb6bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdce94aa>] [do_page_fault+0/1164]
Aug 28 13:08:20 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]
Aug 28 13:08:20 admin kernel: __alloc_pages: 3-order allocation failed. 
Aug 28 13:08:20 admin kernel: pid=1139; __alloc_pages(gfp=0x20, order=3, ...)
Aug 28 13:08:20 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 28 13:08:20 admin kernel:    [<fdcec0f5>] [<fdcea589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>]
Aug 28 13:08:20 admin kernel:    [<fdceb6bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdce94aa>] [do_page_fault+0/1164]
Aug 28 13:08:20 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]
Aug 28 13:08:20 admin kernel: __alloc_pages: 3-order allocation failed. 
Aug 28 13:08:20 admin kernel: pid=1139; __alloc_pages(gfp=0x20, order=3, ...)
Aug 28 13:08:20 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>]
Aug 28 13:08:20 admin kernel:    [<fdcec0f5>] [<fdcea589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] 
Aug 28 13:08:20 admin kernel:    [<fdceb6bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdce94aa>] [do_page_fault+0/1164]
Aug 28 13:08:20 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56]

meminfo shows:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918597632  3129344        0 26300416 783720448
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          3056 kB
MemShared:           0 kB
Buffers:         25684 kB
Cached:         765352 kB
SwapCached:          0 kB
Active:          66372 kB
Inact_dirty:    723020 kB
Inact_clean:      1644 kB
Inact_target:     5708 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          3056 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

I was a bit surprised by the kernel errors. I just wanted to start the CD compare to image, but these problems showed up before that.

If I can do any additional debugging, tell me. There are some unresolved addresses above, maybe I made some mistake with System.map (name System.map-2.4.10-pre1 should be ok, isn't it?)

Regards,
Stephan

