Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279920AbRKFSiH>; Tue, 6 Nov 2001 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279939AbRKFSh7>; Tue, 6 Nov 2001 13:37:59 -0500
Received: from smith.esat.kuleuven.ac.be ([134.58.63.168]:45062 "EHLO
	smith.esat.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S279893AbRKFShg>; Tue, 6 Nov 2001 13:37:36 -0500
From: vdb128@smith.esat.kuleuven.ac.be
Message-Id: <200111061837.fA6IbT502879@smith.esat.kuleuven.ac.be>
Subject: [rfc] de4x5 DC21040 initializing
To: linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 19:37:28 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

linux 2.4.2 2.4.3 2.4.13  de4x5.c

I am trying to get a patch for the de4x5.c driver accepted.  The
patch only changes the initializing behaviour, especially for DC21040 
chipsets (description below).  If someone has an EISA system with a
DC21040 ethernet board, please try this patch and mail the report
to vdb128 @ esat kuleuven ac be.  

Thank you.

The problem
-----------
The znyx315 DC21040 dual nic is initialized in the wrong way on my Intel 
Pentium 166.  The sequence is:

  bus 1 dev 5   this is the 2nd chip that does not have an PROM,
                so the ethernet adress is set to 00: .. :00
  bus 1 dev 4   this is the 1st chip with PROM.


The solution
------------

manual probing
   The arguments  io=0x"bus:dev_num" io1=  io2=  io3=  were added to
   specify the probing sequence.

auto probing

1) removed count_adapters()
  de4x5_probe() returns a new status code.  This value is checked on the 
  return of register_netdev() in init_module().

2) pci_probe(): The srom_search() is only called in pci_probe() if 
  bus.chipset or bus.bus_num differ for the device initializing.  
  The search is only forced if bus.bus!=PCI.  Thus, multiple searches
  for the same srom are avoided.

3) srom_search(): do search for a PROM if the DevicePresent() SROM
  search failed and if it is a DC21040 chipset.  The search logic is 

    search all pci_dev's on the bus except the one initializing.

    if last.chipset or last.bus differ:
      if no srom && lp->chipset==DC21040 then 
        get the h/w ether from the chip itself srom_search_dc21040_pci().

      update last.addr
  
    if SROM found or got h/w ether from PROM then return

  The reasoning is that the nics that I know of either have no srom, one srom,
  or one for every port.  In the multi srom case, the srom data is overwritten
  by DevicePresent() in pci_probe() and srom_search() is superfluous.  

  In the one srom case, the same srom will be found every time so using a 
  valid backup is ok.  If, due to e.g. invalidation of the bus.xxx backup, 
  the procedure is called for the same srom, and last.chipset and last.bus
  are untouched, then it is better not to update last.addr since this would 
  result in ethernet adresses base, base+1, base+1, base+1.

  My two port znyx315 now initializes ok irrespective of the scan order 
  since the no prom port is always base+1.  It even autoprobes due 
  to the one srom emulation through srom_search_dc21040_pci().

EISA probing
   eisa_probe() is only called if no pci devs are found; if num_de4x5s==0.

   ioaddr = 1..0x0fff is interpreted as a pci bus:dev_num pair.  
   ioaddr = 0x1000..0xffff is taken as an eisa base adress (slot=ioaddr>>12).

   modprobe de4x5 io=0x0104 io1=0x1000 io2=0x0105  --> eisa_probe() not called 
   modprobe de4x5 io=0x1000 io1=0x0104 io2=0x0105  --> eisa_probe() called
   modprobe de4x5 io=0x0104 args='eth2:force_eisa' io1=0x1000 io2=0x0105

Examples
--------

system info

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 3).
      Master Capable.  Latency=32.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (rev 0).
      Master Capable.  Latency=32.  
      I/O at 0xefa0 [0xefaf].
  Bus  0, device   8, function  0:
    VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
      Master Capable.  Latency=40.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device  13, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 1).
      Master Capable.  Latency=40.  Min Gnt=3.
  Bus  0, device  15, function  0:
    SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (#2) (rev 8).
      IRQ 10.
      Master Capable.  Latency=40.  Min Gnt=8.Max Lat=8.
      I/O at 0xeff4 [0xeff7].
      Non-prefetchable 32 bit memory at 0xffbef000 [0xffbeffff].
  Bus  0, device  14, function  0:
    SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 8).
      IRQ 10.
      Master Capable.  Latency=40.  Min Gnt=8.Max Lat=8.
      I/O at 0xeff0 [0xeff3].
      Non-prefetchable 32 bit memory at 0xffbee000 [0xffbeefff].
  Bus  1, device   5, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (#2) (rev 35).
      IRQ 10.
      Master Capable.  Latency=96.  
      I/O at 0xfc80 [0xfcff].
      Non-prefetchable 32 bit memory at 0xff9ffc00 [0xff9ffc7f].
  Bus  1, device   4, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 35).
      IRQ 10.
      Master Capable.  Latency=96.  
      I/O at 0xfc00 [0xfc7f].
      Non-prefetchable 32 bit memory at 0xff9ff800 [0xff9ff87f].


modprobe de4x5 io=0x0105 io1=0x0104    wrong order, like autoprobe

eth2: searching PCI bus:dev=0x0105. 
eth2: probing PCI bus=1 dev=5. 
srom_search: PCI bus=1 dev=4. 
DC21040 getting h/w ether from I/O at 0xfc48.  (00:c0:95:f4:02:ae) 
Copying srom ether at 0xfc00, bus=1 dev=4, to last adress. 
eth2: DE434/5 at 0xfc80 (PCI bus 1, device 5), h/w address+ 00:c0:95:f4:02:af,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
eth3: searching PCI bus:dev=0x0104. 
eth3: probing PCI bus=1 dev=4. 
eth3: DE434/5 at 0xfc00 (PCI bus 1, device 4), h/w address= 00:c0:95:f4:02:ae,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
init_module: adapters searched=2 xstat=0

The eth2 initialization calls srom_search() which finds the 0x0104 PROM and
updates last.addr.  Then, test_bad_enet() adds one for the ether hw address.
The eth3 init does not call srom_search() since the backup bus.xxx is valid.


modprobe de4x5 io=0x0104 io1=0x0105    correct order, 0x0104 has hw ether PROM

eth2: searching PCI bus:dev=0x0104. 
eth2: probing PCI bus=1 dev=4. 
srom_search: PCI bus=1 dev=5. 
DC21040 getting h/w ether from I/O at 0xfcc8.  () 
eth2: DE434/5 at 0xfc00 (PCI bus 1, device 4), h/w address= 00:c0:95:f4:02:ae,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
eth3: searching PCI bus:dev=0x0105. 
eth3: probing PCI bus=1 dev=5. 
eth3: DE434/5 at 0xfc80 (PCI bus 1, device 5), h/w address+ 00:c0:95:f4:02:af,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
init_module: adapters searched=2 xstat=0

The eth2 init only searches 0x0105 and finds no PROM.  The srom_search() 
routine is not called for eth3 since the backup bus.xxx was 
valid.  Here, it were the routines de4x5_hw_init() get_hw_addr() 
test_bad_enet() called for eth2 which determined last.addr.


modprobe de4x5 io=0x0104 args='eth2:force_eisa' io1=0x1000 io2=0x0105 

eth2: searching PCI bus:dev=0x0104. 
eth2: probing PCI bus=1 dev=4. 
srom_search: PCI bus=1 dev=5. 
DC21040 getting h/w ether from I/O at 0xfcc8.  () 
eth2: DE434/5 at 0xfc00 (PCI bus 1, device 4), h/w address= 00:c0:95:f4:02:ae,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
eth3: searching EISA iobase=0x1000. 
eth3: searching PCI bus:dev=0x0105. 
eth3: probing PCI bus=1 dev=5. 
srom_search: PCI bus=1 dev=4. 
eth3: DE434/5 at 0xfc80 (PCI bus 1, device 5), h/w address+ 00:c0:95:f4:02:af,
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
init_module: adapters searched=3 xstat=0

First PCI, turn on force_eisa, EISA, PCI.  Note that srom_search is called
two times since eisa_probe() sets bus.bus=EISA and invalidates the backup.
The global variable last.addr was not modified, the EISA initialization 
failed, and was not reset by the srom_search() call for eth3.



Example with znyx346 board #242380 in a Pentium 120  linux-2.2.18
-----------------------------------------------------------------

