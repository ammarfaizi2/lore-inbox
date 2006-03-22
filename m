Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWCVERy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWCVERy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWCVERy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:17:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:1933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750747AbWCVERy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:17:54 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <20060321175004.GA27303@w.ods.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <1142949690.7807.80.camel@homer> <200603220117.54822.kernel@kolivas.org>
	 <200603220220.11368.kernel@kolivas.org>  <20060321175004.GA27303@w.ods.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 05:18:01 +0100
Message-Id: <1143001081.11047.61.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:50 +0100, Willy Tarreau wrote:
> On Wed, Mar 22, 2006 at 02:20:10AM +1100, Con Kolivas wrote:
> > On Wednesday 22 March 2006 01:17, Con Kolivas wrote:
> > > I actually believe the same effect can be had by a tiny 
> > > modification to enable/disable the estimator anyway.
> > 
> > Just for argument's sake it would look something like this.
> > 
> > Cheers,
> > Con
> > ---
> > Add sysctl to enable/disable cpu scheduer interactivity estimator
> 
> At least, in May 2005, the equivalent of this patch I tested on
> 2.6.11.7 considerably improved responsiveness, but there was still
> this very annoying slowdown when the load increased. vmstat delays
> increased by one second every 10 processes. I retried again around
> 2.6.14 a few months ago, and it was the same. Perhaps Mike's code
> and other changes in 2.6-mm really fix the initial problem (array
> switching ?) and then only the interactivity boost is causing the
> remaining trouble ?

The slowdown you see is because a timeslice is 100ms, and that patch
turned the scheduler into a non-preempting pure round-robin slug.

Array switching is only one aspect, and one I hadn't thought of as I was
tinkering with my patches, I discovered that aspect by accident.

My code does a few things, and all of them are part of the picture.  One
of them is to deal with excessive interactive boost.  Another is to
tighten timeslice enforcement, and another is to close the fundamental
hole in the concept sleep_avg.  That hole is causing the majority of the
problems that crop up, the interactivity bits only make it worse.  The
hole is this.  If priority is based solely upon % sleep time, even if
there is no interactive boost, even if accumulation vs consumption is
1:1, if you sleep 51% of the time, you will inevitably rise to max
priority, and be able to use 49% of the CPU at max priority forever.
The current heuristics make that very close to but not quite 95%.

The fact that we don't have _horrendous_ problems shows that the basic
concept of sleep_avg is pretty darn good.  Close the hole in any way you
can think of (mine is one), and it's excellent.

