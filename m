Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUGGRkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUGGRkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUGGRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:40:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3810 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265250AbUGGRkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:40:22 -0400
Date: Wed, 7 Jul 2004 19:40:15 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Frediano Ziglio <freddyz77@tin.it>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: EDD enhanchement patch
Message-ID: <20040707174015.GB11556@apps.cwi.nl>
References: <1089132808.4435.8.camel@freddy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089132808.4435.8.camel@freddy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 06:53:28PM +0200, Frediano Ziglio wrote:

> This patch add support for DTPE data in EDD and mbr_signature. This
> patch do not solve fdisk problems but can help these programs to compute
> correct head count.


Thanks!

(Please, do not gzip - it is much easier to look at the patch
when it is not gzipped, and not hidden in an attachment.
Also for later, for searching things with Google or so, simple
letters are preferable.)

See that Matt Domsch looked at the code. Good. He wrote
 "I don't think this is quite ready to include yet,
  but I'm not philosophically opposed to it, so let's work it out.
  First, I want to understand what information in the DPTE you need.
  I assume byte offset 4, bit 6 (LBA enable), and bytes 10-11 bit 3
  (CHS translation enabled) and bit 4 (LBA translation enabled), yes?
  How are you expecting tools like fdisk to use this information?"

Let me give my answers. No I am not opposed to it, philosophically
or otherwise. It is easiest not to think about what parts might be useful -
next week you might think of some other use. Just fetch all available
information and make it available to user space without looking at it.
(There is a checksum. A revision number. A bit "removable". A Master/Slave bit...)

All this stuff is not very useful. But in some cases it helps.

Long ago I did something similar. Let me see whether I can retrieve that.
Ah, yes. "Collection of BIOS disk info, aeb, Feb 1999"
See http://ftp.cwi.nl/aeb/getbios/2.2.2.patch-HDIO_GETBIOS

+! Try to collect all disk information the BIOS can give us.
+! Such information is difficult to interpret:
+! We don't know whether hd0, hd1, ... are IDE or SCSI disks.
+! Some disks may not be mentioned in the BIOS setup and will
+! probably not be seen here.
+! So, instead of trying to make sense of this, we make the
+! collected information available by ioctl to user space.
+!
+! Layout collected disk data (where DD stands for disk_data)
+! 0x0080-0x008f: hd0 data, from int 41
+! 0x0090-0x009f: hd1 data, from int 46
+! DD[0x000-0x02f]: data following int 41 table, possibly hd1..3
+! DD[0x030-0x0af]: hd0..15 geometry, from int 13, fn 15, 8
+! DD[0x0b0-0x1f8]: hd0..3 Phoenix data, from int 13, fn 41,48
+! Phoenix data has extensive info but takes a lot of space
+! For the moment for 4 disks only

It looks like this is about what Matt and Patrick and you have.
Matt also has something new and very useful: these 4-byte disk signatures.
As additional info I had this "data following int 41 table".
Marginally useful, but it sometimes helps.

There is a difference in philosophy: I made all of the garbage
extracted from the BIOS available to user space without any attempt
at validating or interpreting it in the kernel. A user space routine
sniffed the data and tried to construct the BIOS-Linux disk correspondence,
using ordering and sizes and geometry of the disks.

I never pushed this - had hoped for something that would identify
the correspondence with high probability, but the results were disappointing.

Not many BIOSes implemented Phoenix 3.0, so the much better data provided
by that did not help so much.

I saw mail by Matt Domsch two weeks ago or so, saying "I've got a huge number of
reports, and virtually all show that EDD 3.0 is not supported, or if supported,
is likely implemented in ways contrary to the spec."
So, it seems things have not improved much in these five years.

Of course, one can do a much better job when disk I/O is allowed.
For example, read the first 256 sectors and compute an md5sum.
Reading the MBR signature falls into this category.

There are complications for RAID, even when EDD 3.0 is supported.


Andries


An example.
------------------------------------------------------------------------------------
hd0:  C/H/S= 1020/200/62
hd1:  C/H/S= 1024/255/63
hd00: C/H/S= 1024/255/63
hd01: garbage
hd02: garbage
disk 0: len=0
disk 1: len=0
disk 2: len=0
disk 3: len=0


Found 7 Linux disks

hda: Size  33750864 LinuxCHS=2721/200/62 FdiskCHS=-/16/63
  LBASize  33750864 CurSize  33750864  RawCHS=33483/16/63 CurCHS=2721/200/62
hdb: Size  23547888 LinuxCHS=23361/16/63 FdiskCHS=-/16/63
  LBASize  23547888 CurSize  23547888  RawCHS=23361/16/63 CurCHS=23361/16/63
hdc: Size    417792 LinuxCHS=1024/12/34 FdiskCHS=-/12/34
  LBASize         0 CurSize    417792  RawCHS=1024/12/34 CurCHS=1024/12/34
