Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVC3XnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVC3XnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVC3Xmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:42:50 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:35210 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262567AbVC3Xk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:40:56 -0500
Message-ID: <424B38FC.5090701@yahoo.com.au>
Date: Thu, 31 Mar 2005 09:40:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>     <20050323115736.300f34eb.davem@davemloft.net>     <42420928.7040502@yahoo.com.au> <Pine.LNX.4.61.0503302008080.21817@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0503302008080.21817@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------030605040501020600080804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605040501020600080804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hugh Dickins wrote:

> It's clearly superior to what David and I had, in branching
> less (other than in your BUG_ONs), and I do believe your
> "if (end - ceiling - 1 < P*_SIZE - 1)" is correct and efficient.
> 

Well the BUG_ONs were more to just satisfy me that my assumptions
were correct. Not to mention only contained in the top level, so
they shouldn't hurt performance. But they could go.

> But I still find it harder to understand than ours; and don't
> understand at all your comment "end can't have approached ceiling
> from above...." - but I think you're bravely trying to explain the case
> I sidestepped with a lordly unexplained "end can't go down to 0 there".
> 

Yes, say ceiling is 0 - something less than P*_SIZE, you might
get the feeling that end may be able to come within our limit
of it if it were a very small number.

This can't happen because 0 is actually the top of address space,
and end can't be *greater* than ceiling before any rounding. If it
is not 0, then it must be at least 1, in which case it will always
be rounded up to the next P*_SIZE boundary. So no problem.

This may have been obvious to you from the start, in which case my
extra rambling may have confused you... actually on re-reading it,
it would have confused you no matter what. See if the next version
is better.

> Let others decide.
> 
> One thing I believe is outright wrong, at least with out-of-tree
> patches: your change from "if (addr > end - 1)" to "if (addr >= end)",
> after you've just rounded up end (perhaps to 0).
> 

Oh yes, good catch. I don't know why I did that :(

> (And let me astonish you by asking for the blank lines back before
> pmd_offset and pud_offset!)
> 

Hugh? What have you done with Hugh?


--------------030605040501020600080804
Content-Type: text/plain;
 name="freepgt-boundary-tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="freepgt-boundary-tests.patch"

Simplify (from the machine's point of view) the infamous boundary tests.
The method, and an outline of the proof (which I haven't actually done)
is recorded in the comments.

It is not conceptually much more difficult than the current method when
it is understood, although it doesn't present the corner cases so explicitly
in code (hence the need for comments).

Eliminates 2 branches per freeable page table level.

Tested and works on i386, ia64, sparc64.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-03-29 17:09:16.000000000 +1000
+++ linux-2.6/mm/memory.c	2005-03-31 09:39:31.000000000 +1000
@@ -139,12 +139,8 @@ static inline void free_pmd_range(struct
 	start &= PUD_MASK;
 	if (start < floor)
 		return;
-	if (ceiling) {
-		ceiling &= PUD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	end = (end + PUD_SIZE - 1) & PUD_MASK;
+	if (end - ceiling - 1 < PUD_SIZE - 1)
 		return;
 
 	pmd = pmd_offset(pud, start);
@@ -172,12 +168,8 @@ static inline void free_pud_range(struct
 	start &= PGDIR_MASK;
 	if (start < floor)
 		return;
-	if (ceiling) {
-		ceiling &= PGDIR_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	end = (end + PGDIR_SIZE - 1) & PGDIR_MASK;
+	if (end - ceiling - 1 < PGDIR_SIZE - 1)
 		return;
 
 	pud = pud_offset(pgd, start);
@@ -198,6 +190,10 @@ void free_pgd_range(struct mmu_gather **
 	unsigned long next;
 	unsigned long start;
 
+	BUG_ON(addr >= end);
+	/* Don't want end to be 0 and ceiling to be greater than 0-PGDIR_SIZE */
+	BUG_ON(end - 1 > ceiling - 1);
+
 	/*
 	 * The next few lines have given us lots of grief...
 	 *
@@ -205,23 +201,25 @@ void free_pgd_range(struct mmu_gather **
 	 * there will be no work to do at all, and we'd prefer not to
 	 * go all the way down to the bottom just to discover that.
 	 *
-	 * Why all these "- 1"s?  Because 0 represents both the bottom
-	 * of the address space and the top of it (using -1 for the
-	 * top wouldn't help much: the masks would do the wrong thing).
-	 * The rule is that addr 0 and floor 0 refer to the bottom of
-	 * the address space, but end 0 and ceiling 0 refer to the top
-	 * Comparisons need to use "end - 1" and "ceiling - 1" (though
-	 * that end 0 case should be mythical).
-	 *
-	 * Wherever addr is brought up or ceiling brought down, we must
-	 * be careful to reject "the opposite 0" before it confuses the
-	 * subsequent tests.  But what about where end is brought down
-	 * by PMD_SIZE below? no, end can't go down to 0 there.
+	 * The tricky part of this logic (and similar in free_p?d_range above)
+	 * is the 'end' handling. end and ceiling are *exclusive* boundaries,
+	 * so their maximum is 0. This suggests the use of two's complement
+	 * difference when comparing them, so the wrapping is handled for us.
 	 *
-	 * Whereas we round start (addr) and ceiling down, by different
-	 * masks at different levels, in order to test whether a table
-	 * now has no other vmas using it, so can be freed, we don't
-	 * bother to round floor or end up - the tests don't need that.
+	 * The method is:
+	 * - Round end up to the nearest PMD aligned boundary.
+	 * - If end has exceeded ceiling, then end - ceiling will be less than
+	 *   PMD_SIZE.
+	 * - If end is very small (close to 0) and ceiling is very large
+	 *   (close to wrapping to 0, or 0), then the end - ceiling condition
+	 *   needs to be false. This holds because end must be at least 1, and
+	 *   so rounding it up will always take it to the first PMD boundary,
+	 *   and hence out of reach of ceiling.
+	 * - If end is 0 (top of address space), then ceiling must also be 0.
+	 * - In the above case that end is 0, or any other time end might be
+	 *   equal to ceiling, end - ceiling = 0 < PMD_SIZE. So the actual test
+	 *   we use is (unsigned) end - ceiling - 1 < PMD_SIZE - 1,
+	 *   to catch this case. 
 	 */
 
 	addr &= PMD_MASK;
@@ -230,12 +228,8 @@ void free_pgd_range(struct mmu_gather **
 		if (!addr)
 			return;
 	}
-	if (ceiling) {
-		ceiling &= PMD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	end = (end + PMD_SIZE - 1) & PMD_MASK;
+	if (end - ceiling - 1 < PMD_SIZE - 1)
 		end -= PMD_SIZE;
 	if (addr > end - 1)
 		return;

--------------030605040501020600080804--

