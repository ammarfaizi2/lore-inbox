Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVKYLxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVKYLxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKYLxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:53:25 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:61397 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932187AbVKYLxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:53:23 -0500
Subject: Re: RFC: Kill -ERESTART_RESTARTBLOCK.
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511250110470.1610@scrub.home>
References: <1132859323.11921.110.camel@baythorne.infradead.org>
	 <Pine.LNX.4.61.0511250110470.1610@scrub.home>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 11:53:14 +0000
Message-Id: <1132919594.4044.41.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 02:08 +0100, Roman Zippel wrote:
> What arguments do you need to store?

For pselect(), lots of them.

> Instead of messing with the signal delivery it may be better to slightly 
> change the restart logic. Instead of calling a separate function, we could 
> call the original function with all the arguments, which would reduce the 
> state required to be saved.
 < ... >
> AFAICT only the timeout argument needs to saved over a restart, the rest 
> can be reinitialized from the original arguments.

Yeah, that might be nice -- but if the argument registers are
call-clobbered, then those original arguments don't actually exist
anywhere any more, except in the syscall function which got interrupted.
That's presumably why they were put in the restartblock in the first
place.

Delivering signals by calling do_signal() isn't really that messy -- no
more so than the function restarting, at least. Poking the -EFAULT
return code into the signal frame if nanosleep fails to write the
remaining time back to userspace is a little bit icky, but not really so
bad.

One simpler option which _might_ work for pselect(), ppoll() and
sigsuspend() is a TIF_RESTORE_SIGMASK flag which restores the original
signal mask on the way back to userspace but _after_ calling do_signal()
with the temporary mask.

In fact, the asm part would be simple -- it could just call do_signal()
as it does for TIF_SIGPENDING, and do_signal() would clear the
TIF_RESTORE_SIGMASK flag and either deliver the signal if there still is
one, or just restore the original sigmask.

The problem with that approach is that I think you'll sometimes get
-EINTR without a signal actually being delivered. Because there'll be a
signal pending which breaks you out of the syscall itself, but it's gone
(delivered to another thread, or otherwise not causing you to go into a
handler) by the time we actually end up in do_signal().

Hm, it occurs to me that a more viable option might be a hybrid of the
two -- have the generic code call get_signal_to_deliver() if it thinks
there's a signal pending. Store the returned results in a structure
which replaces the existing restartblock. Set a TIF_flag to indicate
that there's a signal which has _already_ been dequeued and needs
delivering, and return -EINTR in the knowledge that there _will_ be a
signal delivered. Or if get_signal_to_deliver() returns zero, just
continue round the loop as if nothing happened.

That one's slightly problematic because of the way the SPARC kernel uses
the 'cookie' argument to ensure it properly sets up for syscall
restarting before stopping for a debugger -- whereas every other arch
doesn't seem to bother with that and just does it after the ptrace stop.
But since we're not going to be returning anything but -EINTR when we do
this, it's not really a problem. We can just make the sparc
ptrace_deliver_signal() function deal with a NULL cookie.

-- 
dwmw2


