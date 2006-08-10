Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWHJMzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWHJMzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWHJMzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:55:42 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:46097 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161238AbWHJMzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:55:41 -0400
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1155147948.19249.171.camel@localhost.localdomain>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	 <20060807194159.f7c741b5.akpm@osdl.org>
	 <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
	 <200608080714.21151.ak@suse.de> <1155025073.26277.18.camel@localhost>
	 <20060809175854.GA14382@intel.com>
	 <1155147948.19249.171.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 10 Aug 2006 14:55:38 +0200
Message-Id: <1155214538.14749.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 11:25 -0700, Dave Hansen wrote: 
> Instead of:
> 
> #define pfn_to_section_nr(pfn) ((pfn) >> PFN_SECTION_SHIFT)
> 
> We could do:
> 
> static inline unsigned long pfn_to_section_nr(unsigned long pfn)
> {
> 	return some_hash(pfn) % NR_OF_SECTION_SLOTS;
> }
> 
> This would, of course, still have limits on how _many_ sections can be
> populated.  But, it would remove the relationship on what the actual
> physical address ranges can be from the number of populated sections.
> 
> Of course, it isn't quite that simple.  You need to make sure that the
> sparse code is clean from all connections between section number and
> physical address, as well as handling things like hash collisions.  We'd
> probably also need to store the _actual_ physical address somewhere
> because we can't get it from the section number any more.

You have to deal with the hash collisions somehow, for example with a
list of pages that have the same hash. And you have to calculate the
hash value. Both hurts performance.

> P.S. With sparsemem extreme, I think you can cover an entire 64-bits of
> address space with a 4GB top-level table.  If one more level of tables
> was added, we'd be down to (I think) an 8MB table.  So, that might be an
> option, too.

On s390 we have to prepare for the situation of an address space that
has a chunk of memory at the low end and another chunk with bit 2^63
set. So the mem_map array needs to cover the whole 64 bit address range.
For sparsemem, we can choose on the size of the mem_map sections and on
how many indirections the lookup table should have. Some examples:

1) flat mem_map array: 2^52 entries, 56 bytes each.
2) mem_map sections with 256 entries / 14KB for each section,
   1 indirection level, 2^44 indirection pointers, 128TB overhead
3) mem_map sections with 256 entries / 14KB for each section,
   2 indirection levels, 2^22 indirection pointers for each level,
   32MB for each indirection array, minimum 64MB overhead
4) mem_map sections with 256 entries / 14KB for each section,
   3 indirection levels, 2^15/2^15/2^14 indirection pointers,
   256K/256K/128K indirection arrays, minimum 640K overhead
5) mem_map sections with 1024 entries / 56KB for each section,
   3 indirection levels, 2^14/2^14/2^14 indirection pointers,
   128K/128K/128K indirection arrays, minimum 384KB overhead

2 levels of indirection results in large overhead in regard to memory.
For 3 levels of indirection the memory overhead is ok, but each lookup
has to walk 3 indirections. This adds cpu cycles to access the mem_map
array.

The alternative of a flat mem_map array in vmalloc space is much more
attractive. The size of the array is 2^52*56 Byte. 1,3% of the virtual
address space. The access doesn't change, an array gets accessed. The
access gets automatically cached by the hardware.
Simple, straightforward, no additional overhead. Only the setup of the
kernel page tables for the mem_map vmalloc area needs some thought.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


