Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281074AbRKKVR5>; Sun, 11 Nov 2001 16:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKKVRs>; Sun, 11 Nov 2001 16:17:48 -0500
Received: from astcc-423.astound.net ([24.219.123.215]:11525 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281074AbRKKVRg>; Sun, 11 Nov 2001 16:17:36 -0500
Date: Sun, 11 Nov 2001 14:17:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Maxwell Spangler <maxwax@mindspring.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
In-Reply-To: <Pine.LNX.4.33.0111111553220.17893-100000@tyan.doghouse.com>
Message-ID: <Pine.LNX.4.10.10111111406470.13115-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Maxwell Spangler wrote:

> On Sun, 11 Nov 2001, Andre Hedrick wrote:
> 
> > The significance of the tuning code is not just for init events.
> > Linux is the first and only OS to have the autodma down grade feature
> > (Intel borrowed my model, approved by me).  This allows for kernel to auto
> > reconfigure the drive to stablize the transfer rates to protect the data.
> > Of course the ATA hardware has iCRC's un Ultra modes, but excessive
> > retries which are/will be successfully defeat the power of Ultra
> > transfers.  Therefore the tuning code in conjunction the the
> > auto-down-grade functions will reduce the transfer rates until the iCRC's
> > go away.  This is the 0x84/0x51 error pairs.  There are various reasons
> > that can cause this error to occur; however, the first stage is to
> > stablize the transport data path and then allow the SA or EU to examine
> > the problems.
> 
> So the system will boot at ATA100, for example, and if errors are seen,
> downgrade step by step until a satisfactory level is reached.  Perhaps, ATA66
> or ATA33 and the system would continue proper operation still at a "somewhat
> fast" (as compared to PIO) speed level AND in DMA mode, not PIO.  My situation
> with the 6.31 driver has DMA being disabled by the driver when errors are
> seen, as I think you have clearly stated.
> 
> ?? I'm assuming no to this, but I'm curious: Is there any chance the driver
> would "speed up" the transfers?  Ie: after a period of time at ATA33, would it
> try ATA66, 100 again?  I suppose this makes more sense for things like
> serial/modem communications where problems could come and go, but if one is
> experiencing problems between the ATA circuitry, cable and drive, they'll
> start good, get worse and never recover..?
> 
> -------------------------------------------------------------------------------
> Maxwell Spangler
> Program Writer
> Greenbelt, Maryland, U.S.A.
> Washington D.C. Metropolitan Area
> 

Hi Maxwell,

A system will launch PIO and if there is a driver it will be feature
enabled to max performance and auto scaled if there are problems
encountered.

The current code has a mistake that is not fatal, but regardless wrong.

Ultra 100|66|44|33|25|16 -- MW DMA 2|1|0 -- SW DMA 2|1|0 -- PIO4 
        5  4  3  2  1  0 

The fault is that you lose the iCRC features in Ultra so dropping to
Multi/Single word DMAs only gain speed w/ out a safety net.

The current patch code series does a single reduction of transfer rate per
counting 10 iCRC events, and no other errors are allowed.

Ultra 133|100|66|44|33|25|16|---PIO4
	6   5  4  3  2  1  0 ---

You need to enable the chipset code otherwise the driver will not allow
DMA to run in a sane mode.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

