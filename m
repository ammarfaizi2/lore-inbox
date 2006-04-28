Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWD1OCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWD1OCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWD1OCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:02:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13963 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030409AbWD1OCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:02:16 -0400
Date: Sat, 29 Apr 2006 00:01:47 +1000
From: David Chinner <dgc@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: dgc@sgi.com, Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060428140146.GA4657648@melbourne.sgi.com>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com> <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de> <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:31:14PM -0700, Christoph Lameter wrote:
> Dave: Can you tell us more about the tree_lock contentions on I/O that you 
> have seen?

Sorry to be slow responding - I've been sick the last couple of days.

Take a large file - say Size = 5x RAM or so - and then start
N threads runnnning at offset (n / Size) where n = the thread
number. They each read (Size / N) and so typically don't overlap. 

Throughput with increasing numbers of threads on a 24p altix
on an XFS filesystem on 2.6.15-rc5 looks like:

++++ Local I/O Block size 262144 ++++ Thu Dec 22 03:41:42 PST 2005


Loads   Type    blksize count   av_time    tput    usr%   sys%   intr%
-----   ----    ------- -----   ------- -------    ----   ----   -----
  1      read   256.00K 256.00K   82.92  789.59    1.80  215.40   18.40
  2      read   256.00K 256.00K   53.97 1191.56    2.10  389.40   22.60
  4      read   256.00K 256.00K   37.83 1724.63    2.20  776.00   29.30
  8      read   256.00K 256.00K   52.57 1213.63    2.20 1423.60   24.30
  16     read   256.00K 256.00K   60.05 1057.03    1.90 1951.10   24.30
  32     read   256.00K 256.00K   82.13  744.73    2.00 2277.50   18.60
                                        ^^^^^^^         ^^^^^^^

Basically,  we hit a scaling limitation at b/t 4 and 8 threads. This was
consistent across I/O sizes from 4KB to 4MB. I took a simple 30s PC sample
profile:

user ticks:             0               0 %
kernel ticks:           2982            99.97 %
idle ticks:             4               0.13 %

Using /proc/kallsyms as the kernel map file.
====================================================================
                           Kernel

      Ticks     Percent  Cumulative   Routine
                          Percent
--------------------------------------------------------------------
       1897       63.62    63.62      _write_lock_irqsave
        467       15.66    79.28      _read_unlock_irq
         91        3.05    82.33      established_get_next
         74        2.48    84.81      generic__raw_read_trylock
         59        1.98    86.79      xfs_iunlock
         47        1.58    88.36      _write_unlock_irq
         46        1.54    89.91      xfs_bmapi
         40        1.34    91.25      do_generic_mapping_read
         35        1.17    92.42      xfs_ilock_map_shared
         26        0.87    93.29      __copy_user
         23        0.77    94.06      __do_page_cache_readahead
         16        0.54    94.60      unlock_page
         15        0.50    95.10      xfs_ilock
         15        0.50    95.61      shrink_cache
         15        0.50    96.11      _spin_unlock_irqrestore
         13        0.44    96.55      sub_preempt_count
         11        0.37    96.91      mpage_end_io_read
         10        0.34    97.25      add_preempt_count
         10        0.34    97.59      xfs_iomap
          9        0.30    97.89      _read_unlock


So read_unlock_irq looks to be triggered by the mapping->tree_lock.

I think that the write_lock_irqsave() contention is from memory
reclaim (shrink_list()->try_to_release_page()-> ->releasepage()->
xfs_vm_releasepage()-> try_to_free_buffers()->clear_page_dirty()->
test_clear_page_dirty()-> write_lock_irqsave(&mapping->tree_lock...))
because page cache memory was full of this one file and demand is
causing them to be constantly recycled.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
