Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWJTQa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWJTQa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJTQa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:30:27 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:22370 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750877AbWJTQa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:30:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NOswR1Iwf5larakrbDNt21CXMZTg235eaD1YznftP5fWC3muznxAoOYq7IQjJ46oZxsMvvmdczNSvrJx+hlD1c4oKP+aP0uPXP1F+ojlzWD0mAH9d4ma+pVUIdJ6b328jDt0qx8VVN2gAGfXV8PcJTRm+xDJ+wUEiTd+JGhAgOk=  ;
Message-ID: <4538F99C.3060806@yahoo.com.au>
Date: Sat, 21 Oct 2006 02:30:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au> <20061020160538.GB18649@linux-mips.org>
In-Reply-To: <20061020160538.GB18649@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Sat, Oct 21, 2006 at 12:39:40AM +1000, Nick Piggin wrote:

>>So moving the flush_cache_mm below the copy_page_range, to just
>>before the flush_tlb_mm, would work then? This would make the
>>race much smaller than with this patchset.
> 
> 
> 90% of this changeset are MIPS-specific code.  Of that in turn much is
> just infrastructure which is already being used anyway.
> 
> 
>>But doesn't that still leave a race?
> 
> 
> Both calls would have to be done  under the mmap_sem to close any races.

Of course.

>>What if another thread writes to cache after we have flushed it
>>but before flushing the TLBs? Although we've marked the the ptes
>>readonly, the CPU won't trap if the TLB is valid? There must be
>>some special way for the arch to handle this, but I can't see it.
> 
> 
> There isn't really.  Reordering with a patch like:
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 29ebb30..28e51e0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -202,7 +202,6 @@ static inline int dup_mmap(struct mm_str
>  	struct mempolicy *pol;
>  
>  	down_write(&oldmm->mmap_sem);
> -	flush_cache_mm(oldmm);
>  	/*
>  	 * Not linked in yet - no deadlock potential:
>  	 */
> @@ -287,8 +286,9 @@ static inline int dup_mmap(struct mm_str
>  	}
>  	retval = 0;
>  out:
> -	up_write(&mm->mmap_sem);

You don't need to do that. Nothing will use the new mm.
You might also want a flush before the flush_tlb_mm.

Actually, we should turn this into a single call, so architectures
can optimise it however they like.

>  	flush_tlb_mm(oldmm);
> +	flush_cache_mm(oldmm);

That does close the race. We just need to ensure that all architectures
can handle this case.

And we need to figure out whether any of the other code that follows the
same flush_cache_* .. flush_tlb_* is buggy in the presence of other
threads writing into the cache in between.

I suspect they may well be, and you probably only noticed the issue in
fork, because the window is so large.

Places where we want to remove the mapping completely are going to be
more tricky to fix. Either we need to transition to readonly, then flush,
then transition to invalid, or arch code needs to be reworked
(the single operation caches and tlb flush will do the trick, but that
might to do an IPI, which is bad).

> +	up_write(&mm->mmap_sem);
>  	up_write(&oldmm->mmap_sem);
>  	return retval;
>  fail_nomem_policy:
> 
> should close the hole for all effected architectures.  I say should
> because this patch would need another round of linux-arch reviewing and I
> haven't tested it this patch yet myself.
> 
> But even so that doesn't change that I would really like to make
> copy_user_highpage() an arch interface replacing copy_to_user_page.
> 
> The current way of doing things enforces a cacheflush on MIPS which itself
> is pricy - 1,000 cycles when it's cheap but could be several times as
> expensive.  And as a side effect of the cacheflush the process breaking
> a COW page will start with a cold page.
> 
> Or if an architecture wants to be clever about aliasing and uses the
> vto argument of copy_user_page to create a non-conflicting mapping it
> means the mapping setup by copy_user_highpage will be unused ...

OK, I'm not arguing against any other changes. Hmm... I don't see how you
can kmap_coherent the "from" page when it can be mapped into more than one
virtual address? Does the MIPS port restrict remapping to the same colour?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
