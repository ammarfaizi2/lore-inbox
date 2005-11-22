Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVKVSjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVKVSjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKVSjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:39:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932405AbVKVSjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:39:06 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org> 
References: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>  <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <1132611631.11842.83.camel@localhost.localdomain> <1132657991.15117.76.camel@baythorne.infradead.org> <1132668939.20233.47.camel@localhost.localdomain> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 22 Nov 2005 18:37:56 +0000
Message-ID: <9497.1132684676@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> The fact is, 0 _is_ "no interrupt". Always has been.

The fact that it always has been doesn't make it correct; and the fact that
the C particularly likes zeros is only optimisable on some hardware. On RISC
processors where you can't test memory directly, it seems to be the case that
any small positive or negative integer is as good as zero; for instance, in
FRV:

	ldi	@(gr8,#0),gr4		# doesn't set the condition codes
	subicc	gr4,#-1,gr0,icc0	# cmp to -1, result to immutable gr0
	beq	icc0,#0,it_was_unset

I suspect a lot of RISC archs will be like this. It's only certain ones like
M68K and x86 where you can test memory directly:

	testl	(%eax)
	je	it_was_unset

that it's usefully optimisable, and in those cases it might be possible to do
this sort of thing:

	cmpl	$-1,(%eax)
	je	it_was_unset

though the instruction will be longer.

> In short: NO_IRQ _is_ 0. Always has been.

So what? That hasn't stopped you imposing a blanket change before.

> It's the only sane value.

Has anyone ever accused you of being sane? :-)

> Anybody who does anything else is a bug waiting to happen.

My three main concerns are this:

 (1) Changing the no-irq value away from zero is going to cause problems in
     certain drivers that assume they can do !dev->irq. I'd like my drivers to
     work without me having to do anything to them, but there's a lot of
     rubbish drivers out there, even allowing for this. I suspect this is a
     tiny part of the problem, and easily fixed in the drivers in the kernel.

 (2) 0 is a valid IRQ in lots of places, including x86. IIRC it is permissible
     for ISAPNP and PNP-BIOS (and presumably ACPI) to indicate something is
     attached to IRQ 0 (usually only the timer is there though, but it can be
     possible to reconfigure that).
     
     Fortunately, for the FRV arch IRQ 0 is not used - level 0 in the interrupt
     mask register permits all interrupts; and for the AM33 arch, whilst there
     is an IRQ 0, that's the NMI interrupt and so has to be handled specially
     anyway.

     The only reason NO_IRQ on FRV is -1 is that I copied the code from
     elsewhere. It could easily be changed to 0.

 (3) Having to translate a cookie for a specific IRQ means that the IRQ
     handling code will be slower and more complex, or is going to avoid the
     issue and be naughty and not deal with irq == NO_IRQ properly:

     The x86 PIC reports it as IRQ 0 having happened. In which case, by your
     argument, you _have_ to translate it: you're not allowed to pass NO_IRQ to
     setup_irq(), and you're not allowed to pass it to the interrupt handler -
     in this case timer_interrupt(). Doing otherwise is wrong, insane, etc...

     It may even be possible to simplify the x86/x86_64 arch code by making IRQ
     0 a normal IRQ instead of something special.

     The only argument for not doing so is that it's hidden inside the arch
     where it can't be seen... apart from by those looking for examples of good
     code to copy (the i386 arch is used as a model for a lot of things).


I'd like to see dev->irq as a pointer to a structure. As you say, the number is
a cookie, but it's also very much dependent on the bus, so why shouldn't it be
associated with the bus in the same way I/O ports and memory ranges are? I'd
also like to see it arranged as a tree: with FRV, I can add extra PIC's into
the tree, thus expanding the IRQ space available dynamically.

However, as far as the current issue goes, I've no concerns for FRV or AM33
should NO_IRQ become 0.

Whatever you decide to do *please* document this in Documentation/ somewhere!
Then you have a "standard" at which to point and say "so it is written". At the
moment it's documented in the code, and that is inconsistent, perhaps
reasonably.

David
