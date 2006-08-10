Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWHJOm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWHJOm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWHJOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:42:26 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:14097 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161274AbWHJOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:42:25 -0400
Message-ID: <44DB4547.80007@shadowen.org>
Date: Thu, 10 Aug 2006 15:40:07 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Dave Hansen <haveblue@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>	 <20060807194159.f7c741b5.akpm@osdl.org>	 <17624.7310.856480.704542@cargo.ozlabs.ibm.com>	 <200608080714.21151.ak@suse.de> <1155025073.26277.18.camel@localhost>	 <20060809175854.GA14382@intel.com>	 <1155147948.19249.171.camel@localhost.localdomain> <1155214538.14749.54.camel@localhost>
In-Reply-To: <1155214538.14749.54.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Wed, 2006-08-09 at 11:25 -0700, Dave Hansen wrote: 
>> Instead of:
>>
>> #define pfn_to_section_nr(pfn) ((pfn) >> PFN_SECTION_SHIFT)
>>
>> We could do:
>>
>> static inline unsigned long pfn_to_section_nr(unsigned long pfn)
>> {
>> 	return some_hash(pfn) % NR_OF_SECTION_SLOTS;
>> }
>>
>> This would, of course, still have limits on how _many_ sections can be
>> populated.  But, it would remove the relationship on what the actual
>> physical address ranges can be from the number of populated sections.
>>
>> Of course, it isn't quite that simple.  You need to make sure that the
>> sparse code is clean from all connections between section number and
>> physical address, as well as handling things like hash collisions.  We'd
>> probably also need to store the _actual_ physical address somewhere
>> because we can't get it from the section number any more.
> 
> You have to deal with the hash collisions somehow, for example with a
> list of pages that have the same hash. And you have to calculate the
> hash value. Both hurts performance.
> 
>> P.S. With sparsemem extreme, I think you can cover an entire 64-bits of
>> address space with a 4GB top-level table.  If one more level of tables
>> was added, we'd be down to (I think) an 8MB table.  So, that might be an
>> option, too.
> 
> On s390 we have to prepare for the situation of an address space that
> has a chunk of memory at the low end and another chunk with bit 2^63
> set. So the mem_map array needs to cover the whole 64 bit address range.
> For sparsemem, we can choose on the size of the mem_map sections and on
> how many indirections the lookup table should have. Some examples:
> 
> 1) flat mem_map array: 2^52 entries, 56 bytes each.
> 2) mem_map sections with 256 entries / 14KB for each section,
>    1 indirection level, 2^44 indirection pointers, 128TB overhead
> 3) mem_map sections with 256 entries / 14KB for each section,
>    2 indirection levels, 2^22 indirection pointers for each level,
>    32MB for each indirection array, minimum 64MB overhead
> 4) mem_map sections with 256 entries / 14KB for each section,
>    3 indirection levels, 2^15/2^15/2^14 indirection pointers,
>    256K/256K/128K indirection arrays, minimum 640K overhead
> 5) mem_map sections with 1024 entries / 56KB for each section,
>    3 indirection levels, 2^14/2^14/2^14 indirection pointers,
>    128K/128K/128K indirection arrays, minimum 384KB overhead
> 
> 2 levels of indirection results in large overhead in regard to memory.
> For 3 levels of indirection the memory overhead is ok, but each lookup
> has to walk 3 indirections. This adds cpu cycles to access the mem_map
> array.
> 
> The alternative of a flat mem_map array in vmalloc space is much more
> attractive. The size of the array is 2^52*56 Byte. 1,3% of the virtual
> address space. The access doesn't change, an array gets accessed. The
> access gets automatically cached by the hardware.
> Simple, straightforward, no additional overhead. Only the setup of the
> kernel page tables for the mem_map vmalloc area needs some thought.
> 

Well you could do something more fun with the top of the address.  You 
don't need to keep the bytes in the same order for instance.  If this is 
really a fair size chunk at the bottom and one at the top then taking 
the address and swapping the bytes like:

	ABCDEFGH => BCDAEFGH

Would be a pretty trivial bit of register wibbling (ie very quick), but 
would probabally mean a single flat, smaller sparsemem table would cover 
all likely areas.

-apw
