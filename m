Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbTCNJOA>; Fri, 14 Mar 2003 04:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbTCNJOA>; Fri, 14 Mar 2003 04:14:00 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:27914
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S263288AbTCNJN6>; Fri, 14 Mar 2003 04:13:58 -0500
Subject: 2.5.64-mm6: oops in elv_remove_request
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030313190247.GQ836@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org>
	 <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org>
	 <20030313190247.GQ836@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1047633884.1147.3.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 01:24:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 11:02, Jens Axboe wrote: 
> Nope cdrecord is fine, but I think only open by device name works
> currently. So you'd need to do
> 
> # cdrecord -dev=/dev/hdX -inq
> 
> to print inquiry data, for instance.

I get this with some random cdrecord rpm:

# cdrecord dev=/dev/hdc -inq
Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg
Schilling
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
cdrecord: Operation not permitted. Cannot send SCSI cmd via ioctl

strace shows this:

open("/dev/hdc", O_RDWR|O_NONBLOCK)     = 3
fcntl64(3, F_GETFL)                     = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
fcntl64(3, F_SETFL, O_RDWR|O_LARGEFILE) = 0
ioctl(3, 0x5382, 0xbfffc490)            = 0
ioctl(3, 0x5386, 0xbfffc48c)            = 0
ioctl(3, 0x2282, 0xbfffc494)            = 0
write(2, "Linux sg driver version: 3.5.27\n", 32) = 32
ioctl(3, 0x5382, 0xbfffc430)            = 0
ioctl(3, 0x5386, 0xbfffc42c)            = 0
ioctl(3, 0x2201, 0xbfffc344)            = 0
fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
write(1, "Using libscg version \'schily-0.7"..., 34) = 34
ioctl(3, 0x2272, 0xbfffc674)            = 0
ioctl(3, 0x2272, 0xbfffc670)            = 0
ioctl(3, 0x2272, 0xbfffc644)            = 0
ioctl(3, 0x2272, 0xbfffc640)            = 0
brk(0x80a4000)                          = 0x80a4000
gettimeofday({1047632019, 859019}, NULL) = 0
write(3, "*\0\0\0$\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 42) = -1 EPERM (Operation not permitted)
ioctl(3, 0x2201, 0xbfff45f4)            = 0
gettimeofday({1047632019, 859188}, NULL) = 0
write(2, "cdrecord: Operation not permitte"..., 66) = 66
munmap(0x40013000, 4096)                = 0

With the version or cdrtools I compiled, I get an instant oops+lockup
with the above command when running with anticipatory scheduler in
2.5.64-mm6 (hand written):

elv_remove_request
ide_end_request
cdrom_end_request
cdrom_decode_status
cdrom_newpc_intr
ide_do_request
ide_intr
cdrom_newpc_intr
handle_IRQ_event
do_IRQ
default_idle
     "
common_interrupt
...

I'll try it with deadline and see what happens... seems to work OK:

# ./cdrecord dev=/dev/hdc -inq
Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   :
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W4824A'
Revision       : '1.04'
Device seems to be: Generic mmc CD-RW.

though I don't seem to be able to set up a default device in
/etc/cdrecord.conf.

	J

