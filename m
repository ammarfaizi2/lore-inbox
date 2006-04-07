Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWDGNhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWDGNhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWDGNhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:37:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:43907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964794AbWDGNhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:37:39 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200604072256.27665.kernel@kolivas.org>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 15:37:44 +0200
Message-Id: <1144417064.8114.26.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 22:56 +1000, Con Kolivas wrote:
> On Friday 07 April 2006 19:38, Mike Galbraith wrote:
> > Greetings,
> >
> > Problem:  Wake-up -> cpu latency increases with the number of runnable
> > tasks, ergo adding this latency to sleep_avg becomes increasingly potent
> > as nr_running increases.  This turns into a very nasty problem with as
> > few as 10 httpd tasks doing round robin scheduling.  The result is that
> > you can only login with difficulty, and interactivity is nonexistent.
> >
> > Solution:  Restrict the amount of boost a task can receive from this
> > mechanism, and disable the mechanism entirely when load is high.  As
> > always, there is a price for increasing fairness.  In this case, the
> > price seems worth it.  It bought me a usable 2.6 apache server.
> 
> Since this is an RFC, here's my comments :)
> 
> This mechanism is designed to convert on-runqueue waiting time into sleep. The 
> basic reason is that when the system is loaded, every task is fighting for 
> cpu even if they only want say 1% cpu which means they never sleep and are 
> waiting on a runqueue instead of sleeping 99% of the time. What you're doing 
> is exactly biasing against what this mechanism is in place for. You'll get 
> the same effect by bypassing or removing it entirely. Should we do that 
> instead?

Heck no.  That mechanism is just as much about fairness as it is about
intertactivity, and as such is just fine and dandy in my book... once
it's toned down a bit^H^H^Htruckload.  What I'm doing isn't biasing
against the intent, I'm merely straightening the huge bend in favor of
interactive tasks who get this added boost over and over again, and
restricting the general effect to something practical.

Just look at what that mechanism does now with a 10 deep queue.  Every
dinky sleep can have an absolutely huge gob added to it, the exact worst
case number depends on how many cpus you have and whatnot.  Start a slew
of tasks, and you are doomed to have every task that sleeps for the
tiniest bit pegged at max interactive.

Maybe what I did isn't the best that can be done, but something has to
be done about that.  It is very b0rken under heavy load.

	-Mike

