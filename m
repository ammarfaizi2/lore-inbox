Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVLGKcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVLGKcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVLGKcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:32:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:2757 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750819AbVLGKcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:32:09 -0500
Date: Wed, 7 Dec 2005 18:58:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 05/16] mm: balance zone aging in kswapd reclaim path
Message-ID: <20051207105805.GA7203@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105004.018561000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207105004.018561000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the new testing reports. The intermittent and concurrent copy of two
files is expected to generate large range of unreclaimable pages.

The balance seems to improve a lot since last version. And the direct reclaim
times is reduced to minimal.

IN QEMU
=======
root ~# grep (age |rounds) /proc/zoneinfo
        rounds   142
        age      3621
        rounds   142
        age      3499
        rounds   142
        age      3502

root ~# ./show-aging-rate.sh
Linux (none) 2.6.15-rc5-mm1 #8 SMP Wed Dec 7 16:06:47 CST 2005 i686 GNU/Linux
             total       used       free     shared    buffers     cached
Mem:          1138       1119         18          0          0       1105
-/+ buffers/cache:         14       1124
Swap:            0          0          0

---------------------------------------------------------------
active/inactive size ratios:
    DMA0:  469 / 1000 =       621 /      1323
 Normal0:  374 / 1000 =     58588 /    156523
HighMem0:  397 / 1000 =     18880 /     47498

active/inactive scan rates:
     DMA:  273 / 1000 =       58528 / (     210464 +        3296)
  Normal:  342 / 1000 =     7851552 / (   22838944 +       94080)
 HighMem:  393 / 1000 =     2680480 / (    6774304 +       31040)

---------------------------------------------------------------
inactive size ratios:
    DMA0 /  Normal0:   85 / 10000 =      1334 /    156630
 Normal0 / HighMem0: 32946 / 10000 =    156630 /     47540

inactive scan rates:
     DMA /   Normal:   93 / 10000 = (     210464 +        3296) / (   22838944 +       94080)
  Normal /  HighMem: 33698 / 10000 = (   22838944 +       94080) / (    6774304 +       31040)

root ~# grep -E '(low|high|free|protection:) ' /proc/zoneinfo
  pages free     1161
        low      21
        high     25
        protection: (0, 0, 880, 1140)
  pages free     3505
        low      1173
        high     1408
        protection: (0, 0, 0, 2080)
  pages free     189
        low      134
        high     203
        protection: (0, 0, 0, 0)

root ~# vmstat 5 10
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0  18556    344 1131720    0    0    16     5 1042    37  4 66 30  0
 2  0      0  18616    352 1132324    0    0     0    16 1035    48  6 94  0  0
 2  0      0  19060    348 1131512    0    0     0     3  974    52  6 94  0  0
 2  0      0  18256    268 1132272    0    0     0     8 1018    50  6 94  0  0
 2  0      0  19096    248 1132020    0    0     0     3 1009    49  6 94  0  0
 2  0      0  19520    248 1130524    0    0     0     8  989    50  6 94  0  0
 2  0      0  18916    248 1131680    0    0     0     3 1008    49  6 94  0  0
 1  0      0  18436    208 1132740    0    0     0     7 1009    64  4 96  0  0
 2  0      0  18976    200 1132272    0    0     0    14 1029    64  5 95  0  0
 2  0      0  19156    200 1131932    0    0     0     8  992    48  6 94  0  0

root ~# cat /proc/vmstat
nr_dirty 9
nr_writeback 0
nr_unstable 0
nr_page_table_pages 22
nr_mapped 971
nr_slab 1405
pgpgin 68177
pgpgout 21820
pswpin 0
pswpout 0
pgalloc_high 4338439
pgalloc_normal 15416448
pgalloc_dma32 0
pgalloc_dma 157690
pgfree 19917495
pgactivate 10660320
pgdeactivate 10582874
pgkeephot 53405
pgkeepcold 17
pgfault 145079
pgmajfault 116
pgrefill_high 2707872
pgrefill_normal 7936896
pgrefill_dma32 0
pgrefill_dma 59392
pgsteal_high 4264660
pgsteal_normal 15171368
pgsteal_dma32 0
pgsteal_dma 155635
pgscan_kswapd_high 6843616
pgscan_kswapd_normal 23067616
pgscan_kswapd_dma32 0
pgscan_kswapd_dma 212352
pgscan_direct_high 31040
pgscan_direct_normal 94080
pgscan_direct_dma32 0
pgscan_direct_dma 3296
pginodesteal 0
slabs_scanned 128
kswapd_steal 19582040
kswapd_inodesteal 0
pageoutrun 547184
allocstall 274
pgrotated 8
nr_bounce 0


ON A REAL BOX
=============
root@Server ~# grep (age |rounds) /proc/zoneinfo
        rounds   164
        age      410
        rounds   150
        age      396
        rounds   150
        age      396

root@Server ~# ./show-aging-rate.sh
Linux Server 2.6.15-rc5-mm1 #9 SMP Wed Dec 7 16:47:56 CST 2005 i686 GNU/Linux
             total       used       free     shared    buffers     cached
Mem:          2020       1970         50          0          5       1916
-/+ buffers/cache:         48       1972
Swap:            0          0          0

---------------------------------------------------------------
active/inactive size ratios:
    DMA0:  132 / 1000 =       123 /       930
 Normal0:  161 / 1000 =     28022 /    173838
HighMem0:  177 / 1000 =     43935 /    247952

active/inactive scan rates:
     DMA:  170 / 1000 =       23889 / (     118528 +       21216)
  Normal:  210 / 1000 =     5296960 / (   24645696 +      484160)
 HighMem:  239 / 1000 =     8501024 / (   34741600 +      752000)

---------------------------------------------------------------
inactive size ratios:
    DMA0 /  Normal0:   53 / 10000 =       930 /    173838
 Normal0 / HighMem0: 7010 / 10000 =    173838 /    247952

inactive scan rates:
     DMA /   Normal:   55 / 10000 = (     118528 +       21216) / (   24645696 +      484160)
  Normal /  HighMem: 7080 / 10000 = (   24645696 +      484160) / (   34741600 +      752000)

pageoutrun / allocstall = 73374 / 100 = 1072730 / 1461
