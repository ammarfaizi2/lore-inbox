Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSIEAfx>; Wed, 4 Sep 2002 20:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSIEAfx>; Wed, 4 Sep 2002 20:35:53 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:22021 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S316573AbSIEAfu>; Wed, 4 Sep 2002 20:35:50 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200209050039.g850dHY05826@sprite.physics.adelaide.edu.au>
Subject: Re: Linux 2.4.18: short dd read from IDE cdrom
To: andersen@codepoet.org
Date: Thu, 5 Sep 2002 10:09:17 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org, axboe@suse.de, andre@linux-ide.org
In-Reply-To: <20020903073525.GA13386@codepoet.org> from "Erik Andersen" at Sep 03, 2002 01:35:25 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue Sep 03, 2002 at 04:49:12PM +0930, Jonathan Woithe wrote:
> > Hi all
> > 
> > Yesterday I reported a problem to lkml I observed with `dd' and ide cds:
> > > For a number of years now I have duplicated cds using
> > >   dd if=/dev/cdrom of=foo.iso
> > >   cdrecord ... foo.iso
> > > :
> > > Today I tried the same trick under 2.4.18 and struck a problem: the kernel
> > > would not read the complete CD image. ...
> > 
> > After further testing, it seems that turning off dma using "hdparm -d 0
> > /dev/hdc" allows things to work as expected - the full disk can be read and
> > the resulting image is intact.  It appears therefore that the problem may
> 
> Interesting.  When DMA is enabled does running 
>     blockdev --setra 0 /dev/cdrom
> make any difference?

None at all that I can tell:
  baxter:~> hdparm -d 0 /dev/hdc
  /dev/hdc:
   setting using_dma to 0 (off)
   using_dma    =  0 (off)
  baxter:~> dd if=/dev/hdc of=/dev/null bs=2k skip=64008 count=8
  8+0 records in
  8+0 records out
  baxter:~> hdparm -d 1 /dev/hdc
  /dev/hdc:
   setting using_dma to 1 (on)
   using_dma    =  1 (on)
  baxter:~> dd if=/dev/hdc of=/dev/null bs=2k skip=64008 count=8
  dd: reading /dev/hdc': Input/output error
  4+0 records in
  4+0 records out
  baxter:~> blockdev --setra 0 /dev/hdc
  baxter:~> dd if=/dev/hdc of=/dev/null bs=2k skip=64008 count=8
  dd: reading /dev/hdc': Input/output error
  4+0 records in
  4+0 records out

The CD concerned definitely has 64016 data blocks as reported by isosize:
  baxter:~> isosize -x /dev/hdc
  sector count: 64016, sector size: 2048

When the read succeeds, the messages log gives
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256068

This is expected - 256068 is beyond the last data sector and would be one of
those unreadable runout sectors that CDs have.

When the command fails with DMA turned on, we get:
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256048
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256052
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256056
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256060
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256064
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256068

Again, it can't read 512 byte) sector 256068, but appears to fail the four
2048 byte CDROM sectors leading up to the first leadout sector as well.

Interestingly enough, if I seek 64012 blocks in and read 4 blocks, things
work:
  baxter:~> dd if=/dev/hdc of=/dev/null bs=2k skip=64012 count=4
  4+0 records in
  4+0 records out
with 
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256064
  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
  hdc: command error: error=0x50
  end_request: I/O error, dev 16:00 (hdc), sector 256068
appearing in the logs.

This is the only way to read those last 4 2k blocks: reading them from any
other skip offset (or as part of a complete disc read) results in them being
flagged with an I/O error.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
