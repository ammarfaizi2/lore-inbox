Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCXTCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCXTCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVCXTCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:02:34 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:36440 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261313AbVCXTCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:02:07 -0500
Message-ID: <42430EAD.3050605@tls.msk.ru>
Date: Thu, 24 Mar 2005 22:02:05 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Interesting tidbit: NetMos 9835 card, IRQ, and ACPI
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found an interesting issue here.

HP ProLiant ML150 box (dual xeon 2.4GHz) with intel
chipset (lspci output below) and NetMos PCI 9835
Multi-I/O Controller.

Boot with no fancy options on kernel command line.

  # cat /sys/bus/pci/devices/0000:01:00.0/irq
  11
  # modprobe 8250
  # setserial /dev/ttyS2 irq 11 port 0xa400 autoconfig

the serial port does not work: close'int the file
after writing something stalls for a while, and nothing
gets written.  Ok.

  # rmmod 8250
  # modprobe parport_pc
  ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
  # cat /sys/bus/pci/devices/0000:01:00.0/irq
  193
  # rmmod parport_pc # as it will conflict with 8250 here
  # modprobe 8250
  # setserial /dev/ttyS2 irq 193 port 0xa400 autoconfig

now the serial port works.

In other words, one have to load and unload parport_pc to
trigger that IRQ change, after which serial driver works.

When booting with pci=noacpi, the irq here is always 169,
and everything works fine (modulo the parport_pc vs 8250
conflict which is a different story).

Without that parport_pc "ping" hack, the whole stuff looks
like a BIOS problem.  But parport_pc behaviour makes it..
more interesting... ;)

Kernel is 2.6.11.

BTW, we have another prob with this very Netmos card and this very
machine: sometimes, the whole machine hangs hard when using serial
driver, so only power button helps.  Happens with 2.4.* kernels
(it assigns IRQ18 to the card) and with earlier 2.6.x kernels.
Dunno if the two are related.

/mjt

# lspci
0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 01)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:01:00.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O Controller (rev 01)
0000:01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:04:01.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
0000:04:04.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:04:04.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)

# lspci -vv
0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [40] #09 [1105]

0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
         I/O behind bridge: 0000b000-0000dfff
         Memory behind bridge: fe600000-feafffff
         Prefetchable memory behind bridge: ff700000-ff9fffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
         Subsystem: Hewlett-Packard Company: Unknown device 2480
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 153
         Region 4: I/O ports at e800 [size=32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 00007000-0000afff
         Memory behind bridge: fc500000-fe5fffff
         Prefetchable memory behind bridge: ff600000-ff6fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Hewlett-Packard Company: Unknown device 2480
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at ffa0 [size=16]
         Region 5: Memory at 80000000 (32-bit, non-prefetchable) [disabled] [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
         Subsystem: Hewlett-Packard Company: Unknown device 2480
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 161
         Region 4: I/O ports at 0540 [size=32]

0000:01:00.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O Controller (rev 01) (prog-if 02 [16550])
         Subsystem: LSI Logic / Symbios Logic 2S (16C550 UART)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 169
         Region 0: I/O ports at a400 [size=8]
         Region 1: I/O ports at a000 [size=8]
         Region 2: I/O ports at 9800 [size=8]
         Region 3: I/O ports at 9400 [size=8]
         Region 4: I/O ports at 9000 [size=8]
         Region 5: I/O ports at 8800 [size=16]

0000:01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
         Subsystem: Hewlett-Packard Company: Unknown device 8008
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 169
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: I/O ports at a800 [size=256]
         Region 2: Memory at fe5ff000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at fe5c0000 [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
         Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [50] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=2 Dev=28 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x10 (64 bytes)
         Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
         I/O behind bridge: 0000b000-0000dfff
         Memory behind bridge: fe700000-fe9fffff
         Prefetchable memory behind bridge: 00000000ff800000-00000000ff800000
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] PCI-X bridge device.
                 Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=1
                 Status: Bus=2 Dev=29 Func=0 64bit+ 133MHz+ SCD- USC-, SCO-, SRD-
                 : Upstream: Capacity=65535, Commitment Limit=65535
                 : Downstream: Capacity=65535, Commitment Limit=65535

0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
         Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [50] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=2 Dev=30 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x10 (64 bytes)
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
         Memory behind bridge: fe600000-fe6fffff
         Prefetchable memory behind bridge: 00000000ff700000-00000000ff700000
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] PCI-X bridge device.
                 Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3
                 Status: Bus=2 Dev=31 Func=0 64bit+ 133MHz+ SCD- USC-, SCO-, SRD-
                 : Upstream: Capacity=65535, Commitment Limit=65535
                 : Downstream: Capacity=65535, Commitment Limit=65535

0000:04:01.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
         Subsystem: Hewlett-Packard Company: Unknown device 1001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 177
         Region 0: Memory at fe9a0000 (64-bit, non-prefetchable) [size=128K]
         Region 4: I/O ports at c400 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=4 Dev=1 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

0000:04:04.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
         Subsystem: Hewlett-Packard Company: Unknown device 103c
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 185
         Region 0: I/O ports at d000 [size=256]
         Region 1: Memory at fe9fc000 (64-bit, non-prefetchable) [disabled] [size=8K]
         Region 3: I/O ports at c800 [size=256]
         Expansion ROM at fe880000 [disabled] [size=512K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [94]
0000:04:04.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
         Subsystem: Hewlett-Packard Company: Unknown device 103c
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin B routed to IRQ 193
         Region 0: I/O ports at d800 [size=256]
         Region 1: Memory at fe9fe000 (64-bit, non-prefetchable) [disabled] [size=8K]
         Region 3: I/O ports at d400 [size=256]
         Expansion ROM at fe900000 [disabled] [size=512K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [94]
