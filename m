Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWI3VLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWI3VLT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWI3VLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:11:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751936AbWI3VLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:11:18 -0400
Date: Sat, 30 Sep 2006 14:11:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <20060930204900.GA576@elte.hu>
Message-ID: <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de>
 <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org> <20060930204900.GA576@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Ingo Molnar wrote:
> 
> (i'd have been happy with an %rbp based unwinder for x86_64, in fact i 
> implemented it for lockdep and used it for some time on x86_64, but Andi 
> wanted a dwarf-based, lower-overhead one. Andi also nicely integrated it 
> into stacktrace.c.)

I wouldn't mind the dawrf-based one so much, if it wasn't so obviously 
crap.

It could - and _should_ dammit! - do some basic sanity tests like "is the 
thing even in the same stack page"? But nooo... It seems _designed_ to be 
fragile and broken.

Here's a simple test: if the next stack-slot isn't on the same page, the 
unwind information is bogus unless you had the IRQ stack-switch signature 
there. Does the code do that? No. It just assumes that unwind information 
is complete and perfect.

That's not the kind of code we write in the kernel. In the kernel, we 
write code that _works_, regardless of the kind of horrible stuff people 
feed it. That's _doubly_ true for something like a stack frame debugger, 
which is invoced when there is trouble, and for all we know the stack 
itself MIGHT BE CORRUPT.

In short, I think the stack unwinder is just _broken_. It has made all the 
wrong policy decisions - it only works when everything is perfect, yet 
it's actually meant to be _used_ when somethign bad happened. Doesn't that 
strike anybody else as a totally flawed design?

It damn well should.

		Linus
