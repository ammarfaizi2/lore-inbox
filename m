Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVAMCy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVAMCy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVAMCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:54:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26498 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261355AbVAMCxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:53:24 -0500
Date: Thu, 13 Jan 2005 02:52:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Jay Lan <jlan@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@muc.de>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <Pine.LNX.4.58.0501121538110.12669@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0501130222330.4577-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Christoph Lameter wrote:
> On Wed, 12 Jan 2005, Hugh Dickins wrote:
> 
> > Well, I studied the patches a bit more, and wrote
> > "That remark looks a bit unfair to me now I've looked closer."
> > Sorry.  But I do still think it remains unsatisfactory."
> 
> Well then thanks for not ccing me on the initial rant but a whole bunch of
> other people instead that you then did not send the following email too.
> Is this standard behavior on linux-mm?

I did cc you.  What whole bunch of other people?  The list of recipients
was the same, except (for obvious reasons) I added Jay the second time
(and having more time, spelt out most names in full).

Perhaps we've a misunderstanding: when I say "and wrote..." above,
I'm not quoting from some mail I sent others not you, I'm referring
to an earlier draft of the mail I'm then sending.

Or perhaps SGI has a spam filter which chose to gobble it up.
I'll try forwarding it to you again.

> > Might I save face by suggesting that it would be a lot clearer and
> > better if 1/1 got split into two?  The first entirely concerned with
> > removing the spin_lock(&mm->page_table_lock) from handle_mm_fault,
> > and dealing with the consequences of that - moving the locking into
> > the allocating blocks, atomic getting of pud and pmd and pte,
> > passing the atomically-gotten orig_pte down to subfunctions
> > (which no longer expect page_table_lock held on entry) etc.
> 
> That wont do any good since the pte's are not always updated in an atomic
> way. One would have to change set_pte to always be atomic.

You did have set_pte always atomic at one point, to the detriment of
(PAE) set_page_range.  You rightly reverted that, but you've reminded
me of what I confessed to forgetting, where you do need set_pte_atomic
in various places, mainly (only?) the fault handlers in mm/memory.c.
And yes, I think you're right, that needs to be in this first patch.

> The reason
> that I added get_pte_atomic was that you told me that this would fix the
> PAE mode. I did not think too much about this but simply added it
> according to your wish and it seemed to run fine.

Please don't leave the thinking to me or anyone else.

> If you have any complaints, complain to yourself.

I'd better omit my response to that.

> > If there's a slight increase in the number of atomic operations
> > in each i386 PAE page fault, well, I think the superiority of
> > x86_64 makes that now an acceptable tradeoff.
> 
> Could we have PAE mode drop back to using the page_table_lock?

That sounds a simple and sensible alternative (to more atomics):
haven't really thought it through, but if the default arch code is
right, and not overhead, then why not use it for the PAE case instead
of cluttering up with cleverness.  Yes, I think that's a good idea:
anyone see why not?

> > Dismiss those suggestions if they'd just waste everyone's time.
> 
> They dont fix the PAE mode issue.
> 
> > Christoph has made some strides in correcting for other architectures
> > e.g. update_mmu_cache within default ptep_cmpxchg's page_table_lock
> > (probably correct but I can't be sure myself), and get_pte_atomic to
> > get even i386 PAE pte correctly without page_table_lock; and reverted
> > the pessimization of set_pte being always atomic on i386 PAE (but now
> > I've forgotten and can't find the case where it needed to be atomic).
> 
> Well this was another suggestion of yours that I followed. Turns out that
> the set_pte must be atomic for this to work!

I didn't say you never needed an atomic set_pte, I said that making
set_pte always atomic (in the PAE case) unnecessarily slowed down
copy_page_range and zap_pte_range.  Probably a misunderstanding.

> Look I am no expert on the
> i386 PAE mode and I rely on other for this to check up on it. And you were
> the expert.

Expert?  I was trying to help, but you seem to resent that.

> > But no sign of get_pmd(atomic) or get_pud(atomic) to get the higher level
> > entries - I thought we'd agreed they were also necessary on some arches?
> 
> I did not hear about that. Maybe you also sent that email to other people
> instead?

No, you were cc'ed on that one too (Sun, 12 Dec to Nick Piggin).
The spam filter again.  Not that I have total recall of every
exchange about these patches either.

Hugh

