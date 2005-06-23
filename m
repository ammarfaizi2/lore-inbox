Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVFWWSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVFWWSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVFWWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:14:49 -0400
Received: from holomorphy.com ([207.189.100.168]:56792 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262812AbVFWWIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:08:20 -0400
Date: Thu, 23 Jun 2005 15:08:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
Message-ID: <20050623220812.GD3334@holomorphy.com>
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <42BA8FA5.2070407@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA8FA5.2070407@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> As exciting as this is, !!(vma->vm_flags & VM_RESERVED) could trivially
>> go into struct zap_details without excess args or diff.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> Actually, it isn't trivial. I thought of trying that.

You're probably thinking of the zap_page_range() vs. unmap_page_range()
topmost-level entrypoints as being the only places to set the flag in
details. Unconditionally clobbering the field in details in
zap_pud_range() should resolve any issues associated with that.

This is obviously a style and/or diff-minimization issue.


William Lee Irwin III wrote:
>> The refcounting and PG_reserved activity in memmap_init_zone() is
>> superfluous. bootmem.c does all the necessary accounting internally.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> Well not superfluous yet. It is kept around to support all the arch
> code that still uses it (not much, mainly reserved memory reporting).

That activity is outside memmap_init_zone(). Specifically, the page
structures are not used for anything whatsoever before bootmem puts
them into the buddy allocators. It is not particularly interesting
or difficult to defer even the initialization to the precise point
in time bootmem cares to perform buddy bitmap insertion. This goes
for all fields of struct page. What's notable about PG_reserved and
refcounts here is that memmap_init_zone() goes about flipping bits one
way where free_all_bootmem_core() undoes all its work.


William Lee Irwin III wrote:
>> There is no error returned here to be handled by the caller.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> That's OK, the pte has been cleared. Nothing else we can do.

This is called in the interior of a loop, which may be beneficial to
terminate if this intended semantic is to be enforced. Furthermore, no
error is propagated to the caller, which is not the desired effect in
the stated error reporting scheme. So the code is inconsistent with
explicitly stated intention.


William Lee Irwin III wrote:
>> This has no effect but to artificially constrain the interface. There
>> is no a priori reason to avoid the use of install_page() to deposit
>> mappings to normal pages in VM_RESERVED vmas. It's only the reverse
>> being "banned" here. Similar comments also apply to zap_pte().

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> No, install_page is playing with the page (eg. page_add_file_rmap)
> which is explicity banned even before my PageReserved removal. It
> is unclear that this ever safely worked for normal pages, and will
> hit NULL page dereferences if trying to do it with iomem.

You are going on about the fact that install_page() can't be used on
memory outside mem_map[] as it requires a page structure, and can't be
used on reserved pages because page_add_file_rmap() will BUG. This case
is not being discussed.

The issue at stake is inserting normal pages into a VM_RESERVED vma.
These will arise as e.g. kernel-allocated buffers managed by normal
reference counting. remap_pfn_range() can't do it; it refuses to
operate on "valid memory". install_page() now won't do it; it refuses
to touch a VM_RESERVED vma. So this creates a giant semantic hole,
and potentially breaks working code (i.e. if you were going to do
this you would need not only a replacement but also a sweep to adjust
all the drivers doing it or prove their nonexistence).


William Lee Irwin III wrote:
>> An answer should be devised for this. My numerous SCSI CD-ROM devices
>> (I have 5 across several different machines of several different arches)
>> are rather unlikely to be happy with /* FIXME: XXX ... as an answer.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> The worst it will do is dirty a VM_RESERVED page. So it is going
> to work unless you're thinking about doing something crazy like
> mmap /dev/mem and send your CDROM some pages from there. But yeah,
> I have to find someone who knows what they're doing to look at this.

Then you should replace FIXME: XXX with this explanation. By and large
the presence of "FIXME: XXX" is a sign there is a gigantic hole in the
code. It should definitely not be done with new code, but rather,
exclusively confined to documenting discoveries of preexisting brokenness.
After all, if a patch is introducing broken code, why would we merge it?
Best to adjust the commentary and avoid that question altogether.

There are actually larger questions about this than the reserved page
handling. If e.g. pagecache pages need to be dirtied the raw bitflag
toggling is probably not how it should be done.


William Lee Irwin III wrote:
>> snd_malloc_pages() marks all pages it allocates PG_reserved. This
>> merits some commentary, and likely the removal of the superfluous
>> PG_reserved usage.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> Sure, but not in this patch. The aim here is just to eliminate special
> casing of refcounting. Other PG_reserved usage can stay around for the
> moment (and is actually good for catching errors).

Unfortunately for this scheme, it's very much a case of putting the
cart before the horse. PG_reserved is toggled at random in this driver
after this change, to no useful effect (debugging or otherwise). And
this really goes for the whole affair. Diddling the core first is just
going to create bugs. Converting the users first is the way these
things need to be done. When complete, nothing needs the core flags
twiddling anymore and you just nuke the flag twiddling from the core.


William Lee Irwin III wrote:
>> This is user-triggerable where the driver honors mmap() protection
>> flags blindly.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> If the user is allowed write access to VM_RESERVED memory, then I
> suspect there is a lot worse they can do than flood the log.
> But the check isn't going to stay around forever.

This doesn't really do a whole lot of good for the unwitting user
who invokes a privileged application relying on such kernel behavior.
User-visible changes need to be taken on with somewhat more care
(okay, vastly more, along with long-term backward compatibility).


William Lee Irwin III wrote:
>> This behavioral change needs to be commented on. There are some additional
>> difficulties when memory holes are unintentionally covered by mem_map[];
>> It is beneficial otherwise. It's likely to triplefault on such holes.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> It seems the author of this code themselves didn't really understand
> what was going on here, so I'm buggered if I can be bothered :)
> Remember though, PageReserved can stay around for as long as we need,
> so this hunk can be trivially reverted if it is an immediate problem.

This doesn't really fly. A fair number of drivers are poorly-understood
and numerous gyrations have to be gone through to avoid breaking their
possible assumptions until at long last clarifications are made (that
is, if they're ever made). swsusp is not demotable to below their
status on a whim.

The failure mode must also be considered. Users are highly unlikely to
generate comprehensible bugreports from triplefaults.

It's also rather easy to see this case will arise on every non-NUMA
ia32 machine with > 4GB RAM, and that we dare not attempt to save
or restore such pages during suspend/resume cycles.


William Lee Irwin III wrote:
>> The pfn_is_nosave() check must stand barring justification of why
>> unintentionally saving (and hence restoring) the page is tolerable.

On Thu, Jun 23, 2005 at 08:32:05PM +1000, Nick Piggin wrote:
> I thought the PageNosave should catch that, and the next line is
> just a debug check. But I'm looking for someone who *actually* knows
> how swsusp works, if anyone would like to volunteer :)

This one is readily observable. It's doing a bounds check on the pfn.
This corresponds to the __nosave region being assigned struct pages
to cover it. We can't get by with accidentally saving and restoring it.


-- wli
