Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVLFN4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVLFN4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLFN4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:56:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:28820 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932135AbVLFN43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:56:29 -0500
Date: Tue, 6 Dec 2005 22:19:22 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 05/13] mm: balance zone aging in kswapd reclaim path
Message-ID: <20051206141922.GA8179@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051206135608.860737000@localhost.localdomain> <20051206135804.825753000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206135804.825753000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a simple test.
It concurrently copies two sparse files of 601M/1.6G in qemu.

The balance is not good enough for now, but is expected to improve much when
shrink_zone() scans small enough in one run(say, < nr_inactive/100).

RESULTS
=======
root ~# ./show-aging-rate.sh
Linux (none) 2.6.15-rc5-mm1 #4 SMP Tue Dec 6 21:27:36 CST 2005 i686 GNU/Linux
             total       used       free     shared    buffers     cached
Mem:          1138       1119         18          0          0       1104
-/+ buffers/cache:         14       1123
Swap:            0          0          0

---------------------------------------------------------------
active/inactive size ratios:
    DMA0:   78 / 1000 =       141 /      1803
 Normal0:  372 / 1000 =     58453 /    156728
HighMem0:  415 / 1000 =     19471 /     46875

active/inactive scan rates:
     DMA:   45 / 1000 =        3238 / (      61920 +        9280)
  Normal:  279 / 1000 =     1509888 / (    5272608 +      133024)
 HighMem:  437 / 1000 =      645536 / (    1430112 +       44032)

---------------------------------------------------------------
inactive size ratios:
    DMA0 /  Normal0:  115 / 10000 =      1803 /    156733
 Normal0 / HighMem0: 33420 / 10000 =    156733 /     46896

inactive scan rates:
     DMA /   Normal:  131 / 10000 = (      61920 +        9280) / (    5272608 +      133024)
  Normal /  HighMem: 36669 / 10000 = (    5272608 +      133024) / (    1430112 +       44032)
root ~# grep "age " /proc/zoneinfo
        age      3085
        age      3072
        age      3072
root ~# grep -E '(low|high|free|protection:) ' /proc/zoneinfo
  pages free     1161
        low      21
        high     25
        protection: (0, 0, 880, 1140)
  pages free     3420
        low      1173
        high     1408
        protection: (0, 0, 0, 2080)
  pages free     132
        low      134
        high     203
        protection: (0, 0, 0, 0)
root ~# vmstat 5 10
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0  19544    200 1130844    0    0    40     9 1102    61  6 86  7  1
 1  4      0  16936    208 1133012    0    0     0    22 1043    30  7 93  0  0
 1  0      0  19404    208 1130904    0    0     0     8  994    83  5 95  0  0
 1  0      0  19152    160 1130612    0    0     0     8 1018    85  3 93  0  3
 2  0      0  19152    160 1130952    0    0     0     8  997    56  5 95  0  0
 2  0      0  18372    168 1131896    0    0     0     3 1000    50  5 95  0  0
 1  0      0  18672    112 1131544    0    0     0     7 1014    70  5 95  0  0
 1  0      0  19320    112 1131204    0    0     0     2  989    81  4 96  0  0
 2  0      0  19152    108 1131276    0    0     1     0  996    79  5 95  0  0
 2  0      0  18216     96 1132444    0    0     0     8 1015    84  5 95  0  0

pages_high+lowmem_reserve
203 + 1408 + 2080 + 25 + 1140 = 4856 (x4 = 19424)

SCRIPTS
=======
# cat test-aging2
#!/bin/zsh

while true
do
        cp cold /dev/null
        sleep $((RANDOM%20))
done &

while true
do
        cp hot /dev/null
        sleep $((RANDOM%10))
done

# cat show-aging-rate.sh
#!/bin/sh

uname -a
free -m

echo
echo ---------------------------------------------------------------
echo active/inactive size ratios:

