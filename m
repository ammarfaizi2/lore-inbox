Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKAVBI>; Thu, 1 Nov 2001 16:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279771AbRKAVA6>; Thu, 1 Nov 2001 16:00:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32012 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279768AbRKAVAm>; Thu, 1 Nov 2001 16:00:42 -0500
Message-ID: <3BE1B6CD.7DA43A6C@zip.com.au>
Date: Thu, 01 Nov 2001 12:55:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.14-pre6
In-Reply-To: message from Linus Torvalds on Wednesday October 31,
		<Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com> <15329.8658.642254.284398@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> ...
> What I would like is that as soon as a buffer was marked "dirty", it
> would get passed down to the driver (or at least to the
> block-device-layer) with something like
>     submit_bh(WRITEA, bh);
> i.e. a write ahead. (or is it write-behind...)
> The device handler (the elevator algorithm for normal disks, other
> code for other devices) could keep them ordered in whatever way it
> chooses, and feed them into the queues at some appropriate time.
> 

Sounds sensible to me.

In many ways, it's similar to the current scheme when it's used
with an enormous request queue - all writeable blocks in the
system are candidates for request merging.  But your proposal
is a whole lot smarter.

In particular, the current kupdate scheme of writing the
dirty block list out in six chunks, five seconds apart
does potentially miss out on a very large number of merging
opportunities.  Your proposal would fix that.

Another potential microoptimisation would be to write out
clean blocks if that helps merging.  So if we see a write
for blocks 1,2,3,5,6,7 and block 4 is known to be in memory,
then write it out too.  I suspect this would be a win for
ATA but a loss for SCSI.  Not sure.

But I have a gut feel that all this is in the noisefloor,
compared to The Big Problem.  It's just a matter of identifying
and fixing TBP.  Fixing the fdatasync() thing didn't help,
because ext2_write_inode() for a new file has to read the
inode block from disk.  Fixing that, by doing an async preread
of the inode's block in ext2_new_inode() didn't help either,
I suspect because my working set was so large that the VM
tossed out my preread before I got to use it.  A few more days
poking is needed.



Oh.  I have a gripe concerning prune_icache().  The design
idea behind keventd is that it's a "process context bottom
half handler".  It's used for things like cardbus hotplug
interrupt handlers, handling tty hangups, etc.  It should
probably run SCHED_FIFO.

Using keventd to synchronously flush large amounts of 
data out to disk constitutes gross abuse - it's being blocked
from performing its designed duties for many seconds.  Can we
please not do that?  We already have kswapd, kupdate, bdflush,
which should be sufficient.

-
