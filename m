Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCDFKC>; Mon, 4 Mar 2002 00:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291547AbSCDFJy>; Mon, 4 Mar 2002 00:09:54 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:7313 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291484AbSCDFJp>;
	Mon, 4 Mar 2002 00:09:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 06:05:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <757370000.1015212846@tiny>
In-Reply-To: <757370000.1015212846@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hkfB-0000Zp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 04:34 am, Chris Mason wrote:
> On Sunday, March 03, 2002 11:11:44 PM +0100 Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > I have a standing offer from at least one engineer to make firmware changes 
> > to the drives if it makes Linux work better.  So a reasonable plan is: first 
> > know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
> > identifying drives that don't work in the ideal way, and require a fallback.
> > 
> > In my opinion, the only correct behavior is a write barrier that completes
> > when data is on the platter, and that does this even when write-back is
> > enabled.  
> 
> With a battery backup, we want the raid controller (or whatever) to 
> pretend the barrier is done right away.  It should be as safe, and 
> allow the target to merge the writes.

Agreed, that should count as 'on the platter'.  Unless the battery is flat...

> > Surely this is not rocket science at the disk firmware level.  Is
> > this or is this not the way ordered tags were supposed to work?
> 
> There are many issues at play in this thread, here's an attempt at
> a summary (please correct any mistakes).
> 
> 1) The drivers would need to be changed to properly keep tag ordering 
> in place on resets, and error conditions.

Linux drivers?  Isn't that a simple matter of coding? ;-)

> 2) ordered tags force ordering of all writes the drive is processing.
> For some workloads, it will be forced to order stuff the journal code
> doesn't care about at all, perhaps leading to lower performance than
> the simple wait_on_buffer() we're using now.

OK, thanks for the clear definition of the problem.  This corresponds
to my reading of this document:

   http://www.storage.ibm.com/hardsoft/products/ess/pubs/f2ascsi1.pdf

   Ordered Queue Tag:

   The command begins execution after all previously issued commands
   complete.  Subsequent commands may not begin execution until this
   command completes (unless they are issued with Head of Queue tag
   messages).

But chances are, almost all the IOs ahead of the journal commit belong
to your same filesystem anyway, so you may be worrying too much about
possibly waiting for something on another partition.

In theory, bio could notice the barrier coming down the pipe and hold
back commands on other partitions, if they're too far away physically.

> 2a) Are the filesystems asking for something impossible?  Can drives
> really write block N and N+1, making sure to commit N to media before
> N+1 (including an abort on N+1 if N fails), but still keeping up a 
> nice seek free stream of writes?
> 
> 3) Some drives may not be very smart about ordered tags.  We need
> to figure out which is faster, using the ordered tag or using a
> simple cache flush (when writeback is on).  The good news about
> the cache flush is that it doesn't require major surgery in the
> scsi error handlers.

Everything else seems to be getting major surgery these days, so...

> 4) If some scsi drives come with writeback on by default, do they also
> turn it on under high load like IDE drives do?

It shouldn't matter, if the ordered queue tag is implemented properly.
>From the thread I gather it isn't always, which means we need a
blacklist, or putting on a happier face, a whitelist.

> >> Clearly, there would also have to be a mechanism to flush the cache on 
> >> unmount, so if this were done by ioctl, would you prefer that the filesystem 
> >> be in charge of flushing the cache on barrier writes, or would you like the sd 
> >> device to do it transparently?
> > 
> > The filesystem should just say 'this request is a write barrier' and the 
> > lower layers, whether that's scsi or bio, should do what's necessary to make
> > it come true.
> 
> That's the goal.  The current 2.4 patch differentiates between ordered
> barriers and flush barriers just so I can make the flush the default
> on IDE, and enable the ordered stuff when I want to experiment on scsi.

I should state it more precisely: 'this request is a write barrier for this
partition'.  Is that what you had in mind?

-- 
Daniel
