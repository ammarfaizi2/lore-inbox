Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWJTQFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWJTQFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWJTQFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:05:22 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:26507 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932268AbWJTQFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:05:21 -0400
Date: Fri, 20 Oct 2006 17:05:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020160538.GB18649@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4538DFAC.1090206@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 12:39:40AM +1000, Nick Piggin wrote:

> >>That would require changing the order of cache flush and tlb flush.
> >>To keep certain architectures that require a valid translation in
> >>the TLB the cacheflush has to be done first.  Not sure if those
> >>architectures need a writeable mapping for dirty cachelines - I
> >>think hypersparc was one of them.
> >
> >
> >There just has to be "a mapping" in the TLB so that the L2 cache can
> >translate the virtual address to a physical one for the writeback to
> >main memory.
> 
> So moving the flush_cache_mm below the copy_page_range, to just
> before the flush_tlb_mm, would work then? This would make the
> race much smaller than with this patchset.

90% of this changeset are MIPS-specific code.  Of that in turn much is
just infrastructure which is already being used anyway.

> But doesn't that still leave a race?

Both calls would have to be done  under the mmap_sem to close any races.

> What if another thread writes to cache after we have flushed it
> but before flushing the TLBs? Although we've marked the the ptes
> readonly, the CPU won't trap if the TLB is valid? There must be
> some special way for the arch to handle this, but I can't see it.

There isn't really.  Reordering with a patch like:

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/kernel/fork.c b/kernel/fork.c
index 29ebb30..28e51e0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -202,7 +202,6 @@ static inline int dup_mmap(struct mm_str
 	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
-	flush_cache_mm(oldmm);
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
@@ -287,8 +286,9 @@ static inline int dup_mmap(struct mm_str
 	}
 	retval = 0;
 out:
-	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);
+	flush_cache_mm(oldmm);
+	up_write(&mm->mmap_sem);
 	up_write(&oldmm->mmap_sem);
 	return retval;
 fail_nomem_policy:

should close the hole for all effected architectures.  I say should
because this patch would need another round of linux-arch reviewing and I
haven't tested it this patch yet myself.

But even so that doesn't change that I would really like to make
copy_user_highpage() an arch interface replacing copy_to_user_page.

The current way of doing things enforces a cacheflush on MIPS which itself
is pricy - 1,000 cycles when it's cheap but could be several times as
expensive.  And as a side effect of the cacheflush the process breaking
a COW page will start with a cold page.

Or if an architecture wants to be clever about aliasing and uses the
vto argument of copy_user_page to create a non-conflicting mapping it
means the mapping setup by copy_user_highpage will be unused ...

  Ralf
