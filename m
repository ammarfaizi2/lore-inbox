Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTIBFeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbTIBFeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:34:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8842 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263502AbTIBFeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:34:18 -0400
Date: Tue, 2 Sep 2003 06:34:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902053415.GA7619@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901181148.C22682@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> >    1. That's not necessary when the virtual addresses are separated
> >       by some multiple, is it?
> 
> Incorrect - with a VIVT, you have alias hell.  There is no multiple
> which makes it safe.

Ok.  I guess I was thinking of VIPT, but by now I am just guessing :)

> > > I've tested on several silicon revisions of StrongARM-110's:
> > > - H appears buggy (reports as rev. 2)
> > > - K appears fine (reports as rev. 2)
> > > - S appears buggy (reports as rev. 3)
> > 
> > It's possible that all of them are buggy, but the write buffer test
> > doesn't manage to get writes into the buffer with the exact timing
> > needed to trigger it.
> 
> Well, I've just generated a kernel test which does more or less the
> same thing (write to one mapping, write to other, read from first.)
> This indicates the same result.
> 
> If you take a moment to think about what should be going on -
> 
> - first write gets translated to physical address, and the address with
>   the data is placed in the write buffer.
> - second write gets translated to the same physical address, and the
>   address and data is placed into the write buffer such that we store
>   the first write then the second write to the same physical memory.
> - reading from the first mapping should return the second writes value
>   no matter what.

That is an incomplete explanation, because it should never be possible
for reads to access data from the write buffer which isn't the most
recent.  That would break ordinary programs which don't have alias mappings.

> > Unfortunately, while the write buffer test does
> > pretty much guarantee a store/store/load instruction sequence, because
> > it's generic it can't guarantee how those are executed in a
> > superscalar or out of order pipeline.
> 
> ARM doesn't do any of those tricks.

Don't some of the ARMs executed two instructions concurrently, like
the original Pentium?  The simple test is only valid if a
store/store/load sequence is guaranteed to pass through the buggy part
of the pipeline in exactly the same way, no matter which programs it
appears in.

> > > So it seems your test program finds problems which DaveM's aliastest
> > > program fails to detect...  Gah. ;(
> > 
> > Well, it's good to know it was useful :/
> 
> Well, we now have a kernel test to detect the problem, which alters our
> behaviour appropriately.  Thanks.

Fwiw, PA-RISC shows a similar problem.

-- Jamie
