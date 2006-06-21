Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWFUPUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWFUPUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWFUPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:20:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:53547 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932171AbWFUPUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:20:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CM/PBeba4oQyd+pM67LeAVfndryWfPIxejQvEjNyQFMBHCcTEkYxvzgCZEodOZM3pNxNpn9Ef/iiC+/3H/szQeoFojFrprVxjfggHksEgjaUP1ip9N3praesMxAh173jzX/MHOgA2u7PYbILELCIsy/d986d+LPwtoJ7dhARxeU=
Message-ID: <170fa0d20606210820l5a41150bs7e8a088d85ca8d3b@mail.gmail.com>
Date: Wed, 21 Jun 2006 11:20:12 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for PDC202XX
Cc: Erik@echohome.org, linux-kernel@vger.kernel.org
In-Reply-To: <1150898829.15275.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
	 <1150887073.15275.34.camel@localhost.localdomain>
	 <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
	 <1150896840.15275.62.camel@localhost.localdomain>
	 <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
	 <1150898829.15275.69.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-06-21 am 09:34 -0400, ysgrifennodd Mike Snitzer:
> > I have a PDC20267 and tried out 2.6.17 + linux-2.6.17-ide1.gz  The
> > resulting pata_pdc202xx_old module didn't initialize the controller on
> > boot (via initrd).  Is there some other CONFIG option or linux cmdline
> > that should be used?
>
> No it should find it as soon as you load the module. If the device is
> not the primary IDE controller (hda-hdd) you can set CONFIG_IDE = y,
> include drivers for your other controller and get some debug info.
>
> Usually "it didnt initialize" reports are from people with mixed old/new
> IDE in their kernel or initrd, or initrds missing the required modules.
>
> Stick a printk in pdc_init before the pci_register_driver call and
> you'll know for sure if the module is getting loaded. If it is then send
> me an lspci and I'll have a deeper look

The PDC20267 is the primary controller, I do not have CONFIG_IDE set.
The issue with my initrd was mkinitrd --with=pata_pdc202xx_old didn't
include sd_mod; setting scsi_hostadapter accordingly in modprobe.conf
took care of this.

Once the kernel booted the system was seemingly starting without any
problems until various services tried to write files to the root
filesystem.  Each write attempt resulted in a "Read-only filesystem"
error yet all filesystems were mounted read-write.

The kernel had a ton of errors:

Buffer I/O error on device sda3, logical block 4869508
lost page write due to I/O error on sda3
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=0x27a3f9b

lspci output is:

00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated
Graphics Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:01.0 Unknown mass storage controller: Promise Technology, Inc.
PDC20267 (FastTrak100/Ultra100) (rev 02)
01:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet
Controller (rev 02)
