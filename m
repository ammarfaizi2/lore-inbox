Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbUJ1GDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUJ1GDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbUJ1GDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:03:17 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:64422 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S262795AbUJ1Fz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:55:57 -0400
Message-ID: <41808A20.2030408@metaparadigm.com>
Date: Thu, 28 Oct 2004 13:56:48 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
References: <41808419.8070104@metaparadigm.com>
In-Reply-To: <41808419.8070104@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/04 13:31, Michael Clark wrote:
> Hi All,
> 
> I've been some doing load testing to compare 2.4.27 and 2.6.9
> under heavy memory pressure (in eye of deploying a 2.6 kernel).
> No benchmarks at the moment - my main concern is getting 2.6
> to survive the tests gracefully.
> 
> So in my survival suite I run a 'make -j192 bzImage modules'
> and the machine is 2-way P3 1GHz - 2GB RAM + 2GB swap. With my
> .config this is enough to push the machine about 1.7GB into swap
> (3.7GB virtual) during some points of the kernel compile test.
> 
> Anyway 2.4.27 survives without a blip.
> 
> In 2.6.9, the compile completes okay although I see the page
> allocation failures logged below. I'm guessing they are not
> critical and the process faulting on the page to swap in will
> just sleep and retry again later??
> 
> The machine was only about 800MB into swap when they happened.
> 
> It kept going and eventually went 2GB into swap at one point
> with top reporting 0K swap free (2.4 only got to 1.7GB), i guess
> at this point it was evicting file backed pages to free memory
> to keep going, which it did manage to do.
> 
> So, are the messages critical or not? (i didn't see any errors
> from gcc). They all seem to be allocations in radix_tree_node_alloc
> called from add_to_swap_cache. How to fix?

Running the test again i'm getting them showing up from different
places. Compile still completes with no errors.

as: page allocation failure. order:0, mode:0x20
  [<c013ba43>] __alloc_pages+0x1c3/0x390
  [<c013a5e3>] mempool_alloc+0x73/0x140
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c02bc91e>] schedule+0x30e/0x620
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0140499>] kmem_cache_alloc+0x49/0x50
  [<c02134d9>] alloc_as_io_context+0x19/0x80
  [<c0213575>] as_get_io_context+0x35/0x50
  [<c0214cbe>] as_add_request+0x3e/0x220
  [<c020c205>] __elv_add_request+0x45/0xb0
  [<c020f59e>] __make_request+0x2be/0x520
  [<c020f906>] generic_make_request+0x106/0x190
  [<c015b700>] bio_alloc+0x20/0x1e0
  [<c011a8a0>] autoremove_wake_function+0x0/0x60
  [<c015b921>] bio_clone+0x21/0xa0
  [<c0252341>] make_request+0x241/0x310
  [<c0197ae0>] ext3_mark_inode_dirty+0x50/0x60
  [<c0157817>] wake_up_buffer+0x17/0x60
  [<c020f906>] generic_make_request+0x106/0x190
  [<c020fa00>] submit_bio+0x70/0x120
  [<c013d8fb>] test_set_page_writeback+0xbb/0x110
  [<c0137207>] wake_up_page+0x17/0x50
  [<c014d69d>] swap_writepage+0x9d/0xd0
  [<c014d550>] end_swap_bio_write+0x0/0x50
  [<c01428a5>] pageout+0xc5/0x110
  [<c0142b01>] shrink_list+0x211/0x480
  [<c014bf7c>] page_referenced_anon+0x7c/0x90
  [<c01419c8>] __pagevec_release+0x28/0x40
  [<c0142eec>] shrink_cache+0x17c/0x3d0
  [<c014373a>] shrink_zone+0xba/0xf0
  [<c01437e6>] shrink_caches+0x76/0x80
  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
  [<c013baab>] __alloc_pages+0x22b/0x390
  [<c0146780>] do_wp_page+0x90/0x2e0
  [<c014542a>] pte_alloc_map+0x9a/0xc0
  [<c0145a73>] zap_pmd_range+0x63/0x80
  [<c01476a5>] handle_mm_fault+0x185/0x1a0
  [<c011586c>] do_page_fault+0x19c/0x5c0
  [<c0157520>] __fput+0xb0/0x110
  [<c0148247>] remove_vm_struct+0x77/0xa0
  [<c0149b5f>] unmap_vma_list+0x1f/0x30
  [<c0149f53>] do_munmap+0x153/0x1b0
  [<c014a001>] sys_munmap+0x51/0x80
  [<c01156d0>] do_page_fault+0x0/0x5c0
  [<c0106ab1>] error_code+0x2d/0x38
