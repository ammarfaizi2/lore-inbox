Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDNVsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDNVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:48:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:54177 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261815AbUDNVsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:48:33 -0400
Date: Wed, 14 Apr 2004 22:48:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dirk Morris <dmorris@metavize.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Ben Mansell <ben@zeus.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
Message-ID: <20040414214817.GH12105@mail.shareable.org>
References: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com> <407D7BFF.4010700@metavize.com> <20040414193947.GE12105@mail.shareable.org> <407D9D2F.3010901@metavize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407D9D2F.3010901@metavize.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Morris wrote:
> From what I understand you're proposing to remove the fd from the set 
> lazily instead of immediately.
> Which will save system calls in the cases were the HUP/ERR condition 
> does not occur during the 'disabled' time.
> 
> In my case, which you may choose to disregard, this condition is not 
> irregular or in any way a special case.
> So the revision you have proposed is just an optimization.
> You could even use this same optimization with the disable feature 
> (disable it lazily) and get even better performance with the same number 
> of syscalls you proposed.

I don't think you would get any better performance even when HUP/ERR
conditions are commonplace.

A HUP condition means you cannot read & write from the fd any more, so
even though you may defer handling it in userspace, there's nothing to
be gained from disabling all epoll events after you receive the HUP:
instead of lazy disabling, you might as well delete the fd from epoll
as soon as you receive the HUP even though you don't want to handle it yet.
(Btw, the comment about HUP in net/ipv4/tcp.c:tcp_poll() is illuminating).

ERRs can occur many times while a socket is open so the algorithmic
efficiency is worth considering.

An ERR condition, at least on a socket, forces you to examine the
error before you can perform a further read or write.  That's because
read and write operations will both check for pending error, so when
you know there's an error condition, you know that the next read or
write call is really a "tell me the error" call.

So, assuming you apply the lazy strategy, after you receive an ERR, in
principle you could decide that you want to do nothing with it until
the next IN or OUT which represents non-error data readiness, and then
you will examine the error code (by doing a read or write call) and
then read or write actual data.  Then indeed being able to ignore just
ERR and still listen for IN and/or OUT would make a difference.  But
you might as well just read the error condition using MSG_ERRQUEUE,
and spend your one system call that way instead - you can still defer
the processing of the error code.

There is a situation where that is algorithmically not as good as
being able to ignore just ERR: The example is when you are receiving a
malicious flood of ICMP packets which cause lots of error conditions
on a UDP socket (or other similar things), and you want to ignore all
of those while efficiently handling a lower rate of non-error data
transfer.  That's a very unusual situation and it doesn't occur except
under attack circumstances with UDP (because real error ICMPs are a
response to something you transmitted yourself).

Other socket types or devices might give ERR a different meaning which
causes them to be common relative to read and write readiness.  If so,
they probably shouldn't.

> I see no downside, except that it no longer conforms to the semantics of 
> poll and select.
> Whether or not its worth it to deviate from this behavior over such a 
> detail, I don't know. :)

I see two downsides.  They're not performance downsides, just practical:

  1. Currently, you can implement epoll in terms of poll(), if you
     have an epoll-based program and want to create epoll emulation
     functions for running on an old kernel.  If epoll were extended
     to permit ignoring HUP/ERR, that would no longer be possible.

  2. Perhaps most programs will use a flexible library like libevent
     or something made for the program.  It's possible that library
     will offer an API which sends the POLLIN/OUT/ERR/HUP bits to the
     application, and lets the application programmer interpret those
     bits in whatever way is appropriate.  If it becomes easy to
     ignore HUP when the library works with epoll, applications may
     accidentally end up depending on that, and will unexpectedly fail
     when they are run one day on an older system, or even another OS
     where the same library works by calling poll() or select().

Summary: epoll is fine the way it is.  Imho.

-- Jamie
