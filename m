Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbRANIpF>; Sun, 14 Jan 2001 03:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbRANIo4>; Sun, 14 Jan 2001 03:44:56 -0500
Received: from styx.suse.cz ([195.70.145.226]:41722 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130747AbRANIov>;
	Sun, 14 Jan 2001 03:44:51 -0500
Date: Sun, 14 Jan 2001 09:44:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
Message-ID: <20010114094447.A365@suse.cz>
In-Reply-To: <Pine.LNX.4.30.0101131700230.1112-100000@svea.tellus> <Pine.LNX.4.30.0101132300080.1502-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101132300080.1502-100000@svea.tellus>; from tori@tellus.mine.nu on Sat, Jan 13, 2001 at 11:36:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 11:36:13PM +0100, Tobias Ringstrom wrote:

> I have now tried the SAMSUNG VG34323A disk with two other controllers at
> home (Promise ATA100 an VIA vt82c686a rev 0x22, both on an ASUS A7V
> motherboard), and there are no problems to be found with DMA enabled.
> Streaming 10 MB/s without glitches.

So the drive *did* work on the vt82c686a in the A7V board? You tested it
both on the Promise and on the 686a? But doesn't work on the 686a in
your other board?

> However, writing to the SAMSUNG VG34323A disk with DMA enabled on either
> this machine [1] (at work, using the VIA IDE driver version 3.11)
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 
> or this machine [2] (at work, using the VIA IDE driver version 2.1e)
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

What's the manufacturer/model of these boards? Just for record ...
What's the PCI bus speed? Or memory speed?

> I get exactly the following errors on both machines
> 
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> no matter what cable I use.  When I get this, the machine does not recover
> most of the time, and I have to reset or power cycle.

It should be able to recover in a couple (up to 10) minutes ...

> This disc works
> flawlessly on two other IDE controllers, so I do not think that the disk
> is completely broken. It must be either these chipsets or the driver in
> combination with this disk.  Note that I _can_ use another UDMA66 disk
> _with_ DMA enabled on both machine [1] and [2] above without problems.
> Also, 2.2.16-22 seems to work with DMA enabled on machine [1].  I have not
> tried 2.2.16-22 with DMA enabled on machine [2].
> 
> The problem I reported at first, hence the nasty subject, was a hang and a
> nasty fs corruption when RH7 tried to remount the root fs read-write.  I
> examined the RH7 init scripts, or more precisely /etc/rc.sysinit, and
> discovered, to my great disgust, that the stupid thing disables the dmesg
> output on the console very early in the script.  It is thus entirely
> possible that I do get the above mentioned errors when the computer seems
> to hang, and my fs gets corrupted.  I will fix the script tomorrow to see
> if my assumption is correct.
> 
> SUMMARY:  I have a disk that with DMA enabled give me CRC errors on two
> machines, but not on two other, independent on the cable.  Both troubling
> machines do not recover from these errors.  Linux 2.2.16-22 from RedHat
> works fine with DMA enabled on machine [1], [2] is unknown.
> 
> I hope this makes things a lot clearer.

Yes, indeed it's much clearer now. Now to fix the bug, or at least be
able to track it closer, I'll need 'lspci -vvxxx' of the IDE pci device
in the following cases:

1) SAMSUNG VG34323A on VT82C596b/cf with RH 2.2.16-22 and DMA (working)
2) SAMSUNG VG34323A on VT82C686a/ce with RH 2.2.16-22 and DMA (working)
3) SAMSUNG VG34323A on VT82C596b/cf with 2.4.0+via3.11 and DMA,
	(doesn't work, so fs readonly)
4) SAMSUNG VG34323A on VT82C686a/ce with 2.4.0+via3.11 and DMA,
	(doesn't work, so fs readonly)
5) The other drive on VT82C596b/cf with 2.4.0+via3.11 and DMA (working)
6) The other drive on VT82C686a/ce with 2.4.0+via3.11 and DMA (working)

With these data I should be able to find out what's different between
the working and not working setups ...

........

My current theory: In UDMA, when reading, the drive provides the clock.
The IDE controller thus can read everything OK. When writing, the
controller provides the clock and for some reason the Samsung can't keep
up with the setting the driver selects for it. The question is why and
why the driver selects the incorrect (or just too tight?) value.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
