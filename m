Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTI2UK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTI2UK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:10:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16517 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264692AbTI2UK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:10:27 -0400
Date: Mon, 29 Sep 2003 21:08:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030929200820.GA23444@mail.jlokier.co.uk>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929174910.GA90905@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Ok, I added access_ok() checks when the fault came from ring 3 code.

That looks fine.

> >   2. segment_base sets "desc = (u32 *)&cpu_gdt_table[smp_processor_id()]".
> > 
> >      Pre-empt switches CPU.
> 
> True. Fixed.

Where is this fixed?

> > I think for completeness you should check the segment type and limit
> > too (because they can be changed, see 1.).  These are easier to check
> > than they look (w.r.t. 16 bit segments etc.): you don't have to decode
> > the descriptor; just use the "lar" and "lsl" instructions.
> 
> I don't want to do that, the code is already too complicated and I don't
> plan to reimplement an x86 here (just dealing with this segmentation
> horror is bad enough) 

I sympathise with that aversion :)

My concern is that, by being complicated enough to decode segments
when CS is not equal to either of those, you risk opening a loophole
where userspace can trick, if not the kernel (with the access_ok
checks), then surrounding userspace virtualisation due to this code in
the kernel.

My thinking: Segments can be used by x86 virtualising programs which
use a segment to move a "window" of address range accessible to the
virtualised code.  It should _never_ be possible for the virtualised
code, which may be malicious, to trigger reads outside the protected
address range by various combinations of threads and triggering LDT
modifications in the virtualiser.

Btw, you assume that regs->xcs is a valid segment value.  I think that
the upper 16 bits are not guaranteed to be zero in general on the
IA32, although they clearly are zero for the majority of IA-32 chips.
Are they guaranteed to be zero on AMD's processors?

> If it gets any more complicated I would be inclined to just
> handle the in kernel prefetches using __ex_table entries and give up
> on user space.

__ex_table entries would have been a less controversial fix all along :)

Perhaps it is better to just not decode at all when CS != __KERNEL_CS
&& CS != __USER_CS?  Just fault.

Then you can drop the segment code, which you don't like anyway.
Anything as sophisticated as x86 virtualisation in userspace can fixup
spurious faults itself.  (That isn't perfect, but it's imperfect in a
safe way).

If you want to keep the segment base code, then I'll work out a patch
on top of yours to do the right access checks.  It is quite small, I
nearly have it already.

> The x86-64 version just ignores all bases, that should be fine
> too. Anybody who uses non zero code segments likely doesn't care about
> performance and won't use prefetch ;-)

Does the x86-64 version ignore bases in 32 bit programs?

-- Jamie
