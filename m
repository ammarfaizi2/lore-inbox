Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVLGNFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVLGNFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLGNFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:05:24 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:15746 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751026AbVLGNFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:05:23 -0500
Date: Wed, 7 Dec 2005 21:32:22 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 05/16] mm: balance zone aging in kswapd reclaim path
Message-ID: <20051207133222.GA6141@mail.ustc.edu.cn>
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

Here is another testing on 512M desktop. This time only a big sparse file copy.

- The inactive_list balance is perfectly maintained
- The active_list is scanned a bit more, for the calculation is performed after
  the scan, when the nr_inactive is made a little smaller
- direct reclaims near to zero, good or evil?

wfg ~% grep (age |rounds) /proc/zoneinfo
        rounds   100
        age      659
        rounds   100
        age      621

wfg ~% show-aging-rate.sh
Linux lark 2.6.15-rc5-mm1 #9 SMP Wed Dec 7 16:47:56 CST 2005 i686 GNU/Linux
             total       used       free     shared    buffers     cached
Mem:           501        475         26          0          6        278
-/+ buffers/cache:        189        311
Swap:          127          2        125

---------------------------------------------------------------
active/inactive size ratios:
    DMA0:   75 / 1000 =       161 /      2135
 Normal0: 1074 / 1000 =     59046 /     54936

active/inactive scan rates:
     DMA:   31 / 1000 =        7867 / (     246784 +           0)
  Normal:  974 / 1000 =     5847744 / (    6001216 +         128)

---------------------------------------------------------------
inactive size ratios:
    DMA0 /  Normal0:  388 / 10000 =      2135 /     54936

inactive scan rates:
     DMA /   Normal:  411 / 10000 = (     246784 +           0) / (    6001216 +         128)

pageoutrun / allocstall = 4140780 / 100 = 207039 / 4

wfg ~% vmstat 5 10
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0   2612   6408   7280 293960    0    1   122    13 1178  1415 14  9 75  2
 1  0   2612   6404   2144 298144    0    0   190    35 1159  1675 11 89  0  0
 1  0   2612   6216   2052 299596    0    0   442     8 1189  1612 10 90  0  0
 1  0   2612   5916   2032 299888    0    0   326     0 1182  1713 10 90  0  0
 1  3   2612   6528   3252 297240    0    0   795     6 1275  1464 10 53  0 37
 0  0   2612   5648   3644 298480    0    0   739    14 1261  1203 14 23 39 24
[the big cp stops about here]
 0  0   2612   5784   3660 298532    0    0     0    17 1130  1322 10  3 87  0
 0  0   2612   5952   3692 298500    0    0     6     4 1137  1343  9  2 87  2
 0  0   2612   5976   3700 298492    0    0     2     3 1143  1327  7  1 91  0
 0  0   2612   6000   3700 298492    0    0     0     0 1138  1315  7  2 91  0
