Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQLZNbC>; Tue, 26 Dec 2000 08:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130592AbQLZNam>; Tue, 26 Dec 2000 08:30:42 -0500
Received: from cegt201.bradley.edu ([136.176.49.21]:1935 "EHLO
	cegt201.bradley.edu") by vger.kernel.org with ESMTP
	id <S130196AbQLZNac>; Tue, 26 Dec 2000 08:30:32 -0500
Message-ID: <3A489652.4360FD62@cegt201.bradley.edu>
Date: Tue, 26 Dec 2000 07:00:02 -0600
From: "J.D." <jodaman@cegt201.bradley.edu>
X-Mailer: Mozilla 3.04Gold (X11; I; Linux 2.2.18 i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 ide access warps time, stalls serial, slows MIDI, mouse
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed a possible problem in Linux 2.2.18 relating to a
CD-R drive connected to the secondary ide port.  I'm not certain
whether the problem cause is in the kernel software, in the
hardware, or in a combination thereof.  Although I've found a
way to bypass the problem, I'm including a description here for
anyone who wishes to better document the issue or create a more
robust kernel.

While the IDE CD-R drive works perfectly in and of itself,
continuous access to the drive degrades the operation of other
system tasks.  Pointer movement with XFree86 4.0.1 or gpm
becomes noticeably choppy, MIDI music playback under the ALSA
drivers (0.5.10) progresses in slow motion, and network access
through an external modem connected to a serial port all but
ceases to function.

Additional investigation also revealed that the system's notion
of time slows down.  For example, during continuous read access
from the IDE CD-R drive, a 55 second piece of MIDI music is
stretched out to nearly a minute and a half.  While "time"
consistently reports about 57 elapsed real seconds, manually
timing the MIDI playback yielded the following repeatable
results at various processor speeds:
  500 MHz: 86 seconds
  650 MHz: 85 seconds
  750 MHz: 83 seconds
Likewise, repeated application of "date" shows that system time
progresses slower than real time.

With no CD-R access, "time" reports about 55 elapsed real 
seconds for the 55 second MIDI playback test, and a stopwatch
confirms this time.  System time as reported by "date" also
advances correctly.

The problem appears whether using the CD-R drive for continuous
reading (at ~3 MB per second) or writing (at ~600 KB per
second).  Trying "ide-cd" for read access instead of "ide-scsi"
shows the same problem.

The CD-R drive is wired as the master on the secondary IDE port,
with an ATAPI Zip drive wired as the slave, with nothing
connected to the primary IDE port.  Access to the Zip drive
(continuous read at ~700 KB per second) does not cause the
problem, and removing the Zip drive from the system does not
offer a remedy.  All SCSI drives accessed through the Symbios
8751 SCSI adapter work fine with no side effects.  

The problem disappears when the wiring for the CD-R drive is
switched from the secondary IDE port to the primary IDE port.

The compiler version used to build the 2.2.18 kernel reads:
  gcc version 2.95.2 20000220 (Debian GNU/Linux) 
Double checking by building the same kernel with gcc version
2.7.2.3 again demonstrates the same behavior.


Mainboard/Processor: ABit KT7 / 650 MHz Athlon (model 4)


"cat /usr/src/linux/.config | grep IDE | grep =":
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_PARIDE_PARPORT=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_SELECT=y
CONFIG_VIDEO_SELECT=y


"cat /proc/scsi/scsi":
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAB3045SC        Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: MAB3045SC        Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-20TS   Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: 24.D
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W8432T Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02


Regards,

- John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
