Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVFXBBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVFXBBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVFXBBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:01:43 -0400
Received: from holomorphy.com ([207.189.100.168]:17324 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262965AbVFXA77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:59:59 -0400
Date: Thu, 23 Jun 2005 17:59:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
Message-ID: <20050624005952.GE3334@holomorphy.com>
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <42BA8FA5.2070407@yahoo.com.au> <20050623220812.GD3334@holomorphy.com> <42BB43FB.1060609@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BB43FB.1060609@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> You're probably thinking of the zap_page_range() vs. unmap_page_range()
>> topmost-level entrypoints as being the only places to set the flag in
>> details. Unconditionally clobbering the field in details in
>> zap_pud_range() should resolve any issues associated with that.
>> This is obviously a style and/or diff-minimization issue.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> I'm thinking of exit_mmap and unmap_vmas, that don't pass in a
> details field at all, and all the tests for details being marked
> unlikely. I ended up thinking it was less ugly this way.

This doesn't pose any particular difficulty, but so noted since that's
what you had in mind.


William Lee Irwin III wrote:
>> That activity is outside memmap_init_zone(). Specifically, the page
>> structures are not used for anything whatsoever before bootmem puts
>> them into the buddy allocators. It is not particularly interesting
>> or difficult to defer even the initialization to the precise point
>> in time bootmem cares to perform buddy bitmap insertion. This goes
>> for all fields of struct page. What's notable about PG_reserved and
>> refcounts here is that memmap_init_zone() goes about flipping bits one
>> way where free_all_bootmem_core() undoes all its work.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> This patch doesn't care how it works, that would be for a later patch.

The general gist of all this is that the patch doesn't cover anywhere
near enough ground, and so the above illustrates that the usage
in/around bootmem is among the easiest of usages to remove. I have
implemented what I'm talking about on several independent occasions.


William Lee Irwin III wrote:
>> This is called in the interior of a loop, which may be beneficial to
>> terminate if this intended semantic is to be enforced. Furthermore, no
>> error is propagated to the caller, which is not the desired effect in
>> the stated error reporting scheme. So the code is inconsistent with
>> explicitly stated intention.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> No, the error reporting scheme says it doesn't handle any error,
> that is all. What we have here in terms of behaviour is exactly
> what used to happen, that is - do something saneish on error.
> Changing behaviour would be outside the scope of this patch, but
> be my guest.

Some places BUG(), some back out with an error return, others blithely
proceed. This kind of inconsistency will broadly confuse callers of
the API's.


William Lee Irwin III wrote:
>> You are going on about the fact that install_page() can't be used on
>> memory outside mem_map[] as it requires a page structure, and can't be
>> used on reserved pages because page_add_file_rmap() will BUG. This case
>> is not being discussed.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> And that it isn't allowed to touch struct page of physical pages
> in a VM_RESERVED region.

non sequitur


William Lee Irwin III wrote:
>> The issue at stake is inserting normal pages into a VM_RESERVED vma.
>> These will arise as e.g. kernel-allocated buffers managed by normal
>> reference counting. remap_pfn_range() can't do it; it refuses to
>> operate on "valid memory". install_page() now won't do it; it refuses
>> to touch a VM_RESERVED vma. So this creates a giant semantic hole,
>> and potentially breaks working code (i.e. if you were going to do
>> this you would need not only a replacement but also a sweep to adjust
>> all the drivers doing it or prove their nonexistence).

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> I think you'll find that remap_pfn_range will be happy to operate
> on valid memory, and that any driver trying to use install_page
> on VM_RESERVED probably needs fixing anyway.

install_page() of a !PageReserved() page in a VM_RESERVED vma is
neither broken now nor does it merit going BUG().

/dev/mem was disallowed from mapping ordinary kernel memory for a
reason (though I disagree with it), so the removal of the
pfn_valid()/PageReserved() checks can't be blithely done like in
your patch. Other arrangements must be made.


William Lee Irwin III wrote:
>> Unfortunately for this scheme, it's very much a case of putting the
>> cart before the horse. PG_reserved is toggled at random in this driver
>> after this change, to no useful effect (debugging or otherwise). And
>> this really goes for the whole affair. Diddling the core first is just
>> going to create bugs. Converting the users first is the way these
>> things need to be done. When complete, nothing needs the core flags
>> twiddling anymore and you just nuke the flag twiddling from the core.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> I'm sorry, I don't see how 'diddling' the core will create bugs.
> This is a fine way to do it, and "converting" users first (whatever
> that means)
[cut text included in full in the following quote block]

This is going way too far. Someone please deal with this.


On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
[continued]
> This is a fine way to do it, and "converting" users first (whatever
> that means) is not possible because VM_RESERVED handling in core
> code is not up to the task of replacing PageReserved without this
> patch.

You aren't replacing any of the PG_reserved usage with VM_RESERVED
in any of these patches. The primary motive of all this is AFAICT
little more than getting the PG_reserved check out of put_page(),
drivers and arches be damned.


William Lee Irwin III wrote:
>> This doesn't really fly. A fair number of drivers are poorly-understood
>> and numerous gyrations have to be gone through to avoid breaking their
>> possible assumptions until at long last clarifications are made (that
>> is, if they're ever made). swsusp is not demotable to below their
>> status on a whim.

On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> Yep, that's why I'm going to ask some swsusp developers to have
> a look at it.

Do you have any idea who wrote the comment you referred to?


On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> I wouldn't pretend to be able to fix every bug everywhere in the
> kernel myself.

I've got bad news for you. You will need to be willing and able to
read and alter the source of things as unglamorous as crappy ancient
drivers and obscure dogslow architectures and to do so carefully enough
things continue to work when you're changing broadly-used code. You
will never have the luxury of the hardware to test anywhere near 10%
of it on.

Worse yet, when you make the changes, you bear the burden of sweeps.
The fact they break when you make your change does not mean they were
buggy. It means you broke them. Sure, best effort is all you can ever
do, but this is far from anything like that.

If you can't handle the sweep, you have no business writing the patch.

Someone please take this over. None of this will be heeded so long as
I'm the one saying it.


-- wli
