Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUE3UDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUE3UDv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbUE3UDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:03:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12190 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264346AbUE3UDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:03:45 -0400
Date: Sun, 30 May 2004 22:03:00 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040530200300.GA4681@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BA2E5E.6090603@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 02:56:30PM -0400, Jeff Garzik wrote:

> Please educate me :)  Brutally, and in public :)

Hmm. It is easier if you ask questions.
I already wrote several many-page texts on this stuff.
See, e.g., http://www.win.tue.nl/~aeb/linux/Large-Disk.html

Attempt at a brief summary:

(i) Hardware:

In the ancient past a disk (MFM or RLL) had a geometry
describing how many sectors per track, how many tracks (cylinders),
and how many heads the thing had.

With the advent of IDE it no longer was true that a disk has a
well-determined geometry: the ATA command INITIALIZE DRIVE PARAMETERS
will tell the disk what geometry it is supposed to have today.

An IDE disk can be accessed in CHS and in LBA mode, and the
geometry specified, or read via the ATA IDENTIFY command,
defines the meaning of a CHS command. With LBA access
no geometry plays a role.

SCSI disks never had this geometry nonsense.

Linux uses LBA and does not need to concern itself with geometry.

(ii) DOS / Windows:

The DOS disk interface used CHS. If the disk uses LBA the driver
has to convert CHS to LBA and hence needs a geometry (at least H, S).

Because DOS (BIOS INT 13) had 10 bits for C, and 6- bits for S,
while ATA uses 4 bits for H, this scheme could address only
somewhat less than 2^20 sectors. The 528 MB limit.

All kinds of translation schemes were invented to give the
BIOS interface a geometry different from that used at the ATA
interface. The user chooses a translation scheme in the BIOS setup.
The geometry is now unrelated to the disk, but is known to the BIOS.

Various BIOS calls exist that report on various versions of the
geometry.

(iii) Partition tables:

A DOS-type partition table (see, e.g.,
http://www.win.tue.nl/~aeb/partitions/partition_tables.html)
gives the location of a partition in two ways.
One is the way used by Linux (the starting sector and length,
both given in 32 bits). The other, used by DOS, given CHS
for the first and for the last sector (both in 24 bits).

Even when nobody cares about geometry any longer, is it still
necessary to fill these CHS fields.

If the filesystem living in the partition is a FAT filesystem,
then the boot sector of the FAT filesystem again gives information
on the size of the partition.

(iv) Linux:

There is an ioctl HDIO_GETGEO that returns the geometry of a disk
and the starting sector (offset) of a partition.
There is an ioctl BLKGETSIZE that returns the size (in 512-byte sectors)
of a block device in 32 bits.
There is an ioctl BLKGETSIZE64 that returns the size (in bytes)
of a block device in 64 bits.

Clearly, BLKGETSIZE is obsolescent - it should be replaced by
BLKGETSIZE64 everywhere. 2^41 B is 2 TB, and some RAIDs are larger.

The HDIO_GETGEO ioctl gives heads, sectors and cylinders -
fields of 1, 1, 2 bytes. On the one hand that is reasonable -
no interface exists that can use more than 16 bits for the
number of cylinders. On the other hand there is still some
broken software that computes the size of a disk as C*H*S,
and obtains C, H, S by HDIO_GETGEO. Of course this is broken,
and introducing a new ioctl is no good - such software must
be fixed to use BLKGETSIZE64.

(v) Geometry use under Linux:

Roughly speaking geometry was needed under Linux for two
purposes: LILO (and similar bootloaders) and *fdisk.
Of course, also programs that tried to emulate aspects
of DOS/Windows are interested in a geometry.

The LILO aspect has disappeared - with options like linear, or lba32,
lilo uses linear sector numbers at install time, and converts them
to CHS, when needed, at boot time.

The fdisk aspect has also disappeared - after this geometry business
had become infinitely complicated, nobody any longer tried to
understand geometry, but just inferred from the partition table
what geometry was used by the program that last wrote it.

How did the kernel find a geometry?
Mainly in three ways: (i) from boot parameters, (ii) by looking
at the partition table, (iii) by asking the BIOS at boot time,
before switching to protected mode.

Information (i) - explicit specification - and (ii) - partition table -
is also available to user space, no kernel needed.
Remains the question whether (iii) is a good idea.

It didnt always work, but often it worked. (And only on i386 of course.)
Examples of failure: The code we had only asked the BIOS for info
on the first two disks. An often-posed question was: I have two
identical disks, how come they get different geometries?
Also, the code we had failed when the system had SCSI disks.
Also, the code we had assumed that the first two BIOS disks
were hda and hdb. But there is no reason why that would be
the case. For example, many people kept their large disks out of the
BIOS since it would crash upon seeing big disks.

So, this (iii) was a bit messy stuff with many problems, but
OK for most people.

(vi) The present

Linux no longer makes any attempt to invent a geometry.
If someone needs a geometry, he is responsible himself
for choosing one of the many concepts of geometry, and
determining a value. What most software does is looking
at the partition table, and that works.

Maybe parted has not yet been updated to do this,
that is why I conjectured that Fedora problems might be
due to the use of parted.

Was this a loss? I don't think so, but there is at least
one use of the old situation that fails today:
the installation of Windows systems from Linux media
on a completely blank disk.

Andries
