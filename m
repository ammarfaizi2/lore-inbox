Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268213AbTBYSlR>; Tue, 25 Feb 2003 13:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268214AbTBYSlR>; Tue, 25 Feb 2003 13:41:17 -0500
Received: from holomorphy.com ([66.224.33.161]:9655 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268213AbTBYSlO>;
	Tue, 25 Feb 2003 13:41:14 -0500
Date: Tue, 25 Feb 2003 10:50:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225185008.GF10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225175928.GP29467@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:43:59AM -0800, William Lee Irwin III wrote:
>> The pagetable cache is gone in 2.5, so pte_alloc_one() takes the
>> bitblitting hit for pagetables.

On Tue, Feb 25, 2003 at 06:59:28PM +0100, Andrea Arcangeli wrote:
> I'm talking about do_anonymous_page, do_wp_page, do_no_page fork and all
> the other places that introduces spinlocks (per-page) and allocations of
> 2 pieces of ram rather than just 1 (and in turn potentially global
> spinlocks too if the cpu-caches are empty). Just grep for
> pte_chain_alloc or page_add_rmap in mm/memory.c, that's what I mean, I'm
> not talking about pagetables.

Okay, fished out the profiles (w/Dave's optimization):

00000000 total                                    158601   0.0869
c0106ed8 poll_idle                                 99878 1189.0238
c01172e0 do_page_fault                              8788   7.7496
c013adb4 do_wp_page                                 6712   8.4322
c013f70c page_remove_rmap                           3132   6.2640
c0139eac copy_page_range                            2994   3.5643
c013f5c0 page_add_rmap                              2776   8.3614
c013a1f4 zap_pte_range                              2616   4.8806
c0137240 release_pages                              1828   6.4366
c0108d14 system_call                                1116  25.3636
c013ba00 handle_mm_fault                            1098   4.6525
c015b59c d_lookup                                   1096   3.2619
c013b788 do_no_page                                 1044   1.6519
c013b56c do_anonymous_page                           954   1.7667
c011718c pte_alloc_one                               910   6.5000
c0139ba0 clear_page_tables                           841   2.4735
c011450c flush_tlb_page                              725   6.4732
c0207130 __copy_to_user_ll                           687   6.6058
c01333dc free_hot_cold_page                          641   2.7629
c013042c find_get_page                               601  10.7321

Just taking the exception dwarfs anything written in C.

page_add_rmap() absorbs hits from all of the fault routines and
copy_page_range(). page_remove_rmap() absorbs hits from zap_pte_range().
do_wp_page() is huge because it's doing bitblitting in-line.

These things aren't cheap with or without rmap. Trimming down
accounting overhead could raise search problems elsewhere.
Whether avoiding the search problem is worth the accounting overhead
could probably use some more investigation, like actually trying the
anonymous page handling rework needed to use vma-based ptov resolution.


-- wli
