Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263760AbUDVBJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUDVBJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUDVBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 21:09:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:62367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263760AbUDVBJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 21:09:52 -0400
Date: Wed, 21 Apr 2004 18:08:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: ext3 reservation question.
Message-Id: <20040421180850.36e806ff.akpm@osdl.org>
In-Reply-To: <200404211655.47329.pbadari@us.ibm.com>
References: <200404211655.47329.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> I was just wondering, what would make sense..
> 
> Lets say I have a "goal" for allocation, but the goal is not inside my 
> reservation window. Is it worth *try* to satisfy the goal by throwing
> out our window ? Or should we ignore goal and allocate from the
> current reservation window ?

That's a hard question.

Yes, it's worth throwing away the reservation and adopting a new one if
doing that is cheap.

> And also, how does ext3 determines the goal ?

Via various heuristics.  i_next_alloc_goal is "the physical block where I
want to allocate, as long as that allocation corresponds to the logical
block in i_next_alloc_block".  These are reasonably documented at their
definition site.

> I am worried about a case, where multiple threads writing to 
> different parts of same file - there by each thread thrashing 
> reservation window (since each one has its own goal).

Sure.  The reservations should be per-fd, not per-inode.  We've always had
that problem.

Making them per-fd is a little tricky, because there might not be any fd's
associated with the inode - this is the
"writepage-over-a-hole-after-the-file-was-closed" problem.

> BTW, the current reservation code honors "goal" and throws our
> window and tries to get a new one to satisfy the goal.

Right.  That's a problem, because obtaining the new window is now
computationally expensive, and the situation which you describe will
certainly occur.

We need to solve this.

I suggest you move all the reservation info into file->private_data and
swap that into the inode in ext3_prepare_write().  We'd have to do
something along those lines because get_block() isn't passed the file*. 
i_sem is held, so there's no competition for the inode.  Make sure that
inode->reservation_info is set to NULL again before returning from
ext3_prepare_write().


This would require that all allocation-related fields be moved from the
inode into struct reserve_window, as we earlier discussed.

I think this is worth doing.  Free the struct reserve_window at
file->private_data in ext3_release_file().  Allocate and initialise it
lazily, in ext3_prepare_write().

We'll need to be able to cope with a NULL inode->reservation_info in
writepage and get_block() for the pageout-over-a-hole problem, but if the
allocation patterns are crappy there it really doesn't matter.  Your choice
here is to either allocate a new reserve_window, hosted at
inode->fallback_reservation_info just for this case, or to simply handle
the NULL inode->reservation_info in get_block() and try to do something
reasonable.






But even doing that doesn't solve the problem where we have just a single
file* writing to the file, and the application is seeking all over the
place, and there are a lot of other open files against the fs.  In that
case we will also experience potentially very serious CPU consumption
problems.

Two ways of solving this:


a) Convert that linear search into an O(log(n)) one.

b) discard the current reservation window if the application seeked away and

c) only adopt a new reservation window if

   i) the file has just been opened or

   ii) we have seen "several" logically contiguous allocation attempts.


Alternatively, if the application did an lseek, we simply retain the
file*'s current reservation window and start using it for allcations at the
new logical offset.  I think that's OK - it's no worse than what we have at
present.
