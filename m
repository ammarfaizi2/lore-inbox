Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUKOBa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUKOBa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKOB3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:29:54 -0500
Received: from fep16.inet.fi ([194.251.242.241]:43000 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261410AbUKOB00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:26:26 -0500
Date: Mon, 15 Nov 2004 03:26:20 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrea Arcangeli <andrea@novell.com>
Subject: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
Message-ID: <20041115012620.GA5750@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrea Arcangeli <andrea@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in attempt to make 2.6.9 usable for myself, I have been trying
various patches, including

http://kernel.nic.funet.fi/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/vm-pageout-throttling.patch
http://kernel.nic.funet.fi/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/kswapd_balance
http://kernel.nic.funet.fi/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-3
fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
linux-2.6.9-rik-vmscan-priority.diff
linux-2.6.9-queue_congestion_threshold_hysteresis.diff

this report is probably confusing, have patience with me!

today kernel blew up: many processes were hanging in
throttle_vm_writeout, all I did was trying to view a (big) picture
with qiv: after some disk activity hard disk led stopped blinking and
system got pretty unusable.  however, when I pressed sysrq+e and started
syslog, I got the traces :) [2]  (I don't have serial console.)

this time I had some swapspace on /dev/loop1 (file-backed, reiserfs,
loop-AES-2.2d)...  I think (!) it caused this deadlock.
I have two loopdevices configured for swap: one is /dev/hdd5 and
the other file-backed on reiserfs (/dev/hda6).
They have same priority -- I could NOT reproduce this if I had lower
priority for the file-backed swap or if I had only swap on hdd5
or had no swap at all.

I made a cruel patch which dumps stack+mem info if throttle_vm_writeout
didn't succeed in 20s...  it caught two cases: when those were logged,
there was no disk activity and I think (!) without the "break;" I would
have gotten deadlock. [1]
But next time I tried to reproduce it, it didn't help and I got nothing
in syslog (and I had to reboot).

This is how you can try to reproduce:
1) have one device-backed swap (using loop device (well, I did))
2) have one file-backed swap with the same priority (using loop device)
   e.g.
   head -c333m /dev/zero > /tmp/swapfile00
   losetup /dev/loop1 /tmp/swapfile00 && mkswap /dev/loop1 && swapon -p 5 /dev/loop1
                    ^ pick some unused!                                 ^ remember that

3) write to a file on the same partition file-backed swap resides on
   (not sure if it needs to be on the same partition...)
   cp /dev/zero /tmp
4) start mem-eater program in the same time as 3)

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
int main(void) {
  char* ptr; size_t sz = SIZE_MAX;
  while(sz>1024) {
    ptr = malloc(sz);
    if(ptr != NULL) { fprintf(stderr, "%lu\n", sz); memset(ptr, 42, sz); }
    sz -= (sz >> 6);
  }
  return 0;
}

5) if you see hd led stop blinking, press sysrq+m + sysrq+t,
   fix the bug(s) (if any) and send me the patch :)



--- linux/mm/page-writeback.c.bak	2004-10-29 15:28:50.000000000 +0300
+++ linux/mm/page-writeback.c	2004-11-14 20:47:53.000000000 +0200
@@ -281,7 +281,9 @@ void throttle_vm_writeout(void)
 	struct writeback_state wbs;
 	long background_thresh;
 	long dirty_thresh;
+	unsigned long start;
 
+	start = jiffies;
         for ( ; ; ) {
 		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
 
@@ -294,6 +296,24 @@ void throttle_vm_writeout(void)
                 if (wbs.nr_unstable + wbs.nr_writeback <= dirty_thresh)
                         break;
                 blk_congestion_wait(WRITE, HZ/10);
+		/* get out if we have looped for more than twenty seconds */
+		if (time_after(jiffies, (start + 20*HZ))) {
+			static unsigned long prev_whine;
+
+			/* whine at max once per every ten seconds */
+			if (!prev_whine || time_after(jiffies, (prev_whine + 10*HZ))) {
+				prev_whine = jiffies;
+				printk(KERN_WARNING "throttle_vm_writeout: "
+				       "bailing out after %lu jiffies "
+				       "(wbs=[dirty=%lu unstable=%lu mapped=%lu writeback=%lu] background_thresh=%ld dirty_thresh=%ld\n",
+				       jiffies - start, wbs.nr_dirty, wbs.nr_unstable,
+				       wbs.nr_mapped, wbs.nr_writeback,
+				       background_thresh, dirty_thresh);
+				dump_stack();
+				show_mem();
+			}
+			break;
+		}
         }
 }
 


