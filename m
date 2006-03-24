Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWCXMer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWCXMer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCXMeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:34:46 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:57573 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932145AbWCXMeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:34:46 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 23:34:19 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <200603242256.59795.kernel@kolivas.org> <1143202867.7741.76.camel@homer>
In-Reply-To: <1143202867.7741.76.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242334.19837.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 23:21, Mike Galbraith wrote:
> On Fri, 2006-03-24 at 22:56 +1100, Con Kolivas wrote:
> > On Friday 24 March 2006 22:16, Mike Galbraith wrote:
> > > This patch does various interactivity cleanups.
> >
> > I have trouble with this patch. By your own admission this patch does 4
> > different things which one patch shouldn't.
>
> They're all part of the same thing, they're just cleanup.

Cleanup? Something that changes behaviour is not cleanup.
>
> > > 1.  Removes the barrier between kernel threads and user tasks wrt
> > > dynamic priority handling.
> >
> > This is a bad idea. Subjecting a priority ceiling to kernel threads
> > because they spend a long time idle is not the same as a user task that
> > may be an idle bomb.
>
> Kernel threads don't make the transition, they're sitting there with a
> fully loaded sleep_avg.  You stop on the way up, sure, but once there, a
> long sleep doesn't truncate you.  Try it.

Threads like kswapd do not have a fully loaded sleep_avg.

> >  Most kernel threads do sleep for extended periods and will always
> > end up hitting this ceiling. That could lead to some difficult to
> > understand latencies in scheduling of kernel threads, even if they are
> > nice -5 because they'll expire very easily.
>
> No, they won't.  Furthermore, any kernel thread which cannot tolerate
> dynamic priority semantics should not use them, they should be RT.

Very few kernel threads should require RT just to work as you just said, yet 
you'll make it harder for them with your changed dynamic priority semantics. 
We already know they are not going to be misbehaving userspace tasks and they 
deserve simpler semantics than the full interactivity estimator gives.

> > > 2.  Removes the priority barrier for IO.
> >
> > Bad again. This caused the biggest detriment on interbench numbers and is
> > by far the most palpable interactivity killer in linux. I/O hurts us lots
> > and this change will be very noticeable.
>
> This barrier is artificial, and has been demonstrated to be harmful to
> some loads.

Which?

> Being practical, if this is demonstrated to still cause 
> trouble, I'll happily re-introduce it with a follow-up patch.

Trouble occurs months afterwards this hits mainline since you'll get almost 
noone testing it in -mm. It was put there because it hurt interactivity and 
you're removing it because you don't like that we have to put a special case 
there?

> > > 3.  Treats TASK_INTERACTIVE as a transition point that all tasks must
> > > stop at prior to being promoted further.
> >
> > Why? Makes no sense. You end up getting hiccups in the rise of priority
> > of tasks instead of it happening smoothly with sleep.
>
> Quite the opposite, it makes perfect sense.  Taking the long sleeper to
> the artificial barrier of prio 16 as stock does is the very reason that
> thud totally destroys the interactive experience.  I'd love to remove
> this barrier too, and have 'purity', but OTOH, the interactive border
> _is_ a transition point where the scheduler changes behavior.  This is a
> transition point in fact, so treating it as such is indeed correct.

And what does it actually achieve making this change is my question? 

I feel this discussion may degenerate beyond this point. Should we say to 
agree to disagree at this point? I don't like these changes.

Cheers,
Con