as: page allocation failure. order:0, mode:0x20
  [<c013ba43>] __alloc_pages+0x1c3/0x390
  [<c013a5e3>] mempool_alloc+0x73/0x140
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c02bc91e>] schedule+0x30e/0x620
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0140499>] kmem_cache_alloc+0x49/0x50
  [<c02134d9>] alloc_as_io_context+0x19/0x80
  [<c0213575>] as_get_io_context+0x35/0x50
  [<c0214cbe>] as_add_request+0x3e/0x220
  [<c020c205>] __elv_add_request+0x45/0xb0
  [<c020f59e>] __make_request+0x2be/0x520
  [<c020f906>] generic_make_request+0x106/0x190
  [<c015b700>] bio_alloc+0x20/0x1e0
  [<c011a8a0>] autoremove_wake_function+0x0/0x60
  [<c015b921>] bio_clone+0x21/0xa0
  [<c0252341>] make_request+0x241/0x310
  [<c020f906>] generic_make_request+0x106/0x190
  [<c020fa00>] submit_bio+0x70/0x120
  [<c013d8fb>] test_set_page_writeback+0xbb/0x110
  [<c0137207>] wake_up_page+0x17/0x50
  [<c014d69d>] swap_writepage+0x9d/0xd0
  [<c014d550>] end_swap_bio_write+0x0/0x50
  [<c01428a5>] pageout+0xc5/0x110
  [<c0142b01>] shrink_list+0x211/0x480
  [<c014bf7c>] page_referenced_anon+0x7c/0x90
  [<c01419c8>] __pagevec_release+0x28/0x40
  [<c0142eec>] shrink_cache+0x17c/0x3d0
  [<c014373a>] shrink_zone+0xba/0xf0
  [<c01437e6>] shrink_caches+0x76/0x80
  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
  [<c013baab>] __alloc_pages+0x22b/0x390
  [<c0146780>] do_wp_page+0x90/0x2e0
  [<c014542a>] pte_alloc_map+0x9a/0xc0
  [<c0145a73>] zap_pmd_range+0x63/0x80
  [<c01476a5>] handle_mm_fault+0x185/0x1a0
  [<c011586c>] do_page_fault+0x19c/0x5c0
  [<c0157520>] __fput+0xb0/0x110
  [<c0148247>] remove_vm_struct+0x77/0xa0
  [<c0149b5f>] unmap_vma_list+0x1f/0x30
  [<c0149f53>] do_munmap+0x153/0x1b0
  [<c014a001>] sys_munmap+0x51/0x80
  [<c01156d0>] do_page_fault+0x0/0x5c0
  [<c0106ab1>] error_code+0x2d/0x38
