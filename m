Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVC2BZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVC2BZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVC2BZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:25:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39057 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262138AbVC2BYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:24:48 -0500
Date: Mon, 28 Mar 2005 17:24:41 -0800
Message-Id: <200503290124.j2T1OfFA021493@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] posix-cpu-timers and cputime_t divisons.
In-Reply-To: Martin Schwidefsky's message of  Thursday, 17 March 2005 15:59:56 +0100 <20050317145956.GI4807@mschwid3.boeblingen.de.ibm.com>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I was not able to get back to you on this sooner.

The various cputime-related fixes here are all fine and should go in.  As
you can see, I merged my code with the cputime stuff late in the game and
quickly (and apparently somewhat carelessly).  (I knew that you were going
to have to add cputime_div, but I left it to you since cputime is your baby.)

You are right about the incorrect use of do_div because the divisor is 64
bits, thanks for noticing that.  But I'd like to see this fixed in a way that
doesn't penalize the 64-bit platforms where using normal 64-bit division is
perfectly fine to do.  Probably BITS_PER_LONG==BITS_PER_LONG_LONG is a
reasonable test for that.

This patch as it is seems like a fine enough starting point, and fixes
existing problems on 32-bit platforms.  A fix to restore 64-bit platforms
to the simple solution could come after.

> What still worries me a bit is to use "timer->it.cpu.incr.sched == 0"
> as check if the timer is armed at all. It should work but its not
> really clean.

It is not used that way.  The only case of the expression you quoted is the
one in bump_cpu_timer, which is checking whether the timer is set to reload
or not.  All-zeros is what the user interface is for indicating this (in
timer_settime and setitimer).  (bump_cpu_timer short-circuits the no-reload
case to avoid trying divison by zero in the reload code path.)

Perhaps you meant the "expires.sched" field?  It is true that an expiry
time of zero is used to mean a disabled timer.  That is consistent with
what's been done with jiffies timers in the past.  It is clean enough in
that 0 is never going to be the real expiry time of the timer, and moreover
the user interface is the same (a timespec of zeros to disarm a timer).

Or perhaps you are referring to using the ".sched == 0" tests for the
disabled-zero value (for expiry and reload, in various places in the code),
regardless of the flavor of value in the union actually in use?  That is
indeed not so clean.  It seemed reasonable enough when the union members
were unsigned long and unsigned long long.  Now with cputime_t, it is
theoretically opaque and you could be storing the value with a bias of -427
for all I know.  (But, there may be other places we have around that assume
that zeroed data structures including cputime_t's match cputime_zero.)
These could at least be made a macro or inline to consolidate the slightly
magic assumptions in a single spot.  I wouldn't object to changing it to do
something more fully kosher where we now have .sched = 0 assignments to
clear any flavor or .sched == 0 tests to check any flavor for
disarmed/no-reload, but only if it doesn't make the code gcc produces less
optimal than we get now.  Unfortunately gcc on x86 produces more code for
".sched == 0 && .cpu == 0" than the optimal code it yields for ".sched == 0"
alone, though the two are functionally identical given the data layout.


Thanks,
Roland
