Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVAUXZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVAUXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVAUXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:24:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6605 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262573AbVAUXRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:17:55 -0500
Date: Fri, 21 Jan 2005 17:17:51 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Roland Dreier <roland@topspin.com>
cc: Brandon Corey <bcorey@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Pollable Semaphores
In-Reply-To: <521xceqx90.fsf@topspin.com>
Message-ID: <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com>
References: <20050121212212.GA453910@firefly.engr.sgi.com> <521xceqx90.fsf@topspin.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Roland Dreier wrote:

>     Brandon> I'm trying to find out if there is a pollable semaphore
>     Brandon> equivalent on Linux.  The main idea of a "pollable
>     Brandon> semaphore", is a semaphore with a related file
>     Brandon> descriptor.  The file descriptor can be used to select()
>     Brandon> when the semaphore is acquirable.  This provides a
>     Brandon> convenient way for users to implement code
>     Brandon> synchronization between threads, where multiple file
>     Brandon> descriptors are already being selected against.
> 
> Yes, I believe futexes and specifically FUTEX_FD can be used to
> implement this.  See http://people.redhat.com/~drepper/futex.pdf for
> full details.

Thanks for pointing out that paper, I wasn't aware of it (Brandon and
I talked about this problem before he posted).

The problem listed in section 9 of that paper is a showstopper to using
FUTEX_FD.  It's the very problem I ran into when trying to brainstorm a
wrapper library call around it to roughly implement the behavior Brandon
is looking for.

An additional major inconvenience is that the file descriptor can only
be used once, after which it must be closed and another reopened.  If
somehow the poll/select call could reuse the same file descriptor we
could avoid a whole bunch of library glue goo to make it work that
way (i.e. special library routines similar to poll(2) and select(2)
which do some fake file descriptor table hand waving to make it look
like there's reusable futex fds).

Perhaps a new FUTEX_POLLFD would be a reasonable solution for both
problems?  The semantics would be a bit different that FUTEX_FD.

It could solve the race condition (i.e. the problem in section 9 of
the paper) by the following:

  1. A write to the fd is used to set the value of interest analagous to
     the second parmeter to FUTEX_WAIT.  This value is stored on a
     per-fd (or maybe per-fd per-thread if it's not possible to have
     multiple fds per futex) basis.
  2. select/poll on the fd return EWOULDBLOCK if the current value of
     the futex is not equal to the value of interest.  Otherwise it
     behaves as FUTEX_FD currently does.

I think it's even possible that this behavior could be wedged into
the current FUTEX_FD, as a write(2) to this fd is meaningless on it
at present.  It's not a perfect solution, however, in that it would
be possible for one or more of the futexes that are the target of a
select(2) call to be updated so rapidly that we can never make progress
in the "write value then select" loop.

I'm not sure how to fix the reusability problem, as I haven't
determined the technical reason behind the current one-shot design.
Maybe it could be as simple as using another currently unused call
such as read(2) to reset the fd?  But I suspect it's harder than
that, otherwise it wouldn't be a one-shot in the first place.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
