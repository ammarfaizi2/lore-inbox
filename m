Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRCXVqR>; Sat, 24 Mar 2001 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRCXVqI>; Sat, 24 Mar 2001 16:46:08 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:17166 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131820AbRCXVp5>; Sat, 24 Mar 2001 16:45:57 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200103242145.WAA24380@green.mif.pg.gda.pl>
Subject: [BUG] problem with pci=biosirq
To: linux-kernel@vger.kernel.org (kernel list)
Date: Sat, 24 Mar 2001 22:45:50 +0100 (CET)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   While attempting to use pci=biosirq kernel parameter in 2.4.3pre6 (same
observed with ac20) I've got the following oops (manually rewritten) during
3c59x network adapter (compiled into kernel) initialization:

Unable to handle kernel paging request at virtual address 0000dde5
 printing eip:
c00fde03
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c00fde03>]
EFLAGS: 00010292
eax: 00000009   ebx: 0000dde5   ecx: 00000c0a   edx: c1170cc9
esi: c02964f0   edi: 00000000   ebp: 00000000   esp: c1177e92
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1177000)
Stack: 00000cc9 64f00000 0000c029 7eb40000 0030c117 def80000 0c0ac117 0cc90000
       deba0000 0000c00f 64f00000 0000c029 7ed80000 0030c117 0c010000 0c0ac117
       b10c0000 dd410000 b10fc00f 0c0a0c00 c00fdba2 eecc0206 0010c010 000c0000
Call Trace: [<def80000>] [<deba0000>] [<dd410000>] [<eecc0206>] [<f32f0000>] [<f523c117>] [<def8c029>]

          [and long, probably infinite trace here...]

Unfortunately ksymoops tracing gives no effect as the problem seems to
appear in a BIOS call. Some printk() debugging shows trace:

vortex_init()
  ...
    vortex_init_one()            [ drivers/net/3c59x.c ]
      pci_enable_device()        [ drivers/pci/pci.c ]
        pcibios_enable_device()  [ arch/i386/kernel/pci-pc.c ]
          pcibios_enable_irq()   [ arch/i386/kernel/pci-irq.c ]
            pcibios_lookup_irq() [ arch/i386/kernel/pci-irq.c ]
              [ pci-irq.c:555:   r->set(pirq_router_dev, dev, pirq, newirq) ]
              pirq_bios_set()    [ arch/i386/kernel/pci-irq.c ]
                pcibios_set_irq_routing(..., 0, 12)
                                 [ arch/i386/kernel/pci-pc.c ]

What is the reason of this situation:
1. pci=biosirq option is generally broken,
2. my BIOS is not compatible with pci=biosirq kernel parameter,
3. pcibios_set_irq_routing() call with pin=0 is incorrect,
4. ... another problem ?


My PCI bus works at 30MHz and its configuration:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b3)
	Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1531
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0 set

00:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 1100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ed000000 (32-bit, prefetchable)
	Region 1: Memory at efffc000 (32-bit, non-prefetchable)
	Region 2: Memory at ef000000 (32-bit, non-prefetchable)
	Expansion ROM at effe0000 [disabled]

00:06.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 8 max, 64 set
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at ee80
	Expansion ROM at effd0000 [disabled]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 2 min, 4 max, 32 set
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at ffa0

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at efffb000 (32-bit, non-prefetchable)


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
