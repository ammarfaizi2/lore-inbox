Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSJJRmg>; Thu, 10 Oct 2002 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJJRmg>; Thu, 10 Oct 2002 13:42:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26107 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261819AbSJJRme>;
	Thu, 10 Oct 2002 13:42:34 -0400
Message-ID: <3DA5BD47.FC7CDAC3@mvista.com>
Date: Thu, 10 Oct 2002 10:47:51 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com> <3DA4BECB.9C7D6119@mvista.com> <20021010155424.GN21400@waste.org> <3DA5A9D6.D72A8E00@mvista.com> <20021010170416.GP21400@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Thu, Oct 10, 2002 at 09:24:54AM -0700, george anzinger wrote:
> > Oliver Xymoron wrote:
> > >
> > > On Wed, Oct 09, 2002 at 04:42:03PM -0700, george anzinger wrote:
> > > > Linus Torvalds wrote:
> > > > >
> > > > > On Wed, 9 Oct 2002, george anzinger wrote:
> > > > > >
> > > > > > This patch, in conjunction with the "core" high-res-timers
> > > > > > patch implements high resolution timers on the i386
> > > > > > platforms.
> > > > >
> > > > > I really don't get the notion of partial ticks, and quite frankly, this
> > > > > isn't going into my tree until some major distribution kicks me in the
> > > > > head and explains to me why the hell we have partial ticks instead of just
> > > > > making the ticks shorter.
> > > > >
> > > > Well, the notion is to provide timers that have resolution
> > > > down into the micro seconds.  Since this take a bit more
> > > > overhead, we just set up an interrupt on an as needed
> > > > basis.  This is why we define both a high res and a low res
> > > > clock.  Timers on the low res clock will always use the 1/HZ
> > > > tick to drive them and thus do not introduce any additional
> > > > overhead.  If this is all that is needed the configure
> > > > option can be left off and only these timers will be
> > > > available.
> > > >
> > > > On the other hand, if a user requires better resolution,
> > > > s/he just turns on the high-res option and incures the
> > > > overhead only when it is used and then only at timer expire
> > > > time.  Note that the only way to access a high-res timer is
> > > > via the POSIX clocks and timers API.  They are not available
> > > > to select or any other system call.
> > > >
> > > > Making ticks shorter causes extra overhead ALL the time,
> > > > even when it is not needed.  Higher resolution is not free
> > > > in any case, but it is much closer to free with this patch
> > > > than by increasing HZ (which, of course, can still be
> > > > done).  Overhead wise and resolution wise, for timers, we
> > > > would be better off with a 1/HZ tick and the "on demand"
> > > > high-res interrupts this patch introduces.
> > >
> > > I think what Linus is getting at is: why not make the units of jiffies
> > > microseconds and give it larger increments on clock ticks? Now you
> > > don't need any special logic to go to better than HZ resolution.
> > > Unfortunately, this means identifying all the things that use HZ as a
> > > measure of how often we check for rescheduling.
> >
> > Well then you are still dealing with two measures, the HZ
> > and the tick rate.
> 
> Yep, and separating the two breaks a few things. Granted.
> 
> > One might also argue that the subjiffie
> > should be some "normal" thing like nanosecond or micro
> > second.  I went round and round with this in the beginning.
> > What it comes down to it the conversion back and forth is
> > much easier and faster (less overhead) when using the
> > natural units of the underlying clock.  This way the
> > interrupt code, for example, does not have to even do a
> > conversion.
> 
> Then the argument becomes move jiffies to the most convenient unit
> that encompasses what you want to do with subjiffies. Microseconds was
> just an example. Most code doesn't really care when ticks happen,
> except to the extent that they currently trigger timers, so
> jiffies=tick HZ stops being a meaningful measure once timers are
> untied from ticks, see?

Hm?  Not really sure what this leads to.  Right now the
timers are organized by "tick".  I think this is VERY
useful.  It makes the timer insert VERY fast and the tick
processing equally fast.  A regular "tick" also makes the
accounting overhead flat WRT load, also a GOOD thing.  

One thought I had was to separate out the sub tick events
into a different list and come up with a different interrupt
source for them.  Problem is they MUST stay in sync.  This
is most easily done when they are in the same list.

What you haven't touched on, is the separation of the "tick"
from the clock or time.  The patch implements, a separation
here.  Time is taken from a reliable source (in this patch
either TSC or the ACPI pm timer, but others are possible)
and the "tick" is just a reminder to look at the clock and
update accordingly.  This eliminates the issue of choosing a
HZ value that is so many PPM close to real time and the NTP
issues that causes, such as the current early expiration of
timers.  Try this:

time sleep 60

on a 2.5.40 system.  It will come back with 59.xxx seconds. 
Clearly the sleep was for less than 60.
  
> 
> > > I don't think he can seriously mean cranking HZ up to match whatever
> > > timing requirements we might have - that obviously doesn't scale.
> >
> > This is at least the third "take" on what he means, each of
> > which sends me in a very different direction.  Sure would
> > like to know what he really means.
> 
> Perhaps if you pose it as a multiple-choice question? I suppose he's
> almost sure to answer with "none of the above".
> 
> --
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
