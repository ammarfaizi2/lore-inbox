Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbTIPBDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbTIPBDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:03:17 -0400
Received: from dp.samba.org ([66.70.73.150]:16828 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261721AbTIPBDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:03:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Hu, Boris" <boris.hu@intel.com>
Cc: "Jamie Lokier" <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] Split futex global spinlock futex_lock 
In-reply-to: Your message of "Thu, 11 Sep 2003 15:02:17 +0800."
             <37FBBA5F3A361C41AB7CE44558C3448E01C0B8DE@pdsmsx403.ccr.corp.intel.com> 
Date: Tue, 16 Sep 2003 01:07:02 +1000
Message-Id: <20030916010313.69E1F2C974@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <37FBBA5F3A361C41AB7CE44558C3448E01C0B8DE@pdsmsx403.ccr.corp.intel.com> you write:
> +/*
> + * Split the global futex_lock into every hash list lock.
> + */
> +struct futex_hash_bucket {
> +       spinlock_t              lock;
> +       struct list_head       chain;
> +};
> +
>  /* The key for the hash is the address + index + offset within page */
> -static struct list_head futex_queues[1<<FUTEX_HASHBITS];
> -static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
> +static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] \
> +	__cacheline_aligned_in_smp;

This doesn't do what you expect, unfortunately.  You need:

struct futex_hash_bucket {
       spinlock_t              lock;
       struct list_head       chain;
} ____cacheline_aligned_in_smp;

static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS]
	__cacheline_aligned_in_smp;

Also, Jamie was hinting at a sectored approach: optimal memory
footprint/speed balance might be one lock in one cache-line-worth of
list_head.  But the above will do unless someone gets extremely
excited.

Uli, can we ask you for benchmarks with this change, too?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
