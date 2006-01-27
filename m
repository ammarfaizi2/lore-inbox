Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWA0E20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWA0E20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWA0E20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:28:26 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29433 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932199AbWA0E20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:28:26 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Steven Rostedt <rostedt@goodmis.org>
To: Howard Chu <hyc@symas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davids@webmaster.com, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <43D94595.4030002@symas.com>
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
	 <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au>
	 <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au>
	 <43D94595.4030002@symas.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 23:27:50 -0500
Message-Id: <1138336070.7814.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 13:56 -0800, Howard Chu wrote:
> Nick Piggin wrote:

> >>
> >> But why does A take the mutex in the first place? Presumably because 
> >> it is about to execute a critical section. And also presumably, A 
> >> will not release the mutex until it no longer has anything critical 
> >> to do; certainly it could hold it longer if it needed to.
> >>
> >> If A still needed the mutex, why release it and reacquire it, why not 
> >> just hold onto it? The fact that it is being released is significant.
> >>
> >
> > Regardless of why, that is just the simplest scenario I could think
> > of that would give us a test case. However...
> >
> > Why not hold onto it? We sometimes do this in the kernel if we need
> > to take a lock that is incompatible with the lock already being held,
> > or if we discover we need to take a mutex which nests outside our
> > currently held lock in other paths. Ie to prevent deadlock.
> 
> In those cases, A cannot retake the mutex anyway. I.e., you just said 
> that you released the first mutex because you want to acquire a 
> different one. So those cases don't fit this example very well.

Lets say you have two locks X and Y.  Y nests inside of X. To do block1
you need to have lock Y and to do block2 you need to have both locks X
and Y, and block 1 must be done first without holding lock X.

func()
{
again:
	mutex_lock(Y);
	block1();
	if (!mutex_try_lock(X)) {
		mutex_unlock(Y);
		mutex_lock(X);
		mutex_lock(Y);
		if (block1_has_changed()) {
			mutex_unlock(Y);
			mutex_unlock(X);
			goto again;
		}
	}
	block2();
	mutex_unlock(X);
	mutex_unlock(Y);
}

Stuff like the above actually is done (it's done in the kernel). So you
can see here that Y can be released and reacquired right away.  If
another task was waiting on Y (of lower priority) we don't want to give
up the lock, since we would then block and the chances of
block1_has_changed goes up even more.

> 
> > Another reason might be because we will be running for a very long
> > time without requiring the lock.
> 
> And again in this case, A should not be immediately reacquiring the lock 
> if it doesn't actually need it.

I'm not sure what Nick means here, but I'm sure he didn't mean it to
come out that way ;)

> 
> > Or we might like to release it because
> > we expect a higher priority process to take it.
> 
> And in this case, the expected behavior is the same as I've been pursuing.

But you can't know if a higher or lower priority process is waiting.
Sure it works like what you say when a higher priority process is
waiting, but it doesn't when it's a lower priority process waiting.

-- Steve


