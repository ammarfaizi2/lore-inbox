Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUCSRLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUCSRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:11:47 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:49835 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263084AbUCSRLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:11:30 -0500
Date: Fri, 19 Mar 2004 09:11:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <2663710000.1079716282@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'm pleased to say not only is your code stable in my tests, it's
also faster than partial objrmap (not by that much, but definitely 
measurable). And of course, the code's cleaner. Kernbench & SDET are both 
heavy on fork/exec/exit, so this should give these paths a heavy workout.
(this was on 16-way NUMA-Q).

Andrea, are you still working on your code at the moment, or is it ready
for others to play with? I'll make a run at that as well if you say it's
ready, though I think I might have lost track of the latest version ;-)

M.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
                2.6.5-rc1       45.75      102.49      577.39     1486.00
        2.6.5-rc1-partial       44.84       85.75      576.63     1476.67
           2.6.5-rc1-hugh       44.79       83.85      576.71     1474.67

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
                2.6.5-rc1       46.99      121.95      580.82     1495.33
        2.6.5-rc1-partial       45.09       97.16      579.59     1501.00
           2.6.5-rc1-hugh       45.00       95.45      579.05     1498.67

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                2.6.5-rc1       46.96      122.43      580.65     1495.00
        2.6.5-rc1-partial       45.18       93.60      579.10     1488.33
           2.6.5-rc1-hugh       44.89       91.04      578.49     1490.33


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         3.0%
        2.6.5-rc1-partial       101.4%         1.3%
           2.6.5-rc1-hugh       100.0%         2.9%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         1.3%
        2.6.5-rc1-partial       107.7%         1.0%
           2.6.5-rc1-hugh       108.7%         1.5%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.7%
        2.6.5-rc1-partial       110.5%         0.6%
           2.6.5-rc1-hugh       114.6%         1.3%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.9%
        2.6.5-rc1-partial       119.4%         0.5%
           2.6.5-rc1-hugh       120.2%         1.1%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.1%
        2.6.5-rc1-partial       118.1%         0.2%
           2.6.5-rc1-hugh       119.8%         0.4%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.2%
        2.6.5-rc1-partial       119.2%         1.0%
           2.6.5-rc1-hugh       120.4%         0.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.3%
        2.6.5-rc1-partial       122.1%         0.5%
           2.6.5-rc1-hugh       123.5%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                2.6.5-rc1       100.0%         0.2%
        2.6.5-rc1-partial       123.1%         0.4%
           2.6.5-rc1-hugh       124.7%         0.7%


diffprofile from virgin to partial (kernbench)

       520    30.0% do_no_page
       450     9.6% __copy_from_user_ll
       307     5.1% __copy_to_user_ll
        93     9.2% __wake_up
        89     4.8% schedule
...
      -147   -44.8% free_pages_and_swap_cache
      -224    -1.6% do_anonymous_page
      -319    -9.3% zap_pte_range
      -352    -8.9% find_get_page
      -388   -30.3% release_pages
      -448   -75.4% __pte_chain_free
      -555    -1.1% default_idle
      -907   -50.4% kmem_cache_free
     -4647   -69.4% page_add_rmap
    -21876   -90.4% page_remove_rmap
    -29063   -16.8% total

And from partial to full:

       773     0.0% page_add_anon_rmap
       656     0.0% page_add_obj_rmap
       367     0.0% set_page_dirty
       263     7.3% find_get_page
        76     3.4% do_page_fault
        64    13.5% .text.lock.file_table
        58     2.5% atomic_dec_and_lock
...
      -104    -2.0% __copy_from_user_ll
      -126    -8.7% free_hot_cold_page
      -135  -100.0% pte_chain_alloc
      -146  -100.0% __pte_chain_free
      -164    -1.9% __d_lookup
      -282  -100.0% __set_page_dirty_buffers
      -345    -2.4% do_anonymous_page
      -549   -23.7% page_remove_rmap
      -574   -25.4% do_no_page
      -852    -1.7% default_idle
     -2046  -100.0% page_add_rmap
     -3336    -2.3% total


