Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbSAUXeX>; Mon, 21 Jan 2002 18:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSAUXeN>; Mon, 21 Jan 2002 18:34:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57872
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285709AbSAUXd7>; Mon, 21 Jan 2002 18:33:59 -0500
Date: Mon, 21 Jan 2002 15:27:40 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <F9158D81E5D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10201211442190.15703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Petr Vandrovec wrote:

> I did not want to participate in this discussion, as it is probably
> impossible to explain to you that there is nothing wrong with doing
> requests not evenly divisible by block size.
> 
> On 21 Jan 02 at 13:44, Andre Hedrick wrote:
> > On Mon, 21 Jan 2002, Jens Axboe wrote:
> > > On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > > > I always thought it is like this (and this is what I still believe after
> > > > > having read the sprcification):
> > > > > 
> > > > > ---
> > > > > SET_MUTIPLE 16 sectors
> > > > > ---
> > > > > READ_MULTIPLE 24 sectors
> > > > > IRQ
> > > > > PIO transfer 16 sectors
> > > > > IRQ
> > > > > PIO transfer 8 sectors
> > > > > ---
> > 
> > 255 * 512bytes != 128K  BUG
> > 256 * 512bytes == 128K
> > 
> > You insure we will fail on alignemnt.
> 
> SET MULTIPLE MODE description says that host should try block size only
> 1,2,4,8,16,32,64 or 128 sectors. So where you got 255 from?

/storage/src-2.5.3/linux-2.5.3-p2-pristine/drivers/ide

linux/drivers/ide/ide-probe.c

line 627

        /* IDE can do up to 128K per request, pdc4030 needs smaller limit */
        max_sectors = (is_pdc4030_chipset ? 127 : 255);
        blk_queue_max_sectors(q, max_sectors);

/storage/src-2.5.3/linux-2.5.3-p2-pristine/include/linux/blkdev.h

_LINUX_BLKDEV_H

line 322

#define MAX_PHYS_SEGMENTS 128
#define MAX_HW_SEGMENTS 128
#define MAX_SECTORS 255


> > You have stated BLOCK can not deal with correct sector alignments, and
> > thus 255 so please fix it first.  I have accepted this brokeness in BLOCK
> > and dropped to 128 sectors or a clean 64k.
> >
> > If we restrict multi-sector PIO to 8 sectors we can do multi interrupt
> > ATOMIC disk IO on the paging alignments, but you have enforced single
> > sector IO in the multi-sector writing and can not see the difference.
> 
> Why we cannot do multi-sector PIO with 16...128 sectors? There is no need
> to read all data with one insw() loop, you can store each of these
> 64kB of data in 65536 different, non-continuous, locations, and ATA device
> will not complain, as it will always see 32768 of word reads from its
> data port, nothing else... And no, there is no requirement that host
> must do back-to-back reads or writes from ATA device data port. Otherwise
> we would see upper bound on t0 in PIO-in and PIO-out cycles description.

I did not state we can not do the above.
I stated it can be done using multiple interrupts and still return back
partial completion of data io, because I thought it was obvious to the
execution of the COMMAND BLOCK is ATOMIC.  Specifically, once issued, it
must complete its operations.  If you want to IO more than on page of
memory, the you can not have any back until all is done.

No IF's AND's or BUT's and this point is getting totally lost.

> > If rq->current_nr_sectors is less than 8 we do PIO single sector IO, but
> > we are doing that now w/ the copy paste changes from the old ide-disk.c
> > stuff that we are attempting deleting.
> 
> Please tell me what page 168 (it is number of paper page, page number
> in PDF is by 14 greater) of Volume 2, Revision 0, of ATA/ATAPI rev.7
> (T13/1532D) in description of READ MULTIPLE talks about?
> 
> If the number of requested sectors is not evenly divisible by the block
> count, as many full blocks as possible are transferred, followed by a final,
> partial block transfer. The partial block transfer shall be for n sectors,
> where n = remainder (sector count/block count).
> 
> And almost identical text appears on page 296, where it talks about
> WRITE MULTIPLE. 

This arguement is over how to interface to the kernel and will the kernel
allow the device to function.

> If you are trying to persuade us that there are devices which support
> ATA interface, and do not follow these paragraphs word by word, there
> is certainly something wrong in the ATA world...

Again not a device issue, it is a HOST-Kernel issue not providing the
correct and needed glue layer to allow these operation to happen, as you
have so clearly pointed out.

Next if rq->current_nr_sectors is less than MULTI{READ,WRITE} is set for
then why do we attempt?  The hardware try to help with silly HOST affairs
but this one is way to difficult and would cross the ATOMIC nature of the
command execute.

In DMA scatter gather it is reference to page locations and it is done.

In PIO there is no scatter gather possible without a memcpy to a
contigious buffer period.  Therefore under the contstraints issued bu
Linus and Jens, of access to one 4k page of memory, and a forced
requirement to return back every 4k page of memory of completion prevents
one from ever transaction more than 8 sectors per request in PIO any mode.

Regardless if the request is for 128 or 256 sectors, a maximum of 8
sectors may be written or read to any disk, and then the request is ended
early.  Next the same request minus the first 8 sectors (max possible) is
run back up the block layer and re-issued in a new make_request.

start_request_sectors (255 sectors) max

make_request (start_request_sectors())

	do_request()
	ide-disk get (255 sectors)
		block truncates to 8 sectors max
	ide-taskfile
		transfers 8 sectors max
		end request (return 247 sectors)

upate_request(247 to be re issued, + additional max of 8)	
	make_request (247 to be re issued, + additional max of 8)

Now we never have a way to decide if or when the original PIO request is
completed and it is safe to return to DMA if we end up in PIO because of a
DMA failure.

This is why I am going to request for backing out again because the BLOCK
API without a MID-LAYER to buffer against the goal of the kernel,
conflicts with the hardware rules requirements.  Until a satisfactory
agreement can be reached then the current direction it is going will trash
the Virtual DMA hardware coming in the future.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

