Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312879AbSCYXmW>; Mon, 25 Mar 2002 18:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312880AbSCYXmN>; Mon, 25 Mar 2002 18:42:13 -0500
Received: from smcc-2.demon.nl ([212.238.194.110]:8211 "HELO smcc.demon.nl")
	by vger.kernel.org with SMTP id <S312879AbSCYXmA>;
	Mon, 25 Mar 2002 18:42:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Organization: I'm not organized
Message-Id: <200203252338.04352@smcc.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: ncr53c8xx SCSI controller hang with 2.5 (and a clue)
Date: Tue, 26 Mar 2002 00:41:58 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've had some trouble trying to boot my system with a 2.5 kernel recently, 
but it would hang in the SCSI device detection routine; it would only find 
the first 2 devices (my 2 disks), but stop there. The machine remains 
responsive though (numlock works, ctrl-alt-del gives a clean reboot)

After some fiddling I could get it to boot, but the solution might elude 
others. And I'm quite sure the fix is a one-line patch. Oh yeah, needless 
to say, this system works flawlessly with 2.4.18 :-)

First, system parameters: PIIBX motherboard with a PII-400 Celeron, 
a Diamond Fireport 40 SCSI controller with a ncr53c875J chip, with 2 
(internal) harddisks and 2 (external) CD burners:

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: GENERIC  Model: CRD-RW2          Rev: 1.12
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: JVC      Model: XR-W2010         Rev: 1.51
  Type:   WORM                             ANSI SCSI revision: 02

In addition there's an IDE disk and a CDROM attached (I boot from IDE).

Normally, during the 2.4.18 boot, the following messages appear:

ncr53c8xx: at PCI bus 0, device 9,function 0
ncr53c8xx: 53c875J detected with Symbios NVRAM
ncr53c875J-0: rev 0x4 on pci bus 0 device 9 function 0 irq 15
ncr53c875J-0: Symbios format NVRAM, ID 7,Fast-20, Parity Checking
ncr53c875J-0: on-chip RAM at 0xe3001000
ncr53c875J-0: restart (scsi reset).
ncr53c875J-0: Downloading SCSI SCRIPTS. scsi0 : ncr53c8xx-3.4.3b-20010512

Followed by the detection of the disks and burners, followed by the MD 
sublayer messages (I'm using mirroring and striping).

I've tried kernel 2.5.5 and 2.5.6; 2.5.5 would stop with a mysterious 
message about a block not found or out of bounds. 2.5.6 stops right after 
the messages about the SCSI disks. I though that maybe the driver was 
confused by the fact that I compiled the SCSI-CDROM part as a module, so I 
un-moduled that and linked it in: no difference.

Then, I unplugged the SCSI burners, thinking that might be the problem: 
unfortunately, it still stops at the same spot. BTW: I can see the burners 
react on some probing or resetting of the bus, since some of the LEDs go on 
and off.

Next, I tried the syn53c8xx driver instead of ncr53c8xx driver: again, no 
difference.

Then, I recalled that in a far, far away past I had poked around in the 
BIOS of the SCSI controller; in there, you can specify for each of the 15 
SCSI IDs (it supports wide SCSI) if it should probe the ID for a device. 
Since each probe takes a second or so and I don't like waiting, I enabled 
only those IDs which I knew had a SCSI device attached. And this is exactly 
where the ncr53c8xx driver hangs.

As it turns out, SCSI ID 2 is the first empty slot, and this is where the 
driver stops scanning. After enabling "Scan Device...." in the SCSI BIOS 
for this slot, it would boot finding the disks and the burners (ids 0,1, 3 
and 4), but of course stop at ID 5. Only after enabling scanning of all 
IDs, I'm able to boot properly into Linux.

Since it worked fine in 2.4., I'm quite sure this is only a small goof-up 
and easy to fix... I don't know enough about the SCSI drivers to do it 
myself :-( But I can always test something if you want. Since it's not 
clear who maintains this driver I'm sending this report to this list...

 - Nemosoft



