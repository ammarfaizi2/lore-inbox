Return-Path: <linux-kernel-owner+w=401wt.eu-S932959AbWL0PKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbWL0PKi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWL0PKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:10:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35578 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960AbWL0PKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:10:37 -0500
Date: Wed, 27 Dec 2006 16:08:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061227150815.GA27828@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com> <20061218072932.GA5624@elte.hu> <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com>
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

> On 18/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> >* Catalin Marinas <catalin.marinas@gmail.com> wrote:
> >> I could also use a simple allocator based on alloc_pages [...]
> >> [...] It could be so simple that it would never need to free any
> >> pages, just grow the size as required and reuse the freed memleak
> >> objects from a list.
> >
> >sounds good to me. Please make it a per-CPU pool. We'll have to fix the
> >locking too, to be per-CPU - memleak_lock is quite a scalability problem
> >right now. (Add a memleak_object->cpu pointer so that freeing can be
> >done on any other CPU as well.)
> 
> I did some simple statistics about allocations happening on one CPU 
> and freeing on a different one. On a 4-CPU ARM system (and without IRQ 
> balancing and without CONFIG_PREEMPT), these seem to happen in about 
> 8-10% of the cases. Do you expect higher figures on other 
> systems/configurations?
> 
> As I mentioned in a different e-mail, a way to remove the global hash 
> table is to create per-cpu hashes. The only problem is that in these 
> 8-10% of the cases, freeing would need to look up the other hashes. 
> This would become a problem with a high number of CPUs but I'm not 
> sure whether it would overtake the performance issues introduced by 
> cacheline ping-ponging in the single-hash case.

i dont think it's worth doing that. So we should either do the current 
global lock & hash (bad for scalability), or a pure per-CPU design. The 
pure per-CPU design would have to embedd the CPU ID the object is 
attached to into the allocated object. If that is not feasible then only 
the global hash remains i think.

	Ingo
