Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWHJJD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWHJJD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHJJD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:03:26 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:55234 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751475AbWHJJDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:03:25 -0400
Message-ID: <44DAF6A4.9000004@free.fr>
Date: Thu, 10 Aug 2006 11:04:36 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this is a resend, as the original message may be too big to reach the list...]

Le 06.08.2006 12:08, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/26.18-rc3-mm2/

Hello,

On my system, a cron runs every day to check the integrity of
installed RPMS, it runs "rpm -v" on each package, which computes
MD5 hash for each installed file and compares this result, the file 
size and modification time with values stored in RPM database.

This is the workload. Since 2.6.18-rc3-mm2, this processus eats 
all the memory and triggers OOM.

On my system, "free -t" output normally looks like this ("cached" value 
is about half of RAM):
# free -t 
             total       used       free     shared    buffers     cached
Mem:        515032     508512       6520          0      22992     256032
-/+ buffers/cache:     229488     285544
Swap:      1116428        324    1116104
Total:     1631460     508836    1122624

After the rpm database check, "free -t" says:
             total       used       free     shared    buffers     cached
Mem:        515032     507124       7908          0       8132     398296
-/+ buffers/cache:     100696     414336
Swap:      1116428      34896    1081532
Total:     1631460     542020    1089440

And the value of "cached" won't decrease.


This evening, this process trigger OOM-killer. Here is its first report:

syslogd invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
 [show_trace+13/16] show_trace+0xd/0x10
 [<c0104c18>] show_trace+0xd/0x10
 [dump_stack+25/29] dump_stack+0x19/0x1d
 [<c0104c34>] dump_stack+0x19/0x1d
 [out_of_memory+93/422] out_of_memory+0x5d/0x1a6
 [<c013be03>] out_of_memory+0x5d/0x1a6
 [__alloc_pages+505/633] __alloc_pages+0x1f9/0x279
 [<c013d25f>] __alloc_pages+0x1f9/0x279
 [__do_page_cache_readahead+165/495] __do_page_cache_readahead+0xa5/0x1ef
 [<c013e71b>] __do_page_cache_readahead+0xa5/0x1ef
 [do_page_cache_readahead+66/80] do_page_cache_readahead+0x42/0x50
 [<c013ec64>] do_page_cache_readahead+0x42/0x50
 [filemap_nopage+412/882] filemap_nopage+0x19c/0x372
 [<c013afbe>] filemap_nopage+0x19c/0x372
 [__handle_mm_fault+540/1772] __handle_mm_fault+0x21c/0x6ec
 [<c014435d>] __handle_mm_fault+0x21c/0x6ec
 [do_page_fault+397/1158] do_page_fault+0x18d/0x486
 [<c0111e1f>] do_page_fault+0x18d/0x486
 [error_code+57/64] error_code+0x39/0x40
 [<c0293079>] error_code+0x39/0x40
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:63
cpu 0 cold: high 62, batch 15 used:61
Active:1621 inactive:97987 dirty:0 writeback:33 unstable:0 free:1215 slab:23388 mapped:3 pagetables:446
DMA free:2068kB min:88kB low:108kB high:132kB active:0kB inactive:7432kB present:16384kB pages_scanned:11284 all_unreclaimable? yes
lowmem_reserve[]: 0 495
Normal free:2792kB min:2804kB low:3504kB high:4204kB active:6484kB inactive:384516kB present:507824kB pages_scanned:670357
 all_unreclaimable? yes
lowmem_reserve[]: 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2068kB
Normal: 0*4kB 1*8kB 6*16kB 2*32kB 1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2792kB
Swap cache: add 109576, delete 109542, find 12933/22258, race 0+8
Free swap  = 936452kB
Total swap = 1116428kB
Free swap:       936452kB
131052 pages of RAM
0 pages of HIGHMEM
2358 reserved pages
2668 pages shared
34 pages swap cached
0 pages dirty
33 pages writeback
3 pages mapped
23388 pages slab
446 pages pagetables
Out of Memory: Kill process 23392 (seamonkey-bin) score 48523 and children.
Out of memory: Killed process 23392 (seamonkey-bin).


I gather some data before the rpm database check and near the end of it:
- /proc/slabinfo
- /proc/slab_allocators
- /proc/meminfo
- free -t

Please look in http://laurent.riffard.free.fr/2.6.18-rc3-mm2. You'll
find dmesg and .config too.

For information:

/proc/sys/vm/block_dump:0
/proc/sys/vm/dirty_background_ratio:10
/proc/sys/vm/dirty_expire_centisecs:3000
/proc/sys/vm/dirty_ratio:40
/proc/sys/vm/dirty_writeback_centisecs:500
/proc/sys/vm/drop_caches:0
/proc/sys/vm/laptop_mode:0
/proc/sys/vm/legacy_va_layout:0
/proc/sys/vm/lowmem_reserve_ratio:256
/proc/sys/vm/max_map_count:65536
/proc/sys/vm/min_free_kbytes:2896
/proc/sys/vm/nr_pdflush_threads:2
/proc/sys/vm/overcommit_memory:0
/proc/sys/vm/overcommit_ratio:50
/proc/sys/vm/page-cluster:3
/proc/sys/vm/panic_on_oom:0
/proc/sys/vm/percpu_pagelist_fraction:0
/proc/sys/vm/readahead_hit_rate:1
/proc/sys/vm/readahead_ratio:50
/proc/sys/vm/swappiness:60
/proc/sys/vm/swap_prefetch:1
/proc/sys/vm/swap_token_timeout:300
/proc/sys/vm/vdso_enabled:1
/proc/sys/vm/vfs_cache_pressure:100

# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev /dev tmpfs rw 0 0
/dev/vglinux1/lvroot / ext3 rw,data=ordered 0 0
/proc /proc proc rw 0 0
/sys /sys sysfs rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
none /proc/bus/usb usbfs rw 0 0
/dev/hda2 /boot ext2 rw 0 0
/dev/vglinux1/lvhome /home reiserfs rw 0 0
/dev/vglinux1/lvusr /usr reiserfs ro 0 0
/dev/vglinux1/lvvar /var ext3 rw,data=ordered 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0
automount(pid1949) /vol autofs rw,fd=4,pgrp=1949,timeout=5,minproto=2,maxproto=4,indirect 0 0

~~
laurent


