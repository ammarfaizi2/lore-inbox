Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSCDDfD>; Sun, 3 Mar 2002 22:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCDDep>; Sun, 3 Mar 2002 22:34:45 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:43164 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S291193AbSCDDek>; Sun, 3 Mar 2002 22:34:40 -0500
Date: Sun, 03 Mar 2002 22:34:07 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <757370000.1015212846@tiny>
In-Reply-To: <E16heCm-0000Q5-00@starship.berlin>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, March 03, 2002 11:11:44 PM +0100 Daniel Phillips <phillips@bonn-fries.net> wrote:

> I have a standing offer from at least one engineer to make firmware changes 
> to the drives if it makes Linux work better.  So a reasonable plan is: first 
> know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
> identifying drives that don't work in the ideal way, and require a fallback.
> 
> In my opinion, the only correct behavior is a write barrier that completes
> when data is on the platter, and that does this even when write-back is
> enabled.  

With a battery backup, we want the raid controller (or whatever) to 
pretend the barrier is done right away.  It should be as safe, and 
allow the target to merge the writes.

> Surely this is not rocket science at the disk firmware level.  Is
> this or is this not the way ordered tags were supposed to work?

There are many issues at play in this thread, here's an attempt at
a summary (please correct any mistakes).

1) The drivers would need to be changed to properly keep tag ordering 
in place on resets, and error conditions.

2) ordered tags force ordering of all writes the drive is processing.
For some workloads, it will be forced to order stuff the journal code
doesn't care about at all, perhaps leading to lower performance than
the simple wait_on_buffer() we're using now.

2a) Are the filesystems asking for something impossible?  Can drives
really write block N and N+1, making sure to commit N to media before
N+1 (including an abort on N+1 if N fails), but still keeping up a 
nice seek free stream of writes?

3) Some drives may not be very smart about ordered tags.  We need
to figure out which is faster, using the ordered tag or using a
simple cache flush (when writeback is on).  The good news about
the cache flush is that it doesn't require major surgery in the
scsi error handlers.

4) If some scsi drives come with writeback on by default, do they also
turn it on under high load like IDE drives do?

> 
>> Clearly, there would also have to be a mechanism to flush the cache on 
>> unmount, so if this were done by ioctl, would you prefer that the filesystem 
>> be in charge of flushing the cache on barrier writes, or would you like the sd 
>> device to do it transparently?
> 
> The filesystem should just say 'this request is a write barrier' and the 
> lower layers, whether that's scsi or bio, should do what's necessary to make
> it come true.

That's the goal.  The current 2.4 patch differentiates between ordered
barriers and flush barriers just so I can make the flush the default
on IDE, and enable the ordered stuff when I want to experiment on scsi.

-chris

