Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRK1RNp>; Wed, 28 Nov 2001 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRK1RNg>; Wed, 28 Nov 2001 12:13:36 -0500
Received: from femail41.sdc1.sfba.home.com ([24.254.60.35]:49586 "EHLO
	femail41.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277143AbRK1RNW>; Wed, 28 Nov 2001 12:13:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Tue, 27 Nov 2001 15:31:21 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011127175016.D13416@emma1.emma.line.org>
In-Reply-To: <20011127175016.D13416@emma1.emma.line.org>
MIME-Version: 1.0
Message-Id: <01112715312104.01486@localhost>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 11:50, Matthias Andree wrote:
> Please fix your domain in your mailer, localhost.localdomain is prone
> for Message-ID collisions.

I'm using Kmail talking to @home's mail server (to avoid the evil behavior 
sendmail has behind an IP masquerading firewall that triggers every spam 
filter in existence), so if either one of them cares about the hostname of my 
laptop ("driftwood", but apparently not being set right by Red Hat's 
scripts), then something's wrong anyway.

But let's see... 

Ah fun, if you change the hostname of the box, either X or KDE can't pop up 
any more new applicatons until you exit X and restart it.  Brilliant.  
Considering how many Konqueror windows I have open at present on my 6 
desktops, I think I'll leave fixing this until later in the evening.  But 
thanks for letting me know something's up...

>
> Note, the power must RELIABLY last until all of the data has been
> writen, which includes reassigning, seeking and the like, just don't do
> it if you cannot get a real solution.

A) At most 1 seek to a track other than the one you're on.

B) If sectors have been reassigned outside of this track to a "recovery" 
track, then that counts as a seperate track.  Tough.

The point of the buffer is to let the OS feed data to the write head as fast 
as it can write it (which unbuffered ATA can't do because individual requests 
are smaller than individual tracks).  You need a small buffer to avoid 
blocking between each and every ATA write while the platter rotates back into 
position.  So you always let it have a little more data so it knows what to 
do next and can start work on it immediately (doing that next seek, writing 
that next sector as it passes under the head without having to wait for it to 
rotate around again.)

That's it.  No more buffer than does good at the hardware level for request 
merging and minimizing seek latency.  Any buffering over and above that is 
the operating system's job.

Yes the hardware can do a slightly better job with its own elevator algorithm 
using intimate knowledge of on-disk layout, but the OS can do a fairly decent 
job as long as logical linear sectors are linearly arranged on disk too.  
(Relocating bad sectors breaks this, but not fatally.  It causes extra seeks 
in linear writes anyway where the elevator ISN'T involved, so you've already 
GOT a performance hit.  And it just screws up the OS's elevator, not the rest 
of the scheme.  You still have the current track written as one lump and an 
immediate seek to the other track, at which point the drive electronics can 
be accepting blocks destined for the track you seek back to.)

The advantage of limiting the amount of data buffered to current track plus 
one other is you have a fixed amount of work to do on a loss of power.  One 
seek, two track writes, and a spring-driven park.  The amount of power this 
takes has a deterministic upper bound.  THAT is why you block before 
accepting more data than that.

> battery-backed CMOS,
> NVRAM/Flash/whatever which lasts a couple of months should be fine
> though, as long as documents are publicly available that say how long
> this data lasts. Writing to disk will not work out unless you can keep
> the drive going for several seconds which will require BIG capacitors,
> so that's no option, you must go for NVRAM/Flash or something.

You dont' need several seconds.  You need MILISECONDS.  Two track writes and 
one seek.  This is why you don't accept more data than that before blocking.  
Your worst case scenario is a seek from near where the head parks to the 
other end of the disk, then the spring can pull it back.  This should be well 
under 50 miliseconds.  Your huge ram cache is there for reads.  For writes 
you don't accept more than you can reliably flush if you want anything 
approaching reliability.  If you're only going to spring for a capacitor as 
your power failure hedge, than the amount of write cache you can accept is 
small, but it turns out you only need a tiny amount of cache to get 90% of 
the benefit of write cacheing (merging writes into full tracks and seeking 
immediately to the next track).

> OTOH, the OS must reliably know when something went wrong (even with
> good power it has a right to know), and preferably this scheme should
> not involve disabling the write cache, so TCQ or something mandatory
> would be useful (not sure if it's mandatory in current ATA standards).

We're talking about what happens to the drive on a catastrophic power 
failure.  (Even with a UPS, this can happen if your case fan jams and your 
power supply catches fire and burns through a wire, Although most server side 
hosting facilities aren't that dusty, there's always worn bearings and other 
such fun things.  And in a desktop environment, spilled sodas.)  Currently, 
there are drives out there that stop writing a sector in the middle, leaving 
a bad CRC at the hardware level.  This isn't exactly graceful.  At the other 
end, drives with huge caches discard the contents of cache which a journaling 
filesystem thinks are already on disk.  This isn't graceful either.

> If a block has first been reported written OK and the disk later reports
> error, it must send the block back (incompatible with any current ATA
> draft I had my hands on), so I think tagged commands which are marked
> complete only after write+verify are the way to go.

If a block goes bad WHILE power is failing, you're screwed.  This is just a 
touch unlikely.  It will happen to somebody out there someday, sure.  So will 
alpha particle decay corrupting a sector that was long ago written to the 
drive correctly.  Designing for that is not practical.  Recovering after the 
fact might be, but that doesn't mean you get your data back.

Rob
