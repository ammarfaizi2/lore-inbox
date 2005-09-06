Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVIFSiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVIFSiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVIFSiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:38:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9600 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750788AbVIFSiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:38:22 -0400
Date: Tue, 6 Sep 2005 11:31:44 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: torvalds@osdl.org
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Hugh's alternate page fault scalability approach on 512p Altix
Message-ID: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is going to be a bit long so lets just first summarize the important 
conclusions (if you are easily offended by the mentioning of large numbers 
of processors or large amounts of memory then please stop reading right 
now):

1. Hugh's approach is able to replicate all the performance gain that I 
   was able to get with the atomic operations. Given the broader scope and 
   cleaner way of handling things I still favor his patchset. Both 
   patchsets can reach 1.2 million page faults per second which translates 
   into the ability to fault in 19.6 Gigabytes of memory per second.

2. The use rss and anon_rss deltas instead of atomic incs brings small 
   performance enhancements in the lower cpu ranges (1-32) but hurt (%50 
   performance drop at 512 processors) in the high range. The hurting may
   be due to the percularities of SGIs NUMA router architecture and the 
   NUMA cabling scheme employed that allows the effective negotiation for
   two bouncing cachelines on two separate planes of the NUMA router
   structure. If there is only one bouncing cacheline then only one plane
   is used continually by all processors causing more contention and
   reducing performance.

   Some other NUMA architectures as well as other cabling schemes for 
   SGI numa machines may have different features and benefit
   from deltas but I think the deltas should only be an optional 
   feature.

Results of performance tests (concurrent anonymous page faults with an 
increasing number of processors) on a 512p Altix system with 1 TB of main 
memory with the standard NUMA link cabling scheme. 2.6.13-rc6-mm1 patches 
with Hugh Dickin's page locking approach:

64 GB:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
 64  3    1   1    2.58s    219.51s 222.40s 56655.284  56576.495
 64  3    2   1    2.53s    231.22s 122.20s 53828.337 102966.891
 64  3    4   1    2.54s    236.78s  70.13s 52575.134 179422.164
 64  3    8   1    2.63s    231.58s  40.12s 53723.537 313592.049
 64  3   16   1    2.56s    269.22s  29.01s 46298.153 433740.239
 64  3   32   1    9.41s    696.20s  35.08s 17832.521 358633.093
 64  3   64   1   38.95s   1608.78s  41.49s  7636.504 303228.550
 64  3  128   1  166.95s   3894.60s  48.74s  3098.052 258129.528
 64  3  256   1  211.69s   2151.12s  28.21s  5325.388 445952.767
 64  3  512   1  104.45s   1137.74s  15.09s 10129.571 833348.748

Performance increases to a first peak at 16 processors using on brick
routing. Beyond 16 processors metarouters have to be used for NUMA link
traffic which reduces performance. Increasing the number of processors
gradually increases the number of metarouter hops that need to be taken
until all hops are in operation at 128 processors.

No increase in the number of metarouters takes place between 128 and
512 processors, the load is simply balanced by the NUMA router structure
and therefore the page fault handler scales linearly.

At 512 processors each processor will only allocate 64/512 = 128 MB
which (given the likely overlap and scheduler functions while starting and 
stopping threads) may not reflect the full performance potential. Thus we 
increase the amount of memory allocated:

256 GB:

Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
256  3    8   1   10.68s   1207.99s 203.56s 41299.999 247253.752
256  3   16   1   11.00s   1269.70s 127.72s 39299.617 394057.354
256  3   32   1   17.93s   2731.18s 133.69s 18308.303 376461.848
256  3   64   1   62.52s   5761.57s 143.67s  8641.962 350324.172
256  3  128   1  273.98s  13003.28s 159.25s  3790.812 316049.363
256  3  256   1  147.31s   6900.22s  83.08s  7141.733 605791.086
256  3  512   1  125.41s   3819.76s  46.14s 12757.783 1090653.570

The high score increases to 1 mio faults per second. We can get to higher 
numbers by allocating half the available memory:

1/2 TB:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
512  1   64   1   12.24s   3628.84s  92.97s  9215.486 360908.603
512  1  128   1   76.72s   8212.86s  99.06s  4047.780 338727.151
512  1  256   1   24.89s   4493.71s  52.26s  7425.834 641964.130
512  1  512   1   28.84s   2353.45s  27.76s 14084.866 1208616.196

This yields the high score of 1.2 million faults per second.

The version with atomic ops (2.6.13-rc6-mm1 straight) yields:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
512  1   64   1   18.42s   3656.81s  94.88s  9129.852 353624.946
512  1  128   1   73.01s   8118.54s  99.91s  4096.222 335823.722
512  1  256   1   51.60s   4402.05s  52.02s  7534.132 644918.557
512  1  512   1   51.00s   2333.38s  27.72s 14072.603 1210256.600

A kernel with atomic ops plus the delta counters cannot reach the same 
performance in the high range:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
512  1   64   1   29.49s   5467.86s 126.72s  6103.740 264785.328
512  1  256   1  249.79s   3193.13s  71.78s  9745.911 467453.886
512  1  512   1  440.32s   1687.16s  41.71s 15771.855 804340.746

The analysis of the performance bottleneck shows two hotspots in 
ia64_do_page_fault. One is the down_read(mmap_sem) and the other 
is up_read(mmap_sem). 

In the low range the delta counters increase performance somewhat
but the effect is less than 10%:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
256  3    8   1   11.14s   1149.21s 191.03s 43376.040 263470.278
256  3   16   1   10.98s   1257.98s 125.99s 39663.324 399475.518
256  3   32   1   16.38s   2623.76s 129.37s 19063.949 389039.107

If we had only a single NUMA link plane then I guess that the counter
deltas would show up as a significant effect.

We could increase performance further by avoiding bouncing cachelines on
mmap_sem but so far no one has an idea how that could be accomplished. The 
cost is already minimal since the locking operations on mmap_sem 
translate into simple atomic_add / atomic_sub operations.

Architecture specific performance characteristics (numa router delays, 
multiple numa link planes) become significant in the high range.

Other methods that I have proposed last year (gang scheduling page
faults, prezeroing) may be used to increase the fault rate even more but
these have some drawbacks.

Anticipatory prefaulting raises the highest fault rate obtainable three-fold
through gang scheduling faults but may allocate some pages to a task that are
not needed.
http://marc.theaimsgroup.com/?t=110252674900001&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=110252687129267&w=2

Prezeroing raises the fault rate depending on the amount of cachelines
later used of the page by not having to zero a page in the page fault
handler. It makes most sense in sparse memory applications, requires a
separate zeroing mechanism (that can be done in hardware on some platforms)
and a way to track zeroed pages.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111109628913948&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=110383038322893&w=2

