Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWAJK2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAJK2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWAJK2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:28:52 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29386 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750784AbWAJK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:28:51 -0500
Date: Tue, 10 Jan 2006 15:58:51 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20060110102851.GB18325@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org> <43A985E6.CA9C600D@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A985E6.CA9C600D@tv-sign.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 07:42:14PM +0300, Oleg Nesterov wrote:
> Linus Torvalds wrote:
> > 
> > > > [ Oh.  I'm looking at the semaphore code, and I realize that we have a
> > > >   "wake_up(&sem->wait)" in the __down() path because we had some race long
> > > >   ago that we fixed by band-aiding over it. Which means that we wake up
> > > >   sleepers that shouldn't be woken up. THAT may well be part of the
> > > >   performance problem.. The semaphores are really meant to wake up just
> > > >   one at a time, but because of that race hack they'll wake up _two_ at a
> > > >   time - once by up(), once by down().
> > > >
> > > >   That also destroys the fairness. Does anybody remember why it's that
> > > >   way? ]
> > >
> > > History?
> > 
> > Oh, absolutely, I already checked the old BK history too, and that extra
> > wake_up() has been there at least since before we even started using BK.
> > So it's very much historical, I'm just wondering if somebody remembers far
> > enough back that we'd know.
> > 
> > I don't see why it's needed (since we re-try the "atomic_add_negative()"
> > inside the semaphore wait lock, and any up() that saw contention should
> > have always been guaranteed to do a wakeup that should fill the race in
> > between that atomic_add_negative() and the thing going to sleep).
> > 
> > It may be that it is _purely_ historical, and simply isn't needed. That
> > would be funny/sad, in the sense that we've had it there for years and
> > years ;)
> 
> This does not look like it was added to fix a race or historical
> to me. I think without that "wake_up" a waiter can miss wakeup
> if it is not the only one sleeper.
> 
> sem->count == 0, ->sleepers == 0. down() decrements ->count,
> 
> __down:
> 	// ->count == -1
> 
> 	++sleepers; // == 1
> 
> 	for (;;) {
> 		->count += (->sleepers - 1); // does nothing
> 		if (->count >= 0) // NO
> 			break;
> 
> 		->sleepers = 1;
> 		schedule();
> 	...
> 
> Another process calls down(), ->count == -2
> 
> __down:
> 	++sleepers; // == 2;
> 
> 	for (;;) {
> 		->count += (->sleepers - 1) // ->count == -1;
> 
> 		->sleepers = 1;
> 		schedule();
> 	...
> 
> up() makes ++->count == 0, and wakes one of them. It will see
> ->sleepers == 1, so atomic_add_negative(sleepers - 1) again
> has no effect, sets ->sleepers == 0 and takes the semaphore.
> 
> Note that subsequent up() will not call wakeup(): ->count == 0,
> it just increment it. That is why we are waking the next waiter
> in advance. When it gets cpu, it will decrement ->count by 1,
> because ->sleepers == 0. If up() (++->count) was already called,
> it takes semaphore. If not - goes to sleep again.
> 
> Or my understanding is completely broken?

Sorry for the delayed response, but I just started looking at the double
wakeup issue.

The analysis looks a bit confusing. We start with an initial count=0 and
after 2 down()'s and 2 up()'s, the final value of expected count==0, but
it seems like it is +1.

My analysis is based on your analysis and I have used your cool convention!

Lets assume that there are two tasks P1 and P2.

For a semaphore with ->count = 0 and ->sleepers = 0

If P1 does a down(), then

->count = -1 // decl

->sleepers++ //sleepers = 1

for (;;)
	sleepers = 1;
	->count += (sleepers - 1); // sleepers - 1 = 0, count = -1
	if (->count >= 0)  // count is -1
		break;
	->sleepers = 1;
	schedule();


Now, if there is another down() by P2

->count = -2 // decl
->sleepers++ // sleepers = 2

for (;;)
	sleepers = 2;
	->count += (sleepers - 1);	// (sleepers - 1) = 1, count = -1
	if (->count >= 0) // count is -1
		break;
	->sleepers = 1;
	schedule()


Consider some task doing an up()

->count++ //incl, count = 0, count was previously -1

This wakes up one of P1. P1 will do the following

	....
	spin_lock_irqsave(...)
	tsk->state = TASK_UNINTERRUPTIBLE

	and go back to the for loop

	sleepers = 1;
	->count += (sleepers - 1) // count += 0, count = 0
	if (count >= 0) {	// YES
		->sleepers = 0;
		break;
	}

	// outside the for loop
	remove_wait_queue_locked(->wait, &wait);

	wake_up_locked(->wait); // double wakeup
	tsk->state = TASK_UNINTERRUPTIBLE

The *double wakeup* will cause P2 to be woken up, it will do the following

	...
	....
	spin_lock_irqsave(...)
	tsk->state = TASK_UNINTERRUPTIBLE

	and go back to the for loop
	sleepers = 0; // the last task out of __down, set sleepers to 0
	->count += -1; // (sleepers - 1) = -1, count = -1

	if (count >= 0) // NO, count = -1
		break;

	sleepers = 1;
	spin_unlock_irqrestore(...)
	schedule()

without this *double wakeup*, the count would become 0, which is incorrect.

If some other task does an up() 
->count++ // incl, count = 0, was previously -1


This would wakeup P2, which would do the following

	....
	spin_lock_irqsave(...)
	tsk->state = TASK_UNINTERRUPTIBLE

	and go back to the for loop

	sleepers = 1;
	->count += 0;	// count = 0
	if (count >= 0) { // YES
		->sleepers = 0;
		break;
	}


The question now remains as to why we have the atomic_add_negative()? Why do
we change the count in __down(), when down() has already decremented it
for us?

Comments?

Balbir

PS: This analysis involved no caffeine, so it might be incorrect or bogus.
I did try and do my best to check its validity.
