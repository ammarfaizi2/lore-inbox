Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUCLRXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbUCLRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:23:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262361AbUCLRXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:23:35 -0500
Date: Fri, 12 Mar 2004 12:23:22 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312171307.GA30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Fri, Mar 12, 2004 at 11:25:27AM -0500, Rik van Riel wrote:
> > pointing to a struct address_space with its anonymous
> > memory.  On exec() the mm_struct gets a new address_space,
> > on fork parent and child share them.
> 
> isn't this what anonmm is already doing? are you suggesting something
> different?

I am suggesting a pointer from the mm_struct to a
struct address_space ...

> > There's no difference between mremap() of anonymous memory
> > and mremap() of part of an mmap() range of a file...
> > 
> > At least, there doesn't need to be.
> 
> the anonmm simply cannot work because it's not reaching vmas, it only
> reaches mm, and with an mm and a virtual address you cannot reach the
> right vma if it was moved around by mremap,

... and use the offset into the struct address_space as
the page->index, NOT the virtual address inside the mm.

On first creation of anonymous memory these addresses
could be the same, but on mremap inside a forked process
(with multiple processes sharing part of anonymous memory)
a page could have a different offset inside the struct
address space than its virtual address....

Then on mremap you only need to adjust the start and
end offsets inside the VMAs, not the page->index ...

> That would be like anon_vma but it would not be finegriend like anon_vma
> is, you'll end up scanning very old vma segments in other address spaces

Not really.  On exec you can start with a new address
space entirely, so the sharing is limited only to
processes that really do share anonymous memory with
each other...

> I think my anon_vma is superior because more finegriend

Isn't being LESS finegrained the whole reason for moving
from pte based to object based reverse mapping ? ;))

> (it also avoids the need of a prio_tree even if in theory we could stack
> a prio_tree on top of every anon_vma, but it's really not needed)

We need the prio_tree anyway for files.  I don't see
why we couldn't reuse that code for anonymous memory,
but instead reimplement something new...

Having the same code everywhere will definately help
simplifying things.

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

