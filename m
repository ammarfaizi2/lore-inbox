Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUIQMgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUIQMgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIQMgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:36:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50189 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268708AbUIQMfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:35:50 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Fri, 17 Sep 2004 15:34:59 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171157.24943.vda@port.imtp.ilyichevsk.odessa.ua> <20040917110353.GM9106@holomorphy.com>
In-Reply-To: <20040917110353.GM9106@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 14:03, William Lee Irwin III wrote:
> On Thursday 16 September 2004 15:17, William Lee Irwin III wrote:
> >> How do microbenchmarks fare, e.g. lmbench?
>
> On Fri, Sep 17, 2004 at 11:57:24AM +0300, Denis Vlasenko wrote:
> > Not a lmbench, but:
>
> [...]
>
> > 2.4:
> > # time ./openclose
> > real    0m7.455s
> > user    0m0.300s
> > sys     0m7.150s
> > 2.6:
> > # time ./openclose
> > real    0m8.170s
> > user    0m0.370s
> > sys     0m7.800s
> > 2.6 is at HZ=100 here. /etc is on ramfs.
> > configs are in attached tarball.
>
> To address this in a meaningful way, we're going to have to get some
> profiling data. The built-in kernel profiler should suffice, though you
> may want to run the test for a longer, fixed period of time (I
> recommend making the test run as long as 60s and recording the number
> of operations completed). Also, please snapshot the profile state with
> readprofile(1) immediately before and after the microbenchmark runs on
> both kernels. This should only require booting into the kernels you've
> already built with an additional commandline parameter, e.g. profile=2.

I have profile=2. Profiles were collected with this script:

./openclose100000
readprofile -m System.map -r
./openclose100000
./openclose100000
./openclose100000
./openclose100000
readprofile -m System.map | sort -r

2.4:

  2994 total                                      0.0013
   620 link_path_walk                             0.2892
   285 d_lookup                                   1.2076
   156 dput                                       0.4815
   118 kmem_cache_free                            0.7564
   109 system_call                                1.9464
   106 kmem_cache_alloc                           0.5096
   103 strncpy_from_user                          1.2875
    97 open_namei                                 0.0767
    92 fput                                       0.3710
    88 get_unused_fd                              0.2529
    85 vfs_permission                             0.3320
    79 page_follow_link                           0.2264
    79 __constant_c_and_count_memset              0.6583
    78 sys_close                                  0.9286
    72 permission                                 1.5000
    72 path_init                                  0.3000
    67 lookup_mnt                                 0.8816
    64 cached_lookup                              0.8000
    54 get_empty_filp                             0.2045
    54 fd_install                                 1.1250
    45 page_getlink                               0.2679
    44 sys_open                                   0.3438
    35 getname                                    0.2083
    31 read_cache_page                            0.1020
    30 path_release                               0.5769
    30 dnotify_flush                              0.2778
    30 dentry_open                                0.0708
    27 filp_open                                  0.3553
    26 __free_pages                               0.7222
    25 __find_get_page                            0.5682
    24 update_atime                               0.2727
    23 mark_page_accessed                         0.4423
    22 file_move                                  0.4583
    19 path_lookup                                0.4318
    19 filp_close                                 0.2065
    12 ret_from_sys_call                          0.7059
    12 locks_remove_posix                         0.0390
    12 locks_remove_flock                         0.1364
    11 __generic_copy_to_user                     0.1146
     8 write_profile                              0.1538
     6 path_walk                                  0.2143
     6 find_trylock_page                          0.0600
     4 do_truncate                                0.0312
     3 fs_may_remount_ro                          0.0417
     3 do_wp_page                                 0.0044
     3 clear_user                                 0.0312
     3 check_mnt                                  0.0577
     1 inet_rtm_newrule                           0.0017
     1 fib_lookup                                 0.0045
     1 copy_page_range                            0.0023

2.6:

  3200 total                                      0.0013
   790 link_path_walk                             0.2759
   287 __d_lookup                                 1.2756
   277 get_empty_filp                             1.4503
   146 strncpy_from_user                          1.8250
   110 dput                                       0.3254
   109 system_call                                2.4773
    98 find_trylock_page                          2.0000
    92 do_lookup                                  0.8070
    69 path_lookup                                0.2594
    68 get_unused_fd                              0.4172
    61 dentry_open                                0.1709
    60 may_open                                   0.1339
    55 follow_mount                               0.3873
    54 sys_close                                  0.6506
    54 __fput                                     0.2784
    53 kmem_cache_free                            1.0000
    53 kmem_cache_alloc                           1.0192
    50 read_cache_page                            0.0978
    45 open_namei                                 0.0323
    42 locks_remove_flock                         0.2642
    41 find_next_zero_bit                         0.2847
    41 filp_open                                  0.5775
    40 vfs_permission                             0.1465
    35 sys_open                                   0.3333
    34 getname                                    0.2125
    34 filp_close                                 0.3333
    29 dnotify_flush                              0.2762
    28 page_getlink                               0.1931
    28 file_ra_state_init                         1.1667
    28 fd_install                                 0.6364
    26 page_put_link                              0.1733
    25 file_move                                  0.6098
    23 update_atime                               0.1361
    23 syscall_exit                               2.0909
    23 lookup_mnt                                 0.2706
    18 locks_remove_posix                         0.0732
    17 fs_may_remount_ro                          0.1910
    15 permission                                 0.2273
    14 path_release                               0.2500
    12 page_follow_link_light                     0.3333
    10 file_kill                                  0.3704
     9 zap_pte_range                              0.0171
     9 write_profile                              0.1765
     9 eventpoll_init_file                        0.3462
     8 fput                                       0.3200
     7 mark_page_accessed                         0.1346
     6 eventpoll_release_file                     0.0444
     6 clear_user                                 0.1071
     4 syscall_call                               0.3636
     4 __copy_to_user_ll                          0.0101
     3 do_wp_page                                 0.0043
     3 detach_mnt                                 0.0400
     2 read_cache_pages                           0.0066
     2 page_remove_rmap                           0.0317
     1 zap_pmd_range                              0.0097
     1 unmap_vmas                                 0.0024
     1 pte_alloc_one                              0.0154
     1 process_backlog                            0.0039
     1 free_page_and_swap_cache                   0.0109
     1 free_hot_cold_page                         0.0045
     1 find_get_page                              0.0323
     1 dst_alloc                                  0.0074
     1 do_no_page                                 0.0016
     1 do_anonymous_page                          0.0033
     1 __up_write                                 0.0044

