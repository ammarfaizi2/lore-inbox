Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267631AbUHEK7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267631AbUHEK7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbUHEK6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:58:24 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:15081 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S267631AbUHEK4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:56:48 -0400
Message-ID: <41121265.8000909@sdl.hitachi.co.jp>
Date: Thu, 05 Aug 2004 19:56:37 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <Pine.LNX.4.58.0408020806210.13053@dhcp030.home.surriel.com>
In-Reply-To: <Pine.LNX.4.58.0408020806210.13053@dhcp030.home.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Rik van Riel wrote:

> I would really appreciate any testing results on this, both good
> and bad.  I want to get this thing tuned and into a generally good
> shape for use by everybody upstream.
> 
> I'm especially interested in how this affects compute servers,
> desktops and heavily overloaded network servers (the "spamassassin
> slowed my system to a crawl" symptom would be one to test ;)).
> 
> I suspect the patch may need some tweaking to help interactivity
> in some cases, but maybe it'll already work magically by itself...

To evaluate your patch, I tested -mm kernels for thrashing generated
by our benchmark suit.

In 2.6.8-rc2-mm2, performance of application increased, and overhead
of kernel decreased.


** Overview of workload

 Benchmark program creates disk I/O processes and shared memory access
 processes. Generating disk I/O and shared memory access at the same
 time.



** Detailed environment of performance evaluation

 - Hardware
   CPU: Xeon 1.6GHz * 4
   Memory: 2GB
   HDD: IDE ATA100 

 - The benchmark suit 
   The benchmark suit is the wblg-disk, which I have released on
   SourceForge.

   <http://sourceforge.net/project/showfiles.php?group_id=110454&package_id=119281> 
   # I used alpha version (1.0.3-alpha) in this test.
   # I will release 1.0.3 soon.

 - configuration of benchmark
   1. disk IO workload
     + number of process: 4 processes
     + read/write ratio: read 0% / write 100%
     + file IO size: 1KB - 256KB (random) 

   2. memory access workload
     + number of process: 32 processes
     + Shard memory regions: 512MB * 4 
     + Each process accesses one shared memory region.
       (8 processes share one shared memory region.)
     + Each process repeats 4 byte memory access each 4KB.

   Measurement time: 1 hour
   Measurement items: write throughput

 - Other configurations
   Using Oprofile 
   Issue vmstat command each 1 minute



** Results of performance evaluation

* result of benchmark
                        write throughput [MB/s]
        2.6.8-rc2-mm1:  2.39
        2.6.8-rc2-mm2:  2.68


* result of vmstat
                        swap in(kB/s)   swap out(kB/s)
        2.6.8-rc2-mm1:  0 - 641         0 - 583         
        2.6.8-rc2-mm2:  0 - 727         0 - 684         


* results of Oprofile

  - System profiling (top 2)

    Overhead of kernel decreased by 3.9%.

    2.6.8-rc2-mm1:
        No.     samples         %               
        1.      170981153       77.6102 wblg-disk_client
        2.       46808551       21.2469 vmlinux-2.6.8-rc2-mm1

    2.6.8-rc2-mm2:
        No.     samples         %               
        1.      179798682       81.6102 wblg-disk_client
        2.       38141112       17.3122 vmlinux-2.6.8-rc2-mm2


  - Kernel profiling (top 10) 

    Ratio of page_referenced_one() and kmap_atomic() decreased.

    2.6.8-rc2-mm1:
        No.     samples         %       symbol name
        1       11398599        24.3515 page_referenced_one
        2        5652276        12.0753 kmap_atomic
        3        2257662         4.8232 sysenter_past_esp
        4        2098275         4.4827 flush_tlb_others
        5        1467288         3.1347 __copy_to_user_ll
        6        1167740         2.4947 page_address
        7        1145108         2.4464 page_fault
        8         946909         2.0229 flush_tlb_page
        9         889151         1.8995 do_gettimeofday
        10        828174         1.7693 refill_inactive_zone

    2.6.8-rc2-mm2:
        No.     samples         %       symbol name
        1        6057840        15.8827 page_referenced_one
        2        3707571         9.7207 kmap_atomic
        3        2531840         6.6381 sysenter_past_esp
        4        1707017         4.4755 __copy_to_user_ll
        5        1328610         3.4834 flush_tlb_others
        6        1233726         3.2346 page_fault
        7        1140917         2.9913 do_gettimeofday
        8         970534         2.5446 get_offset_tsc
        9         759579         1.9915 mark_offset_tsc
        10        650208         1.7047 page_address


Best regards,
Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

