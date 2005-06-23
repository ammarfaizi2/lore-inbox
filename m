Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVFWXWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVFWXWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWXWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:22:40 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:12948 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262705AbVFWXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:21:40 -0400
Message-ID: <42BB43FB.1060609@yahoo.com.au>
Date: Fri, 24 Jun 2005 09:21:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <42BA8FA5.2070407@yahoo.com.au> <20050623220812.GD3334@holomorphy.com>
In-Reply-To: <20050623220812.GD3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>As exciting as this is, !!(vma->vm_flags & VM_RESERVED) could trivially
>>>go into struct zap_details without excess args or diff.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>Actually, it isn't trivial. I thought of trying that.
> 
> 
> You're probably thinking of the zap_page_range() vs. unmap_page_range()
> topmost-level entrypoints as being the only places to set the flag in
> details. Unconditionally clobbering the field in details in
> zap_pud_range() should resolve any issues associated with that.
> 
> This is obviously a style and/or diff-minimization issue.
> 

I'm thinking of exit_mmap and unmap_vmas, that don't pass in a
details field at all, and all the tests for details being marked
unlikely. I ended up thinking it was less ugly this way.

> 
> William Lee Irwin III wrote:
> 
>>>The refcounting and PG_reserved activity in memmap_init_zone() is
>>>superfluous. bootmem.c does all the necessary accounting internally.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>Well not superfluous yet. It is kept around to support all the arch
>>code that still uses it (not much, mainly reserved memory reporting).
> 
> 
> That activity is outside memmap_init_zone(). Specifically, the page
> structures are not used for anything whatsoever before bootmem puts
> them into the buddy allocators. It is not particularly interesting
> or difficult to defer even the initialization to the precise point
> in time bootmem cares to perform buddy bitmap insertion. This goes
> for all fields of struct page. What's notable about PG_reserved and
> refcounts here is that memmap_init_zone() goes about flipping bits one
> way where free_all_bootmem_core() undoes all its work.
> 

This patch doesn't care how it works, that would be for a later patch.

> 
> William Lee Irwin III wrote:
> 
>>>There is no error returned here to be handled by the caller.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>That's OK, the pte has been cleared. Nothing else we can do.
> 
> 
> This is called in the interior of a loop, which may be beneficial to
> terminate if this intended semantic is to be enforced. Furthermore, no
> error is propagated to the caller, which is not the desired effect in
> the stated error reporting scheme. So the code is inconsistent with
> explicitly stated intention.
> 

No, the error reporting scheme says it doesn't handle any error,
that is all. What we have here in terms of behaviour is exactly
what used to happen, that is - do something saneish on error.
Changing behaviour would be outside the scope of this patch, but
be my guest.

> 
> William Lee Irwin III wrote:
> 
>>>This has no effect but to artificially constrain the interface. There
>>>is no a priori reason to avoid the use of install_page() to deposit
>>>mappings to normal pages in VM_RESERVED vmas. It's only the reverse
>>>being "banned" here. Similar comments also apply to zap_pte().
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>No, install_page is playing with the page (eg. page_add_file_rmap)
>>which is explicity banned even before my PageReserved removal. It
>>is unclear that this ever safely worked for normal pages, and will
>>hit NULL page dereferences if trying to do it with iomem.
> 
> 
> You are going on about the fact that install_page() can't be used on
> memory outside mem_map[] as it requires a page structure, and can't be
> used on reserved pages because page_add_file_rmap() will BUG. This case
> is not being discussed.
> 

And that it isn't allowed to touch struct page of physical pages
in a VM_RESERVED region.

> The issue at stake is inserting normal pages into a VM_RESERVED vma.
> These will arise as e.g. kernel-allocated buffers managed by normal
> reference counting. remap_pfn_range() can't do it; it refuses to
> operate on "valid memory". install_page() now won't do it; it refuses
> to touch a VM_RESERVED vma. So this creates a giant semantic hole,
> and potentially breaks working code (i.e. if you were going to do
> this you would need not only a replacement but also a sweep to adjust
> all the drivers doing it or prove their nonexistence).
> 

