Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261603AbSJJPsp>; Thu, 10 Oct 2002 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJJPso>; Thu, 10 Oct 2002 11:48:44 -0400
Received: from waste.org ([209.173.204.2]:23494 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261603AbSJJPsn>;
	Thu, 10 Oct 2002 11:48:43 -0400
Date: Thu, 10 Oct 2002 10:54:24 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Message-ID: <20021010155424.GN21400@waste.org>
References: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA4BECB.9C7D6119@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA4BECB.9C7D6119@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:42:03PM -0700, george anzinger wrote:
> Linus Torvalds wrote:
> > 
> > On Wed, 9 Oct 2002, george anzinger wrote:
> > >
> > > This patch, in conjunction with the "core" high-res-timers
> > > patch implements high resolution timers on the i386
> > > platforms.
> > 
> > I really don't get the notion of partial ticks, and quite frankly, this
> > isn't going into my tree until some major distribution kicks me in the
> > head and explains to me why the hell we have partial ticks instead of just
> > making the ticks shorter.
> > 
> Well, the notion is to provide timers that have resolution
> down into the micro seconds.  Since this take a bit more
> overhead, we just set up an interrupt on an as needed
> basis.  This is why we define both a high res and a low res
> clock.  Timers on the low res clock will always use the 1/HZ
> tick to drive them and thus do not introduce any additional
> overhead.  If this is all that is needed the configure
> option can be left off and only these timers will be
> available.
> 
> On the other hand, if a user requires better resolution,
> s/he just turns on the high-res option and incures the
> overhead only when it is used and then only at timer expire
> time.  Note that the only way to access a high-res timer is
> via the POSIX clocks and timers API.  They are not available
> to select or any other system call.
> 
> Making ticks shorter causes extra overhead ALL the time,
> even when it is not needed.  Higher resolution is not free
> in any case, but it is much closer to free with this patch
> than by increasing HZ (which, of course, can still be
> done).  Overhead wise and resolution wise, for timers, we
> would be better off with a 1/HZ tick and the "on demand"
> high-res interrupts this patch introduces.

I think what Linus is getting at is: why not make the units of jiffies
microseconds and give it larger increments on clock ticks? Now you
don't need any special logic to go to better than HZ resolution.
Unfortunately, this means identifying all the things that use HZ as a
measure of how often we check for rescheduling. 

There's also an issue of dynamic range - if we some day soon decide we
want internal timestamps with nanosecond resolution (because units of
.1us are annoying, not because we'll actually have ns accuracy),
then we're seeing timer wraps every couple seconds on 32bit machines
and we're pretty much forced to break into seconds and nanoseconds.
This is arguably saner than jiffies and subjiffies, but it forces
people who are using long timeouts today to use a new interface.

I don't think he can seriously mean cranking HZ up to match whatever
timing requirements we might have - that obviously doesn't scale.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
