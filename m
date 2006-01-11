Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWAKGd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWAKGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbWAKGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:33:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:23186 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932699AbWAKGd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:33:26 -0500
Date: Wed, 11 Jan 2006 12:03:22 +0530
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
Message-ID: <20060111063322.GA9261@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org> <43A985E6.CA9C600D@tv-sign.ru> <20060110102851.GB18325@in.ibm.com> <43C3F6DB.FEFDA101@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3F6DB.FEFDA101@tv-sign.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:03:07PM +0300, Oleg Nesterov wrote:
> Balbir Singh wrote:
> >
> > On Wed, Dec 21, 2005 at 07:42:14PM +0300, Oleg Nesterov wrote:
> > >
> > > Note that subsequent up() will not call wakeup(): ->count == 0,
> > > it just increment it. That is why we are waking the next waiter
> > > in advance. When it gets cpu, it will decrement ->count by 1,
> > > because ->sleepers == 0. If up() (++->count) was already called,
> > > it takes semaphore. If not - goes to sleep again.
> > >
> > > Or my understanding is completely broken?
> >
> > [ ... long snip ... ]
> >
> > The question now remains as to why we have the atomic_add_negative()? Why do
> > we change the count in __down(), when down() has already decremented it
> > for us?
> 
> ... and why __down() always sets ->sleepers = 0 on return.
>

I think sem->sleepers initially started as a counter, but was later converted
to a boolean value (0 or 1). The only possible values of sem->sleepers is 0, 1
or 2 and we always use sem->sleepers - 1 and set the value to either 0 or 1.

sem->sleepers is set to 0, so that when the double wakeup is called on the
wait queue, the task that wakes up (P2) corrects the count to 
(sem->sleepers - 1) = -1. This ensures that other tasks do not acquire 
the semaphore with down() (count is -1) and P2 sets sem->sleepers back to 1 
and sleeps.

 
> I don't have an answer, only a wild guess.
> 
> Note that if P1 releases this semaphore before pre-woken P2 actually
> gets cpu what happens is:
> 
> 	P1->up() just increments ->count, no wake_up() (fastpath)
> 
> 	P2 takes the semaphore without schedule.
> 
> So *may be* it was designed this way as some form of optimization,
> in this scenario P2 has some chances to run with sem held earlier.
>

P1->up() will do a wake_up() only if count < 0. For no wake_up()
the count >=0 before the increment. This means that there is no one
sleeping on the semaphore.
 
Feel free to correct me,
Balbir
