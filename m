Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUE2RqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUE2RqR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUE2RqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 13:46:17 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:7770 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265311AbUE2RqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 13:46:13 -0400
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jurjen@stupendous.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040528160612.306c22ab.akpm@osdl.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085852755.5999.167.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 29 May 2004 12:45:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 18:06, Andrew Morton wrote:
> Obviously the current locking is pointless...

Agreed

> ... and the only useful locking we have in there is lock_kernel().

For calling write_wakeup, even that is useless.

After more examination, I see write_wakeup can
be called in any context (even hard interrupt) with no
locking (external to write_wakeup) at all.

write_wakeup *must* provide all required locking internally,
because none is provided externally (in a consistent way
by all callers). write_wakeup implementations requiring
external locking are broken.
Planned or not, this is the current situation.

I'm still poking around the flush_buffer calls
but the same appears to apply here as well.


> The reason why a patch such as yours wasn't applied is that it was all kept
> as a reminder that we suck.  Someone needs to get down and audit what's
> actually happening in there.  It seems that you've now done that via
> comparison with other callers, but that is not necessarily a good approach
> when it comes to the tty layer ;)

My analysis of callers of these functions was to show that
disabling interrupts to make these calls in do_tty_hangup()
is useless, because not all callers follow this convention.
It is not an indication of the correctness
of individual tty drivers or line disciplines.

Removing the interrupt disabling won't make
individual tty drivers or line disciplines any more or
less broken. (but may expose existing problems more readily)


> We need to itemise all the affected memory storage in all impementations of
> ->flush_buffer() and ->write_wakeup() and then make sure that all _other_
> users of those fields (whether or not they lie in the ->flush_buffer() and
> ->write_wakeup() codepaths) are using the same locking.  Is that something
> you could do?

I see what you are getting at, but what question are we
trying to answer? We already know flush_buffer/write_wakeup
implementations requiring external locking
are broken as no such locking currently exists, and
interrupt disabling in do_tty_hangup does not fix this.
If external locking is not required, then interrupt
disabling in do_tty_hangup serves no purpose.

Apart from that question, auditing the correctness of internal
details of the 17 line disciplines and 64 tty drivers would be
nice but would take a very long time for one person :-)
It is probably better that:
* Broken, unmaintained drivers remain broken and are eventually culled.
* Broken, maintained drivers are identified and fixed by the maintainer.

I understand that without such an audit you may want
to let interrupt disabling in do_tty_hangup() stand in
case it is helping broken drivers or line disciplines
to limp along in some cases.


As for the softirq.c warning, this is not a problem.
Currently ppp_synctty does not allow for the fact that
write_wakeup can be called in hard interrupt context.
A patch from Paul Mackerras has already been accepted
to correct the same problem for ppp_async.c and I will
adapt his modifications to ppp_synctty.c
These modifications have the side effect of making
the interrupt enable/disable state of the write_wakeup
caller irrelevant. 

--
Paul Fulghum
paulkf@microgate.com



