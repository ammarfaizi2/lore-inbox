Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCTLTG>; Tue, 20 Mar 2001 06:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRCTLS4>; Tue, 20 Mar 2001 06:18:56 -0500
Received: from blueberry.jellybean.co.uk ([194.88.75.31]:63752 "EHLO
	blueberry.jellybean.co.uk") by vger.kernel.org with ESMTP
	id <S129568AbRCTLSo>; Tue, 20 Mar 2001 06:18:44 -0500
Date: Tue, 20 Mar 2001 11:17:38 +0000
From: Jules Bean <jules@jellybean.co.uk>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA resets with ALI15X3 on Aladdin V
Message-ID: <20010320111737.B8625@blueberry.jellybean.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an intermittent problem with my IDE setup:

pear# dmesg | grep -i ide
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
scsi0 : SCSI host adapter emulation for IDE ATAPI devices

pear# lspci   
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev
03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA
Bridge [Aladdin IV] (rev c3)
00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 
08)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c2)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3
(rev 01)


It works absolutely fine under normal load; I see the very occasional 

Mar 18 12:23:01 pear kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Mar 18 12:23:01 pear kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }

but they don't seem to affect performance.

However, very occasionally, normally when the HD is under very heavy
load, I get messages like this:

Mar 20 10:24:05 pear kernel: hda: timeout waiting for DMA
Mar 20 10:24:05 pear kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
Mar 20 10:24:05 pear kernel: hda: irq timeout: status=0x58 {
DriveReady SeekComplete DataRequest }
Mar 20 10:24:05 pear kernel: hda: status timeout: status=0xd0 { Busy }
Mar 20 10:24:05 pear kernel: hda: drive not ready for command
Mar 20 10:24:05 pear kernel: ide0: reset: success

This is accompanied by a freeze of the machine, which in this
particular instance sorted itself out.  Sometimes, the machine goes
down hard, causing some disk corruption (always minor, thankfully, so
far).

This all sounds very like that described in the thread which starts at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0006.1/0924.html
although he didn't seem to get an actually crashes from it.

Sometimes I also hear alarming clicking sounds from the disk; on those 
occasions, the crash is hard, and the machine has to be reset.

Is this a hardware fault?  I would think so, except for the
intermittent dma_intr errors suggesting there could be a motherboard
problem too?

The disk is as follows:

pear# cat /proc/ide/hda/model 
Maxtor 91080D5

(It does normally seem to be that disk, but the other disk is much
smaller anyhow).

I do also sometime see problems with hdd, which is an ATAPI
cd-rom. This normally happens after there's been some problem with
hda, and I get:

Mar 20 09:56:04 pear kernel: scsi0 : SCSI host adapter emulation for
IDE ATAPI devices
Mar 20 09:56:04 pear kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
Mar 20 09:56:04 pear kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
Mar 20 09:56:04 pear kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Mar 20 09:56:04 pear kernel: SCSI bus is being reset for host 0
channel 0.
Mar 20 09:56:04 pear kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
[repeated many times, before finally:]
Mar 20 09:56:04 pear kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Mar 20 09:56:04 pear kernel: SCSI bus is being reset for host 0
channel 0.
Mar 20 09:56:04 pear kernel: hdc: timeout waiting for DMA
Mar 20 09:56:04 pear kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
Mar 20 09:56:04 pear kernel: hdc: irq timeout: status=0x50 {
DriveReady SeekComplete }
Mar 20 09:56:04 pear kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
Mar 20 09:56:04 pear kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Mar 20 09:56:04 pear kernel: SCSI bus is being reset for host 0
channel 0.
Mar 20 09:56:04 pear kernel: hdd: irq timeout: status=0xd0 { Busy }
Mar 20 09:56:04 pear kernel: hdd: DMA disabled
Mar 20 09:56:04 pear kernel: hdd: ATAPI reset complete
Mar 20 09:56:04 pear kernel: hdd: status error: status=0x08 {
DataRequest }
Mar 20 09:56:04 pear kernel: hdd: drive not ready for command
Mar 20 09:56:04 pear kernel: hdd: status timeout: status=0x80 { Busy }
Mar 20 09:56:04 pear kernel: hdd: drive not ready for command
Mar 20 09:56:04 pear kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
Mar 20 09:56:04 pear kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Mar 20 09:56:04 pear kernel: SCSI bus is being reset for host 0
channel 0.
Mar 20 09:56:04 pear kernel: hdd: ATAPI reset complete
Mar 20 09:56:04 pear kernel: hdd: irq timeout: status=0x80 { Busy }
Mar 20 09:56:04 pear kernel: hdd: status error: status=0x08 {
DataRequest }
Mar 20 09:56:04 pear kernel: hdd: drive not ready for command
Mar 20 09:56:04 pear kernel: hdd: status timeout: status=0x80 { Busy }
Mar 20 09:56:04 pear kernel: hdd: drive not ready for command
Mar 20 09:56:04 pear kernel: hdd: ATAPI reset complete

This is another reason to think it's not my hda, right?  If it gets
confused with hdc and hdd too?

This is all using kernel 2.4.0, but I did used to see similar errors
with 2.2 + IDE patches.

Obviously I'll supply any more detail needed.

Please Cc: me on replies.

Jules

Meta: Is this the right forum for this question?  If not, where? The
FAQ at tux.org suggests mailing the driver author directly, but normal 
netiquette suggests to me that Andre gets enough mail as it is and
would prefer questions to go via the mailing list.
