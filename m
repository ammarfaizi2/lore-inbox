Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVAMAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVAMAGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVALXzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:55:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5577 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261597AbVALXxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:53:15 -0500
Date: Wed, 12 Jan 2005 15:52:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Jay Lan <jlan@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <Pine.LNX.4.44.0501122017320.3070-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501121538110.12669@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501122017320.3070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Hugh Dickins wrote:

> Well, I studied the patches a bit more, and wrote
> "That remark looks a bit unfair to me now I've looked closer."
> Sorry.  But I do still think it remains unsatisfactory."

Well then thanks for not ccing me on the initial rant but a whole bunch of
other people instead that you then did not send the following email too.
Is this standard behavior on linux-mm?

> Might I save face by suggesting that it would be a lot clearer and
> better if 1/1 got split into two?  The first entirely concerned with
> removing the spin_lock(&mm->page_table_lock) from handle_mm_fault,
> and dealing with the consequences of that - moving the locking into
> the allocating blocks, atomic getting of pud and pmd and pte,
> passing the atomically-gotten orig_pte down to subfunctions
> (which no longer expect page_table_lock held on entry) etc.

That wont do any good since the pte's are not always updated in an atomic
way. One would have to change set_pte to always be atomic. The reason
that I added get_pte_atomic was that you told me that this would fix the
PAE mode. I did not think too much about this but simply added it
according to your wish and it seemed to run fine. If you have any
complaints, complain to yourself.

> If there's a slight increase in the number of atomic operations
> in each i386 PAE page fault, well, I think the superiority of
> x86_64 makes that now an acceptable tradeoff.

Could we have PAE mode drop back to using the page_table_lock?

> Dismiss those suggestions if they'd just waste everyone's time.

They dont fix the PAE mode issue.

> Christoph has made some strides in correcting for other architectures
> e.g. update_mmu_cache within default ptep_cmpxchg's page_table_lock
> (probably correct but I can't be sure myself), and get_pte_atomic to
> get even i386 PAE pte correctly without page_table_lock; and reverted
> the pessimization of set_pte being always atomic on i386 PAE (but now
> I've forgotten and can't find the case where it needed to be atomic).

Well this was another suggestion of yours that I followed. Turns out that
the set_pte must be atomic for this to work! Look I am no expert on the
i386 PAE mode and I rely on other for this to check up on it. And you were
the expert.

> But no sign of get_pmd(atomic) or get_pud(atomic) to get the higher level
> entries - I thought we'd agreed they were also necessary on some arches?

I did not hear about that. Maybe you also sent that email to other people
instead?

> In its present state it is absurd: partly because Christoph seems to
> have forgotten the point of it, so after all the per-thread infrastructure,
> has ended up with do_anonymous_page saying mm->rss++, mm->anon_rss++.

Sorry that seems to have dropped out of the patch somehow. Here is the
fix:

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-11 09:16:34.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-12 15:49:45.000000000 -0800
@@ -1835,8 +1835,8 @@ do_anonymous_page(struct mm_struct *mm,
 		 */
 		page_add_anon_rmap(page, vma, addr);
 		lru_cache_add_active(page);
-		mm->rss++;
-		mm->anon_rss++;
+		current->rss++;
+		current->anon_rss++;
 		acct_update_integrals();
 		update_mem_hiwater();



> And partly because others at SGI have been working in the opposite
> direction, adding mysterious and tasteless acct_update_integrals
> and update_mem_hiwater calls.  I say mysterious because there's

Yea. I posted a patch to move that stuff out of the vm. No
good deed gets unpunished.

