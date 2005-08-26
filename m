Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVHZSXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVHZSXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVHZSXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:23:06 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:62142 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965168AbVHZSXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=dpoM+rdo00uncLvMpQyDUhmKKvaC6L1bSpzkZCfB9JTZoA1TzGSo/MWI1MT3q2dFB8MVI+6AuYQO4mP+hMJU3P8DvX/IxbeRIPiju/t7GpW7vuTkw8J+DSiFoe00X9X6UG3aOcqgVT5y+60tLdVtTNJbS58OOEZ4kaoSvV8KjX4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: remove-stale-comment-from-swapfilec.patch added to -mm tree
Date: Fri, 26 Aug 2005 20:17:37 +0200
User-Agent: KMail/1.8.1
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
References: <200508172149.j7HLn37L012796@shell0.pdx.osdl.net> <Pine.LNX.4.61.0508241335390.4198@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508241335390.4198@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508262017.38301.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 15:26, Hugh Dickins wrote:
> On Wed, 17 Aug 2005 akpm@osdl.org wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > Seems like on 2.4.9.4 this comment got out of sync ;-)

> Not at all.  That comment (not mine) was valid before and after 2.4.9,
> though agreed may be mystifying since there's no visible pte_wrprotect.
> That's because vm_page_prot must not include write permission there,
> so the pte being constructed is automatically write-protected.
Ahhh! Thanks.
> (But there are several other places in the mm source, I'll not look
> them up right now, where there is an explicit pte_wrprotect, despite
> that vm_page_prot cannot have write permission in that place.
> I think do_anonymous_page gives an example of that.  Inconsistent.)
Ok, a shared writable mapping is made shmfs-based, so nopage is used there. A 
bit tricky to notice.
> > I'm not completely sure on which basis we don't need any more to do as
> > the comment suggests,

> There has been no change regarding write protection of the pte there,
> not since before 2.4.0 anyway.

> > but it seems that when faulting in a second time the same
> > swap page,  can_share_swap_page() returns false, and we do an early COW
> > break, so there's no need to write-protect the page.
> >
> > No idea why we don't defer the COW break.

> I don't understand what's being asserted there.

> If do_swap_page gets 
> a write fault, it either determines it can go ahead and use the swap
> page, or if it can't, gets do_wp_page to Copy-On-Write for it (that's
> a call I added in 2.6.7, as an optimization, and as a necessity for
> correct behaviour of ptrace's get_user_pages; the latter has just in
> 2.6.13-rc been made more resilient, so we could remove do_swap_page's
> call to do_wp_page now - though I'm inclined to let it stay as an
> optimization, avoiding the second fault which would follow).
get_user_pages() can still get two faults there, because VM_FAULT_WRITE is not 
returned by do_swap_page(). And faults can be very expensive (for UML a fault 
is given by a SIGSEGV delivery).

> If do_swap_page gets a read fault, it doesn't COW at all.

> I don't know what the "early" COW break referred to is: the write_access
> call to do_wp_page could be deferred, yes, but it's hardly early.
The idea in my mind is that after loading the page from swap the first time 
there's no need to copy the page to give a private copy to the process, if 
the page is kept on swap.

We COW it anyway to break the sharing, to keep the original copy in the 
swapcache, instead of reading it again from the disk. This is *early*. 

> Usually that's a reason to mark it as young (recently referenced).

> Yes, it was me who added that pte_mkold to unuse_pte in 2.4.10:
> because the user process is not faulting the page in (referencing it),
> we're just bringing it in because we're forced to empty out swap.
> Mark it as old because it hasn't been referenced by the process.

> But in 2.6.8, amusingly, Andrew introduced an activate_page there:
> because people were irritated by the way in which a swapoff followed
> by a swapon (which should "clean out" swap) led to the pages which
> had been swapped out before, quickly being swapped out again.

> My pte_mkold, and Andrew's activate_page, both have good justifications,
> but work right against each other.  Perhaps Andrew should have just
> removed my pte_mkold to get the effect he wanted.

Removing pte_mkold() and leaving the _PAGE_ACCESSED in vma->vm_page_prot would 
just turn out in one call to mark_page_accessed() I guess,, i.e. from 
inactive, unreferenced to inactive, referenced, while activate_page makes two 
steps...

> Oh, and now we 
> have another in unuse_mm - I thought I'd moved the unuse_pte one
> there, but there's two now.
> Amusing, but not very important. 
swapoff() and swapon() are not a real workload, agreed. But taking twice the 
spinlocks is bad, no?
> Andrew, please drop remove-stale-comment-from-swapfilec.patch.
> It was a good way to prod me into writing about a few things,
> but the comments are just wrong in too many ways.
Sorry for that and thanks for the insights!
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