Re-sorted by 3rd column:

2.4:

   109 system_call                                1.9464
    72 permission                                 1.5000
   103 strncpy_from_user                          1.2875
   285 d_lookup                                   1.2076
    54 fd_install                                 1.1250
    78 sys_close                                  0.9286
    67 lookup_mnt                                 0.8816
    64 cached_lookup                              0.8000
   118 kmem_cache_free                            0.7564
    26 __free_pages                               0.7222
    12 ret_from_sys_call                          0.7059
    79 __constant_c_and_count_memset              0.6583
    30 path_release                               0.5769
    25 __find_get_page                            0.5682
   106 kmem_cache_alloc                           0.5096
   156 dput                                       0.4815
    22 file_move                                  0.4583
    23 mark_page_accessed                         0.4423
    19 path_lookup                                0.4318
    92 fput                                       0.3710
    27 filp_open                                  0.3553
    44 sys_open                                   0.3438
    85 vfs_permission                             0.3320
    72 path_init                                  0.3000
   620 link_path_walk                             0.2892
    30 dnotify_flush                              0.2778
    24 update_atime                               0.2727
    45 page_getlink                               0.2679
    88 get_unused_fd                              0.2529
    79 page_follow_link                           0.2264
     6 path_walk                                  0.2143
    35 getname                                    0.2083
    19 filp_close                                 0.2065
    54 get_empty_filp                             0.2045
     8 write_profile                              0.1538
    12 locks_remove_flock                         0.1364
    11 __generic_copy_to_user                     0.1146
    31 read_cache_page                            0.1020
    97 open_namei                                 0.0767
    30 dentry_open                                0.0708
     6 find_trylock_page                          0.0600
     3 check_mnt                                  0.0577
     3 fs_may_remount_ro                          0.0417
    12 locks_remove_posix                         0.0390
     4 do_truncate                                0.0312
     3 clear_user                                 0.0312
     1 fib_lookup                                 0.0045
     3 do_wp_page                                 0.0044
     1 copy_page_range                            0.0023
     1 inet_rtm_newrule                           0.0017
  2994 total                                      0.0013

2.6:

   109 system_call                                2.4773
    23 syscall_exit                               2.0909
    98 find_trylock_page                          2.0000
   146 strncpy_from_user                          1.8250
   277 get_empty_filp                             1.4503
   287 __d_lookup                                 1.2756
    28 file_ra_state_init                         1.1667
    53 kmem_cache_alloc                           1.0192
    53 kmem_cache_free                            1.0000
    92 do_lookup                                  0.8070
    54 sys_close                                  0.6506
    28 fd_install                                 0.6364
    25 file_move                                  0.6098
    41 filp_open                                  0.5775
    68 get_unused_fd                              0.4172
    55 follow_mount                               0.3873
    10 file_kill                                  0.3704
     4 syscall_call                               0.3636
     9 eventpoll_init_file                        0.3462
    35 sys_open                                   0.3333
    34 filp_close                                 0.3333
    12 page_follow_link_light                     0.3333
   110 dput                                       0.3254
     8 fput                                       0.3200
    41 find_next_zero_bit                         0.2847
    54 __fput                                     0.2784
    29 dnotify_flush                              0.2762
   790 link_path_walk                             0.2759
    23 lookup_mnt                                 0.2706
    42 locks_remove_flock                         0.2642
    69 path_lookup                                0.2594
    14 path_release                               0.2500
    15 permission                                 0.2273
    34 getname                                    0.2125
    28 page_getlink                               0.1931
    17 fs_may_remount_ro                          0.1910
     9 write_profile                              0.1765
    26 page_put_link                              0.1733
    61 dentry_open                                0.1709
    40 vfs_permission                             0.1465
    23 update_atime                               0.1361
     7 mark_page_accessed                         0.1346
    60 may_open                                   0.1339
     6 clear_user                                 0.1071
    50 read_cache_page                            0.0978
    18 locks_remove_posix                         0.0732
     6 eventpoll_release_file                     0.0444
     3 detach_mnt                                 0.0400
    45 open_namei                                 0.0323
     1 find_get_page                              0.0323
     2 page_remove_rmap                           0.0317
     9 zap_pte_range                              0.0171
     1 pte_alloc_one                              0.0154
     1 free_page_and_swap_cache                   0.0109
     4 __copy_to_user_ll                          0.0101
     1 zap_pmd_range                              0.0097
     1 dst_alloc                                  0.0074
     2 read_cache_pages                           0.0066
     1 free_hot_cold_page                         0.0045
     1 __up_write                                 0.0044
     3 do_wp_page                                 0.0043
     1 process_backlog                            0.0039
     1 do_anonymous_page                          0.0033
     1 unmap_vmas                                 0.0024
     1 do_no_page                                 0.0016
  3200 total                                      0.0013

--
vda

