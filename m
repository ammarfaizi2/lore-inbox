Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWCXMUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWCXMUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWCXMUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:20:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:46479 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422708AbWCXMUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:20:24 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603242256.59795.kernel@kolivas.org>
References: <1143198208.7741.8.camel@homer> <1143198459.7741.14.camel@homer>
	 <1143198964.7741.23.camel@homer>  <200603242256.59795.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 13:21:07 +0100
Message-Id: <1143202867.7741.76.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 22:56 +1100, Con Kolivas wrote:
> On Friday 24 March 2006 22:16, Mike Galbraith wrote:
> > This patch does various interactivity cleanups.
> 
> I have trouble with this patch. By your own admission this patch does 4 
> different things which one patch shouldn't.

They're all part of the same thing, they're just cleanup.

> > 1.  Removes the barrier between kernel threads and user tasks wrt
> > dynamic priority handling.
> 
> This is a bad idea. Subjecting a priority ceiling to kernel threads because 
> they spend a long time idle is not the same as a user task that may be an 
> idle bomb.

Kernel threads don't make the transition, they're sitting there with a
fully loaded sleep_avg.  You stop on the way up, sure, but once there, a
long sleep doesn't truncate you.  Try it.

>  Most kernel threads do sleep for extended periods and will always 
> end up hitting this ceiling. That could lead to some difficult to understand 
> latencies in scheduling of kernel threads, even if they are nice -5 because 
> they'll expire very easily.

No, they won't.  Furthermore, any kernel thread which cannot tolerate
dynamic priority semantics should not use them, they should be RT.

> > 2.  Removes the priority barrier for IO.
> 
> Bad again. This caused the biggest detriment on interbench numbers and is by 
> far the most palpable interactivity killer in linux. I/O hurts us lots and 
> this change will be very noticeable.

This barrier is artificial, and has been demonstrated to be harmful to
some loads.  Being practical, if this is demonstrated to still cause
trouble, I'll happily re-introduce it with a follow-up patch.

> > 3.  Treats TASK_INTERACTIVE as a transition point that all tasks must
> > stop at prior to being promoted further.
> 
> Why? Makes no sense. You end up getting hiccups in the rise of priority of 
> tasks instead of it happening smoothly with sleep.

Quite the opposite, it makes perfect sense.  Taking the long sleeper to
the artificial barrier of prio 16 as stock does is the very reason that
thud totally destroys the interactive experience.  I'd love to remove
this barrier too, and have 'purity', but OTOH, the interactive border
_is_ a transition point where the scheduler changes behavior.  This is a
transition point in fact, so treating it as such is indeed correct.

	-Mike

