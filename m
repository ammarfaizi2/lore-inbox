Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJaFk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 00:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJaFk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 00:40:28 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:31195 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262955AbTJaFkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 00:40:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "CN" <cnliou9@fastmail.fm>, linux-kernel@vger.kernel.org
Subject: Re: kernel: i8253 counting too high! resetting..
Date: Fri, 31 Oct 2003 00:40:19 -0500
User-Agent: KMail/1.5.1
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com> <20031030171235.GA59683@teraz.cwru.edu> <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
In-Reply-To: <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310310040.19519.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.58.154] at Thu, 30 Oct 2003 23:40:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 00:04, CN wrote:
>Thank you a lot!
>
>> > entries in syslog from kernel 2.4.22 upgraded from Debian woody
>> > (gcc 2.95.4) running on AMD K6II 450MHz with 64MB RAM. I don't
>> > have such problem in kernel 2.4.20 upgraded from Slackware (gcc
>> > 2.95.3) running on another box with the identical CPU and main
>> > board (but with 192MB RAM). Does this message hurt anything?
>>
>> Can you please provide additional details about your hardware?
>> What kind of main board are you using, and what southbridge?
>
>Now I found that the two boards are slightly different. The
> printings on the biggest 2 chips on the problematic board are:
>
>ALi
>M1542 A1
>100MHz
>9949 TS05
>
>ALi
>M1543C B1
>9947 TM07
>
>respectively. While the board having no i8253 messages has the
> chips:
>
>ALi
>M1542 A1
>100MHz
>9937 TS05
>
>ALi
>M1543C B1
>0002 TM05
>
The last line of each chips data above seems inconsequential as thats 
only the mfgr's code date and such.  The chips themselves really 
should be functionally identical.

>> What is the reported latency of your IDE interface?
>
>Sorry! I don't quite understand the meanings! I am trying to report
> all I know about. dmesg on the problematic box shows:
>
>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>hda: FUJITSU MPE3064AT, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>hda: attached ide-disk driver.
>hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=13410/15/63
>Partition check:
> hda: [PTBL] [788/255/63] hda1
>
>One thing I want to mention here is that this disk supports 66MHz
> DMA access according to Fjuitsu's whitepaper. OTOH, the board
> running kernel 2.4.20 reports:
>
>Uniform Multi-Platform E-IDE driver Revision: 6.31
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx

This is correct, and for 2.4.20, I don't think the override works.

>ALI15X3: IDE controller on PCI bus 00 dev 78
>PCI: Assigned IRQ 10 for device 00:0f.0
>ALI15X3: chipset revision 194
>ALI15X3: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>hda: Maxtor 91021U2, ATA DISK drive
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx

And again, while slower, this is the default bus speed FOR PIO, 
Programmed I/O, not DMA.  Another animal entirely.  Running at this 
33MHZ speed, but without any handshaking, it can move 132Mb a second 
because each access is 32 bits, or 4 bytes, wide.  Which is still far 
faster than your drives can bring data past the heads.  You are 
confusing the UDMA66 mode which exists on the drive cable, with the 
bus speed the IDE card is plugged into, 2 entirely different animals.

>hdc: Maxtor 91021U2, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>blk: queue c02c60a4, I/O limit 4095Mb (mask 0xffffffff)
>hda: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=1245/255/63,
>UDMA(66)
>blk: queue c02c6408, I/O limit 4095Mb (mask 0xffffffff)
>hdc: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=19852/16/63,
>UDMA(66)
>Partition check:
> hda: hda1
> hdc: [PTBL] [1245/255/63] hdc1
>
>which looks to me that it supports DMA 66 as expected. I set the
> bios' of these 2 boxes to the same parameters related to IDE in
> menu "Integrated Peripherals".

You'll need good cables, and a lengthy read of the hdparm manpage.  
Then you can put the correct hdparm command to enable the UDMA66 mode 
right into your /etc/rc.d/rc.local script.

>Best Regards,
>
>CN

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

