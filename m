Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSDPTLC>; Tue, 16 Apr 2002 15:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDPTLB>; Tue, 16 Apr 2002 15:11:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:38094 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312855AbSDPTLA>;
	Tue, 16 Apr 2002 15:11:00 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 16 Apr 2002 21:10:59 +0200 (MEST)
Message-Id: <UTC200204161910.g3GJAx009370.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@zip.com.au
Subject: Re: readahead
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andrew Morton <akpm@zip.com.au>

    > In the good old days we had tunable readahead.
    > Very good, especially for special purposes.

    readahead is tunable, but the window size is stored
    at the request queue layer.  If it has never been
    set, or if the device doesn't have a request queue,
    you get the defaults.

    Do these cards not have a request queue?

The kernel views them as SCSI disks.
So yes, I can do

   blockdev --setra 0 /dev/sdc

Unfortunately that does not help in the least.
Indeed, the only user of the readahead info is
readahead.c: get_max_readahead() and it does

        blk_ra_kbytes = blk_get_readahead(inode->i_dev) / 2;
        if (blk_ra_kbytes < VM_MIN_READAHEAD)
                blk_ra_kbytes = VM_MAX_READAHEAD;

We need to distinguish between undefined, and explicily zero.
Also, overriding the value explicitly given by the user
is a bad idea.
     
    > I recall the days where I tried to get something off
    > a bad SCSI disk, and the kernel would die in the retries
    > trying to read a bad block, while the data I needed was
    > not in the block but just before. Set readahead to zero
    > and all was fine.

    Yes, but things should be OK as-is.  If the readahead attempt
    gets an I/O error, do_generic_file_read will notice the non-uptodate
    page and will issue a single-page read.  So everything up to
    a page's distance from the bad block should be recoverable.
    That's the theory; can't say that I've tested it.

It is really important to be able to tell the kernel to read and
write only the blocks it has been asked to read and write and
not to touch anything else.

In my SCSI example you go easily past "an I/O error", but what
this driver would do is retry a few times, reset the device,
retry again, reset the scsi bus, and then the kernel would crash
or hang forever. Maybe things are better today, but one does
not want to depend on complicated subsystems recovering
from their errors. There must just not be any errors.

In my situation yesterday night entirely different things play a role.
This card has a mapping from logical to physical blocks, but a
logical block only has a corresponding physical block when it has
been written at least once. So readahead will ask for blocks that
do not exist yet. (The driver that I put on ftp now recognizes this
situation and returns an all zero block, instead of an error.)

There are other situations where reading something has side effects.
A very common side effect is time delay.

So, for some devices I want to be able to kill read-ahead, even
before the kernel looks at the partition table.
Fortunately, I think that 2.5 will include the code that moves
partition table reading code out of the kernel, so this is
really possible.

    If the driver is actually dying over the bad block, well, foo.

    Yup.  Permitting a window size of zero is on my todo list,
    but it would require that the device have a request queue.

It has.

Andries
