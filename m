Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbULJVpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbULJVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULJVpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:45:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9047 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261816AbULJVoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:44:46 -0500
Date: Fri, 10 Dec 2004 21:43:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <Pine.LNX.4.58.0412101006200.8714@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0412102125210.32422-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Christoph Lameter wrote:
> On Thu, 9 Dec 2004, Hugh Dickins wrote:
> 
> > Your V12 patches would apply well to 2.6.10-rc3, except that (as noted
> > before) your mailer or whatever is eating trailing whitespace: trivial
> > patch attached to apply before yours, removing that whitespace so yours
> > apply.  But what your patches need to apply to would be 2.6.10-mm.
> 
> I am still mystified as to why this is an issue at all. The patches apply
> just fine to the kernel sources as is. I have patched kernels numerous
> times with this patchset and never ran into any issue. quilt removes trailing
> whitespace from patches when they are generated as far as I can tell.

Perhaps you've only tried applying your original patches, not the ones
as received through the mail.  It discourages people from trying them
when "patch -p1" fails with rejects, however trivial.  Or am I alone
in seeing this?  never had such a problem with other patches before.

> > Your scalability figures show a superb improvement.  But they are (I
> > presume) for the best case: intense initial faulting of distinct areas
> > of anonymous memory by parallel cpus running a multithreaded process.
> > This is not a common case: how much do what real-world apps benefit?
> 
> This is common during the startup of distributed applications on our large
> machines. They seem to freeze for minutes on bootup. I am not sure how
> much real-world apps benefit. The numbers show that the benefit would
> mostly be for SMP applications. UP has only very minor improvements.

How much do your patches speed the startup of these applications?
Can you name them?

> I have worked with a couple of arches and received feedback that was
> integrated. I certainly welcome more feedback. A vague idea if there is
> more trouble on that front: One could take the ptl in the cmpxchg
> emulation and then unlock on update_mmu cache.

Or move the update_mmu_cache into the ptep_cmpxchg emulation perhaps.

> > (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> > lru_cache_add_active.  The other instances of lru_cache_add_active for
> > an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> > why here?  But that's nothing new with your patch, and although you've
> > reordered the calls, the final page state is the same as before.)
> 
> The mark_page_accessed is likely there avoid a future fault just to set
> the accessed bit.

No, mark_page_accessed is an operation on the struct page
(and the accessed bit of the pte is preset too anyway).

> > Where handle_pte_fault does "entry = *pte" without page_table_lock:
> > you're quite right to passing down precisely that entry to the fault
> > handlers below, but there's still a problem on the 32bit architectures
> > supporting 64bit ptes (i386, mips, ppc), that the upper and lower ints
> > of entry may be out of synch.  Not a problem for do_anonymous_page, or
> > anything else relying on ptep_cmpxchg to check; but a problem for
> > do_wp_page (which could find !pfn_valid and kill the process) and
> > probably others (harder to think through).  Your 4/7 patch for i386 has
> > an unused atomic get_64bit function from Nick, I think you'll have to
> > define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.
> 
> That would be a performance issue.

Sadly, yes, but correctness must take precedence over performance.
It may be possible to avoid it in most cases, doing the atomic
later when in doubt: but would need careful thought.

> Good suggestions. Will see what I can do but I will need some assistence
> my main platform is ia64 and the hardware and opportunities for testing on
> i386 are limited.

There's plenty of us can be trying i386.  It's other arches worrying me.

Hugh

