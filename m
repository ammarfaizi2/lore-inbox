Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTAVHyR>; Wed, 22 Jan 2003 02:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTAVHyR>; Wed, 22 Jan 2003 02:54:17 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:24788 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267375AbTAVHyQ>;
	Wed, 22 Jan 2003 02:54:16 -0500
Date: Wed, 22 Jan 2003 08:03:22 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030122080322.GB3466@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122065502.GA23790@math.leidenuniv.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> Both /dev/epoll EP_POLL and sys_epoll_wait, when converting the passed
> timeout value in msec to jiffies, round down instead of up.  This
> occasionally causes these functions to return without any active fd's
> before the given timeout period has passed.

So you would like it to round up the timeout like poll(), select(),
and io_getevents() do?  Fair enough, for the sake of consistency!

sys_poll() says:

	if (timeout) {
		/* Careful about overflow in the intermediate values */
		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
		else /* Negative or overflow */
			timeout = MAX_SCHEDULE_TIMEOUT;
	}

sys_io_getevents() does something more complicated in a function
called set_timeout(), but it essentially comes to the same thing.  It
takes a value in nanseconds (which I prefer, btw, for future usefulness).

There is also a nasty overflow in ep_poll().  If HZ == 1000 and
you ask to wait for > approx. 2000 seconds (not unreasonable, say if
epoll is running an ftp server and the client timeout is set to 1
hour), then ep_poll gets the calculation wrong.

I suggest that this line in eventpoll.c:

	jtimeout = timeout == -1 ? MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;

be changed to this:

	jtimeout = 0;
	if (timeout) {
		/* Careful about overflow in the intermediate values */
		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
			jtimeout = (unsigned long)(timeout*HZ+999)/1000+1;
		else /* Negative or overflow */
			jtimeout = MAX_SCHEDULE_TIMEOUT;
	}

And that the prototypes for ep_poll() and sys_epoll_wait() be changed
to take a "long timeout" instead of an "int", just like sys_poll().

> Effectively causing busy-wait loops of on average half a jiffy.

Sometimes busy waiting is the right thing to do.  With HZ == 100,
anything involving video animation needs to busy wait after select()
or equivalent, otherwise there is too much display jitter.

But all that sort of code needs to know how much select() et al. tend
to overrun by anyway, so they can just do the same if using epoll.

-- Jamie


ps.  sys_* system-call functions should never return "int".  They
should always return "long" or a pointer - even if the user-space
equivalent returns "int".  Take a look at sys_open() for an example.
Technical requirement of the system call return path on 64-bit targets.
