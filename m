Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282653AbRKZXgt>; Mon, 26 Nov 2001 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282654AbRKZXgd>; Mon, 26 Nov 2001 18:36:33 -0500
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:19373 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282653AbRKZXgO>; Mon, 26 Nov 2001 18:36:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 15:35:07 -0500
X-Mailer: KMail [version 1.2]
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <0111261535070J.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 15:30, Andre Hedrick wrote:
> On Mon, 26 Nov 2001, Rob Landley wrote:

> > Just add an off-the-shelf capacitor to your circuit.  The firmware
> > already has to detect power failure in order to park the head sanely, so
> > make it flush the buffers along the way.  This isn't brain surgery, it
> > just wasn't a design criteria on IBM's checklist of features approved in
> > the meeting. (Maybe they ran out of donuts and adjourned the meeting
> > early?)
>
> Rob,
>
> Send me an outline/discription and I will present it during the Dec T13
> meeting for a proposal number for inclusion into ATA-7.

What kind of write-up do you want?  (How formal?)

The trick here is limiting the scope of the problem.  Your buffer can't be 
larger than you can reliably write back on a sudden power failure.  (This 
should be obvious.)  So the obvious answer is to make your writeback cache 
SMALL.  The problems that go with flushing it are then correspondingly small.

Your READ cache can be as large as you like, but when the disk accepts data 
written to it, a journaling FS assumes it will be committed to disk.  
Explicit flush requests are largely trying to get the filesystem to know 
about disk implementation issues: that's unnecessary complexity.  (And 
something vendors hate to implement because it kills performance.)  But 
either the drive can flush cache when the power goes out, or it's not 
reliable.

So how big of a cache is useful?  Well, what does the cache DO?  A small 
1-track cache helps write full tracks at a time, and if the cache can hold a 
second track it can start its seek immediately upon finishing the first track 
without worrying about latency of the OS getting back to it with more data.  
But more than 2 tracks gives you no benefit: cacheing beyond that is the 
operating system's job.  No benefit, and the liability of more to flush on 
power failure.  The answer is simple: Don't Do That Then.

You need stored power to flush the stored data, and a capacitor's better than 
a battery for several reasons.  It's cheaper, it lasts longer (no repeated 
charge/discharge fatigue), it can provide a LOT of power very quickly (we're 
actuating motors here), and we're only asking for a fraction of a second's 
extra power here which isn't what most batteries are designed for anyway.  
Capacitors are.

The people talking about batteries are trying to do battery backed up cache, 
which is silly and overkill.  We want the data to go to a disk which is 
ALREADY spinning at full speed when we lose power.  Current designs already 
try to flush the cache as they're losing power (a write cache is always in 
the process of being flushed, barring contention with read requests), and 
sometimes they even manage to do it.  We just need a little extra power to 
guarantee we can shut down gracefully.

A capacitor can provide a few miliseconds worth of power to keep the platters 
spinning at full speed, power the logic, do a maximum of two seeks, and of 
course feed power to the write head.  Conceptually, our volatile ram cache 
needs a power cache to flush it on power failure, and cacheing amperage is 
what a capacitor DOES.

Now let's get back to cache size.  You need 1 track of cache to get full 
track writes with ATA.  Being able to feed it a second track might be a good 
idea to avoid latency at the OS between one track finishing and the next 
starting.  (If nothing else, you tell it where to seek to next.)  But more 
than 2 tracks serves no purpose if the OS has a backlog of work for the disk 
to do, and if it doesn't we're not optimizing anything anyway.

Now a cache large enough to hold 2 full tracks could also hold dozens of 
individual sectors scattered around the disk, which could take a full second 
to write off and power down.  This is a "doctor, it hurts when I do this" 
question.  DON'T DO THAT.

The drive should block when it's fed sectors living on more than 2 tracks.  
Don't bother having the drive implement an elevator algorithm: the OS already 
has one.  Just don't cache sectors living on more than 2 tracks at a time: 
treat it as a "cache full" situation and BLOCK.

And further, don't cache anything for a SECOND track until you've already 
seeked to the first track.  This is to limit the number of potential seeks 
the capacitor has to power.  Reads work into this too: any time you get a 
"seek request", for read or for write, finish with the track you're on before 
moving.  Accept new write requests into the buffer for the track you're 
currently on, and for ONE other track.  If you're not currently on a track 
you have anything to write to, you can buffer stuff for only one other track. 
 Anything else blocks just as if the buffer was full.  (Because it is.)

That way, the power down problem is strictly limited:

1) write out the track you're over
2) seek to the second track
3) write that out too
4) park the head

You're done.  You can measure this in the lab, determine exactly how much 
power your capacitor needs to supply to guarantee that, and implement it.  
Your worst case scenario is a full track write next to where the head 
normally parks, a full track write at the far end of the disk, and then 
seeking back to the landing zone.  This is two seeks including the park, 
which should still be easily measured in miliseconds.

There's no elevator algorithm (that's the OS's job), no battery backed up 
cache (not needed, the platters are already persistent), just a cheap 
solution for a cheap ATA drive, arrived at by limiting the size of the 
problem you're handling.

What new hardware is involved?

Add a capacitor.

Add a power level sensor.  (Drives may already have this to know when to park 
the head.)

Firmware to manage the cache (limiting its data intake, and flushing right 
before parking).

I think that's it.  Did I miss anything?  Oh yeah, on power fail stop 
worrying about read requests.  (They can theoretically starve the write 
requests on this capacitor-powered guaranteed seek thing, although if the 
power IS failing there shouldn't be too many more of them coming in, should 
there?  But they may be queued.)  But that's fairly obvious, and there has to 
be logic for this already or else the read head would run out of power and 
crash into the disk before it got a chance to park...

Again, just unload the real write cacheing on the OS because the purpose of 
the drive's cacheing is to batch requests to the track level and to disguise 
seek latency a bit, and if that's ALL it does it's easy to reliably flush 
that on power down with just a capacitor.  Any cacheing beyond 2 tracks worth 
(not 2 tracks worth of individual sectors scattered all over the disk but 
"the current track and 1 other track") just gets in the way of reliability.  
Yes the drive maker may be wasting DRAM by doing that.  Tell them they can 
dedicate that other ram to a read cache, but writes need to block to maintain 
the implicit guarantee that if the drive accepted the write the data will 
still be there after a power off..

Rob
