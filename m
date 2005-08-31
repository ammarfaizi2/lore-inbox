Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVHaQZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVHaQZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVHaQZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:25:56 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:30919 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S964863AbVHaQZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:25:55 -0400
Date: Wed, 31 Aug 2005 16:25:43 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <4315A179.8070102@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508311524190.16574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <4315A179.8070102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Nick Piggin wrote:

> Holger Kiehl wrote:
>
>> 3236497 total                                      1.4547
>> 2507913 default_idle                             52248.1875
>> 158752 shrink_zone                               43.3275
>> 121584 copy_user_generic_c                      3199.5789
>>  34271 __wake_up_bit                            713.9792
>>  31131 __make_request                            23.1629
>>  22096 scsi_request_fn                           18.4133
>>  21915 rotate_reclaimable_page                   80.5699
>           ^^^^^^^^^
>
> I don't think this function should be here. This indicates that
> lots of writeout is happening due to pages falling off the end
> of the LRU.
>
> There was a bug recently causing memory estimates to be wrong
> on Opterons that could cause this I think.
>
> Can you send in 2 dumps of /proc/vmstat taken 10 seconds apart
> while you're writing at full speed (with 2.6.13 or the latest
> -git tree).
>
I took 2.6.13, there where no git snapshots at www.kernel.org when
I looked. With 2.6.13 I must load the Fusion MPT driver as module.
Compiling it in it does not detect the drive correctly, as module
there is no problem.

Here is what I did:

    #!/bin/bash

    time dd if=/dev/full of=/dev/sdc1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdd1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sde1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdf1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdg1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdh1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdi1 bs=4M count=4883 &
    time dd if=/dev/full of=/dev/sdj1 bs=4M count=4883 &

    sleep 20

    cat /proc/vmstat > /root/vmstat-1.dump

    sleep 10

    cat /proc/vmstat > /root/vmstat-2.dump
    cat /proc/zoneinfo > /root/zoneinfo.dump
    cat /proc/meminfo > /root/meminfo.dump

    exit 0

vmstat-1.dump:

    nr_dirty 787282
    nr_writeback 44317
    nr_unstable 0
    nr_page_table_pages 633
    nr_mapped 6373
    nr_slab 53030
    pgpgin 263362
    pgpgout 5260352
    pswpin 0
    pswpout 0
    pgalloc_high 0
    pgalloc_normal 2448628
    pgalloc_dma 1041
    pgfree 2457343
    pgactivate 5775
    pgdeactivate 2113
    pgfault 465679
    pgmajfault 321
    pgrefill_high 0
    pgrefill_normal 5940
    pgrefill_dma 33
    pgsteal_high 0
    pgsteal_normal 148759
    pgsteal_dma 0
    pgscan_kswapd_high 0
    pgscan_kswapd_normal 153813
    pgscan_kswapd_dma 1089
    pgscan_direct_high 0
    pgscan_direct_normal 0
    pgscan_direct_dma 0
    pginodesteal 0
    slabs_scanned 0
    kswapd_steal 148759
    kswapd_inodesteal 0
    pageoutrun 5304
    allocstall 0
    pgrotated 0
    nr_bounce 0

vmstat-2.dump:

    nr_dirty 786397
    nr_writeback 44233
    nr_unstable 0
    nr_page_table_pages 640
    nr_mapped 6406
    nr_slab 53027
    pgpgin 263382
    pgpgout 7835732
    pswpin 0
    pswpout 0
    pgalloc_high 0
    pgalloc_normal 3091687
    pgalloc_dma 2420
    pgfree 3101327
    pgactivate 5817
    pgdeactivate 2918
    pgfault 466269
    pgmajfault 322
    pgrefill_high 0
    pgrefill_normal 28265
    pgrefill_dma 150
    pgsteal_high 0
    pgsteal_normal 789909
    pgsteal_dma 1388
    pgscan_kswapd_high 0
    pgscan_kswapd_normal 904101
    pgscan_kswapd_dma 4950
    pgscan_direct_high 0
    pgscan_direct_normal 0
    pgscan_direct_dma 0
    pginodesteal 0
    slabs_scanned 1152
    kswapd_steal 791297
    kswapd_inodesteal 0
    pageoutrun 28299
    allocstall 0
    pgrotated 562
    nr_bounce 0

