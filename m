Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbRCGWgs>; Wed, 7 Mar 2001 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131111AbRCGWgi>; Wed, 7 Mar 2001 17:36:38 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:30221
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131056AbRCGWgd>; Wed, 7 Mar 2001 17:36:33 -0500
Date: Wed, 7 Mar 2001 14:35:56 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Craig Ruff <cruff@ucar.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <20010307150506.A1046@bells.scd.ucar.edu>
Message-ID: <Pine.LNX.4.10.10103071430351.19253-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So basically you are pointing out that there is now a sequencer reject in
linux?  Because this used to effect and wipe drives, but you are showing
that Linux now does scsi commands check for execution on the /dev/sdxx?

On Wed, 7 Mar 2001, Craig Ruff wrote:

> On Wed, Mar 07, 2001 at 01:15:46PM -0800, Andre Hedrick wrote:
> > 
> > Then run this and see if you live.
> 
> Well, I ran it, the disk lives.  The typescript is appended below.
> Interestingly, scsikiller didn't cream the partition table like I
> expected.  However the dd if=/dev/zero of=/dev/sdc certainly did.
> 
> I've been using dd to copy entire disks for 18 years.  Not just SCSI,
> but SMD, IPI and IDE.  I've never had a problem with multi-sector writes
> starting at any sector on drives.  Unless there is a bug in the
> drive's firmware, about the only thing you can do software wise to
> a SCSI disk is to interrupt a format command, which can leave things
> messed up a bit until the next format.
> 
> 
> Script started on Wed Mar  7 14:55:00 2001
> bells# fdisk /dev/sdc
> 
> Command (m for help): p
> 
> Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdc1             1       553   4441941   83  Linux
> 
> Command (m for help): q
> 
> bells# dd if=/dev/sdc of=sdc.part bs=512 count=1
> 1+0 records in
> 1+0 records out
> bells# cat scsikiller.c
> /* scsikiller.c */
> #include <sys/ioctl.h>
> #include <sys/fcntl.h>
> #include <scsi/scsi.h>
> 
> struct cdb6hdr{
> 	unsigned int inbufsize;
> 	unsigned int outbufsize;
> 	unsigned char cdb [6];
> } __attribute__ ((packed));
> 
> int main (int argv, char **argc)
> {
> 	int fd;
> 	unsigned char tBuf[526];
> 	struct cdb6hdr *ioctlhdr;
> 
> 	if (argv != 2) exit(-1);
> 	
> 	fd = open (*(argc+1), O_RDWR );
> 	if (fd < 0) exit (-1);
> 
> 	memset(&tBuf, 0, 526);
>   
> 	ioctlhdr = (struct cdb6hdr *) &tBuf;
>   
> 	ioctlhdr->inbufsize = 512;
> 	ioctlhdr->outbufsize = 0;
> 	ioctlhdr->cdb[0] = WRITE_6;
> 	ioctlhdr->cdb[4] = 1;
>   
> 	return ioctl(fd, 1, &tBuf);
> }
> bells# cc -o scsikiller scsikiller.c
> bells# scsikiller /dev/sdc
> bells# dd if=/dev/sdc of=/dev/null bs=512 count=100
> 100+0 records in
> 100+0 records out
> bells# fdisk /dev/sdc
> 
> Command (m for help): p
> 
> Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdc1             1       553   4441941   83  Linux
> 
> Command (m for help): q
> 
> bells# dd if=sdc.part of=/dev/sdc
> 1+0 records in
> 1+0 records out
> bells# dd if=/dev/sdc of=/dev/null bs=512 count=100
> 100+0 records in
> 100+0 records out
> bells# dd if=/dev/zero of=/dev/sc bs=512 count=100
                         ^^^^^^^^^^
I assume typo ??

> 100+0 records in
> 100+0 records out
> bells# fdisk /dev/sdc
> Device contains neither a valid DOS partition table, nor Sun or SGI disklabel
> Building a new DOS disklabel. Changes will remain in memory only,
> until you decide to write them. After that, of course, the previous
> content won't be recoverable.
> 
> 
> Command (m for help): q
> 
> bells# dd if=sdc.part of=/dev/sdc
> 1+0 records in
> 1+0 records out
> bells# fdisk /dev/sdc
> 
> Command (m for help): p
> 
> Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdc1             1       553   4441941   83  Linux
> 
> Command (m for help): q
> 
> bells# ^Dexit
> 
> Script done on Wed Mar  7 14:57:35 2001
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

