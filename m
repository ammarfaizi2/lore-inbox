Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284139AbRLRQGF>; Tue, 18 Dec 2001 11:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284140AbRLRQF4>; Tue, 18 Dec 2001 11:05:56 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:24928 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S284139AbRLRQFh>; Tue, 18 Dec 2001 11:05:37 -0500
Date: Tue, 18 Dec 2001 10:05:33 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
To: "ChristianK."@t-online.de (Christian Koenig),
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
Cc: Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, antirez <antirez@invece.org>,
        Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Hi,
> 
> On Monday 17 December 2001 23:10, Grover, Andrew wrote:
> > > From: Alexander Viro [mailto:viro@math.psu.edu]
> > >
> > > On Mon, 17 Dec 2001, Grover, Andrew wrote:
> > > > I don't think multiple streams is a good idea, but did you
> > >
> > > all see the patch
> > >
> > > > by Christian Koenig to let the bootloader load modules?
> > >
> > > That seems to solve
> > >
> > > > the problem nicely.
> > >
> > > That puts an awful lot of smarts into bootloader and creates
> > > code duplication
> > > for no good reason.
> 
> I agree, but the problem I have with Initrd is that you could only have 
> 1 single initrd-image on your hard disk / loaded by the boot-loader.
> 
> Imaging my situation, I have some removeable hard-disks, changing it between 
> a large amount of Systems all with individual Hardware-configuration.
> (Some SCSI, some ide, and a cluster booting with pxegrub/Floppy-Disks).
> 
> With the last relleas of my patch I'm now capable to have a grub menu.lst 
> looking like:
> 
> tile Kernel 2.4.14 Adaptec xyz/ne2000
> kernel /boot/vmlinuz-2.4.14 root=/dev/sdxyz ...
> 
> # Loading SCSI-Drivers
> modulesfromfile /etc/modules-adaptec /lib/modules/2.4.14/modules.dep 
> 
> # Loading Network-Drivers
> modulesfromfile /etc/modules-ne2000 /lib/modules/2.4.14/modules.dep
> 
> tile Kernel 2.4.14 Tecram xyz / Inter EExpresPro 
> 
> # Loading SCSI-Drivers
> modulesfromfile /etc/modules-tecram /lib/modules/2.4.14/modules.dep 
> 
> # Loading Network-Drivers
> modulesfromfile /etc/modules-eepro /lib/modules/2.4.14/modules.dep 
> ......
> 
> Could you Imaging what work it would be to create an individual initrd-Image 
> / Kernel Image for every system I have. Beside this I sometimes have the 
> Problem that I come to a system never seen bevore and have to boot with my 
> Floppy Disk's. (I'm now looking forward that grub someday gets capable to use 
> cd-roms directly).
> 
> I know this it isn't the best solution to add a module-loader to the Kernel, 
> but did you have a better idea ?

How about a three step loader:
1. primary boot (PROM) loads secondary boot <any boot program>
2. the <any boot program> loads a "superboot"
3. superboot has filesystem knowlege of a boot device (this is different) and
   Loads base kernel
4. installs required modules from boot device (this is not done currently)
5. starts kernel

The kernel should not need any installed drivers. All of them could be
installed after the kernel is loaded, but before being started.

This used to be/is done by many systems (VAX, Sun, IBM, SGI...) The PROM loader
loads a boot loader which loads boot program.

There are several ways to implement this: The "superboot" program doesn't
even have to know more than one filesystem type. A very simple file system
using contigueous, variable length segments, each segment containing one file.
The only requirement is that the /boot filesystem be accessable to both
Linux AND the loader. and yes, the /lib/modules/... should be moved to
/boot/modules directory. The /boot filesystem should need be no larger
than 2-5 MB depending on how many kernels and modules are to be present
at one time.

And yes, a tar formatted file should be sufficient if it were on a partition
of it's own (below cylender 1024 for the antique systems). If desired, the
tar file(fs?) could even be compressed (in which case, the kernel wouldn't
need to be). Even an ISO9660 format might work, with some modifications
(it WOULD be desirable to be able to write directly to it, and it would
 have to allow for fragmentation of the free space)

I think it would be much easier to use a block device though.. first block
is a directory block, directory containing the minimum of 
"name:filetype:starting block:length (in blocks)". If the filetype is a
directory, then the blocks pointed to are a subdirectory, treated in the
same manner as the first directory. True, there are no inodes in this,
but they could be added as just a unique number in an additional field
in a directory entry. NO hard links, NO symbolic links, NO owner (mounted
ONLY as uid=0,gid=0) intended for /boot. The superblock would only need to
know where the first filesystem block is, the length of the file name array,
and the size of the partition (for limit error checking).

Even an ISO9660 format might work, with some modifications.

The block nature of the file boundaries would allow for a possible DMA load
of an entire file into memory directly. Installing a module might require a
copy operation though. The contigueous nature of the files eliminates the
need for an fsck (not possible to corrupt the files, and it is easy to
recreate the entire filesystem). This also simplifies the secondary boot -
there is only one starting block number and length needed (file starting
block number + FS offset).

It may not even be necessary that the filesystem be known to linux, provided
some tools similar to the "mtools" were available to put files into the
partition, defragment the filesystem (move files to put all contigueous free
space at the end), get files out, make directory listings... It would just
make support simpler to mount it.

Oh - another thing - this could eliminate the need for the kernel to include
a "decompress" startup; this should be done by the "superboot" loader,
allowing a choice of different kinds of compression without kernel modification.

Who knows - it may be possible to merge <any boot program> with the "superboot"
and produce the equivalent to what is being done now, but without requiring
any built-in modules. Personally, I don't think so because such a loader
would become more usefull as a "mini-os" capable of being used to run
diagnostics as well as booting the system.

Suggested contents of the boot fs:

boot	- the superboot program
vmlinux	- the kernel (one or more instances)
<version> - directory containing modules for kernel <version>
	    multiple instances, one per kernel version. The contents of the
	    directory could even be in the same as in /lib/modules/<vers>
	    with the necessary modules dependancy files and directories of
	    for the drivers.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
