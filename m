Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUILPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUILPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUILPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:53:57 -0400
Received: from [213.85.13.118] ([213.85.13.118]:13440 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S268119AbUILPxv (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 12 Sep 2004 11:53:51 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16708.28915.200356.565462@gargle.gargle.HOWL>
Date: Sun, 12 Sep 2004 19:53:23 +0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: 2.6.9-rc1: page_referenced_one() CPU consumption
In-Reply-To: <41424E71.3050107@yahoo.com.au>
References: <Pine.LNX.4.44.0409101315520.16623-100000@localhost.localdomain>
	<41424E71.3050107@yahoo.com.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > Hugh Dickins wrote:
 > > On Fri, 10 Sep 2004, Hugh Dickins wrote:
 > > 
 > >>I'm quite content to go back to a trylock in page_referenced_one - and
 > >>in try_to_unmap_one?  But yours is the first report of an issue there,
 > >>so I'm inclined to wait for more reports (which should come flooding in
 > >>now you mention it!), and input from those with a better grasp than I
 > >>of how vmscan pans out in practice (Andrew, Nick, Con spring to mind).
 > > 
 > > 
 > > Just want to add, that there'd be little point in changing that back
 > > to a trylock, if vmscan ends up cycling hopelessly around a larger
 > > loop - though if the larger loop is more preemptible, that's a plus.
 > > 
 > 
 > Yeah - I'm not sure why a trylock would perform better. If it is just
 > one big address space, and memory needs to be freed, presumably the
 > scanner will just choose a different page, and try the lock again.
 > 
 > Feel like doing a few more quick tests Nikita? ;)

Ok, here are my highly unscientific results.

Work-load: copying 1G _byte_ file from XNU lustre client to the UML
lustre server running in the 2.6.9-rc1 host.

Top CPU consumers according to readprofile:

2.6.9-rc1 vanilla:

  3312 prio_tree_parent                          41.4000
  3483 ide_do_request                             3.9806
  4899 page_referenced_file                      25.1231
  6138 __copy_from_user_ll                       78.6923
  7461 get_offset_pmtmr                          54.0652
  7492 __copy_to_user_ll                         96.0513
  8042 finish_task_switch                        76.5905
  9657 prio_tree_next                            76.0394
 10083 wait_task_stopped                         11.7517
 11080 sigprocmask                               53.0144
 13345 prio_tree_right                           65.4167
 14956 vma_prio_tree_next                       173.9070
 15838 prio_tree_left                            92.6199
 27049 eligible_child                           124.0780
 28533 try_to_unmap_one                          64.8477
 33810 system_call                              768.4091
 49865 __preempt_spin_lock                      547.9670
 56045 do_wait                                   47.5360
109964 page_referenced_one                      388.5654
1529155 mwait_idle                               19604.5513
2011318 total                                      0.7514

2.6.9-rc1 with patch (below) applied:

  2999 prio_tree_parent                          37.4875
  3012 ide_outbsync                             301.2000
  3272 ide_do_request                             3.7394
  4365 page_referenced_file                      22.3846
  6031 __copy_to_user_ll                         77.3205
  6296 __copy_from_user_ll                       80.7179
  7563 get_offset_pmtmr                          54.8043
  7698 finish_task_switch                        73.3143
  9133 prio_tree_next                            71.9134
  9817 wait_task_stopped                         11.4417
 13242 prio_tree_right                           64.9118
 13620 vma_prio_tree_next                       158.3721
 15736 prio_tree_left                            92.0234
 17768 sigprocmask                               85.0144
 26260 try_to_unmap_one                          59.9543
 27096 eligible_child                           124.2936
 28141 system_call                              639.5682
 41002 __preempt_spin_lock                      450.5714
 58325 do_wait                                   49.4699
101512 page_referenced_one                      347.6438
1648567 mwait_idle                               21135.4744
2107521 total                                      0.7874

Patch:
----------------------------------------------------------------------
===== mm/rmap.c 1.77 vs edited =====
--- 1.77/mm/rmap.c      2004-08-24 13:08:39 +04:00
+++ edited/mm/rmap.c    2004-09-12 19:05:26 +04:00
@@ -268,7 +268,8 @@
        if (address == -EFAULT)
                goto out;
 
-       spin_lock(&mm->page_table_lock);
+       if (!spin_trylock(&mm->page_table_lock))
+               goto out;
 
        pgd = pgd_offset(mm, address);
        if (!pgd_present(*pgd))
----------------------------------------------------------------------

I ran tests few times, and difference between patched and un-patched
kernels is within noise, so you are right, try-lock does not help.

But now I have new great idea instead. :)

I think page_referenced() should transfer dirtiness to the struct page
as it scans pte's. Basically the earlier we mark page dirty the better
file system write-back performs, because page has more chances to be
bulk-written by ->writepages(). This is better than my previous patches
to this end (that used separate function to transfer dirtiness from
pte's to the page), because

    - locking overhead is avoided

    - it's simpler.

Nick, are you still in business of benchmarking random VM patches? :-)

Nikita.
