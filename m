Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUCXQUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUCXQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:20:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30104
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263762AbUCXQUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:20:24 -0500
Date: Wed, 24 Mar 2004 17:21:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040324162116.GQ2065@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24560000.1080143798@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 07:56:39AM -0800, Martin J. Bligh wrote:
> 
> 
> --Andrea Arcangeli <andrea@suse.de> wrote (on Wednesday, March 24, 2004 07:19:57 +0100):
> 
> > On Mon, Mar 22, 2004 at 07:53:02AM -0800, Martin J. Bligh wrote:
> >> Just against 2.6.5-rc1 virgin is easiest - that's what I was doing the
> >> rest of it against ...
> > 
> > here it is:
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc1/anon-vma-2.6.5-rc2-aa2.gz
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc1/objrmap-core-2.6.5-rc2-aa2.gz
> > 
> > 
> 
> Yay, that works ;-) Without the rest of your tree, performance of anon_vma
> is almost exactly = anon_mm ... of course all this is under no mem pressure,
> I'll have to do some more tests on another machine without infinite ram to
> see what happens as we start to reclaim ;-)

excellent. under reclaim at least in theory you should see less cpu
utilization with anon_vma since the page links directly to the vmas.

> Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
>                               Elapsed      System        User         CPU
>                 2.6.5-rc1       45.75      102.49      577.39     1486.00
>         2.6.5-rc1-partial       44.84       85.75      576.63     1476.67
>            2.6.5-rc1-hugh       44.79       83.85      576.71     1474.67
>        2.6.5-rc1-anon_vma       44.66       83.69      577.14     1479.00

anonvma is the fastest here.

> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed      System        User         CPU
>                 2.6.5-rc1       46.99      121.95      580.82     1495.33
>         2.6.5-rc1-partial       45.09       97.16      579.59     1501.00
>            2.6.5-rc1-hugh       45.00       95.45      579.05     1498.67
>        2.6.5-rc1-anon_vma       44.90       96.17      579.60     1503.67

here again the fastest.

> 
> Kernbench: (make -j vmlinux, maximal tasks)
>                               Elapsed      System        User         CPU
>                 2.6.5-rc1       46.96      122.43      580.65     1495.00
>         2.6.5-rc1-partial       45.18       93.60      579.10     1488.33
>            2.6.5-rc1-hugh       44.89       91.04      578.49     1490.33
>        2.6.5-rc1-anon_vma       44.92       91.96      578.86     1493.33

here it's not the fastest (though a 0.03 difference should be in the
error range with an unlimited -j)

I also left a zillon of BUG_ON enabled (in cpu-bound fast paths, of
page_add_rmap/page-faults/pagecache etc..), those in theory can be all
removed.

> SDET 1  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         3.0%
>         2.6.5-rc1-partial       101.4%         1.3%
>            2.6.5-rc1-hugh       100.0%         2.9%
>        2.6.5-rc1-anon_vma       101.4%         1.9%

here it's as fast as plain objrmap.

> SDET 2  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         1.3%
>         2.6.5-rc1-partial       107.7%         1.0%
>            2.6.5-rc1-hugh       108.7%         1.5%
>        2.6.5-rc1-anon_vma       109.5%         0.7%

here it's the fastest.

> SDET 4  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.7%
>         2.6.5-rc1-partial       110.5%         0.6%
>            2.6.5-rc1-hugh       114.6%         1.3%
>        2.6.5-rc1-anon_vma       113.3%         0.3%

here a 1% slower though anonmm has 1% of standard deviation (higher than
all the others).

> SDET 8  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.9%
>         2.6.5-rc1-partial       119.4%         0.5%
>            2.6.5-rc1-hugh       120.2%         1.1%
>        2.6.5-rc1-anon_vma       119.6%         0.0%

here 1% slower tha anonmm though anonm still has a 1% std deviation.

it's interesting I get 0 standard deviation. Is it possible I get lower
standard deviation because you run it less times? just wondering. I'd
expect SDET has a default number of passes, so I expect the answer is no
of course.

> SDET 16  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.1%
>         2.6.5-rc1-partial       118.1%         0.2%
>            2.6.5-rc1-hugh       119.8%         0.4%
>        2.6.5-rc1-anon_vma       119.9%         0.8%

here the fastest.

> SDET 32  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.2%
>         2.6.5-rc1-partial       119.2%         1.0%
>            2.6.5-rc1-hugh       120.4%         0.4%
>        2.6.5-rc1-anon_vma       121.8%         0.6%

more than 1% faster.

> SDET 64  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.3%
>         2.6.5-rc1-partial       122.1%         0.5%
>            2.6.5-rc1-hugh       123.5%         0.4%
>        2.6.5-rc1-anon_vma       123.3%         0.8%

here .2% slower.

> SDET 128  (see disclaimer)
>                            Throughput    Std. Dev
>                 2.6.5-rc1       100.0%         0.2%
>         2.6.5-rc1-partial       123.1%         0.4%
>            2.6.5-rc1-hugh       124.7%         0.7%
>        2.6.5-rc1-anon_vma       123.9%         0.3%

around 1% slower here.

overall I think for the fast path we can conclude they're at least
equally fast.

Using Christoph's teqniques of splitting out the swapper_space checks
from the pagecache paths I can boost some more cpu cycle into anon_vma
btw (very low prio at this time, much better to keep the patch smaller
and more robust while it's out of the mainline tree).

> For interest's sake, here's the diffprofile for kernbench from
> anon_mm to the whole -aa tree ...
> 
>       3808  25386.7% find_trylock_page
>        568  2704.8% pgd_alloc
>        273    74.2% dentry_open
>        125    11.2% file_move
>        106    23.1% do_page_cache_readahead
>         64     0.5% do_anonymous_page
> ...
>        -64    -1.0% __copy_to_user_ll
>        -66   -12.2% .text.lock.file_table
>        -72    -0.8% __d_lookup
>        -78    -3.9% path_lookup
>        -84   -14.9% kmap_atomic
>        -92   -11.0% pte_alloc_one
>        -97   -13.7% generic_file_open
>       -106   -11.2% kmem_cache_free
>       -121   -13.2% release_pages
>       -126   -12.6% page_add_rmap
>       -137   -12.9% clear_page_tables
>       -212    -7.2% zap_pte_range
>       -235  -100.0% radix_tree_lookup
>       -239   -12.5% buffered_rmqueue
>       -268   -17.8% link_path_walk
>       -291  -100.0% .text.lock.filemap
>       -397   -20.8% page_remove_rmap
>       -398  -100.0% pgd_ctor
>       -461   -21.6% do_no_page
>       -669    -1.4% default_idle
>      -3508    -2.5% total
>      -3719   -99.4% find_get_page
> 
> zap_pte_range and page_remove_rmap and do_no_page are cheaper ... are we 
> setting up and tearing down pages less frequently somehow? Would be 
> curious to know which patch that is ...

it's one of the -mm patches probably that boosts those bits (the
cost page_add_rmap and the page faults should be the same with both
anon-vma and anonmm). as for the regression, the pgd_alloc slowdown is
the unslabify one from andrew that releases 8 bytes per page in 32bit
archs and 16 bytes per page in 64bit archs.

My current page_t is now 36 bytes (compared to 48bytes of 2.4) in 32bit
archs, and 56bytes on 64bit archs (hope I counted right this time, Hugh
says I'm counting wrong the page_t, methinks we were looking different
source trees instead but maybe I was really counting wrong ;).
