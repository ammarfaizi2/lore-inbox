Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKLYK>; Thu, 11 Jan 2001 06:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAKLYA>; Thu, 11 Jan 2001 06:24:00 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:27307 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129610AbRAKLXp>; Thu, 11 Jan 2001 06:23:45 -0500
Message-ID: <3A5D994A.1568A4D5@uow.edu.au>
Date: Thu, 11 Jan 2001 22:30:18 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jayts@bigfoot.com
CC: lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>, xpert@xfree86.org,
        "mcrichto@mpp.ecs.umass.edu" <mcrichto@mpp.ecs.umass.edu>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM <200101110312.UAA06343@toltec.metran.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Ts wrote:
> 
> > A patch against kernel 2.4.0 final which provides low-latency
> > scheduling is at
> >
> >       http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads
> >
> > Some notes:
> >
> > - Worst-case scheduling latency with *very* intense workloads is now
> >   0.8 milliseconds on a 500MHz uniprocessor.
> 
> Wow!  That's super.  Now about the only thing left is to get it included
> in the standard kernel.  Do you think Linus Torvalds is more likely
> to accept these patches than Ingo's?  I sure hope this one works out.

Neither, I think.

We can't apply some patch and say "there; it's low-latency".

We (or "he") need to decide up-front that Linux is to become
a low latency kernel. Then we need to decide the best way of
doing that.

Making the kernel internally preemptive is probably the best way of
doing this.  But it's a *big* task to which must beard-scratching must
be put.  It goes way beyond the preemptive-kernel patches which have
thus far been proposed.

I could propose a simple patch for 2.4 (say, the ten most-needed
scheduling points).  This would get us down to maybe 5-10 milliesconds
under heavy load (10-20x improvement).

That would probably be a great and sufficient improvement for
the HA heartbeat monitoring apps, the database TP monitors,
the QuakeIII players and, of course, people who are only
interested in audio record and playback - I'd need advice
from the audio experts for that.

I hope that one or more of the desktop-oriented Linux distributors
discover that hosing HTML out of gigE ports is not really the
One True Appplication of Linux, and that they decide to offer
a low-latency kernel for the other 99.99% of Linux users.
 
> >   This is one to
> >   three orders of magnitude better than BeOS, MacOS and the Windowses.
> 
> ** salivates **
> 
> > - Low latency will probably only be achieved when using the ext2 and
> >   NFS filesystems.
> 
> Well it's extremely nice to see NFS included at least.  I was really
> worried about that one.  What about Samba?  (Keeping in mind that
> serious "professional" musicians will likely have their Linux systems
> networked to a Windows box, at least until they have all the necessary
> tools on Linux.

I would expect the smbfs client code to be OK.  Will test - thanks.

> > - If you care about latency, be *very* cautious about upgrading to
> >   XFree86 4.x.  I'll cover this issue in a separate email, copied
> >   to the XFree team.
> 
> Did that email pass by me unnoticed?  What's the prob with XF86 4.0?

I haven't gathered the energy to send it.

The basic problem with many video cards is this:

Video adapters have on-board command FIFOs.  They also
have a "FIFO has spare room" control bit.

If you write to the FIFO when there is no spare room,
the damned thing busies the PCI bus until there *is*
room.  This can be up to twenty *milliseconds*.

This will screw up realtime operating systems,
will cause network receive overruns, will screw
up isochronous protocols such as USB and 1394
and will of course screw up scheduling latency.

In xfree3 it was OK - the drivers polled the "spare room"
bit before writing.  But in xfree4 the drivers are starting
to take advantage of this misfeature.  I am told that
a significant number of people are backing out xfree4
upgrades because of this.  For audio.

The manufacturers got caught out by the trade press
in '98 and '99 and they added registry flags to their
drivers to turn off this obnoxious behaviour.

What needs to happen is for the xfree guys to add a
control flag to XF86Config for this.  I believe they
have - it's called `PCIRetry'.

I believe PCIRetry defaults to `off'.  This is bad.
It should default to `on'.

You can read about this minor scandal at the following
URLs:

        http://www.zefiro.com/vgakills.txt
        http://www.zdnet.com/pcmag/news/trends/t980619a.htm
        http://www.research.microsoft.com/~mbj/papers/tr-98-29.html

So,  we need to talk to the xfree team.

Whoops!  I accidentally Cc'ed them :-)

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
