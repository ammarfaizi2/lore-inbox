Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWHNPeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWHNPeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWHNPen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:34:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:63419 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751014AbWHNPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:34:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S3NBFy+PzHr62PwUXDGwBwGXqoGI2ygivR5AsNdgZAHsDdLfniEsf4OPz3WCsC2ga64Xs+tsDRjeb0+dbV2XKWK1AcJgwY0+oqm+M1xR+idFpeuYtM8+yDCcqHiBxVCZP4MUvH+WuHI4tpxfQzcVCN56L13WE4YZhHBE2e12a+Y=
Message-ID: <b0943d9e0608140834w7c338203lfdaf108c0b89fe39@mail.gmail.com>
Date: Mon, 14 Aug 2006 16:34:41 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Can you look at this?
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> events/0/8 is trying to acquire lock:
>  (old_style_spin_init){++..}, at: [<c017674f>] memleak_free+0x95/0x157
>
> but task is already holding lock:
>  (&parent->list_lock){++..}, at: [<c0174f29>] drain_array+0x49/0xad
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&parent->list_lock){++..}:
>        [<c0140cc7>] check_prevs_add+0x4d/0xaf
>        [<c01423c1>] __lock_acquire+0x7b1/0x814
>        [<c01429bc>] lock_acquire+0x5e/0x7e
>        [<c02f9f7a>] _spin_lock+0x23/0x2f
>        [<c0174058>] cache_alloc_refill+0x76/0x1d2
>        [<c0174559>] kmem_cache_alloc+0x73/0xce
>        [<c01f0c8a>] radix_tree_node_alloc+0x1a/0x51
>        [<c01f0e3f>] radix_tree_insert+0x51/0xfb
>        [<c01761f6>] insert_alias+0x85/0xe8
>        [<c01762a4>] memleak_insert_aliases+0x4b/0xa6
>        [<c01773f7>] memleak_init+0x44/0xf5
>        [<c0100ab0>] start_kernel+0x17e/0x1f9
>        [<c0100210>] 0xc0100210
> -> #0 (old_style_spin_init){++..}:
>        [<c0140cc7>] check_prevs_add+0x4d/0xaf
>        [<c01423c1>] __lock_acquire+0x7b1/0x814
>        [<c01429bc>] lock_acquire+0x5e/0x7e
>        [<c02f9f7a>] _spin_lock+0x23/0x2f
>        [<c017674f>] memleak_free+0x95/0x157
>        [<c0174a74>] kmem_cache_free+0x62/0xbc
>        [<c0172fc8>] slab_destroy+0x48/0x4d
>        [<c01743b8>] free_block+0xc9/0x101
>        [<c0174f65>] drain_array+0x85/0xad
>        [<c017500d>] cache_reap+0x80/0xfe
>        [<c01394dd>] run_workqueue+0x88/0xc4
>        [<c0139617>] worker_thread+0xfe/0x131
>        [<c013c6e1>] kthread+0x82/0xaa
>        [<c01044c9>] kernel_thread_helper+0x5/0xb

I don't think I fully understand the slab locking, maybe some other
kernel guys could help with this, but lockdep is probably right (the
lock could happen on SMP systems).

It looks like lockdep complains that memleak_lock is acquired while
list_lock is held and there is a possibility that (on a different CPU)
memleak_lock was acquired first, followed by list_lock acquiring and
therefore a deadlock.

The kmemleak+slab locking is a bit complicated because memleak itself
needs to allocate memory and avoid recursive calls to it (the
pointer_cache and the radix_tree allocations). The kmemleak-related
allocations are not tracked by kmemleak.

I see the following solutions:

1. acquire the memleak_lock at the beginning of an alloc/free function
and release it when finished while allowing recursive/nested calls
(and only call the memleak_* functions during the outermost lock).
This would mean ignoring the off-slab management allocations as these
would lead to deadlock because of the recursive call into kmemleak.
This locking should be placed around cache_reap() as well (actually,
around all the entry points in the mm/slab.c file).

2. do an independent (simple) memory management in kmemleak and
probably replace radix_tree with prio_tree as the latter doesn't seem
to require allocations.

The first option is simple to implement but it has the disadvantage of
serializing the slab calls on SMP and also not tracking the mm/slab.c
allocations. The second one would provide full coverage of the kernel
slab allocations but it is probably more difficult to implement.

Any thoughts/suggestions on this?

Thanks.

-- 
Catalin
