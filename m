Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTE1Vsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTE1Vsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:48:45 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19657
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261196AbTE1Vsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:48:42 -0400
Message-ID: <3ED531AD.1020309@redhat.com>
Date: Wed, 28 May 2003 15:01:17 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jim.houston@attbi.com
CC: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: signal queue resource - Posix timers
References: <200305281856.h4SIuFZ02449@linux.local>
In-Reply-To: <200305281856.h4SIuFZ02449@linux.local>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Posix timers are required to fail the
> timer_create with EAGAIN if "the system lacks sufficient signal queuing
> resources to honor the request."  The current Linux posix-timers 
> implementation doesn't do this.

That's not really how you can interpret this.  At the time timer_create
is it is not know when the timer expires and whether it's a repeating
timer.  Therefore it is not correct to assume that if timer_create
succeeds the resources to always deliver the signal are available.

The shall-error in the standard just covers the case if there is really
no way this can be made working.  For instance, some implementation
might allocate to each process using timer_create N signal slots.  The
whole system could have only N * M slots.

Because there is no fixed limit (or better said: no guaranteed minimal
number of signal slots) in Linux this error doesn't apply at all.


> I'm contemplating changes to kernel/signal.c to allow reserved or
> pre-allocated sigqueue structures to be used.  The idea is to do the
> allocation in the system call context so the failure can be returned to
> the application.

Allocate how and what for?

If you mean allocating signal slots for the process, this is wrong.  It
should never we the case that a process accumulates many outstanding
signals.  Every limit is reached at some point and then all further
signals are ignored.  This is problematic because there is no guarantee
whatsoever that all signals come from the same timer and therefore later
signals can be safely ignored (to some degree of safety).  You might
lose the one event a long-running timer generates.

Allocating signal slots to the timer object does make sense.  But the
number must be small.  This indeed makes the signal handling simpler and
more robust.  Especially wrt to the just mentioned example, a often
expiring timer won't flood the signal system so that the events of other
timers are lost.

What I don' understand is why you bring up this 2000 outstanding signal
issue.  It never makes sense to handle this, especially not when the
events come from one system.  If really a high number of signals is used
the system is specialized and it not a problem to require a kernel
recompilation with new limits.


In summary: I think allocate, say, 16 signal slots per timer is a good
idea.  It means all timers are treated fairly which is important.  But
it should never be a goal to optimize the system for hundreds or even
thousands of outstanding signals.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+1TGt2ijCOnn/RHQRAiyVAJ0bOIVhou4LAw5WR3hDuc+o60uEbwCgr6V9
Nfo2tgcmiU6q8M9GGacqXvE=
=JTEF
-----END PGP SIGNATURE-----

