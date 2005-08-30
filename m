Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVH3Pu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVH3Pu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVH3Pu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:50:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15522 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751446AbVH3Pu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:50:58 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: solving page table access attribute aliasing.
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<200508300412.55027.ak@suse.de>
	<m1br3gq71m.fsf_-_@ebiederm.dsl.xmission.com>
	<200508301714.35017.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 09:50:25 -0600
In-Reply-To: <200508301714.35017.ak@suse.de> (Andi Kleen's message of "Tue,
 30 Aug 2005 17:14:34 +0200")
Message-ID: <m1zmqzpgou.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 30 August 2005 08:21, Eric W. Biederman wrote:
>
>> Letting drivers/users decide is the interface we have now so
>> unless we wish to change the linux driver model we need to support
>> it.
>>
>> From this perspective I think the change should be quite simple.
>> We need a function:
>> verify_pfn_mapping(unsigned long pfn, unsigned long size, pgprot_t prot);
>> That performs the following checks, on every page:
>>
>>  - Is the page RAM with a struct page.  If so it must be mapped write
>>    back.  If we want anything else fail.
>>
>>  - If the pfn is not RAM and already mapped and do the caching
>>    attributes in pgprot_t match.  If we want anything else fail.
>>
>>  - If the pfn is not mapped, allow anything that is possible.
>
> I think we need an object with reference count here. Otherwise
> there is no way for two drivers to use the same region with the
> same attribute in a safe way.

Agreed.  For the kernel mapping we can potentially imposes a 1
ioremap rule.  Mappings to user space we very much need a reference
count, or to keep track of all mappings.  Which is why I like simply
using the existing vmas.  It makes establishing a new mapping
slow but effective.

>> For the case where we are dealing with physical addresses without a
>> struct page we need a space efficient way to get this information.
>> For each user mapping we already have a vm_area_struct so it makes
>> sense to keep all of them on a linked list so we can walk through them
>> and find any user space mappings for a pfn.  For the kernel mapping
>
> vma is space critical unfortunately. I don't think another list_head
> there will be popular. Separate tree is better.

We already have the list we just need an address space for I/O mappings,
like we have swapper_space for the swap cache.  I need to do a close
code review as a few things have changed since I was in there last but
I don't anticipate problems.  Fundamentally it just make sense that
we can add a logical backing store object, although there may be an
odd interaction with drivers calling remap_pfn_range, I need
to think about that one.

> That is an unrelated feature? 

On x86 yes as we don't allow this.  On sparc64 you can't check for aliases
if you don't grok huge pages.  So for the general case it may not be.

>> Unless I am hugely mistake every architecture that can set caching
>> attributes on the page tables needs this.
>
> Yes, some shared code might make sense.
>
>> I am going to sleep now and work on implementing this in the morning.
>
> I can code something up too. The main thing I'm not sure about 
> is what to do with existing MTRRs. The PATs will overrule them
> normally, so it would be tempting to just ignore, but we could still 
> effectively have an illegal alias if someone (SMM?) uses the mappings behind 
> our back.

SMM as I recall does use the page tables so we should be relatively
safe there.  The painful case then would be using memory that the
mttrs specify as write-back that we set to uncached in the page
tables.

> And interoperation with the X server that messes with mappings
> and MTRRs in user space freely also needs some thought.

I believe the X server always requests the kernel to perform the action
and does not actually perform it. 

As long as the kernel keeps the page tables in sync X should not be
able to cause us any problems.

Eric

