Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271666AbRIHRIi>; Sat, 8 Sep 2001 13:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRIHRI3>; Sat, 8 Sep 2001 13:08:29 -0400
Received: from serifos.unige.ch ([129.194.49.75]:25359 "EHLO serifos.unige.ch")
	by vger.kernel.org with ESMTP id <S271666AbRIHRIT>;
	Sat, 8 Sep 2001 13:08:19 -0400
Date: Sat, 8 Sep 2001 19:01:33 +0200
From: Brunet Eric <Eric.Brunet@physics.unige.ch>
To: linux-kernel@vger.kernel.org
Subject: Two bugs: PCMCIA doesn't work and bad DMA/APM interaction
Message-ID: <20010908190133.B5716@serifos.unige.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I would like to report two problems I have with my laptop (clevo computer 660)

The first problem concerns the PCMCIA support and the second problem a
weird interaction between the APM and DMA.

All the tests have been made with three different kernels
	the 2.2.16-22 as shipped with redhat 7.0
	the 2.4.2-2 as shipped with redhat 7.1
	the 2.4.10-pre4 compiled myself

FIRST PROBLEM
==============

Short description:

The PCMCIA support works flawlessly with the 2.2.16 kernel. With the
2.4.2 kernel, the hardware is detected but doesn't work, with the 2.4.10
kernel the hardware is not detected.

Full description:

For the three kernels, I reproduce the messages given by the kernel when
I insmod the pcmcia modules:

With kernel 2.2.16

insmod pcmcia_core
   | Linux PCMCIA Card Services 3.1.19
   |   kernel build: 2.2.16-22 #1 Tue Aug 22 16:49:06 EDT 2000
   |   options:  [pci] [cardbus] [apm]
   | PCI routing table version 1.0 at 0xfe840
insmod i82365
   | Intel PCIC probe:
   |   TI 1250A rev 02 PCI-to-CardBus at slot 00:03, mem 0x68000000
   |     host opts [0]: [ring] [isa irq] [pci irq 11] [lat 168/176] [bus 32/34]
   |     host opts [1]: [ring] [isa irq] [pci irq 11] [lat 168/176] [bus 35/37]
   |     ISA irqs (scanned) = 3,4,7,9,10 PCI status changes

My xircom ethernet card is then recognized, and works.


With kernel 2.4.2

insmod pcmcia_core
   | Linux PCMCIA Card Services 3.1.22
   |   options:  [pci] [cardbus] [pm]
insmod i82365
   | Intel PCIC probe:
   |   Intel i82365sl DF ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
   |     host opts [0]: none
   |     host opts [1]: none
   |     ISA irqs (scanned) = 3,4,7,9,10 polling interval = 1000 ms

My xircom ethernet card is then recognized, but doesn't work. More
precisely, the computer hangs completely if the usb modules are loaded as
soon as there is some traffic on the network. If the usb modules are not
loaded, the computer does not hang but the network does not work.
(According to the /proc/interrupts given below, the usb and pcmcia
hardware share the same interrupt.)

With kernel 2.4.10-pre4

insmod pcmcia_core
   | Linux PCMCIA Card Services 3.1.22
   |   options:  [pci] [cardbus] [pm]
insmod i82365
   | Intel PCIC probe: not found.

(insmod's output is:
/lib/modules/2.4.10-pre4/kernel/drivers/pcmcia/i82365.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
)

Then, of course, no pcmcia card can work.

Relevant data, obtained from the 2.2.16 kernel:

/proc/interrupts:
=================
           CPU0       
  0:     266803          XT-PIC  timer
  1:       7568          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      34336          XT-PIC  xirc2ps_cs
  5:       2616          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
 11:          4          XT-PIC  usb-uhci, i82365
 12:       5591          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:      16116          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0

/proc/ioports:
==============
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : soundblaster
02f8-02ff : serial(auto)
0310-031f : xirc2ps_cs
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
3000-3007 : ide0
3008-300f : ide1
f300-f313 : usb-uhci

relevant part of /proc/pci:
===========================
  Bus  0, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1250 (rev 2).
      Medium devsel.  IRQ 11.  Master Capable.  Latency=168.  Min Gnt=192.Max Lat=7.
  Bus  0, device   3, function  1:
    CardBus bridge: Texas Instruments PCI1250 (rev 2).
      Medium devsel.  IRQ 11.  Master Capable.  Latency=168.  Min Gnt=192.Max Lat=7.


Is there anything I could do to have pcmcia working with a 2.4 kernel,
or should I stick to a 2.2 ?

SECOND PROBLEM
==============

Short description:

DMA transfers from the hard disk work very well after a fresh boot, but
make the computer hang after a suspend to ram/resume cycle.

Long description:

On my laptop, the hard disk as a throughput of 6.3 MB/sec if DMA is
disabled, and 12.9 MB/sec if DMA is enabled (dixit hdparm). Thus, I
prefer using DMA, and it works very well, with all the kernels.

However, if I suspend the laptop and resume it to operation, I can only
use the hard disk without DMA. (My apmd scripts disable dma before
suspend, and don't reenable it after resume.) If I try to reenable dma
transfers using hdparm, then, on the first acces to the disk, the
computer hangs, the led of the hard disk turns solid, and, after a
couple of seconds, I get the message:

hda: timeout waiting for dma
ide_dmaproc: chipset supported ide_dma_imeout func only : 14

(second line only with a 2.4 kernel)

Then I have to hit the on/off button.

I presume that the state of the hard drive controller is changed during
the suspend/resume and that I could put it back to its previous state
using the -p and -X switches of hdparm, but I dont understand well the
relevant sections of the hdparm manpage and I don't know how to read the
actual settings that -p and -X can change. For information:

hdparm -i /dev/hda:
===================
 Model=TOSHIBA MK6014MAP, FwRev=N2.11 F, SerialNo=20S15274T
 Config={ Fixed }
 RawCHS=12416/15/63, TrkSize=0, SectSize=0, ECCbytes=46
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=12416/15/63, CurSects=142606515, LBA=yes, LBAsects=11733120
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

hdparm /dev/hda:
================
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 776/240/63, sectors = 11733120, start = 0

Is there a way I can use DMA transfers after a suspend/resume ?


Thank you for any help you could give me,

	Éric Brunet
