Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTJDOet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTJDOes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 10:34:48 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:15509 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262060AbTJDOer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 10:34:47 -0400
Date: Sat, 04 Oct 2003 07:32:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Oeser <ioe-lkml@rameria.de>, Russell King <rmk@arm.linux.org.uk>
cc: Andi Kleen <ak@muc.de>, Joe Korty <joe.korty@ccur.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <19820000.1065277957@[10.10.2.4]>
In-Reply-To: <200310041202.08742.ioe-lkml@rameria.de>
References: <CFYv.787.23@gated-at.bofh.it> <20031004091703.GB23306@colin2.muc.de> <20031004102221.A18928@flint.arm.linux.org.uk> <200310041202.08742.ioe-lkml@rameria.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > pfn_valid is useless, it doesn't handle all IO holes on x86 for examples.
>> 
>> Sounds like pfn_valid() is buggy on x86.  It's supposed to definitively
>> indicate whether the PFN is a valid page of ram (and has a valid struct
>> page entry.)  If it doesn't do that, the architecture implementation is
>> wrong.
> 
> Looks like it. But it also has to be fast (see include/asm-i386/mmzone.h) 
> and doesn't even hide the holes in NUMA machines. 

There are no holes between nodes for any i386 NUMA machines at the moment,
and we don't free back the struct pages for internal holes yet. So we have
pfn_valid set up for i386 such that there's a valid struct page if pfn_valid
is true.
 
> We had a page_is_ram() for this somewhere. I don't know, why this is
> gone. It would be useful in other places as well.
> 
> If the page_is_ram() test could be done using the vma only now, this
> would be even better and should be called vma_is_ram() to generalize
> these corner cases (today and in the future) and make more
> clear what these kind of tests want to do.

page_is_ram is defined in arch/i386/mm/init.c:

static inline int page_is_ram(unsigned long pagenr)
{
        int i;

        for (i = 0; i < e820.nr_map; i++) {
                unsigned long addr, end;

                if (e820.map[i].type != E820_RAM)       /* not usable memory */
                        continue;
                /*
                 *      !!!FIXME!!! Some BIOSen report areas as RAM that
                 *      are not. Notably the 640->1Mb area. We need a sanity
                 *      check here.
                 */
                addr = (e820.map[i].addr+PAGE_SIZE-1) >> PAGE_SHIFT;
                end = (e820.map[i].addr+e820.map[i].size) >> PAGE_SHIFT;
                if  ((pagenr >= addr) && (pagenr < end))
                        return 1;
        }
        return 0;
}

However, we probably want a runtime one that checks some aspect of
the struct page itself to see whether it's a valid memory page or not.

I believe it's useful to have the faster and slower tests still.
Most things using pfn_valid seem to be doing it before a pfn_to_page
translation to check it's safe, and we still seem to have that correct.
pfn_has_struct_page or something might be a better name, but still.

M.
