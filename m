Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbTIJXhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266046AbTIJXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:37:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21137 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266045AbTIJXh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:37:27 -0400
Date: Thu, 11 Sep 2003 00:37:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030910233720.GA25756@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910233951.Q30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> >     CPUs with incoherent write buffers: PA-RISC 2.0, 68040 and ARMs.
> 
> Some StrongARM CPUs seem to exhibit non-coherence in their write buffers.
> I don't think we've done enough testing to make any statement like "ARMs
> have uncoherent write buffers."

It should be read as "some ARMs", as in you can't rely on an ARM
userspace having coherent write buffers unless you know you're using
the right chip _or_ the right kernel.

Similarly we don't know that all PA-RISCs or all 68040s have
incoherent write buffers, we just know that some of them do.

> >     SHMLBA not valid:		ARM, m68k
> > 
> > Note that "SHMLBA" is defined for some architectures on which it
> > doesn't actually provide coherent virtual aliases.  On the ARM this is
> > believed to be due to a chip bug, and very recent kernels may contain
> > a workaround for it (disabling the write buffer for aliased pages).
> 
> Not correct.  Because of the fundamental nature of VIVT caches, there
> is no "SHMLBA" value which prevents aliases occuring.  Think carefully
> about the structure of a VIVT cache and how it would be searched.  This
> isn't a chip bug.

I am describing coherence seen by the application.  That is a function
of the kernel, not the chip.  I'll make that clearer in any next
revision of the document.

The kernel can make virtual aliases coherent on _any_ CPU, using
software techniques if necessary.

Therefore the VIVT cache is not something the application cares about.
It's irrelevant, an implementation detail for the kernel to handle.
In this case, by making aliased pages uncacheable.  The application
only cares whether the pages appear coherent, and how fast that is.

The unexpected chip behaviour is the reason why the (old) ARM kernel
doesn't succesfully make alias appear coherent.

> The kernel works around this, but, due to some bugs on StrongARM chips
> in the write buffer, it appears that we need further work-arounds, which
> are already implemented.

In other words, there _is_ an SHMLBA value which prevents alias
incoherence on the ARM, because the kernel implements a workaround, if
it's a recent kernel.  That value is one page.

I put ARM in the "don't rely on this" category simply because there
are older kernels in use which don't have the correct workaround.
Otherwise, I would have said ARM has a reliable SHMLBA, of one page.
To the application, this is correct.

There is one thing which puzzles me.  The ARM test program outputs
I've been sent say that the cache is incoherent, _not_ just the write
buffers.  You said you have results which report write buffers, but I
don't have those in detail, only descriptions.

Does your fix, which makes pages uncacheable andq disables write
combining (correct?) only fix your test results which intermittently
reported write buffer problems, or does it fix _all_ the ARM test
results I received, including those which don't report write buffer
problems?

If the former, then I have to say that ARM Linux _in general_ still
doesn't have coherent virtual aliases.  If they are all fixed, then
there's a flaw in the test program because it should have been
reporting write buffer problems, not general cache incoherence.

Thanks,
-- Jamie
