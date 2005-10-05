Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVJFM6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVJFM6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJFM6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:58:00 -0400
Received: from hera.kernel.org ([140.211.167.34]:16352 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750860AbVJFM57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:57:59 -0400
Date: Wed, 5 Oct 2005 18:25:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: shrinkable cache statistics [was Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough]
Message-ID: <20051005212551.GA10057@logos.cnet>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet> <20050915093945.GD3869@in.ibm.com> <20050915132910.GA6806@dmt.cnet> <20051002163229.GB5190@in.ibm.com> <20051002200640.GB9865@xeon.cnet> <20051004133635.GA23575@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004133635.GA23575@in.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharata,

On Tue, Oct 04, 2005 at 07:06:35PM +0530, Bharata B Rao wrote:
> Marcelo,
> 
> Here's my next attempt in breaking the "slabs_scanned" from /proc/vmstat
> into meaningful per cache statistics. Now I have the statistics counters
> as percpu. [an issue remaining is that there are more than one cache as
> part of mbcache and they all have a common shrinker routine and I am
> displaying the collective shrinker stats info on each of them in
> /proc/slabinfo ==> some kind of duplication]

Looks good to me! IMO it should be a candidate for -mm/mainline.

Nothing useful to suggest on the mbcache issue... sorry.

> With this patch (and my earlier dcache stats patch) I observed some
> interesting results with the following test scenario on a 8cpu p3 box:
> 
> - Ran an application which consumes 40% of the total memory.
> - Ran dbench on tmpfs with 128 clients twice (serially).
> - Ran a find on a ext3 partition having ~9.5million entries (files and
>   directories included)
> 
> At the end of this run, I have the following results:
> 
> [root@llm09 bharata]# cat /proc/meminfo
> MemTotal:      3872528 kB
> MemFree:       1420940 kB
> Buffers:        714068 kB
> Cached:          21536 kB
> SwapCached:       2264 kB
> Active:        1672680 kB
> Inactive:       637460 kB
> HighTotal:     3014616 kB
> HighFree:      1411740 kB
> LowTotal:       857912 kB
> LowFree:          9200 kB
> SwapTotal:     2096472 kB
> SwapFree:      2051408 kB
> Dirty:             172 kB
> Writeback:           0 kB
> Mapped:        1583680 kB
> Slab:           119564 kB
> CommitLimit:   4032736 kB
> Committed_AS:  1647260 kB
> PageTables:       2248 kB
> VmallocTotal:   114680 kB
> VmallocUsed:      1264 kB
> VmallocChunk:   113384 kB
> nr_dentries/page        nr_pages        nr_inuse
>          0              0               0
>          1              5               2
>          2              12              4
>          3              26              9
>          4              46              18
>          5              76              40
>          6              82              47
>          7              91              59
>          8              122             93
>          9              114             102
>         10              142             136
>         11              138             185
>         12              118             164
>         13              128             206
>         14              126             208
>         15              120             219
>         16              136             261
>         17              159             315
>         18              145             311
>         19              179             379
>         20              192             407
>         21              256             631
>         22              286             741
>         23              316             816
>         24              342             934
>         25              381             1177
>         26              664             2813
>         27              0               0
>         28              0               0
>         29              0               0
> Total:                  4402            10277
> dcache lru: total 75369 inuse 3599
> 
> [Here,
> nr_dentries/page - Number of dentries per page
> nr_pages - Number of pages with given number of dentries
> nr_inuse - Number of inuse dentries in those pages.
> Eg: From the above data, there are 26 pages with 3 dentries each
> and out of 78 total dentries in these 3 pages, 9 dentries are in use.]
> 
> [root@llm09 bharata]# grep shrinker /proc/slabinfo
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : shrinker stat <nr requested> <nr freed>
> ext3_xattr             0      0     48   78    1 : tunables  120   60    8 : slabdata      0      0      0 : shrinker stat       0       0
> dquot                  0      0    160   24    1 : tunables  120   60    8 : slabdata      0      0      0 : shrinker stat       0       0
> inode_cache         1301   1390    400   10    1 : tunables   54   27    8 : slabdata    139    139      0 : shrinker stat  682752  681900
> dentry_cache       82110 114452    152   26    1 : tunables  120   60    8 : slabdata   4402   4402      0 : shrinker stat 1557760  760100
> 
> [root@llm09 bharata]# grep slabs_scanned /proc/vmstat
> slabs_scanned 2240512
> 
> [root@llm09 bharata]# cat /proc/sys/fs/dentry-state
> 82046   75369   45      0       3599    0
> [The order of dentry-state o/p is like this:
> total dentries in dentry hash list, total dentries in lru list, age limit,
> want_pages, inuse dentries in lru list, dummy]
> 
> So, we can see that with low memory pressure, even though the
> shrinker runs on dcache repeatedly, not many dentries are freed
> by dcache. And dcache lru list still has huge number of free
> dentries.

The success/attempt ratio is about 1/2, which seems alright? 
