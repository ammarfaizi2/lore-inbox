Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUDNXGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDNXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:04:15 -0400
Received: from smtp.rol.ru ([194.67.21.9]:867 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S262019AbUDNWe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:34:29 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 02:36:05 +0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VzbfAk99aso2U9c"
Message-Id: <200404150236.05894.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VzbfAk99aso2U9c
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I recently got a new sata disk and must say that it's performace is totally 
unacceptable, on both siimage and sata_sil drivers. DMA is turned on.

More details: MB is EPoX 8k9a2+, KT400 chipset, it has embedded Sil3112a SATA 
controller. HDD is WD740GD (10k RPM, 8MB cache), also tried WD360GD, got 
absolutely the same results. Tried lots of different 2.6 kernels: 2.6.4-ck1, 
-ck2, -wolk2.3 and 2.6.5 vanilla and -mm5. No difference. Tried to 
enable/disable APIC and ACPI and even removed all hardware sharing the same 
IRQ. Nothing changed. Transfer speed was measured using hdparm -Tt. Results 
for siimage driver:

/dev/hde:
 Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
 Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec

for sata_sil:

/dev/sda:
 Timing buffer-cache reads:   1412 MB in  2.00 seconds = 705.05 MB/sec
 Timing buffered disk reads:   84 MB in  3.06 seconds =  27.43 MB/sec

So my old IDE HDD appears to be considerably faster. Expected results were 
55-70MB/s.

Playing with hdparm gives nothing (-d1 -u1 -c1 -X70 -m16 gives +3MB/s 
'boost').

hdparm -i:

 Model=WDC WD740GD-00FLA0, FwRev=21.08U21, SerialNo=WD-WMAKE1059828
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=off
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=145226112
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:

lspci -vvv output is attached.

dmesg for siimage:

SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0f.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 185
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: WDC WD740GD-00FLA0, ATA DISK drive
ide2 at 0xf99bb080-0xf99bb087,0xf99bb08a on irq 185
hde: max request size: 64KiB
hde: 145226112 sectors (74355 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(133)
 hde: unknown partition table

dmesg for libata:

libata version 1.02 loaded.
sata_sil version 0.54
PCI: Found IRQ 12 for device 0000:00:0f.0
PCI: Sharing IRQ 12 with 0000:00:0a.0
PCI: Sharing IRQ 12 with 0000:00:10.2
ata1: SATA max UDMA/100 cmd 0xF99B3080 ctl 0xF99B308A bmdma 0xF99B3000 irq 12
ata2: SATA max UDMA/100 cmd 0xF99B30C0 ctl 0xF99B30CA bmdma 0xF99B3008 irq 12
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 145226112 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata2: thread exiting
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 32MB (lba48)
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write through
 sda:<6>USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 5 for device 0000:00:10.0
PCI: Sharing IRQ 5 with 0000:00:12.0

(IRQ's are different because first run was with ACPI used for IRQ routing, and 
second was with 'acpi=off noapic')

I'm really eager to find a solution for this problem. 

Thanks
-- 
/KoS
* Did you receive a proper socialist education?			      

--Boundary-00=_VzbfAk99aso2U9c
Content-Type: application/x-gzip;
  name="lspci.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci.txt.gz"

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
AAA=

--Boundary-00=_VzbfAk99aso2U9c--