egrep '(zone|active|inactive)' /proc/zoneinfo |
while true
do
        read a b c d
        [[ -z $a ]] && break
        if [[ $c = "zone" ]]; then
                prev_node=$node
                prev_zone=$zone
                node=${b%,}
                zone=$d$node
        else
                eval $a=$b
                if [[ $a = "inactive" ]]; then
                        printf "%8s: %4d / 1000 = %9d / %9d\n" $zone \
                                $((active * 1000 / (1 + inactive))) \
                                $active $inactive
                fi
        fi
done

while true
do
        read name value
        [[ -z $name ]] && break
        eval $name=$value
done < /proc/vmstat

echo
echo active/inactive scan rates:

printf "     DMA: %4d / 1000 = %11d / (%11d + %11d)\n" \
        $((pgrefill_dma * 1000 / (1 + pgscan_kswapd_dma + pgscan_direct_dma))) \
        $pgrefill_dma $pgscan_kswapd_dma $pgscan_direct_dma

[[ $pgscan_kswapd_dma32 != 0 ]] && \
printf "   DMA32: %4d / 1000 = %11d / (%11d + %11d)\n" \
        $((pgrefill_dma32 * 1000 / (1 + pgscan_kswapd_dma32 + pgscan_direct_dma32))) \
        $pgrefill_dma32 $pgscan_kswapd_dma32 $pgscan_direct_dma32

printf "  Normal: %4d / 1000 = %11d / (%11d + %11d)\n" \
        $((pgrefill_normal * 1000 / (1 + pgscan_kswapd_normal + pgscan_direct_normal))) \
        $pgrefill_normal $pgscan_kswapd_normal $pgscan_direct_normal

[[ $pgscan_kswapd_high != 0 ]] && \
printf " HighMem: %4d / 1000 = %11d / (%11d + %11d)\n" \
        $((pgrefill_high * 1000 / (1 + pgscan_kswapd_high + pgscan_direct_high))) \
        $pgrefill_high $pgscan_kswapd_high $pgscan_direct_high

echo
echo ---------------------------------------------------------------
echo inactive size ratios:

egrep '(zone|inactive)' /proc/zoneinfo |
while true
do
        read a b c d
        [[ -z $a ]] && break
        if [[ $c = "zone" ]]; then
                prev_node=$node
                prev_zone=$zone
                node=${b%,}
                zone=$d$node
        else
                prev_inactive=$inactive
                eval $a=$b
                if [[ $prev_node = $node ]]; then
                        printf "%8s / %8s: %4d / 10000 = %9d / %9d\n" \
                                $prev_zone $zone \
                                $((prev_inactive * 10000 / (1 + inactive))) \
                                $prev_inactive $inactive
                fi
        fi
done

echo
echo inactive scan rates:

[[ $pgscan_kswapd_dma != 0 ]] && \
printf "%8s / %8s: %4d / 10000 = (%11d + %11d) / (%11d + %11d)\n" \
        "DMA" "Normal" \
        $(((1 + pgscan_kswapd_dma + pgscan_direct_dma)* 10000 /\
        (1 + pgscan_kswapd_normal + pgscan_direct_normal))) \
        $pgscan_kswapd_dma $pgscan_direct_dma \
        $pgscan_kswapd_normal $pgscan_direct_normal

[[ $pgscan_kswapd_dma32 != 0 ]] && \
printf "%8s / %8s: %4d / 10000 = (%11d + %11d) / (%11d + %11d)\n" \
        "DMA32" "Normal" \
        $(((1 + pgscan_kswapd_dma32 + pgscan_direct_dma32)* 10000 /\
        (1 + pgscan_kswapd_normal + pgscan_direct_normal))) \
        $pgscan_kswapd_dma32 $pgscan_direct_dma32 \
        $pgscan_kswapd_normal $pgscan_direct_normal

[[ $pgscan_kswapd_high != 0 ]] && \
printf "%8s / %8s: %4d / 10000 = (%11d + %11d) / (%11d + %11d)\n" \
        "Normal" "HighMem" \
        $(((1 + pgscan_kswapd_normal + pgscan_direct_normal)* 10000 /\
        (1 + pgscan_kswapd_high + pgscan_direct_high))) \
        $pgscan_kswapd_normal $pgscan_direct_normal \
        $pgscan_kswapd_high $pgscan_direct_high
