Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTIQXl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbTIQXl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:41:26 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:49136
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262887AbTIQXlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:41:21 -0400
Message-ID: <3F68F11D.73E35377@eyal.emu.id.au>
Date: Thu, 18 Sep 2003 09:41:17 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: PCI (USB) problem on a laptop
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: it looks like a bad PCI setup, which I need to work around.
A USB device is not assigned an interrupt.


This is an Acer Aspire 1703SC, which comes preinstalled with WinXP
which works OK. I attached an external USB 2.0 3.5" IDE disk which
also works properly.

The first sign of a problem was that DriveImage, when booted into
(what looks like a) W2K mode could not access the external disk.
I next tried Ghost (part of Norton SystemWorks 2003, which boots
into DOS) and the USB 2.0 drivers ended up hanging or not seeing
the USB 2.0 controller.

OK, (now we get on-topic) I then booted Knoppix which uses kernel
2.4.22 (it needed "noapic" or it locks up). It saw problems with
the USB 2.0 controller:
 ===========================================
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 00:03:14 Sep  6 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
SiS router pirq escape (96)
SiS router pirq escape (96)
usb-ohci.c: USB OHCI at membase 0xdfbac000, IRQ 10
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] USB 1.0
Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
advanced SiS pirq mapping not yet implemented
usb-ohci.c: USB OHCI at membase 0xdfbae000, IRQ 10
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] USB 1.0
Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Assigned IRQ 10 for device 00:03.2
usb-ohci.c: USB OHCI at membase 0xdfbb0000, IRQ 10
usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] USB 1.0
Controller (#3)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usbdevfs: remount parameter error
hub.c: new USB device 00:03.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x45e/0x40) is not claimed by any active
driver.
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with
IntelliEye(TM)] on usb3:2.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
 ===========================================

You will notice that we only see three "USB 1.0 Controller"s. I then
loaded ehci_hdc manually and got these in dmesg:
 ===========================================
PCI: Enabling device 00:03.3 (0000 -> 0002)
SiS router pirq escape (99)
SiS router pirq escape (99)
PCI: No IRQ known for interrupt pin D of device 00:03.3. Please try
using pci=biosirq.
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 00:03.3 setup!
 ===========================================

I now look at the PCI system:
 ===========================================
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e4001000 (32-bit, non-prefetchable)
[size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at e4002000 (32-bit, non-prefetchable)
[size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at e4003000 (32-bit, non-prefetchable)
[size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
(prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0							<<<<<<<<<<
        Region 0: Memory at e4004000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 ===========================================

and it I boot with "pci=biosirq" (which still fails):
 ===========================================
00:03.0 - 00:03.2 unchanged
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
(prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0028
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0
        Region 0: Memory at e4004000 (32-bit, non-prefetchable)
[disabled] [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 ===========================================

Naturally, lsusb does not see this fourth device.

All help will be appreciated.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
