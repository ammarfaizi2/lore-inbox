Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317788AbSGLUi5>; Fri, 12 Jul 2002 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317959AbSGLUi4>; Fri, 12 Jul 2002 16:38:56 -0400
Received: from waste.org ([209.173.204.2]:20868 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317788AbSGLUiu>;
	Fri, 12 Jul 2002 16:38:50 -0400
Date: Fri, 12 Jul 2002 15:41:23 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@arcor.de>
cc: Dave Jones <davej@suse.de>, Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: spinlock assertion macros
In-Reply-To: <E17Szx2-0002es-00@starship>
Message-ID: <Pine.LNX.4.44.0207121533590.15441-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Daniel Phillips wrote:

> On Friday 12 July 2002 14:07, Dave Jones wrote:
> > On Thu, Jul 11, 2002 at 09:17:44PM +0200, Daniel Phillips wrote:
> >  > On Thursday 11 July 2002 20:03, Jesse Barnes wrote:
> >  > > How about this?
> >  >
> >  > It looks good, the obvious thing we don't get is what the actual lock
> >  > count is, and actually, we don't care because we know what it is in
> >  > this case.
> >
> > Something I've been meaning to hack up for a while is some spinlock
> > debugging code that adds a FUNCTION_SLEEPS() to (ta-da) functions that
> > may sleep.
>
> Yesss.  May I suggest simply SLEEPS()?  (Chances are, we know it's a
> function.)
>
> > This macro then checks whether we're currently holding any
> > locks, and if so printk's the names of locks held, and where they were taken.
>
> And then oopes?
>
> > When I came up with the idea[1] I envisioned some linked-lists frobbing,
> > but in more recent times, we can now check the preempt_count for a
> > quick-n-dirty implementation (without the additional info of which locks
> > we hold, lock-taker, etc).
>
> Spin_lock just has to store the address/location of the lock in a
> per-cpu vector, and the assert prints that out when it oopses.  Such
> bugs won't live too long under those conditions.

Store it in the task struct, and store a pointer to the previous (outer
lock) in that lock, then you've got a linked list of locks per task - very
useful. You'll need a helper function - current() is hard to get at from
spinlock.h due to tangled dependencies. As I mentioned before, it can also
be very handy to stash the address of the code that took the lock in the
lock itself.

> Any idea how one might implement NEVER_SLEEPS()?  Maybe as:
>
>    NEVER_ [code goes here] _SLEEPS
>
> which inc/dec the preeempt count, triggering a BUG in schedule().

NEVER_SLEEPS will only trigger on the rare events that blow up anyway,
while the MAY_SLEEP version catches _potential_ problems even when the
fatal sleep doesn't happen.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

