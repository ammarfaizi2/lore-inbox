Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSGXNmk>; Wed, 24 Jul 2002 09:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSGXNmk>; Wed, 24 Jul 2002 09:42:40 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:27557 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317287AbSGXNlp>; Wed, 24 Jul 2002 09:41:45 -0400
Date: Wed, 24 Jul 2002 14:44:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Message-ID: <20020724144433.B7192@kushida.apsleyroad.org>
References: <200207190952.g6J9q4I07044@sic.twinsun.com> <200207200038.g6K0cZO12086@devserv.devel.redhat.com> <ahau4q$1n2$1@penguin.transmeta.com> <m13cudnled.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m13cudnled.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Jul 21, 2002 at 09:36:10AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> torvalds@transmeta.com (Linus Torvalds) writes:
> > A _useful_ interface would be to say "I want to sleep to at most time X"
> > or "to at least time X".  Those are unambiguous things to say, and are
> > not open to interpretation.
> 
> Sleeping until at most time X is only useful if the kernel can actually
> make a guarantee like that.  If you are doing hard real time fine, otherwise
> that doesn't work to well.

Oh, that would definitely be useful even if it's only a "soft"
guarantee.  Especially with recent HZ changes.

Typical soft real-time code looks a bit like this pseudo-code (excuse
the bugs :-):

	void wait_until_time (const struct timeval * until)
	{
		struct timeval now, timeout;
		while (1) {
		        gettimeofday (&now, 0);
		        timeout.tv_sec = until->tv_sec - now.tv_sec;
			timeout.tv_usec = until->tv_usec - now.tv_usec;
			if (timeout.tv_usec < 0) {
				timeout.tv_usec += 1000000;
				timeout.tv_sec -= 1;
			}
			if (timeout.tv_sec < 0)
				break;		/* Finished! */
			timeout.tv_usec -= SCHEDULER_GRANULARITY;
			if (timeout.tv_usec < 0) {
				timeout.tv_usec += 1000000;
				timeout.tv_sec -= 1;
			}
			/* Busy wait if within scheduler granularity. */
			if (timeout.tv_sec > 0) {
				select (0, 0, 0, &timeout);
			}
		}
	}

Note that SCHEDULER_GRANULARITY is an architecure-specific and
OS-specific constant that has to be determined somehow.

The select() call in the above code is one that would, ideally, be "wait
until at most TIME" even if that is limited by the granularity of
scheduler timeouts.  The scheduler may not be able to _guarantee_ to
schedule the process before TIME (fair enough, that's why we call it
soft real-time), but at least the tick calculations etc. in the kernel
would be rounded down, rather than up.

-- Jamie
