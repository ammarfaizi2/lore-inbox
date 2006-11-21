Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031253AbWKUSIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031253AbWKUSIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031255AbWKUSIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:08:35 -0500
Received: from mx27.mail.ru ([194.67.23.64]:16210 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1031253AbWKUSIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:08:34 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.19-rc5: possible regression - OHCI dead after several STD/resume cycles
Date: Tue, 21 Nov 2006 21:08:24 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212108.28154.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using 2.6.9-rc5 + Alan Stern fix for "can't disable OHCI wakeup via sysfs". I 
started noticing strange messages after resume:

ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI interrupt for device 0000:00:06.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
pccard: card ejected from slot 0
Stopping tasks... 
===========================================================================================done.
Shrinking memory... done (27344 pages freed)
Suspending console(s)
 usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 1
hub 1-0:1.0: PM: suspend 1->1, parent usb1 already 1
 usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 1
usb usb1: PM: suspend 1->1, parent 0000:00:02.0 already 2
ACPI: PCI interrupt for device 0000:00:11.1 disabled
ACPI: PCI interrupt for device 0000:00:11.0 disabled
ACPI: PCI interrupt for device 0000:00:10.0 disabled
swsusp: Need to copy 58705 pages
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
PCI: Setting latency timer of device 0000:00:01.0 to 64
PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 
c2900007, writing c2900003)
PM: Writing back config space on device 0000:00:0a.0 at offset 1 (was 2900007, 
writing 2900003)
PM: Writing back config space on device 0000:00:10.0 at offset f (was 34001ff, 
writing 5c001ff)
PM: Writing back config space on device 0000:00:10.0 at offset 3 (was 24008, 
writing 2a808)
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
PM: Writing back config space on device 0000:00:11.0 at offset f (was 10001ff, 
writing 58001ff)
PM: Writing back config space on device 0000:00:11.0 at offset 3 (was 824000, 
writing 82a800)
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:11.1 at offset f (was 10002ff, 
writing 58002ff)
PM: Writing back config space on device 0000:00:11.1 at offset 3 (was 824000, 
writing 82a800)
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
pnp: Failed to activate device 00:05.
pnp: Failed to activate device 00:06.
 usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
 usbdev1.1_ep81: PM: resume from 0, parent 1-0:1.0 still 1
Restarting tasks... done.

those strange are usbdev1.1_ep00/81.

Now I needed to read from USB stick - it was not detected. Actually even HUB 
itself has not been shown in lsusb output. Reloading ohci did fix it.

This never happend to me in all previous versions (since 2.6.15 I guess). Also 
it did not start immediately after Alan's patch so I do not believe it is 
related.

Please tell me what can I sensibly test and which input info should I collect. 
Thank you. Configuration, dmesg etc available on request. lspci:

{pts/2}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin 
IV/V/V+]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)


- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFY0CcR6LMutpd94wRAgkQAJ47iMkbfXcS+W3DLuYbQcVNBQwnhwCfZbNc
SO8/36kh+XNDWh5miWt5oLo=
=6Nk7
-----END PGP SIGNATURE-----
