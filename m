Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTE3XhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTE3XhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:37:01 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:3595 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264057AbTE3Xg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:36:59 -0400
Date: Sat, 31 May 2003 01:50:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Different geometry settings for identical drives
Message-ID: <20030531015019.A2856@pclin040.win.tue.nl>
References: <20030530224603.GA21297@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530224603.GA21297@heat>; from jwbaker@acm.org on Fri, May 30, 2003 at 03:46:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 03:46:03PM -0700, Jeffrey Baker wrote:

> I'm having some IDE troubles on 2.4.21-rc3 on amd64
> platform.  The problem is I've got these two drives:
> 
> hda: WDC WD1200JB-75CRA0, ATA DISK drive
> hdc: WDC WD1200JB-75CRA0, ATA DISK drive
> hda: setmax LBA 234441648, native  234375000
> hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> hdc: setmax LBA 234441648, native  234375000
> hdc: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63, UDMA(100)
> 
> which are configured identically in the BIOS and recognized identically
> at bootup, but the geometry is getting setup differently:

A FAQ. Nothing wrong about that.
See http://www.win.tue.nl/~aeb/linux/Large-Disk-14.html#ss14.2
"Nonproblem: Identical disks have different geometry?"

> prime:~# hdparm /dev/hda /dev/hdc | grep geometry
>  geometry     = 14589/255/63, sectors = 234375000, start = 0
>  geometry     = 35906/16/63, sectors = 234375000, start = 0
> prime:~# cat /proc/ide/ide0/hda/geometry 
> physical     232514/16/63
> logical      14589/255/63
> prime:~# cat /proc/ide/ide1/hdc/geometry 
> physical     232514/16/63
> logical      232514/16/63

All this output is rather nonsensical. Geometry does not exist, and
various pieces of software print various meaningless numbers.
It would be better if /proc/.../geometry were removed.
Every microsecond spent looking at its contents is wasted.

> The result is that hda works fine but hdc doesn't.

I think you incorrectly blame your problems on disk geometry.
But I don't know the actual cause.

> When I try to mke2fs on the latter I see:
> 
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=234441583, sector=232343808
> 
> You can see that LBAsect (234441583) is higher than the "native" sectors
> quoted by the kernel (234375000, difference 66583 sectors).  Why are
> these two disks being addressed differently?  

Geometry does not influence addressing mode. Moreover, mke2fs is a user space
utility. You mention 2.4.21-rc3, and the ide code including this stuff
changes quite a lot from version to version. What happens under 2.4.N
for N=18,19,20? Both geometries given multiply out to 234372285 and
234374112 sectors, both below 234375000.

Does mke2fs actually ask for an access of sector 234441583?
What size does *fdisk think the disk has?

Can it be that this was an attempted 48-bit command?
(Sorry - no time to read 2.4.21-rc3.)

Andries

