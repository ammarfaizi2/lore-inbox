Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWGQTHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWGQTHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWGQTHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:07:51 -0400
Received: from homer.mvista.com ([63.81.120.155]:45487 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751158AbWGQTHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:07:49 -0400
Message-ID: <44BBDFBE.10800@ru.mvista.com>
Date: Mon, 17 Jul 2006 23:06:38 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Status of HPT372A driver?
References: <20060717142705.GS1485@earth.li> <44BBC75A.2000800@ru.mvista.com> <20060717182633.GX1485@earth.li>
In-Reply-To: <20060717182633.GX1485@earth.li>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jonathan McDowell wrote:

>>Jonathan McDowell wrote:

>>>I recently acquired a HighPoint RocketRaid 1520 SATA controller (I know,
>>>I know, bad choice but I just need something to tide me over until I can
>>>upgrade to a motherboard with AHCI love). This presents as a HPT372A:

>>>00:09.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 
>>>01)
>>>00:09.0 0104: 1103:0005 (rev 01)

>>   Sigh, I had no chance to test the driver on this chip myself... And I 
>>   also haven't tried the driver on SATA drives at all... :-/

> :(

> I've had a try with libata and Alan Cox's 2.6.17-ide1 patch (I'd
> previously tried this and had issues, which turned out to be a faulty
> drive I think). This seems to get better results (sda is the same drive
> as was hde earlier):

    I wouldn't be so sure about the faulty drive. ;-)
    However, I haven't looked at the Alan's recent libata driver yet. 
Unfortunately, I've been severely distracted from IDE stuff for the last 
couple months... :-/

> /dev/sda:
>  Timing cached reads:   1084 MB in  2.01 seconds = 540.41 MB/sec
>  Timing buffered disk reads:  166 MB in  3.00 seconds =  55.25 MB/sec

> I imagine this is due to:

> libata version 1.20 loaded.
> pata_hpt37x: BIOS has not set timing clocks.
> hpt37x: HPT372A: Bus clock 33MHz.
> ata1: PATA max UDMA/133 cmd 0xA000 ctl 0xA402 bmdma 0xB000 irq 11
> ata2: PATA max UDMA/133 cmd 0xA800 ctl 0xAC02 bmdma 0xB008 irq 11
> ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
> ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
> Find mode for 12 reports C829C62
> Find mode for DMA 70 reports 1C81DC62
> ata1: dev 0 configured for UDMA/133

> ie it's configuring for UDMA/133 as expected.

    Well, my version of driver should have UDMA133 working faster than the 
original driver due to the switch to 66 MHz DPLL clocking... And it looks like 
pata_hpt37x driver is still using the PCI clock, so should be slower too.

> The hpt366 driver was stable (I copied 100+G of data with cp/rsync and
> it was fine); I've only been running this one (marked "Raving Lunatic"

    It may be not as bad. :-)

> in the Kconfig) for 5 minutes, so I'll see how it goes. I'm happy to try
> out anything you might want for the hpt366 driver though.

   It looks like this is not the driver problem so far, read on...

>>>The 2.6.17 hpt366.c driver is at version 0.36. I also found your patches
>>>to l-k earlier this year, but I'm not sure whether I got them all as I
>>>had some rejects; I ended up with a version 1.00 driver as at:

>>   Some patch was recast, maybe this was the reason...

>>>http://the.earth.li/~noodles/hpt366.c

>>   I'm surprised that this has even compiled! It has check_in_drive_lists() 
>>defined twice...

> No, it has it once (unused) - the used instance is check_in_drive_list()

>>>Is there somewhere I can get your latest work without having to try to
>>>pick the right patches from the l-k archives?

>>   You may find the summary patch in the -mm tree

> Right, I found this shortly after I sent my first mail, but it's not a
> lot different from what I'm running AFAICT (changes from min to min_t
> and the removal of the unused check_in_drive_lists).

    Ah, I forgot that I renamed it. :-)

>>   Output of hdparm -iI /dev/hde would also be helpful.

> /dev/hde:

>  Model=WDC WD2500KS-00MJB0, FwRev=02.01C03, SerialNo=WD-WCANK3255074
>  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
>  BuffType=unknown, BuffSize=16384kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
 >
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: Unspecified:  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7
> 
>  * signifies the current active mode

    And the shortened UDMA mode list signifies 40c cable...

> Capabilities:
>         LBA, IORDY(can be disabled)
>         Standby timer values: spec'd by Standard, with device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Recommended acoustic management value: 128, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6

    Now this is UDMA133 capable drive. Well, I know it's actually capable of 
300 MiB/s . :-)

> Security:
>         Master password revision code = 65534
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
> Checksum: correct

    No "HW reset results" -- SATA drives don't have valid word 93 as it seems, 
and so the eighty_ninty_three() returns 0 meaning that the device reports 40c 
PATA cable.
    I think you need to try this 2.6.18-rc1 patch from Alan:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1a1276e7b6cba549553285f74e87f702bfff6fac

> J.

WBR, Sergei
