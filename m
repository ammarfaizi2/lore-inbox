Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289090AbSAUHF2>; Mon, 21 Jan 2002 02:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSAUHFT>; Mon, 21 Jan 2002 02:05:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30285 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289086AbSAUHFJ>; Mon, 21 Jan 2002 02:05:09 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <Pine.LNX.4.33L.0201210333460.32617-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jan 2002 00:01:54 -0700
In-Reply-To: <Pine.LNX.4.33L.0201210333460.32617-100000@imladris.surriel.com>
Message-ID: <m1zo38faql.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sun, 20 Jan 2002, Richard Gooch wrote:
> 
> > Will lazy page table instantiation speed up fork(2) without rmap?
> > If so, then you've got a problem, because rmap will still be slower
> > than non-rmap. Linus will happily grab any speedup and make that the
> > new baseline against which new schemes are compared :-)

But the differences will go down to the noise level.  Your average fork
shouldn't need to copy more than one page.  So the amount of work is
near constant. 
 
> I guess the difference here is "optimised for lmbench"
> vs. "optimised to be stable in real workloads"  ;)

Currently the rmap patch triples the size of the page tables which is
also an issue.  Though it is relatively straight forward to reduce
that to simply double the page table size with a order(1) allocation,
so we can remove one pointer.

Unless I am mistaken an every day shell script is fairly fork/exec/exit
intensive operation.  And there are probably more shell scripts for
unix than every other kind of program put together.

An additional possible strike against rmap is that walking through
page tables in virtual address order is fairly cache friendly, while a
random walk has more of a cache penalty.

One more case that is difficult for rmap is the highly mapped case of 
something like glibc.  You can easily get to a thousand entries or
more for a single page.  In which case a doubly linked list may be
more appropriate then a singly linked list (for add/insert), but this
again tripples or quadruples the page table size.  And none of it
solves having to walk very long lists in some circumstances.   The
best you can do is periodically unmapping pages, and then you only
have very long lists for highly active pages.

And to be fair rmap has some advantages over the current system.  VM
algorithms are some simpler to code when you can code them however
you want to, instead of being constrained by other parts of the
implementation.

To the true sceptic what remains to be shown is 

Eric
