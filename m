Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTKKPTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTKKPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:19:08 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54656 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263565AbTKKPSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:18:54 -0500
Date: Tue, 11 Nov 2003 16:18:06 +0100 (MET)
From: Michal Kosmulski <M.Kosmulski@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: ASUS CD-ROM problem reading CD-RW
Message-ID: <Pine.SOL.4.30.0311111615110.14443-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

this is my first post to lkml, please excuse if my post is against the
guidelines of the mailing list in any way. Please also CC: any answers to
my e-mail address as I am not subscribed to the list.

I own a 40x ASUS CD-ROM drive CD-S400 (this is an IDE drive but it runs
under ide-scsi). Recently I noticed that more and more CD-Rs and CD-RWs
can't be read by the drive under linux. However, under windows (95) on the
same machine, most of those CDs can be read.
A more complete description of my system can be found at the end of this
post.

The drive's behavior under linux is somewhat strange. I made a test with
several different brands of CD-Rs and CD-RWs (further in this document I
will refer to them as CDs; I have not experienced any problems with
regular (not recordable) CD-ROMs yet), recorded with two different
recorders and here's what I noticed:

1. some of the CDs simply wouldn't mount; that's bad, but at least one
knows there's some kind of trouble

2. worse, some CD's would mount, but then the content of the files would
be corrupted. There were no I/O errors when reading the files, but the
file's content was not what it should have been. Archives would not unpack
etc. I had some BMP images on one of the disks and there I could easily
see random-colored horizontal lines in the image - some bytes were just
not read correctly, but instead of giving an error, the I/O subsystem just
read some garbage from the disks and returned that as the contents of the
file.
Note that while some of the lines were random-colored, some of them were
just black - this suggests there are two kinds of situations - in both of
them a buffer is returned although actually an I/O error should occur, but
in one case the buffer contains random data and in the other case it is
zeroed.

3. the strangest of all - I can perform the following experiment:
   - take any of the CDs which behave like what is described in point 2.
   - mount it
   - md5sum any file larger than a few kB
   - umount the disk
   - mount it again
   - md5sum the same file
   - the md5sums differ ! The random bytes which are inserted are
different each time I mount the disk and they appear in different areas of
the file. I could see this with the BMP images: the funky random colored
lines appeared in different parts of the image each time the cd was
mounted. By mounting the CD several times and copying the parts of the
image which were not corrupted after that particular mount, and then
stitching them together with the GIMP, I would probably be able to
retrieve the whole image from the disk. By looking at the lines I could
find out how large areas of the disk could not be read - the length of the
lines varied greatly: from about a hundred pixels (meaning about 300 bytes
of data) to probably several thousand. Sometimes the lines seemed to be
located in a completely random fashin, but there were also groups of lines
which looked like this:
        ----------
      ----------
    ----------
This suggests, that there is a problematic area somewhere on the disk, so
that with each rotation of the disk, a "line of data bytes" going through
this area is read erronueously (the length of the lines in this patter was
uniform, and so was the vertical distance between the lines as well as the
horizontal shift between them).

4. Now, hadn't I accidentally tried to read one of the "broken" CDs under
windows, I would have thaught that either the CDs I bought were broken, or
that the CD-recorder I used went crazy or that my CD-ROM drive is broken.
However, except for one CD-RW which could not be read under either OS (but
could be read on other computers), all the CDs that didn't work under
linux worked under windows - I could uncompress archives etc.; the files'
contents were not corrupted.

I have no experience with kernel programming, but here's what I think
about this problem:
Probably my CD-ROM drive is getting old and so it starts having some sort
of trouble reading the CDs. The fact that there was one CD that could be
read on other machines but not on my machine under either OS seems to
support this idea. However, it seems that windows has somehow better error
correction mechanisms or perhaps can calibrate the drive in a better way
than linux or something similar and so the problems with the drive are at
this point already a problem for linux but not a problem yet for windows.
Note that under windows I don't use any special vendor-made driver for the
cd-rom, but just a generic cd-rom driver. Thus, the best thing would be to
try and find out how to make linux less susceptible to the sort of problem
my drive has so it can read the CDs. If windows can do it, probably so can
linux. But even if it takes some time to fix the problem with error
correction (or whatever causes the trouble), I think it is very important
to avoid situations from point 2, such that the disk can be mounted and
files can be read without producing I/O errors, but the data read is
corrupted. If the contents of the files on the disk can not be read
without corruption, the kernel should generate an I/O error instead of
allowing the reading to proceed.

I hope the above described problems can be fixed. I don't know if the
drive would behave the same way with a 2.6.x kernel (haven't tested 2.6.x
yet). Please let me know if more experimental data is needed.

Michal Kosmulski



Here's a sample of what dmesg says after using some of the CDs affected by
the problem
(/var/log/syslog is just full of this sort of information - I have about
15000 entries of this type in syslog after trying perhaps a few dozen of
such CDs)

discarding data
ide-scsi: [[ 28 0 0 4 1c ee 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 131072 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 1d ee 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 192512 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 1d ee 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 157696 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 1e ee 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 192512 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 1e ee 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 157696 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 20 6e 0 0 3f 0 0 0 ]
]
ide-scsi: expected 129024 got 192512 limit 129024
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: [[ 28 0 0 4 20 6e 0 0 3f 0 0 0 ]
]

<snip - it goes on this way for quite a few lines>


/var/log/syslog also has entries of this type:

Nov 11 08:32:59 sredni kernel: ide-scsi: expected 2048 got 4096 limit 2048
Nov 11 08:33:09 sredni kernel: ide-scsi: The scsi wants to send us more
data than expected - discarding data
Nov 11 08:33:09 sredni kernel: ide-scsi: [[ 28 0 0 0 3b 30 0 0 1 0 0 0 ]
Nov 11 08:33:09 sredni kernel: ]
Nov 11 08:33:09 sredni kernel: ide-scsi: expected 2048 got 4096 limit 2048

(same as the ones in dmesg but the "expected xxxx got yyyy limit zzzz"
line doesn't always appear in dmesg)



My system:
Slackware Linux 9.0, kernel 2.4.22 (vanilla) compiled with gcc 3.2.2.
The CD-ROM (hdd) works under ide-scsi. hde is an IDE hard disk. I also
have a parallel port zip drive (module imm) (sda4 - scsi emulation).
Relevant lines from bootup time (copied from /var/log/syslog):
<snip>
Kernel command line: root=/dev/hde7 ro hdd=ide-scsi
<snip>
CPU: Intel Celeron (Mendocino) stepping 05
<snip>
HPT366: onboard version of chipset, pin1=1 pin2=2
hdd: ASUS CD-S400, ATAPI CD/DVD-ROM drive
<snip>
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hdd: attached ide-scsi driver.
  Vendor: ASUS      Model: CD-S400           Rev: 2.70
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
<snip>

Windows 95A. The CD-ROM driver is a generic one.


