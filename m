Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSFSVti>; Wed, 19 Jun 2002 17:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSFSVti>; Wed, 19 Jun 2002 17:49:38 -0400
Received: from jalon.able.es ([212.97.163.2]:21734 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318027AbSFSVtd>;
	Wed, 19 Jun 2002 17:49:33 -0400
Date: Wed, 19 Jun 2002 23:49:25 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Nick Papadonis <nick@coelacanth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX + v2.4.18 problems?
Message-ID: <20020619214925.GA1739@werewolf.able.es>
References: <m3k7ov2tly.fsf@noop.bombay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m3k7ov2tly.fsf@noop.bombay>; from nick@coelacanth.com on Wed, Jun 19, 2002 at 17:09:13 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.19 Nick Papadonis wrote:
>Is anyone else having problems with the AIC7XXX driver using a AHA-29160
>controller?  I believe my kernel is going into a unrecoverable spin-lock 
>when there is high SCSI load.  I'm assuming this because the keyboard 
>lights still function and network still replies to pings.
>
>In addition the 'st' driver returns with unrecoverable errors when 
>trying to tar to tape.  This usually occurs after a few hundred 
>megabytes have been pushed through a device.
>
>My setup is :
>   - AHA-29160N controller
>   - Internal 50 PIN / SCSI-2 port in use
>   - See below for connected drives
>
>I tested the following kernels and they display similar behavior:
>   - v2.4.9
>   - v2.4.18
>   - v2.4.18 with updated 7XXX driver
>   - v2.4.19-pre10
>

First of all, I have a setup like yours, and with 2 U160 drives hanged on the
LVD connector for the bus, and one zip and one CD on the 50-pin, everything
works fine:

annwn:/proc/scsi> cat scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAJ3364MP        Rev: 0115
  Type:   Direct-Access                    ANSI SCSI revision: 04
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: MAJ3364MP        Rev: 0115
  Type:   Direct-Access                    ANSI SCSI revision: 04
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1030
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.08
  Type:   Direct-Access                    ANSI SCSI revision: 02

annwn:/proc/scsi/aic7xxx> cat 0
Adaptec AIC7xxx driver version: 6.2.8
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
...
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
...
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 16)
        Curr: 10.000MB/s transfers (10.000MHz, offset 16)
...
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers

>
>DETAILS:
>Jun 19 01:25:15 bombay kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
>Jun 19 01:25:15 bombay kernel:         <Adaptec 29160 Ultra160 SCSI adapter>
>Jun 19 01:25:15 bombay kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
>Jun 19 01:25:15 bombay kernel: 
>Jun 19 01:25:15 bombay kernel:   Vendor: IBM       Model: DNES-318350       Rev: SAH0
>Jun 19 01:25:15 bombay kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
>Jun 19 01:25:15 bombay kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
>Jun 19 01:25:15 bombay kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
>Jun 19 01:25:15 bombay kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
>Jun 19 01:25:15 bombay kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02

You are hangin things on the 50pin connector, which is SE, so you could never
get 160Mb/s (LVD, transmit on up and down), you could at most go at 80Mb/s.

>
>Channel A Target 0 Negotiation Settings
>        User: 40.000MB/s transfers (40.000MHz DT, offset 255)
>        Goal: 20.000MB/s transfers (20.000MHz, offset 31)
>        Curr: 20.000MB/s transfers (20.000MHz, offset 31)

Hardware thinks the disk just can do Goal=20Mb/s. Why ?
It says nothing about 16 bits... Are you forcing it to narrow
with a jumper ??

>Channel A Target 2 Negotiation Settings
>        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
>        Goal: 20.000MB/s transfers (20.000MHz, offset 15)
>        Curr: 20.000MB/s transfers (20.000MHz, offset 15)

It recognizes the drive can do wide, but as the first device in the
chain forced narrow, goal is narrow.

>Channel A Target 3 Negotiation Settings
>        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
>        Goal: 40.000MB/s transfers (40.000MHz, offset 127)
>        Curr: 3.300MB/s transfers

Same as above....

Move the fast drive to the LVD connector, and chech for jumper settings on
that drive.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
