Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965271AbWGJWVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbWGJWVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWGJWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:21:34 -0400
Received: from smtp.ono.com ([62.42.230.12]:51040 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S965272AbWGJWVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:21:33 -0400
Date: Tue, 11 Jul 2006 00:21:16 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060711002116.3bb8e329@werewolf.auna.net>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs78 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 02:11:06 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 

Hi...

I'm using this plus Jeff Garzik's alloc/free cleanup patch for libata.
In my home box it works fine wrt CD-ROMs (ata-piix).

My RAID box at work has this hardware:

00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0a.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a4)

ie, a VIA PATA on-board (with just a DVD-RW), a Promise 20267 also on board
(anything hung there), an Adaptec 7892 for the system disk and 2 Promise
SATA cards for a RAID5 (software md).

I have aic driver builtin, and sata_promise and pata_via as modules.
In previous kernels I used the IDE drivers for the CD, but I have tried to
switch to libata. I looked here:

http://zeniv.linux.org.uk/~alan/IDE/STATUS.txt

and read:

VIA:
	Added IRQ masking support
	Completed

Now the problems. pata_via takes an eon to load:

nada:~# time modprobe pata_via0.00user 0.01system 2:13.17elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k0inputs+0outputs (0major+208minor)pagefaults 0swaps
and it does not detect the burner, as ata_piix did in my home box:

Jul 10 16:15:28 nada kernel: pata_via 0000:00:11.1: version 0.1.13
Jul 10 16:15:28 nada kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
Jul 10 16:15:28 nada kernel: ata9: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
Jul 10 16:15:28 nada kernel: scsi9 : pata_via
Jul 10 16:15:29 nada kernel: ata9.00: ATAPI, max UDMA/33
Jul 10 16:15:59 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 16:15:59 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 16:15:59 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 16:15:59 nada kernel: ata9.00: limiting speed to UDMA/25
Jul 10 16:15:59 nada kernel: ata9: failed to recover some devices, retrying in 5 secs
Jul 10 16:16:34 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 16:16:34 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 16:16:34 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 16:16:34 nada kernel: ata9: failed to recover some devices, retrying in 5 secs
Jul 10 16:17:10 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 16:17:10 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 16:17:10 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 16:17:10 nada kernel: ata9.00: disabled
Jul 10 16:17:10 nada kernel: ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
Jul 10 16:17:10 nada kernel: scsi10 : pata_via
Jul 10 16:17:17 nada kernel: ata10: port is slow to respond, please be patient
Jul 10 16:17:40 nada kernel: ata10: port failed to respond (30 secs)
Jul 10 16:17:40 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 16:17:40 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 16:17:40 nada kernel: ata10: softreset failed, retrying in 5 secs
Jul 10 16:17:45 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 16:17:45 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 16:17:45 nada kernel: ata10: softreset failed, retrying in 5 secs
Jul 10 16:17:51 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 16:17:51 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 16:17:51 nada kernel: ata10: reset failed, giving up

(note: the previous ata channels are:
libata version 2.00 loaded.
sata_promise 0000:00:07.0: version 1.04
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8818200 ctl 0xF8818238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8818280 ctl 0xF88182B8 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8818300 ctl 0xF8818338 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8818380 ctl 0xF88183B8 bmdma 0x0 irq 17
ata5: SATA max UDMA/133 cmd 0xF881A200 ctl 0xF881A238 bmdma 0x0 irq 18
ata6: SATA max UDMA/133 cmd 0xF881A280 ctl 0xF881A2B8 bmdma 0x0 irq 18
ata7: SATA max UDMA/133 cmd 0xF881A300 ctl 0xF881A338 bmdma 0x0 irq 18
ata8: SATA max UDMA/133 cmd 0xF881A380 ctl 0xF881A3B8 bmdma 0x0 irq 18
)

nada:/var/log# lsscsi -H
[0]    aic7xxx     
[1]    sata_promise
[2]    sata_promise
[3]    sata_promise
[4]    sata_promise
[5]    sata_promise
[6]    sata_promise
[7]    sata_promise
[8]    sata_promise
[9]    pata_via    
[10]    pata_via    

nada:/var/log# lsscsi
[0:0:0:0]    disk    IBM      DDYS-T18350N     S96H  /dev/sda
[1:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdb
[2:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdc
[3:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdd
[4:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sde
[5:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdf
[6:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdg
[7:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sdh

In my home box I get:

werewolf:~> lsscsi -H
[0]    ata_piix    
[1]    ata_piix    
[2]    ata_piix    
[3]    ata_piix    
[4]    sata_promise
[5]    sata_promise
[6]    sata_promise
[7]    usb-storage 

werewolf:~> lsscsi
[0:0:0:0]    cd/dvd  HL-DT-ST DVDRAM GSA-4120B A111  /dev/sr0
[0:0:1:0]    disk    IOMEGA   ZIP 250          51.G  /dev/sda
[1:0:0:0]    disk    ATA      ST3120022A       3.06  /dev/sdb
[1:0:1:0]    cd/dvd  TOSHIBA  DVD-ROM SD-M1712 1004  /dev/sr1
[2:0:0:0]    disk    ATA      ST3200822AS      3.01  /dev/sdc
[7:0:0:0]    disk    LG       USBDrive         1100  /dev/sdd

Any ideas ? There is a CDRW in ata9...

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam03 (gcc 4.1.1 20060518 (prerelease)) #3 SMP PREEMPT Mon
