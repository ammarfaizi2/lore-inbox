Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289192AbSAVHlJ>; Tue, 22 Jan 2002 02:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSAVHlB>; Tue, 22 Jan 2002 02:41:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25618 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289188AbSAVHkq>;
	Tue, 22 Jan 2002 02:40:46 -0500
Date: Tue, 22 Jan 2002 08:32:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020122083230.G1018@suse.de>
In-Reply-To: <20020121184433.C1018@suse.de> <Pine.LNX.4.10.10201211323500.15703-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201211323500.15703-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> 255 * 512bytes != 128K  BUG
> 256 * 512bytes == 128K
> 
> You insure we will fail on alignemnt.
> 
> You have stated BLOCK can not deal with correct sector alignments, and
> thus 255 so please fix it first.  I have accepted this brokeness in BLOCK
> and dropped to 128 sectors or a clean 64k.

What statement? The block layer gives you the allignment that _you_
need. Heck, all you have to do is make a simple api call and define your
rules. Nobody is trying to cram anything down your throat. 255 is just
the kernel default, nothing more.

> If we restrict multi-sector PIO to 8 sectors we can do multi interrupt
> ATOMIC disk IO on the paging alignments, but you have enforced single
> sector IO in the multi-sector writing and can not see the difference.

False, I've enforced current_nr_sectors transfers in multi-sector write.
But Andre please understand that changes like this are never final, feel
free to alter it and make it work any other way. Fact is, we needed a
change that made pio and multi mode _work_ right now -- my change does
that, and it's not all that bad.

> If rq->current_nr_sectors is less than 8 we do PIO single sector IO, but
> we are doing that now w/ the copy paste changes from the old ide-disk.c
> stuff that we are attempting deleting.

Well I'm sorry for making changes to your isr's, but they were broken.

> You are making mistakes left and right because you think you understand
> the hardware.  I thought we had an agreement, BLOCK stops at DO_REQUEST.
> Now you are altering the driver core, and the ISR's.  BLOCK has no
> business in dictating how to talk to the hardware, especially since it
> violates the specification willfully and without need.

?! I can't do anything but block stuff now, what a pity. Please tell me
where the block layer is dictating what you must do.

> We do a DMA of two PRD's of 128 sectors and 127 sectors, thus a mess.

I can add a

	BUG_ON(rq->nr_sectors == 255);

for you if you want, that will not happen.

> So at this point pull it and put back the munge for before and I will fix
> it completely and return a turn-key, now that I understand the brokeness
> of the interface I am deal w/ on both sides.

What is broken?

> Until you understand the execution of the command block is ATOMIC it will
> never work.  Also when the SCSI-MID Layer is deleted, you will have a
> repeat of this issue on a much grander scale.  Eric was a brilliant to
> hide the nature of the transport layer in the SCSI-MID Layer and return
> back partial completion against his ATOMIC Command IO calls.

Oh like the partial completion I added in ide_end_request?

Please calm down Andre, lets not start another round of flames.

-- 
Jens Axboe

