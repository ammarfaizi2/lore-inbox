Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTBWDOD>; Sat, 22 Feb 2003 22:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbTBWDOD>; Sat, 22 Feb 2003 22:14:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:63940 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268016AbTBWDOB>;
	Sat, 22 Feb 2003 22:14:01 -0500
Date: Sat, 22 Feb 2003 19:24:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-Id: <20030222192424.6ba7e859.akpm@digeo.com>
In-Reply-To: <96700000.1045871294@w-hlinder>
References: <96700000.1045871294@w-hlinder>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2003 03:24:05.0659 (UTC) FILETIME=[050B46B0:01C2DAEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> wrote:
>
> 
> 	Dave coded up an initial patch for partial object based rmap
> which he sent to linux-mm yesterday.

I've run some numbers on this.  Looks like it reclaims most of the
fork/exec/exit rmap overhead.

The testcase is applying and removing 64 kernel patches using my patch
management scripts.  I use this because

a) It's a real workload, which someone cares about and

b) It's about as forky as anything is ever likely to be, without being a
   stupid microbenchmark.

Testing is on the fast P4-HT, everything in pagecache.

2.4.21-pre4:                    8.10 seconds
2.5.62-mm3 with objrmap:        9.95 seconds	(+1.85)
2.5.62-mm3 without objrmap:     10.86 seconds   (+0.91)

Current 2.5 is 2.76 seconds slower, and this patch reclaims 0.91 of those
seconds.


So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.

Here is 2.5.62-mm3, with objrmap:

c013042c find_get_page                               601  10.7321
c01333dc free_hot_cold_page                          641   2.7629
c0207130 __copy_to_user_ll                           687   6.6058
c011450c flush_tlb_page                              725   6.4732
c0139ba0 clear_page_tables                           841   2.4735
c011718c pte_alloc_one                               910   6.5000
c013b56c do_anonymous_page                           954   1.7667
c013b788 do_no_page                                 1044   1.6519
c015b59c d_lookup                                   1096   3.2619
c013ba00 handle_mm_fault                            1098   4.6525
c0108d14 system_call                                1116  25.3636
c0137240 release_pages                              1828   6.4366
c013a1f4 zap_pte_range                              2616   4.8806
c013f5c0 page_add_rmap                              2776   8.3614
c0139eac copy_page_range                            2994   3.5643
c013f70c page_remove_rmap                           3132   6.2640
c013adb4 do_wp_page                                 6712   8.4322
c01172e0 do_page_fault                              8788   7.7496
c0106ed8 poll_idle                                 99878 1189.0238
00000000 total                                    158601   0.0869

Note one second spent in pte_alloc_one().


Here is 2.4.21-pre4, with the following functions uninlined

pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address);
pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address);
void pte_free_fast(pte_t *pte);
void pte_free_slow(pte_t *pte);

c0252950 atomic_dec_and_lock                          36   0.4800
c0111778 flush_tlb_mm                                 37   0.3304
c0129c3c file_read_actor                              37   0.2569
c025282c strnlen_user                                 43   0.5119
c012b35c generic_file_write                           46   0.0283
c0114c78 schedule                                     48   0.0361
c0129050 unlock_page                                  53   0.4907
c0140974 link_path_walk                               57   0.0237
c0116740 copy_mm                                      62   0.0852
c0130740 __free_pages_ok                              62   0.0963
c0126afc handle_mm_fault                              63   0.3424
c01254c0 __free_pte                                   67   0.8816
c0129198 __find_get_page                              67   0.9853
c01309c4 rmqueue                                      70   0.1207
c011ae0c exit_notify                                  77   0.1075
c0149b34 d_lookup                                     81   0.2774
c0126874 do_anonymous_page                            83   0.3517
c0126960 do_no_page                                   86   0.2087
c01117e8 flush_tlb_page                              105   0.8750
c0106f54 system_call                                 138   2.4643
c01255c8 copy_page_range                             197   0.4603
c0130ffc __free_pages                                204   5.6667
c0125774 zap_page_range                              262   0.3104
c0126330 do_wp_page                                  775   1.4904
c0113c18 do_page_fault                               864   0.7030
c01052f8 poll_idle                                  6803 170.0750
00000000 total                                     11923   0.0087

Note the lack of pte_alloc_one_slow().

So we need the page table cache back.

We cannot put it in slab, because slab does not do highmem.

I believe the best way to solve this is to implement a per-cpu LIFO head
array of known-to-be-zeroed pages in the page allocator.  Populate it with
free_zeroed_page(), grab pages from it with __GFP_ZEROED.

This is a simple extension to the existing hot and cold head arrays, and I
have patches, and they don't work.  Something in the pagetable freeing path
seems to be putting back pages which are not fully zeroed, and I didn't get
onto debugging it.

It would be nice to get it going, because a number of architectures can
perhaps nuke their private pagetable caches.

I shall drop the patches in next-mm/experimental and look hopefully
at Dave ;)
