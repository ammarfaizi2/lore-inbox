Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131816AbRCUXLn>; Wed, 21 Mar 2001 18:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRCUXLe>; Wed, 21 Mar 2001 18:11:34 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:11684 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131816AbRCUXLY>; Wed, 21 Mar 2001 18:11:24 -0500
Message-ID: <3AB934F1.44BACC68@inet.com>
Date: Wed, 21 Mar 2001 17:10:41 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103192134.VAA01785@raistlin.arm.linux.org.uk> <3AB927D0.F152717D@inet.com> <3AB92AC1.DF054E2E@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> 
> Eli Carter wrote:
> >
> > Russell King wrote:
> > >
> > > Eli Carter writes:
> > > > What are you seeing that I'm missing?
> > >
> > > Ok, after sitting down and thinking again about this problem, its not
> > > the 9.9999ms case, but the 10.000000001 case:
> > [snip]
> > > Like I say, this requires good timing to create, so may not be too much of
> > > a problem, but it does seem to be a problem that could occur.
> >
> > It appears that this problem is easier to create than we originally gave
> > credit for....  All that is needed is for gettimeoffset() not to be
> > called for a _minimum_ of >10ms, and for the timer to wrap during a call
> > to do_gettimeofday() or during a period of time where interrupts are
> > disabled and do_gettimeofday() is called.  Note that there is no upper
> > limit to the time...
> >
> > If we call gettimeoffset() after do_timer() returns (and there-by update
> > the internal variables every 10ms), we should reduce the impact of this
> > bug dramatically (in theory--in practice, disabling interrupts for long
> > periods can also have some bad effects that this won't help, but I think
> > that's another issue.)
> >
> > One of the guys I'm working with did some testing on this, and he was
> > seeing this problem (off by 10ms) every 5 to 10 minutes (on a modified
> > ARM & kernel).  With the additional gettimeoffset() call, he no longer
> > saw it (at least within ~3hrs.).
> >
> > Questions, comments, etc.?
> 
> Another thought...
> 
> If we pull count_p and jiffies_p out of the various *_gettimeoffset()
> functions, and added an updatetimeoffset() that only updated count_p and
> jiffies_p, (and called it after every do_timer(),) we'd accomplish the
> same thing, but with less overhead.

Ok, it just dawned on me...
if we update jiffies_p every time we update jiffies, it stands to reason
that they will always be equal... soooo... we can eliminate the need for
that check, and hence, the variable.

Since we are open to this problem from 10ms after the last call to
gettimeoffset to the time that interrupts are enabled, we should be
significantly better off.

We still have a race, just smaller....Updating count_p twice per jiffie
should eliminate the problem in practice (though in theory, we still
have a race.)  Errrm...  ????

Questions, comments, etc?

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