cc1: page allocation failure. order:0, mode:0x20
  [<c013ba43>] __alloc_pages+0x1c3/0x390
  [<c013a5e3>] mempool_alloc+0x73/0x140
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c02bc91e>] schedule+0x30e/0x620
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0140499>] kmem_cache_alloc+0x49/0x50
  [<c02134d9>] alloc_as_io_context+0x19/0x80
  [<c0213575>] as_get_io_context+0x35/0x50
  [<c0214cbe>] as_add_request+0x3e/0x220
  [<c020c205>] __elv_add_request+0x45/0xb0
  [<c020f59e>] __make_request+0x2be/0x520
  [<c020f906>] generic_make_request+0x106/0x190
  [<c011007b>] mtrr_ioctl+0x6b/0x510
  [<c015b92d>] bio_clone+0x2d/0xa0
  [<c0252341>] make_request+0x241/0x310
  [<c020f906>] generic_make_request+0x106/0x190
  [<c020fa00>] submit_bio+0x70/0x120
  [<c013d8fb>] test_set_page_writeback+0xbb/0x110
  [<c0137207>] wake_up_page+0x17/0x50
  [<c014d69d>] swap_writepage+0x9d/0xd0
  [<c014d550>] end_swap_bio_write+0x0/0x50
  [<c01428a5>] pageout+0xc5/0x110
  [<c0142b01>] shrink_list+0x211/0x480
  [<c014bf7c>] page_referenced_anon+0x7c/0x90
  [<c01419c8>] __pagevec_release+0x28/0x40
  [<c0142eec>] shrink_cache+0x17c/0x3d0
  [<c01471e0>] do_no_page+0x60/0x290
  [<c014373a>] shrink_zone+0xba/0xf0
  [<c01437e6>] shrink_caches+0x76/0x80
  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
  [<c013baab>] __alloc_pages+0x22b/0x390
  [<c0147095>] do_anonymous_page+0x95/0x180
  [<c01471e0>] do_no_page+0x60/0x290
  [<c0147640>] handle_mm_fault+0x120/0x1a0
  [<c011586c>] do_page_fault+0x19c/0x5c0
  [<c012df40>] __rcu_process_callbacks+0xc0/0x110
  [<c0117a8c>] finish_task_switch+0x3c/0x90
  [<c02bc91e>] schedule+0x30e/0x620
  [<c01218fa>] __do_softirq+0xba/0xd0
  [<c01156d0>] do_page_fault+0x0/0x5c0
  [<c0106ab1>] error_code+0x2d/0x38
make: page allocation failure. order:0, mode:0x20
  [<c013ba43>] __alloc_pages+0x1c3/0x390
  [<c013a5e3>] mempool_alloc+0x73/0x140
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c02bc91e>] schedule+0x30e/0x620
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0140499>] kmem_cache_alloc+0x49/0x50
  [<c02134d9>] alloc_as_io_context+0x19/0x80
  [<c0213575>] as_get_io_context+0x35/0x50
  [<c0214cbe>] as_add_request+0x3e/0x220
  [<c020c205>] __elv_add_request+0x45/0xb0
  [<c020f59e>] __make_request+0x2be/0x520
  [<c020f906>] generic_make_request+0x106/0x190
  [<c015b700>] bio_alloc+0x20/0x1e0
  [<c011a8a0>] autoremove_wake_function+0x0/0x60
  [<c015b921>] bio_clone+0x21/0xa0
  [<c0252341>] make_request+0x241/0x310
  [<c020f906>] generic_make_request+0x106/0x190
  [<c020fa00>] submit_bio+0x70/0x120
  [<c013d8fb>] test_set_page_writeback+0xbb/0x110
  [<c0137207>] wake_up_page+0x17/0x50
  [<c014d69d>] swap_writepage+0x9d/0xd0
  [<c014d550>] end_swap_bio_write+0x0/0x50
  [<c01428a5>] pageout+0xc5/0x110
  [<c0142b01>] shrink_list+0x211/0x480
  [<c014bf7c>] page_referenced_anon+0x7c/0x90
  [<c01419c8>] __pagevec_release+0x28/0x40
  [<c0142eec>] shrink_cache+0x17c/0x3d0
  [<c014373a>] shrink_zone+0xba/0xf0
  [<c01437e6>] shrink_caches+0x76/0x80
  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
  [<c013baab>] __alloc_pages+0x22b/0x390
  [<c01376ac>] find_or_create_page+0x8c/0xa0
  [<c0158c71>] grow_dev_page+0x31/0x130
  [<c0158e08>] __getblk_slow+0x98/0x110
  [<c015920f>] __getblk+0x4f/0x60
  [<c0194b33>] ext3_getblk+0x93/0x270
  [<c0198c47>] ext3_find_entry+0x137/0x440
  [<c01991d1>] ext3_lookup+0x41/0xd0
  [<c0163f45>] real_lookup+0xd5/0x100
  [<c01641e6>] do_lookup+0x96/0xb0
  [<c016489f>] link_path_walk+0x69f/0xd20
  [<c01651e1>] path_lookup+0x91/0x160
  [<c0161080>] open_exec+0x30/0x100
  [<c0162103>] do_execve+0x13/0x230
  [<c0104b02>] sys_execve+0x42/0x80
  [<c010603f>] syscall_call+0x7/0xb

