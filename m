Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVFXBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVFXBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVFXBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:18:16 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:18782 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262976AbVFXBRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:17:36 -0400
Message-ID: <42BB5F29.6060802@yahoo.com.au>
Date: Fri, 24 Jun 2005 11:17:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <42BA8FA5.2070407@yahoo.com.au> <20050623220812.GD3334@holomorphy.com> <42BB43FB.1060609@yahoo.com.au> <20050624005952.GE3334@holomorphy.com>
In-Reply-To: <20050624005952.GE3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> 
>>This patch doesn't care how it works, that would be for a later patch.
> 
> 
> The general gist of all this is that the patch doesn't cover anywhere
> near enough ground, and so the above illustrates that the usage
> in/around bootmem is among the easiest of usages to remove. I have
> implemented what I'm talking about on several independent occasions.
> 

I don't think you understand what ground the patch covers.
It removes PageReserved() queries from core code, leaving
all PG_reserved flags and other uses of it intact so it
doesn't cause mass breakage.

Things can then be looked at and fixed up properly at a slower
pace while the patch is in -mm, for example.

> 
> William Lee Irwin III wrote:
> 
>>>This is called in the interior of a loop, which may be beneficial to
>>>terminate if this intended semantic is to be enforced. Furthermore, no
>>>error is propagated to the caller, which is not the desired effect in
>>>the stated error reporting scheme. So the code is inconsistent with
>>>explicitly stated intention.
> 
> 
> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> 
>>No, the error reporting scheme says it doesn't handle any error,
>>that is all. What we have here in terms of behaviour is exactly
>>what used to happen, that is - do something saneish on error.
>>Changing behaviour would be outside the scope of this patch, but
>>be my guest.
> 
> 
> Some places BUG(), some back out with an error return, others blithely
> proceed. This kind of inconsistency will broadly confuse callers of
> the API's.
> 

I don't think any places BUG(), but regardless, this patch doesn't
deal with changing behaviour, just reporting of the problem.

> 
> William Lee Irwin III wrote:
> 
>>>You are going on about the fact that install_page() can't be used on
>>>memory outside mem_map[] as it requires a page structure, and can't be
>>>used on reserved pages because page_add_file_rmap() will BUG. This case
>>>is not being discussed.
> 
> 
> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> 
>>And that it isn't allowed to touch struct page of physical pages
>>in a VM_RESERVED region.
> 
> 
> non sequitur
> 

Huh? That is why it is broken. Previously, PageReserved pages
*were not* accounted with the normal rmap and friends in core
code, so you can't just do it in here and hope it works.

> 
> William Lee Irwin III wrote:
> 
>>>The issue at stake is inserting normal pages into a VM_RESERVED vma.
>>>These will arise as e.g. kernel-allocated buffers managed by normal
>>>reference counting. remap_pfn_range() can't do it; it refuses to
>>>operate on "valid memory". install_page() now won't do it; it refuses
>>>to touch a VM_RESERVED vma. So this creates a giant semantic hole,
>>>and potentially breaks working code (i.e. if you were going to do
>>>this you would need not only a replacement but also a sweep to adjust
>>>all the drivers doing it or prove their nonexistence).
> 
> 
> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> 
>>I think you'll find that remap_pfn_range will be happy to operate
>>on valid memory, and that any driver trying to use install_page
>>on VM_RESERVED probably needs fixing anyway.
> 
> 
> install_page() of a !PageReserved() page in a VM_RESERVED vma is
> neither broken now nor does it merit going BUG().
> 

Hugh says it is broken, so you can ask him the details.

> /dev/mem was disallowed from mapping ordinary kernel memory for a
> reason (though I disagree with it), so the removal of the
> pfn_valid()/PageReserved() checks can't be blithely done like in
> your patch. Other arrangements must be made.
> 
> 
> William Lee Irwin III wrote:
> 
>>>Unfortunately for this scheme, it's very much a case of putting the
>>>cart before the horse. PG_reserved is toggled at random in this driver
>>>after this change, to no useful effect (debugging or otherwise). And
>>>this really goes for the whole affair. Diddling the core first is just
>>>going to create bugs. Converting the users first is the way these
>>>things need to be done. When complete, nothing needs the core flags
>>>twiddling anymore and you just nuke the flag twiddling from the core.
> 
> 
> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> 
>>I'm sorry, I don't see how 'diddling' the core will create bugs.
>>This is a fine way to do it, and "converting" users first (whatever
>>that means)
> 
> [cut text included in full in the following quote block]
> 
> This is going way too far. Someone please deal with this.
> 

No, just tell me how it might magically create bugs in drivers
that didn't exist in the first place?

> 
> On Fri, Jun 24, 2005 at 09:21:31AM +1000, Nick Piggin wrote:
> [continued]
> 
>>This is a fine way to do it, and "converting" users first (whatever
>>that means) is not possible because VM_RESERVED handling in core
>>code is not up to the task of replacing PageReserved without this
>>patch.
> 
> 
> You aren't replacing any of the PG_reserved usage with VM_RESERVED
> in any of these patches. The primary motive of all this is AFAICT
> little more than getting the PG_reserved check out of put_page(),
> drivers and arches be damned.
> 

Excuse me? drivers work, arches work.

And how might you "fix" them first, without the necessary core
code in place?

Send instant messages to your online friends http://au.messenger.yahoo.com 
