Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280842AbRKBVQW>; Fri, 2 Nov 2001 16:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280839AbRKBVQN>; Fri, 2 Nov 2001 16:16:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280842AbRKBVPw>; Fri, 2 Nov 2001 16:15:52 -0500
Date: Fri, 2 Nov 2001 13:13:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <Pine.LNX.4.33.0111021250560.20078-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111021303060.20128-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Slightly updated version of earlier private email ]

On Fri, 2 Nov 2001, Daniel Phillips wrote:
>
> Yes, it does various things on various vms.  On 2.4.9 it stays on the
> inactive list until free memory gets down to rock bottom, then most of it
> moves to the active list and the system reaches a steady state where it can
> operate, though with kswapd grabbing 99% CPU (two processor system), but the
> test does complete.  On the current kernel the it dies.

On the 2.4.9 kernel, the "active" list is completely and utterly misnamed.

We move random pages to the active list, for random reasons. One of the
random reasons we have is "this page is mapped". Which has nothing to do
with activeness. The "active" list might as well have been called
"random_list_two".

In the new VM, only _active_ page get moved to the active list. So the
mlocked pages will stay on the inactive list until somebody says they are
active. And right now nobody will ever say that they are active, because
we don't even scan the locked areas.

And the advantage of the non-random approach is that in the new VM, we can
_use_ the knowledge that the inactive list has filled up with mapped pages
to make a _useful_ decision: we decide that we need to start scanning the
VM tree and try to remove pages from the mappings.

Notice? No more "random decisions". We have a well-defined point where we
can say "Ok, our inactive list seems to be mostly mapped, so let's try to
unmap something".

In short, 2.4.9 handles the test because it does everything else wrong.

While 2.4.13 doesn't handle the test well, because the VM says "there's a
_lot_ of inactive mapped pages, I need to _do_ something about it". And
then vmscanning doesn't actually do anything.

Suggested patch appended.

> In the tests I did, it was about 1 gig out of 2.  I'm not sure how much
> memory is mlocked in the 3.5 Gig test the one that's failing, but it's
> certainly not anything like all of memory.  Really, we should be able to
> mlock 90%+ of memory without falling over.

Not a way in hell, for many reasons, and none of them have anything to do
with this particular problem.

The most _trivial_ reason is that if you lock more than 900MB of memory,
that locked area may well be all of the lowmem pages, and you're now
screwed forever. Dead, dead, dead.

(And I can come up with loads that do exactly the above: it's easy enough
to try to first allocate up all of highmem, and then do a mlock and try to
allocate up all of lowmem locked. It's even easier if you use loopback or
something that only wants to allocate lowmem in the first place).

In short, we MUST NOT mlock more than maybe 500MB _tops_ on intel. If we
ever do, our survival is pretty random, regardless of other VM issues.

The appended patch will should fix the unintentional problem, though.

		Linus

----
diff -u --recursive --new-file penguin/linux/mm/vmscan.c linux/mm/vmscan.c
--- penguin/linux/mm/vmscan.c	Thu Nov  1 17:59:12 2001
+++ linux/mm/vmscan.c	Fri Nov  2 13:10:58 2001
@@ -49,7 +49,7 @@
 	swp_entry_t entry;

 	/* Don't look at this pte if it's been accessed recently. */
-	if (ptep_test_and_clear_young(page_table)) {
+	if ((vma->vm_flags & VM_LOCKED) || ptep_test_and_clear_young(page_table)) {
 		mark_page_accessed(page);
 		return 0;
 	}
@@ -220,8 +220,8 @@
 	pgd_t *pgdir;
 	unsigned long end;

-	/* Don't swap out areas which are locked down */
-	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+	/* Don't swap out areas which are reserved */
+	if (vma->vm_flags & VM_RESERVED)
 		return count;

 	pgdir = pgd_offset(mm, address);

