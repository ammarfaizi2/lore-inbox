Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWATAni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWATAni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161422AbWATAni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:43:38 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24016 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161428AbWATAnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:43:37 -0500
Date: Fri, 20 Jan 2006 00:42:19 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <43CFE77B.3090708@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0601200011190.15823@skynet>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
 <43CFE77B.3090708@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Joel Schopp wrote:

> > Benchmark comparison between -mm+NoOOM tree and with the new zones
>
> I know you had also previously posted a very simplified version of your real
> fragmentation avoidance patches.  I was curious if you could repost those with
> the other benchmarks for a 3 way comparison.  The simplified version got rid
> of a lot of the complexity people were complaining about and in my mind still
> seems like preferable direction.
>

To satisfy this request, I did a quick rebase of the list-based approach
against 2.6.16-rc1-mm1 to have a comparable set of benchmarks. I will post
the patches in the morning after a re-read.

The results here are in three sets

Set 1: -mm3 Vs list-based anti-frag
Set 2: -mm3 Vs zone-based anti-frag
Set 3: list-based anti-frag Vs zone-based anti-frag

In the headers, list-based is called mbuddy-v22. Zone based is called
zbuddy-v3 (versions 1 and 2 were only posted to lhms-devel)

>>> BEGIN SET 1: -clean Vs mbuddy-v22 <<<
                               2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-mbuddy-v22
Time taken to extract kernel:                    14                         15
Time taken to build kernel:                     741                        741

                 2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-mbuddy-v22
 1 creat-clo                 12273.11                   12239.80     -33.31 -0.27% File Creations and Closes/second
 2 page_test                131762.75                  134311.90    2549.15  1.93% System Allocations & Pages/second
 3 brk_test                 586206.90                  597167.14   10960.24  1.87% System Memory Allocations/second
 4 jmp_test                4375520.75                 4373004.50   -2516.25 -0.06% Non-local gotos/second
 5 signal_test               79436.76                   77307.56   -2129.20 -2.68% Signal Traps/second
 6 exec_test                    62.90                      62.93       0.03  0.05% Program Loads/second
 7 fork_test                  1211.92                    1218.13       6.21  0.51% Task Creations/second
 8 link_test                  4332.30                    4324.56      -7.74 -0.18% Link/Unlink Pairs/second

                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-mbuddy-v22
Order                                        10                         10
Allocation type                         HighMem                    HighMem
Attempted allocations                       275                        275
Success allocs                               60                         86
Failed allocs                               215                        189
DMA zone allocs                               1                          1
Normal zone allocs                            5                          0
HighMem zone allocs                          54                         85
EasyRclm zone allocs                          0                          0
% Success                                    21                         31
HighAlloc Under Load Test Results Pass 2
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-mbuddy-v22
Order                                        10                         10
Allocation type                         HighMem                    HighMem
Attempted allocations                       275                        275
Success allocs                              101                        103
Failed allocs                               174                        172
DMA zone allocs                               1                          1
Normal zone allocs                            5                          0
HighMem zone allocs                          95                        102
EasyRclm zone allocs                          0                          0
% Success                                    36                         37
HighAlloc Test Results while Rested
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-mbuddy-v22
Order                                        10                         10
Allocation type                         HighMem                    HighMem
Attempted allocations                       275                        275
Success allocs                              141                        242
Failed allocs                               134                         33
DMA zone allocs                               1                          1
Normal zone allocs                           16                         83
HighMem zone allocs                         124                        158
EasyRclm zone allocs                          0                          0
% Success                                    51                         88
>>> END SET 1: -clean Vs mbuddy-v22 <<<

>>> BEGIN SET 2: -clean Vs zbuddy-v3 <<<
                               2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
Time taken to extract kernel:                    14                        14
Time taken to build kernel:                     741                       738

                 2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
 1 creat-clo                 12273.11                  12235.72     -37.39 -0.30% File Creations and Closes/second
 2 page_test                131762.75                 132946.18    1183.43  0.90% System Allocations & Pages/second
 3 brk_test                 586206.90                 603298.90   17092.00  2.92% System Memory Allocations/second
 4 jmp_test                4375520.75                4376557.81    1037.06  0.02% Non-local gotos/second
 5 signal_test               79436.76                  81086.49    1649.73  2.08% Signal Traps/second
 6 exec_test                    62.90                     62.81      -0.09 -0.14% Program Loads/second
 7 fork_test                  1211.92                   1212.52       0.60  0.05% Task Creations/second
 8 link_test                  4332.30                   4346.60      14.30  0.33% Link/Unlink Pairs/second

                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
Order                                        10                        10
Allocation type                         HighMem                   HighMem
Attempted allocations                       275                       275
Success allocs                               60                       106
Failed allocs                               215                       169
DMA zone allocs                               1                         1
Normal zone allocs                            5                         8
HighMem zone allocs                          54                         0
EasyRclm zone allocs                          0                        97
% Success                                    21                        38
HighAlloc Under Load Test Results Pass 2
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
Order                                        10                        10
Allocation type                         HighMem                   HighMem
Attempted allocations                       275                       275
Success allocs                              101                       154
Failed allocs                               174                       121
DMA zone allocs                               1                         1
Normal zone allocs                            5                         8
HighMem zone allocs                          95                         0
EasyRclm zone allocs                          0                       145
% Success                                    36                        56
HighAlloc Test Results while Rested
                           2.6.16-rc1-mm1-clean  2.6.16-rc1-mm1-zbuddy-v3
