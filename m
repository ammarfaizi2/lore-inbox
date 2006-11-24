Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757785AbWKXOac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbWKXOac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 09:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934623AbWKXOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 09:30:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:13022 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757785AbWKXOaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 09:30:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IAgemIu3PUWdDEfyreP342zPgtHptTj3fGGaSeguoV2O7acbJCztRfvOGOOPDVemPGZg3COrXzlxx1bAGdr4LqKZLYiW2qyxaC7gI+mhlKiZKNNONOjJF/et9bH9fa5eYLXMHGnuY6IcF/kbMwMXXLNge4p6SfaSwNei5DzFesw=
Message-ID: <6278d2220611240630r48d6a406sacdf5ee2ab5903b2@mail.gmail.com>
Date: Fri, 24 Nov 2006 14:30:27 +0000
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Martin A. Fink" <fink@mpe.mpg.de>, Alan <alan@lxorguk.ukuu.org.uk>,
       "Jeff Garzik" <jeff@garzik.org>
Subject: Re: SATA Performance with Intel ICH6
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Ed Sweetman" <safemode2@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same issue - I have an ICH6M w/ SATAII-300 disk
(running in SATA I-150 mode), running in native AHCI mode. Processor
is Pentium-M 1.7GHz 2MB L2$, DDR2-667.

The kernel is stock-compiled 2.6.19-rc6 on current Debian stable (gcc
4.1.2) - and I saw this on previous kernels also. When read()ing 16KB
or 1MB chunks from the disk, I'm getting 65MB/s (expected) [1], but at
a surprising ~12% system time [2].

Oprofile [3] shows nothing unexpected. Kernel messages [4] look like
it's configured correctly too. Spinlocks or what?

--- [1]

# dd if=/dev/sda of=/dev/null bs=1024k
<Ctrl-C>
3532+0 records in
3531+0 records out
3702521856 bytes (3.7 GB) copied, 56.5266 seconds, 65.5 MB/s

--- [2]

# vmstat 2
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
[snip]
 0  1      0   9532 537632  79812    0    0     0     0 1348 1217  0 11  0 89
 0  1      0   9944 576888  41724    0    0     0     0 1343 1195  0 12  0 89

--- [3]

# opreport -lt1
CPU: PIII, speed 1700 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with
a unit mask of 0x00 (No unit mask) count 100000
warning: /usr/lib/locale/locale-archive is not in a usable binary format.
samples  %        app name                 symbol name
19710    38.9965  vmlinux                  __copy_to_user_ll
13573    26.8544  vmlinux                  default_idle
982       1.9429  vmlinux                  isolate_lru_pages
661       1.3078  vmlinux                  kmem_cache_free
521       1.0308  vmlinux                  kmem_cache_alloc

--- [4]

$ dmesg | less
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf800-0xf807, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: TRANSCEND, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 8124480 sectors (4159 MB) w/1KiB Cache, CHS=8060/16/63, DMA
 hda: hda1 hda2
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF080E100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF080E180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF080E200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF080E280 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda

Alan wrote:
> On Fri, 24 Nov 2006 14:07:01 +0100
> "Martin A. Fink" <fink@mpe.mpg.de> wrote:
>
> > If I understand the design of this chipset correctly, then I would have
> > expected, that the CPU needs to do only few work, instead I found out, that
> > writing to disk seems to be really hard work for the CPU.
>
> It has some work to do - the amount in question depends upon the file
> system and device drivers in use. For very high throughput read up on
> the O_DIRECT feature.
>
> > My final aim is to get around 140MB/s of data from 3 different Gigabit
> > Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
> > >From the SATA bus side there should be no problem. Each of the 4 SATAs on
> > this ICH6 chipset are capable of 150MB/s.
>
> I doubt an ICH6 has the total memory bandwidth to achieve that to be
> honest, but with PCI-E maybe you can.
>
> > So what makes my CPU that slow? Is it a hardware problem or a problem of
> > SATA driver of my operating system?
>
> You don't give anything like enough information to even guess this. What
> controller, what disks, what driver, what kernel version ?
>
> > By the way: I'm working with SuSE Linux 9.2 on a Dell Desktop PC, 1GB RAM
>
> For vendor kernels, especially older ones it is probably best to ask the
> vendor first.
>
> Alan
-- 
Daniel J Blueman
