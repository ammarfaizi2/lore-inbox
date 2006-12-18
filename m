Return-Path: <linux-kernel-owner+w=401wt.eu-S1753651AbWLRLX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbWLRLX5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbWLRLX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:23:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33732 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651AbWLRLX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:23:56 -0500
Date: Mon, 18 Dec 2006 12:21:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061218112120.GA7599@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com> <20061218072932.GA5624@elte.hu> <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com>
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

> >> [...] It could be so simple that it would never need to free any
> >> pages, just grow the size as required and reuse the freed memleak
> >> objects from a list.
> >
> >sounds good to me. Please make it a per-CPU pool.
> 
> Isn't there a risk for the pools to become imbalanced? A lot of 
> allocations would initially happen on the first CPU.

hm, what's the problem with imbalance? These are trees and imbalance 
isnt a big issue.

> >[...] (Add a memleak_object->cpu pointer so that freeing can be done 
> >on any other CPU as well.)
> 
> We could add the freed objects to the CPU pool where they were freed 
> and not use a memleak_object->cpu pointer.

i mean totally per-CPU locking and per-CPU radix trees, etc.

> > We'll have to fix the locking too, to be per-CPU - memleak_lock is 
> > quite a scalability problem right now.
> 
> The memleak_lock is indeed too coarse (but it was easier to track the 
> locking dependencies). With a new allocator, however, I could do a 
> finer grain locking. It probably still needs a (rw)lock for the hash 
> table. Having per-CPU hash tables is inefficient as we would have to 
> look up all the tables at every freeing or scanning for the 
> corresponding memleak_object.

at freeing we only have to look up the tree belonging to object->cpu. 
Scanning overhead does not matter in comparison to runtime tracking 
overhead. (but i doubt it would be much different - scanning overhead 
scales with size of tree)

> There is a global object_list as well covered by memleak_lock (only 
> for insertions/deletions as traversing is RCU). [...]

yeah, that would have to become per-CPU too.

> [...] List insertion/deletion is very small compared to the hash-table 
> look-up and it wouldn't introduce a scalability problem.

it's a common misconception to think that 'small' critical sections are 
fine. That's not the issue. The pure fact of having globally modified 
resource is the problem, the lock cacheline would ping-pong, etc.

	Ingo