make: page allocation failure. order:0, mode:0x20
  [<c013ba43>] __alloc_pages+0x1c3/0x390
  [<c013a5e3>] mempool_alloc+0x73/0x140
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c02bc91e>] schedule+0x30e/0x620
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0140499>] kmem_cache_alloc+0x49/0x50
  [<c02134d9>] alloc_as_io_context+0x19/0x80
  [<c0213575>] as_get_io_context+0x35/0x50
  [<c0214cbe>] as_add_request+0x3e/0x220
  [<c020c205>] __elv_add_request+0x45/0xb0
  [<c020f59e>] __make_request+0x2be/0x520
  [<c020f906>] generic_make_request+0x106/0x190
  [<c015b700>] bio_alloc+0x20/0x1e0
  [<c011a8a0>] autoremove_wake_function+0x0/0x60
  [<c015b921>] bio_clone+0x21/0xa0
  [<c0252341>] make_request+0x241/0x310
  [<c020f906>] generic_make_request+0x106/0x190
  [<c020fa00>] submit_bio+0x70/0x120
  [<c013d8fb>] test_set_page_writeback+0xbb/0x110
  [<c0137207>] wake_up_page+0x17/0x50
  [<c014d69d>] swap_writepage+0x9d/0xd0
  [<c014d550>] end_swap_bio_write+0x0/0x50
  [<c01428a5>] pageout+0xc5/0x110
  [<c0142b01>] shrink_list+0x211/0x480
  [<c014bf7c>] page_referenced_anon+0x7c/0x90
  [<c01419c8>] __pagevec_release+0x28/0x40
  [<c0142eec>] shrink_cache+0x17c/0x3d0
  [<c020f5c3>] __make_request+0x2e3/0x520
  [<c014373a>] shrink_zone+0xba/0xf0
  [<c01437e6>] shrink_caches+0x76/0x80
  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
  [<c013baab>] __alloc_pages+0x22b/0x390
  [<c013bc35>] __get_free_pages+0x25/0x40
  [<c013f283>] kmem_getpages+0x23/0xd0
  [<c013ffcf>] cache_grow+0xaf/0x160
  [<c0140202>] cache_alloc_refill+0x182/0x230
  [<c0159151>] __find_get_block+0x61/0xd0
  [<c01406a8>] __kmalloc+0x88/0xa0
  [<c01ab3e8>] __jbd_kmalloc+0x28/0x30
  [<c01a37a2>] do_get_write_access+0x232/0x670
  [<c01591eb>] __getblk+0x2b/0x60
  [<c0196d0a>] ext3_get_inode_loc+0x5a/0x260
  [<c01a3c17>] journal_get_write_access+0x37/0x50
  [<c0197a15>] ext3_reserve_inode_write+0x55/0xd0
  [<c0116e98>] task_rq_lock+0x38/0x70
  [<c0197abb>] ext3_mark_inode_dirty+0x2b/0x60
  [<c016f29d>] __d_lookup+0x10d/0x130
  [<c0197b7c>] ext3_dirty_inode+0x8c/0x90
  [<c0197af0>] ext3_dirty_inode+0x0/0x90
  [<c017794a>] __mark_inode_dirty+0x1da/0x1e0
  [<c016f164>] d_lookup+0x34/0x60
  [<c01713c9>] update_atime+0xd9/0xe0
  [<c0164969>] link_path_walk+0x769/0xd20
  [<c01651e1>] path_lookup+0x91/0x160
  [<c0161080>] open_exec+0x30/0x100
  [<c0162103>] do_execve+0x13/0x230
  [<c0104b02>] sys_execve+0x42/0x80
  [<c010603f>] syscall_call+0x7/0xb




