Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSA1WfH>; Mon, 28 Jan 2002 17:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSA1We6>; Mon, 28 Jan 2002 17:34:58 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:4743 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287287AbSA1Wel>;
	Mon, 28 Jan 2002 17:34:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Mon, 28 Jan 2002 23:39:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VHy5-0000Bz-00@starship.berlin> <3C55C39A.8040203@vitalstream.com>
In-Reply-To: <3C55C39A.8040203@vitalstream.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VKR5-0000DG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 10:33 pm, Rick Stevens wrote:
> Daniel Phillips wrote:
> [snip]
> 
> > I've been a little slow to 'publish' this on lkml because I wanted a 
working 
> > prototype first, as proof of concept.  My efforts to dragoon one or more 
of 
> > the notably capable kernelnewbies crowd into coding it haven't been 
> > particularly successful, perhaps due to the opacity of the code in 
question 
> > (pgtable.h et al).  So I've begun coding it myself, and it's rather slow 
> > going, again because of the opacity of the code.  Oh, and the difficult 
> > nature of the problem itself, since it requires understanding pretty much 
all 
> > of Unix memory management semantics first, including the bizarre (and 
useful) 
> > properties of process forking.
> > 
> > The good news is, the code changes required do fit very cleanly into the 
> > current design.  Changes are required in three places I've identified so
> > far:
> > 
> >   copy_page_range
> >     Intead of copying the page tables, just increment their use counts
> > 
> >   zap_page_range:
> >     If a page table is shared according to its use count, just decrement
> >     the use count and otherwise leave it alone.
> > 
> >   handle_mm_fault:
> >     If a page table is shared according to its use count and the faulting 
> >     instruction is a write, allocate a new page table and do the work 
> >     that would have normally been done by copy_page_range at fork time.
> >     Decrement the use count of the (perhaps formerly) shared page table.
> 
> 
> Perhaps I'm missing this, but I read that as the child gets a reference
> to the parent's memory.  If the child attempts a write, then new memory
> is allocated, data copied and the write occurs to this new memory.  As
> I read this, it's only invoked on a child write.

Notice that the word 'child' is only used in reference to the intial page 
directory copy.  After that things are symmetric with respect to parent and 
child, a fundamental simplification that allows the algorithm to work without 
explicit knowledge of the structure of the mm tree (and also simplifies the 
locking considerably).

> Would this not leave a hole where the parent could write and, since the
> child shares that memory, the new data would be read by the child?  Sort
> of a hidden shm segment?  If so, I think we've got problems brewing.
> Now, if a parent write causes the same behaviour as a child write, then
> my point is moot.
> 
> Could you clarify this for me?  I'm probably way off base here.

Since the page was copied to the child, the child's page table must be 
altered, and since it is shared, it must first be instantiated by the child.  
So after all the dust settles, the parent and child have their own copies of 
a page table page, which differ only at a single location: the child's page 
table points at its freshly made CoW copy, and the parent's page table points 
at the original page.

The beauty of this is, the page table could just as easily have been shared 
by a sibling of the child, not the parent at all, in the case that the parent 
had already instantiated its own copy of the page table page because of an 
earlier CoW.

Confused yet?  Welcome to the club ;-)

-- 
Daniel