zoneinfo.dump:

    Node 3, zone   Normal
      pages free     899
            min      726
            low      907
            high     1089
            active   3996
            inactive 490989
            scanned  0 (a: 16 i: 0)
            spanned  524287
            present  524287
            protection: (0, 0, 0)
      pagesets
        cpu: 0 pcp: 0
                  count: 2
                  low:   62
                  high:  186
                  batch: 31
        cpu: 0 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       10186
                numa_miss:      3313
                numa_foreign:   0
                interleave_hit: 10136
                local_node:     0
                other_node:     13499
        cpu: 1 pcp: 0
                  count: 13
                  low:   62
                  high:  186
                  batch: 31
        cpu: 1 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       6559
                numa_miss:      1668
                numa_foreign:   0
                interleave_hit: 6559
                local_node:     0
                other_node:     8227
        cpu: 2 pcp: 0
                  count: 84
                  low:   62
                  high:  186
                  batch: 31
        cpu: 2 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5579
                numa_miss:      12806
                numa_foreign:   0
                interleave_hit: 5579
                local_node:     0
                other_node:     18385
        cpu: 3 pcp: 0
                  count: 93
                  low:   62
                  high:  186
                  batch: 31
        cpu: 3 pcp: 1
                  count: 55
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       834769
                numa_miss:      1
                numa_foreign:   940192
                interleave_hit: 5563
                local_node:     834770
                other_node:     0
      all_unreclaimable: 0
      prev_priority:     12
      temp_priority:     12
      start_pfn:         1572864
    Node 2, zone   Normal
      pages free     1036
            min      726
            low      907
            high     1089
            active   360
            inactive 501700
            scanned  0 (a: 26 i: 0)
            spanned  524287
            present  524287
            protection: (0, 0, 0)
      pagesets
        cpu: 1 pcp: 0
                  count: 91
                  low:   62
                  high:  186
                  batch: 31
        cpu: 1 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       6002
                numa_miss:      15490
                numa_foreign:   0
                interleave_hit: 6002
                local_node:     0
                other_node:     21492
        cpu: 2 pcp: 0
                  count: 75
                  low:   62
                  high:  186
                  batch: 31
        cpu: 2 pcp: 1
                  count: 56
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       410692
                numa_miss:      0
                numa_foreign:   76064
                interleave_hit: 5223
                local_node:     410692
                other_node:     0
        cpu: 3 pcp: 0
                  count: 73
                  low:   62
                  high:  186
                  batch: 31
        cpu: 3 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5163
                numa_miss:      288909
                numa_foreign:   1
                interleave_hit: 5152
                local_node:     0
                other_node:     294072
      all_unreclaimable: 0
      prev_priority:     12
      temp_priority:     12
      start_pfn:         1048576
    Node 1, zone   Normal
      pages free     859
            min      703
            low      878
            high     1054
            active   1224
            inactive 485043
            scanned  0 (a: 14 i: 0)
            spanned  507903
            present  507760
            protection: (0, 0, 0)
      pagesets
        cpu: 0 pcp: 0
                  count: 1
                  low:   62
                  high:  186
                  batch: 31
        cpu: 0 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       9443
                numa_miss:      15475
                numa_foreign:   18446604437880297808
                interleave_hit: 18446604437880307200
                local_node:     1
                other_node:     24917
        cpu: 1 pcp: 0
                  count: 181
                  low:   62
                  high:  186
                  batch: 31
        cpu: 1 pcp: 1
                  count: 38
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       368191
                numa_miss:      0
                numa_foreign:   39046
                interleave_hit: 5967
                local_node:     368191
                other_node:     0
        cpu: 2 pcp: 0
                  count: 85
                  low:   62
                  high:  186
                  batch: 31
        cpu: 2 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5139
                numa_miss:      18963
                numa_foreign:   0
                interleave_hit: 5139
                local_node:     0
                other_node:     24102
        cpu: 3 pcp: 0
                  count: 92
                  low:   62
                  high:  186
                  batch: 31
        cpu: 3 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5124
                numa_miss:      363472
                numa_foreign:   0
                interleave_hit: 5115
                local_node:     0
                other_node:     368596
      all_unreclaimable: 0
      prev_priority:     12
      temp_priority:     12
      start_pfn:         524288
    Node 0, zone      DMA
      pages free     2045
            min      5
            low      6
            high     7
            active   0
            inactive 992
            scanned  0 (a: 2 i: 2)
            spanned  4096
            present  3994
            protection: (0, 2031, 2031)
      pagesets
        cpu: 0 pcp: 0
                  count: 1
                  low:   2
                  high:  6
                  batch: 1
        cpu: 0 pcp: 1
                  count: 1
                  low:   0
                  high:  2
                  batch: 1
                numa_hit:       18446604437880298786
                numa_miss:      18446604442220017848
                numa_foreign:   0
                interleave_hit: 0
                local_node:     7567460
                other_node:     0
      all_unreclaimable: 0
      prev_priority:     12
      temp_priority:     12
      start_pfn:         0
    Node 0, zone   Normal
      pages free     1052
            min      721
            low      901
            high     1081
            active   845
            inactive 480162
            scanned  0 (a: 2 i: 0)
            spanned  520191
            present  520191
            protection: (0, 0, 0)
      pagesets
        cpu: 0 pcp: 0
                  count: 96
                  low:   62
                  high:  186
                  batch: 31
        cpu: 0 pcp: 1
                  count: 50
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       18446604437880708763
                numa_miss:      18446604439958819000
                numa_foreign:   29590
                interleave_hit: 9679
                local_node:     7977309
                other_node:     0
        cpu: 1 pcp: 0
                  count: 88
                  low:   62
                  high:  186
                  batch: 31
        cpu: 1 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       6206
                numa_miss:      21831
                numa_foreign:   0
                interleave_hit: 6206
                local_node:     0
                other_node:     28037
        cpu: 2 pcp: 0
                  count: 65
                  low:   62
                  high:  186
                  batch: 31
        cpu: 2 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5367
                numa_miss:      44135
                numa_foreign:   0
                interleave_hit: 5365
                local_node:     0
                other_node:     49502
        cpu: 3 pcp: 0
                  count: 92
                  low:   62
                  high:  186
                  batch: 31
        cpu: 3 pcp: 1
                  count: 0
                  low:   0
                  high:  62
                  batch: 31
                numa_hit:       5544
                numa_miss:      286378
                numa_foreign:   0
                interleave_hit: 5507
                local_node:     0
                other_node:     291922
      all_unreclaimable: 0
      prev_priority:     12
      temp_priority:     12
      start_pfn:         4096

meminfo.dump:

    MemTotal:      8124172 kB
    MemFree:         23564 kB
    Buffers:       7825944 kB
    Cached:          19216 kB
    SwapCached:          0 kB
    Active:          25708 kB
    Inactive:      7835548 kB
    HighTotal:           0 kB
    HighFree:            0 kB
    LowTotal:      8124172 kB
    LowFree:         23564 kB
    SwapTotal:    15631160 kB
    SwapFree:     15631160 kB
    Dirty:         3145604 kB
    Writeback:      176452 kB
    Mapped:          25624 kB
    Slab:           212116 kB
    CommitLimit:  19693244 kB
    Committed_AS:    85112 kB
    PageTables:       2560 kB
    VmallocTotal: 34359738367 kB
    VmallocUsed:     16288 kB
    VmallocChunk: 34359721635 kB

Thanks,
Holger