[1]

Nov 15 00:10:07 safari kernel: throttle_vm_writeout: bailing out after 20079 jiffies (wbs=[dirty=1446 unstable=0 mapped=24796 writeback=22389] background_thresh=6553 dirty_thresh=22347
Nov 15 00:10:07 safari kernel:  [<c0106f4e>] dump_stack+0x1e/0x20
Nov 15 00:10:07 safari kernel:  [<c0142f22>] throttle_vm_writeout+0xf2/0x100
Nov 15 00:10:07 safari kernel:  [<c0148d3d>] shrink_caches+0x5d/0x80
Nov 15 00:10:07 safari kernel:  [<c0148e0d>] try_to_free_pages+0xad/0x1a0
Nov 15 00:10:07 safari kernel:  [<c0141c94>] __alloc_pages+0x264/0x370
Nov 15 00:10:07 safari kernel:  [<c014bcb6>] do_anonymous_page+0x66/0x130
Nov 15 00:10:07 safari kernel:  [<c014bddf>] do_no_page+0x5f/0x250
Nov 15 00:10:07 safari kernel:  [<c014c20c>] handle_mm_fault+0x14c/0x190
Nov 15 00:10:07 safari kernel:  [<c0119635>] do_page_fault+0x1f5/0x620
Nov 15 00:10:07 safari kernel:  [<c0106ba1>] error_code+0x2d/0x38
Nov 15 00:10:07 safari kernel: Mem-info:
Nov 15 00:10:07 safari kernel: DMA per-cpu:
Nov 15 00:10:07 safari kernel: cpu 0 hot: low 2, high 6, batch 1
Nov 15 00:10:07 safari kernel: cpu 0 cold: low 0, high 2, batch 1
Nov 15 00:10:07 safari kernel: Normal per-cpu:
Nov 15 00:10:07 safari kernel: cpu 0 hot: low 30, high 90, batch 15
Nov 15 00:10:07 safari kernel: cpu 0 cold: low 0, high 30, batch 15
Nov 15 00:10:07 safari kernel: HighMem per-cpu: empty
Nov 15 00:10:07 safari kernel: 
Nov 15 00:10:07 safari kernel: Free pages:        1500kB (0kB HighMem)
Nov 15 00:10:07 safari kernel: Active:11110 inactive:45212 dirty:1446 writeback:22389 unstable:0 free:375 slab:3968 mapped:24796 pagetables:901
Nov 15 00:10:07 safari kernel: DMA free:976kB min:32kB low:64kB high:96kB active:540kB inactive:9728kB present:16384kB pages_scanned:96 all_unreclaimable? no
Nov 15 00:10:07 safari kernel: lowmem_reserve[]: 0 240 240
Nov 15 00:10:07 safari kernel: Normal free:524kB min:480kB low:960kB high:1440kB active:43900kB inactive:171120kB present:245760kB pages_scanned:0 all_unreclaimable? no
Nov 15 00:10:07 safari kernel: lowmem_reserve[]: 0 0 0
Nov 15 00:10:07 safari kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 15 00:10:07 safari kernel: lowmem_reserve[]: 0 0 0
Nov 15 00:10:07 safari kernel: DMA: 0*4kB 0*8kB 1*16kB 0*32kB 1*64kB 3*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 976kB
Nov 15 00:10:07 safari kernel: Normal: 61*4kB 9*8kB 1*16kB 2*32kB 2*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 524kB
Nov 15 00:10:07 safari kernel: HighMem: empty
Nov 15 00:10:07 safari kernel: Swap cache: add 1068782, delete 1045449, find 15983/29495, race 2+0
Nov 15 00:10:07 safari kernel: Free swap:        37384kB
Nov 15 00:10:07 safari kernel: 65536 pages of RAM
Nov 15 00:10:07 safari kernel: 0 pages of HIGHMEM
Nov 15 00:10:07 safari kernel: 1819 reserved pages
Nov 15 00:10:07 safari kernel: 19017 pages shared
Nov 15 00:10:07 safari kernel: 23333 pages swap cached


[2]

here the first sysrq+t I captured about this hang... full trace (157 KiB) at
http://safari.iki.fi/hanging.txt


Nov 14 17:31:17 safari kernel: SysRq : Show State
Nov 14 17:31:17 safari kernel: 
Nov 14 17:31:17 safari kernel:                                                sibling
Nov 14 17:31:17 safari kernel:   task             PC      pid father child younger older
Nov 14 17:31:17 safari kernel: init          D C04F2660     0     1      0     2               (NOTLB)
Nov 14 17:31:17 safari kernel: c12afc8c 00000086 c12899e0 c04f2660 00000000 00000000 12df353d c0464268 
Nov 14 17:31:17 safari kernel:        c12afc8c c12afca0 c53510c0 000001fd aa3af952 000120a0 c1289b3c 12dfbc57 
Nov 14 17:31:17 safari kernel:        c12afca0 c0464268 c12afcc8 c03a69da c12afca0 12dfbc57 00000000 c066dd28 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:17 safari kernel:  [<c03a6971>] io_schedule_timeout+0x11/0x20
Nov 14 17:31:17 safari kernel:  [<c02cdca4>] blk_congestion_wait+0x74/0x90
Nov 14 17:31:17 safari kernel:  [<c0142e69>] throttle_vm_writeout+0x29/0x70
Nov 14 17:31:17 safari kernel:  [<c0148cbd>] shrink_caches+0x5d/0x80
Nov 14 17:31:17 safari kernel:  [<c0148d8d>] try_to_free_pages+0xad/0x1a0
Nov 14 17:31:17 safari kernel:  [<c0141ca4>] __alloc_pages+0x264/0x370
Nov 14 17:31:17 safari kernel:  [<c0144a0a>] do_page_cache_readahead+0xda/0x140
Nov 14 17:31:17 safari kernel:  [<c013ea69>] filemap_nopage+0x249/0x330
Nov 14 17:31:17 safari kernel:  [<c014bd99>] do_no_page+0x99/0x250
Nov 14 17:31:17 safari kernel:  [<c014c18c>] handle_mm_fault+0x14c/0x190
Nov 14 17:31:17 safari kernel:  [<c0119635>] do_page_fault+0x1f5/0x620
Nov 14 17:31:17 safari kernel:  [<c0106ba1>] error_code+0x2d/0x38
Nov 14 17:31:17 safari kernel: ksoftirqd/0   S C04F2660     0     2      1             3       (L-TLB)
Nov 14 17:31:17 safari kernel: c12b1fa8 00000046 c1289500 c04f2660 0001209d c12b1f84 c012695a 00000000 
Nov 14 17:31:17 safari kernel:        60d34fff 0001209d c1289020 00000096 60d3764a 0001209d c128965c c12b0000 
Nov 14 17:31:17 safari kernel:        c12aff6c 00000000 c12b1fbc c0126b03 c1289500 00000013 c12b0000 c12b1fec 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0126b03>] ksoftirqd+0x93/0xa0
Nov 14 17:31:17 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: events/0      R running     0     3      1     4       6     2 (L-TLB)
Nov 14 17:31:17 safari kernel: khelper       S C04F2660     0     4      3             5       (L-TLB)
Nov 14 17:31:17 safari kernel: c12cff40 00000046 c1290a00 c04f2660 ffffffff c01042c0 00000000 00000096 
Nov 14 17:31:17 safari kernel:        c253bd5c c12cff40 c2eaeae0 00000284 23b59dd6 0000d47c c1290b5c 00000286 
Nov 14 17:31:17 safari kernel:        c253bd98 c127b748 c12cffbc c0130ecc 00000000 c12cff70 00000000 c127b758 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0130ecc>] worker_thread+0x1ec/0x220
Nov 14 17:31:17 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: kblockd/0     S C04F2660     0     5      3            34     4 (L-TLB)
Nov 14 17:31:17 safari kernel: cfc93f40 00000046 c1290520 c04f2660 cfe1736c cfd0c788 00000000 00000096 
Nov 14 17:31:17 safari kernel:        cfd0c880 cfc93f40 00000096 000016fe 23653922 0001209a c129067c 00000286 
Nov 14 17:31:17 safari kernel:        cfd0c788 c12cb468 cfc93fbc c0130ecc 00000000 cfc93f70 00000000 c12cb478 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0130ecc>] worker_thread+0x1ec/0x220
Nov 14 17:31:17 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: khubd         S C04F2660     0     6      1            33     3 (L-TLB)
Nov 14 17:31:17 safari kernel: cfc95f8c 00000046 c1290040 c04f2660 c0419c40 c0413340 00000068 cfc94000 
Nov 14 17:31:17 safari kernel:        00000000 cfc95f8c c12899e0 00001451 9d8e12cb 0000000f c129019c cfc94000 
Nov 14 17:31:17 safari kernel:        cfc94000 cfc95fb4 cfc95fec c0311cd6 00000009 00000000 cfc94000 00000000 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0311cd6>] hub_thread+0x86/0x100
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: aio/0         S C04F2660     0    34      3           190     5 (L-TLB)
Nov 14 17:31:17 safari kernel: cfccbf40 00000046 cfc9ca40 c04f2660 cfcca000 cfc9ca40 cfcca000 cfccbf40 
Nov 14 17:31:17 safari kernel:        c012dac3 00010000 c12899e0 00001da4 cf162d88 00000008 cfc9cb9c cfcca000 
Nov 14 17:31:17 safari kernel:        00000000 fffffff6 cfccbfbc c0130ecc 00000011 cfccbf70 00000000 c1309898 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0130ecc>] worker_thread+0x1ec/0x220
Nov 14 17:31:17 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: kswapd0       D C04F2660     0    33      1           109     6 (L-TLB)
Nov 14 17:31:17 safari kernel: cfcc9e64 00000046 c130a060 c04f2660 c0513900 00000000 cfcc9e68 cfcc9e50 
Nov 14 17:31:17 safari kernel:        c0122a5f cfcc9e78 c7f06500 00000148 aa3ad3f1 000120a0 c130a1bc 12dfbc57 
Nov 14 17:31:17 safari kernel:        cfcc9e78 c0464268 cfcc9ea0 c03a69da cfcc9e78 12dfbc57 00000246 c2bc9cd8 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:17 safari kernel:  [<c03a6971>] io_schedule_timeout+0x11/0x20
Nov 14 17:31:17 safari kernel:  [<c02cdca4>] blk_congestion_wait+0x74/0x90
Nov 14 17:31:17 safari kernel:  [<c0142e69>] throttle_vm_writeout+0x29/0x70
Nov 14 17:31:17 safari kernel:  [<c014904f>] balance_pgdat+0x1cf/0x2a0
Nov 14 17:31:17 safari kernel:  [<c01491dd>] kswapd+0xbd/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: kseriod       S C04F2690     0   109      1           826    33 (L-TLB)
Nov 14 17:31:17 safari kernel: cfcdff8c 00000046 c1289500 c04f2690 00000008 c0413340 00000068 cfcde000 
Nov 14 17:31:17 safari kernel:        e751db42 00000008 c1289500 00006ae3 eca5e045 00000008 cfcb4bbc cfcde000 
Nov 14 17:31:17 safari kernel:        cfcde000 cfcdffb4 cfcdffec c02bca86 0000000f 00000008 cfcde000 00000000 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c02bca86>] serio_thread+0x86/0x110
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: reiserfs/0    S C04F2660     0   190      3          3555    34 (L-TLB)
Nov 14 17:31:17 safari kernel: cfd0ff40 00000046 cfcb4580 c04f2660 cfd0ff28 c013d342 00000000 00000096 
Nov 14 17:31:17 safari kernel:        d0841120 cfd0ff40 00000096 00000985 9642195a 0001207f cfcb46dc 00000286 
Nov 14 17:31:17 safari kernel:        cfd5f000 cfd3c848 cfd0ffbc c0130ecc 00000000 cfd0ff70 00000000 cfd3c858 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c0130ecc>] worker_thread+0x1ec/0x220
Nov 14 17:31:17 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: udevd         S C04F2B08     0   826      1          2408   109 (NOTLB)
Nov 14 17:31:17 safari kernel: cf499eac 00000082 cf4705c0 c04f2b08 0000d47c c033a66a c041a704 00000001 
Nov 14 17:31:17 safari kernel:        4c8db269 0000d47c cf4705c0 0000da29 4c8db269 0000d47c cf1461fc 00000000 
Nov 14 17:31:17 safari kernel:        7fffffff 00000006 cf499ee8 c03a6a26 cf499ed0 c03414a2 cf41ac40 cf5dd8b8 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a6a26>] schedule_timeout+0xa6/0xb0
Nov 14 17:31:17 safari kernel:  [<c016cf96>] do_select+0x256/0x290
Nov 14 17:31:17 safari kernel:  [<c016d25d>] sys_select+0x24d/0x4e0
Nov 14 17:31:17 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
Nov 14 17:31:17 safari kernel: loop7         S C04F2660     0  2408      1          2733   826 (L-TLB)
Nov 14 17:31:17 safari kernel: ce7d9f6c 00000046 ce671060 c04f2660 0000003f ceca8600 c0985560 00000000 
Nov 14 17:31:17 safari kernel:        cda33000 ce7d9f5c cccb0aa0 000432da f0a5c203 00012097 ce6711bc 00000000 
Nov 14 17:31:17 safari kernel:        00000000 cda33000 ce7d9fec d0c6f2e4 cda33000 cfd94c20 00000001 c8c48000 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<d0c6f2e4>] loop_thread+0x124/0x540 [loop]
Nov 14 17:31:17 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:17 safari kernel: dhclient      S C04F2660     0  2733      1          3074  2408 (NOTLB)
Nov 14 17:31:17 safari kernel: ccd23eac 00000086 cccffa20 c04f2660 cccffa20 00000010 00000000 000000d0 
Nov 14 17:31:17 safari kernel:        8910dd18 ccd23ec0 00000246 00000fee 892027dc 00011961 cccffb7c 13056dcf 
Nov 14 17:31:17 safari kernel:        ccd23ec0 00000005 ccd23ee8 c03a69da ccd23ec0 13056dcf cf650ce0 c0514aa8 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:17 safari kernel:  [<c016cf96>] do_select+0x256/0x290
Nov 14 17:31:17 safari kernel:  [<c016d25d>] sys_select+0x24d/0x4e0
Nov 14 17:31:17 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
Nov 14 17:31:17 safari kernel: syslogd       D C04F2660     0  3074      1          3089  2733 (NOTLB)
Nov 14 17:31:17 safari kernel: ccc71d14 00000086 ccc23060 c04f2660 ccc71d2c 00000001 c0464268 ccc71cfc 
Nov 14 17:31:17 safari kernel:        c01229af ccc71d28 c7f06020 000001d0 aa49a1fd 000120a0 ccc231bc 12dfbc58 
Nov 14 17:31:17 safari kernel:        ccc71d28 c0464268 ccc71d50 c03a69da ccc71d28 12dfbc58 ccc71db0 c1e53ca0 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:17 safari kernel:  [<c03a6971>] io_schedule_timeout+0x11/0x20
Nov 14 17:31:17 safari kernel:  [<c02cdca4>] blk_congestion_wait+0x74/0x90
Nov 14 17:31:17 safari kernel:  [<c0142e69>] throttle_vm_writeout+0x29/0x70
Nov 14 17:31:17 safari kernel:  [<c0148cbd>] shrink_caches+0x5d/0x80
Nov 14 17:31:17 safari kernel:  [<c0148d8d>] try_to_free_pages+0xad/0x1a0
Nov 14 17:31:17 safari kernel:  [<c0141ca4>] __alloc_pages+0x264/0x370
Nov 14 17:31:17 safari kernel:  [<c0141dcb>] __get_free_pages+0x1b/0x40
Nov 14 17:31:17 safari kernel:  [<c016cc10>] __pollwait+0x80/0xc0
Nov 14 17:31:17 safari kernel:  [<c03414a2>] datagram_poll+0xe2/0xf0
Nov 14 17:31:17 safari kernel:  [<c033b2d7>] sock_poll+0x27/0x30
Nov 14 17:31:17 safari kernel:  [<c016ceac>] do_select+0x16c/0x290
Nov 14 17:31:17 safari kernel:  [<c016d25d>] sys_select+0x24d/0x4e0
Nov 14 17:31:17 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
Nov 14 17:31:17 safari kernel: klogd         D C04F2660     0  3089      1          3217  3074 (NOTLB)
Nov 14 17:31:17 safari kernel: cd105d30 00000082 cccb00e0 c04f2660 d0c6f1bc cfd0cce0 00000000 cd105d28 
Nov 14 17:31:17 safari kernel:        c0152988 cfd0c230 c1056f20 00002dcd 3fac0e66 00012088 cccb023c c1056f20 
Nov 14 17:31:17 safari kernel:        c1200980 cd105d6c cd105d38 c03a694e cd105d90 c013dabb c1056f20 c1056f20 
Nov 14 17:31:17 safari kernel: Call Trace:
Nov 14 17:31:17 safari kernel:  [<c03a694e>] io_schedule+0xe/0x20
Nov 14 17:31:17 safari kernel:  [<c013dabb>] __lock_page+0xeb/0x100
Nov 14 17:31:17 safari kernel:  [<c014ba99>] do_swap_page+0xf9/0x230
Nov 14 17:31:17 safari kernel:  [<c014c168>] handle_mm_fault+0x128/0x190
Nov 14 17:31:17 safari kernel:  [<c0119635>] do_page_fault+0x1f5/0x620
Nov 14 17:31:17 safari kernel:  [<c0106ba1>] error_code+0x2d/0x38
Nov 14 17:31:17 safari kernel:  [<c015a17f>] vfs_read+0xcf/0x150
Nov 14 17:31:17 safari kernel:  [<c015a49b>] sys_read+0x4b/0x80
Nov 14 17:31:17 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
...
Nov 14 17:31:18 safari kernel: loop1         D C04F2690     0   849      1          1243   636 (L-TLB)
Nov 14 17:31:18 safari kernel: c8027c78 00000046 ca74a5e0 c04f2690 0001207f 00000000 cb195bfc c8027c74 
Nov 14 17:31:18 safari kernel:        911d8718 0001207f ca74a5e0 00004024 91273fb4 0001207f cb3b36dc d0bbf048 
Nov 14 17:31:18 safari kernel:        cb3b3580 00000246 c8027cb0 c03a6004 d0bbf050 00000001 cb3b3580 c011e910 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a6004>] __down+0x64/0xc0
Nov 14 17:31:18 safari kernel:  [<c03a615a>] __down_failed+0xa/0x10
Nov 14 17:31:18 safari kernel:  [<c01bff87>] .text.lock.journal+0x63/0xec
Nov 14 17:31:18 safari kernel:  [<c01be300>] journal_begin+0x70/0xf0
Nov 14 17:31:18 safari kernel:  [<c01ab1a8>] reiserfs_dirty_inode+0x58/0xa0
Nov 14 17:31:18 safari kernel:  [<c0179886>] __mark_inode_dirty+0xe6/0x1c0
Nov 14 17:31:18 safari kernel:  [<c0173bbb>] inode_update_time+0xcb/0xd0
Nov 14 17:31:18 safari kernel:  [<c01a5bf7>] reiserfs_file_write+0x1e7/0x760
Nov 14 17:31:18 safari kernel:  [<d0c6ea57>] loop_file_io+0x37/0xf0 [loop]
Nov 14 17:31:18 safari kernel:  [<d0c6ec21>] do_bio_filebacked+0x111/0x2a0 [loop]
Nov 14 17:31:18 safari kernel:  [<d0c6f481>] loop_thread+0x2c1/0x540 [loop]
Nov 14 17:31:18 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
...
Nov 14 17:31:18 safari kernel: pdflush       D C04F2690     0  4212      3         30030  3556 (L-TLB)
Nov 14 17:31:18 safari kernel: c192df00 00000046 cb06ca00 c04f2690 00012088 00000000 00000000 cb06ca00 
Nov 14 17:31:18 safari kernel:        a0faaf64 00012088 cb06ca00 00002770 a0fbb2ca 00012088 cf470bfc cf0a964c 
Nov 14 17:31:18 safari kernel:        cf470aa0 00000246 c192df38 c03a6004 cf0a9654 00000001 cf470aa0 c011e910 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a6004>] __down+0x64/0xc0
Nov 14 17:31:18 safari kernel:  [<c03a615a>] __down_failed+0xa/0x10
Nov 14 17:31:18 safari kernel:  [<c0161355>] .text.lock.super+0x90/0x1ab
Nov 14 17:31:18 safari kernel:  [<c015ba9c>] do_sync+0x3c/0x90
Nov 14 17:31:18 safari kernel:  [<c01439b4>] __pdflush+0xa4/0x190
Nov 14 17:31:18 safari kernel:  [<c0143ac8>] pdflush+0x28/0x30
Nov 14 17:31:18 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:18 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:18 safari kernel: thttpd        D C04F2660     0  4331   3793                     (NOTLB)
Nov 14 17:31:18 safari kernel: c7019d44 00000082 c7ee2b00 c04f2660 c0464268 c7019d24 c01229af c0513900 
Nov 14 17:31:18 safari kernel:        00000000 c7019d58 cbfe05e0 00000214 aa3caad2 000120a0 c7ee2c5c 12dfbc57 
Nov 14 17:31:18 safari kernel:        c7019d58 c0464268 c7019d80 c03a69da c7019d58 12dfbc57 c7019dfc c5dd9d14 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:18 safari kernel:  [<c03a6971>] io_schedule_timeout+0x11/0x20
Nov 14 17:31:18 safari kernel:  [<c02cdca4>] blk_congestion_wait+0x74/0x90
Nov 14 17:31:18 safari kernel:  [<c0142e69>] throttle_vm_writeout+0x29/0x70
Nov 14 17:31:18 safari kernel:  [<c0148cbd>] shrink_caches+0x5d/0x80
Nov 14 17:31:18 safari kernel:  [<c0148d8d>] try_to_free_pages+0xad/0x1a0
Nov 14 17:31:18 safari kernel:  [<c0141ca4>] __alloc_pages+0x264/0x370
Nov 14 17:31:18 safari kernel:  [<c0141dcb>] __get_free_pages+0x1b/0x40
Nov 14 17:31:18 safari kernel:  [<c016cc10>] __pollwait+0x80/0xc0
Nov 14 17:31:18 safari kernel:  [<c0365a58>] tcp_poll+0x108/0x1a0
Nov 14 17:31:18 safari kernel:  [<c033b2d7>] sock_poll+0x27/0x30
Nov 14 17:31:18 safari kernel:  [<c016d580>] do_pollfd+0x90/0xa0
Nov 14 17:31:18 safari kernel:  [<c016d5ed>] do_poll+0x5d/0xc0
Nov 14 17:31:18 safari kernel:  [<c016d7c1>] sys_poll+0x171/0x230
Nov 14 17:31:18 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
...
Nov 14 17:31:18 safari kernel: pdflush       D C04F2660     0 30030      3         30056  4212 (L-TLB)
Nov 14 17:31:18 safari kernel: c7213c10 00000046 cc7db600 c04f2660 00000000 c7213c10 cd01fd28 c721007b 
Nov 14 17:31:18 safari kernel:        c012007b c7213c24 ce671540 00000176 aa3bcf6f 000120a0 cc7db75c 12dfbc57 
Nov 14 17:31:18 safari kernel:        c7213c24 c0464268 c7213c4c c03a69da c7213c24 12dfbc57 00000246 cc6fbd48 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a69da>] schedule_timeout+0x5a/0xb0
Nov 14 17:31:18 safari kernel:  [<c03a6971>] io_schedule_timeout+0x11/0x20
Nov 14 17:31:18 safari kernel:  [<c02cdca4>] blk_congestion_wait+0x74/0x90
Nov 14 17:31:18 safari kernel:  [<c0142e69>] throttle_vm_writeout+0x29/0x70
Nov 14 17:31:18 safari kernel:  [<c0148cbd>] shrink_caches+0x5d/0x80
Nov 14 17:31:18 safari kernel:  [<c0148d8d>] try_to_free_pages+0xad/0x1a0
Nov 14 17:31:18 safari kernel:  [<c0141ca4>] __alloc_pages+0x264/0x370
Nov 14 17:31:18 safari kernel:  [<c013dc46>] find_or_create_page+0x66/0x90
Nov 14 17:31:18 safari kernel:  [<c015c6c0>] grow_dev_page+0x30/0x110
Nov 14 17:31:18 safari kernel:  [<c015c85e>] __getblk_slow+0xbe/0x160
Nov 14 17:31:18 safari kernel:  [<c015cc63>] __getblk+0x63/0x70
Nov 14 17:31:18 safari kernel:  [<c01bf55e>] do_journal_end+0x15e/0xb24
Nov 14 17:31:18 safari kernel:  [<c01be968>] journal_end_sync+0x48/0xb0
Nov 14 17:31:18 safari kernel:  [<c01aa5bd>] reiserfs_sync_fs+0x4d/0x70
Nov 14 17:31:18 safari kernel:  [<c016081b>] sync_supers+0x7b/0x80
Nov 14 17:31:18 safari kernel:  [<c0142fe7>] wb_kupdate+0x27/0x110
Nov 14 17:31:18 safari kernel:  [<c01439b4>] __pdflush+0xa4/0x190
Nov 14 17:31:18 safari kernel:  [<c0143ac8>] pdflush+0x28/0x30
Nov 14 17:31:18 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:18 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:18 safari kernel: qiv           S C04F2660     0 30045    647               29977 (NOTLB)
Nov 14 17:31:18 safari kernel: c1c67eac 00000082 c0c56500 c04f2660 c0c56500 00000010 00000000 000000d0 
Nov 14 17:31:18 safari kernel:        4810c3a2 00000000 c58eb5e0 00009159 49e6c5f1 0001207f c0c5665c 00000000 
Nov 14 17:31:18 safari kernel:        7fffffff 00000004 c1c67ee8 c03a6a26 c1c67ed0 c03a2da0 c34f6740 ca419918 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a6a26>] schedule_timeout+0xa6/0xb0
Nov 14 17:31:18 safari kernel:  [<c016cf96>] do_select+0x256/0x290
Nov 14 17:31:18 safari kernel:  [<c016d25d>] sys_select+0x24d/0x4e0
Nov 14 17:31:18 safari kernel:  [<c0106153>] syscall_call+0x7/0xb
Nov 14 17:31:18 safari kernel: pdflush       D C04F2660     0 30056      3               30030 (L-TLB)
Nov 14 17:31:18 safari kernel: c0a33f00 00000046 cb06ca00 c04f2660 00000000 00000000 00000000 cf591878 
Nov 14 17:31:18 safari kernel:        cf591870 00000000 00000001 00018874 f5b7f75a 00012088 cb06cb5c cf0a964c 
Nov 14 17:31:18 safari kernel:        cb06ca00 00000246 c0a33f38 c03a6004 cf0a9654 00000001 cb06ca00 c011e910 
Nov 14 17:31:18 safari kernel: Call Trace:
Nov 14 17:31:18 safari kernel:  [<c03a6004>] __down+0x64/0xc0
Nov 14 17:31:18 safari kernel:  [<c03a615a>] __down_failed+0xa/0x10
Nov 14 17:31:18 safari kernel:  [<c0161355>] .text.lock.super+0x90/0x1ab
Nov 14 17:31:18 safari kernel:  [<c015ba9c>] do_sync+0x3c/0x90
Nov 14 17:31:18 safari kernel:  [<c01439b4>] __pdflush+0xa4/0x190
Nov 14 17:31:18 safari kernel:  [<c0143ac8>] pdflush+0x28/0x30
Nov 14 17:31:18 safari kernel:  [<c013475a>] kthread+0x9a/0xe0
Nov 14 17:31:18 safari kernel:  [<c01042c5>] kernel_thread_helper+0x5/0x10
Nov 14 17:31:18 safari kernel: SysRq : SAK
Nov 14 17:31:18 safari kernel: SAK: killed process 510 (bash): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 555 (bash): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 556 (startx): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 568 (xinit): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 569 (X): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 593 (wmaker): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 626 (wmaker): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 630 (xephem): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 632 (wmweather+): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 633 (wmload): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 634 (xscreensaver): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 635 (wmnet): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 636 (wmclock): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SysRq : Emergency Sync
Nov 14 17:31:18 safari last message repeated 6 times
Nov 14 17:31:18 safari kernel: SysRq : SAK
Nov 14 17:31:18 safari kernel: SAK: killed process 510 (bash): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 555 (bash): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 556 (startx): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 568 (xinit): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 569 (X): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 593 (wmaker): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 626 (wmaker): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 630 (xephem): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 632 (wmweather+): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 633 (wmload): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 634 (xscreensaver): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 635 (wmnet): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SAK: killed process 636 (wmclock): p->signal->session==tty->session
Nov 14 17:31:18 safari kernel: SysRq : Emergency Sync
Nov 14 17:31:18 safari kernel: SysRq : Terminate All Tasks
Nov 14 17:31:18 safari kernel: Emergency Sync complete
Nov 14 17:31:18 safari kernel: Emergency Sync complete
Nov 14 17:31:18 safari kernel: SysRq : SAK
Nov 14 17:31:18 safari kernel: SAK: killed process 30199 (mingetty): p->signal->session==tty->session

-- 
--More--

