Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUDCCug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 21:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDCCug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 21:50:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:36573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbUDCCuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 21:50:32 -0500
Date: Fri, 2 Apr 2004 18:50:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
 preallocation
Message-Id: <20040402185007.7d41e1a2.akpm@osdl.org>
In-Reply-To: <1080959870.3548.6555.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> On Fri, 2004-04-02 at 17:50, Andrew Morton wrote:
> > hm, maybe.  We should probably also provide a per-file ext3-specific ioctl
> > to allow specialised apps to manipulate the reservation size.
> > 
> > And we should grow the reservation size dynamically.  I've suggested that
> > we double its size each time it is exhausted, up to some limit.  There may
> > be better algorithms though.
> You mean when the reservation window size is exhausted, right? I think
> this is probably the easiest way. Maybe like the readahead window does. 
> Just sometimes the window reserved does not contains much free blocks to
> allocate, and we could easily reach to the upper limit.

Good point.  So the reservation should be grown by "the number of blocks we
allocated in the previous window", not by "the size of the previous
window", yes?

> Currently, when try to reserve a window in a block group, if there is no
> window big enough for this, we skip this group and move on to the next
> group.  I was thinking maybe we should keep track of the largest
> avaliable reservable window when we are looking for a new window, so in
> case we can't find the one with expected size, we at least could get one
> within the group.

I suspect that if you cannot get a window in the blockgroup then simply
skipping to the next blockgroup should be OK.

But I don't understand why the reservation code needs to know about
blockgroups at all, at least from a conceptual point of view. 

> This will try to keep the file inside it's target group, and also reduce
> the possibility of bogus earlier ENOSPC. Just it's a trade off:there
> maybe plenty of space in the next group......who knows. What do you
> think?

Probably it's sufficient to use the inode's blockgroup's starting block as
the initial target for allocations and then just forget about blockgroups. 
Simply let allocation wander further up the disk from there, with no
further consideration of blockgroups.

> Also, for the the bogus earlier ENOSPC, : the filesystem probably
> relatively full of reservations, so the late guy who need a new block
> but don't have a reservation window will failed to allocate a block. In
> this case, the easiest way as you said before is to just steal a free
> block from other file's reservation window. I agree it's the extreme
> case and the solution is easy, just a little concern that this will in
> favor of those inodes who came first and made reservations, but whose
> who come in later need a new block, every time has to suffer the same
> pain: search the whole filesystem first, then end of steal blocks every
> time.

It would be fairly weird for the entire disk to be covered by reservations,
so falling back to the current algorithm would be OK.

> Anyway maybe by that moment the there are too many open files for
> writes(so the fs is full of reservations) so it is already in trouble.
> 
> > 
> > This work doesn't help us with the slowly-growing logfile or mailbox file
> > problem.  I guess that would require on-disk reservations, or a new
> > `chattr' hint or such.
> 
> Ted has suggested to preserve the reservation/preallocation for those
> slowing growing logfile for mailbox file. Probably do not discard the
> reservation window for those files(the logfile) when they are closed.
> When it opens next time, it will allocate blocks directly from the old
> reservation window. Is that what you think? 

yup, except we now have potentially millions of inodes which have active
reservations.  ENOSPC and CPU consumption problems are certain.

Some combination of

- A chattr hint

- Using O_APPEND as a hint and

- Retaining an upper limit on the number of unopened inodes which have a
  reservation

should fix that up.  You'd need to hook into ->destroy_inode to release
reservations when inodes are reclaimed by the VM.

But this is surely phase two material.


