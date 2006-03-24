Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWCXNBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWCXNBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWCXNBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:01:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:14473 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964940AbWCXNBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:01:38 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603242334.19837.kernel@kolivas.org>
References: <1143198208.7741.8.camel@homer>
	 <200603242256.59795.kernel@kolivas.org> <1143202867.7741.76.camel@homer>
	 <200603242334.19837.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 14:02:22 +0100
Message-Id: <1143205342.7741.104.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 23:34 +1100, Con Kolivas wrote:
> On Friday 24 March 2006 23:21, Mike Galbraith wrote:
> > On Fri, 2006-03-24 at 22:56 +1100, Con Kolivas wrote:
> > > On Friday 24 March 2006 22:16, Mike Galbraith wrote:
> > > > This patch does various interactivity cleanups.
> > >
> > > I have trouble with this patch. By your own admission this patch does 4
> > > different things which one patch shouldn't.
> >
> > They're all part of the same thing, they're just cleanup.
> 
> Cleanup? Something that changes behaviour is not cleanup.

A semantic cleanup remains a cleanup.

> > > > 1.  Removes the barrier between kernel threads and user tasks wrt
> > > > dynamic priority handling.
> > >
> > > This is a bad idea. Subjecting a priority ceiling to kernel threads
> > > because they spend a long time idle is not the same as a user task that
> > > may be an idle bomb.
> >
> > Kernel threads don't make the transition, they're sitting there with a
> > fully loaded sleep_avg.  You stop on the way up, sure, but once there, a
> > long sleep doesn't truncate you.  Try it.
> 
> Threads like kswapd do not have a fully loaded sleep_avg.

Huh?  I've yet to see kswapd non-interactive.  If I do, I'll have
grounds to party, because the box would otherwise have been a doorstop.

> > >  Most kernel threads do sleep for extended periods and will always
> > > end up hitting this ceiling. That could lead to some difficult to
> > > understand latencies in scheduling of kernel threads, even if they are
> > > nice -5 because they'll expire very easily.
> >
> > No, they won't.  Furthermore, any kernel thread which cannot tolerate
> > dynamic priority semantics should not use them, they should be RT.
> 
> Very few kernel threads should require RT just to work as you just said, yet 
> you'll make it harder for them with your changed dynamic priority semantics. 
> We already know they are not going to be misbehaving userspace tasks and they 
> deserve simpler semantics than the full interactivity estimator gives.

They don't need to be treated special, and it is flat wrong to do so.
Try the patch set and you'll see that they continue to work just fine.

Consider this:  why should 10 copies of knfsd have any more right than
10 copies of apache to utterly monopolize my cpu?  Fact is, there is no
difference.  Both are acting on behalf other user tasks.  The fact that
one is a kernel thread means nothing.

> > > > 2.  Removes the priority barrier for IO.
> > >
> > > Bad again. This caused the biggest detriment on interbench numbers and is
> > > by far the most palpable interactivity killer in linux. I/O hurts us lots
> > > and this change will be very noticeable.
> >
> > This barrier is artificial, and has been demonstrated to be harmful to
> > some loads.
> 
> Which?

Remember the demonstration of dd being starved?

> > Being practical, if this is demonstrated to still cause 
> > trouble, I'll happily re-introduce it with a follow-up patch.
> 
> Trouble occurs months afterwards this hits mainline since you'll get almost 
> noone testing it in -mm. It was put there because it hurt interactivity and 
> you're removing it because you don't like that we have to put a special case 
> there?

Throttling changes this.  Believe it or not, I didn't just run around
with a machete looking for things to chop to ribbons.

> > > > 3.  Treats TASK_INTERACTIVE as a transition point that all tasks must
> > > > stop at prior to being promoted further.
> > >
> > > Why? Makes no sense. You end up getting hiccups in the rise of priority
> > > of tasks instead of it happening smoothly with sleep.
> >
> > Quite the opposite, it makes perfect sense.  Taking the long sleeper to
> > the artificial barrier of prio 16 as stock does is the very reason that
> > thud totally destroys the interactive experience.  I'd love to remove
> > this barrier too, and have 'purity', but OTOH, the interactive border
> > _is_ a transition point where the scheduler changes behavior.  This is a
> > transition point in fact, so treating it as such is indeed correct.
> 
> And what does it actually achieve making this change is my question?

It achieves precisely what the comment you placed there some odd years
ago says it should achieve.  Thud is a pure cpu hog that sleeps for a
while to charge it's battery for an intentional attack.  It was written
specifically to demonstrate the problem with allowing a long sleep to
rocket you to the top of the world as stock code does.  Try running the
stock kernel with irman2 and thud running, then you'll certainly
understand what this change achieves.

> I feel this discussion may degenerate beyond this point. Should we say to 
> agree to disagree at this point? I don't like these changes.

Why should it degenerate?  You express your concerns, I answer them.
You don't have to agree with me, and I don't have to agree with you.
That's no reason for the discussion to degenerate.

	-Mike



