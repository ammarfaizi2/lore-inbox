Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVCXA0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVCXA0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCXA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:26:37 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:26987 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262108AbVCXA0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:26:21 -0500
Message-ID: <42420928.7040502@yahoo.com.au>
Date: Thu, 24 Mar 2005 11:26:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050323115736.300f34eb.davem@davemloft.net>
In-Reply-To: <20050323115736.300f34eb.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------010606030809050400000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606030809050400000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> On Wed, 23 Mar 2005 17:10:15 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> 
>>Here's the recut of those patches, including David Miller's vital fixes.
>>I'm addressing these to Nick rather than Andrew, because they're perhaps
>>not fit for -mm until more testing done and the x86_64 32-bit vdso issue
>>handled.  I'm unlikely to be responsive until next week, sorry: over to
>>you, Nick - thanks.
> 
> 
> Works perfectly fine on sparc64.
> 

OK, attached is my first cut at slimming down the boundary tests.
I have only had a chance to try it on i386, so I hate to drop it
on you like this - but I *have* put a bit of thought into it....
Treat it as an RFC, and I'll try to test it on a wider range of
things in the next couple of days.

Not that there is anything really nasty with your system David,
so I don't think it will be a big disaster if I can't get this to
work.

Goes on top of Hugh's 6 patches.

--------------010606030809050400000301
Content-Type: text/plain;
 name="fix-ptclear"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ptclear"

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-03-24 10:43:31.000000000 +1100
+++ linux-2.6/mm/memory.c	2005-03-24 11:22:21.000000000 +1100
@@ -139,14 +139,9 @@ static inline void free_pmd_range(struct
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
-
 	pmd = pmd_offset(pud, start);
 	pud_clear(pud);
 	pmd_free_tlb(tlb, pmd);
@@ -172,14 +167,9 @@ static inline void free_pud_range(struct
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
-
 	pud = pud_offset(pgd, start);
 	pgd_clear(pgd);
 	pud_free_tlb(tlb, pud);
@@ -198,6 +188,10 @@ void free_pgd_range(struct mmu_gather **
 	unsigned long next;
 	unsigned long start;
 
+	BUG_ON(addr >= end);
+	/* Don't want end to be 0 and ceiling to be greater than 0-PGDIR_SIZE */
+	BUG_ON(end - 1 > ceiling - 1);
+
 	/*
 	 * The next few lines have given us lots of grief...
 	 *
@@ -205,23 +199,22 @@ void free_pgd_range(struct mmu_gather **
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
+	 *   end can't have approached ceiling from above if ceiling is 0,
+	 *   because it is rounded up to the next PMD aligned boundary, so
+	 *   either it will be 0, or 0+PMD_SIZE.
+	 * - In the above case that end is 0, or any other time end might be
+	 *   equal to ceiling, end - ceiling = 0 < PMD_SIZE. So the actual test
+	 *   we use is (unsigned) end - ceiling - 1 < PMD_SIZE - 1,
+	 *   to catch this case. 
 	 */
 
 	addr &= PMD_MASK;
@@ -230,14 +223,10 @@ void free_pgd_range(struct mmu_gather **
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
-	if (addr > end - 1)
+	if (addr >= end)
 		return;
 
 	start = addr;

--------------010606030809050400000301--

