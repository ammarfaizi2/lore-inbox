Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWIKJSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWIKJSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWIKJSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:18:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:37543 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751283AbWIKJSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:18:45 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1157965071.23085.84.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 19:17:49 +1000
Message-Id: <1157966269.3879.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 09:57 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 14:03 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > be interleaved when reaching the host PCI controller (and thus the
> 
> "a host PCI controller". The semantics with multiple independant PCI
> busses are otherwise evil.

Ok.

> >  1- {read,write}{b,w,l,q} : Those accessors provide all MMIO ordering
> > requirements. They are thus called "fully ordered". That is #1, #2 and
> > #4 for writes and #1 and #3 for reads. 
> 
> #4 may be incredibly expensive on NUMA boxes.

Yes, and that's why there is Question #2 :)

I don't care either way for PowerPC at this point, but it's an open
question and I'd like folks like you to tell me what you prefer.

> >  3- memcpy_to_io, memcpy_from_io: #1 semantics apply (all MMIO loads or
> > stores are performed in order to each other). #2+#4 (stores) or #3
> 
> What is "in order" here. "In ascending order of address" would be
> tighter.

In program order. Every time I say "in order", I mean "in program
order". I agree that this is not enough precision as it's not obvious
that memcpy will copy in ascending order of addresses (it doesn't have
to), I'll add that precision... or not. THat could be another question.
What do we want here ? I would rather have those strongly ordered for
Class 1.

> >  1- __{read,write}{b,w,l,q} : Those accessors provide only ordering rule
> > #1. That is, MMIOs are ordered vs. each other as issued by one CPU.
> > Barriers are required to ensure ordering vs. memory and vs. locks (see
> > "Barriers" section). 
> 
> "Except where the underlying device is marked as cachable or
> prefetchable"

You aren't supposed to use MMIO accessors on cacheable memory, are you ?
On PowerPC, even if using cacheable mappings, they would still be
visible in order to coherency domain, though being  cacheable, there is
indeed no saying in what order they'll end up hitting the PCI host
bridge. In fact, I know of platforms (like Apple G5s) who cannot cope
with cacheable mappings of anything behind HT... I'd keep use of
cacheable mapping as an arch specific special case for now, and that
definitely doesn't allow for MMIO accessors ...

> Q2:
> > coherency domain. If we decide not to, then an explicit barrier will
> > still be needed in most drivers before spin_unlock(). This is the
> > current mmiowb() barrier that I'm proposing to rename (section * III *).
> 
> I think we need mmiowb() still anyway (for __writel etc)

Oh, we surely have a barrier providing that semantic (I call it
io_to_lock_wb() in my proposal, and it can be #defined to mmiowb to ease
driver migration). The question is wether we want rule #4 to be enforced
by accessors of Class 1 or not ..

> > If we decide to not enforce rule #4 for ordered accessors, and thus
> > require the barrier before spin_unlock, the above trick, could still be
> > implemented as a debug option to "detect" the lack of appropriate
> > barriers.
> 
> This I think is an excellent idea.

Thanks :)

> > [* Question 3] If we decide that accessors of Class 1 do not provide rule
> > #4, then this barrier is to be used for all classes of accessors, except
> > maybe PIO which should always be fully ordered.
> 
> On x86 PIO (outb/inb) etc are always ordered and always stall until the
> cycle completes on the device.

Yes and I think that as far as PIO is concerned, we shall remain as
close as possible to x86. PIO is mostly used by "old stuff", that is
drivers that are likely not to have been adapted/audited to undestand
ordering issues, and is generally slow anyway. Thus even if we decide to
relax rule #4 for Class 1 MMIO accessors, I'd be tempted to keep it for
PIO (and config space too btw)

> > [* Question 5] Should we document the rules for memory-memory barriers
> > here as well ? (and give examples, like live updating of a network
> > driver ring descriptor entry)
> > 
> 
> Update the existing docs

Ok.

Thanks for your comments. I'll wait for more of these and post an
updated version tomorrow. I'm still waiting for your preference
regarding including or not rule #4 for Class 1 (ordered) MMIO accessors.

Cheers,
Ben.


