Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCLG30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 01:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUCLG30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 01:29:26 -0500
Received: from pri-dns2.mtco.com ([207.179.200.252]:37804 "HELO
	pri-dns2.mtco.com") by vger.kernel.org with SMTP id S261979AbUCLG3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 01:29:21 -0500
From: Tom Felker <tcfelker@mtco.com>
To: "psycosonic" <psycosonic@rootisg0d.org>
Subject: Re: Abysmal network performance since 2.4.25 !!!!!...
Date: Fri, 12 Mar 2004 00:31:09 -0600
User-Agent: KMail/1.6
Cc: <linux-net@oss.sgi.com>, <linux-kernel@vger.kernel.org>
References: <004c01c407cf$5fffa270$0700a8c0@darkgod>
In-Reply-To: <004c01c407cf$5fffa270$0700a8c0@darkgod>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403120031.09602.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 7:14 pm, psycosonic wrote:

> Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , with
> 2.4.25 it only goes to 2,2Mb/s MAX speed.  :(
> I've tried to use vsftpd, proftpd, apache 1.3.x, apache 2.x, samba.. etc

I'm assuming you meant MBytes/s, and assuming you're timing large file 
transfers, where disk speed could be a limiting factor.  12 MB/s is 96Mbit/s, 
which sounds about right for Ethernet.  Hard drive transfer rates are usually 
20-40.  But without DMA, in my experience, it can fall to around 2 MB/s, 
which is about what you're getting.

The dmesg from the first machine says DMA is on, but the second machine's 
dmesg doesn't mention it.  The following info, for both machines and all 
drives, would be helpful:

hdparm /dev/hdx
hdparm -t /dev/hdx

And if you notice DMA is 0, you might try 

hdparm -d 1 /dev/hdx

But be careful.  It's entirely possible that DMA got disabled because it was a 
risk on your drive or chipset.

> Mar 10 21:44:15 rootisg0d kernel: Uniform Multi-Platform E-IDE driver
> Revision: 7.00beta4-2.4
> Mar 10 21:44:15 rootisg0d kernel: ide: Assuming 33MHz system bus speed for
> PIO modes; override with idebus=xx
> Mar 10 21:44:15 rootisg0d kernel: ALI15X3: IDE controller at PCI slot
> 00:0f.0
> Mar 10 21:44:15 rootisg0d kernel: PCI: Hardcoded IRQ 14 for device 00:0f.0
> Mar 10 21:44:15 rootisg0d kernel: ALI15X3: chipset revision 194
> Mar 10 21:44:15 rootisg0d kernel: ALI15X3: not 100%% native mode: will
> probe irqs later
> Mar 10 21:44:15 rootisg0d kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
> settings: hda:DMA, hdb:pio
> Mar 10 21:44:15 rootisg0d kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS
> settings: hdc:pio, hdd:DMA
> Mar 10 21:44:15 rootisg0d kernel: ide: Assuming 33MHz system bus speed for
> PIO modes; override with idebus=xx
> Mar 10 21:44:15 rootisg0d kernel: hda: 40021632 sectors (20491 MB)
> w/2048KiB Cache, CHS=2491/255/63, UDMA(66)
> Mar 10 21:44:15 rootisg0d kernel: hdd: ATAPI 48X CD-ROM drive, 128kB Cache,
> DMA
> Mar 10 21:44:15 rootisg0d kernel: Uniform CD-ROM driver Revision: 3.12
> Mar 10 21:44:15 rootisg0d kernel: Partition check:
> Mar 10 21:44:15 rootisg0d kernel:  hda: hda1 < hda5 > hda2

> Let's check the second...

> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hda: ST380011A, ATA DISK drive
> hdb: ST360014A, ATA DISK drive
> hdc: ASUS DVD-ROM E612, ATAPI CD/DVD-ROM drive
> hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63
> hdb: attached ide-disk driver.
> hdb: host protected area => 1
> hdb: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63
> hdc: attached ide-cdrom driver.
> hdc: ATAPI 40X DVD-ROM drive, 640kB Cache
> Uniform CD-ROM driver Revision: 3.12
> hdd: attached ide-cdrom driver.
> hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
> Partition check:
>  hda: hda1 hda2
>  hdb: unknown partition table

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

ruby -r complex -e 
'c,m,w,h=Complex(-0.75,0.136),50,150,100;puts"P6\n#{w}\n#{h}\
n255";(0...h).each{|j|(0...w).each{|i|n,z=0,Complex(.9*i/w,.9*j/h);while 
n<=m&&(
z-c).abs<=2;z=z*z+c;n+=1 end;print [10+n*15,0,rand*99].pack("C*")}}'|display
#by Michael Neumann AFAICT
