Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVEQUbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEQUbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEQUbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:31:39 -0400
Received: from science.horizon.com ([192.35.100.1]:15404 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261935AbVEQUbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:31:18 -0400
Date: 17 May 2005 20:31:17 -0000
Message-ID: <20050517203117.10588.qmail@science.horizon.com>
From: linux@horizon.com
To: lsorense@csclub.uwaterloo.ca
Subject: Re: Sync option destroys flash!
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050517133606.GD23621@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It can also respond to loosing power during write by getting it's state
> so mixed up the whole card is dead (it identifies but all sectors fail
> to read).

Gee, that just happened to me!  Well, actually, thanks to Linux's
*insistence* on reading the partition table, I haven't managed to
get I/O errors on anything bit sectors 0 through 7, but I am quite
sure I wasn't writing those sectors when I pulled the plug:

hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
ide0: reset: success
hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table

> The binary industrial grade CF cards (no longer in
> production) had capacitors to be able to finish writing the block they
> were doing to prevent problems.

Er... are you talking about the SanDisk SDCFI or SDCFJ series?
If they told me, I'd specify them instantly...

> Supposedly their new firmware now will have a rollback system so that any
> partial write is just added back to the free pool.  I had thought this
> was always how they did it, but no apparently that is also something new.

Indeed; I'm in a fix right now because this seemed to thunderingly obvious
to me I didn't check carefully before committing to a CF-based design.

> We were told by SanDisk when we asked about a dead card (it had power
> loss during a write) and was told that is normal for the regular
> multicell flash cards.  They told us the firmware in the generation of
> cards they are currently launching does not have a problem with that
> anymore since it essentially journals the writes and can roll back a
> partial block write.

You wouldn't happen to know what devices those are, would you?
The SDCFH "Ultra II" series, maybe?

I'm talking to them now, so perhaps I'll learn.  As I said, since it
specifically does out-of-place writes, a two-phase commit is
startlingly easy to do.  The basic procedure is:

- For those who don't know, Flash memory technology can only be "erased"
  to all 1 bits large blocks, but can be "programmed" to 0 bits on
  a bit-by-bit basis.  Also, high-density NAND flash often has bad bits,
  so ECC is required.
- All High-density NAND flash has 512+16=528-byte sectors.  The 16 bytes
  are a label area for ECC and information to identify the 512-byte payload.
- If a write is interrupted, it's possible that the affected bit will
  read unreliably.
- Reserve three bits (possibly each implemented with multiple physical
  bits for redundancy in the face of errors).  They mean, respectively:
  - "This sector has started being programmed",
  - "This sector has finished being programmed and its contents are valid", and
  - "This sector contains stale data and should be erased".

To execute a new write,
- Choose an erased sector (or erase an unused sector if your pool of
  pre-erased sectors has been used up).
- (Verify that the sector truly is erased.  If it's not, program the
  "stale data; to be erased" bits and go back to step 1.)
- Program the "write starting bit".  This is important so that it is
  possible to tell that the sector is no longer clear without having
  to check the entire data area.  Which is important when building the
  initial list of erased sectors when booting.
- Program the data, ECC bits, etc.
- (Verify the data was written properly.  Flash memory wears out
  eventually, so bad blocks may develop during operation.)
- Program the "finished programming bit".
- Program the stale-data bits of the previous version of the sector.

When booting, read all the label areas and build the initial
logical/physical sector map.

If you find one for which the "started programming" bit is set but the
"finished programming" one is not, read it and verify the checksums.
If all looks well, re-program the sector (to make sure there aren't
any half-programmed bits) and program the "finished programming" bit.
(This is required in case the finished programming bit was half-programmed
when power was lost; if you don't do it, it's possible that *this* time
you felt sure the sector wasn't finished but the next time the card is
booted, the bit *will* read as programmed, resulting in a confused user.)

Also find the pervious version of the same sector and program its
stale bits.  You need at least a 3-state sequence number to do this,
but that's not a requirement created by atomic writing.

If, on the other hand, reading the payload produces a CRC error, program
the "stale & to be erased" bit.

> I imagine they have patents on that too along with
> lots of other flash technology.  Unfortunately their next generation
> cards aren't -40 to +85C operation so although everything else was
> perfect about them, they are of no use to us.

Well, I can make do.  If you *are* talking about SDCFI or SDCFJ, they're
still for sale at
https://www.californiapc.com/products/sdflash_industrial.php3
at least...

Anyway, thanks for the information!
