Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbTCUGhj>; Fri, 21 Mar 2003 01:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCUGhj>; Fri, 21 Mar 2003 01:37:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:35517 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263293AbTCUGh0>;
	Fri, 21 Mar 2003 01:37:26 -0500
Date: Thu, 20 Mar 2003 22:48:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] anobjrmap 1/6 rmap.h
Message-Id: <20030320224813.0df5a911.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 06:47:54.0214 (UTC) FILETIME=[CC923060:01C2EF75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> First of a sequence of six patches, extending Dave McCracken's
> objrmap to handle anonymous memory too, eliminating pte_chains.
> 
> Based upon 2.5.65-mm2, the aggregate has
>  81 files changed, 1140 insertions(+), 1634 deletions(-)
> 
> anobjrmap 1/6 create include/linux/rmap.h
> anobjrmap 2/6 free page->mapping for use by anon
> anobjrmap 3/6 remove pte-pointer-based rmap
> anobjrmap 4/6 add anonmm to track anonymous pages
> anonjrmap 5/6 virtual address chains for odd cases
> anonjrmap 6/6 updates to arches other than i386
> 
> I've not done any timings, hope others can do that better than
> I would.  My guess is that Dave has already covered the worst
> cases, but this should cut the rmap overhead when forking.

Initial indications are that it offers no performance advantage over objrmap.

This needs a lot more work.  Timings were on a 2.7G P4-HT.  The workload is
applying and removing the 125 patches in 2.5.65-mm.  Tons of bash forking.

Note that on uniprocessor kernels we're almost equal to 2.4.  But on SMP, 2.5
is way slower.

The profiles are all over the place because the readprofile -M option (which
I use to boost the profiler interrupt rate by ten) isn't working on UP+APIC
2.5 kernels for some reason.

This all needs to be redone with oprofile, find out what on earth is going
on.


objrmap+Hugh's stuff
====================

UP:
pushpatch 999  3.90s user 4.33s system 99% cpu 8.271 total
poppatch 999  2.62s user 2.96s system 99% cpu 5.599 total

SMP:
pushpatch 9999  4.11s user 8.39s system 97% cpu 12.758 total
poppatch 9999  2.82s user 5.42s system 99% cpu 8.269 total

c011c438 copy_mm                                     694   0.6968
c01590a4 link_path_walk                              696   0.3141
c01f9b30 __copy_to_user_ll                           696   6.6923
c0114dec flush_tlb_page                              766   5.3194
c013dfa0 clear_page_tables                           792   2.3294
c013fc20 do_no_page                                  833   1.0735
c013d500 install_page                                987   2.2847
c0117c5c pte_alloc_one                              1056   7.5429
c0162510 d_lookup                                   1254   3.4076
c0108f88 system_call                                1292  29.3636
c013fa50 do_anonymous_page                          1294   2.7888
c0133e28 find_get_page                              2526  27.4565
c0144280 page_add_rmap                              2793   8.4127
c013b274 release_pages                              4032  10.6105
c0117db0 do_page_fault                              4546   3.9530
c013e534 zap_pte_range                              5153  10.0645
c01443cc page_dup_rmap                              6065  63.1771
c013e2ec copy_page_range                            6878  11.7774
c013f220 do_wp_page                                 8339  10.4761
c01445b0 page_remove_rmap                           9415  40.5819
c0106f94 default_idle                             131970 2537.8846
00000000 total                                    217986   0.1157

objrmap
=======

UP:
pushpatch 999  3.91s user 4.64s system 99% cpu 8.584 total
poppatch 999  2.66s user 3.09s system 99% cpu 5.772 total

SMP:
pushpatch 999  4.00s user 8.30s system 100% cpu 12.270 total
poppatch 9999  2.75s user 5.66s system 99% cpu 8.412 total

c011c404 copy_mm                                     718   0.7671
c013df50 clear_page_tables                           770   2.1875
c013ff38 do_no_page                                  805   1.0705
c0114dec flush_tlb_page                              808   5.6111
c013d450 install_page                               1035   1.9602
c0117c5c pte_alloc_one                              1150   8.2143
c0162a60 d_lookup                                   1180   3.2065
c0108f88 system_call                                1229  27.9318
c013fc9c do_anonymous_page                          1413   2.1153
c0133d6c find_get_page                              2415  25.1562
c013b1d4 release_pages                              4175  10.9868
c0117db0 do_page_fault                              4392   3.8191
c013e704 zap_pte_range                              5790  10.6434
c013e2cc copy_page_range                            6242   5.7796
c013f410 do_wp_page                                 8462   9.9319
c0144010 page_add_rmap                             11357  24.6891
c01441dc page_remove_rmap                          11581  18.5593
c0106f94 default_idle                             126736 2437.2308
00000000 total                                    218819   0.1160

100% pte_chains
===============

UP:
pushpatch 999  3.97s user 5.97s system 99% cpu 9.947 total
poppatch 999  2.74s user 3.95s system 99% cpu 6.719 total

c01da5bc radix_tree_lookup                            55   0.7237
c013c0d8 free_page_and_swap_cache                     57   0.6786
c0149614 link_path_walk                               59   0.0322
c01dbac8 __copy_from_user_ll                          64   0.5818
c01dba60 __copy_to_user_ll                            65   0.6250
c01334dc pte_alloc_map                                74   0.4111
c0134c20 do_no_page                                   74   0.1267
c01512ac d_lookup                                     93   0.3633
c0114f5c pte_alloc_one                                97   0.6929
c0134a4c do_anonymous_page                           105   0.2244
c0108b54 system_call                                 125   2.8409
c0133624 copy_page_range                             202   0.2644
c01150b0 do_page_fault                               409   0.3658
c0133920 zap_pte_range                               421   0.9656
c013836c page_add_rmap                               570   2.7404
c013431c do_wp_page                                  846   1.1371
c013843c page_remove_rmap                            850   2.7597
00000000 total                                      5952   0.0036

SMP:
pushpatch 9999  3.89s user 10.38s system 100% cpu 14.152 total
poppatch 999  2.83s user 6.20s system 99% cpu 9.045 total

c0138478 __set_page_dirty_buffers                    654   1.6188
c01f9560 __copy_to_user_ll                           676   6.5000
c01f95c8 __copy_from_user_ll                         727   6.6091
c011c404 copy_mm                                     809   0.8643
c013def0 clear_page_tables                           817   2.3210
c0114dec flush_tlb_page                              854   5.9306
c013fea8 do_no_page                                  909   1.2625
c013d420 install_page                               1068   2.2250
c0117c5c pte_alloc_one                              1070   7.6429
c0108f88 system_call                                1230  27.9545
c013fc20 do_anonymous_page                          1316   2.0309
c0161f40 d_lookup                                   1355   3.6821
c0133d6c find_get_page                              2543  26.4896
c013b1a4 release_pages                              4227  11.1237
c0117db0 do_page_fault                              4550   3.9565
c013e6a4 zap_pte_range                              6399  11.7629
c013e26c copy_page_range                            7228   6.6926
c013f3b0 do_wp_page                                 9082  10.7607
c0143d90 page_add_rmap                             13941  41.9910
c0143edc page_remove_rmap                          18275  36.8448
c0106f94 default_idle                             137863 2651.2115
00000000 total                                    242308   0.1287

2.4.21-pre5
===========

UP:
pushpatch 9999  3.98s user 3.66s system 99% cpu 7.656 total
poppatch 9999  2.52s user 2.59s system 99% cpu 5.136 total
SMP:
pushpatch 9999  4.34s user 6.10s system 122% cpu 8.522 total
poppatch 999  2.93s user 3.90s system 118% cpu 5.761 total

c0258e70 atomic_dec_and_lock                          53   0.7067
c0129b90 unlock_page                                  63   0.5833
c0116afc copy_mm                                      71   0.0970
c01275ac handle_mm_fault                              73   0.3967
c0129cd8 __find_get_page                              77   1.1324
c011b2ec exit_notify                                  90   0.1257
c0127410 do_no_page                                   91   0.2209
c0131554 rmqueue                                      92   0.1586
c014aa94 d_lookup                                     93   0.3185
c0127324 do_anonymous_page                           100   0.4237
c0111b08 flush_tlb_page                              117   0.9750
c0106f60 system_call                                 136   2.4286
c0131b8c __free_pages                                240   6.6667
c0126080 copy_page_range                             257   0.5949
c0126230 zap_page_range                              278   0.3341
c0113ec8 do_page_fault                               954   0.7762
c0126de0 do_wp_page                                  972   1.8692
c01052c0 default_idle                               6414 114.5357
00000000 total                                     12240   0.0088



