Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRAYMVT>; Thu, 25 Jan 2001 07:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135241AbRAYMVJ>; Thu, 25 Jan 2001 07:21:09 -0500
Received: from styx.suse.cz ([195.70.145.226]:50165 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130781AbRAYMVA>;
	Thu, 25 Jan 2001 07:21:00 -0500
Date: Thu, 25 Jan 2001 13:20:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010125132054.B1204@suse.cz>
In-Reply-To: <20010124202527.A2405@suse.cz> <Pine.LNX.4.10.10101241314470.14153-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101241314470.14153-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 24, 2001 at 01:58:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 01:58:09PM -0800, Andre Hedrick wrote:

> In the past there were hardcoded timing values for the allowable for the
> VIA cores that were defined by VIA.  They were taken from their internal
> lookup tables.  You have stated that you have allowed for "slop" in the
> timing to attempt to soften the driver, that is your decision you are
> totally responsible for keeping that chipset alive.
> 
> I suspect that you have not seen and know that you have not hear in person
> the issues that arise for pushing or slacking the timing on the HOST side
> of the world.  However, I do expect that you understand that at slower
> transfer rates you have a greater margin for error-tolerance.  However the
> game completely changes once Mode 3 and higher are used.  The margins are
> ever so narrow.  Thus by following the exact letter and value you remove
> suspect from the driver.

You can always check the /proc/ide/via listing to check that the values
are the same as in the specs. Actually there is not much to get wrong
with UDMA timing - it's just one register's value on VIA chipsets.

> Additionally with the auto_crc_downgrade feature now in 2.4.x if they only
> get iCRC errors the main driver will force the transfer rate down to
> stablize the timings.  This was put in to correct for all the real crap
> mainboards that everyone buys and expects them to work at full speed.
> Well the do not, and fudging the timing tables to make crap work and
> then cause ones that are within the tolerance of the cable skews is not
> acceptable.  You will continue to fight this battle and lose, but consider
> doing so gracefully.
> 
> Put the hardcoded timing values back in as default, and allow for the
> option to use the dynamic fudged ones by the enduser.  The default are
> generally stable, the fudged ones I can not comment.

There are no 'fudged' values. The values the chipset is programmed to,
when the idebus= option is set to the default 33 MHz are exactly the
same as in the specs. Really.

I hope the auto_crc_downgrade will help things, at least on those
drives, that don't crash their firmware in the case of a iCRCed
transfer.

Anyway, what about adding a XFER_UDMA_SLOW mode that would set the
chipset to say 150 or 180 ns per UDMA cycle? At least AMD specs mention
such a possibility. It's better than using MWDMA, and if XFER_UDMA_0 is
still too fast for the drive, it'd be a good 'last fallback'.

> Lastly the IDE-PCI clocking is independent of the FBS or PCI-Bus clocking.
> The three timing ranges given by VIA for 25, 33, 41 are to morph the
> IDE-PCI clock back to 33.  Thus PCI-Bus of 25 increases cycle time to
> achieve the 33, as the 41 reduces time to achieve the 33.  I know what I
> want to say, whether I did or not succeed is an issue.  So if you do not
> follow me (as most usually fail to follow me :-(( ) just ask.

Yes. The IDE timing should be always the same, independent on the PCI
clock. However, it is programmed in terms of PCI cycles, so yes, the
only thing my driver does is exactly this compensation for the PCI speed
so that the IDE timing stays constant.

Yes, my driver is doing exactly what you say.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
