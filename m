Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbTIDWuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbTIDWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:50:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:11917 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265596AbTIDWuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:50:13 -0400
Date: Thu, 4 Sep 2003 23:50:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030904225001.GM31590@mail.jlokier.co.uk>
References: <20030901082911.GA1638@mail.jlokier.co.uk> <20030901020203.1779efe8.davem@redhat.com> <bj58r9$85p$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bj58r9$85p$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> | Why do you need the same piece of data mapped to multiple places
> | in the first place, and why at specific addresses?  It's purely an
> | optimization of some sort, right?
> 
> I think he said he was doing DSP... there's a trick of double mapping
> the same memory to save one subscript calculation in FFT (or maybe DFT)
> inner loop.

It is for DSP, but nothing to do with FFT.  I hadn't ever thought of
using this techinque for FFT, and it would probably make little
difference on a modern CPU given the form of FFT algorithms.

No, I use it to make a circular buffer, in which the data always
appears as a contiguous block - no split.  This is useful for
operations on streams of data, such as FIR & IIR filters, equalisers,
upconverters, downcoverters, etc.  Many DSP algorithms fall into this
category.

A characteristic of these algorithms is that they consist of a long,
tight sequence of streaming memory accesses with calculations at each
step.

DSP chips often implement circular buffers by masking the offset into
the buffer's memory.

On a CPU, I prefer to avoid the masking operation which happens for
each address calculation.  This saves a couple of registers, as I can
just use an incrementing pointer into the buffer, rather than a base
address, offset and mask value.  Especially on x86, a couple of
registers saved is good.

It's possible to write DSP algorithms which avoid address masking,
after all a circular buffer in an ordinary array is just two separate
regions.  But that complicates the algorithms especially with corner
cases, and some of them are complicated enough already.

Using the duplicate mappings, I can use the most straightforward
streaming DSP code, and it runs as fast as possible if the mappings
don't incur a penalty.

When mappings aren't available or are too slow, then I just copy the
contents of the buffer backwards whenever the write pointer will cross
the end of the array.  That costs some, but keeps the DSP code simple.

Fwiw, the test program asseses whether there's a cost to using
duplicate mappings and whether they work.  However, for the above kind
of DSP buffer, the measurement isn't the best it could be (although
it's what I'm using).  There's a balance of factors.  For a large
buffer, it's ok even if page faults were to be needed as we switch
between alias pages, because the access pattern doesn't do that very
often.  Then the occasional page faults are just a potentially faster
version of the copy backwards.  On the other hand, if aliased pages
are made coherent by making then uncacheable (such as the ARM port),
even though that's much faster than faulting, it isn't good for the
DSP algorithms.

Fwiw#2, in the DSP I'm working on it's better to use the copying
method for most of my buffers even on x86, because they aren't that
large and fit better into L1 cache without the mappings.  Maybe for a
different project, it will get used for more of the buffers.  Mainly,
having developed the testing code, I wanted to know if it worked
properly on the different architectures.  It's nice to see some spin
offs, such as finding the ARM write buffer bug.

So thanks to everyone who responded.  I'll post a table of the results
soon.

Thanks,
-- Jamie
