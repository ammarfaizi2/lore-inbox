Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUHENAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUHENAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUHEM7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:59:41 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:23753 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S267218AbUHEMzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:55:22 -0400
Message-ID: <41122E29.10306@sdl.hitachi.co.jp>
Date: Thu, 05 Aug 2004 21:55:05 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <Pine.LNX.4.58.0408020806210.13053@dhcp030.home.surriel.com> <41121265.8000909@sdl.hitachi.co.jp>
In-Reply-To: <41121265.8000909@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tested --mm kernels for no thrashing situation by our benchmark
suit.

In 2.6.8-rc2-mm2, overhead of page_refernced_one() decreases in shared
memory access. Additionally, it seems that token based thrashing
control patch has not bad effect in no thrashing situation.


** Overview of workload

Benchmark program creates workload processes that alternate disk IO
with shared memory access.



** Detailed environment of performance evaluation

 - Hardware
   CPU: Xeon 1.6GHz * 4
   Memory: 4GB
   HDD: IDE ATA100 

 - The benchmark suit
   The benchmark suit is the wblg-disk 1.0.2, which I have released on
   SourceForge. You can get from following URL.


   <http://sourceforge.net/project/showfiles.php?group_id=110454&package_id=119281>. 

 - Configuration of benchmark suit
   + number of workload process: 640 processes
   + read/write ratio: read 0% / write 100%
   + file IO size: 1KB - 256KB (random) 

   + Shard memory regions: 1.6GB * 1 
     All workload processes share one shared memory region.
   + Each process repeats 4 byte memory access each 4KB.

   Measurement time: 3 hour
   Measurement items: write throughput

 - Other configurations
   Using Oprofile 
   Issue vmstat command each 1 minute


** Results of performance evaluation

* result of benchmark
                        write throughput [MB/s]
        2.6.8-rc2-mm1:  2.08
        2.6.8-rc2-mm2:  2.10

* result of vmstat
                        swap in (min-max)(kB/s) swap out (min-max)(kB/s)
        2.6.8-rc2-mm1:  0 - 9                   0 - 9         
        2.6.8-rc2-mm2:  0 - 1                   0 - 1         

* Results of Oprofile

  - system profiling (top 2)

    2.6.8-rc2-mm1:
        No.     samples         %               
        1       252096016       81.1833 wblg-disk_client
        2        55708450       17.94   vmlinux-2.6.8-rc2-mm1

    2.6.8-rc2-mm2:
        No.     samples         %
        1       180452715       84.9684 wblg-disk_client
        2        29715808       13.9921 vmlinux-2.6.8-rc2-mm2

  - kernel profiling (top 10) 

    Ratio of page_referenced_one() and kmap_atomic() decreased. Ratio
    of copy_page_range(), page_fault(), and refill_inactive_zone()
    increased.

    2.6.8-rc2-mm1:
        No.     samples         %       symbol name
        1       24952210        44.7907 page_referenced_one
        2        6924133        12.4292 kmap_atomic
        3        2751806         4.9397 flush_tlb_page
        4        1466868         2.6331 copy_page_range
        5        1362218         2.4453 try_atomic_semop
        6        1042919         1.8721 mark_offset_tsc
        7         820792         1.4734 page_fault
        8         633105         1.1365 vma_prio_tree_next
        9         586925         1.0536 update_queue
        10        576520         1.0349 __copy_from_user_ll

    2.6.8-rc2-mm2:
        No.     samples         %       symbol name
        1       10778546        36.2721 page_referenced_one
        2        2821678         9.4955 kmap_atomic
        3        1526580         5.1373 copy_page_range
        4        1400807         4.714  flush_tlb_page
        5         753029         2.5341 mark_offset_tsc
        6         724207         2.4371 page_fault
        7         461152         1.5519 refill_inactive_zone
        8         436286         1.4682 __copy_from_user_ll
        9         395080         1.3295 ext3_find_entry
        10        341127         1.148  apic_timer_interrupt

Best regards,
Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.


