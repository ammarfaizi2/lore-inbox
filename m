Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRCGWGI>; Wed, 7 Mar 2001 17:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131222AbRCGWFt>; Wed, 7 Mar 2001 17:05:49 -0500
Received: from niwot.scd.ucar.edu ([128.117.8.223]:2962 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S131221AbRCGWFi> convert rfc822-to-8bit; Wed, 7 Mar 2001 17:05:38 -0500
Date: Wed, 7 Mar 2001 15:05:06 -0700
From: Craig Ruff <cruff@ucar.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <20010307150506.A1046@bells.scd.ucar.edu>
In-Reply-To: <20010307135811.A20146@bells.scd.ucar.edu> <Pine.LNX.4.10.10103071315180.19253-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10103071315180.19253-200000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Mar 07, 2001 at 01:15:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 01:15:46PM -0800, Andre Hedrick wrote:
> 
> Then run this and see if you live.

Well, I ran it, the disk lives.  The typescript is appended below.
Interestingly, scsikiller didn't cream the partition table like I
expected.  However the dd if=/dev/zero of=/dev/sdc certainly did.

I've been using dd to copy entire disks for 18 years.  Not just SCSI,
but SMD, IPI and IDE.  I've never had a problem with multi-sector writes
starting at any sector on drives.  Unless there is a bug in the
drive's firmware, about the only thing you can do software wise to
a SCSI disk is to interrupt a format command, which can leave things
messed up a bit until the next format.


Script started on Wed Mar  7 14:55:00 2001
bells# fdisk /dev/sdc

Command (m for help): p

Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdc1             1       553   4441941   83  Linux

Command (m for help): q

bells# dd if=/dev/sdc of=sdc.part bs=512 count=1
1+0 records in
1+0 records out
bells# cat scsikiller.c
/* scsikiller.c */
#include <sys/ioctl.h>
#include <sys/fcntl.h>
#include <scsi/scsi.h>

struct cdb6hdr{
	unsigned int inbufsize;
	unsigned int outbufsize;
	unsigned char cdb [6];
} __attribute__ ((packed));

int main (int argv, char **argc)
{
	int fd;
	unsigned char tBuf[526];
	struct cdb6hdr *ioctlhdr;

	if (argv != 2) exit(-1);
	
	fd = open (*(argc+1), O_RDWR );
	if (fd < 0) exit (-1);

	memset(&tBuf, 0, 526);
  
	ioctlhdr = (struct cdb6hdr *) &tBuf;
  
	ioctlhdr->inbufsize = 512;
	ioctlhdr->outbufsize = 0;
	ioctlhdr->cdb[0] = WRITE_6;
	ioctlhdr->cdb[4] = 1;
  
	return ioctl(fd, 1, &tBuf);
}
bells# cc -o scsikiller scsikiller.c
bells# scsikiller /dev/sdc
bells# dd if=/dev/sdc of=/dev/null bs=512 count=100
100+0 records in
100+0 records out
bells# fdisk /dev/sdc

Command (m for help): p

Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdc1             1       553   4441941   83  Linux

Command (m for help): q

bells# dd if=sdc.part of=/dev/sdc
1+0 records in
1+0 records out
bells# dd if=/dev/sdc of=/dev/null bs=512 count=100
100+0 records in
100+0 records out
bells# dd if=/dev/zero of=/dev/sc bs=512 count=100
100+0 records in
100+0 records out
bells# fdisk /dev/sdc
Device contains neither a valid DOS partition table, nor Sun or SGI disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.


Command (m for help): q

bells# dd if=sdc.part of=/dev/sdc
1+0 records in
1+0 records out
bells# fdisk /dev/sdc

Command (m for help): p

Disk /dev/sdc: 255 heads, 63 sectors, 553 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdc1             1       553   4441941   83  Linux

Command (m for help): q

bells# ^Dexit

Script done on Wed Mar  7 14:57:35 2001
