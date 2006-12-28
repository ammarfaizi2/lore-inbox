Return-Path: <linux-kernel-owner+w=401wt.eu-S932856AbWL1Jq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWL1Jq6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWL1Jq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:46:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53586 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932848AbWL1Jq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:46:57 -0500
Date: Thu, 28 Dec 2006 10:44:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061228094431.GE24765@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com> <20061218072932.GA5624@elte.hu> <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com> <20061227150815.GA27828@elte.hu> <20061227173013.GA17560@elte.hu> <b0943d9e0612271615r42c7f6abt38f36bbd9c94319f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612271615r42c7f6abt38f36bbd9c94319f@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> >memleak info is at a negative offset from the allocated pointer. I.e.
> >that if kmalloc() returns 'ptr', the memleak info could be at
> >ptr-sizeof(memleak_info). That way you dont have to know the size of the
> >object beforehand and there's absolutely no need for a global hash of
> >any sort.
> 
> It would probably need to be just a pointer embedded in the allocated 
> block. With the current design, the memleak objects have a lifetime 
> longer than the tracked block. This is mainly to avoid long locking 
> during memory scanning and reporting.

this thing has to be /fast/ in the common path. I dont really see the 
point in spreading out allocations like that for small objects. Access 
to the object has to be refcounted /anyway/ due to scanning. Just move 
that refcounting to the object freeing stage. Keep freed-but-used 
buffers in some sort of per-CPU list that the scanning code flushes 
after it's done. (Also maybe hold the cache_chain_mutex to prevent slab 
caches from being destroyed during scanning.)

> > (it gets a bit more complex for page aligned allocations for the 
> > buddy and for vmalloc - but that could be solved by adding one extra 
> > pointer into struct page. [...]
> 
> This still leaves the issue of marking objects as not being leaks or 
> being of a different type. This is done by calling memleak_* functions 
> at the allocation point (outside allocator) where only the pointer is 
> known. [...]

i dont see the problem. By having the pointer we have access to the 
memleak descriptor too.

> [...] In the vmalloc case, it would need to call find_vm_area. This 
> might not be a big problem, only that memory resources are no longer 
> treated in a unified way by kmemleak (and might not be trivial to add 
> support for new allocators).

the pretty horrible locking dependencies in the current one are just as 
bad. (which could be softened by a simplified allocator - but that 
brings in other problems, which problems can only be solved via 
allocator complexity ...)

If 'unification' means global locking and bad overhead and leak 
descriptor maintainance complexity then yes, we very much dont want to 
treat them in a unified way. Unless there's some killer counter-argument 
against embedding the memleak descriptor in the object that we allocate 
it is pretty much a must.

btw., you made the argument before that what matters most is the SLAB 
allocator. (when i argued that we might want to extend this to other 
allocators as well) You cant have it both ways :)

> > [...] That is a far more preferable cost than the locking/cache 
> > overhead of a global hash.)
> 
> A global hash would need to be re-built for every scan (and destroyed 
> afterwards), making this operation longer since the pointer values 
> together with their aliases (resulted from using container_of) are 
> added to the hash.

by 'global hash' i mean the current code.

> I understand the benefits but I personally favor simplicity over 
> performance, [...]

i think you are trying to clinge to a bad design detail. You spent time 
on it, and that time was still worthwile, believe me. I often change 
design details dozens of times before a patch hits lkml. It doesnt 
matter, really - it's the path you walk that matters. This thing /has/ 
to be fast/scalable to be used in distributions.

> [...] Global structures are indeed a scalability problem but for a 
> reasonable number of CPUs their overhead might not be that big.

lets forget you ever said this, ok? ;-)

	Ingo
