Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGLDUF>; Thu, 11 Jul 2002 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317972AbSGLDUE>; Thu, 11 Jul 2002 23:20:04 -0400
Received: from waste.org ([209.173.204.2]:24233 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314395AbSGLDUE>;
	Thu, 11 Jul 2002 23:20:04 -0400
Date: Thu, 11 Jul 2002 22:22:38 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Sandy Harris <pashley@storm.ca>
cc: Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: spinlock assertion macros
In-Reply-To: <3D2E1A4D.10705EA5@storm.ca>
Message-ID: <Pine.LNX.4.44.0207112047021.15441-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Sandy Harris wrote:

> Oliver Xymoron wrote:
> >
> > On Thu, 11 Jul 2002, Daniel Phillips wrote:
> >
> > > I was thinking of something as simple as:
> > >
> > >    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
> > >
> > > but in truth I'd be happy regardless of the internal implementation.  A note
> > > on names: Linus likes to shout the names of his BUG macros.  I've never been
> > > one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> > > asserts.  I bet he'd like it more spelled like this though:
> > >
> > >    MUST_HOLD(&lock);
> >
> > I prefer that form too.
>
> Is it worth adding MUST_NOT_HOLD(&lock) in an attempt to catch potential
> deadlocks?

No, you'd rather do that inside the debugging version of spinlock itself.
I see MUST_HOLD happening inside helper functions that presume a lock is
in effect but don't do any on their own to ensure integrity, while
MUST_NOT_HOLD is a matter of forcing ordering and avoiding deadlocks.
Locking order is larger than functions and should be documented at the
point of declaration of the locks.

You can do lock order checking in the spinlock debugging code something
like this:

struct spinlock
{
	atomic_t val;
#ifdef SPINLOCK_DEBUG
	void *eip;
	struct spinlock *previous;
	struct spinlock *ordering;
};

DECLARE_SPINLOCK(a, 0); /* a is outermost for this group */
DECLARE_SPINLOCK(b, &a); /* b must nest inside a */
DECLARE_SPINLOCK(c, &b);

Each time you take a spinlock, record the eip, stick the address of the
current lock in the task struct, and stick the outer lock in previous.
Then see if the current lock appears anywhere in the previous lock's
ordering chain (it shouldn't). This may be a bit overkill though.

It might make sense to have a MAY_SLEEP assert in a few key places (high
up in the chains of things that rarely sleep or for which the call path to
sleeping isn't obvious).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

