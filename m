Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUHMNdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUHMNdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUHMNdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:33:35 -0400
Received: from netmail01.eng.net ([213.130.128.38]:24515 "EHLO
	netmail01.eng.net") by vger.kernel.org with ESMTP id S265256AbUHMNd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:33:28 -0400
From: Chris Clayton <chris@theclaytons.giointernet.co.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: CDMRW in 2.6
Date: Fri, 13 Aug 2004 14:35:17 +0000
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <200408131253.49321.chris@theclaytons.giointernet.co.uk> <20040813115426.GN2663@suse.de>
In-Reply-To: <20040813115426.GN2663@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131435.17362.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 Aug 2004 11:54, Jens Axboe wrote:
> On Fri, Aug 13 2004, Chris Clayton wrote:
> > On Friday 13 Aug 2004 07:15, Jens Axboe wrote:
> > > On Mon, Aug 09 2004, Chris Clayton wrote:
> > > > cdrom: hdc: mrw address space DMA selected
> > > > cdrom open: mrw_status 'mrw complete'
> > > > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > > > hdc: command error: error=0x54
> > > > end_request: I/O error, dev hdc, sector 1048576
> > >
> > > Command was aborted, probably the media isn't writable after all.  Can
> > > you try and force a full format with cdrwtool?
> >
> > Jens,
> >
> > Did you mean cdrwtool or cdmrw?
>
> Sorry, meant cdmrw of course.
>
> > I've done a format with cdrwtool (cdrwtool -t 10 -d /dev/hdc -q) but
> > when I try and mount it (mount -o rw,noatime -t udf /dev/hdc /cdmrw)
> > and mount gives the message:
> >
> > mount: block device /dev/hdc is write-protected, mounting read-only
> >
> > dmesg shows no error after cdrwtool has run but has the following new
> > messages after the media is mounted:
> >
> > cdrom: hdc: mrw address space DMA selected
> > cdrom open: mrw_status 'not mrw'
> > UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF',
> > timestamp 2004/08/13 12:35 (1000)
> >
> > The media does, however, mount OK for packet writing (sudo mount -t
> > udf -o rw,noatime /dev/pktcdvd/cdrw /cdrw) using another kernel
> > patched with the packet writing patches Peter Osterlund has submitted
> > for the -mm series.
> >
> > I'll try a full (as opposed to quick) blank with cdrwtool plus a
> > forced format with cdmrw and report back when that has finished.
>
> Yes please do that, if that doesn't work it's really screwed.

Ok, here's the results:

[chris:~]$ cdrwtool -t 10 -d /dev/hdc -b full
setting speed to 10
using device /dev/hdc
full blank
1386KB internal buffer
setting write speed to 10x

<<no new messages from dmesg>>

[chris:~]$ cdmrw -d /dev/hdc -f full -F
not a mrw formatted disc
LBA space: DMA

<<no new messages from dmesg>>

[chris:~]$ while cdmrw -d /dev/hdc -f full | grep "mrw format running" ; do 
sleep 20; done
mrw format running
<snip>
mrw format running

<<no new messages from dmesg>>

[chris:~]$ mkudffs --media-type=cdrw /dev/hdc
start=0, blocks=16, type=RESERVED
start=16, blocks=3, type=VRS
start=19, blocks=237, type=USPACE
start=256, blocks=1, type=ANCHOR
start=257, blocks=31, type=USPACE
start=288, blocks=32, type=PVDS
start=320, blocks=32, type=LVID
start=352, blocks=32, type=STABLE
start=384, blocks=1024, type=SSPACE
start=1408, blocks=256480, type=PSPACE
start=257888, blocks=31, type=USPACE
start=257919, blocks=1, type=ANCHOR
start=257920, blocks=160, type=USPACE
start=258080, blocks=32, type=STABLE
start=258112, blocks=32, type=RVDS
start=258144, blocks=31, type=USPACE
start=258175, blocks=1, type=ANCHOR

<<the following new messages from dmesg>>

cdrom: hdc: mrw address space DMA selected
cdrom open: mrw_status 'mrw complete'
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1048576
Buffer I/O error on device hdc, logical block 262144
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1048580
Buffer I/O error on device hdc, logical block 262145
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1040384
Buffer I/O error on device hdc, logical block 260096
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1040388
Buffer I/O error on device hdc, logical block 260097
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1036288
Buffer I/O error on device hdc, logical block 259072
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1036292
Buffer I/O error on device hdc, logical block 259073
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1034240
Buffer I/O error on device hdc, logical block 258560
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1034244
Buffer I/O error on device hdc, logical block 258561
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1033216
Buffer I/O error on device hdc, logical block 258304
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1033220
Buffer I/O error on device hdc, logical block 258305
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1032704
Buffer I/O error on device hdc, logical block 258176
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1032708
Buffer I/O error on device hdc, logical block 258177

Exactly the same errors reported as in my post at the head of this thread, but 
as it's the same media, I guess there's every likelihood of that.

I'll try the same process (except the blanking) with a brand new piece of 
media and report when that is complete.

-- 
Chris
