Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163026AbWLBOmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163026AbWLBOmX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163028AbWLBOmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:42:22 -0500
Received: from www.osadl.org ([213.239.205.134]:13471 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1163026AbWLBOmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:42:21 -0500
Subject: Re: [RFC] timers, pointers to functions and type safety
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061202140521.GJ3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk>
	 <1165064370.24604.36.camel@localhost.localdomain>
	 <20061202140521.GJ3078@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 15:45:12 +0100
Message-Id: <1165070713.24604.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 14:05 +0000, Al Viro wrote:
> On Sat, Dec 02, 2006 at 01:59:30PM +0100, Thomas Gleixner wrote:
> > On Fri, 2006-12-01 at 17:21 +0000, Al Viro wrote:
> > > Now, there's another question: how do we get there?  Or, at least, from
> > > current void (*)(unsigned long) to void (*)(void *)...
> > 
> > I think the real solution should be 
> > 
> > 	void (*function)(struct timer_list *timer);
> > 
> > and hand the timer itself to the callback. Most of the timers are
> > embedded into data structures anyway and for the rest we can easily
> > build one.
> 
> Ewwwwwww....
> 
> Let's not.  It means more cruft in callbacks for no good reason.

What's the cruft ? 

struct bla = container_of(timer, struct bla, timer); ???

> And more cruft in code setting it up, while we are at it.

Err, you remove the timer->data = (unsigned long) hackery. Why is this
adding cruft ?

I looked deeper into it. We have following timer usage:

- timers which don't use data at all - no change except for the callback
argument of the function.

- timers which point to the data structure which embedds them - only the
callback has to get a container_of()

- static single instance timers, which use .data as local storage for
some value. That can be done with a simple static variable near the
timer and using that variable instead of .data

- some rather seldom multi instance timers, which need then to become a
data structure.

> > > "A fscking huge patch flipping everything at once" is obviously not an
> > > answer; too much PITA merging and impossible to review.
> > 
> > There are ~ 500 files affected and this is in the range of cleanups we
> > did recently at the end of the merge window already. I'd volunteer to
> > hack this up and keep the patch up to date until the final merge. I have
> > done that before and I'm not scared about it. The patches are a couple
> > of lines per file and I do not agree that this is impossible to review. 
> 
> I'd rather see that as patch series, TYVM.  And no, it won't be a couple
> of lines per file with your variant.

It will. Just some random files:

 arch/alpha/kernel/srmcons.c             |    7 +++--
 arch/arm/mach-pxa/lubbock.c             |    7 +++--
 arch/i386/kernel/tsc.c                  |    2 -
 arch/i386/mach-voyager/voyager_thread.c |    2 -
 arch/ia64/kernel/mca.c                  |    8 +++---
 arch/ia64/kernel/salinfo.c              |    2 -
 arch/ia64/sn/kernel/mca.c               |    2 -
 arch/ia64/sn/kernel/xpc_channel.c       |    3 --
 arch/ia64/sn/kernel/xpc_main.c          |    5 +++-
 arch/mips/lasat/picvue_proc.c           |    2 -
 arch/mips/sgi-ip22/ip22-reset.c         |   17 +++++++------
 include/asm-ia64/sn/xpc.h               |    2 -

> Anyway, I'm doing that series in my tree, will post when it's over...

Same here :)

	tglx


