Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWHML7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWHML7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 07:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHML7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 07:59:47 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:53995 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751021AbWHML7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 07:59:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LemOlFJARE0IQtTuKJzX1+1GSbbnSiC1Y2a9+04j3kCfcnP0vP+KyACNIgqSg1Rmw+YCZpEO5ib+sNXgvTHkNZtewT5ykZ8j+Mhp386x2BU1EQQvSsRVOzk8D6on0lrCk73dIHF8ntoOz4qppyw1U3bWC51KRhyknCS6jDfhtjk=
Message-ID: <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
Date: Sun, 13 Aug 2006 13:59:46 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 12/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This is a new version (0.9) of the kernel memory leak detector. See
> the Documentation/kmemleak.txt file for a more detailed
> description. The patches are downloadable from (the whole patch or the
> broken-out series):
>
> http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc4-kmemleak-0.9.bz2
> http://homepage.ntlworld.com/cmarinas/kmemleak/broken-out/patches-kmemleak-0.9.tar.bz2

Can you look at this?

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
events/0/8 is trying to acquire lock:
 (old_style_spin_init){++..}, at: [<c017674f>] memleak_free+0x95/0x157

but task is already holding lock:
 (&parent->list_lock){++..}, at: [<c0174f29>] drain_array+0x49/0xad

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&parent->list_lock){++..}:
       [<c0140cc7>] check_prevs_add+0x4d/0xaf
       [<c01423c1>] __lock_acquire+0x7b1/0x814
       [<c01429bc>] lock_acquire+0x5e/0x7e
       [<c02f9f7a>] _spin_lock+0x23/0x2f
       [<c0174058>] cache_alloc_refill+0x76/0x1d2
       [<c0174559>] kmem_cache_alloc+0x73/0xce
       [<c01f0c8a>] radix_tree_node_alloc+0x1a/0x51
       [<c01f0e3f>] radix_tree_insert+0x51/0xfb
       [<c01761f6>] insert_alias+0x85/0xe8
       [<c01762a4>] memleak_insert_aliases+0x4b/0xa6
       [<c01773f7>] memleak_init+0x44/0xf5
       [<c0100ab0>] start_kernel+0x17e/0x1f9
       [<c0100210>] 0xc0100210
-> #0 (old_style_spin_init){++..}:
       [<c0140cc7>] check_prevs_add+0x4d/0xaf
       [<c01423c1>] __lock_acquire+0x7b1/0x814
       [<c01429bc>] lock_acquire+0x5e/0x7e
       [<c02f9f7a>] _spin_lock+0x23/0x2f
       [<c017674f>] memleak_free+0x95/0x157
       [<c0174a74>] kmem_cache_free+0x62/0xbc
       [<c0172fc8>] slab_destroy+0x48/0x4d
       [<c01743b8>] free_block+0xc9/0x101
       [<c0174f65>] drain_array+0x85/0xad
       [<c017500d>] cache_reap+0x80/0xfe
       [<c01394dd>] run_workqueue+0x88/0xc4
       [<c0139617>] worker_thread+0xfe/0x131
       [<c013c6e1>] kthread+0x82/0xaa
       [<c01044c9>] kernel_thread_helper+0x5/0xb

other info that might help us debug this:

2 locks held by events/0/8:
 #0:  (cache_chain_mutex){--..}, at: [<c0174f9d>] cache_reap+0x10/0xfe
 #1:  (&parent->list_lock){++..}, at: [<c0174f29>] drain_array+0x49/0xad
stack backtrace:
 [<c0106e59>] show_trace_log_lvl+0x58/0x14c
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c01405c0>] print_circular_bug_tail+0x59/0x62
 [<c0140af1>] check_prev_add+0x2b/0x1b4
 [<c0140cc7>] check_prevs_add+0x4d/0xaf
 [<c01423c1>] __lock_acquire+0x7b1/0x814
 [<c01429bc>] lock_acquire+0x5e/0x7e
 [<c02f9f7a>] _spin_lock+0x23/0x2f
 [<c017674f>] memleak_free+0x95/0x157
 [<c0174a74>] kmem_cache_free+0x62/0xbc
 [<c0172fc8>] slab_destroy+0x48/0x4d
 [<c01743b8>] free_block+0xc9/0x101
 [<c0174f65>] drain_array+0x85/0xad
 [<c017500d>] cache_reap+0x80/0xfe
 [<c01394dd>] run_workqueue+0x88/0xc4
 [<c0139617>] worker_thread+0xfe/0x131
  [<c013c6e1>] kthread+0x82/0xaa
 [<c01044c9>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c01405c0>] print_circular_bug_tail+0x59/0x62
 [<c0140af1>] check_prev_add+0x2b/0x1b4
 [<c0140cc7>] check_prevs_add+0x4d/0xaf
 [<c01423c1>] __lock_acquire+0x7b1/0x814
 [<c01429bc>] lock_acquire+0x5e/0x7e
 [<c02f9f7a>] _spin_lock+0x23/0x2f
 [<c017674f>] memleak_free+0x95/0x157
 [<c0174a74>] kmem_cache_free+0x62/0xbc
 [<c0172fc8>] slab_destroy+0x48/0x4d
 [<c01743b8>] free_block+0xc9/0x101
 [<c0174f65>] drain_array+0x85/0xad
 [<c017500d>] cache_reap+0x80/0xfe
 [<c01394dd>] run_workqueue+0x88/0xc4
 [<c0139617>] worker_thread+0xfe/0x131
  [<c013c6e1>] kthread+0x82/0xaa
 [<c01044c9>] kernel_thread_helper+0x5/0xb

0xc017674f is in memleak_free (/usr/src/linux-work3/mm/memleak.c:479).
474     /* Remove a pointer and its aliases from the pointer radix tree */
475     static inline void delete_pointer(unsigned long ptr)
476     {
477             struct memleak_pointer *pointer;
478
479             pointer = radix_tree_delete(&pointer_tree, ptr);
480             if (!pointer) {
481                     dump_stack();
482                     printk(KERN_WARNING "kmemleak: freeing unknown
pointer value 0x%08lx\n", ptr);
483                     return;

0xc0174f29 is in drain_array (/usr/src/linux-work3/mm/slab.c:3739).
3734                    return;
3735            if (ac->touched && !force) {
3736                    ac->touched = 0;
3737            } else {
3738                    spin_lock_irq(&l3->list_lock);
3739                    if (ac->avail) {
3740                            tofree = force ? ac->avail :
(ac->limit + 4) / 5;
3741                            if (tofree > ac->avail)
3742                                    tofree = (ac->avail + 1) / 2;
3743                            free_block(cachep, ac->entry, tofree, node);

0xc0174f9d is in cache_reap (/usr/src/linux-work3/mm/slab.c:3770).
3765    {
3766            struct kmem_cache *searchp;
3767            struct kmem_list3 *l3;
3768            int node = numa_node_id();
3769
3770            if (!mutex_trylock(&cache_chain_mutex)) {
3771                    /* Give up. Setup the next iteration. */
3772                    schedule_delayed_work(&__get_cpu_var(reap_work),
3773                                          REAPTIMEOUT_CPUC);
3774                    return;

config file and dmesg http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/

> --
> Catalin

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
