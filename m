Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUDNXJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDNXHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:07:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:63425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbUDNXGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:06:04 -0400
Date: Wed, 14 Apr 2004 16:07:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Message-Id: <20040414160714.30e34753.akpm@osdl.org>
In-Reply-To: <1081963850.4714.6888.camel@localhost.localdomain>
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
	<1081963850.4714.6888.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> >   It's not clear when we should free up the write_state.  I guess we
> >   could leave it around for the remaining lifetime of the inode - that'd
> >   still be a net win.

> We could free up the write_state at the time of ext3_discard_allocation(),
> (not at the time when we allocate a new reservation window)
> 
> or later if we preserve reservation for slow growing files, we release
> the write_state at the time the inode is released.

That sounds appropriate.

> > - You're performing ext3_discard_reservation() in ext3_release_file(). 
> >   Note that the file may still have pending allocations at this stage: say,
> >   open a file, map it MAP_SHARED, dirty some pages which lie over file
> >   holes then close the file again.
> > 
> >   Later, the VM will come along and write those dirty pages into the
> >   file, at which point allocations need to be performed.  But we have no
> >   reservation data and, later, we may have no inode->write_state at all.
> > 
> >   What will happen?
> > 
> In this case, we will allocation a new reservation window for it.
> Nothing bad will happen. We probably just waste a previously allocated
> reservation window...but I am not sure.
> 
> My question is, if the file is first time opened, mapped, and we dirty
> pages in the file hole, will there any really disk block allocation
> involved there?

There might be, and there might not be.  It depends on timing, memory
pressure, application activity, etc.

> The current implementation is more than O(n): every time it does not
> have a reservation window, it search from the head of per filesystem
> reservation window list head. If it failed within the group, it will
> move to the next group and start the search from the head of the list
> again.

Same problem exists in arch_get_unmapped_area().  We have a funny little
heuristic (free_area_cache) in there to speed up the common case.

> This could be fixed by forget about the block group boundary at
> all,(remove the for loop in ext3_new_block), make it searchs for a block
> in a filesystem wide:)

I do think we should do this.  Does it have any disadvantages?

> I have concern about red black tree: it takes O(log(n)) to get where you
> want to start, but it need also takes O(log(n)) compare to find the hole
> size between two windows next to each other. And to find a reservable
> window, we need to browse the whole red black tree in the worse case, so
> the complexity is
> 	O(log(n)) + O(log(n)) *O(n)) = O(n)*O(log(n))
> 
> Am I right?

Think so.  rbtrees are optimised for loopkup, not for
get-me-a-suitably-sized-hole.


> > - Why do we discard the file's reservation on every iput()?  iput's are
> >   relatively common operations. (see fs/fs-writeback.c)
> > 
> Yes..you are right! I was intent to call ext3_discard_allocation only
> when the usage count of the inode is 0.  I looked at ext2 preallocation
> code, it called ext2_discard_preallocation in ext2_put_inode(), so I
> thought that's the place.  But it seems ext3_put_inode() being called
> every time iput() is called.  We should call ext3_discard_reservation in
> iput_final(). Should fix this in ext2.

Could be. so.

> > - What locking protects rsv_alloc_hit?  i_sem is not held during
> >   VM-initiated writeout.  Maybe an atomic_t there, or just say that if we
> >   race and the number is a bit inaccurate, we don't care?
> > 
> Currently no lock is protect rsv_alloc_hit.  The reason is it is just a
> heuristics indicator of whether we should enlarge the reservation window
> size next time. Even the hit ratio(50%) is just a rough guess, so, a
> little bit inaccurate would not hurt much, adding another lock probably
> not worth it. 

I'd agree with that.
