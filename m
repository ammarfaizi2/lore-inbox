Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131801AbRCUWPr>; Wed, 21 Mar 2001 17:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRCUWPg>; Wed, 21 Mar 2001 17:15:36 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:64671 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S131801AbRCUWPX>; Wed, 21 Mar 2001 17:15:23 -0500
Message-ID: <3AB927D0.F152717D@inet.com>
Date: Wed, 21 Mar 2001 16:14:40 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103192134.VAA01785@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Eli Carter writes:
> > What are you seeing that I'm missing?
> 
> Ok, after sitting down and thinking again about this problem, its not
> the 9.9999ms case, but the 10.000000001 case:
[snip]
> Like I say, this requires good timing to create, so may not be too much of
> a problem, but it does seem to be a problem that could occur. 

It appears that this problem is easier to create than we originally gave
credit for....  All that is needed is for gettimeoffset() not to be
called for a _minimum_ of >10ms, and for the timer to wrap during a call
to do_gettimeofday() or during a period of time where interrupts are
disabled and do_gettimeofday() is called.  Note that there is no upper
limit to the time...

If we call gettimeoffset() after do_timer() returns (and there-by update
the internal variables every 10ms), we should reduce the impact of this
bug dramatically (in theory--in practice, disabling interrupts for long
periods can also have some bad effects that this won't help, but I think
that's another issue.)

One of the guys I'm working with did some testing on this, and he was
seeing this problem (off by 10ms) every 5 to 10 minutes (on a modified
ARM & kernel).  With the additional gettimeoffset() call, he no longer
saw it (at least within ~3hrs.).

Questions, comments, etc.?

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
