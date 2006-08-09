Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHIS0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHIS0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHIS0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:26:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:43432 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751295AbWHIS0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:26:02 -0400
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
From: Dave Hansen <haveblue@us.ibm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060809175854.GA14382@intel.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	 <20060807194159.f7c741b5.akpm@osdl.org>
	 <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
	 <200608080714.21151.ak@suse.de> <1155025073.26277.18.camel@localhost>
	 <20060809175854.GA14382@intel.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:25:48 -0700
Message-Id: <1155147948.19249.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 10:58 -0700, Luck, Tony wrote:
> On Tue, Aug 08, 2006 at 10:17:53AM +0200, Martin Schwidefsky wrote:
> > "vmalloc reserve first; allocate pages later" would be a really nice
> > feature. We could use this on s390 to implement the virtual mem_map
> > array spanning the whole 64 bit address range (with holes in it). To
> > make it perfect a "deallocate pages; keep vmalloc reserve" should be
> > added, then we could free parts of the mem_map array again on hot memory
> > remove. 

Martin,

We can already do this partial freeing today with sparsemem and memory
hot-remove.  It would be a shame to go have to do another implementation
for each an every architecture that wants to do it.

For the very sparse 64-bit address spaces, I would be really interested
to see an alternate pfn_to_section_nr() that relies on something other
than a direct correlation between physical address and section number.

Instead of:

#define pfn_to_section_nr(pfn) ((pfn) >> PFN_SECTION_SHIFT)

We could do:

static inline unsigned long pfn_to_section_nr(unsigned long pfn)
{
	return some_hash(pfn) % NR_OF_SECTION_SLOTS;
}

This would, of course, still have limits on how _many_ sections can be
populated.  But, it would remove the relationship on what the actual
physical address ranges can be from the number of populated sections.

Of course, it isn't quite that simple.  You need to make sure that the
sparse code is clean from all connections between section number and
physical address, as well as handling things like hash collisions.  We'd
probably also need to store the _actual_ physical address somewhere
because we can't get it from the section number any more.

But, Andy and I have talked about this kind of thing from the beginning
of sparsemem, so I hope the code is amenable to change like this.

-- Dave

P.S. With sparsemem extreme, I think you can cover an entire 64-bits of
address space with a 4GB top-level table.  If one more level of tables
was added, we'd be down to (I think) an 8MB table.  So, that might be an
option, too.

