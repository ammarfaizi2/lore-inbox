Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTECOw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTECOw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:52:56 -0400
Received: from [217.157.19.70] ([217.157.19.70]:50952 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S263272AbTECOww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:52:52 -0400
Date: Sat, 3 May 2003 17:05:15 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: arjanv@redhat.com, <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: SiI 3112+Medley Software RAID (in 2.4.21-rc1-ac3), some info and
 bugs
Message-ID: <Pine.LNX.4.40.0305031552250.17709-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan and Andre,

I have the Asus A7N8X Deluxe motherboard with the SiI 3112 SATA
controller.

I noticed the latest -ac patch includes your driver for SiI's Medley
software raid and decided to give it a try (I am using the SiI RAID for
Windows XP and running Linux on a separate disk on the Nvidia IDE
controller). I have founds some problems with both the RAID driver and
possibly with the SiI driver itself as well.

I have two Maxtor 80GB disks (the DiamondMax Plus variety with 7200RPM and
8MB cache) connected to the 3112 using Abit's Serillel SATA->PATA
converters. They are configured as a striped set (RAID0). It works like a
dream in Windows (>80MB/second sustained transfer rate with less than 20%
CPU utilisation according to HDTach (on an Athlon XP3000+)).

This is the disk info from hdparm -i (identical for both drives except
the serial number of course), and /proc/ide/hde/capacity and gemoetry:

 Model=Maxtor 6Y080P0, FwRev=YAR41BW0, SerialNo=Y2V4VL2E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive Supports : ataATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 ATA-7

$ cat /proc/ide/hde/geometry
physical     158816/16/63
logical      9964/255/63
$ cat /proc/ide/hde/capacity
160086528

At first your driver failed to find the striped set:

Guestimating sector 160086527 for superblock
Guestimating sector 160086527 for superblock
driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid array found

I thought at first it might be because it was looking in the wrong sector
for the Medley superblock, so I looked in the last 1000 sectors and found
that the superblock was mirrored twice there, with two identical copies,
and the second copy was at the very last sector (the other copy is where
you looked for it but I wasn't sure so I hacked your driver to look in the
last sector instead). (In any case it might make sense to load both and
check if they both match, as a check to whether the information can be
relied upon).

It also doesn't have the magic word you are looking for so I changed it to
look for ascii "2Y" at offset 0x14 and 0x15 (this is the first two letters
of the serial number of both disks, but byte swapped - the serial numbers
are Y2V4VL2E for the first disk and Y2V4VKJE for the second, but they
appear to be byte swapped in the SiI superblock because they appear as
2Y4VLVE2 and 2Y4VKVEJ, respectively.

In any case it might be an idea to look for the disk serial number at this
position as a check whether this is a valid SiI RAID set (it would be
quite unlikely to have the byte swapped serial number there by chance
and I don't think anyone would think of putting a disk that is so old it
doesn't support serial numbers in a RAID ;-)), if it is there for all
versions of SiI RAID.

After I made these changes it managed to detect my striped set:

Guestimating sector 160086527 for superblock
Guestimating sector 160086527 for superblock
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 < ataraid/d0p5 ataraid/d0p6 ataraid/d0p7 ataraid/d0p8 >
Drive 0 is 78167 Mb (33 / 0)
Drive 1 is 78167 Mb (34 / 0)
Raid0 array consists of 2 drives.

Now I noticed something curious - it appears you try to check if the RAID
device is itself part of a raid because after this I get:

Guestimating sector 39876479 for superblock

This is probably not what we want and it should probably check if the
device has an ATARAID major number and skip it if it does.

Anyway, I could now mount my VFAT drives on /dev/ataraid/d0pX, and it
mounted them succesfully (in read only mode since I have no death wish
;-). I could also list all the files on my "transfer" drive and correctly
copy a 4MB test file (that I copied to the FAT drive using Windows) off
the RAID set.

However when I tried to copy a larger file (about 2GB), the cp process
seemed to hang after a few seconds, and the whole system was almost frozen
(it was like all disk IO was locked up), but it was still working although
amazingly slowly and a kill -9 from another window managed to kill the cp
process after several minutes, at which point it had copied almost 1GB
(but using almost all system resources meanwhile).

Another time I tried it (from a console without X running), it didn't hang
the rest of the system but the cp process was hanging after 49MB and
nothing more happened until it was killed -9.

When DMA was enabled on the SiI controller the whole system crashed
instead (completely frozen) when I tried to copy the large file.

I don't know if this is beacuse of the RAID driver or the SiI SATA driver
itself. There are some subtle differences in how requests are made to SATA
devices, how command queueing etc. is done, and so it could be related to
that. Also it could be related to the fact that the 3112 shares its IRQ
with a lot of devices:

 11:     348177          XT-PIC  ide2, ide3, eth0, NVIDIA nForce Audio, usb-ohci

(where ide2 and ide3 are the two channels on the SATA controller). I did
try it without the other drivers loaded, and it did seem to work better
although it was still very slow, <1MB/second, but this could have been
random.

Anyway I don't know enough about SATA to make a qualified guess here and
unfortunately don't have time to investigate and debug this extensively
right now. But intuitively it seems that maybe the problem is caused by
the two disks both working intensively at the same time.

I'll be happy to help in any way with more information or trying
something, please mail me.

To help reverse engineer the Medley superblock I've appended the
superblocks from my harddisks here. As I said there are two copies of the
superblock, one was found at sector 160085503 and the other at 160086527
(the very last sector) on both disks, and they are both identical, don't
know which one is best to use.

/dev/hde (first SATA channel, first RAID0 drive):

00000000  40 00 ff 3f 37 c8 10 00  00 00 00 00 3f 00 00 00  |@..?7.......?...|
00000010  00 00 00 00 32 59 34 56  4c 56 45 32 20 20 20 20  |....2Y4VLVE2    |
00000020  20 20 20 20 20 20 20 20  03 00 00 3e 39 00 32 2e  |        ...>9.2.|
00000030  30 30 20 20 20 20 4d 61  78 74 6f 72 20 36 59 30  |00    Maxtor 6Y0|
00000040  38 30 50 30 00 00 00 00  00 00 00 00 00 00 00 00  |80P0............|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 10 80  |................|
00000060  00 00 00 2f 00 40 00 02  00 00 07 00 00 5c 15 13  |.../.@.......\..|
00000070  00 00 00 00 00 00 00 01  00 ba 8a 09 00 00 07 04  |................|
00000080  03 00 78 00 78 00 78 00  78 00 00 00 00 00 00 00  |..x.x.x.x.......|
00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000a0  fe 00 1e 00 6b 7c 09 7b  03 40 69 7c 01 3a 03 40  |....k|.{.@i|.:.@|
000000b0  7f 00 00 00 00 00 00 00  fe ff 0b 60 fe c0 00 00  |...........`....|
000000c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100  01 00 00 00 12 31 95 10  00 00 02 00 55 14 19 03  |.....1......U...|
00000110  04 03 20 00 00 00 00 00  02 00 ff ff 00 00 00 00  |.. .............|
00000120  00 00 00 00 01 00 00 00  01 00 00 00 00 00 00 00  |................|
00000130  00 00 00 00 00 00 00 00  00 00 00 00 00 00 0c 3b  |...............;|
00000140  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 a5 1f  |................|
00000200

/dev/hdg (second SATA channel, second RAID0 drive):

00000000  40 00 ff 3f 37 c8 10 00  00 00 00 00 3f 00 00 00  |@..?7.......?...|
00000010  00 00 00 00 32 59 34 56  4b 56 45 4a 20 20 20 20  |....2Y4VKVEJ    |
00000020  20 20 20 20 20 20 20 20  03 00 00 3e 39 00 32 2e  |        ...>9.2.|
00000030  30 30 20 20 20 20 4d 61  78 74 6f 72 20 36 59 30  |00    Maxtor 6Y0|
00000040  38 30 50 30 00 00 00 00  00 00 00 00 00 00 00 00  |80P0............|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 10 80  |................|
00000060  00 00 00 2f 00 40 00 02  00 00 07 00 00 5c 15 13  |.../.@.......\..|
00000070  00 00 00 00 00 00 00 01  00 ba 8a 09 00 00 07 04  |................|
00000080  03 00 78 00 78 00 78 00  78 00 00 00 00 00 00 00  |..x.x.x.x.......|
00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000a0  fe 00 1e 00 6b 7c 09 7b  03 40 69 7c 01 3a 03 40  |....k|.{.@i|.:.@|
000000b0  7f 00 00 00 00 00 00 00  fe ff 0b 60 fe c0 00 00  |...........`....|
000000c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100  01 00 00 00 12 31 95 10  00 00 02 00 55 14 19 03  |.....1......U...|
00000110  04 03 20 00 00 00 01 00  02 00 ff ff 00 00 00 00  |.. .............|
00000120  00 00 00 00 01 00 00 00  01 00 00 02 00 00 00 00  |................|
00000130  00 00 00 00 00 00 00 00  00 00 00 00 00 00 0c 21  |...............!|
00000140  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 a5 08  |................|
00000200

Please let me know if I can do anything to help.

Cheers,
Thomas