The board has 4 sroms.  The srom_search() is only called once, on 0x0104, 
while initializing eth0 at 0x0107.

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82437 (rev 2).
      Medium devsel.  Master Capable.  Latency=64.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371FB PIIX ISA (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
  Bus  0, device  13, function  0:
    VGA compatible controller: S3 Inc. ViRGE (rev 6).
      Medium devsel.  IRQ 11.  Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xf8000000].
  Bus  0, device  16, function  0:
    PCI bridge: DEC DC21152 (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=66.  Min Gnt=3.
  Bus  1, device   7, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=66.  Min Gnt=20.Max Lat=40.
      I/O at 0xfc80 [0xfc81].
      Non-prefetchable 32 bit memory at 0xff9fff80 [0xff9fff80].
  Bus  1, device   6, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Latency=66.  Min Gnt=20.Max Lat=40.
      I/O at 0xfc00 [0xfc01].
      Non-prefetchable 32 bit memory at 0xff9fff00 [0xff9fff00].
  Bus  1, device   5, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=66.  Min Gnt=20.Max Lat=40.
      I/O at 0xf880 [0xf881].
      Non-prefetchable 32 bit memory at 0xff9ffe80 [0xff9ffe80].
  Bus  1, device   4, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=66.  Min Gnt=20.Max Lat=40.
      I/O at 0xf800 [0xf801].
      Non-prefetchable 32 bit memory at 0xff9ffe00 [0xff9ffe00].

eth0: probing PCI bus=1 dev=7. 
srom_search: PCI bus=1 dev=4. 
Sub-system Vendor ID: c000
Sub-system ID:        e095
ID Block CRC:         74
SROM version:         01
# controllers:         04
Hardware Address:     00:c0:95:e0:37:64
CRC checksum:         df25
  0 c000
  2 e095
  4 6437
  6 0000
  8 0000
 10 0000
 12 0000
 14 0000
 16 0074
 18 0401
 20 c000
 22 e095
 24 6437
 26 2704
 28 0500
 30 0027
 32 2706
 34 0700
 36 0027
 38 0000
 40 0308
 42 0002
 44 1700
 46 0300
 48 8700
 50 0040
 52 0000
 54 0000
 56 0000
 58 0000
 60 0000
 62 0000
 64 0000
 66 0000
 68 0000
 70 0000
 72 0000
 74 0000
 76 0000
 78 0000
 80 0000
 82 0000
 84 0000
 86 0000
 88 0000
 90 0000
 92 0000
 94 0000
 96 0000
 98 0000
100 0000
102 0000
104 0000
106 0000
108 0000
110 0000
112 0000
114 524a
116 0001
118 0e01
120 0001
122 5159
124 0072
126 df25
Copying srom ether at 0xf800, bus=1 dev=4, to last adress. 
Sub-system Vendor ID: c000
Sub-system ID:        e095
ID Block CRC:         c9
SROM version:         01
# controllers:         01
Hardware Address:     00:c0:95:e0:37:67
CRC checksum:         fca9
  0 c000
  2 e095
  4 6737
  6 0000
  8 0000
 10 0000
 12 0000
 14 0000
 16 00c9
 18 0101
 20 c000
 22 e095
 24 6737
 26 1e00
 28 0000
 30 0800
 32 0203
 34 0000
 36 0017
 38 0003
 40 4087
 42 0000
 44 0000
 46 0000
 48 0000
 50 0000
 52 0000
 54 0000
 56 0000
 58 0000
 60 0000
 62 0000
 64 0000
 66 0000
 68 0000
 70 0000
 72 0000
 74 0000
 76 0000
 78 0000
 80 0000
 82 0000
 84 0000
 86 0000
 88 0000
 90 0000
 92 0000
 94 0000
 96 0000
 98 0000
100 0000
102 0000
104 0000
106 0000
108 0000
110 0000
112 0000
114 524a
116 0001
118 0e01
120 0001
122 5159
124 0072
126 fca9
eth0: DC21140 at 0xfc80 (PCI bus 1, device 7), h/w address= 00:c0:95:e0:37:67,
eth0: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  85e8
MII 18:  10


MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10
      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
eth1: probing PCI bus=1 dev=6. 
Sub-system Vendor ID: c000
Sub-system ID:        e095
ID Block CRC:         5d
SROM version:         01
# controllers:         01
Hardware Address:     00:c0:95:e0:37:66
CRC checksum:         e665
  0 c000
  2 e095
  4 6637
  6 0000
  8 0000
 10 0000
 12 0000
 14 0000
 16 005d
 18 0101
 20 c000
 22 e095
 24 6637
 26 1e00
 28 0000
 30 0800
 32 0203
 34 0000
 36 0017
 38 0003
 40 4087
 42 0000
 44 0000
 46 0000
 48 0000
 50 0000
 52 0000
 54 0000
 56 0000
 58 0000
 60 0000
 62 0000
 64 0000
 66 0000
 68 0000
 70 0000
 72 0000
 74 0000
 76 0000
 78 0000
 80 0000
 82 0000
 84 0000
 86 0000
 88 0000
 90 0000
 92 0000
 94 0000
 96 0000
 98 0000
100 0000
102 0000
104 0000
106 0000
108 0000
110 0000
112 0000
114 524a
116 0001
118 0e01
120 0001
122 5159
124 0072
126 e665
eth1: DC21140 at 0xfc00 (PCI bus 1, device 6), h/w address= 00:c0:95:e0:37:66,
eth1: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10


MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10
      and requires IRQ9 (provided by PCI BIOS).
de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
eth2: probing PCI bus=1 dev=5. 
Sub-system Vendor ID: c000
Sub-system ID:        e095
ID Block CRC:         e8
SROM version:         01
# controllers:         01
Hardware Address:     00:c0:95:e0:37:65
CRC checksum:         8992
  0 c000
  2 e095
  4 6537
  6 0000
  8 0000
 10 0000
 12 0000
 14 0000
 16 00e8
 18 0101
 20 c000
 22 e095
 24 6537
 26 1e00
 28 0000
 30 0800
 32 0203
 34 0000
 36 0017
 38 0003
 40 4087
 42 0000
 44 0000
 46 0000
 48 0000
 50 0000
 52 0000
 54 0000
 56 0000
 58 0000
 60 0000
 62 0000
 64 0000
 66 0000
 68 0000
 70 0000
 72 0000
 74 0000
 76 0000
 78 0000
 80 0000
 82 0000
 84 0000
 86 0000
 88 0000
 90 0000
 92 0000
 94 0000
 96 0000
 98 0000
100 0000
102 0000
104 0000
106 0000
108 0000
110 0000
112 0000
114 524a
116 0001
118 0e01
120 0001
122 5159
124 0072
126 8992
eth2: DC21140 at 0xf880 (PCI bus 1, device 5), h/w address= 00:c0:95:e0:37:65,
eth2: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10


MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10
      and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
eth3: probing PCI bus=1 dev=4. 
Sub-system Vendor ID: c000
Sub-system ID:        e095
ID Block CRC:         74
SROM version:         01
# controllers:         04
Hardware Address:     00:c0:95:e0:37:64
CRC checksum:         df25
  0 c000
  2 e095
  4 6437
  6 0000
  8 0000
 10 0000
 12 0000
 14 0000
 16 0074
 18 0401
 20 c000
 22 e095
 24 6437
 26 2704
 28 0500
 30 0027
 32 2706
 34 0700
 36 0027
 38 0000
 40 0308
 42 0002
 44 1700
 46 0300
 48 8700
 50 0040
 52 0000
 54 0000
 56 0000
 58 0000
 60 0000
 62 0000
 64 0000
 66 0000
 68 0000
 70 0000
 72 0000
 74 0000
 76 0000
 78 0000
 80 0000
 82 0000
 84 0000
 86 0000
 88 0000
 90 0000
 92 0000
 94 0000
 96 0000
 98 0000
100 0000
102 0000
104 0000
106 0000
108 0000
110 0000
112 0000
114 524a
116 0001
118 0e01
120 0001
122 5159
124 0072
126 df25
eth3: DC21140 at 0xf800 (PCI bus 1, device 4), h/w address= 00:c0:95:e0:37:64,
eth3: Using generic MII device control. If the board doesn't operate, 
please mail the following dump to the author:

MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10


MII device address: 1
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f423
MII ANA: 1e1
MII ANC: 0
MII 16:  58
MII 17:  8408
MII 18:  10
      and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
init_module: adapters searched=5 xstat=-5


------------------- de4x5-2.4.2.diff ------------------------
--- linux-2.4.2/drivers/net/de4x5-dist.c	Fri Feb  9 20:40:02 2001
+++ linux-2.4.2/drivers/net/de4x5.c	Tue Apr 10 03:36:32 2001
@@ -569,8 +569,8 @@
 #ifdef DE4X5_DEBUG
 static int de4x5_debug = DE4X5_DEBUG;
 #else
-/*static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);*/
-static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION);
+static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);
+/* static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION); */
 #endif
 
 /*
@@ -869,7 +869,7 @@
     struct de4x5_srom srom;
     int autosense;
     int useSROM;
-} bus;
+} bus = {0,0,0,0,};
 
 /*
 ** To get around certain poxy cards that don't provide an SROM
@@ -888,7 +888,7 @@
     int bus;
     int irq;
     u_char addr[ETH_ALEN];
-} last = {0,};
+} last = {0,0,};
 
 /*
 ** The transmit ring full condition is described by the tx_old and tx_new
@@ -965,7 +965,7 @@
 static int     test_tp(struct net_device *dev, s32 msec);
 static int     EISA_signature(char *name, s32 eisa_id);
 static int     PCI_signature(char *name, struct bus_type *lp);
-static void    DevicePresent(u_long iobase);
+static int     DevicePresent(u_long iobase);
 static void    enet_addr_rst(u_long aprom_addr);
 static int     de4x5_bad_srom(struct bus_type *lp);
 static short   srom_rd(u_long address, u_char offset);
@@ -997,10 +997,11 @@
 static int     test_bad_enet(struct net_device *dev, int status);
 static int     an_exception(struct bus_type *lp);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-static void    eisa_probe(struct net_device *dev, u_long iobase);
+static int     eisa_probe(struct net_device *dev, u_long iobase);
 #endif
-static void    pci_probe(struct net_device *dev, u_long iobase);
+static int     pci_probe(struct net_device *dev, u_long iobase);
 static void    srom_search(struct pci_dev *pdev);
+static int     srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr);
 static char    *build_setup_frame(struct net_device *dev, int mode);
 static void    disable_ast(struct net_device *dev);
 static void    enable_ast(struct net_device *dev, u32 time_out);
@@ -1035,7 +1036,6 @@
 static struct net_device *unlink_modules(struct net_device *p);
 static struct net_device *insert_device(struct net_device *dev, u_long iobase,
 				     int (*init)(struct net_device *));
-static int count_adapters(void);
 static int loading_module = 1;
 MODULE_PARM(de4x5_debug, "i");
 MODULE_PARM(dec_only, "i");
@@ -1121,15 +1121,16 @@
 de4x5_probe(struct net_device *dev)
 {
     u_long iobase = dev->base_addr;
+    int status;
 
-    pci_probe(dev, iobase);
+    status=pci_probe(dev, iobase);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    if ((lastPCI == NO_MORE_PCI) && ((num_de4x5s == 0) || forceEISA)) {
-        eisa_probe(dev, iobase);
+    if((-status)==ENODEV && ((num_de4x5s == 0) || forceEISA)) {
+      status=eisa_probe(dev, iobase);
     }
 #endif
     
-    return (dev->priv ? 0 : -ENODEV);
+    return(status);             /* was (dev->priv ? 0 : -ENODEV); */
 }
 
 static int __init 
