Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSBMJKm>; Wed, 13 Feb 2002 04:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291161AbSBMJKY>; Wed, 13 Feb 2002 04:10:24 -0500
Received: from mail50-s.fg.online.no ([148.122.161.50]:3540 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S291291AbSBMJKD>; Wed, 13 Feb 2002 04:10:03 -0500
Date: Wed, 13 Feb 2002 11:09:12 +0100
From: Dag Bakke <dag@bakke.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  hpfs bug
Message-ID: <20020213110912.A191@dagb>
In-Reply-To: <20020212140036.A223@dagb> <1013523397.263.6.camel@unaropia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1013523397.263.6.camel@unaropia>; from spstarr@sh0n.net on Tue, Feb 12, 2002 at 09:16:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 09:16:10AM -0500, Shawn Starr wrote:
> Some others have reported problems with superblock reading on boot.
> There may be some code that has changed superblock reading but this
> might be different.

Booting with BUG() enabled, I get:

kernel BUG at buffer.c:2630! 

The relevant section is:

   2618 static int grow_buffers(kdev_t dev, unsigned long block, int size)
   2619 {
   2620         struct page * page;
   2621         struct block_device *bdev;
   2622         unsigned long index;
   2623         int sizebits;
   2624 
   2625         /* Size must be multiple of hard sectorsize */
   2626         if (size & (get_hardsect_size(dev)-1))
   2627                 BUG();
   2628         /* Size must be within 512 bytes and PAGE_SIZE */
   2629         if (size < 512 || size > PAGE_SIZE)
   2630                 BUG();


My disks are partitioned/formatted as follows:

    hda1        Boot        Primary   Linux ext2                          49.36 
    hda2                    Primary   Linux XFS                        10001.95
    hda3                    Primary   Linux raid autodetect            10001.95
                            Pri/Log   Free Space                       20925.12

    hdc1                    Primary   Linux ext2                          49.36 
    hdc2                    Primary   Linux ext2                       10001.95
    hdc3                    Primary   Linux raid autodetect            10001.95
                            Pri/Log   Free Space                       20925.12

I.e. my hpfs disk is not connected at this time.

I have compiled-in support for:
CONFIG_VIDEO_PROC_FS=y
CONFIG_EXT3_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_ZISOFS=y
CONFIG_HPFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_XFS_FS=y
CONFIG_XFS_DMAPI=y
CONFIG_HAVE_XFS_DMAPI=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_USB_DEVICEFS=y


Disregarding hpfs for a moment:
I see this during boot with working and non-working kernels:
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0

Not sure what the FAT code complains about, but it could possibly be the
two raid partitions (raid0/xfs). 

Anything else I can provide? kdb appears to require a little bit of
rewiring/replugging. Got no response to keyboardwhacking when I hit the
kdb prompt. Don't know if my USB keyboard makse a difference, but it
probably does.... :-)
If you want kdb stuff, please provide a little roadmap. 

Regards,

Dag B

 
> On Tue, 2002-02-12 at 08:00, Dag Bakke wrote:
> > Hi.
> > 
> > Compiling in support for hpfs in 2.4.18-pre9-xfs-shawn4 causes panic on
> > boot.
> > (I do have a some devicedriver patches added to your patch, but nothing related to
> > core, vfs or hpfs.)
> > 
> > Thanks,
> > 
> > Dag B
> > 
> > 
> > root@dagb:~# ksymoops -L -m /boot/System.map -K <~dagb/kernelcrash.txt 
> > ksymoops 2.4.3 on i686 2.4.18-pre9-xfs-shawn4.  Options used
> >      -V (default)
> >      -K (specified)
> >      -L (specified)
> >      -o /lib/modules/2.4.18-pre9-xfs-shawn4/ (default)
> >      -m /boot/System.map (specified)
> > 
> > No modules in ksyms, skipping objects
> > invalid operand:        0000
> > CPU:    0
> > EIP:  0010:[<c0136d10>] Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010286
> > Warning (Oops_read): Code line not seen, dumping what data is available
> > 
> > >>EIP; c0136d10 <grow_buffers+50/100>   <=====
> > 
> > Stack:  00000302  00000000  00000000  c13a91c0  00002240  c0134eb7  00000302  00000000
> >         00000000  cffe7ed8  cfe6a000  cfe6a044  c01350aa  00000302  00000000  00000000
> >         cffe7ed8  cfe6a000  c13a91c0  c019e96c  00000302  00000000  00000000  00000000
> > Call Trace: [<c0134eb7>] [<c01350aa>] [<c019e96e>] [<c01a7a8d>] [<c01378a9>] [<c0137c27>] [<c010503a>] [<c010504c>] [<c01054e8>]
> > Code: 0f 0b b9 ff ff ff ff 89 fa b6 00 90 8d 74 26 06 8b 44 24 20
> > 
> > Trace; c0134eb6 <getblk+26/40>
> > Trace; c01350aa <bread+1a/c0>
> > Trace; c019e96e <hpfs_map_sector+1e/40>
> > Trace; c01a7a8c <hpfs_read_super+15c/730>
> > Trace; c01378a8 <insert_super+38/40>
> > Trace; c0137c26 <read_super+56/b0>
> > Trace; c010503a <prepare_namespace+a/10>
> > Trace; c010504c <init+c/110>
> > Trace; c01054e8 <kernel_thread+28/40>
> > Code;  c0136d10 <grow_buffers+50/100>
> > 00000000 <_EIP>:
> > Code;  c0136d10 <grow_buffers+50/100>
> >    0:   0f 0b                     ud2a   
> > Code;  c0136d12 <grow_buffers+52/100>
> >    2:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
> > Code;  c0136d16 <grow_buffers+56/100>
> >    7:   89 fa                     mov    %edi,%edx
> > Code;  c0136d18 <grow_buffers+58/100>
> >    9:   b6 00                     mov    $0x0,%dh
> > Code;  c0136d1a <grow_buffers+5a/100>
> >    b:   90                        nop    
> > Code;  c0136d1c <grow_buffers+5c/100>
> >    c:   8d 74 26 06               lea    0x6(%esi,1),%esi
> > Code;  c0136d20 <grow_buffers+60/100>
> >   10:   8b 44 24 20               mov    0x20(%esp,1),%eax
> > 
> > 
> > 1 warning issued.  Results may not be reliable.
> > 
> 
> 
> 
