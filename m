Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKOAlr>; Thu, 14 Nov 2002 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSKOAlN>; Thu, 14 Nov 2002 19:41:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56843 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265477AbSKOAkC>; Thu, 14 Nov 2002 19:40:02 -0500
Date: Thu, 14 Nov 2002 16:46:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       John Alvord <jalvo@mbay.net>, <linux-kernel@vger.kernel.org>
Subject: Re: module mess in -CURRENT
In-Reply-To: <20021115002730.GA22547@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Nov 2002, Jamie Lokier wrote:
> 
> Once you're talking about nanoseconds, you can have both: each time
> you store an mtime, make sure the value is at least 1 nanosecond
> greater than the previously stored mtime for any file in the
> serialisation domain.  If it is not, simply _wait_ for up to a
> nanosecond until the value has advanced enough.

Note that the fields already _are_ nanoseconds, it's just not updated at a
nanosecond rate. We're updating xtime only at a rate of HZ, where the 1 ms
comes from in 2.5.x.

And doing a full "gettimeofday()" sounds just a bit too expensive for the
stuff that needs to just update an inode time field.

But the thing is, we don't actually care about the exact time, we only
care about it being monotonically increasing, so I suspect we could just
have something like

	static unsigned long xtime_count;

	static struct timespec current_time(void)
	{
		struct timespec val;
		unsigned long extra;

		read_lock_irq(&xtime_lock);
		val = xtime;
		extra = xtime_count;
		xtime_count = extra+1;
		read_unlock_irq(&xtime_lock);

		val.nsec += count;
		if (val.tv_nsec > 1000000000) {
			val.tv_nsec -= 1000000000;
			val.tv_sec ++;
		}
		return val;
	}

and then have the timer clear "xtime_count" every time it updates it.  

This obviously doesn't give us nanosecond resolution, but it _does_ give
us "unique" timestamps (assuming a system call takes longer than a
nanosecond, which is likely true for the next decade or so - after that we
can start worrying about whether the users might be outrunning the clock).

		Linus

