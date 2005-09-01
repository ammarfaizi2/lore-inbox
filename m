Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVIAI3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVIAI3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIAI3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:29:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31132 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750857AbVIAI3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:29:51 -0400
Date: Thu, 1 Sep 2005 10:30:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: MAX_ARG_PAGES has no effect?
Message-ID: <20050901083033.GA8190@elte.hu>
References: <4314F761.2050908@kundor.org> <p73psrtr8ho.fsf@verdi.suse.de> <20050901065710.GB5179@elte.hu> <200509010926.51749.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509010926.51749.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Thursday 01 September 2005 08:57, Ingo Molnar wrote:
> 
> > the whole thing should be reworked, so that there is no artificial limit
> > like MAX_ARG_PAGES. (it is after all just another piece of memory, in
> > theory)
> 
> Yes, a sysctl would probably lead to fragmentation problems and then 
> people would do ugly linked lists of buffers like poll.

not really fragmentation problems (the unit of allocation of argument 
pages is already a single page, and we do an array of pages), the real 
problem is the DoS - right now the array pages are unswappable while an 
exec() is ongoing.

> > If we do unconditional page-flipping then we fragment the argument
> > space, if we do both page-flipping if things are unfragmented and
> > well-aligned, and 'compact' the layout otherwise, we havent solved the
> > problem and have introduced a significant extra layer of complexity to
> > an already security-sensitive and fragile piece of code.
> 
> Page flipping = COW like fork would do?

i dont think we need COW. During execve() we are destroying the old 
context and are creating a completely new context, so in theory we could 
just 'flip over' the argument/environment pages (which are a parameter 
to sys_execve()) from the old mm into the newly created mm, without 
caring about the old mm.

> Not sure how this would work - the arguments of execve can be anywhere 
> in the address space and would presumably be often be in a 
> inconvenient place like in the middle of the stack of the new 
> executable.

yes, that's one of the issues. I've done some instrumentation some time 
ago and it seemed that the arguments are typically page-aligned, so the 
only issue would be to clear the partial page at the end of the 
arguments. But i still think the concept is volatile.

> > The best method i found was to get rid of bprm->pages[] and to directly
> > copy strings into the new mm via kmap (and to follow whatever RAM
> > allocation policies/limits there are for the new mm), but that's quite
> > ugly.
> 
> That sounds better.

yeah. It's also pretty laborous though.

	Ingo
