Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292915AbSBVP6V>; Fri, 22 Feb 2002 10:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSBVP6L>; Fri, 22 Feb 2002 10:58:11 -0500
Received: from host194.steeleye.com ([216.33.1.194]:32783 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292915AbSBVP6B>; Fri, 22 Feb 2002 10:58:01 -0500
Message-Id: <200202221557.g1MFvp004149@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Feb 2002 10:57:51 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most ext3 commits, in practice, are lazy, asynchronous commits, and we
> only nedd BH_Ordered_Tag for that, not *_Flush.  It would be easy
> enough to track whether a given transaction has any synchronous
> waiters, and if not, to use the async *_Tag request for the commit
> block instead of forcing a flush.

> We'd also have to track the sync status of the most recent
> transaction, too, so that on fsync of a non-dirty file/inode, we make
> sure that its data had been forced to disk by at least one synchronous
> flush.  

> But that's really only a win for SCSI, where proper async ordered tags
> are supported.  For IDE, the single BH_Ordered_Flush is quite
> sufficient.

Unfortunately, there's actually a hole in the SCSI spec that means ordered 
tags are actually extremely difficult to use in the way you want (although I 
think this is an accident, conceptually, I think they were supposed to be used 
for this).  For the interested, I attach the details at the bottom.

The easy way out of the problem, I think, is to impose the barrier as an 
effective queue plug in the SCSI mid-layer, so that after the mid-layer 
recevies the barrier, it plugs the device queue from below, drains the drive 
tag queue, sends the barrier and unplugs the device queue on barrier I/O 
completion.

Ordinarily, this would produce extremely poor performance since you're 
effectively starving the device to implement the barrier.  However, in Linux 
it might just work because it will give the elevator more time to coalesce 
requests.

James Bottomley

Problems Using Ordered Tags as a Barrier
========================================

Note, the following is independent of re-ordering on error conditions which 
was discussed in a previous thread.  This discussion pertains to normal device 
operations.

The SCSI tag system allows all devices to have a dynamic queue.  This means 
that there is no a priori guarantee about how many tags the device will accept 
before the queue becomes full.

The problem comes because most drivers issue SCSI commands directly from the 
incoming I/O thread but complete them via the SCSI interrupt routine.  What 
this means is that if the SCSI device decides it has no more resources left, 
the driver won't be told until it recevies an interrupt indicating that the 
queue is full and the particular I/O wasn't queued.  At this point, the user 
threads may have send down several more I/Os, and worse still, the SCSI device 
may have accepted some of the later I/Os because the local conditions causing 
it to signal queue full may have abated.

As I read the standard, there's no way to avoid this problem, since the queue 
full signal entitles the device not to queue the command, and not to act on 
any ordering the command may have had.

The other problem is actually driver related, not SCSI.  Most HBA chips are 
intelligent beasts which can process independently of the host CPU.  
Unfortunately, implementing linked lists tends to be rather beyond their 
capabilities.  For this reason, most low level drivers have a certain number 
of queue slots (per device, per chip or whatever).  The usual act of feeding 
an I/O command to a device involves stuffing it in the first available free 
slot.  This can lead to command re-ordering because even though the HBA is 
sequentially processing slots in a round-robin fashion, you don't often know 
which slot it is currently looking at.  Also, the multi threaded nature of tag 
command queuing means that the slot will remain full long after the HBA has 
started processing it and moved on to the next slot.

One possible get out is to process the queue full signal internally (either in 
the interrupt routine or in the chip driver itself) to force it to re-send of 
the non-queued tag until the drive actually accepts it.  As long as this 
looping is done at a level which prevents the device from accepting any more 
commands.  In general, this is nasty because it is effectively a busy wait 
inside the HBA and will block commands to all other devices until the device 
queue drained sufficiently to accept the tag.

The other possibility would be to treat all pending commands for a particular 
device as queue full errors if we get that for one of them.  This would 
require the interrupt or chip script routine to complete all commands for the 
particular device as queue full, which would still be quite a large amount of 
work for device driver writers.

Finally, I think the driver ordering problem can be solved easily as long as 
an observation I have about your barrier is true.  It seems to me that the 
barrier is only semi permeable, namely its purpose is to complete *after* a 
particular set of commands do.  This means that it doesnt matter if later 
commands move through the barrier, it only matters that earlier commands 
cannot move past it?  If this is true, then we can fix the slot problem simply 
by having a slot dedicated to barrier tags, so the processing engine goes over 
it once per cycle.  However, if it finds the barrier slot full, it doesn't 
issue the command until the *next* cycle, thus ensuring that all commands sent 
down before the barrier (plus a few after) are accepted by the device queue 
before we send the barrier with its ordered tag.



