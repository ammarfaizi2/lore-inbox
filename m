Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290480AbSAYBej>; Thu, 24 Jan 2002 20:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290486AbSAYBea>; Thu, 24 Jan 2002 20:34:30 -0500
Received: from host-47-84.dsl.innercite.com ([158.222.47.84]:45828 "EHLO
	darkstar.brie.com") by vger.kernel.org with ESMTP
	id <S290480AbSAYBeW>; Thu, 24 Jan 2002 20:34:22 -0500
From: Brian Lavender <brian@brie.com>
Date: Thu, 24 Jan 2002 17:34:21 -0800
To: linux-kernel@vger.kernel.org
Subject: VAIO IRQ assignment problem of USB controller
Message-ID: <20020124173421.B8732@brie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Sony VAIO PCG-GR170K laptop with a memory stick which operates
off of the USB controller with device ID 00:1d.2. The laptop has a total
of three USB controllers.  The first two are getting IRQ's, but the third
one is not. Under Win2k, it assigns all three USB controllers IRQ 9. I
checked the bios for USB options, and the only option I could find is to
set a "Non PNP" OS.  I found no other USB options. I am currently using
kernel 2.4.9 from Redhat compiled from the source RPM.  I am guessing
that this must be a problem somewhere in the PCI IRQ configuration.
Any other suggestions aside from downloading 2.4.17?

$ dmesg 
[snip]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 00:19:35 Dec 17 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:1d.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:1d.2.
usb-uhci.c: found UHCI device with no IRQ assigned. check BIOS settings!
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver

$ lspci -vv
[snip]
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 80e7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 0
        Region 4: I/O ports at 1840 [size=32]


Here's the code from UHCI that configures the device. It looks like if
it can't see an IRQ, it can't configure the device.

/usr/src/linux/drivers/usb/uhci.c

   2856 static int __devinit uhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
   2857 {
   2858         int i;
   2859 
   2860         if (!pci_dma_supported(dev, 0xFFFFFFFF)) {
   2861                 err("PCI subsystem doesn't support 32 bit addressing?");
   2862                 return -ENODEV;
   2863         }
   2864         dev->dma_mask = 0xFFFFFFFF;
   2865 
   2866         /* disable legacy emulation */
   2867         pci_write_config_word(dev, USBLEGSUP, 0);
   2868 
   2869         if (pci_enable_device(dev) < 0)
   2870                 return -ENODEV;
   2871 
   2872         if (!dev->irq) {
   2873                 err("found UHCI device with no IRQ assigned. check BIOS settings!");
   2874                 return -ENODEV;
   2875         }

-- 
Brian Lavender
http://www.brie.com/brian/

_______________________________________________
Linux-usb-users@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-users

-- 
Brian Lavender
http://www.brie.com/brian/
