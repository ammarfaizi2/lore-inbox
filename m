Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTIAKFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTIAKFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:05:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45193 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262787AbTIAKFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:05:14 -0400
Date: Mon, 1 Sep 2003 11:04:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901100458.GA1903@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030829230521.GD3846@matchmail.com> <20030830221032.1edf71d0.davem@redhat.com> <20030831224937.GA29239@mail.jlokier.co.uk> <20030831223102.3affcb34.davem@redhat.com> <20030901064231.GJ748@mail.jlokier.co.uk> <20030901000615.28d93760.davem@redhat.com> <20030901082911.GA1638@mail.jlokier.co.uk> <20030901020203.1779efe8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901020203.1779efe8.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Why do you need the same piece of data mapped to multiple places
> in the first place, and why at specific addresses?  It's purely an
> optimization of some sort, right?

Right.  It's a circular buffer for signal processing: DSP code sees
contiguous ascending addresses.  The multiple maps mean we don't have
to copy the contents of the buffer back to the start periodically, nor
mask the offset into the array on each memory access, nor write
extra-complicated DSP code which can handle split regions.

It's an optimisation, it works well on some architectures and on
others it's not worth it.  On those, I just copy - it keeps the DSP
code fast and simple.

> > Well, my code has no bug because I do run-time tests to see what
> > rubbish the architecture gave me.  As we see, they work :)
> 
> It doesn't work in just the right set of circumstances, if interrupts
> arrive at just the right moment it might flush the bad aliases out
> of the cache via displacement during your 'check' phase.
> 
> Then during your actual computation you can hit the aliasing problem
> silently.

To fool the coherence test, interrupts would need to arrive in a 2
instruction window, at least 8192 times.  It is possible, but unlikely
except in pathological situations.

Of course if you make mmap() return EINVAL then it cannot possible fail :)

> I'd suggest instead to hardcode the SHMLBA stuff into your sources.

How?  SHMLBA is a run time value on the Sparc; I have no idea how
to work it out.

-- Jamie

