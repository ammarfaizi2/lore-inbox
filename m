Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTIYLxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTIYLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:53:43 -0400
Received: from mail-12.iinet.net.au ([203.59.3.44]:31162 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261821AbTIYLxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:53:41 -0400
Date: Thu, 25 Sep 2003 19:59:44 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Waychison <michael.waychison@sun.com>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [autofs] Re: [PATCH] autofs4 deadlock during expire - kernel
 2.6
In-Reply-To: <Pine.LNX.4.33.0309250924160.18646-100000@wombat.indigo.net.au>
Message-ID: <Pine.LNX.4.44.0309251933590.1548-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Ian Kent wrote:

Seem to have lost the original message.
Please forgive the double indent.

I have tried the patch you recommended and have exactly the same symptoms.

> On Wed, 24 Sep 2003, Mike Waychison wrote:
> 
> >
> > I think the deadlock itself needs to be properly identified.
> >
> > Could you explain where the deadlock is actually occuring?  I briefed
> > over the automount 4 code as well as autofs4 and I don't see the
> > deadlock.  The 'owner' in the case of an expiry will be a child process
> > of the daemon, within a call to ioctl(EXPIRE_MULTI), correct?  Having it
> > be released from the waitqueue first should not affect flow of execution
> > and released from deadlock.

I have had some time to clear my thoughts on this now.

First, the expire is done using a while in the daemon. It continues until 
the ioctl returns non zero.

I believe the sequence of events is:

Expire locates an expireable dentry and sends a message to the daemon to 
do the umount and returns 0. The ioctl runs with the BKL.
The Naultilus process triggers a revalidate during the expire and waits 
till that iteration of the expire finishes before continuing. The 
revalidate leads to a lookup which takes the BKL.
Meanwhile the expire enters the ioctl again but is blocked on the BKL.
The lookup sends a mount request to the daemon which it cannot hear 
because it is still waiting for the expire to finish.

While this is a plausible description with the code as it is, I 
have found that even if I bracket the revalidate with a BKL the problem 
still occurs. 
So there is something else I am missing. I don't know what it is.

> > I don't see how having it wake up before before any other racing
> > processes solves anything.

If my description above where correct then forcing the expire to finish 
would lead to the correct behaviour.

> 
> I thought this was a side effect of the O(1) scheduler and that the
> design of the wait handling left it open to a sequence of calls problem.
> I first got the impression that it was related to the scheduler (and
> felt that it was a deadlock) when I bumped the priority of the expire to
> see what would happen and it work fine every time I tried it.
> 

I still think that it is a O(1) effect. When the sleeping processes awake 
it is possible that the scheduler does not pick the expire process as it 
was the most recent of the processes to run.

> >
> > I think Arjan is right in that the race is do to the nautilus process
> > entering the sleep_on after the a call to wake_up(&wq->queue).  I don't
> 
> That needs fixing for sure, apart from anything else.
> 
> > know if a change to using a workqueue is best..   how about refactoring
> > that chunk of code to use wait_event_interruptible on the queue, which
> > should be clear of any waitqueue/sleep_on races.

Again if my explanation is close to correct then the question is what is 
the proper way to force the execution order? Using a completion as well as 
the wait perhaps?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

