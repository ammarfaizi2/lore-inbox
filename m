Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDCSql (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 13:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUDCSql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 13:46:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57534
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261867AbUDCSqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 13:46:38 -0500
Date: Sat, 3 Apr 2004 20:46:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging [Re:    2.6.5-rc2-aa vma merging]
Message-ID: <20040403184639.GN2307@dualathlon.random>
References: <20040403012612.GY21341@dualathlon.random> <Pine.LNX.4.44.0404031727320.10197-100000@localhost.localdomain> <20040403172426.GJ2307@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403172426.GJ2307@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 07:24:26PM +0200, Andrea Arcangeli wrote:
> exactly. the cost of the anonvmas is absolutely non measurable, so while
> it makes sense to share the sane anon_vma for adiancent mappings that
> differs only for the page protection flags, I don't want to share
> anything else to boost the reverse lookup performance. I want it as
> finegrined as possible, not just to have few vmas, but also to track
> _only_ the interesting MM in the group, something anonmm will never be
> able to do, except when the page has mapcount == 1. Sharing the same
> anon_vma for everything would just slowdown the lookup, in practice
> there would be no more merging at all. I believe being as finegrined as
> possible will payoff, maybe one day we may even be ok to pay for some
> more byte in the vma for a prio_tree on top of the anon_vma, to speedup
> the lookup as much as possible (today it would only waste ram IMO). Plus
> I love being able to handle mremap trasparently by-design. The ugliness
> of doing a swapin + copy and calling handle_mm_fault in mremap is pretty
> bad IMO. some more byte per-vma is not a problem and it'll never be
> noticeable, just like not merging non adiacent mappings will never be
> noticeable. So I believe the few bytes per vma are worth it, plus now it
> does filebacked mprotect merging too.

another relevant advantage of anon-vma compared to anonmm, is the smp
locking scalability and simplicity. With anonmm you're either forced to
keep the mm-wide page_table_lock during vma merging and in general
during all vma modifications (so you can lookup the rbtree from
try_to_unmap by trylocking on the page_table_lock). While with anon-vma
the page_table_lock goes away completely from the vma merging and all
vma manipulations. page_table_lock remains but only for accessing the
pagetables.

btw, it's good I was thinking now at the locking since I noticed I
missed an anon_vma_lock here:

 	/*
 	 * Otherwise extend it.
 	 */
-	spin_lock(&mm->page_table_lock);
-	prev->vm_end = end;
-	vma->vm_start = end;
-	spin_unlock(&mm->page_table_lock);
+	if (file)
+		down(i_shared_sem);
+	__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
+	__vma_modify(root, vma, end, vma->vm_end,
+		     vma->vm_pgoff + ((end - vma->vm_start) >>
PAGE_SHIFT));
+	if (file)
+		up(i_shared_sem);


it's really needed only for the "start" moves, the "end" moves can go
lockless, but adding an anon_vma_lock/unlock(vma) after the if (file)
down is simpler. The other modifications don't need it because they're
all extensions at the end (not at the start), so the smp race is controlled.

I'll recheck and fix it in next -aa tomorrow (it's unlikely anybody can
trigger it in the meantime ;)

About the ppc page->mapping stuff I don't think the ppc fixes in
anobjrmap are really going to fix anything, though that tlb.c code is
very confusing to me, not sure how can it work without it, but OTOH then
even mainline shouldn't work if that's needed. ppc help?