sda: Size  12657717 LinuxCHS=1020/200/62 FdiskCHS=-/200/62
sdb: Size  17755792 LinuxCHS=8669/64/32 FdiskCHS=-/0/0
sdc: Size   4226725 LinuxCHS=2063/64/32 FdiskCHS=-/64/32
sdd: Size   3517856 LinuxCHS=1717/64/32 FdiskCHS=-/64/32


Found 5 BIOS disks

0 of 5:   12648000 sectors, C/H/S 1020 / 200 / 62 OK
1 of 5:   16450560 sectors, C/H/S 1024 / 255 / 63 OK
2 of 5:    2097152 sectors, C/H/S 1024 / 64 / 32 OK
3 of 5:    2097152 sectors, C/H/S 1024 / 64 / 32 OK
4 of 5: 4292876420 sectors, C/H/S 1023 / 16 / 63 C*H*S=1031184


hda: 0x84?
hdb: 0x84?
hdc:not in BIOS
sda: 0x80
sdb: 0x81
sdc: 0x82
sdd: 0x83

This is a machine booted from SCSI with

hda: Maxtor 91728D8, 16479MB w/512kB Cache, CHS=2721/200/62, (U)DMA
        RawCHS=16383/16/63, CurCHS=16383/16/63, CurSects=16514064, LBAsects=33750864
hdb: QUANTUM Bigfoot TX12.0AT, 11497MB w/69kB Cache, CHS=23361/16/63, (U)DMA
        RawCHS=16383/16/63, CurCHS=16383/16/63, CurSects=16514064, LBAsects=23547888
hdc: ST3243A, 204MB w/32kB Cache, CHS=1024/12/34
        RawCHS=1024/12/34, LBA=no.

hd0 reports sda (and the kernel mistakes it for hda)
hd1 reports sdb, I suppose
------------------------------------------------------------------------------------

This was an example without INT 13 extensions. One with:

------------------------------------------------------------------------------------
disk 0: len=26
  flags 0, phys CHS 0/0/0, totsecs 12594960, seclen 512
  disk 1: len=26
  flags 0, phys CHS 0/0/0, totsecs 6306048, seclen 512
  disk 2: len=26
  flags 0, phys CHS 0/0/0, totsecs 13269690, seclen 512
  disk 3: len=26
  flags 0, phys CHS 0/0/0, totsecs 13269690, seclen 512

Found 5 Linux disks

hda: Size  12594960 LinuxCHS=13328/15/63 FdiskCHS=-/0/63
  LBASize  12594960 CurSize  12594960  RawCHS=13328/15/63 CurCHS=13328/15/63
hdb: Size   6306048 LinuxCHS=782/128/63 FdiskCHS=-/128/63
  LBASize   6306048 CurSize   6306048  RawCHS=6256/16/63 CurCHS=782/128/63
hdc: Size  13281408 LinuxCHS=13176/16/63 FdiskCHS=-/0/63
  LBASize  13281408 CurSize  13281408  RawCHS=13176/16/63 CurCHS=13176/16/63
hdd: Size  13281408 LinuxCHS=13176/16/63 FdiskCHS=-/0/0
  LBASize  13281408 CurSize  13281408  RawCHS=13176/16/63 CurCHS=13176/16/63
hdh: Size    196608 LinuxCHS=32/64/96 FdiskCHS=-/0/0
  LBASize         0 CurSize         0  RawCHS=0/0/0 CurCHS=0/0/0

Found 8 BIOS disks

0 of 4:   12578895 sectors, C/H/S 783 / 255 / 63 OK
1 of 4:    6297984 sectors, C/H/S 781 / 128 / 63 OK
2 of 4:   13253625 sectors, C/H/S 825 / 255 / 63 OK
3 of 4:   13253625 sectors, C/H/S 825 / 255 / 63 OK
4 of 4:      20740 sectors, C/H/S 305 / 4 / 17 OK
5 of 4:      20740 sectors, C/H/S 305 / 4 / 17 OK
6 of 4:      20740 sectors, C/H/S 305 / 4 / 17 OK
7 of 4:      20740 sectors, C/H/S 305 / 4 / 17 OK

hda: 0x80?
hdb: 0x81
hdc: 0x80? 0x82? 0x83?
hdd: 0x80? 0x82? 0x83?
hdh:not in BIOS

Here the IBM extensions report the same size as Linux does
for the Quantum Fireballs, but for the Maxtors we have:
Linux 13281408, IBM extensions 13269690, BIOS 13253625.
The BIOS value is derived from 825*255*63, the IBM extensions value from
826*255*63, so that the BIOS here decides that the last cylinder is a
test cylinder.
The BIOS did not return an error when we asked for disks 4-7 but says
that there are only 4 disks (0-3), and the data for 4-7 is not meaningful.
Thus, Ralf Brown (INT 13, AH=8) is incomplete when he suggests to use
INT 13, AH=15 to check on INT 13, AH=8: in this case both succeeded.
--------------------------------------------------------------------------------

I can imagine that we sooner or later would like to have a preinitrd,
configurable, describing all things that should be done in real mode
before actually starting the kernel. The main problem would be how to
communicate.

