Return-Path: <linux-kernel-owner+w=401wt.eu-S932866AbXASOpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbXASOpm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXASOpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:45:42 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:35402 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbXASOpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:45:41 -0500
Message-ID: <45B0D967.8090607@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2007 20:14:55 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Aubrey Li <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
In-Reply-To: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aubrey Li wrote:
> Here is the newest patch against 2.6.20-rc5.
> ======================================================
> From ad9ca9a32bdcaddce9988afbf0187bfd04685a0c Mon Sep 17 00:00:00 2001
> From: Aubrey.Li <aubreylee@gmail.com>
> Date: Thu, 18 Jan 2007 11:08:31 +0800
> Subject: [PATCH] Add an interface to limit total vfs page cache.
> The default percent is using 90% memory for page cache.

Hi Aubrey,

I used your patch on my PPC64 box and I do not get expected
behavior.  As you had requested, I am attaching zoneinfo and meminfo
dumps:

# cat  /proc/sys/vm/pagecache_ratio
50
# cat /proc/meminfo
MemTotal:      1014600 kB << 1GB Ram
MemFree:        960336 kB << Expect to see around 500MB free after
Buffers:          8348 kB       issue of DD command
Cached:           8624 kB
SwapCached:          8 kB
Active:          20908 kB
Inactive:         5680 kB
SwapTotal:     1526164 kB
SwapFree:      1526088 kB
Dirty:             116 kB
Writeback:           0 kB
AnonPages:        9544 kB
Mapped:           7736 kB
Slab:            18920 kB
SReclaimable:     5792 kB
SUnreclaim:      13128 kB
PageTables:        972 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   2033464 kB
Committed_AS:    46652 kB
VmallocTotal: 8589934592 kB
VmallocUsed:      2440 kB
VmallocChunk: 8589932152 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:    16384 kB

# cat /proc/zoneinfo
Node 0, zone      DMA
  pages free     130474
        min      571
        low      713
        high     856
        active   5010
        inactive 775
        scanned  0 (a: 24 i: 0)
        spanned  147456
        present  145440
    nr_anon_pages 2383
    nr_mapped    1932
    nr_file_pages 3389
    nr_slab_reclaimable 1094
    nr_slab_unreclaimable 1819
    nr_page_table_pages 243
    nr_dirty     4
    nr_writeback 0
    nr_unstable  0
    nr_bounce    0
    nr_vmscan_write 34
    numa_hit     1428389
    numa_miss    0
    numa_foreign 1048457
    numa_interleave 1511
    numa_local   1428389
    numa_other   0
        protection: (0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 77
              high:  186
              batch: 31
    cpu: 0 pcp: 1
              count: 3
              high:  62
              batch: 15
  vm stats threshold: 16
    cpu: 1 pcp: 0
              count: 171
              high:  186
              batch: 31
    cpu: 1 pcp: 1
              count: 11
              high:  62
              batch: 15
  vm stats threshold: 16
  all_unreclaimable: 0
  prev_priority:     12
  start_pfn:         0
Node 1, zone      DMA
  pages free     109610
        min      444
        low      555
        high     666
        active   217
        inactive 655
        scanned  0 (a: 21 i: 0)
        spanned  114688
        present  113120
    nr_anon_pages 3
    nr_mapped    2
    nr_file_pages 869
    nr_slab_reclaimable 354
    nr_slab_unreclaimable 1454
    nr_page_table_pages 0
    nr_dirty     0
    nr_writeback 0
    nr_unstable  0
    nr_bounce    0
    nr_vmscan_write 0
    numa_hit     2220
    numa_miss    1048457
    numa_foreign 0
    numa_interleave 1519
    numa_local   0
    numa_other   1050677
        protection: (0, 0)
  pagesets
  all_unreclaimable: 0
  prev_priority:     12
  start_pfn:         147456

The test: Write 1GB file in /tmp

 # dd if=/dev/zero of=/tmp/foo bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 15.2301 seconds, 70.5 MB/s

Expect around 500MB to be retained as free after the run?

# cat /proc/meminfo
MemTotal:      1014600 kB
MemFree:         14080 kB  <<<
Buffers:         11164 kB
Cached:         924536 kB  <<< Almost all memory is consumed by
SwapCached:          8 kB         pagecache
Active:          27500 kB
Inactive:       917740 kB
SwapTotal:     1526164 kB
SwapFree:      1526088 kB
Dirty:          100528 kB
Writeback:           0 kB
AnonPages:        9544 kB
Mapped:           7736 kB
Slab:            45264 kB
SReclaimable:    29652 kB
SUnreclaim:      15612 kB
PageTables:        972 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   2033464 kB
Committed_AS:    47732 kB
VmallocTotal: 8589934592 kB
VmallocUsed:      2440 kB
VmallocChunk: 8589932152 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:    16384 kB

# cat /proc/zoneinfo
Node 0, zone      DMA
  pages free     2063
        min      571
        low      713
        high     856
        active   6028
        inactive 124552
        scanned  0 (a: 5 i: 0)
        spanned  147456
        present  145440
    nr_anon_pages 2384
    nr_mapped    1932
    nr_file_pages 128191
    nr_slab_reclaimable 4312
    nr_slab_unreclaimable 2102
    nr_page_table_pages 243
    nr_dirty     13724
    nr_writeback 0
    nr_unstable  0
    nr_bounce    0
    nr_vmscan_write 34
    numa_hit     1577905
    numa_miss    0
    numa_foreign 1173147
    numa_interleave 1511
    numa_local   1577905
    numa_other   0
        protection: (0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 147
              high:  186
              batch: 31
    cpu: 0 pcp: 1
              count: 7
              high:  62
              batch: 15
  vm stats threshold: 16
    cpu: 1 pcp: 0
              count: 160
              high:  186
              batch: 31
    cpu: 1 pcp: 1
              count: 52
              high:  62
              batch: 15
  vm stats threshold: 16
  all_unreclaimable: 0
  prev_priority:     12
  start_pfn:         0
Node 1, zone      DMA
  pages free     1766
        min      444
        low      555
        high     666
        active   847
        inactive 104893
        scanned  0 (a: 27 i: 0)
        spanned  114688
        present  113120
    nr_anon_pages 2
    nr_mapped    2
    nr_file_pages 105739
    nr_slab_reclaimable 3082
    nr_slab_unreclaimable 1658
    nr_page_table_pages 0
    nr_dirty     11419
    nr_writeback 0
    nr_unstable  0
    nr_bounce    0
    nr_vmscan_write 0
    numa_hit     2220
    numa_miss    1173147
    numa_foreign 0
    numa_interleave 1519
    numa_local   0
    numa_other   1175367
        protection: (0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 1
              high:  186
              batch: 31
    cpu: 0 pcp: 1
              count: 0
              high:  62
              batch: 15
  vm stats threshold: 12
    cpu: 1 pcp: 0
              count: 35
              high:  186
              batch: 31
    cpu: 1 pcp: 1
              count: 0
              high:  62
              batch: 15
  vm stats threshold: 12
  all_unreclaimable: 0
  prev_priority:     12
  start_pfn:         147456



[snip]

Please let me know if you need any further data to help me out with
the test/experiment.

--Vaidy

