Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAMSLP>; Sat, 13 Jan 2001 13:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAMSLF>; Sat, 13 Jan 2001 13:11:05 -0500
Received: from icemserv.folkwang.uni-essen.de ([132.252.170.129]:40718 "EHLO
	icemserv.folkwang.uni-essen.de") by vger.kernel.org with ESMTP
	id <S129704AbRAMSKq>; Sat, 13 Jan 2001 13:10:46 -0500
Message-ID: <3A609A55.7F80CF31@folkwang.uni-essen.de>
Date: Sat, 13 Jan 2001 19:11:33 +0100
From: Jörn Nettingsmeier 
	<nettings@folkwang.uni-essen.de>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: jayts@bigfoot.com, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>, xpert@xfree86.org,
        "mcrichto@mpp.ecs.umass.edu" <mcrichto@mpp.ecs.umass.edu>,
        alsa-devel@alsa-project.org
Subject: video drivers hog pci bus ? [was:[linux-audio-dev] low-latency 
 scheduling patch for 2.4.0]
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM <200101110312.UAA06343@toltec.metran.cx> <3A5D994A.1568A4D5@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[alsa folks, i'd appreciate a comment on this thread from
linux-audio-dev]

hello everyone !

in a post related to his latest low-latency patch, andrew morton
gave a pointer to
http://www.zefiro.com/vgakills.txt , which addresses the problem of
dropped samples due to agressive video drivers hogging the pci bus
with retry attempts to optimize benchmark results while producing a
"zipper" noise, e.g. when moving windows around with the mouse while
playing a soundfile.
some may have tried fiddling with the "pci retry" option in the
XF86Config (see the linux audio quality howto by paul winkler at
http://www.linuxdj.com/audio/quality for details).

i recall some people having reported mysterious l/r swaps w/ alsa
drivers on some cards, and iirc, most of these reports were not
easily reproduced and explained. 
the zefiro paper states that the zefiro cards would swap channels
occasionally under the circumstances mentioned. it sounds probable
to me that all drivers using interleaved data would suffer from this
problem.

can some more experienced people comment on this ?
is my assumption correct that the bus hogging behaviour is affected
by the pci_retry option ?

btw: the text only mentions pci video cards. will agp cards also
clog the pci bus ?

please give some detail in your answers - i would like to include
this in the linux-audio-dev faq and resources pages. (so chances are
you will only have to answer this once :)


sorry if this has been dealt with before, i seem to have trouble to
follow all my mailing lists...


regards,

jörn


Andrew Morton wrote:
> 
> >
> > > A patch against kernel 2.4.0 final which provides low-latency
> > > scheduling is at
> > >
> > >       http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads
> > >
> > > Some notes:
> > >
> > > - Worst-case scheduling latency with *very* intense workloads is now
> > >   0.8 milliseconds on a 500MHz uniprocessor.
> Neither, I think.
> 
> We can't apply some patch and say "there; it's low-latency".
> 
> We (or "he") need to decide up-front that Linux is to become
> a low latency kernel. Then we need to decide the best way of
> doing that.
> 
> Making the kernel internally preemptive is probably the best way of
> doing this.  But it's a *big* task to which must beard-scratching must
> be put.  It goes way beyond the preemptive-kernel patches which have
> thus far been proposed.
> 
> I could propose a simple patch for 2.4 (say, the ten most-needed
> scheduling points).  This would get us down to maybe 5-10 milliesconds
> under heavy load (10-20x improvement).
> 
> That would probably be a great and sufficient improvement for
> the HA heartbeat monitoring apps, the database TP monitors,
> the QuakeIII players and, of course, people who are only
> interested in audio record and playback - I'd need advice
> from the audio experts for that.
> 
> I hope that one or more of the desktop-oriented Linux distributors
> discover that hosing HTML out of gigE ports is not really the
> One True Appplication of Linux, and that they decide to offer
> a low-latency kernel for the other 99.99% of Linux users.
> >
> > Well it's extremely nice to see NFS included at least.  I was really
> > worried about that one.  What about Samba?  (Keeping in mind that
> > serious "professional" musicians will likely have their Linux systems
> > networked to a Windows box, at least until they have all the necessary
> > tools on Linux.
> 
> > > - If you care about latency, be *very* cautious about upgrading to
> > >   XFree86 4.x.  I'll cover this issue in a separate email, copied
> > >   to the XFree team.
> 
> I haven't gathered the energy to send it.
> 
> The basic problem with many video cards is this:
> 
> Video adapters have on-board command FIFOs.  They also
> have a "FIFO has spare room" control bit.
> 
> If you write to the FIFO when there is no spare room,
> the damned thing busies the PCI bus until there *is*
> room.  This can be up to twenty *milliseconds*.
> 
> This will screw up realtime operating systems,
> will cause network receive overruns, will screw
> up isochronous protocols such as USB and 1394
> and will of course screw up scheduling latency.
> 
> In xfree3 it was OK - the drivers polled the "spare room"
> bit before writing.  But in xfree4 the drivers are starting
> to take advantage of this misfeature.  I am told that
> a significant number of people are backing out xfree4
> upgrades because of this.  For audio.
> 
> The manufacturers got caught out by the trade press
> in '98 and '99 and they added registry flags to their
> drivers to turn off this obnoxious behaviour.
> 
> What needs to happen is for the xfree guys to add a
> control flag to XF86Config for this.  I believe they
> have - it's called `PCIRetry'.
> 
> I believe PCIRetry defaults to `off'.  This is bad.
> It should default to `on'.
> 
> You can read about this minor scandal at the following
> URLs:
> 
>         http://www.zefiro.com/vgakills.txt
>         http://www.zdnet.com/pcmag/news/trends/t980619a.htm
>         http://www.research.microsoft.com/~mbj/papers/tr-98-29.html
> 
> So,  we need to talk to the xfree team.
> 
> Whoops!  I accidentally Cc'ed them :-)
> 
> -

-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://www.folkwang.uni-essen.de/~nettings/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
