Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTCOE1U>; Fri, 14 Mar 2003 23:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTCOE1U>; Fri, 14 Mar 2003 23:27:20 -0500
Received: from holomorphy.com ([66.224.33.161]:7888 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261390AbTCOE1S>;
	Fri, 14 Mar 2003 23:27:18 -0500
Date: Fri, 14 Mar 2003 20:37:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315043744.GM1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38yvixvlz.fsf@lexa.home.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 10:20:24AM +0300, Alex Tomas wrote:
> and corrected patch:

This patch is a godsend. Whoever's listening, please apply!

dbench on 32x/48G NUMA-Q, aic7xxx adapter, pbay disk, 32K PAGE_SIZE
(pgcl was used for benchmark feasibility purposes)

throughput:
---------- 
before:
Throughput 61.5376 MB/sec 512 procs
dbench 512  637.21s user 15739.41s system 565% cpu 48:16.28 total

after:
Throughput 104.074 MB/sec 512 procs
(GRR, didn't do time, took ca. 30 minutes)

profile:
--------
before:
vma      samples    %-age       symbol name
c0106ff4 160824916  45.1855     default_idle
c01dbfd0  49993575  14.0462     __copy_to_user_ll
c01dc038  15474349   4.34768    __copy_from_user_ll
c0108140  13603867   3.82215    .text.lock.semaphore
c0119058  10872716   3.0548     try_to_wake_up
c02647f0   7896052   2.21848    sync_buffer
c011a1bc   7539112   2.11819    schedule
c0119dac   7168574   2.01409    scheduler_tick
c011fadc   6053745   1.70086    profile_hook
c0119860   4759523   1.33724    load_balance
c0107d0c   4472105   1.25649    __down
c011c4ff   4159010   1.16852    .text.lock.sched
c013dd28   3026705   0.850385   .text.lock.vmscan
c013ece4   3016788   0.847599   check_highmem_ptes
c0113590   2406329   0.676084   mark_offset_tsc
c02649c0   2210485   0.621059   add_event_entry
c010f6b8   2195748   0.616919   timer_interrupt
c0133118   1696204   0.476566   find_get_page

after:
vma        samples  %-age       symbol name
c0106ff4   52751908 30.8696     default_idle
c01dc3b0   28988721 16.9637     __copy_to_user_ll
c01dc418    8240854  4.82242    __copy_from_user_ll
c011e472    8044716  4.70764    .text.lock.fork
c0264bd0    5666004  3.31566    sync_buffer
c013dd28    4454362  2.60662    .text.lock.vmscan
c0119058    4291999  2.51161    try_to_wake_up
c0119dac    4055412  2.37316    scheduler_tick
c011fadc    3554019  2.07976    profile_hook
c011a1bc    2866025  1.67715    schedule
c0119860    2637644  1.54351    load_balance
c0108140    2433644  1.42413    .text.lock.semaphore
c0264da0    1406704  0.823181   add_event_entry
c011c9a4    1370708  0.802117   prepare_to_wait
c0185e20    1236390  0.723516   ext2_new_block
c011c4ff    1227452  0.718285   .text.lock.sched
c013ece4    1148317  0.671977   check_highmem_ptes
c0113590    1145881  0.670551   mark_offset_tsc


vmstat (short excerpt, edited for readability):
------
before:
procs -----------memory---------- -----io---- --system-- ----cpu----
 r  b     free    buff    cache     bi   bo    in   cs    us sy id wa
12  5   38747168 484672  9049088    20  4032  1171 13148   1 22 65 12
11 11   38767264 479168  9034304    20  2908  1180 13077   1 28 52 19
 9 14   38764256 480000  9036512    24  1920  1164 13940   1 23 51 25
 7  7   38764128 480832  9035360    12  4444  1191 13784   1 24 51 24
 9  5   38764512 481664  9033024    16  2924  1220 13853   1 23 66 10
 9  6   38762208 482816  9035904     0  3404  1186 13686   1 25 62 12

after:
procs -----------memory---------- -----io---- --system-- ----cpu----
 r  b     free    buff    cache     bi    bo   in    cs   us sy id wa
60 11   38659840 533920  9226720   100  1672  2760  1853   5 66 11 18
31 23   38565472 531264  9320384   240  1020  1195  1679   2 35 37 26
23 23   38384928 521952  9503104   772  3372  5624  5093   2 62  9 27
24 31   37945664 518080  9916448  1536  5808 10449 13484   1 45 13 41
31 86   37755072 516096 10091104  1040  1916  3672  9744   2 51 15 32
24 30   37644352 512864 10192960   900  1612  3184  8414   2 49 12 36

There's a lot of odd things going on in both of the vmstat logs.


I've also collected logs of top slab consumers every 10s and full
dbench output for both runs, if that's interesting to anyone.


-- wli
