Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTLJTS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLJTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:18:56 -0500
Received: from medusa.csi-inc.com ([204.17.222.19]:49046 "EHLO
	medusa.csi-inc.com") by vger.kernel.org with ESMTP id S263890AbTLJTSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:18:52 -0500
Message-ID: <02f701c3bf52$6f6a3240$c8de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: hdparm and DMA
Date: Wed, 10 Dec 2003 14:18:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing IDE hotswap using hdparm's ability to reset the IDE bus.
Problem is, even though it seems to work I can' re-enable DMA on the drive afterwards without a reboot.
This is similar to a problems I had with the via8xxxx module which when compiled as module couldn't get DMA going either.

I'm running 2.4.23.  And here's the two different IDE reports:

Boot messages where DMA is fine:
Dec  9 05:21:04 picard kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Dec  9 05:21:04 picard kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  9 05:21:04 picard kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Dec  9 05:21:04 picard kernel: VP_IDE: chipset revision 6
Dec  9 05:21:04 picard kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec  9 05:21:04 picard kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  9 05:21:04 picard kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
Dec  9 05:21:04 picard kernel:     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
Dec  9 05:21:04 picard kernel:     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
Dec  9 05:21:04 picard kernel: hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
Dec  9 05:21:04 picard kernel: hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63, UDMA(100)

After running idectl to add remove and add the drive back to the IDE bus.
Dec  8 08:04:16 picard kernel: hdc: WDC WD1200JB-00DUA3, ATA DISK drive
Dec  8 08:04:16 picard kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  8 08:04:16 picard kernel: hdc: attached ide-disk driver.

And trying to turn DMA on produces:
hdparm -d 1 /dev/hdc

/dev/hdc:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Operation not permitted
using_dma    =  0 (off)

Also I end up with multiple ide1 entreis in /proc/ide (one for every time I re-add the drive):
drivers  hda@     hdc@     ide0/    ide1/    ide1/    via

So it looks like the reset is not occuring on the VIA but on the higher level IDE bus.

Here's the idectl script from hdparm-5.4
#!/bin/sh

HDPARM=/sbin/hdparm
MAX_IDE_NR=1

IDE_IO_0=0x1f0
IDE_IO_1=0x170

USE_IDE_DEV_0=/dev/hdc
USE_IDE_DEV_1=/dev/hda

usage () {
       if [ $# -gt 0 ]; then
               echo $* >&2
               echo
       fi

       echo "usage: $0 ide-channel-nr [off|on|rescan]" 2>&1
       exit 1
}

IDE_NR=$1
MODE=$2

do_register=0
do_unregister=0


if [ ! "$IDE_NR" ] || [ $IDE_NR -lt 0 ] || [ $IDE_NR -gt $MAX_IDE_NR ]; then
       usage "Unrecognized IDE-channel number"
fi

case "$MODE" in
on )            do_register=1 ;;
off )           do_unregister=1 ;;
rescan )        do_unregister=1; do_register=1 ;;
* )                     usage "Unrecognized command" ;;
esac

eval "IDE_IO=\$IDE_IO_$IDE_NR"
eval "USE_IDE_DEV=\$USE_IDE_DEV_$IDE_NR"

[ $do_unregister -eq 1 ] && eval "$HDPARM -U $IDE_NR $USE_IDE_DEV > /dev/null"
[ $do_register -eq 1 ] && eval "$HDPARM -R $IDE_IO 0 0 $USE_IDE_DEV > /dev/null"

ioctl(3, 0x326, 0x1)                    = 0
ioctl(3, 0x30b, 0x8053664)              = 0
write(1, " using_dma    =  1 (on)\n", 24 using_dma    =  1 (on)
) = 24


Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL
