Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUDEQnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUDEQnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:43:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:53423 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262961AbUDEQnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:43:08 -0400
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
	preallocation
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040402185007.7d41e1a2.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain> 
	<20040402185007.7d41e1a2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Apr 2004 09:49:14 -0700
Message-Id: <1081183756.4714.6580.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 18:50, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > On Fri, 2004-04-02 at 17:50, Andrew Morton wrote:
> > > hm, maybe.  We should probably also provide a per-file ext3-specific ioctl
> > > to allow specialised apps to manipulate the reservation size.
> > > 
> > > And we should grow the reservation size dynamically.  I've suggested that
> > > we double its size each time it is exhausted, up to some limit.  There may
> > > be better algorithms though.
> > You mean when the reservation window size is exhausted, right? I think
> > this is probably the easiest way. Maybe like the readahead window does. 
> > Just sometimes the window reserved does not contains much free blocks to
> > allocate, and we could easily reach to the upper limit.
> 
> Good point.  So the reservation should be grown by "the number of blocks we
> allocated in the previous window", not by "the size of the previous
> window", yes?
> 
Yes.  Maybe in the reservation structure we add a counter to keep track
of the preallocation hit. Then when a new window need to be created, we
look at the old window preallocation hit ratio to determine how much the
window size should be next time.

> > Currently, when try to reserve a window in a block group, if there is no
> > window big enough for this, we skip this group and move on to the next
> > group.  I was thinking maybe we should keep track of the largest
> > avaliable reservable window when we are looking for a new window, so in
> > case we can't find the one with expected size, we at least could get one
> > within the group.
> 
> I suspect that if you cannot get a window in the blockgroup then simply
> skipping to the next blockgroup should be OK.
>
okey.
 
> But I don't understand why the reservation code needs to know about
> blockgroups at all, at least from a conceptual point of view. 
> 
Agree that reservation itself is a filesystem wide concept. The
reservation window could cross the block group boundary. 

> Probably it's sufficient to use the inode's blockgroup's starting block as
> the initial target for allocations and then just forget about blockgroups. 
> Simply let allocation wander further up the disk from there, with no
> further consideration of blockgroups.
I think the current code's logic is the same as you said. The logic of
current code is: given a goal block,try to allocate a block starting
from there within the inode's block group. If it failed, then simply
move on to next group without a goal -- the search for a free block will
start from the starting block of the next group.  I was trying to keep
the same logic as before.  So for the reservation code, given a goal
block, we will try to allocate a new reservation window (and then
allocate a block within it) from the give goal block. If it failed, we
will simply do reservation window allocate in the rest of the disk,
without consideration of the inode's blockgroup.

> 
> It would be fairly weird for the entire disk to be covered by reservations,
> so falling back to the current algorithm would be OK.
okey.

> > > This work doesn't help us with the slowly-growing logfile or mailbox file
> > > problem.  I guess that would require on-disk reservations, or a new
> > > `chattr' hint or such.
> > 
> > Ted has suggested to preserve the reservation/preallocation for those
> > slowing growing logfile for mailbox file. Probably do not discard the
> > reservation window for those files(the logfile) when they are closed.
> > When it opens next time, it will allocate blocks directly from the old
> > reservation window. Is that what you think? 
> 
> yup, except we now have potentially millions of inodes which have active
> reservations.  ENOSPC and CPU consumption problems are certain.
> 
> Some combination of
> 
> - A chattr hint
> 
> - Using O_APPEND as a hint and
> 
> - Retaining an upper limit on the number of unopened inodes which have a
>   reservation
> 
> should fix that up.  You'd need to hook into ->destroy_inode to release
> reservations when inodes are reclaimed by the VM.
> 
> But this is surely phase two material.
Okey. Will think about this more later...

Thanks for your help!

Mingming

> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
> 


