Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbREEFeh>; Sat, 5 May 2001 01:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbREEFe2>; Sat, 5 May 2001 01:34:28 -0400
Received: from [209.102.21.2] ([209.102.21.2]:59398 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131638AbREEFeM>;
	Sat, 5 May 2001 01:34:12 -0400
Message-ID: <3AF390EA.5CE10BE3@goingware.com>
Date: Sat, 05 May 2001 01:34:47 -0400
From: "Michael D. Crawford" <crawford@goingware.com>
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Win98 Setup ignores partition table, corrupts filesystems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bill sez: "All Your Partition Are Belong To Us."

Do you have the pleasure of installing or using multiple operating
systems, one of which is a Microsoft product?  Then the following
information may be of great importance to you.
Failure to pay attention to warning symptoms will result in filesystem
corruption the likes of which you've never seen before.

Under certain conditions, the Windows 98 Setup drive formatter will lay
down a FAT filesystem which describes a volume larger than the partition
it is contained in.  If you then initialize other filesystems like ext2
on the same drive afterward, everything will seem to OK at first,
perhaps for weeks of use.  But the day will come that you add some new
files to your Windows partition, and your other filesystems will get
overwritten with FAT data, perhaps (as in my sorry case) unrecoverably.

I guess our friends in Redmond take the partition not as the hard and
fast barrier that most of us do, but as a mere hint of how we want our
drive laid out.  In some cases that hint is ignored and Windows will use
its own ideas to figure out how to initialize the drive.

Something else seemed to have happened besides a simple overwriting of
some filesystem sectors; my drive was bleeding like an ebola victim,
it's partition map full of garbage and me unable to find any superblocks
using disk recovery utilties like gpart, rescuept and findsuper.  I had
to declare it a total loss; fortunately I have backups so my economic
loss is just a few days work but it is a lot of effort to rebuild my
system.  Some files were not backed up and are just gone.

If you initialize your partition map so that exactly the first partition
is labeled as a FAT partition you _should_ be OK.

I recall from earlier installations that if you have some partitions,
none of which are marked as a FAT variety, Windows setup will
repartition your drive without asking and lay down a single filesystem
that uses the whole drive.  While painful, it is not disastrous because
when you go to install your other operating systems you will find their
partitions gone and you can start over before having committed important
data to the drive.  It is more of a problem if you had installed the
other operating systems first - so one tip is to install Windows first,
so that if it screws up your system you at least won't have to reinstall Linux.

The above mistake can happen if you aren't careful to set the FAT
partition type when partitioning with a Linux utility like cfdisk, fdisk
or sfdisk, perhaps while booted off an installation CD or utility floppy.

What happened to me is that I had _two_ FAT partitions, one was the
first partition in the drive, and the second was the second to last in a
drive that had lots of partitions.

I had three primary partitions, marked as FAT, ext2, BeOS, then an
extended partition with BeOS, Linux swap, BeOS, FAT32 and ext32.

The problem is that the presence of the second FAT32 partition on the
drive is taken by the formatter in the Win98 setup as a signal to ignore
the partition map and allocate the entire remaining drive space as a FAT volume.

It might make some twisted sense if it allocated all the space from the
beginning of the drive to the start of the second fat partition, but my
hazy recollection is that Windows said the filesystem had the entire
remaining space on the drive - that is, the sum of the two fat
partitions was the entire drive space, and the two filesystems
overlapped.  I'm less sure of this however.

The formatter used is the formatter that runs within the Windows 98
setup program.  This is apparently a different formatter than is
available if you don't start setup and run DOS off the Win98
installation CD.

There are two early warning signs: when Windows setup formats your C:
drive, it takes longer than it should.  I had allocated 4 GB for C: on
an 18 GB drive, and the formatting took quite a long time, because it
does bad block checking.  This would be less noticeable if the FAT
partition took up proportionally more space on your drive.  Compare the
time to the time required to low-level format the whole drive with a bad
block check.

The other warning sign is that when Windows is installed, the total size
and free space shown for the C drive is much larger than it should be. 
Here is where I am kicking myself because I had noticed it, and I just
assumed it was a bug in the code that displayed the free space.  I
simply didn't conceive of the possibility that a bad filesystem had been written.

If you mount the fat partition under Linux, df will show a total size
and free space indicating the same size that Windows thinks it is.  This
will be larger than the partition size.  So one tip is, after formatting
the drive under Windows setup, quit from setup and restart off a Linux
installation CD, mount the FAT partition and check the size with df. 
Doing this, I found after my reformat, repartition and first attempt at
reinstalling the Windows had done it again.  

It's also a good idea to check that your partition table is still what
you want after a Windows format.

Another option is to just not allow Windows to format your C: drive, but
format it under Linux with mkdosfs or mkfs.msdos, or use some utility
like System Commander.  If you can move the drive to another machine (I
couldn't easily, because it was a laptop), you can move the drive to
another machine and format it under an installed version of Windows.

I had trouble using mkfs.msdos, Windows setup seemed to be happy with it
and copied its files to fat volume but then the machine wouldn't restart
off of the partition to continue the installation, so I finally did end
up figuring out what was going on and allowing a successful format under Windows.

What I had to do was use a Linux partitioning utility and mark my spare
FAT partition as Linux Native (83, I think).  Then setup happily lived
within its means.

After I had Windows completely installed I could use Linux again to
change the partition type, then the volume showed up as an unformatted
volume in Windows "My Computer", and I could format it with the
formatter you get from right-clicking on the volume icon.

Part of the reason I have my partitions set up as so was so that I could
have lots of data storage and a good size swap space, but all of my
operating systems would live below the 1024 cylinder limit.  I have two
different versions of the BeOS on, Slackware Linux and Windows 98, and
the OS installs are all in the first four partitions and linux swap and
user data areas are all in the remaining partitions above 1024 cylinders.

Being careful about things I could use GNU Grub and boot Linux higher
than 1024 cylinders, but mixing lots of different OSes, most of which
have to be chain-loaded, it just seemed wiser to keep everything below
1024 cylinders.

Here's one more tip.  Before doing anything else, make a backup of your
partition table and copy it to some other computers.  Print it out and
tape it to the front of the machine or the wall.  Do it this way:

sfdisk -d /dev/{drivename} > partition.sav

where {drivename} would be hda for the first IDE drive or sda for the
first SCSI disk.  

Restore the partitions like this:

sfdisk /dev/{drivename} < partition.save

You can make a more readable display of your partitions for the first
IDE drive like this:

sfdisk -l /dev/hda 

I think sfdisk only works on x86.  Other architectures like Macintosh
have different kinds of partition tables.  I don't know how you could do
a backup of your table like this on a Mac but maybe there is another
utility that someone could describe that does.

I haven't tried parted yet, but sfdisk is better than fdisk or cfdisk at
making sure you get exactly what you want out of a partition.  The
problem is that it is fussy.  

What you want to do is use sfdisk -d to get the partition map from an
existing drive and edit it to describe the partition map you want.  You
want to always end in a cylinder boundary, allow at least a block of
unpartitioned space for the boot record at the start and a block before
each logical partition, but if you're going to be using DOS or Windows
leave a track instead (use cfdisk to check your partitions after laying
them down; if the flags say "NC" then it is Not Compatible with DOS).

You can use sfdisk interactively but it is difficult.  It is much easier
to edit a file that will be used as standard input to write the
partition map all at once.  If you have a spare drive around, try
practicing with sfdisk until you can use it well, I think it is worth
the effort.

Also, after creating a DOS partition, set its first block to zeros to
avoid problems with DOS format (this is not what caused my trouble above)

dd if=/dev/zero of=/dev/{partitionname} bs=512 count=1

carefully, as you may destroy something!  Using the drive name rather
than your partition name will destroy something.

It is worth your effort to put some time and thought into partitioning
your drive.  Use a spreadsheet to work out how you want to partition it.
 Calculate the start and end of your partitions down to the sector.  Try
out different options in your spreadsheet to see how they work out.

Note that Linux is more flexible about partitions and the 1024 cylinder
limit, besides being able to use grub you could put your kernels in a
small partition all by themselves that your sure is below and have your
other partitions (/, /home etc.) crossing the boundary or above.

Ever Faithful,

Mike
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

    Tilting at Windmills for a Better Tomorrow.
