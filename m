Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSKUHto>; Thu, 21 Nov 2002 02:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSKUHtn>; Thu, 21 Nov 2002 02:49:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64157 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266377AbSKUHtn>;
	Thu, 21 Nov 2002 02:49:43 -0500
Date: Thu, 21 Nov 2002 10:13:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
In-Reply-To: <20021121001819.GA12650@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211211007100.1782-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Nov 2002, Jamie Lokier wrote:

> Thread calls cfork(), which does this in the parent:
> 
> 	sigprocmask(...)
> 		// Very short time during which signals aren't delivered.
> 	clone(...)
> 		// Very short time during which signals aren't delivered.
> 	sigprocmask(...)
> 

Jamie, we've been there, done that. This is precisely the kind of signal
locking cruft we got rid of in LinuxThreads, and which cruft caused it to
be slow. My goal was and still is to isolate signals from the rest of the
kernel APIs as much as possible, while still keeping the traditional
semantics. Check out an strace of a LinuxThreads linked pthread
application and you'll see signal mask manipulation syscalls all around
the place. Check out an NPTL strace, and see all those straightforward
single-syscall operations.

sure, fork() has some overhead larger than signal manipulation costs, but
this does not make the approach right in any way. If all this userspace
cost can be dealt with by doing some simple things in kernel-space, why
not do it?

	Ingo

