Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTKZTdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTKZTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:33:37 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:15489 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264283AbTKZTde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:33:34 -0500
Date: Wed, 26 Nov 2003 19:33:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
Message-ID: <20031126193310.GE14383@mail.shareable.org>
References: <Pine.LNX.4.53.0311261153050.10929@chaos> <Pine.LNX.4.58.0311261021400.1524@home.osdl.org> <Pine.LNX.4.53.0311261344280.11326@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311261344280.11326@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> The actual problem in the production machine involves two absolutely
> independent tasks that end up using the same shared 'C' runtime
> library. There should be no interaction between them, none
> whatsover. However, when they both execute rand(), they interact in
> bad ways. This interraction occurs on random days at monthly
> intervals.

On Linux (unlike Windows), there is _no_ interaction between the
libraries of different tasks.  Neither of them sees changes to the
other's memory space.

If you are seeing a fault, then there might well be a bug, even a
kernel bug, but your test program does not illustrate the same problem.

What is the "bad interaction" that you observed at monthly intervals?
Also a SIGSEGV?

> This is likely caused by the failure to use "-s" in the compilation
> of a shared library function, fixed in subsequent releases.

No, this has nothing to do with it.  Unlike Windows and some embedded
environments, Linux shared libraries do not have "shared writable data"
sections.

> So, I allowed rand() to be "interrupted" just as it would be in a
> context-switch. I simply used a signal handler, knowing quite well
> that the "interrupt" could occur at any time. [...] What I brought
> to light was a SIGSEGV that can occur when the shared-library rand()
> function is "interrupted".

You have made a mistake.  You program shows a different problem to the
one which you noticed every month or so.

Calling a function from a signal handler while it is being interrupted
by that handler is _very_ different from tasks context switching.
They are not similar at all!  (Yes, signals can be used to simulate
context switches, but not like this!)

Your code interrupts one call to rand() and calls rand() _within_
the interrupt handler.  The inner call and outer call interfere, in a
very similar way to calling it twice from two threads (note: threads
not tasks).  The memory state becomes corrupted.

This is _very_ different from two independent tasks context switching.
Independent tasks do not share the same memory space, not even when
they share the same libraries, so this type of corruption isn't
possible.

Summary: your monthly "bad interaction" is not illustrated in this
test program.  It's a different problem.

-- Jamie
