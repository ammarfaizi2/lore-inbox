Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbRB1XLg>; Wed, 28 Feb 2001 18:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRB1XLX>; Wed, 28 Feb 2001 18:11:23 -0500
Received: from nwcst340.netaddress.usa.net ([204.68.23.85]:4527 "HELO
	nwcst340.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S129309AbRB1XKA> convert rfc822-to-8bit; Wed, 28 Feb 2001 18:10:00 -0500
Message-ID: <20010228230958.7613.qmail@nwcst340.netaddress.usa.net>
Date: 28 Feb 2001 17:09:58 CST
From: Neelam Saboo <neelam_saboo@usa.net>
To: Andrew Morton <andrewm@uow.edu.au>,
        David Mansfield <lkml@dm.ultramaster.com>
Subject: Re: [Re: paging behavior in Linux]
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
X-Mailer: USANET web-mailer (34FM.0700.15B.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another observation. I have two independent programs. One program incurring
page faults and another program just doing some work.
When work program run undependently it takes ~19 seconds of CPU time, but when
it is run along with page faulting program on the same machine, it takes ~32
seconds of CPU time. Doesnt this indicate that page faults in a program slows
down all the program on the machine and not only threads in the same process
?

neelam

Andrew Morton <andrewm@uow.edu.au> wrote:
> David Mansfield wrote:
> > 
> > Manfred Spraul wrote:
> > >
> > > >
> > > > When I run my program on a readhat linux machine, I dont get results
as
> > > > expected, work thread seems to be stuck when prefetch thread is
waiting on
> > > > a page fault
> > > >
> > > That's a known problem:
> > >
> > > The paging io for a process is controlled with a per-process semaphore.
> > > The semaphore is held while waiting for the actual io. Thus the paging
> > > in multi threaded applications is single threaded.
> > > Probably your prefetch thread is waiting for disk io, and the worker
> > > thread causes a minor pagefault --> worker thread sleeps until the disk
> > > io is completed.
> > 
> > This behavior is actually pretty annoying.  There can be cases where a
> > process wakes up from a page fault, does some work, goes back to sleep
> > on a page fault, thereby keeping it's mmap_sem locked at all times (i.e.
> > vmstat, top, ps unusable) on a UP system.  I posted this complaint a
> > while ago, it was discussed by Linus and Andrew Morton about how it also
> > boiled down to semaphore wakeup unfairness (and bugs?).  The current
> > semaphore was determined to be too ugly to even look at.  So it was
> > dropped.
> > 
> > Is there any way that the mmap_sem could be dropped during the blocking
> > on I/O, and reclaimed after the handle_mm_fault?  Probably not, or it'd
> > be done.
> > 
> > It can be a real DOS though, a 'well-written' clobbering program can
> > make ps/vmstat useless.  (it's actually /proc/pid/stat that's the
> > killer, IIRC).
> 
> Did the `goto inside' trick in the semaphore code actually
> fix this unfairness issue?
> 
> -


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
