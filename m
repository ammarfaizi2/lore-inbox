Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWERIq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWERIq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWERIq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:46:56 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:13460 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750781AbWERIq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:46:56 -0400
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20060516103644.GH25570@devserv.devel.redhat.com>
References: <20060510112651.24a36e7b@frecb000686>
	 <20060510100858.GA31504@elte.hu> <1147266235.3969.31.camel@frecb000686>
	 <1147271536.27820.288.camel@localhost.localdomain>
	 <20060510150140.GR14147@devserv.devel.redhat.com>
	 <1147280521.27820.329.camel@localhost.localdomain>
	 <1147337817.3969.46.camel@frecb000686>
	 <20060516103644.GH25570@devserv.devel.redhat.com>
Date: Thu, 18 May 2006 10:51:16 +0200
Message-Id: <1147942276.4996.23.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:50:00,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:50:03,
	Serialize complete at 18/05/2006 10:50:03
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 06:36 -0400, Jakub Jelinek wrote:
> On Thu, May 11, 2006 at 10:56:57AM +0200, S?bastien Dugu? wrote:
> >   Hm, I wonder what would be the effect of having the external mutex
> > and __data.__lock use a PI futex and __data.__futex use a regular
> > futex when the waiters on __data.__futex are requeued on the external
> > mutex during a broadcast.
> 
> Well, either glibc can stop using requeue if the mutex is PI mutex (and use
> the slower fallback), or kernel would need to handle requeueing from normal to
> PI futex.

  Yes, or make the condvar use a PI futex and implement a 
futex_requeue_pi() and have glibc use that in the broadcast case. I 
think the requeue thing is a good idea and should not be dropped.

> 
> > > > But, there is a problem here - pthread_cond_{signal,broadcast} don't
> > > > have any associated mutexes, so you often don't know which type
> > > > of protocol you want to use for the internal condvar lock.
> > 
> >   Just a wild guess here, but in the broadcast or signal path, couldn't
> > __data.__mutex be looked up to determine what protocol to use for the
> > __data.__futex?
> 
> Not always.
> Say if you do:
> thread1 (low prio)	thread2 (very high prio)		thread3 (mid prio)
> pthread_cond_signal (&cv)
> # first use of cv in the program, no mutex has been ever used with this
> # condvar
> lll_mutex_lock (&cv->__data.__lock)
> 			pthread_cond_wait (&cv, &pi_mutex)
> 			lll_mutex_lock (&cv->__data.__lock)
> 								use_all_CPU
> 			# Then thread2 is stuck, waiting on thread1 which waits on thread3
> 
> At pthread_cond_signal enter time you don't know the type of associated
> mutex, so you don't know which kind of internal lock to use.
> It doesn't have to be the first use of cv in the program, similarly it can
> be any pthread_cond_{signal,broadcast} called while there are no threads
> in pthread_cond_*wait on that cv.

  OK, it makes sense now, thanks.

  Sébastien.

