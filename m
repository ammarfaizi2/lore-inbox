Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSAUN6K>; Mon, 21 Jan 2002 08:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAUN6A>; Mon, 21 Jan 2002 08:58:00 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:27783 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286263AbSAUN5u>;
	Mon, 21 Jan 2002 08:57:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman),
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Linux 2.4.18pre3-ac1
Date: Mon, 21 Jan 2002 15:02:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201210333460.32617-100000@imladris.surriel.com> <m1zo38faql.fsf@frodo.biederman.org>
In-Reply-To: <m1zo38faql.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Sf1h-0001gX-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 08:01 am, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> > On Sun, 20 Jan 2002, Richard Gooch wrote:
> > 
> > > Will lazy page table instantiation speed up fork(2) without rmap?
> > > If so, then you've got a problem, because rmap will still be slower
> > > than non-rmap. Linus will happily grab any speedup and make that the
> > > new baseline against which new schemes are compared :-)
> 
> But the differences will go down to the noise level.  Your average fork
> shouldn't need to copy more than one page.  So the amount of work is
> near constant. 

In fact there's no difference at all at fork time since the instantiation 
work is defered to page fault time.

> > I guess the difference here is "optimised for lmbench"
> > vs. "optimised to be stable in real workloads"  ;)
> 
> Currently the rmap patch triples the size of the page tables which is
> also an issue.  Though it is relatively straight forward to reduce
> that to simply double the page table size with a order(1) allocation,
> so we can remove one pointer.

As Rik pointed out, the overhead isn't per pte, it's 8 bytes per mapped page 
plus 4 bytes per physical page.

This can be reduced to just 4 bytes per physical page in the case of 
nonshared pages, and the shared case the 8 bytes per mapped page can be 
reduced by various strategies.  Even as it stands it's not too bad.

> Unless I am mistaken an every day shell script is fairly fork/exec/exit
> intensive operation.  And there are probably more shell scripts for
> unix than every other kind of program put together.
> 
> An additional possible strike against rmap is that walking through
> page tables in virtual address order is fairly cache friendly, while a
> random walk has more of a cache penalty.

Yes.  I've proposed a small optimization where each pte_chain link points to 
several ptes, reducing the cache penalty for the pte chain walk.  Improving 
the locality of the pte accesses themselves is not as easy since that would 
require the lru list would need to be in non-random order with respect to 
ptes, and I don't know any simple way to do that.  I also think it doesn't 
matter much since this overhead is incurred only when we are doing heavy 
scanning of the ptes, and we are only doing that when we are under heavy 
memory pressure.  In theory, the cost of the extra cache hits will be
drowned out by the savings from improved page replacement decisions.  Of 
course, this remains to be seen.

> One more case that is difficult for rmap is the highly mapped case of 
> something like glibc.  You can easily get to a thousand entries or
> more for a single page.  In which case a doubly linked list may be
> more appropriate then a singly linked list (for add/insert), but this
> again tripples or quadruples the page table size.  And none of it
> solves having to walk very long lists in some circumstances.   The
> best you can do is periodically unmapping pages, and then you only
> have very long lists for highly active pages.

It's likely that many of the page tables referring to glibc can be shared as 
well.  This is a somewhat different problem than the lazy instantiation, but 
looks tractable to me.  Without such sharing there are various things that 
can be done to reduce the list maintainance overhead.  Such long lists can be 
special-cased for example, so that you would go to a double-linked list or a 
tree only when sharing exceeds some threshold.

> And to be fair rmap has some advantages over the current system.  VM
> algorithms are some simpler to code when you can code them however
> you want to, instead of being constrained by other parts of the
> implementation.

Virtual scanning has a fundamental disadvantage in comparison to reverse 
mapping: there is a large and unpredictable lag between the time a pte's 
accessed bit is transfered to a physical page and when it is queried during 
the physical scan.  Thus, virtual scanning does not scale well, because as 
memory size increases the age of the accessed information in the physical 
page becomes increasingly random.  There is no simple way to partition the 
virtual scan by physical region to reduce this lag.  Though this is far from 
the only problem with virtual scanning, in the long run it's the killer.

--
Daniel
