Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUDNRYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUDNRYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:24:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32218 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261317AbUDNRYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:24:10 -0400
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040413194734.3a08c80f.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain>
	<20040402185007.7d41e1a2.akpm@osdl.org>
	<1081903949.3548.6837.camel@localhost.localdomain> 
	<20040413194734.3a08c80f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Apr 2004 10:30:47 -0700
Message-Id: <1081963850.4714.6888.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-13 at 19:47, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > Here is a set of patches which implement the in-memory ext3 block
> >  reservation (previously called reservation based ext3 preallocation). 
> 
> Great, thanks.  Let's get these in the pipeline.
> 
> A few thoughts, from a five-minute read:
> 
> 
> - The majority of in-core inodes are not open for reading, and we've
>   added 24 bytes to the inode just for inodes which are open for writing.
Yes, The structure is getting bigger when we add more stuff into it. It
may not worth to put it inside the ext3_inode_info structure just for
files for write....I agree!
> 
>   At some stage we should stop aggregating struct reserve_window into the
>   inode and dynamically allocate it.  We can move i_next_alloc_block,
>   i_next_alloc_goal and possibly other fields in there too.
> 
>   At which point it has the wrong name ;) Should be `write_state' or
>   something.
> 
>   It's not clear when we should free up the write_state.  I guess we
>   could leave it around for the remaining lifetime of the inode - that'd
>   still be a net win.
We could free up the write_state at the time of ext3_discard_allocation(), (not at the time when we allocate a new reservation window)

or later if we preserve reservation for slow growing files, we release the write_state at the time the inode is released.

>   Is this something you can look at as a low-priority activity?
> 
Sure!
> - You're performing ext3_discard_reservation() in ext3_release_file(). 
>   Note that the file may still have pending allocations at this stage: say,
>   open a file, map it MAP_SHARED, dirty some pages which lie over file
>   holes then close the file again.
> 
>   Later, the VM will come along and write those dirty pages into the
>   file, at which point allocations need to be performed.  But we have no
>   reservation data and, later, we may have no inode->write_state at all.
> 
>   What will happen?
> 
In this case, we will allocation a new reservation window for it.
Nothing bad will happen. We probably just waste a previously allocated
reservation window...but I am not sure.

My question is, if the file is first time opened, mapped, and we dirty
pages in the file hole, will there any really disk block allocation
involved there? If not, we do not have a reservation window at at all,
and ext3_discard_reservation will detect that and will do nothing.

> - Have you tested and profiled this with a huge number of open files?  At
>   what stage do we get into search complexity problems?
> 
Not yet. The current search complexity is O(n), if you don't have a
reservation, you need O(n) to move the search head to the place where
you want to search for a new reservation, finding the hole size between
two reservation window is just O(1) for sorted double linked list, we
need O(n) to look for a reservable window after that, so the complex is:
		O(n) +O(1) * 0(n) = O(n); 
if you already have a old reservation, we will remember where to start
the search, so the complex is O(1) + O(n);

The current implementation is more than O(n): every time it does not
have a reservation window, it search from the head of per filesystem
reservation window list head. If it failed within the group, it will
move to the next group and start the search from the head of the list
again.

This could be fixed by forget about the block group boundary at
all,(remove the for loop in ext3_new_block), make it searchs for a block
in a filesystem wide:)

I have concern about red black tree: it takes O(log(n)) to get where you
want to start, but it need also takes O(log(n)) compare to find the hole
size between two windows next to each other. And to find a reservable
window, we need to browse the whole red black tree in the worse case, so
the complexity is
	O(log(n)) + O(log(n)) *O(n)) = O(n)*O(log(n))

Am I right?

> - Why do we discard the file's reservation on every iput()?  iput's are
>   relatively common operations. (see fs/fs-writeback.c)
> 
Yes..you are right! I was intent to call ext3_discard_allocation only
when the usage count of the inode is 0.  I looked at ext2 preallocation
code, it called ext2_discard_preallocation in ext2_put_inode(), so I
thought that's the place.  But it seems ext3_put_inode() being called
every time iput() is called.  We should call ext3_discard_reservation in
iput_final(). Should fix this in ext2.

> - What locking protects rsv_alloc_hit?  i_sem is not held during
>   VM-initiated writeout.  Maybe an atomic_t there, or just say that if we
>   race and the number is a bit inaccurate, we don't care?
> 
Currently no lock is protect rsv_alloc_hit.  The reason is it is just a
heuristics indicator of whether we should enlarge the reservation window
size next time. Even the hit ratio(50%) is just a rough guess, so, a
little bit inaccurate would not hurt much, adding another lock probably
not worth it. 

Thanks,

Mingming

