Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271953AbRH2MIU>; Wed, 29 Aug 2001 08:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271955AbRH2MIN>; Wed, 29 Aug 2001 08:08:13 -0400
Received: from ns.ithnet.com ([217.64.64.10]:15634 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271953AbRH2MIA>;
	Wed, 29 Aug 2001 08:08:00 -0400
Date: Wed, 29 Aug 2001 14:07:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: roger.larsson@skelleftea.mail.telia.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010829140706.3fcb735c.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I managed it again. As with previous 2.4-releases I managed to let __alloc_pages fail quite easily with pretty standard test bed:

Hardware: 2 x P-III 1GHz, 1 GB RAM, 29160 U160 SCSI, 36GB HD
Kernel: 2.4.10-pre2 with trace output in mm/page_alloc.c (thanks Roger)

Test:
exported reiserfs filesystem, simply copying files on it from a 2.2.19 nfs client (files are big 10-20 MB each).
at the same time I read a CD to HD via xcdroast and run setiathome on nice-level 19.

meminfo before test:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 90714112 831012864        0  6696960 36126720
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:        811536 kB
MemShared:           0 kB
Buffers:          6540 kB
Cached:          35280 kB
SwapCached:          0 kB
Active:           3640 kB
Inact_dirty:     38180 kB
Inact_clean:         0 kB
Inact_target:      824 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:        811536 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

Everything runs acceptable, but CPU-Load is high (6-8). Simply "cat /proc/meminfo" takes half a minute sometimes during test. Mouse cannot be moved smoothly during the whole test.
When xcdroast is finished with reading CD (at about 1 MB/sec speed, not very fast indeed) the following shows up:

Aug 29 13:43:34 admin kernel: >] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
Aug 29 13:43:34 admin kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=0, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
Aug 29 13:43:34 admin kernel:    [system_call+51/56] 

meminfo at this point:
        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918597632  3129344        0  8036352 812560384
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          3056 kB
MemShared:           0 kB
Buffers:          7848 kB
Cached:         793516 kB
SwapCached:          0 kB
Active:          47396 kB
Inact_dirty:    750120 kB
Inact_clean:      3848 kB
Inact_target:     5736 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          3056 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

Unfortunately I cannot tell what pid 1207 is, for it is gone when I do a ps afterwards. This test setup shows vm errors on every 2.4 I tested so far, but on various occasions, all 2.4 below 10-pre1 fail during reading / writing. All 10-pre-x fail afterwards. If I can provide additional information please tell me. I am very willing to test anything you like with chances it doesn't corrupt my filesystems ;-)
Another thing worth mentioning: NFS server fails in this test if I do not use export-option "no_subtree_check". I found this out with very friendly help from Neil Brown. It fails _only_ on exported reiserfs, though. It would be nice if someone could investigate this (maybe Hans?).

BTW this same test never (mem) fails on 2.2.19 and has far less CPU load and lower memory consumption.

Regards, Stephan

