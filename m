Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282726AbRK0CCS>; Mon, 26 Nov 2001 21:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282727AbRK0CCI>; Mon, 26 Nov 2001 21:02:08 -0500
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:3028 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282726AbRK0CBx>; Mon, 26 Nov 2001 21:01:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Ian Stirling <root@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 18:00:34 -0500
X-Mailer: KMail [version 1.2]
Cc: andre@linux-ide.org (Andre Hedrick), cw@f00f.org (Chris Wedgwood),
        linux-kernel@vger.kernel.org
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk>
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk>
MIME-Version: 1.0
Message-Id: <0111261800340R.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 20:23, Ian Stirling wrote:

> > Now a cache large enough to hold 2 full tracks could also hold dozens of
> > individual sectors scattered around the disk, which could take a full
> > second to write off and power down.  This is a "doctor, it hurts when I
> > do this" question.  DON'T DO THAT.
>
> Or, to seek to a journal track, and write the cache to it.

Except that at most you have one seek to write out all the pending cache data 
anyway, so what exactly does seeking to a journal track buy you?

Now modern drives have this fun little thing where they remap bad sectors so 
writing to one logical track can involve a seek, and the idea here is to cap 
seeks, so the drive has to keep track how where sectors ACTUALLY are and 
block based on their physical position rather than the logical position they 
present to the system.  Which could be fairly evil.  But oh well...

(And in theory, if you're doing a linear write on a sector by sector basis, 
the discontinuous portions of a damaged track (the first half of the track, 
with one sector out of line, followed by the rest of track) could still be 
written in one go assuming the system unblocks when it physically seeks to 
the track in question, allowing the system to write the rest of the data to 
that track before it seeks away from it...)

> Errors are a problem, writing twice may help.
> This avoids having to block on bad write patterns, for example, if you
> are writing mixed blocks that go to tracks 1 and 88, you can't start to
> write blocks that would go to track 44.
> Performance would rise if it can do the writes in elevator order.

The elevator is the operating system's problem.  To reliably write stuff back 
you can't have an unlimited number of different tracks in cache, or the seeks 
to write it all out will kill any reasonable finite power reserve you'd want 
to put in a disk.

> <snip>
>
> > That way, the power down problem is strictly limited:
> >
> > 1) write out the track you're over
> > 2) seek to the second track
> > 3) write that out too
> > 4) park the head
>
> Or 2) optionally seek to the journal track, and write the journal.

Possibly.  I still don't see what it gets you if you only have one track 
other than the one you're over to write to.  (is the journal track near the 
area the head parks in?  That could be a power saving method, I suppose.  But 
it's also wasting disk space that would probably otherwise be used for 
storage or a block remapping, and how do you remap a bad sector out of the 
journal track if that happens?)

> > What new hardware is involved?
> >
> > Add a capacitor.
> >
> > Add a power level sensor.  (Drives may already have this to know when to
> > park the head.)
>
> Most drives I've taken apart recently seem to have passive means,
> a spring to move the head to the side, and a magnet to hold it there.

Yeah, I'd heard that.  That's why the word "may" was involved. :)  (That and 
just trusting the inertia of the platter to aerodynamically keep the head 
airborne before it can snap back to the parking position.)

You could still do this, by the way.  It reduces the power requirements to 
only one seek.  And with the journal track hack, that seek could be in the 
direction the spring pulls.  Still not too thrilled about that, though...

> <Snip>>
>
> > I think that's it.  Did I miss anything?  Oh yeah, on power fail stop
>
> It needs a power switch to stop back-feeding the computer.

Yup.

Rob
