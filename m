Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVERNi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVERNi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVERNi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:38:29 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:18308 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262170AbVERNhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:37:42 -0400
Date: Wed, 18 May 2005 09:37:41 -0400
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050518133741.GS23488@csclub.uwaterloo.ca>
References: <20050517133606.GD23621@csclub.uwaterloo.ca> <20050517203117.10588.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517203117.10588.qmail@science.horizon.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 08:31:17PM -0000, linux@horizon.com wrote:
> Gee, that just happened to me!  Well, actually, thanks to Linux's
> *insistence* on reading the partition table, I haven't managed to
> get I/O errors on anything bit sectors 0 through 7, but I am quite
> sure I wasn't writing those sectors when I pulled the plug:
> 
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> ide0: reset: success
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> end_request: I/O error, dev 03:00 (hda), sector 6
>  unable to read partition table

Yeah that is exactly how it responds after a powerloss during write when
you have no protection against that.

> > The binary industrial grade CF cards (no longer in
> > production) had capacitors to be able to finish writing the block they
> > were doing to prevent problems.
> 
> Er... are you talking about the SanDisk SDCFI or SDCFJ series?
> If they told me, I'd specify them instantly...

The model with the capacitors was the SDCFBI-size-201-80, but they are no
longer available for purchase (we were going to use them and are now
trying a few other brands).  The -80 Meant industrial grade which was
the flash with capacitors to keep power failures from killing a write
in progress.  None of our tests have killed a -80 yet.  The -00 we have
killed by have power off during writes.  They were also rated at 3 times
the write cycles of their regular grade.

We were told the new cards that they offer to OEMs have new firmware
that does some kind of journaling or timestamping or something to deal
with the problem instead.  I haven't tried the new cards and given they
don't offer the needed temperature range we need, I won't be trying them
either.

> > Supposedly their new firmware now will have a rollback system so that any
> > partial write is just added back to the free pool.  I had thought this
> > was always how they did it, but no apparently that is also something new.
> 
> Indeed; I'm in a fix right now because this seemed to thunderingly obvious
> to me I didn't check carefully before committing to a CF-based design.
> 
> > We were told by SanDisk when we asked about a dead card (it had power
> > loss during a write) and was told that is normal for the regular
> > multicell flash cards.  They told us the firmware in the generation of
> > cards they are currently launching does not have a problem with that
> > anymore since it essentially journals the writes and can roll back a
> > partial block write.
> 
> You wouldn't happen to know what devices those are, would you?
> The SDCFH "Ultra II" series, maybe?

Anything sold retail is anyone's guess (according to their rep) while
OEM cards you get what it says on the card.  The retail cards don't
carry the same model numbers either.  A retail sandisk card might not
even contain sandisk memory (only the controller is sure to be sandisk).

> I'm talking to them now, so perhaps I'll learn.  As I said, since it
> specifically does out-of-place writes, a two-phase commit is
> startlingly easy to do.  The basic procedure is:
> 
> - For those who don't know, Flash memory technology can only be "erased"
>   to all 1 bits large blocks, but can be "programmed" to 0 bits on
>   a bit-by-bit basis.  Also, high-density NAND flash often has bad bits,
>   so ECC is required.
> - All High-density NAND flash has 512+16=528-byte sectors.  The 16 bytes
>   are a label area for ECC and information to identify the 512-byte payload.
> - If a write is interrupted, it's possible that the affected bit will
>   read unreliably.
> - Reserve three bits (possibly each implemented with multiple physical
>   bits for redundancy in the face of errors).  They mean, respectively:
>   - "This sector has started being programmed",
>   - "This sector has finished being programmed and its contents are valid", and
>   - "This sector contains stale data and should be erased".
> 
> To execute a new write,
> - Choose an erased sector (or erase an unused sector if your pool of
>   pre-erased sectors has been used up).
> - (Verify that the sector truly is erased.  If it's not, program the
>   "stale data; to be erased" bits and go back to step 1.)
> - Program the "write starting bit".  This is important so that it is
>   possible to tell that the sector is no longer clear without having
>   to check the entire data area.  Which is important when building the
>   initial list of erased sectors when booting.
> - Program the data, ECC bits, etc.
> - (Verify the data was written properly.  Flash memory wears out
>   eventually, so bad blocks may develop during operation.)
> - Program the "finished programming bit".
> - Program the stale-data bits of the previous version of the sector.
> 
> When booting, read all the label areas and build the initial
> logical/physical sector map.
> 
> If you find one for which the "started programming" bit is set but the
> "finished programming" one is not, read it and verify the checksums.
> If all looks well, re-program the sector (to make sure there aren't
> any half-programmed bits) and program the "finished programming" bit.
> (This is required in case the finished programming bit was half-programmed
> when power was lost; if you don't do it, it's possible that *this* time
> you felt sure the sector wasn't finished but the next time the card is
> booted, the bit *will* read as programmed, resulting in a confused user.)
> 
> Also find the pervious version of the same sector and program its
> stale bits.  You need at least a 3-state sequence number to do this,
> but that's not a requirement created by atomic writing.
> 
> If, on the other hand, reading the payload produces a CRC error, program
> the "stale & to be erased" bit.

Well I suspect that is along the lines of what the sandisk 201 series'
replacement is doing in it's firmware.

The new ones must be either SDCFH or SDCFJ but I can't find anything
that says what the difference is between the two lines.  We were using
the SDCFBI-*-80 cards.

> Well, I can make do.  If you *are* talking about SDCFI or SDCFJ, they're
> still for sale at
> https://www.californiapc.com/products/sdflash_industrial.php3
> at least...

Well we were told last buy was about a week or two ago on the
SDCFBI-*-201-80 cards.  We are now playing with SLCF*JI cards from
SimpleTech and hopefully those will work out for us.  It sure is hard to
do indurstrial temperature when most people don't care.  Most companies
are happy to avoid the trouble since normal temperature suits 99% of the
market, so why bother with the trouble for the last 1% even if they are
willing to pay double. :)

Len Sorensen
