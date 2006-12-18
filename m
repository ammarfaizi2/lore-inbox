Return-Path: <linux-kernel-owner+w=401wt.eu-S1753446AbWLRHbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbWLRHbi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbWLRHbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:31:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56565 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbWLRHbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:31:37 -0500
Date: Mon, 18 Dec 2006 08:29:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061218072932.GA5624@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> > hm, even on vanilla you might run into problems in slab_destroy(), 
> > there we hold the l3 lock.
> 
> It seems that slab_destroy doesn't take the l3 lock again if it is 
> already held, otherwise it would fail without kmemleak. However, I 
> can't guarantee that even a minor change wouldn't break kmemleak.

slab_destroy() is careful to not take the /same/ lock. But kmemleak does 
an unconditional kfree() and i dont see what saves us from a rare but 
possible deadlock here.

> > yeah, delayed RCU freeing might work better.
> 
> I could also use a simple allocator based on alloc_pages since 
> kmemleak doesn't track pages. [...]

actually, i'm quite sure we want to track pages later on too, any reason 
why kmemleak shouldnt cover them?

But i agree that using a separate allocator would be the right choice 
here. Once the page allocator will be added to the tracking mechanism we 
can exclude those allocations by doing wrappers. I.e. you shouldnt just 
add the memleak_*() functions to the page allocator directly - wrap the 
existing calls cleanly, and thus preserve a non-tracked API variant. For 
the SLAB this is hard because the SLAB has so many internal dependencies 
- but the buddy is a 'core' allocator.

and those non-wrapped APIs would also be useful for the SLAB to call 
into - that way we could exclude the tracking of SLAB allocations. 
(unless someone wants to track/debug the SLAB implementation itself.)

> [...] It could be so simple that it would never need to free any 
> pages, just grow the size as required and reuse the freed memleak 
> objects from a list.

sounds good to me. Please make it a per-CPU pool. We'll have to fix the 
locking too, to be per-CPU - memleak_lock is quite a scalability problem 
right now. (Add a memleak_object->cpu pointer so that freeing can be 
done on any other CPU as well.)

> This would simplify the recursiveness and also work on any other slab 
> allocator (looking back at the amount of time I spend to sort out the 
> recursiveness and locking dependencies, I could've implemented a full 
> allocator).

yes.

	Ingo
