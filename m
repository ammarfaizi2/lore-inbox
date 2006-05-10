Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWEJPB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWEJPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWEJPB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:01:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964969AbWEJPB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:01:58 -0400
Date: Wed, 10 May 2006 11:01:40 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastien Dugue <sebastien.dugue@bull.net>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
Message-ID: <20060510150140.GR14147@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060510112651.24a36e7b@frecb000686> <20060510100858.GA31504@elte.hu> <1147266235.3969.31.camel@frecb000686> <1147271536.27820.288.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1147271536.27820.288.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:32:14PM +0200, Thomas Gleixner wrote:
> On Wed, 2006-05-10 at 15:03 +0200, Sébastien Dugué wrote:
> >   Maybe the pthread_cond_*() function should be made to use the
> > PI-futexes support in glibc.
> 
> <hack_alert>
> 
> There is a simple way to do so. Just remove the assembler version of
> pthread_cond_xx and use the generic c code implementation in glibc. That
> allows you to use a PI mutex for the outer mutex.
> 
> </hack_alert>

I don't see how would that help.  Both asm and sysdeps/pthread/*.c
versions call __pthread_mutex_unlock_usercnt/__pthread_mutex_cond_lock,
which will DTRT for the mutex passed as second argument to
pthread_mutex_*wait (assuming you have Ulrich's/mine PI nptl patch).
But, there are 2 other futexes used by condvars - internal condvar's lock
and __data.__futex.  If the associated mutex uses PI protocol, then
I'm afraid the internal condvar lock needs to follow the same protocol
(i.e. use FUTEX_*LOCK_PI), otherwise a low priority task calling
pthread_cond_* and acquiring the internal lock, then scheduled away
indefinitely because of some middle-priority CPU hog could delay
some high priority task calling pthread_cond_* on the same condvar.
But, there is a problem here - pthread_cond_{signal,broadcast} don't
have any associated mutexes, so you often don't know which type
of protocol you want to use for the internal condvar lock.
Now, for the __data.__futex lock POSIX seems to be more clear,
all it says is that the wake up should happen according to the scheduling
policy (but, on the other side for pthread_mutex_unlock it says the same
and we still use FIFO there).

	Jakub
