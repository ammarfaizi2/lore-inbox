Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULaAi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULaAi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbULaAi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:38:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:55948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261794AbULaAix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:38:53 -0500
Date: Thu, 30 Dec 2004 16:38:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <m1mzvvjs3k.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <m1mzvvjs3k.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Andi Kleen wrote:
> 
> Just looking at all this complexiy and thinking about
> making it work on x86-64 too doesn't exactly give a good
> feeling in my spine.
> 
> Not to belittle your archivement Linus but it all looks
> very overengineered to me.

Ehh, do you have any _alternatives_?

> I think such complex instruction emulation games will be 
> hard to maintain and there are very surely bugs in so 
> much subtle code. 

There is no complexity anywhere, and we don't actually emulate any 
instructions at all. The only thing we do is to check _whether_ the 
instruction is a "popf" - we let the CPU do all the work, we just say "ok, 
the instruction will set TF, so we should not touch it afterwards.

> Can someone repeat again what was wrong with the old ptrace
> semantics before the initial change that caused all these complex
> changes?  It seemed to work well for years. How about we just
> go back to the old state, revert all the recent ptrace changes 
> and skip all that?

Let me count the ways that were wrong before the changes:
 - you couldn't debug any code that set TF. Really. ptrace would totally 
   destroy the TF state in the controlled process, so it would do 
   something totally different when debugged.
 - you couldn't even debug signal handlers, because they were _really_ 
   hard to get into unless you knew where they were and put a breakpoint 
   on them.
 - you couldn't see the instruction after a system call.
 - ptrace returned bogus TF state after a single-step

> I would love to skip this all on x86-64, but I would prefer
> to not make the behaviour incompatible to i386.

I suspect all the code can be shared. In fact, the change to send a
SIGTRAP directly rather than play around with "ptrace_notify()" etc is
likely totally architecture-independent apart from the calling convention
magic, so all of "do_syscall_trace()" could probably be moved into
kernel/ptrace.c.

The _only_ real complexity is actually following the silly LDT
descriptors, and we actually do that (badly) in another place: the AMD
"prefetch" check does exactly the same thing except it seems to get a few
details wrong (looks like it cannot handle 16-bit code), and only works
for the current process.

I assume you have that same prefetch thing on x86-64 already, so if
anything, you could look at my replacement and see if it would be workable
to do the prefetch thing too..

IOW, none of the issues involved are new. 

			Linus
