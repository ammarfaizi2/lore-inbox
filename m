Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVLVQ6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVLVQ6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLVQ6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:58:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41231 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932433AbVLVQ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:58:50 -0500
Date: Thu, 22 Dec 2005 16:58:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nicolas Pitre <nico@cam.org>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222165828.GA5268@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@cam.org>,
	Christoph Hellwig <hch@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain> <20051222164415.GA10628@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222164415.GA10628@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 05:44:15PM +0100, Ingo Molnar wrote:
> * Nicolas Pitre <nico@cam.org> wrote:
> > > i'm curious, how would this ARMv6 solution look like, and what would be 
> > > the advantages over the atomic swap based variant?
> > 
> > On ARMv6 (which can be SMP) the atomic swap instruction is much more 
> > costly than on former ARM versions.  It however has ll/sc instructions 
> > which allows it to implement a true atomic decrement, and the lock 
> > fast path would look like: [...]
> 
> but couldnt you implement atomic_dec_return() with the ll/sc 
> instructions? Something like:
> 
> repeat:
>        ldrex   r1, [r0]
>        sub     r1, r1, #1
>        strex   r2, r1, [r0]
>        orrs    r0, r2, r1
>        jneq    repeat
> 
> (shot-in-the-dark guess at ARMv6 assembly)

atomic_dec_return() would be:

1:	ldrex	r1, [r0]
	sub	r1, r1, #1
	strex	r2, r1, [r0]
	teq	r2, #0
	bne	1b
	@ result in r1

But that's not really the main point Nico's making.  Yes, on ARMv6
there is little difference.  However, ARMv6 is _not_ mainstream yet.
The previous generation which do not have this is currently mainstream.

When it comes down to it, unlike x86 land where new CPU features are
taken up very quickly, the take up of new features on ARM CPUs is
a lot slower - it's a matter of years not a matter of months.
Therefore, we can expect ARMv5 architecture CPUs to be mainstream
at least for the next year or two, and these are the ones which
we should optimise for.

Nico's point still stands though - and I'd like to ask a more direct
question.  There is an efficient implementation for ARMv5 CPUs which
it appears we're being denied the ability to use.

Given that this has been argued for using clear technical arguments
over the last two days, I have yet to see any explaination why you're
choosing to ignore it.  Could you please explain why?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
