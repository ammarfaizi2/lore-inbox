Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRBSTLh>; Mon, 19 Feb 2001 14:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbRBSTL1>; Mon, 19 Feb 2001 14:11:27 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:12817 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130202AbRBSTLR>; Mon, 19 Feb 2001 14:11:17 -0500
Date: Mon, 19 Feb 2001 20:11:14 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: The lack of specification (was Re: [LONG RANT] Re: Linux stifles innovation... )
In-Reply-To: <Pine.LNX.3.96.1010219102055.17842O-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.3.96.1010219191533.6201A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I suspect part of the problem with commercial driver support on Linux is that
> > > > the Linux driver API (such as it is) is relatively poorly documented
> > > 
> > > In-kernel documentation, agreed.
> > > 
> > > _Linux Device Drivers_ is a good reference for 2.2 and below.
> > 
> > And do implementators of generic kernel functions and developers of device
> > drivers respect it? And how can they respect it if it's a commercial book?
> 
> _Linux Device Drivers_ documents the 2.2 (and previous) API, and
> thus refutes the argument that the kernel API is poorly documented.
> Since the publication of the book -succeeds- the publication of the
> APIs, your questions are not applicable.

What does it say about mark_buffer_dirty blocking or schedule and
TASK_[UN]INTERRUPTIBLE issues? If it says nothing, it is bad
documentation. If it says something, kernel developers do not respect it
and it is useless documentation...

> > > > and seems
> > > > to change almost on a week-by-week basis anyway. I've done my share of chasing
> > > > the current kernel revision with drivers that aren't part of the kernel tree:
> > > > by the time you update the driver to work with the current kernel revision,
> > > > there's a new one out, and the driver doesn't compile with it.
> > > 
> > > This is entirely in your imagination.  Driver APIs are stable across the
> > > stable series of kernels: 2.0.0 through 2.0.38, 2.2.0 through 2.2.18,
> > > 2.4.0 through whatever.
> > 
> > No true. Do you remember for example the mark_buffer_dirty change in some
> > 2.2.x that triggered ext2 directory corruption? (mark_buffer_dirty was
> > changed so that it could block). 
> > 
> > Another example of bug that comes from the lack of specification is
> > calling of get_free_pages by non-running processes that caused lockups on
> > all kernels < 2.2.15. And it is still not cleaned up - see tcp_recvmsg(). 
> > 
> > Having documentation could prevent this kind of bugs.
> 
> Hardly.

Imagine that there is specification of mark_buffer_dirty. That
specification says that
	1. it may not block
	2. it may block

In case 1. implementators wouldn't change it to block in stable kernel
	relese because they don't want to violate the specification.

In case 2. implementators of ext2 wouldn't assume that it doesn't block
	even if it doesn't in current implementation.

In both cases, the bug wouldn't be created.

> No documentation is often -better- than bad documentation.

Of course. But good documentation is better than no documentation :-)

> > You don't need too
> > long texts, just a brief description: "this function may be called from
> > process/bh/interrupt context, it may/may not block, it may/may not be
> > called in TASK_[UN]INTERURPTIBLE state, it may take these locks."
> > 
> > With documentation developers would be able to change implementation of
> > kernel functions without the need to recheck all drivers that use them. 
> 
> Anytime you change implementation, you gotta check all drivers that use
> them.  I know, I'm one of the grunts that does such reviews and changes.

Anytime you change implementation of syscalls, you gotta check all
applications that use them ;-) Luckily not - because there is
specification and you can check that syscalls conform to the
specification, not apps. 

> > Saying "code is the specification" is not good.
> 
> I'm not arguing against documentation.  That is dumb.  But the code is
> ALWAYS canonical.  Not docs.

Let's see:

There are parts of code (1) that set state to TASK_[UN]INTERRUPTIBLE and
then call some other complex functions, like page fault handlers. (for
example tcp in 2.2)

There are parts of code (2) that call schedule to yield the process
assuming that the state is TASK_RUNNING. (including some drivers) 

Sooner or later will happen, that subroutine called from part (1) get
somehow to part (2) and the process locks up.


Now implementators of TCP will say: that driver is buggy. Everybody should
set state=TASK_RUNNING before calling schedule to yield the process. 

Implementators of driver will say: TCP is buggy - no one should call my
driver in TASK_[UN]INTERRUPTIBLE state.

Who is right? If there is no specification....

Mikulas

