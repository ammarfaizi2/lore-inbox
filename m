Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUCLSWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbUCLSTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:19:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:17877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbUCLSTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:19:16 -0500
Date: Fri, 12 Mar 2004 10:25:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0403120956370.1045@ppc970.osdl.org>
References: <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Mar 2004, Rik van Riel wrote:
> 
> I am suggesting a pointer from the mm_struct to a
> struct address_space ...

[ deleted ]

> Then on mremap you only need to adjust the start and
> end offsets inside the VMAs, not the page->index ...

One fundamental problem I see, maybe you can explain it to me...

 - You need a _unique_ page->index start for each VMA, since each
   anonymous page needs to have a unique index. Right?
 - You can use the virtual address as that unique page index start
 - when you mremap() an area, you leave the start indexes the same, so 
   that you can find the original pages (and create new ones in the old 
   mapping) by just searching the vma's, not by actually looking at the 
   page tables.
 - HOWEVER, after a mremap(), when you now create a new vma (or expand an 
   old one) into the previously used page index area, you're now screwed. 
   How are you going to generate unique page indexes in this new area 
   without re-using the indexes that you allocated in the old (moved)  
   area?

I think your approach could work (reverse map by having separate address
spaces for unrelated processes), but I don't see any good "page->index"  
allocation scheme that is implementable.

The "unique" page->index thing wouldn't need to have to have anything to 
do with the virtual address (indeed, after a mremap it clearly cannot have 
anything to do with that), but the thing is, you'd need to be able to 
cover the virtual address space with whatever numbers you choose.

You'd want to allocate contiguous indexes within one "vma", since the
whole point would be to be able to try to quickly find the vma (and thus
the page) that contains one particular page, but there are no range
allocators that I can think of that allow growing the VMA after allocation
(needed for vma merging on mmap and brk()) and still keep the range of
indexes down to reasonable numbers.

Or did I totally mis-understand what you were proposing?

		Linus
