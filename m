Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760073AbWLCUhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760073AbWLCUhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760076AbWLCUhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:37:20 -0500
Received: from ms.trustica.cz ([82.208.32.68]:16276 "EHLO ms.trustica.cz")
	by vger.kernel.org with ESMTP id S1760073AbWLCUhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:37:19 -0500
Message-ID: <4573353E.2060307@assembler.cz>
Date: Sun, 03 Dec 2006 21:36:14 +0100
From: Rudolf Marek <r.marek@assembler.cz>
User-Agent: Icedove 1.5.0.8 (X11/20061123)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: pata_via report
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I would like to report my experience with new pata_via driver.

Short version: works (no data were trashed, during the investigation), but the 
bits to detect the cable type are not set by BIOS.
There is also a bug in my BIOS, which kills the UDMA register.

Long version:
I have 80pin cable on primary master with western digital drive on it as slave. 
No other device on primary master. Secondary master is NEC DVDRW. I have two 
SATA drives, from which I boot the system.

ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xCC00 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xCC08 irq 15
scsi2 : pata_via
DEBUG ATA66: 0x07e1e607
ATA: abnormal status 0x8 on port 0x1F7
ATA: abnormal status 0x8 on port 0x1F7

When kernel boots it produces this messages. I already found out why, the BIOS 
incorrectly programs the 0x50 DWORD in PCI space (the UDMA register) so its 
value is somewhat mirrored like it is above. (I know it is a BIOS bug, I tried 
to dump the register in PCI init function) If I set the drive to master, then it 
is programmed correctly.

However my BIOS do not program the 80wire cable info, so I receive:
ata3.01: ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3.01: ata3: dev 1 multi count 16
ata3.01: configured for UDMA/33

I checked docs if VIA has some internal register/pin for the cable sense, but it 
does not. It is routed to some GPIO and the BIOS did not update this register.

My board is A8V-E SE, ASUS, I already wrote to their support, so I may have some 
news on this in future.

I think I'm not the only one with buggy BIOS, maybe the old is >UDMA33 active 
method will work for more people. Other solution would be to test the cable 
status via WORD 93 in IDENTIFY command, but this must be done "post" somehow,
I dont know if this is even possible or planed feature of libsata.

As for the wrong PCI register value, I think I would be able to develop some 
code test to detect this, but I dont know if you will accept it into the driver. 
Do we care about sane values?

There is no problem with secondary DVDRW drive, thanks to libsata, it recovers 
from media errors nicely.

Oh and one more thing. The cable sensing stuff is supported from newer VIA 
chipsets, older datasheets says "read as 0" but do NOT trust them. Often many 
VIA registers "read as 0" read as whatever. Maybe some check for chipset version
is necessary.

I hope it helps,

Rudolf

Please CC me on LKML posts.

00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 02 01 00 00
40: 3b f2 09 05 18 8c c0 00 5d 20 5d 20 ff 00 20 20
50: 07 e6 07 e1 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 a0 b9 3f 00 00 00 00 00 50 b2 3f 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 43 10 ed 80 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00 00

Version: ASUS A8V-E SE ACPI BIOS Revision 1010
   _NEC     DVD_RW ND-3520AW 3.06
     ATA      WDC WD2000JB-00G

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800/K8T890 South]

