Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282515AbRKZU4b>; Mon, 26 Nov 2001 15:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282520AbRKZUyv>; Mon, 26 Nov 2001 15:54:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42122 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S282515AbRKZUyY>; Mon, 26 Nov 2001 15:54:24 -0500
Date: Mon, 26 Nov 2001 15:53:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob Landley <landley@trommello.org>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <0111261159080F.02001@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1011126151922.29433A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Rob Landley wrote:

> On Sunday 25 November 2001 04:14, Chris Wedgwood wrote:
> 
> >
> > P.S. Write-caching in hard-drives is insanely dangerous for
> >      journalling filesystems and can result in all sorts of nasties.
> >      I recommend people turn this off in their init scripts (perhaps I
> >      will send a patch for the kernel to do this on boot, I just
> >      wonder if it will eat some drives).
> 
> Anybody remember back when hard drives didn't reliably park themselves when 
> they cut power?  This isn't something drive makers seem to pay much attention 
> to until customers scream at them for a while...
> 
> Having no write caching on the IDE side isn't a solution either.  The problem 
> is the largest block of data you can send to an ATA drive in a single command 
> is smaller than modern track sizes (let alone all the tracks under the heads 
> on a multi-head drive), so without any sort of cacheing in the drive at all 
> you add rotational latency between each write request for the point you left 
> off writing to come back under the head again.  This will positively KILL 
> write performance.  (I suspect the situation's more or less the same for read 
> too, but nobody's objecting to read cacheing.)
> 
> The solution isn't to avoid write cacheing altogether (performance is 100% 
> guaranteed to suck otherwise, for reasons unrelated to how well your hardware 
> works but to legacy request size limits in the ATA specification), but to 
> have a SMALL write buffer, the size of one or two tracks to allow linear ATA 
> write requests to be assembled into single whole-track writes, and to make 
> sure the disks' electronics has enough capacitance in it to flush this buffer 
> to disk.  (How much do capacitors cost?  We're talking what, an extra 20 
> miliseconds?  The buffer should be small enough you don't have to do that 
> much seeking.)
> 
> Just add an off-the-shelf capacitor to your circuit.  The firmware already 
> has to detect power failure in order to park the head sanely, so make it 
> flush the buffers along the way.  This isn't brain surgery, it just wasn't a 
> design criteria on IBM's checklist of features approved in the meeting.  
> (Maybe they ran out of donuts and adjourned the meeting early?)
> 
> Rob

It isn't that easy!  Any kind of power storage within the drive would
have to be isolated with diodes so that it doesn't try to run your
motherboard as well as the drive. This means that +5 volt logic supply 
would now be 5.0 - 0.6 =  4.4 volts at the drive, well below the design
voltage. Use of a Schottky diode (0.34 volts) would help somewhat, but you
have now narrowed the normal power design-margin by 90 percent, not good.

There is supposed to be a "power good" line out of your power supply
which is supposed to tell equipment when the main power has failed or
is about to fail. There isn't a "power good" line in SCSI so that
doesn't help. 

Basically, when the power fails, all bets are off. A write in progress
may not succeed any more than a seek in progress would. Seeks take a
lot of power, usually from the +12 volt line. Typically, if a write
is in progress, when low power is sensed by the drive, write current
is terminated. At one time, there was a electromagnet that was
released to move the heads to a landing zone. Now there is none.
The center of radius of the head arm is slightly forward of the
center of rotation of the disk so that when the heads "land", they
skate to the inside of the platter, off the active media. The media
is supposed to be able to take this abuse for quite some time.

When a partially written sector is read with a bad CRC, the host
(not the drive) can rewrite the sector. As long as the sector
header, which is ahead of the write-splice, isn't destroyed
the disk doesn't need to be re-formatted. In the remote case where
the sector header is destroyed, the bad sector may be re-mapped by
the drive if there are any spare sectors still available. The first
error returned to the host is the bad CRC. Subsequent reads will
not return a bad CRC if the sector was re-mapped. However, the data
is invalid! Therefore, the drivers can't retry reads expecting that
a bad CRC got fixed so the data is okay. The driver needs to read
all the sense data and try to figure it out.

The solution is an UPS. When the UPS power gets low, shut down
the computer, preferably automatically.

Also, if your computer is on all day long as is typical at a
workplace, never shut it off. Just turn off the monitor when you
go home. Your disk drives will last until you decide to replace
then because they are too small or too slow.

And beware when you finally do turn off the computer. The disks
may not spin up the next time you start the computer. It's a good
idea to back up everything before shutting down a computer that
has been running for a year or two.

Of course you can re-boot as much as you want. Just don't kill the power!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