Order                                        10                        10
Allocation type                         HighMem                   HighMem
Attempted allocations                       275                       275
Success allocs                              141                       212
Failed allocs                               134                        63
DMA zone allocs                               1                         1
Normal zone allocs                           16                         8
HighMem zone allocs                         124                         0
EasyRclm zone allocs                          0                       203
% Success                                    51                        77

>>> BEGIN SET 2: -clean Vs zbuddy-v3 <<<

>>> BEGIN SET 3: -mbuddy-v22 Vs zbuddy-v3 <<<
                               2.6.16-rc1-mm1-mbuddy-v22  2.6.16-rc1-mm1-zbuddy-v3
Time taken to extract kernel:                         15                        14
Time taken to build kernel:                          741                       738

                 2.6.16-rc1-mm1-mbuddy-v22  2.6.16-rc1-mm1-zbuddy-v3
 1 creat-clo                      12239.80                  12235.72      -4.08 -0.03% File Creations and Closes/second
 2 page_test                     134311.90                 132946.18   -1365.72 -1.02% System Allocations & Pages/second
 3 brk_test                      597167.14                 603298.90    6131.76  1.03% System Memory Allocations/second
 4 jmp_test                     4373004.50                4376557.81    3553.31  0.08% Non-local gotos/second
 5 signal_test                    77307.56                  81086.49    3778.93  4.89% Signal Traps/second
 6 exec_test                         62.93                     62.81      -0.12 -0.19% Program Loads/second
 7 fork_test                       1218.13                   1212.52      -5.61 -0.46% Task Creations/second
 8 link_test                       4324.56                   4346.60      22.04  0.51% Link/Unlink Pairs/second

                           2.6.16-rc1-mm1-mbuddy-v22  2.6.16-rc1-mm1-zbuddy-v3
Order                                             10                        10
Allocation type                              HighMem                   HighMem
Attempted allocations                            275                       275
Success allocs                                    86                       106
Failed allocs                                    189                       169
DMA zone allocs                                    1                         1
Normal zone allocs                                 0                         8
HighMem zone allocs                               85                         0
EasyRclm zone allocs                               0                        97
% Success                                         31                        38
HighAlloc Under Load Test Results Pass 2
                           2.6.16-rc1-mm1-mbuddy-v22  2.6.16-rc1-mm1-zbuddy-v3
Order                                             10                        10
Allocation type                              HighMem                   HighMem
Attempted allocations                            275                       275
Success allocs                                   103                       154
Failed allocs                                    172                       121
DMA zone allocs                                    1                         1
Normal zone allocs                                 0                         8
HighMem zone allocs                              102                         0
EasyRclm zone allocs                               0                       145
% Success                                         37                        56
HighAlloc Test Results while Rested
                           2.6.16-rc1-mm1-mbuddy-v22  2.6.16-rc1-mm1-zbuddy-v3
Order                                             10                        10
Allocation type                              HighMem                   HighMem
Attempted allocations                            275                       275
Success allocs                                   242                       212
Failed allocs                                     33                        63
DMA zone allocs                                    1                         1
Normal zone allocs                                83                         8
HighMem zone allocs                              158                         0
EasyRclm zone allocs                               0                       203
% Success                                         88                        77

>>> END SET 3: -mbuddy-v22 Vs zbuddy-v3 <<<

So, in terms of performance on this set of tests, both approachs perform
roughly the same as the stock kernel in terms of absolute performance. In
terms of high-order allocations, zone-based appears to do better under
load. However, if you look at the zones that are used, you will see that
zone-based appears to do as well as list-based *only* because it has the
EASYRCLM zone to play with. list-based was way better at keeping the
normal zone defragmented as well as highmem which is especially obvious
when tested at rest.  list-based was able to allocate 83 huge pages from
ZONE_NORMAL at rest while zone-based only managed 8.

Secondly, zone-based requires careful configuration to be successful.  If
booted with kernelcore=896MB for example, it only performs slightly better
than the standard kernel. If booted with kernelcore=1024MB, it tends to
perform slightly worse (more zone fallbacks I guess) and still only
manages slighly better satisfaction of high order pages.

On the flip side, zone-based code changes are easier to understand than
the list-based ones (at least in terms of volume of code changes). The
zone-based gives guarantees on what will happen in the future while
list-based is best-effort.

In terms of fragmentation, I still think that list-based is better overall
without configuration. The results above also represent the best possible
configuration with zone-based versus no configuration at all against
list-based. In an environment with changing workloads a constant reality,
I bet that list-based would win overall.

> Zone based approaches are runtime inflexible and require boot time tuning by
> the sysadmin.  There are lots of workloads that "reasonable" defaults for a
> zone based approach would cause the system to regress terribly.
>
> -Joel
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
