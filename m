Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbRDRMsy>; Wed, 18 Apr 2001 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133112AbRDRMsp>; Wed, 18 Apr 2001 08:48:45 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:64155 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S133110AbRDRMsd> convert rfc822-to-8bit; Wed, 18 Apr 2001 08:48:33 -0400
Message-ID: <3ADD8D08.A0A655DE@mrc-lmb.cam.ac.uk>
Date: Wed, 18 Apr 2001 13:48:09 +0100
From: Julian Gough <jgough@mrc-lmb.cam.ac.uk>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug report:ide-scsi
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by server1.mrc-lmb.cam.ac.uk id NAA03781
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is a bug in ide-scsi.  Please excuse me if I am wrong.

I have found independantly on 2 different machines,  with 3 different
kernels (including 2.4),  that certain conditions cause ide-scsi to lock
up irretrievably.  Here is one condition which I know to reproduce the
error:

-When writing to an ide CD writer which is configured to emulate scsi,
using cdrecord version > 1.6 and writing an audio track which REQUIRES
the '-pad' option,  for some reason tracks of the right size are OK,
even with the '-pad' option.  At the point the CD TOC is finished being
written,  or the point at which the CD is fixated,  the following error
message is thrown,  and the CD is unreadable:

cdrecord: faio_wait_on_buffer for reader timed out.
cdrecord: Input/output error. prevent/allow medium removal: scsi
sendcmd: retryable error
status: 0x2 (CHECK CONDITION)

CDB:  1E 00 00 00 00 00
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 2C 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x2C Qual 0x00 (command sequence error) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.000s timeout 40s


After this the CD drive locks up completely and will not respond to any
commands and cannot even be ejected manually.  The only way to recover
is to re-boot.  In fact if cdrecord  -checkdrive is run,  it reports
that the CD writer is now only a CD reader.

This does not happen with cdrecord version 1.6 or lower,  but I believe
that in higher versions it doesn't cause problems with genuine scsi
devices (this I'm afraid is only based on surfing newsgroups).

Julian.

here is some information about one system before AND AFTER lock up which
might be relevant:

BEFORE:

[root@stash jgough]# uname --all
Linux stash.mrc-lmb.cam.ac.uk 2.2.17 #14 SMP Wed Sep 27 21:12:39 BST
2000 i686 unknown

[root@stash jgough]# cdrecord -scanbus
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling
Linux sg driver version: 2.1.39
Using libscg version 'schily-0.1'
scsibus0:
 0,0,0   0) 'SEAGATE ' 'ST39140N        ' '1444' Disk
 0,1,0   1) 'SEAGATE ' 'ST39140LW       ' '1503' Disk
 0,2,0   2) *
 0,3,0   3) *
 0,4,0   4) *
 0,5,0   5) 'EXABYTE ' 'EXB-8200        ' '2618' Removable Tape
 0,6,0   6) *
 0,7,0   7) *
scsibus1:
 1,0,0 100) 'PLEXTOR ' 'CD-R   PX-W8432T' '1.07' Removable CD-ROM
 1,1,0 101) *
 1,2,0 102) *
 1,3,0 103) *
 1,4,0 104) *
 1,5,0 105) *
 1,6,0 106) *
 1,7,0 107) *

[root@stash jgough]# cdrecord -checkdrive dev=1,0,0
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling
scsidev: '1,0,0'
scsibus: 1 target: 0 lun: 0
Linux sg driver version: 2.1.39
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W8432T'
Revision       : '1.07'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO

[root@stash jgough]# more /etc/lilo.conf
boot=/dev/sda
install=/boot/boot.b
prompt
timeout=50
default=linux-2.2.17
image=/boot/vmlinuz-2.2.5-15smp
 label=linux
 root=/dev/sda1
 initrd=/boot/initrd-2.2.5-15smp.img
 read-only
image=/boot/vmlinuz-2.2.5-15
 label=linux-up
 root=/dev/sda1
 initrd=/boot/initrd-2.2.5-15.img
 read-only
image=/boot/vmlinuz-2.2.10
 label=linux-2.2.10
 root=/dev/sda1
        read-only
image=/boot/vmlinuz-2.2.17smp
 label=linux-2.2.17
 root=/dev/sda1
        read-only
       append="hda=ide-scsi mem=1024M"
 ramdisk=200000

[root@stash jgough]# cdrecord -version
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling

AFTER:

[root@stash jgough]# eject
eject: unable to eject, last error: Invalid argument

[root@stash jgough]# cdrecord -scanbus
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling
Linux sg driver version: 2.1.39
Using libscg version 'schily-0.1'
scsibus0:
 0,0,0   0) 'SEAGATE ' 'ST39140N        ' '1444' Disk
 0,1,0   1) 'SEAGATE ' 'ST39140LW       ' '1503' Disk
 0,2,0   2) *
 0,3,0   3) *
 0,4,0   4) *
 0,5,0   5) 'EXABYTE ' 'EXB-8200        ' '2618' Removable Tape
 0,6,0   6) *
 0,7,0   7) *
scsibus1:
 1,0,0 100) 'PLEXTOR ' 'CD-R   PX-W8432T' '1.07' Removable CD-ROM
 1,1,0 101) *
 1,2,0 102) *
 1,3,0 103) *
 1,4,0 104) *
 1,5,0 105) *
 1,6,0 106) *
 1,7,0 107) *

[root@stash jgough]# cdrecord -checkdrive dev=1,0,0
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling
scsidev: '1,0,0'
scsibus: 1 target: 0 lun: 0
Linux sg driver version: 2.1.39
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W8432T'
Revision       : '1.07'
Device seems to be: Generic CD-ROM.
cdrecord: Sorry, no CD/DVD-Recorder or unsupported CD/DVD-Recorder found
on this target.

[root@stash jgough]# ls -l /dev/cdrom
lrwxrwxrwx   1 root     root            9 Sep 27  2000 /dev/cdrom ->
/dev/scd0

[root@stash jgough]# scsi_info /dev/scd0
SCSI_ID="0,0,0"
MODEL="PLEXTOR CD-R   PX-W8432T"
FW_REV="1.07"

[root@stash jgough]# cdrecord -reset dev=1,0,0
Cdrecord 1.9 (i586-mandrake-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling
scsidev: '1,0,0'
scsibus: 1 target: 0 lun: 0
Linux sg driver version: 2.1.39
Using libscg version 'schily-0.1'



