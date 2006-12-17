Return-Path: <linux-kernel-owner+w=401wt.eu-S1753186AbWLQXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbWLQXFM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbWLQXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:05:12 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:48683 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbWLQXFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:05:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLSgVIw3L+3RRJMFvHSTZr6Q+zeYS3Q9ppF08s6ds+20hkLwcvl5bKANhSRG2ljaziE7+QuQ4oq3jQGBQbME9fxd0GElEfPoszIbJq+F9p5eHIssNK1PfFqpxp0Aqcm+BnmLpS4BrRyVj1l9zUCmBYX7nOnLL9YJ3FQH6/PVUco=
Message-ID: <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
Date: Sun, 17 Dec 2006 23:05:08 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061217085859.GB2938@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > Do you need these fixes to avoid a compiler error? If yes, this is
> > caused by a bug in gcc-4.x. The kmemleak container_of macro has
> > protection for non-constant offsets passed to container_of but the
> > faulty gcc always returns true for builtin_contant_p, even when this
> > is not the case. Previous versions (3.4) or one of the latest 4.x gcc
> > don't have this bug.
>
> correct, i needed it for gcc 4.0.2. If you want this feature upstream,
> this has to be solved - no way are we going to phase out portions of
> gcc4. It's not hard as you can see it from my patch, non-static
> container_of is very rare. We do alot of other hackery to keep older
> compilers alive, and we only drop compiler support if some important
> feature really, really needs new gcc and a sane workaround is not
> possible.

There might be a simpler solution (haven't tried it), just before your
compilation error line:

#undef container_of
#define container_of(...) __container_of(...)

I could add some meaningful macros that eliminate the use of the
non-constant offset to make this more obvious.

> > In the -rt kernel, is there any protection against a re-entrant
> > __cache_free (via cache_flusharray -> free_block -> slab_destroy) or
> > this is not needed?
>
> the problem on -rt is the per-CPU slab buffer handling. In vanilla they
> are handled with irqs off/on - but inside is an unbound algorithm so for
> -rt i converted the local_irq_disable() logic to per-CPU locks. So this
> is an -rt only problem.
>
> hm, even on vanilla you might run into problems in slab_destroy(), there
> we hold the l3 lock.

It seems that slab_destroy doesn't take the l3 lock again if it is
already held, otherwise it would fail without kmemleak. However, I
can't guarantee that even a minor change wouldn't break kmemleak.

> > There are also the memleak_object structures that need to be
> > allocated/freed. To avoid any locking dependencies, I ended up
> > delaying the memleak_object structures freeing in an RCU manner. It
> > might work if I do the same with the hash nodes.
>
> yeah, delayed RCU freeing might work better.

I could also use a simple allocator based on alloc_pages since
kmemleak doesn't track pages. It could be so simple that it would
never need to free any pages, just grow the size as required and reuse
the freed memleak objects from a list.

This would simplify the recursiveness and also work on any other slab
allocator (looking back at the amount of time I spend to sort out the
recursiveness and locking dependencies, I could've implemented a full
allocator).

I'll try to implement your other suggestions as well. Thanks.

-- 
Catalin
