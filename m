Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278225AbRJMBIR>; Fri, 12 Oct 2001 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278229AbRJMBH5>; Fri, 12 Oct 2001 21:07:57 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:34573 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278225AbRJMBHw>;
	Fri, 12 Oct 2001 21:07:52 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15303.37865.489986.425653@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 11:07:53 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com>
In-Reply-To: <20011012150606.5d522fda.rusty@rustcorp.com.au>
	<Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> So how about just going all the way and calling it what it is:
> "data_dependent_read_barrier()", with a notice in the PPC docs about how
> the PPC cannot speculate reads anyway, so it's a no-op.

To set the record straight, the PPC architecture spec says that
implementations *can* speculate reads, but they have to make it look
as if dependent loads have a read barrier between them.

And it isn't speculated reads that are the problem in the alpha case,
it's the fact that the cache can reorder invalidations that are
received from the bus.  That's why you can read the new value of p but
the old value of *p on one processor after another processor has just
done something like a = 1; wmb(); p = &a.

My impression from what Paul McKenney was saying was that on most
modern architectures other than alpha, dependent loads act as if they
have a read barrier between them.  What we need to know is which
architectures specify that behaviour in their architecture spec, as
against those which do that today but which might not do it tomorrow.

I just looked at the SPARC V9 specification; it has a formal
definition of the memory model which precludes reordering dependent
loads (once again this is an "as if" rule).  So on ppc and sparc64 we
have an assurance that we won't need an rmb() between dependent loads
in the future.

As for intel x86, is there a architecture spec that talks about things
like memory ordering?  My impression is that the x86 architecture is
pretty much defined by its implementations but I could well be wrong.

> too. It's not as if we should ever have that many of them, and when we
> _do_ have them, they might as well stand out to make it clear that we're
> doing subtle things.. Although that "data-dependent read barrier" is a lot
> more subtle than most.

Indeed...  getting the new p but the old *p is quite
counter-intuitive IMHO.

Paul.
