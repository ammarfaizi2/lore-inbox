Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282504AbRKZUjL>; Mon, 26 Nov 2001 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282490AbRKZUiq>; Mon, 26 Nov 2001 15:38:46 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:50181
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282500AbRKZUiK>; Mon, 26 Nov 2001 15:38:10 -0500
Date: Mon, 26 Nov 2001 12:36:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Steve Brueggeman <xioborg@yahoo.com>
cc: linux-kernel@vger.kernel.org,
        Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <k1t40uciislnibv9927hekv82ejgu3eahb@4ax.com>
Message-ID: <Pine.LNX.4.10.10111261232140.8817-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve,

Dream on fellow, it is SOP that upon media failure the device logs the
failure and does an internal re-allocation in the slip-sector stream.
If the media is out of slip-sectors then it does an out-of-bounds
re-allocation.  Once the total number of out-of-bounds sectors are gone
you need to deal with getting new media or exectute a seek and purge
operation; however, if the badblock list is full you are toast.

That is what is done - knowledge is first hand.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Mon, 26 Nov 2001, Steve Brueggeman wrote:

> While I am not familiar with the IBM drives in particular, I am
> familar with this particular problem.
> 
> The problem is that half of a sector gets new data, then when power is
> dropped, the old data+CRC/ECC is left on second part of that sector,
> and a subsequent read on the whole sector will detect the CRC/ECC
> mismatch, and determine the error burst is larger than what it can
> correct with retries, and ECC, and report it as a HARD ERROR. (03-1100
> in the SCSI World) 
> 
> Since the error is non-recoverable, the disk drive should not
> auto-reassign the sector, since it cannot succeed at moving good data
> to the newly assigned sector.
> 
> This type of error does not require a low-level format.  Just writing
> any data to the sector in error should give the sector a CRC/ECC field
> that matches the data in the sector, and you should not get hard
> errors when reading that sector anymore.
> 
> This was more of a problem with older disk drives (8-Inch platters, or
> older), because the time required to finish any given sector was more
> than the amount of time the electronics would run reliably.  All that
> could be guranteed on these older drives was that a power loss would
> not corrupt any adjacent data, ie write gate must be crow-bared
> inactive before the heads start retracting, emergency-style, to the
> landing zone.
> 
> I believe that the time to complete a sector is so short on current
> drives, that they should be able to complete writing their current
> sector, but I do not believe that there are any drive manufacturers
> out there that gurrantee this.  Thus, there is probably a window, on
> all disk drives out there, where a loss of power durring an active
> write will end up causing a hard error when that sector is
> subsequently read (I haven't looked though, and could be wrong).
> Writing to the sector with the error should clear the hard-error when
> that sector is read.  A low-level format should not be required to fix
> this, and if it is, the drive is definitely broken in design.
> 
> This is basic power-economics, and one of the reasons for UPS's
> 
> Steve Brueggeman
> 
> 
> 
> On 24 Nov 2001 14:03:11 +0100, you wrote:
> 
> >In the German computer community, a statement from IBM[1] is
> >circulating which describes a rather peculiar behavior of certain IBM
> >IDE hard drivers (the DTLA series):
> >
> >When the drive is powered down during a write operation, the sector
> >which was being written has got an incorrect checksum stored on disk.
> >So far, so good---but if the sector is read later, the drive returns a
> >*permanent*, *hard* error, which can only be removed by a low-level
> >format (IBM provides a tool for it).  The drive does not automatically
> >map out such sectors.
> >
> >IBM claims this isn't a firmware error, but thinks that this explains
> >the failures frequently observed with DTLA drivers (which might
> >reflect reality or not, I don't know, but that's not the point
> >anyway).
> >
> >Now my question: Obviously, journaling file systems do not work
> >correctly on drivers with such behavior.  In contrast, a vital data
> >structure is frequently written to (the journal), so such file systems
> >*increase* the probability of complete failure (with a bad sector in
> >the journal, the file system is probably unusable; for non-journaling
> >file systems, only a part of the data becomes unavailable).  Is the
> >DTLA hard disk behavior regarding aborted writes more common among
> >contemporary hard drives?  Wouldn't this make journaling pretty
> >pointless?
> >
> >
> >1. http://www.cooling-solutions.de/dtla-faq (German)

