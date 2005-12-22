Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVLVVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVLVVFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVLVVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:05:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52639 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030319AbVLVVFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:05:38 -0500
Date: Thu, 22 Dec 2005 22:04:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222210446.GA16092@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain> <20051222164415.GA10628@elte.hu> <20051222165828.GA5268@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222165828.GA5268@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > but couldnt you implement atomic_dec_return() with the ll/sc 
> > instructions? Something like:
> > 
> > repeat:
> >        ldrex   r1, [r0]
> >        sub     r1, r1, #1
> >        strex   r2, r1, [r0]
> >        orrs    r0, r2, r1
> >        jneq    repeat
> > 
> > (shot-in-the-dark guess at ARMv6 assembly)
> 
> atomic_dec_return() would be:
> 
> 1:	ldrex	r1, [r0]
> 	sub	r1, r1, #1
> 	strex	r2, r1, [r0]
> 	teq	r2, #0
> 	bne	1b
> 	@ result in r1
> 
> But that's not really the main point Nico's making.  Yes, on ARMv6 
> there is little difference.  However, ARMv6 is _not_ mainstream yet.  
> The previous generation which do not have this is currently 
> mainstream.

i think there is some miscommunication here. I am actually on your side, 
and i spent all my day enabling the best mutex variant on both the v5 
and v6 version of your CPU. What we were doing was to discuss the 
details of getting there. So dont shoot the messenger, ok?

This is Nico's point i replied to:

> > [...] on ARMv6 at least this can be improved even further, but a
> > special implementation which is neither a fully qualified atomic
> > decrement nor an atomic swap is needed. [...]

and this was my reply:

> i'm curious, how would this ARMv6 solution look like, and what would 
> be the advantages over the atomic swap based variant?

to which Nico replied with an ll/sc implementation, which very much 
looked like atomic_dec_return(). That's all i said. Nobody is trying to
shut out anything from anywhere, and certainly not me. I am _enabling_
your stuff. I'm just trying to find the most maintainable and still most 
flexible solution.

> Nico's point still stands though - and I'd like to ask a more direct 
> question.  There is an efficient implementation for ARMv5 CPUs which 
> it appears we're being denied the ability to use.

do you realize that i've enabled this efficient implementation via 
CONFIG_MUTEX_XCHG_ALGORITHM? Do you realize that you _dont_ have to use 
extremely heavy IRQ-disabling ops on ARM to enable mutexes? Do you 
realize that what we are down to now are 1-2 instructions of 
differences?

The discussion was not about ARMv5 at all. The discussion was about the 
claim that 'ARMv6 is somehow magical that it needs its own stuff'. No it 
isnt magical, it's a sane CPU that can implement a sane 
atomic_dec_return(), or even better, a sane atomic_*_call_if_*() 
primitive. Or whatever primitive we end up having - i dont mind if it's 
called __mutex_whatever, as long as it has a _well defined_ meaning.

what i _DONT_ want is some over-opaque per-arch thing that will again 
escallate into the same situation as semaphores: 23 different 
implementations nobody is able to change at once, nobody is able to add 
features or debugging to, and by today there's probably is no single 
person on this planet who knows all 23 of them to begin with.

if you sense me trying to avoid something then that's it: ambiguities in 
the arch-level implementation, because they end up stiffling the generic 
code.

	Ingo
