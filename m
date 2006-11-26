Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935443AbWKZRCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935443AbWKZRCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935446AbWKZRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 12:02:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42123 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935443AbWKZRCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 12:02:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=D/BTd31ER2/BMzupXaS7oz74qCwzZibFKbNj7TW7D/X+JPlkm6Pw61boA37eWrAAVGkvyP3nlDQFu79drXHTSu0TYz8rBbEFJlEe2mUV8SkHxIRJz9j5ivtPPPCjMny0KZfLbEPv8daZuCKa3fhWLvPNqqOIjoUnRu/xEFLc1Q8=
Date: Sun, 26 Nov 2006 19:01:49 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       kronos.it@gmail.com
Subject: pata_ali: troubles with interrupt
Message-ID: <20061126180149.GA10986@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a "hamlet xsataci" card[1], which is basically a PCI card with
both an Ali M5228 PATA controller and a M5281 SATA controller:

05:02.0 Mass storage controller: ALi Corporation ALi M5281 Serial ATA / RAID Host Controller (rev a4)
05:02.1 Mass storage controller: ALi Corporation M5228 ALi ATA/RAID Controller (rev c6)

I'm using kernel 2.6.19-rc6 (current git, pulled few hours ago) SMP
(dual core CPU) and PREEMP enabled; PCI_MULTITHREAD_PROBE is disabled.
alim15x3 works (almost) fine:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:05:02.1
ACPI: PCI Interrupt 0000:05:02.1[A] -> GSI 23 (level, low) -> IRQ 18
ALI15X3: chipset revision 198
ALI15X3: 100% native mode on irq 18
    ide0: BM-DMA at 0xc080-0xc087, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc088-0xc08f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: Maxtor 6Y120L0, ATA DISK drive
hdd: QUANTUM FIREBALLlct10 10, ATA DISK drive
ide1 at 0xc480-0xc487,0xc402 on irq 18
hdc: max request size: 128KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 > hdc3
hdd: max request size: 128KiB
hdd: 20044080 sectors (10262 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
hdd: cache flushes not supported
 hdd: hdd1 hdd2

only problem is that hdd supports UDMA66 but it's configured as UDMA33.

sata_uli handles the SATA part of the board fine (nothing connected ATM,
but I plan to use the external port).

pata_ali doesn't work for this board though:

sata_uli 0000:05:02.0: version 1.0
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 23 (level, low) -> IRQ 18
ata11: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB480 irq 18
ata12: SATA max UDMA/133 cmd 0xB880 ctl 0xB802 bmdma 0xB488 irq 18
scsi10 : sata_uli
ata11: SATA link down (SStatus 0 SControl 310)
scsi11 : sata_uli
ata12: SATA link down (SStatus 0 SControl 310)
ACPI: PCI Interrupt 0000:05:02.1[A] -> GSI 23 (level, low) -> IRQ 18
ata13: PATA max UDMA/133 cmd 0xC880 ctl 0xC802 bmdma 0xC080 irq 18
ata14: PATA max UDMA/133 cmd 0xC480 ctl 0xC402 bmdma 0xC088 irq 18
scsi12 : pata_ali
irq 18: nobody cared (try booting with the "irqpoll" option)
 [<b0103ec3>] dump_trace+0x69/0x1af
 [<b0104021>] show_trace_log_lvl+0x18/0x2c
 [<b01046d8>] show_trace+0xf/0x11
 [<b0104788>] dump_stack+0x15/0x17
 [<b0143e8a>] __report_bad_irq+0x36/0x7d
 [<b0144070>] note_interrupt+0x19f/0x1db
 [<b01445a6>] handle_fasteoi_irq+0x86/0xa7
 [<b0105ab3>] do_IRQ+0xd9/0x112
 =======================
handlers:
[<b02552b1>] (ata_interrupt+0x0/0x178)
[<b02552b1>] (ata_interrupt+0x0/0x178)
Disabling IRQ #18
ata13: port is slow to respond, please be patient (Status 0xff)
ata13: port failed to respond (30 secs, Status 0xff)
ata13: SRST failed (status 0xFF)
ata13: SRST failed (err_mask=0x100)
ata13: softreset failed, retrying in 5 secs
ata13: SRST failed (status 0xFF)
ata13: SRST failed (err_mask=0x100)
ata13: softreset failed, retrying in 5 secs
ata13: SRST failed (status 0xFF)
ata13: SRST failed (err_mask=0x100)
ata13: reset failed, giving up
scsi13 : pata_ali
ata14.00: qc timeout (cmd 0xec)
ata14.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata14.00: qc timeout (cmd 0xec)
ata14.00: failed to IDENTIFY (I/O error, err_mask=0x4)

I also tried booting without sata_uli but I still get the same screaming
interrupt.
Note that the card has only one PATA channel (and 2 SATA ports).

/proc/ide/ali:
                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 0.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  No                                Yes
Channel state:        busy                              OK            
Add. Setup Timing:    8T                                1T
Command Act. Count:   8T                                3T
Command Rec. Count:   16T                               1T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              Yes               Yes              Yes
FIFO threshold:    4 Words          4 Words           8 Words          8 Words
FIFO mode:        FIFO Off         FIFO Off          FIFO On          FIFO On 
Dt RW act. Cnt     8T               8T                3T               3T
Dt RW rec. Cnt    16T              16T                1T               1T

-----------------------------------UDMA Timings--------------------------------

UDMA:             No               No                OK               OK
UDMA timings:     3.5T             3.5T                4T             2.5T


lspci -vvvxxx:

05:02.0 Mass storage controller: ALi Corporation ALi M5281 Serial ATA / RAID Host Controller (rev a4) (prog-if 85)
	Subsystem: ALi Corporation ALi M5281 Serial ATA / RAID Host Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128, cache line size 80
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at bc00 [size=4]
	Region 2: I/O ports at b880 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at b480 [size=16]
	Expansion ROM at dfe00000 [disabled] [size=64K]
00: b9 10 81 52 05 00 a0 02 a4 85 80 01 80 80 80 00
10: 01 c0 00 00 01 bc 00 00 81 b8 00 00 01 b8 00 00
20: 81 b4 00 00 00 00 00 00 00 00 00 00 b9 10 81 52
30: 00 00 7f ff 00 00 00 00 00 00 00 00 0e 01 00 00
40: 80 88 08 0f 00 00 55 b1 0a 00 b1 0e 68 00 68 00
50: 01 00 02 00 00 00 00 00 00 00 00 00 09 bc 44 00
60: 00 00 00 00 00 00 00 00 10 03 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 09 00 44 00
c0: 00 00 00 00 00 00 00 00 10 03 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

05:02.1 Mass storage controller: ALi Corporation M5228 ALi ATA/RAID Controller (rev c6) (prog-if 85)
	Subsystem: ALi Corporation: Unknown device 5281
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c880 [size=8]
	Region 1: I/O ports at c800 [size=4]
	Region 2: I/O ports at c480 [size=8]
	Region 3: I/O ports at c400 [size=4]
	Region 4: I/O ports at c080 [size=16]
00: b9 10 28 52 05 00 a0 02 c6 85 80 01 00 80 80 00
10: 81 c8 00 00 01 c8 00 00 81 c4 00 00 01 c4 00 00
20: 81 c0 00 00 00 00 00 00 a0 00 00 00 b9 10 81 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00
40: 00 00 00 7f 00 00 00 00 00 10 64 c9 00 00 ba 1a
50: 00 00 00 81 00 55 44 ad 00 00 00 00 01 31 31 31
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Luca
[1] http://www.hamletcom.com/ProductDetails.aspx?ProductId=3483
-- 
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook
