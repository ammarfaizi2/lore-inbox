Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSEEVWo>; Sun, 5 May 2002 17:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSEEVWn>; Sun, 5 May 2002 17:22:43 -0400
Received: from harddata.com ([216.123.194.198]:41231 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S313660AbSEEVWl>;
	Sun, 5 May 2002 17:22:41 -0400
Date: Sun, 5 May 2002 15:22:32 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Interrupt posted but not delivered
Message-ID: <20020505152232.A11037@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have troubles which look like an IRQ delivery failures on
TYAN-S2466N-4M dual processor Athlon board.

More precisely this looks as follows. There is a 3Com 3c905C Tornado
NIC built-in on the board.  It works, no problems, as long as it is
alone. But we also have to add to that DLink DFE570 with four other
ethernet ports which are using 'tulip' (or 'de4x5') driver.  This
card, and video, are stuck into a raiser card.  I understand that
this spells trouble but the whole thing have to fit into a 2U unit.

The moment these extra ports show up 3c905C stops to work.  It is
visible, and I configure it using a static IP address, but nothing
gets through it and from /proc/interrupts it looks that it is not
getting a single interrupt.  I can get tulip ports to work; at least
with some raisers, and this may require an extra voodoo, but it
is doable.  So far no luck with tornado as long as as tulips are
present.  I tried few different kernels from 2.4 series (none from
2.4.19pre yet, though) and results are invariably the same.  Options
like 'noacpi' and/or 'pci=biosirq' do not improve anything.  There
seem to be some conflict with USB which is not needed here.  Booting
with 'nousb' seems to give somewhat saner results but still no dice.

'lspci -tv' with a "good" raiser provides the following picture and
I marked assigned IRQs (no conflicts on i/o ports as far as I can see).

-[00]-+-00.0  Advanced Micro Devices [AMD]: Unknown device 700c
      +-01.0-[01]--
      +-07.0  Advanced Micro Devices [AMD]: Unknown device 7440
      +-07.1  Advanced Micro Devices [AMD]: Unknown device 7441
      +-07.3  Advanced Micro Devices [AMD]: Unknown device 7443
      +-08.0-[02]--+-04.0  Digital Equipment Corporation DECchip 21142/43
								(IRQ 10)
      |            +-05.0  Digital Equipment Corporation DECchip 21142/43
								(IRQ 11)
      |            +-06.0  Digital Equipment Corporation DECchip 21142/43
								(IRQ 5)
      |            \-07.0  Digital Equipment Corporation DECchip 21142/43
								(IRQ 9)
      +-09.0  nVidia Corporation Vanta [NV6]    (IRQ 11)
      \-10.0-[03]--+-00.0  Advanced Micro Devices [AMD]: Unknown device 7449
								(IRQ 10)
                   \-08.0  3Com Corporation 3c905C-TX [Fast Etherlink] (IRQ 11)

"Uknown devices" are:
 700c - host bridge
 7440 - ISA bridge
 7441 - IDE interface
 7443 - bridge of some kind
 7449 - USB controller

Attempts to pass, rather long, 'pirq=...' line to kernel made tulips
to behave somewhat "better" but nothing for 3com.  Maybe I have not
done that properly with with four busses this seem to be 16 numbers.
BTW, Tyan FAQ gives that (AGP slot is not used):

AGP                     IntB/IntC
PCI Bus 1 slot 1 =      IntA
PCI bus 1 slot 2 =      IntB
PCI Bus 2 slot 1 =      IntA
PCI bus 2 slot 2 =      IntB
PCI bus 2 slot 3 =      IntC
PCI bus 2 slot 4 =      IntD
3COM LAN                IntD

MP specs are v1.4 and I do not see a way to switch them to v1.1;
at least not in BIOS.  Am I looking in wrong places?

Here are what looks like relavant fragments of 'dmesg' (these are
from 2.4.18 based kernel but they really do not differ elsewhere).

127MB HIGHMEM available.
found SMP MP-table at 000f71e0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
.........
Total of 2 processors activated (6121.06 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  0    0    0   0   0    1    1    A9
 11 003 03  0    0    0   0   0    1    1    B1
 12 003 03  0    0    0   0   0    1    1    B9
 13 003 03  0    0    0   0   0    1    1    C1
 14 003 03  0    0    0   0   0    1    1    C9
 15 003 03  1    1    0   1   0    1    1    D1
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
.................................... done.
..............
PCI: Using IRQ router default [1022/7443] at 00:07.3
BIOS failed to enable PCI standards compliance, fixing this error.
..........
Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 786d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xf8947000, 00:80:C8:CF:E0:DD, IRQ 10.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 1000 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xf8949400, 00:80:C8:CF:E0:DE, IRQ 11.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 1000 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xf894b800, 00:80:C8:CF:E0:DF, IRQ 5.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 1000 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0xf894dc00, 00:80:C8:CF:E0:E0, IRQ 9.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
03:08.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
03:08.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16

and later after attempts to sent something through Tornado:

NETDEV WATCHDOG: eth4: transmit timed out
eth4: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0ccc media 8880 dma 0000003a.
eth4: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 16(0) current 16(0)
  Transmit list 00000000 vs. f610c200.
  0: @f610c200  length 8000002a status 0001002a
  1: @f610c240  length 8000002a status 0001002a
  2: @f610c280  length 8000002a status 0001002a
  3: @f610c2c0  length 8000002a status 0001002a
  4: @f610c300  length 8000002a status 0001002a
  5: @f610c340  length 8000002a status 0001002a
  6: @f610c380  length 8000002a status 0001002a
  7: @f610c3c0  length 8000002a status 0001002a
  8: @f610c400  length 8000002a status 0001002a
  9: @f610c440  length 8000002a status 0001002a
  10: @f610c480  length 8000002a status 0001002a
  11: @f610c4c0  length 8000002a status 0001002a
  12: @f610c500  length 8000002a status 0001002a
  13: @f610c540  length 8000002a status 0001002a
  14: @f610c580  length 8000002a status 8001002a
  15: @f610c5c0  length 8000002a status 8001002a
eth4: Resetting the Tx ring pointer.

Any bright ideas what could/should be done here?

  TIA,
  Michal
