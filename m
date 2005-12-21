Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVLUP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVLUP0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLUP0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:26:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26806 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932422AbVLUP0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:26:40 -0500
Message-ID: <43A985E6.CA9C600D@tv-sign.ru>
Date: Wed, 21 Dec 2005 19:42:14 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
	 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu>
	 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> > > [ Oh.  I'm looking at the semaphore code, and I realize that we have a
> > >   "wake_up(&sem->wait)" in the __down() path because we had some race long
> > >   ago that we fixed by band-aiding over it. Which means that we wake up
> > >   sleepers that shouldn't be woken up. THAT may well be part of the
> > >   performance problem.. The semaphores are really meant to wake up just
> > >   one at a time, but because of that race hack they'll wake up _two_ at a
> > >   time - once by up(), once by down().
> > >
> > >   That also destroys the fairness. Does anybody remember why it's that
> > >   way? ]
> >
> > History?
> 
> Oh, absolutely, I already checked the old BK history too, and that extra
> wake_up() has been there at least since before we even started using BK.
> So it's very much historical, I'm just wondering if somebody remembers far
> enough back that we'd know.
> 
> I don't see why it's needed (since we re-try the "atomic_add_negative()"
> inside the semaphore wait lock, and any up() that saw contention should
> have always been guaranteed to do a wakeup that should fill the race in
> between that atomic_add_negative() and the thing going to sleep).
> 
> It may be that it is _purely_ historical, and simply isn't needed. That
> would be funny/sad, in the sense that we've had it there for years and
> years ;)

This does not look like it was added to fix a race or historical
to me. I think without that "wake_up" a waiter can miss wakeup
if it is not the only one sleeper.

sem->count == 0, ->sleepers == 0. down() decrements ->count,

__down:
	// ->count == -1

	++sleepers; // == 1

	for (;;) {
		->count += (->sleepers - 1); // does nothing
		if (->count >= 0) // NO
			break;

		->sleepers = 1;
		schedule();
	...

Another process calls down(), ->count == -2

__down:
	++sleepers; // == 2;

	for (;;) {
		->count += (->sleepers - 1) // ->count == -1;

		->sleepers = 1;
		schedule();
	...

up() makes ++->count == 0, and wakes one of them. It will see
->sleepers == 1, so atomic_add_negative(sleepers - 1) again
has no effect, sets ->sleepers == 0 and takes the semaphore.

Note that subsequent up() will not call wakeup(): ->count == 0,
it just increment it. That is why we are waking the next waiter
in advance. When it gets cpu, it will decrement ->count by 1,
because ->sleepers == 0. If up() (++->count) was already called,
it takes semaphore. If not - goes to sleep again.

Or my understanding is completely broken?

Oleg.
