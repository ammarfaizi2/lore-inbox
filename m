Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVALV3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVALV3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:25:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19376 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261460AbVALVW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:22:58 -0500
Date: Wed, 12 Jan 2005 21:22:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Jay Lan <jlan@engr.sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       <linux-mm@kvack.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <Pine.LNX.4.44.0501121217580.6133-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0501122017320.3070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Hugh Dickins wrote:
> On Wed, 12 Jan 2005, Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > Christoph Lameter wrote:
> > >  > Changes from V14->V15 of this patch:
> > >  I wonder what everyone thinks about moving forward with these patches?
> > I was waiting for them to settle down before paying more attention.
> They seem to have settled down, without advancing to anything satisfactory.

Well, I studied the patches a bit more, and wrote
"That remark looks a bit unfair to me now I've looked closer."
Sorry.  But I do still think it remains unsatisfactory."

Then I studied it a bit more, and I think my hostility melted away
once I thought about the other-arch-defaults: I'd been supposing that
taking and dropping the page_table_lock within each primitive was
adding up to an unhealthy flurry of takes and drops on the non-target
architectures.  But that doesn't look like the case to me now (except
in those rarer paths where a page table has to be allocated: of course,
not a problem).

I owe Christoph an apology.  It's not quite satisfactory yet,
but it does look a lot better than an ia64 hack for one special case.

Might I save face by suggesting that it would be a lot clearer and
better if 1/1 got split into two?  The first entirely concerned with
removing the spin_lock(&mm->page_table_lock) from handle_mm_fault,
and dealing with the consequences of that - moving the locking into
the allocating blocks, atomic getting of pud and pmd and pte,
passing the atomically-gotten orig_pte down to subfunctions
(which no longer expect page_table_lock held on entry) etc.

If there's a slight increase in the number of atomic operations
in each i386 PAE page fault, well, I think the superiority of
x86_64 makes that now an acceptable tradeoff.

That would be quite a decent patch, wouldn't it? that could go into
-mm for a few days and be measured, before any more.  Then one using
something called ptep_cmpxchg to encapsulate the page_table_lock'ed
checking of pte_same and set_pte in do_anonymous page.  Then ones to
implement ptep_cmpxchg per selected arches without page_table_lock.

Dismiss those suggestions if they'd just waste everyone's time.

Christoph has made some strides in correcting for other architectures
e.g. update_mmu_cache within default ptep_cmpxchg's page_table_lock
(probably correct but I can't be sure myself), and get_pte_atomic to
get even i386 PAE pte correctly without page_table_lock; and reverted
the pessimization of set_pte being always atomic on i386 PAE (but now
I've forgotten and can't find the case where it needed to be atomic).

Unless it's just been fixed in this latest version, the well-intentioned
get_pte_atomic doesn't actually work on i386 PAE: once you get swapping,
the swap entries look like pte_nones and all collapses.  Presumably just
#define get_pte_atomic(__ptep) __pte(get_64bit((unsigned long long *)(__ptep)))
doesn't quite do what it's trying to do, and needs a slight adjustment.

But no sign of get_pmd(atomic) or get_pud(atomic) to get the higher level
entries - I thought we'd agreed they were also necessary on some arches?

> 7/7 is particularly amusing at the moment (added complexity with no payoff).

I still dislike 7/7, despite seeing the sense of keeping stats in the
task struct.  It's at the very end anyway, and I'd be glad for it to
be delayed (in the hope that time somehow magically makes it nicer).

In its present state it is absurd: partly because Christoph seems to
have forgotten the point of it, so after all the per-thread infrastructure,
has ended up with do_anonymous_page saying mm->rss++, mm->anon_rss++.

And partly because others at SGI have been working in the opposite
direction, adding mysterious and tasteless acct_update_integrals
and update_mem_hiwater calls.  I say mysterious because there's
nothing in the tree which actually uses the accumulated statistics,
or shows how they might be used (when many threads share the mm),
- so Adrian/Arjan/HCH might remove them any day.  But looking at
December mails suggests there's lse-tech agreement that all kinds
of addons would find them useful.  I say tasteless because they
don't even take "mm" arguments (what happens when ptrace or AIO
daemon faults something? perhaps it's okay but there's no use of
the stats to judge by), and the places where you'd want to update
hiwater_rss are almost entirely disjoint from the places where
you'd want to update hiwater_vm (expand_stack the exception).

If those new stats stay, and the per-task-rss idea stays,
then I suppose those new stats need to be split per task too.

> I'll write at greater length to support these accusations later on.

I rather failed to do so!  And perhaps tomorrow I'll have to be
apologizing to Jay for my uncomprehending attack on hiwater etc.

Hugh

