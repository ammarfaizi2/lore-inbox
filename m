Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA2RTu>; Mon, 29 Jan 2001 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA2RTk>; Mon, 29 Jan 2001 12:19:40 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:16403 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S129051AbRA2RTa>; Mon, 29 Jan 2001 12:19:30 -0500
To: torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.10.10101282323570.5605-100000@penguin.transmeta.com>
In-Reply-To: <20010129081132I.siemer@panorama.hadiko.de>
	<Pine.LNX.4.10.10101282323570.5605-100000@penguin.transmeta.com>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010129181917N.siemer@panorama.hadiko.de>
Date: Mon, 29 Jan 2001 18:19:17 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@transmeta.com>
> On Mon, 29 Jan 2001, Robert Siemer wrote:
> > 
> > Further I always see '09' in the Configuration Space at Interrupt_Line
> > (0x3c) for the 00:01.2 USB Controller. But 2.4.0 says:
> >   Interrupt: pin A routed to IRQ 12
> > while 2.4.0-test9 states:
> >   Interrupt: pin A routed to IRQ 9
> 
> Ahhah!
> 
> I bet it's the code that goes through all PCI devices, and tries to find
> devices that have the same "pirq" (aka "link") value in the tables.
> 
> How about this patch? I bet that you'll get a message about pirq table
> conflicts. Does USB end up working afterwards?

The patch is good! (:  Currently I'm using 2.4.0 with both the
patch and the alternate pirq-sis-functions.

Here some lines from the kernel after loading usb-ohci:

 usb.c: registered new driver hub
 IRQ for 00:01.2:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=9 -> got IRQ 12
 PCI: Found IRQ 12 for device 00:01.2
 PCI: The same IRQ used for device 00:01.1
 IRQ routing conflict in pirq table for device 00:01.2
 PCI: The same IRQ used for device 00:0c.0
 usb-ohci.c: USB OHCI at membase 0xc8901000, IRQ 9


I send two diffs: the first of "dmesg" from a nonworking 2.4.0 to my
current (working) kernel, the second of "lspci -vvvxxx" from a working
2.4.0-test9 to the working 2.4.0 I use now.


Many thanks, Linus!
			Robert

----
--- dmesg.2.4.0.alternate_sis_func	Mon Jan 29 06:25:53 2001
+++ dmesg.2.4.0.alternate+traversepatch	Mon Jan 29 17:16:57 2001
@@ -1,4 +1,4 @@
-Linux version 2.4.0 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 Mon Jan 29 06:19:16 CET 2001
+Linux version 2.4.0 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #7 Mon Jan 29 15:44:39 CET 2001
 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
@@ -231,9 +231,10 @@
 bttv: using 2 buffers with 2080k (4160k total) for capture
 BT848 and your chipset may not work together.
 bttv: Bt8xx card found (0).
-IRQ for 00:09.0:0 -> PIRQ 04, mask 1eb8, excl 0000 -> newirq=11 -> got IRQ 11
-PCI: Found IRQ 11 for device 00:09.0
-PCI: The same IRQ used for device 00:09.1
+IRQ for 00:09.0:0 -> PIRQ 04, mask 1eb8, excl 0000 -> newirq=11 -> got IRQ 10
+PCI: Found IRQ 10 for device 00:09.0
+IRQ routing conflict in pirq table for device 00:09.0
+IRQ routing conflict in pirq table for device 00:09.1
 bttv0: Bt878 (rev 2) at 00:09.0, irq: 11, latency: 32, memory: 0xe7800000
 bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
 bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
@@ -279,9 +280,9 @@
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SIS5513: IDE controller on PCI bus 00 dev 09
 PCI: Enabling device 00:01.1 (0000 -> 0001)
-IRQ for 00:01.1:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=12 -> got IRQ 12
-PCI: Found IRQ 12 for device 00:01.1
-PCI: The same IRQ used for device 00:01.2
+IRQ for 00:01.1:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=12 -> assigning IRQ 12 ... OK
+PCI: Assigned IRQ 12 for device 00:01.1
+IRQ routing conflict in pirq table for device 00:01.2
 PCI: The same IRQ used for device 00:0c.0
 SIS5513: chipset revision 208
 SIS5513: not 100% native mode: will probe irqs later



--- lspci-vvvxxx.2.4.0-test9	Mon Jan 29 07:43:27 2001
+++ lspci-vvvxxx.2.4.0.alternate+traversepatch	Mon Jan 29 17:19:18 2001
@@ -27,8 +27,8 @@
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-40: fa 0c 0e 0a 0b 64 00 00 ff ff 10 0f 11 20 04 01
-50: 11 28 02 01 60 0b 64 0b 9c 2e 12 00 a6 0b 00 00
+40: 0c 0c 0e 0a 0b 64 00 00 ff ff 10 0f 11 20 04 01
+50: 11 28 02 01 62 0b 64 0b 9c 2e 12 00 36 06 00 00
 60: ff 80 49 00 88 00 00 02 00 80 80 00 20 19 00 00
 70: 1a 00 00 c1 00 c1 00 00 00 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -40,7 +40,7 @@
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8f [Master SecP SecO PriP PriO])
+00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 12
@@ -49,7 +49,7 @@
 	Region 2: I/O ports at <ignored>
 	Region 3: I/O ports at <ignored>
 	Region 4: I/O ports at d000 [size=16]
-00: 39 10 13 55 01 00 00 00 d0 8f 01 01 00 20 80 00
+00: 39 10 13 55 01 00 00 00 d0 8a 01 01 00 20 80 00
 10: 01 e4 00 00 01 e0 00 00 01 d8 00 00 01 d4 00 00
 20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00
@@ -200,14 +200,14 @@
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-80: da 00 00 9d 47 0f 09 07 04 00 89 00 80 00 0f 0a
-90: ff 60 2a 01 00 ff ff ff 20 f0 35 30 98 03 00 e1
+80: da 00 00 35 47 08 00 07 04 00 80 00 80 00 0f 02
+90: ff c0 2c 01 00 ff ff ff 20 f0 35 30 98 03 00 e1
 a0: 00 08 24 00 00 00 00 50 b8 03 00 e1 c0 03 00 e1
-b0: 00 00 00 e1 b0 76 2a 01 46 6d 00 81 c0 03 00 e1
-c0: 8f 05 00 00 75 00 70 0f 0c 00 80 00 76 0c 00 80
-d0: 00 00 00 80 00 00 00 80 00 00 00 80 00 84 00 20
-e0: 43 d1 e6 21 d0 18 28 00 f8 41 22 81 aa ff cf 53
-f0: 12 0f 80 20 6f bf 02 81 8e 84 22 a8 d5 f3 45 73
+b0: 00 00 00 e1 d0 d5 2c 01 46 6d 00 81 c0 03 00 e1
+c0: 8f 05 00 00 93 00 70 0f 0c 00 80 00 76 0c 00 80
+d0: 00 00 00 80 00 00 00 80 00 00 00 80 00 84 00 08
+e0: ff c0 2c 01 ff c0 2c 01 d8 d5 2c 01 d8 d5 2c 01
+f0: 12 0f 80 20 12 0f 80 20 c4 00 00 a0 d5 f3 45 73
 
 00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 65) (prog-if 00 [VGA])
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
