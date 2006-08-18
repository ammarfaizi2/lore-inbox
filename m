Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWHRGSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWHRGSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWHRGSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:18:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7628 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750745AbWHRGSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:18:23 -0400
Date: Thu, 17 Aug 2006 23:17:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <44E3FC4F.2090506@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, Manfred Spraul wrote:

> I'm not sure that the current approach with virt_to_page()/vmalloc_to_page()
> is the right thing(tm): Both functions are slow.

I am not so sure.

C code

typedef union ia64_va {
        struct {
                unsigned long off : 61;         /* intra-region offset */
                unsigned long reg :  3;         /* region number */
        } f;
        unsigned long l;
        void *p;
} ia64_va;

#define __pa(x)         ({ia64_va _v; _v.l = (long) (x); _v.f.reg = 0; _v.l;})
#define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
# define pfn_to_page(pfn)       (vmem_map + (pfn))


Here is a disassembly of kfree() (just relevant instructions, compiler
creates a mess and wastes scores of instructions repeating the same 
thing about 3 times due to the failure to properly optimize (gcc 3.3) the
debugging crud in the existing slab):

0xa000000100144850 <kfree+48>:  [MII]       addl r11=-1995424,r1

					r11 = &vmem_map

0xa000000100144870 <kfree+80>:  [MII]       mov r10=r11

					r10 = &vmem_map

0xa000000100144881 <kfree+97>:              ld8 r18=[r10]

					r18 = [vmem_map] 

0xa000000100144890 <kfree+112>: [MMI]       shladd r16=r3,3,r18;;
0xa000000100144891 <kfree+113>:             ld4.acq r2=[r16]

			struct page * =	r16 = vmem_map + pfn
					r2 = flags;

0xa0000001001448a0 <kfree+128>: [MII]       nop.m 0x0
0xa0000001001448a1 <kfree+129>:             tbit.z p8,p9=r2,14;;

				if(PageCompound(page))
						.....

(And some more crud: A useless check for PageCompound (in the hot path!) 
although page compound is not used for higher order slabs (only for non 
MMU arches))

So we only have a single lookup of vmem_map from memory in order to 
calculate the address of struct page. The cacheline for vmem_map is 
heavily used and certainly in memory. virt_to_page seems to be a very 
efficient means to get to struct page. The problem scope may simply be
to minimize the cachelines touched during free and alloc.

vmalloc_to_addr is certainly slower due to the page table walking. But the 
user already is aware of the fact that vmalloc memory is not as fast as
direct mapped.

