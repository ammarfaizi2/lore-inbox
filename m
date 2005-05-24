Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVEXDtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEXDtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEXDtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:49:04 -0400
Received: from opersys.com ([64.40.108.71]:8967 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261189AbVEXDsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:48:40 -0400
Message-ID: <4292A69C.4070605@opersys.com>
Date: Mon, 23 May 2005 23:59:24 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd vs. DMA
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com> <1116905090.4992.7.camel@gaston>
In-Reply-To: <1116905090.4992.7.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt wrote:
> Well, not sure what's wrong here, but ATAPI errors shouldn't normally
> result in stopping DMA. We may want to just blacklist your drive rather
> than having this stupid fallback. In this case, I suspect it's
> CSS/region issue with a DVD.

Here's a little bit more info:

Here's from dmesg:
hdc: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)

hdparm -i /dev/hdc:

/dev/hdc:

 Model=SAMSUNG SC-140B, FwRev=d005, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

Here's what happens on the first mount attempt:
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0x00
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete

Now, if I'm stuborn and re-enable DMA using a "hdparm -d1 /dev/hdc" and then
try again, now I get:
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdc: media error (bad sector): error=0x34
ide: failed opcode was 100
end_request: I/O error, dev hdc, sector 16

The last error being repeated ad-nauseam for every "sector" on the
disk. Again, note that this is a CD drive, not a hard disk.

Here's from lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c)

In attempting to isolate the problem, I ran into a spurious issue with
another drive I have in that machine:
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled

Try as I may, however, I haven't been able to reproduce this problem with
hda (from dmesg: hda: WDC AC22500L, ATA DISK drive). It's worthy pointing
out that the machine came with a drive on which it was found that there
were actual bad sectors (tested on another machine.) ... the thought of
a buggy controller came to mind, but (though this may be possible), I've
never heard about a bad controller generating bad sectors ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
