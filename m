Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281853AbRKREUK>; Sat, 17 Nov 2001 23:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRKREUA>; Sat, 17 Nov 2001 23:20:00 -0500
Received: from N402P014.adsl.highway.telekom.at ([213.33.50.46]:11167 "HELO
	twinny.dyndns.org") by vger.kernel.org with SMTP id <S281853AbRKRETm>;
	Sat, 17 Nov 2001 23:19:42 -0500
Message-ID: <3BF735A6.E7E67ABD@webit.com>
Date: Sun, 18 Nov 2001 05:14:30 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB-OHCI + USB broken in 2.4.14/15pre2?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resume from suspend does not work correctly on my machine. Here's what
the log says:

----
Nov 18 04:33:52 oland cardmgr[188]: executing: './network suspend eth1'
Nov 18 04:33:52 oland kernel: usb-ohci.c: USB suspend: usb-00:01.2
Nov 18 04:33:52 oland kernel: NETDEV WATCHDOG: eth1: transmit timed out
Nov 18 04:33:52 oland kernel: eth1: Transmit timeout.
Nov 18 04:33:52 oland kernel: usb-ohci.c: Bus suspended
Nov 18 04:33:52 oland kernel: usb-ohci.c: USB suspend: usb-00:01.3
Nov 18 04:33:53 oland kernel: usb-ohci.c: Bus suspended
Nov 18 04:33:57 oland logger: Storing ALSA mixer settings...done.
Nov 18 04:33:58 oland logger: Shutting down ALSA sound driver (version
0.9.0beta9): done.
Nov 18 04:33:59 oland apmd[349]: User Suspend
Nov 18 04:34:09 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.2
Nov 18 04:34:09 oland kernel: usb-ohci.c: odd PCI resume for usb-00:01.3
Nov 18 04:34:09 oland kernel: APIC error on CPU0: 00(40)
Nov 18 04:34:10 oland cardmgr[188]: executing: './network resume eth1'
Nov 18 04:34:11 oland logger: ALSA driver (version 0.9.0beta9) is
already running.
Nov 18 04:34:13 oland kernel: PCI: Found IRQ 11 for device 00:01.4
Nov 18 04:34:13 oland kernel: PCI: Sharing IRQ 11 with 00:03.0
Nov 18 04:34:14 oland apmd[349]: Normal Resume after 00:00:15 (99%
unknown) AC power
----

(Don't care about eth1 errors. ALSA doesn't matter either, although I
never saw this behavior (driver already running after stopping them?!)
before I started using the USB drivers. However, don't bother....)

Anyway: Machine gets up, but - needless to say - my usb mouse (or any
other usb device) does not work after resume:

----
Nov 18 04:44:40 oland kernel: hub.c: USB new device connect on bus2/1,
assigned device number 2
Nov 18 04:44:43 oland kernel: usb_control/bulk_msg: timeout
Nov 18 04:44:43 oland kernel: usb-ohci.c: unlink URB timeout
Nov 18 04:44:43 oland kernel: usb.c: USB device not accepting new
address=2 (error=-110)
Nov 18 04:44:43 oland kernel: hub.c: USB new device connect on bus2/1,
assigned device number 3
Nov 18 04:44:46 oland kernel: usb_control/bulk_msg: timeout
Nov 18 04:44:46 oland kernel: usb-ohci.c: unlink URB timeout
Nov 18 04:44:46 oland kernel: usb.c: USB device not accepting new
address=3 (error=-110)
---- 

The APIC error (shown in the first log) does not appear if I compile the
kernel without APIC (duh!). Situation regarding the USB is the same in
either case.

Although the bus gets suspended (ohci_pci_suspend() works correctly, I
doublechecked this by simply replacing dbg() with info() in
ohci_pci_suspend(), thus the log entry at 04:33:53), it seems that the
control flags are for some reason (already) set to OHCI_USB_OPER (as the
only value capable of causing "odd PCI resume" messages) when the resume
procedure in usb_ohci.c is called.

I tried to "recover" this behavior by temporarily patching
ohci_pci_resume() so that it does a brutal hc_restart(ohci) instead of
nothing when detecting this "odd PCI resume" situation - without any
success.

Configuration (imho relevant parts):

Laptop (Celeron 1Ghz) with SiS630 chipset, including two SiS 7001 USB
controllers. USB controllers share IRQ (11) with cardbus and sound (and
unused winmodem).

# lspci -vv
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at dffd0000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at dffe0000 (32-bit, non-prefetchable) [size=4K]

I am running kernel 2.4.15pre2 but I did not see any relevant changes in
usb-ohci since then up to pre6.

Any further information will, of course, be supplied on request.

The Usual Questions(tm): Did I miss anything obvious? Is this a known
bug? Any ideas?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:         
mailto:tw@webit.com              *** http://www.webit.com/tw
