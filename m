Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRCFTmU>; Tue, 6 Mar 2001 14:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbRCFTmK>; Tue, 6 Mar 2001 14:42:10 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:8716
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129429AbRCFTmA>; Tue, 6 Mar 2001 14:42:00 -0500
Date: Tue, 6 Mar 2001 11:41:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l0313030ab6ca4912a397@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10103060526470.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan,

I am not going to bite on your flame bate, and are free to waste you money.

On Tue, 6 Mar 2001, Jonathan Morton wrote:

> >> It's pretty clear that the IDE drive(r) is *not* waiting for the physical
> >> write to take place before returning control to the user program, whereas
> >> the SCSI drive(r) is.  Both devices appear to be performing the write
> >
> >Wrong, IDE does not unplug thus the request is almost, I hate to admit it
> >SYNC and not ASYNC :-(  Thus if the drive acks that it has the data then
> >the driver lets go.
> 
> Uh, run that past me again?  You are saying that because the IDE drive hogs
> the bus until the write is complete or the driver forcibly disconnects, you
> make the driver disconnect to save time?  Or (more likely) have I totally
> misread you...

No, SCSI does with queuing.
I am saying that the ata/ide driver rips the heart out of the
io_request_lock what to darn long.  This means that upon execution a
request virtually all interrupts are wacked and the drivers in dominating
the system.  Given that IO's are limited to 128 sectors or one DMA PRD,
this is vastly smaller than the SCSI trasfer limit.

Since you are not using the test "Write Verify Read" all drives are going
to lie.  Only this command will force the stuff to hit the platters and
return a read out of the dirty-cache.

> >pre-seek.  Thus the question is were is the drive leaving the heads when
> >not active?  It does not appear to be in the zone 1 region.
> 
> Duh...  I don't quite see what you're saying here, either.  The test is a

Okay real short....limit to two zones that are equal in size.
The inner and outer, and the latter will cover more physical media than
the former.  Simple Two zone model.

> continuous rewrite of the same sector of the disk, so the head shouldn't be
> moving *at all* until it's all over.  In addition, the drive can't start

True and you slip a rev. everytime.

> writing the sector when it's just finished writing it, so it has to wait
> for the rotation to breing it back round again.  Under those circumstances,
> I would expect my 7200rpm Seagate to perform slower than my 10000rpm IBM
> *regardless* of seeking performance.  Seeking doesn't come into it!

It does, because more RPM means more air-flow and more work to keep the
position stable.

> >Thus if your drive is one of those that does a stress test check that goes:
> >"this bozo did not really mean to turn off write caching, renabling <smurk>"
> 
> Why does this sound familiar?

Because of WinBench!
All the prefetch/caching are modeled to be optimized to that bench-mark.

> Personally, I feel the bottom line is rapidly turning into "if you have
> critical data, don't put it on an IDE disk".  There are too many corners
> cut when compared to ostensibly similar SCSI devices.  Call me a SCSI bigot
> if you like - I realise SCSI is more expensive, but you get what you pay
> for.

Let me slap you in the face with a salomi stick!
ATA 7200 RPM Drives are using SCSI 7200 RPM Drive HDA's
So you say ATA is Lame?  Then so was your SCSI 7200's.

> Of course, under normal circumstances, you leave write-caching and UDMA on,
> and you don't use a pathological stress-test like we've been doing.  That
> gives the best performance.  But sometimes it's necessary to use these
> "pathological" access patterns to achieve certain system functions.
> Suppose, harking back to the Windows data-corruption scenario mentioned
> earlier, that just before powering off you stuffed several MB of data,
> scattered across the disk, into said disk and waited for said disk to say
> "yup, i've got that", then powered down.  Recent drives have very large
> (2MB?) on-board caches, so how long does it take for a pathological pattern
> of these to be committed to physical media?  Can the drive sustain it's own
> power long enough to do this (highly unlikely)?  So the drive *must* be
> able to tell the OS when it's actually committed the data to media, or risk
> *serious* data corruption.

OH...you are talking about the one IBM drive that is goat-screwed...
The one that is to stupid to use the energy of the platters to drop the
data in the vender power down strip...yet it dumps the buffer in a panic..

ERM, that is a bad drive, regardless if they publish an errata that states
only good HOSTS that issue a flush-cache prior to power are to be
certified...we maybe if they did not default the WC on then it would be a
NOP of the design error.  Since all OSes that enable WC at init will flush
it at shutdown and do a periodic purge with in-activity.

> Pathological shutdown pattern:  assuming scatter-gather is not allowed (for
> IDE), and a 20ms full-stroke seek, write sectors at alternately opposite
> ends of the disk, working inwards until the buffer is full.  512-byte
> sectors, 2MB of them, is 4000 writes * 20ms = around 80 seconds (not
> including rotational delay, either).  Last time I checked, you'd need a
> capacitor array the size of the entire computer case to store enough power
> to allow the drive to do this after system shutdown, and I don't remember
> seeing LiIon batteries strapped to the bottom of my HDs.  Admittedly, any
> sane OS doesn't actually use that kind of write pattern on shutdown, but
> the drive can't assume that.

Err, last time I check all good devices flush their write caching on their
own to take advantage of having a maximum cache for prefetching.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

