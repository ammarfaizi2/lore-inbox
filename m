Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbTCNJbj>; Fri, 14 Mar 2003 04:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCNJbj>; Fri, 14 Mar 2003 04:31:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64159 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263293AbTCNJbh>;
	Fri, 14 Mar 2003 04:31:37 -0500
Date: Fri, 14 Mar 2003 11:42:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030314104219.GA791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org> <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org> <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047633884.1147.3.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> On Thu, 2003-03-13 at 11:02, Jens Axboe wrote: 
> > Nope cdrecord is fine, but I think only open by device name works
> > currently. So you'd need to do
> > 
> > # cdrecord -dev=/dev/hdX -inq
> > 
> > to print inquiry data, for instance.
> 
> I get this with some random cdrecord rpm:
> 
> # cdrecord dev=/dev/hdc -inq
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg
> Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> cdrecord: Operation not permitted. Cannot send SCSI cmd via ioctl
> 
> strace shows this:
> 
> open("/dev/hdc", O_RDWR|O_NONBLOCK)     = 3
> fcntl64(3, F_GETFL)                     = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
> fcntl64(3, F_SETFL, O_RDWR|O_LARGEFILE) = 0
> ioctl(3, 0x5382, 0xbfffc490)            = 0
> ioctl(3, 0x5386, 0xbfffc48c)            = 0
> ioctl(3, 0x2282, 0xbfffc494)            = 0
> write(2, "Linux sg driver version: 3.5.27\n", 32) = 32

this matches the block/scsi_ioctl.c transport

> ioctl(3, 0x5382, 0xbfffc430)            = 0
> ioctl(3, 0x5386, 0xbfffc42c)            = 0
> ioctl(3, 0x2201, 0xbfffc344)            = 0
> fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
> write(1, "Using libscg version \'schily-0.7"..., 34) = 34
> ioctl(3, 0x2272, 0xbfffc674)            = 0
> ioctl(3, 0x2272, 0xbfffc670)            = 0
> ioctl(3, 0x2272, 0xbfffc644)            = 0
> ioctl(3, 0x2272, 0xbfffc640)            = 0
> brk(0x80a4000)                          = 0x80a4000
> gettimeofday({1047632019, 859019}, NULL) = 0
> write(3, "*\0\0\0$\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 42) = -1 EPERM (Operation not permitted)

it's trying to write a SCSI command to the device, assuming it's a
character scsi generic device. bad!

> ioctl(3, 0x2201, 0xbfff45f4)            = 0
> gettimeofday({1047632019, 859188}, NULL) = 0
> write(2, "cdrecord: Operation not permitte"..., 66) = 66
> munmap(0x40013000, 4096)                = 0
> 
> With the version or cdrtools I compiled, I get an instant oops+lockup
> with the above command when running with anticipatory scheduler in
> 2.5.64-mm6 (hand written):

Bug in that io scheduler...

> I'll try it with deadline and see what happens... seems to work OK:
> 
> # ./cdrecord dev=/dev/hdc -inq
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> Device type    : Removable CD-ROM
> Version        : 2
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'CD-R   PX-W4824A'
> Revision       : '1.04'
> Device seems to be: Generic mmc CD-RW.

Looks much better. Somehow the 'random' rpm you had didn't do SG_IO,
odd.

> though I don't seem to be able to set up a default device in
> /etc/cdrecord.conf.

I have no idea how that works. What do you typicall do?

-- 
Jens Axboe

