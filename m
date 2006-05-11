Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWEKIwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWEKIwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWEKIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:52:41 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40163 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965212AbWEKIwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:52:40 -0400
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: tglx@linutronix.de
Cc: Jakub Jelinek <jakub@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <1147280521.27820.329.camel@localhost.localdomain>
References: <20060510112651.24a36e7b@frecb000686>
	 <20060510100858.GA31504@elte.hu> <1147266235.3969.31.camel@frecb000686>
	 <1147271536.27820.288.camel@localhost.localdomain>
	 <20060510150140.GR14147@devserv.devel.redhat.com>
	 <1147280521.27820.329.camel@localhost.localdomain>
Date: Thu, 11 May 2006 10:56:57 +0200
Message-Id: <1147337817.3969.46.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/05/2006 10:55:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/05/2006 10:55:39,
	Serialize complete at 11/05/2006 10:55:39
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 19:02 +0200, Thomas Gleixner wrote:
> On Wed, 2006-05-10 at 11:01 -0400, Jakub Jelinek wrote:
> > But, there are 2 other futexes used by condvars - internal condvar's lock
> > and __data.__futex.  If the associated mutex uses PI protocol, then
> > I'm afraid the internal condvar lock needs to follow the same protocol
> > (i.e. use FUTEX_*LOCK_PI), otherwise a low priority task calling
> > pthread_cond_* and acquiring the internal lock, then scheduled away
> > indefinitely because of some middle-priority CPU hog could delay
> > some high priority task calling pthread_cond_* on the same condvar.
> 
> Did not think about __data.__lock
> 
> I said "hack_alert" explicitely as this was just a work around, so we
> could use an PI futex for the outer one, which was used to protect other
> things too. The assmebler code corrupted the lock field of the outer
> mutex with 0/1/2.

  Hm, I wonder what would be the effect of having the external mutex
and __data.__lock use a PI futex and __data.__futex use a regular
futex when the waiters on __data.__futex are requeued on the external
mutex during a broadcast.

> 
> > But, there is a problem here - pthread_cond_{signal,broadcast} don't
> > have any associated mutexes, so you often don't know which type
> > of protocol you want to use for the internal condvar lock.

  Just a wild guess here, but in the broadcast or signal path, couldn't
__data.__mutex be looked up to determine what protocol to use for the
__data.__futex?

> > Now, for the __data.__futex lock POSIX seems to be more clear,
> > all it says is that the wake up should happen according to the scheduling
> > policy (but, on the other side for pthread_mutex_unlock it says the same
> > and we still use FIFO there).
> 
> Sebastians patch might solve this.
> 
> Is there a way to (pre)set the policy of the inner lock or is there any
> other solution in sight ?

  As a corolary to the above couldn't the protocol used by the external
mutex dictates what the __data.__futex should use (PI or not)?

Maybe there is a need for something like a futex_requeue_pi() otherwise
we'll end up mixing PI and non-PI futexes or maybe I'm not understanding
the thing.

  Sébastien.




