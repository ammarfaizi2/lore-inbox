Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRF2WKe>; Fri, 29 Jun 2001 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbRF2WKZ>; Fri, 29 Jun 2001 18:10:25 -0400
Received: from pille.addcom.de ([62.96.128.34]:6662 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S262702AbRF2WKQ>;
	Fri, 29 Jun 2001 18:10:16 -0400
Date: Sat, 30 Jun 2001 00:09:26 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [BUG] Re: Linux 2.4.5-ac22
In-Reply-To: <20010629212224.A3588@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0106292352440.1578-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Alan Cox wrote:

> 2.4.5-ac20
> o	Commence resync with 2.4.6pre5

I updated my laptop to 2.4.5-ac21 today. After reboot, I found a strange 
problem: My network card wouldn't initialize properly (eepro100).

Jun 29 21:26:31 vaio kernel: eepro100.c: $Revision: 1.36 $ 
2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> 
and others
Jun 29 21:26:31 vaio kernel: PCI: Found IRQ 9 for device 00:0b.0
Jun 29 21:26:31 vaio kernel: eth0: Invalid EEPROM checksum 
0xff00, check settings before activating this device!
Jun 29 21:26:31 vaio kernel: eth0: OEM i82557/i82558 10/100 
Ethernet, FF:FF:FF:FF:FF:FF, IRQ 9.
Jun 29 21:26:31 vaio kernel:   Board assembly ffffff-255, 
Physical connectors present: RJ45 BNC AUI MII
Jun 29 21:26:31 vaio kernel:   Primary interface chip unknown-15 
PHY #31.
Jun 29 21:26:31 vaio kernel:     Secondary interface chip i82555.
Jun 29 21:26:31 vaio kernel: Self test failed, status ffffffff:
Jun 29 21:26:31 vaio kernel:  Failure to initialize the i82557.
Jun 29 21:26:31 vaio kernel:  Verify that the card is a 
bus-master capable slot.Jun 29 21:26:31 vaio kernel: eth0: 0 
multicast blocks dropped.
Jun 29 21:26:31 vaio kernel: eth0: 0 multicast blocks dropped.

rmmod'ing and insmod'ing eepro100 again fixed the problem:

Jun 29 21:27:16 vaio kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jun 29 21:27:16 vaio kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jun 29 21:27:16 vaio kernel: PCI: Found IRQ 9 for device 00:0b.0
Jun 29 21:27:16 vaio kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 
08:00:46:08:0E:5D, IRQ 9.
Jun 29 21:27:16 vaio kernel:   Receiver lock-up bug exists -- enabling 
work-around.
Jun 29 21:27:16 vaio kernel:   Board assembly 100001-001, Physical 
connectors present: RJ45
Jun 29 21:27:16 vaio kernel:   Primary interface chip i82555 PHY #1.
Jun 29 21:27:16 vaio kernel:   General self-test: passed.
Jun 29 21:27:16 vaio kernel:   Serial sub-system self-test: passed.
Jun 29 21:27:16 vaio kernel:   Internal registers self-test: passed.
Jun 29 21:27:16 vaio kernel:   ROM checksum self-test: passed 
(0x04f4518b).
Jun 29 21:27:16 vaio kernel:   Receiver lock-up workaround activated.

Things weren't always exactly reproducible, but I found the following:
- The problem doesn't seem to happen with -ac19, it starts with -ac20
- After cold reboot it doesn't seem to happen
- I took eepro100.c from -ac19 and put into -ac20: Still the same problem,
  but everything would stay at 0xFF even after reloading
- I backed out the pci changes from -ac19 to -ac20 - no change of behavior
  (hope I didn't screw up anything during this test)
- I tried 2.4.6-pre5, same behavior as -ac20+

I have CONFIG_ACPI off, CONFIG_PM on, CONFIG_EEPRO100_PM on (when it still 
existed)

lspci -vvxxx diff before/after loading the module the first (non-working) 
time:

 00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
 	Subsystem: Sony Corporation: Unknown device 8084
-	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 9
 	Region 0: Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
 	Region 1: I/O ports at fcc0 [size=64]
@@ -231,7 +232,7 @@
 	Capabilities: [dc] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D2 PME-Enable- DSel=0 DScale=2 PME-
-00: 86 80 29 12 13 00 90 02 08 00 00 02 08 42 00 00
+00: 86 80 29 12 17 00 90 02 08 00 00 02 08 42 00 00
 10: 00 f0 cf fe c1 fc 00 00 00 00 d0 fe 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 84 80

Looks like expected, and doesn't explain the problem, at least not to me.

--Kai


