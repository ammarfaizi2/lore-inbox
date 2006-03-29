Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWC2F4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWC2F4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 00:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWC2F4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 00:56:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:27076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751077AbWC2F4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 00:56:14 -0500
X-Authenticated: #14349625
Subject: Re: scheduler starvation resistance patches for 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603282301.55314.a1426z@gawab.com>
References: <200603272136.07908.a1426z@gawab.com>
	 <1143522632.7441.16.camel@homer> <1143537120.10571.5.camel@homer>
	 <200603282301.55314.a1426z@gawab.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 07:56:14 +0200
Message-Id: <1143611774.7535.30.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 23:01 +0300, Al Boldi wrote:
> Mike Galbraith wrote:
> > On Tue, 2006-03-28 at 07:10 +0200, Mike Galbraith wrote:
> > > On Mon, 2006-03-27 at 21:36 +0300, Al Boldi wrote:
> > > > It's not bad.  w/ credit_c1/2 set to 0 results in an improvement in
> > > > running the MESA demos  "# gears & reflect & morph3d" .
> > >
> > > Hmm.  That's unexpected.
> > >
> > > > But a simple "# while :; do :; done &" (10x) makes a "# ping 10.1 -A
> > > > -s8" choke.
> > >
> > > Ouch, so is that.  But thanks, testcases are great.  I'll look into it.
> >
> > OK, this has nothing to do with my patches.  The same slowdown happens
> > with a stock kernel when running a few pure cpu hogs.  I suspect it has
> > to do with softirqd, but am still investigating.
> 
> I think so too.

(suspicion led to wild goose chase)

> I played with some numbers inside sched.c.  Raising the MIN_TIMESLICE from 1 
> to between 10-100  affects interactivity positively, although it does not 
> fix it entirely.

After some fiddling with it, looks to me like it's just a combination of
EXPIRED_STARVING(rq) doing it's thing, which in turn causes (if you're
running kde at least) your terminal to not be able to keep up, which
makes it lose priority due to burning more cpu trying to catch up.

Try this.  Using virgin 2.6.16, disable EXPIRED_STARVING(rq), and start
your ping -A without any cpu hogs.  If you're running KDE, you'll notice
that the konsole priority where ping is running remains forever highly
interactive.  Enable EXPIRED_STARVING(rq) and repeat.  Just from the
scrolling, being bumped into the expired array will cause konsole to
lose priority because of increased cpu usage trying to catch up.

There is a price to be paid for starvation prevention.  You can choose
when it's paid, and in what sized installments, but pay you will :-/

> It does look like there is an underlying problem (locking?) that may be 
> worked-around by tuning the scheduler to some extent.
> 
> Also, MAX_TIMESLICE = 800 seems a bit high.  Can this be lowered?

The round-robin logic prevents this from being a problem.

	-Mike

