Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTIJLHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbTIJLHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:07:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53392 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262041AbTIJLHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:07:48 -0400
Date: Wed, 10 Sep 2003 12:07:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Hu, Boris" <boris.hu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split futex global spinlock futex_lock
Message-ID: <20030910110744.GD21313@mail.jlokier.co.uk>
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hu, Boris wrote:
> Split futex global spinlock futex_lock into hash bucket spinlocks.

> +/*
> + * Split the global futex_lock into every hash list lock.
> + */
> +struct futex_hash_bucket {
> +       struct list_head        chain;
> +       spinlock_t              lock;
> +};

Put "lock" first: it is always the first field accessed.  That will
save a few clock cycles on some systems.

I was going to suggest something about cache alignment, but of course
that doesn't make sense.  If the structure is made any larger,
it might as well contain more hash buckets.

Thinking a little deeper, it occurs to me that for scalable SMP
performance, you want:

  (1 << FUTEX_HASHBITS) > some factor * SMP_CACHE_BYTES * NR_CPUS / sizeof (bucket)

To put it into perspective, consider a hypothetical 16-way P4.
SMP_CACHE_BYTES is 128 on a P4.  That's 24 cache lines in the whole hash table.

If there are only a few futexes in the table at any time, the dominant
time for each operation is going to be the spinlock and associated
cache line transfers, not traversing a bucket's list.

So that hypothetical box would have an effective hash table of only 24 buckets.

What I'm saying is:

	If you're able to benchmark changes to the code on a big box,
	and you want to tune it's performance, try changing
	FUTEX_HASHBITS.  Also try adding a dummy word into
	futex_hash_bucket, and use __cache_aligned_in_smp on the array so that
	no buckets straddle two cache lines.

Thought for the day...
-- Jamie