I think you'll find that remap_pfn_range will be happy to operate
on valid memory, and that any driver trying to use install_page
on VM_RESERVED probably needs fixing anyway.

> 
> William Lee Irwin III wrote:
> 
>>>An answer should be devised for this. My numerous SCSI CD-ROM devices
>>>(I have 5 across several different machines of several different arches)
>>>are rather unlikely to be happy with /* FIXME: XXX ... as an answer.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>The worst it will do is dirty a VM_RESERVED page. So it is going
>>to work unless you're thinking about doing something crazy like
>>mmap /dev/mem and send your CDROM some pages from there. But yeah,
>>I have to find someone who knows what they're doing to look at this.
> 
> 
> Then you should replace FIXME: XXX with this explanation. By and large
> the presence of "FIXME: XXX" is a sign there is a gigantic hole in the
> code. It should definitely not be done with new code, but rather,
> exclusively confined to documenting discoveries of preexisting brokenness.
> After all, if a patch is introducing broken code, why would we merge it?
> Best to adjust the commentary and avoid that question altogether.
> 

We wouldn't merge it. Hence this is an rfc and I explicitly said
it is not for merging.

> There are actually larger questions about this than the reserved page
> handling. If e.g. pagecache pages need to be dirtied the raw bitflag
> toggling is probably not how it should be done.
> 

Yep.

> 
> William Lee Irwin III wrote:
> 
>>>snd_malloc_pages() marks all pages it allocates PG_reserved. This
>>>merits some commentary, and likely the removal of the superfluous
>>>PG_reserved usage.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>Sure, but not in this patch. The aim here is just to eliminate special
>>casing of refcounting. Other PG_reserved usage can stay around for the
>>moment (and is actually good for catching errors).
> 
> 
> Unfortunately for this scheme, it's very much a case of putting the
> cart before the horse. PG_reserved is toggled at random in this driver
> after this change, to no useful effect (debugging or otherwise). And
> this really goes for the whole affair. Diddling the core first is just
> going to create bugs. Converting the users first is the way these
> things need to be done. When complete, nothing needs the core flags
> twiddling anymore and you just nuke the flag twiddling from the core.
> 

I'm sorry, I don't see how 'diddling' the core will create bugs.

This is a fine way to do it, and "converting" users first (whatever
that means) is not possible because VM_RESERVED handling in core
code is not up to the task of replacing PageReserved without this
patch.

> 
> William Lee Irwin III wrote:
> 
>>>This is user-triggerable where the driver honors mmap() protection
>>>flags blindly.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>If the user is allowed write access to VM_RESERVED memory, then I
>>suspect there is a lot worse they can do than flood the log.
>>But the check isn't going to stay around forever.
> 
> 
> This doesn't really do a whole lot of good for the unwitting user
> who invokes a privileged application relying on such kernel behavior.
> User-visible changes need to be taken on with somewhat more care
> (okay, vastly more, along with long-term backward compatibility).
> 

It does a great lot of good, because they can tell us about it
we'll fix it. Search the kernel sources and you'll find other
examples that look almost exactly like this one.

> 
> William Lee Irwin III wrote:
> 
>>>This behavioral change needs to be commented on. There are some additional
>>>difficulties when memory holes are unintentionally covered by mem_map[];
>>>It is beneficial otherwise. It's likely to triplefault on such holes.
> 
> 
> On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> 
>>It seems the author of this code themselves didn't really understand
>>what was going on here, so I'm buggered if I can be bothered :)
>>Remember though, PageReserved can stay around for as long as we need,
>>so this hunk can be trivially reverted if it is an immediate problem.
> 
> 
> This doesn't really fly. A fair number of drivers are poorly-understood
> and numerous gyrations have to be gone through to avoid breaking their
> possible assumptions until at long last clarifications are made (that
> is, if they're ever made). swsusp is not demotable to below their
> status on a whim.
> 

Yep, that's why I'm going to ask some swsusp developers to have
a look at it.

I wouldn't pretend to be able to fix every bug everywhere in the
kernel myself.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
