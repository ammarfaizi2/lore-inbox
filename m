Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbTIPLEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTIPLEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:04:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8084 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261205AbTIPLEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:04:37 -0400
Date: Tue, 16 Sep 2003 12:04:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Hu, Boris" <boris.hu@intel.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] Split futex global spinlock futex_lock
Message-ID: <20030916110419.GB26576@mail.jlokier.co.uk>
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B8DE@pdsmsx403.ccr.corp.intel.com> <20030916010313.69E1F2C974@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916010313.69E1F2C974@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't agree with this change,

Rusty Russell wrote:
> This doesn't do what you expect, unfortunately.  You need:
> 
> struct futex_hash_bucket {
>        spinlock_t              lock;
>        struct list_head       chain;
> } ____cacheline_aligned_in_smp;
> 
> static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS]
> 	__cacheline_aligned_in_smp;

> Also, Jamie was hinting at a sectored approach: optimal memory
> footprint/speed balance might be one lock in one cache-line-worth of
> list_head.

That was before I thought a bit more :)

If you're increasing the size of futex_hash_bucket, you can put
multiple lists in each one (as you observed).  That reduces the
average list length, making hash operations faster when the table is
quite full.

There isn't any speed penalty for having a lock per list_head when you
do that, because the cache line has to bounce anyway for the
list_head, and locks are small.  (On HT, where cache lines are shared
between sibling CPUs, a lock per list is a slight improvement).

Therefore, if cache line transfer between CPUs is a bottleneck, it
makes more sense to increase FUTEX_HASHBITS than to increase the
alignment of each bucket.

Increasing the alignment from 12 bytes to 16 bytes, to prevent buckets
straddling 2 cache lines, makes sense though.  (Alternatively using a
single-linked list would do the trick, and be kinder on UP).

> Uli, can we ask you for benchmarks with this change, too?

Theoretically, I'd expect slightly better performance from increasing
FUTEX_HASHBITS than from this change, if there is any improvement at all.

Note that we're still bouncing mmap_sem on every futex operation, so
if the 6% improvement from splitting locks is anything to go by,
splitting mmap_sem should make a further measureable improvement,
although it might slow down the rest of the kernel.

-- Jamie
