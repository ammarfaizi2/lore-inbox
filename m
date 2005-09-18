Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVIRAEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVIRAEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIRAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:04:12 -0400
Received: from ws6-3.us4.outblaze.com ([205.158.62.199]:25058 "HELO
	ws6-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751238AbVIRAEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:04:12 -0400
Message-ID: <432CAEF4.7070601@bakke.com>
Date: Sun, 18 Sep 2005 02:04:04 +0200
From: Dag Bakke <dag@bakke.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk@arm.linux.org.uk>
Subject: Quad serial CardBus appears as 8 ports, only one useable.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I have a 4-port CardBus device. The kernel (2.6.14-rc1) detects 8 ports:

[   75.126331] PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
[   75.126375] ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [LNKA] -> GSI 
11 (level, low) -> IRQ 11
[   75.128420] ttyS4: detected caps 00000700 should be 00000100
[   75.128441] ttyS4 at I/O 0x3060 (irq = 11) is a 16C950/954
[   75.131674] ttyS5: detected caps 00000700 should be 00000100
[   75.131695] ttyS5 at I/O 0x3068 (irq = 11) is a 16C950/954
[   75.135594] ttyS6: detected caps 00000700 should be 00000100
[   75.135617] ttyS6 at I/O 0x3070 (irq = 11) is a 16C950/954
[   75.145197] ttyS7: detected caps 00000700 should be 00000100
[   75.145220] ttyS7 at I/O 0x3078 (irq = 11) is a 16C950/954
[   75.218480] PCI: Enabling device 0000:06:00.1 (0000 -> 0003)
[   75.218530] ACPI: PCI Interrupt 0000:06:00.1[A] -> Link [LNKA] -> GSI 
11 (level, low) -> IRQ 11
[   75.224327] ttyS8 at I/O 0x3020 (irq = 11) is a 16450
[   75.233726] ttyS9 at I/O 0x3028 (irq = 11) is a 16450
[   75.243654] ttyS1 at I/O 0x3030 (irq = 11) is a 16450
[   75.257886] ttyS2 at I/O 0x3038 (irq = 11) is a 16450

I can't get any of the ports to work with vanilla code.


lspci -n
--------
0000:06:00.0 Class 0700: 1415:9504
0000:06:00.1 Class 0680: 1415:9511

lspci -vv
---------
0000:06:00.0 Serial controller: Oxford Semiconductor Ltd: Unknown device 
9504 (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3060
        Region 1: I/O ports at 3068 [size=8]
        Region 2: I/O ports at 3070 [size=8]
        Region 3: I/O ports at 3078 [size=8]
        Region 4: I/O ports at 3000 [size=32]
        Region 5: Memory at 46000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:06:00.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 
UART) function 1
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3020
        Region 1: Memory at 46001000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 3040 [size=32]
        Region 3: Memory at 46002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Adding the following code to 8250_pci.c:

+       {       PCI_VENDOR_ID_OXSEMI, 0x9504,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+               pbn_b0_bt_4_921600 },

allows me to use any of the 8 ports from minicom, but only if I 
physically connect the first port. I.e.:
I get data trough the first physical port, no matter what port I choose 
to use in minicom.

The card works as expected in an Alternative Operating System, using 
these drivers: http://www.oxsemi.co.uk/download/updates/up000001/v4_09.zip

Suggestions?



Dag B.
