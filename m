Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSFEQRa>; Wed, 5 Jun 2002 12:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFEQRa>; Wed, 5 Jun 2002 12:17:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61173 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315479AbSFEQR3>; Wed, 5 Jun 2002 12:17:29 -0400
Subject: Re: [PATCH] scheduler hints
From: Robert Love <rml@tech9.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CFDC796.C05FC7E2@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 09:17:13 -0700
Message-Id: <1023293838.917.283.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 01:11, Helge Hafting wrote:

> Seems to me this particular case is covered by increasing
> priority when grabbing the semaphore and normalizing
> priority when releasing.  
> 
> Only root can do that - but only root does real-time
> anyway. And I guess only rood should be able to increase 
> its timeslice too...

Increasing its priority has no bearing on whether it runs out of
timeslice, however.  The idea here is to help the task complete its
critical section (and thus not block other tasks) before being
preempted.  Only way to achieve that is boost its timeslice.

Boosting its priority will assure there is no priority inversion and
that, eventually, the task will run - but it does nothing to avoid the
nasty "grab resource, be preempted, reschedule a bunch, finally find
yourself running again since everyone else blocked" issue.

And I don't think only root should be able to do this.  If we later
punish the task (take back the timeslice we gave it) then this is fair.

> > Other hints could be "I am interactive" 
>
> Already shows up as a thread who always ends its timeslice
> blocking for io.  Such threads do get an priority
> boost for the next timeslice.
> 
> > or "I am a batch (i.e. cpu hog)
>
> shows up as a thread who spends its entire timeslice - these
> don't get the above mentioned boost as it is assumed it gets
> "enough cpu" while the interactive threads blocks.
>
> Well, hog/interactive is determined in one timeslice already...

In the O(1) scheduler it is determined based on a running sleep average,
not timeslice used (this is effectively the same thing - although we
turn it into a heuristic so it is more accurate over time).

The problem is it takes time to figure these out.  One whole schedule of
the app to determine anything, and then a series of schedules to perfect
it.  My idea here was let the app tell the system what it is to give the
system a head start.  The scheduler will slowly readjust whatever it is
told, based on the task's behavior, anyhow.

Giving a hint at the start of an interactive task, for example, skips
the second or two of low priority where the task is not receiving its
full boost.

> The problem is that this may be abused.  Someone nasty could
> write a cpu hog that drops a lot of hints about being
> interactive, starving real interactive programs.

Agreed.  The code does require CAP_SYS_NICE and the comments explain the
issue... One thing worth saying is I don't think this is as useful as
the HINT_TIME hint anyhow.

> Generally, it degenerates into application programmers
> using _all_ the hints to get performance, so they
> can beat some competitor in benchmarks.  And all
> other programs just get penalized.

Well they can already nice themselves or make themselves real-time, so
we have to trust them in numerous ways already not to cheat.

	Robert Love