@@ -1177,9 +1178,14 @@
 	       iobase, lp->bus_num, lp->device);
     }
     
-    printk(", h/w address ");
     status = get_hw_addr(dev);
-    for (i = 0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
+    if(status==1) {
+      status=0;
+      printk(", h/w address+ ");
+    } else {
+      printk(", h/w address= ");
+    }
+    for (i=0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
 	printk("%2.2x:", dev->dev_addr[i]);
     }
     printk("%2.2x,\n", dev->dev_addr[i]);
@@ -2095,10 +2101,10 @@
 ** EISA bus I/O device probe. Probe from slot 1 since slot 0 is usually
 ** the motherboard. Upto 15 EISA devices are supported.
 */
-static void __init 
+static int __init 
 eisa_probe(struct net_device *dev, u_long ioaddr)
 {
-    int i, maxSlots, status, device;
+    int i, maxSlots, status=-ENODEV, device;
     u_char irq;
     u_short vendor;
     u32 cfid;
@@ -2106,21 +2112,26 @@
     struct bus_type *lp = &bus;
     char name[DE4X5_STRLEN];
 
-    if (lastEISA == MAX_EISA_SLOTS) return;/* No more EISA devices to search */
+    if( lastEISA==MAX_EISA_SLOTS || !dev || /* No more EISA devices  */
+	(ioaddr && ioaddr<0x1000) )         /* it is a PCI bus:dev adress */
+      return(status);
 
     lp->bus = EISA;
+    lp->bus_num = 0;
     
-    if (ioaddr == 0) {                     /* Autoprobing */
-	iobase = EISA_SLOT_INC;            /* Get the first slot address */
-	i = 1;
+    if (ioaddr==0) {                       /* Autoprobing */
+	i = lastEISA+1;
+	iobase = i<<12;                    /* Get slot i address */
 	maxSlots = MAX_EISA_SLOTS;
     } else {                               /* Probe a specific location */
 	iobase = ioaddr;
 	i = (ioaddr >> 12);
 	maxSlots = i + 1;
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching EISA iobase=0x%04lx. \n", dev->name,iobase);
     }
     
-    for (status = -ENODEV; (i<maxSlots) && (dev!=NULL); i++, iobase+=EISA_SLOT_INC) {
+    for (; i<maxSlots; i++, iobase+=EISA_SLOT_INC) {
 	if (check_region(iobase, DE4X5_EISA_TOTAL_SIZE)) continue;
 	if (!EISA_signature(name, EISA_ID)) continue;
 
@@ -2149,14 +2160,14 @@
 	if ((status = de4x5_hw_init(dev, iobase, NULL)) == 0) {
 	    num_de4x5s++;
 	    if (loading_module) link_modules(lastModule, dev);
-	    lastEISA = i;
-	    return;
+	    if(ioaddr==0) lastEISA = i;
+	    return(status);
 	}
     }
 
     if (ioaddr == 0) lastEISA = i;
 
-    return;
+    return(status);
 }
 #endif          /* !(__sparc_v9__) && !(__powerpc__) && !defined(__alpha__) */
 
@@ -2175,36 +2186,45 @@
 ** This function is only compatible with the *latest* 2.1.x kernels. For 2.0.x
 ** kernels use the V0.535[n] drivers.
 */
-#define PCI_LAST_DEV  32
+/*#define PCI_LAST_DEV  32*/
 
-static void __init 
+static int __init 
 pci_probe(struct net_device *dev, u_long ioaddr)
 {
     u_char pb, pbus, dev_num, dnum, timer;
-    u_short vendor, index, status;
+    u_short vendor, status;
     u_int irq = 0, device, class = DE4X5_CLASS_CODE;
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     struct bus_type *lp = &bus;
+    int autoprobe=(!loading_module || ioaddr==0), estatus=-ENODEV;
 
-    if (lastPCI == NO_MORE_PCI) return;
+    if( lastPCI==NO_MORE_PCI || !dev || 
+	(loading_module && ioaddr>=0x1000) )  /* ioaddr is an EISA iobase */
+      return(estatus);
 
     if (!pcibios_present()) {
 	lastPCI = NO_MORE_PCI;
-	return;          /* No PCI bus in this machine! */
+	return(estatus);          /* No PCI bus in this machine! */
     }
     
-    lp->bus = PCI;
-    lp->bus_num = 0;
+    if(lp->bus!=PCI) {  /* force srom_search() */
+      lp->bus = PCI;
+      lp->bus_num = 0;
+      lp->chipset = 0;
+    }
 
-    if ((ioaddr < 0x1000) && loading_module) {
-	pbus = (u_short)(ioaddr >> 8);
-	dnum = (u_short)(ioaddr & 0xff);
-    } else {
+    if(autoprobe) {
 	pbus = 0;
 	dnum = 0;
+    } else {
+	pbus = (u_short)(ioaddr >> 8);
+	dnum = (u_short)(ioaddr & 0xff);
+	pdev=NULL;       /* search the whole PCI list */
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching PCI bus:dev=0x%04lx. \n", dev->name,ioaddr);
     }
 
-    for (index=lastPCI+1;(pdev = pci_find_class(class, pdev))!=NULL;index++) {
+    for (; (pdev = pci_find_class(class, pdev))!=NULL; ) {
 	dev_num = PCI_SLOT(pdev->devfn);
 	pb = pdev->bus->number;
 	if ((pbus || dnum) && ((pbus != pb) || (dnum != dev_num))) continue;
@@ -2213,8 +2233,11 @@
 	device = pdev->device << 8;
 	if (!(is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x)) continue;
 
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: probing PCI bus=%d dev=%d. \n", dev->name,pb,dev_num);
+
 	/* Search for an SROM on this bus */
-	if (lp->bus_num != pb) {
+	if (lp->chipset!=device || lp->bus_num!=pb) {
 	    lp->bus_num = pb;
 	    srom_search(pdev);
 	}
@@ -2266,31 +2289,32 @@
 	DevicePresent(DE4X5_APROM);
 	if (check_region(iobase, DE4X5_PCI_TOTAL_SIZE) == 0) {
 	    dev->irq = irq;
-	    if ((status = de4x5_hw_init(dev, iobase, pdev)) == 0) {
+	    if ((estatus = de4x5_hw_init(dev, iobase, pdev)) == 0) {
 		num_de4x5s++;
-		lastPCI = index;
 		if (loading_module) link_modules(lastModule, dev);
-		return;
+		return(estatus);
 	    }
 	} else if (ioaddr != 0) {
-	    printk("%s: region already allocated at 0x%04lx.\n", dev->name,
-		   iobase);
+	    printk("%s: region already allocated at 0x%04lx, bus=%d dev=%d.\n",
+		   dev->name,iobase,pb,dev_num);
 	}
-    }
+    } /* for index */
 
-    lastPCI = NO_MORE_PCI;
+    if(autoprobe) lastPCI = NO_MORE_PCI;
 
-    return;
+    return(estatus);
 }
 
 /*
 ** This function searches the current bus (which is >0) for a DECchip with an
 ** SROM, so that in multiport cards that have one SROM shared between multiple 
 ** DECchips, we can find the base SROM irrespective of the BIOS scan direction.
-** For single port cards this is a time waster...
+** The global variable last.addr is updated only once initializing multiport
+** cards.  Otherwise, the four port one srom/prom card results in hw ethers
+** base, base+1, base+1, base+1.
 */
 static void __init 
-srom_search(struct pci_dev *dev)
+srom_search(struct pci_dev *orig_dev)
 {
     u_char pb;
     u_short vendor, status;
@@ -2298,10 +2322,14 @@
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j;
     struct bus_type *lp = &bus;
-    struct list_head *walk = &dev->bus_list;
+    struct list_head *walk = &orig_dev->bus_list;
 
-    for (walk = walk->next; walk != &dev->bus_list; walk = walk->next) {
+    /* Search all pci devs behind the bridge except the one initializing, 
+     * since DevicePresent in pci_probe() will search that one.
+     */
+    for (walk = walk->next; walk != &orig_dev->bus_list; walk = walk->next) {
 	struct pci_dev *this_dev = pci_dev_b(walk);
+	if(this_dev==orig_dev) continue;
 
 	pb = this_dev->bus->number;
 	vendor = this_dev->vendor;
@@ -2314,7 +2342,10 @@
 	/* Set the device number information */
 	lp->device = PCI_SLOT(this_dev->devfn);
 	lp->bus_num = pb;
-	    
+
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("srom_search: PCI bus=%d dev=%d. \n", pb,lp->device);
+
 	/* Set the chipset information */
 	if (is_DC2114x) {
 	    device = ((cfrv & CFRV_RN) < DC2114x_BRK ? DC21142 : DC21143);
@@ -2333,24 +2364,81 @@
 	if (!(status & PCI_COMMAND_IO)) continue;
 
 	/* Search for a valid SROM attached to this DECchip */
-	DevicePresent(DE4X5_APROM);
-	for (j=0, i=0; i<ETH_ALEN; i++) {
-	    j += (u_char) *((u_char *)&lp->srom + SROM_HWADD + i);
-	}
-	if ((j != 0) && (j != 0x5fa)) {
+	j=DevicePresent(DE4X5_APROM);
+
+	/* update last. if necessary */
+	if(last.chipset!=device || last.bus!=pb) {
+	  int k=0;
+	  if (!j && lp->chipset==DC21040)
+	    j=k=srom_search_dc21040_pci(DE4X5_APROM, last.addr);
+	  
+	  if(j) {
+	    if(de4x5_debug & DEBUG_PCICFG)
+	      printk("Copying srom ether at 0x%04lx, bus=%d dev=%d, to last "
+		     "adress. \n", iobase,pb,lp->device);
 	    last.chipset = device;
 	    last.bus = pb;
 	    last.irq = irq;
-	    for (i=0; i<ETH_ALEN; i++) {
+	    if(!k) 
+	      for (i=0; i<ETH_ALEN; i++) {
 		last.addr[i] = (u_char)*((u_char *)&lp->srom + SROM_HWADD + i);
-	    }
+	      }
 	    return;
-	}
-    }
+	  }
+	} /* update last. needed */
+	if(j) return;
+    } /* for walk */
 
     return;
 }
 
+static int __init
+srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr)
+{
+   u_char tmp_addr[ETH_ALEN];
+   int i, k, tmp, psum;
+   u_short j,chksum;
+
+   if(de4x5_debug & DEBUG_PCICFG)
+     printk("DC21040 getting h/w ether from I/O at 0x%04lx.  (",aprom_addr);
+   for (i=0,psum=0,k=0,j=0; j<3; j++) {
+     k <<= 1;
+     if (k > 0xffff) k-=0xffff;
+
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_char) tmp;
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_short) (tmp << 8);
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+
+     if (k > 0xffff) k-=0xffff;
+   }
+   if (k == 0xffff) k=0;
+
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum = (u_char) tmp;
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum |= (u_short) (tmp << 8);
+   if( ((k == chksum) || !dec_only) && psum!=0x0 && psum!=0x5fa) {
+     for(i=0; i<6; i++) dev_addr[i]=tmp_addr[i];
+     if(de4x5_debug & DEBUG_PCICFG) {
+       for (i=0; i < ETH_ALEN - 1; i++) printk("%2.2x:", tmp_addr[i]);
+       printk("%2.2x", tmp_addr[i]);
+     }
+   } else
+     psum=0;
+ 
+   if(de4x5_debug & DEBUG_PCICFG) printk(") \n");
+ 
+   outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
+ 
+   return(psum);
+}
+
+
 static void __init 
 link_modules(struct net_device *dev, struct net_device *tmp)
 {
@@ -4059,12 +4147,12 @@
 ** immediately with the prior srom contents intact (the h/w address will
 ** be fixed up later).
 */
-static void
+static int
 DevicePresent(u_long aprom_addr)
 {
-    int i, j=0;
+    int status=0;
     struct bus_type *lp = &bus;
-    
+
     if (lp->chipset == DC21040) {
 	if (lp->bus == EISA) {
 	    enet_addr_rst(aprom_addr); /* Reset Ethernet Address ROM Pointer */
@@ -4072,6 +4160,7 @@
 	    outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
 	}
     } else {                           /* Read new srom */
+        int i, j=0;
 	u_short tmp, *p = (short *)((char *)&lp->srom + SROM_HWADD);
 	for (i=0; i<(ETH_ALEN>>1); i++) {
 	    tmp = srom_rd(aprom_addr, (SROM_HWADD>>1) + i);
@@ -4079,7 +4168,7 @@
 	    j += *p++;
 	}
 	if ((j == 0) || (j == 0x2fffd)) {
-	    return;
+	    return(status);
 	}
 
 	p=(short *)&lp->srom;
@@ -4087,10 +4176,11 @@
 	    tmp = srom_rd(aprom_addr, i);
 	    *p++ = le16_to_cpu(tmp);
 	}
+	status=1;                      /* success */
 	de4x5_dbg_srom((struct de4x5_srom *)&lp->srom);
     }
     
-    return;
+    return(status);
 }
 
 /*
@@ -4297,7 +4387,7 @@
 		dev->irq = last.irq;
 	    }
 
-	    status = 0;
+	    status = 1;
 	}
     } else if (!status) {
 	last.chipset = lp->chipset;
@@ -5800,27 +5890,36 @@
 ** IRQ lines will not be auto-detected; instead I'll rely on the BIOSes
 ** to "do the right thing".
 */
-#define LP(a) ((struct de4x5_private *)(a))
+/*#define LP(a) ((struct de4x5_private *)(a))*/
 static struct net_device *mdev = NULL;
-static int io=0x0;/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+static int io=0x0, io1=0x0, io2=0x0, io3=0x0, zeroconst=0;
 MODULE_PARM(io, "i");
+MODULE_PARM(io1, "i");
+MODULE_PARM(io2, "i");
+MODULE_PARM(io3, "i");
+static int *giolist[]={&io, &io1, &io2, &io3, &zeroconst};
 
 int
 init_module(void)
 {
-    int i, num, status = -EIO;
+    int i, num, status=-ENODEV, xstat=0;
     struct net_device *p;
+    u_long net_io=0;
 
-    num = count_adapters();
+    for(num=0; *giolist[num]; num++);
+    if(!num) num = 32;
 
-    for (i=0; i<num; i++) {
-	if ((p = insert_device(NULL, io, de4x5_probe)) == NULL) 
+    for (i=0; i<num && (*giolist[0] || !xstat); i++) {
+        if(*giolist[0]) net_io=*giolist[i];
+	if ((p = insert_device(NULL, net_io, de4x5_probe)) == NULL) 
 	    return -ENOMEM;
 
 	if (!mdev) mdev = p;
 
-	if (register_netdev(p) != 0) {
+	if ((xstat=register_netdev(p)) != 0) {
 	    struct de4x5_private *lp = (struct de4x5_private *)p->priv;
+	    if (status && xstat) status=xstat;
 	    if (lp) {
 		release_region(p->base_addr, (lp->bus == PCI ? 
 					      DE4X5_PCI_TOTAL_SIZE :
@@ -5840,6 +5939,8 @@
 	}
     }
 
+    if(de4x5_debug & DEBUG_PCICFG) 
+      printk("init_module: adapters searched=%d xstat=%d\n",i,xstat);
     return status;
 }
 
@@ -5875,33 +5976,6 @@
     kfree(p);                               /* Free the device structure */
     
     return next;
-}
-
-static int
-count_adapters(void)
-{
-    int i, j=0;
-    u_short vendor;
-    u_int class = DE4X5_CLASS_CODE;
-    u_int device;
-
-#if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    char name[DE4X5_STRLEN];
-    u_long iobase = 0x1000;
-
-    for (i=1; i<MAX_EISA_SLOTS; i++, iobase+=EISA_SLOT_INC) {
-	if (EISA_signature(name, EISA_ID)) j++;
-    }
-#endif
-    if (!pcibios_present()) return j;
-
-    for (i=0; (pdev=pci_find_class(class, pdev))!= NULL; i++) {
-	vendor = pdev->vendor;
-	device = pdev->device << 8;
-	if (is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x) j++;
-    }
-
-    return j;
 }
 
 /*
------------------- de4x5-2.4.3.diff ------------------------
--- linux-2.4.3/drivers/net/de4x5-dist.c	Wed Mar  7 04:28:35 2001
+++ linux-2.4.3/drivers/net/de4x5.c	Thu Apr 19 02:46:21 2001
@@ -569,8 +569,8 @@
 #ifdef DE4X5_DEBUG
 static int de4x5_debug = DE4X5_DEBUG;
 #else
-/*static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);*/
-static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION);
+static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);
+/* static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION); */
 #endif
 
 /*
@@ -869,7 +869,7 @@
     struct de4x5_srom srom;
     int autosense;
     int useSROM;
-} bus;
+} bus = {0,0,0,0,};
 
 /*
 ** To get around certain poxy cards that don't provide an SROM
@@ -888,7 +888,7 @@
     int bus;
     int irq;
     u_char addr[ETH_ALEN];
-} last = {0,};
+} last = {0,0,};
 
 /*
 ** The transmit ring full condition is described by the tx_old and tx_new
@@ -963,7 +963,7 @@
 static int     test_tp(struct net_device *dev, s32 msec);
 static int     EISA_signature(char *name, s32 eisa_id);
 static int     PCI_signature(char *name, struct bus_type *lp);
-static void    DevicePresent(u_long iobase);
+static int     DevicePresent(u_long iobase);
 static void    enet_addr_rst(u_long aprom_addr);
 static int     de4x5_bad_srom(struct bus_type *lp);
 static short   srom_rd(u_long address, u_char offset);
@@ -995,10 +995,11 @@
 static int     test_bad_enet(struct net_device *dev, int status);
 static int     an_exception(struct bus_type *lp);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-static void    eisa_probe(struct net_device *dev, u_long iobase);
+static int     eisa_probe(struct net_device *dev, u_long iobase);
 #endif
-static void    pci_probe(struct net_device *dev, u_long iobase);
+static int     pci_probe(struct net_device *dev, u_long iobase);
 static void    srom_search(struct pci_dev *pdev);
+static int     srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr);
 static char    *build_setup_frame(struct net_device *dev, int mode);
 static void    disable_ast(struct net_device *dev);
 static void    enable_ast(struct net_device *dev, u32 time_out);
@@ -1033,7 +1034,6 @@
 static struct net_device *unlink_modules(struct net_device *p);
 static struct net_device *insert_device(struct net_device *dev, u_long iobase,
 				     int (*init)(struct net_device *));
-static int count_adapters(void);
 static int loading_module = 1;
 MODULE_PARM(de4x5_debug, "i");
 MODULE_PARM(dec_only, "i");
@@ -1119,15 +1119,16 @@
 de4x5_probe(struct net_device *dev)
 {
     u_long iobase = dev->base_addr;
+    int status;
 
-    pci_probe(dev, iobase);
+    status=pci_probe(dev, iobase);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    if ((lastPCI == NO_MORE_PCI) && ((num_de4x5s == 0) || forceEISA)) {
-        eisa_probe(dev, iobase);
+    if((-status)==ENODEV && ((num_de4x5s == 0) || forceEISA)) {
+      status=eisa_probe(dev, iobase);
     }
 #endif
     
-    return (dev->priv ? 0 : -ENODEV);
+    return(status);             /* was (dev->priv ? 0 : -ENODEV); */
 }
 
 static int __init 
@@ -1175,9 +1176,14 @@
 	       iobase, lp->bus_num, lp->device);
     }
     
-    printk(", h/w address ");
     status = get_hw_addr(dev);
-    for (i = 0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
+    if(status==1) {
+      status=0;
+      printk(", h/w address+ ");
+    } else {
+      printk(", h/w address= ");
+    }
+    for (i=0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
 	printk("%2.2x:", dev->dev_addr[i]);
     }
     printk("%2.2x,\n", dev->dev_addr[i]);
@@ -2093,10 +2099,10 @@
 ** EISA bus I/O device probe. Probe from slot 1 since slot 0 is usually
 ** the motherboard. Upto 15 EISA devices are supported.
 */
-static void __init 
+static int __init 
 eisa_probe(struct net_device *dev, u_long ioaddr)
 {
-    int i, maxSlots, status, device;
+    int i, maxSlots, status=-ENODEV, device;
     u_char irq;
     u_short vendor;
     u32 cfid;
@@ -2104,21 +2110,26 @@
     struct bus_type *lp = &bus;
     char name[DE4X5_STRLEN];
 
-    if (lastEISA == MAX_EISA_SLOTS) return;/* No more EISA devices to search */
+    if( lastEISA==MAX_EISA_SLOTS || !dev || /* No more EISA devices  */
+	(ioaddr && ioaddr<0x1000) )         /* it is a PCI bus:dev adress */
+      return(status);
 
     lp->bus = EISA;
+    lp->bus_num = 0;
     
-    if (ioaddr == 0) {                     /* Autoprobing */
-	iobase = EISA_SLOT_INC;            /* Get the first slot address */
-	i = 1;
+    if (ioaddr==0) {                       /* Autoprobing */
+	i = lastEISA+1;
+	iobase = i<<12;                    /* Get slot i address */
 	maxSlots = MAX_EISA_SLOTS;
     } else {                               /* Probe a specific location */
 	iobase = ioaddr;
 	i = (ioaddr >> 12);
 	maxSlots = i + 1;
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching EISA iobase=0x%04lx. \n", dev->name,iobase);
     }
     
-    for (status = -ENODEV; (i<maxSlots) && (dev!=NULL); i++, iobase+=EISA_SLOT_INC) {
+    for (; i<maxSlots; i++, iobase+=EISA_SLOT_INC) {
 	if (check_region(iobase, DE4X5_EISA_TOTAL_SIZE)) continue;
 	if (!EISA_signature(name, EISA_ID)) continue;
 
@@ -2147,14 +2158,14 @@
 	if ((status = de4x5_hw_init(dev, iobase, NULL)) == 0) {
 	    num_de4x5s++;
 	    if (loading_module) link_modules(lastModule, dev);
-	    lastEISA = i;
-	    return;
+	    if(ioaddr==0) lastEISA = i;
+	    return(status);
 	}
     }
 
     if (ioaddr == 0) lastEISA = i;
 
-    return;
+    return(status);
 }
 #endif          /* !(__sparc_v9__) && !(__powerpc__) && !defined(__alpha__) */
 
@@ -2173,36 +2184,45 @@
 ** This function is only compatible with the *latest* 2.1.x kernels. For 2.0.x
 ** kernels use the V0.535[n] drivers.
 */
-#define PCI_LAST_DEV  32
+/*#define PCI_LAST_DEV  32*/
 
-static void __init 
+static int __init 
 pci_probe(struct net_device *dev, u_long ioaddr)
 {
     u_char pb, pbus, dev_num, dnum, timer;
-    u_short vendor, index, status;
+    u_short vendor, status;
     u_int irq = 0, device, class = DE4X5_CLASS_CODE;
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     struct bus_type *lp = &bus;
+    int autoprobe=(!loading_module || ioaddr==0), estatus=-ENODEV;
 
-    if (lastPCI == NO_MORE_PCI) return;
+    if( lastPCI==NO_MORE_PCI || !dev || 
+	(loading_module && ioaddr>=0x1000) )  /* ioaddr is an EISA iobase */
+      return(estatus);
 
     if (!pcibios_present()) {
 	lastPCI = NO_MORE_PCI;
-	return;          /* No PCI bus in this machine! */
+	return(estatus);          /* No PCI bus in this machine! */
     }
     
+    if(lp->bus!=PCI) {  /* force srom_search() */
     lp->bus = PCI;
     lp->bus_num = 0;
+      lp->chipset = 0;
+    }
 
-    if ((ioaddr < 0x1000) && loading_module) {
-	pbus = (u_short)(ioaddr >> 8);
-	dnum = (u_short)(ioaddr & 0xff);
-    } else {
+    if(autoprobe) {
 	pbus = 0;
 	dnum = 0;
+    } else {
+	pbus = (u_short)(ioaddr >> 8);
+	dnum = (u_short)(ioaddr & 0xff);
+	pdev=NULL;       /* search the whole PCI list */
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching PCI bus:dev=0x%04lx. \n", dev->name,ioaddr);
     }
 
-    for (index=lastPCI+1;(pdev = pci_find_class(class, pdev))!=NULL;index++) {
+    for (; (pdev = pci_find_class(class, pdev))!=NULL; ) {
 	dev_num = PCI_SLOT(pdev->devfn);
 	pb = pdev->bus->number;
 	if ((pbus || dnum) && ((pbus != pb) || (dnum != dev_num))) continue;
@@ -2211,8 +2231,11 @@
 	device = pdev->device << 8;
 	if (!(is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x)) continue;
 
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: probing PCI bus=%d dev=%d. \n", dev->name,pb,dev_num);
+
 	/* Search for an SROM on this bus */
-	if (lp->bus_num != pb) {
+	if (lp->chipset!=device || lp->bus_num!=pb) {
 	    lp->bus_num = pb;
 	    srom_search(pdev);
 	}
@@ -2264,31 +2287,32 @@
 	DevicePresent(DE4X5_APROM);
 	if (check_region(iobase, DE4X5_PCI_TOTAL_SIZE) == 0) {
 	    dev->irq = irq;
-	    if ((status = de4x5_hw_init(dev, iobase, pdev)) == 0) {
+	    if ((estatus = de4x5_hw_init(dev, iobase, pdev)) == 0) {
 		num_de4x5s++;
-		lastPCI = index;
 		if (loading_module) link_modules(lastModule, dev);
-		return;
+		return(estatus);
 	    }
 	} else if (ioaddr != 0) {
-	    printk("%s: region already allocated at 0x%04lx.\n", dev->name,
-		   iobase);
-	}
+	    printk("%s: region already allocated at 0x%04lx, bus=%d dev=%d.\n",
+		   dev->name,iobase,pb,dev_num);
     }
+    } /* for index */
 
-    lastPCI = NO_MORE_PCI;
+    if(autoprobe) lastPCI = NO_MORE_PCI;
 
-    return;
+    return(estatus);
 }
 
 /*
 ** This function searches the current bus (which is >0) for a DECchip with an
 ** SROM, so that in multiport cards that have one SROM shared between multiple 
 ** DECchips, we can find the base SROM irrespective of the BIOS scan direction.
-** For single port cards this is a time waster...
+** The global variable last.addr is updated only once initializing multiport
+** cards.  Otherwise, the four port one srom/prom card results in hw ethers
+** base, base+1, base+1, base+1.
 */
 static void __init 
-srom_search(struct pci_dev *dev)
+srom_search(struct pci_dev *orig_dev)
 {
     u_char pb;
     u_short vendor, status;
@@ -2296,13 +2320,18 @@
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j;
     struct bus_type *lp = &bus;
-    struct list_head *walk = &dev->bus_list;
+    struct list_head *walk = &orig_dev->bus_list;
 
-    for (walk = walk->next; walk != &dev->bus_list; walk = walk->next) {
+    /* Search all pci devs behind the bridge except the one initializing, 
+     * since DevicePresent in pci_probe() will search that one.
+     */
+    for (walk = walk->next; walk != &orig_dev->bus_list; walk = walk->next) {
 	struct pci_dev *this_dev = pci_dev_b(walk);
+	if (this_dev==orig_dev) continue;
 
 	/* Skip the pci_bus list entry */
-	if (list_entry(walk, struct pci_bus, devices) == dev->bus) continue;
+	if (list_entry(walk, struct pci_bus, devices) == orig_dev->bus) 
+	  continue;
 
 	pb = this_dev->bus->number;
 	vendor = this_dev->vendor;
@@ -2316,6 +2345,9 @@
 	lp->device = PCI_SLOT(this_dev->devfn);
 	lp->bus_num = pb;
 	    
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("srom_search: PCI bus=%d dev=%d. \n", pb,lp->device);
+
 	/* Set the chipset information */
 	if (is_DC2114x) {
 	    device = ((cfrv & CFRV_RN) < DC2114x_BRK ? DC21142 : DC21143);
@@ -2334,24 +2366,81 @@
 	if (!(status & PCI_COMMAND_IO)) continue;
 
 	/* Search for a valid SROM attached to this DECchip */
-	DevicePresent(DE4X5_APROM);
-	for (j=0, i=0; i<ETH_ALEN; i++) {
-	    j += (u_char) *((u_char *)&lp->srom + SROM_HWADD + i);
-	}
-	if ((j != 0) && (j != 0x5fa)) {
+	j=DevicePresent(DE4X5_APROM);
+
+	/* update last. if necessary */
+	if(last.chipset!=device || last.bus!=pb) {
+	  int k=0;
+	  if (!j && lp->chipset==DC21040)
+	    j=k=srom_search_dc21040_pci(DE4X5_APROM, last.addr);
+	  
+	  if(j) {
+	    if(de4x5_debug & DEBUG_PCICFG)
+	      printk("Copying srom ether at 0x%04lx, bus=%d dev=%d, to last "
+		     "adress. \n", iobase,pb,lp->device);
 	    last.chipset = device;
 	    last.bus = pb;
 	    last.irq = irq;
+	    if(!k) 
 	    for (i=0; i<ETH_ALEN; i++) {
 		last.addr[i] = (u_char)*((u_char *)&lp->srom + SROM_HWADD + i);
 	    }
 	    return;
 	}
-    }
+	} /* update last. needed */
+	if(j) return;
+    } /* for walk */
 
     return;
 }
 
+static int __init
+srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr)
+{
+   u_char tmp_addr[ETH_ALEN];
+   int i, k, tmp, psum;
+   u_short j,chksum;
+
+   if(de4x5_debug & DEBUG_PCICFG)
+     printk("DC21040 getting h/w ether from I/O at 0x%04lx.  (",aprom_addr);
+   for (i=0,psum=0,k=0,j=0; j<3; j++) {
+     k <<= 1;
+     if (k > 0xffff) k-=0xffff;
+
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_char) tmp;
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_short) (tmp << 8);
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+
+     if (k > 0xffff) k-=0xffff;
+   }
+   if (k == 0xffff) k=0;
+
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum = (u_char) tmp;
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum |= (u_short) (tmp << 8);
+   if( ((k == chksum) || !dec_only) && psum!=0x0 && psum!=0x5fa) {
+     for(i=0; i<6; i++) dev_addr[i]=tmp_addr[i];
+     if(de4x5_debug & DEBUG_PCICFG) {
+       for (i=0; i < ETH_ALEN - 1; i++) printk("%2.2x:", tmp_addr[i]);
+       printk("%2.2x", tmp_addr[i]);
+     }
+   } else
+     psum=0;
+ 
+   if(de4x5_debug & DEBUG_PCICFG) printk(") \n");
+ 
+   outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
+ 
+   return(psum);
+}
+
+
 static void __init 
 link_modules(struct net_device *dev, struct net_device *tmp)
 {
@@ -4033,10 +4122,10 @@
 ** immediately with the prior srom contents intact (the h/w address will
 ** be fixed up later).
 */
-static void
+static int
 DevicePresent(u_long aprom_addr)
 {
-    int i, j=0;
+    int status=0;
     struct bus_type *lp = &bus;
     
     if (lp->chipset == DC21040) {
@@ -4046,6 +4135,7 @@
 	    outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
 	}
     } else {                           /* Read new srom */
+        int i, j=0;
 	u_short tmp, *p = (short *)((char *)&lp->srom + SROM_HWADD);
 	for (i=0; i<(ETH_ALEN>>1); i++) {
 	    tmp = srom_rd(aprom_addr, (SROM_HWADD>>1) + i);
@@ -4053,7 +4143,7 @@
 	    j += *p++;
 	}
 	if ((j == 0) || (j == 0x2fffd)) {
-	    return;
+	    return(status);
 	}
 
 	p=(short *)&lp->srom;
@@ -4061,10 +4151,11 @@
 	    tmp = srom_rd(aprom_addr, i);
 	    *p++ = le16_to_cpu(tmp);
 	}
+	status=1;                      /* success */
 	de4x5_dbg_srom((struct de4x5_srom *)&lp->srom);
     }
     
-    return;
+    return(status);
 }
 
 /*
@@ -4271,7 +4362,7 @@
 		dev->irq = last.irq;
 	    }
 
-	    status = 0;
+	    status = 1;
 	}
     } else if (!status) {
 	last.chipset = lp->chipset;
@@ -5774,27 +5865,36 @@
 ** IRQ lines will not be auto-detected; instead I'll rely on the BIOSes
 ** to "do the right thing".
 */
-#define LP(a) ((struct de4x5_private *)(a))
+/*#define LP(a) ((struct de4x5_private *)(a))*/
 static struct net_device *mdev = NULL;
-static int io=0x0;/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+static int io=0x0, io1=0x0, io2=0x0, io3=0x0, zeroconst=0;
 MODULE_PARM(io, "i");
+MODULE_PARM(io1, "i");
+MODULE_PARM(io2, "i");
+MODULE_PARM(io3, "i");
+static int *giolist[]={&io, &io1, &io2, &io3, &zeroconst};
 
 int
 init_module(void)
 {
-    int i, num, status = -EIO;
+    int i, num, status=-ENODEV, xstat=0;
     struct net_device *p;
+    u_long net_io=0;
 
-    num = count_adapters();
+    for(num=0; *giolist[num]; num++);
+    if(!num) num = 32;
 
-    for (i=0; i<num; i++) {
-	if ((p = insert_device(NULL, io, de4x5_probe)) == NULL) 
+    for (i=0; i<num && (*giolist[0] || !xstat); i++) {
+        if(*giolist[0]) net_io=*giolist[i];
+	if ((p = insert_device(NULL, net_io, de4x5_probe)) == NULL) 
 	    return -ENOMEM;
 
 	if (!mdev) mdev = p;
 
-	if (register_netdev(p) != 0) {
+	if ((xstat=register_netdev(p)) != 0) {
 	    struct de4x5_private *lp = (struct de4x5_private *)p->priv;
+	    if (status && xstat) status=xstat;
 	    if (lp) {
 		release_region(p->base_addr, (lp->bus == PCI ? 
 					      DE4X5_PCI_TOTAL_SIZE :
@@ -5814,6 +5914,8 @@
 	}
     }
 
+    if(de4x5_debug & DEBUG_PCICFG) 
+      printk("init_module: adapters searched=%d xstat=%d\n",i,xstat);
     return status;
 }
 
@@ -5849,33 +5951,6 @@
     kfree(p);                               /* Free the device structure */
     
     return next;
-}
-
-static int
-count_adapters(void)
-{
-    int i, j=0;
-    u_short vendor;
-    u_int class = DE4X5_CLASS_CODE;
-    u_int device;
-
-#if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    char name[DE4X5_STRLEN];
-    u_long iobase = 0x1000;
-
-    for (i=1; i<MAX_EISA_SLOTS; i++, iobase+=EISA_SLOT_INC) {
-	if (EISA_signature(name, EISA_ID)) j++;
-    }
-#endif
-    if (!pcibios_present()) return j;
-
-    for (i=0; (pdev=pci_find_class(class, pdev))!= NULL; i++) {
-	vendor = pdev->vendor;
-	device = pdev->device << 8;
-	if (is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x) j++;
-    }
-
-    return j;
 }
 
 /*
------------------- de4x5-2.4.13.diff ------------------------
--- linux-2.4.13/drivers/net/de4x5-dist.c	Sun Sep 30 21:26:06 2001
+++ linux-2.4.13/drivers/net/de4x5.c	Wed Oct 31 19:57:39 2001
@@ -575,8 +575,8 @@
 #ifdef DE4X5_DEBUG
 static int de4x5_debug = DE4X5_DEBUG;
 #else
-/*static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);*/
-static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION);
+static int de4x5_debug = (DEBUG_MII | DEBUG_SROM | DEBUG_PCICFG | DEBUG_MEDIA | DEBUG_VERSION);
+/* static int de4x5_debug = (DEBUG_MEDIA | DEBUG_VERSION); */
 #endif
 
 /*
@@ -875,7 +875,7 @@
     struct de4x5_srom srom;
     int autosense;
     int useSROM;
-} bus;
+} bus = {0,0,0,0,};
 
 /*
 ** To get around certain poxy cards that don't provide an SROM
@@ -894,7 +894,7 @@
     int bus;
     int irq;
     u_char addr[ETH_ALEN];
-} last = {0,};
+} last = {0,0,};
 
 /*
 ** The transmit ring full condition is described by the tx_old and tx_new
@@ -969,7 +969,7 @@
 static int     test_tp(struct net_device *dev, s32 msec);
 static int     EISA_signature(char *name, s32 eisa_id);
 static int     PCI_signature(char *name, struct bus_type *lp);
-static void    DevicePresent(u_long iobase);
+static int     DevicePresent(u_long iobase);
 static void    enet_addr_rst(u_long aprom_addr);
 static int     de4x5_bad_srom(struct bus_type *lp);
 static short   srom_rd(u_long address, u_char offset);
@@ -1001,10 +1001,11 @@
 static int     test_bad_enet(struct net_device *dev, int status);
 static int     an_exception(struct bus_type *lp);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-static void    eisa_probe(struct net_device *dev, u_long iobase);
+static int     eisa_probe(struct net_device *dev, u_long iobase);
 #endif
-static void    pci_probe(struct net_device *dev, u_long iobase);
+static int     pci_probe(struct net_device *dev, u_long iobase);
 static void    srom_search(struct pci_dev *pdev);
+static int     srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr);
 static char    *build_setup_frame(struct net_device *dev, int mode);
 static void    disable_ast(struct net_device *dev);
 static void    enable_ast(struct net_device *dev, u32 time_out);
@@ -1039,7 +1040,6 @@
 static struct net_device *unlink_modules(struct net_device *p);
 static struct net_device *insert_device(struct net_device *dev, u_long iobase,
 				     int (*init)(struct net_device *));
-static int count_adapters(void);
 static int loading_module = 1;
 MODULE_PARM(de4x5_debug, "i");
 MODULE_PARM(dec_only, "i");
@@ -1130,15 +1130,16 @@
 de4x5_probe(struct net_device *dev)
 {
     u_long iobase = dev->base_addr;
+    int status;
 
-    pci_probe(dev, iobase);
+    status=pci_probe(dev, iobase);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    if ((lastPCI == NO_MORE_PCI) && ((num_de4x5s == 0) || forceEISA)) {
-        eisa_probe(dev, iobase);
+    if((-status)==ENODEV && ((num_de4x5s == 0) || forceEISA)) {
+      status=eisa_probe(dev, iobase);
     }
 #endif
     
-    return (dev->priv ? 0 : -ENODEV);
+    return(status);             /* was (dev->priv ? 0 : -ENODEV); */
 }
 
 static int __init 
@@ -1186,9 +1187,14 @@
 	       iobase, lp->bus_num, lp->device);
     }
     
-    printk(", h/w address ");
     status = get_hw_addr(dev);
-    for (i = 0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
+    if(status==1) {
+      status=0;
+      printk(", h/w address+ ");
+    } else {
+      printk(", h/w address= ");
+    }
+    for (i=0; i < ETH_ALEN - 1; i++) {     /* get the ethernet addr. */
 	printk("%2.2x:", dev->dev_addr[i]);
     }
     printk("%2.2x,\n", dev->dev_addr[i]);
@@ -2104,10 +2110,10 @@
 ** EISA bus I/O device probe. Probe from slot 1 since slot 0 is usually
 ** the motherboard. Upto 15 EISA devices are supported.
 */
-static void __init 
+static int __init 
 eisa_probe(struct net_device *dev, u_long ioaddr)
 {
-    int i, maxSlots, status, device;
+    int i, maxSlots, status=-ENODEV, device;
     u_char irq;
     u_short vendor;
     u32 cfid;
@@ -2115,21 +2121,26 @@
     struct bus_type *lp = &bus;
     char name[DE4X5_STRLEN];
 
-    if (lastEISA == MAX_EISA_SLOTS) return;/* No more EISA devices to search */
+    if( lastEISA==MAX_EISA_SLOTS || !dev || /* No more EISA devices  */
+	(ioaddr && ioaddr<0x1000) )         /* it is a PCI bus:dev adress */
+      return(status);
 
     lp->bus = EISA;
+    lp->bus_num = 0;
     
-    if (ioaddr == 0) {                     /* Autoprobing */
-	iobase = EISA_SLOT_INC;            /* Get the first slot address */
-	i = 1;
+    if (ioaddr==0) {                       /* Autoprobing */
+	i = lastEISA+1;
+	iobase = i<<12;                    /* Get slot i address */
 	maxSlots = MAX_EISA_SLOTS;
     } else {                               /* Probe a specific location */
 	iobase = ioaddr;
 	i = (ioaddr >> 12);
 	maxSlots = i + 1;
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching EISA iobase=0x%04lx. \n", dev->name,iobase);
     }
     
-    for (status = -ENODEV; (i<maxSlots) && (dev!=NULL); i++, iobase+=EISA_SLOT_INC) {
+    for (; i<maxSlots; i++, iobase+=EISA_SLOT_INC) {
 	if (check_region(iobase, DE4X5_EISA_TOTAL_SIZE)) continue;
 	if (!EISA_signature(name, EISA_ID)) continue;
 
@@ -2158,14 +2169,14 @@
 	if ((status = de4x5_hw_init(dev, iobase, NULL)) == 0) {
 	    num_de4x5s++;
 	    if (loading_module) link_modules(lastModule, dev);
-	    lastEISA = i;
-	    return;
+	    if(ioaddr==0) lastEISA = i;
+	    return(status);
 	}
     }
 
     if (ioaddr == 0) lastEISA = i;
 
-    return;
+    return(status);
 }
 #endif          /* !(__sparc_v9__) && !(__powerpc__) && !defined(__alpha__) */
 
@@ -2184,36 +2195,45 @@
 ** This function is only compatible with the *latest* 2.1.x kernels. For 2.0.x
 ** kernels use the V0.535[n] drivers.
 */
-#define PCI_LAST_DEV  32
+/*#define PCI_LAST_DEV  32*/
 
-static void __init 
+static int __init 
 pci_probe(struct net_device *dev, u_long ioaddr)
 {
     u_char pb, pbus, dev_num, dnum, timer;
-    u_short vendor, index, status;
+    u_short vendor, status;
     u_int irq = 0, device, class = DE4X5_CLASS_CODE;
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     struct bus_type *lp = &bus;
+    int autoprobe=(!loading_module || ioaddr==0), estatus=-ENODEV;
 
-    if (lastPCI == NO_MORE_PCI) return;
+    if( lastPCI==NO_MORE_PCI || !dev || 
+	(loading_module && ioaddr>=0x1000) )  /* ioaddr is an EISA iobase */
+      return(estatus);
 
     if (!pcibios_present()) {
 	lastPCI = NO_MORE_PCI;
-	return;          /* No PCI bus in this machine! */
+	return(estatus);          /* No PCI bus in this machine! */
     }
     
+    if(lp->bus!=PCI) {  /* force srom_search() */
     lp->bus = PCI;
     lp->bus_num = 0;
+      lp->chipset = 0;
+    }
 
-    if ((ioaddr < 0x1000) && loading_module) {
-	pbus = (u_short)(ioaddr >> 8);
-	dnum = (u_short)(ioaddr & 0xff);
-    } else {
+    if(autoprobe) {
 	pbus = 0;
 	dnum = 0;
+    } else {
+	pbus = (u_short)(ioaddr >> 8);
+	dnum = (u_short)(ioaddr & 0xff);
+	pdev=NULL;       /* search the whole PCI list */
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: searching PCI bus:dev=0x%04lx. \n", dev->name,ioaddr);
     }
 
-    for (index=lastPCI+1;(pdev = pci_find_class(class, pdev))!=NULL;index++) {
+    for (; (pdev = pci_find_class(class, pdev))!=NULL; ) {
 	dev_num = PCI_SLOT(pdev->devfn);
 	pb = pdev->bus->number;
 	if ((pbus || dnum) && ((pbus != pb) || (dnum != dev_num))) continue;
@@ -2222,8 +2242,11 @@
 	device = pdev->device << 8;
 	if (!(is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x)) continue;
 
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("%s: probing PCI bus=%d dev=%d. \n", dev->name,pb,dev_num);
+
 	/* Search for an SROM on this bus */
-	if (lp->bus_num != pb) {
+	if (lp->chipset!=device || lp->bus_num!=pb) {
 	    lp->bus_num = pb;
 	    srom_search(pdev);
 	}
@@ -2275,31 +2298,32 @@
 	DevicePresent(DE4X5_APROM);
 	if (check_region(iobase, DE4X5_PCI_TOTAL_SIZE) == 0) {
 	    dev->irq = irq;
-	    if ((status = de4x5_hw_init(dev, iobase, pdev)) == 0) {
+	    if ((estatus = de4x5_hw_init(dev, iobase, pdev)) == 0) {
 		num_de4x5s++;
-		lastPCI = index;
 		if (loading_module) link_modules(lastModule, dev);
-		return;
+		return(estatus);
 	    }
 	} else if (ioaddr != 0) {
-	    printk("%s: region already allocated at 0x%04lx.\n", dev->name,
-		   iobase);
-	}
+	    printk("%s: region already allocated at 0x%04lx, bus=%d dev=%d.\n",
+		   dev->name,iobase,pb,dev_num);
     }
+    } /* for index */
 
-    lastPCI = NO_MORE_PCI;
+    if(autoprobe) lastPCI = NO_MORE_PCI;
 
-    return;
+    return(estatus);
 }
 
 /*
 ** This function searches the current bus (which is >0) for a DECchip with an
 ** SROM, so that in multiport cards that have one SROM shared between multiple 
 ** DECchips, we can find the base SROM irrespective of the BIOS scan direction.
-** For single port cards this is a time waster...
+** The global variable last.addr is updated only once initializing multiport
+** cards.  Otherwise, the four port one srom/prom card results in hw ethers
+** base, base+1, base+1, base+1.
 */
 static void __init 
-srom_search(struct pci_dev *dev)
+srom_search(struct pci_dev *orig_dev)
 {
     u_char pb;
     u_short vendor, status;
@@ -2307,13 +2331,18 @@
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j;
     struct bus_type *lp = &bus;
-    struct list_head *walk = &dev->bus_list;
+    struct list_head *walk = &orig_dev->bus_list;
 
-    for (walk = walk->next; walk != &dev->bus_list; walk = walk->next) {
+    /* Search all pci devs behind the bridge except the one initializing, 
+     * since DevicePresent in pci_probe() will search that one.
+     */
+    for (walk = walk->next; walk != &orig_dev->bus_list; walk = walk->next) {
 	struct pci_dev *this_dev = pci_dev_b(walk);
+	if (this_dev==orig_dev) continue;
 
 	/* Skip the pci_bus list entry */
-	if (list_entry(walk, struct pci_bus, devices) == dev->bus) continue;
+	if (list_entry(walk, struct pci_bus, devices) == orig_dev->bus) 
+	  continue;
 
 	vendor = this_dev->vendor;
 	device = this_dev->device << 8;
@@ -2327,6 +2356,9 @@
 	lp->device = PCI_SLOT(this_dev->devfn);
 	lp->bus_num = pb;
 	    
+	if(de4x5_debug & DEBUG_PCICFG) 
+	  printk("srom_search: PCI bus=%d dev=%d. \n", pb,lp->device);
+
 	/* Set the chipset information */
 	if (is_DC2114x) {
 	    device = ((cfrv & CFRV_RN) < DC2114x_BRK ? DC21142 : DC21143);
@@ -2345,24 +2377,81 @@
 	if (!(status & PCI_COMMAND_IO)) continue;
 
 	/* Search for a valid SROM attached to this DECchip */
-	DevicePresent(DE4X5_APROM);
-	for (j=0, i=0; i<ETH_ALEN; i++) {
-	    j += (u_char) *((u_char *)&lp->srom + SROM_HWADD + i);
-	}
-	if ((j != 0) && (j != 0x5fa)) {
+	j=DevicePresent(DE4X5_APROM);
+
+	/* update last. if necessary */
+	if(last.chipset!=device || last.bus!=pb) {
+	  int k=0;
+	  if (!j && lp->chipset==DC21040)
+	    j=k=srom_search_dc21040_pci(DE4X5_APROM, last.addr);
+	  
+	  if(j) {
+	    if(de4x5_debug & DEBUG_PCICFG)
+	      printk("Copying srom ether at 0x%04lx, bus=%d dev=%d, to last "
+		     "adress. \n", iobase,pb,lp->device);
 	    last.chipset = device;
 	    last.bus = pb;
 	    last.irq = irq;
+	    if(!k) 
 	    for (i=0; i<ETH_ALEN; i++) {
 		last.addr[i] = (u_char)*((u_char *)&lp->srom + SROM_HWADD + i);
 	    }
 	    return;
 	}
-    }
+	} /* update last. needed */
+	if(j) return;
+    } /* for walk */
 
     return;
 }
 
+static int __init
+srom_search_dc21040_pci(u_long aprom_addr, u_char *dev_addr)
+{
+   u_char tmp_addr[ETH_ALEN];
+   int i, k, tmp, psum;
+   u_short j,chksum;
+
+   if(de4x5_debug & DEBUG_PCICFG)
+     printk("DC21040 getting h/w ether from I/O at 0x%04lx.  (",aprom_addr);
+   for (i=0,psum=0,k=0,j=0; j<3; j++) {
+     k <<= 1;
+     if (k > 0xffff) k-=0xffff;
+
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_char) tmp;
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+     while ((tmp = inl(aprom_addr)) < 0);
+     k += (u_short) (tmp << 8);
+     psum+= (u_char) tmp;
+     tmp_addr[i++] = (u_char) tmp;
+
+     if (k > 0xffff) k-=0xffff;
+   }
+   if (k == 0xffff) k=0;
+
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum = (u_char) tmp;
+   while ((tmp = inl(aprom_addr)) < 0);
+   chksum |= (u_short) (tmp << 8);
+   if( ((k == chksum) || !dec_only) && psum!=0x0 && psum!=0x5fa) {
+     for(i=0; i<6; i++) dev_addr[i]=tmp_addr[i];
+     if(de4x5_debug & DEBUG_PCICFG) {
+       for (i=0; i < ETH_ALEN - 1; i++) printk("%2.2x:", tmp_addr[i]);
+       printk("%2.2x", tmp_addr[i]);
+     }
+   } else
+     psum=0;
+ 
+   if(de4x5_debug & DEBUG_PCICFG) printk(") \n");
+ 
+   outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
+ 
+   return(psum);
+}
+
+
 static void __init 
 link_modules(struct net_device *dev, struct net_device *tmp)
 {
@@ -4044,10 +4133,10 @@
 ** immediately with the prior srom contents intact (the h/w address will
 ** be fixed up later).
 */
-static void
+static int
 DevicePresent(u_long aprom_addr)
 {
-    int i, j=0;
+    int status=0;
     struct bus_type *lp = &bus;
     
     if (lp->chipset == DC21040) {
@@ -4057,6 +4146,7 @@
 	    outl(0, aprom_addr);       /* Reset Ethernet Address ROM Pointer */
 	}
     } else {                           /* Read new srom */
+        int i, j=0;
 	u_short tmp, *p = (short *)((char *)&lp->srom + SROM_HWADD);
 	for (i=0; i<(ETH_ALEN>>1); i++) {
 	    tmp = srom_rd(aprom_addr, (SROM_HWADD>>1) + i);
@@ -4064,7 +4154,7 @@
 	    j += *p++;
 	}
 	if ((j == 0) || (j == 0x2fffd)) {
-	    return;
+	    return(status);
 	}
 
 	p=(short *)&lp->srom;
@@ -4072,10 +4162,11 @@
 	    tmp = srom_rd(aprom_addr, i);
 	    *p++ = le16_to_cpu(tmp);
 	}
+	status=1;                      /* success */
 	de4x5_dbg_srom((struct de4x5_srom *)&lp->srom);
     }
     
-    return;
+    return(status);
 }
 
 /*
@@ -4282,7 +4373,7 @@
 		dev->irq = last.irq;
 	    }
 
-	    status = 0;
+	    status = 1;
 	}
     } else if (!status) {
 	last.chipset = lp->chipset;
@@ -5785,28 +5876,40 @@
 ** IRQ lines will not be auto-detected; instead I'll rely on the BIOSes
 ** to "do the right thing".
 */
-#define LP(a) ((struct de4x5_private *)(a))
+/* #define LP(a) ((struct de4x5_private *)(a)) */
 static struct net_device *mdev = NULL;
-static int io=0x0;/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+/* EDIT THIS LINE FOR YOUR CONFIGURATION IF NEEDED        */
+static int io=0x0, io1=0x0, io2=0x0, io3=0x0, zeroconst=0;
+static int *giolist[]={&io, &io1, &io2, &io3, &zeroconst};
 MODULE_PARM(io, "i");
+MODULE_PARM(io1, "i");
+MODULE_PARM(io2, "i");
+MODULE_PARM(io3, "i");
 MODULE_PARM_DESC(io, "de4x5 I/O base address");
+MODULE_PARM_DESC(io1, "de4x5 I/O base address");
+MODULE_PARM_DESC(io2, "de4x5 I/O base address");
+MODULE_PARM_DESC(io3, "de4x5 I/O base address");
 
 int
 init_module(void)
 {
-    int i, num, status = -EIO;
+    int i, num, status = -EIO, xstat=0;
     struct net_device *p;
+    u_long net_io=0;
 
-    num = count_adapters();
+    for(num=0; *giolist[num]; num++);
+    if(!num) num = 32; /* autoprobe */
 
-    for (i=0; i<num; i++) {
-	if ((p = insert_device(NULL, io, de4x5_probe)) == NULL) 
+    for (i=0; i<num && (*giolist[0] || !xstat); i++) {
+        if(*giolist[0]) net_io=*giolist[i];
+	if ((p = insert_device(NULL, net_io, de4x5_probe)) == NULL) 
 	    return -ENOMEM;
 
 	if (!mdev) mdev = p;
 
-	if (register_netdev(p) != 0) {
+	if ((xstat=register_netdev(p)) != 0) {
 	    struct de4x5_private *lp = (struct de4x5_private *)p->priv;
+	    if (status && xstat) status=xstat;
 	    if (lp) {
 		release_region(p->base_addr, (lp->bus == PCI ? 
 					      DE4X5_PCI_TOTAL_SIZE :
@@ -5826,6 +5929,8 @@
 	}
     }
 
+    if(de4x5_debug & DEBUG_PCICFG) 
+      printk("init_module: adapters searched=%d xstat=%d\n",i,xstat);
     return status;
 }
 
@@ -5861,33 +5966,6 @@
     kfree(p);                               /* Free the device structure */
     
     return next;
-}
-
-static int
-count_adapters(void)
-{
-    int i, j=0;
-    u_short vendor;
-    u_int class = DE4X5_CLASS_CODE;
-    u_int device;
-
-#if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
-    char name[DE4X5_STRLEN];
-    u_long iobase = 0x1000;
-
-    for (i=1; i<MAX_EISA_SLOTS; i++, iobase+=EISA_SLOT_INC) {
-	if (EISA_signature(name, EISA_ID)) j++;
-    }
-#endif
-    if (!pcibios_present()) return j;
-
-    for (i=0; (pdev=pci_find_class(class, pdev))!= NULL; i++) {
-	vendor = pdev->vendor;
-	device = pdev->device << 8;
-	if (is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x) j++;
-    }
-
-    return j;
 }
 
 /*
