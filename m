Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSGUPos>; Sun, 21 Jul 2002 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSGUPos>; Sun, 21 Jul 2002 11:44:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10570 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317694AbSGUPor>; Sun, 21 Jul 2002 11:44:47 -0400
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <200207190952.g6J9q4I07044@sic.twinsun.com>
	<200207200038.g6K0cZO12086@devserv.devel.redhat.com>
	<ahau4q$1n2$1@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jul 2002 09:36:10 -0600
In-Reply-To: <ahau4q$1n2$1@penguin.transmeta.com>
Message-ID: <m13cudnled.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

> In article <200207200038.g6K0cZO12086@devserv.devel.redhat.com>,
> Alan Cox  <alan@redhat.com> wrote:
> >> <http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
> >> says that 'select' may modify its timeout argument only "upon
> >> successful completion".  However, the Linux kernel sometimes modifies
> >> the timeout argument even when 'select' fails or is interrupted.
> >
> >This is extremely useful behaviour. POSIX is broken here. Fix it in the
> >C library or somewhere it doesn't harm the clueful
> 
> Personally, I've gotten to the point where I think that the select()
> time is broken. 
> 
> The thing is, nobody should really ever use timeouts, because the notion
> of "I want to sleep X seconds" is simply not _useful_ if the process
> also just got delayed by a page-out event as it said so.  What does "X
> seconds" mean at that point? It's ambiguous - and the kernel will (quite
> naturally) just always assume that it is "X seconds from when the kernel
> got notified". 
> 
> A _useful_ interface would be to say "I want to sleep to at most time X"
> or "to at least time X".  Those are unambiguous things to say, and are
> not open to interpretation.

Sleeping until at most time X is only useful if the kernel can actually
make a guarantee like that.  If you are doing hard real time fine, otherwise
that doesn't work to well.
 
> The "I want to sleep until at least time X" (or "at most time X") also
> has the added advantage that it is inherently re-startable - restarting
> the sleep has _no_ rounding issues, and again no ambiguity.
> 
> Note that select() is definitely not the only offender here.  Other
> system calls like "nanosleep()" have the exact same problem - what do
> you do if you get interrupted by a signal and need to restart? 
> 
> The Linux behaviour of modifying the timeout is a half-assed try for
> restartability, but the problem is that (a) nobody else does that or
> expects it to happen, despite the man-pages originally claiming that
> they were supposed to and (b) it inherently has rounding problems and
> other ambiguities - making it even less useful. 
> 
> Oh, well.
> 
> I suspect almost nobody actually uses the Linux timeout feature because
> of the nonportability issues, making the whole mess even less tasty.

Actually I have had occasion in dosemu to not use the timeout features
because it did not do a good job of attempting to sleep for X seconds.
There can be a lot of time from when the kernel updates the timeout
value, and when the system call is restarted.

The desired semantics in this case were I want to sleep until time X,
and I want to wake up as soon afterwards as is reasonable.  Calling
gettimeofday before restarting the system call resulted in a much
better approximation of the desired result.

Eric
