Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272012AbRH2P7U>; Wed, 29 Aug 2001 11:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272008AbRH2P7L>; Wed, 29 Aug 2001 11:59:11 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:8701 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S272009AbRH2P66>;
	Wed, 29 Aug 2001 11:58:58 -0400
Date: Wed, 29 Aug 2001 16:57:59 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Odd aic7xxx behaviour
Message-ID: <Pine.LNX.4.21.0108291633080.4488-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, could anyone help explain what is going on here?

I've got an HP LH6000r with a built-in NetRaid/MegaRAID controller and
also an Adaptec chip, a 7880U. In fact, here's the PCI listing:

root@spud:~# lspci -vvt
-+-[04]-+-02.0  Hewlett-Packard Company NetServer PCI Hot-Plug Controller
 |      +-02.1  Hewlett-Packard Company NetServer SMIC Controller
 |      +-03.0-[05]--+-07.0  Adaptec AIC-7880U
 |      |            \-08.0  Hewlett-Packard Company NetServer Smart IRQ Router
 |      \-03.1  Intel Corporation 80960RP [i960RP Microprocessor]
 \-[00]-+-00.0  Relience Computer CNB20HE
        +-00.1  Relience Computer CNB20HE
        +-00.2  Relience Computer: Unknown device 0006
        +-00.3  Relience Computer: Unknown device 0006
        +-06.0  Intel Corporation 82557 [Ethernet Pro 100]
        +-07.0  ATI Technologies Inc 3D Rage IIC
        +-0f.0  Relience Computer: Unknown device 0200
        \-0f.1  Relience Computer: Unknown device 0211

I've got two drive hotswap cage/backplane "thingies", one is connected to
the internal SCSI A channel (ie. the MegaRAID), and the other is plugged
onto the Adaptec header. (The reason I'm doing this is I'm temporarily
using the second cage to build up some software mirrored disks that will
be used in other non-RAID machines, and you can't mix RAID and non-RAID
disks on the MegaRAID. It'll eventually end up on SCSI B).

I got 4 brand new HP 18GB 10K U160 disks and loaded 'em into the cage, the
first thing I noticed was that I got 3 of one kind, and 1 of another. All
branded HP, with the same geometry, etc. but noticeably different casing.

Anyway, booting up kernel 2.4.9 I can see all the disks, here's
/proc/scsi/scsi for clarity:

Attached devices:
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: SAFTE; U160/M BP Rev: 1023
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-D94N Rev: D94N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 11 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-D94N Rev: D94N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-D94N Rev: D94N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 13 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-H008 Rev: H008
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: SAFTE; U160/M BP Rev: 1023
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 02 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID5 26031R Rev:   E
  Type:   Direct-Access                    ANSI SCSI revision: 02

I've used the first two 18GB disks to build up a pair of mirrored disks,
no problem, they work fine. I partitioned the next two disks, (one of each
"type"), and then went to run mkraid on them. The access LED jammed on the
odd disk (Id 13), and I got this repeated in dmesg:

scsi0:0:13:0: Attempting to queue an ABORT message
scsi0:0:13:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:13:0: Attempting to queue an ABORT message
Recovery SCB completes
(scsi0:A:13:0): Queuing a recovery SCB
scsi0:0:13:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 8194

...and then this repeated:

scsi: device set offline - not ready or command retry failed after bus
reset: host 0 channel 0 id 13 lun 0
scsi0:0:13:0: Attempting to queue an ABORT message
scsi0:0:13:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194

...and finally this repeated:

SCSI disk error : host 0 channel 0 id 13 lun 0 return code = 50000
 I/O error: dev 08:35, sector 5088

...with the sector value changing.

It looks to me like the disk is shafted, but it's brand new, it came
shrink-wrapped. I realise the Adaptec controller probably isn't U160, but
I figured the disks would still work, just slower than they might, and at
least two of them do, no problems with one pair of mirrored disks.

Can anyone clarify what's going on? I'm running 2.4.9 with both the
aic7xxx driver and the megaraid compiled in.

Cheers

Matt

--
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy."

