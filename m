Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUCUQah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbUCUQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:30:37 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:21144 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263673AbUCUQad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:30:33 -0500
Date: Sun, 21 Mar 2004 08:30:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <2924080000.1079886632@[10.10.2.4]>
In-Reply-To: <20040320161905.GT9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Mmmm, if you have a broken out patch, it'd be preferable. If I were to 
>> apply the whole of -mjb, I'll get a damned sight better results than 
>> any of them, but that's not really a fair comparison ;-) I'll can at 
>> least check it's stable for me that way though. 
>> 
>> I did find your broken-out anon-vma patch, but it's against something
>> else, maybe half-way up your tree or something, and I didn't bother
>> trying to fix it ;-)
> 
> this one is against mainline, but you must use my objrmap patch too
> which is fixed so it doesn't crash in 2.6.5-rc1.
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00100_objrmap-core-1.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00101_anon_vma-2.gz
> 
> just backout your objrmap and apply the above two, it should apply
> pretty well.

I tried the aa3 equiv of the above, just on top of virgin 2.6.5-rc1, but 
it doesn't work cleanly. Your whole aa3 tree runs nicely, but I'd prefer
to have the broken out patch before publishing comparisons, as otherwise
it's a bit unfair ;-) I'm not sure if the results come from your anon_vma
approach, or other patches in your tree ...

I'm presuming you shifted the cost of find_get_page into find_trylock_page
and pgd_ctor into pgd_alloc from the profiles below ...

diffprofile from partial objrmap to aa3:

      3809  27207.1% find_trylock_page
       569  2845.0% pgd_alloc
       242    60.7% dentry_open
       100    21.5% do_page_cache_readahead
        95     0.0% anon_vma_unlink
        67     0.0% anon_vma_prepare
...
      -118    -8.1% free_hot_cold_page
      -119    -6.7% buffered_rmqueue
      -120    -0.8% do_anonymous_page
      -131    -2.1% __copy_to_user_ll
      -135  -100.0% pte_chain_alloc
      -143   -13.3% clear_page_tables
      -146  -100.0% __pte_chain_free
      -149   -10.7% link_path_walk
      -221  -100.0% radix_tree_lookup
      -275  -100.0% .text.lock.filemap
      -372   -12.0% zap_pte_range
      -397  -100.0% pgd_ctor
      -584   -25.9% do_no_page
      -807   -34.8% page_remove_rmap
     -1171   -57.2% page_add_rmap
     -1664    -3.4% default_idle
     -3564   -99.3% find_get_page
     -6182    -4.3% total

diffprofile from hugh's to aa3:

      3809  27207.1% find_trylock_page
       875     0.0% page_add_rmap
       568  2704.8% pgd_alloc
       264     0.0% __set_page_dirty_buffers
       256    66.5% dentry_open
       225     1.6% do_anonymous_page
       138     1.7% __d_lookup
        97    20.7% do_page_cache_readahead
        95     0.0% anon_vma_unlink
        76     6.5% file_move
        67     0.0% anon_vma_prepare
        61     1.2% __copy_from_user_ll
...
       -51   -32.7% vma_link
       -52   -40.0% fd_install
       -52    -2.3% do_page_fault
       -55   -10.3% kmap_atomic
       -64   -11.9% .text.lock.file_table
       -74    -3.2% atomic_dec_and_lock
       -77   -16.6% copy_page_range
       -79    -1.3% __copy_to_user_ll
       -89    -4.4% path_lookup
       -92   -11.0% pte_alloc_one
       -98    -7.3% link_path_walk
      -102    -5.8% buffered_rmqueue
      -116   -12.7% release_pages
      -129   -12.2% clear_page_tables
      -230  -100.0% radix_tree_lookup
      -258   -14.6% page_remove_rmap
      -303  -100.0% .text.lock.filemap
      -342   -93.2% set_page_dirty
      -394   -12.6% zap_pte_range
      -404  -100.0% pgd_ctor
      -656  -100.0% page_add_obj_rmap
      -773  -100.0% page_add_anon_rmap
      -812    -1.7% default_idle
     -2846    -2.0% total
     -3827   -99.4% find_get_page



