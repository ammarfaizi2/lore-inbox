Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWHLUCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWHLUCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHLUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:02:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932591AbWHLUCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:02:46 -0400
Date: Sat, 12 Aug 2006 13:02:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Kobras <kobras@linux.de>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Fix deadlock under high i/o load in raid1 setup.
Message-Id: <20060812130228.f7954b5f.akpm@osdl.org>
In-Reply-To: <20060809164421.GC9984@antares.tat.physik.uni-tuebingen.de>
References: <20060809164421.GC9984@antares.tat.physik.uni-tuebingen.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 18:44:21 +0200
Daniel Kobras <kobras@linux.de> wrote:

> Implement private fallback if immediate allocation from mempool fails.
> Standard mempool_alloc() fallback can yield a deadlock when only the
> calling process is able to refill the pool. In out-of-memory situations,
> instead of waiting for itself, kmirrord now waits for someone else to
> free some space, using a standard blocking allocation.
> 
> Signed-off-by: Daniel Kobras <kobras@linux.de>
> ---
> [Resending with Cc to l-k. First attempt apparently hasn't made it through to 
> dm-devel.]
> 
> Hi!
> 
> On an nForce4-equipped machine with two SATA disk in raid1 setup using
> dmraid, we experienced frequent deadlock of the system under high i/o
> load. 'cat /dev/zero > ~/zero' was the most reliable way to reproduce
> them: Randomly after a few GB, 'cp' would be left in 'D' state along
> with kjournald and kmirrord. The functions cp and kjournald were blocked
> in did vary, but kmirrord's wchan always pointed to 'mempool_alloc()'.
> We've seen this pattern on 2.6.15 and 2.6.17 kernels.
> http://lkml.org/lkml/2005/4/20/142 indicates that this problem has been
> around even before.
> 
> So much for the facts, here's my interpretation: mempool_alloc() first
> tries to atomically allocate the requested memory, or falls back to hand
> out preallocated chunks from the mempool. If both fail, it puts the
> calling process (kmirrord in this case) on a private waitqueue until
> somebody refills the pool. Where the only 'somebody' is kmirrord itself,
> so we have a deadlock.

Right.  That's a design error in DM.  mempools are only supposed to be used
in situations where we *know* that if we wait for a bit, some elements will
be returned to the pool.  Obviously, if the only thread in the machine
which can release elements is the one which is waiting for thse elements,
we die.

> I worked around this problem by falling back to a (blocking) kmalloc
> when before kmirrord would have ended up on the waitqueue. This defeats
> part of the benefits of using the mempool, but at least keeps the system
> running. And it could be done with a two-line change. Note that
> mempool_alloc() clears the GFP_NOIO flag internally, and only uses it to
> decide whether to wait or return an error if immediate allocation fails,
> so the attached patch doesn't change behaviour in the non-deadlocking case.
> Path is against current git (2.6.18-rc4), but should apply to earlier
> versions as well. I've tested on 2.6.15, where this patch makes the
> difference between random lockup and a stable system.
> 
> Regards,
> 
> Daniel.
> 
> diff -r dcc321d1340a -r d52bb3a14d60 drivers/md/dm-raid1.c
> --- a/drivers/md/dm-raid1.c	Sun Aug 06 19:00:05 2006 +0000
> +++ b/drivers/md/dm-raid1.c	Mon Aug 07 23:16:44 2006 +0200
> @@ -255,7 +255,9 @@ static struct region *__rh_alloc(struct 
>  	struct region *reg, *nreg;
>  
>  	read_unlock(&rh->hash_lock);
> -	nreg = mempool_alloc(rh->region_pool, GFP_NOIO);
> +	nreg = mempool_alloc(rh->region_pool, GFP_ATOMIC);
> +	if (unlikely(!nreg))
> +		nreg = kmalloc(sizeof(struct region), GFP_NOIO);
>  	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
>  		RH_CLEAN : RH_NOSYNC;
>  	nreg->rh = rh;

Yes, that'll fix it.  It's rather nasty to be allocating elements with
kmalloc and then sending them back with mempool_free().  But it'll work.

Alasdair, I'd say that this is a 2.6.18 fix and a 2.6.17.x backport.

A longer-term fix might be to stop using mempools in there, just use
kmalloc.  Or move the mempool_free()ing out of kmorrord context and into
IO-completion context, perhaps.


