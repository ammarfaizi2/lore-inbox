Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbQLUS4N>; Thu, 21 Dec 2000 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbQLUS4C>; Thu, 21 Dec 2000 13:56:02 -0500
Received: from ip165-250.fli-ykh.psinet.ne.jp ([210.129.165.250]:33475 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131380AbQLUSzw>;
	Thu, 21 Dec 2000 13:55:52 -0500
Message-ID: <3A424B0F.39E71E4F@yk.rim.or.jp>
Date: Fri, 22 Dec 2000 03:25:20 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE woes:linux and BIOS won't agree on C/H/S detection 
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE woes.

Sorry for this lengthy post, I read ide.txt, large-disk-howto.txt and
experimented with fdisk (DOS/WIN), dd, and a few other tricks,
but can't seem to be able to solve a question.

Big Question - 1:

I have a 20GB seagate ATA disk.
My Board BIOS recognizes the CHS geometry when it auto-detects the
disk as

        C/H/S=39694/16/63.

However, linux refuses to recognize this and tries to report

      C/H/S=2490/255/63.

This 2490/255/63 seems to get stuck after I tried partitioning
the disk using OLD 2.2.yy (probably 2.2.12?)
Debian GNU/Linux CD installer. (beta version of stormlinux CD
in fact.)

How can I get rid of this "unnatural" C/H/S information
so that linux boots with the geometry that BIOS uses.
This is necessary for me to make win98 co-exist with linux on this
disk. I tried a few commands :

       fdisk /mbr
        dd if=/dev/null of=/dev/hdaZ bs=512 count=1
        Run Seagate Disk Manager to partition the disk with
        motherboard BIOS C/H/S setting hopefully,

but no luck so far.

The boot command line parameter saved the day for now.
I added the following to the boot command line:
        hda=39694,16,63

But this is a little awkward since I tend to forget to add the
hda=39694,16,63 paramater to the command line when I make emergency
loadlin DOS disk, etc.

How can I "erase" this 2940/255/63 CHS setting from the disk so that
linux will use 39694/16/63 WITHOUT boot command line parameter?

The rest is the long background of hardware and
the history that led to the current problem.

Lengthy background and historical information.

OS version: uname -a
Linux duron 2.4.0-test12 #16 Thu Dec 21 03:07:26 JST 2000 i686 unknown
CPU: AMD K7 Duron 750 (100x7.5)

Motherboard: Gigabyte GA-7IXE4
Chipset : AMD 751 PCI/AGP controller
        + AMD 756 PCI IDE controller

BIOS AMI BIOS.
Disk in question: Seagate ST320423A 20GB ATA disk.
     This is the only IDE/ATA disk (on primary controller
     as a master device.
     I have an ATAPI CDROM on the secondary controller.)
     My main linux stays on a SCSI disk via Tekram SCSI controller.

Symptom:

I can't get linux to properly recognize the C/H/S with the hardware
combination above.  I would like to make win98 and linux co-exist on
this disk and the motherboard (MB) BIOS and linux not agreeing on this
is a disaster.

My Board BIOS recognizes the CHS geometry
when it auto-detects the disk as

        C/H/S=39694/16/63.

However, linux refuses to recognize this and tries to report

      C/H/S=2490/255/63.

(These numbers seemed to picked up by 2.2.yy installation I tried
on the disk earlier.)

Right now, I am forced to add

      ... hda=39694,16,63 ...

on the boot command line.

/usr/src/linux/Documentation/ide.txt states:

    Drives are normally found by auto-probing and/or examining the
    CMOS/BIOS data.  For really weird situations, the apparent (fdisk)
    geometry can also be specified on the kernel "command line" using
    LILO.  The format of such lines is:

            hdx=cyls,heads,sects,wpcom,irq
    or      hdx=cdrom


I am not sure why my hardware combo became weired, but something is
wrong here. I suspect that incorrect fdisk information left by 2.2.12
kernel tool might be the culprit, but can't pin point where the problem
lies and thus am posting this for experts' opinion.

What prompted me to think like this is the following history.

(1) The disk was originally used on a Gigabyte 586SG motherboard as a
secondary master device.  (586SG uses AWARD BIOS.)  I think it uses
VIA chip set.(I can dig up documentation if this proves important.)

On 586SG motherboard, Linux 2.4.0-testXX reported accetable
39693/16/63 (QUESTION: why 39693 is one less the number reported by
AMI BIOS? Oh well.)

The disk was formatted as a big Linux partition using Linux fdisk.
Since this was a big linux-only disk, I didn't have to worry about
this CHS mismatch with other OS.

The following is an excerpt from the /var/log/messages: the device hdc
is the disk in question.

>Nov 23 20:59:40 standard kernel: hda: 3419720 sectors (1751 MB)
 w/256KiB Cache, CHS=904/60/63, UDMA(33)
>Nov 23 20:59:40 standard kernel: hdc: 40011300 sectors (20486 MB)
 w/512KiB Cache, CHS=39693/16/63, UDMA(33)

(cf. The CPU on 586SG was AMD K6-III/400.  I had two IDE disks as the
log
above showed and one SCSI CDROM.)


(2) New motherboard: part-1.

Then the disk is moved onto Soyo SY-K7VTA motherboard with AMD K7
Duron 750 (the current CPU I use) and used there for two weeks.

Soyo SY-K7VTA uses VIA chipset (apollo KT133 + 686A) and uses AWARD
BIOS.  I put the seagate drive as the single IDE/ATA disk as primary
master device.  I put an ATAPI CDROM as secondary slave.

(Later on, I moved the main scsi disk where my linux 2.4.0-testXX is
stored to this motherboard. I could boot the 2.4.0-testXX using
loadlin floppy.)

(2-a) SOYO Motheboard. Initial attempt.

After digging up the old log, I found that the initially
all was well.

On this Soyo motherboard, the disk was recognized during the boot
process as below.  Since the linux kernel seemed to recognize the
"natural" C/H/S, I didn't seem to have much problem on this
motherboard even if I tried to partition the drive with multiple
partitions and tried to install DOS/win98 near the beginning of the
disk area. Initially, anyway.

I booted the Linux 2.4.0-testXX off the scsi disk using
loadlin from a boot disk.

This is the log : Please note the "CHS=39693/16/63" line. This seems
to be an OK number except that the later on I see 39694 as cylinder
number in AMI BIOS on the second new motherboard.

     Uniform Multi-Platform E-IDE driver Revision: 6.31
    Nov 24 13:21:45 standard kernel: ide: Assuming 33MHz system bus
speed
    for PIO modes; override with idebus=xx
    Nov 24 13:21:45 standard kernel: VP_IDE: IDE controller on PCI bus
00
    dev 39
    Nov 24 13:21:45 standard kernel: VP_IDE: chipset revision 16
    Nov 24 13:21:45 standard kernel: VP_IDE: not 100%% native mode: will

    probe irqs later
    Nov 24 13:21:45 standard kernel:     ide0: BM-DMA at 0xa000-0xa007,
BIOS
    settings: hda:DMA, hdb:pio
    Nov 24 13:21:45 standard kernel:     ide1: BM-DMA at 0xa008-0xa00f,
BIOS
    settings: hdc:DMA, hdd:pio
    Nov 24 13:21:45 standard kernel: hda: ST320423A, ATA DISK drive
    Nov 24 13:21:45 standard kernel: hdc: MATSHITA CR-583, ATAPI CDROM
drive

    Nov 24 13:21:45 standard kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

    Nov 24 13:21:45 standard kernel: ide1 at 0x170-0x177,0x376 on irq 15

    Nov 24 13:21:45 standard kernel: hda: 40011300 sectors (20486 MB)
    w/512KiB Cache, CHS=39693/16/63
    Nov 24 13:21:45 standard kernel: Partition check:
    Nov 24 13:21:45 standard kernel:  hda: hda1 hda2 hda4 < hda5 hda6
hda7
    hda8 >


So far, so good.

(2-b) Tried partitioning with 2.2.1? and fdisk.

I wanted to experimenting repartition the whole seagate disk into a
main linux partition, linux swap, and DOS/Win98 partition, etc.. While
playing with this using somewhat old Debian Gnu/Linux disk that had
2.2.yy on it, the incorrect C/H/S crept in.  (I think it was 2.2.12.
Ugh, very old.)

   What did I do here? Most likely simply re-partitioned the drive.
   But what tool did I use?
  It is the partition tool on the old 2.2.yy Debian
  GNU/linux CD. More specifically a beta Stormix Debian
  GNU/Linux CD I had: it came as an experimental CD with a
  Japanese UNIX magazine. My guess is that it simply calls
  fdisk or cfdisk.

=== Now the CHS reported is somewhat not bios/win98-friendly. ===

I rebooted the system using the 2.4.0-test11 on the scsi disk using
loadlin.

This is the log from such boot.:
Please note the "CHS=2490/255/63" near the end.
(This CHS info is problematic for DOS/Win98 co-existence since
BIOS reports 39694/16/63.)

    Dec  6 05:37:09 duron kernel: Linux version 2.4.0-test11
(root@duron)
    (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #11 Sun Dec 3
01:20:19
    JST 2000
         ...
    Dec  6 05:37:09 duron kernel: Kernel command line: root=/dev/sda6 ro

    sym53c8xx=mpar:n scsihosts=sym53c8xx:tmscsim
    Dec  6 05:37:09 duron kernel:  BOOT_IMAGE=240t11.i2c
         ...

    Dec  6 05:37:09 duron kernel: Uniform Multi-Platform E-IDE driver
    Revision: 6.31
    Dec  6 05:37:09 duron kernel: ide: Assuming 33MHz system bus speed
for
    PIO modes; override with idebus=xx
    Dec  6 05:37:09 duron kernel: VP_IDE: IDE controller on PCI bus 00
dev
    39
    Dec  6 05:37:09 duron kernel: VP_IDE: chipset revision 16
    Dec  6 05:37:09 duron kernel: VP_IDE: not 100%% native mode: will
probe
    irqs later
    Dec  6 05:37:09 duron kernel:     ide0: BM-DMA at 0xa000-0xa007,
BIOS
    settings: hda:DMA, hdb:pio
    Dec  6 05:37:09 duron kernel:     ide1: BM-DMA at 0xa008-0xa00f,
BIOS
    settings: hdc:DMA, hdd:pio
    Dec  6 05:37:09 duron kernel: hda: ST320423A, ATA DISK drive
    Dec  6 05:37:09 duron kernel: hdc: MATSHITA CR-583, ATAPI CDROM
drive
    Dec  6 05:37:09 duron kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    Dec  6 05:37:09 duron kernel: ide1 at 0x170-0x177,0x376 on irq 15
    Dec  6 05:37:09 duron kernel: hda: 40011300 sectors (20486 MB)
w/512KiB
    Cache, CHS=2490/255/63
    Dec  6 05:37:09 duron kernel: Partition check:
    Dec  6 05:37:09 duron kernel:  hda: hda1 hda2 hda4 < hda5 hda6 >

(3) CHS=2490/255/63 stuck?

Problem is that this 2490/255/63 stuck.

Once the CHS value came into use, re-partitioning was done
using this value on the linux side no matter what I tried..

>Dec  6 17:34:22 duron kernel: ide1 at 0x170-0x177,0x376 on irq 15
>Dec  6 17:34:22 duron kernel: hda: 40011300 sectors (20486 MB) w/512KiB

Cache, CHS=2490/255/63
>Dec  6 17:34:22 duron kernel: Partition check:
>Dec  6 17:34:22 duron kernel:  hda: hda1 hda2 hda4 < hda5 hda6 hda7
hda8 hda9 hda10 >
>Dec  6 17:34:22 duron kernel: Floppy drive(s): fd0 is 1.44M


Initially, I only had 2.2.yy kernel and a single DOS partition (which
was well below 2GB) on this seagate disk and I didn't have a practical
problem.  But once I tried to create larger partitions to store Win98
and linux together on this disk,
the discrepancy of

            CHS=39693/16/63  (presumably used by DOS [and win98?])

and

            CHS=2490/255/63  (linux)

became very annoying. The larger partitions later in the disk cause
the boundary mismatch(?) or some such messages. This is disturbing.

After the two weeks of usage with the Soyo motherboard, now
the disk has been moved to the current Gigabyte 7IXE4 motherboard.
The "unnatural" CHS still got stuck to the disk.
The BIOS now reports 39694/16/63.

(4) What I tried: boot line parameter, fdisk /mbr, dd, etc..

How can I clear this "incorrect"(?) CHS information?  When I boot
Linux, the boot command line parameter solved this as a bandaid
(hda=39694,16,63 ), but it is easy to forget this when I create an
emergency loadlin floppy, etc..

Linux recognizes 2490/255/63 no matter what the BIOS setting.
This naturally led me to think the information is on the
disk platter. I tried

  fdisk /mbr

from the DOS/Win. (This may not clear the whole 512bytes as explained
in the ide.txt and large-disk-howto doc.)  I also tried

  dd if=/dev/null of=/dev/hdaZ bs=512 count=1

But this didn't to seem to work.
(I am now not sure which value of Z I used. Maybe I should try simple
hda without Z?)

I even used the Seagate partition tool that could be used to partition
large disk from DOS (even on a machine without BIOS support for large
ATA disk).  The tool, called Disk manager happily partitioned (and
formated it very quickly!) the disk into 10 partitions (one
primary, 9 logical each less than the FAT16 2G limit.) This was done
after the BIOS setting of CHS=39694/16/63 was in place: actually
automatic recognition picked this value.

But even then the strange C/H/S recognition on the linux side stuck.
Hmm...

Example: After the disk manager partition:

If I don't specify hda=xxx on the boot command line, we still get
CHS=2940/255/63 on the linux side.

Dec 21 08:06:30 duron kernel: AMD7409: IDE controller on PCI bus 00 dev
39
Dec 21 08:06:30 duron kernel: AMD7409: chipset revision 7
Dec 21 08:06:30 duron kernel: AMD7409: not 100%% native mode: will probe

irqs later
Dec 21 08:06:30 duron kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Dec 21 08:06:30 duron kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Dec 21 08:06:30 duron kernel: hda: ST320423A, ATA DISK drive
Dec 21 08:06:30 duron kernel: hdc: MATSHITA CR-583, ATAPI CDROM drive
Dec 21 08:06:30 duron kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 21 08:06:30 duron kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 21 08:06:30 duron kernel: hda: 40011300 sectors (20486 MB) w/512KiB
Cache, CHS=2490/255/63
Dec 21 08:06:30 duron kernel: Partition check:
Dec 21 08:06:30 duron kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9

hda10 hda11 hda12 hda13 >

With "hda=..." command line parameter, Linux uses the desirable CHS
value.

Dec 21 08:09:14 duron kernel: hda: 40011300 sectors (20486 MB) w/512KiB
Cache, CHS=39694/16/63
Dec 21 08:09:14 duron kernel: Partition check:
Dec 21 08:09:14 duron kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9

hda10 hda11 hda12 hda13 >

With the boot line command line parameter, fdisk /dev/hda prints the
following.
I take that as long as I stay away from the first and the last
partition,
I can make linux and win98 co-exist.

command (m for help): p

Disk /dev/hda: 16 heads, 63 sectors, 39693 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1      3969   2000061    6  FAT16
Partition 1 does not end on cylinder boundary:
     phys=(248, 254, 63) should be (248, 15, 63)
/dev/hda2          3969     39685  18000832+   f  Win95 Ext'd (LBA)
Partition 2 does not end on cylinder boundary:
     phys=(1023, 254, 63) should be (1023, 15, 63)
/dev/hda5          3969      7937   2000061    6  FAT16
/dev/hda6          7937     11906   2000061    6  FAT16
/dev/hda7         11906     15874   2000061    6  FAT16
/dev/hda8         15874     19843   2000061    6  FAT16
/dev/hda9         19843     23811   2000061    6  FAT16
/dev/hda10        23811     27780   2000061    6  FAT16
/dev/hda11        27780     31748   2000061    6  FAT16
/dev/hda12        31748     35716   2000061    6  FAT16
/dev/hda13        35717     39685   2000061    6  FAT16

Anyway, back to the original question:
What can I do to let the disk "forget" the 2940/255/63 CHS setting?

I can wipe out the initial portion of the disk and
try re-install.

PS: Come to think of it, I no longer see UDMA(33) message
in the log. Is this also a potential problem?




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
