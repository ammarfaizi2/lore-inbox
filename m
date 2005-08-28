Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVH1Gs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVH1Gs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 02:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVH1Gs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 02:48:59 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:28246 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750764AbVH1Gs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 02:48:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=hJJxjDJnyd1/9n6L8NkqonqNPTxNmoSZinfnwEIQkTzC2Xwy9ucIkiwTefKJebtjsx1czSgg7ev9PrW4vI7tyHqaOI5DI88OqYjAC6JjxET2TMelJhwKh5JykLZKAsWlCv1/HEtxK6hbOK9+9BQBuRAFtJusN/++mtYYDDOnl9U=  ;
Message-ID: <43115E67.1050305@yahoo.com.au>
Date: Sun, 28 Aug 2005 16:49:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org> <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com> <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com> <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au> <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------090309030003000304010703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309030003000304010703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hugh Dickins wrote:
> On Sun, 28 Aug 2005, Nick Piggin wrote:
> 
>>This is the condition I ended up with. Any good?
>>
>>if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
>>if (vma->vm_flags & VM_MAYSHARE)
>> return 0;
>>if (vma->vm_file && !vma->anon_vma)
>>   return 0;
>>}
> 
> 
> It's not bad, and practical timings are unlikely to differ, but your
> VM_MAYSHARE test is redundant (VM_MAYSHARE areas don't have anon_vmas *),
> and your vm_file test is unnecessary, excluding pure anonymous areas
> which haven't yet taken a fault.
> 

Haven't taken a _write_ fault? Hmm, OK  that would seem to be a good
optimisation as well: we don't need to copy anon memory with only
ZERO_PAGE mappings... well, good as in "nice and logical" if not so
much "will make a difference"!

> Please do send Andrew the patch for -mm, Nick: you were one of the
> creators of this (don't omit credit to Ray, Parag, Andi, Rik, Linus),
> much better that it go in your name (heh, heh, heh, can you trust me?)
> 

Well Andi and I seemed to have the idea independently, Linus thought
private would be a good idea (I agree), you came up with the complete
patch with others contributing bits and pieces, and most importantly
Ray brought our attention to the possible deficiency in our mm.

> Hugh
> 
> * That's ignoring, as we do everywhere else, the case which came up
> a couple of weeks back in discussions with Linus, ptrace writing to
> an area the process does not have write access to, creating an anon
> page within a shared vma: that's an awkward case currently mishandled,
> but the patch below does it no harm.
> 

And in that case maybe your patch works better anyway, because the child
will inherit that page from parent.

How does the following look? (I changed the comment a bit). Andrew, please
apply if nobody objects.

-- 
SUSE Labs, Novell Inc.


--------------090309030003000304010703
Content-Type: text/plain;
 name="vm-lazy-fork.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-lazy-fork.patch"

Defer copying of ptes until fault time when it is possible to reconstruct
the pte from backing store. Idea from Andi Kleen and Nick Piggin.

Thanks to input from Rik van Riel and Linus and to Hugh for correcting
my blundering.

[ Note to akpm: Ray Fucillo <fucillo@intersystems.com>'s results go here ]

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-08-13 11:16:34.000000000 +1000
+++ linux-2.6/mm/memory.c	2005-08-28 16:41:32.000000000 +1000
@@ -498,6 +498,17 @@ int copy_page_range(struct mm_struct *ds
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
 
+	/*
+	 * Don't copy ptes where a page fault will fill them correctly.
+	 * Fork becomes much lighter when there are big shared or private
+	 * readonly mappings. The tradeoff is that copy_page_range is more
+	 * efficient than faulting.
+	 */
+	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
+		if (!vma->anon_vma)
+			return 0;
+	}
+
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 

--------------090309030003000304010703--
Send instant messages to your online friends http://au.messenger.yahoo.com 
