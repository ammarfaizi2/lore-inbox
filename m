Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSGMDRs>; Fri, 12 Jul 2002 23:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSGMDRr>; Fri, 12 Jul 2002 23:17:47 -0400
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:9187 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318085AbSGMDRo>;
	Fri, 12 Jul 2002 23:17:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: spinlock assertion macros
Date: Sat, 13 Jul 2002 05:21:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@suse.de>, Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207121533590.15441-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0207121533590.15441-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17TDTB-0002hg-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 22:41, Oliver Xymoron wrote:
> On Fri, 12 Jul 2002, Daniel Phillips wrote:
> > On Friday 12 July 2002 14:07, Dave Jones wrote:
> > > Something I've been meaning to hack up for a while is some spinlock
> > > debugging code that adds a FUNCTION_SLEEPS() to (ta-da) functions that
> > > may sleep.
> >
> > Yesss.  May I suggest simply SLEEPS()?  (Chances are, we know it's a
> > function.)
> >
> > > This macro then checks whether we're currently holding any
> > > locks, and if so printk's the names of locks held, and where they were taken.
> >
> > And then oopes?
> >
> > > When I came up with the idea[1] I envisioned some linked-lists frobbing,
> > > but in more recent times, we can now check the preempt_count for a
> > > quick-n-dirty implementation (without the additional info of which locks
> > > we hold, lock-taker, etc).
> >
> > Spin_lock just has to store the address/location of the lock in a
> > per-cpu vector, and the assert prints that out when it oopses.  Such
> > bugs won't live too long under those conditions.
> 
> Store it in the task struct, and store a pointer to the previous (outer
> lock) in that lock, then you've got a linked list of locks per task - very
> useful.

Yes, thanks, I was in fact feeling a little guilty about proposing that
non-nested solution, even if it would in practice point you at the
correct culprit most of the time.

So in schedule() we check the task struct field and oops if it's non-null.
In other words, one instance of SLEEPS goes in shedule() and others are
sprinkled around the kernel as executable documentation.

> You'll need a helper function - current() is hard to get at from
> spinlock.h due to tangled dependencies.

What is the problem?  It looks like (struct thread_info *) can be forward
declared, and hence current_thread_info and get_current can be defined
early.  Maybe I didn't sniff at enough architectures.

Anyway, if there are nasty dependencies then they are probably similar
to the ones I unravelled with my early-page patch, which allows struct
page to be declared right at the start of mm.h instead of way later,
below a lot of things that want to reference it.

> As I mentioned before, it can also
> be very handy to stash the address of the code that took the lock in the
> lock itself.

And since the stack is chained through the locks, that just works.
 
> > Any idea how one might implement NEVER_SLEEPS()?  Maybe as:
> >
> >    NEVER_ [code goes here] _SLEEPS
> >
> > which inc/dec the preeempt count, triggering a BUG in schedule().
> 
> NEVER_SLEEPS will only trigger on the rare events that blow up anyway,
> while the MAY_SLEEP version catches _potential_ problems even when the
> fatal sleep doesn't happen.

Yes, that one's already been rejected as largely pointless.

-- 
Daniel
