Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265576AbRFVXaJ>; Fri, 22 Jun 2001 19:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbRFVX36>; Fri, 22 Jun 2001 19:29:58 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:5394 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S265575AbRFVX3r>; Fri, 22 Jun 2001 19:29:47 -0400
Date: Sat, 23 Jun 2001 01:25:50 +0200
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Mike Galbraith <mikeg@wen-online.de>,
        Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
Message-ID: <20010623012550.B415@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Mike Galbraith <mikeg@wen-online.de>,
	Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
	John Stoffel <stoffel@casc.com>,
	Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01062003503300.00439@starship> <200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca> <01062016294903.00439@starship> <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Jun 20, 2001 at 10:12:38AM -0600
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 10:12:38AM -0600, Richard Gooch wrote:
> Daniel Phillips writes:
> > I'd like that too, but what about sync writes?  As things stand now,
> > there is no option but to spin the disk back up.  To get around this
> > we'd have to change the basic behavior of the block device and
> > that's doable, but it's an entirely different proposition than the
> > little patch above.
> 
> I don't care as much about sync writes. They don't seem to happen very
> often on my boxes.

syslog and some editors are the most common users of sync writes. vim, e.g.,
per default keeps fsync()ing its swapfile. Tweaking the configuration of
these apps, this can be prevented fairly easy though. Changing sync semantics
for this matter on the other hand seems pretty awkward to me. I'd expect an
application calling fsync() to have good reason for having its data flushed
to disk _now_, no matter what state the disk happens to be in. If it hasn't,
fix the app, not the kernel. 

> > You know about this project no doubt:
> > 
> >    http://noflushd.sourceforge.net/
> 
> Only vaguely. It's huge. Over 2300 lines of C code and >560 lines in
> .h files! As you say, not really lightweight. There must be a better
> way.

noflushd would benefit a lot from being able to set bdflush parameters per
device or per disk. So I'm really eager to see what Daniel comes up with.
Currently, we can only turn kupdate either on or off as a whole, which means
that noflushd implements a crude replacement for the benefit of multi-disk
setups. A lot of the cruft stems from there.

> Also, I suspect (without having looked at the code) that it
> doesn't handle memory pressure well. Things may get nasty when we run
> low on free pages.

It doesn't handle memory pressure at all. It doesn't have to. noflushd only
messes with kupdate{,d} but leaves bdflush (formerly known as kflushd) alone.
If memory gets tight, bdflush starts writing out dirty buffers, which makes the
disk spin up, and we're back to normal.

Regards,

Daniel.

