Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTKZUOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTKZUOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:14:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8322 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264301AbTKZUON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:14:13 -0500
Date: Wed, 26 Nov 2003 15:17:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
In-Reply-To: <20031126193310.GE14383@mail.shareable.org>
Message-ID: <Pine.LNX.4.53.0311261459340.11574@chaos>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
 <Pine.LNX.4.58.0311261021400.1524@home.osdl.org> <Pine.LNX.4.53.0311261344280.11326@chaos>
 <20031126193310.GE14383@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > The actual problem in the production machine involves two absolutely
> > independent tasks that end up using the same shared 'C' runtime
> > library. There should be no interaction between them, none
> > whatsover. However, when they both execute rand(), they interact in
> > bad ways. This interraction occurs on random days at monthly
> > intervals.
>
> On Linux (unlike Windows), there is _no_ interaction between the
> libraries of different tasks.  Neither of them sees changes to the
> other's memory space.
>
> If you are seeing a fault, then there might well be a bug, even a
> kernel bug, but your test program does not illustrate the same problem.
>
> What is the "bad interaction" that you observed at monthly intervals?
> Also a SIGSEGV?
>

Yes. When the call to rand() was replaced with a static-linked
clone it went away.

> > This is likely caused by the failure to use "-s" in the compilation
> > of a shared library function, fixed in subsequent releases.
>
> No, this has nothing to do with it.  Unlike Windows and some embedded
> environments, Linux shared libraries do not have "shared writable data"
> sections.

Well the libc rand() does something that looks like that.

>
> > So, I allowed rand() to be "interrupted" just as it would be in a
> > context-switch. I simply used a signal handler, knowing quite well
> > that the "interrupt" could occur at any time. [...] What I brought
> > to light was a SIGSEGV that can occur when the shared-library rand()
> > function is "interrupted".
>
> You have made a mistake.  You program shows a different problem to the
> one which you noticed every month or so.
>

The calling rand() from a handler in a newer libc doesn't seg-fault.

> Calling a function from a signal handler while it is being interrupted
> by that handler is _very_ different from tasks context switching.
> They are not similar at all!  (Yes, signals can be used to simulate
> context switches, but not like this!)
>

Not with the emulation. The problem is that rand() uses a thread-
specific pointer to find the seed (history variable), just like
'errno' which isn't really a static variable, but a function
that returns a pointer to a thread-specific integer. If this
is interrupted in a critical section, and that same pointer
is used, that pointer is left pointing to a variable in somebody
else's address space. That same problem is observed to happen when
the same shared runtime library was used by entirely different tasks.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


