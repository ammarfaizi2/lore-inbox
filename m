Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbTCWMBW>; Sun, 23 Mar 2003 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbTCWMBW>; Sun, 23 Mar 2003 07:01:22 -0500
Received: from mta08bw.bigpond.com ([144.135.24.137]:33227 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263036AbTCWMBU>; Sun, 23 Mar 2003 07:01:20 -0500
Message-ID: <3E7DA537.7080608@bigpond.com>
Date: Sun, 23 Mar 2003 23:14:47 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.3a) Gecko/20021212
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE todo list
References: <20030322160012$0f05@gated-at.bofh.it> <20030322173016$24a8@gated-at.bofh.it> <20030322180018$5114@gated-at.bofh.it>
In-Reply-To: <20030322180018$5114@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2003-03-22 at 17:24, Petr Vandrovec wrote:
> 
>>  any hope that promise 20265 driver could detect non-udma66 cable
>>and run at udma2 only? BIOS properly detect this, but Linux driver
>>wants to use udma100, and usually dies hard with CRC errors during
>>reading of PTBL extended chain (it also should not lockup when
>>CRC error happens 5 times in a row, but ...).
> 
> 
> The five CRC in a row is what causes the DMA->PIO changedown. That
> implies there is a real bug in the error handling locking, or in
> the driver handling of that.
> 
> Can you throw some printks into the ide code and see what kind of 
> a death you get when it tries to change back to PIO.
> 
> As to the cable stuff, I'll take a look at it in time, but both
> need fixing

I've got a slightly different take on cables.

First an outline of the hardware:
Epox 8KHA+ with VIA KT266A
Promise Ultra100 TX2 (PDC20268)
Working ATA100 drive on Promise. 80 conductor cable, kernel has OFFBOARD set.
40 conductor cables on VIA IDE primary and secondary.  Each has cdrom (slave).
   Cable is correctly flagged by BIOS on boot screen as 40 conductor.
   Second ATA100 HD in cradle MAY be plugged into VIA primary IDE.
Kernel 2.4.21-pre5-ac3

W/o second HD all operates correctly.
With second HD I get:

hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
  hde:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdf: DMA disabled
ide2: reset: success
  hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >


Checking with "hdparm -d" I find that the HD has DMA on,
and the blameless cdrom has it disabled!
The HD then runs w/o error at UDMA2.

I had expected that by using a 40 conductor cable it would be sensed
and UDMA2 then used as the top setting, matching the cdrom capability.