> The kerenl is plain 2.6.9 + Nick Piggin's
>   vm-pages_scanned-active_list.patch
> (as in earlier runs I saw kswapd periodically chewing CPU so I
> picked this patch out of a mail from Nick in reply to someone
> with a similar problem).
> 
> BTW - 2.6 is much more responsive than 2.4 while this is all
> going on - i'm just worried about these messages.
> 
> ~mc
> 
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c0147095>] do_anonymous_page+0x95/0x180
>  [<c014e32f>] swap_free+0x2f/0x50
>  [<c01471e0>] do_no_page+0x60/0x290
>  [<c0147640>] handle_mm_fault+0x120/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c0125916>] update_wall_time+0x16/0x40
>  [<c0125d50>] do_timer+0xc0/0xd0
>  [<c010cb60>] timer_interrupt+0xc0/0x130
>  [<c0108984>] handle_IRQ_event+0x34/0x70
>  [<c0108d5a>] do_IRQ+0xca/0x130
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> uml_switch: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c0169a6c>] __pollwait+0x8c/0xd0
>  [<f8820e8b>] unix_poll+0x2b/0xb0 [unix]
>  [<c025d909>] sock_poll+0x29/0x40
>  [<c016a455>] do_pollfd+0x95/0xa0
>  [<c016a4ca>] do_poll+0x6a/0xd0
>  [<c016a691>] sys_poll+0x161/0x240
>  [<c01699e0>] __pollwait+0x0/0xd0
>  [<c010603f>] syscall_call+0x7/0xb
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c0147095>] do_anonymous_page+0x95/0x180
>  [<c01471e0>] do_no_page+0x60/0x290
>  [<c0147640>] handle_mm_fault+0x120/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c01ff8f0>] i8042_interrupt+0x50/0x190
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> uml_switch: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c0169a6c>] __pollwait+0x8c/0xd0
>  [<f8820e8b>] unix_poll+0x2b/0xb0 [unix]
>  [<c025d909>] sock_poll+0x29/0x40
>  [<c016a455>] do_pollfd+0x95/0xa0
>  [<c016a4ca>] do_poll+0x6a/0xd0
>  [<c016a691>] sys_poll+0x161/0x240
>  [<c01699e0>] __pollwait+0x0/0xd0
>  [<c010603f>] syscall_call+0x7/0xb
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c01c1131>] radix_tree_delete+0x141/0x190
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c014de51>] read_swap_cache_async+0xb1/0xd0
>  [<c0146d3f>] swapin_readahead+0x4f/0x80
>  [<c0146f54>] do_swap_page+0x1e4/0x290
>  [<c014542a>] pte_alloc_map+0x9a/0xc0
>  [<c0147617>] handle_mm_fault+0xf7/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c02441ba>] sd_rw_intr+0x5a/0x1e0
>  [<c0222504>] scsi_device_unbusy+0x44/0x80
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c020f906>] generic_make_request+0x106/0x190
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c0881>] radix_tree_preload+0x51/0xb0
>  [<c014d80b>] __add_to_swap_cache+0x3b/0x100
>  [<c014d904>] add_to_swap_cache+0x34/0x80
>  [<c014de01>] read_swap_cache_async+0x61/0xd0
>  [<c0146d3f>] swapin_readahead+0x4f/0x80
>  [<c0146f54>] do_swap_page+0x1e4/0x290
>  [<c014542a>] pte_alloc_map+0x9a/0xc0
>  [<c0147617>] handle_mm_fault+0xf7/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c0222504>] scsi_device_unbusy+0x44/0x80
>  [<c01ffb60>] i8042_timer_func+0x0/0x20
>  [<c01ffb7b>] i8042_timer_func+0x1b/0x20
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c02bc91e>] schedule+0x30e/0x620
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c014de51>] read_swap_cache_async+0xb1/0xd0
>  [<c0146d3f>] swapin_readahead+0x4f/0x80
>  [<c0146f54>] do_swap_page+0x1e4/0x290
>  [<c014542a>] pte_alloc_map+0x9a/0xc0
>  [<c0147617>] handle_mm_fault+0xf7/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c02441ba>] sd_rw_intr+0x5a/0x1e0
>  [<c0222504>] scsi_device_unbusy+0x44/0x80
>  [<c0125916>] update_wall_time+0x16/0x40
>  [<c0125d50>] do_timer+0xc0/0xd0
>  [<c010cb60>] timer_interrupt+0xc0/0x130
>  [<c0108984>] handle_IRQ_event+0x34/0x70
>  [<c0108d5a>] do_IRQ+0xca/0x130
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c0222504>] scsi_device_unbusy+0x44/0x80
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c0147095>] do_anonymous_page+0x95/0x180
>  [<c014e32f>] swap_free+0x2f/0x50
>  [<c01471e0>] do_no_page+0x60/0x290
>  [<c0147640>] handle_mm_fault+0x120/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c0222504>] scsi_device_unbusy+0x44/0x80
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c0147095>] do_anonymous_page+0x95/0x180
>  [<c014e32f>] swap_free+0x2f/0x50
>  [<c01471e0>] do_no_page+0x60/0x290
>  [<c0147640>] handle_mm_fault+0x120/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014da5f>] add_to_swap+0x5f/0xc0
>  [<c0142d32>] shrink_list+0x442/0x480
>  [<c014bf7c>] page_referenced_anon+0x7c/0x90
>  [<c01419c8>] __pagevec_release+0x28/0x40
>  [<c0142eec>] shrink_cache+0x17c/0x3d0
>  [<c014373a>] shrink_zone+0xba/0xf0
>  [<c01437e6>] shrink_caches+0x76/0x80
>  [<c01438b4>] try_to_free_pages+0xc4/0x1b0
>  [<c013baab>] __alloc_pages+0x22b/0x390
>  [<c014de51>] read_swap_cache_async+0xb1/0xd0
>  [<c0146d3f>] swapin_readahead+0x4f/0x80
>  [<c0146f54>] do_swap_page+0x1e4/0x290
>  [<c014542a>] pte_alloc_map+0x9a/0xc0
>  [<c0147617>] handle_mm_fault+0xf7/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c01630a8>] pipe_write+0x38/0x40
>  [<c01727ba>] dnotify_parent+0x3a/0xb0
>  [<c0156762>] vfs_write+0xd2/0x130
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c0156891>] sys_write+0x51/0x80
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> cc1: page allocation failure. order:0, mode:0x20
>  [<c013ba43>] __alloc_pages+0x1c3/0x390
>  [<c013bc35>] __get_free_pages+0x25/0x40
>  [<c013f283>] kmem_getpages+0x23/0xd0
>  [<c013ffcf>] cache_grow+0xaf/0x160
>  [<c0140202>] cache_alloc_refill+0x182/0x230
>  [<c0117a8c>] finish_task_switch+0x3c/0x90
>  [<c0140499>] kmem_cache_alloc+0x49/0x50
>  [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>  [<c01c0aad>] radix_tree_insert+0xed/0x110
>  [<c014d841>] __add_to_swap_cache+0x71/0x100
>  [<c014d904>] add_to_swap_cache+0x34/0x80
>  [<c014de01>] read_swap_cache_async+0x61/0xd0
>  [<c0146d3f>] swapin_readahead+0x4f/0x80
>  [<c0146f54>] do_swap_page+0x1e4/0x290
>  [<c014542a>] pte_alloc_map+0x9a/0xc0
>  [<c0147617>] handle_mm_fault+0xf7/0x1a0
>  [<c011586c>] do_page_fault+0x19c/0x5c0
>  [<c0125bdf>] run_timer_softirq+0xff/0x1a0
>  [<c0118d23>] scheduler_tick+0x123/0x480
>  [<c01218fa>] __do_softirq+0xba/0xd0
>  [<c01156d0>] do_page_fault+0x0/0x5c0
>  [<c0106ab1>] error_code+0x2d/0x38
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.9-skas3-v6
> # Tue Oct 26 21:22:17 2004
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_HOTPLUG=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> CONFIG_STOP_MACHINE=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HPET_TIMER is not set
> CONFIG_SMP=y
> CONFIG_NR_CPUS=4
> # CONFIG_SCHED_SMT is not set
> # CONFIG_PREEMPT is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=m
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> CONFIG_PROC_MM=y
> # CONFIG_HIGHPTE is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> # CONFIG_IRQBALANCE is not set
> CONFIG_HAVE_DEC_LOCK=y
> # CONFIG_REGPARM is not set
> 
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
> # CONFIG_PM_DEBUG is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_ASUS=m
> CONFIG_ACPI_TOSHIBA=m
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_X86_PM_TIMER is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> 
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_MISC=m
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=m
> CONFIG_BLK_DEV_IDE=m
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_IDEDISK is not set
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> # CONFIG_IDE_TASKFILE_IO is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> CONFIG_BLK_DEV_SVWKS=m
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=0
> # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=y
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> CONFIG_SCSI_QLA2300=m
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA6322 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=y
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID5=m
> # CONFIG_MD_RAID6 is not set
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_BLK_DEV_DM=m
> # CONFIG_DM_CRYPT is not set
> CONFIG_DM_SNAPSHOT=m
> CONFIG_DM_MIRROR=m
> # CONFIG_DM_ZERO is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=m
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=m
> CONFIG_UNIX=m
> CONFIG_NET_KEY=m
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_TUNNEL=m
> 
> #
> # IP: Virtual Server Configuration
> #
> CONFIG_IP_VS=m
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> # CONFIG_IP_VS_PROTO_ESP is not set
> # CONFIG_IP_VS_PROTO_AH is not set
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> 
> #
> # IPVS application helper
> #
> # CONFIG_IP_VS_FTP is not set
> CONFIG_IPV6=m
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_INET6_TUNNEL=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_BRIDGE_NETFILTER=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_CT_ACCT=y
> # CONFIG_IP_NF_CT_PROTO_SCTP is not set
> # CONFIG_IP_NF_FTP is not set
> # CONFIG_IP_NF_IRC is not set
> # CONFIG_IP_NF_TFTP is not set
> # CONFIG_IP_NF_AMANDA is not set
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_IPRANGE=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_RECENT=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_DSCP=m
> CONFIG_IP_NF_MATCH_AH_ESP=m
> CONFIG_IP_NF_MATCH_LENGTH=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_HELPER=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_CONNTRACK=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_MATCH_PHYSDEV=m
> CONFIG_IP_NF_MATCH_ADDRTYPE=m
> # CONFIG_IP_NF_MATCH_REALM is not set
> # CONFIG_IP_NF_MATCH_SCTP is not set
> CONFIG_IP_NF_MATCH_COMMENT=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_SAME=m
> CONFIG_IP_NF_NAT_LOCAL=y
> # CONFIG_IP_NF_NAT_SNMP_BASIC is not set
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> # CONFIG_IP_NF_TARGET_DSCP is not set
> CONFIG_IP_NF_TARGET_MARK=m
> # CONFIG_IP_NF_TARGET_CLASSIFY is not set
> # CONFIG_IP_NF_RAW is not set
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
> # CONFIG_IP_NF_COMPAT_IPFWADM is not set
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_QUEUE=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_PHYSDEV=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> # CONFIG_IP6_NF_RAW is not set
> 
> #
> # Bridge: Netfilter Configuration
> #
> CONFIG_BRIDGE_NF_EBTABLES=m
> CONFIG_BRIDGE_EBT_BROUTE=m
> CONFIG_BRIDGE_EBT_T_FILTER=m
> CONFIG_BRIDGE_EBT_T_NAT=m
> CONFIG_BRIDGE_EBT_802_3=m
> CONFIG_BRIDGE_EBT_AMONG=m
> CONFIG_BRIDGE_EBT_ARP=m
> CONFIG_BRIDGE_EBT_IP=m
> CONFIG_BRIDGE_EBT_LIMIT=m
> CONFIG_BRIDGE_EBT_MARK=m
> CONFIG_BRIDGE_EBT_PKTTYPE=m
> CONFIG_BRIDGE_EBT_STP=m
> CONFIG_BRIDGE_EBT_VLAN=m
> CONFIG_BRIDGE_EBT_ARPREPLY=m
> CONFIG_BRIDGE_EBT_DNAT=m
> CONFIG_BRIDGE_EBT_MARK_T=m
> CONFIG_BRIDGE_EBT_REDIRECT=m
> CONFIG_BRIDGE_EBT_SNAT=m
> CONFIG_BRIDGE_EBT_LOG=m
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=m
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_MSG is not set
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_HMAC_NONE is not set
> # CONFIG_SCTP_HMAC_SHA1 is not set
> CONFIG_SCTP_HMAC_MD5=y
> # CONFIG_ATM is not set
> CONFIG_BRIDGE=m
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> CONFIG_ATALK=m
> # CONFIG_DEV_APPLETALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> # CONFIG_NET_CLS_ROUTE is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=m
> CONFIG_ETHERTAP=m
> 
> #
> # ARCnet devices
> #
> CONFIG_ARCNET=m
> CONFIG_ARCNET_1201=m
> CONFIG_ARCNET_1051=m
> CONFIG_ARCNET_RAW=m
> CONFIG_ARCNET_COM90xx=m
> CONFIG_ARCNET_COM90xxIO=m
> CONFIG_ARCNET_RIM_I=m
> CONFIG_ARCNET_COM20020=m
> CONFIG_ARCNET_COM20020_PCI=m
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=y
> # CONFIG_E100_NAPI is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=m
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> # CONFIG_PPPOE is not set
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> # CONFIG_SERIO_RAW is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_SC520_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I8XX_TCO is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_SCx200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=m
> CONFIG_RTC=m
> CONFIG_GEN_RTC=m
> CONFIG_GEN_RTC_X=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=m
> # CONFIG_HPET is not set
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HANGCHECK_TIMER=y
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> # CONFIG_I2C_CHARDEV is not set
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=m
> # CONFIG_I2C_ALGOPCA is not set
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_ISA is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
> # CONFIG_I2C_PCA_ISA is not set
> 
> #
> # Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
> 
> #
> # Other I2C Chip support
> #
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_RTC8564 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_BANDWIDTH=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_EHCI_HCD is not set
> CONFIG_USB_OHCI_HCD=m
> # CONFIG_USB_UHCI_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_RW_DETECT is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_HP8200e is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> 
> #
> # USB Human Interface Devices (HID)
> #
> # CONFIG_USB_HID is not set
> 
> #
> # USB HID Boot Protocol drivers
> #
> CONFIG_USB_KBD=m
> CONFIG_USB_MOUSE=m
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
> 
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_BELKIN is not set
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> CONFIG_USB_SERIAL_PL2303=m
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_XIRCOM is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_TEST is not set
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_EXT2_FS_SECURITY is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=m
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_QUOTA=y
> # CONFIG_XFS_SECURITY is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=m
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=m
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> CONFIG_RPCSEC_GSS_SPKM3=m
> CONFIG_SMB_FS=m
> CONFIG_SMB_NLS_DEFAULT=y
> CONFIG_SMB_NLS_REMOTE="cp437"
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS=y
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="cp437"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=m
> 
> #
> # Profiling support
> #
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=m
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_EARLY_PRINTK=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_KPROBES is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_4KSTACKS is not set
> # CONFIG_SCHEDSTATS is not set
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> # CONFIG_CRYPTO_WP512 is not set
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_AES_586=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_ARC4=m
> # CONFIG_CRYPTO_KHAZAD is not set
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> CONFIG_CRYPTO_TEST=m
> 
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> CONFIG_CRC32=m
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_X86_SMP=y
> CONFIG_X86_HT=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_TRAMPOLINE=y
> CONFIG_PC=y

-- 
Michael Clark,  . . . . . . . . . . . .  michael@metaparadigm.com
Metaparadigm Pte. Ltd . . . . . . . . http://www.metaparadigm.com
