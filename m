Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287163AbSAZWil>; Sat, 26 Jan 2002 17:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSAZWi0>; Sat, 26 Jan 2002 17:38:26 -0500
Received: from pc-80-192-228-3-mo.blueyonder.co.uk ([80.192.228.3]:13031 "HELO
	gate.mcdee.net") by vger.kernel.org with SMTP id <S287163AbSAZWiO>;
	Sat, 26 Jan 2002 17:38:14 -0500
Subject: IO Throughput Problem with 2.5.2-dj6 and HPT370 RAID Controller
From: Jim McDonald <Jim@mcdee.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 26 Jan 2002 22:37:04 +0000
Message-Id: <1012084624.1504.216.camel@lapcat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm seeing some strange disk throughput results with the latest
kernel.

   My system is as follows:  Athlon 1.2GHz on Abit KT7A-RAID
motherboard, 256MB memory, 4xhdd (hda, hdc, hde, hdg)

   hde and hdg are my test disks, they are master devices on the primary
and secondary ATA-100 IDE channels backed by the Promise RAID controller
(HighPoint 370).  There are no slave devices on these channels.  The
drives are both Maxtor 4D060H3 60GB drives.  There is no RAID device set
up on the controller, it is just there for the dedicated high-speede
channels.

   I did some basic tests to look at throughput of the disks by timing
'dd' reading 1GB (or 1000MB if you're being picky) off the drives, first
one at a time and then both of them at the same time.

The results that I got for a stock 2.4.17 kernel seem reasonable:

dd if=/dev/hde of=/dev/null bs=1024k count=1000
29 seconds

dd if=/dev/hdg of=/dev/null bs=1024k count=1000
29 seconds

dd if=/dev/hde of=/dev/null bs=1024k count=1000
dd if=/dev/hdg of=/dev/null bs=1024k count=1000
34 seconds

However, when I tried this with the 2.5.2-dj6 kernel I got some very
strange results:

dd if=/dev/hde of=/dev/null bs=1024k count=1000
45 seconds

dd if=/dev/hdg of=/dev/null bs=1024k count=1000
45 seconds

dd if=/dev/hde of=/dev/null bs=1024k count=1000
dd if=/dev/hdg of=/dev/null bs=1024k count=1000
30 seconds

Which shows a couple of things: first, that the single-drive performance
of 2.5.2-dj6 seems to be really low, and second that running both disks
at the same time results in each disk itself transferring data faster
than when they were running alone!

I've had a look in userspace and the two disks look like separate
devices.  I also extended DK_MAX_MAJOR to get statistics on the two
devices and the resultant output from /proc/stat looks good, too.  I'm
pretty sure that the system is not looking at the same drive twice adn
getting benefits of buffering.

The only thing of any interest that I can spot from the process table is
that when only running 1 dd kswapd hangs out at around 1% CPU, running a
second makes it jump to 10-15%

   Running 1 dd on /dev/hde and 1 dd on /dev/hdc (same motherboard,
on-board non-RAID IDE) gives similar relative results between 2.4.17 and
2.5.2-dj6, although the performance of /dev/hde on 2.5.2-dj6 was still
down at the 45-second transfer speed.

   Running 1 dd on /dev/hda and 1 dd on /dev/hdc comes out the same on
2.4.17 and 2.5.2-dj6

   Can anyone else give this a shot and see if they are getting similar
results, or any pointers on where I might look to see what is going on
here?  I'm pretty lost as to where this might be, the only thing I could
think of was that ATARAID code, but I removed that from the kernel and
got the same results.  At current the ataraid code is broken in 2.5 -
I'll have a go at getting it working, but if someone else has already
done it I'd love to hear from them.

Other miscellaneous stuff:

hdparm shows all drives have dma enabled
nothing in dmesg to suggest problems

Boot log from 2.4.17:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:09.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 92732U8, ATA DISK drive
hdb: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdc: Maxtor 4D040H2, ATA DISK drive
hde: Maxtor 4D060H3, ATA DISK drive
hdg: Maxtor 4D060H3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11
hda: 53369568 sectors (27325 MB) w/2048KiB Cache, CHS=3322/255/63, UDMA(66)
hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
hde: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/16/63, UDMA(100)
hdg: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/16/63, UDMA(100)

Boot log from 2.5.2-dj6:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI slot 00:13.0
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:09.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 92732U8, ATA DISK drive
hdb: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdc: Maxtor 4D040H2, ATA DISK drive
hde: Maxtor 4D060H3, ATA DISK drive
hdg: Maxtor 4D060H3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11
blk: queue c0413d44, I/O limit 4095Mb (mask 0xffffffff)
hda: 53369568 sectors (27325 MB) w/2048KiB Cache, CHS=3322/255/63, UDMA(66)
blk: queue c0414104, I/O limit 4095Mb (mask 0xffffffff)
hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
blk: queue c04144c4, I/O limit 4095Mb (mask 0xffffffff)
hde: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/255/63, UDMA(100)
blk: queue c0414884, I/O limit 4095Mb (mask 0xffffffff)
hdg: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/255/63, UDMA(100) 


Cheers,
Jim.
-- 
Jim McDonald - Jim@mcdee.net


