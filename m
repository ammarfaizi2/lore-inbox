Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbTIYBoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 21:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTIYBoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 21:44:24 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:8206 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261650AbTIYBoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 21:44:22 -0400
Date: Thu, 25 Sep 2003 09:44:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <michael.waychison@sun.com>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
In-Reply-To: <3F71BE3D.6030501@sun.com>
Message-ID: <Pine.LNX.4.33.0309250924160.18646-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Mike Waychison wrote:

>
> I think the deadlock itself needs to be properly identified.
>
> Could you explain where the deadlock is actually occuring?  I briefed
> over the automount 4 code as well as autofs4 and I don't see the
> deadlock.  The 'owner' in the case of an expiry will be a child process
> of the daemon, within a call to ioctl(EXPIRE_MULTI), correct?  Having it
> be released from the waitqueue first should not affect flow of execution
> and released from deadlock.

Yes. I am having trouble defining the actual problem also.

I believe that the deadlock occures because of the sequence of calls
between the expire and Naultilus, each execution path taking and releasing
the BKL.

I will try and get more evidence as I work on it.

>
> I don't see how having it wake up before before any other racing
> processes solves anything.

I thought this was a side effect of the O(1) scheduler and that the
design of the wait handling left it open to a sequence of calls problem.
I first got the impression that it was related to the scheduler (and
felt that it was a deadlock) when I bumped the priority of the expire to
see what would happen and it work fine every time I tried it.

>
> I think Arjan is right in that the race is do to the nautilus process
> entering the sleep_on after the a call to wake_up(&wq->queue).  I don't

That needs fixing for sure, apart from anything else.

> know if a change to using a workqueue is best..   how about refactoring
> that chunk of code to use wait_event_interruptible on the queue, which
> should be clear of any waitqueue/sleep_on races.

Exaclty what I thought after pondering Arjans' mail last night.
The expire must be interruptible.
This will show if there actually is a timing problem (I hope).

>
> >
> >
> > OK so maybe I should have suggestions instead of comments.
> >
> > Please elaborate.
> >
>
> How about you try out this quick patch I threw together.

Oops. Replied without looking at the patch.

I'll check it out after work tonight.

Thanks to all for the help.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

