Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUHSQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUHSQQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266591AbUHSQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:16:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:1991 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266590AbUHSQQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:16:38 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: kernbench on 512p
Date: Thu, 19 Aug 2004 12:16:33 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191216.33667.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set out to benchmark the page cache round robin stuff I posted earlier to 
see whether round robining across 256 nodes would really hurt kernbench 
performance.  What I found was that things aren't scaling well enough to make 
reasonable measurements.

                      time     user   system   %cpu    ctx    sleeps
2.6.8.1-mm1+nodespan  108.622  1588   10536    11158  31193   397966
2.6.8.1-mm1+ns+rr     105.614  1163    8631     9302  27774   420888

2.6.8.1-mm1+nodespan is just 2.6.8.1-mm1 with my last node-span patch applied.  
2.6.8.1-mm1+ns+rr is that plus the page cache round robin patch I posted 
recently.  I just extracted the 'optimal run' average for each of the above 
lines.

Here's the kernel profile.  It would be nice if the patch to show which lock 
is contended got included.  I think it was discussed awhile back, but I don't 
have one against the newly merged profiling code.

[root@ascender root]# readprofile -m System.map | sort -nr | head -30
208218076 total                                     30.1677
90036167 ia64_pal_call_static                     468938.3698
88140492 default_idle                             229532.5312
10312592 ia64_save_scratch_fpregs                 161134.2500
10306777 ia64_load_scratch_fpregs                 161043.3906
8723555 ia64_spinlock_contention                 90870.3646
121385 rcu_check_quiescent_state                316.1068
 40464 file_move                                180.6429
 32374 file_kill                                144.5268
 25316 atomic_dec_and_lock                       98.8906
 24814 clear_page                               155.0875
 17709 file_ra_state_init                       110.6813
 17603 clear_page_tables                         13.4169
 16822 copy_page                                 65.7109
 16683 del_timer_sync                            32.5840
 15098 zap_pte_range                              7.8635
 15076 __d_lookup                                16.8259
 13275 find_get_page                             31.9111
 12898 __copy_user                                5.5214
 10472 finish_task_switch                        36.3611
 10037 ia64_pfn_valid                            52.2760
  8610 get_zone_counts                           22.4219
  7905 current_kernel_time                       41.1719
  7155 __down_trylock                            22.3594
  7063 _pagebuf_find                              4.9049
  6995 xfs_ilock                                 13.6621
  6965 tasklet_action                             8.3714
  6494 free_page_and_swap_cache                  28.9911
  5652 nr_free_pages                             22.0781
  5555 xfs_trans_push_ail                         3.6165

This is a 64p profile only.  If I set the prof_cpu_mask to include all 512 
CPUs, the system livelocks.  I reset the counter right after the warmup run, 
partly through the half load run, and collected it after a few runs were 
complete.

Thanks,
Jesse
