Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHNQng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHNQng (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUHNQng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:43:36 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:1235 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S263893AbUHNQnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:43:23 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408141643.i7EGhCV3003867@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Aug 2004 12:43:11 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat Aug 14th, Martin J. Bligh wrote:
>Does time indicate more systime or user time? If it's systime (probably is)
>please take a kernel profile of each (see Documentation/basic_profiling.txt).
>That'll give us a much better clue what's going on.
>
>M.

Martin, the time is almost exclusively listed as "user" in the the "time"
results:

FAST (with mem=800M): time ls -laR /home/groups/sysmbase >/dev/null

      real    0m0.122s
      user    0m0.101s
      sys     0m0.021s

SLOW (without mem=800M): time ls -laR /home/groups/sysmbase >/dev/null
      real    0m5.175s
      user    0m5.145s
      sys     0m0.030s

Though there is a consistant sys component that is slightly higher.  I ran
profiles three times for "fast" and three times for "slow".  Here they are

FAST profile 1:
    33 __do_softirq                               0.2578
     1 groups_search                              0.0094
     1 in_group_p                                 0.0085
     1 do_mmap_pgoff                              0.0006
     5 __d_lookup                                 0.0208
     1 xfs_dir2_leaf_getdents                     0.0003
     1 xfs_trans_brelse                           0.0035
     6 strncpy_from_user                          0.0606
    49 total                                      0.0000

FAST profile 2:
     3 system_call                                0.0682
     1 do_page_fault                              0.0008
     1 groups_search                              0.0094
     1 sys_lstat64                                0.0175
     1 follow_mount                               0.0073
     1 do_lookup                                  0.0062
     3 link_path_walk                             0.0015
     5 __d_lookup                                 0.0208
     2 write_profile                              0.0312
     1 xfs_dir2_put_dirent64_direct               0.0067
     1 xfs_dir2_put_dirent64_uio                  0.0049
     1 xfs_dir2_leaf_getdents                     0.0003
     4 strncpy_from_user                          0.0404
     1 __copy_user_intel                          0.0058
     1 __copy_to_user_ll                          0.0093
    27 total                                      0.0000

FAST profile 3:
     2 system_call                                0.0455
     1 groups_search                              0.0094
     1 in_group_p                                 0.0085
     1 buffered_rmqueue                           0.0028
     1 find_vma_prev                              0.0123
     1 cp_new_stat64                              0.0037
     2 follow_mount                               0.0146
     4 link_path_walk                             0.0020
     2 dput                                       0.0058
     4 __d_lookup                                 0.0167
     1 de_put                                     0.0097
     3 write_profile                              0.0469
     2 strncpy_from_user                          0.0202
     1 __copy_user_intel                          0.0058
    26 total                                      0.0000

And here are the three "SLOW" profiles:

SLOW profile 1:
     4 system_call                                0.0909
     2 groups_search                              0.0189
     1 free_hot_cold_page                         0.0043
     1 kmem_cache_alloc                           0.0089
     1 kmem_cache_free                            0.0132
     1 __pagevec_lru_add_active                   0.0060
     1 do_wp_page                                 0.0013
     1 do_anonymous_page                          0.0027
     3 do_no_page                                 0.0040
     1 vfs_getattr                                0.0065
     2 follow_mount                               0.0146
     2 do_lookup                                  0.0124
     5 link_path_walk                             0.0024
     1 path_lookup                                0.0030
     1 dput                                       0.0029
     6 __d_lookup                                 0.0250
     3 write_profile                              0.0469
     1 xfs_bmapi                                  0.0002
     1 xfs_dir2_block_getdents                    0.0012
     2 strncpy_from_user                          0.0202
     2 __copy_user_intel                          0.0116
     7 __copy_to_user_ll                          0.0648
    49 total                                      0.0000

SLOW profile 2:
     2 system_call                                0.0455
     2 do_page_fault                              0.0015
     1 zap_pte_range                              0.0017
     1 do_anonymous_page                          0.0027
     2 do_no_page                                 0.0027
     1 follow_mount                               0.0073
     1 do_lookup                                  0.0062
     4 link_path_walk                             0.0020
     1 filldir64                                  0.0043
    10 __d_lookup                                 0.0417
     3 write_profile                              0.0469
     1 linvfs_getattr                             0.0159
     4 strncpy_from_user                          0.0404
     1 __copy_user_intel                          0.0058
     3 __copy_to_user_ll                          0.0278
     1 ata_interrupt                              0.0037
    38 total                                      0.0000

SLOW profile 3:
     4 system_call                                0.0909
     1 __might_sleep                              0.0063
     1 in_group_p                                 0.0085
     1 wake_up_page                               0.0175
     1 prep_new_page                              0.0123
     1 kmem_cache_free                            0.0132
     2 do_no_page                                 0.0027
     1 sys_llseek                                 0.0051
     1 vfs_getattr                                0.0065
     1 getname                                    0.0041
     3 link_path_walk                             0.0015
     1 path_lookup                                0.0030
    10 __d_lookup                                 0.0417
     2 write_profile                              0.0312
     1 xfs_da_brelse                              0.0034
     1 xfs_dir2_put_dirent64_direct               0.0067
     4 strncpy_from_user                          0.0404
     4 __copy_user_intel                          0.0233
     2 __copy_to_user_ll                          0.0185
    42 total                                      0.0000

Hope this helps.



-- 
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188


