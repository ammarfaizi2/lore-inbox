Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282793AbRLOQjO>; Sat, 15 Dec 2001 11:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282812AbRLOQjE>; Sat, 15 Dec 2001 11:39:04 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:55241 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S282793AbRLOQiz>; Sat, 15 Dec 2001 11:38:55 -0500
Date: Sat, 15 Dec 2001 16:38:45 +0000
From: Adam Sampson <azz@gnu.org>
To: linux-kernel@vger.kernel.org
Cc: ben@spod.cx
Subject: cdrecord/ide-scsi fails randomly on later 2.4 kernels
Message-ID: <20011215163845.A13340@cartman.azz.us-lot.org>
Mail-Followup-To: Adam Sampson <azz@gnu.org>,
	linux-kernel@vger.kernel.org, ben@spod.cx
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Homepage: http://azz.us-lot.org/
X-Message: You appear to be using Outlook. Or Yahoo! Mail.
X-Planation: RSA in 2 lines Perl: see http://dcs.ex.ac.uk/~aba/x.html
X-Munition-Export: print pack"C*",split/\D+/,`echo "16iII*o\U@{$/=$z;[(pop,pop,unpack"H*",<>)]}\EsMsKsN0[lN*1lK[d2%Sa2/d0<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<J]dsJxp"|dc`
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya.

We've been having problems on a couple of machines here (with somewhat
different hardware configurations, although they've both got IDE CD writers and
multiple IDE hard disks) with cdrecord failing on later 2.4-series kernels.
Both are running 2.4.16, although we've seen the same problems on other recent
kernels.

The error typically looks like this, although we've had variations on it in the
past:

cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 02 77 24 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 03 00 00 00 00 0A 00 00 00 00 0C 09 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x09 (write error - loss of streaming) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 5.551s timeout 40s

On one machine, I was able to fix this by altering the plug-and-play IRQ
allocation rules in the BIOS settings; it now appears to work reliably, whereas
previously CD writing failed approximately half the time. IRQ 5 was originally
shared with bttv, btaudio and eth0 when writes were failing; it's now only used
by the IDE controller (and bttv, btaudio and eth0 are using IRQ 9).

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller on PCI bus 00 dev 40
PCI: Found IRQ 5 for device 00:08.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xe9000000
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:pio, hdh:pio
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Assigned IRQ 5 for device 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-305030, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
hdd: Maxtor 91080D5, ATA DISK drive
hde: IBM-DPTA-372050, ATA DISK drive
hdg: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd000-0xd007,0xd402 on irq 5
ide3 at 0xd800-0xd807,0xdc02 on irq 5

On the other, cdrecord worked reliably on 2.4.7; an upgrade to 2.4.10 caused CD
writing to fail as described above; upgrading to 2.4.16 appeared to cure it
again until we added a new hard disk, hdd. (I suspect there might have been two
different problems here...)

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hdc: TDK CDRW241040X, ATAPI CD/DVD-ROM drive
hdd: Maxtor 4G120J6, ATA DISK drive
hde: IBM-DTLA-307060, ATA DISK drive
hdf: IBM-DTLA-307060, ATA DISK drive
hdg: Maxtor 54098U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11

We shuffled hard disks around again (removing hdh and putting hdd in its
place), and it appears to work with this config:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:DMA
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hdc: TDK CDRW241040X, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307060, ATA DISK drive
hdf: IBM-DTLA-307060, ATA DISK drive
hdh: Maxtor 4G120J6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11

/proc/interrupts on this machine:

           CPU0       CPU1       
  0:      72586      58070    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 10:          0          0   IO-APIC-level  usb-uhci, usb-uhci
 11:       7498       7622   IO-APIC-level  ide2, ide3
 12:      10608      10870   IO-APIC-level  eth0
 14:       3853       3862    IO-APIC-edge  ide0
 15:       8121       8385    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     130569     130567 
ERR:          0
MIS:          0

Further information available on request; while we've fixed the problem for
now, it would certainly be nice to know why it's doing it...

Thanks very much,

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
