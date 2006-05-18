Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWERHDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWERHDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWERHDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:03:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:3545 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750726AbWERHDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:03:50 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605181552.19868.kernel@kolivas.org>
References: <4t16i2$142pji@orsmga001.jf.intel.com>
	 <200605181138.26399.kernel@kolivas.org> <1147931064.7514.39.camel@homer>
	 <200605181552.19868.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 09:04:38 +0200
Message-Id: <1147935878.7481.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 15:52 +1000, Con Kolivas wrote:
> On Thursday 18 May 2006 15:44, Mike Galbraith wrote:
> > On Thu, 2006-05-18 at 11:38 +1000, Con Kolivas wrote:
> > > I just want to formalise the relationship between the ceiling, nice
> > > value and INTERACTIVE_SLEEP and make the comment clear enough to be
> > > understood.
> >
> > Oh yeah, that reminded me...
> >
> > INTERACTIVE_SLEEP(p) for nice(>=16) tasks is > NS_MAX_SLEEP_AVG.
> > CURRENT_BONUS(p) if it took the long sleep path can end up being 11,
> > which will lead to Ka-[fword]-BOOM in scheduler_tick() for an SMP box.
> > See TIMESLICE_GRANULARITY(p).  (btdt;)
> 
> Thanks. This updated one fixes that and clears up the remaining mystery of
> why the ceiling is the size it is in the comments.

OK, after some brief testing, I think this is a step in the right
direct, but there is another problem.  In the case where the queue isn't
empty, the stated intent is utterly defeated by the on runqueue bonus.

If you fix this, the thud and irman2 kind of pain mostly goes away for
interactive tasks, and a lot of starvation scenarios go as well.

The best way I've found to fix these kind of boost problems is to just
say no if the task is using more than it's fair share of cpu, and in NO
case, let one wait rocket you to the top... that sets you up for a queue
round-robin nightmare (my interactive feeding frenzy scenario).  It
doesn't take much for tasks that nanosleep and round-robin before it
becomes impossible for them to use their sleep_avg.  I would say nuke
that code, except that it is the only chance at fairness some tasks
have.  Nuking it is definitely easier that getting it right.

	-Mike

