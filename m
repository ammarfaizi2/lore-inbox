Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRFATE3>; Fri, 1 Jun 2001 15:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRFATEU>; Fri, 1 Jun 2001 15:04:20 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:59362 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S261289AbRFATEP>;
	Fri, 1 Jun 2001 15:04:15 -0400
From: thunder7@xs4all.nl
Date: Fri, 1 Jun 2001 21:03:46 +0200
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
Message-ID: <20010601210346.A1069@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere> <3B16AD5D.DEDB8523@colorfullife.com> <20010601071414.A871@middle.of.nowhere> <3B17D0C1.5FC21CFB@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B17D0C1.5FC21CFB@colorfullife.com>; from manfred@colorfullife.com on Fri, Jun 01, 2001 at 07:28:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 07:28:33PM +0200, Manfred Spraul wrote:
> thunder7@xs4all.nl wrote:
> > 
> > :setpci -s 00:07.2 INTERRUPT_LINE=15
> > :lspci -vx -s 00:07.2
> > 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
> >         Subsystem: Unknown device 0925:1234
> >         Flags: bus master, medium devsel, latency 32, IRQ 19
> >         I/O ports at a000 [size=32]
> >         Capabilities: [80] Power Management version 2
> > 30: 00 00 00 00 80 00 00 00 00 00 00 00 15 04 00 
> > :setpci -s 00:07.2 INTERRUPT_LINE=19
> > :lspci -vx -s 00:07.2
> > 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
> >         Subsystem: Unknown device 0925:1234
> >         Flags: bus master, medium devsel, latency 32, IRQ 19
> >         I/O ports at a000 [size=32]
> >         Capabilities: [80] Power Management version 2
> > 30: 00 00 00 00 80 00 00 00 00 00 00 00 19 04 00 00
> > 
> > So that is correct. I'll attach all the information from the MPS 1.4
> > reboot, in which 00:07.2 happily points at 05, while everything else
> > thinks it's at 19.....
> >
> 
> Could you compile uhci as a module, set the configuration to MPS1.4 and
> find out with which interrupt line setting it works.
> I'd try both
> 
> setpci -s 00:07.2 INTERRUPT_LINE=13
no change, still this in /var/log/messages:

Jun  1 20:57:48 middle kernel: uhci.c: USB Universal Host Controller Interface driver
Jun  1 20:57:48 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Jun  1 20:57:51 middle kernel: usb_control/bulk_msg: timeout
Jun  1 20:57:51 middle kernel: usb.c: USB device not accepting new address=2 (error=-110)
Jun  1 20:57:51 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 3
Jun  1 20:57:54 middle kernel: usb_control/bulk_msg: timeout
Jun  1 20:57:54 middle kernel: usb.c: USB device not accepting new address=3 (error=-110)

> setpci -s 00:07.2 INTERRUPT_LINE=3
> [even if 13 works, please try 03 as well. 13 is hexadecimal==19]

Bingo!!

Jun  1 20:59:34 middle kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun  1 20:59:34 middle kernel: Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
Jun  1 20:59:34 middle kernel: sda : READ CAPACITY failed.
Jun  1 20:59:34 middle kernel: sda : status = 1, message = 00, host = 0, driver = 08 
Jun  1 20:59:34 middle kernel: sda : extended sense code = 2 
Jun  1 20:59:34 middle kernel: sda : block size assumed to be 512 bytes, disk size 1GB.  
Jun  1 20:59:34 middle kernel:  sda: I/O error: dev 08:00, sector 0
Jun  1 20:59:34 middle kernel:  unable to read partition table
Jun  1 20:59:34 middle kernel: WARNING: USB Mass Storage data integrity not assured
Jun  1 20:59:34 middle kernel: USB Mass Storage device found at 2

> 
> The via ac97 sound driver contains an irq fixup for this problem. Either
> a similar fixup is necessary in the uhci driver, or the fixup from the
> ac97 driver could be moved to the pci-quirks and applied to all devices
> in the southbridge.
> 
Just to be sure, the lspci -vvvxxx reading of 07.2 after this setpci -s
00:07.2 INTERRUPT_LINE=3 with MPS=1.4 in the bios:

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at a000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 04 00 00
40: 00 10 03 00 02 00 32 e0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

/proc/interrupts:

           CPU0       CPU1       
  0:      22004      24207    IO-APIC-edge  timer
  1:       2073       2617    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
 14:        240        241    IO-APIC-edge  ide0
 16:    5342007    5342450   IO-APIC-level  sym53c8xx
 17:         23         21   IO-APIC-level  sym53c8xx, sym53c8xx
 18:       6448       6349   IO-APIC-level  ide2, ide3, DE500-AA (eth0)
 19:         42         42   IO-APIC-level  usb-uhci, usb-uhci
NMI:          0          0 
LOC:      46131      46128 
ERR:          0
MIS:          0

Good luck,
Jurriaan
-- 
BOFH excuse #317:

Internet exceeded Luser level, please wait until a luser
logs off before attempting to log back on.
GNU/Linux 2.4.5-ac6 SMP/ReiserFS 2x1402 bogomips load av: 0.49 0.12 0.04
