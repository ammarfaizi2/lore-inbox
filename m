Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283468AbRLMG3p>; Thu, 13 Dec 2001 01:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283489AbRLMG3f>; Thu, 13 Dec 2001 01:29:35 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:59540 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S283468AbRLMG3U>; Thu, 13 Dec 2001 01:29:20 -0500
Date: Wed, 12 Dec 2001 22:28:41 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <BCF5AF03A80@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0112122156150.19090-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Petr Vandrovec wrote:

> On 12 Dec 01 at 12:02, Wayne Whitney wrote:
> 
> > o Pick a maximum stack size S and change the kernel so the "mmap()
> >   without MAP_FIXED" region starts at 0xC0000000 - S and grows downwards. 
> 
> How you'll pick S? 8MB? 128MB? 

Well, Mark Hahn suggests using the stack ulimit.  On my bog standard
RedHat 7.2, ulimit -a tells me the stack size limit is 8MB.  Of course,
once an mmap() (sans MAP_FIXED) has occurred, you can't increase S, so a
program that wants more stack would have to ensure that the ulimit is set
before calling mmap().

> Now you can have 1GB brk + 2GB (stack+mmap), after change you have
> 2.9GB (brk+mmap), but only 128MB stack.

My (very limited) experience suggests that of the stack, mmap and brk
regions, stack is likely the smallest.  So if one of the three has to have
a predetermined maximum size, and the other two are allowed to grow toward
each other from opposite ends of address space, it seems the stack should
have the fixed size, not brk.

> Another problem is mremap. Due to way how apps works, you'll have to
> move VMAs around much more because of you cannot grow your last VMA up
> without move. And if you shrink your last block, you'll get a gap.

Right now, growing any VMA other than the last requires relocating, and
shrinking any VMA other than the last will cause gaps.  How big a hit
would it be to remove the exception for the last VMA, so that any VMA
growth requires relocation, and any VMA shrink leaves a gap?  Are there
applications that rely on cheap growth and shrinkage of the most recently
allocated VMA (when there have been deletions and MAP_FIXED mmap()s)?

> Nobody can call brk() directly from app, as libc may use brk() for
> implementing malloc(), and libraries can call malloc.  So you have to
> create your own allocator on the top of brk() results, and this
> allocator must not release memory back to system, as this could
> release also chunks you do not own.  Writting your allocator on the
> top of malloc()ed areas is much better idea.

Assuming the overhead of malloc() is low, I agree that in writing a new
program one would be better off writing an allocator over malloc() than
over brk().  But there are plenty of legacy programs that use brk(), which
may be hard to port to a malloc()-based allocator, or available to some
users only as binaries.

So there is a tradeoff between changing the programs and changing the
kernel.  I'm trying to figure out how expensive the requisite kernel
changes would be.  For example, I don't grok the structure that holds the
VMAs, I think it is in some sense sorted by increasing start address.  So
if one were to change mmap() to allocate VMAs going downward, would it be
appropriate to change the VMA containment structure to be sorted by
decreasing start address?

BTW, if one were trying to port some code that uses brk() directly and
even frees memory that way, then it seems that with glibc's malloc(), one
could make it work by instructing malloc() always to use mmap().

Cheers, Wayne

P.S.  I am 100% sure that the particular application of mine that started
me thinking about this, MAGMA, uses its own allocator built on top of
brk() and never calls malloc() itself.

