Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTI3FuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTI3FuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:50:03 -0400
Received: from colin2.muc.de ([193.149.48.15]:58637 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263114AbTI3Ft7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:49:59 -0400
Date: 30 Sep 2003 07:50:11 +0200
Date: Tue, 30 Sep 2003 07:50:11 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030930055011.GB75928@colin2.muc.de>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de> <20030929200820.GA23444@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929200820.GA23444@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 09:08:20PM +0100, Jamie Lokier wrote:
> My thinking: Segments can be used by x86 virtualising programs which
> use a segment to move a "window" of address range accessible to the
> virtualised code.  It should _never_ be possible for the virtualised
> code, which may be malicious, to trigger reads outside the protected
> address range by various combinations of threads and triggering LDT
> modifications in the virtualiser.

Agreed. But access_ok() takes care of that. It does not guarantee
that the right instruction is checked, but whoever uses non zero
code segment bases can add their own checker or more likely
not use prefetch at all (it is likely ancient legacy code 
code anyways). 

> Btw, you assume that regs->xcs is a valid segment value.  I think that
> the upper 16 bits are not guaranteed to be zero in general on the
> IA32, although they clearly are zero for the majority of IA-32 chips.
> Are they guaranteed to be zero on AMD's processors?

That would be new to me. Can you quote a line that says that from
the architecture manual?

Also remember the code only runs on AMD.

> > If it gets any more complicated I would be inclined to just
> > handle the in kernel prefetches using __ex_table entries and give up
> > on user space.
> 
> __ex_table entries would have been a less controversial fix all along :)
> 
> Perhaps it is better to just not decode at all when CS != __KERNEL_CS
> && CS != __USER_CS?  Just fault.

Yep, I considered that too.

I think I will do that for x86-64 and 32bit can handle it all in 
user space as I suspect the patch is unmergeable anyways.

> > The x86-64 version just ignores all bases, that should be fine
> > too. Anybody who uses non zero code segments likely doesn't care about
> > performance and won't use prefetch ;-)
> 
> Does the x86-64 version ignore bases in 32 bit programs?

The CPU doesn't, the prefetch fix does.

I will add a check for __USER32_CS/__USER_CS and __KERNEL_CS to make
sure it will never wrap.

I'm dropping the original segment checking/code checking proposal for 32bit. 
It obviously was misguided and Linus was right from the beginning 
to reject it.

-Andi
