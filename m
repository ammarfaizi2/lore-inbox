Return-Path: <linux-kernel-owner+w=401wt.eu-S1754660AbWL0Rdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbWL0Rdn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbWL0Rdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:33:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58034 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964777AbWL0Rdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:33:42 -0500
Date: Wed, 27 Dec 2006 18:30:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061227173013.GA17560@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com> <20061218072932.GA5624@elte.hu> <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com> <20061227150815.GA27828@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227150815.GA27828@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > As I mentioned in a different e-mail, a way to remove the global 
> > hash table is to create per-cpu hashes. The only problem is that in 
> > these 8-10% of the cases, freeing would need to look up the other 
> > hashes. This would become a problem with a high number of CPUs but 
> > I'm not sure whether it would overtake the performance issues 
> > introduced by cacheline ping-ponging in the single-hash case.
> 
> i dont think it's worth doing that. So we should either do the current 
> global lock & hash (bad for scalability), or a pure per-CPU design. 
> The pure per-CPU design would have to embedd the CPU ID the object is 
> attached to into the allocated object. If that is not feasible then 
> only the global hash remains i think.

embedding the info shouldnt be /that/ hard in case of the SLAB: if the 
memleak info is at a negative offset from the allocated pointer. I.e. 
that if kmalloc() returns 'ptr', the memleak info could be at 
ptr-sizeof(memleak_info). That way you dont have to know the size of the 
object beforehand and there's absolutely no need for a global hash of 
any sort.

(it gets a bit more complex for page aligned allocations for the buddy 
and for vmalloc - but that could be solved by adding one extra pointer 
into struct page. That is a far more preferable cost than the 
locking/cache overhead of a global hash.)

	Ingo
