Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUF2Dzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUF2Dzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUF2Dzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:55:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:19139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265390AbUF2Dzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:55:42 -0400
Date: Mon, 28 Jun 2004 20:55:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200406290346.i5T3keo1022764@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406282049350.28764@ppc970.osdl.org>
References: <200406290346.i5T3keo1022764@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jun 2004, Roland McGrath wrote:
>
> > And I refuse to make the fast-path slower just because of this. 
> 
> You are talking about the int $0x80 system call path here?
> That is the only non-exception path touched by my changes.

That's still the fast path on any machine where this matters.

If the system uses sysenter, it won't matter because we reload TF by hand. 
And if it uses "int 0x80" through the trampoline, it won't matter, because 
the "lost" instruction is part of the trampoline, and not "important" for 
the debuggee. I think it's a "ret" instruction that gets lost, so the only 
thing that happens is that the person "magically" returns to the caller. 

If that's a problem (for "finish" or other logic), I'd be ok with adding a 
"nop" to the vsyscall thing. That would have less of an impact than adding 
the test to the kernel path..

So the _only_ case your patch matters is for old-style binaries that use 
"int 0x80" inline, and there that path is indeed the hot-path.
 
> > Not only has Linux always worked like this, as far as I know all other
> > x86 OS's also tend to just do the Intel behaviour thing.
> 
> The only other one I have at hand to test is NetBSD 1.6.1, which does
> indeed behave the same way for its int $0x80 system calls.

I bet that if you really search, you cna probably find _some_ OS out there
that considered the Intel behaviour a bug, and fixed it with something
like your patch. But I bet it's not just Linux and BSD that use the Intel
behaviour, just because it's such a pain _not_ to.

			Linus
