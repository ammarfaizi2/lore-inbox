Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTE1XBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTE1XBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:01:04 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:18843 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S261548AbTE1XBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:01:02 -0400
Message-ID: <3ED542D6.795A7467@attbi.com>
Date: Wed, 28 May 2003 19:14:30 -0400
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: signal queue resource - Posix timers
References: <200305281856.h4SIuFZ02449@linux.local> <3ED531AD.1020309@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > Posix timers are required to fail the
> > timer_create with EAGAIN if "the system lacks sufficient signal queuing
> > resources to honor the request."  The current Linux posix-timers
> > implementation doesn't do this.
> 
> That's not really how you can interpret this.  At the time timer_create
> is it is not know when the timer expires and whether it's a repeating
> timer.  Therefore it is not correct to assume that if timer_create
> succeeds the resources to always deliver the signal are available.

Hi Ulrich,

My intention is to allocate a sigqueue structure in the kernel as part
of the timer_create call.  Later on in timer completion, I will use this 
preallocated sigqueue entry to queue the siginfo_t for the timer completion.
The Posix timers specification guarantees that there can only be a single
signal pending for a given timer so preallocating one sigqueue structure
for each timer is sufficient.

Perhaps I should have tracked down the appropriate "shall deliver the 
signal on timer completion" and quoted it instead.  The point is that
the current Linux implementation will fail to deliver the signal at the
whim of other programs which might consume the limited signal queue 
resource.

I saw your post on the posixtest-discuss which complained about the test suite
trying to force this condition.  I agree that this is a bad test. When I preallocate
this resource, I may happily wait for a sigqueue entry to be available
and never return this failure.

Have a look at the Rationale and Notes section B.14.2.2 Create a Per-Process
Timer. It is fairly clear that it expects signal queuing resources to 
be allocated at timer_create time and that failing to deliver a completion 
signal is never acceptable.

Jim Houston - Concurrent Computer Corp.
